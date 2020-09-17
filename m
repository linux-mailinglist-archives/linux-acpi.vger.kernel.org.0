Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD2926D5F7
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Sep 2020 10:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIQILd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Sep 2020 04:11:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57632 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726381AbgIQIEz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Sep 2020 04:04:55 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7792259F09CA9F5AFFD1;
        Thu, 17 Sep 2020 15:46:55 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 15:46:48 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 11/25] ACPI: debugfs: Remove the ACPICA debug code
Date:   Thu, 17 Sep 2020 15:38:51 +0800
Message-ID: <1600328345-27627-12-git-send-email-guohanjun@huawei.com>
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

The ACPICA code is not used, remove it.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/debugfs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/acpi/debugfs.c b/drivers/acpi/debugfs.c
index d5ecea3..074eb98d 100644
--- a/drivers/acpi/debugfs.c
+++ b/drivers/acpi/debugfs.c
@@ -10,9 +10,6 @@
 
 #include "internal.h"
 
-#define _COMPONENT		ACPI_SYSTEM_COMPONENT
-ACPI_MODULE_NAME("debugfs");
-
 struct dentry *acpi_debugfs_dir;
 EXPORT_SYMBOL_GPL(acpi_debugfs_dir);
 
-- 
1.7.12.4

