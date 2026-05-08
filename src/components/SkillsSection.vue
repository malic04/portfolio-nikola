<template>
  <section id="skills" class="section">
    <v-container>
      <div class="section-cmd">
        <span class="c-green">nikola@portfolio</span><span class="c-muted">:~$</span>
        <span class="c-white"> ls -1 skills/</span>
      </div>
      <TerminalWindow title="skills/">
        <v-row>
          <v-col
            v-for="group in skillGroups"
            :key="group.category"
            cols="12" sm="6" md="3"
          >
            <div class="group">
              <div class="group-name c-amber">{{ group.category }}/</div>
              <div
                v-for="(skill, i) in group.skills"
                :key="skill"
                class="skill-item"
              >
                <span class="tree c-dim">{{ i < group.skills.length - 1 ? '├── ' : '└── ' }}</span>
                <span class="c-white">{{ skill }}</span>
              </div>
            </div>
          </v-col>
        </v-row>
      </TerminalWindow>
    </v-container>
  </section>
</template>

<script setup>
import TerminalWindow from './TerminalWindow.vue'
import { skillGroups } from '../data/skills.js'
</script>

<style scoped>
.section {
  padding: 80px 0;
  background: #0d1117;
}

.section-cmd {
  margin-bottom: 14px;
  font-family: 'JetBrains Mono', monospace;
  font-size: 0.875rem;
}

.c-green { color: #00ff41; }
.c-amber { color: #ffb300; }
.c-muted { color: #8b949e; }
.c-white { color: #e6edf3; }
.c-dim   { color: #30363d; user-select: none; }

.group {
  font-family: 'JetBrains Mono', monospace;
  font-size: 0.875rem;
  margin-bottom: 8px;
}

.group-name {
  font-weight: 600;
  margin-bottom: 6px;
}

.skill-item {
  line-height: 1.9;
}

.tree {
  white-space: pre;
}
</style>
