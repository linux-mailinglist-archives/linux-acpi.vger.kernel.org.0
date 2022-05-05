Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5885051B591
	for <lists+linux-acpi@lfdr.de>; Thu,  5 May 2022 03:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236923AbiEECCG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 May 2022 22:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236720AbiEECCF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 May 2022 22:02:05 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BADB473BD;
        Wed,  4 May 2022 18:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651715908; x=1683251908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7tqwlSchStXbCHGSxqQd/Vgz7WRZ8Bl2Gc0YOUqfvzI=;
  b=GY3F26P6rm6HbGCcqFCL7OeP2IvNGau+SakvCASh51/fm1XzhAuRuFDx
   sFdqx1AMHJP6FxshoNaOePUtTcQd53qT17IQA/JSIgLlrcSOne4jrB8uK
   dsC3tZeH+UwbF3Jj0qd9ze/NMspC+5hwfK3xJVshu4jJNxnplqAhoVO3F
   3n3UpNxvcOVIe5pIQ/OrTekCVs6SIuDQb7k2Dzs9nownKZ6LN7Ozo6qKL
   TKvPbPO6uf6sIAE2QWzkVIQXz7jE5wHl6OK5RUx6cDLJtWiEu+B7Fo9Gg
   pUYjD3D+7r3bl0vF9PgWjAF2/yPAZLlFGZR2W/i8YGjI4VHes8ZEjroj1
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="293153477"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="293153477"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 18:58:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="537106007"
Received: from rzhang1-dev.sh.intel.com ([10.239.48.43])
  by orsmga006.jf.intel.com with ESMTP; 04 May 2022 18:58:24 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net, kvalo@kernel.org, alexandre.belloni@bootlin.com
Cc:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-wireless@vger.kernel.org,
        daniel.lezcano@linaro.org, merez@codeaurora.org, mat.jonczyk@o2.pl,
        sumeet.r.pawnikar@intel.com, len.brown@intel.com
Subject: [PATCH 4/7] ACPI: video: improve PM notifer callback
Date:   Thu,  5 May 2022 09:58:11 +0800
Message-Id: <20220505015814.3727692-5-rui.zhang@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220505015814.3727692-1-rui.zhang@intel.com>
References: <20220505015814.3727692-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PM notifier callbacks should check for supported events rather than filter
out the unsupported events. So that it won't break when a new event is
introduced.

No functional change in this patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 drivers/acpi/acpi_video.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 990ff5b0aeb8..e07782b1fbb6 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1707,24 +1707,23 @@ static int acpi_video_resume(struct notifier_block *nb,
 	int i;
 
 	switch (val) {
-	case PM_HIBERNATION_PREPARE:
-	case PM_SUSPEND_PREPARE:
-	case PM_RESTORE_PREPARE:
-		return NOTIFY_DONE;
-	}
-
-	video = container_of(nb, struct acpi_video_bus, pm_nb);
-
-	dev_info(&video->device->dev, "Restoring backlight state\n");
+	case PM_POST_HIBERNATION:
+	case PM_POST_SUSPEND:
+	case PM_POST_RESTORE:
+		video = container_of(nb, struct acpi_video_bus, pm_nb);
+
+		dev_info(&video->device->dev, "Restoring backlight state\n");
+
+		for (i = 0; i < video->attached_count; i++) {
+			video_device = video->attached_array[i].bind_info;
+			if (video_device && video_device->brightness)
+				acpi_video_device_lcd_set_level(video_device,
+						video_device->brightness->curr);
+		}
 
-	for (i = 0; i < video->attached_count; i++) {
-		video_device = video->attached_array[i].bind_info;
-		if (video_device && video_device->brightness)
-			acpi_video_device_lcd_set_level(video_device,
-					video_device->brightness->curr);
+		return NOTIFY_OK;
 	}
-
-	return NOTIFY_OK;
+	return NOTIFY_DONE;
 }
 
 static acpi_status
-- 
2.17.1

