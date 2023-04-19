Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761AF6E8280
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Apr 2023 22:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjDSUVK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Apr 2023 16:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjDSUVJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Apr 2023 16:21:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8130455BE;
        Wed, 19 Apr 2023 13:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681935663; x=1713471663;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hZuR9iC6y7SyOnvrg6dj8v6AFKu3QjVK3S6YAJQCSf4=;
  b=aZLylt4qdi9RFtgmdkLQGNtpbZNJ6/qw4BWhZeBiKInWnQTpmfnyQU/D
   SVGMoNDWk31oicCe/DpRA3/ghmekwdqZQpv4L7SgHOJiZjoeYJT1kwql7
   NuBwHKPlDxy0OgVQJ66056+IAnkBI07MQ70FUeUtdZ588CjaD4Dtg5ZPc
   un+QNsRMZxvlKBIuBYXrtBgOAc0kSNoNDBBLpkNbpZFeY2B0jgbyweot9
   Gv4v7nfzkl0YQaYihDIS5snG3S0b9J1djWHLOBx7n/jFDpX7nw+UBo0a3
   2/1OmYM1HylV6onMY/9Hu6cn2sE9lsPXrd9orCwtmNvrfNr6jJHt8+OaX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="334369526"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="334369526"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 13:21:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="937798459"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="937798459"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.179.6])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 13:21:02 -0700
Subject: [PATCH v4 00/23] cxl: Add support for QTG ID retrieval for CXL
 subsystem
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Wed, 19 Apr 2023 13:21:01 -0700
Message-ID: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

v4:
- Reworked PCIe link path latency calculation
- 0-day fixes
- Removed unused qos_list from cxl_memdev and its stray usages

v3:
- Please see specific patches for log entries addressing comments from v2.
- Refactor cxl_port_probe() additions. (Alison)
- Convert to use 'struct node_hmem_attrs'
- Refactor to use common code for genport target allocation.
- Add third array entry for target hmem_attrs to store genport locality data.
- Go back to per partition QTG ID. (Dan)

v2:
- Please see specific patches for log entries addressing comments from v1.
- Removed ACPICA code usages.
- Removed PCI subsystem helpers for latency and bandwidth.
- Add CXL switch CDAT parsing support (SSLBIS)
- Add generic port SRAT+HMAT support (ACPI)
- Export a single QTG ID via sysfs per memory device (Dan)
- Provide rest of DSMAS range info in debugfs (Dan)


Hi Rafael,
please review the relevant patches to ACPI: 13/23-16/23. Thank you!
If they are ok, Dan can take them through the CXL tree for upstream merging.
13 - Adds enum for memory_target hmem_attrs in order to enumerate the array index.
14 - Add generic port target allocation for SRAT parsing during HMAT init in order
to extract and store the device handle.
15 - Add a new index for hmem_attrs and save the locality data to the new hmem_attrs
array element with generic port data. The old array elements are preserved for later
when we want to store the calculated CXL memory target locality data.
16 - Add ACPI helper function to retrieve the locality data for generic port. Used by
CXL driver to calculate the full locality data for the CXL memory device.

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
as a sysfs attribute under the mem device memory partition type:
/sys/bus/cxl/devices/memX/ram/qtg_id
/sys/bus/cxl/devices/memX/pmem/qtg_id
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

Dave Jiang (23):
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
      ACPI: NUMA: Create enum for memory_target hmem_attrs indexing
      ACPI: NUMA: Add genport target allocation to the HMAT parsing
      ACPI: NUMA: Add setting of generic port locality attributes
      ACPI: NUMA: Add helper function to retrieve the performance attributes
      cxl: Add helper function to retrieve generic port QoS
      cxl: Add latency and bandwidth calculations for the CXL path
      cxl: Wait Memory_Info_Valid before access memory related info
      cxl: Move identify and partition query from pci probe to port probe
      cxl: Store QTG IDs and related info to the CXL memory device context
      cxl: Export sysfs attributes for memory device QTG ID
      cxl/mem: Add debugfs output for QTG related data


 Documentation/ABI/testing/debugfs-cxl   |  11 +
 Documentation/ABI/testing/sysfs-bus-cxl |  31 +++
 drivers/acpi/numa/hmat.c                | 138 ++++++++++--
 drivers/cxl/acpi.c                      |   3 +
 drivers/cxl/core/Makefile               |   2 +
 drivers/cxl/core/acpi.c                 | 180 ++++++++++++++++
 drivers/cxl/core/cdat.c                 | 270 ++++++++++++++++++++++++
 drivers/cxl/core/mbox.c                 |   3 +
 drivers/cxl/core/memdev.c               |  26 +++
 drivers/cxl/core/pci.c                  | 187 ++++++++++++++--
 drivers/cxl/core/port.c                 | 183 ++++++++++++++++
 drivers/cxl/cxl.h                       |  27 +++
 drivers/cxl/cxlmem.h                    |  21 ++
 drivers/cxl/cxlpci.h                    | 117 ++++++++++
 drivers/cxl/mem.c                       |  17 ++
 drivers/cxl/pci.c                       |  21 --
 drivers/cxl/port.c                      | 155 +++++++++++++-
 include/acpi/actbl3.h                   |   2 +
 include/linux/acpi.h                    |   6 +
 19 files changed, 1348 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-cxl
 create mode 100644 drivers/cxl/core/acpi.c
 create mode 100644 drivers/cxl/core/cdat.c

--

