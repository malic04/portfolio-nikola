<template>
  <section class="hero-section" @click="focusInput">
    <v-container class="py-0">
      <TerminalWindow title="nikola@portfolio: ~">
        <div class="term-scroll" ref="scrollRef">

          <!-- Output history -->
          <div v-for="(line, i) in lines" :key="i" class="term-line">
            <template v-if="line.type === 'command'">
              <span class="c-green">nikola@portfolio</span><span class="c-muted">:~$</span><span class="c-white"> {{ line.text }}</span>
            </template>
            <template v-else-if="line.type === 'blank'">&nbsp;</template>
            <template v-else>
              <span :class="typeClass(line.type)">{{ line.text }}</span>
            </template>
          </div>

          <!-- Active input line -->
          <div v-if="inputActive" class="term-line input-line">
            <span class="c-green">nikola@portfolio</span><span class="c-muted">:~$</span>
            <span class="c-white"> {{ rawInput }}</span><span class="cursor">█</span>
            <input
              ref="inputRef"
              v-model="rawInput"
              @keydown="handleKey"
              class="hidden-input"
              autocomplete="off"
              autocorrect="off"
              autocapitalize="off"
              spellcheck="false"
              aria-label="Terminal input"
            />
          </div>

        </div>
      </TerminalWindow>
    </v-container>
  </section>
</template>

<script setup>
import { ref, nextTick, onMounted } from 'vue'
import TerminalWindow from './TerminalWindow.vue'
import { skillGroups } from '../data/skills.js'
import { projects } from '../data/projects.js'

const scrollRef  = ref(null)
const inputRef   = ref(null)
const lines      = ref([])
const rawInput   = ref('')
const inputActive = ref(false)
const cmdHistory = ref([])
const historyIdx = ref(-1)

// ─── Boot sequence ────────────────────────────────────────────────────────────
const bootLines = [
  { type: 'output-green', text: '╔══════════════════════════════════╗' },
  { type: 'output-green', text: '║    NIKOLA MALIC  —  PORTFOLIO    ║' },
  { type: 'output-green', text: '╚══════════════════════════════════╝' },
  { type: 'blank' },
  { type: 'output-muted', text: 'Software Developer  ·  Frontend · Backend' },
  { type: 'blank' },
  { type: 'output', text: 'Type "help" to see available commands.' },
  { type: 'blank' },
]

// ─── Helpers ──────────────────────────────────────────────────────────────────
function typeClass(type) {
  return {
    'output':       'c-white',
    'output-green': 'c-green',
    'output-amber': 'c-amber',
    'output-muted': 'c-muted',
    'output-error': 'c-error',
    'output-name':  'name-big',
  }[type] ?? 'c-white'
}

function push(...items) {
  lines.value.push(...items)
}

function blank() { return { type: 'blank' } }
function out(text)  { return { type: 'output',       text } }
function grn(text)  { return { type: 'output-green', text } }
function amb(text)  { return { type: 'output-amber', text } }
function mut(text)  { return { type: 'output-muted', text } }
function err(text)  { return { type: 'output-error', text } }

function scrollToBottom() {
  nextTick(() => {
    if (scrollRef.value) scrollRef.value.scrollTop = scrollRef.value.scrollHeight
  })
}

function focusInput() {
  inputRef.value?.focus()
}

// ─── Command processor ────────────────────────────────────────────────────────
function processCommand(raw) {
  const trimmed = raw.trim()
  push({ type: 'command', text: trimmed })

  if (!trimmed) return

  const parts = trimmed.split(/\s+/)
  const base  = parts[0].toLowerCase()

  // clear / ctrl+l
  if (base === 'clear') {
    lines.value = []
    return
  }

  // help
  if (base === 'help') {
    push(
      blank(),
      amb('Available commands:'),
      blank(),
      out('  help                    Show this message'),
      out('  whoami                  About Nikola'),
      out('  ls                      List available files'),
      out('  cat about.txt           Show bio'),
      out('  cat skills.txt          Show skills'),
      out('  cat projects.txt        Show all projects'),
      out('  goto <section>          Navigate to section'),
      out('  cd <section>            Alias for goto'),
      out('  clear                   Clear terminal'),
      blank(),
      mut('Sections: about  ·  skills  ·  projects'),
      blank(),
    )
    return
  }

  // ls
  if (base === 'ls') {
    push(blank(), grn('about.txt    skills.txt    projects.txt'), blank())
    return
  }

  // whoami
  if (base === 'whoami') {
    push(
      blank(),
      { type: 'output-name', text: 'Nikola Malic' },
      mut('Software Developer'),
      mut('github.com/malic04'),
      blank(),
    )
    return
  }

  // cat
  if (base === 'cat') {
    const file = parts[1]
    if (!file) {
      push(blank(), err('cat: missing operand'), mut('Available: about.txt  skills.txt  projects.txt'), blank())
      return
    }
    if (file === 'about.txt') {
      push(
        blank(),
        out('Name   : Nikola Malic'),
        out('Role   : Software Developer'),
        out('Focus  : Backend · Algorithms · Systems Programming'),
        out('GitHub : github.com/malic04'),
        blank(),
        mut("I enjoy building things from scratch — whether it's a secure"),
        mut('authentication API, a graph search algorithm, or OS-level'),
        mut('concurrent programs. Always looking for new challenges.'),
        blank(),
      )
      return
    }
    if (file === 'skills.txt') {
      push(blank())
      skillGroups.forEach(g => {
        push(amb(`[${g.category}]`), out('  ' + g.skills.join('  ·  ')), blank())
      })
      return
    }
    if (file === 'projects.txt') {
      push(blank())
      projects.forEach(p => {
        push(
          grn(p.name),
          mut('  ' + p.description),
          out('  tech : ' + p.tech.join(', ')),
          out('  url  : ' + p.url),
          blank(),
        )
      })
      return
    }
    push(blank(), err(`cat: ${file}: No such file or directory`), blank())
    return
  }

  // goto / cd
  if (base === 'goto' || base === 'cd') {
    const target = (parts[1] ?? '').toLowerCase()
    const valid  = ['about', 'skills', 'projects']
    if (!target || !valid.includes(target)) {
      push(
        blank(),
        err(`${base}: unknown section "${target || '(none)'}"`),
        mut('Available: about  ·  skills  ·  projects'),
        blank(),
      )
      return
    }
    push(blank(), out(`Navigating to #${target}...`), blank())
    nextTick(() => {
      document.getElementById(target)?.scrollIntoView({ behavior: 'smooth' })
    })
    return
  }

  // echo — output rendered as plain text via {{ }}, safe from XSS
  if (base === 'echo') {
    push(blank(), out(parts.slice(1).join(' ')), blank())
    return
  }

  // unknown
  push(
    blank(),
    err(`command not found: ${parts[0]}`),
    mut('Type "help" for available commands.'),
    blank(),
  )
}

