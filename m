Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012EA3984E6
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jun 2021 11:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhFBJIU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 05:08:20 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3348 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhFBJIS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2021 05:08:18 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Fw31T52jpz19TQp;
        Wed,  2 Jun 2021 17:01:49 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:42 +0800
Received: from linux-ibm.site (10.175.102.37) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:05:42 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 03/18] ACPI: bus: Use pr_*() macros to replace printk()
Date:   Wed, 2 Jun 2021 16:54:25 +0800
Message-ID: <1622624080-56025-4-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1622624080-56025-1-git-send-email-guohanjun@huawei.com>
References: <1622624080-56025-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In commit ee98460b2ff9 ("ACPI: bus: Clean up printing messages"),
direct printk() invocations was replaced with the matching pr_*()
calls, but the left two printk() calls was merged at the same time
with the above cleaup commit, so we missed them for cleanup, let's
replace them now and we can remove the use of PREFIX later.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index be7da23..60787d9 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -370,7 +370,7 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 
 static void acpi_bus_decode_usb_osc(const char *msg, u32 bits)
 {
-	printk(KERN_INFO PREFIX "%s USB3%c DisplayPort%c PCIe%c XDomain%c\n", msg,
+	pr_info("%s USB3%c DisplayPort%c PCIe%c XDomain%c\n", msg,
 	       (bits & OSC_USB_USB3_TUNNELING) ? '+' : '-',
 	       (bits & OSC_USB_DP_TUNNELING) ? '+' : '-',
 	       (bits & OSC_USB_PCIE_TUNNELING) ? '+' : '-',
@@ -409,7 +409,7 @@ static void acpi_bus_osc_negotiate_usb_control(void)
 		return;
 
 	if (context.ret.length != sizeof(capbuf)) {
-		printk(KERN_INFO PREFIX "USB4 _OSC: returned invalid length buffer\n");
+		pr_info("USB4 _OSC: returned invalid length buffer\n");
 		goto out_free;
 	}
 
-- 
1.7.12.4

