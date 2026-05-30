var designs = [
	{
		id: 221, name: "Mid Century Modern", author: "Andrew Lohman",
		tags: ["geometric", "warm palette", "retro"],
		description: "Clean geometric shapes and a warm earth-tone palette inspired by 1950s American design. Bold sans-serif typography, structured layouts, and a sense of order with decorative flair."
	},
	{
		id: 220, name: "Garments", author: "Dan Mall",
		tags: ["editorial", "fashion", "typographic"],
		description: "Editorial fashion-magazine aesthetic. Typography is the hero — oversized display text, stark contrast, and refined whitespace create a high-fashion feel without a single image."
	},
	{
		id: 219, name: "Steel", author: "Steffen Knoeller",
		tags: ["industrial", "dark", "metallic"],
		notable: { badge: "CSS-only textures", color: "dark" },
		description: "Fakes riveted steel and brushed metal surfaces using only CSS gradients — no images at all. Almost every other design in this set relies on background images for atmosphere; Steel proves you don't need them."
	},
	{
		id: 218, name: "Apothecary", author: "Trent Walton",
		tags: ["vintage", "serif-heavy", "earthy"],
		description: "Victorian apothecary shop aesthetic. Dense serif typography, aged parchment tones, and ornamental rules and dividers evoke hand-typeset pharmaceutical labels from the 1800s."
	},
	{
		id: 217, name: "Screen Filler", author: "Elliot Jay Stocks",
		tags: ["bold", "full-bleed", "modern"],
		description: "Every element stretches edge-to-edge. Typography at huge scale fills the viewport deliberately. Contrast and spatial tension replace decorative detail."
	},
	{
		id: 216, name: "Fountain Kiss", author: "Jeremy Carlson",
		tags: ["romantic", "painterly", "flowing"],
		description: "Organic, flowing shapes and a romantic soft-focus palette. Curved containers and painterly background elements make the layout feel hand-crafted rather than constructed."
	},
	{
		id: 215, name: "A Robot Named Jimmy", author: "meltmedia",
		tags: ["playful", "illustrated", "quirky"],
		notable: { badge: "animated character", color: "warning" },
		description: "The only design in this set that builds a full animated character directly into the layout. CSS positions and animates a custom robot illustration around the content — it reads more like a game screen than a web page."
	},
	{
		id: 214, name: "Verde Moderna", author: "Dave Shea",
		tags: ["elegant", "green", "art nouveau"],
		notable: { badge: "by the creator", color: "success" },
		description: "Dave Shea's own submission to the site he built. Art Nouveau ornamental borders and a deep forest-green palette set a standard the other contributors were responding to — it's the benchmark everything else departs from."
	},
	{
		id: 213, name: "Under the Sea!", author: "Eric Stoltz",
		tags: ["aquatic", "illustrated", "layered"],
		description: "Richly illustrated underwater scene layered behind and around the text. Multiple z-index layers of coral, fish, and bubbles create parallax depth — all controlled by CSS positioning."
	},
	{
		id: 212, name: "Make 'em Proud", author: "McAghon & Reifsnyder",
		tags: ["americana", "bold", "athletic"],
		description: "Bold American sports-team aesthetic. Block typography, strong diagonal accents, and a high-contrast red-white-blue palette give it the energy of a stadium scoreboard or vintage pennant."
	},
	{
		id: 211, name: "Orchid Beauty", author: "Kevin Addison",
		tags: ["floral", "soft", "feminine"],
		description: "Delicate orchid motifs and a soft pink-lavender palette. Floating petals and curved section backgrounds are pure CSS — the layout breathes and the decoration feels woven into the structure."
	},
	{
		id: 210, name: "Oceanscape", author: "Justin Gray",
		tags: ["panoramic", "blue", "atmospheric"],
		description: "A wide, cinematic ocean horizon stretches across the top. Cool blue gradients and generous whitespace make it feel like staring out to sea — calm, spacious, and unhurried."
	},
	{
		id: 209, name: "CSS Co., Ltd.", author: "Benjamin Klemm",
		tags: ["corporate", "japanese", "structured"],
		description: "Japanese corporate design language — clean grid structure, kanji-style logotype, formal hierarchy, and a restrained monochromatic palette. Looks like a multinational annual report."
	},
	{
		id: 208, name: "Sakura", author: "Tatsuya Uchida",
		tags: ["japanese", "minimalist", "spring"],
		notable: { badge: "cultural minimalism", color: "info" },
		description: "Where CSS Co., Ltd. is Japanese in a corporate sense, Sakura is Japanese in a deeply cultural one — cherry blossoms, ink-wash tones, and wabi-sabi negative space make it the most philosophically distinct design in the set."
	},
	{
		id: 207, name: "Kyoto Forest", author: "John Politowski",
		tags: ["lush", "vertical", "nature"],
		description: "Tall bamboo grove imagery and vertical rhythms dominate. The layout scrolls like a hanging scroll painting; deep greens and vertical text spacing reinforce the forest immersion."
	},
	{
		id: 206, name: "A Walk in the Garden", author: "Simon Van Hauwermeiren",
		tags: ["illustrated", "storybook", "green"],
		description: "A hand-illustrated garden stroll. Whimsical plant and path illustrations border the content, giving it the feel of a children's book illustration rather than a web page."
	},
	{
		id: 205, name: "spring360", author: "Rene Hornig",
		tags: ["circular", "radial", "experimental"],
		notable: { badge: "breaks the grid", color: "danger" },
		description: "The only design here that completely abandons the vertical scroll. Elements orbit a central point in a radial layout — it's the most structurally experimental submission in the set and the one most likely to make you rethink what a web page can be."
	},
	{
		id: 204, name: "Withering Beauty", author: "William Duffy",
		tags: ["dark", "gothic", "decay"],
		description: "Gothic decay aesthetic. Dark backgrounds, aged textures, and wilting botanical motifs create a memento mori mood. The typography is deliberately distressed and fragile-feeling."
	}
]

