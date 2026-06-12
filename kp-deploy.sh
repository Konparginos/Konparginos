#!/usr/bin/env bash
# KP demo sites — self-contained deploy script (creates files + deploys to Firebase Hosting)
set -e
PROJECT_ID="${1:-kp-demos-$((RANDOM%9000+1000))}"
mkdir -p kp-sites/public/{vouliotiko,psaropouli,milopotamos} kp-sites/emails
cd kp-sites
cat > firebase.json << 'KPEOF'
{
  "hosting": {
    "public": "public",
    "ignore": ["firebase.json", "**/.*"],
    "cleanUrls": true
  }
}
KPEOF

cat > public/index.html << 'KPEOF'
<!DOCTYPE html>
<html lang="el"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<meta name="robots" content="noindex">
<title>KP — Demos</title>
<style>body{font-family:system-ui;background:#10222E;color:#F7F5F0;display:grid;place-items:center;min-height:100vh;margin:0}
a{display:block;color:#F7F5F0;text-decoration:none;border:1px solid #ffffff33;border-radius:12px;padding:14px 22px;margin:8px 0;font-size:17px}
a:hover{background:#ffffff14}</style></head>
<body><div><h1 style="font-weight:600">KP · Demo sites</h1>
<a href="/vouliotiko/">Το Βουλιώτικο — Μεζεδοπωλείο</a>
<a href="/psaropouli/">το Ψαροπούλι — Ψαροταβέρνα</a>
<a href="/milopotamos/">ο Μυλοπόταμος — Φούρνος</a>
</div></body></html>
KPEOF

cat > public/vouliotiko/index.html << 'KPEOF'
<!DOCTYPE html>
<html lang="el">
<head>
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Το Βουλιώτικο · Μεζεδοπωλείο στη Βούλα</title>
<meta name="description" content="Μεζεδοπωλείο στη Βούλα με νοοτροπία Βολιώτικου τσιπουράδικου. Θαλασσινοί και κλασικοί μεζέδες, τσίπουρο, οικογενειακή ατμόσφαιρα.">
<link href="https://fonts.googleapis.com/css2?family=Literata:wght@500;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<style>
:root{--wine:#6E2A2A;--paper:#FAF6EE;--ink:#241A14;--brass:#B07A33;--soft:#EFE6D6}
*{box-sizing:border-box}body{margin:0;font-family:Inter,system-ui;background:var(--paper);color:var(--ink);line-height:1.6}
h1,h2,h3{font-family:Literata,serif}
.en{display:none}body.lang-en .en{display:revert}body.lang-en .gr{display:none}
header{background:var(--wine);color:var(--paper);padding:18px 20px;display:flex;justify-content:space-between;align-items:center;gap:10px;flex-wrap:wrap}
.logo{font-family:Literata,serif;font-weight:700;font-size:20px}
#lang{background:none;border:1px solid #ffffff66;color:var(--paper);border-radius:999px;padding:6px 14px;cursor:pointer;font-size:13px}
.hero{background:linear-gradient(160deg,var(--wine) 0%,#4C1D1D 100%);color:var(--paper);padding:64px 20px 72px;text-align:center}
.hero h1{font-size:clamp(34px,7vw,54px);margin:0 0 10px}
.hero p{max-width:560px;margin:0 auto 26px;color:#F2E4D2;font-size:17px}
.cta{display:inline-block;background:var(--brass);color:#fff;text-decoration:none;font-weight:600;border-radius:12px;padding:14px 26px;margin:4px 6px}
.cta.ghost{background:transparent;border:1px solid #ffffff77}
section{max-width:860px;margin:0 auto;padding:48px 20px}
.kicker{color:var(--wine);font-size:12px;letter-spacing:.14em;text-transform:uppercase;font-weight:600}
h2{font-size:30px;margin:6px 0 18px}
.grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:14px}
.card{background:#fff;border:1px solid var(--soft);border-radius:14px;padding:18px}
.card h3{margin:0 0 6px;font-size:18px}
.menu li{display:flex;justify-content:space-between;border-bottom:1px dashed var(--soft);padding:9px 0;list-style:none}
.menu{padding:0;margin:0}
blockquote{background:#fff;border-left:4px solid var(--brass);border-radius:0 12px 12px 0;padding:14px 18px;margin:10px 0;font-style:italic}
blockquote small{display:block;font-style:normal;color:#7A6C5C;margin-top:6px}
form{display:grid;gap:10px}
input,select,textarea{border:1px solid #D9CDBB;border-radius:10px;padding:12px;font-size:15px;font-family:inherit;background:#fff;width:100%}
button[type=submit]{background:var(--wine);color:#fff;border:none;border-radius:12px;padding:14px;font-size:16px;font-weight:600;cursor:pointer}
footer{background:var(--ink);color:#D8CBB8;padding:34px 20px;text-align:center;font-size:14px}
footer a{color:var(--paper)}
.bar{display:flex;gap:16px;flex-wrap:wrap;justify-content:center;background:var(--soft);padding:14px;font-size:14px;font-weight:500}
@media(prefers-reduced-motion:no-preference){.card{transition:transform .15s}.card:hover{transform:translateY(-3px)}}
</style>
</head>
<body>
<header>
  <div class="logo">Το Βουλιώτικο</div>
  <button id="lang" onclick="document.body.classList.toggle('lang-en');this.textContent=document.body.classList.contains('lang-en')?'ΕΛ':'EN'">EN</button>
</header>

<div class="hero">
  <h1>Το Βουλιώτικο</h1>
  <p class="gr">Μεζεδοπωλείο με ψυχή Βολιώτικου τσιπουράδικου, στην καρδιά της Βούλας. Θαλασσινοί μεζέδες, τσίπουρο και παρέα — δίπλα στην παιδική χαρά, με εύκολο πάρκινγκ.</p>
  <p class="en">A meze house with the soul of a Volos tsipouradiko, in the heart of Voula. Seafood mezedes, tsipouro and good company — next to the playground, with easy parking.</p>
  <a class="cta" href="#booking"><span class="gr">Κράτηση τραπεζιού</span><span class="en">Book a table</span></a>
  <a class="cta ghost" href="tel:+302110017730">☎ 211 001 7730</a>
</div>

<div class="bar">
  <span class="gr">⭐ 4,6 στο Google (200+ κριτικές)</span><span class="en">⭐ 4.6 on Google (200+ reviews)</span>
  <span class="gr">👨‍👩‍👧 Φιλικό για οικογένειες</span><span class="en">👨‍👩‍👧 Family friendly</span>
  <span class="gr">🛵 Delivery μέσω efood</span><span class="en">🛵 Delivery via efood</span>
</div>

<section>
  <div class="kicker"><span class="gr">Από την κουζίνα μας</span><span class="en">From our kitchen</span></div>
  <h2 class="gr">Οι μεζέδες που αγαπήθηκαν</h2><h2 class="en">The mezedes people love</h2>
  <ul class="menu">
    <li><span class="gr">Καλαμαράκι τηγανητό — τρυφερό, όπως πρέπει</span><span class="en">Fried squid — tender, as it should be</span></li>
    <li><span class="gr">Χταπόδι ξιδάτο</span><span class="en">Octopus in vinegar</span></li>
    <li><span class="gr">Γαρίδες παστές</span><span class="en">Cured prawns</span></li>
    <li><span class="gr">Τυροκαυτερή</span><span class="en">Spicy cheese dip</span></li>
    <li><span class="gr">Μπακαλιάρος σκορδαλιά</span><span class="en">Cod with garlic dip</span></li>
  </ul>
  <p style="font-size:13px;color:#7A6C5C"><span class="gr">* Ενδεικτικά πιάτα από τις κριτικές των πελατών μας. Ο πλήρης κατάλογος στο κατάστημα.</span><span class="en">* A taste of what guests mention most. Full menu in store.</span></p>
</section>

<section style="padding-top:0">
  <div class="kicker"><span class="gr">Είπαν για εμάς</span><span class="en">What guests say</span></div>
  <blockquote><span class="gr">«Κάθε πιάτο και γευστική έκπληξη — από το χταπόδι μέχρι τις παστές γαρίδες.»</span><span class="en">"Every dish a delight — from the octopus to the cured prawns."</span><small>— Google review</small></blockquote>
  <blockquote><span class="gr">«Αυθεντικό ελληνικό φαγητό, ιδανικό για οικογένειες, πρόθυμο προσωπικό.»</span><span class="en">"Authentic Greek food, child-friendly, helpful staff."</span><small>— Google review</small></blockquote>
</section>

<section style="padding-top:0">
  <div class="grid">
    <div class="card"><h3 class="gr">Ωράριο</h3><h3 class="en">Hours</h3>
      <p class="gr">Τρ–Πα 13:00–23:00<br>Σά 12:00–23:00 · Κυ 12:00–22:00<br>Δευτέρα κλειστά</p>
      <p class="en">Tue–Fri 1pm–11pm<br>Sat 12–11pm · Sun 12–10pm<br>Closed Mondays</p></div>
    <div class="card"><h3 class="gr">Πού θα μας βρείτε</h3><h3 class="en">Find us</h3>
      <p>Στρατάρχου Αλ. Παπάγου 28, Βούλα 166 73<br><a href="https://maps.google.com/?q=Το+Βουλιώτικο+Μεζεδοπωλείο+Βούλα">Google Maps →</a></p></div>
    <div class="card"><h3 class="gr">Παραγγελία σπίτι</h3><h3 class="en">Order in</h3>
      <p><a href="https://www.e-food.gr/delivery/boula/to-voyliotiko-mezedopoleio-6960634">efood →</a></p></div>
  </div>
</section>

<section id="booking" style="padding-top:0">
  <div class="kicker"><span class="gr">Κρατήσεις</span><span class="en">Reservations</span></div>
  <h2 class="gr">Κλείστε τραπέζι</h2><h2 class="en">Book a table</h2>
  <form action="https://formsubmit.co/konstantinosparginos@gmail.com" method="POST">
    <input type="hidden" name="_subject" value="Κράτηση — Το Βουλιώτικο">
    <input type="hidden" name="_captcha" value="false">
    <input name="name" required placeholder="Όνομα / Name">
    <input name="phone" required placeholder="Τηλέφωνο / Phone">
    <div style="display:flex;gap:10px"><input type="date" name="date" required style="flex:1"><input type="time" name="time" required style="flex:1"></div>
    <select name="guests"><option>2 άτομα / guests</option><option>3</option><option>4</option><option>5</option><option>6+</option></select>
    <textarea name="notes" rows="2" placeholder="Σχόλια / Notes (προαιρετικά)"></textarea>
    <button type="submit"><span class="gr">Αποστολή κράτησης</span><span class="en">Send reservation</span></button>
  </form>
</section>

<footer>
  Το Βουλιώτικο · Στρ. Αλ. Παπάγου 28, Βούλα · <a href="tel:+302110017730">211 001 7730</a><br>
  <span style="opacity:.55;font-size:12px">Demo σχεδιασμένο από KP · kp-demos</span>
</footer>
</body>
</html>
KPEOF

cat > public/psaropouli/index.html << 'KPEOF'
<!DOCTYPE html>
<html lang="el">
<head>
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>το Ψαροπούλι · Ψαροταβέρνα στη Βούλα</title>
<meta name="description" content="Φρέσκο ψάρι καθημερινά στη Βούλα. Σεβίτσε μπαρμπούνι, σφυρίδα στον ατμό, φιλόξενη ατμόσφαιρα. Κρατήσεις online.">
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,600;9..144,700&family=Manrope:wght@400;500;600&display=swap" rel="stylesheet">
<style>
:root{--sea:#0E4C66;--foam:#F4F8F9;--ink:#0C2630;--coral:#E2683F;--mist:#DCE9EE}
*{box-sizing:border-box}body{margin:0;font-family:Manrope,system-ui;background:var(--foam);color:var(--ink);line-height:1.6}
h1,h2,h3{font-family:Fraunces,serif}
.en{display:none}body.lang-en .en{display:revert}body.lang-en .gr{display:none}
header{padding:18px 20px;display:flex;justify-content:space-between;align-items:center;background:var(--foam);border-bottom:1px solid var(--mist)}
.logo{font-family:Fraunces,serif;font-weight:700;font-size:20px;color:var(--sea)}
#lang{background:none;border:1px solid var(--sea);color:var(--sea);border-radius:999px;padding:6px 14px;cursor:pointer;font-size:13px}
.hero{background:linear-gradient(180deg,var(--sea),#072F40);color:#fff;text-align:center;padding:64px 20px 88px;position:relative;overflow:hidden}
.hero h1{font-size:clamp(36px,8vw,58px);margin:0 0 10px;font-style:italic}
.hero p{max-width:520px;margin:0 auto 26px;color:#CFE4ED;font-size:17px}
.wave{position:absolute;bottom:-2px;left:0;width:100%}
.cta{display:inline-block;background:var(--coral);color:#fff;text-decoration:none;font-weight:600;border-radius:12px;padding:14px 26px;margin:4px 6px}
.cta.ghost{background:transparent;border:1px solid #ffffff77}
section{max-width:860px;margin:0 auto;padding:48px 20px}
.kicker{color:var(--coral);font-size:12px;letter-spacing:.14em;text-transform:uppercase;font-weight:700}
h2{font-size:30px;margin:6px 0 18px;color:var(--sea)}
.menu li{display:flex;justify-content:space-between;border-bottom:1px dashed var(--mist);padding:9px 0;list-style:none}
.menu{padding:0;margin:0}
.grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:14px}
.card{background:#fff;border:1px solid var(--mist);border-radius:14px;padding:18px}
.card h3{margin:0 0 6px;font-size:18px;color:var(--sea)}
blockquote{background:#fff;border-left:4px solid var(--coral);border-radius:0 12px 12px 0;padding:14px 18px;margin:10px 0;font-style:italic}
blockquote small{display:block;font-style:normal;color:#5E7682;margin-top:6px}
.notice{background:#FDEFE7;border:1px solid #F3CDB7;border-radius:12px;padding:12px 16px;font-size:14px;font-weight:500}
form{display:grid;gap:10px}
input,select,textarea{border:1px solid #C6D8E0;border-radius:10px;padding:12px;font-size:15px;font-family:inherit;background:#fff;width:100%}
button[type=submit]{background:var(--sea);color:#fff;border:none;border-radius:12px;padding:14px;font-size:16px;font-weight:600;cursor:pointer}
footer{background:var(--ink);color:#B9CDD6;padding:34px 20px;text-align:center;font-size:14px}
footer a{color:#fff}
</style>
</head>
<body>
<header>
  <div class="logo">το Ψαροπούλι</div>
  <button id="lang" onclick="document.body.classList.toggle('lang-en');this.textContent=document.body.classList.contains('lang-en')?'ΕΛ':'EN'">EN</button>
</header>

<div class="hero">
  <h1>το Ψαροπούλι</h1>
  <p class="gr">Φρέσκο ψάρι καθημερινά, σε έναν μικρό, φιλόξενο χώρο στη Βούλα. Ο Παύλος και η ομάδα του σας περιμένουν.</p>
  <p class="en">Fresh fish daily, in a small, welcoming spot in Voula. Pavlos and his team look forward to seeing you.</p>
  <a class="cta" href="#booking"><span class="gr">Κράτηση — απαραίτητη Σ/Κ</span><span class="en">Book — essential on weekends</span></a>
  <a class="cta ghost" href="tel:+302108953986">☎ 210 895 3986</a>
  <svg class="wave" viewBox="0 0 1440 60" preserveAspectRatio="none" height="60"><path d="M0 30 Q120 0 240 30 T480 30 T720 30 T960 30 T1200 30 T1440 30 V60 H0 Z" fill="#F4F8F9"/></svg>
</div>

<section>
  <div class="kicker"><span class="gr">Η ψαριά της ημέρας</span><span class="en">Catch of the day</span></div>
  <h2 class="gr">Ό,τι φέρνει η θάλασσα</h2><h2 class="en">Whatever the sea brings</h2>
  <ul class="menu">
    <li><span class="gr">Σεβίτσε μπαρμπούνι</span><span class="en">Red mullet ceviche</span></li>
    <li><span class="gr">Σφυρίδα στον ατμό, λαδολέμονο</span><span class="en">Steamed grouper, olive oil &amp; lemon</span></li>
    <li><span class="gr">Φρέσκο ψάρι ημέρας στη σχάρα</span><span class="en">Grilled fresh fish of the day</span></li>
    <li><span class="gr">Θαλασσινοί μεζέδες</span><span class="en">Seafood mezedes</span></li>
  </ul>
  <p style="font-size:13px;color:#5E7682"><span class="gr">* Πιάτα που ξεχωρίζουν οι πελάτες μας στις κριτικές. Ο κατάλογος αλλάζει με την ψαριά.</span><span class="en">* Guest favourites from our reviews. The menu follows the catch.</span></p>
</section>

<section style="padding-top:0">
  <blockquote><span class="gr">«Το καλύτερο φαγητό που έχω φάει — ευχάριστη ατμόσφαιρα, ευγενικό προσωπικό.»</span><span class="en">"The best food I've ever had — pleasant atmosphere, very polite staff."</span><small>— Google review</small></blockquote>
  <blockquote><span class="gr">«Φρέσκο ψάρι σε λογικές τιμές, με τον Παύλο εξαιρετικό οικοδεσπότη.»</span><span class="en">"Fresh fish at fair prices, with Pavlos a great host."</span><small>— Google review</small></blockquote>
  <div class="notice"><span class="gr">Ο χώρος είναι μικρός — τα Σαββατοκύριακα η κράτηση είναι απαραίτητη.</span><span class="en">We're a small venue — weekend bookings are essential.</span></div>
</section>

<section style="padding-top:0">
  <div class="grid">
    <div class="card"><h3 class="gr">Ωράριο</h3><h3 class="en">Hours</h3>
      <p class="gr">Τε–Σά 14:00–23:00<br>Κυ 13:00–23:00<br>Δε–Τρ κλειστά</p>
      <p class="en">Wed–Sat 2pm–11pm<br>Sun 1pm–11pm<br>Closed Mon–Tue</p></div>
    <div class="card"><h3 class="gr">Πού θα μας βρείτε</h3><h3 class="en">Find us</h3>
      <p>Μπιζανίου 1, Βούλα 166 73<br><a href="https://maps.google.com/?q=το+Ψαροπούλι+Βούλα">Google Maps →</a></p></div>
  </div>
</section>

<section id="booking" style="padding-top:0">
  <div class="kicker"><span class="gr">Κρατήσεις</span><span class="en">Reservations</span></div>
  <h2 class="gr">Κλείστε τραπέζι</h2><h2 class="en">Book a table</h2>
  <form action="https://formsubmit.co/konstantinosparginos@gmail.com" method="POST">
    <input type="hidden" name="_subject" value="Κράτηση — το Ψαροπούλι">
    <input type="hidden" name="_captcha" value="false">
    <input name="name" required placeholder="Όνομα / Name">
    <input name="phone" required placeholder="Τηλέφωνο / Phone">
    <div style="display:flex;gap:10px"><input type="date" name="date" required style="flex:1"><input type="time" name="time" required style="flex:1"></div>
    <select name="guests"><option>2 άτομα / guests</option><option>3</option><option>4</option><option>5</option><option>6+</option></select>
    <button type="submit"><span class="gr">Αποστολή κράτησης</span><span class="en">Send reservation</span></button>
  </form>
</section>

<footer>
  το Ψαροπούλι · Μπιζανίου 1, Βούλα · <a href="tel:+302108953986">210 895 3986</a><br>
  <span style="opacity:.55;font-size:12px">Demo σχεδιασμένο από KP · kp-demos</span>
</footer>
</body>
</html>
KPEOF

cat > public/milopotamos/index.html << 'KPEOF'
<!DOCTYPE html>
<html lang="el">
<head>
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>ο Μυλοπόταμος · Παραδοσιακός φούρνος στη Βούλα</title>
<meta name="description" content="Παραδοσιακός φούρνος στην πλατεία της Βούλας. Ζυμωτό ψωμί, ντίνκελ, πίτες, δίπλες, καφές — από τις 6 το πρωί, κάθε μέρα.">
<link href="https://fonts.googleapis.com/css2?family=Gabarito:wght@600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<style>
:root{--wheat:#C98A2B;--crust:#7A4A1E;--cream:#FBF7EF;--ink:#33261A;--soft:#F0E5D2}
*{box-sizing:border-box}body{margin:0;font-family:Inter,system-ui;background:var(--cream);color:var(--ink);line-height:1.6}
h1,h2,h3{font-family:Gabarito,system-ui}
.en{display:none}body.lang-en .en{display:revert}body.lang-en .gr{display:none}
header{padding:18px 20px;display:flex;justify-content:space-between;align-items:center;border-bottom:1px solid var(--soft)}
.logo{font-family:Gabarito;font-weight:700;font-size:20px;color:var(--crust)}
#lang{background:none;border:1px solid var(--crust);color:var(--crust);border-radius:999px;padding:6px 14px;cursor:pointer;font-size:13px}
.hero{text-align:center;padding:60px 20px 56px;background:radial-gradient(ellipse at top,#F6E9D2,var(--cream) 70%)}
.hero h1{font-size:clamp(36px,8vw,56px);margin:0 0 8px;color:var(--crust)}
.hero .since{color:var(--wheat);font-weight:700;letter-spacing:.12em;text-transform:uppercase;font-size:12px}
.hero p{max-width:540px;margin:10px auto 26px;font-size:17px;color:#5C4A35}
.cta{display:inline-block;background:var(--crust);color:#fff;text-decoration:none;font-weight:600;border-radius:12px;padding:14px 26px;margin:4px 6px}
.cta.ghost{background:transparent;border:1px solid var(--crust);color:var(--crust)}
.openbar{background:var(--crust);color:#F6E9D2;text-align:center;padding:12px;font-weight:600;font-size:15px}
section{max-width:860px;margin:0 auto;padding:48px 20px}
.kicker{color:var(--wheat);font-size:12px;letter-spacing:.14em;text-transform:uppercase;font-weight:700}
h2{font-size:30px;margin:6px 0 18px;color:var(--crust)}
.grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:14px}
.card{background:#fff;border:1px solid var(--soft);border-radius:14px;padding:18px}
.card h3{margin:0 0 6px;font-size:17px;color:var(--crust)}
.card p{margin:0;font-size:14px;color:#6B563E}
blockquote{background:#fff;border-left:4px solid var(--wheat);border-radius:0 12px 12px 0;padding:14px 18px;margin:10px 0;font-style:italic}
blockquote small{display:block;font-style:normal;color:#8A7458;margin-top:6px}
form{display:grid;gap:10px}
input,textarea{border:1px solid #DCCBAE;border-radius:10px;padding:12px;font-size:15px;font-family:inherit;background:#fff;width:100%}
button[type=submit]{background:var(--crust);color:#fff;border:none;border-radius:12px;padding:14px;font-size:16px;font-weight:600;cursor:pointer}
footer{background:var(--ink);color:#D9C6A8;padding:34px 20px;text-align:center;font-size:14px}
footer a{color:#fff}
</style>
</head>
<body>
<header>
  <div class="logo">ο Μυλοπόταμος</div>
  <button id="lang" onclick="document.body.classList.toggle('lang-en');this.textContent=document.body.classList.contains('lang-en')?'ΕΛ':'EN'">EN</button>
</header>

<div class="hero">
  <div class="since"><span class="gr">Παραδοσιακός φούρνος · Πλατεία Βούλας</span><span class="en">Traditional bakery · Voula square</span></div>
  <h1>ο Μυλοπόταμος</h1>
  <p class="gr">Από τους πιο παλιούς φούρνους της γειτονιάς. Ζυμωτό ψωμί, ζεστές πίτες και γλυκά, ψημένα κάθε πρωί από τις 6 — με την ίδια φροντίδα, χρόνια τώρα.</p>
  <p class="en">One of the neighbourhood's oldest bakeries. Hand-kneaded bread, warm pies and sweets, baked fresh every morning from 6am — with the same care, year after year.</p>
  <a class="cta" href="#order"><span class="gr">Παραγγελία για παραλαβή</span><span class="en">Order for pickup</span></a>
  <a class="cta ghost" href="tel:+302108958080">☎ 210 895 8080</a>
</div>

<div class="openbar"><span class="gr">Ανοιχτά κάθε μέρα 6:00 – 21:00</span><span class="en">Open daily 6am – 9pm</span></div>

<section>
  <div class="kicker"><span class="gr">Από τον φούρνο μας</span><span class="en">From our oven</span></div>
  <h2 class="gr">Ψημένα με μεράκι</h2><h2 class="en">Baked with care</h2>
  <div class="grid">
    <div class="card"><h3 class="gr">Ψωμιά</h3><h3 class="en">Breads</h3><p class="gr">Ζυμωτό, προζύμι, ντίνκελ, πολύσπορο</p><p class="en">Hand-kneaded, sourdough, dinkel, multigrain</p></div>
    <div class="card"><h3 class="gr">Πίτες</h3><h3 class="en">Pies</h3><p class="gr">Τυρόπιτα, σπανακόπιτα — ζεστές όλη μέρα</p><p class="en">Cheese &amp; spinach pies — warm all day</p></div>
    <div class="card"><h3 class="gr">Γλυκά</h3><h3 class="en">Sweets</h3><p class="gr">Δίπλες «σαν της γιαγιάς», σιροπιαστά</p><p class="en">Grandma-style diples, syrup sweets</p></div>
    <div class="card"><h3 class="gr">Καφές</h3><h3 class="en">Coffee</h3><p class="gr">Φρέσκος καφές για το δρόμο</p><p class="en">Fresh coffee to go</p></div>
  </div>
</section>

<section style="padding-top:0">
  <blockquote><span class="gr">«Οι δίπλες του, οι καλύτερες που έχω φάει μετά της γιαγιάς μου.»</span><span class="en">"The best diples I've had since my grandmother's."</span><small>— Google review</small></blockquote>
  <blockquote><span class="gr">«Φρέσκο ψωμί καθημερινά και προσωπικό με χαμόγελο — γι' αυτό ξαναγυρνάμε.»</span><span class="en">"Daily fresh bread and staff with a smile — that's why we keep coming back."</span><small>— Google review</small></blockquote>
</section>

<section id="order" style="padding-top:0">
  <div class="kicker"><span class="gr">Παραγγελίες</span><span class="en">Orders</span></div>
  <h2 class="gr">Παραγγείλετε από πριν</h2><h2 class="en">Order ahead</h2>
  <p class="gr" style="margin-top:-8px;color:#6B563E">Για γιορτές, τσουρέκια, τούρτες ή μεγάλες ποσότητες — στείλτε μας τι θέλετε και πότε.</p>
  <p class="en" style="margin-top:-8px;color:#6B563E">For celebrations, tsoureki, cakes or larger quantities — tell us what you need and when.</p>
  <form action="https://formsubmit.co/konstantinosparginos@gmail.com" method="POST">
    <input type="hidden" name="_subject" value="Παραγγελία — ο Μυλοπόταμος">
    <input type="hidden" name="_captcha" value="false">
    <input name="name" required placeholder="Όνομα / Name">
    <input name="phone" required placeholder="Τηλέφωνο / Phone">
    <input type="date" name="pickup" required>
    <textarea name="order" rows="3" required placeholder="Τι θα θέλατε; / What would you like?"></textarea>
    <button type="submit"><span class="gr">Αποστολή παραγγελίας</span><span class="en">Send order</span></button>
  </form>
</section>

<footer>
  ο Μυλοπόταμος · Πλαστήρα 6, Βούλα · <a href="tel:+302108958080">210 895 8080</a><br>
  <span style="opacity:.55;font-size:12px">Demo σχεδιασμένο από KP · kp-demos</span>
</footer>
</body>
</html>
KPEOF

cat > emails/outreach-emails.md << 'KPEOF'
# Έτοιμα emails (στείλε από το προσωπικό σου Gmail)
Αντικατέστησε ΜΟΝΟ το PROJECT με το όνομα του Firebase project σου.

---
## 1. Το Βουλιώτικο — tovouliotiko (Instagram DM ή email αν βρεις)
**Θέμα:** Σας έφτιαξα μια ιστοσελίδα — ρίξτε μια ματιά

Καλησπέρα σας,

με λένε Κωνσταντίνο και μένω εδώ, στη Βούλα. Είμαι από αυτούς που έρχονται
για το καλαμαράκι και τις παστές γαρίδες — και πρόσεξα ότι, ενώ έχετε από
τις καλύτερες κριτικές της περιοχής, δεν έχετε δική σας ιστοσελίδα.

Σας έφτιαξα λοιπόν μία, χωρίς καμία υποχρέωση, για να δείτε πώς θα έδειχνε:
https://PROJECT.web.app/vouliotiko

Έχει κρατήσεις online, μενού, ωράριο, σύνδεση με το efood — όλα στα ελληνικά
και στα αγγλικά. Αν σας αρέσει, γίνεται δική σας με 150€ εφάπαξ. Προαιρετικά:
επαγγελματικό email και φιλοξενία +50€, e-shop +250€, online πληρωμές ανάλογα
με τις ανάγκες σας. Μπορώ επίσης να ψηφιοποιήσω κρατήσεις ή ό,τι άλλο
χρειάζεται η καθημερινότητα του μαγαζιού.

Ευχαρίστως να περάσω από το κατάστημα να τα πούμε — ή τηλεφωνικά, όποτε σας
βολεύει. Αν προτιμάτε επικοινωνία στα αγγλικά, κανένα πρόβλημα.

Καλή συνέχεια,
Κωνσταντίνος (KP)
[τηλέφωνό σου]

---
## 2. το Ψαροπούλι
**Θέμα:** Μια ιστοσελίδα για το Ψαροπούλι — με online κρατήσεις

Καλησπέρα σας,

με λένε Κωνσταντίνο, μένω στη Βούλα. Ξέρω ότι ο χώρος σας γεμίζει και ότι
τα Σαββατοκύριακα η κράτηση είναι απαραίτητη — γι' αυτό σας έφτιαξα μια
ιστοσελίδα όπου οι πελάτες κλείνουν τραπέζι μόνοι τους, μέρα-νύχτα:
https://PROJECT.web.app/psaropouli

Δείτε την με την ησυχία σας — έχει την ψαριά, το ωράριο, κρατήσεις, σε
ελληνικά και αγγλικά για τους ξένους επισκέπτες. Αν σας αρέσει, γίνεται
δική σας με 150€ εφάπαξ. Προαιρετικά: επαγγελματικό email + φιλοξενία +50€,
e-shop +250€, online πληρωμές κατόπιν συζήτησης.

Χωρίς καμία δέσμευση — ευχαρίστως να περάσω να γνωριστούμε. Αν προτιμάτε
αγγλικά, κανένα πρόβλημα.

Με εκτίμηση,
Κωνσταντίνος (KP)
[τηλέφωνό σου]

---
## 3. ο Μυλοπόταμος
**Θέμα:** Έφτιαξα μια ιστοσελίδα για τον φούρνο σας

Καλημέρα σας,

με λένε Κωνσταντίνο και είμαι πελάτης σας — από τους πιο παλιούς και
αγαπημένους φούρνους της Βούλας λείπει μόνο ένα πράγμα: μια δική σας
ιστοσελίδα. Σας έφτιαξα μία για να τη δείτε:
https://PROJECT.web.app/milopotamos

Έχει τα προϊόντα σας, το ωράριο και φόρμα για παραγγελίες από πριν
(τσουρέκια, δίπλες, γιορτές) — ελληνικά και αγγλικά. Αν σας αρέσει,
γίνεται δική σας με 150€ εφάπαξ. Προαιρετικά: επαγγελματικό email +
φιλοξενία +50€, e-shop +250€.

Περνάω ούτως ή άλλως για ψωμί — πείτε μου πότε σας βολεύει να τα πούμε
από κοντά. Αν προτιμάτε αγγλικά, κανένα πρόβλημα.

Καλή συνέχεια,
Κωνσταντίνος (KP)
[τηλέφωνό σου]
KPEOF

cat > .firebaserc << KPEOF
{ "projects": { "default": "$PROJECT_ID" } }
KPEOF

command -v firebase >/dev/null || npm i -g firebase-tools
firebase projects:list >/dev/null 2>&1 || firebase login
firebase projects:create "$PROJECT_ID" --display-name "KP Demos" 2>/dev/null || echo "Project exists or creation skipped — using $PROJECT_ID"
firebase deploy --only hosting --project "$PROJECT_ID"

echo ""
echo "================ LIVE LINKS ================"
echo "https://$PROJECT_ID.web.app/vouliotiko"
echo "https://$PROJECT_ID.web.app/psaropouli"
echo "https://$PROJECT_ID.web.app/milopotamos"
echo "Emails: kp-sites/emails/outreach-emails.md (βάλε το PROJECT URL + τηλέφωνό σου)"
