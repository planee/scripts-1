/* 为遗产1056扩展一下合成系统
   通过使用【大工匠的熔铸核心】来合成装备
   可合成装备范围是灰色装备以上的除工匠装备之外的任意装备 
   装等之类的下面设置
   
*/


/*下面的数值为各等级合成的装备的基础属性&抗性&护甲的提升倍率*/
set @lv1 = 1.242;
set @lv2 = 1.484;
set @lv3 = 1.968;
set @lv4 = 2.936;
set @lv5 = 4.872;
/*下面的数值为各等级合成的装备武器伤害提升倍率*/
set @lv1_dmg = 1.12;
set @lv2_dmg = 1.24;
set @lv3_dmg = 1.48;
set @lv4_dmg = 1.96;
set @lv5_dmg = 2.92;
/*下面的是可合成装备的最低的装等，写10就是装等10以上的装备都会生成合成数据*/
set @hc_lv_min = 10;
/*下面的是合成后的装备可以通过【附魔】的【分解】技能拆回原来的两件时成功的几率*/
set @chaijie = 95;
/*为不附加任何属性的只带效果的装备(例如某些饰品)增加提高5000血量的效果
  下面的wsx_typ_x是要增加的属性类型，这里的1表示是血量
   wsx_zhi_y 是具体的数值
   1 表示 装等1~150的装备
   2 表示 装等151~232的装备
   3 表示 装等233~251的装备
   4 表示 装等252~999的装备*/
set @wsx_typ_1 = 1;
set @wsx_zhi_1 = 1500;
set @wsx_typ_2 = 1;
set @wsx_zhi_2 = 3000;
set @wsx_typ_3 = 1;
set @wsx_zhi_3 = 4500;
set @wsx_typ_4 = 1;
set @wsx_zhi_4 = 6000;



/*清理调试生成的合成物残留*/
DELETE FROM item_template WHERE entry>3100000;
DELETE FROM item_link_item_config WHERE level7=level10; 
DELETE FROM disenchant_loot_template WHERE entry>3000000; 
DROP TABLE IF EXISTS item_template_shengji_0;
DROP TABLE IF EXISTS item_template_shengji_1;
DROP TABLE IF EXISTS item_template_shengji_2;
DROP TABLE IF EXISTS item_template_shengji_3;
DROP TABLE IF EXISTS item_template_shengji_4;
DROP TABLE IF EXISTS item_template_shengji_5;

/*装备唯一改为2*/
UPDATE item_template SET maxcount = 2 where maxcount = 1 and (class = 4 or class = 2) and (ItemLevel > @hc_lv_min);

CREATE TABLE item_template_shengji_0 (select * from item_template where  (class = 4 or class = 2) and (ItemLevel > @hc_lv_min) and Quality > 0);
DELETE FROM item_template_shengji_0 WHERE entry = any(select sourceid from item_link_item_config);
DELETE FROM item_template_shengji_0 WHERE entry BETWEEN '1234568' AND '1274207';/* 去除工匠物品*/
DELETE FROM item_template_shengji_0 WHERE entry BETWEEN '150000' AND '159999';/* 去除自制物品(可以不管)*/
DELETE FROM item_template_shengji_0 WHERE entry BETWEEN '130000' AND '139999';/* 去除自制物品(可以不管)*/
update item_template_shengji_0 set stat_value1=@wsx_zhi_1,stat_type1=@wsx_typ_1,StatsCount=StatsCount+1 where (ItemLevel BETWEEN '1' AND '150') and stat_value1=0 and stat_value2=0 and stat_value3=0 and stat_value4=0 and stat_value5=0 and stat_value6=0 and stat_value7=0 and stat_value8=0 and stat_value9=0 and stat_value10=0;
update item_template_shengji_0 set stat_value1=@wsx_zhi_2,stat_type1=@wsx_typ_2,StatsCount=StatsCount+1 where (ItemLevel BETWEEN '151' AND '232') and stat_value1=0 and stat_value2=0 and stat_value3=0 and stat_value4=0 and stat_value5=0 and stat_value6=0 and stat_value7=0 and stat_value8=0 and stat_value9=0 and stat_value10=0;
update item_template_shengji_0 set stat_value1=@wsx_zhi_3,stat_type1=@wsx_typ_3,StatsCount=StatsCount+1 where (ItemLevel BETWEEN '233' AND '251') and stat_value1=0 and stat_value2=0 and stat_value3=0 and stat_value4=0 and stat_value5=0 and stat_value6=0 and stat_value7=0 and stat_value8=0 and stat_value9=0 and stat_value10=0;
update item_template_shengji_0 set stat_value1=@wsx_zhi_4,stat_type1=@wsx_typ_4,StatsCount=StatsCount+1 where (ItemLevel BETWEEN '252' AND '9999') and stat_value1=0 and stat_value2=0 and stat_value3=0 and stat_value4=0 and stat_value5=0 and stat_value6=0 and stat_value7=0 and stat_value8=0 and stat_value9=0 and stat_value10=0;
update item_template_shengji_0 set bonding = 1;

