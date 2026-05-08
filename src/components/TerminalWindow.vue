<template>
  <div class="terminal-window">
    <div class="terminal-header">
      <span class="dot dot-red"></span>
      <span class="dot dot-yellow"></span>
      <span class="dot dot-green"></span>
      <span class="terminal-title">{{ title }}</span>
    </div>
    <div class="terminal-body">
      <slot />
    </div>
  </div>
</template>

<script setup>
defineProps({
  title: {
    type: String,
    default: 'nikola@portfolio: ~',
  },
})
</script>

<style scoped>
.terminal-window {
  background: #161b22;
  border-radius: 8px;
  border: 1px solid #30363d;
  overflow: hidden;
}

.terminal-header {
  background: #21262d;
  padding: 10px 16px;
  display: flex;
  align-items: center;
  gap: 6px;
  border-bottom: 1px solid #30363d;
}

.dot {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  display: inline-block;
  flex-shrink: 0;
}
.dot-red    { background: #ff5f57; }
.dot-yellow { background: #ffbd2e; }
.dot-green  { background: #28ca41; }

.terminal-title {
  margin-left: 8px;
  color: #8b949e;
  font-size: 0.75rem;
  font-family: 'JetBrains Mono', monospace;
}

.terminal-body {
  padding: 20px 24px;
  font-family: 'JetBrains Mono', monospace;
  font-size: 0.9rem;
  line-height: 1.7;
}
</style>
