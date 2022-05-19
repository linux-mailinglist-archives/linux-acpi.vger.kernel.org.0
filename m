Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB83B52D642
	for <lists+linux-acpi@lfdr.de>; Thu, 19 May 2022 16:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239880AbiESOh4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 May 2022 10:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239895AbiESOhl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 May 2022 10:37:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AB2AFB3F
        for <linux-acpi@vger.kernel.org>; Thu, 19 May 2022 07:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652971052; x=1684507052;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XyBfHMKW1tI5bLDOJnXn72Wt1g67Xg28eHyb5gv1SYs=;
  b=hRV84FV7YIRFaVWB0PN0eu1/Iyov10I+YOsl0WJ3DGuWwulhMipZmjdN
   EsAumAr2x5pzYKllvaDSOwqQAVVK8uHsspQB7k3ad+hf/YnxY3kwOxzyl
   ck7Yq+GeDDFdkommLAdRxdYGWVN+shDP5pSwpeT18rrqiGgWSctGAFuoV
   sUTA0lP5PbIublGWYRK2ajG/rT0Mi+vWxvQlJpkNEgUTh6ovPxZm7v1HH
   +KUFkCJGxfFbl4zbuW/oTMySgfoKgiAMpN1nbijerkXEy+UPvINECGqUZ
   j4oR+nIyrhrzVnoBCzE+sOVyD4BnYydSnYOJXrkg9MyHETYkDTTYWmJ47
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="271048156"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="271048156"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 07:37:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="598602289"
Received: from rzhang1-dev.sh.intel.com ([10.239.48.43])
  by orsmga008.jf.intel.com with ESMTP; 19 May 2022 07:37:18 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: video: improve PM notifer callback
Date:   Thu, 19 May 2022 22:37:32 +0800
Message-Id: <20220519143732.3804174-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

