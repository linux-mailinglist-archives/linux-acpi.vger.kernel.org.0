Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A73034B53D
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Mar 2021 08:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhC0Hts (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 27 Mar 2021 03:49:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15343 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhC0HtT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 27 Mar 2021 03:49:19 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F6rXK4WSSz93yh;
        Sat, 27 Mar 2021 15:47:13 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 15:49:05 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <rui.zhang@intel.com>,
        <bhelgaas@google.com>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH v2 10/15] ACPI: button: fix some coding style issues
Date:   Sat, 27 Mar 2021 15:46:28 +0800
Message-ID: <1616831193-17920-11-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616831193-17920-1-git-send-email-tanxiaofei@huawei.com>
References: <1616831193-17920-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fix some coding style issues reported by checkpatch.pl, including
following types:

WARNING: Block comments use * on subsequent lines
WARNING: Block comments use a trailing */ on a separate line
ERROR: code indent should use tabs where possible

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/acpi/button.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 85e5e03..c66db72 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -157,8 +157,9 @@ module_param(lid_report_interval, ulong, 0644);
 MODULE_PARM_DESC(lid_report_interval, "Interval (ms) between lid key events");
 
 /* --------------------------------------------------------------------------
-                              FS Interface (/proc)
-   -------------------------------------------------------------------------- */
+ *			FS Interface (/proc)
+ * --------------------------------------------------------------------------
+ */
 
 static struct proc_dir_entry *acpi_button_dir;
 static struct proc_dir_entry *acpi_lid_dir;
@@ -349,8 +350,9 @@ static int acpi_button_remove_fs(struct acpi_device *device)
 }
 
 /* --------------------------------------------------------------------------
-                                Driver Interface
-   -------------------------------------------------------------------------- */
+ *				Driver Interface
+ * --------------------------------------------------------------------------
+ */
 int acpi_lid_open(void)
 {
 	if (!lid_device)
-- 
2.8.1

