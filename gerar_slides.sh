#!/bin/bash
set -e
mkdir -p slides
cat > slides/nr35.html <<HTML
<!DOCTYPE html>
<html lang="pt-br">
<meta charset="utf-8">
<title>NR-35 - Trabalho em Altura</title>
<style>
body{font-family:sans-serif;margin:0;padding:20px;background:#f7f8fa;color:#111}
h1{color:#005c99}h2{color:#004466}
.card{background:#fff;padding:15px;border-radius:10px;margin:15px 0;box-shadow:0 2px 6px rgba(0,0,0,0.1)}
</style>
<h1>NR-35 – Trabalho em Altura</h1>
<div class="card"><h2>Planejamento</h2>
<ul>
<li>Identificação de riscos e condições impeditivas (chuva, vento, eletricidade, etc.).</li>
<li>Planejamento e análise de risco antes da execução.</li>
<li>Inspeção de EPI e área antes do início do trabalho.</li>
</ul></div>
<div class="card"><h2>EPIs e Sistemas</h2>
<ul>
<li>Cinturão paraquedista, talabarte com absorvedor, trava-quedas.</li>
<li>Verificação de ancoragens certificadas e linha de vida.</li>
<li>Evitar improvisos e sobreposição de cordas.</li>
</ul></div>
<div class="card"><h2>Escadas e Plataformas</h2>
<ul>
<li>Escada reta fixada, ultrapassando 1m do piso superior.</li>
<li>Escada marinheiro com uso de trava-quedas guiado.</li>
<li>Proibido transporte de cargas manuais durante subida.</li>
</ul></div>
<div class="card"><h2>Resgate e Emergência</h2>
<ul>
<li>Plano de resgate prévio com simulado periódico.</li>
<li>Equipamentos de içamento, maca e sistema de resgate.</li>
</ul></div>
</html>
HTML

cat > slides/index.html <<HTML
<!DOCTYPE html>
<html lang="pt-br"><meta charset="utf-8">
<title>Slides das NRs</title>
<body style="font-family:sans-serif;padding:20px">
<h1>Slides • Conteúdos Programáticos</h1>
<ul>
<li><a href="nr35.html">NR-35 – Trabalho em Altura</a></li>
</ul>
</body></html>
HTML
