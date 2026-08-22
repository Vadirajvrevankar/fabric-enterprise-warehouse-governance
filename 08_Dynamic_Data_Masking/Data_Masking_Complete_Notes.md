# Dynamic Data Masking (DDM)

## 1. Definition

**Dynamic Data Masking (DDM)** is a data-security technique that hides or obfuscates sensitive values when data is returned to users who should not see the original value.

The underlying data remains unchanged.

> **Data Masking = Controls how sensitive data is displayed.**

---

## 2. Why Data Masking Is Used

Data masking is used to:

- Protect sensitive information
- Reduce exposure of confidential data
- Support least-privilege security
- Protect data in development and testing environments
- Limit exposure of personally identifiable information (PII)
- Protect financial and business-sensitive information

Examples:

- Phone numbers
- Email addresses
- Credit card numbers
- National identification numbers
- Salary
- Customer information

---

## 3. Simple Example

Actual data:

```text
CustomerName | PhoneNumber
-------------|------------
Rahul        | 9876543210
```

Masked display:

```text
CustomerName | PhoneNumber
-------------|------------
Rahul        | **********
```

The actual value remains stored in the database.

---

## 4. Important Concept

DDM generally does **not encrypt or permanently modify the stored value**.

Conceptually:

```text
Database
   ↓
Actual value: 9876543210
   ↓
User queries data
   ↓
Masking rule
   ↓
Displayed value: **********
```

Therefore:

```text
Stored Data ≠ Displayed Data
```

for a user affected by the masking rule.

---

## 5. Real-World Company Example

A company has a customer table:

```text
CustomerID | CustomerName | PhoneNumber | Email
-----------|--------------|-------------|----------------
101        | Rahul        | 9876543210  | rahul@email.com
```

A support employee may need to identify the customer but may not need the complete phone number or email.

The application could display:

```text
CustomerID | CustomerName | PhoneNumber | Email
-----------|--------------|-------------|----------------
101        | Rahul        | **********  | r****@email.com
```

The original data remains stored securely.

---

## 6. Data Masking vs Encryption

### Data Masking

Changes how data is presented to a user affected by the masking rule.

```text
Stored value
    ↓
Masking
    ↓
Masked display
```

### Encryption

Transforms data into an encrypted representation that requires decryption to recover the original value.

```text
Original data
    ↓
Encryption
    ↓
Encrypted data
```

Easy memory:

```text
Masking    → Hide the display
Encryption → Cryptographically protect data
```

---

## 7. Data Masking vs CLS

### CLS

Column-Level Security controls whether the user can access a column.

```text
Salary
  ↓
No permission
  ↓
Access denied
```

### Masking

The user may query the column, but the returned value can be masked.

```text
Salary
  ↓
Access allowed
  ↓
*****
```

Remember:

```text
CLS     → Can I access the COLUMN?
Masking → What VALUE do I see?
```

---

## 8. Data Masking vs RLS

### RLS

Controls which rows are visible.

```text
User
 ↓
Sales table
 ↓
Only user's region rows
```

### Masking

Controls how sensitive values are displayed.

```text
User
 ↓
Customer table
 ↓
Phone number → masked
```

Remember:

```text
RLS     → Which ROWS?
Masking → Which VALUE is displayed?
```

---

## 9. Data Masking vs OLS

### OLS

Controls access to an object.

```text
Payroll table
     ↓
No access
```

### Masking

Allows access to the object while hiding a sensitive value according to the masking mechanism.

```text
Payroll table
     ↓
Salary → *****
```

Remember:

```text
OLS     → OBJECT
Masking → VALUE DISPLAY
```

---

## 10. Common Masking Patterns

Different platforms support different masking mechanisms and syntax.

### Full Mask

```text
9876543210
    ↓
**********
```

### Partial Mask

```text
9876543210
    ↓
******3210
```

### Email Masking

```text
rahul@gmail.com
      ↓
r****@gmail.com
```

### Randomized Number

```text
80000
  ↓
47291
```

The exact syntax and available masking functions depend on the database platform.

---

## 11. Dynamic Nature of Masking

The word **Dynamic** means the underlying data does not need to be changed just to display a masked value.

Conceptually:

```text
Stored value
     ↓
80000
```

For a user affected by masking:

```text
*****
```

For a privileged user, the original value may be visible depending on the platform and permissions:

```text
80000
```

The database still stores:

```text
80000
```

---

## 12. Privileged Users

Security systems commonly provide mechanisms for specific privileged users or roles to see unmasked data.

