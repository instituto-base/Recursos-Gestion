// app.js

const groupID = '5360829'; // Puedes usar tu ID de usuario si es una biblioteca personal
const zoteroDataDiv = document.getElementById('zotero-data');

fetch(`https://api.zotero.org/groups/5360829/items/top?direction=desc&format=atom&sort=date`)
  .then(response => response.json())
  .then(data => {
    displayZoteroData(data);
  })
  .catch(error => console.error('Error al obtener datos de Zotero:', error));

function displayZoteroData(data) {
  // Procesa y muestra los datos en el div
  // Puedes adaptar esta función según cómo quieras mostrar los datos
  // ...

  // Crear una lista para mostrar los elementos
  const ulElement = document.createElement('ul');

  data.forEach(item => {
    // Crear un elemento de lista para cada artículo
    const liElement = document.createElement('li');

    // Mostrar título
    const titleElement = document.createElement('strong');
    titleElement.textContent = item.data.title;
    liElement.appendChild(titleElement);

     // Mostrar autores
    if (item.data.creators) {
      const authorsElement = document.createElement('p');
      const authorNames = item.data.creators.map(creator => creator.lastName + ', ' + creator.firstName).join(', ');
      authorsElement.textContent = `Autores: ${authorNames}`;
      liElement.appendChild(authorsElement);
    }

    // Mostrar revista
    if (item.data.publicationTitle) {
      const journalElement = document.createElement('p');
      journalElement.textContent = `Revista: ${item.data.publicationTitle}`;
      liElement.appendChild(journalElement);
    }

    // Mostrar resumen
    if (item.data.abstractNote) {
      const abstractElement = document.createElement('p');
      abstractElement.textContent = `Resumen: ${item.data.abstractNote}`;
      liElement.appendChild(abstractElement);
    }
 // Mostrar DOI
    if (item.data.DOI) {
      const doiElement = document.createElement('p');
      doiElement.textContent = `DOI: ${item.data.DOI}`;
      liElement.appendChild(doiElement);
    }
    // Agregar el elemento de lista al elemento principal
    ulElement.appendChild(liElement);
  });

  // Agregar la lista al div en la página
  zoteroDataDiv.appendChild(ulElement);
}
