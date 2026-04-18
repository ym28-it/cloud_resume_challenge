import AutoCounter from './AutoCounter'


const certifications = ['基本情報技術者', 'AWS CLF-C02']

const techStack = [
  'JavaScript',
  'TypeScript',
  'React',
  'Next.js',
  'Bun',
  'Python',
  'FastAPI',
  'Golang',
  'C',
  'Docker',
  'PostgreSQL',
  'Unreal Engine',
]

function Contents() {
  return (
    <main className="min-h-screen overflow-hidden bg-slate-950 px-6 py-10 text-slate-100 sm:px-10 lg:px-14">
      <div className="mx-auto flex w-full max-w-5xl flex-col gap-8">
        <section className="relative overflow-hidden rounded-[32px] border border-white/10 bg-gradient-to-br from-cyan-400 via-sky-500 to-indigo-700 px-8 py-12 text-left shadow-2xl shadow-cyan-950/40 sm:px-12">
          <div className="absolute inset-0 bg-[radial-gradient(circle_at_top_right,_rgba(255,255,255,0.28),_transparent_35%),radial-gradient(circle_at_bottom_left,_rgba(15,23,42,0.38),_transparent_30%)]" />
          <div className="relative">
            <p className="text-sm font-medium uppercase tracking-[0.45em] text-white/75">
              Resume
            </p>
            <h1 className="mt-4 text-4xl font-semibold tracking-tight text-white sm:text-5xl">
              技術と実装経験を整理した
              <span className="block text-sky-100">Resume</span>
            </h1>
            <p className="mt-4 max-w-2xl text-sm leading-7 text-white/80 sm:text-base">
              取得資格とこれまで扱ってきた技術スタックを、見やすいカード形式でまとめています。
            </p>
          </div>
        </section>

        <section className="grid gap-6 lg:grid-cols-[0.9fr_1.1fr]">
          <article className="rounded-[28px] border border-slate-700 bg-slate-900 p-8 text-left shadow-xl shadow-slate-950/30 backdrop-blur">
            <p className="inline-flex rounded-full border border-white/15 bg-white/5 px-3 py-1 text-xs font-semibold uppercase tracking-[0.3em] text-white">
              Certifications
            </p>
            <h2 className="mt-4 text-2xl font-semibold tracking-tight !text-white">
              取得資格
            </h2>
            <ul className="mt-6 space-y-4">
              {certifications.map((certification) => (
                <li
                  key={certification}
                  className="rounded-2xl border border-slate-800 bg-slate-950/70 px-5 py-4 text-base font-medium text-slate-100"
                >
                  {certification}
                </li>
              ))}
            </ul>
          </article>

          <article className="rounded-[28px] border border-slate-700 bg-slate-900 p-8 text-left shadow-xl shadow-slate-950/30 backdrop-blur">
            <p className="inline-flex rounded-full border border-white/15 bg-white/5 px-3 py-1 text-xs font-semibold uppercase tracking-[0.3em] text-white">
              Tech Stack
            </p>
            <h2 className="mt-4 text-2xl font-semibold tracking-tight !text-white">
              使用経験のある技術スタック
            </h2>
            <div className="mt-6 flex flex-wrap gap-3">
              {techStack.map((tech) => (
                <span
                  key={tech}
                  className="rounded-full border border-emerald-400/20 bg-emerald-400/10 px-4 py-2 text-sm font-medium text-emerald-100"
                >
                  {tech}
                </span>
              ))}
            </div>
          </article>
        </section>
        <AutoCounter />
      </div>
    </main>
  )
}

export default Contents
