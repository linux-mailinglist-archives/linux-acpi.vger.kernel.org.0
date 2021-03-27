Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9086034B720
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Mar 2021 13:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhC0MLY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 27 Mar 2021 08:11:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15021 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhC0MLS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 27 Mar 2021 08:11:18 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F6yKt5qGmzPqb9;
        Sat, 27 Mar 2021 20:08:34 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 20:11:01 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <rui.zhang@intel.com>,
        <bhelgaas@google.com>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH v3 09/12] ACPI: custom_method: fix a coding style issue
Date:   Sat, 27 Mar 2021 20:08:21 +0800
Message-ID: <1616846904-25719-10-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616846904-25719-1-git-send-email-tanxiaofei@huawei.com>
References: <1616846904-25719-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fix the following coding style issue reported by checkpatch.pl

ERROR: "foo * bar" should be "foo *bar"
FILE: drivers/acpi/custom_method.c:22:
+static ssize_t cm_write(struct file *file, const char __user * user_buf,

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/acpi/custom_method.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index 7b54dc9..443fdf62 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -19,7 +19,7 @@ static struct dentry *cm_dentry;
 
 /* /sys/kernel/debug/acpi/custom_method */
 
-static ssize_t cm_write(struct file *file, const char __user * user_buf,
+static ssize_t cm_write(struct file *file, const char __user *user_buf,
 			size_t count, loff_t *ppos)
 {
 	static char *buf;
-- 
2.8.1

