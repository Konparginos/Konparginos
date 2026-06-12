#!/usr/bin/env bash
# kp-deploy.sh — Build 3 Greek restaurant demo sites and deploy to Firebase Hosting
set -euo pipefail

PROJECT_ID="${1:-kp-demos-$(openssl rand -hex 4)}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEPLOY_DIR="$SCRIPT_DIR/kp-sites"
PUBLIC_DIR="$DEPLOY_DIR/public"

echo "================================================"
echo "  KP Demo Sites — Firebase Deployment"
echo "================================================"
echo "  Project ID : $PROJECT_ID"
echo "  Output dir : $DEPLOY_DIR"
echo "================================================"

# ── 1. Firebase CLI ────────────────────────────────────────────────────────────
if ! command -v firebase &>/dev/null; then
  echo "▶ Installing Firebase CLI via npm..."
  npm install -g firebase-tools
fi
echo "▶ Firebase CLI: $(firebase --version)"

# ── 2. Directory scaffold ──────────────────────────────────────────────────────
echo "▶ Creating site files..."
mkdir -p "$PUBLIC_DIR/vouliotiko" \
         "$PUBLIC_DIR/psaropouli" \
         "$PUBLIC_DIR/milopotamos" \
         "$DEPLOY_DIR/emails"

# ── 3. firebase.json ───────────────────────────────────────────────────────────
cat > "$DEPLOY_DIR/firebase.json" << 'ENDJSON'
{
  "hosting": {
    "public": "public",
    "ignore": ["firebase.json", "**/.*", "**/node_modules/**"],
    "cleanUrls": true,
    "trailingSlash": false
  }
}
ENDJSON

# ── 4. .firebaserc ─────────────────────────────────────────────────────────────
cat > "$DEPLOY_DIR/.firebaserc" << ENDJSON
{
  "projects": {
    "default": "$PROJECT_ID"
  }
}
ENDJSON

