# ============================================================
# Lutong Pinoy Recipes — Week 4 Facebook Scheduler
# Dates: August 24–30, 2025 @ 7:00 AM PHT (UTC+8)
# Page ID: 1162389303634284
# ============================================================
# BEFORE RUNNING: Replace $PageToken with a fresh token from
# https://developers.facebook.com/tools/explorer/
# ============================================================

$PageId    = "1162389303634284"
$PageToken = "PASTE_YOUR_PAGE_TOKEN_HERE"

# ---- Helper: Unix timestamp for a given PHT date at 7:00 AM ----
function Get-PHTTimestamp {
    param([string]$DateStr)  # Format: "YYYY-MM-DD"
    $pht = [System.TimeZoneInfo]::FindSystemTimeZoneById("Singapore Standard Time")
    $local = [datetime]::ParseExact("$DateStr 07:00:00", "yyyy-MM-dd HH:mm:ss", $null)
    $utcTime = [System.TimeZoneInfo]::ConvertTimeToUtc($local, $pht)
    return [int][double]::Parse(($utcTime - [datetime]"1970-01-01 00:00:00").TotalSeconds.ToString())
}

# ---- Helper: Post to Facebook with FLUX image URL ----
function Post-Recipe {
    param(
        [string]$Date,
        [string]$RecipeName,
        [string]$ImagePrompt,
        [string]$Caption
    )

    $ts  = Get-PHTTimestamp -DateStr $Date
    $enc = [System.Uri]::EscapeDataString($ImagePrompt)
    $img = "https://image.pollinations.ai/prompt/$enc`?width=1024&height=1024&model=flux-realism&nologo=true&seed=42"

    $body = @{
        url                    = $img
        caption                = $Caption
        published              = "false"
        scheduled_publish_time = $ts
        access_token           = $PageToken
    }

    Write-Host "`n📅 Scheduling: $RecipeName on $Date @ 7AM PHT (ts=$ts)" -ForegroundColor Cyan
    Write-Host "🖼️  Image URL: $img" -ForegroundColor DarkGray

    try {
        $resp = Invoke-RestMethod -Uri "https://graph.facebook.com/v19.0/$PageId/photos" `
                                  -Method POST -Body $body
        Write-Host "✅ SUCCESS — Post ID: $($resp.id)" -ForegroundColor Green
        return $resp.id
    } catch {
        Write-Host "❌ FAILED: $_" -ForegroundColor Red
        return $null
    }
}

# ============================================================
# WEEK 4 — Aug 24–30, 2025
# ============================================================

# --- Aug 24 (Mon): Pinoy Pork BBQ ---
Post-Recipe `
    -Date "2025-08-24" `
    -RecipeName "Pinoy Pork BBQ" `
    -ImagePrompt "Filipino pork barbecue skewers on charcoal grill, orange-glazed caramelized pork, banana ketchup baste, smoky charcoal, street food style, vibrant Filipino colors, steamed rice and atchara on side, professional food photography" `
    -Caption @"
🔥 PINOY PORK BBQ — The ULTIMATE Filipino Street Food! 🍢

Walang tatalo sa ihaw-ihaw na Pinoy BBQ tuwing weekend! Malapot na marinade, matamis, maalat, at may halong calamansi... 😍

🥩 1 kg kasim (pork shoulder), hiniwa nang manipis
🧄 1 ulo bawang, dinurog
🍅 ½ cup banana ketchup
🫙 ½ cup toyo
🥤 ¼ cup Sprite
🍬 3 tbsp brown sugar

1. Ihalo lahat ng marinade — ilubog ang baboy ng 4 oras (o overnight!)
2. I-skewer ang baboy sa bamboo sticks
3. Ihaw sa uling — i-baste ng ketchup habang nagluluto
4. Lutuin hanggang may charred edges, mga 10–12 minuto
5. Ihain kasama ng kanin at atsara!

💡 Tip: Banana ketchup ang lihim ng tunay na Pinoy BBQ — huwag palitan ng tomato ketchup!

💬 I-tag ang iyong BBQ buddy tuwing Sabado! 👇
💾 I-save ang recipe na ito para sa susunod na ihaw session!

#LutongPinoy #PinoyBBQ #FilipinoFood #IhawIhaw #PorkBBQ #FilipinoBBQ #RecipesDaily #PinoyKitchen #StreetFood #WeekendGrill
"@

# --- Aug 25 (Tue): Kinilaw na Tuna ---
Post-Recipe `
    -Date "2025-08-25" `
    -RecipeName "Kinilaw na Tuna" `
    -ImagePrompt "Filipino kinilaw na tuna ceviche in white bowl, fresh raw tuna cubes marinated in calamansi and vinegar, red onions, ginger, bird eye chili, vibrant colors, fresh seafood, Visayan cuisine, professional food photography" `
    -Caption @"
🐟 KINILAW NA TUNA — No Cook, 100% Sarap! 😍🌶️

Ang sarap ng fresh na kinilaw lalo na sa mainit na panahon! Hindi na kailangan ng apoy — ang asim ng calamansi at suka ang magluluto ng isda! 🍋

🐟 500g fresh tuna, hiniwa ng cubes
🍋 ¼ cup calamansi juice
🧴 ½ cup sukang tuba o white vinegar
🧅 1 pulang sibuyas, hiniwa nang manipis
🫚 1 thumb ginger, julienned
🌶️ 2–3 labuyo, sliced

1. Banlawan ang tuna sa kaunting suka — itapon ang tubig
2. Ihalo ang calamansi juice + suka — isawsaw ang tuna ng 5–10 minuto
3. Hanguin, dagdagan ng sibuyas, luya, at labuyo
4. Timplahan ng asin, paminta, at patis
5. Ihain agad — fresh pa fresh!

💡 Tip: Gamitin palagi ang pinakasariwa at sashimi-grade na tuna para sa kinilaw!

💬 Kumain ka na ba ng kinilaw dati? Share mo ang version mo! 👇
💾 I-save ang recipe na ito!

#LutongPinoy #KinilawNaTuna #FilipinoFood #Kinilaw #FilipinoSeafood #Pulutan #NoCookRecipe #VisayanFood #RecipesDaily #PinoyKitchen
"@

# --- Aug 26 (Wed): Monggo Guisado ---
Post-Recipe `
    -Date "2025-08-26" `
    -RecipeName "Monggo Guisado" `
    -ImagePrompt "Filipino monggo guisado mung bean soup with pork, green malunggay leaves, tomatoes, rich savory broth in clay pot, served with steamed white rice, Filipino home cooking, warm comfort food, professional food photography" `
    -Caption @"
🫘 MONGGO GUISADO — Klasikong Lutong Biyernes ng Pilipinas! 💚

Pag Biyernes, monggo! Ito ang lutuin na pang-masa, mura, masustansya, at talagang nakaka-busog! 😋

🫘 2 cups monggo, binabad ng 4 oras
🥩 200g pork belly o hipon
🌿 1 cup malunggay leaves
🧅 Sibuyas, bawang, kamatis
🫙 2 tbsp patis

1. Pakuluan ang monggo ng 30–40 minuto hanggang lumambot
2. Igisa ang bawang, sibuyas, kamatis
3. Dagdagan ng baboy — lutuin hanggang maluto
4. Ihalo ang monggo — pakuluin ng 10 minuto
5. Lagyan ng malunggay, timplahan — tapos na!

💡 Tip: I-try ang tinapa (smoked fish) bilang palaman — mas masarap pa!

💬 Monggo ba ang lutuin ninyo tuwing Biyernes? 👇
💾 I-save para sa susunod na Biyernes!

#LutongPinoy #MonggoGuisado #FilipinoFood #MonggoBiyernes #FilipinoBudgetMeal #RecipesDaily #PinoyKitchen #HealthyFilipino #ComfortFood #MungBeans
"@

# --- Aug 27 (Thu): Pork Sisig ---
Post-Recipe `
    -Date "2025-08-27" `
    -RecipeName "Pork Sisig" `
    -ImagePrompt "Filipino sizzling pork sisig on a hot cast iron plate, chopped crispy pork belly, egg on top, chili peppers, calamansi halves, steam rising, dark background, Pampanga cuisine, pulutan, professional restaurant food photography" `
    -Caption @"
🔥 SIZZLING PORK SISIG — Hari ng Pulutan, Hari ng Kanin! 👑

Ang sizzling sisig sa mainit na plato — walang kapantay! Crispy, maasim, maanghang, at sulit sa bawat kurot! 😩🤤

🥩 500g pork belly, niluto at inihaw
🧅 1 malaking sibuyas, tinadtad
🍋 3 tbsp calamansi juice
🌶️ 3–4 labuyo, sliced
🫙 2 tbsp toyo + 1 tbsp oyster sauce
🥚 2 itlog (para sa ibabaw)

1. Pakuluan ang baboy — ihaw hanggang mag-char
2. Tadtarin nang maliit — mas maliit, mas masarap!
3. I-sizzle sa mainit na kawali — hayaang mag-crispy
4. Dagdagan ng sibuyas, labuyo, calamansi, at toyo
5. Lagyan ng itlog sa ibabaw — ihalo bago ihain!

💡 Tip: Ang charcoal grilling ang nagbibigay ng tunay na lasa ng sisig!

💬 Rice o beer — ano ang kasama mo sa sisig? 🍚🍺 👇
💾 I-save ang recipe na ito!

#LutongPinoy #PorkSisig #Sisig #FilipinoFood #SizzlingPlateFoods #Pulutan #PampangaFood #RecipesDaily #PinoyKitchen #FilipinoComfortFood
"@

# --- Aug 28 (Fri): Ginataang Bilo-Bilo ---
Post-Recipe `
    -Date "2025-08-28" `
    -RecipeName "Ginataang Bilo-Bilo" `
    -ImagePrompt "Filipino ginataang bilo-bilo dessert in white bowl, chewy glutinous rice balls, saba banana slices, sweet potato, taro, jackfruit, tapioca pearls in creamy coconut milk, warm cozy dessert, merienda, professional food photography" `
    -Caption @"
🥥 GINATAANG BILO-BILO — Mainit, Matamis, at Sobrang Sarap! 🍌

Pag maulan, ginataang bilo-bilo ang sagot! Malapot na gata, malambot na bilo-bilo, at tamis ng saging at kamote — ito na ang pinakamagandang merienda! 😍

🍚 2 cups galapong (glutinous rice flour)
🥥 2 cans coconut milk
🍌 3 pcs saging saba, hiniwa
🍠 Kamote at gabi, hiniwa
🫐 Sago, niluto na
🍬 ½ cup asukal

1. Gumawa ng bilo-bilo — bilugin ang masa ng galapong
2. Pakuluin ang gata + tubig — lutuin ang gabi at kamote ng 10 minuto
3. Ihulog ang mga bilo-bilo — float na sila pag luto na (5–7 minuto)
4. Dagdagan ng saging, langka, sago, at asukal
5. Haluin nang dahan-dahan — lutuin ng 5 minuto pa — tapos!

💡 Tip: Iluto ang sago nang hiwalay — 20–30 minuto bago transparent sila!

💬 Mainit o malamig ang gusto mo sa ginataang bilo-bilo? 🌡️ 👇
💾 I-save ang recipe para sa rainy day!

#LutongPinoy #GinataangBiloBilo #FilipinoFood #Kakanin #GinataanDessert #FilipinoDessert #RecipesDaily #PinoyKitchen #CoconutDessert #Merienda
"@

# --- Aug 29 (Sat): Chicken Inasal ---
Post-Recipe `
    -Date "2025-08-29" `
    -RecipeName "Chicken Inasal" `
    -ImagePrompt "Filipino chicken inasal Bacolod style grilled chicken, vibrant orange-red annatto color, charcoal grill marks, lemongrass aroma, served with garlic sinangag rice, calamansi, spiced vinegar dip, Bacolod food, professional food photography" `
    -Caption @"
🍗 CHICKEN INASAL — Ang Lasa ng Bacolod, Sa Inyong Hapag-Kainan! 🔥

Pag narinig mo na "inasal," alam mo nang masarap! Ang ganda ng kulay, ang bango ng lemongrass at calamansi, at ang tunay na Filipino grilling experience! 😩🤤

🍗 1 manok, hiniwa ng quarters
🍋 ½ cup calamansi juice
🌿 3 stalks lemongrass, dinurog
🧄 6 butil bawang
🌾 Atsuete oil para sa basting
🍬 2 tbsp brown sugar

1. Gumawa ng atsuete oil — init ang mantika + atsuete seeds = orange oil!
2. I-marinate ang manok ng 4 oras (overnight para mas malalim ang lasa)
3. Ihaw sa uling — bone-side down muna, 8–10 minuto
4. I-baste ng atsuete oil bawat 2–3 minuto habang nagluluto
5. Lutuin ng 20–25 minuto total — orange-red ang kulay pag luto na!

💡 Tip: I-drizzle ang natirang basting oil sa ibabaw ng garlic rice — ito ang LIHIM ng tunay na inasal rice!

💬 Nakaraan ka na ba sa Bacolod at natikman ang tunay na inasal? 😋 👇
💾 I-save ang recipe na ito!

#LutongPinoy #ChickenInasal #Inasal #FilipinoFood #BacolodFood #GrilledChicken #RecipesDaily #PinoyKitchen #VisayanFood #FilipinoBBQ
"@

# --- Aug 30 (Sun): Leche Flan ---
Post-Recipe `
    -Date "2025-08-30" `
    -RecipeName "Leche Flan" `
    -ImagePrompt "Filipino leche flan caramel custard dessert, perfectly unmolded on white plate, glossy amber caramel sauce flowing over silky smooth custard, llanera oval shape, elegant Filipino dessert, fiesta food, professional food photography" `
    -Caption @"
🍮 LECHE FLAN — Ang Reyna ng mga Dessert sa Pilipinas! 👑

Walang fiesta na kumpleto kung walang leche flan! Malapot, matamis, at nakakalunod na sarap — ito ang pinaka-iconic na Filipino dessert ng lahat ng panahon! 😍

🥚 10 egg yolks
🥛 1 can condensed milk
🥛 1 can evaporated milk
🍬 ¾ cup asukal (para sa caramel)
🌿 1 tsp vanilla extract

1. Tunawin ang asukal sa llanera — hintayin maging golden caramel
2. Haluin nang dahan-dahan ang egg yolks + dalawang gatas + vanilla
3. Salain ang mixture para mag-smooth
4. Ibuhos sa llanera na may caramel — takpan ng foil
5. I-steam ng 25–35 minuto sa mahinang apoy
6. Palamigin ng 2 oras — i-flip sa plato — enjoy!

💡 Tip: Huwag palakihin ang apoy habang ste-steam — gentle heat lang para walang bubbles sa custard!

💬 Sino sa inyo ang nagluto ng leche flan para sa kapistahan? 🙋 Tag ang magaling na magluto sa pamilya! 👇
💾 I-save — susunod na Pasko, ikaw na ang mag-bring ng leche flan!

#LutongPinoy #LecheFlan #FilipinoFood #FilipinoDesert #CaramelCustard #FilipinoFiesta #RecipesDaily #PinoyKitchen #Kakanin #FilipinoSweets
"@

Write-Host "`n✅ Week 4 scheduling complete!" -ForegroundColor Yellow
Write-Host "   All 7 posts scheduled Aug 24–30 @ 7AM PHT" -ForegroundColor Yellow
