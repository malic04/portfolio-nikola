<template>
  <footer class="footer">
    <v-container>
      <div class="footer-inner">
        <div class="footer-cmd">
          <span class="c-green">nikola@portfolio</span><span class="c-muted">:~$</span>
          <span class="c-white"> echo "Thanks for visiting :)"</span>
        </div>
        <div class="footer-output c-muted">Thanks for visiting :)</div>
        <div class="footer-links">
          <a
            href="https://github.com/malic04"
            target="_blank"
            rel="noopener noreferrer"
            class="footer-link"
          >
            <v-icon size="18" style="margin-right: 6px;">mdi-github</v-icon>
            malic04
          </a>
        </div>
      </div>
    </v-container>
  </footer>
</template>

<script setup></script>

<style scoped>
.footer {
  padding: 48px 0 32px;
  border-top: 1px solid #21262d;
  background: #0d1117;
}

.footer-inner {
  font-family: 'JetBrains Mono', monospace;
  font-size: 0.875rem;
}

.c-green { color: #00ff41; }
.c-muted { color: #8b949e; }
.c-white { color: #e6edf3; }

.footer-cmd {
  margin-bottom: 4px;
}

.footer-output {
  margin-bottom: 24px;
}

.footer-links {
  display: flex;
  gap: 20px;
}

.footer-link {
  display: flex;
  align-items: center;
  color: #8b949e;
  text-decoration: none;
  transition: color 0.2s;
}
.footer-link:hover {
  color: #00ff41;
}
</style>
