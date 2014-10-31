
SET @ENTRY := 186267;
UPDATE `gameobject_template` SET `AIName`="SmartGameObjectAI" WHERE `entry`=186267;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=9;
DELETE FROM `smart_scripts` WHERE `entryorguid`=-54947 AND `source_type`=1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(-54947,1,0,0,62,0,100,0,8891,0,0,0,80,186267,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gameobject - Event - Action (phase) (dungeon difficulty)"),
(@ENTRY,9,0,0,0,0,100,0,0,0,0,0,12,23682,3,300000,0,0,0,1,0,0,0,0,0,0,0,"Gameobject - Event - Action (phase) (dungeon difficulty)"),
(@ENTRY,9,1,0,0,0,100,0,0,0,0,0,104,4,0,0,0,0,0,1,0,0,0,0,0,0,0,"Source - Event - Action (phase) (dungeon difficulty)"),
(@ENTRY,9,2,0,0,0,100,0,0,0,0,0,72,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Source - Event - Action (phase) (dungeon difficulty)");
DELETE FROM `gameobject_queststarter` WHERE (`id`=@ENTRY);
