Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AADB22C4C96
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Nov 2020 02:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbgKZB0l (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Nov 2020 20:26:41 -0500
Received: from mail.loongson.cn ([114.242.206.163]:56604 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730632AbgKZB0l (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 25 Nov 2020 20:26:41 -0500
Received: from bogon.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxutBKBL9ffsQWAA--.37398S2;
        Thu, 26 Nov 2020 09:26:34 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] acpi: Fix use-after-free in acpi_ipmi.c
Date:   Thu, 26 Nov 2020 09:26:34 +0800
Message-Id: <1606353994-10348-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9AxutBKBL9ffsQWAA--.37398S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKw18JF15Xry8JFy8GrWxWFg_yoWxZrb_u3
        ZF9rW7X3Wqyr10kr12vr1rZrWj9FsIqFZ3ur10qF1Ik3s3Xr97Jry7Z340vr15Zw4UGFn8
        XanFyr1kAr4agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb7AYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_KwCF04k2
        0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8HxR3UUUUU==
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

kfree() has been called inside put_device so anther kfree would cause a
use-after-free bug.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 drivers/acpi/acpi_ipmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
index 9d6c0fc..18edf8b 100644
--- a/drivers/acpi/acpi_ipmi.c
+++ b/drivers/acpi/acpi_ipmi.c
@@ -142,7 +142,6 @@ static void ipmi_dev_release(struct acpi_ipmi_device *ipmi_device)
 {
 	ipmi_destroy_user(ipmi_device->user_interface);
 	put_device(ipmi_device->dev);
-	kfree(ipmi_device);
 }
 
 static void ipmi_dev_release_kref(struct kref *kref)
-- 
2.1.0

