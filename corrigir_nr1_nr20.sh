#!/bin/bash
set -e
cd ~/nr-normas-regulamentadoras

mkdir -p assets/questions

# ---------- NR-20 (Inflamáveis e Combustíveis) ----------
cat > assets/questions/nr20.json <<'JSON'
[
  {"q":"A NR-20 trata de:", "a":["Eletricidade","Máquinas","Inflamáveis e combustíveis","Ergonomia"], "c":2},
  {"q":"Um objetivo central da NR-20 é:", "a":["Definir limites de ruído","Estabelecer requisitos para gestão da segurança com inflamáveis e combustíveis","Normatizar proteção de máquina","Tratar de postura e mobiliário"], "c":1},
  {"q":"No âmbito da NR-20, 'Análise de Risco' serve para:", "a":["Calcular folha de pagamento","Identificar perigos, avaliar riscos e propor controles","Avaliar conforto térmico","Definir compras"], "c":1},
  {"q":"Na NR-20, o Plano de Resposta a Emergências deve:", "a":["Ficar apenas arquivado","Prever ações, recursos e responsabilidades para emergências","Ser feito só após acidentes","Ser opcional"], "c":1},
  {"q":"Capacitação exigida pela NR-20:", "a":["Não há capacitação","Somente vídeo-aula, sem avaliação","Conforme nível (Básico/Intermediário/Avançado) e atividade","Somente prática"], "c":2},
  {"q":"Reciclagem na NR-20:", "a":["Nunca é obrigatória","Conforme periodicidade definida e mudança de risco/atividade","Apenas por troca de endereço","Somente por afastamento"], "c":1},
  {"q":"Medidas de controle típicas na NR-20 incluem:", "a":["EPC/EPI, procedimentos operacionais e PT","Somente EPI","Somente sinalização","Apenas registros"], "c":0},
  {"q":"Permissão de Trabalho (PT) na NR-20:", "a":["É documento para atividades críticas, emitido antes da execução","É o crachá do trabalhador","É apenas uma etiqueta de bloqueio","É um recibo de EPI"], "c":0},
  {"q":"Instalações com inflamáveis devem possuir:", "a":["Inventário de riscos e controles","Somente extintor portátil","Apenas treinamento inicial","Somente EPC"], "c":0},
  {"q":"Sobre GLP em áreas de consumo:", "a":["Dispensa controle de vazamentos","Cilindros devem ficar ventilados e afastados de fontes de ignição","Pode ser aquecido diretamente","Não precisa identificação"], "c":1},
  {"q":"Sinalização na NR-20:", "a":["Não se aplica","Deve indicar riscos, rotas de fuga, equipamentos e procedimentos","Serve apenas para decoração","Exclusiva para almoxarifado"], "c":1},
  {"q":"Integração com PGR/GRO (NR-1) na NR-20:", "a":["Inexistente","Necessária para consolidar perigos, avaliações e controles","Somente RH faz","É proibida"], "c":1}
]
JSON

# ---------- NR-1 (Disposições Gerais e GRO/PGR) ----------
cat > assets/questions/nr1.json <<'JSON'
[
  {"q":"A NR-1 define diretrizes gerais de SST e integra qual instrumento de gestão?", "a":["PCMSO","PPRA","PGR (no âmbito do GRO)","PPP"], "c":2},
  {"q":"O PGR é composto, essencialmente, por:", "a":["Inventário de Riscos e Plano de Ação","CAT e PPP","PCMSO e ASO","Apenas ficha de EPI"], "c":0},
  {"q":"Responsabilidades do empregador segundo a NR-1 incluem:", "a":["Fornecer EPIs e capacitação quando aplicável","Somente fiscalizar","Somente registrar acidentes","Apenas pagar adicional"], "c":0},
  {"q":"Quanto às responsabilidades do empregado:", "a":["Não usar EPI","Usar e conservar EPI, cumprir procedimentos e participar das capacitações","Vender EPI","Guardar em casa"], "c":1},
  {"q":"A avaliação de riscos no PGR deve:", "a":["Ser eventual e sem registro","Identificar perigos, avaliar riscos e definir medidas de controle","Somente copiar modelos","Ser delegada a qualquer trabalhador"], "c":1},
  {"q":"Registros do PGR:", "a":["Dispensáveis","Devem ser mantidos e atualizados, com evidências das avaliações e ações","Apenas verbais","Somente anuais"], "c":1},
  {"q":"Capacitação segundo NR-1 (quando aplicável):", "a":["Somente assinatura manual","Com conteúdos, carga mínima e avaliação, podendo ser EAD quando permitido","Apenas leitura de manual","Não prevista"], "c":1},
  {"q":"Integração PGR/GRO com demais NRs:", "a":["Inexistente","Obrigatória para consolidar controles e monitoramento","Somente para NR-10","Apenas para CIPA"], "c":1},
  {"q":"Mudança significativa no processo exige:", "a":["Nada","Revisão do PGR e, se necessário, nova avaliação e capacitação","Somente comunicado ao sindicato","Somente troca de EPI"], "c":1},
  {"q":"Monitoramento de riscos no PGR:", "a":["Não é necessário","Acompanha eficácia das medidas e atualiza o plano de ação","Apenas quando há acidente","Somente auditar anual"], "c":1},
  {"q":"Documentos que podem evidenciar o PGR incluem:", "a":["Logs e prints","Inventário de Riscos, Plano de Ação, registros de capacitação e PTs quando aplicáveis","Apenas crachá","Somente nota fiscal"], "c":1},
  {"q":"Quando as avaliações devem ser registradas no PGR?", "a":["Nunca","Sempre que houver identificação de perigos, mudanças ou periodicidade definida","Somente quando há acidente","Somente na admissão"], "c":1}
]
JSON

