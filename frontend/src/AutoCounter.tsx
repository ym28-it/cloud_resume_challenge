import { useEffect, useState } from "react";


function AutoCounter() {
  const [visitorCount, setVisitorCount] = useState<string | null>(null);

  useEffect(() => {
    let isMounted = true;

    const syncVisitorCount = async () => {
      try {
        const counter = await updateVisitorCounter();

        if (isMounted) {
          setVisitorCount(counter);
        }
      } catch (error) {
        console.error("Failed to update visitor counter", error);
      }
    };

    void syncVisitorCount();

    return () => {
      isMounted = false;
    };
  }, []);

  return (
    <section className="rounded-[28px] border border-slate-800 bg-slate-900/80 p-8 text-left shadow-xl shadow-slate-950/30 backdrop-blur">
      <p className="text-xs font-semibold uppercase tracking-[0.3em] text-cyan-300">
        Visitor Counter
      </p>
      <h2 className="mt-3 text-2xl font-semibold !text-white">訪問者数</h2>
      <p className="mt-6 rounded-2xl border border-slate-800 bg-slate-950/70 px-5 py-4 text-base font-medium text-slate-100">
        {visitorCount === null ? "Loading..." : visitorCount}
      </p>
    </section>
  );
}

async function updateVisitorCounter() {
  const apiBaseUrl = import.meta.env.VITE_API_BASE_URL;

  if (!apiBaseUrl) {
    throw new Error("VITE_API_BASE_URL is not defined");
  }

  const response = await fetch(apiBaseUrl, {
    method: "POST",
  });

  if (!response.ok) {
    throw new Error(`HTTP error: ${response.status}`);
  }

  const counter = await response.json();

  return counter["body"];
}

export default AutoCounter;
