window.addEventListener("trix-file-accept", function(event) {
  const acceptedTypes = ['image/jpeg', 'image/png']
  const maxFileSize = 2048 * 2048;
  if (!acceptedTypes.includes(event.file.type)) {
    event.preventDefault();
    alert('Only JPEG and PNG attachments are allowed!');
  } else if (event.file.size > maxFileSize) {
    event.preventDefault();
    alert('Attachment size exceeds 2MB!');
  }
});
