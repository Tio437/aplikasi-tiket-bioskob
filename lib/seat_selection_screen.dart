import 'package:flutter/material.dart';
import 'movie_model.dart';

class SeatSelectionScreen extends StatefulWidget {
  final Movie movie;

  const SeatSelectionScreen({super.key, required this.movie});

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  final Color primaryGreen = const Color(0xFF072A1D);
  final Color goldAccent = const Color(0xFFD4AF37);
  final int rows = 8;
  final int cols = 10;
  final Set<String> selectedSeats = {};
  
  // Hardcoded booked seats for demo purposes
  final Set<String> bookedSeats = {'B3', 'B4', 'D5', 'D6', 'F7', 'F8'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Pilih Kursi Bioskop',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryGreen,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Movie Title Banner
          Container(
            color: primaryGreen.withOpacity(0.05),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            width: double.infinity,
            child: Column(
              children: [
                Text(
                  widget.movie.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryGreen,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'Harga Tiket: Rp 50.000 / Kursi',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Cinema Screen Representation
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 6,
                decoration: BoxDecoration(
                  color: primaryGreen,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: primaryGreen.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'LAYAR UTAMA',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // Seat Grid
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: List.generate(rows, (rIndex) {
                  final rowLabel = String.fromCharCode(65 + rIndex); // A, B, C...
                  
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Row Label Left
                        Container(
                          width: 24,
                          alignment: Alignment.center,
                          child: Text(
                            rowLabel,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryGreen.withOpacity(0.6),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        
                        // Seats
                        Row(
                          children: List.generate(cols, (cIndex) {
                            final seatId = '$rowLabel${cIndex + 1}';
                            final isBooked = bookedSeats.contains(seatId);
                            final isSelected = selectedSeats.contains(seatId);
                            
                            // Add gap in the middle of cinema seats
                            final isMiddleGap = cIndex == 5;

                            return Row(
                              children: [
                                if (isMiddleGap) const SizedBox(width: 20),
                                GestureDetector(
                                  onTap: isBooked
                                      ? null
                                      : () {
                                          setState(() {
                                            if (isSelected) {
                                              selectedSeats.remove(seatId);
                                            } else {
                                              selectedSeats.add(seatId);
                                            }
                                          });
                                        },
                                  child: Container(
                                    width: 26,
                                    height: 26,
                                    margin: const EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                      color: isBooked
                                          ? Colors.grey[300]
                                          : isSelected
                                              ? goldAccent
                                              : Colors.white,
                                      border: Border.all(
                                        color: isBooked
                                            ? Colors.grey[400]!
                                            : isSelected
                                                ? goldAccent
                                                : primaryGreen,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${cIndex + 1}',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: isBooked
                                            ? Colors.grey[600]
                                            : isSelected
                                                ? Colors.white
                                                : primaryGreen,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                        
                        const SizedBox(width: 8),
                        // Row Label Right
                        Container(
                          width: 24,
                          alignment: Alignment.center,
                          child: Text(
                            rowLabel,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryGreen.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),

          // Legend
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem(Colors.white, primaryGreen, 'Tersedia'),
                const SizedBox(width: 20),
                _buildLegendItem(goldAccent, goldAccent, 'Dipilih'),
                const SizedBox(width: 20),
                _buildLegendItem(Colors.grey[300]!, Colors.grey[400]!, 'Terisi'),
              ],
            ),
          ),

          // Bottom Bar showing Summary and Action Button
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kursi Terpilih',
                            style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            selectedSeats.isEmpty
                                ? '-'
                                : selectedSeats.join(', '),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryGreen,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Total Pembayaran',
                            style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Rp ${(selectedSeats.length * 50000).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: goldAccent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: selectedSeats.isEmpty
                          ? null
                          : () {
                              _showReceiptDialog(context);
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        disabledBackgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: selectedSeats.isEmpty ? Colors.transparent : goldAccent,
                            width: 1.5,
                          ),
                        ),
                      ),
                      child: Text(
                        'Konfirmasi Pembayaran',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: selectedSeats.isEmpty ? Colors.grey[600] : Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color bgColor, Color borderColor, String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(color: borderColor, width: 1.5),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: Colors.black87),
        ),
      ],
    );
  }

  void _showReceiptDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 10,
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: goldAccent,
                  size: 72,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Transaksi Berhasil!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF072A1D),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tiket Anda berhasil dipesan.',
                  style: TextStyle(color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                const Divider(height: 32, thickness: 1.5),
                // Ticket Detail
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Film', style: TextStyle(fontWeight: FontWeight.w500)),
                    Expanded(
                      child: Text(
                        widget.movie.title,
                        textAlign: TextAlign.right,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Kursi', style: TextStyle(fontWeight: FontWeight.w500)),
                    Text(
                      selectedSeats.join(', '),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Pembayaran', style: TextStyle(fontWeight: FontWeight.w500)),
                    Text(
                      'Rp ${(selectedSeats.length * 50000).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                      style: TextStyle(fontWeight: FontWeight.bold, color: goldAccent),
                    ),
                  ],
                ),
                const Divider(height: 32, thickness: 1.5),
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close dialog
                      Navigator.pop(context); // Return to detail screen
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Kembali',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
