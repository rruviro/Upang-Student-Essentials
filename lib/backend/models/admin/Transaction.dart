class TransactionStatus {
  final String consumer;
  final String studentID;
  final String imageUrl;
  final String reservedDate;
  final String status;
  final category;
  const TransactionStatus(this.consumer, this.studentID, this.imageUrl, this.reservedDate, this.status, this.category);
}

List<TransactionStatus> products = [
  TransactionStatus(
    'Ramon Montenegro', 
    '01-1234-123456', 
    'https://1.bp.blogspot.com/-dHN4KiD3dsU/XRxU5JRV7DI/AAAAAAAAAz4/u1ynpCMIuKwZMA642dHEoXFVKuHQbJvwgCEwYBhgL/s1600/qr-code.png', 
    '14/08/2024',
    'Request',
    1
  ),
  TransactionStatus(
    'Ramon Montenegro', 
    '01-1234-123456', 
    'https://1.bp.blogspot.com/-dHN4KiD3dsU/XRxU5JRV7DI/AAAAAAAAAz4/u1ynpCMIuKwZMA642dHEoXFVKuHQbJvwgCEwYBhgL/s1600/qr-code.png', 
    '14/08/2024',
    'Reserved',
    2
  ),
  TransactionStatus(
    'Ramon Montenegro', 
    '01-1234-123456', 
    'https://1.bp.blogspot.com/-dHN4KiD3dsU/XRxU5JRV7DI/AAAAAAAAAz4/u1ynpCMIuKwZMA642dHEoXFVKuHQbJvwgCEwYBhgL/s1600/qr-code.png', 
    '14/08/2024',
    'Pending',
    3
  ),
  TransactionStatus(
    'Ramon Montenegro', 
    '01-1234-123456', 
    'https://1.bp.blogspot.com/-dHN4KiD3dsU/XRxU5JRV7DI/AAAAAAAAAz4/u1ynpCMIuKwZMA642dHEoXFVKuHQbJvwgCEwYBhgL/s1600/qr-code.png', 
    '14/08/2024',
    'Complete',
    4
  ),
];