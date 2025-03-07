---
title: PenguMagic

summary: A C# Powered Web Application with Blazor
draft: false

dev: true
---

The **PenguMagic** project was born from my desire to dive into the world of Blazor and see how far I could push its capabilities for building modern web applications using C#. As a developer with experience primarily in JavaScript, I wanted to explore the power of Blazor, which allows you to build rich, interactive web UIs with C# instead of JavaScript. The motivation behind PenguMagic was simple: I wanted to build a dynamic, single-page application (SPA) entirely in C#—from the backend to the frontend—while taking full advantage of Blazor’s seamless integration with ASP.NET Core and WebAssembly.

One of the key architectural decisions I made was to use **Blazor WebAssembly** for the frontend. This choice enabled the application to run in the browser with C# code compiled to WebAssembly, meaning I didn't have to rely on JavaScript for handling the frontend logic. For the backend, I chose **ASP.NET Core** for its robust API capabilities and easy integration with Blazor. This combination created a solid foundation for PenguMagic, ensuring that the application was both highly performant and easy to maintain. Here's a simple Blazor component that fetches user data from an API:

```csharp
@page "/users"
@inject HttpClient Http

<h3>Users</h3>
<ul>
    @foreach (var user in users)
    {
        <li>@user.Name</li>
    }
</ul>

@code {
    private List<User> users;

    protected override async Task OnInitializedAsync()
    {
        users = await Http.GetFromJsonAsync<List<User>>("api/users");
    }

    public class User
    {
        public string Name { get; set; }
    }
}
```

A major challenge was **handling state management** efficiently, especially in a SPA context where maintaining state across pages is crucial. In Blazor, state can be managed either locally within components or using a shared service. For PenguMagic, I chose to use a **state container** service to manage global state across the app. This allowed me to share state such as user information and preferences between components, making it easier to build a consistent and responsive UI.

As I developed PenguMagic, I learned a lot about **C# in the browser**. It was fascinating to see how Blazor could run directly in the browser via WebAssembly, providing the same performance and interaction you would expect from traditional JavaScript-driven SPAs. Another valuable lesson was how **code sharing** between the client and server can simplify development. Since both sides of the application are written in C#, I was able to reuse models and validation logic, significantly reducing the amount of duplicate code and streamlining the development process.

In conclusion, **PenguMagic** was an enjoyable journey into the world of Blazor, where I had the opportunity to create a modern, fully-featured web application using just C#. The combination of Blazor WebAssembly for the frontend and ASP.NET Core for the backend proved to be a powerful pairing, and I learned valuable lessons about C#’s potential in web development. As I continue to explore Blazor and expand PenguMagic, I’m excited to see how the framework evolves and what new possibilities it will bring for developers like me who are eager to embrace a C#-driven web development world.