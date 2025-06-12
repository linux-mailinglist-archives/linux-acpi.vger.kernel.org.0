Return-Path: <linux-acpi+bounces-14305-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E51DAD7C32
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jun 2025 22:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9708E1881D8E
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jun 2025 20:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872822E0B40;
	Thu, 12 Jun 2025 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ioT39UGF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A184C2D543F;
	Thu, 12 Jun 2025 20:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749759209; cv=none; b=mIwJQSwb3EWaDL5vSrmeDa4bCAKR0nAOBdDdJrgA6ITKCheuZTCBoPm1Q9tY/ed2G2iiO8Yr6H6iqEViqLC+F3VnioYvQvXv3gHguMrjAYg+iTu5+fok9rD+La5kEz/BhGFHi01r5SbwxDAuGCxvCEjKPqIYGdty33M1qJtbxw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749759209; c=relaxed/simple;
	bh=jiXN2lT2Mg8lozoTHx7bb4oAfcHcxJtAnRZWPKNM9jA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MrsJJukTUOCvrxn7OqbH7v5iKgX1ccRhXrxwz7Il0mA0UW/7yrwewjt7jtogzdYtLZ8IzGrlFMy2PhasMIHoUxOTmLLBYNZeuNef+5N6G8ummzsXoNIutfWjZSLMNk2tV/NAOU8tiOfUmUUkDqoXUwOwN68JOKdgcW+BKx0nb98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ioT39UGF; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749759208; x=1781295208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jiXN2lT2Mg8lozoTHx7bb4oAfcHcxJtAnRZWPKNM9jA=;
  b=ioT39UGFLn3lBQVmcYgAdewVFfzsrQZsUNVj+5HTJzqwi2+JLll1lSed
   RSMEsJYLzsRXzDCuIXRJC880VqgRSXU6wGMbSgrLDbdR8dPAWHBuS/sro
   8ZQLCLISmaMkQdWfH4FgsE0qKQpfVovJ48WDfExa/UEml+Pw3/g/rAb66
   ebxxtTC7guNnF3UMUhG+5DnZtQT/MaHNdu+UPvatf9RXcCfjPqR92rlSD
   u34fJAI3AtGY/OxK5WvjMGJ6HATdqRagZIj8RPFXYKylgUJryNNLEFanT
   J7UjVdCbjkC878+mx6CKOrN3Y8tb0v/EGHREssKD8V0kpPKixu66Ht1PD
   w==;
X-CSE-ConnectionGUID: 1PDLsv7DQIawsjTi/sCRpA==
X-CSE-MsgGUID: JxREkC0mRtO2R5TEP5N7hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="54588551"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="54588551"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 13:13:27 -0700
X-CSE-ConnectionGUID: oDHZJ1YPQFG1TZoPK6Dmjw==
X-CSE-MsgGUID: /D1v+w8vSWWKV8FfU4PFcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="152393996"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 12 Jun 2025 13:13:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 59414168; Thu, 12 Jun 2025 23:13:24 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v1 1/5] ACPI: wakeup: Drop unneeded casting for sleep_state
Date: Thu, 12 Jun 2025 23:11:25 +0300
Message-ID: <20250612201321.3536493-2-andriy.shevchenko@linux.intel.com>
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

Back to the original patch [1] sleep_state was defined as
a custom acpi_integer type variable. Nowadays it's plain
u64. No need to have casting for it anymore.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=1415 [1]
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/wakeup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/wakeup.c b/drivers/acpi/wakeup.c
index b02bf770aead..ff6dc957bc11 100644
--- a/drivers/acpi/wakeup.c
+++ b/drivers/acpi/wakeup.c
@@ -42,7 +42,7 @@ void acpi_enable_wakeup_devices(u8 sleep_state)
 	list_for_each_entry_safe(dev, tmp, &acpi_wakeup_device_list,
 				 wakeup_list) {
 		if (!dev->wakeup.flags.valid
-		    || sleep_state > (u32) dev->wakeup.sleep_state
+		    || sleep_state > dev->wakeup.sleep_state
 		    || !(device_may_wakeup(&dev->dev)
 			 || dev->wakeup.prepare_count))
 			continue;
@@ -67,7 +67,7 @@ void acpi_disable_wakeup_devices(u8 sleep_state)
 	list_for_each_entry_safe(dev, tmp, &acpi_wakeup_device_list,
 				 wakeup_list) {
 		if (!dev->wakeup.flags.valid
-		    || sleep_state > (u32) dev->wakeup.sleep_state
+		    || sleep_state > dev->wakeup.sleep_state
 		    || !(device_may_wakeup(&dev->dev)
 			 || dev->wakeup.prepare_count))
 			continue;
-- 
2.47.2


