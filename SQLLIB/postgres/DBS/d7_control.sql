SELECT * FROM d7_control;
SELECT * FROM d7_control WHERE REGEXP_LIKE(name,'image|img','i') ORDER BY name,ctype; 

SELECT * FROM d7_control WHERE REGEXP_LIKE(name,'tab','i') AND NOT REGEXP_LIKE(name,'database','i') ORDER BY name,ctype; 