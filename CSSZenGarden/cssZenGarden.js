var designs = [
	{ id: 221, name: "Mid Century Modern", author: "Andrew Lohman", description: "Clean geometric shapes and warm earth tones inspired by 1950s American design." },
	{ id: 220, name: "Garments", author: "Dan Mall", description: "Editorial fashion-magazine aesthetic where oversized typography is the entire visual statement." },
	{ id: 219, name: "Steel", author: "Steffen Knoeller", description: "Riveted metal and brushed steel surfaces faked entirely with CSS gradients — no images at all." },
	{ id: 218, name: "Apothecary", author: "Trent Walton", description: "Victorian pharmaceutical labels rendered in dense serif type on aged parchment tones." },
	{ id: 217, name: "Screen Filler", author: "Elliot Jay Stocks", description: "Typography at massive scale bleeds edge-to-edge, treating the viewport as a billboard." },
	{ id: 216, name: "Fountain Kiss", author: "Jeremy Carlson", description: "Flowing organic shapes and a romantic soft-focus palette make it feel hand-painted rather than coded." },
	{ id: 215, name: "A Robot Named Jimmy", author: "meltmedia", description: "A fully animated robot character is woven into the layout, making it feel more like a game screen than a web page." },
	{ id: 214, name: "Verde Moderna", author: "Dave Shea", description: "Dave Shea's own submission — Art Nouveau ornamental borders and deep forest green set the benchmark others respond to." },
	{ id: 213, name: "Under the Sea!", author: "Eric Stoltz", description: "Layered coral, fish, and bubbles create CSS-positioned parallax depth beneath the text." },
	{ id: 212, name: "Make 'em Proud", author: "McAghon & Reifsnyder", description: "Bold Americana sports-team energy with diagonal accents and a red-white-blue palette." },
	{ id: 211, name: "Orchid Beauty", author: "Kevin Addison", description: "Delicate orchid petals and soft pink-lavender tones woven into the layout structure itself." },
	{ id: 210, name: "Oceanscape", author: "Justin Gray", description: "A cinematic ocean horizon stretches across the top, giving the whole page a sense of vast calm." },
	{ id: 209, name: "CSS Co., Ltd.", author: "Benjamin Klemm", description: "Japanese corporate design — structured grid, restrained palette, and formal hierarchy like an annual report." },
	{ id: 208, name: "Sakura", author: "Tatsuya Uchida", description: "Falling cherry blossoms and ink-wash tones express wabi-sabi minimalism in a deeply cultural rather than trendy way." },
	{ id: 207, name: "Kyoto Forest", author: "John Politowski", description: "Tall bamboo imagery and vertical rhythms make the page scroll like an unrolling hanging scroll." },
	{ id: 206, name: "A Walk in the Garden", author: "Simon Van Hauwermeiren", description: "Hand-illustrated garden paths and plants give it the warmth of a children's picture book." },
	{ id: 205, name: "spring360", author: "Rene Hornig", description: "The only design here that abandons vertical scrolling entirely, arranging content radially around a central point." },
	{ id: 204, name: "Withering Beauty", author: "William Duffy", description: "Gothic decay — dark backgrounds, aged textures, and wilting botanicals create a deliberate memento mori mood." },
	{ id: 203, name: "Tiny Blue", author: "Timo Virtanen", description: "A spare, minimal design built around a single small blue accent that anchors the entire composition." },
	{ id: 202, name: "Retro Theater", author: "Eric Rogé", description: "Heavy curtain motifs and vintage marquee typography evoke the glamour of a 1940s movie palace." },
	{ id: 201, name: "Lily Pond", author: "Rose Thorogood", description: "Soft reflective water imagery and floating lily pads create a tranquil, unhurried atmosphere." },
	{ id: 200, name: "Icicle Outback", author: "Timo Virtanen", description: "An unlikely collision of frozen ice textures and arid Australian landscape colors." },
	{ id: 199, name: "CSS ZEN ARMY", author: "Carl Desmond", description: "Military camouflage patterns and stencil typography turn the Zen Garden into a boot camp." },
	{ id: 198, name: "The Original", author: "Joachim Shotter", description: "A deliberately retro tribute to early-2000s web design, embracing the aesthetic of the era rather than transcending it." },
	{ id: 197, name: "Floral Touch", author: "Jadas Jimmy", description: "Delicate floral watercolor elements drift across a clean white background with restrained elegance." },
	{ id: 196, name: "Elegance in Simplicity", author: "Mani Sheriar", description: "The title is the brief — nothing decorative, every element earns its place through pure typographic refinement." },
	{ id: 195, name: "Dazzling Beauty", author: "Deny Sri Supriyono", description: "Rich jewel tones and ornamental flourishes create an almost overwhelming sense of decorative abundance." },
	{ id: 194, name: "Dark Rose", author: "Rose Fu", description: "Deep crimson and shadowed black make the rose motif feel gothic rather than romantic." },
	{ id: 193, name: "Leggo My Ego", author: "Jon Tan", description: "Playful confidence in every typographic choice — bold, irreverent, and unapologetically self-assured." },
	{ id: 192, name: "LuGoZee", author: "Viallon Pierre-Antoine", description: "Abstract shapes and an experimental French graphic design sensibility push the layout into art territory." },
	{ id: 191, name: "The Diary", author: "Alexander Shabuniewicz", description: "Handwritten letterforms and personal journal textures make it feel like reading someone's private notebook." },
	{ id: 190, name: "Lonely Flower", author: "Mitja Ribic", description: "A single isolated bloom against stark negative space — melancholy rendered through restraint." },
	{ id: 189, name: "Mozart", author: "Andrew Brundle", description: "Baroque musical ornaments and formal 18th-century composition nod to the composer's structural perfection." },
	{ id: 188, name: "Organica Creativa", author: "Eduardo Cesario", description: "Earthy organic textures and hand-drawn curves make it feel grown rather than designed." },
	{ id: 187, name: "Wilderness", author: "Aadesh Mistry", description: "Untamed natural forms spill beyond grid constraints, evoking landscape that refuses to be domesticated." },
	{ id: 186, name: "Faded Flowers", author: "Mani Sheriar", description: "Washed-out botanical imagery and muted tones give it the faded elegance of a pressed flower collection." },
	{ id: 185, name: "Manhattan Edition", author: "José Tomás Tocino García", description: "Urban grid systems and New York City energy channeled into tight typographic columns." },
	{ id: 184, name: "Peace Of Mind", author: "Carlos Varela", description: "Soft gradients and generous white space create a genuinely calming, meditative browsing experience." },
	{ id: 182, name: "45 RPM", author: "Thomas Michaud", description: "Vinyl record culture — turntable imagery, groove textures, and the warm nostalgia of analog music." },
	{ id: 181, name: "Pretty in Pink", author: "Jordi Romkema", description: "Unabashedly feminine — all pink, all the time, leaning into sweetness rather than subverting it." },
	{ id: 180, name: "Vertigo", author: "Antonio Cella", description: "Spiral and concentric motifs induce a deliberate sense of visual disorientation." },
	{ id: 179, name: "Vin Rouge", author: "Thorsten Bopp", description: "Deep burgundy tones and French typographic elegance evoke a candlelit wine cellar." },
	{ id: 178, name: "Pinups", author: "Emiliano Pennisi", description: "1950s pin-up illustration style — bold outlines, flat color fills, and a knowing retro wink." },
	{ id: 177, name: "Zen City Morning", author: "Ray Henry", description: "An urban skyline at dawn rendered in cool blues and grays, bringing the city into the garden." },
	{ id: 176, name: "Kelmscott", author: "Bronwen Hodgkinson", description: "Directly inspired by William Morris's Kelmscott Press — dense decorative borders and medieval revival typography." },
	{ id: 175, name: "Business Style", author: "Gunta Klavina", description: "Clean corporate professionalism — the Zen Garden reimagined as a polished business presentation." },
	{ id: 174, name: "Simple", author: "Shawn Chin", description: "An exercise in reduction — how little can you add and still create something worth looking at." },
	{ id: 173, name: "Red Stars", author: "Shafiq Rizwan", description: "Stark red star motifs against dark backgrounds carry a bold graphic poster quality." },
	{ id: 172, name: "blackcomb*75", author: "Bryan Carichner", description: "Ski mountain culture filtered through 1970s sport graphic design — angular, athletic, and cold." },
	{ id: 171, name: "Shaolin Yokobue", author: "Javier Cabrera", description: "Martial arts discipline meets Japanese flute imagery in an unexpectedly meditative design." },
	{ id: 170, name: "Love Is In The Air", author: "Nele Goetz", description: "Floating hearts and pastel clouds treat the page as a Valentine's Day card come to life." },
	{ id: 169, name: "Greece Remembrance", author: "Pierre-Leo Bourbonnais", description: "Aegean blue and white, classical column motifs, and a bittersweet reverence for ancient beauty." },
	{ id: 168, name: "Hengarden", author: "Mr. Khmerang", description: "Southeast Asian textile patterns and warm ochre tones root it firmly in a specific cultural geography." },
	{ id: 167, name: "Hoops - Tournament Edition", author: "David Marshall Jr.", description: "Basketball court graphics and tournament bracket energy bring arena sports into the garden." },
	{ id: 166, name: "Obsequience", author: "Pierce Gleeson", description: "Somber and formal, as if the page itself is bowing — muted tones and deliberate, deferential spacing." },
	{ id: 165, name: "Red Paper", author: "Rob Soule", description: "Origami folding cues and red paper textures create a tactile, handcrafted Japanese aesthetic." },
	{ id: 164, name: "Chien", author: "Alex Miller", description: "French for 'dog' — playful canine motifs rendered with a loose, sketchy illustration style." },
	{ id: 163, name: "Like the Sea", author: "Lars Daum", description: "Wave rhythms and shifting blue-green tones make the page feel like it breathes with the tide." },
	{ id: 162, name: "Angelus", author: "Vladimir Lukic", description: "Religious iconography and bell-hour solemnity rendered in gold and shadow." },
	{ id: 161, name: "Zenfandel", author: "Nicholas Rougeux", description: "Wine culture meets Zen — deep purple tones and the contemplative patience of a good vintage." },
	{ id: 160, name: "Daruma", author: "Stuart Cruickshank", description: "The iconic Japanese wishing doll rendered in bold red and black with folk art directness." },
	{ id: 159, name: "Berry Flavour", author: "Maren Becker", description: "Rich berry purples and bruised reds create something sweet, tart, and distinctly edible-feeling." },
	{ id: 158, name: "a Simple Sunrise", author: "Rob Soule", description: "Warm horizon gradients and quiet morning light captured in a few understated CSS layers." },
	{ id: 157, name: "Bugs", author: "Zohar Arad", description: "Entomological illustration style — detailed insect forms treated with scientific precision and dark humor." },
	{ id: 156, name: "Table Layout Assassination!", author: "Marko Krsul & Marko Dugonjic", description: "A manifesto disguised as a design — the title says it all about the battle CSS was fighting in 2003." },
	{ id: 155, name: "November", author: "Alen Grakalic", description: "The color palette of a cold, grey autumn month — bare branches and fading light." },
	{ id: 154, name: "Butterfly Effect", author: "Kevin Linkous", description: "Delicate wing patterns and soft iridescence suggest the fragile beauty of transformation." },
	{ id: 153, name: "Moss", author: "Mani Sheriar", description: "Dense green textures and forest floor imagery make it feel genuinely damp and botanical." },
	{ id: 152, name: "Subway Dream", author: "Pablo Caro", description: "Underground transit system graphics and tile mosaic patterns bring the city underground." },
	{ id: 151, name: "Contempo Finery", author: "Ro London", description: "Contemporary luxury fashion aesthetic — refined, tasteful, and expensively understated." },
	{ id: 150, name: "By The Pier", author: "Peter Ong", description: "Salt air and weathered timber — the nostalgic texture of a seaside boardwalk in summer." },
	{ id: 149, name: "Uncultivated", author: "Mario Carboni", description: "Deliberately rough, unpolished, and wild — rejecting refinement as a design philosophy." },
	{ id: 148, name: "Museum", author: "Samuel Marin", description: "Gallery-white walls and curatorial spacing give every element the weight of an exhibit." },
	{ id: 147, name: "Attitude", author: "Stephane Moens", description: "Bold, confrontational typography that leans forward as if daring you to look away." },
	{ id: 146, name: "Urban", author: "Matt Kim & Nicole", description: "Street-level city textures — concrete, signage, and the honest grit of urban surfaces." },
	{ id: 145, name: "Paravion", author: "Emiliano Pennisi", description: "Vintage aviation graphics and airmail letterhead aesthetics take the page airborne." },
	{ id: 144, name: "Verdure", author: "Lim Yuan Qing", description: "Lush layered greens in every shade from lime to forest, celebrating pure botanical abundance." },
	{ id: 143, name: "Pixelisation", author: "Lim Yuan Qing", description: "Deliberately pixelated forms celebrate the low-resolution aesthetic of early computer graphics." },
	{ id: 142, name: "Invasion of the Body Switchers", author: "Andy Clarke", description: "Sci-fi horror B-movie poster aesthetics with a pointed commentary on table-based layout practices." },
	{ id: 141, name: "Golden Cut", author: "Petr Stanicek", description: "The golden ratio applied with mathematical rigor — proportion as the primary design tool." },
	{ id: 140, name: "The Hall", author: "Michael Simmons", description: "Architectural grandeur — vaulted ceilings and receding perspective make the page feel monumental." },
	{ id: 139, name: "Neat & Tidy", author: "Oli Dale", description: "Crisp, organized, and satisfying — everything in its place like a freshly made bed." },
	{ id: 138, name: "Cube Garden", author: "Masanori Kawachi", description: "Three-dimensional cubic forms rendered in CSS create an isometric garden of geometric precision." },
	{ id: 137, name: "DJ Style", author: "Ramon Bispo", description: "Turntable culture and club graphic design — all energy, contrast, and late-night momentum." },
	{ id: 136, name: "The Final Ending", author: "Ray Henry", description: "Cinematic closing credits energy — the feeling of a story finishing with measured solemnity." },
	{ id: 135, name: "contemporary nouveau", author: "David Hellsing", description: "Art Nouveau organic forms filtered through a contemporary minimalist sensibility." },
	{ id: 134, name: "El Collar de Tomas", author: "Maria Stultz", description: "A Spanish-language design bringing Latin American craft traditions and warm folk art colors." },
	{ id: 133, name: "OrderedZen", author: "Steve Smith", description: "The paradox of the title made visible — strict grid order achieving a genuinely calm, zen quality." },
	{ id: 132, name: "Bonsai", author: "Martin Plazotta", description: "The patient art of bonsai — small, deliberate, shaped over time into something quietly extraordinary." },
	{ id: 131, name: "Type Thing", author: "Michal Mokrzycki", description: "Typography as pure visual material — letterforms treated as shapes, not just vessels for words." },
	{ id: 130, name: "Pseudo Sahara", author: "John Barrick", description: "Desert sand textures and heat-haze colors evoke a vast, arid landscape baking in the sun." },
	{ id: 129, name: "Geocities 1996", author: "Bruce Lawson", description: "A loving parody of early web aesthetics — tiling backgrounds, web-safe colors, and gleeful bad taste." },
	{ id: 128, name: "Dragen", author: "Matthew Buchanan", description: "Scandinavian dragon mythology rendered with fierce Norse knotwork and dramatic dark tones." },
	{ id: 127, name: "Vivacity", author: "Sofiane Toudji", description: "Bursting with saturated color and kinetic energy — everything vibrates at a slightly higher frequency." },
	{ id: 126, name: "C-Note", author: "Brian Williams", description: "Currency aesthetics and engraving-style typography treat the page like legal tender." },
	{ id: 125, name: "Beccah", author: "Chris Morrell", description: "Warmly personal and handcrafted in feeling, as though designed specifically for someone named Beccah." },
	{ id: 124, name: "Teatime", author: "Michaela Maria Sampl", description: "British afternoon tea culture — floral china patterns, soft creams, and the ritual of the kettle." },
	{ id: 123, name: "Skyroots", author: "Axel Hebenstreit", description: "Trees growing upward into sky and downward into earth simultaneously, roots and clouds sharing space." },
	{ id: 122, name: "Centerfold", author: "John Oxton", description: "Magazine centerfold layout sensibility — the page as the main attraction, not a container." },
	{ id: 121, name: "60's Lifestyle", author: "Emiliano Pennisi", description: "Mod patterns, op-art geometry, and the Pop Art palette of Swinging London." },
	{ id: 120, name: "Medioevo", author: "Emiliano Pennisi", description: "Medieval manuscript illumination — ornate initials, dark vellum tones, and scriptorum patience." },
	{ id: 119, name: "Pleasant Day", author: "Kyle Jones", description: "Straightforwardly cheerful — clean lines, friendly colors, and the uncomplicated pleasure of a nice afternoon." },
	{ id: 118, name: "Some Leafs", author: "Michael Tupy", description: "Autumn foliage rendered with a quiet attention to the specific beauty of individual leaves." },
	{ id: 117, name: "Brushwood", author: "Katrin Zieger", description: "Tangled brushwood and bramble textures create a wild, overgrown hedgerow atmosphere." },
	{ id: 116, name: "Ragged", author: "Jose Florido", description: "Torn paper edges and rough textures celebrate imperfection as an intentional aesthetic choice." },
	{ id: 115, name: "Burnt Offering", author: "Jonny Blair", description: "Charred edges and ember-glow colors as if the page itself has been held over a flame." },
	{ id: 114, name: "Salvage Yard", author: "Justin Peters", description: "Industrial salvage aesthetics — rust, corrugated metal, and the rough poetry of discarded things." },
	{ id: 113, name: "Switch On", author: "Michael Fasani", description: "Electronics and circuitry aesthetics with the clean precision of a well-designed control panel." },
	{ id: 112, name: "Mountain Resort", author: "Jordi Romkema", description: "Alpine ski resort branding — clean whites, bold type, and the crisp air of high altitude." },
	{ id: 111, name: "Grüener Entwurf", author: "Hannah F. Liesong", description: "German green design — ecological, precise, and quietly idealistic in its environmental palette." },
	{ id: 110, name: "Perfume de Gardenias", author: "Armando Sosa", description: "Lush tropical gardenia imagery with a Latin American warmth in its color and spirit." },
	{ id: 109, name: "Pneuma", author: "Adam Polselli", description: "Air and breath made visible — gossamer textures and shifting tones suggest something barely tangible." },
	{ id: 107, name: "Defiance", author: "James Ehly", description: "Confrontational and bold — the design does not ask permission or apologize for taking up space." },
	{ id: 106, name: "Mediterranean", author: "John Whittet", description: "Terracotta, olive, and Aegean blue conjure whitewashed walls and sun-drenched coastlines." },
	{ id: 105, name: "Austrian's Darker Side", author: "Rene Grassegger", description: "Expressionist darkness from Austria's art history — Schiele's angularity without the flesh." },
	{ id: 104, name: "Invitation", author: "Brad Daily", description: "Engraved letterpress invitation aesthetics — formal, considered, and ceremonially beautiful." },
	{ id: 103, name: "Odyssey", author: "Terrence Conley", description: "Homeric epic scale — wine-dark seas and the visual weight of a very long journey home." },
	{ id: 102, name: "Revolution!", author: "David Hellsing", description: "Constructivist poster design channels Soviet-era graphic energy into typographic agitation." },
	{ id: 101, name: "Punkass", author: "Mikhel Proulx", description: "Deliberately abrasive — torn edges, aggressive type, and zero interest in making you comfortable." },
	{ id: 100, name: "15 Petals", author: "Eric Meyer & Dave Shea", description: "A collaboration between two CSS legends — floral geometry with authoritative technical precision." },
	{ id: 99, name: "Wiggles the Wonderworm", author: "Joseph Pearson", description: "A children's book character set free in the garden — joyful, wriggly, and completely charming." },
	{ id: 98, name: "Edo and Tokyo", author: "Daisuke Sato", description: "Old Edo woodblock print aesthetics collide with modern Tokyo neon in a layered cultural dialogue." },
	{ id: 97, name: "No Frontiers!", author: "Michal Mokrzycki", description: "Maps, borders, and cartographic imagery used to argue for their own irrelevance." },
	{ id: 96, name: "Japanese Garden", author: "Masanori Kawachi", description: "Raked gravel, stone lanterns, and the composed stillness of a traditional karesansui garden." },
	{ id: 95, name: "Corporate ZenWorks", author: "Derek Hansen", description: "The irony is the point — corporate PowerPoint aesthetics applied to a meditation on web beauty." },
	{ id: 94, name: "Deco", author: "Marc Trudel", description: "Art Deco's geometric glamour — sunburst patterns, gold, and the confident elegance of the 1920s." },
	{ id: 93, name: "South of the Border", author: "Rob Shields", description: "Warm Mexican folk art colors and patterned textiles create a fiesta atmosphere." },
	{ id: 92, name: "Port of Call", author: "Jessica Dunn", description: "Nautical charts, rope textures, and the romantic melancholy of a sailor's last port." },
	{ id: 91, name: "webZine", author: "Vincent Valentin", description: "Early 2000s web magazine layout — the design thinking of a digital publication finding its voice." },
	{ id: 90, name: "Open Window", author: "Ray Henry", description: "A view through glass to outside — the page as a frame for something just beyond reach." },
	{ id: 89, name: "Dark Industrial", author: "Ray Henry", description: "Factory floor aesthetics — bare metal, utility lighting, and the grim beauty of industrial function." },
	{ id: 88, name: "Tulipe", author: "Eric Shepherd", description: "Dutch tulip mania reimagined — single blooms given the reverence of precious objects." },
	{ id: 87, name: "Maya", author: "Bernd Willenberg", description: "Mayan glyph systems and pre-Columbian geometry create a pre-internet information architecture." },
	{ id: 86, name: "RedFrog", author: "Bernd Willenberg", description: "A single vivid red frog against tropical greens — nature's warning colors as design system." },
	{ id: 85, name: "Oceans Apart", author: "Ryan Sims", description: "The ache of distance across water — wide open blues and the loneliness of a vast horizon." },
	{ id: 84, name: "Start Listening!", author: "Liz Lubowitz", description: "Audio waveforms and speaker imagery demand attention in a design that refuses to be background noise." },
	{ id: 83, name: "Springtime", author: "Boér Attila", description: "Eastern European folk art spring motifs — bright embroidery patterns bursting with seasonal optimism." },
	{ id: 82, name: "Miracle Cure", author: "Joseph Pearson", description: "Patent medicine label aesthetics with Victorian quackery charm and elaborate typographic promises." },
	{ id: 81, name: "seashore", author: "Clinton Barth", description: "The precise moment where ocean meets land — wet sand textures and the rhythm of retreating waves." },
	{ id: 80, name: "Zen Pool", author: "Clinton Barth", description: "Still water and reflection at the center — the garden pool as metaphor for a quiet mind." },
	{ id: 79, name: "Green Tea", author: "Amy Rae Som", description: "The clean, slightly bitter refinement of a good green tea — simple, healthy, and quietly Japanese." },
	{ id: 78, name: "Muto Verde", author: "Alex Taylor", description: "Silent green — the muteness of deep forest where sound doesn't travel and color does the talking." },
	{ id: 77, name: "Hop", author: "Guillaume Lahalle", description: "Playful jumping energy — light on its feet, bouncing between elements with Gallic sprightliness." },
	{ id: 76, name: "Lotus", author: "Chika", description: "The lotus flower rising from muddy water — Buddhist purity symbolism rendered with Japanese delicacy." },
	{ id: 75, name: "Lost HighWay", author: "Julien Roumagnac", description: "Empty road stretching to a vanishing point — Americana loneliness with a French road movie sensibility." },
	{ id: 74, name: "Egyptian Dawn", author: "James Abbott", description: "Hieroglyphs and pyramid silhouettes at first light — ancient geometry meeting the modern web." },
	{ id: 73, name: "Emmakade", author: "Alexander Christiaan Jacob", description: "Named for a Dutch canal quay — harbor reflections, brick textures, and Northern European quietude." },
	{ id: 72, name: "Outburst", author: "Chris Vincent", description: "Explosive energy barely contained — the design feels like it might burst through the browser window." },
	{ id: 71, name: "Garden Party", author: "Bobby van der Sluis", description: "Striped lawn chairs and bunting — the English garden party as a study in civilized outdoor pleasure." },
	{ id: 70, name: "CS(S) Monk", author: "Cedric Savarese", description: "Monastic illuminated manuscript aesthetics applied to a CSS showcase with quiet devotion." },
	{ id: 69, name: "Bonsai Sky", author: "Mike Davidson", description: "A bonsai tree growing against an open sky — contained beauty set against infinite space." },
	{ id: 68, name: "Ballade", author: "Charlotte Lambert", description: "Musical ballad structure — verses and refrains visible in the rhythm of the typographic layout." },
	{ id: 67, name: "A Silent Strength", author: "Ray Henry", description: "Stillness as power — the design says nothing loudly and everything quietly." },
	{ id: 66, name: "Focus & Shoot", author: "Colectivo YTW", description: "Camera viewfinder and photography aesthetics with the decisive-moment energy of street photography." },
	{ id: 65, name: "New Groove", author: "Martin Neumann", description: "Vinyl record grooves and music club graphics with the warm crackle of analog sound." },
	{ id: 64, name: "Night Drive", author: "Dave Shea", description: "Headlights and dark roads — the hypnotic experience of driving alone through the night." },
	{ id: 63, name: "Elastic Lawn", author: "Patrick Grifiths", description: "A garden that stretches and breathes — fluid layout principles made literal and botanical." },
	{ id: 62, name: "Gemination", author: "Egor Kloos", description: "Paired and doubled forms create visual rhymes — everything has an echo or a twin." },
	{ id: 61, name: "Sky", author: "Stefan Petre", description: "Pure sky — cloud formations and blue gradients create a design that is entirely atmosphere." },
	{ id: 60, name: "Extreme Limits", author: "Richard Chatfield", description: "Testing boundaries in both concept and CSS technique — the design pushes as far as it can go." },
	{ id: 59, name: "Dune Temple", author: "Greg Reimer", description: "Desert sand dunes sculpted into temple architecture — natural forms given sacred geometry." },
	{ id: 58, name: "Radio Zen", author: "Marc LA van den Heuvel", description: "Shortwave radio dial aesthetics and broadcast tower imagery tune into a frequency of calm." },
	{ id: 57, name: "This is Cereal", author: "Shaun Inman", description: "Breakfast cereal box design with playful nutrition label typography and morning-bright colors." },
	{ id: 56, name: "Elevation", author: "Nigel Goodfellow", description: "Architectural elevation drawings — the page as blueprint, precise and technical and beautiful." },
	{ id: 55, name: "zenlightenment", author: "Lance Leonard", description: "Enlightenment as a visual destination — the design moves from dark to light as you read down." },
	{ id: 54, name: "Gecko's Eye", author: "Sandra Greco", description: "Reptilian close-up vision — textured scales and compound-eye patterns see the world differently." },
	{ id: 53, name: "Self-Growth", author: "Ray Henry", description: "Plant growth as personal development metaphor — branching forms that spread slowly and purposefully." },
	{ id: 52, name: "Postage Paid", author: "Mike Stenhouse", description: "Postage stamp and airmail aesthetics celebrate the physical beauty of postal communication." },
	{ id: 51, name: "Commercial Drive", author: "Wendy Foster", description: "Named for Vancouver's eclectic street — independent shop fronts and community noticeboard energy." },
	{ id: 50, name: "First Summary", author: "Cornelia Lange", description: "The visual clarity of a well-organized executive summary — German precision in information hierarchy." },
	{ id: 49, name: "Buddha", author: "Daniel Leroux", description: "The Buddha's iconography rendered with genuine reverence rather than decorative appropriation." },
	{ id: 48, name: "HoriZental", author: "Clément Hardouin", description: "Horizontal emphasis — the design breathes sideways, resisting the vertical pull of the scroll." },
	{ id: 47, name: "dusk", author: "Jon Hicks", description: "The specific quality of evening light — warm oranges draining into purple as day gives way to night." },
	{ id: 46, name: "sub:lime", author: "Andy Budd", description: "The sublime made accessible — grandeur scaled down to browser width without losing its power." },
	{ id: 45, name: "I Dream in Colour", author: "Jeff Bilen", description: "Saturated dream logic where color operates on emotion rather than representation." },
	{ id: 44, name: "si6", author: "Shaun Inman", description: "Typographic experimentation where letterforms become pure form, divorced from their phonetic function." },
	{ id: 43, name: "Burning", author: "Kevin & Ethel Davis", description: "Fire and combustion made tangible — the page burns at its edges with controlled elemental energy." },
	{ id: 42, name: "Stone Washed", author: "Andrew Hayward", description: "Denim and stonewash textures bring the worn, faded quality of well-loved fabric to the screen." },
	{ id: 41, name: "door to my garden", author: "Patrick H. Lauke", description: "A threshold rather than a destination — the promise of a garden just beyond the next click." },
	{ id: 40, name: "The Question Why", author: "Diane Clayton", description: "Philosophical inquiry built into the visual structure — the layout itself asks something of you." },
	{ id: 39, name: "Erratic Blue", author: "Ian Main", description: "Unpredictable blue forms that refuse to settle into expected patterns — restless and searching." },
	{ id: 38, name: "Creepy Crawly", author: "Luke Redpath", description: "Insect forms and biological close-up aesthetics make the familiar web feel pleasantly unsettling." },
	{ id: 37, name: "prêt-á-porter", author: "Minz Meyer", description: "Ready-to-wear fashion editorial — the Zen Garden as a French fashion magazine spread." },
	{ id: 36, name: "White Lily", author: "Jens Kristensen", description: "Scandinavian simplicity — a single white lily on white space, purity achieving its own presence." },
	{ id: 35, name: "Release One", author: "Didier Hilhorst", description: "Software release aesthetics — the design reads like a version 1.0 launch in its confident newness." },
	{ id: 34, name: "zengrounds", author: "Andrea Piernock", description: "Coffee grounds and café culture create an Italian espresso bar atmosphere." },
	{ id: 33, name: "Fleur-de-lys", author: "Claire Campbell", description: "The French royal lily rendered with heraldic precision and aristocratic restraint." },
	{ id: 32, name: "Crab Apple", author: "Jai Brinkofski", description: "The tart, overlooked beauty of the crab apple — small, puckering, and underestimated." },
	{ id: 31, name: "Hedges", author: "Kev Mears", description: "The living architecture of hedge forms — green walls that divide and define without stone." },
	{ id: 30, name: "Entomology", author: "Jon Hicks", description: "Scientific insect illustration — specimen pins and Latin labels treat bugs with taxonomic reverence." },
	{ id: 29, name: "Backyard", author: "Ray Henry", description: "Domestic garden familiarity — the honest, unglamorous beauty of your own backyard." },
	{ id: 28, name: "Atlantis", author: "Kevin Davis", description: "The lost continent rising from the deep — underwater ruins and the romance of civilization submerged." },
	{ id: 27, name: "Gothica", author: "Patrick H. Lauke", description: "Gothic blackletter typography and dark ecclesiastical aesthetics form a cathedral out of CSS." },
	{ id: 26, name: "Zunflower", author: "Radu Darvas", description: "The Z in 'Zen' blooms into a sunflower — simple wordplay made into a sunny, generous design." },
	{ id: 25, name: "mnemonic", author: "Dave Shea", description: "A memory device made visual — forms that help the eye remember where it has been." },
	{ id: 24, name: "Not So Minimal", author: "Dan Rubin", description: "The title contains the entire design argument — minimalism that admits what it actually is." },
	{ id: 23, name: "fleur de l'avant-garde", author: "Michael Switzer", description: "Flowers meet avant-garde typography in a design that quotes French artistic radicalism." },
	{ id: 22, name: "viridity", author: "Laura MacArthur", description: "The quality of being green — fresh growth and the specific vibrant green of new leaves in spring." },
	{ id: 21, name: "Calm & Smooth", author: "Cornelia Lange", description: "Cornelia Lange's second submission proves the thesis of the title with unruffled precision." },
	{ id: 20, name: "Friendly Beaches", author: "Sophie G", description: "Sandy shores and welcoming waves create an invitation rather than a landscape." },
	{ id: 19, name: "What Lies Beneath", author: "Michael Pick", description: "Layers concealing layers — the design rewards those who look past the surface." },
	{ id: 18, name: "Wrapped in Burlap", author: "John Simons", description: "Rough burlap texture and organic brown tones celebrate humble, unvarnished materials." },
	{ id: 17, name: "Golden Mean", author: "Douglas Bowman", description: "The golden ratio applied by one of web design's most respected practitioners — proportional perfection." },
	{ id: 16, name: "The Garden Beneath", author: "Minz Meyer", description: "What exists under the garden's surface — root systems and underground life made visible." },
	{ id: 15, name: "Boddhidarma", author: "Michael Angeles", description: "The Zen patriarch who stared at a wall for nine years — discipline and stillness as design values." },
	{ id: 14, name: "Samuraai", author: "Minz Meyer", description: "Warrior aesthetics with the quiet precision of a sword — Japanese discipline in every element." },
	{ id: 13, name: "Coastal Breeze", author: "Dave Shea", description: "Dave Shea's early coastal design — salt air and the clean freshness of an ocean-facing window." },
	{ id: 12, name: "TechnOhm", author: "Josh Ambrutis", description: "Electrical resistance made decorative — circuit diagrams and ohm symbols as ornamental elements." },
	{ id: 11, name: "meliorism", author: "Brett J. Gilbert", description: "The belief that the world can be made better — optimism given typographic form." },
	{ id: 10, name: "A Garden Apart", author: "Dan Cederholm", description: "SimpleBits' Dan Cederholm brings his signature warmth and craft to a design apart from the ordinary." },
	{ id: 9, name: "Dead or Alive", author: "Michael Pick", description: "Western wanted-poster aesthetics channel the lawless frontier into a CSS standoff." },
	{ id: 8, name: "RPM", author: "Bruno Cunha", description: "Revolutions per minute — motor culture and speed rendered in mechanical precision." },
	{ id: 7, name: "deep thoughts", author: "Jason Estes", description: "Introspective and inward-facing — the design creates the visual equivalent of a long pause." },
	{ id: 6, name: "Wicked Grove", author: "D. Keith Robinson", description: "A grove that has gone dark — fairy tale forest aesthetics where the trees have their own intentions." },
	{ id: 5, name: "Blood Lust", author: "Dave Shea", description: "Dave Shea shows range early — vivid crimson and gothic intensity from the garden's own creator." },
	{ id: 4, name: "arch4.20", author: "Dave Shea", description: "Architectural blueprints and technical drawing aesthetics from the CSS Zen Garden's own founder." },
	{ id: 3, name: "Stormweather", author: "Dave Shea", description: "Turbulent skies and weather-beaten textures — one of Dave Shea's original launch designs." },
	{ id: 2, name: "Salmon Cream Cheese", author: "Dave Shea", description: "The odd title delivers — an unexpectedly edible palette from the site's creator in its opening days." },
	{ id: 1, name: "tranquille", author: "Dave Shea", description: "The very first CSS Zen Garden submission — Dave Shea's quiet opening statement for the whole project." }
]