function renderCards() {
	var grid = document.getElementById('zg-grid')
	var html = ''
	for (var i = 0; i < designs.length; i++) {
		var d = designs[i]
		var notableBadge = ''
		if (d.notable) {
			notableBadge = '<span class="badge text-bg-' + d.notable.color + ' zg-notable-badge text-nowrap">' + d.notable.badge + '</span>'
		}
		var tagHtml = ''
		for (var j = 0; j < d.tags.length; j++) {
			tagHtml += '<span class="badge rounded-pill text-bg-secondary">' + d.tags[j] + '</span>'
		}
		html += '<div class="col">'
		html +=   '<div class="card h-100 zg-card" id="card-' + d.id + '">'
		html +=     '<a href="https://csszengarden.com/' + d.id + '/" target="_blank" rel="noopener" class="zg-thumb">'
		html +=       '<img src="https://csszengarden.com/content/previews/' + d.id + '.png" alt="' + d.name + ' design preview"'
		html +=         ' onerror="this.style.display=\'none\'; this.nextElementSibling.style.display=\'flex\';">'
		html +=       '<div class="zg-thumb-placeholder" style="display:none;">' + d.id + '</div>'
		html +=     '</a>'
		html +=     '<div class="card-header d-flex align-items-start justify-content-between gap-2">'
		html +=       '<span class="zg-title">What makes this unique</span>'
		html +=       notableBadge
		html +=     '</div>'
		html +=     '<div class="card-body">'
		html +=       '<p class="card-title zg-title mb-1">' + d.name + '</p>'
		html +=       '<p class="text-muted mb-2" style="font-size:11px;">by ' + d.author + '</p>'
		html +=       '<div class="d-flex flex-wrap gap-1 mb-2">' + tagHtml + '</div>'
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
			otherDesigns += '- ' + designs[j].name + ': ' + designs[j].tags.join(', ') + '\n'
		}
	}

	var prompt = 'You are an expert CSS and web design historian explaining CSS Zen Garden designs.\n\n'
		+ 'The design is: "' + design.name + '" by ' + design.author + '\n'
		+ 'Its character: ' + design.description + '\n'
		+ 'Tags: ' + design.tags.join(', ') + '\n\n'
		+ 'The other 17 designs in this set are:\n' + otherDesigns + '\n'
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
		var result = design.description
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
