Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D412C2691
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Nov 2020 13:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387582AbgKXMv0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Nov 2020 07:51:26 -0500
Received: from mail.loongson.cn ([114.242.206.163]:41634 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733265AbgKXMv0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 24 Nov 2020 07:51:26 -0500
Received: from bogon.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxCtG6Ab1fG_wVAA--.37925S2;
        Tue, 24 Nov 2020 20:51:07 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] acpi: Fix use-after-free in acpi_ipmi.c
Date:   Tue, 24 Nov 2020 20:51:06 +0800
Message-Id: <1606222266-11685-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9AxCtG6Ab1fG_wVAA--.37925S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKw18JrWfuw1rGw13Xw13Jwb_yoWfAFc_uF
        nFvr47WF1kAr10kr12vr15ZrWj9FsIqFZ3Wr18tFn2y3s3XrykXrW7Zry0qr13uw4UCFn0
        g3Wjyr4UAr1agjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb38YjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z2
        80aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG
        8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2js
        IE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE
        14v_Xr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI
        0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWI
        evJa73UjIFyTuYvjxUshF4DUUUU
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

kfree() has been called inside put_device so anther kfree would cause a
use-after-free bug.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 drivers/acpi/acpi_ipmi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
index 9d6c0fc..72902b6 100644
--- a/drivers/acpi/acpi_ipmi.c
+++ b/drivers/acpi/acpi_ipmi.c
@@ -130,7 +130,6 @@ ipmi_dev_alloc(int iface, struct device *dev, acpi_handle handle)
 			       ipmi_device, &user);
 	if (err) {
 		put_device(dev);
-		kfree(ipmi_device);
 		return NULL;
 	}
 	ipmi_device->user_interface = user;
@@ -142,7 +141,6 @@ static void ipmi_dev_release(struct acpi_ipmi_device *ipmi_device)
 {
 	ipmi_destroy_user(ipmi_device->user_interface);
 	put_device(ipmi_device->dev);
-	kfree(ipmi_device);
 }
 
 static void ipmi_dev_release_kref(struct kref *kref)
-- 
2.1.0