function padId(id) {
	if (id < 10) return '00' + id
	if (id < 100) return '0' + id
	return '' + id
}

function renderCards() {
	var grid = document.getElementById('zg-grid')
	var html = ''
	for (var i = 0; i < designs.length; i++) {
		var d = designs[i]
		var pid = padId(d.id)
		html += '<div class="col">'
		html +=   '<div class="card h-100 zg-card" id="card-' + d.id + '">'
		html +=     '<a href="https://csszengarden.com/' + pid + '/" target="_blank" rel="noopener" class="zg-thumb">'
		html +=       '<img src="https://csszengarden.com/content/previews/' + pid + '.png" alt="' + d.name + ' design preview" loading="lazy"'
		html +=         ' onerror="this.style.display=\'none\'; this.nextElementSibling.style.display=\'flex\';">'
		html +=       '<div class="zg-thumb-placeholder" style="display:none;">' + d.id + '</div>'
		html +=     '</a>'
		html +=     '<div class="card-header">'
		html +=       '<span class="zg-title">What makes this unique</span>'
		html +=     '</div>'
		html +=     '<div class="card-body">'
		html +=       '<p class="card-title zg-title mb-1">' + d.name + '</p>'
		html +=       '<p class="text-muted mb-2" style="font-size:11px;">by ' + d.author + '</p>'
		html +=       '<p class="mb-0">' + d.description + '</p>'
		html +=     '</div>'
		html +=     '<div class="card-footer" id="footer-' + d.id + '">'
		html +=       '<button class="btn btn-outline-secondary btn-sm zg-btn float-end" onclick="more(' + d.id + ')">More</button>'
		html +=     '</div>'
		html +=   '</div>'
		html += '</div>'
	}
	grid.innerHTML = html
}

