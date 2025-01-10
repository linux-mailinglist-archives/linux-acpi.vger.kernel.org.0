Return-Path: <linux-acpi+bounces-10512-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 909BCA094E4
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2025 16:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5736C168D7D
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2025 15:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42B8210F76;
	Fri, 10 Jan 2025 15:19:17 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A54B674;
	Fri, 10 Jan 2025 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736522357; cv=none; b=uk3Rz+zYVaE65WwhMdXlUgSpBk9A99aqPL4NjG6QfuOvRxozRsXwE51hCEsCvSZUvJZD/kaynSZiuLIS58dvbz75M2HK8KVef8/n6VrDQRg/1ZyulAjYx13i0Dd0YxYXEBO3n8uQWaxpKhpkiG8EKJm/u2zoZ2pYOdsh5K/S03M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736522357; c=relaxed/simple;
	bh=iI+zkuPPGC6KVu7GjaczTIH5hOYA56r8kmqssm6oh2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BH1I5+gVSRRyuj99KQUFHwC8dbkCju12AxvcosqBiCVZmC0WJf1WGMv5YIVD/e4ZlbOfBIA74Dl9HXrCqLQ7OmLz+pedXW8n3GU7derOORY12Of9rS9Ra0exbg5+IP6cXNzRrSnLehZ/cZnQoy36PxI3LosY0C8aqWPTdRfFV5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27446C4CEE1;
	Fri, 10 Jan 2025 15:19:17 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: rafael@kernel.org,
	bp@alien8.de,
	dan.j.williams@intel.com,
	tony.luck@intel.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com
Subject: [PATCH v2 0/4] acpi/hmat / cxl: Add exclusive caching enumeration and RAS support
Date: Fri, 10 Jan 2025 08:17:43 -0700
Message-ID: <20250110151913.3462283-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
- Fix 0-day issues
- Fix checking of cache flag. (Ming)
- Add comment about cache range vs CFMWS. (Ming)
- Update EXPORT_SYMBOL_(). (Jonathan)
- Fix various code comments. (Jonathan)
- Emit hpa_alias0 instead of hpa_alias. (Jonathan)
- Introduce CONFIG_CXL_MCE to address kernel build dep issues.

v1:
- Drop RFC prefix
- Drop MMIO hole discovery. Will implement if there's real world implementation.
- Drop MCE_PRI_CXL. Use MCE_PRI_UC. (Boris)
- Minor refactors and grammar fixes. (Jonathan)
- Rename 'mode' to 'address_mode'. (Jonathan)

RFCv2:
- Dropped 1/6 (ACPICA definition merged)
- Change UNKNOWN to RESERVED for cache definition. (Jonathan)
- Fix spelling errors (Jonathan)
- Rename region_res_match_range() to region_res_match_cxl_range(). (Jonathan)
- Add warning when cache is not 1:1 with backing region. (Jonathan)
- Code and comments cleanup. (Jonathan)
- Make MCE code access in CXL arch independent. (Jonathan)
- Fixup 0-day reports.

Certain systems provide an exclusive caching memory configurations where a
1:1 layout of DRAM and far memory (FM) such as CXL memory is utilized. In
this configuration, the memory region is provided as a single memory region
to the OS. For example such as below:

             128GB DRAM                         128GB CXL memory
|------------------------------------|------------------------------------|

The kernel sees the region as a 256G system memory region. Data can reside
in either DRAM or FM with no replication. Hot data is swapped into DRAM by
the hardware behind the scenes.

This kernel series introduces code to enumerate the side cache by the kernel
when configured in a exclusive-cache configuration. It also adds RAS support
to deal with the aliased memory addresses.

A new ECN [1] to ACPI HMAT table was introduced and was approved to describe
the "extended-linear" addressing for direct-mapped memory-side caches. A
reserved field in the Memory Side Cache Information Structure of HMAT is
redefined as "Address Mode" where a value of 1 is defined as Extended-linear
mode. This value is valid if the cache is direct mapped. "It indicates that
the associated address range (SRAT.MemoryAffinityStructure.Length) is
comprised of the backing store capacity extended by the cache capacity." By
augmenting the HMAT and SRAT parsing code, this new information can be stored
by the HMAT handling code.

Current CXL region enumeration code is not enlightened with the side cache
configuration and therefore only presents the region size as the size of the
CXL region. Add support to allow CXL region enumeration code to query the HMAT 
handling code and retrieve the information regarding the side cache and adjust
the region size accordingly. This should allow the CXL CLI to display the
full region size rather than just the CXL only region size.

There are 3 sources where the kernel may be notified that error is detected for
memory.
1. CXL DRAM event. This is a CXL event that is generated when an error is
   detected by the CXL device patrol or demand scrubber. The trace_event is
   augmented to display the aliased System Phyiscal Address (SPA) in addition
   to the alerted address.  However, reporting of memory failure is TBD until
   the discussion [2] of failure reporting is settled upstream.
2. UCNA event from DRAM patrol or demand scrubber. This should eventually go
   through the MCE callback chain.
3. MCE from kernel consume poison.

It is possible that all 3 sources may report at the same time and all report
at the error.

For 2 and 3, a MCE notifier callback is registered by the CXL on a per device
basis. The callback will determine if the reported address is in one of the
special regions and offline the aliased address if that is the case.

[1]: https://lore.kernel.org/linux-cxl/668333b17e4b2_5639294fd@dwillia2-xfh.jf.intel.com.notmuch/
[2]: https://lore.kernel.org/linux-cxl/20240808151328.707869-2-ruansy.fnst@fujitsu.com/

---

Dave Jiang (4):
      acpi: numa: Add support to enumerate and store extended linear address mode
      acpi/hmat / cxl: Add extended linear cache support for CXL
      cxl: Add extended linear cache address alias emission for cxl events
      cxl: Add mce notifier to emit aliased address for extended linear cache

 Documentation/ABI/stable/sysfs-devices-node |   6 +++
 arch/x86/mm/pat/set_memory.c                |   1 +
 drivers/acpi/numa/hmat.c                    |  44 +++++++++++++++++++
 drivers/base/node.c                         |   2 +
 drivers/cxl/Kconfig                         |   4 ++
 drivers/cxl/core/Makefile                   |   2 +
 drivers/cxl/core/acpi.c                     |  11 +++++
 drivers/cxl/core/core.h                     |   8 ++++
 drivers/cxl/core/mbox.c                     |  36 ++++++++++++++--
 drivers/cxl/core/mce.c                      |  53 +++++++++++++++++++++++
 drivers/cxl/core/mce.h                      |  14 ++++++
 drivers/cxl/core/region.c                   | 110 ++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/cxl/core/trace.h                    |  24 +++++++----
 drivers/cxl/cxl.h                           |   8 ++++
 drivers/cxl/cxlmem.h                        |   2 +
 include/linux/acpi.h                        |  11 +++++
 include/linux/node.h                        |   7 +++
 tools/testing/cxl/Kbuild                    |   1 +
 18 files changed, 328 insertions(+), 16 deletions(-)

