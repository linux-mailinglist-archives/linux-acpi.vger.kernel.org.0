Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16DA6CB0D5
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Mar 2023 23:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjC0VoF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Mar 2023 17:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjC0VoE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Mar 2023 17:44:04 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C751FF2;
        Mon, 27 Mar 2023 14:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679953443; x=1711489443;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CtKXQqajNNgRhkF3MayJ//12i6vxPvwBv2iZSQaYSmI=;
  b=TcTOl7CSOqtAzmz2zd5o/0ofEAHFoTWQX80O2A0YpnvrLbvYIlyUjx5w
   SxKTCL+hyNfcobsNELbH4ib5NexVIcMYKsXOaUsW98yoZkUdPbYr9UvQ4
   3z3Hx22TJ2bKNewDz4jc+kLNDculeBGwHlwfnV9tfpPD9g/aCB0hbf6Xf
   ksJTzW7ky3J5ETUBj5G8LFbMQz1duReZXO3mu0AYcMy+3fW23Chqnmj/A
   qg4KFc/1pH3whO1hfgvm2CwMv8DTBX8FgllEGfZRfASX81Bfm21NfWZPH
   A3PgauGwLIXytBjGL8rOPbNw0t0D4o71w3YZd8Syu+uEMPTUWRFlMHEnR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="339120526"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="339120526"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:44:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="772883194"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="772883194"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.91.66])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:44:02 -0700
Subject: [PATCH v2 00/21] cxl: Add support for QTG ID retrieval for CXL
 subsystem
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rafael@kernel.org, lukas@wunner.de
Date:   Mon, 27 Mar 2023 14:44:02 -0700
Message-ID: <167995336797.2857312.539473939839316778.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

v2:
- Please see specific patches for log entries addressing comments from v1.
- Removed ACPICA code usages.
- Removed PCI subsystem helpers for latency and bandwidth.
- Add CXL switch CDAT parsing support (SSLBIS)
- Add generic port SRAT+HMAT support (ACPI)
- Export a single QTG ID via sysfs per memory device (Dan)
- Provide rest of DSMAS range info in debugfs (Dan)


Hi Rafael, please review the relevant patches to ACPI: 13/18, 14/18. Thank you!
If they are ok, Dan can take them through the CXL tree for upstream merging.
These patches are different than what was posted in v1. I've removed ACPICA usages
from v1. The two new patches adds the SRAT Generic Port Affinity Structure parsing
in order to store the device handle that correlates to the proximity domains
exported by the SRAT table and ties that to the performance data that's exported by
the HMAT.

This series adds the retrieval of QoS Throttling Group (QTG) IDs for the CXL Fixed
Memory Window Structure (CFMWS) and the CXL memory device. It provides the QTG IDs
to user space to provide some guidance with putting the proper DPA range under the
appropriate CFMWS window for a hot-plugged CXL memory device.

The CFMWS structure contains a QTG ID that is associated with the memory window that the
structure exports. On Linux, the CFMWS is represented as a CXL root decoder. The QTG
ID will be attached to the CXL root decoder and exported as a sysfs attribute (qtg_id).

The QTG ID for a device is retrieved via sending a _DSM method to the ACPI0017 device.
The _DSM expects an input package of 4 DWORDS that contains the read latency, write
latency, read bandwidth, and write banwidth. These are the caluclated numbers for the
path between the CXL device and the CXL host bridge (HB). The QTG ID is also exported
as a sysfs attribute under the mem device memory type:
/sys/bus/cxl/devices/memX/qtg_id
Only the first QTG ID is exported. The rest of the information can be found under
/sys/kernel/debug/cxl/memX/qtgmap where all the DPA ranges with the correlated QTG ID
are displayed. Each DSMAS from the device CDAT will provide a DPA range.

The latency numbers are the aggregated latencies for the path between the CXL device and
the CPU. If a CXL device is directly attached to the CXL HB, the latency
would be the aggregated latencies from the device Coherent Device Attribute Table (CDAT),
the caluclated PCIe link latency between the device and the HB, and the generic port data
from ACPI SRAT+HMAT. The bandwidth in this configuration would be the minimum between the
CDAT bandwidth number, link bandwidth between the device and the HB, and the bandwidth data
from the generic port data via ACPI SRAT+HMAT.

If a configuration has a switch in between then the latency would be the aggregated
latencies from the device CDAT, the link latency between device and switch, the
latency from the switch CDAT, the link latency between switch and the HB, and the
generic port latency between the CPU and the CXL HB. The bandwidth calculation would be the
min of device CDAT bandwidth, link bandwith between device and switch, switch CDAT
bandwidth, the link bandwidth between switch and HB, and the generic port bandwidth

There can be 0 or more switches between the CXL device and the CXL HB. There are detailed
examples on calculating bandwidth and latency in the CXL Memory Device Software Guide [4].

