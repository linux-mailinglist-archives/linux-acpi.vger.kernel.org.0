Return-Path: <linux-acpi+bounces-9514-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EFF9C6590
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 00:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F29DB2AA47
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2024 22:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5732B21A4D0;
	Tue, 12 Nov 2024 22:13:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B84521A4A7;
	Tue, 12 Nov 2024 22:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731449618; cv=none; b=EJSQxwHFBbkJfQX2VROyFRtFBjcAS9QND/+vHoGWyKGUQNlbDNouCeD6J2hGqlkXaEWaiRy7LJgRhUGS5UVhcAUnV1ceMQ2kFL1TWjwdyUzHGIsgWyuTjkVcZb+KgiVNQKkkD3C6x8hoJ5H3/FkH3Ulx9tCT4CMXzok8mZgCKOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731449618; c=relaxed/simple;
	bh=r3gSCVx4mBfi39/3Mhartg80r4Jb6NJ4NVBvFg3cL7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KTaVaVuVxvCv9I+izPi2S02cvNdd5fKs3jdRFH7qsVIq3HJdZ2PVuiraIlqMLUpTBXPN55lYR7sxqGLIIr0P19UzQ80Fnn7cB3lrfIUtTbWMCKm4FKOwGoOHb31hpWs/+VZO6rgncM5ha8bXNxcluGlBcl/PQ8GKpiaoXA4BGvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D1AC4CECD;
	Tue, 12 Nov 2024 22:13:37 +0000 (UTC)
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
Subject: [RFC PATCH v2 0/6] acpi/hmat / cxl: Add exclusive caching enumeration and RAS support
Date: Tue, 12 Nov 2024 15:12:32 -0700
Message-ID: <20241112221335.432583-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
- Dropped 1/6 (ACPICA definition merged)
- Change UNKNOWN to RESERVED for cache definition. (Jonathan)
- Fix spelling errors (Jonathan)
- Rename region_res_match_range() to region_res_match_cxl_range(). (Jonathan)
- Add warning when cache is not 1:1 with backing region. (Jonathan)
- Code and comments cleanup. (Jonathan)
- Make MCE code access in CXL arch independent. (Jonathan)
- Fixup 0-day reports.

I'm looking for comments on the approach and the implementation of dealing with
this exclusive caching configuration. I have concerns with the discovering and
handling of the PCIe MMIO space in the memory mapping (MMIO hole) and looking
for suggestions on if there are better ways to do it. One example of MMIO hole
can possibly look like:
0 - 2G: RAM
2G-4G: MMIO
4G-end of memory: RAM
end of memory-infinity: 64-bit MMIO

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

Dave Jiang (5):
      acpi: numa: Add support to enumerate and store extended linear address mode
      acpi/hmat / cxl: Add extended linear cache support for CXL
      acpi/hmat: Add helper functions to provide extended linear cache translation
      cxl: Add extended linear cache address alias emission for cxl events
      cxl: Add mce notifier to emit aliased address for extended linear cache

 Documentation/ABI/stable/sysfs-devices-node |   6 ++
 arch/x86/include/asm/mce.h                  |   1 +
 arch/x86/mm/pat/set_memory.c                |   1 +
 drivers/acpi/numa/hmat.c                    | 195 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/base/node.c                         |   2 +
 drivers/cxl/core/Makefile                   |   2 +
 drivers/cxl/core/acpi.c                     |  21 ++++++
 drivers/cxl/core/core.h                     |  10 +++
 drivers/cxl/core/mbox.c                     |  45 ++++++++++-
 drivers/cxl/core/mce.c                      |  52 +++++++++++++
 drivers/cxl/core/mce.h                      |  14 ++++
 drivers/cxl/core/region.c                   | 107 +++++++++++++++++++++++++-
 drivers/cxl/core/trace.h                    |  24 ++++--
 drivers/cxl/cxl.h                           |   8 ++
 drivers/cxl/cxlmem.h                        |   2 +
 include/linux/acpi.h                        |  25 +++++++
 include/linux/node.h                        |   7 ++
 tools/testing/cxl/Kbuild                    |   1 +
 18 files changed, 508 insertions(+), 15 deletions(-)

