Return-Path: <linux-acpi+bounces-10973-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FE9A2FB82
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 22:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB891669E3
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 21:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325A124C670;
	Mon, 10 Feb 2025 21:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P31MKEsA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7348424BCFD;
	Mon, 10 Feb 2025 21:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739221953; cv=none; b=EzRqva941R2pk/vQK41BTgH0D9cXEOJ+y5C+UpdijC0XecW1hq8louHs0ruH6XkA740nxFKl/TyviS4tRK85IDu2ckUCTlch8YUb0ISBbyRxfFal24AkWCfW/LY2T0PL5ar78x5IMh/aeiZjuT1QLD6wROQKVhnz5e2SR5tmqWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739221953; c=relaxed/simple;
	bh=FhBhyXDJXIuoPanAZKFkaze/gZWzPhRBvVyIHTjIrZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZWpm5nJp1m0WBu+2/RsRkDaiMDgQV0FsJne+FiBH5ksfkFHvOMQ9fG6sijs7UbqodR+fhfxGvkZowpZBppGjOueRxE7lRuD4pFLUH9b8DknTlCA4e/y8lALzoj8JIWetojpXf9jWBnqVG0W2UYhk39EA2iDVWU7V9wUapCuQLaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P31MKEsA; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739221952; x=1770757952;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FhBhyXDJXIuoPanAZKFkaze/gZWzPhRBvVyIHTjIrZ0=;
  b=P31MKEsARvLLXNUQ0yO5mytlzUQHxKhUiVRfQM+51VDE7bB6iak5tr7J
   v6xJA4fHbyIJRvf20SH6QMJv+5YcInQgXhVDmKtiD0JLWr96IcyvVzFis
   rUWijw2dPDNtKoId5FxG9TsS8hQkU3UZ2i19ned7pcln3XhGIvsfIV0jg
   07EczEseVDS9/YKPujw7VxnGjYNxQfjryYGyoKeiKEmTG7UWr39ck/SOs
   pCFxu78xavAcyI0ggJHExDMcSrlWocyMCVPc0QFCPMVR5twR6jDQvPjZ9
   BO7B3Wm3keycA7LXZxfZf66PCQ/fXD6XghYskD90rsd+mVnOdCjY8OXgJ
   g==;
X-CSE-ConnectionGUID: ZZMhWvRETUOBjgwPzQBztw==
X-CSE-MsgGUID: BAisLiPPQGWLycj2uXDZzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="39969728"
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; 
   d="scan'208";a="39969728"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 13:12:31 -0800
X-CSE-ConnectionGUID: Y00ORRFoQKuySL54Ru0/uQ==
X-CSE-MsgGUID: SBYD10rIQyqCrrJYW1lmjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116393877"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 13:12:30 -0800
From: Tony Luck <tony.luck@intel.com>
To: Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH 0/4] Add interfaces for ACPI MRRM table
Date: Mon, 10 Feb 2025 13:12:19 -0800
Message-ID: <20250210211223.6139-1-tony.luck@intel.com>
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
each range).

The region IDs will be used to provide separate event counts for each
region for "perf" and for the "resctrl" file system to monitor and
control memory bandwidth in each region.

Users will need to know the address range(s) that are part of each
region. This patch series adds /sys/devices/memory/rangeX directories
to provide user space accessible enumeration.

-Tony

[1] MRRM definition allow for future expansion for the OS to assign
these region IDs.

Fenghua Yu (1):
  ACPICA: Define MRRM ACPI table

Tony Luck (3):
  ACPI/MRRM: Create /sys/devices/system/memory/rangeX ABI
  ACPI/MRRM: Add "node" symlink to /sys/devices/system/memory/rangeX
  ACPI/MRRM: ABI documentation for /sys/devices/system/memory/rangeX

 include/linux/memory.h                        |   9 +
 include/acpi/actbl3.h                         |  40 ++++
 drivers/acpi/acpi_mrrm.c                      | 188 ++++++++++++++++++
 drivers/base/memory.c                         |   9 +
 .../ABI/testing/sysfs-devices-memory          |  32 +++
 arch/x86/Kconfig                              |   1 +
 drivers/acpi/Kconfig                          |   4 +
 drivers/acpi/Makefile                         |   1 +
 8 files changed, 284 insertions(+)
 create mode 100644 drivers/acpi/acpi_mrrm.c


base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
-- 
2.48.1


