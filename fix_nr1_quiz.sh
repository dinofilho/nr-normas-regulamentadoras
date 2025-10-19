#!/bin/bash
set -e
cd ~/nr-normas-regulamentadoras

# 1) Descobre a chave do gabarito usada no seu projeto (ex.: "ans" ou "correct")
SCHEMA_KEY=$(grep -hoE '"(ans|correct|gabarito|answer|resposta)"' assets/questions/*.json 2>/dev/null | head -n1 | tr -d '"')
[ -z "$SCHEMA_KEY" ] && SCHEMA_KEY="ans"   # fallback seguro

mkdir -p assets/questions
# 2) Backup (se existir)
[ -f assets/questions/nr1.json ] && cp -f assets/questions/nr1.json assets/questions/nr1.json.bak

# 3) Gera novo banco de questões NR-1 (10 itens), compatível com o schema detectado
cat > assets/questions/nr1.json <<JSON
[
  {"q":"A NR-1 estabelece disposições gerais de SST. Qual documento integra o GRO?","a":"PCMSO","b":"PPRA","c":"PGR","d":"PPP","$SCHEMA_KEY":"c"},
  {"q":"O PGR é composto por quais elementos principais?","a":"Relatório financeiro e PCMSO","b":"Inventário de riscos e plano de ação","c":"CIPA e PPP","d":"SIPAT e atas","$SCHEMA_KEY":"b"},
  {"q":"Na hierarquia de controles, qual opção vem antes do uso de EPI?","a":"Substituição/engenharia e EPC","b":"Treinamento apenas","c":"Cartazes informativos","d":"Nenhuma","$SCHEMA_KEY":"a"},
  {"q":"Quem é responsável por implementar e manter o PGR?","a":"Somente o empregado","b":"Somente a CIPA","c":"Empregador, com participação dos trabalhadores","d":"A prefeitura","$SCHEMA_KEY":"c"},
  {"q":"Capacitações previstas na NR-1 devem ter:","a":"Conteúdo, carga horária, avaliação e registros","b":"Apenas lista de presença","c":"Somente vídeo","d":"Apenas assinatura do RH","$SCHEMA_KEY":"a"},
  {"q":"Quando o EAD é aceitável segundo a NR-1?","a":"Nunca é aceitável","b":"Sempre sem critérios","c":"Conforme a NR específica e requisitos de avaliação/registro","d":"Somente se for gratuito","$SCHEMA_KEY":"c"},
  {"q":"Inventário de riscos do PGR deve:","a":"Citar perigos, avaliar riscos e indicar controles","b":"Apresentar fotos apenas","c":"Conter apenas estatísticas","d":"Tratar só riscos ergonômicos","$SCHEMA_KEY":"a"},
  {"q":"Registros da avaliação do treinamento devem:","a":"Ser verbais","b":"Ser guardados conforme prazos e disponíveis para auditoria","c":"Ser descartados ao fim do dia","d":"Ficar com o aluno","$SCHEMA_KEY":"b"},
  {"q":"Integração entre PGR e outras NRs significa:","a":"Cada NR isolada, sem conexão","b":"PGR orienta controles e capacitações das NRs aplicáveis","c":"Apenas CIPA cuida disso","d":"Não se aplica","$SCHEMA_KEY":"b"},
  {"q":"Revisões do PGR devem ocorrer:","a":"A cada 20 anos","b":"Somente após multa","c":"Periodicamente e quando houver mudanças relevantes","d":"Nunca","$SCHEMA_KEY":"c"}
]
JSON

# 4) Garante que o botão “Fazer Avaliação” da NR-1 aponta para o quiz
if grep -q 'quiz.html' nr1.html; then
  true
else
  sed -i '0,/<main[^>]*>/s//&\n<a class="inline-block bg-blue-700 text-white px-5 py-3 rounded-xl mr-3" href="quiz.html?curso=nr1">Fazer Avaliação<\/a>\n/' nr1.html || true
fi

git add assets/questions/nr1.json nr1.html
git commit -m "NR-1: recriado banco de questões válido e garantido link para avaliação"
git push
echo "✅ NR-1 pronta. Recarregue a página da NR-1 (Ctrl+F5) e faça a avaliação."
