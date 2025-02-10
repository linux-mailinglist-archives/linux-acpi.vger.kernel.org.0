Return-Path: <linux-acpi+bounces-10977-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE9FA2FB8A
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 22:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3816D16329A
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 21:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4BF24E4CB;
	Mon, 10 Feb 2025 21:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BjzJZl1C"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA2924CEE4;
	Mon, 10 Feb 2025 21:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739221957; cv=none; b=CU7U09IzjcolnktM2JZ/JJ6b8UBC2bUOMisRgjv17wpAQgzoIqFMK2JLlp4t+bGDpoDsf8+m1dzJnxqTtGOChTiQo8/VQ75ljSEhROpbMWsuON3aymhLUkaRqNLbB78icY/McICaPQmTBqmHOfDh92udOZu7Y+6y0M46L60VW70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739221957; c=relaxed/simple;
	bh=bXXOUiASgqk4c+hIO4L437SLM+6D5Advsy/FQVu/yV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFKqVkcGuo7o1yWFFPy+K8uOq98dBKnJFbNnbidunciG3/wgvvt2Hl2/bQGYKV2kRq9qVD7cTnaeZVNwBZQIwzsxfDVaduFBlIoXE5XtNVUiEwFKpO8fhW712Ud6x1uzUndQuNzJ8kG2fYl4lYe8anK9g2/riouoZ5whhc0u/7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BjzJZl1C; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739221956; x=1770757956;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bXXOUiASgqk4c+hIO4L437SLM+6D5Advsy/FQVu/yV4=;
  b=BjzJZl1C1xiGBMUNgeWjOW+kmw56b9SYx8LQLxQHpXoKqHBYCT4ki3ce
   Q+UT9vS9yS/BD/XmRIi9jy8S2OirsrRZZBlPQmwypEMI+PyRXh9AmUj2Y
   ZGRPfzvS3ozwueS+RzjrOICQobPq4uCwEVbx8boWYrEygjIR+nOAu67tT
   q86+PxHAmEHt7W6Vc9vo8Ls3g9YSglPDlEdlu+YLDpVve008b1Ha9noGZ
   Onv/n48FAxp9liusQotv6Acgchk8QwpIDGxyJvulKAODuSXv14TyzhbV4
   av5J7G9QtUt41RC6Czd/upUhyvau4E13VQjdzZfqBDhrwS5PEHEpjHAbK
   Q==;
X-CSE-ConnectionGUID: duBGsey5Qy+oMJRqhE7FTw==
X-CSE-MsgGUID: 2s0p6oK4SPiJRrwdiKG4Fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="39969769"
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; 
   d="scan'208";a="39969769"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 13:12:31 -0800
X-CSE-ConnectionGUID: y9RTFk+DQ0yuxNEyycL5zQ==
X-CSE-MsgGUID: K/qjkN4OTbibNI8BYQUVOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116393890"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 13:12:31 -0800
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
Subject: [PATCH 4/4] ACPI/MRRM: ABI documentation for /sys/devices/system/memory/rangeX
Date: Mon, 10 Feb 2025 13:12:23 -0800
Message-ID: <20250210211223.6139-5-tony.luck@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210211223.6139-1-tony.luck@intel.com>
References: <20250210211223.6139-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ABI providing users with a mapping between physical address ranges
and "region id" used by perf for uncore memory events and the
resctrl file system for per-region memory monitoring and control.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 .../ABI/testing/sysfs-devices-memory          | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-memory b/Documentation/ABI/testing/sysfs-devices-memory
index cec65827e602..fb01739e016e 100644
--- a/Documentation/ABI/testing/sysfs-devices-memory
+++ b/Documentation/ABI/testing/sysfs-devices-memory
@@ -118,3 +118,35 @@ Description:
 		(RO) indicates whether or not the kernel updates relevant kexec
 		segments on memory hot un/plug and/or on/offline events, avoiding the
 		need to reload kdump kernel.
+
+What:           /sys/devices/system/memory/rangeX/base
+Date:           January 2025
+Contact:	Tony Luck <tony.luck@intel.com>
+Description:
+		On systems with the ACPI MRRM table reports the
+		base system physical address of memory range X.
+
+What:           /sys/devices/system/memory/rangeX/length
+Date:           January 2025
+Contact:	Tony Luck <tony.luck@intel.com>
+Description:
+		On systems with the ACPI MRRM table reports the
+		size of rangeX system physical memory.
+
+What:           /sys/devices/system/memory/rangeX/local_region_id
+Date:           January 2025
+Contact:	Tony Luck <tony.luck@intel.com>
+Description:
+		On systems with the ACPI MRRM table reports the
+		the region id associated with memory access by
+		agents local to this range of addresses. Reports
+		0xff when no region id has been assigned.
+
+What:           /sys/devices/system/memory/rangeX/remote_region_id
+Date:           January 2025
+Contact:	Tony Luck <tony.luck@intel.com>
+Description:
+		On systems with the ACPI MRRM table reports the
+		the region id associated with memory access by
+		agents non-local to this range of addresses. Reports
+		0xff when no region id has been assigned.
-- 
2.48.1


