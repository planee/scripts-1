

/*下面的数值为各等级合成的装备的基础属性&抗性&护甲的提升倍率*/
set @lv1 = 1.5;
set @lv2 = 2.1;
set @lv3 = 2.7;
set @lv4 = 3.5;
set @lv5 = 4.6;
/*下面的数值为各等级合成的装备武器伤害提升倍率*/
set @lv1_dmg = 1.12;
set @lv2_dmg = 1.24;
set @lv3_dmg = 1.48;
set @lv4_dmg = 1.96;
set @lv5_dmg = 2.92;
/*下面的是可合成装备的最低的装等，写10就是装等10以上的装备都会生成合成数据*/
set @hc_lv_min = 10;
/*为不附加任何属性的只带效果的装备(例如某些饰品)增加提高5000血量的效果
  下面的wsx_typ_x是要增加的属性类型，这里的1表示是血量
   wsx_zhi_y 是具体的数值
   1 表示 装等1~150的装备
   2 表示 装等151~232的装备
   3 表示 装等233~251的装备
   4 表示 装等252~999的装备*/
set @wsx_typ_1 = 1;
set @wsx_zhi_1 = 400;
set @wsx_typ_2 = 1;
set @wsx_zhi_2 = 800;
set @wsx_typ_3 = 1;
set @wsx_zhi_3 = 1200;
set @wsx_typ_4 = 1;
set @wsx_zhi_4 = 1600;


/*清理调试生成的合成物残留*/
DELETE FROM item_template WHERE entry>100000;
DELETE FROM disenchant_loot_template WHERE entry>100000; 
DROP TABLE IF EXISTS item_template_shengji_0;
DROP TABLE IF EXISTS item_template_shengji_1;
DROP TABLE IF EXISTS item_template_shengji_2;
DROP TABLE IF EXISTS item_template_shengji_3;
DROP TABLE IF EXISTS item_template_shengji_4;
DROP TABLE IF EXISTS item_template_shengji_5;
DROP TABLE IF EXISTS item_up_1_0_100;
DROP TABLE IF EXISTS item_up_2_0_100;
DROP TABLE IF EXISTS item_up_3_0_100;
DROP TABLE IF EXISTS item_up_4_0_100;
DROP TABLE IF EXISTS item_up_5_0_100;
DROP TABLE IF EXISTS item_up_1_101_150;
DROP TABLE IF EXISTS item_up_2_101_150;
DROP TABLE IF EXISTS item_up_3_101_150;
DROP TABLE IF EXISTS item_up_4_101_150;
DROP TABLE IF EXISTS item_up_5_101_150;
DROP TABLE IF EXISTS item_up_1_151_200;
DROP TABLE IF EXISTS item_up_2_151_200;
DROP TABLE IF EXISTS item_up_3_151_200;
DROP TABLE IF EXISTS item_up_4_151_200;
DROP TABLE IF EXISTS item_up_5_151_200;
DROP TABLE IF EXISTS item_up_1_201_251;
DROP TABLE IF EXISTS item_up_2_201_251;
DROP TABLE IF EXISTS item_up_3_201_251;
DROP TABLE IF EXISTS item_up_4_201_251;
DROP TABLE IF EXISTS item_up_5_201_251;
DROP TABLE IF EXISTS item_up_1_252_999;
DROP TABLE IF EXISTS item_up_2_252_999;
DROP TABLE IF EXISTS item_up_3_252_999;
DROP TABLE IF EXISTS item_up_4_252_999;
DROP TABLE IF EXISTS item_up_5_252_999;
DROP TABLE IF EXISTS item_up;

SET FOREIGN_KEY_CHECKS=0;

