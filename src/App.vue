<template>
  <v-app theme="terminal">
    <v-app-bar flat color="surface" elevation="0" style="border-bottom: 1px solid #21262d;">
      <v-app-bar-title>
        <span class="nav-brand"><span class="c-green">nikola</span><span class="c-muted">@portfolio</span><span class="c-muted">:~$</span></span>
      </v-app-bar-title>
      <template v-slot:append>
        <nav class="nav-links">
          <a href="#about" class="nav-link"><span class="c-green">./</span>about</a>
          <a href="#skills" class="nav-link"><span class="c-green">./</span>skills</a>
          <a href="#projects" class="nav-link"><span class="c-green">./</span>projects</a>
          <a href="https://github.com/malic04" target="_blank" rel="noopener noreferrer" class="nav-link"><span class="c-green">./</span>github</a>
        </nav>
      </template>
    </v-app-bar>

    <v-main>
      <HeroSection />
      <AboutSection />
      <SkillsSection />
      <ProjectsSection />
      <FooterSection />
    </v-main>
  </v-app>
</template>

<script setup>
import HeroSection from './components/HeroSection.vue'
import AboutSection from './components/AboutSection.vue'
import SkillsSection from './components/SkillsSection.vue'
import ProjectsSection from './components/ProjectsSection.vue'
import FooterSection from './components/FooterSection.vue'
</script>

<style scoped>
.nav-brand {
  font-family: 'JetBrains Mono', monospace;
  font-size: 0.95rem;
}
.c-green { color: #00ff41; }
.c-muted { color: #8b949e; }

.nav-links {
  display: flex;
  gap: 24px;
  padding-right: 24px;
}
.nav-link {
  color: #8b949e;
  text-decoration: none;
  font-family: 'JetBrains Mono', monospace;
  font-size: 0.85rem;
  transition: color 0.2s;
}
.nav-link:hover {
  color: #e6edf3;
}
</style>
