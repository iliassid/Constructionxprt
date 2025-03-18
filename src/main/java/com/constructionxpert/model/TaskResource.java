//TaskResource.java (Model)
package com.constructionxpert.model;
import java.sql.Timestamp;
public class TaskResource {

    private int taskResourceId;
    private int taskId;
    private int resourceId;
    private int quantityNeeded;
    private Timestamp assignedAt;
    //constructors , getters and setters

    public TaskResource() {
    }

    public TaskResource(int taskResourceId, int taskId, int resourceId, int quantityNeeded, Timestamp assignedAt) {
        this.taskResourceId = taskResourceId;
        this.taskId = taskId;
        this.resourceId = resourceId;
        this.quantityNeeded = quantityNeeded;
        this.assignedAt = assignedAt;
    }

    public int getTaskResourceId() {
        return taskResourceId;
    }

    public void setTaskResourceId(int taskResourceId) {
        this.taskResourceId = taskResourceId;
    }

    public int getTaskId() {
        return taskId;
    }

    public void setTaskId(int taskId) {
        this.taskId = taskId;
    }

    public int getResourceId() {
        return resourceId;
    }

    public void setResourceId(int resourceId) {
        this.resourceId = resourceId;
    }

    public int getQuantityNeeded() {
        return quantityNeeded;
    }

    public void setQuantityNeeded(int quantityNeeded) {
        this.quantityNeeded = quantityNeeded;
    }

    public Timestamp getAssignedAt() {
        return assignedAt;
    }

    public void setAssignedAt(Timestamp assignedAt) {
        this.assignedAt = assignedAt;
    }
}