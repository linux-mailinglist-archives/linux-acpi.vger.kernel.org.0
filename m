Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D08726D5E2
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Sep 2020 10:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgIQIKs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Sep 2020 04:10:48 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36836 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726411AbgIQIFK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Sep 2020 04:05:10 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9CD494BE50FCF8929D0A;
        Thu, 17 Sep 2020 15:47:00 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 15:46:53 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 20/25] ACPI: tiny-power-button: Remove the dead ACPICA debug code
Date:   Thu, 17 Sep 2020 15:39:00 +0800
Message-ID: <1600328345-27627-21-git-send-email-guohanjun@huawei.com>
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

The ACPICA debug code is not used, can be removed.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/tiny-power-button.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/tiny-power-button.c b/drivers/acpi/tiny-power-button.c
index 6273d73..420e61b 100644
--- a/drivers/acpi/tiny-power-button.c
+++ b/drivers/acpi/tiny-power-button.c
@@ -4,7 +4,6 @@
 #include <linux/acpi.h>
 #include <acpi/button.h>
 
-ACPI_MODULE_NAME("tiny-power-button");
 MODULE_AUTHOR("Josh Triplett");
 MODULE_DESCRIPTION("ACPI Tiny Power Button Driver");
 MODULE_LICENSE("GPL");
-- 
1.7.12.4