CREATE TABLE item_template_shengji_1 (SELECT * FROM `item_template_shengji_0` );/* lv1*/
CREATE TABLE item_template_shengji_2 (SELECT * FROM `item_template_shengji_0` );/* lv2*/
CREATE TABLE item_template_shengji_3 (SELECT * FROM `item_template_shengji_0` );/* lv3*/
CREATE TABLE item_template_shengji_4 (SELECT * FROM `item_template_shengji_0` );/* lv4*/
CREATE TABLE item_template_shengji_5 (SELECT * FROM `item_template_shengji_0` );/* lv5*/

/*删除合成表部分物品  效果：(条件可自己设置)
233装等以下的装备不可合成到lv4
251装等以下的装备不可合成到lv5
*/
DELETE FROM `item_template_shengji_4` WHERE ItemLevel<233;
DELETE FROM `item_template_shengji_5` WHERE ItemLevel<251;

/*按比例提升属性*/
update item_template_shengji_1 set name=concat(name,'|cFFFFFFFF◇英勇青铜|r');
update item_template_shengji_1 set entry = entry + 3100000;
UPDATE item_template_shengji_1 SET stat_value1 = stat_value1*@lv1;
UPDATE item_template_shengji_1 SET stat_value2 = stat_value2*@lv1;
UPDATE item_template_shengji_1 SET stat_value3 = stat_value3*@lv1;
UPDATE item_template_shengji_1 SET stat_value4 = stat_value4*@lv1;
UPDATE item_template_shengji_1 SET stat_value5 = stat_value5*@lv1;
UPDATE item_template_shengji_1 SET stat_value6 = stat_value6*@lv1;
UPDATE item_template_shengji_1 SET stat_value7 = stat_value7*@lv1;
UPDATE item_template_shengji_1 SET stat_value8 = stat_value8*@lv1;
UPDATE item_template_shengji_1 SET stat_value9 = stat_value9*@lv1;
UPDATE item_template_shengji_1 SET stat_value10 = stat_value10*@lv1;
UPDATE item_template_shengji_1 SET armor = armor*@lv1;
UPDATE item_template_shengji_1 SET holy_res = holy_res*@lv1;
UPDATE item_template_shengji_1 SET fire_res = fire_res*@lv1;
UPDATE item_template_shengji_1 SET nature_res = nature_res*@lv1;
UPDATE item_template_shengji_1 SET frost_res = frost_res*@lv1;
UPDATE item_template_shengji_1 SET shadow_res = shadow_res*@lv1;
UPDATE item_template_shengji_1 SET arcane_res = arcane_res*@lv1;
UPDATE item_template_shengji_1 SET dmg_min1 = dmg_min1*@lv1_dmg;
UPDATE item_template_shengji_1 SET dmg_max1 = dmg_max1*@lv1_dmg;
UPDATE item_template_shengji_1 SET SellPrice = SellPrice*2;
UPDATE item_template_shengji_1 SET itemlevel = itemlevel+2;

update item_template_shengji_2 set name=concat(name,'|cFF00FF00◇不屈白银|r');
update item_template_shengji_2 set entry = entry + 3200000;
UPDATE item_template_shengji_2 SET stat_value1 = stat_value1*@lv2;
UPDATE item_template_shengji_2 SET stat_value2 = stat_value2*@lv2;
UPDATE item_template_shengji_2 SET stat_value3 = stat_value3*@lv2;
UPDATE item_template_shengji_2 SET stat_value4 = stat_value4*@lv2;
UPDATE item_template_shengji_2 SET stat_value5 = stat_value5*@lv2;
UPDATE item_template_shengji_2 SET stat_value6 = stat_value6*@lv2;
UPDATE item_template_shengji_2 SET stat_value7 = stat_value7*@lv2;
UPDATE item_template_shengji_2 SET stat_value8 = stat_value8*@lv2;
UPDATE item_template_shengji_2 SET stat_value9 = stat_value9*@lv2;
UPDATE item_template_shengji_2 SET stat_value10 = stat_value10*@lv2;
UPDATE item_template_shengji_2 SET armor = armor*@lv2;
UPDATE item_template_shengji_2 SET holy_res = holy_res*@lv2;
UPDATE item_template_shengji_2 SET fire_res = fire_res*@lv2;
UPDATE item_template_shengji_2 SET nature_res = nature_res*@lv2;
UPDATE item_template_shengji_2 SET frost_res = frost_res*@lv2;
UPDATE item_template_shengji_2 SET shadow_res = shadow_res*@lv2;
UPDATE item_template_shengji_2 SET arcane_res = arcane_res*@lv2;
UPDATE item_template_shengji_2 SET dmg_min1 = dmg_min1*@lv2_dmg;
UPDATE item_template_shengji_2 SET dmg_max1 = dmg_max1*@lv2_dmg;
UPDATE item_template_shengji_2 SET SellPrice = SellPrice*4;
UPDATE item_template_shengji_2 SET itemlevel = itemlevel+4;

