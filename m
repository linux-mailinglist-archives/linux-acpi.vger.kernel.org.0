Return-Path: <linux-acpi+bounces-13464-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F446AA9AD0
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 19:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0BED1889689
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 17:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25C625D207;
	Mon,  5 May 2025 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eh66KuTV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED222EEC3;
	Mon,  5 May 2025 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746466709; cv=none; b=Y2olbO0nJB/ZbEzJonvm76gT63oGJ+BzJyNYI0oGeXCtPKphpUb8ChfTDOWV5yTfcXIuXZ+0JwEvx+cwfsgSQu8Rk+AZUFOql9p190rhhjKDq63n1VI2d4edEkBtln+G4e37UDLTm02FG2tQ0abHj5K4M8KwhJMnNN6gleAjTlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746466709; c=relaxed/simple;
	bh=CyE8nIQK/SrdNbmMMzGos4oYdpNaa/3NLdNJmLW/RlI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JLBl/zp7DvlpGxNvpWxnzCVlE/ICO2hebRTlx/kucbXSmWmhaBH1uYVQQLaUDHmHxawLauSSPAvElI+fFH+UxBxOW1vTpi2ku6rQdj8Z3+m9gC6jj6IEZb7Mm4XjcUNAhWuJHyG0mTynIVPnD/Lp27ULHw8BqhJSJ95prVJ2YuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eh66KuTV; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746466708; x=1778002708;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CyE8nIQK/SrdNbmMMzGos4oYdpNaa/3NLdNJmLW/RlI=;
  b=eh66KuTVmwGa9tdWUAK5YAAh59fAQCqbuVuSnwvfOtb7Cnid3ywGH2gK
   7yQ87lvAwUbi6P24xoWPi+O+4+kwjLdBuRB7qsGeMZYQy8AbwGB2K3ih2
   7VO+e3uCo+UO2EFD/AUBQrKCGv6VC+muLbvGtHGmPMnrn6HY+6w1yt6iu
   I+MX43AEzadU3Ez2rMni2o3UielYFYV61ZvPQ3IiGqEcoAfwh1M3xlNQM
   GiJT5DZxc3kIKNt55ZUWfX89O9TDSmPgr/PQjeza7EJuOeDNh8T2q+AGo
   n0prx5fgbLsQL7cDCCc0QumdZYaooZzrg7aedHtADIHony0o/OJ1azdiG
   A==;
X-CSE-ConnectionGUID: B+lX8F/CSmyY87j/w5d5gQ==
X-CSE-MsgGUID: F4NQUFWbTUy3YaDtufxjJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="47991513"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="47991513"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 10:38:27 -0700
X-CSE-ConnectionGUID: cj9lDzCITPmR/x5nUFeUjA==
X-CSE-MsgGUID: sYArKipUT52QpRlPIVhbYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="140092223"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 10:38:27 -0700
From: Tony Luck <tony.luck@intel.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v5 0/3] Add interfaces for ACPI MRRM table
Date: Mon,  5 May 2025 10:38:16 -0700
Message-ID: <20250505173819.419271-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series based on:
	https://web.git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=testing

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

Changes since version 4 here:
https://lore.kernel.org/all/20250429202412.380637-1-tony.luck@intel.com/

*) Dropped patch 1. ACPICA changes have been merged into the linux-pm
   tree.
*) Removed spurious blank file from mrrm_init() (Thanks, Fenghua).

Tony Luck (3):
  ACPI/MRRM: Minimal parse of ACPI MRRM table
  ACPI/MRRM: Add /sys files to describe memory ranges
  ACPI: Add documentation for exposing MRRM data

 include/linux/acpi.h                          |   9 +
 drivers/acpi/acpi_mrrm.c                      | 182 ++++++++++++++++++
 Documentation/ABI/testing/sysfs-firmware-acpi |  21 ++
 arch/x86/Kconfig                              |   1 +
 drivers/acpi/Kconfig                          |   3 +
 drivers/acpi/Makefile                         |   1 +
 6 files changed, 217 insertions(+)
 create mode 100644 drivers/acpi/acpi_mrrm.c


base-repo: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
base-branch: testing
base-commit: 70cb3b9a371fe9ff4f50cd7889763abd4ab621dc
-- 
2.48.1


