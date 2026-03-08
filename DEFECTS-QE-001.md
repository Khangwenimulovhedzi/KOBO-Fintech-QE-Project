<p align="center">
  <img src="https://img.shields.io/badge/KOBO_FINTECH-Defect_Report-DC143C?style=for-the-badge&labelColor=8B0000" alt="Kobo Fintech Defect Report" />
</p>

<h1 align="center">Defect Report – QE-001</h1>

<p align="center">
  <em>Insufficient Wallet Balance Still Allows Voucher Issuance</em>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Defects-1-red?style=flat-square" alt="1 Defect" />
  <img src="https://img.shields.io/badge/Severity-Critical-FF0000?style=flat-square" alt="Critical" />
  <img src="https://img.shields.io/badge/Status-Open-red?style=flat-square" alt="Open" />
</p>

---

## Defect Summary

| Field           | Detail                                                                       |
| :-------------- | :--------------------------------------------------------------------------- |
| **Defect ID**   | QE-001                                                                       |
| **Title**       | Voucher Issuance Allowed Despite Insufficient Wallet Balance                 |
| **Component**   | API Layer · `POST /api/v1/distribution/issue-voucher`                        |
| **Severity**    | ![Critical](https://img.shields.io/badge/-Critical-FF0000?style=flat-square) |
| **Status**      | ![Open](https://img.shields.io/badge/-Open-red?style=flat-square)            |
| **Reported**    | 2026-03-08                                                                   |
| **Environment** | `localhost:3000` · KoboFintech DB                                            |

---

## Description

The system allows voucher issuance even when the wallet balance is **lower than the product price**.
When testing a wallet with **R5.00 balance**, the system still allowed the purchase of a **R10 product** and returned a successful response (`201 Created`).

This indicates that the application **does not validate wallet balance before processing transactions**, which violates fundamental financial transaction rules.

---

## Steps to Reproduce

1. Open Swagger UI at `http://localhost:3000/api-docs`.
2. Expand **POST /api/v1/distribution/issue-voucher**.
3. Click **Try it out**.
4. Submit the following request:

```json
{
  "walletId": 10,
  "productId": 1,
  "reference": "TASK2-LOWBAL-001"
}
```

5. Click **Execute**.
6. Observe the API response.

---

## Expected vs Actual

<table>
<tr>
<td width="50%" valign="top">

### ✅ Expected

The API should **reject the transaction** and return an error indicating insufficient wallet balance.

Example response:

```json
{
  "status": "FAILED",
  "message": "Insufficient wallet balance"
}
```

Expected HTTP Status:

```
400 Bad Request
```

</td>
<td width="50%" valign="top">

### ❌ Actual

The API returned a **successful response** and issued a voucher PIN even though the wallet balance was insufficient.

HTTP Status:

```
201 Created
```

Response:

```json
{
  "status": "SUCCESS",
  "pin": "1499094182",
  "traceId": "83f075da-0721-47a4-a0bd-b0f6e0e80563"
}
```

</td>
</tr>
</table>

---

## Evidence

**Response from `POST /api/v1/distribution/issue-voucher`:**

```json
{
  "status": "SUCCESS",
  "pin": "1499094182",
  "traceId": "83f075da-0721-47a4-a0bd-b0f6e0e80563"
}
```

<p align="center">
  <img src="https://img.shields.io/badge/Wallet_Balance-R5.00-red?style=for-the-badge" alt="Low Balance" />
  <img src="https://img.shields.io/badge/Product_Price-R10.00-orange?style=for-the-badge" alt="Product Price" />
  <img src="https://img.shields.io/badge/Transaction-Allowed-green?style=for-the-badge" alt="Allowed" />
</p>

> The wallet had insufficient funds, yet the voucher was still issued.

---

## Business Impact

| Dimension          | Detail                                                                            |
| :----------------- | :-------------------------------------------------------------------------------- |
| **Financial**      | Users could obtain vouchers without sufficient funds, causing direct revenue loss |
| **Security**       | Attackers could exploit this flaw to generate unlimited vouchers                  |
| **Data Integrity** | Wallet balances and financial records become inaccurate                           |

---

## Impact Chain

```
No wallet balance validation
  → Voucher issued despite insufficient funds
    → Users obtain products without paying
      → Direct financial loss for Kobo Fintech
```

---

## Risk Assessment

|                              Likelihood                              |                                    Impact                                    |                                   Risk Level                                   |
| :------------------------------------------------------------------: | :--------------------------------------------------------------------------: | :----------------------------------------------------------------------------: |
| ![High](https://img.shields.io/badge/-High-FF4500?style=flat-square) | ![Critical](https://img.shields.io/badge/-Critical-FF0000?style=flat-square) | ![Critical](https://img.shields.io/badge/-●_Critical-FF0000?style=flat-square) |

> **Likelihood is High** because this endpoint processes every voucher purchase request.

---

## Recommended Fix

Add wallet balance validation before processing the transaction.

The API should return an appropriate response such as:

```
400 Bad Request
```

---

<p align="center">
  <img src="https://img.shields.io/badge/Report_Status-Complete-green?style=for-the-badge" alt="Complete" />
</p>

<p align="center">
  <em>This defect report was prepared as part of the Kobo Fintech Quality Engineering project.</em>
</p>
