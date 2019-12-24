Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0FA8129C85
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2019 03:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfLXCB0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Dec 2019 21:01:26 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:44788 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727005AbfLXCB0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 23 Dec 2019 21:01:26 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6F5292A369FDE405820F;
        Tue, 24 Dec 2019 10:01:24 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Tue, 24 Dec 2019 10:01:16 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 1/2] cpufreq : cppc: Break out if we match the HiSilicon cppc workaround
Date:   Tue, 24 Dec 2019 09:56:29 +0800
Message-ID: <1577152590-25574-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Bail out if we match the OEM information, to save some possible
extra iteration. And update the code to fix minor coding style issue.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 8d8da76..d0ca300 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -39,7 +39,7 @@
 static struct cppc_cpudata **all_cpu_data;
 
 struct cppc_workaround_oem_info {
-	char oem_id[ACPI_OEM_ID_SIZE +1];
+	char oem_id[ACPI_OEM_ID_SIZE + 1];
 	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
 	u32 oem_revision;
 };
@@ -93,8 +93,10 @@ static void cppc_check_hisi_workaround(void)
 	for (i = 0; i < ARRAY_SIZE(wa_info); i++) {
 		if (!memcmp(wa_info[i].oem_id, tbl->oem_id, ACPI_OEM_ID_SIZE) &&
 		    !memcmp(wa_info[i].oem_table_id, tbl->oem_table_id, ACPI_OEM_TABLE_ID_SIZE) &&
-		    wa_info[i].oem_revision == tbl->oem_revision)
+		    wa_info[i].oem_revision == tbl->oem_revision) {
 			apply_hisi_workaround = true;
+			break;
+		}
 	}
 }
 
-- 
1.7.12.4

