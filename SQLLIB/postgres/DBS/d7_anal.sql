UPDATE d7_control SET name = ltrim(rtrim(upper(name)));
UPDATE d7_prop SET name = ltrim(rtrim(upper(name)));
UPDATE d7_event SET name = ltrim(rtrim(upper(name)));
UPDATE d7_method SET name = ltrim(rtrim(upper(name)));
COMMIT;
SELECT * FROM d7_control;
SELECT * FROM d7_prop;
SELECT * FROM d7_control WHERE REGEXP_LIKE(name,'listbox|combobox|scroll','i') ORDER BY name ;
SELECT * FROM d7_prop;

UPDATE d7_prop SET name = substr(name,3);
SELECT * FROM d7_prop a LEFT OUTER JOIN (SELECT * FROM d7_prop WHERE substr(name,1,2) = '**') b ON a.name = b.name AND a.val = b.val WHERE b.name IS null;
SELECT substr(name,3),name FROM d7_prop;
DELETE FROM d7_prop WHERE name IS NULL;
COMMIT;
DROP table d7_ctl_prop;
CREATE TABLE d7_ctl_prop AS SELECT b.name cname,a.ctype,a.scr,a.cdesc,a.xframe,b.val prop FROM d7_control a FULL OUTER JOIN d7_prop b ON ltrim(rtrim(upper(a.name))) =ltrim(rtrim(upper(b.name))) ;
SELECT * FROM d7_control a FULL OUTER JOIN d7_prop b ON ltrim(rtrim(upper(a.name))) =ltrim(rtrim(upper(b.name))) ORDER BY a.name,b.val;
SELECT * FROM d7_control a FULL OUTER JOIN d7_prop b ON ltrim(rtrim(upper(a.name))) =ltrim(rtrim(upper(b.name))) WHERE b.name IS NULL ORDER BY a.name,b.val; -- control은 있으나, prop이 없는 경우, 0건 
SELECT * FROM d7_control a FULL OUTER JOIN d7_prop b ON ltrim(rtrim(upper(a.name))) =ltrim(rtrim(upper(b.name))) WHERE a.name IS NULL ORDER BY a.name,b.val; -- prop은 있으나, control이 없는 경우 , 6개 컴포넌트
SELECT name FROM (SELECT b.name,b.val FROM d7_control a FULL OUTER JOIN d7_prop b ON ltrim(rtrim(upper(a.name))) =ltrim(rtrim(upper(b.name))) WHERE a.name IS NULL ORDER BY a.name,b.val) t GROUP BY name ; -- prop은 있으나, control이 없는 경우6개 컴포넌트

SELECT * FROM d7_event;
SELECT * FROM d7_control a FULL OUTER JOIN d7_event b ON ltrim(rtrim(upper(a.name))) =ltrim(rtrim(upper(b.name))) ORDER BY a.name,b.cevent;
SELECT * FROM d7_control a FULL OUTER JOIN d7_event b ON ltrim(rtrim(upper(a.name))) =ltrim(rtrim(upper(b.name))) WHERE b.name IS NULL ORDER BY a.name,b.cevent; -- control은 있으나, event가 없는 경우, 65건 
SELECT name FROM (SELECT a.name,a.ctype FROM d7_control a FULL OUTER JOIN d7_event b ON ltrim(rtrim(upper(a.name))) =ltrim(rtrim(upper(b.name))) WHERE b.name IS NULL ORDER BY a.name,b.cevent) t GROUP BY name; -- control은 있으나, event가 없는 경우, 65건 
SELECT * FROM d7_control a FULL OUTER JOIN d7_event b ON ltrim(rtrim(upper(a.name))) =ltrim(rtrim(upper(b.name))) WHERE a.name IS NULL ORDER BY a.name,b.cevent; -- event는 있으나, control이 없는 경우, 0건

CREATE TABLE d7_ctl_event AS SELECT a.name cname,a.ctype,a.scr,a.cdesc,a.xframe,b.cevent event FROM d7_control a FULL OUTER JOIN d7_event b ON upper(a.name) =upper(b.name) ;

SELECT * FROM d7_ctl_event ORDER BY cname,event;

SELECT * FROM d7_method;
SELECT * FROM d7_control a FULL OUTER JOIN d7_method b ON upper(a.name) =upper(b.name) ORDER BY a.name,b.val;
SELECT * FROM d7_control a FULL OUTER JOIN d7_method b ON upper(a.name) =upper(b.name) WHERE b.name IS NULL ORDER BY a.name,b.val; -- control은 있으나, method가 없는 경우, 41건 
SELECT name FROM (SELECT a.name,a.ctype FROM d7_control a FULL OUTER JOIN d7_method b ON upper(a.name) =upper(b.name) WHERE b.name IS NULL ORDER BY a.name,b.val) t GROUP BY name; -- control은 있으나, event가 없는 경우, 41건 
SELECT * FROM d7_control a FULL OUTER JOIN d7_method b ON upper(a.name) =upper(b.name) WHERE a.name IS NULL ORDER BY a.name,b.val; -- method가 있으나, control이 없는 경우, 0건
SELECT name FROM (SELECT b.name,b.val FROM d7_control a FULL OUTER JOIN d7_method b ON upper(a.name) =upper(b.name) WHERE a.name IS NULL ORDER BY a.name,b.val) t GROUP BY name; -- method가 있으나 , control이 없는 경우 3건

-- // method는 join 으로 찾을것 
SELECT * FROM d7_ctl_prop WHERE REGEXP_LIKE(cname,'iamge|img','i') ORDER BY cname,prop ;
SELECT * FROM d7_ctl_event WHERE REGEXP_LIKE(cname,'iamge|img','i') ORDER BY cname,event ;
SELECT * FROM (SELECT a.name cname1,a.ctype,a.scr scr1,a.cdesc,a.xframe,b.name cname2,b.val cmethod,b.scr scr2 FROM d7_control a FULL OUTER JOIN d7_method b ON upper(a.name) =upper(b.name) ) t 
 WHERE REGEXP_LIKE(t.cname1,'image|img','i') OR REGEXP_LIKE(t.cname2,'image|img','i')  ORDER BY cname1,cmethod,cname2;




