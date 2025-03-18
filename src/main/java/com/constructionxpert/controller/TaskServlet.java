//TaskServlet.java
package com.constructionxpert.controller;

import com.constructionxpert.dao.ProjectDao;
import com.constructionxpert.dao.TaskDao;
import com.constructionxpert.model.Project;
import com.constructionxpert.model.Task;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "TaskServlet", urlPatterns = {
        "/tasks", "/tasks/add", "/tasks/edit", "/tasks/update", "/tasks/delete"
})
public class TaskServlet extends HttpServlet {


}