package org.hqu.production_ms.domain;

public class Department {
    private String departmentId;

    private String departmentName;

    private String departmentDuty;

    private String note;

    public String getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(String departmentId) {
        this.departmentId = departmentId == null ? null : departmentId.trim();
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName == null ? null : departmentName.trim();
    }

    public String getDepartmentDuty() {
        return departmentDuty;
    }

    public void setDepartmentDuty(String departmentDuty) {
        this.departmentDuty = departmentDuty == null ? null : departmentDuty.trim();
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note == null ? null : note.trim();
    }
}