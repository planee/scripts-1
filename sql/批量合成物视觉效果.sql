/* 
   这个sql是配合之前写的1056装备合成的
   为合成后的装备附加视觉效果
   当然保留原有的模型，只是在这个基础上添加类似附魔的效果以作区分
   
   呃，其实这个sql生成结果并不是最终的文件，还需要手动转换来生成dbc的
   
   目前只生成【武器】的部分视觉效果 当然你也可以改下面的语句让它为不同的装备附加不同的效果
   
*/

/*  定义合成物各等级的视觉效果 
    把下面的1~5改成各个等级所需要的ItemVisuals.dbc的id值*/
set @ItemVisuals_lv1 = 301;
set @ItemVisuals_lv2 = 302;
set @ItemVisuals_lv3 = 303;
set @ItemVisuals_lv4 = 304;
set @ItemVisuals_lv5 = 305;

/*清理可能生成失败后的残留*/
update item_template set displayid=displayid-100001 where (entry BETWEEN '3100000' AND '3199999') and (class=2) and displayid>100001;
update item_template set displayid=displayid-200002 where (entry BETWEEN '3200000' AND '3299999') and (class=2) and displayid>100001;
update item_template set displayid=displayid-300003 where (entry BETWEEN '3300000' AND '3399999') and (class=2) and displayid>100001;
update item_template set displayid=displayid-400004 where (entry BETWEEN '3400000' AND '3499999') and (class=2) and displayid>100001;
update item_template set displayid=displayid-500005 where (entry BETWEEN '3500000' AND '3599999') and (class=2) and displayid>100001;
DROP TABLE IF EXISTS item_template_display;
DROP TABLE IF EXISTS item_template_display_id;
DROP TABLE IF EXISTS itemdisplay_2;
DROP TABLE IF EXISTS itemdisplay_lv1;
DROP TABLE IF EXISTS itemdisplay_lv2;
DROP TABLE IF EXISTS itemdisplay_lv3;
DROP TABLE IF EXISTS itemdisplay_lv4;
DROP TABLE IF EXISTS itemdisplay_lv5;

/*提取合成物的武器部分 
自己注意自己的数据库合成物品的entry的增加量
比如我的是第一级+31000000  所以下面的是提取 entry>3100000 的数据
*/
CREATE TABLE item_template_display (select * from item_template where (class = 2) and  entry>3100000);
CREATE TABLE item_template_display_id (select displayid, count(distinct displayid) from item_template_display group by displayid);
CREATE TABLE itemdisplay_2 SELECT * FROM itemdisplay,item_template_display_id WHERE itemdisplay.ID = item_template_display_id.displayid;
ALTER TABLE itemdisplay_2 DROP COLUMN displayid,DROP COLUMN `count(distinct displayid)`;

/*按照合成等级分别生成*/
CREATE TABLE itemdisplay_lv1 (SELECT * FROM `itemdisplay_2` );/* lv1*/
CREATE TABLE itemdisplay_lv2 (SELECT * FROM `itemdisplay_2` );/* lv2*/
CREATE TABLE itemdisplay_lv3 (SELECT * FROM `itemdisplay_2` );/* lv3*/
CREATE TABLE itemdisplay_lv4 (SELECT * FROM `itemdisplay_2` );/* lv4*/
CREATE TABLE itemdisplay_lv5 (SELECT * FROM `itemdisplay_2` );/* lv5*/

update itemdisplay_lv1 set id=id+100001,field23 = @ItemVisuals_lv1;
update itemdisplay_lv2 set id=id+200002,field23 = @ItemVisuals_lv2;
update itemdisplay_lv3 set id=id+300003,field23 = @ItemVisuals_lv3;
update itemdisplay_lv4 set id=id+400004,field23 = @ItemVisuals_lv4;
update itemdisplay_lv5 set id=id+500005,field23 = @ItemVisuals_lv5;

TRUNCATE itemdisplay_2;

insert into itemdisplay_2 select * from itemdisplay_lv1;
insert into itemdisplay_2 select * from itemdisplay_lv2;
insert into itemdisplay_2 select * from itemdisplay_lv3;
insert into itemdisplay_2 select * from itemdisplay_lv4;
insert into itemdisplay_2 select * from itemdisplay_lv5;

/*更新item_template表的displayid值
entry BETWEEN '3100000' AND '3199999' 这个是我的物品表的lv1的物品的id值
下面的也是
你们按照自己的id改动
*/
update item_template set displayid=displayid+100001 where (entry BETWEEN '3100000' AND '3199999') and (class=2);
update item_template set displayid=displayid+200002 where (entry BETWEEN '3200000' AND '3299999') and (class=2);
update item_template set displayid=displayid+300003 where (entry BETWEEN '3300000' AND '3399999') and (class=2);
update item_template set displayid=displayid+400004 where (entry BETWEEN '3400000' AND '3499999') and (class=2);
update item_template set displayid=displayid+500005 where (entry BETWEEN '3500000' AND '3599999') and (class=2);

/*删除工作表*/
DROP TABLE IF EXISTS item_template_display;
DROP TABLE IF EXISTS item_template_display_id;
DROP TABLE IF EXISTS itemdisplay_lv1;
DROP TABLE IF EXISTS itemdisplay_lv2;
DROP TABLE IF EXISTS itemdisplay_lv3;
DROP TABLE IF EXISTS itemdisplay_lv4;
DROP TABLE IF EXISTS itemdisplay_lv5;
