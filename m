Return-Path: <linux-acpi+bounces-1579-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D697EF2B2
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Nov 2023 13:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87F36280A0E
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Nov 2023 12:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7DD30F83
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Nov 2023 12:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJWRQZ8d"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F241CD51;
	Fri, 17 Nov 2023 03:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700219684; x=1731755684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OPmQAk0OpQh83zt36TXMHBtJTrjTJma9nZ7JEe6oktc=;
  b=WJWRQZ8d/nRo3w9jtmwj4gUPKQshr38AXInt1VeCKRX7cOCsvnaxsEOA
   EF1FBX1qehpMv/ezPsbrv7b8q8Gzt7sb+/1Sg5+uKe+Ks5GJua/tO4IHE
   oIfPb+UpVSp/u45ner4oWGJrAJmcPrYnoIzF7BvaiVq82WFBgpKvXCdvn
   7B4DBiWxD/6vJng9inB6bKw8fQ3u9RpfWwBdYs/21dl3JBxd5aWh7LZj4
   EFOGeFSRBVvW3XEyO6AeVp3lcNiqVhnyGeezpFKs1Xk3i9qdJjkAG+9eO
   PIg01hkD9yMhE6rmn4wdeyj+PIfFg5RkJdxQTFlu6L993nNrxwBd0A5o1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="9941646"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="9941646"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 03:14:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="769201204"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="769201204"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 03:14:41 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 89CC8120F3E;
	Fri, 17 Nov 2023 13:14:38 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: linux-media@vger.kernel.org,
	rafael@kernel.org,
	jacopo.mondi@ideasonboard.com,
	laurent.pinchart@ideasonboard.com
Subject: [PATCH v2 6/7] media: imx319: Put usage_count correctly in s_ctrl callback
Date: Fri, 17 Nov 2023 13:14:32 +0200
Message-Id: <20231117111433.1561669-7-sakari.ailus@linux.intel.com>
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
 drivers/media/i2c/imx319.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/imx319.c b/drivers/media/i2c/imx319.c
index 5378f607f340..e7b2d0c20d29 100644
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
+	pm_status = pm_runtime_get_if_in_use(&client->dev);
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


