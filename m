Return-Path: <linux-acpi+bounces-1578-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B417EF2AF
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Nov 2023 13:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE024280A73
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Nov 2023 12:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6839330F80
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Nov 2023 12:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sg2bd+Wu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93170194;
	Fri, 17 Nov 2023 03:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700219682; x=1731755682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E51JwvVc+WS4nt6BjqwLo96XXpb3Un3sSEB2K+/Lpqo=;
  b=Sg2bd+WujtCjJCKaK94Bo/1IyjJkWb1tnDwQAeAGeTHluVIszsgzt/dN
   SRkpxB+9do/5m3Jc4mnIlGi04/RQPf3c2YJY1J8vNCYve1+48VEJI2omP
   fkNZpbGQJDx9wc/PZ8cT26hFi1/CuyvOYc1TLityYFIsw3dBQuJZynNVP
   g8L4OtzeeomPhkxf9ocdpwNHM5OKbZTJlqkQoFlwhkyxVFaFtMBDVjaO+
   zXQP85wFcvBReeJZugcHkhcsEM8iE4i0DKTo3kH0LVxSRhAMGUlK2PRup
   64A3BuwTBo2Q0ruRDfDRxLmSsuyL1EO6dXbytTN4mBV54ZbMjJlRzQ4fY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="9941633"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="9941633"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 03:14:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="769201196"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="769201196"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 03:14:38 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 2D916120ED2;
	Fri, 17 Nov 2023 13:14:35 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: linux-media@vger.kernel.org,
	rafael@kernel.org,
	jacopo.mondi@ideasonboard.com,
	laurent.pinchart@ideasonboard.com
Subject: [PATCH v2 2/7] pm: runtime: Add pm_runtime_put_mark_busy_autosusp() helper
Date: Fri, 17 Nov 2023 13:14:28 +0200
Message-Id: <20231117111433.1561669-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231117111433.1561669-1-sakari.ailus@linux.intel.com>
References: <20231117111433.1561669-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add pm_runtime_put_mark_busy_autosusp() helper function for users that
wish to set the last_busy timestamp to current time and put the
usage_count of the device and set the autosuspend timer.

Essentially calling pm_runtime_suspend_mark_busy_autosusp() equal to
calling first pm_runtime_mark_last_busy() and then
pm_runtime_put_autosuspend().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 include/linux/pm_runtime.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 13cd526634c1..4afe7b0b9d7e 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -495,6 +495,23 @@ static inline int pm_runtime_put_autosuspend(struct device *dev)
 	    RPM_GET_PUT | RPM_ASYNC | RPM_AUTO);
 }
 
+/**
+ * pm_runtime_put_mark_busy_autosusp - Update the last access time of a device
+ *				       and drop device usage counter and queue
+ *				       autosuspend if 0.
+ * @dev: Target device.
+ *
+ * Update the last access time of @dev using pm_runtime_mark_last_busy(), then
+ * decrement the runtime PM usage counter of @dev and if it turns out to be
+ * equal to 0, queue up a work item for @dev like in pm_request_autosuspend().
+ */
+static inline int pm_runtime_put_mark_busy_autosusp(struct device *dev)
+{
+	pm_runtime_mark_last_busy(dev);
+
+	return pm_runtime_autosuspend(dev);
+}
+
 /**
  * pm_runtime_put_sync - Drop device usage counter and run "idle check" if 0.
  * @dev: Target device.
-- 
2.39.2


