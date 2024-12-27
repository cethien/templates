<script lang="ts">
	import { meta } from '$lib/meta'
	import { toggleTheme } from '$lib/theme'

	import '../app.css'

	const copyrightYears = () => {
		if (meta.copyright.years[0] === meta.copyright.years[1]) {
			return meta.copyright.years[0].toString()
		}
		return `${meta.copyright.years[0]} - ${meta.copyright.years[1]}`
	}
</script>

<svelte:head>
	<title>{meta.title}</title>
	<meta name="description" content={meta.description} />
	<script>
		if (
			localStorage.getItem('theme') === 'dark' ||
			(window.matchMedia('(prefers-color-scheme: dark)').matches &&
				!(localStorage.getItem('theme') === 'light'))
		) {
			document.documentElement.classList.add('dark')
		}
	</script>
</svelte:head>

<div
	class="grid min-h-screen select-none grid-rows-[auto_1fr] dark:bg-gray-900 dark:text-white"
>
	<header
		class="flex items-center justify-between border-b-2 px-4 py-2 2xl:px-96"
	>
		<div class="text-4xl font-extrabold">
			<a href="/">{meta.title}</a>
		</div>
		<div>
			<button on:click={() => toggleTheme()} class="text-2xl">
				<span
					class="icon-[material-symbols--light-mode] dark:icon-[material-symbols--dark-mode]"
				></span>
			</button>
		</div>
	</header>
	<main class="select-text px-4 py-6 2xl:px-96">
		<slot />
	</main>
	<footer
		class="flex items-center justify-between border-t-2 px-4 py-2 2xl:px-96"
	>
		<div></div>
		<div>
			<p>
				©
				<a
					href={meta.copyright.ref}
					target="_blank"
					rel="noopener noreferrer"
					class="hover:underline">{meta.copyright.name}</a
				>
				{copyrightYears()}
			</p>
		</div>
	</footer>
</div>
