Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D2F1FAC33
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jun 2020 11:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgFPJUd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Jun 2020 05:20:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55440 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726052AbgFPJUa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 16 Jun 2020 05:20:30 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0DB4DAF247A6438F2798;
        Tue, 16 Jun 2020 17:20:28 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 16 Jun 2020 17:20:17 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <guohanjun@huawei.com>, <wangxiongfeng2@huawei.com>
Subject: [PATCH 2/2] ACPI: sysfs: add missing newlines when printing module parameters
Date:   Tue, 16 Jun 2020 17:14:09 +0800
Message-ID: <1592298849-41530-3-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1592298849-41530-1-git-send-email-wangxiongfeng2@huawei.com>
References: <1592298849-41530-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add newlines for several module parameters printed by sysfs.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/acpi/sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 3a89909..6ad142d 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -214,7 +214,7 @@ static int param_set_trace_method_name(const char *val,
 
 static int param_get_trace_method_name(char *buffer, const struct kernel_param *kp)
 {
-	return scnprintf(buffer, PAGE_SIZE, "%s", acpi_gbl_trace_method_name);
+	return scnprintf(buffer, PAGE_SIZE, "%s\n", acpi_gbl_trace_method_name);
 }
 
 static const struct kernel_param_ops param_ops_trace_method = {
@@ -271,15 +271,15 @@ static int param_set_trace_state(const char *val,
 static int param_get_trace_state(char *buffer, const struct kernel_param *kp)
 {
 	if (!(acpi_gbl_trace_flags & ACPI_TRACE_ENABLED))
-		return sprintf(buffer, "disable");
+		return sprintf(buffer, "disable\n");
 	else {
 		if (acpi_gbl_trace_method_name) {
 			if (acpi_gbl_trace_flags & ACPI_TRACE_ONESHOT)
-				return sprintf(buffer, "method-once");
+				return sprintf(buffer, "method-once\n");
 			else
-				return sprintf(buffer, "method");
+				return sprintf(buffer, "method\n");
 		} else
-			return sprintf(buffer, "enable");
+			return sprintf(buffer, "enable\n");
 	}
 	return 0;
 }
@@ -302,7 +302,7 @@ static int param_get_acpica_version(char *buffer,
 {
 	int result;
 
-	result = sprintf(buffer, "%x", ACPI_CA_VERSION);
+	result = sprintf(buffer, "%x\n", ACPI_CA_VERSION);
 
 	return result;
 }
-- 
1.7.12.4

