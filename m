Return-Path: <linux-acpi+bounces-1582-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF3A7EF2B6
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Nov 2023 13:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66A81F27A06
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Nov 2023 12:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF9030F83
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Nov 2023 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CkXZVtuu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50514D57;
	Fri, 17 Nov 2023 03:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700219685; x=1731755685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wMdQE0ACbFrBEZ5gtKToux6b5gaXcnt3420OvS47qMo=;
  b=CkXZVtuuzrG7Lr9MFbXAdmTtawWn7KzMU0YRHnLLrUWg5NzhYBpPBLng
   Q4YsPsfT0XibAOWxv/K2W5XKPA+etzHKhg4dGvUKiHwz5hyqYxqbzGSPI
   Jxv6gY+tJ830l/xoqd4hud4+CE5NnjSrp39RwunRUGbK2jK10LzrSmtiL
   jTnpaseOPsKploMtj/kgaVNKby0S8pf61gspLEdiqSbLrgnKC1OUYjmCm
   y1C+jhU+5v934h3sMdOiLA2amSsUG/DfQpNecrT285eq10z4bi/mYtHxO
   cBG2/M36ahjPwjVomXqqeT8yiE+gJa7ERCvZNgxSzuWP6JCpW0YRfDTfC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="9941650"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="9941650"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 03:14:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="769201205"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="769201205"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 03:14:41 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 52E78120E67;
	Fri, 17 Nov 2023 13:14:39 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: linux-media@vger.kernel.org,
	rafael@kernel.org,
	jacopo.mondi@ideasonboard.com,
	laurent.pinchart@ideasonboard.com
Subject: [PATCH v2 7/7] media: imx219: Put usage_count correctly in s_ctrl callback
Date: Fri, 17 Nov 2023 13:14:33 +0200
Message-Id: <20231117111433.1561669-8-sakari.ailus@linux.intel.com>
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

pm_runtime_get_if_in_use() returns an error if Runtime PM is disabled for
the device, in which case it won't increment the use count.
pm_runtime_put() does that unconditionally however. Only call
pm_runtime_put() in case pm_runtime_get_if_in_use() has returned a value >
0.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/imx219.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index 8436880dcf7a..9865d0b41244 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -371,7 +371,7 @@ static int imx219_set_ctrl(struct v4l2_ctrl *ctrl)
 	struct i2c_client *client = v4l2_get_subdevdata(&imx219->sd);
 	const struct v4l2_mbus_framefmt *format;
 	struct v4l2_subdev_state *state;
-	int ret = 0;
+	int ret = 0, pm_status;
 
 	state = v4l2_subdev_get_locked_active_state(&imx219->sd);
 	format = v4l2_subdev_get_pad_format(&imx219->sd, state, 0);
@@ -393,7 +393,8 @@ static int imx219_set_ctrl(struct v4l2_ctrl *ctrl)
 	 * Applying V4L2 control value only happens
 	 * when power is up for streaming
 	 */
-	if (pm_runtime_get_if_in_use(&client->dev) == 0)
+	pm_status = pm_runtime_get_if_in_use(&client->dev);
+	if (!pm_status)
 		return 0;
 
 	switch (ctrl->id) {
@@ -446,7 +447,8 @@ static int imx219_set_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	}
 
-	pm_runtime_put(&client->dev);
+	if (pm_status > 0)
+		pm_runtime_put(&client->dev);
 
 	return ret;
 }
-- 
2.39.2


