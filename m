Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D032D705C
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Dec 2020 07:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436522AbgLKGva (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Dec 2020 01:51:30 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:8991 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391753AbgLKGut (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Dec 2020 01:50:49 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CshGm4V7nzhqWM;
        Fri, 11 Dec 2020 14:49:36 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 11 Dec 2020 14:49:59 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>
Subject: [PATCH] ACPI / AC: used pr_info instead of printk
Date:   Fri, 11 Dec 2020 14:50:12 +0800
Message-ID: <1607669412-21491-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

printk(KERNEL_INFO) is same with pr_info, so used pr_info instead of
printk.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/acpi/ac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 46a64e9..5e4b9c1 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -278,9 +278,9 @@ static int acpi_ac_add(struct acpi_device *device)
 		goto end;
 	}
 
-	printk(KERN_INFO PREFIX "%s [%s] (%s)\n",
-	       acpi_device_name(device), acpi_device_bid(device),
-	       ac->state ? "on-line" : "off-line");
+	pr_info(PREFIX "%s [%s] (%s)\n",
+		acpi_device_name(device), acpi_device_bid(device),
+		ac->state ? "on-line" : "off-line");
 
 	ac->battery_nb.notifier_call = acpi_ac_battery_notify;
 	register_acpi_notifier(&ac->battery_nb);
-- 
2.7.4

