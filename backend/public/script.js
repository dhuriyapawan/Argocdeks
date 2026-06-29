const loadBlogs = async () => {
  const res = await fetch('/api/blogs');
  const blogs = await res.json();
  const container = document.getElementById('blog-list');
  container.innerHTML = blogs
    .map(
      (blog) => `
      <article class="blog-card">
        <h2>${blog.title}</h2>
        <small>By ${blog.author}</small>
        <p>${blog.content}</p>
      </article>
    `
    )
    .join('');
};

loadBlogs();
