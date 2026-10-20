# Database Normalization Cheat Sheet (1NF to 5NF)

### 1NF (First Normal Form)
* **Rule:** Cells must contain atomic (single) values. No lists, arrays, or comma-separated sets of values within a single cell. Every row must be unique.
* **Usecase:** Building a clean, queryable foundational table where you can easily filter, count, or search specific data points without string manipulation.
* **Before 1NF:**

  | StudentID | Name | Courses |
  | :--- | :--- | :--- |
  | S101 | Ram | Java, Python, SQL |
* **After 1NF (Example):**

  | StudentID | Name | Course |
  | :--- | :--- | :--- |
  | S101 | Ram | Java |
  | S101 | Ram | Python |
  | S101 | Ram | SQL |

---

### 2NF (Second Normal Form)
* **Rule:** Must be in 1NF and have **No Partial Dependency**. If you have a composite primary key (a key made of multiple columns), every non-key column must depend on the *entire* key, not just a part of it.
* **Usecase:** Preventing data redundancy when tracking items with multi-part identifiers (like Order Details or Student Enrolments).
* **Before 2NF:** 
  *(Composite Key: StudentID + Subject)*

  | StudentID (Key) | Subject (Key) | Teacher | Teacher_Age |
  | :--- | :--- | :--- | :--- |
  | S101 | Math | Mr. Suresh | 45 |
  | S102 | Math | Mr. Suresh | 45 |
  *(Teacher info depends only on Subject, causing duplication every time a student registers for Math).*
* **After 2NF (Example):**
  **Table 1: Student_Subject**

  | StudentID | Subject |
  | :--- | :--- |
  | S101 | Math |
  | S102 | Math |

  **Table 2: Subject_Teacher**

  | Subject (Key) | Teacher | Teacher_Age |
  | :--- | :--- | :--- |
  | Math | Mr. Suresh | 45 |

---

### 3NF (Third Normal Form)
* **Rule:** Must be in 2NF and have **No Transitive Dependency**. A non-key column must not depend on another non-key column. Columns must depend "nothing but the key."
* **Usecase:** Keeping entities strictly distinct so that changing an attribute of a secondary object (like a department or a branch) doesn't require modifying individual employee rows.
* **Before 3NF:**
  *(Primary Key: StudentID)*

  | StudentID (Key) | Name | Center_Code | Center_Name |
  | :--- | :--- | :--- | :--- |
  | S101 | Ram | C01 | Chennai Tech |
  | S102 | Shiva | C01 | Chennai Tech |
  *(`Center_Name` relies on `Center_Code` [Non-Key], which then relies on `StudentID` [Key]. "Chennai Tech" gets duplicated).*
* **After 3NF (Example):**
  **Table 1: Student_Details**

  | StudentID (Key) | Name | Center_Code |
  | :--- | :--- | :--- |
  | S101 | Ram | C01 |
  | S102 | Shiva | C01 |

  **Table 2: Center_Details**

  | Center_Code (Key) | Center_Name |
  | :--- | :--- |
  | C01 | Chennai Tech |

---

### BCNF (Boyce-Codd Normal Form)
* **Rule:** A stricter extension of 3NF. For every functional dependency (X → Y), the left-hand side **X must always be a Super Key**. BCNF removes the 3NF loophole that allows a non-key to point to a piece of a key.
* **Usecase:** Systems featuring heavy scheduling constraints, booking assignments, or overlapping candidate keys (like assigning specific staff members to specific locations or projects).
* **Before BCNF:**
  *(Primary Key: StudentID + Subject. Rule: Each professor teaches only 1 subject).*

  | StudentID (Key) | Subject (Key) | Professor |
  | :--- | :--- | :--- |
  | S101 | Java | Prof. Rajesh |
  | S102 | Java | Prof. Rajesh |
  *(Dependency: `Professor` → `Subject`. This is valid in 3NF because Subject is part of the key. But `Professor` is NOT a super key on its own, which violates BCNF and repeats data).*
* **After BCNF (Example):**
  **Table 1: Student_Professor**

  | StudentID | Professor |
  | :--- | :--- |
  | S101 | Prof. Rajesh |
  | S102 | Prof. Rajesh |

  **Table 2: Professor_Subject**

  | Professor (Key) | Subject |
  | :--- | :--- |
  | Prof. Rajesh | Java |

---

### 4NF (Fourth Normal Form)
* **Rule:** Must be in BCNF and have **No Multi-Valued Dependency (MVD)**. You cannot store two entirely independent, one-to-many lists under a single primary key in the same table.
* **Usecase:** Managing multiple unrelated traits, skills, or hobbies belonging to a single user without generating exhausting, exponential row combinations.
* **Before 4NF:**
  *(A student plays multiple sports AND speaks multiple languages. Sports and languages are unrelated).*

  | StudentID (Key) | Sport (Key) | Language (Key) |
  | :--- | :--- | :--- |
  | S101 | Cricket | Tamil |
  | S101 | Cricket | English |
  | S101 | Football | Tamil |
  | S101 | Football | English |
  *(To keep this table accurate, you must artificially combine every sport with every language).*
* **After 4NF (Example):**
  **Table 1: Student_Sports**

  | StudentID | Sport |
  | :--- | :--- |
  | S101 | Cricket |
  | S101 | Football |

  **Table 2: Student_Languages**

  | StudentID | Language |
  | :--- | :--- |
  | S101 | Tamil |
  | S101 | English |

---

### 5NF (Fifth Normal Form)
* **Rule:** Must be in 4NF and have **No Join Dependency**. A table is in 5NF if it cannot be broken down into smaller tables without losing information or creating false data ("ghost rows") when joining them back together. 
* **Usecase:** Complex supply chain, manufacturing, or B2B platforms where strict 3-way cyclic business rules dictate exact operational allowances.
* **Before 5NF:**
  *(Rule: A supplier provides a product ONLY to specific brands they are paired with).*

  | Supplier | Product | Brand |
  | :--- | :--- | :--- |
  | Supplier A | Laptop | Brand X |
  | Supplier B | Mobile | Brand Y |
  | Supplier A | Mobile | Brand X |
  *(If you try to split this into only 2 tables, a SQL JOIN will mistakenly match Supplier A to Brand Y's Mobile, creating fake data. It requires a clean 3-way split).*
* **After 5NF (Example):**
  **Table 1: Supplier_Product**

  | Supplier | Product |
  | :--- | :--- |
  | Supplier A | Laptop |
  | Supplier A | Mobile |
  | Supplier B | Mobile |

  **Table 2: Product_Brand**

  | Product | Brand |
  | :--- | :--- |
  | Laptop | Brand X |
  | Mobile | Brand X |
  | Mobile | Brand Y |

  **Table 3: Supplier_Brand**

  | Supplier | Brand |
  | :--- | :--- |
  | Supplier A | Brand X |
  | Supplier B | Brand Y |
