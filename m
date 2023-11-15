Return-Path: <linux-acpi+bounces-1540-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5597ECAA2
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 19:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCAFD1F28325
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 18:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6D9364BC
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fcA6jjzm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFA11B8;
	Wed, 15 Nov 2023 10:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700072336; x=1731608336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3aLB1aRUdymuA6UhjFx/E2icz3ilO2LbesGWwW2V+rs=;
  b=fcA6jjzm0o+nzUO3j+jZ4Wlvv2hIg8U8ePRDzWZHF8ebuEgi/ElNuQKV
   0oVzpQRHQ1FvVlfDLzj/By5sQ99MpuIjFHThCrXFECk7n1XOl4HWfUtPz
   OpRvOS93rTauDBwMMj/FhmGy962LiCK4g0v2Tu8u0izhG52QuH1Q3FjHB
   Ug9H5CQygMVr3lL7DLgl8uOYbR3UzwuESYyvXVXMLQ4bEApF3/I6TC7g8
   xUaYsu/OzABLFVi14YKxpVMhLZgzdCfCOXek4Dt8v4nxOqzT/5pqYqaxI
   2BLmHGRrGUBLbGYSRO8k0ocwtx2GSS7+jGAlZegbaIRNtxz+4/TqJyA8Z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="381321156"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="381321156"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 10:18:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="831014666"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="831014666"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 10:18:48 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 2790311F830;
	Wed, 15 Nov 2023 20:18:46 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: linux-media@vger.kernel.org,
	rafael@kernel.org,
	jacopo.mondi@ideasonboard.com,
	laurent.pinchart@ideasonboard.com
Subject: [PATCH 6/6] media: imx219: Use pm_runtime_get_if_active(), put usage_count correctly
Date: Wed, 15 Nov 2023 20:18:40 +0200
Message-Id: <20231115181840.1509046-7-sakari.ailus@linux.intel.com>
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
 drivers/media/i2c/imx219.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index 8436880dcf7a..b38ee8b3e073 100644
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
+	pm_status = pm_runtime_get_if_active(&client->dev);
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


