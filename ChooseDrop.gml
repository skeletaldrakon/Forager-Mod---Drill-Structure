#define ChooseDrop
var chance = irandom_range(0, 100);
lighthouseScale = LighthouseCalculate(x, y);
//always drops stone
DropItem(x, y, Item.Stone, round(irandom_range(3, 5) * lighthouseScale));
/*
    40% of 3-5 Sand (or 7-10 in the Desert)
    30% of 3-5 Coal, Iron Ore, Gold Ore, or biome specific resource (Crystal or Obisidian)
    20% of 3-5 Arrows or Bones
    9% of 1-3 Gems (1 of the 4 chosen at random with equal odds)
    1% of Artifact
    All of it should be affected by Lighthouses
*/
if (chance <= 40) {
    //get more sand in the desert
    if (GetBiome(x, y) == Biome.Desert) {
        DropItem(x, y, Item.Sand, round(irandom_range(7, 10) * lighthouseScale));
    } else {
        DropItem(x, y, Item.Sand, round(irandom_range(3, 5) * lighthouseScale));   
    }
} else if (chance > 40 && chance <= 70) {
    ChooseResource();
} else if (chance > 70 && chance <= 90) {
    ChooseJunk();
} else if (chance > 90 && chance <= 99) {
    ChooseGem();
} else {
    ChooseArtifact();
}

/* 
    handles choosing resources for the 30% pool
    Grass, Desert, and Graveyard use the Default helper
    Winter uses the Snow helper
    Fire uses the Volcano helper
*/
#define ChooseResource
var biome = GetBiome(x, y);
if (biome != Biome.Volcano && biome != Biome.Snow) {
    ChooseResourceDefault();
} else if (biome == Biome.Snow) {
    ChooseResourceSnow();
} else {
    ChooseResourceVolcano();
}

/* 
    default helper for biomes that aren't snow or volcano
    50% of 3-5 Coal
    30% of 3-5 Iron Ore
    20% of 3-5 Gold Ore
*/
#define ChooseResourceDefault
var chooseResource = irandom_range(1, 10);
if (chooseResource <= 5) {
    DropItem(x, y, Item.Coal, round(irandom_range(3, 5) * lighthouseScale));
} else if (chooseResource > 5 && chooseResource <= 8) {
    DropItem(x, y, Item.IronOre, round(irandom_range(3, 5) * lighthouseScale));
} else {
    DropItem(x, y, Item.GoldOre, round(irandom_range(3, 5) * lighthouseScale));
}

/* 
    helper for snow biome that adds crystals
    30% of 3-5 Coal
    30% of 3-5 Iron Ore
    20% of 3-5 Gold Ore
    20% of 2-4 Crystal
*/
#define ChooseResourceSnow
var chooseResource = irandom_range(1, 10);
if (chooseResource <= 3) {
    DropItem(x, y, Item.Coal, round(irandom_range(3, 5) * lighthouseScale));
} else if (chooseResource > 3 && chooseResource <= 6) {
    DropItem(x, y, Item.IronOre, round(irandom_range(3, 5) * lighthouseScale));
} else if (chooseResource > 6 && chooseResource <= 8) {
    DropItem(x, y, Item.GoldOre, round(irandom_range(3, 5) * lighthouseScale));
} else {
    DropItem(x, y, Item.Crystal, round(irandom_range(2, 4) * lighthouseScale));
}

/* 
    helper for volcano biome that adds obsidian
    40% of 3-5 Coal
    30% of 3-5 Iron Ore
    20% of 3-5 Gold Ore
    10% of 1-3 Obsidian
*/
#define ChooseResourceVolcano
var chooseResource = irandom_range(1, 10);
if (chooseResource <= 4) {
    DropItem(x, y, Item.Coal, round(irandom_range(3, 5) * lighthouseScale));
} else if (chooseResource > 4 && chooseResource <= 7) {
    DropItem(x, y, Item.IronOre, round(irandom_range(3, 5) * lighthouseScale));
} else if (chooseResource > 7 && chooseResource <= 9)  {
    DropItem(x, y, Item.GoldOre, round(irandom_range(3, 5) * lighthouseScale));
} else {
    DropItem(x, y, Item.Obsidian, round(irandom_range(1, 3) * lighthouseScale));
}

/* 
    handles choosing junk for the 20% pool including having a chance at great skulls in volcano biome
    If not Volcano Biome:
    50% for 3-5 Bone
    50% for 3-5 Arrow
    If Volcano Biome
    25% for 3-5 Bone
    25% for 1 Greak Skull
    50% for 3-5 Arrow
*/
#define ChooseJunk
var chooseJunk = irandom_range(1, 2);
if (chooseJunk == 1) {
    if (GetBiome(x, y) == Biome.Volcano) {
        var chooseBone = irandom_range (1, 2);
        if (chooseBone == 1) {
            DropItem(x, y, Item.Bone, round(irandom_range(3, 5) * lighthouseScale));  
        } else {
            DropItem(x, y, Item.GreatSkull, round(1 * lighthouseScale));  
        }
    } else {
        DropItem(x, y, Item.Bone, round(irandom_range(3, 5) * lighthouseScale));     
    }
} else {
    DropItem(x, y, Item.Arrow, round(irandom_range(3, 5) * lighthouseScale));
}


/* 
    handles choosing gems for the 9% pool with an even chance for each gem
    25% for 1-3 Ruby
    25% for 1-3 Emerald
    25% for 1-3 Topaz
    25% for 1-3 Amethyst
*/
#define ChooseGem
var chooseGem = irandom_range(1, 4);
if (chooseGem == 1) {
    DropItem(x, y, Item.Ruby, round(irandom_range(1, 3) * lighthouseScale));
} else if (chooseGem == 2) {
    DropItem(x, y, Item.Emerald, round(irandom_range(1, 3) * lighthouseScale));
} else if (chooseGem == 3) {
    DropItem(x, y, Item.Topaz, round(irandom_range(1, 3) * lighthouseScale));
} else {
    DropItem(x, y, Item.Amethyst, round(irandom_range(1, 3) * lighthouseScale));
}

/* 
    handles choosing artifacts for the 1% pool based on what biome your in
    You get 1 artifact of that biome, which is always the one you'd get from a dig spot
*/
#define ChooseArtifact
var biome = GetBiome(x, y);
if (biome == Biome.Grass) {
    DropItem(x, y, Item.Fossil, round(1 * lighthouseScale));
} else if (biome == Biome.Desert) {
    DropItem(x, y, Item.Sphynx, round(1 * lighthouseScale));
} else if (biome == Biome.Graveyard) {
    DropItem(x, y, Item.Kapala, round(1 * lighthouseScale));
} else if (biome == Biome.Snow) {
    DropItem(x, y, Item.FrozenRelic, round(1 * lighthouseScale));
} else if (biome == Biome.Volcano) {
    DropItem(x, y, Item.DinoEgg, round(1 * lighthouseScale));
}