# ── 5. Hub index.html ──────────────────────────────────────────────────────────
cat > "$PUBLIC_DIR/index.html" << 'ENDHTML'
<!DOCTYPE html>
<html lang="el">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>KP Demo Sites — Ελληνικά Εστιατόρια</title>
<style>
  *{box-sizing:border-box;margin:0;padding:0}
  body{font-family:'Segoe UI',sans-serif;background:#0d1b2a;color:#e0e0e0;min-height:100vh;display:flex;flex-direction:column;align-items:center;justify-content:center;padding:2rem}
  h1{font-size:2.2rem;text-align:center;color:#f5c842;margin-bottom:.5rem}
  p{text-align:center;color:#9ab;margin-bottom:2.5rem;font-size:1.05rem}
  .grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(260px,1fr));gap:1.5rem;width:100%;max-width:900px}
  .card{background:#162032;border-radius:14px;padding:2rem 1.5rem;text-align:center;text-decoration:none;color:inherit;border:1px solid #1e3a5f;transition:.2s}
  .card:hover{transform:translateY(-4px);border-color:#f5c842}
  .card .emoji{font-size:3rem;margin-bottom:.8rem}
  .card h2{font-size:1.3rem;color:#f5c842;margin-bottom:.4rem}
  .card p{font-size:.9rem;color:#8ab;margin:0}
  footer{margin-top:3rem;color:#456;font-size:.8rem}
</style>
</head>
<body>
<h1>🍽️ KP Demo Restaurants</h1>
<p>Three live demo websites built for Greek tavernas — click to explore</p>
<div class="grid">
  <a class="card" href="/vouliotiko">
    <div class="emoji">🍷</div>
    <h2>Το Βουλιώτικο</h2>
    <p>Παραδοσιακή μεζεδοπωλείο — Traditional mezze taverna</p>
  </a>
  <a class="card" href="/psaropouli">
    <div class="emoji">🐟</div>
    <h2>το Ψαροπούλι</h2>
    <p>Φρέσκα ψάρια καθημερινά — Fresh fish taverna by the sea</p>
  </a>
  <a class="card" href="/milopotamos">
    <div class="emoji">🍞</div>
    <h2>ο Μυλοπόταμος</h2>
    <p>Παραδοσιακός φούρνος — Traditional bakery &amp; café</p>
  </a>
</div>
<footer>Demo sites created by Konstantinos Parginos · Firebase Hosting</footer>
</body>
</html>
ENDHTML

# ── 6. Βουλιώτικο ─────────────────────────────────────────────────────────────
cat > "$PUBLIC_DIR/vouliotiko/index.html" << 'ENDHTML'
<!DOCTYPE html>
<html lang="el" data-lang="el">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Το Βουλιώτικο — Μεζεδοπωλείο</title>
<style>
  *{box-sizing:border-box;margin:0;padding:0}
  :root{--clay:#b5451b;--sand:#f5e6c8;--dark:#2c1a0e;--olive:#5a7a2a;--light:#fffbf3}
  body{font-family:'Segoe UI',sans-serif;background:var(--light);color:var(--dark)}
  /* NAV */
  nav{background:var(--clay);padding:1rem 2rem;display:flex;justify-content:space-between;align-items:center;position:sticky;top:0;z-index:100}
  nav .logo{color:#fff;font-size:1.4rem;font-weight:700;text-decoration:none}
  nav .links a{color:#fde;text-decoration:none;margin-left:1.2rem;font-size:.95rem}
  nav .links a:hover{color:#fff}
  .lang-btn{background:rgba(255,255,255,.2);border:1px solid rgba(255,255,255,.4);color:#fff;padding:.3rem .8rem;border-radius:20px;cursor:pointer;font-size:.85rem}
  .lang-btn:hover{background:rgba(255,255,255,.3)}
  /* HERO */
  .hero{background:linear-gradient(135deg,var(--clay) 0%,#7a2e10 100%);color:#fff;text-align:center;padding:5rem 2rem}
  .hero h1{font-size:3rem;margin-bottom:1rem;text-shadow:0 2px 8px rgba(0,0,0,.4)}
  .hero p{font-size:1.2rem;opacity:.9;max-width:600px;margin:0 auto 2rem}
  .hero .cta{display:inline-block;background:var(--sand);color:var(--clay);padding:.8rem 2rem;border-radius:30px;text-decoration:none;font-weight:700;font-size:1rem}
  .hero .cta:hover{background:#fff}
  /* SECTIONS */
  section{padding:4rem 2rem;max-width:1000px;margin:0 auto}
  h2{font-size:1.9rem;color:var(--clay);margin-bottom:1.5rem;text-align:center}
  /* MENU */
  .menu-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:1.2rem}
  .menu-item{background:#fff;border-radius:10px;padding:1.2rem;border-left:4px solid var(--clay);box-shadow:0 2px 8px rgba(0,0,0,.06)}
  .menu-item h3{color:var(--clay);font-size:1rem;margin-bottom:.3rem}
  .menu-item p{font-size:.85rem;color:#666;margin-bottom:.5rem}
  .menu-item .price{font-weight:700;color:var(--olive);font-size:1rem}
  /* INFO */
  .info-cards{display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:1.2rem}
  .info-card{text-align:center;padding:1.5rem;background:#fff;border-radius:10px;box-shadow:0 2px 8px rgba(0,0,0,.06)}
  .info-card .icon{font-size:2rem;margin-bottom:.5rem}
  .info-card h3{font-size:1rem;color:var(--clay);margin-bottom:.3rem}
  .info-card p{font-size:.85rem;color:#555}
  .info-card a{color:var(--clay);text-decoration:none}
  /* FORM */
  .form-wrap{background:#fff;border-radius:14px;padding:2rem;box-shadow:0 4px 16px rgba(0,0,0,.08);max-width:600px;margin:0 auto}
  .form-group{margin-bottom:1.2rem}
  label{display:block;font-size:.9rem;color:var(--dark);margin-bottom:.3rem;font-weight:600}
  input,select,textarea{width:100%;padding:.7rem 1rem;border:1px solid #ddd;border-radius:8px;font-size:.95rem;font-family:inherit}
  input:focus,select:focus,textarea:focus{outline:none;border-color:var(--clay)}
  .form-row{display:grid;grid-template-columns:1fr 1fr;gap:1rem}
  button[type=submit]{background:var(--clay);color:#fff;border:none;padding:.8rem 2rem;border-radius:30px;font-size:1rem;font-weight:700;cursor:pointer;width:100%}
  button[type=submit]:hover{background:#9a3810}
  /* FOOTER */
  footer{background:var(--dark);color:#cba;text-align:center;padding:2rem;font-size:.9rem}
  footer a{color:#f5c842;text-decoration:none}
  /* LANG */
  [data-lang=en] .el{display:none}
  [data-lang=el] .en{display:none}
  @media(max-width:600px){
    .hero h1{font-size:2rem}
    .form-row{grid-template-columns:1fr}
    nav .links{display:none}
  }
</style>
</head>
<body>
<nav>
  <a class="logo" href="/">← <span class="el">Το Βουλιώτικο</span><span class="en">To Vouliwtiko</span></a>
  <div class="links">
    <a href="#menu"><span class="el">Μενού</span><span class="en">Menu</span></a>
    <a href="#info"><span class="el">Πληροφορίες</span><span class="en">Info</span></a>
    <a href="#reservation"><span class="el">Κράτηση</span><span class="en">Reserve</span></a>
  </div>
  <button class="lang-btn" onclick="toggleLang()">EN / ΕΛ</button>
</nav>

<div class="hero">
  <h1>🍷 <span class="el">Το Βουλιώτικο</span><span class="en">To Vouliwtiko</span></h1>
  <p class="el">Αυθεντικά μεζεδάκια, κρασί χύμα και παρέα που δεν ξεχνιέται</p>
  <p class="en">Authentic mezze, house wine, and unforgettable company</p>
  <a class="cta" href="#reservation"><span class="el">Κάνε κράτηση</span><span class="en">Book a table</span></a>
</div>

<section id="menu">
  <h2><span class="el">Το Μενού μας</span><span class="en">Our Menu</span></h2>
  <div class="menu-grid">
    <div class="menu-item">
      <h3><span class="el">Τυροκαυτερή</span><span class="en">Spicy Feta Dip</span></h3>
      <p class="el">Καυτερή φέτα με ντομάτα &amp; πιπεριά</p><p class="en">Spicy feta with tomato &amp; pepper</p>
      <div class="price">4,50 €</div>
    </div>
    <div class="menu-item">
      <h3><span class="el">Χταπόδι σχάρας</span><span class="en">Grilled Octopus</span></h3>
      <p class="el">Φρέσκο χταπόδι με λαδολέμονο</p><p class="en">Fresh octopus with olive oil &amp; lemon</p>
      <div class="price">11,00 €</div>
    </div>
    <div class="menu-item">
      <h3><span class="el">Κολοκυθοκεφτέδες</span><span class="en">Zucchini Fritters</span></h3>
      <p class="el">Τραγανοί, σερβιρισμένοι με τζατζίκι</p><p class="en">Crispy, served with tzatziki</p>
      <div class="price">6,00 €</div>
    </div>
    <div class="menu-item">
      <h3><span class="el">Σαγανάκι</span><span class="en">Pan-fried Cheese</span></h3>
      <p class="el">Τηγανητό κεφαλοτύρι με λεμόνι</p><p class="en">Fried kefalotiri with lemon</p>
      <div class="price">7,50 €</div>
    </div>
    <div class="menu-item">
      <h3><span class="el">Μελιτζανοσαλάτα</span><span class="en">Aubergine Salad</span></h3>
      <p class="el">Ψητή μελιτζάνα με σκόρδο &amp; παρσλεϊ</p><p class="en">Roasted aubergine with garlic &amp; parsley</p>
      <div class="price">5,00 €</div>
    </div>
    <div class="menu-item">
      <h3><span class="el">Κρασί χύμα (καράφα)</span><span class="en">House Wine (carafe)</span></h3>
      <p class="el">Τοπικός οίνος 500ml</p><p class="en">Local wine 500ml</p>
      <div class="price">8,00 €</div>
    </div>
  </div>
</section>

<section id="info" style="background:#fff8f0;padding:4rem 2rem;max-width:100%">
  <div style="max-width:1000px;margin:0 auto">
    <h2><span class="el">Βρείτε μας</span><span class="en">Find Us</span></h2>
    <div class="info-cards">
      <div class="info-card">
        <div class="icon">📍</div>
        <h3><span class="el">Διεύθυνση</span><span class="en">Address</span></h3>
        <p><a href="https://maps.google.com/?q=Βουλιώτικο+ταβέρνα" target="_blank">
          <span class="el">Κεντρική Πλατεία 5, Βουλιαγμένη</span>
          <span class="en">5 Central Square, Vouliagmeni</span>
        </a></p>
      </div>
      <div class="info-card">
        <div class="icon">📞</div>
        <h3><span class="el">Τηλέφωνο</span><span class="en">Phone</span></h3>
        <p><a href="tel:+302109000111">+30 210 900 0111</a></p>
      </div>
      <div class="info-card">
        <div class="icon">🕐</div>
        <h3><span class="el">Ώρες</span><span class="en">Hours</span></h3>
        <p class="el">Καθημερινά 18:00 – 01:00</p>
        <p class="en">Daily 18:00 – 01:00</p>
      </div>
      <div class="info-card">
        <div class="icon">🅿️</div>
        <h3><span class="el">Parking</span><span class="en">Parking</span></h3>
        <p class="el">Δωρεάν χώρος στάθμευσης</p>
        <p class="en">Free parking available</p>
      </div>
    </div>
  </div>
</section>

<section id="reservation" style="max-width:1000px;margin:0 auto;padding:4rem 2rem">
  <h2><span class="el">Κάνε Κράτηση</span><span class="en">Make a Reservation</span></h2>
  <div class="form-wrap">
    <form action="https://formsubmit.co/demo@example.com" method="POST">
      <input type="hidden" name="_subject" value="Νέα κράτηση - Βουλιώτικο">
      <input type="hidden" name="_captcha" value="false">
      <div class="form-row">
        <div class="form-group">
          <label><span class="el">Όνομα</span><span class="en">Name</span></label>
          <input type="text" name="name" required placeholder="π.χ. Γιώργος Παπαδόπουλος">
        </div>
        <div class="form-group">
          <label><span class="el">Τηλέφωνο</span><span class="en">Phone</span></label>
          <input type="tel" name="phone" required placeholder="+30 69...">
        </div>
      </div>
      <div class="form-row">
        <div class="form-group">
          <label><span class="el">Ημερομηνία</span><span class="en">Date</span></label>
          <input type="date" name="date" required>
        </div>
        <div class="form-group">
          <label><span class="el">Ώρα</span><span class="en">Time</span></label>
          <select name="time">
            <option>18:00</option><option>18:30</option><option>19:00</option>
            <option>19:30</option><option>20:00</option><option>20:30</option>
            <option>21:00</option><option>21:30</option><option>22:00</option>
          </select>
        </div>
      </div>
      <div class="form-group">
        <label><span class="el">Αριθμός ατόμων</span><span class="en">Number of guests</span></label>
        <select name="guests">
          <option>1</option><option>2</option><option>3</option><option>4</option>
          <option>5</option><option>6</option><option>7-10</option><option>10+</option>
        </select>
      </div>
      <div class="form-group">
        <label><span class="el">Ειδικές σημειώσεις</span><span class="en">Special requests</span></label>
        <textarea name="notes" rows="3" placeholder="..."></textarea>
      </div>
      <button type="submit"><span class="el">Αποστολή Κράτησης</span><span class="en">Send Reservation</span></button>
    </form>
  </div>
</section>

<footer>
  <p>© 2025 Το Βουλιώτικο &nbsp;|&nbsp; <a href="tel:+302109000111">+30 210 900 0111</a> &nbsp;|&nbsp;
  <a href="https://maps.google.com/?q=Βουλιώτικο+ταβέρνα" target="_blank">Google Maps</a></p>
  <p style="margin-top:.5rem;color:#876;font-size:.8rem">Demo site by <a href="/">KP Demo Sites</a></p>
</footer>

<script>
function toggleLang(){
  var h=document.documentElement;
  h.dataset.lang = h.dataset.lang==='el' ? 'en' : 'el';
}
</script>
</body>
</html>
ENDHTML

# ── 7. Ψαροπούλι ──────────────────────────────────────────────────────────────
cat > "$PUBLIC_DIR/psaropouli/index.html" << 'ENDHTML'
<!DOCTYPE html>
<html lang="el" data-lang="el">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>το Ψαροπούλι — Ψαροταβέρνα</title>
<style>
  *{box-sizing:border-box;margin:0;padding:0}
  :root{--sea:#0a6b8a;--foam:#e8f6f9;--dark:#0a2332;--coral:#e05c35;--light:#f0fbff}
  body{font-family:'Segoe UI',sans-serif;background:var(--light);color:var(--dark)}
  nav{background:var(--sea);padding:1rem 2rem;display:flex;justify-content:space-between;align-items:center;position:sticky;top:0;z-index:100}
  nav .logo{color:#fff;font-size:1.4rem;font-weight:700;text-decoration:none}
  nav .links a{color:#aee;text-decoration:none;margin-left:1.2rem;font-size:.95rem}
  nav .links a:hover{color:#fff}
  .lang-btn{background:rgba(255,255,255,.2);border:1px solid rgba(255,255,255,.4);color:#fff;padding:.3rem .8rem;border-radius:20px;cursor:pointer;font-size:.85rem}
  .hero{background:linear-gradient(135deg,var(--sea) 0%,#063d52 100%);color:#fff;text-align:center;padding:5rem 2rem}
  .hero h1{font-size:3rem;margin-bottom:1rem;text-shadow:0 2px 8px rgba(0,0,0,.4)}
  .hero p{font-size:1.2rem;opacity:.9;max-width:600px;margin:0 auto 2rem}
  .hero .cta{display:inline-block;background:var(--coral);color:#fff;padding:.8rem 2rem;border-radius:30px;text-decoration:none;font-weight:700}
  .hero .cta:hover{background:#c44a28}
  .catch-banner{background:var(--sea);color:#fff;text-align:center;padding:.8rem 2rem;font-size:1rem}
  .catch-banner strong{color:#ffe066}
  section{padding:4rem 2rem;max-width:1000px;margin:0 auto}
  h2{font-size:1.9rem;color:var(--sea);margin-bottom:1.5rem;text-align:center}
  .menu-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:1.2rem}
  .menu-item{background:#fff;border-radius:10px;padding:1.2rem;border-top:4px solid var(--sea);box-shadow:0 2px 8px rgba(0,0,0,.06)}
  .menu-item h3{color:var(--sea);font-size:1rem;margin-bottom:.3rem}
  .menu-item p{font-size:.85rem;color:#556;margin-bottom:.5rem}
  .menu-item .price{font-weight:700;color:var(--coral)}
  .fresh{display:inline-block;background:#e8f6f9;color:var(--sea);font-size:.72rem;padding:.15rem .5rem;border-radius:10px;font-weight:700;margin-left:.3rem}
  .info-cards{display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:1.2rem}
  .info-card{text-align:center;padding:1.5rem;background:#fff;border-radius:10px;box-shadow:0 2px 8px rgba(0,0,0,.06)}
  .info-card .icon{font-size:2rem;margin-bottom:.5rem}
  .info-card h3{font-size:1rem;color:var(--sea);margin-bottom:.3rem}
  .info-card a{color:var(--sea);text-decoration:none}
  .form-wrap{background:#fff;border-radius:14px;padding:2rem;box-shadow:0 4px 16px rgba(0,0,0,.08);max-width:600px;margin:0 auto}
  .form-group{margin-bottom:1.2rem}
  label{display:block;font-size:.9rem;color:var(--dark);margin-bottom:.3rem;font-weight:600}
  input,select,textarea{width:100%;padding:.7rem 1rem;border:1px solid #ddd;border-radius:8px;font-size:.95rem;font-family:inherit}
  input:focus,select:focus,textarea:focus{outline:none;border-color:var(--sea)}
  .form-row{display:grid;grid-template-columns:1fr 1fr;gap:1rem}
  button[type=submit]{background:var(--sea);color:#fff;border:none;padding:.8rem 2rem;border-radius:30px;font-size:1rem;font-weight:700;cursor:pointer;width:100%}
  button[type=submit]:hover{background:#085570}
  footer{background:var(--dark);color:#acd;text-align:center;padding:2rem;font-size:.9rem}
  footer a{color:#ffe066;text-decoration:none}
  [data-lang=en] .el{display:none}
  [data-lang=el] .en{display:none}
  @media(max-width:600px){.hero h1{font-size:2rem}.form-row{grid-template-columns:1fr}nav .links{display:none}}
</style>
</head>
<body>
<nav>
  <a class="logo" href="/">← <span class="el">το Ψαροπούλι</span><span class="en">The Fish Place</span></a>
  <div class="links">
    <a href="#menu"><span class="el">Μενού</span><span class="en">Menu</span></a>
    <a href="#info"><span class="el">Πληροφορίες</span><span class="en">Info</span></a>
    <a href="#booking"><span class="el">Κράτηση</span><span class="en">Book</span></a>
  </div>
  <button class="lang-btn" onclick="toggleLang()">EN / ΕΛ</button>
</nav>

<div class="hero">
  <h1>🐟 <span class="el">το Ψαροπούλι</span><span class="en">The Fish Place</span></h1>
  <p class="el">Φρέσκα ψάρια απ' την αγορά κάθε πρωί — θαλασσινά που μυρίζουν θάλασσα</p>
  <p class="en">Fresh-from-market fish every morning — seafood that tastes like the sea</p>
  <a class="cta" href="#booking"><span class="el">Κλείσε τραπέζι</span><span class="en">Book a table</span></a>
</div>

<div class="catch-banner">
  🎣 <span class="el"><strong>Σημερινή σύλληψη:</strong> Λαβράκι, Τσιπούρα, Μύδια Θεσσαλονίκης</span>
  <span class="en"><strong>Today's catch:</strong> Sea bass, Gilt-head bream, Thessaloniki mussels</span>
</div>

<section id="menu">
  <h2><span class="el">Θαλασσινά &amp; Ψάρια</span><span class="en">Seafood &amp; Fish</span></h2>
  <div class="menu-grid">
    <div class="menu-item">
      <h3><span class="el">Λαβράκι σχάρας</span><span class="en">Grilled Sea Bass</span> <span class="fresh">FRESH</span></h3>
      <p class="el">Ολόκληρο, λαδολέμονο, ρίγανη</p><p class="en">Whole, olive oil &amp; lemon, oregano</p>
      <div class="price"><span class="el">τιμή / κιλό</span><span class="en">price / kg</span> 32 €</div>
    </div>
    <div class="menu-item">
      <h3><span class="el">Μύδια σαγανάκι</span><span class="en">Mussels saganaki</span> <span class="fresh">FRESH</span></h3>
      <p class="el">Σε σάλτσα ντομάτας με φέτα</p><p class="en">In tomato sauce with feta cheese</p>
      <div class="price">12 €</div>
    </div>
    <div class="menu-item">
      <h3><span class="el">Καλαμαράκια τηγανητά</span><span class="en">Fried Calamari</span></h3>
      <p class="el">Τραγανά, με σκορδαλιά</p><p class="en">Crispy rings, with garlic dip</p>
      <div class="price">9 €</div>
    </div>
    <div class="menu-item">
      <h3><span class="el">Γαρίδες σχάρας</span><span class="en">Grilled Prawns</span> <span class="fresh">FRESH</span></h3>
      <p class="el">Μεγάλες γαρίδες, βούτυρο, σκόρδο</p><p class="en">King prawns, butter &amp; garlic</p>
      <div class="price">18 €</div>
    </div>
    <div class="menu-item">
      <h3><span class="el">Ψαρόσουπα</span><span class="en">Fish Soup</span></h3>
      <p class="el">Παραδοσιακή κακαβιά</p><p class="en">Traditional kakavia fish stew</p>
      <div class="price">10 €</div>
    </div>
    <div class="menu-item">
      <h3><span class="el">Ταραμοσαλάτα</span><span class="en">Taramosalata</span></h3>
      <p class="el">Σπιτική, με φρεσκοψημένο ψωμί</p><p class="en">Homemade, with freshly baked bread</p>
      <div class="price">5 €</div>
    </div>
  </div>
</section>

<section id="info" style="background:var(--foam);padding:4rem 2rem;max-width:100%">
  <div style="max-width:1000px;margin:0 auto">
    <h2><span class="el">Πού θα μας βρείτε</span><span class="en">Where to find us</span></h2>
    <div class="info-cards">
      <div class="info-card">
        <div class="icon">📍</div>
        <h3><span class="el">Διεύθυνση</span><span class="en">Address</span></h3>
        <p><a href="https://maps.google.com/?q=ψαροταβέρνα+Αθήνα" target="_blank">
          <span class="el">Παραλία Φλοίσβου 22, Παλαιό Φάληρο</span>
          <span class="en">22 Floisvos Waterfront, Paleo Faliro</span>
        </a></p>
      </div>
      <div class="info-card">
        <div class="icon">📞</div>
        <h3><span class="el">Τηλέφωνο</span><span class="en">Phone</span></h3>
        <p><a href="tel:+302109000222">+30 210 900 0222</a></p>
      </div>
      <div class="info-card">
        <div class="icon">🕐</div>
        <h3><span class="el">Ώρες</span><span class="en">Hours</span></h3>
        <p class="el">Τρ–Κυρ 12:00–23:00</p>
        <p class="en">Tue–Sun 12:00–23:00</p>
      </div>
      <div class="info-card">
        <div class="icon">🚢</div>
        <h3><span class="el">Θέα θάλασσα</span><span class="en">Sea view</span></h3>
        <p class="el">Τραπέζια δίπλα στη θάλασσα</p>
        <p class="en">Tables right by the sea</p>
      </div>
    </div>
  </div>
</section>

<section id="booking" style="max-width:1000px;margin:0 auto;padding:4rem 2rem">
  <h2><span class="el">Κράτηση Τραπεζιού</span><span class="en">Table Booking</span></h2>
  <div class="form-wrap">
    <form action="https://formsubmit.co/demo@example.com" method="POST">
      <input type="hidden" name="_subject" value="Νέα κράτηση - Ψαροπούλι">
      <input type="hidden" name="_captcha" value="false">
      <div class="form-row">
        <div class="form-group">
          <label><span class="el">Ονοματεπώνυμο</span><span class="en">Full name</span></label>
          <input type="text" name="name" required>
        </div>
        <div class="form-group">
          <label><span class="el">Τηλέφωνο</span><span class="en">Phone</span></label>
          <input type="tel" name="phone" required>
        </div>
      </div>
      <div class="form-row">
        <div class="form-group">
          <label><span class="el">Ημερομηνία</span><span class="en">Date</span></label>
          <input type="date" name="date" required>
        </div>
        <div class="form-group">
          <label><span class="el">Ώρα</span><span class="en">Time</span></label>
          <select name="time">
            <option>12:00</option><option>12:30</option><option>13:00</option>
            <option>13:30</option><option>14:00</option><option>19:00</option>
            <option>19:30</option><option>20:00</option><option>20:30</option><option>21:00</option>
          </select>
        </div>
      </div>
      <div class="form-group">
        <label><span class="el">Αριθμός ατόμων</span><span class="en">Number of guests</span></label>
        <select name="guests">
          <option>2</option><option>3</option><option>4</option><option>5</option>
          <option>6</option><option>7-10</option><option>10+</option>
        </select>
      </div>
      <div class="form-group">
        <label><span class="el">Θέλετε τραπέζι με θέα;</span><span class="en">Sea view table preference?</span></label>
        <select name="seaview">
          <option value="yes"><span class="el">Ναι, παρακαλώ</span><span class="en">Yes please</span></option>
          <option value="any"><span class="el">Δεν με πειράζει</span><span class="en">No preference</span></option>
        </select>
      </div>
      <button type="submit"><span class="el">Αποστολή Κράτησης</span><span class="en">Send Booking</span></button>
    </form>
  </div>
</section>

<footer>
  <p>© 2025 το Ψαροπούλι &nbsp;|&nbsp; <a href="tel:+302109000222">+30 210 900 0222</a> &nbsp;|&nbsp;
  <a href="https://maps.google.com/?q=ψαροταβέρνα+Αθήνα" target="_blank">Google Maps</a></p>
  <p style="margin-top:.5rem;color:#456;font-size:.8rem">Demo site by <a href="/">KP Demo Sites</a></p>
</footer>
<script>function toggleLang(){var h=document.documentElement;h.dataset.lang=h.dataset.lang==='el'?'en':'el'}</script>
</body>
</html>
ENDHTML

# ── 8. Μυλοπόταμος ────────────────────────────────────────────────────────────
cat > "$PUBLIC_DIR/milopotamos/index.html" << 'ENDHTML'
<!DOCTYPE html>
<html lang="el" data-lang="el">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>ο Μυλοπόταμος — Παραδοσιακός Φούρνος</title>
<style>
  *{box-sizing:border-box;margin:0;padding:0}
  :root{--wheat:#c8821a;--cream:#fdf6e3;--brown:#3b2008;--green:#4a7c40;--light:#fffdf7}
  body{font-family:'Segoe UI',sans-serif;background:var(--light);color:var(--brown)}
  nav{background:var(--brown);padding:1rem 2rem;display:flex;justify-content:space-between;align-items:center;position:sticky;top:0;z-index:100}
  nav .logo{color:#fde;font-size:1.4rem;font-weight:700;text-decoration:none}
  nav .links a{color:#dca;text-decoration:none;margin-left:1.2rem;font-size:.95rem}
  nav .links a:hover{color:#fff}
  .lang-btn{background:rgba(255,255,255,.15);border:1px solid rgba(255,255,255,.3);color:#fde;padding:.3rem .8rem;border-radius:20px;cursor:pointer;font-size:.85rem}
  .hero{background:linear-gradient(135deg,var(--wheat) 0%,#8a5210 100%);color:#fff;text-align:center;padding:5rem 2rem}
  .hero h1{font-size:3rem;margin-bottom:1rem;text-shadow:0 2px 8px rgba(0,0,0,.3)}
  .hero p{font-size:1.2rem;opacity:.9;max-width:600px;margin:0 auto 2rem}
  .hero .cta{display:inline-block;background:var(--cream);color:var(--brown);padding:.8rem 2rem;border-radius:30px;text-decoration:none;font-weight:700}
  .hero .cta:hover{background:#fff}
  .fresh-banner{background:var(--green);color:#fff;text-align:center;padding:.8rem 2rem;font-size:1rem}
  .fresh-banner strong{color:#cfe8a0}
  section{padding:4rem 2rem;max-width:1000px;margin:0 auto}
  h2{font-size:1.9rem;color:var(--wheat);margin-bottom:1.5rem;text-align:center}
  .products-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:1.2rem}
  .product{background:#fff;border-radius:10px;padding:1.2rem;box-shadow:0 2px 8px rgba(0,0,0,.07);border-bottom:3px solid var(--wheat)}
  .product .emoji{font-size:2rem;margin-bottom:.5rem}
  .product h3{color:var(--brown);font-size:.95rem;font-weight:700;margin-bottom:.3rem}
  .product p{font-size:.82rem;color:#776;margin-bottom:.5rem}
  .product .price{font-weight:700;color:var(--wheat)}
  .order-badge{display:inline-block;background:#e8f5e2;color:var(--green);font-size:.72rem;padding:.15rem .5rem;border-radius:10px;font-weight:700;margin-left:.3rem}
  .info-cards{display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:1.2rem}
  .info-card{text-align:center;padding:1.5rem;background:#fff;border-radius:10px;box-shadow:0 2px 8px rgba(0,0,0,.06)}
  .info-card .icon{font-size:2rem;margin-bottom:.5rem}
  .info-card h3{font-size:1rem;color:var(--wheat);margin-bottom:.3rem}
  .info-card a{color:var(--wheat);text-decoration:none}
  .form-wrap{background:#fff;border-radius:14px;padding:2rem;box-shadow:0 4px 16px rgba(0,0,0,.08);max-width:600px;margin:0 auto}
  .form-group{margin-bottom:1.2rem}
  label{display:block;font-size:.9rem;color:var(--brown);margin-bottom:.3rem;font-weight:600}
  input,select,textarea{width:100%;padding:.7rem 1rem;border:1px solid #ddd;border-radius:8px;font-size:.95rem;font-family:inherit}
  input:focus,select:focus,textarea:focus{outline:none;border-color:var(--wheat)}
  .form-row{display:grid;grid-template-columns:1fr 1fr;gap:1rem}
  button[type=submit]{background:var(--wheat);color:#fff;border:none;padding:.8rem 2rem;border-radius:30px;font-size:1rem;font-weight:700;cursor:pointer;width:100%}
  button[type=submit]:hover{background:#a66a12}
  footer{background:var(--brown);color:#dca;text-align:center;padding:2rem;font-size:.9rem}
  footer a{color:#f5c842;text-decoration:none}
  [data-lang=en] .el{display:none}
  [data-lang=el] .en{display:none}
  @media(max-width:600px){.hero h1{font-size:2rem}.form-row{grid-template-columns:1fr}nav .links{display:none}}
</style>
</head>
<body>
<nav>
  <a class="logo" href="/">← <span class="el">ο Μυλοπόταμος</span><span class="en">O Milopotamos</span></a>
  <div class="links">
    <a href="#products"><span class="el">Προϊόντα</span><span class="en">Products</span></a>
    <a href="#info"><span class="el">Πληροφορίες</span><span class="en">Info</span></a>
    <a href="#order"><span class="el">Παραγγελία</span><span class="en">Order</span></a>
  </div>
  <button class="lang-btn" onclick="toggleLang()">EN / ΕΛ</button>
</nav>

<div class="hero">
  <h1>🍞 <span class="el">ο Μυλοπόταμος</span><span class="en">O Milopotamos</span></h1>
  <p class="el">Παραδοσιακός φούρνος από το 1962 — ψωμί που μυρίζει αγάπη</p>
  <p class="en">Traditional bakery since 1962 — bread baked with love</p>
  <a class="cta" href="#order"><span class="el">Παράγγειλε online</span><span class="en">Order online</span></a>
</div>

<div class="fresh-banner">
  🌾 <span class="el"><strong>Φρεσκοψημένα σήμερα:</strong> Σταρένιο, Σικάλεως, Τσουρέκι, Κουλούρι Θεσσαλονίκης</span>
  <span class="en"><strong>Fresh today:</strong> Wheat loaf, Rye bread, Sweet brioche, Thessaloniki sesame ring</span>
</div>

<section id="products">
  <h2><span class="el">Τα Προϊόντα μας</span><span class="en">Our Products</span></h2>
  <div class="products-grid">
    <div class="product">
      <div class="emoji">🍞</div>
      <h3><span class="el">Χωριάτικο ψωμί</span><span class="en">Village bread</span></h3>
      <p class="el">Σταρένιο, χειροποίητο, 1 κιλό</p><p class="en">Wheat, handmade, 1kg loaf</p>
      <div class="price">3,50 €</div>
    </div>
    <div class="product">
      <div class="emoji">🥐</div>
      <h3><span class="el">Κρουασάν βουτύρου</span><span class="en">Butter croissant</span></h3>
      <p class="el">Τριπλής βούτυρου, τραγανό</p><p class="en">Triple butter, flaky &amp; crispy</p>
      <div class="price">2,20 €</div>
    </div>
    <div class="product">
      <div class="emoji">🥧</div>
      <h3><span class="el">Τυρόπιτα</span><span class="en">Cheese pie</span></h3>
      <p class="el">Φέτα &amp; τριμμένο τυρί, χειροποίητη</p><p class="en">Feta &amp; mixed cheese, handmade</p>
      <div class="price">2,80 €</div>
    </div>
    <div class="product">
      <div class="emoji">🍫</div>
      <h3><span class="el">Σοκολατένιο τσουρέκι</span><span class="en">Chocolate brioche</span></h3>
      <p class="el">Τριπλό τσουρέκι με σοκολάτα</p><p class="en">Triple-weave brioche with chocolate</p>
      <div class="price">5,50 €</div>
    </div>
    <div class="product">
      <div class="emoji">🫓</div>
      <h3><span class="el">Κουλούρι Θεσσαλονίκης</span><span class="en">Sesame ring</span></h3>
      <p class="el">Κλασικό, πλούσιο σε σουσάμι</p><p class="en">Classic, generously coated in sesame</p>
      <div class="price">0,80 €</div>
    </div>
    <div class="product">
      <div class="emoji">🎂</div>
      <h3><span class="el">Κέικ παραγγελία</span><span class="en">Custom cake</span> <span class="order-badge">ΠΡΟΠΑΡ.</span></h3>
      <p class="el">Κέικ &amp; τούρτες για κάθε περίσταση</p><p class="en">Cakes &amp; tarts for any occasion</p>
      <div class="price"><span class="el">από</span><span class="en">from</span> 25 €</div>
    </div>
  </div>
</section>

<section id="info" style="background:var(--cream);padding:4rem 2rem;max-width:100%">
  <div style="max-width:1000px;margin:0 auto">
    <h2><span class="el">Πού θα μας βρείτε</span><span class="en">Find Us</span></h2>
    <div class="info-cards">
      <div class="info-card">
        <div class="icon">📍</div>
        <h3><span class="el">Διεύθυνση</span><span class="en">Address</span></h3>
        <p><a href="https://maps.google.com/?q=φούρνος+παραδοσιακός+Αθήνα" target="_blank">
          <span class="el">Αγίου Νικολάου 14, Ηράκλειο Αττικής</span>
          <span class="en">14 Agios Nikolaos St, Iraklio Attica</span>
        </a></p>
      </div>
      <div class="info-card">
        <div class="icon">📞</div>
        <h3><span class="el">Τηλέφωνο</span><span class="en">Phone</span></h3>
        <p><a href="tel:+302109000333">+30 210 900 0333</a></p>
      </div>
      <div class="info-card">
        <div class="icon">🕐</div>
        <h3><span class="el">Ώρες</span><span class="en">Hours</span></h3>
        <p class="el">Καθημερινά 06:30 – 20:00</p>
        <p class="en">Daily 06:30 – 20:00</p>
      </div>
      <div class="info-card">
        <div class="icon">🚚</div>
        <h3><span class="el">Διανομή</span><span class="en">Delivery</span></h3>
        <p class="el">Δωρεάν άνω των 15 €</p>
        <p class="en">Free delivery over €15</p>
      </div>
    </div>
  </div>
</section>

<section id="order" style="max-width:1000px;margin:0 auto;padding:4rem 2rem">
  <h2><span class="el">Παράγγειλε Online</span><span class="en">Order Online</span></h2>
  <div class="form-wrap">
    <form action="https://formsubmit.co/demo@example.com" method="POST">
      <input type="hidden" name="_subject" value="Νέα παραγγελία - Μυλοπόταμος">
      <input type="hidden" name="_captcha" value="false">
      <div class="form-row">
        <div class="form-group">
          <label><span class="el">Όνομα</span><span class="en">Name</span></label>
          <input type="text" name="name" required>
        </div>
        <div class="form-group">
          <label><span class="el">Τηλέφωνο</span><span class="en">Phone</span></label>
          <input type="tel" name="phone" required>
        </div>
      </div>
      <div class="form-group">
        <label><span class="el">Διεύθυνση παράδοσης</span><span class="en">Delivery address</span></label>
        <input type="text" name="address" required>
      </div>
      <div class="form-row">
        <div class="form-group">
          <label><span class="el">Ημερομηνία παράδοσης</span><span class="en">Delivery date</span></label>
          <input type="date" name="date" required>
        </div>
        <div class="form-group">
          <label><span class="el">Ώρα παράδοσης</span><span class="en">Delivery time</span></label>
          <select name="time">
            <option>07:00–09:00</option><option>09:00–11:00</option>
            <option>11:00–13:00</option><option>13:00–15:00</option>
            <option>15:00–17:00</option><option>17:00–20:00</option>
          </select>
        </div>
      </div>
      <div class="form-group">
        <label><span class="el">Προϊόντα &amp; ποσότητες</span><span class="en">Products &amp; quantities</span></label>
        <textarea name="order" rows="4" required placeholder="π.χ. 2× χωριάτικο ψωμί, 4× τυρόπιτα, 1× τσουρέκι..."></textarea>
      </div>
      <button type="submit"><span class="el">Αποστολή Παραγγελίας</span><span class="en">Send Order</span></button>
    </form>
  </div>
</section>

<footer>
  <p>© 2025 ο Μυλοπόταμος &nbsp;|&nbsp; <a href="tel:+302109000333">+30 210 900 0333</a> &nbsp;|&nbsp;
  <a href="https://maps.google.com/?q=φούρνος+Αθήνα" target="_blank">Google Maps</a></p>
  <p style="margin-top:.5rem;color:#876;font-size:.8rem">Demo site by <a href="/">KP Demo Sites</a></p>
</footer>
<script>function toggleLang(){var h=document.documentElement;h.dataset.lang=h.dataset.lang==='el'?'en':'el'}</script>
</body>
</html>
ENDHTML

# ── 9. Outreach emails ─────────────────────────────────────────────────────────
cat > "$DEPLOY_DIR/emails/outreach-emails.md" << 'ENDEMAIL'
# Outreach Emails — KP Demo Sites

---

## 1. Το Βουλιώτικο

**Θέμα:** Δωρεάν demo website για το Βουλιώτικο — ζωντανό τώρα!

Καλησπέρα,

Είμαι ο Κωνσταντίνος Παργινός, web developer με εξειδίκευση σε websites για εστιατόρια και επιχειρήσεις εστίασης.

Δημιούργησα ένα **δωρεάν demo** για το Βουλιώτικο — ένα σύγχρονο, responsive website με:
✅ Online κρατήσεις τραπεζιού
✅ Ψηφιακό μενού
✅ Δίγλωσση υποστήριξη (Ελληνικά / Αγγλικά) για τουρίστες
✅ Κουμπί κλήσης & Google Maps

Μπορείτε να το δείτε ζωντανά εδώ: [URL]

Το κόστος μετατροπής σε πλήρη ιστοσελίδα ξεκινά από **€350** (εφάπαξ) + €15/μήνα hosting.

Θα χαρώ να το συζητήσουμε. Καλέστε με ή απαντήστε σε αυτό το email.

Με εκτίμηση,
Κωνσταντίνος Παργινός
📱 +30 697 XXX XXXX

---

## 2. το Ψαροπούλι

**Θέμα:** Δωρεάν demo website για την ψαροταβέρνα σας

Καλησπέρα,

Δημιούργησα ένα **δωρεάν demo website** ειδικά για την ψαροταβέρνα σας, με:
✅ «Σημερινή σύλληψη» — ενότητα που ανανεώνεται εύκολα
✅ Online κράτηση τραπεζιού (με επιλογή θέας θάλασσα)
✅ Responsive design για κινητά
✅ Αγγλική έκδοση για ξένους επισκέπτες

Δείτε το εδώ: [URL]

Πακέτα από **€350** εφάπαξ. Δεν χρειάζεστε τεχνικές γνώσεις — αναλαμβάνω τα πάντα.

Κωνσταντίνος Παργινός | Web Developer
📱 +30 697 XXX XXXX

---

## 3. ο Μυλοπόταμος

**Θέμα:** Δωρεάν demo για τον φούρνο σας — με online παραγγελίες!

Καλησπέρα,

Ξέρω ότι ο φούρνος σας έχει πολλούς πιστούς πελάτες. Φανταστείτε να μπορούν να **παραγγέλνουν online** πριν περάσουν να παραλάβουν!

Δημιούργησα ένα demo website για σας με:
✅ Online φόρμα παραγγελίας με επιλογή ωραρίου παράδοσης
✅ Ψηφιακό τιμοκατάλογο προϊόντων
✅ Ανακοίνωση «φρεσκοψημένων σήμερα»
✅ Κινητό-friendly design

Δείτε το: [URL]

Έτοιμο website από **€300** εφάπαξ. Χωρίς μηνιαίες αμοιβές τον πρώτο χρόνο.

Κωνσταντίνος Παργινός
📱 +30 697 XXX XXXX
ENDEMAIL

# ── 10. Firebase project creation & deploy ────────────────────────────────────
cd "$DEPLOY_DIR"

echo ""
echo "▶ Checking Firebase login status..."
if ! firebase login:list 2>/dev/null | grep -q "@"; then
  echo "  Not logged in. Starting login..."
  firebase login --no-localhost
fi

echo "▶ Creating Firebase project: $PROJECT_ID ..."
CREATE_OUTPUT=$(firebase projects:create "$PROJECT_ID" --display-name "KP Demo Sites" 2>&1) && {
  echo "  ✓ Project created"
} || {
  echo "  ℹ $CREATE_OUTPUT"
  echo "  Continuing — project may already exist or creation failed (quota/billing)"
  echo "  Attempting to use project: $PROJECT_ID"
}

echo "▶ Deploying to Firebase Hosting..."
firebase deploy --only hosting --project "$PROJECT_ID"

HOSTING_URL="https://$PROJECT_ID.web.app"

echo ""
echo "================================================"
echo "  ✅ DEPLOYMENT COMPLETE"
echo "================================================"
echo ""
echo "  Live URLs:"
echo "  🏠  Hub:          $HOSTING_URL"
echo "  🍷  Βουλιώτικο:  $HOSTING_URL/vouliotiko"
echo "  🐟  Ψαροπούλι:   $HOSTING_URL/psaropouli"
echo "  🍞  Μυλοπόταμος: $HOSTING_URL/milopotamos"
echo ""
echo "  Outreach emails: $DEPLOY_DIR/emails/outreach-emails.md"
echo "================================================"