update item_template_shengji_3 set name=concat(name,'|cFF3399CC◇荣耀黄金|r');
update item_template_shengji_3 set entry = entry + 3300000;
UPDATE item_template_shengji_3 SET stat_value1 = stat_value1*@lv3;
UPDATE item_template_shengji_3 SET stat_value2 = stat_value2*@lv3;
UPDATE item_template_shengji_3 SET stat_value3 = stat_value3*@lv3;
UPDATE item_template_shengji_3 SET stat_value4 = stat_value4*@lv3;
UPDATE item_template_shengji_3 SET stat_value5 = stat_value5*@lv3;
UPDATE item_template_shengji_3 SET stat_value6 = stat_value6*@lv3;
UPDATE item_template_shengji_3 SET stat_value7 = stat_value7*@lv3;
UPDATE item_template_shengji_3 SET stat_value8 = stat_value8*@lv3;
UPDATE item_template_shengji_3 SET stat_value9 = stat_value9*@lv3;
UPDATE item_template_shengji_3 SET stat_value10 = stat_value10*@lv3;
UPDATE item_template_shengji_3 SET armor = armor*@lv3;
UPDATE item_template_shengji_3 SET holy_res = holy_res*@lv3;
UPDATE item_template_shengji_3 SET fire_res = fire_res*@lv3;
UPDATE item_template_shengji_3 SET nature_res = nature_res*@lv3;
UPDATE item_template_shengji_3 SET frost_res = frost_res*@lv3;
UPDATE item_template_shengji_3 SET shadow_res = shadow_res*@lv3;
UPDATE item_template_shengji_3 SET arcane_res = arcane_res*@lv3;
UPDATE item_template_shengji_3 SET dmg_min1 = dmg_min1*@lv3_dmg;
UPDATE item_template_shengji_3 SET dmg_max1 = dmg_max1*@lv3_dmg;
UPDATE item_template_shengji_3 SET SellPrice = SellPrice*8;
UPDATE item_template_shengji_3 SET itemlevel = itemlevel+8;

update item_template_shengji_4 set name=concat(name,'|cFF9900CC◇华贵铂金|r');
update item_template_shengji_4 set entry = entry + 3400000;
UPDATE item_template_shengji_4 SET stat_value1 = stat_value1*@lv4;
UPDATE item_template_shengji_4 SET stat_value2 = stat_value2*@lv4;
UPDATE item_template_shengji_4 SET stat_value3 = stat_value3*@lv4;
UPDATE item_template_shengji_4 SET stat_value4 = stat_value4*@lv4;
UPDATE item_template_shengji_4 SET stat_value5 = stat_value5*@lv4;
UPDATE item_template_shengji_4 SET stat_value6 = stat_value6*@lv4;
UPDATE item_template_shengji_4 SET stat_value7 = stat_value7*@lv4;
UPDATE item_template_shengji_4 SET stat_value8 = stat_value8*@lv4;
UPDATE item_template_shengji_4 SET stat_value9 = stat_value9*@lv4;
UPDATE item_template_shengji_4 SET stat_value10 = stat_value10*@lv4;
UPDATE item_template_shengji_4 SET armor = armor*@lv4;
UPDATE item_template_shengji_4 SET holy_res = holy_res*@lv4;
UPDATE item_template_shengji_4 SET fire_res = fire_res*@lv4;
UPDATE item_template_shengji_4 SET nature_res = nature_res*@lv4;
UPDATE item_template_shengji_4 SET frost_res = frost_res*@lv4;
UPDATE item_template_shengji_4 SET shadow_res = shadow_res*@lv4;
UPDATE item_template_shengji_4 SET arcane_res = arcane_res*@lv4;
UPDATE item_template_shengji_4 SET dmg_min1 = dmg_min1*@lv4_dmg;
UPDATE item_template_shengji_4 SET dmg_max1 = dmg_max1*@lv4_dmg;
UPDATE item_template_shengji_4 SET SellPrice = SellPrice*16;
UPDATE item_template_shengji_4 SET itemlevel = itemlevel+16;