Conceptually:

```text
Normal User
     ↓
Masked value

Privileged User
     ↓
Original value
```

The exact behavior depends on the database platform and permission model.

---

## 13. Least Privilege

Data masking supports the principle of least privilege.

Example:

```text
Support Analyst
     ↓
Customer name → visible
Phone number  → masked
Credit card   → masked
```

The employee can perform their job without receiving unnecessary sensitive information.

---

## 14. Data Masking in Development

Data masking is particularly useful in non-production environments.

Example:

```text
Production
     ↓
Real customer data
     ↓
Masking / protected copy
     ↓
Development
```

Developers can work with realistic datasets while reducing exposure of sensitive information.

---

## 15. Important Limitation

Data masking should **not automatically be treated as complete data protection**.

Masking does not replace:

- Encryption
- Authentication
- Authorization
- Network security
- Auditing
- Data classification
- Secure application design

A complete security architecture normally uses multiple controls.

---

## 16. Security Layer Comparison

```text
OLS
 ↓
Which OBJECT can I access?

RLS
 ↓
Which ROWS can I access?

CLS
 ↓
Which COLUMNS can I access?

Masking
 ↓
How is the VALUE displayed?

Encryption
 ↓
How is the DATA protected cryptographically?
```

This distinction is important for interviews.

---

## 17. Azure Data Engineer Perspective

A Data Engineer should understand:

- Why sensitive data needs masking
- Difference between masking and encryption
- Difference between masking and CLS
- Difference between masking and RLS
- Least privilege
- Privileged/unmasked access
- Development/test data protection
- Platform-specific masking capabilities
- How to validate masking behavior

The exact implementation should be checked against the Azure service being used because masking capabilities and syntax vary across Azure data services.

---

## 18. Interview Definition

> **Dynamic Data Masking is a data-security mechanism that limits exposure of sensitive information by returning a masked representation of the value to users who are not permitted to see the original value, while leaving the underlying stored data unchanged.**

---

## 19. Interview Questions

### Q1. What is Dynamic Data Masking?

It hides sensitive values from users by displaying a masked representation instead of the original value.

### Q2. Does masking change the stored data?

Generally, no. Masking affects how data is returned or displayed.

### Q3. Masking vs encryption?

Masking hides data from certain users during access/display, while encryption cryptographically protects data.

### Q4. Masking vs CLS?

CLS controls whether a user can access a column. Masking controls how the sensitive value is presented.

### Q5. Masking vs RLS?

RLS controls which rows are returned. Masking controls the representation of sensitive values.

### Q6. Why is masking useful in development?

It reduces exposure of real sensitive information while allowing developers/testers to work with realistic data.

### Q7. Does masking replace encryption?

No. They solve different security problems and can be used together.

### Q8. What is least privilege?

Giving a user only the access required for their job.

### Q9. Can privileged users see unmasked data?

Depending on the platform and permissions, privileged users may be able to see the original values.

### Q10. What should you verify before implementing masking?

Verify that the specific Azure service/database engine supports the required masking feature and syntax.

---

## 20. Key Points to Remember

```text
Masking
   ↓
Protects sensitive value exposure
   ↓
Underlying data remains unchanged
```

Remember:

```text
OLS        → OBJECT
RLS        → ROW
CLS        → COLUMN
Masking    → VALUE DISPLAY
Encryption → CRYPTOGRAPHIC PROTECTION
```

Most important sentence:

> **Data Masking controls how sensitive data is displayed without necessarily changing the underlying stored value.**

---

## 21. Practical Learning Flow

```text
Understand Masking
       ↓
Create Demo Sensitive Data
       ↓
Identify Sensitive Column
       ↓
Configure Supported Masking Mechanism
       ↓
Verify Masked Result
       ↓
Verify Original/Privileged Result
       ↓
Take Screenshots
       ↓
Create SQL File
       ↓
Create README
       ↓
Git Commit
```

---

## 22. Final Summary

Data Masking is a security technique used to reduce exposure of sensitive values.

Example:

```text
Actual:
9876543210

Masked:
**********
```

The most important distinction is:

```text
OLS        → Which OBJECT can I access?
RLS        → Which ROWS can I access?
CLS        → Which COLUMNS can I access?
Masking    → Which VALUE do I see?
Encryption → How is the DATA cryptographically protected?
```

## Technologies

- SQL
- Azure Data Services
- Dynamic Data Masking
- Database Security
- Database Roles
- Permissions
- Data Privacy
- Git
- GitHub