CREATE TABLE `item_up` (
  `entry` mediumint(255) NOT NULL,
  `chengpin` mediumint(255) NOT NULL,
  `cailiao1` mediumint(255) NOT NULL,
  `shuliang1` int(255) NOT NULL,
  `cailiao2` mediumint(255) NOT NULL,
  `shuliang2` int(255) NOT NULL,
  `cailiao3` mediumint(255) NOT NULL,
  `shuliang3` int(255) NOT NULL,
  `cailiao4` mediumint(255) NOT NULL,
  `shuliang4` int(255) NOT NULL,
  `cailiao5` mediumint(255) NOT NULL,
  `shuliang5` int(255) NOT NULL,
  `jilv` int(255) NOT NULL,
  `baoshi` mediumint(255) NOT NULL,
  `suilie` int(255) NOT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
  alter table item_up alter column chengpin set default 0;
  alter table item_up alter column cailiao1 set default 0;
  alter table item_up alter column shuliang1 set default 0;
  alter table item_up alter column cailiao2 set default 0;
  alter table item_up alter column shuliang2 set default 0;
  alter table item_up alter column cailiao3 set default 0;
  alter table item_up alter column shuliang3 set default 0;
  alter table item_up alter column cailiao4 set default 0;
  alter table item_up alter column shuliang4 set default 0;
  alter table item_up alter column cailiao5 set default 0;
  alter table item_up alter column shuliang5 set default 0;
  alter table item_up alter column jilv set default 0;
  alter table item_up alter column baoshi set default 0;
  alter table item_up alter column suilie set default 0;


/*装备唯一改为2*/
UPDATE item_template SET maxcount = 0 where maxcount = 1 and (class = 4 or class = 2) and (ItemLevel > @hc_lv_min) and entry>100000;
ALTER TABLE `item_template`
	CHANGE COLUMN `holy_res` `holy_res` INT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `armor`,
	CHANGE COLUMN `fire_res` `fire_res` INT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `holy_res`,
	CHANGE COLUMN `nature_res` `nature_res` INT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `fire_res`,
	CHANGE COLUMN `frost_res` `frost_res` INT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `nature_res`,
	CHANGE COLUMN `shadow_res` `shadow_res` INT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `frost_res`,
	CHANGE COLUMN `arcane_res` `arcane_res` INT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `shadow_res`;

CREATE TABLE item_template_shengji_0 (select * from item_template where  (class = 4 or class = 2) and (ItemLevel > @hc_lv_min) and Quality > 0);

update item_template_shengji_0 set stat_value1=@wsx_zhi_1,stat_type1=@wsx_typ_1,StatsCount=StatsCount+1 where (ItemLevel BETWEEN '1' AND '100') and stat_value1=0 and stat_value2=0 and stat_value3=0 and stat_value4=0 and stat_value5=0 and stat_value6=0 and stat_value7=0 and stat_value8=0 and stat_value9=0 and stat_value10=0;
update item_template_shengji_0 set stat_value1=@wsx_zhi_2,stat_type1=@wsx_typ_2,StatsCount=StatsCount+1 where (ItemLevel BETWEEN '101' AND '232') and stat_value1=0 and stat_value2=0 and stat_value3=0 and stat_value4=0 and stat_value5=0 and stat_value6=0 and stat_value7=0 and stat_value8=0 and stat_value9=0 and stat_value10=0;
update item_template_shengji_0 set stat_value1=@wsx_zhi_3,stat_type1=@wsx_typ_3,StatsCount=StatsCount+1 where (ItemLevel BETWEEN '233' AND '251') and stat_value1=0 and stat_value2=0 and stat_value3=0 and stat_value4=0 and stat_value5=0 and stat_value6=0 and stat_value7=0 and stat_value8=0 and stat_value9=0 and stat_value10=0;
update item_template_shengji_0 set stat_value1=@wsx_zhi_4,stat_type1=@wsx_typ_4,StatsCount=StatsCount+1 where (ItemLevel BETWEEN '252' AND '9999') and stat_value1=0 and stat_value2=0 and stat_value3=0 and stat_value4=0 and stat_value5=0 and stat_value6=0 and stat_value7=0 and stat_value8=0 and stat_value9=0 and stat_value10=0;
update item_template_shengji_0 set bonding = 1;

UPDATE item_template_shengji_0 SET RandomProperty = 10001 where (ItemLevel BETWEEN '1' AND '60') and RandomProperty=0 and RandomSuffix=0;
UPDATE item_template_shengji_0 SET RandomProperty = 10002 where (ItemLevel BETWEEN '61' AND '120') and RandomProperty=0 and RandomSuffix=0;
UPDATE item_template_shengji_0 SET RandomProperty = 10003 where (ItemLevel BETWEEN '121' AND '180') and RandomProperty=0 and RandomSuffix=0;
UPDATE item_template_shengji_0 SET RandomProperty = 10004 where (ItemLevel BETWEEN '181' AND '240') and RandomProperty=0 and RandomSuffix=0;
UPDATE item_template_shengji_0 SET RandomProperty = 10005 where (ItemLevel BETWEEN '241' AND '900') and RandomProperty=0 and RandomSuffix=0;

CREATE TABLE item_template_shengji_1 (SELECT * FROM `item_template_shengji_0` );/* lv1*/
CREATE TABLE item_template_shengji_2 (SELECT * FROM `item_template_shengji_0` );/* lv2*/
CREATE TABLE item_template_shengji_3 (SELECT * FROM `item_template_shengji_0` );/* lv3*/
CREATE TABLE item_template_shengji_4 (SELECT * FROM `item_template_shengji_0` );/* lv4*/
CREATE TABLE item_template_shengji_5 (SELECT * FROM `item_template_shengji_0` );/* lv5*/

DELETE FROM `item_template_shengji_4` WHERE ItemLevel<233;
DELETE FROM `item_template_shengji_5` WHERE ItemLevel<251;

update item_template_shengji_1 set name=concat(name,'|cFFFFFFFF◇英勇青铜|r');
update item_template_shengji_1 set entry = entry + 100000;
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
UPDATE item_template_shengji_1 SET SellPrice = SellPrice*1;
UPDATE item_template_shengji_1 SET itemlevel = itemlevel+10;

update item_template_shengji_2 set name=concat(name,'|cFF00FF00◇不屈白银|r');
update item_template_shengji_2 set entry = entry + 200000;
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
UPDATE item_template_shengji_2 SET SellPrice = SellPrice*1;
UPDATE item_template_shengji_2 SET itemlevel = itemlevel+20;

update item_template_shengji_3 set name=concat(name,'|cFF3399CC◇荣耀黄金|r');
update item_template_shengji_3 set entry = entry + 300000;
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
UPDATE item_template_shengji_3 SET SellPrice = SellPrice*4;
UPDATE item_template_shengji_3 SET itemlevel = itemlevel+30;

update item_template_shengji_4 set name=concat(name,'|cFF9900CC◇华贵铂金|r');
update item_template_shengji_4 set entry = entry + 400000;
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
UPDATE item_template_shengji_4 SET SellPrice = SellPrice*8;
UPDATE item_template_shengji_4 SET itemlevel = itemlevel+40;

update item_template_shengji_5 set name=concat(name,'|cFFFF9900◇璀璨钻石|r');
update item_template_shengji_5 set entry = entry + 500000;
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
UPDATE item_template_shengji_5 SET itemlevel = itemlevel+80;

CREATE TABLE item_up_1_0_100  (SELECT * FROM item_up);
CREATE TABLE item_up_2_0_100  (SELECT * FROM item_up);
CREATE TABLE item_up_3_0_100  (SELECT * FROM item_up);
CREATE TABLE item_up_4_0_100  (SELECT * FROM item_up);
CREATE TABLE item_up_5_0_100  (SELECT * FROM item_up);
CREATE TABLE item_up_1_101_150  (SELECT * FROM item_up);
CREATE TABLE item_up_2_101_150  (SELECT * FROM item_up);
CREATE TABLE item_up_3_101_150  (SELECT * FROM item_up);
CREATE TABLE item_up_4_101_150  (SELECT * FROM item_up);
CREATE TABLE item_up_5_101_150  (SELECT * FROM item_up);
CREATE TABLE item_up_1_151_200  (SELECT * FROM item_up);
CREATE TABLE item_up_2_151_200  (SELECT * FROM item_up);
CREATE TABLE item_up_3_151_200  (SELECT * FROM item_up);
CREATE TABLE item_up_4_151_200  (SELECT * FROM item_up);
CREATE TABLE item_up_5_151_200  (SELECT * FROM item_up);
CREATE TABLE item_up_1_201_251  (SELECT * FROM item_up);
CREATE TABLE item_up_2_201_251  (SELECT * FROM item_up);
CREATE TABLE item_up_3_201_251  (SELECT * FROM item_up);
CREATE TABLE item_up_4_201_251  (SELECT * FROM item_up);
CREATE TABLE item_up_5_201_251  (SELECT * FROM item_up);
CREATE TABLE item_up_1_252_999  (SELECT * FROM item_up);
CREATE TABLE item_up_2_252_999  (SELECT * FROM item_up);
CREATE TABLE item_up_3_252_999  (SELECT * FROM item_up);
CREATE TABLE item_up_4_252_999  (SELECT * FROM item_up);
CREATE TABLE item_up_5_252_999  (SELECT * FROM item_up);

INSERT INTO item_up_1_0_100 (entry) (SELECT entry FROM `item_template_shengji_0` where (ItemLevel BETWEEN '1' AND '100'));
INSERT INTO item_up_2_0_100 (entry) (SELECT entry FROM `item_template_shengji_1` where (ItemLevel BETWEEN '1' AND '100'));
INSERT INTO item_up_3_0_100 (entry) (SELECT entry FROM `item_template_shengji_2` where (ItemLevel BETWEEN '1' AND '100'));
INSERT INTO item_up_4_0_100 (entry) (SELECT entry FROM `item_template_shengji_3` where (ItemLevel BETWEEN '1' AND '100'));
INSERT INTO item_up_5_0_100 (entry) (SELECT entry FROM `item_template_shengji_4` where (ItemLevel BETWEEN '1' AND '100'));
INSERT INTO item_up_1_101_150 (entry) (SELECT entry FROM `item_template_shengji_0` where (ItemLevel BETWEEN '101' AND '150'));
INSERT INTO item_up_2_101_150 (entry) (SELECT entry FROM `item_template_shengji_1` where (ItemLevel BETWEEN '101' AND '150'));
INSERT INTO item_up_3_101_150 (entry) (SELECT entry FROM `item_template_shengji_2` where (ItemLevel BETWEEN '101' AND '150'));
INSERT INTO item_up_4_101_150 (entry) (SELECT entry FROM `item_template_shengji_3` where (ItemLevel BETWEEN '101' AND '150'));
INSERT INTO item_up_5_101_150 (entry) (SELECT entry FROM `item_template_shengji_4` where (ItemLevel BETWEEN '101' AND '150'));
INSERT INTO item_up_1_151_200 (entry) (SELECT entry FROM `item_template_shengji_0` where (ItemLevel BETWEEN '151' AND '200'));
INSERT INTO item_up_2_151_200 (entry) (SELECT entry FROM `item_template_shengji_1` where (ItemLevel BETWEEN '151' AND '200'));
INSERT INTO item_up_3_151_200 (entry) (SELECT entry FROM `item_template_shengji_2` where (ItemLevel BETWEEN '151' AND '200'));
INSERT INTO item_up_4_151_200 (entry) (SELECT entry FROM `item_template_shengji_3` where (ItemLevel BETWEEN '151' AND '200'));
INSERT INTO item_up_5_151_200 (entry) (SELECT entry FROM `item_template_shengji_4` where (ItemLevel BETWEEN '151' AND '200'));
INSERT INTO item_up_1_201_251 (entry) (SELECT entry FROM `item_template_shengji_0` where (ItemLevel BETWEEN '201' AND '251'));
INSERT INTO item_up_2_201_251 (entry) (SELECT entry FROM `item_template_shengji_1` where (ItemLevel BETWEEN '201' AND '251'));
INSERT INTO item_up_3_201_251 (entry) (SELECT entry FROM `item_template_shengji_2` where (ItemLevel BETWEEN '201' AND '251'));
INSERT INTO item_up_4_201_251 (entry) (SELECT entry FROM `item_template_shengji_3` where (ItemLevel BETWEEN '201' AND '251'));
INSERT INTO item_up_5_201_251 (entry) (SELECT entry FROM `item_template_shengji_4` where (ItemLevel BETWEEN '201' AND '251'));
INSERT INTO item_up_1_252_999 (entry) (SELECT entry FROM `item_template_shengji_0` where (ItemLevel BETWEEN '252' AND '999'));
INSERT INTO item_up_2_252_999 (entry) (SELECT entry FROM `item_template_shengji_1` where (ItemLevel BETWEEN '252' AND '999'));
INSERT INTO item_up_3_252_999 (entry) (SELECT entry FROM `item_template_shengji_2` where (ItemLevel BETWEEN '252' AND '999'));
INSERT INTO item_up_4_252_999 (entry) (SELECT entry FROM `item_template_shengji_3` where (ItemLevel BETWEEN '252' AND '999'));
INSERT INTO item_up_5_252_999 (entry) (SELECT entry FROM `item_template_shengji_4` where (ItemLevel BETWEEN '252' AND '999'));

update item_up_1_0_100 set chengpin=entry+100000,cailiao1=entry,shuliang1=1,cailiao2=70001,shuliang2=2,cailiao3=70002,shuliang3=3,jilv=95; 	/*lv0 to lv1*/
update item_up_2_0_100 set chengpin=entry+100000,cailiao1=entry,shuliang1=1,cailiao2=70001,shuliang2=4,cailiao3=70002,shuliang3=6,jilv=90; 	/*lv1 to lv2*/
update item_up_3_0_100 set chengpin=entry+100000,cailiao1=entry,shuliang1=2,cailiao2=70001,shuliang2=6,cailiao3=70002,shuliang3=9,jilv=85;	/*lv2 to lv3*/
update item_up_4_0_100 set chengpin=entry+100000,cailiao1=entry,shuliang1=2,cailiao2=70001,shuliang2=8,cailiao3=70002,shuliang3=12,jilv=80; /*lv3 to lv4*/
update item_up_5_0_100 set chengpin=entry+100000,cailiao1=entry,shuliang1=3,cailiao2=70001,shuliang2=10,cailiao3=70002,shuliang3=15,cailiao4=70009,shuliang4=1,jilv=75;	/*lv4 to lv5*/
update item_up_1_101_150 set chengpin=entry+100000,cailiao1=entry,shuliang1=1,cailiao2=70001,shuliang2=4,cailiao3=70002,shuliang3=6,jilv=90; 	/*lv0 to lv1*/
update item_up_2_101_150 set chengpin=entry+100000,cailiao1=entry,shuliang1=1,cailiao2=70001,shuliang2=8,cailiao3=70002,shuliang3=12,jilv=85; 	/*lv1 to lv2*/
update item_up_3_101_150 set chengpin=entry+100000,cailiao1=entry,shuliang1=2,cailiao2=70001,shuliang2=16,cailiao3=70002,shuliang3=18,jilv=80;	/*lv2 to lv3*/
update item_up_4_101_150 set chengpin=entry+100000,cailiao1=entry,shuliang1=2,cailiao2=70001,shuliang2=20,cailiao3=70002,shuliang3=24,jilv=75; /*lv3 to lv4*/
update item_up_5_101_150 set chengpin=entry+100000,cailiao1=entry,shuliang1=3,cailiao2=70001,shuliang2=24,cailiao3=70002,shuliang3=30,cailiao4=70009,shuliang4=1,jilv=70;	/*lv4 to lv5*/
update item_up_1_151_200 set chengpin=entry+100000,cailiao1=entry,shuliang1=1,cailiao2=70001,shuliang2=6,cailiao3=70002,shuliang3=9,jilv=85; 	/*lv0 to lv1*/
update item_up_2_151_200 set chengpin=entry+100000,cailiao1=entry,shuliang1=1,cailiao2=70001,shuliang2=12,cailiao3=70002,shuliang3=18,jilv=80; 	/*lv1 to lv2*/
update item_up_3_151_200 set chengpin=entry+100000,cailiao1=entry,shuliang1=2,cailiao2=70001,shuliang2=18,cailiao3=70002,shuliang3=27,jilv=75;	/*lv2 to lv3*/
update item_up_4_151_200 set chengpin=entry+100000,cailiao1=entry,shuliang1=2,cailiao2=70001,shuliang2=24,cailiao3=70002,shuliang3=36,jilv=70; /*lv3 to lv4*/
update item_up_5_151_200 set chengpin=entry+100000,cailiao1=entry,shuliang1=3,cailiao2=70001,shuliang2=30,cailiao3=70002,shuliang3=45,cailiao4=70009,shuliang4=1,jilv=65;	/*lv4 to lv5*/
update item_up_1_201_251 set chengpin=entry+100000,cailiao1=entry,shuliang1=1,cailiao2=70001,shuliang2=8,cailiao3=70002,shuliang3=12,jilv=80; 	/*lv0 to lv1*/
update item_up_2_201_251 set chengpin=entry+100000,cailiao1=entry,shuliang1=1,cailiao2=70001,shuliang2=16,cailiao3=70002,shuliang3=24,jilv=75; 	/*lv1 to lv2*/
update item_up_3_201_251 set chengpin=entry+100000,cailiao1=entry,shuliang1=2,cailiao2=70001,shuliang2=24,cailiao3=70002,shuliang3=36,jilv=70;	/*lv2 to lv3*/
update item_up_4_201_251 set chengpin=entry+100000,cailiao1=entry,shuliang1=2,cailiao2=70001,shuliang2=32,cailiao3=70002,shuliang3=48,jilv=65; /*lv3 to lv4*/
update item_up_5_201_251 set chengpin=entry+100000,cailiao1=entry,shuliang1=3,cailiao2=70001,shuliang2=40,cailiao3=70002,shuliang3=60,cailiao4=70009,shuliang4=2,jilv=60;	/*lv4 to lv5*/
update item_up_1_252_999 set chengpin=entry+100000,cailiao1=entry,shuliang1=1,cailiao2=70001,shuliang2=10,cailiao3=70002,shuliang3=15,jilv=75; 	/*lv0 to lv1*/
update item_up_2_252_999 set chengpin=entry+100000,cailiao1=entry,shuliang1=1,cailiao2=70001,shuliang2=20,cailiao3=70002,shuliang3=30,jilv=70; 	/*lv1 to lv2*/
update item_up_3_252_999 set chengpin=entry+100000,cailiao1=entry,shuliang1=2,cailiao2=70001,shuliang2=30,cailiao3=70002,shuliang3=45,jilv=65;	/*lv2 to lv3*/
update item_up_4_252_999 set chengpin=entry+100000,cailiao1=entry,shuliang1=2,cailiao2=70001,shuliang2=40,cailiao3=70002,shuliang3=60,jilv=60; /*lv3 to lv4*/
update item_up_5_252_999 set chengpin=entry+100000,cailiao1=entry,shuliang1=3,cailiao2=70001,shuliang2=50,cailiao3=70002,shuliang3=75,cailiao4=70009,shuliang4=3,jilv=55;	/*lv4 to lv5*/

insert into item_up select * from item_up_1_0_100;
insert into item_up select * from item_up_2_0_100;
insert into item_up select * from item_up_3_0_100;
insert into item_up select * from item_up_4_0_100;
insert into item_up select * from item_up_5_0_100;
insert into item_up select * from item_up_1_101_150;
insert into item_up select * from item_up_2_101_150;
insert into item_up select * from item_up_3_101_150;
insert into item_up select * from item_up_4_101_150;
insert into item_up select * from item_up_5_101_150;
insert into item_up select * from item_up_1_151_200;
insert into item_up select * from item_up_2_151_200;
insert into item_up select * from item_up_3_151_200;
insert into item_up select * from item_up_4_151_200;
insert into item_up select * from item_up_5_151_200;
insert into item_up select * from item_up_1_201_251;
insert into item_up select * from item_up_2_201_251;
insert into item_up select * from item_up_3_201_251;
insert into item_up select * from item_up_4_201_251;
insert into item_up select * from item_up_5_201_251;
insert into item_up select * from item_up_1_252_999;
insert into item_up select * from item_up_2_252_999;
insert into item_up select * from item_up_3_252_999;
insert into item_up select * from item_up_4_252_999;
insert into item_up select * from item_up_5_252_999;

insert into item_template select * from item_template_shengji_1;
insert into item_template select * from item_template_shengji_2;
insert into item_template select * from item_template_shengji_3;
insert into item_template select * from item_template_shengji_4;
insert into item_template select * from item_template_shengji_5;

DROP TABLE IF EXISTS item_template_shengji_0;
DROP TABLE IF EXISTS item_template_shengji_1;
DROP TABLE IF EXISTS item_template_shengji_2;
DROP TABLE IF EXISTS item_template_shengji_3;
DROP TABLE IF EXISTS item_template_shengji_4;
DROP TABLE IF EXISTS item_template_shengji_5;
DROP TABLE IF EXISTS item_up_1_0_100;
DROP TABLE IF EXISTS item_up_2_0_100;
DROP TABLE IF EXISTS item_up_3_0_100;
DROP TABLE IF EXISTS item_up_4_0_100;
DROP TABLE IF EXISTS item_up_5_0_100;
DROP TABLE IF EXISTS item_up_1_101_150;
DROP TABLE IF EXISTS item_up_2_101_150;
DROP TABLE IF EXISTS item_up_3_101_150;
DROP TABLE IF EXISTS item_up_4_101_150;
DROP TABLE IF EXISTS item_up_5_101_150;
DROP TABLE IF EXISTS item_up_1_151_200;
DROP TABLE IF EXISTS item_up_2_151_200;
DROP TABLE IF EXISTS item_up_3_151_200;
DROP TABLE IF EXISTS item_up_4_151_200;
DROP TABLE IF EXISTS item_up_5_151_200;
DROP TABLE IF EXISTS item_up_1_201_251;
DROP TABLE IF EXISTS item_up_2_201_251;
DROP TABLE IF EXISTS item_up_3_201_251;
DROP TABLE IF EXISTS item_up_4_201_251;
DROP TABLE IF EXISTS item_up_5_201_251;
DROP TABLE IF EXISTS item_up_1_252_999;
DROP TABLE IF EXISTS item_up_2_252_999;
DROP TABLE IF EXISTS item_up_3_252_999;
DROP TABLE IF EXISTS item_up_4_252_999;
DROP TABLE IF EXISTS item_up_5_252_999;
