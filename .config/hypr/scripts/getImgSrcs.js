  const urls = Array.from(document.querySelectorAll('img.imagen-busqueda'))
    .map(img => img.src)
    .filter(src => src && src.includes('engl'))
    .map(src => src.replace('--thumb', ''));

  const blob = new Blob([urls.join('\n') + '\n'], { type: 'text/plain' });
  const a = document.createElement('a');
  a.href = URL.createObjectURL(blob);
  a.download = 'qb_links.js';
  document.body.appendChild(a);
  a.click();
  a.remove();
  URL.revokeObjectURL(a.href);