update item_template_shengji_5 set name=concat(name,'|cFFFF9900◇璀璨钻石|r');
update item_template_shengji_5 set entry = entry + 3500000;
UPDATE item_template_shengji_5 SET stat_value1 = stat_value1*@lv5;
UPDATE item_template_shengji_5 SET stat_value2 = stat_value2*@lv5;
UPDATE item_template_shengji_5 SET stat_value3 = stat_value3*@lv5;
UPDATE item_template_shengji_5 SET stat_value4 = stat_value4*@lv5;
UPDATE item_template_shengji_5 SET stat_value5 = stat_value5*@lv5;
UPDATE item_template_shengji_5 SET stat_value6 = stat_value6*@lv5;
UPDATE item_template_shengji_5 SET stat_value7 = stat_value7*@lv5;
UPDATE item_template_shengji_5 SET stat_value8 = stat_value8*@lv5;
UPDATE item_template_shengji_5 SET stat_value9 = stat_value9*@lv5;
UPDATE item_template_shengji_5 SET stat_value10 = stat_value10*@lv5;
UPDATE item_template_shengji_5 SET armor = armor*@lv5;
UPDATE item_template_shengji_5 SET holy_res = holy_res*@lv5;
UPDATE item_template_shengji_5 SET fire_res = fire_res*@lv5;
UPDATE item_template_shengji_5 SET nature_res = nature_res*@lv5;
UPDATE item_template_shengji_5 SET frost_res = frost_res*@lv5;
UPDATE item_template_shengji_5 SET shadow_res = shadow_res*@lv5;
UPDATE item_template_shengji_5 SET arcane_res = arcane_res*@lv5;
UPDATE item_template_shengji_5 SET dmg_min1 = dmg_min1*@lv5_dmg;
UPDATE item_template_shengji_5 SET dmg_max1 = dmg_max1*@lv5_dmg;
UPDATE item_template_shengji_5 SET SellPrice = SellPrice*32;
UPDATE item_template_shengji_5 SET itemlevel = itemlevel+32;



/*添加分解掉落拆解*/
insert into disenchant_loot_template (entry) select entry from item_template_shengji_1;
insert into disenchant_loot_template (entry) select entry from item_template_shengji_2;
insert into disenchant_loot_template (entry) select entry from item_template_shengji_3;
insert into disenchant_loot_template (entry) select entry from item_template_shengji_4;
insert into disenchant_loot_template (entry) select entry from item_template_shengji_5;
update disenchant_loot_template set item = entry-3100000,groupid=1,ChanceOrQuestChance=@chaijie,mincountOrRef=2,maxcount=2 where entry BETWEEN '3100000' AND '3199999';
update disenchant_loot_template set item = entry-100000,groupid=1,ChanceOrQuestChance=@chaijie,mincountOrRef=2,maxcount=2 where entry BETWEEN '3200000' AND '3599999';

/*生成的合成物导入物品表*/
insert into item_template select * from item_template_shengji_1;
insert into item_template select * from item_template_shengji_2;
insert into item_template select * from item_template_shengji_3;
insert into item_template select * from item_template_shengji_4;
insert into item_template select * from item_template_shengji_5;

/*合成对应表改变默认值*/
alter table item_link_item_config alter column level1 set default 0;
alter table item_link_item_config alter column level2 set default 0;
alter table item_link_item_config alter column level3 set default 0;
alter table item_link_item_config alter column level4 set default 0;
alter table item_link_item_config alter column level5 set default 0;
alter table item_link_item_config alter column level6 set default 0;
alter table item_link_item_config alter column level7 set default 0;
alter table item_link_item_config alter column level8 set default 0;
alter table item_link_item_config alter column level9 set default 0;
alter table item_link_item_config alter column level10 set default 0;
alter table item_link_item_config alter column level11 set default 0;
alter table item_link_item_config alter column level12 set default 0;
alter table item_link_item_config alter column level13 set default 0;
alter table item_link_item_config alter column level14 set default 0;
alter table item_link_item_config alter column level15 set default 0;
alter table item_link_item_config alter column level16 set default 0;
alter table item_link_item_config alter column level17 set default 0;
alter table item_link_item_config alter column level18 set default 0;
alter table item_link_item_config alter column level19 set default 0;
alter table item_link_item_config alter column level20 set default 0;


/*添加合成对应表数据*/
INSERT INTO item_link_item_config (sourceid) select entry from item_template_shengji_0;
update item_link_item_config set level1=sourceid+3100000,level2=sourceid+3200000,level3=sourceid+3300000,level4=sourceid+3400000,level5=sourceid+3500000 where level9 = 0;

/*合成物分解生产物改变为*/
update item_template set DisenchantID = entry where entry>3100000;
update item_template set RequiredDisenchantSkill = 1 where entry>3100000;


/*删除工作表*/
DROP TABLE IF EXISTS item_template_shengji_0;
DROP TABLE IF EXISTS item_template_shengji_1;
DROP TABLE IF EXISTS item_template_shengji_2;
DROP TABLE IF EXISTS item_template_shengji_3;
DROP TABLE IF EXISTS item_template_shengji_4;
DROP TABLE IF EXISTS item_template_shengji_5;


