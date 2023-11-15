Return-Path: <linux-acpi+bounces-1535-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 424217ECA9A
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 19:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5A9CB20B2E
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 18:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4368231729
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVoilLmq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F01B18B;
	Wed, 15 Nov 2023 10:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700072332; x=1731608332;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xqZXn0Yxfn3Sk9v5JbBgGwiaA3KD1uEzo/vK6o/D7T4=;
  b=cVoilLmq9JtRoNN65FWqBi03qlDXixKbmsFd4kNT4BjXEGLscPtWCZ2a
   E6HwFGiJUA6XraBHp6n5HgoeYkToJqXAwNJSBeR2bQNTM4N1mJwbHWLup
   AVZJK2K7sOM2t/2WKLu2BRWsgjLOK9BAy+Sm8zvX1hsr37jZd5n3v2vjg
   iHi7FozsekIQBbFz6kCzzOdW5RDlNFucGfDyVv+LFK4tnQM+4TpWwgdNR
   5iQx/Ht/CNSxwAB9JZljTGkv4CFpqtSh/e6XmOLj00y6WNoZfeQYG2p3C
   W7TxekjwZx8lW9Yxj1Lx1TBcLbWC4XfkLfSpd4XX0FB01ulzhg+oOuadh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="381321128"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="381321128"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 10:18:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="831014657"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="831014657"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 10:18:45 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 5DA5411FC11;
	Wed, 15 Nov 2023 20:18:42 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: linux-media@vger.kernel.org,
	rafael@kernel.org,
	jacopo.mondi@ideasonboard.com,
	laurent.pinchart@ideasonboard.com
Subject: [PATCH 2/6] pm: runtime: Add pm_runtime_put_mark_busy_autosusp() helper
Date: Wed, 15 Nov 2023 20:18:36 +0200
Message-Id: <20231115181840.1509046-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231115181840.1509046-1-sakari.ailus@linux.intel.com>
References: <20231115181840.1509046-1-sakari.ailus@linux.intel.com>
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
index 810330bb802b..59871ab1532a 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -494,6 +494,23 @@ static inline int pm_runtime_put_autosuspend(struct device *dev)
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