// ─── Key handler ──────────────────────────────────────────────────────────────
function handleKey(e) {
  if (e.key === 'Enter') {
    const cmd = rawInput.value
    if (cmd.trim()) {
      cmdHistory.value.unshift(cmd)
      historyIdx.value = -1
    }
    processCommand(cmd)
    rawInput.value = ''
    scrollToBottom()

  } else if (e.key === 'ArrowUp') {
    e.preventDefault()
    if (historyIdx.value < cmdHistory.value.length - 1) {
      historyIdx.value++
      rawInput.value = cmdHistory.value[historyIdx.value]
    }

  } else if (e.key === 'ArrowDown') {
    e.preventDefault()
    if (historyIdx.value > 0) {
      historyIdx.value--
      rawInput.value = cmdHistory.value[historyIdx.value]
    } else {
      historyIdx.value = -1
      rawInput.value = ''
    }

  } else if (e.key === 'Tab') {
    e.preventDefault()

  } else if (e.key === 'l' && e.ctrlKey) {
    e.preventDefault()
    lines.value = []
  }
}

// ─── Mount — boot sequence ────────────────────────────────────────────────────
onMounted(() => {
  bootLines.forEach((line, i) => {
    setTimeout(() => {
      lines.value.push(line)
      if (i === bootLines.length - 1) {
        inputActive.value = true
        nextTick(() => { focusInput(); scrollToBottom() })
      }
    }, i * 80)
  })
})
</script>

<style scoped>
.hero-section {
  min-height: calc(100svh - 64px);
  display: flex;
  align-items: center;
  background: #0d1117;
  padding: 60px 0;
  cursor: text;
}

.term-scroll {
  max-height: min(480px, 55svh);
  overflow-y: auto;
  font-family: 'JetBrains Mono', monospace;
  font-size: 0.875rem;
  line-height: 1.75;
}

.term-scroll::-webkit-scrollbar { width: 4px; }
.term-scroll::-webkit-scrollbar-track { background: transparent; }
.term-scroll::-webkit-scrollbar-thumb { background: #30363d; border-radius: 2px; }

.term-line {
  display: block;
  white-space: pre-wrap;
  word-break: break-word;
}

/* Input line */
.input-line {
  position: relative;
  display: flex;
  align-items: center;
  flex-wrap: wrap;
}

.hidden-input {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  opacity: 0;
  border: none;
  outline: none;
  background: transparent;
  cursor: text;
  font-family: inherit;
  font-size: inherit;
}

.cursor {
  color: #00ff41;
  animation: blink 1s step-end infinite;
}

@keyframes blink {
  0%, 100% { opacity: 1; }
  50%       { opacity: 0; }
}

/* Colours */
.c-green  { color: #00ff41; }
.c-amber  { color: #ffb300; }
.c-muted  { color: #8b949e; }
.c-white  { color: #e6edf3; }
.c-error  { color: #ff5555; }

.name-big {
  font-size: 1.35rem;
  font-weight: 700;
  color: #00ff41;
}

/* Mobile tweaks: reduce padding and limit terminal height to avoid overflow on small phones */
@media (max-width: 480px) {
  .hero-section {
    padding: 24px 12px;
    min-height: calc(100svh - 56px);
    align-items: flex-start;
  }

  .term-scroll {
    /* use small-viewport units to avoid mobile browser chrome issues */
    max-height: 55svh;
    font-size: 0.825rem;
  }

  .input-line {
    gap: 6px;
  }

  .hidden-input {
    font-size: 0.95rem;
  }
}
</style>
