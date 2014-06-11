This REAMDE describes the code structure for Tiny ORAM.

--------------------------------------------------------------------------------
								Introduction
--------------------------------------------------------------------------------

Tiny ORAM is partitioned into a frontend and a backend for a better modular design.
Frontend provides the same interface as a RAM. 
Each frontend access takes as input an (operation, address, data) tuple.
Backend provides a Position ORAM interface. 
Each backend access takes as input an (operation, address, data, currentPos, NewPos) tuple.

Frontend manages the block-to-position mapping, and translates a frontend access into one or multiple backend accesses.
A Unified frontend is currently available, which manages the position map (PosMap) recursively.
Unified frontend hides most of the recursion overhead when the access pattern has good locality, using PosMap-Lookaside-Buffer (PLB). 
A basic (non-recursive) frontend is under development.

Backend is built on Path ORAM by Stefanov et. al [1].
Backend structures the memory as a binary tree, reads random paths in the tree to retrieve the blocks requested by frontend.
Backend also manages the stash and evicts blocks back to the tree.
Tiny ORAM currently supports two backend protocols.
One is the original Path ORAM in [1].
The other is RAW Path ORAM, a variant of Path ORAM proposed in [2].
RAW Path ORAM simplifies integrity verification, and reduces the number of encryption and hash units required.
(Note: we have REW instead of RAW in the code due to legacy. Will be corrected in future releases.)

To choose between different configurations, users only need to change the parameters passed to Tiny ORAMCore.
	EnableREW 	==> 	Path ORAM vs. RAW Path ORAM 
	EnableIV 	==> 	whether or not to enable integrity verification (EnableIV = 1 only works when EnableREW = 1)

[1] Emil Stefanov, Marten van Dijk, Elaine Shi, Christopher Fletcher, Ling Ren, Xiangyao Yu, and Srinivas Devadas. 2013. 
	Path ORAM: an extremely simple oblivious RAM protocol. 
	In Proceedings of the 2013 ACM SIGSAC conference on Computer & communications security (CCS '13). ACM, New York, NY, USA, 299-310. 
	DOI=10.1145/2508859.2516660 http://doi.acm.org/10.1145/2508859.2516660 
	
[2] In submission.	

--------------------------------------------------------------------------------
								Code structure
--------------------------------------------------------------------------------
	 

	- Tiny ORAM							(Tiny ORAMCore.v, top module)
		FrontEnd 							(choose between Basic or Unified)
		Backend								(choose between Path ORAM or RAW Path ORAM)		
										
		- Basic frontend					(under development)
											
		- Unified frontend					(frontend/UORAMController.v)
			PosMap+PLB							(frontend/PosMapPLB.v)
			DataPath							(frontend/UORAMDataPath.v)
											
		- Path ORAM Backend 				(backend/PathORAMBackend.v)
			Address Generator					(addr/*.v)             
			Stash								(stash/*.v)
			Encryption							(encryption/basic/*.v)
											
		- RAW Path ORAM Backend 			(backend/PathORAMBackend.v)
			Address Generator					(addr/*.v)             
			Stash								(stash/*.v)
			Coherence Controller				(backend/CoherenceController.v)
				Integrity							(integrity/*.v)
			Encryption							(encryption/rew/*.v)					
