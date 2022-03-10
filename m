Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECE64D3FD8
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Mar 2022 04:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239313AbiCJDua (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Mar 2022 22:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiCJDu3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Mar 2022 22:50:29 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BC26D946
        for <linux-acpi@vger.kernel.org>; Wed,  9 Mar 2022 19:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646884167; x=1678420167;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=acMqT4La8TM/ifojo1VoH9GF3H0pVajvV8ZDmHGaD+8=;
  b=m531bZaudAv6muIHOvRUk7Qj9btV4n1oE5H2IVmCoEgKOHjTeQg49gU8
   f3OL7tvnShy4ldXbC5WNsrRx/0njg3VanooiXXhyF7K6y400ZV9611pdJ
   dS9h+DsbPu4wsxAlIg44b9x8JPtlm7lZyYt/JOTw72ON16M/3lxsV5BrZ
   Nb6JTM38ROFfIMoQuNAhKBKCPXoH2eePzTeyeNu5fBSg3e2aPpvVjRmRq
   Na6lVHb/T4kP3IBGun1HKoANn7L/8zZ+rU/ZtxhPMJEqOJh0PDqlTF9Ew
   wVjkU3kzqE4gTl5bkMagJAhutR8CgmpLJFf1Qms2zjxfAR5wdgE9esy7x
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="252721461"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="252721461"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 19:49:27 -0800
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="642404842"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 19:49:26 -0800
Subject: [PATCH 2/6] nvdimm/blk: Delete the block-aperture window driver
From:   Dan Williams <dan.j.williams@intel.com>
To:     nvdimm@lists.linux.dev
Cc:     robert.hu@linux.intel.com, vishal.l.verma@intel.com, hch@lst.de,
        linux-acpi@vger.kernel.org
Date:   Wed, 09 Mar 2022 19:49:26 -0800
Message-ID: <164688416668.2879318.16903178375774275120.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164688415599.2879318.17035042246954533659.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164688415599.2879318.17035042246954533659.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Block Aperture Window support was an attempt to layer an error model
over PMEM for platforms that did not support machine-check-recovery.
However, it was abandoned before it ever shipped, and only ever existed
in the ACPI specification. Meanwhile Linux has carried a large pile of
dead code for non-shipping infrastructure. For years it has been off to
the side out of the way, but now CXL and recent directions with DAX
support have the potential to collide with this code.

In preparation for adding discontiguous namespace support, a
pre-requisite for the nvdimm subsystem to replace device-mapper for
striping + concatenation use cases, delete BLK aperture support.

On the obscure chance that some hardware vendor shipped support for this
mode, note that the driver will still keep BLK space reserved in the
label area. So an end user in this case would still have the opportunity
to report the regression to get BLK-mode support restored without
risking the data they have on that device.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/driver-api/nvdimm/nvdimm.rst |  406 ++++++----------------------
 drivers/nvdimm/Kconfig                     |   25 --
 drivers/nvdimm/Makefile                    |    3 
 drivers/nvdimm/blk.c                       |  335 -----------------------
 tools/testing/nvdimm/Kbuild                |    4 
 tools/testing/nvdimm/config_check.c        |    1 
 6 files changed, 92 insertions(+), 682 deletions(-)
 delete mode 100644 drivers/nvdimm/blk.c

diff --git a/Documentation/driver-api/nvdimm/nvdimm.rst b/Documentation/driver-api/nvdimm/nvdimm.rst
index 1d8302b89bd4..7917f6471092 100644
--- a/Documentation/driver-api/nvdimm/nvdimm.rst
+++ b/Documentation/driver-api/nvdimm/nvdimm.rst
@@ -14,10 +14,8 @@ Version 13
 	Overview
 	    Supporting Documents
 	    Git Trees
-	LIBNVDIMM PMEM and BLK
-	Why BLK?
-	    PMEM vs BLK
-	        BLK-REGIONs, PMEM-REGIONs, Atomic Sectors, and DAX
+	LIBNVDIMM PMEM
+	        PMEM-REGIONs, Atomic Sectors, and DAX
 	Example NVDIMM Platform
 	LIBNVDIMM Kernel Device Model and LIBNDCTL Userspace API
 	    LIBNDCTL: Context
@@ -53,19 +51,12 @@ PMEM:
   block device composed of PMEM is capable of DAX.  A PMEM address range
   may span an interleave of several DIMMs.
 
-BLK:
-  A set of one or more programmable memory mapped apertures provided
-  by a DIMM to access its media.  This indirection precludes the
-  performance benefit of interleaving, but enables DIMM-bounded failure
-  modes.
-
 DPA:
   DIMM Physical Address, is a DIMM-relative offset.  With one DIMM in
   the system there would be a 1:1 system-physical-address:DPA association.
   Once more DIMMs are added a memory controller interleave must be
   decoded to determine the DPA associated with a given
-  system-physical-address.  BLK capacity always has a 1:1 relationship
-  with a single-DIMM's DPA range.
+  system-physical-address.
 
 DAX:
   File system extensions to bypass the page cache and block layer to
@@ -84,30 +75,30 @@ BTT:
   Block Translation Table: Persistent memory is byte addressable.
   Existing software may have an expectation that the power-fail-atomicity
   of writes is at least one sector, 512 bytes.  The BTT is an indirection
-  table with atomic update semantics to front a PMEM/BLK block device
+  table with atomic update semantics to front a PMEM block device
   driver and present arbitrary atomic sector sizes.
 
 LABEL:
   Metadata stored on a DIMM device that partitions and identifies
-  (persistently names) storage between PMEM and BLK.  It also partitions
-  BLK storage to host BTTs with different parameters per BLK-partition.
-  Note that traditional partition tables, GPT/MBR, are layered on top of a
-  BLK or PMEM device.
+  (persistently names) capacity allocated to different PMEM namespaces. It
+  also indicates whether an address abstraction like a BTT is applied to
+  the namepsace.  Note that traditional partition tables, GPT/MBR, are
+  layered on top of a PMEM namespace, or an address abstraction like BTT
+  if present, but partition support is deprecated going forward.
 
 
 Overview
 ========
 
-The LIBNVDIMM subsystem provides support for three types of NVDIMMs, namely,
-PMEM, BLK, and NVDIMM devices that can simultaneously support both PMEM
-and BLK mode access.  These three modes of operation are described by
-the "NVDIMM Firmware Interface Table" (NFIT) in ACPI 6.  While the LIBNVDIMM
-implementation is generic and supports pre-NFIT platforms, it was guided
-by the superset of capabilities need to support this ACPI 6 definition
-for NVDIMM resources.  The bulk of the kernel implementation is in place
-to handle the case where DPA accessible via PMEM is aliased with DPA
-accessible via BLK.  When that occurs a LABEL is needed to reserve DPA
-for exclusive access via one mode a time.
+The LIBNVDIMM subsystem provides support for PMEM described by platform
+firmware or a device driver. On ACPI based systems the platform firmware
+conveys persistent memory resource via the ACPI NFIT "NVDIMM Firmware
+Interface Table" in ACPI 6. While the LIBNVDIMM subsystem implementation
+is generic and supports pre-NFIT platforms, it was guided by the
+superset of capabilities need to support this ACPI 6 definition for
+NVDIMM resources. The original implementation supported the
+block-window-aperture capability described in the NFIT, but that support
+has since been abandoned and never shipped in a product.
 
 Supporting Documents
 --------------------
@@ -125,107 +116,38 @@ Git Trees
 ---------
 
 LIBNVDIMM:
-	https://git.kernel.org/cgit/linux/kernel/git/djbw/nvdimm.git
+	https://git.kernel.org/cgit/linux/kernel/git/nvdimm/nvdimm.git
 LIBNDCTL:
 	https://github.com/pmem/ndctl.git
-PMEM:
-	https://github.com/01org/prd
 
 
-LIBNVDIMM PMEM and BLK
-======================
+LIBNVDIMM PMEM
+==============
 
 Prior to the arrival of the NFIT, non-volatile memory was described to a
 system in various ad-hoc ways.  Usually only the bare minimum was
 provided, namely, a single system-physical-address range where writes
 are expected to be durable after a system power loss.  Now, the NFIT
 specification standardizes not only the description of PMEM, but also
-BLK and platform message-passing entry points for control and
-configuration.
-
-For each NVDIMM access method (PMEM, BLK), LIBNVDIMM provides a block
-device driver:
-
-    1. PMEM (nd_pmem.ko): Drives a system-physical-address range.  This
-       range is contiguous in system memory and may be interleaved (hardware
-       memory controller striped) across multiple DIMMs.  When interleaved the
-       platform may optionally provide details of which DIMMs are participating
-       in the interleave.
-
-       Note that while LIBNVDIMM describes system-physical-address ranges that may
-       alias with BLK access as ND_NAMESPACE_PMEM ranges and those without
-       alias as ND_NAMESPACE_IO ranges, to the nd_pmem driver there is no
-       distinction.  The different device-types are an implementation detail
-       that userspace can exploit to implement policies like "only interface
-       with address ranges from certain DIMMs".  It is worth noting that when
-       aliasing is present and a DIMM lacks a label, then no block device can
-       be created by default as userspace needs to do at least one allocation
-       of DPA to the PMEM range.  In contrast ND_NAMESPACE_IO ranges, once
-       registered, can be immediately attached to nd_pmem.
-
-    2. BLK (nd_blk.ko): This driver performs I/O using a set of platform
-       defined apertures.  A set of apertures will access just one DIMM.
-       Multiple windows (apertures) allow multiple concurrent accesses, much like
-       tagged-command-queuing, and would likely be used by different threads or
-       different CPUs.
-
-       The NFIT specification defines a standard format for a BLK-aperture, but
-       the spec also allows for vendor specific layouts, and non-NFIT BLK
-       implementations may have other designs for BLK I/O.  For this reason
-       "nd_blk" calls back into platform-specific code to perform the I/O.
-
-       One such implementation is defined in the "Driver Writer's Guide" and "DSM
-       Interface Example".
-
-
-Why BLK?
-========
+platform message-passing entry points for control and configuration.
+
+PMEM (nd_pmem.ko): Drives a system-physical-address range.  This range is
+contiguous in system memory and may be interleaved (hardware memory controller
+striped) across multiple DIMMs.  When interleaved the platform may optionally
+provide details of which DIMMs are participating in the interleave.
+
+It is worth noting that when the labeling capability is detected (a EFI
+namespace label index block is found), then no block device is created
+by default as userspace needs to do at least one allocation of DPA to
+the PMEM range.  In contrast ND_NAMESPACE_IO ranges, once registered,
+can be immediately attached to nd_pmem. This latter mode is called
+label-less or "legacy".
+
+PMEM-REGIONs, Atomic Sectors, and DAX
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-While PMEM provides direct byte-addressable CPU-load/store access to
-NVDIMM storage, it does not provide the best system RAS (recovery,
-availability, and serviceability) model.  An access to a corrupted
-system-physical-address address causes a CPU exception while an access
-to a corrupted address through an BLK-aperture causes that block window
-to raise an error status in a register.  The latter is more aligned with
-the standard error model that host-bus-adapter attached disks present.
-
-Also, if an administrator ever wants to replace a memory it is easier to
-service a system at DIMM module boundaries.  Compare this to PMEM where
-data could be interleaved in an opaque hardware specific manner across
-several DIMMs.
-
-PMEM vs BLK
------------
-
-BLK-apertures solve these RAS problems, but their presence is also the
-major contributing factor to the complexity of the ND subsystem.  They
-complicate the implementation because PMEM and BLK alias in DPA space.
-Any given DIMM's DPA-range may contribute to one or more
-system-physical-address sets of interleaved DIMMs, *and* may also be
-accessed in its entirety through its BLK-aperture.  Accessing a DPA
-through a system-physical-address while simultaneously accessing the
-same DPA through a BLK-aperture has undefined results.  For this reason,
-DIMMs with this dual interface configuration include a DSM function to
-store/retrieve a LABEL.  The LABEL effectively partitions the DPA-space
-into exclusive system-physical-address and BLK-aperture accessible
-regions.  For simplicity a DIMM is allowed a PMEM "region" per each
-interleave set in which it is a member.  The remaining DPA space can be
-carved into an arbitrary number of BLK devices with discontiguous
-extents.
-
-BLK-REGIONs, PMEM-REGIONs, Atomic Sectors, and DAX
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-One of the few
-reasons to allow multiple BLK namespaces per REGION is so that each
-BLK-namespace can be configured with a BTT with unique atomic sector
-sizes.  While a PMEM device can host a BTT the LABEL specification does
-not provide for a sector size to be specified for a PMEM namespace.
-
-This is due to the expectation that the primary usage model for PMEM is
-via DAX, and the BTT is incompatible with DAX.  However, for the cases
-where an application or filesystem still needs atomic sector update
-guarantees it can register a BTT on a PMEM device or partition.  See
+For the cases where an application or filesystem still needs atomic sector
+update guarantees it can register a BTT on a PMEM device or partition.  See
 LIBNVDIMM/NDCTL: Block Translation Table "btt"
 
 
@@ -236,51 +158,40 @@ For the remainder of this document the following diagram will be
 referenced for any example sysfs layouts::
 
 
-                               (a)               (b)           DIMM   BLK-REGION
+                               (a)               (b)           DIMM
             +-------------------+--------+--------+--------+
-  +------+  |       pm0.0       | blk2.0 | pm1.0  | blk2.1 |    0      region2
+  +------+  |       pm0.0       |  free  | pm1.0  |  free  |    0
   | imc0 +--+- - - region0- - - +--------+        +--------+
-  +--+---+  |       pm0.0       | blk3.0 | pm1.0  | blk3.1 |    1      region3
+  +--+---+  |       pm0.0       |  free  | pm1.0  |  free  |    1
      |      +-------------------+--------v        v--------+
   +--+---+                               |                 |
   | cpu0 |                                     region1
   +--+---+                               |                 |
      |      +----------------------------^        ^--------+
-  +--+---+  |           blk4.0           | pm1.0  | blk4.0 |    2      region4
+  +--+---+  |           free             | pm1.0  |  free  |    2
   | imc1 +--+----------------------------|        +--------+
-  +------+  |           blk5.0           | pm1.0  | blk5.0 |    3      region5
+  +------+  |           free             | pm1.0  |  free  |    3
             +----------------------------+--------+--------+
 
 In this platform we have four DIMMs and two memory controllers in one
-socket.  Each unique interface (BLK or PMEM) to DPA space is identified
-by a region device with a dynamically assigned id (REGION0 - REGION5).
+socket.  Each PMEM interleave set is identified by a region device with
+a dynamically assigned id.
 
     1. The first portion of DIMM0 and DIMM1 are interleaved as REGION0. A
        single PMEM namespace is created in the REGION0-SPA-range that spans most
        of DIMM0 and DIMM1 with a user-specified name of "pm0.0". Some of that
-       interleaved system-physical-address range is reclaimed as BLK-aperture
-       accessed space starting at DPA-offset (a) into each DIMM.  In that
-       reclaimed space we create two BLK-aperture "namespaces" from REGION2 and
-       REGION3 where "blk2.0" and "blk3.0" are just human readable names that
-       could be set to any user-desired name in the LABEL.
+       interleaved system-physical-address range is left free for
+       another PMEM namespace to be defined.
 
     2. In the last portion of DIMM0 and DIMM1 we have an interleaved
        system-physical-address range, REGION1, that spans those two DIMMs as
        well as DIMM2 and DIMM3.  Some of REGION1 is allocated to a PMEM namespace
-       named "pm1.0", the rest is reclaimed in 4 BLK-aperture namespaces (for
-       each DIMM in the interleave set), "blk2.1", "blk3.1", "blk4.0", and
-       "blk5.0".
-
-    3. The portion of DIMM2 and DIMM3 that do not participate in the REGION1
-       interleaved system-physical-address range (i.e. the DPA address past
-       offset (b) are also included in the "blk4.0" and "blk5.0" namespaces.
-       Note, that this example shows that BLK-aperture namespaces don't need to
-       be contiguous in DPA-space.
+       named "pm1.0".
 
     This bus is provided by the kernel under the device
     /sys/devices/platform/nfit_test.0 when the nfit_test.ko module from
-    tools/testing/nvdimm is loaded.  This not only test LIBNVDIMM but the
-    acpi_nfit.ko driver as well.
+    tools/testing/nvdimm is loaded. This module is a unit test for
+    LIBNVDIMM and the  acpi_nfit.ko driver.
 
 
 LIBNVDIMM Kernel Device Model and LIBNDCTL Userspace API
@@ -469,17 +380,14 @@ identified by an "nfit_handle" a 32-bit value where:
 LIBNVDIMM/LIBNDCTL: Region
 --------------------------
 
-A generic REGION device is registered for each PMEM range or BLK-aperture
-set.  Per the example there are 6 regions: 2 PMEM and 4 BLK-aperture
-sets on the "nfit_test.0" bus.  The primary role of regions are to be a
-container of "mappings".  A mapping is a tuple of <DIMM,
-DPA-start-offset, length>.
+A generic REGION device is registered for each PMEM interleave-set /
+range. Per the example there are 2 PMEM regions on the "nfit_test.0"
+bus. The primary role of regions are to be a container of "mappings".  A
+mapping is a tuple of <DIMM, DPA-start-offset, length>.
 
-LIBNVDIMM provides a built-in driver for these REGION devices.  This driver
-is responsible for reconciling the aliased DPA mappings across all
-regions, parsing the LABEL, if present, and then emitting NAMESPACE
-devices with the resolved/exclusive DPA-boundaries for the nd_pmem or
-nd_blk device driver to consume.
+LIBNVDIMM provides a built-in driver for REGION devices.  This driver
+is responsible for all parsing LABELs, if present, and then emitting NAMESPACE
+devices for the nd_pmem driver to consume.
 
 In addition to the generic attributes of "mapping"s, "interleave_ways"
 and "size" the REGION device also exports some convenience attributes.
@@ -493,8 +401,6 @@ LIBNVDIMM: region::
 
 	struct nd_region *nvdimm_pmem_region_create(struct nvdimm_bus *nvdimm_bus,
 			struct nd_region_desc *ndr_desc);
-	struct nd_region *nvdimm_blk_region_create(struct nvdimm_bus *nvdimm_bus,
-			struct nd_region_desc *ndr_desc);
 
 ::
 
@@ -527,8 +433,9 @@ LIBNDCTL: region enumeration example
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 Sample region retrieval routines based on NFIT-unique data like
-"spa_index" (interleave set id) for PMEM and "nfit_handle" (dimm id) for
-BLK::
+"spa_index" (interleave set id).
+
+::
 
 	static struct ndctl_region *get_pmem_region_by_spa_index(struct ndctl_bus *bus,
 			unsigned int spa_index)
@@ -544,139 +451,23 @@ BLK::
 		return NULL;
 	}
 
-	static struct ndctl_region *get_blk_region_by_dimm_handle(struct ndctl_bus *bus,
-			unsigned int handle)
-	{
-		struct ndctl_region *region;
-
-		ndctl_region_foreach(bus, region) {
-			struct ndctl_mapping *map;
-
-			if (ndctl_region_get_type(region) != ND_DEVICE_REGION_BLOCK)
-				continue;
-			ndctl_mapping_foreach(region, map) {
-				struct ndctl_dimm *dimm = ndctl_mapping_get_dimm(map);
-
-				if (ndctl_dimm_get_handle(dimm) == handle)
-					return region;
-			}
-		}
-		return NULL;
-	}
-
-
-Why Not Encode the Region Type into the Region Name?
-----------------------------------------------------
-
-At first glance it seems since NFIT defines just PMEM and BLK interface
-types that we should simply name REGION devices with something derived
-from those type names.  However, the ND subsystem explicitly keeps the
-REGION name generic and expects userspace to always consider the
-region-attributes for four reasons:
-
-    1. There are already more than two REGION and "namespace" types.  For
-       PMEM there are two subtypes.  As mentioned previously we have PMEM where
-       the constituent DIMM devices are known and anonymous PMEM.  For BLK
-       regions the NFIT specification already anticipates vendor specific
-       implementations.  The exact distinction of what a region contains is in
-       the region-attributes not the region-name or the region-devtype.
-
-    2. A region with zero child-namespaces is a possible configuration.  For
-       example, the NFIT allows for a DCR to be published without a
-       corresponding BLK-aperture.  This equates to a DIMM that can only accept
-       control/configuration messages, but no i/o through a descendant block
-       device.  Again, this "type" is advertised in the attributes ('mappings'
-       == 0) and the name does not tell you much.
-
-    3. What if a third major interface type arises in the future?  Outside
-       of vendor specific implementations, it's not difficult to envision a
-       third class of interface type beyond BLK and PMEM.  With a generic name
-       for the REGION level of the device-hierarchy old userspace
-       implementations can still make sense of new kernel advertised
-       region-types.  Userspace can always rely on the generic region
-       attributes like "mappings", "size", etc and the expected child devices
-       named "namespace".  This generic format of the device-model hierarchy
-       allows the LIBNVDIMM and LIBNDCTL implementations to be more uniform and
-       future-proof.
-
-    4. There are more robust mechanisms for determining the major type of a
-       region than a device name.  See the next section, How Do I Determine the
-       Major Type of a Region?
-
-How Do I Determine the Major Type of a Region?
-----------------------------------------------
-
-Outside of the blanket recommendation of "use libndctl", or simply
-looking at the kernel header (/usr/include/linux/ndctl.h) to decode the
-"nstype" integer attribute, here are some other options.
-
-1. module alias lookup
-^^^^^^^^^^^^^^^^^^^^^^
-
-    The whole point of region/namespace device type differentiation is to
-    decide which block-device driver will attach to a given LIBNVDIMM namespace.
-    One can simply use the modalias to lookup the resulting module.  It's
-    important to note that this method is robust in the presence of a
-    vendor-specific driver down the road.  If a vendor-specific
-    implementation wants to supplant the standard nd_blk driver it can with
-    minimal impact to the rest of LIBNVDIMM.
-
-    In fact, a vendor may also want to have a vendor-specific region-driver
-    (outside of nd_region).  For example, if a vendor defined its own LABEL
-    format it would need its own region driver to parse that LABEL and emit
-    the resulting namespaces.  The output from module resolution is more
-    accurate than a region-name or region-devtype.
-
-2. udev
-^^^^^^^
-
-    The kernel "devtype" is registered in the udev database::
-
-	# udevadm info --path=/devices/platform/nfit_test.0/ndbus0/region0
-	P: /devices/platform/nfit_test.0/ndbus0/region0
-	E: DEVPATH=/devices/platform/nfit_test.0/ndbus0/region0
-	E: DEVTYPE=nd_pmem
-	E: MODALIAS=nd:t2
-	E: SUBSYSTEM=nd
-
-	# udevadm info --path=/devices/platform/nfit_test.0/ndbus0/region4
-	P: /devices/platform/nfit_test.0/ndbus0/region4
-	E: DEVPATH=/devices/platform/nfit_test.0/ndbus0/region4
-	E: DEVTYPE=nd_blk
-	E: MODALIAS=nd:t3
-	E: SUBSYSTEM=nd
-
-    ...and is available as a region attribute, but keep in mind that the
-    "devtype" does not indicate sub-type variations and scripts should
-    really be understanding the other attributes.
-
-3. type specific attributes
-^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-    As it currently stands a BLK-aperture region will never have a
-    "nfit/spa_index" attribute, but neither will a non-NFIT PMEM region.  A
-    BLK region with a "mappings" value of 0 is, as mentioned above, a DIMM
-    that does not allow I/O.  A PMEM region with a "mappings" value of zero
-    is a simple system-physical-address range.
-
 
 LIBNVDIMM/LIBNDCTL: Namespace
 -----------------------------
 
-A REGION, after resolving DPA aliasing and LABEL specified boundaries,
-surfaces one or more "namespace" devices.  The arrival of a "namespace"
-device currently triggers either the nd_blk or nd_pmem driver to load
-and register a disk/block device.
+A REGION, after resolving DPA aliasing and LABEL specified boundaries, surfaces
+one or more "namespace" devices.  The arrival of a "namespace" device currently
+triggers the nd_pmem driver to load and register a disk/block device.
 
 LIBNVDIMM: namespace
 ^^^^^^^^^^^^^^^^^^^^
 
-Here is a sample layout from the three major types of NAMESPACE where
-namespace0.0 represents DIMM-info-backed PMEM (note that it has a 'uuid'
-attribute), namespace2.0 represents a BLK namespace (note it has a
-'sector_size' attribute) that, and namespace6.0 represents an anonymous
-PMEM namespace (note that has no 'uuid' attribute due to not support a
-LABEL)::
+Here is a sample layout from the 2 major types of NAMESPACE where namespace0.0
+represents DIMM-info-backed PMEM (note that it has a 'uuid' attribute), and
+namespace1.0 represents an anonymous PMEM namespace (note that has no 'uuid'
+attribute due to not support a LABEL)
+
+::
 
 	/sys/devices/platform/nfit_test.0/ndbus0/region0/namespace0.0
 	|-- alt_name
@@ -691,20 +482,7 @@ LABEL)::
 	|-- type
 	|-- uevent
 	`-- uuid
-	/sys/devices/platform/nfit_test.0/ndbus0/region2/namespace2.0
-	|-- alt_name
-	|-- devtype
-	|-- dpa_extents
-	|-- force_raw
-	|-- modalias
-	|-- numa_node
-	|-- sector_size
-	|-- size
-	|-- subsystem -> ../../../../../../bus/nd
-	|-- type
-	|-- uevent
-	`-- uuid
-	/sys/devices/platform/nfit_test.1/ndbus1/region6/namespace6.0
+	/sys/devices/platform/nfit_test.1/ndbus1/region1/namespace1.0
 	|-- block
 	|   `-- pmem0
 	|-- devtype
@@ -786,9 +564,9 @@ Why the Term "namespace"?
 LIBNVDIMM/LIBNDCTL: Block Translation Table "btt"
 -------------------------------------------------
 
-A BTT (design document: https://pmem.io/2014/09/23/btt.html) is a stacked
-block device driver that fronts either the whole block device or a
-partition of a block device emitted by either a PMEM or BLK NAMESPACE.
+A BTT (design document: https://pmem.io/2014/09/23/btt.html) is a
+personality driver for a namespace that fronts entire namespace as an
+'address abstraction'.
 
 LIBNVDIMM: btt layout
 ^^^^^^^^^^^^^^^^^^^^^
@@ -815,7 +593,9 @@ LIBNDCTL: btt creation example
 Similar to namespaces an idle BTT device is automatically created per
 region.  Each time this "seed" btt device is configured and enabled a new
 seed is created.  Creating a BTT configuration involves two steps of
-finding and idle BTT and assigning it to consume a PMEM or BLK namespace::
+finding and idle BTT and assigning it to consume a namespace.
+
+::
 
 	static struct ndctl_btt *get_idle_btt(struct ndctl_region *region)
 	{
@@ -863,25 +643,15 @@ For the given example above, here is the view of the objects as seen by the
 LIBNDCTL API::
 
               +---+
-              |CTX|    +---------+   +--------------+  +---------------+
-              +-+-+  +-> REGION0 +---> NAMESPACE0.0 +--> PMEM8 "pm0.0" |
-                |    | +---------+   +--------------+  +---------------+
-  +-------+     |    | +---------+   +--------------+  +---------------+
-  | DIMM0 <-+   |    +-> REGION1 +---> NAMESPACE1.0 +--> PMEM6 "pm1.0" |
-  +-------+ |   |    | +---------+   +--------------+  +---------------+
+              |CTX|
+              +-+-+
+                |
+  +-------+     |
+  | DIMM0 <-+   |      +---------+   +--------------+  +---------------+
+  +-------+ |   |    +-> REGION0 +---> NAMESPACE0.0 +--> PMEM8 "pm0.0" |
   | DIMM1 <-+ +-v--+ | +---------+   +--------------+  +---------------+
-  +-------+ +-+BUS0+---> REGION2 +-+-> NAMESPACE2.0 +--> ND6  "blk2.0" |
-  | DIMM2 <-+ +----+ | +---------+ | +--------------+  +----------------------+
-  +-------+ |        |             +-> NAMESPACE2.1 +--> ND5  "blk2.1" | BTT2 |
-  | DIMM3 <-+        |               +--------------+  +----------------------+
-  +-------+          | +---------+   +--------------+  +---------------+
-                     +-> REGION3 +-+-> NAMESPACE3.0 +--> ND4  "blk3.0" |
-                     | +---------+ | +--------------+  +----------------------+
-                     |             +-> NAMESPACE3.1 +--> ND3  "blk3.1" | BTT1 |
-                     |               +--------------+  +----------------------+
-                     | +---------+   +--------------+  +---------------+
-                     +-> REGION4 +---> NAMESPACE4.0 +--> ND2  "blk4.0" |
-                     | +---------+   +--------------+  +---------------+
-                     | +---------+   +--------------+  +----------------------+
-                     +-> REGION5 +---> NAMESPACE5.0 +--> ND1  "blk5.0" | BTT0 |
-                       +---------+   +--------------+  +---------------+------+
+  +-------+ +-+BUS0+-| +---------+   +--------------+  +----------------------+
+  | DIMM2 <-+ +----+ +-> REGION1 +---> NAMESPACE1.0 +--> PMEM6 "pm1.0" | BTT1 |
+  +-------+ |        | +---------+   +--------------+  +---------------+------+
+  | DIMM3 <-+
+  +-------+
diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
index 347fe7afa583..5a29046e3319 100644
--- a/drivers/nvdimm/Kconfig
+++ b/drivers/nvdimm/Kconfig
@@ -10,12 +10,9 @@ menuconfig LIBNVDIMM
 	  ACPI-6-NFIT defined resources.  On platforms that define an
 	  NFIT, or otherwise can discover NVDIMM resources, a libnvdimm
 	  bus is registered to advertise PMEM (persistent memory)
-	  namespaces (/dev/pmemX) and BLK (sliding mmio window(s))
-	  namespaces (/dev/ndblkX.Y). A PMEM namespace refers to a
+	  namespaces (/dev/pmemX). A PMEM namespace refers to a
 	  memory resource that may span multiple DIMMs and support DAX
-	  (see CONFIG_DAX).  A BLK namespace refers to an NVDIMM control
-	  region which exposes an mmio register set for windowed access
-	  mode to non-volatile memory.
+	  (see CONFIG_DAX).
 
 if LIBNVDIMM
 
@@ -38,19 +35,6 @@ config BLK_DEV_PMEM
 
 	  Say Y if you want to use an NVDIMM
 
-config ND_BLK
-	tristate "BLK: Block data window (aperture) device support"
-	default LIBNVDIMM
-	select ND_BTT if BTT
-	help
-	  Support NVDIMMs, or other devices, that implement a BLK-mode
-	  access capability.  BLK-mode access uses memory-mapped-i/o
-	  apertures to access persistent media.
-
-	  Say Y if your platform firmware emits an ACPI.NFIT table
-	  (CONFIG_ACPI_NFIT), or otherwise exposes BLK-mode
-	  capabilities.
-
 config ND_CLAIM
 	bool
 
@@ -67,9 +51,8 @@ config BTT
 	  applications that rely on sector writes not being torn (a
 	  guarantee that typical disks provide) can continue to do so.
 	  The BTT manifests itself as an alternate personality for an
-	  NVDIMM namespace, i.e. a namespace can be in raw mode (pmemX,
-	  ndblkX.Y, etc...), or 'sectored' mode, (pmemXs, ndblkX.Ys,
-	  etc...).
+	  NVDIMM namespace, i.e. a namespace can be in raw mode pmemX,
+	  or 'sectored' mode.
 
 	  Select Y if unsure
 
diff --git a/drivers/nvdimm/Makefile b/drivers/nvdimm/Makefile
index 25dba6095612..3fb806748716 100644
--- a/drivers/nvdimm/Makefile
+++ b/drivers/nvdimm/Makefile
@@ -2,7 +2,6 @@
 obj-$(CONFIG_LIBNVDIMM) += libnvdimm.o
 obj-$(CONFIG_BLK_DEV_PMEM) += nd_pmem.o
 obj-$(CONFIG_ND_BTT) += nd_btt.o
-obj-$(CONFIG_ND_BLK) += nd_blk.o
 obj-$(CONFIG_X86_PMEM_LEGACY) += nd_e820.o
 obj-$(CONFIG_OF_PMEM) += of_pmem.o
 obj-$(CONFIG_VIRTIO_PMEM) += virtio_pmem.o nd_virtio.o
@@ -11,8 +10,6 @@ nd_pmem-y := pmem.o
 
 nd_btt-y := btt.o
 
-nd_blk-y := blk.o
-
 nd_e820-y := e820.o
 
 libnvdimm-y := core.o
diff --git a/drivers/nvdimm/blk.c b/drivers/nvdimm/blk.c
deleted file mode 100644
index 228c33b8d1d6..000000000000
--- a/drivers/nvdimm/blk.c
+++ /dev/null
@@ -1,335 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * NVDIMM Block Window Driver
- * Copyright (c) 2014, Intel Corporation.
- */
-
-#include <linux/blkdev.h>
-#include <linux/fs.h>
-#include <linux/genhd.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/nd.h>
-#include <linux/sizes.h>
-#include "nd.h"
-
-static u32 nsblk_meta_size(struct nd_namespace_blk *nsblk)
-{
-	return nsblk->lbasize - ((nsblk->lbasize >= 4096) ? 4096 : 512);
-}
-
-static u32 nsblk_internal_lbasize(struct nd_namespace_blk *nsblk)
-{
-	return roundup(nsblk->lbasize, INT_LBASIZE_ALIGNMENT);
-}
-
-static u32 nsblk_sector_size(struct nd_namespace_blk *nsblk)
-{
-	return nsblk->lbasize - nsblk_meta_size(nsblk);
-}
-
-static resource_size_t to_dev_offset(struct nd_namespace_blk *nsblk,
-				resource_size_t ns_offset, unsigned int len)
-{
-	int i;
-
-	for (i = 0; i < nsblk->num_resources; i++) {
-		if (ns_offset < resource_size(nsblk->res[i])) {
-			if (ns_offset + len > resource_size(nsblk->res[i])) {
-				dev_WARN_ONCE(&nsblk->common.dev, 1,
-					"illegal request\n");
-				return SIZE_MAX;
-			}
-			return nsblk->res[i]->start + ns_offset;
-		}
-		ns_offset -= resource_size(nsblk->res[i]);
-	}
-
-	dev_WARN_ONCE(&nsblk->common.dev, 1, "request out of range\n");
-	return SIZE_MAX;
-}
-
-static struct nd_blk_region *to_ndbr(struct nd_namespace_blk *nsblk)
-{
-	struct nd_region *nd_region;
-	struct device *parent;
-
-	parent = nsblk->common.dev.parent;
-	nd_region = container_of(parent, struct nd_region, dev);
-	return container_of(nd_region, struct nd_blk_region, nd_region);
-}
-
-#ifdef CONFIG_BLK_DEV_INTEGRITY
-static int nd_blk_rw_integrity(struct nd_namespace_blk *nsblk,
-		struct bio_integrity_payload *bip, u64 lba, int rw)
-{
-	struct nd_blk_region *ndbr = to_ndbr(nsblk);
-	unsigned int len = nsblk_meta_size(nsblk);
-	resource_size_t	dev_offset, ns_offset;
-	u32 internal_lbasize, sector_size;
-	int err = 0;
-
-	internal_lbasize = nsblk_internal_lbasize(nsblk);
-	sector_size = nsblk_sector_size(nsblk);
-	ns_offset = lba * internal_lbasize + sector_size;
-	dev_offset = to_dev_offset(nsblk, ns_offset, len);
-	if (dev_offset == SIZE_MAX)
-		return -EIO;
-
-	while (len) {
-		unsigned int cur_len;
-		struct bio_vec bv;
-		void *iobuf;
-
-		bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
-		/*
-		 * The 'bv' obtained from bvec_iter_bvec has its .bv_len and
-		 * .bv_offset already adjusted for iter->bi_bvec_done, and we
-		 * can use those directly
-		 */
-
-		cur_len = min(len, bv.bv_len);
-		iobuf = kmap_atomic(bv.bv_page);
-		err = ndbr->do_io(ndbr, dev_offset, iobuf + bv.bv_offset,
-				cur_len, rw);
-		kunmap_atomic(iobuf);
-		if (err)
-			return err;
-
-		len -= cur_len;
-		dev_offset += cur_len;
-		if (!bvec_iter_advance(bip->bip_vec, &bip->bip_iter, cur_len))
-			return -EIO;
-	}
-
-	return err;
-}
-
-#else /* CONFIG_BLK_DEV_INTEGRITY */
-static int nd_blk_rw_integrity(struct nd_namespace_blk *nsblk,
-		struct bio_integrity_payload *bip, u64 lba, int rw)
-{
-	return 0;
-}
-#endif
-
-static int nsblk_do_bvec(struct nd_namespace_blk *nsblk,
-		struct bio_integrity_payload *bip, struct page *page,
-		unsigned int len, unsigned int off, int rw, sector_t sector)
-{
-	struct nd_blk_region *ndbr = to_ndbr(nsblk);
-	resource_size_t	dev_offset, ns_offset;
-	u32 internal_lbasize, sector_size;
-	int err = 0;
-	void *iobuf;
-	u64 lba;
-
-	internal_lbasize = nsblk_internal_lbasize(nsblk);
-	sector_size = nsblk_sector_size(nsblk);
-	while (len) {
-		unsigned int cur_len;
-
-		/*
-		 * If we don't have an integrity payload, we don't have to
-		 * split the bvec into sectors, as this would cause unnecessary
-		 * Block Window setup/move steps. the do_io routine is capable
-		 * of handling len <= PAGE_SIZE.
-		 */
-		cur_len = bip ? min(len, sector_size) : len;
-
-		lba = div_u64(sector << SECTOR_SHIFT, sector_size);
-		ns_offset = lba * internal_lbasize;
-		dev_offset = to_dev_offset(nsblk, ns_offset, cur_len);
-		if (dev_offset == SIZE_MAX)
-			return -EIO;
-
-		iobuf = kmap_atomic(page);
-		err = ndbr->do_io(ndbr, dev_offset, iobuf + off, cur_len, rw);
-		kunmap_atomic(iobuf);
-		if (err)
-			return err;
-
-		if (bip) {
-			err = nd_blk_rw_integrity(nsblk, bip, lba, rw);
-			if (err)
-				return err;
-		}
-		len -= cur_len;
-		off += cur_len;
-		sector += sector_size >> SECTOR_SHIFT;
-	}
-
-	return err;
-}
-
-static void nd_blk_submit_bio(struct bio *bio)
-{
-	struct bio_integrity_payload *bip;
-	struct nd_namespace_blk *nsblk = bio->bi_bdev->bd_disk->private_data;
-	struct bvec_iter iter;
-	unsigned long start;
-	struct bio_vec bvec;
-	int err = 0, rw;
-	bool do_acct;
-
-	if (!bio_integrity_prep(bio))
-		return;
-
-	bip = bio_integrity(bio);
-	rw = bio_data_dir(bio);
-	do_acct = blk_queue_io_stat(bio->bi_bdev->bd_disk->queue);
-	if (do_acct)
-		start = bio_start_io_acct(bio);
-	bio_for_each_segment(bvec, bio, iter) {
-		unsigned int len = bvec.bv_len;
-
-		BUG_ON(len > PAGE_SIZE);
-		err = nsblk_do_bvec(nsblk, bip, bvec.bv_page, len,
-				bvec.bv_offset, rw, iter.bi_sector);
-		if (err) {
-			dev_dbg(&nsblk->common.dev,
-					"io error in %s sector %lld, len %d,\n",
-					(rw == READ) ? "READ" : "WRITE",
-					(unsigned long long) iter.bi_sector, len);
-			bio->bi_status = errno_to_blk_status(err);
-			break;
-		}
-	}
-	if (do_acct)
-		bio_end_io_acct(bio, start);
-
-	bio_endio(bio);
-}
-
-static int nsblk_rw_bytes(struct nd_namespace_common *ndns,
-		resource_size_t offset, void *iobuf, size_t n, int rw,
-		unsigned long flags)
-{
-	struct nd_namespace_blk *nsblk = to_nd_namespace_blk(&ndns->dev);
-	struct nd_blk_region *ndbr = to_ndbr(nsblk);
-	resource_size_t	dev_offset;
-
-	dev_offset = to_dev_offset(nsblk, offset, n);
-
-	if (unlikely(offset + n > nsblk->size)) {
-		dev_WARN_ONCE(&ndns->dev, 1, "request out of range\n");
-		return -EFAULT;
-	}
-
-	if (dev_offset == SIZE_MAX)
-		return -EIO;
-
-	return ndbr->do_io(ndbr, dev_offset, iobuf, n, rw);
-}
-
-static const struct block_device_operations nd_blk_fops = {
-	.owner = THIS_MODULE,
-	.submit_bio =  nd_blk_submit_bio,
-};
-
-static void nd_blk_release_disk(void *disk)
-{
-	del_gendisk(disk);
-	blk_cleanup_disk(disk);
-}
-
-static int nsblk_attach_disk(struct nd_namespace_blk *nsblk)
-{
-	struct device *dev = &nsblk->common.dev;
-	resource_size_t available_disk_size;
-	struct gendisk *disk;
-	u64 internal_nlba;
-	int rc;
-
-	internal_nlba = div_u64(nsblk->size, nsblk_internal_lbasize(nsblk));
-	available_disk_size = internal_nlba * nsblk_sector_size(nsblk);
-
-	disk = blk_alloc_disk(NUMA_NO_NODE);
-	if (!disk)
-		return -ENOMEM;
-
-	disk->fops		= &nd_blk_fops;
-	disk->private_data	= nsblk;
-	nvdimm_namespace_disk_name(&nsblk->common, disk->disk_name);
-
-	blk_queue_max_hw_sectors(disk->queue, UINT_MAX);
-	blk_queue_logical_block_size(disk->queue, nsblk_sector_size(nsblk));
-	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
-
-	if (nsblk_meta_size(nsblk)) {
-		rc = nd_integrity_init(disk, nsblk_meta_size(nsblk));
-
-		if (rc)
-			goto out_before_devm_err;
-	}
-
-	set_capacity(disk, available_disk_size >> SECTOR_SHIFT);
-	rc = device_add_disk(dev, disk, NULL);
-	if (rc)
-		goto out_before_devm_err;
-
-	/* nd_blk_release_disk() is called if this fails */
-	if (devm_add_action_or_reset(dev, nd_blk_release_disk, disk))
-		return -ENOMEM;
-
-	nvdimm_check_and_set_ro(disk);
-	return 0;
-
-out_before_devm_err:
-	blk_cleanup_disk(disk);
-	return rc;
-}
-
-static int nd_blk_probe(struct device *dev)
-{
-	struct nd_namespace_common *ndns;
-	struct nd_namespace_blk *nsblk;
-
-	ndns = nvdimm_namespace_common_probe(dev);
-	if (IS_ERR(ndns))
-		return PTR_ERR(ndns);
-
-	nsblk = to_nd_namespace_blk(&ndns->dev);
-	nsblk->size = nvdimm_namespace_capacity(ndns);
-	dev_set_drvdata(dev, nsblk);
-
-	ndns->rw_bytes = nsblk_rw_bytes;
-	if (is_nd_btt(dev))
-		return nvdimm_namespace_attach_btt(ndns);
-	else if (nd_btt_probe(dev, ndns) == 0) {
-		/* we'll come back as btt-blk */
-		return -ENXIO;
-	} else
-		return nsblk_attach_disk(nsblk);
-}
-
-static void nd_blk_remove(struct device *dev)
-{
-	if (is_nd_btt(dev))
-		nvdimm_namespace_detach_btt(to_nd_btt(dev));
-}
-
-static struct nd_device_driver nd_blk_driver = {
-	.probe = nd_blk_probe,
-	.remove = nd_blk_remove,
-	.drv = {
-		.name = "nd_blk",
-	},
-	.type = ND_DRIVER_NAMESPACE_BLK,
-};
-
-static int __init nd_blk_init(void)
-{
-	return nd_driver_register(&nd_blk_driver);
-}
-
-static void __exit nd_blk_exit(void)
-{
-	driver_unregister(&nd_blk_driver.drv);
-}
-
-MODULE_AUTHOR("Ross Zwisler <ross.zwisler@linux.intel.com>");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS_ND_DEVICE(ND_DEVICE_NAMESPACE_BLK);
-module_init(nd_blk_init);
-module_exit(nd_blk_exit);
diff --git a/tools/testing/nvdimm/Kbuild b/tools/testing/nvdimm/Kbuild
index c57d9e9d4480..5eb5c23b062f 100644
--- a/tools/testing/nvdimm/Kbuild
+++ b/tools/testing/nvdimm/Kbuild
@@ -27,7 +27,6 @@ ccflags-y += -I$(srctree)/drivers/acpi/nfit/
 obj-$(CONFIG_LIBNVDIMM) += libnvdimm.o
 obj-$(CONFIG_BLK_DEV_PMEM) += nd_pmem.o
 obj-$(CONFIG_ND_BTT) += nd_btt.o
-obj-$(CONFIG_ND_BLK) += nd_blk.o
 obj-$(CONFIG_X86_PMEM_LEGACY) += nd_e820.o
 obj-$(CONFIG_ACPI_NFIT) += nfit.o
 ifeq ($(CONFIG_DAX),m)
@@ -50,9 +49,6 @@ nd_pmem-y += config_check.o
 nd_btt-y := $(NVDIMM_SRC)/btt.o
 nd_btt-y += config_check.o
 
-nd_blk-y := $(NVDIMM_SRC)/blk.o
-nd_blk-y += config_check.o
-
 nd_e820-y := $(NVDIMM_SRC)/e820.o
 nd_e820-y += config_check.o
 
diff --git a/tools/testing/nvdimm/config_check.c b/tools/testing/nvdimm/config_check.c
index 3e3a5f518864..baed75e2ccbc 100644
--- a/tools/testing/nvdimm/config_check.c
+++ b/tools/testing/nvdimm/config_check.c
@@ -11,7 +11,6 @@ void check(void)
 	BUILD_BUG_ON(!IS_MODULE(CONFIG_BLK_DEV_PMEM));
 	BUILD_BUG_ON(!IS_MODULE(CONFIG_ND_BTT));
 	BUILD_BUG_ON(!IS_MODULE(CONFIG_ND_PFN));
-	BUILD_BUG_ON(!IS_MODULE(CONFIG_ND_BLK));
 	if (IS_ENABLED(CONFIG_ACPI_NFIT))
 		BUILD_BUG_ON(!IS_MODULE(CONFIG_ACPI_NFIT));
 	BUILD_BUG_ON(!IS_MODULE(CONFIG_DEV_DAX));

