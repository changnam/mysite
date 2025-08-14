SELECT * FROM d7_prop;
SELECT * FROM d7_prop WHERE REGEXP_LIKE(name,'image|img','i') ORDER BY name,val; 

SELECT * FROM d7_prop WHERE REGEXP_LIKE(name,'line|multi','i') ORDER BY name,val; 

SELECT * FROM d7_prop WHERE REGEXP_LIKE(name,'progress','i') ORDER BY name,val; 

SELECT * FROM d7_prop WHERE REGEXP_LIKE(name,'shape','i') ORDER BY name,val; 

SELECT * FROM d7_prop WHERE REGEXP_LIKE(name,'tab','i') AND NOT REGEXP_LIKE(name,'database','i') ORDER BY name,val; 

SELECT * FROM d7_prop WHERE REGEXP_LIKE(name,'timer','i') ORDER BY name,val; 

SELECT * FROM d7_prop WHERE REGEXP_LIKE(name,'web|browser','i') ORDER BY name,val; 