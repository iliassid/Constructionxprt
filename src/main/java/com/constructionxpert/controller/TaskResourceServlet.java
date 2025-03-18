package com.constructionxpert.controller;

import com.constructionxpert.dao.ResourceDao;
import com.constructionxpert.dao.TaskDao;
import com.constructionxpert.dao.TaskResourceDao;
import com.constructionxpert.model.Resource;
import com.constructionxpert.model.Task;
import com.constructionxpert.model.TaskResource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
@WebServlet(name = "TaskResourceServlet", urlPatterns = {
        "/tasks/resources/add", "/tasks/resources/edit", "/tasks/resources/update", "/tasks/resources/delete"
})
public class TaskResourceServlet  extends HttpServlet{


}