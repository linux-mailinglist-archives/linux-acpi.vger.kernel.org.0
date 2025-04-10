Return-Path: <linux-acpi+bounces-12956-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C80A84FAC
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 00:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0C519E3C09
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 22:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B832B1DED40;
	Thu, 10 Apr 2025 22:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SxxQArfP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E922F2905;
	Thu, 10 Apr 2025 22:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744324338; cv=none; b=JxddEGsucg3+O8NxT7dWOLNOkhWR1AYkF63MA6TKKEhedgZhF8zadOlnL+3srSu3MbzQAIa/e/7+9yfJ3fASb17GAnvK8sIOT4vAbQ0lbNI6mzRjsUyjHOv7Xt7wJjFPvBpMagSxVOE3GJcAeK/59Kuue+3alQjEZP4Ddvy0enA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744324338; c=relaxed/simple;
	bh=/MNEJun8mN9wBvPTrRr3BCmyxv8MkoWawmsQxDaLYPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DA1XIa9jE0mCZLXTrR+Whf1hxAIl4T3+dvaZqJTtDkWlj1wf3D5QDrV+3hCinVyAEc4Jtiivbf28dm8++RWCkzHxlwkvQdEqFfcl3fDCMjk5J/pMms1P900Au8HhHiI7VP3UbXVa+Aa7/77Sa05jCQsG0O2cj3lmZnd7puN58A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SxxQArfP; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744324337; x=1775860337;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/MNEJun8mN9wBvPTrRr3BCmyxv8MkoWawmsQxDaLYPA=;
  b=SxxQArfP5D6e6Row1WD5F5MU9mdWPfgwdVStbqLNFQ0b95OVrp8AgHQ2
   BMsHZ99sd4w9swH76TFw6KruSIu5aKWwbjgbmn9kX2AASd5rdl1P8hFC5
   noYU2D8h0XUQPu4hZxhb7LrmAX1DYDK1k1wl2PguRoC4Ma4nVaU3WQPaP
   UyQvAQkInc00nAPmmCtgYFjfM3ojrryQDZmw+S3MVT11Lz6MRqqnTFSl5
   9LzyTCHWufObeX+LcxzFcFE7I1B20ZMABR06SpStKNI+EIJ2F6dhgfAVd
   0+iRZhYVpxUaxpmO43dDnlSrjM+ACYzYBgSIbSuytJRD5SyMvuABPBc51
   g==;
X-CSE-ConnectionGUID: c5ScI66wQSSZzByl7GOS1Q==
X-CSE-MsgGUID: mfKcJfd2SCuzwYCnq1K1Yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="56845627"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="56845627"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 15:32:16 -0700
X-CSE-ConnectionGUID: o17e926cTeOszgHlX7/BoQ==
X-CSE-MsgGUID: GZAl8x3dTOO6BKHhQTjrtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="128988745"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 15:32:16 -0700
From: Tony Luck <tony.luck@intel.com>
To: rafael.j.wysocki@intel.com
Cc: lenb@kernel.org,
	Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 0/4] Add interfaces for ACPI MRRM table
Date: Thu, 10 Apr 2025 15:32:03 -0700
Message-ID: <20250410223207.257722-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory used to be homogeneous. Then NUMA came along. Later different
types of memory (persistent memory, on-package high bandwidth memory,
CXL attached memory).

Each type of memory has its own performance characteristics, and users
will need to monitor and control access by type.

The MRRM solution is to tag physical address ranges with "region IDs"
so that platform firmware[1] can indicate the type of memory for each
range (with separate tags available for local vs. remote access to
each range). Note that these ranges can include addresses reserved
for future hotplugged memory.

The region IDs will be used to provide separate event counts for each
region for "perf" and for the "resctrl" file system to monitor and
control memory bandwidth in each region.

Users will need to know the address range(s) that are part of each
region. This patch series adds
	/sys/firmware/acpi/memory_ranges/rangeX
directories to provide user space accessible enumeration.

-Tony

[1] MRRM definition allow for future expansion for the OS to assign
these region IDs.

Changes since version 2 here:
https://lore.kernel.org/all/20250227224828.306537-1-tony.luck@intel.com/

1) Changes in patch 1 are now in the R2025_04_04 release of the ACPICA
project (plus PR #1015 to fix a naming issue for "acpisrc" conversion
to Linux format).

2) Split the /sys/firmware part into its own patch. Linux resctrl only
needs the enumeration of the number of supported regions.

3) Added a "node" file to each of the rangeX directories to report
which NUMA node the range belongs to.

4) Dropped the debug-only last patch in the series as I now have
other methods to test this code.

Tony Luck (4):
  ACPICA: Define MRRM ACPI table
  ACPI/MRRM: Minimal parse of ACPI MRRM table
  ACPI/MRRM: Add /sys files to describe memory ranges
  ACPI: Add documentation for exposing MRRM data

 include/linux/acpi.h                          |   6 +
 include/acpi/actbl1.h                         |   7 +
 include/acpi/actbl2.h                         |  42 ++++
 drivers/acpi/acpi_mrrm.c                      | 185 ++++++++++++++++++
 Documentation/ABI/testing/sysfs-firmware-acpi |  21 ++
 arch/x86/Kconfig                              |   1 +
 drivers/acpi/Kconfig                          |   3 +
 drivers/acpi/Makefile                         |   1 +
 8 files changed, 266 insertions(+)
 create mode 100644 drivers/acpi/acpi_mrrm.c


base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
-- 
2.48.1


