#define Main
//dimensions are 27 x 43
var sprDrill = sprite_add("forager_drill.png", 4, false, false, 13, 42);

//add unlocking drills to the Drilling desc.
LocalizationAddKey("english", "skillDesc7", "U unlocks drills and offshore drills**U offshore drills may gather sand*for free**U provides a 25% chance to*find coal when digging")

//The only collidable part should be the base
sprite_collision_mask(sprDrill, false, 2, 0, 34, 27, 43, 1, 0);

global.Drill = StructureCreate(
    undefined,
    "Drill",
    "Digs for items underground",
    StructureType.Base,
    sprDrill,
    undefined,
    [Item.Electronics, 2, Item.Steel, 5],
    2,
    false,
    undefined,
    false, //edit to true when they get drilling
    BuildMenuCategory.Industrial,
    undefined,
)

#define OnSystemStep()
//check if they have drilling and haven't already unlocked the structure
if (HasSkill(Skill.Drilling) && !StructureGet(global.Drill, StructureData.Unlocked)) {
    StructureEdit(global.Drill, StructureData.Unlocked, true);
}

#define OnStructureSpawn(inst, structure)
antiCull = true;
global.count = 0; //used in DrillStep
if (structure == global.Drill) {
    InstanceAssignMethod(inst, "step", ScriptWrap(DrillStep), true);
}

#define DrillStep
global.count++;
//every 5 seconds it does a drop (1 second == 60 frame)
if (global.count == 60 * 5) {
    ScriptCall(ScriptWrap(ChooseDrop)); //ChooseDrop is in it's own GML file
    global.count = 0;
}
