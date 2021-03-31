Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612AC34B533
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Mar 2021 08:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhC0Htp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 27 Mar 2021 03:49:45 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14922 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhC0HtU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 27 Mar 2021 03:49:20 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F6rXg3fj1zkgkX;
        Sat, 27 Mar 2021 15:47:31 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 15:49:04 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <rui.zhang@intel.com>,
        <bhelgaas@google.com>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH v2 06/15] ACPI: LPSS: fix some coding style issues
Date:   Sat, 27 Mar 2021 15:46:24 +0800
Message-ID: <1616831193-17920-7-git-send-email-tanxiaofei@huawei.com>
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

WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: Missing a blank line after declarations

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/acpi/acpi_lpss.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index be73974..2df231e 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -187,7 +187,7 @@ static void byt_i2c_setup(struct lpss_private_data *pdata)
 
 	/* Expected to always be true, but better safe then sorry */
 	if (uid_str)
-		uid = simple_strtol(uid_str, NULL, 10);
+		uid = kstrtol(uid_str, NULL, 10);
 
 	/* Detect I2C bus shared with PUNIT and ignore its d3 status */
 	status = acpi_evaluate_integer(handle, "_SEM", NULL, &shared_host);
@@ -377,6 +377,7 @@ static const struct acpi_device_id acpi_lpss_device_ids[] = {
 static int is_memory(struct acpi_resource *res, void *not_used)
 {
 	struct resource r;
+
 	return !acpi_dev_resource_memory(res, &r);
 }
 
@@ -1200,6 +1201,7 @@ static int acpi_lpss_poweroff_noirq(struct device *dev)
 	if (pdata->dev_desc->resume_from_noirq) {
 		/* This is analogous to the acpi_lpss_suspend_noirq() case. */
 		int ret = acpi_lpss_do_poweroff_late(dev);
+
 		if (ret)
 			return ret;
 	}
-- 
2.8.1

