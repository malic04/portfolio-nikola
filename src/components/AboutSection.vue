<template>
  <section id="about" class="section">
    <v-container>
      <div class="section-cmd">
        <span class="c-green">nikola@portfolio</span><span class="c-muted">:~$</span>
        <span class="c-white"> cat about.txt</span>
      </div>
      <TerminalWindow title="about.txt">
        <div class="about-rows">
          <div class="row">
            <span class="key">Name</span><span class="sep">:</span>
            <span class="c-green">Nikola Malic</span>
          </div>
          <div class="row">
            <span class="key">Role</span><span class="sep">:</span>
            <span class="c-white">Software Developer</span>
          </div>
          <div class="row">
            <span class="key">Focus</span><span class="sep">:</span>
            <span class="c-white">Backend &bull; Algorithms &bull; Systems Programming</span>
          </div>
          <div class="row">
            <span class="key">GitHub</span><span class="sep">:</span>
            <a class="c-amber link" href="https://github.com/malic04" target="_blank" rel="noopener noreferrer">
              github.com/malic04
            </a>
          </div>
        </div>
        <div class="divider"></div>
        <p class="bio">
          I enjoy building things from scratch — whether it's a secure authentication API,
          a graph search algorithm, or OS-level concurrent programs. Always looking for
          new challenges and interesting problems to solve.
        </p>
      </TerminalWindow>
    </v-container>
  </section>
</template>

<script setup>
import TerminalWindow from './TerminalWindow.vue'
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

.about-rows {
  font-family: 'JetBrains Mono', monospace;
  font-size: 0.875rem;
}

.row {
  display: flex;
  gap: 8px;
  line-height: 2.1;
  flex-wrap: wrap;
}

.key {
  color: #8b949e;
  min-width: 72px;
}

.sep {
  color: #30363d;
}

.link {
  text-decoration: none;
}
.link:hover {
  text-decoration: underline;
}

.divider {
  border-top: 1px solid #21262d;
  margin: 18px 0;
}

.bio {
  color: #8b949e;
  font-family: 'JetBrains Mono', monospace;
  font-size: 0.85rem;
  line-height: 1.8;
  margin: 0;
}
</style>
