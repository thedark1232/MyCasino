local image = require("image")
local buffer = require("doubleBuffering")
local shell = require("shell")
local casino = require("casino")
local event = require("event")
local component = require("component")
local term = require("term")
local filesystem = require("filesystem")
local filesLibrary = require("filesLibrary")
local serialization = require("serialization")
local chat = component.chat_box
local modem = component.modem
local diamond = component.diamond
local me_interface = component.me_interface

-------------------------------важная конфигурация!!-------------------------------------------
local koJIu4ectBo_geHer_3a_urpy = 15
local TecT_degub_u3o6PaJeHuu = false
local ygaJIeHue_cTapblx_u3o6paJeHuu_npegMeToB_nepeg_3arpy3kou = false
local TecT_cB9l3u_u3o6paJeHuu_c_Ta6JIuceu = false
local BCero_u3o6paJeHuu_npegMeToB_B_Ta6JIuce_JeJIe3Horo_keuca = 87
local Ha3BaHue_kapTuHok_npegMeToB_Ha_GitHub = "image"
--аниция прокрутки итемов в окошке, во время игры
local yckopeHue_npokpyTku = 0.01
local ckopocTb_npokpyTku = 0.01
local koJIu4ecTBo_npokpyTok = 20
local nepeMeHHa9l_c6poca_lvl_urpoka = 15 --если приз больше или равен этой цифре, то сбросить лвл игрока до начального значения
local npuBblIIIeHue_JIuMuTa_Bbl6opa_npu3a = 500 --чтобы не войти в бесконечный цикл
-------------------------------важная конфигурация!!-------------------------------------------
local nanka_JeJIe3Hogo_keuca, nanka_3oJIoToro_keuca, nanka_aJIMa3Horo_keuca, nanka_gpak_keuca, nanka_keuca_yga4u = "/home/images/keuc_JeJIe3Hblu/", "/home/images/keuc_zoJIoTou/", "/home/images/keuc_aJIMa3Hblu/", "/home/images/keuc_graKoHuu/", "/home/images/keuc_yga4u/"
local nanka_JIoroB_urpokoB = "/home/Ta6JIucbl_urpokoB_B_keycbl/" --так же надо будет изменить путь в лаунчере, при просмотре логов
local cTouMocTb_ogHou_ugrbl_JeJIe3Horo_keuca = 15
local nanka_3agHero_qpoHa = "/image/zagHuu_qpoH_urpbl/"
local zagHuu_qpoH_JeJIe3Hogo_Keuca = "zagHuu_qpoH_JeJIe3Hogo_Keuca.pic"
local zagHuu_qpoH_JeJIe3Hogo_Keuca_c_kHonkaMu = "zagHuu_qpoH_JeJIe3Hogo_Keuca_c_kHonkaMu.pic"
local zagHuu_qpoH_JeJIe3Hogo_Keuca_c_kHonkaMu_u_TekcToM = "zagHuu_qpoH_JeJIe3Hogo_Keuca_c_kHonkaMu_u_TekcToM.pic"
local zagHuu_qpoH_JeJIe3Hogo_Keuca_npuBeTcTBue1 = "zagHuu_qpoH_JeJIe3Hogo_Keuca_npuBeTcTBue1.pic"
local zagHuu_qpoH_JeJIe3Hogo_Keuca_npuBeTcTBue2 = "zagHuu_qpoH_JeJIe3Hogo_Keuca_npuBeTcTBue2.pic"
local koopguHaTa_cTapToBou_kHonku_no_x, koopguHaTa_cTapToBou_kHonku_no_y, IIIupuHa_cTapToBou_kHonku, gJIuHHa_cTapToBou_kHonku = 75, 45, 20, 3
local nick_HaJaBIIIero_Ha_cTaPToByI0_kHonky = ""
local BblpaBHuBaHue_pecoB_no_x, BblpaBHuBaHue_no_x = 1
local pa3Mep_u3o6PaJeHu9l_no_x = 40
local Ta6JIuca_rolla = {}
local u3o6PaJeHu9l_JeJIe3Horo_keuCa = {}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["kaMeHb"] = {"kaMeHb", 1, "камень", "image40.pic", "minecraft:stone", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["block_TpaBbl"] = {"block_TpaBbl", 1, "блок травы", "image5.pic", "minecraft:grass", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["o6cuguaH"] = {"o6cuguaH", 1, "обсидиан", "image64.pic", "minecraft:obsidian", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["aJIMa3"] = {"aJIMa3", 1, "алмаз", "image2.pic", "minecraft:diamond", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["u3yMpyg"] = {"u3yMpyg", 1, "изумруд", "image74.pic", "minecraft:emerald", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["ygoJIb"] = {"ygoJIb", 1, "уголь", "image78.pic", "minecraft:coal", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["JIa3ypuT"] = {"JIa3ypuT", 1, "лазурит", "image36.pic", "minecraft:dye", 4}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["kpacHa9l_nblJIb"] = {"kpacHa9l_nblJIb", 1, "красная пыль", "image48.pic", "minecraft:redstone", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["cBeTonblJIb"] = {"cBeTonblJIb", 1, "светопыль", "image7.pic", "minecraft:glowstone_dust", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["kBapc"] = {"kBapc", 1, "кварц", "image45.pic", "minecraft:quartz", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["kpucTaJIJI_ucTuHHoro_kBapca"] = {"kpucTaJIJI_ucTuHHoro_kBapca", 1, "кристалл истинного кварца", "image52.pic", "appliedenergistics2:item.ItemMultiMaterial", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["rpo3oBou_kpucTaJIJI"] = {"rpo3oBou_kpucTaJIJI", 1, "грозовой кристалл", "image72.pic", "Thaumcraft:ItemShard", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["orHeHHblu_kpucTaJIJI"] = {"orHeHHblu_kpucTaJIJI", 1, "огненный кристалл", "image67.pic", "Thaumcraft:ItemShard", 1}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["JIeg9lHou_kpucTaJIJI"] = {"JIeg9lHou_kpucTaJIJI", 1, "ледяной кристалл", "image39.pic", "Thaumcraft:ItemShard", 2}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["zeMJI9lHou_kpucTaJIJI"] = {"zeMJI9lHou_kpucTaJIJI", 1, "земляной кристалл", "image85.pic", "Thaumcraft:ItemShard", 3}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["kpucTaJIJI_nop9lgka"] = {"kpucTaJIJI_nop9lgka", 1, "кристалл порядка", "image51.pic", "Thaumcraft:ItemShard", 4}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["eHTponuuHblu_kpucTaJIJI"] = {"eHTponuuHblu_kpucTaJIJI", 1, "энтропийный кристалл", "image17.pic", "Thaumcraft:ItemShard", 5}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["JeJIe3Hblu_cJIuTok"] = {"JeJIe3Hblu_cJIuTok", 1, "железный слиток", "image34.pic", "minecraft:iron_ingot", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["zoJIoTou_cJIuTok"] = {"zoJIoTou_cJIuTok", 1, "золотой слиток", "image86.pic", "minecraft:gold_ingot", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["MegHblu_CJIuToK"] = {"MegHblu_CJIuToK", 1, "медный слиток", "image55.pic", "IC2:itemIngot", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["cBuHcoBblu_cJIuTok"] = {"cBuHcoBblu_cJIuTok", 1, "свинцовый слиток", "image8.pic", "IC2:itemIngot", 5}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["oJIoB9lHblu_CJIuTok"] = {"oJIoB9lHblu_CJIuTok", 1, "оловяный слиток", "image66.pic", "IC2:itemIngot", 1}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["bpoH3oBblu_cJIuTok"] = {"bpoH3oBblu_cJIuTok", 1, "бронзовый слиток", "image6.pic", "IC2:itemIngot", 2}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["cJIuTok_ypaHa"] = {"cJIuTok_ypaHa", 5, "слиток урана", "image14.pic", "AdvancedSolarPanel:asp_crafting_items", 11}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["nJIaTuHoBblu_cJIuTok"] = {"nJIaTuHoBblu_cJIuTok", 5, "платиновый слиток", "image61.pic", "ThermalFoundation:material", 69}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["kocTb"] = {"kocTb", 1, "кость", "image46.pic", "minecraft:bone", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["nay4uu_rJIa3"] = {"nay4uu_rJIa3", 1, "паучий глаз", "image60.pic", "minecraft:spider_eye", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["cTepJeHb_uqppuTa"] = {"cTepJeHb_uqppuTa", 1, "стержень ифрита", "image16.pic", "minecraft:blaze_rod", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["JeM4yr_kpa9l"] = {"JeM4yr_kpa9l", 1, "жемчуг края", "image35.pic", "minecraft:ender_pearl", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["chepHuJIbHblu_MeIIIok"] = {"chepHuJIbHblu_MeIIIok", 1, "чернильный мешок", "image10.pic", "minecraft:dye", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["crycTok_cJIu3u"] = {"crycTok_cJIu3u", 1, "сгусток слизи", "image15.pic", "minecraft:slime_ball", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["Mo3r_3oM6u"] = {"Mo3r_3oM6u", 1, "мозг зомби", "image56.pic", "Thaumcraft:ItemZombieBrain", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["cJIe3a_racTa"] = {"cJIe3a_racTa", 5, "слеза гаста", "image11.pic", "minecraft:ghast_tear", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["ny3blpek_onblTa"] = {"ny3blpek_onblTa", 10, "пузырёк опыта", "image63.pic", "minecraft:experience_bottle", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["JIaTekc"] = {"JIaTekc", 1, "латекс", "image37.pic", "IC2:itemHarz", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["cJIuTok_eHgePHuyMa"] = {"cJIuTok_eHgePHuyMa", 5, "слиток эндерниума", "image12.pic", "ThermalFoundation:material", 76}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["TayM_cJIuTok"] = {"TayM_cJIuTok", 1, "таум слиток", "image73.pic", "Thaumcraft:ItemResource", 2}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["cJIuTok_nycToTHoro_MeTaJIJIa"] = {"cJIuTok_nycToTHoro_MeTaJIJIa", 1, "пустотный металл", "image13.pic", "Thaumcraft:ItemResource", 16}	
u3o6PaJeHu9l_JeJIe3Horo_keuCa["HuTop"] = {"HuTop", 1, "нитор", "image33.pic", "Thaumcraft:ItemResource", 1}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["aJII0MeHTuyM"] = {"aJII0MeHTuyM", 1, "алюментиум", "image1.pic", "Thaumcraft:ItemResource", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["koMno3uT"] = {"koMno3uT", 1, "композит", "image47.pic", "IC2:itemPartAlloy", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["yrJIenJIaCTuk"] = {"yrJIenJIaCTuk", 1, "углепластик", "image83.pic", "IC2:itemPartCarbonPlate", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["eJIekTpocxeMa"] = {"eJIekTpocxeMa", 1, "электросхема", "image18.pic", "IC2:itemPartCircuit", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["eJIekTpocxeMa_BToporo_ypoBH9l"] = {"eJIekTpocxeMa_BToporo_ypoBH9l", 2, "электросхема второго уровня", "image19.pic", "IC2:itemPartCircuitAdv", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["akkyMyJI9lTop"] = {"akkyMyJI9lTop", 1, "аккумулятор", "image3.pic", "IC2:itemBatREDischarged", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["qpParMeHT_3HaHuu"] = {"qpParMeHT_3HaHuu", 1, "фрагмент знаний", "image70.pic", "Thaumcraft:ItemResource", 9}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["MaTePu9l"] = {"MaTePu9l", 10, "материя", "image54.pic", "dwcity:Materia", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["gPaKoHueBa9l_nblJIb"] = {"gPaKoHueBa9l_nblJIb", 10, "дракониевая пыль", "image26.pic", "DraconicEvolution:draconiumDust", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["kpuCTaJIJI_aga"] = {"kpuCTaJIJI_aga", 10, "кристалл ада", "image49.pic", "ThaumicTinkerer:kamiResource", 6}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["kpuCTaJIJI_kpa9l"] = {"kpuCTaJIJI_kpa9l", 10, "кристалл края", "image50.pic", "ThaumicTinkerer:kamiResource", 7}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["zakJIuHaHue_MoJIHuu"] = {"zakJIuHaHue_MoJIHuu", 50, "заклинание молнии", "image84.pic", "customnpcs:npcLightningSpell", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["orHeHHoe_3akJIuHaHue"] = {"orHeHHoe_3akJIuHaHue", 50, "огненное заклинание", "image68.pic", "customnpcs:npcFireSpell", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["JIeg9lHoe_3aKJIuHaHue"] = {"JIeg9lHoe_3aKJIuHaHue", 50, "ледяное заклинание", "image38.pic", "customnpcs:npcIceSpell", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["npupogHoe_3akJIuHaHue"] = {"npupogHoe_3akJIuHaHue", 50, "природное заклинание", "image62.pic", "customnpcs:npcNatureSpell", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["geMoHu4eCKue_cJIuTok"] = {"geMoHu4eCKue_cJIuTok", 50, "демонический слиток", "image24.pic", "customnpcs:npcDemonicIngot", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["HaHo_IIIJIeM"] = {"HaHo_IIIJIeM", 3, "нано шлем", "image30.pic", "IC2:itemArmorNanoHelmet", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["HaHo_Kupaca"] = {"HaHo_Kupaca", 3, "нано кираса", "image31.pic", "IC2:itemArmorNanoChestplate", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["HaHo_noHoJu"] = {"HaHo_noHoJu", 3, "нано поножи", "image32.pic", "IC2:itemArmorNanoLegs", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["HaHo_6oTuHku"] = {"HaHo_6oTuHku", 3, "нано ботинки", "image28.pic", "IC2:itemArmorNanoBoots", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["HaHo_ca6JI9l"] = {"HaHo_ca6JI9l", 3, "нано сабля", "image29.pic", "IC2:itemNanoSaber", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["yJIy4IIIeHblu_HaHo_JuJIeT"] = {"yJIy4IIIeHblu_HaHo_JuJIeT", 7, "улучшеный нано жилет", "image81.pic", "GraviSuite:advNanoChestPlate", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["yJIy4IIIeHblu_JeTnak"] = {"yJIy4IIIeHblu_JeTnak", 15, "улучшеный джетпак", "image82.pic", "GraviSuite:advJetpack", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["yJIy4IIIeHblu_aJIMa3Hblu_6yp"] = {"yJIy4IIIeHblu_aJIMa3Hblu_6yp", 5, "улучшеный алмазный бур", "image80.pic", "GraviSuite:advDDrill", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["rpaBuTyJI"] = {"rpaBuTyJI", 5, "гравитул", "image71.pic", "GraviSuite:graviTool", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["yJIy4IIIeHa9l_eJIekTponuJIa"] = {"yJIy4IIIeHa9l_eJIekTponuJIa", 5, "улучшеная электропила", "image79.pic", "GraviSuite:advChainsaw", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["MaJIaXuT"] = {"MaJIaXuT", 10, "малахит", "image53.pic", "dwcity:Malahit", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["upuguu"] = {"upuguu", 5, "иридиевая руда", "image76.pic", "IC2:itemOreIridium", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["uxop_kanJI9l"] = {"uxop_kanJI9l", 5, "ихор капля", "image77.pic", "ThaumicTinkerer:kamiResource", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["cepgce_gpaKoHa"] = {"cepgce_gpaKoHa", 50, "сердце дракона", "image9.pic", "DraconicEvolution:dragonHeart", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["agcKa9l_3Be3ga"] = {"agcKa9l_3Be3ga", 5, "звезда ада", "image0.pic", "minecraft:nether_star", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["gpaKoHueBblu_kpucTaJIJI"] = {"gpaKoHueBblu_kpucTaJIJI", 10, "дракониевый кристалл", "image27.pic", "dwcity:Dragon_shard", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["uckaJeHHblu_kpucTaJIJI"] = {"uckaJeHHblu_kpucTaJIJI", 10, "искаженный кристалл", "image75.pic", "dwcity:Tainted_shard", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["paguo"] = {"paguo", 10, "радио", "image69.pic", "DragonsRadioMod:Radio", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["oHJIauH_KapTuHa"] = {"oHJIauH_KapTuHa", 10, "онлайн картина", "image65.pic", "dwcity:UrlPaint", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["eJIeMeHT_Bo3gyXa"] = {"eJIeMeHT_Bo3gyXa", 50, "элемент воздуха", "image21.pic", "customnpcs:npcAirElement", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["eJIeMeHT_orH9l"] = {"eJIeMeHT_orH9l", 50, "элемент огня", "image23.pic", "customnpcs:npcFireElement", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["eJIeMeHT_Bogbl"] = {"eJIeMeHT_Bogbl", 50, "элемент воды", "image22.pic", "customnpcs:npcWaterElement", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["eJIeMeHT_3eMJIu"] = {"eJIeMeHT_3eMJIu", 50, "элемент земли", "image20.pic", "customnpcs:npcEarthElement", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["MuqpPuJIoBblu_cJIuToK"] = {"MuqpPuJIoBblu_cJIuToK", 20, "мифриловый слиток", "image57.pic", "customnpcs:npcMithrilIngot", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["kBaHToBblu_IIIJIeM"] = {"kBaHToBblu_IIIJIeM", 15, "квантовый шлем", "image44.pic", "IC2:itemArmorQuantumHelmet", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["kBaHToBa9l_Kupaca"] = {"kBaHToBa9l_Kupaca", 15, "квантовая кираса", "image41.pic", "IC2:itemArmorQuantumChestplate", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["kBaHToBble_noHoJu"] = {"kBaHToBble_noHoJu", 15, "квантовые поножи", "image43.pic", "IC2:itemArmorQuantumLegs", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["kBaHToBble_6oTuHku"] = {"kBaHToBble_6oTuHku", 15, "квантовые ботинки", "image42.pic", "IC2:itemArmorQuantumBoots", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["BagJpa"] = {"BagJpa", 15, "ваджра", "image4.pic", "GraviSuite:vajra", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["gpaBuTacuoHHblu_JuJIeT"] = {"gpaBuTacuoHHblu_JuJIeT", 15, "гравитационный жилет", "image25.pic", "GraviSuite:graviChestPlate", 0}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["naHeJIb_4_lvl"] = {"naHeJIb_4_lvl", 50, "панель 4 уровня", "image58.pic", "CompactSolars:CompactSolarBlock", 2}
u3o6PaJeHu9l_JeJIe3Horo_keuCa["naHeJIb_5_lvl"] = {"naHeJIb_5_lvl", 100, "панель 5 уровня", "image59.pic", "AdvancedSolarPanel:BlockAdvSolarPanel", 0}

local function npoBepka_koJIu4ecTBa_uTeMa_B_me_ceTu(id_arg, dmg_arg)
	return me_interface.getItemDetail({id = id_arg, dmg = dmg_arg}).all().qty
end
local function nonpo6oBaTb_noJIoJuTb_npu3_B_CyHgyk_u3_me_ceTu(id_arg, dmg_arg, KoJIu4ecTBo_BblTaJIkuBaeMoro_npegMeTa)
	return me_interface.exportItem({id = id_arg, dmg = dmg_arg}, "UP", KoJIu4ecTBo_BblTaJIkuBaeMoro_npegMeTa, 108)
end
local function co3gaTb_Ta6JIucy_rolla(Ta6JIuca_keucoB)
	for k, v in pairs(Ta6JIuca_keucoB) do
		table.insert(Ta6JIuca_rolla, v)
	end
end
local function npopucoBka_paMku_gJI9l_u3o6paJeHuu_npegMeToB()
	local o6IIIuu_cBeT_paMku = 0xFFFF00
	local cBeT_paMku_c_BblurpblIIIoM = 0x9900CC
	buffer.drawRectangle(3, 2, 155, 20, 0x999999, 0, " ")
	buffer.drawLine(2, 1, 158, 1, o6IIIuu_cBeT_paMku, o6IIIuu_cBeT_paMku, "▄")
	buffer.drawLine(2, 22, 158, 22, o6IIIuu_cBeT_paMku, o6IIIuu_cBeT_paMku, "▀")
	buffer.drawLine(2, 2, 2, 22, o6IIIuu_cBeT_paMku, o6IIIuu_cBeT_paMku, "█")
	buffer.drawLine(41, 2, 41, 22, o6IIIuu_cBeT_paMku, o6IIIuu_cBeT_paMku, "█")
	buffer.drawLine(80, 2, 80, 22, o6IIIuu_cBeT_paMku, o6IIIuu_cBeT_paMku, "█")
	buffer.drawLine(119, 2, 119, 22, o6IIIuu_cBeT_paMku, o6IIIuu_cBeT_paMku, "█")
	buffer.drawLine(158, 2, 158, 22, o6IIIuu_cBeT_paMku, o6IIIuu_cBeT_paMku, "█")
	--фиолетовая рамка
	buffer.drawLine(80, 1, 119, 1, cBeT_paMku_c_BblurpblIIIoM, cBeT_paMku_c_BblurpblIIIoM, "▄")
	buffer.drawLine(81, 22, 119, 22, cBeT_paMku_c_BblurpblIIIoM, cBeT_paMku_c_BblurpblIIIoM, "▀")
	buffer.drawLine(80, 1, 80, 22, cBeT_paMku_c_BblurpblIIIoM, cBeT_paMku_c_BblurpblIIIoM, "█")
	buffer.drawLine(120, 1, 119, 22, cBeT_paMku_c_BblurpblIIIoM, cBeT_paMku_c_BblurpblIIIoM, "█")
	
	
	buffer.drawChanges()
end
local function zarpy3ka_u3o6paJeHuu_npegMeToB()
	if ygaJIeHue_cTapblx_u3o6paJeHuu_npegMeToB_nepeg_3arpy3kou then
		for i = 1, BCero_u3o6paJeHuu_npegMeToB_B_Ta6JIuce_JeJIe3Horo_keuca do
			local Ha3BaHue_qpauJIa = Ha3BaHue_kapTuHok_npegMeToB_Ha_GitHub .. i - 1 .. ".pic"
			filesystem.remove(nanka_JeJIe3Hogo_keuca .. Ha3BaHue_qpauJIa)
		end
	end
	
	for i = 1, BCero_u3o6paJeHuu_npegMeToB_B_Ta6JIuce_JeJIe3Horo_keuca do
		local Ha3BaHue_qpauJIa = Ha3BaHue_kapTuHok_npegMeToB_Ha_GitHub .. i - 1 .. ".pic"
		casino.downloadFile("https://raw.githubusercontent.com/thedark1232/kapTuHku_gJI9l_kazuHo/main/JeJIe3Hblu_keys/" .. Ha3BaHue_qpauJIa, nanka_JeJIe3Hogo_keuca .. Ha3BaHue_qpauJIa)
	end
	
	if TecT_degub_u3o6PaJeHuu then
			--центровка изображения в рамки
			npopucoBka_paMku_gJI9l_u3o6paJeHuu_npegMeToB()
			buffer.drawImage(3, 2, image.load(nanka_JeJIe3Hogo_keuca .. Ha3BaHue_kapTuHok_npegMeToB_Ha_GitHub .. "1.pic"))
			buffer.drawImage(42, 2, image.load(nanka_JeJIe3Hogo_keuca .. Ha3BaHue_kapTuHok_npegMeToB_Ha_GitHub .. "1.pic"))
			buffer.drawImage(81, 2, image.load(nanka_JeJIe3Hogo_keuca .. Ha3BaHue_kapTuHok_npegMeToB_Ha_GitHub .. "1.pic"))
			buffer.drawImage(120, 2, image.load(nanka_JeJIe3Hogo_keuca .. Ha3BaHue_kapTuHok_npegMeToB_Ha_GitHub .. "1.pic"))
			buffer.drawChanges()
			--npopucoBka_paMku_gJI9l_u3o6paJeHuu_npegMeToB()
			local del2 = io.read()
		for i = 1, BCero_u3o6paJeHuu_npegMeToB_B_Ta6JIuce_JeJIe3Horo_keuca do
			local Ha3BaHue_qpauJIa = Ha3BaHue_kapTuHok_npegMeToB_Ha_GitHub .. i - 1 .. ".pic"
			pcall(buffer.drawImage ,3, 2, image.load(nanka_JeJIe3Hogo_keuca .. Ha3BaHue_qpauJIa))
			buffer.drawText(1, 24, 0, Ha3BaHue_qpauJIa)
			buffer.drawChanges()
			local del = io.read()
			term.setCursor(1,1)
		end
	end
	if TecT_cB9l3u_u3o6paJeHuu_c_Ta6JIuceu then
		npopucoBka_paMku_gJI9l_u3o6paJeHuu_npegMeToB()
		for k, v in pairs(u3o6PaJeHu9l_JeJIe3Horo_keuCa) do
			pcall(buffer.drawImage ,3, 2, image.load(nanka_JeJIe3Hogo_keuca .. v[4]))
			buffer.drawText(1, 24, 0, v[3] .. "                         ")
			buffer.drawChanges()
			local del3 = io.read()
			term.setCursor(1,1)
		end
	end
end
local function co3gaHue_Bcex_Heo6XoguMblx_nanok()
	filesystem.makeDirectory(nanka_JeJIe3Hogo_keuca)
	filesystem.makeDirectory(nanka_3agHero_qpoHa)
	
	casino.downloadFile("https://raw.githubusercontent.com/thedark1232/kapTuHku_gJI9l_kazuHo/main/JeJIe3Hblu_keys/" .. zagHuu_qpoH_JeJIe3Hogo_Keuca, nanka_3agHero_qpoHa .. zagHuu_qpoH_JeJIe3Hogo_Keuca)
	casino.downloadFile("https://raw.githubusercontent.com/thedark1232/kapTuHku_gJI9l_kazuHo/main/JeJIe3Hblu_keys/" .. zagHuu_qpoH_JeJIe3Hogo_Keuca_c_kHonkaMu, nanka_3agHero_qpoHa .. zagHuu_qpoH_JeJIe3Hogo_Keuca_c_kHonkaMu)
	casino.downloadFile("https://raw.githubusercontent.com/thedark1232/kapTuHku_gJI9l_kazuHo/main/JeJIe3Hblu_keys/" .. zagHuu_qpoH_JeJIe3Hogo_Keuca_c_kHonkaMu_u_TekcToM, nanka_3agHero_qpoHa .. zagHuu_qpoH_JeJIe3Hogo_Keuca_c_kHonkaMu_u_TekcToM)
	casino.downloadFile("https://raw.githubusercontent.com/thedark1232/kapTuHku_gJI9l_kazuHo/main/JeJIe3Hblu_keys/" .. zagHuu_qpoH_JeJIe3Hogo_Keuca_npuBeTcTBue1, nanka_3agHero_qpoHa .. zagHuu_qpoH_JeJIe3Hogo_Keuca_npuBeTcTBue1)
	casino.downloadFile("https://raw.githubusercontent.com/thedark1232/kapTuHku_gJI9l_kazuHo/main/JeJIe3Hblu_keys/" .. zagHuu_qpoH_JeJIe3Hogo_Keuca_npuBeTcTBue2, nanka_3agHero_qpoHa .. zagHuu_qpoH_JeJIe3Hogo_Keuca_npuBeTcTBue2)
	
	filesystem.makeDirectory(nanka_3oJIoToro_keuca)
	filesystem.makeDirectory(nanka_aJIMa3Horo_keuca)
	filesystem.makeDirectory(nanka_gpak_keuca)
	filesystem.makeDirectory(nanka_keuca_yga4u)
	
	filesystem.makeDirectory(nanka_JIoroB_urpokoB)
end
local function oJugaHue_coo6IIIeHu9l_oT_Mogema()
	chat.say("§6ожидание команды")
	local Tun_co6blTu9l, Mou_agpec, agpec_oTnpaBuTeJI9l, HoMep_nopTa, paccTo9lHue, TekcT_coo6IIIeHu9l = event.pull("modem_message")
	if TekcT_coo6IIIeHu9l == "exit" then os.exit() end
end
local function roll(Huk_urpoka)
	local npu3 = ""
	local npu3oBoe_3Ha4eHue_paHgoMa
	local npu3_ecTb_B_HaJIu4uu = false
	local npu3_nogXoguT_no_lvl_urpoka = false
	local ckopocTb_rolla = ckopocTb_npokpyTku
	local KoJIu4ecTBo_npu3oBblx_uTeMoB_3a_oguH_pa3
	npopucoBka_paMku_gJI9l_u3o6paJeHuu_npegMeToB()
	local zanoMHuTb_nepByI0_kapTuHky
	local zanoMHuTb_BTopyI0_kapTuHky
	local zanoMHuTb_TpeTbI0_kapTuHky
	local zanoMHuTb_4eTBepTyI0_kapTuHky
	local random_3Ha4eHue
	local TekyIIIee_3Ha4eHue_JIuMuTa = 0
	--получение таблицы логов игрока
	local Ta6JIuca_JIoroB_urpoka = {}
	local re3yJIbTaT_4TeHu9l_u3_qpauJIa = filesLibrary.write_file(nanka_JIoroB_urpokoB .. Huk_urpoka, "nil")
	if re3yJIbTaT_4TeHu9l_u3_qpauJIa ~= "nil" then Ta6JIuca_JIoroB_urpoka = serialization.unserialize(re3yJIbTaT_4TeHu9l_u3_qpauJIa) end
	setmetatable(Ta6JIuca_JIoroB_urpoka, {__index = function() return 0 end})
	Ta6JIuca_JIoroB_urpoka["KoJIu4ecTBo_urp"] = Ta6JIuca_JIoroB_urpoka["KoJIu4ecTBo_urp"] + 1
	Ta6JIuca_JIoroB_urpoka["lvl_urpoka"] = Ta6JIuca_JIoroB_urpoka["lvl_urpoka"] + 1
	--проверка 108 слота сундука, если занят, то вернет предмет в мэ сеть
	if diamond.getStackInSlot(108) ~= nil then diamond.pushItem("DOWN", 108, 64) end
	--просчет приза
	repeat
		npu3_ecTb_B_HaJIu4uu = false
		npu3_nogXoguT_no_lvl_urpoka = false
		--выбрать случайный приз в таблице
		npu3oBoe_3Ha4eHue_paHgoMa = math.random(1, BCero_u3o6paJeHuu_npegMeToB_B_Ta6JIuce_JeJIe3Horo_keuca)
		--проверка приза по лвл игрока
		if Ta6JIuca_rolla[npu3oBoe_3Ha4eHue_paHgoMa][2] <= Ta6JIuca_JIoroB_urpoka["lvl_urpoka"] then
			npu3_nogXoguT_no_lvl_urpoka = true
		else
			npu3_nogXoguT_no_lvl_urpoka = false
		end
		--если приз подходит по лвл
		if npu3_nogXoguT_no_lvl_urpoka then
			--подсчет ожидаемой выдачи приза
			KoJIu4ecTBo_npu3oBblx_uTeMoB_3a_oguH_pa3 = 1
			--если предмет имеет 1 лвл, то количество выдаваемого приза может быть от 32 до 64
			if Ta6JIuca_rolla[npu3oBoe_3Ha4eHue_paHgoMa][2] == 1 then KoJIu4ecTBo_npu3oBblx_uTeMoB_3a_oguH_pa3 = math.random(32, 64) end
			--проверка подключения мэ интерфейса к мэ сети
			while me_interface.getStoredPower() == 0 do
				chat.say("§cСВЯЗЬ С МЭ ПОТЕРЯНА! ОЖИДАНИЕ ПОДКЛЮЧЕНИЯ К МЭ СЕТИ")
				os.sleep(10)
			end
			--проверка количества приза в мэ сети
			local npu3_eCTb_B_ME_CETu, koJIu4ecTBo_npu3a_B_Me = pcall(npoBepka_koJIu4ecTBa_uTeMa_B_me_ceTu, Ta6JIuca_rolla[npu3oBoe_3Ha4eHue_paHgoMa][5], Ta6JIuca_rolla[npu3oBoe_3Ha4eHue_paHgoMa][6])
			if npu3_eCTb_B_ME_CETu then
				if koJIu4ecTBo_npu3a_B_Me >= KoJIu4ecTBo_npu3oBblx_uTeMoB_3a_oguH_pa3 then
					--проверка досупности алмазного сундука над мэ интерфейсом
					while not me_interface.canExport("UP") do chat.say("§cАЛМАЗНЫЙ СУНДУК НАД МЭ ИНТЕРФЕЙСОМ НЕ НАЙДЕН!"); os.sleep(10) end
					--попрбовать протолкнуть предмет в сундук					
					local noJIy4uJIocb_BblToJIKHyTb, _ = pcall(nonpo6oBaTb_noJIoJuTb_npu3_B_CyHgyk_u3_me_ceTu,  Ta6JIuca_rolla[npu3oBoe_3Ha4eHue_paHgoMa][5], Ta6JIuca_rolla[npu3oBoe_3Ha4eHue_paHgoMa][6], KoJIu4ecTBo_npu3oBblx_uTeMoB_3a_oguH_pa3)
					if noJIy4uJIocb_BblToJIKHyTb then
						npu3_ecTb_B_HaJIu4uu = true
					else
						npu3_ecTb_B_HaJIu4uu = false
						--chat.say("§6ветвление на ошибку положить приз в сундук")
						--chat.say("§6" ..Ta6JIuca_rolla[npu3oBoe_3Ha4eHue_paHgoMa][3])
						--chat.say("§6" .. tostring(koJIu4ecTBo_npu3a_B_Me))
						--oJugaHue_coo6IIIeHu9l_oT_Mogema()
					end
				end
			else
				--chat.say("§6ветвление на ошибку проверки количества итемов в сети")
				--chat.say("§6" ..Ta6JIuca_rolla[npu3oBoe_3Ha4eHue_paHgoMa][3])
				--chat.say("§6" .. tostring(koJIu4ecTBo_npu3a_B_Me))
				--oJugaHue_coo6IIIeHu9l_oT_Mogema()
			end
		end
		if TekyIIIee_3Ha4eHue_JIuMuTa >= npuBblIIIeHue_JIuMuTa_Bbl6opa_npu3a then chat.say("§6превышение лемита выбора приза"); os.exit() end
		TekyIIIee_3Ha4eHue_JIuMuTa = TekyIIIee_3Ha4eHue_JIuMuTa + 1
	until npu3_ecTb_B_HaJIu4uu and npu3_nogXoguT_no_lvl_urpoka
	--сбросить лвл игрока, если призовой уровень предмета слишком велик(настраивается в стартовых переменных)
	if Ta6JIuca_JIoroB_urpoka[Ta6JIuca_rolla[npu3oBoe_3Ha4eHue_paHgoMa][2]] >= nepeMeHHa9l_c6poca_lvl_urpoka then Ta6JIuca_JIoroB_urpoka["lvl_urpoka"] = 1 end
	
	Ta6JIuca_JIoroB_urpoka[Ta6JIuca_rolla[npu3oBoe_3Ha4eHue_paHgoMa][1]] = Ta6JIuca_JIoroB_urpoka[Ta6JIuca_rolla[npu3oBoe_3Ha4eHue_paHgoMa][1]] + KoJIu4ecTBo_npu3oBblx_uTeMoB_3a_oguH_pa3
	
	--прорисовка 1 итема
	random_3Ha4eHue = math.random(1, BCero_u3o6paJeHuu_npegMeToB_B_Ta6JIuce_JeJIe3Horo_keuca)
	buffer.drawImage(3, 2, image.load(nanka_JeJIe3Hogo_keuca .. Ta6JIuca_rolla[random_3Ha4eHue][4]))
	zanoMHuTb_nepByI0_kapTuHky = random_3Ha4eHue
	buffer.drawChanges()
	os.sleep(ckopocTb_rolla)
	
	--прорисовка 1 и 2 итемов
	random_3Ha4eHue = math.random(1, BCero_u3o6paJeHuu_npegMeToB_B_Ta6JIuce_JeJIe3Horo_keuca)
	buffer.drawImage(3, 2, image.load(nanka_JeJIe3Hogo_keuca .. Ta6JIuca_rolla[random_3Ha4eHue][4]))
	buffer.drawImage(42, 2, image.load(nanka_JeJIe3Hogo_keuca .. Ta6JIuca_rolla[zanoMHuTb_nepByI0_kapTuHky][4]))
	zanoMHuTb_BTopyI0_kapTuHky = random_3Ha4eHue
	buffer.drawChanges()
	os.sleep(ckopocTb_rolla)
	
	--прорисовка 1, 2, 3 итемов
	random_3Ha4eHue = math.random(1, BCero_u3o6paJeHuu_npegMeToB_B_Ta6JIuce_JeJIe3Horo_keuca)
	buffer.drawImage(3, 2, image.load(nanka_JeJIe3Hogo_keuca .. Ta6JIuca_rolla[random_3Ha4eHue][4]))
	buffer.drawImage(42, 2, image.load(nanka_JeJIe3Hogo_keuca .. Ta6JIuca_rolla[zanoMHuTb_BTopyI0_kapTuHky][4]))
	buffer.drawImage(81, 2, image.load(nanka_JeJIe3Hogo_keuca .. Ta6JIuca_rolla[zanoMHuTb_nepByI0_kapTuHky][4]))
	zanoMHuTb_TpeTbI0_kapTuHky = random_3Ha4eHue
	buffer.drawChanges()
	os.sleep(ckopocTb_rolla)
	
	--прорисовка 1, 2, 3, 4 итемов
	random_3Ha4eHue = math.random(1, BCero_u3o6paJeHuu_npegMeToB_B_Ta6JIuce_JeJIe3Horo_keuca)
	buffer.drawImage(3, 2, image.load(nanka_JeJIe3Hogo_keuca .. Ta6JIuca_rolla[random_3Ha4eHue][4]))
	buffer.drawImage(42, 2, image.load(nanka_JeJIe3Hogo_keuca .. Ta6JIuca_rolla[zanoMHuTb_TpeTbI0_kapTuHky][4]))
	buffer.drawImage(81, 2, image.load(nanka_JeJIe3Hogo_keuca .. Ta6JIuca_rolla[zanoMHuTb_BTopyI0_kapTuHky][4]))
	buffer.drawImage(120, 2, image.load(nanka_JeJIe3Hogo_keuca .. Ta6JIuca_rolla[zanoMHuTb_nepByI0_kapTuHky][4]))	
	zanoMHuTb_4eTBepTyI0_kapTuHky = random_3Ha4eHue
	buffer.drawChanges()
	os.sleep(ckopocTb_rolla)

	for i = 1, koJIu4ecTBo_npokpyTok do		
		random_3Ha4eHue = math.random(1, BCero_u3o6paJeHuu_npegMeToB_B_Ta6JIuce_JeJIe3Horo_keuca)
		buffer.drawImage(3, 2, image.load(nanka_JeJIe3Hogo_keuca .. Ta6JIuca_rolla[random_3Ha4eHue][4]))
		buffer.drawImage(42, 2, image.load(nanka_JeJIe3Hogo_keuca .. Ta6JIuca_rolla[zanoMHuTb_4eTBepTyI0_kapTuHky][4]))
		buffer.drawImage(81, 2, image.load(nanka_JeJIe3Hogo_keuca .. Ta6JIuca_rolla[zanoMHuTb_TpeTbI0_kapTuHky][4]))
		buffer.drawImage(120, 2, image.load(nanka_JeJIe3Hogo_keuca .. Ta6JIuca_rolla[zanoMHuTb_BTopyI0_kapTuHky][4]))	
		buffer.drawChanges()
		zanoMHuTb_BTopyI0_kapTuHky = zanoMHuTb_TpeTbI0_kapTuHky
		zanoMHuTb_TpeTbI0_kapTuHky = zanoMHuTb_4eTBepTyI0_kapTuHky
		zanoMHuTb_4eTBepTyI0_kapTuHky = random_3Ha4eHue
		os.sleep(ckopocTb_rolla)
		ckopocTb_rolla = ckopocTb_rolla + ckopocTb_npokpyTku
	end
	
	--перед призом 1
	buffer.drawImage(3, 2, image.load(nanka_JeJIe3Hogo_keuca .. Ta6JIuca_rolla[npu3oBoe_3Ha4eHue_paHgoMa][4]))
	buffer.drawImage(42, 2, image.load(nanka_JeJIe3Hogo_keuca .. Ta6JIuca_rolla[zanoMHuTb_4eTBepTyI0_kapTuHky][4]))
	buffer.drawImage(81, 2, image.load(nanka_JeJIe3Hogo_keuca .. Ta6JIuca_rolla[zanoMHuTb_TpeTbI0_kapTuHky][4]))
	buffer.drawImage(120, 2, image.load(nanka_JeJIe3Hogo_keuca .. Ta6JIuca_rolla[zanoMHuTb_BTopyI0_kapTuHky][4]))	
	buffer.drawChanges()
	local BpeMeHHoe_3Ha4eHue = zanoMHuTb_4eTBepTyI0_kapTuHky
	zanoMHuTb_4eTBepTyI0_kapTuHky = zanoMHuTb_TpeTbI0_kapTuHky
	zanoMHuTb_TpeTbI0_kapTuHky = BpeMeHHoe_3Ha4eHue
	os.sleep(ckopocTb_rolla)
	ckopocTb_rolla = ckopocTb_rolla + ckopocTb_npokpyTku + 0.01
	
	--перед призом 2
	random_3Ha4eHue = math.random(1, BCero_u3o6paJeHuu_npegMeToB_B_Ta6JIuce_JeJIe3Horo_keuca)
	buffer.drawImage(3, 2, image.load(nanka_JeJIe3Hogo_keuca .. Ta6JIuca_rolla[random_3Ha4eHue][4]))
	buffer.drawImage(42, 2, image.load(nanka_JeJIe3Hogo_keuca .. Ta6JIuca_rolla[npu3oBoe_3Ha4eHue_paHgoMa][4]))
	buffer.drawImage(81, 2, image.load(nanka_JeJIe3Hogo_keuca .. Ta6JIuca_rolla[zanoMHuTb_TpeTbI0_kapTuHky][4]))
	buffer.drawImage(120, 2, image.load(nanka_JeJIe3Hogo_keuca .. Ta6JIuca_rolla[zanoMHuTb_4eTBepTyI0_kapTuHky][4]))	
	buffer.drawChanges()
	zanoMHuTb_BTopyI0_kapTuHky = random_3Ha4eHue
	zanoMHuTb_4eTBepTyI0_kapTuHky = zanoMHuTb_TpeTbI0_kapTuHky
	os.sleep(ckopocTb_rolla)
	ckopocTb_rolla = ckopocTb_rolla + ckopocTb_npokpyTku + 0.01
		
	--перед призом 3
	random_3Ha4eHue = math.random(1, BCero_u3o6paJeHuu_npegMeToB_B_Ta6JIuce_JeJIe3Horo_keuca)
	buffer.drawImage(3, 2, image.load(nanka_JeJIe3Hogo_keuca .. Ta6JIuca_rolla[random_3Ha4eHue][4]))
	buffer.drawImage(42, 2, image.load(nanka_JeJIe3Hogo_keuca .. Ta6JIuca_rolla[zanoMHuTb_BTopyI0_kapTuHky][4]))
	buffer.drawImage(81, 2, image.load(nanka_JeJIe3Hogo_keuca .. Ta6JIuca_rolla[npu3oBoe_3Ha4eHue_paHgoMa][4]))
	buffer.drawImage(120, 2, image.load(nanka_JeJIe3Hogo_keuca .. Ta6JIuca_rolla[zanoMHuTb_4eTBepTyI0_kapTuHky][4]))	
	buffer.drawChanges()
	os.sleep(ckopocTb_rolla)
	filesLibrary.creat_file(nanka_JIoroB_urpokoB .. Huk_urpoka, serialization.serialize(Ta6JIuca_JIoroB_urpoka))
	chat.say("§cВаш приз: " .. Ta6JIuca_rolla[npu3oBoe_3Ha4eHue_paHgoMa][3] .. " Кол-во: " .. KoJIu4ecTBo_npu3oBblx_uTeMoB_3a_oguH_pa3)
	diamond.pushItem("UP", 108)
end
local function zanycTuTb_cTapToBoe_npuBeTcTBue()
	buffer.drawImage(1, 1, image.load(nanka_3agHero_qpoHa .. zagHuu_qpoH_JeJIe3Hogo_Keuca))
	buffer.drawChanges()
	os.sleep(1)
	buffer.drawImage(1, 1, image.load(nanka_3agHero_qpoHa .. zagHuu_qpoH_JeJIe3Hogo_Keuca_npuBeTcTBue1))
	buffer.drawChanges()
	os.sleep(2)
	buffer.drawImage(1, 1, image.load(nanka_3agHero_qpoHa .. zagHuu_qpoH_JeJIe3Hogo_Keuca_npuBeTcTBue2))
	buffer.drawChanges()
	os.sleep(2)
	buffer.drawImage(1, 1, image.load(nanka_3agHero_qpoHa .. zagHuu_qpoH_JeJIe3Hogo_Keuca_c_kHonkaMu_u_TekcToM))
	buffer.drawChanges()
end

do
	modem.open(10)
	chat.setName("§aказино")
	co3gaHue_Bcex_Heo6XoguMblx_nanok()
	zarpy3ka_u3o6paJeHuu_npegMeToB()
	co3gaTb_Ta6JIucy_rolla(u3o6PaJeHu9l_JeJIe3Horo_keuCa)		
	zanycTuTb_cTapToBoe_npuBeTcTBue()
	math.randomseed(os.clock())
	while true do
		local _, _, x, y, _, nick_HaJaBIIIero_kHonKy = event.pull("touch")
		if x >= 59 and x <= 108 then
			-- Play button
			if y >= 26 and y <= 36 then
				local payed, reason = casino.takeMoney(koJIu4ectBo_geHer_3a_urpy)
				if payed then
					chat.say("§6началась игра для " .. tostring(nick_HaJaBIIIero_kHonKy))
					roll(nick_HaJaBIIIero_kHonKy)
				else
					chat.say("§6" .. tostring(reason))
				end
			end
			-- Exit button
			if y >= 38 and y <= 48 then
				error("Exit by request")
			end
		end
	end
end