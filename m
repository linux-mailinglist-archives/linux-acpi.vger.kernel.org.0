Return-Path: <linux-acpi+bounces-1539-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD267ECAA1
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 19:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498851F2831C
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 18:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E5B364C7
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N4eGbtHr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F43A18B;
	Wed, 15 Nov 2023 10:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700072336; x=1731608336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BHZ3rQCBwZttLGzPJ5NDl4vbRktavRob3om7tj6BWeQ=;
  b=N4eGbtHr8hDfMhAOoIc+ggUi/gfPxjgEsS0ZeOBIAucceYFmi+PaGX5f
   qYsvT3cIMMJZRITz4MUtwRTNrXtxltoIaEfir2pVRhfNqoYfL8xoX3y/l
   Ue2cyCeqSqb80rlS81m5X0BeFYPjXqwRHSVOKKIS2UOoNNBkC6X6Fhply
   hRt7a+B9G6RzbFUWhQtOweUBxvYSGq7iHhxg/ZOAGyvWJeOTVQoXrlUuI
   OTSGAKe0f2Bvhv2fveq/52qyeqH15RQYmldFleSDSXUSNUoRc/rdo/YEk
   B8ikFnHj6m2Id++Yvq3XTHg5ciuj4PI7N3kWvUpoRUEaDxD1MYFNjNVoW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="381321150"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="381321150"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 10:18:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="831014664"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="831014664"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 10:18:48 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 079D0120AB3;
	Wed, 15 Nov 2023 20:18:44 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: linux-media@vger.kernel.org,
	rafael@kernel.org,
	jacopo.mondi@ideasonboard.com,
	laurent.pinchart@ideasonboard.com
Subject: [PATCH 5/6] media: imx319: Use pm_runtime_get_if_active(), put usage_count correctly
Date: Wed, 15 Nov 2023 20:18:39 +0200
Message-Id: <20231115181840.1509046-6-sakari.ailus@linux.intel.com>
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
 drivers/media/i2c/imx319.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/imx319.c b/drivers/media/i2c/imx319.c
index 5378f607f340..b1031bba71b7 100644
--- a/drivers/media/i2c/imx319.c
+++ b/drivers/media/i2c/imx319.c
@@ -1880,8 +1880,8 @@ static int imx319_set_ctrl(struct v4l2_ctrl *ctrl)
 	struct imx319 *imx319 = container_of(ctrl->handler,
 					     struct imx319, ctrl_handler);
 	struct i2c_client *client = v4l2_get_subdevdata(&imx319->sd);
+	int ret, pm_status;
 	s64 max;
-	int ret;
 
 	/* Propagate change of current control to all related controls */
 	switch (ctrl->id) {
@@ -1898,7 +1898,8 @@ static int imx319_set_ctrl(struct v4l2_ctrl *ctrl)
 	 * Applying V4L2 control value only happens
 	 * when power is up for streaming
 	 */
-	if (!pm_runtime_get_if_in_use(&client->dev))
+	pm_status = pm_runtime_get_if_active(&client->dev);
+	if (!pm_status)
 		return 0;
 
 	switch (ctrl->id) {
@@ -1937,7 +1938,8 @@ static int imx319_set_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	}
 
-	pm_runtime_put(&client->dev);
+	if (pm_status > 0)
+		pm_runtime_put(&client->dev);
 
 	return ret;
 }
-- 
2.39.2