function more(id) {
	var design = null
	for (var i = 0; i < designs.length; i++) {
		if (designs[i].id === id) {
			design = designs[i]
			break
		}
	}
	var footer = document.getElementById('footer-' + id)
	footer.innerHTML = 'api.anthropic.com&hellip;'

	var otherDesigns = ''
	for (var j = 0; j < designs.length; j++) {
		if (designs[j].id !== id) {
			otherDesigns += '- ' + designs[j].name + ' by ' + designs[j].author + '\n'
		}
	}

	var prompt = 'You are an expert CSS and web design historian explaining CSS Zen Garden designs.\n\n'
		+ 'The design is: "' + design.name + '" by ' + design.author + '\n\n'
		+ 'The other designs in this set are:\n' + otherDesigns + '\n'
		+ 'Write 2-3 sentences explaining what makes "' + design.name + '" distinctly different from all the others. '
		+ 'Focus on its unique CSS technique, aesthetic philosophy, or cultural inspiration. '
		+ 'Be specific and interesting. Do not use bullet points. Plain prose only.'

	post_json('proxy.cfm', {
		model: 'claude-sonnet-4-6',
		max_tokens: 1000,
		messages: [{
			role: 'user',
			content: prompt
		}]
	}).then(show_more)

	function show_more(response) {
		var result = ''
		if (response.content) {
			for (var k = 0; k < response.content.length; k++) {
				if (response.content[k].type === 'text') {
					result = response.content[k].text
					break
				}
			}
		}
		footer.textContent = result
	}
}

renderCards()