The CDAT provides Device Scoped Memory Affinity Structures (DSMAS) that contains the
Device Physical Address (DPA) range and the related Device Scoped Latency and Bandwidth
Informat Stuctures (DSLBIS). Each DSLBIS provides a latency or bandwidth entry that is
tied to a DSMAS entry via a per DSMAS unique DSMAD handle.

This series is based on Lukas's latest DOE changes [5]. Kernel branch with all the code can
be retrieved here [6] for convenience.

Test setup is done with runqemu genport support branch [6]. The setup provides 2 CXL HBs
with one HB having a CXL switch underneath. It also provides generic port support detailed
below.

A hacked up qemu branch is used to support generic port SRAT and HMAT [7].

To create the appropriate HMAT entries for generic port, the following qemu paramters must
be added:

-object genport,id=$X -numa node,genport=genport$X,nodeid=$Y,initiator=$Z
-numa hmat-lb,initiator=$Z,target=$X,hierarchy=memory,data-type=access-latency,latency=$latency
-numa hmat-lb,initiator=$Z,target=$X,hierarchy=memory,data-type=access-bandwidth,bandwidth=$bandwidthM
for ((i = 0; i < total_nodes; i++)); do
	for ((j = 0; j < cxl_hbs; j++ )); do	# 2 CXL HBs
		-numa dist,src=$i,dst=$X,val=$dist
	done
done

See the genport run_qemu branch for full details.

[1]: https://www.computeexpresslink.org/download-the-specification
[2]: https://uefi.org/sites/default/files/resources/Coherent%20Device%20Attribute%20Table_1.01.pdf
[3]: https://uefi.org/sites/default/files/resources/ACPI_Spec_6_5_Aug29.pdf
[4]: https://cdrdv2-public.intel.com/643805/643805_CXL%20Memory%20Device%20SW%20Guide_Rev1p0.pdf
[5]: https://lore.kernel.org/linux-cxl/20230313195530.GA1532686@bhelgaas/T/#t
[6]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-qtg
[7]: https://github.com/pmem/run_qemu/tree/djiang/genport
[8]: https://github.com/davejiang/qemu/tree/genport

---

Dave Jiang (21):
      cxl: Export QTG ids from CFMWS to sysfs
      cxl: Add checksum verification to CDAT from CXL
      cxl: Add support for reading CXL switch CDAT table
      cxl: Add common helpers for cdat parsing
      cxl: Add callback to parse the DSMAS subtables from CDAT
      cxl: Add callback to parse the DSLBIS subtable from CDAT
      cxl: Add callback to parse the SSLBIS subtable from CDAT
      cxl: Add support for _DSM Function for retrieving QTG ID
      cxl: Add helper function to retrieve ACPI handle of CXL root device
      cxl: Add helpers to calculate pci latency for the CXL device
      cxl: Add helper function that calculates QoS values for switches
      cxl: Add helper function that calculate QoS values for PCI path
      ACPI: NUMA: Add genport target allocation to the HMAT parsing
      ACPI: NUMA: Add helper function to retrieve the performance attributes
      cxl: Add helper function to retrieve generic port QoS
      cxl: Add latency and bandwidth calculations for the CXL path
      cxl: Wait Memory_Info_Valid before access memory related info
      cxl: Move identify and partition query from pci probe to port probe
      cxl: Store QTG IDs and related info to the CXL memory device context
      cxl: Export sysfs attributes for memory device QTG ID
      cxl/mem: Add debugfs output for QTG related data


 Documentation/ABI/testing/sysfs-bus-cxl |  20 ++
 drivers/acpi/numa/hmat.c                |  95 +++++++++
 drivers/cxl/acpi.c                      |   3 +
 drivers/cxl/core/Makefile               |   2 +
 drivers/cxl/core/acpi.c                 | 180 ++++++++++++++++++
 drivers/cxl/core/cdat.c                 | 243 ++++++++++++++++++++++++
 drivers/cxl/core/memdev.c               |  16 ++
 drivers/cxl/core/pci.c                  | 187 ++++++++++++++++--
 drivers/cxl/core/port.c                 | 169 ++++++++++++++++
 drivers/cxl/cxl.h                       |  27 +++
 drivers/cxl/cxlmem.h                    |  14 ++
 drivers/cxl/cxlpci.h                    | 121 ++++++++++++
 drivers/cxl/mem.c                       |  16 ++
 drivers/cxl/pci.c                       |  21 --
 drivers/cxl/port.c                      | 130 ++++++++++++-
 include/acpi/actbl3.h                   |   2 +
 include/linux/acpi.h                    |   6 +
 tools/testing/cxl/Kbuild                |   1 +
 tools/testing/cxl/test/mock.c           |   5 +
 19 files changed, 1221 insertions(+), 37 deletions(-)
 create mode 100644 drivers/cxl/core/acpi.c
 create mode 100644 drivers/cxl/core/cdat.c

--

