Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709E82766B9
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Sep 2020 05:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgIXDFZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Sep 2020 23:05:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46228 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726460AbgIXDFW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 23 Sep 2020 23:05:22 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AFC992FADA9FDEA35560;
        Thu, 24 Sep 2020 11:05:20 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 24 Sep 2020 11:05:10 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v2 14/15] ACPI: video: Remove the leftover ACPICA debug code
Date:   Thu, 24 Sep 2020 10:57:06 +0800
Message-ID: <1600916227-21805-15-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1600916227-21805-1-git-send-email-guohanjun@huawei.com>
References: <1600916227-21805-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

After commit (87521e16a7ab "acpi-video-detect: Rewrite backlight interface
selection logic"), ACPI_DEBUG_PRINT() was remove, so ACPI_MODULE_NAME()
and _COMPONENT are not used anymore, remove them.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/video_detect.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 2499d7e..d2981f7 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -35,9 +35,6 @@
 #include <linux/workqueue.h>
 #include <acpi/video.h>
 
-ACPI_MODULE_NAME("video");
-#define _COMPONENT		ACPI_VIDEO_COMPONENT
-
 void acpi_video_unregister_backlight(void);
 
 static bool backlight_notifier_registered;
-- 
1.7.12.4

