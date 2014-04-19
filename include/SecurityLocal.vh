
	// Symmetric encryption
	//
	// lambda = AESWidth _unless_ the adversary is allowed to see > 2^AESEntropy ciphertexts
	localparam				AESEntropy =		64, // 2^64 ciphertexts = ORAM must run for 100+ years
	           				AESWidth =			128;

	// Integrity verification
	//
	// Given HashPreimage, the ORAM core will ensure that resistance against preimage attacks is >= 2^HashPreimage.  Resistance against collisions is correspondingly >= 2^(HashPreimage/2).
	localparam				HashPreimage =		80; // The minimum recommended preimage resistance according to the HMAC spec