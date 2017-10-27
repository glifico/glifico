<?php
$currencies=array(
  "translation",
  "accounting",
  "advertising: TV, radio, newspapers",
  "agriculture",
  "architecture",
  "art",
  "art history",
  "astronomy",
  "automotive engineering",
  "aviation",
  "banking",
  "biology",
  "business correspondence",
  "business terminology",
  "chemistry",
  "communications",
  "computing",
  "conservation - ecology",
  "construction",
  "contracts",
  "cookery",
  "cosmetics",
  "crime",
  "culture",
  "defence",
  "documentary programmes",
  "domestic products",
  "economics",
  "education",
  "electrical engineering",
  "electronic engineering",
  "finance",
  "fine arts",
  "food",
  "food industry",
  "forest management",
  "geodesy",
  "graphics",
  "handbooks",
  "health education, rehabilitation",
  "history",
  "humanities",
  "hunting",
  "immigration and refugees",
  "information technology",
  "insurance",
  "intellectual property",
  "international law",
  "international relations",
  "food processing equipment",
  "journals",
  "law",
  "legal terminology",
  "legislation",
  "literature",
  "management",
  "marketing",
  "mathematics",
  "medicine",
  "metallurgy",
  "military terminology",
  "mining",
  "music",
  "newspaper articles",
  "nuclear energy",
  "offers and contracts",
  "para-science",
  "patents",
  "personal documents",
  "pharmacology",
  "philosophy",
  "photography",
  "physics",
  "police",
  "politics",
  "promotions",
  "psychology",
  "quality",
  "reclamation",
  "religion",
  "school",
  "science",
  "shopping",
  "social science",
  "social security",
  "sport",
  "sport medicine",
  "sporting competitions",
  "standardisation",
  "standards",
  "technical documentation",
  "technical regulations",
  "telecommunications",
  "television films and serials",
  "textiles",
  "tourism",
  "traffic management",
  "transport",
  "white goods",
  "wood industry",
  "wood working",
  "wood working equipment",
  "consecutive interpretation",
  "simultaneous interpretation",
  "correction");


  $exit=[];
  $id=0;
  foreach ($currencies as $value) {
    array_push($exit,array("Id"=>$id,"Field"=>$value));
    $id+=1;
  }
  exit(json_encode($exit));
  ?>
