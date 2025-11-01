document.addEventListener("DOMContentLoaded", () => {
  try {
    const now = new Date();
    const opBR = { day:"2-digit", month:"2-digit", year:"numeric", hour:"2-digit", minute:"2-digit" };
    const br = now.toLocaleDateString("pt-BR", opBR).replace(",", " -");
    const iso = now.toISOString().slice(0,10); // yyyy-mm-dd

    // Mostrar info abaixo do <h1> (opcional; mantém)
    const h1 = document.querySelector("h1");
    if (h1 && !document.getElementById("dataHora")) {
      const p = document.createElement("p");
      p.id = "dataHora";
      p.className = "text-gray-600 text-sm mb-4";
      p.textContent = `🕓 Data da avaliação: ${br}`;
      h1.insertAdjacentElement("afterend", p);
    }

    // Criar/atualizar campo oculto dataEnvio
    const form = document.querySelector("form");
    let hidden = document.querySelector(\'input[name="dataEnvio"]\');
    if (!hidden && form) {
      hidden = document.createElement("input");
      hidden.type = "hidden";
      hidden.name = "dataEnvio";
      form.appendChild(hidden);
    }
    const setHiddenFromISO = (isoStr) => {
      const d = new Date(isoStr+"T00:00:00");
      const s = d.toLocaleDateString("pt-BR", { day:"2-digit", month:"2-digit", year:"numeric" });
      const h = new Date().toLocaleTimeString("pt-BR", { hour:"2-digit", minute:"2-digit" });
      if (hidden) hidden.value = `${s} - ${h}`;
      const ph = document.getElementById("dataHora");
      if (ph) ph.textContent = `🕓 Data da avaliação: ${s} - ${h}`;
    };

    // Inserir campo visível "Data da avaliação" logo após o e-mail
    function insertDateField() {
      // tenta achar o input de e-mail por tipo ou label
      const emailInput =
        document.querySelector("input[type=email], input[name=email], input[name=e-mail]") ||
        Array.from(document.querySelectorAll("label"))
          .find(lb => /e-?mail/i.test(lb.textContent||""))?.htmlFor &&
        document.getElementById(Array.from(document.querySelectorAll("label"))
          .find(lb => /e-?mail/i.test(lb.textContent||""))?.htmlFor);

      if (!emailInput || emailInput.dataset.dateInjected === "1") return;

      const wrapper = document.createElement("div");
      wrapper.className = "mt-3";
      const label = document.createElement("label");
      label.setAttribute("for", "dataAvaliacao");
      label.className = "block text-sm font-medium mb-1";
      label.textContent = "Data da avaliação";
      const input = document.createElement("input");
      input.type = "date";
      input.id = "dataAvaliacao";
      input.name = "dataAvaliacao";
      input.value = iso; // pré-preenche hoje
      input.className = emailInput.className || "border rounded px-3 py-2 w-full";

      wrapper.appendChild(label);
      wrapper.appendChild(input);

      // insere logo depois do campo de e-mail
      emailInput.insertAdjacentElement("afterend", wrapper);
      emailInput.dataset.dateInjected = "1";

      // sincroniza com o oculto e com o cabeçalho
      setHiddenFromISO(input.value);
      input.addEventListener("change", () => setHiddenFromISO(input.value));
    }

    insertDateField();

    // fallback: se não achar e-mail, injeta no topo do form
    if (!document.getElementById("dataAvaliacao") && form) {
      const wrap = document.createElement("div");
      wrap.className = "mt-3";
      wrap.innerHTML = `
        <label for="dataAvaliacao" class="block text-sm font-medium mb-1">Data da avaliação</label>
        <input type="date" id="dataAvaliacao" name="dataAvaliacao" class="border rounded px-3 py-2 w-full" />
      `;
      form.insertAdjacentElement("afterbegin", wrap);
      document.getElementById("dataAvaliacao").value = iso;
      setHiddenFromISO(iso);
    }

    // garante atualização na submissão
    if (form) {
      form.addEventListener("submit", () => {
        const da = document.getElementById("dataAvaliacao");
        if (da && da.value) setHiddenFromISO(da.value);
      }, true);
    }
  } catch (e) {
    console.error("inject-date.js error:", e);
  }
});
