// app.js

const groupID = '5360829'; // Puedes usar tu ID de usuario si es una biblioteca personal
const zoteroDataDiv = document.getElementById('zotero-data');

fetch(`https://api.zotero.org/groups/${groupID}/items/top?direction=desc&format=json&sort=dateAdded`)
  .then(response => response.json())
  .then(data => {
    displayZoteroData(data);
  })
  .catch(error => console.error('Error al obtener datos de Zotero:', error));

function displayZoteroData(data) {
  // Procesa y muestra los datos en el div
  // Puedes adaptar esta función según cómo quieras mostrar los datos
  // ...

  // Por ejemplo, puedes agregar elementos de lista con los títulos de los elementos
  const ulElement = document.createElement('ul');
  data.forEach(item => {
    const liElement = document.createElement('li');
    liElement.textContent = item.data.title;
    ulElement.appendChild(liElement);
  });

  zoteroDataDiv.appendChild(ulElement);
}
