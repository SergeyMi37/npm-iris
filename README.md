# NPM By IRIS - No Project Mess By IRIS

No Project Mess is a simple app to help developers and small business companies deal with "Real World" problems in projects and tasks management.

Offering different views to task management, like a spreadsheet, kanban, scheduler, or even Gantt!

## Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

## Installation

1. Clone/git pull the repo into any local directory

```
$ git clone https://github.com/diashenrique/npm-iris.git
```

2. Open the terminal in this directory and run:

```
$ docker-compose build
```

3. Run the IRIS container with your project:

```
$ docker-compose up -d
```

## Testing the Application

Open URL http://localhost:52773/npm/home.csp

The foundation of this project are the following pages:

- User
- Project
- Tasks

Those pages are the base for everything else.

Scheduler, Kanban, and Gantt are just different views from the same tasks that are created in the Task page.

### Initial Setup

#### Projects

The first thing you should do it adds a new project.

![Add Project](https://raw.githubusercontent.com/diashenrique/npm-iris/master/images/addProject.png)

The Daily Working Hours is the field that you **should** inform how many hours your project will have. This field it's used for calculation in Tasks.

![Project Form](https://raw.githubusercontent.com/diashenrique/npm-iris/master/images/projectForm.png)

#### Users

The second thing you **should** create it's the users that will be working on this project. Well, because someone has to do it the tasks, right?!

![Add User](https://raw.githubusercontent.com/diashenrique/npm-iris/master/images/addUser.png)

![User Form](https://raw.githubusercontent.com/diashenrique/npm-iris/master/images/userForm.png)

#### Tasks

The task view it's easy to use as filling cells in an Excel spreadsheet.

![Tasks](https://raw.githubusercontent.com/diashenrique/npm-iris/master/images/tasks.png)

#### Scheduler

Scheduler view gives you the option to see your tasks as appointments, in the week, month, and Agenda viewer, acting as a Google Calendar clone.

![Scheduler](https://raw.githubusercontent.com/diashenrique/npm-iris/master/images/scheduler.png)

#### Kanban

For those who prefers deal with the tasks in a Kanban Style, this view it's perfect to do it.

![Kanban](https://raw.githubusercontent.com/diashenrique/npm-iris/master/images/kanban.png)

You can move the tasks around the phases (Backlog, To-Do, In-Progress, Done, Accepted),  and change their progress (%).

![Kanban](https://raw.githubusercontent.com/diashenrique/npm-iris/master/images/kanbanDetail.png)

#### Gantt

Finally, for the Project Managers out there, looking forward to follow the project in real time, using a MS Project style, this view is for you!

![Gantt](https://raw.githubusercontent.com/diashenrique/npm-iris/master/images/gantt.png)

## Roadmap

I created a project in Github to share my ideas to improve this application. If you want to collaborate with some ideas, you are very welcome!  

[Brainstorming New Features / Improvements](https://github.com/diashenrique/npm-iris/projects/2)

## Other information

The project was created as a Technology Example using the possibilities provided by InterSystems IRIS.

The library used for this demo, DevExtreme, it's free to use and to develop non-commercial applications.

For specific feature availability and license restrictions, please, visit the website to the product feature [comparison](https://js.devexpress.com/Buy/), and the [DevExtreme Non-Commercial, Non-Competitive License Agreement](https://js.devexpress.com/EULAs/DevExtremeNonCommercial/), respectively.
