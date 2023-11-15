Return-Path: <linux-acpi+bounces-1537-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C417ECA9D
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 19:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0570B1F28305
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 18:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79112364D0
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NXfXKfkN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF961A8;
	Wed, 15 Nov 2023 10:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700072335; x=1731608335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A9/YvkwCnHZnNCqK8j9jReosCqqZSDqKlSJZVgPOZyA=;
  b=NXfXKfkNO/YtySFtz44GhxGNhNfXno/ZGT/2i6GEw/5K+Br/XsE0yPlp
   wKS476bZRGQV+UmXmz5zynQfhnfGcsWz/wRoSFfxsTQIiOBsMtYebEtLv
   Ioa3POwJijSgLAN+9++DgSIoTCcVGJQVU2LYSBrtHcLC80AXEaufBiaAd
   5Q7rQOOZiKdnuBebBKo3gO1vez3s/eQ4p/ixAAJVYgDwyhVfdMfmTfTMn
   wPw0IG0ENms4nnSTdMwh3QDJQfBEilIsW37PGk21nUzHPFY0qIyxj21Oh
   0dW24qgcGWlgHIUOoTRx/6fKRGmlQ5QJNR7U+6oQqepeFZgXV6AH2ReMr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="381321142"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="381321142"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 10:18:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="831014661"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="831014661"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 10:18:46 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 285D01202AB;
	Wed, 15 Nov 2023 20:18:44 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: linux-media@vger.kernel.org,
	rafael@kernel.org,
	jacopo.mondi@ideasonboard.com,
	laurent.pinchart@ideasonboard.com
Subject: [PATCH 4/6] media: ov8858: Use pm_runtime_get_if_active(), put usage_count correctly
Date: Wed, 15 Nov 2023 20:18:38 +0200
Message-Id: <20231115181840.1509046-5-sakari.ailus@linux.intel.com>
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

Use pm_runtime_get_if_active() to get the device's runtime PM usage_count
and set controls, then use runtime PM autosuspend once the controls have
been set (instead of likely transitioning to suspended state immediately).

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/ov8858.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/ov8858.c b/drivers/media/i2c/ov8858.c
index 3af6125a2eee..a99b91700a8d 100644
--- a/drivers/media/i2c/ov8858.c
+++ b/drivers/media/i2c/ov8858.c
@@ -1538,7 +1538,7 @@ static int ov8858_set_ctrl(struct v4l2_ctrl *ctrl)
 	struct v4l2_subdev_state *state;
 	u16 digi_gain;
 	s64 max_exp;
-	int ret;
+	int ret, pm_status;
 
 	/*
 	 * The control handler and the subdev state use the same mutex and the
@@ -1561,7 +1561,8 @@ static int ov8858_set_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	}
 
-	if (!pm_runtime_get_if_in_use(&client->dev))
+	pm_status = pm_runtime_get_if_active(&client->dev);
+	if (!pm_status)
 		return 0;
 
 	switch (ctrl->id) {
@@ -1601,7 +1602,8 @@ static int ov8858_set_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	}
 
-	pm_runtime_put(&client->dev);
+	if (pm_status > 0)
+		pm_runtime_mark_busy_autosusp(&client->dev);
 
 	return ret;
 }
-- 
2.39.2


