Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1097E26D5E1
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Sep 2020 10:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgIQIKr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Sep 2020 04:10:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36834 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726388AbgIQIFK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Sep 2020 04:05:10 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 98E87703CE1EC1BDF4DF;
        Thu, 17 Sep 2020 15:47:00 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 15:46:54 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 22/25] ACPI: video: Remove the dead ACPICA debug code
Date:   Thu, 17 Sep 2020 15:39:02 +0800
Message-ID: <1600328345-27627-23-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1600328345-27627-1-git-send-email-guohanjun@huawei.com>
References: <1600328345-27627-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Remove the not used ACPICA debug code.

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

