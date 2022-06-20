from fastapi import FastAPI
app=FastAPI()
students={
    1:{
        "name":"john",
        "age":14,
        "class":"year 12"
    }
}

@app.get("/")
def index():
    return{"name":"first  data"}
@app.get("/get-student/{student_id}")
def get_student(student_id:int):
    return students[student_id]