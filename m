Return-Path: <linux-acpi+bounces-14308-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2588AD7C2D
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jun 2025 22:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4BD91700FA
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jun 2025 20:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9812E0B44;
	Thu, 12 Jun 2025 20:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZiX7CHmW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D5B2E0B56;
	Thu, 12 Jun 2025 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749759211; cv=none; b=G18G/5p0kO6IF06aFbd/3hMki7myvQbTGXl6KlhQAZE/yoXzwlU4TUsfuHnWBsgbQTKgzPl4DiSFFRZP35IsD995LLSA2eK74H7XaPuTWidZwIOwaFXMo4aWKEg1dWKPwDDlCgUY9Mr8zRhL768HKr5VMc7gEutnK/8nJVqB3kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749759211; c=relaxed/simple;
	bh=+pCE1xm1azKhfoWVwggxBY79YjQj7FFgR2g3ro0J8wI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKHeozt8dpuFIJyefzk2zKilIH0NTC3nf2RaR9ohKsgxINb9gUKnB2j7vm42SJ8YT6/Ioq6/R9DvAETYO4SLS2grLZMGX47OANZbXcVKpdKIkSX2q7HJhtrDRRbU2XA4egBxukqt9OIkEbPZfB+mOVhZU1Zwh0dQDGADM1gYg1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZiX7CHmW; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749759210; x=1781295210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+pCE1xm1azKhfoWVwggxBY79YjQj7FFgR2g3ro0J8wI=;
  b=ZiX7CHmWywciOkdqTHya17z9nX5EqBCy4i0mTvkpwpgAj6Ovlb9moQWD
   ZrYQ69DK5EPXMV5koHTKhCyjNDFAU8RtqyYzCzhEOp2wAuLLEGhAbL46q
   /LJEHx1CHH+5nY477A/v+xfUnE0uRd2E6OdpaqpTJQcHgAsEqUUyo1RRi
   0v5qXxCxtlo5ddVo4EHYG2FlZus6vF3BDWmGFO5Q3nNir5lFHMAsapgsA
   swFc+Tsa5MR85dw7/5srNqSyOFmgpnNhXEQ7Z49xAcmvIFh7va9wTBKat
   X7OwrFkEmKNMWGmSZ5be9rm2YfFIhCgcFGACvQ9pH6L5FOfCGMD3BTDyp
   A==;
X-CSE-ConnectionGUID: M7l/9g89TpCFWm/64YX6xg==
X-CSE-MsgGUID: o5Qdr29eTLu+h5Rh+2aa6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="54588555"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="54588555"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 13:13:27 -0700
X-CSE-ConnectionGUID: Vgwf6eOUT5+d3c7tMK7HpA==
X-CSE-MsgGUID: QB+ioz5jSkWNOjoxfwOCsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="152393998"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 12 Jun 2025 13:13:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6E11C1DF; Thu, 12 Jun 2025 23:13:24 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v1 2/5] ACPI: proc: Use correct format specifier and drop casting
Date: Thu, 12 Jun 2025 23:11:26 +0300
Message-ID: <20250612201321.3536493-3-andriy.shevchenko@linux.intel.com>
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

The format string in acpi_system_wakeup_device_seq_show() uses incorrect
specifier along with explicit (unneeded) casting. Drop the latter and
update the former.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/proc.c b/drivers/acpi/proc.c
index 4322f2da6d10..48215ba09193 100644
--- a/drivers/acpi/proc.c
+++ b/drivers/acpi/proc.c
@@ -30,9 +30,9 @@ acpi_system_wakeup_device_seq_show(struct seq_file *seq, void *offset)
 		if (!dev->wakeup.flags.valid)
 			continue;
 
-		seq_printf(seq, "%s\t  S%d\t",
+		seq_printf(seq, "%s\t  S%llu\t",
 			   dev->pnp.bus_id,
-			   (u32) dev->wakeup.sleep_state);
+			   dev->wakeup.sleep_state);
 
 		mutex_lock(&dev->physical_node_lock);
 
-- 
2.47.2