# Garante o quiz sem duplicar e exibindo 10 questões únicas
cat > assets/js/quiz.js <<'EOF'
(function(){
  const nomes = {
    nr1:"NR-1 – Disposições Gerais e GRO",
    nr20:"NR-20 – Inflamáveis e Combustíveis",
    nr33:"NR-33 – Espaço Confinado",
    nr35:"NR-35 – Trabalho em Altura",
    nr10:"NR-10 – Segurança em Eletricidade",
    nr05:"NR-05 – CIPA",
    nr06:"NR-06 – EPI"
  };
  const params = new URLSearchParams(location.search);
  const curso = (params.get("curso")||"nr1").toLowerCase();
  const cursoNome = nomes[curso] || curso.toUpperCase();

  const form = document.getElementById("quizForm");
  const btnEnviar = document.getElementById("btnEnviar");
  const btnComp  = document.getElementById("btnComprovante");
  const resultado = document.getElementById("resultado");
  const fldNome = document.getElementById("aluno");
  const fldCPF  = document.getElementById("cpf");
  const tag = document.getElementById("cursoTag"); if(tag) tag.textContent = cursoNome;

  const arquivo = `assets/questions/${curso}.json`;

  fetch(arquivo).then(r=>{
    if(!r.ok) throw new Error("Arquivo de questões não encontrado");
    return r.json();
  }).then(qs=>{
    // remove duplicadas por texto e limpa itens inválidos
    const vistos = new Set();
    const base = [];
    for(const it of qs){
      if(it && typeof it.q==="string" && Array.isArray(it.a) && it.a.length>=4 && Number.isInteger(it.c)){
        const chave = it.q.trim();
        if(!vistos.has(chave)){vistos.add(chave); base.push(it);}
      }
    }
    // embaralha e escolhe 10
    base.sort(()=>Math.random()-0.5);
    const chosen = base.slice(0, Math.min(10, base.length));

    chosen.forEach((item,idx)=>{
      const b = document.createElement("div");
      b.className="p-4 border rounded";
      b.innerHTML = `<p class="font-semibold mb-2">${idx+1}. ${item.q}</p>`+
        item.a.map((alt,i)=>`<label class="block"><input type="radio" name="q${idx}" value="${i}" class="mr-2"> ${String.fromCharCode(65+i)}) ${alt}</label>`).join("");
      form.appendChild(b);
    });

    btnEnviar.onclick = (e)=>{
      e.preventDefault();
      let acertos=0, resp=0;
      chosen.forEach((it,idx)=>{
        const v=(new FormData(form)).get("q"+idx);
        if(v!==null){resp++; if(+v===it.c) acertos++;}
      });
      const nota = Math.round((acertos/chosen.length)*100);
      const ok = nota>=70 && resp===chosen.length;
      resultado.textContent = `Acertos: ${acertos}/${chosen.length} — Nota: ${nota}% ${ok?"(APROVADO)":"(REPROVADO)"}${resp<chosen.length?" — Responda todas as questões.":""}`;

      if(ok){
        localStorage.setItem("cert_dados", JSON.stringify({
          curso: cursoNome, cod: curso, nota, data: new Date().toISOString(),
          aluno: (fldNome?.value||""), cpf: (fldCPF?.value||"")
        }));
        btnComp?.classList.remove("hidden");
      } else {
        btnComp?.classList.add("hidden");
      }
    };
  }).catch(err=>{
    resultado.className="mt-6 text-lg font-semibold text-red-600";
    resultado.textContent = "Não foi possível carregar as questões deste curso ("+err.message+").";
  });
})();
EOF

git add assets/questions/nr1.json assets/questions/nr20.json assets/js/quiz.js
git commit -m "Recria bancos NR-1 e NR-20 com 12 questões reais; força seleção de 10 únicas no quiz"
git push
echo "✅ Corrigido. Atualize o site (Ctrl+F5) e refaça NR-1 e NR-20."
