Return-Path: <linux-acpi+bounces-14309-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BCEAD7C2E
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jun 2025 22:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0533A4EC9
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jun 2025 20:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD17F2E1733;
	Thu, 12 Jun 2025 20:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HP36LuGH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF9C2E0B42;
	Thu, 12 Jun 2025 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749759211; cv=none; b=DG2CDWjODne2fIHhE6BQ7WCOtf1fIRxE5Xzo27sYxR5w4Ug4evTQCRdnNAKOgLxWjF9tukpzWPFVyXJEIcU562/p3CbqQnR1tv0nGNPo2oGz2TDBHqQGEwZY4oTw6LIpIV65PtrcwRsUZflQGJ4Sf1NkdV+haP11f/zP6eFE3Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749759211; c=relaxed/simple;
	bh=OvLIOLHVYmoxljxXazIm7M7nVajoTtrRYOwqHR9k41E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RsBNBmuM93hCALaHF0Ai2O/m9ccbf9O/kfWFlyn8mN6AIDVHovenYZGC9+wvAUsmSUznKoG5bm5M62m7vRzfBhSVT1Np0Ij9IH4TSxFhVB0tR/RPvYf/YEe5QJWW4Wq6Z1RI+gDf/UMx0Hq7pLTxTl8ME9wDZ3w7Fn+mWrhfFd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HP36LuGH; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749759210; x=1781295210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OvLIOLHVYmoxljxXazIm7M7nVajoTtrRYOwqHR9k41E=;
  b=HP36LuGHtlMx9Y3uO6MgD0r4MxzzyayLLa4YEEkCFROvAG1rhRtoaMDq
   uuCWZgcQ7P8Ee+gju1sgPbjxlHcoT6RDMFqTHkn04glMCDWz910GKvfFP
   WF8GVmlKfDzTRZouucihDk//ymNw9YdPpm/CiJeQk5Da5v6bHWyTxl+w1
   9hqIde2hRlkgchCR+kMD5NqiV40uZOVN+i/WO9RnLCaR98z8e9Bq+iD9v
   4Oy0kCqx9e+0fR35HSpB6Ozm4OJSV+3BO+ZFLrutJo99S54hqrfgKtqZI
   L7TAZu6h6Qrf1V9Xx1CwrT5W2SmiGV19B6dHrsx89UPRrh/9+nJUaZWrW
   A==;
X-CSE-ConnectionGUID: pIxWrbF/THOOPpcgR1KzZw==
X-CSE-MsgGUID: 2KEX5CFkRe268L/X8ll76Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="55761136"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="55761136"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 13:13:27 -0700
X-CSE-ConnectionGUID: X9nk8NKgReKV/lCbVGS/fA==
X-CSE-MsgGUID: D36gT3dqTQmSr7Trd8kdIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="148114138"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 12 Jun 2025 13:13:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8C8E819E; Thu, 12 Jun 2025 23:13:24 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v1 4/5] ACPI: proc: Use str_enabled_disabled() helper
Date: Thu, 12 Jun 2025 23:11:28 +0300
Message-ID: <20250612201321.3536493-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250612201321.3536493-1-andriy.shevchenko@linux.intel.com>
References: <20250612201321.3536493-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace ternary (condition ? "enabled" : "disabled") with
str_enabled_disabled() from string_choices.h to improve readability,
maintain uniform string usage, and reduce binary size through linker
deduplication.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/proc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/proc.c b/drivers/acpi/proc.c
index 8ae85b06c422..440150c67ba6 100644
--- a/drivers/acpi/proc.c
+++ b/drivers/acpi/proc.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/string_choices.h>
 #include <linux/suspend.h>
 #include <linux/bcd.h>
 #include <linux/acpi.h>
@@ -38,8 +39,7 @@ acpi_system_wakeup_device_seq_show(struct seq_file *seq, void *offset)
 		if (!dev->physical_node_count) {
 			seq_printf(seq, "%c%-8s\n",
 				dev->wakeup.flags.valid ? '*' : ' ',
-				device_may_wakeup(&dev->dev) ?
-					"enabled" : "disabled");
+				str_enabled_disabled(device_may_wakeup(&dev->dev)));
 		} else {
 			struct device *ldev;
 			list_for_each_entry(entry, &dev->physical_node_list,
@@ -54,9 +54,8 @@ acpi_system_wakeup_device_seq_show(struct seq_file *seq, void *offset)
 
 				seq_printf(seq, "%c%-8s  %s:%s\n",
 					dev->wakeup.flags.valid ? '*' : ' ',
-					(device_may_wakeup(&dev->dev) ||
-					device_may_wakeup(ldev)) ?
-					"enabled" : "disabled",
+					str_enabled_disabled(device_may_wakeup(ldev) ||
+							     device_may_wakeup(&dev->dev)),
 					ldev->bus ? ldev->bus->name :
 					"no-bus", dev_name(ldev));
 				put_device(ldev);
-- 
2.47.2


