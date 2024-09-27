Return-Path: <linux-acpi+bounces-8462-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7470C9886F1
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 16:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10388B20DA2
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 14:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCB88248D;
	Fri, 27 Sep 2024 14:21:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3DE81ADA;
	Fri, 27 Sep 2024 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446885; cv=none; b=AAidw9Xim0fU0UZkFJo4zWwwPIBSreClgaQsJIW0b0GXS28hVIaVkiHUP597RNdAICOl6jdrDlDsiJXiRjxZ7R7LOekQv4KQA6H9OUq1HOS9mNvpwuCRmEI5JL7WGDT4hNIEAda5jxqnEiGOw6j6IOg7RzPvnsA8gG6GpaD5xLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446885; c=relaxed/simple;
	bh=LB+wFiTYfh2w4LO5VulVa9YZc7FkDpuHt5GXshnBYks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EhNv0Eb+hAL+lfNsKcmmqPJqaAdYYANz+9MdKUiaPd4/8l+11sEe2Tbt+YsySP1FrbknlHoqkoieTRqFNVxCQc/WjCkY9UV5AEs3zcABt1dNWtzeSjZs8GPhAtAvNx+oVKVctZbPQTJWW7K9oq+KBMFHY+z+OUz2pjGcEMbQ5no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3A2C4CECF;
	Fri, 27 Sep 2024 14:21:24 +0000 (UTC)
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
Subject: [RFC PATCH 0/6] acpi/hmat / cxl: Add exclusive caching enumeration and RAS support
Date: Fri, 27 Sep 2024 07:16:52 -0700
Message-ID: <20240927142108.1156362-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,
I'm looking for comments on the approach and the implementation of dealing with
this exclusive caching configuration. I have concerns with the discovering and
handling of I/O hole in the memory mapping and looking for suggestions on if
there are better ways to do it. I will be taking a 4 weeks sabbatical starting
next week and I apologize in advance in the delay on responses. Thank you in
advance for reviewing the patches.

The MCE folks will be interested in patch 6/6 where MCE_PRIO_CXL is added.


Certain systems provide an exclusive caching memory configurations where a
1:1 layout of DRAM and far memory (FR) such as CXL memory is utilized. In
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

Dave Jiang (6):
      ACPICA: actbl1.h: Add extended linear address mode to MSCIS
      acpi: numa: Add support to enumerate and store extended linear address mode
      acpi/hmat / cxl: Add extended linear cache support for CXL
      acpi/hmat: Add helper functions to provide extended linear cache translation
      cxl: Add extended linear cache address alias emission for cxl events
      cxl: Add mce notifier to emit aliased address for extended linear cache

 Documentation/ABI/stable/sysfs-devices-node |   7 ++
 arch/x86/include/asm/mce.h                  |   1 +
 arch/x86/mm/pat/set_memory.c                |   1 +
 drivers/acpi/numa/hmat.c                    | 183 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/base/node.c                         |   2 +
 drivers/cxl/core/Makefile                   |   1 +
 drivers/cxl/core/acpi.c                     |  21 ++++++
 drivers/cxl/core/core.h                     |  10 +++
 drivers/cxl/core/mbox.c                     |  87 ++++++++++++++++++++++-
 drivers/cxl/core/region.c                   |  78 +++++++++++++++++++--
 drivers/cxl/core/trace.h                    |  24 ++++---
 drivers/cxl/cxl.h                           |   8 +++
 drivers/cxl/cxlmem.h                        |   2 +
 include/acpi/actbl1.h                       |   5 +-
 include/linux/acpi.h                        |  22 ++++++
 include/linux/node.h                        |   7 ++
 tools/testing/cxl/Kbuild                    |   1 +
 17 files changed, 443 insertions(+), 17 deletions(-)

