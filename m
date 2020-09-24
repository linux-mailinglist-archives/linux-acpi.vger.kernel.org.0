Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489AC2766AF
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Sep 2020 05:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgIXDFT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Sep 2020 23:05:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44738 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbgIXDFS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 23 Sep 2020 23:05:18 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B7215F411275ED48A070;
        Thu, 24 Sep 2020 11:05:15 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 24 Sep 2020 11:05:06 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v2 06/15] ACPI: custom_method: Remove the dead ACPICA debug code
Date:   Thu, 24 Sep 2020 10:56:58 +0800
Message-ID: <1600916227-21805-7-git-send-email-guohanjun@huawei.com>
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

ACPICA debug code _COMPONENT and ACPI_MODULE_NAME() is not
used in custom_method.c, remove it.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/custom_method.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index b097ef2..7b54dc9 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -13,8 +13,6 @@
 
 #include "internal.h"
 
-#define _COMPONENT		ACPI_SYSTEM_COMPONENT
-ACPI_MODULE_NAME("custom_method");
 MODULE_LICENSE("GPL");
 
 static struct dentry *cm_dentry;
-- 
1.7.12.4

