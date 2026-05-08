<template>
  <section id="projects" class="section">
    <v-container>
      <div class="section-cmd">
        <span class="c-green">nikola@portfolio</span><span class="c-muted">:~$</span>
        <span class="c-white"> git log --oneline projects/</span>
      </div>
      <v-row>
        <v-col
          v-for="project in projects"
          :key="project.id"
          cols="12" md="6"
        >
          <div class="project-card">
            <div class="card-header">
              <span class="lang-dot" :style="{ background: project.color }"></span>
              <span class="project-name c-green">{{ project.name }}</span>
              <a
                :href="project.url"
                target="_blank"
                rel="noopener noreferrer"
                class="ext-link"
                :aria-label="`View ${project.name} on GitHub`"
              >
                <v-icon size="14">mdi-open-in-new</v-icon>
              </a>
            </div>
            <p class="project-desc">{{ project.description }}</p>
            <div class="tech-tags">
              <span v-for="tech in project.tech" :key="tech" class="tag">{{ tech }}</span>
            </div>
          </div>
        </v-col>
      </v-row>
    </v-container>
  </section>
</template>

<script setup>
import { projects } from '../data/projects.js'
</script>

<style scoped>
.section {
  padding: 80px 0;
  background: #0d1117;
}

.section-cmd {
  margin-bottom: 24px;
  font-family: 'JetBrains Mono', monospace;
  font-size: 0.875rem;
}

.c-green { color: #00ff41; }
.c-muted { color: #8b949e; }
.c-white { color: #e6edf3; }

.project-card {
  background: #161b22;
  border: 1px solid #21262d;
  border-radius: 6px;
  padding: 20px;
  margin-bottom: 16px;
  font-family: 'JetBrains Mono', monospace;
  transition: border-color 0.2s, box-shadow 0.2s;
  height: calc(100% - 16px);
}

.project-card:hover {
  border-color: #00ff41;
  box-shadow: 0 0 12px rgba(0, 255, 65, 0.08);
}

.card-header {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 10px;
}

.lang-dot {
  width: 10px;
  height: 10px;
  border-radius: 50%;
  flex-shrink: 0;
}

.project-name {
  font-weight: 500;
  font-size: 0.95rem;
  flex: 1;
}

.ext-link {
  color: #8b949e;
  text-decoration: none;
  display: flex;
  align-items: center;
  transition: color 0.2s;
}
.ext-link:hover {
  color: #e6edf3;
}

.project-desc {
  color: #8b949e;
  font-size: 0.8rem;
  line-height: 1.65;
  margin-bottom: 14px;
}

.tech-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
}

.tag {
  background: #21262d;
  color: #58a6ff;
  font-size: 0.7rem;
  padding: 2px 9px;
  border-radius: 12px;
  border: 1px solid #30363d;
}
</style>
