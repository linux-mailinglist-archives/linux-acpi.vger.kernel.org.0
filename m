Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3468E227C80
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jul 2020 12:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgGUKGO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Jul 2020 06:06:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45800 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729046AbgGUKGM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 21 Jul 2020 06:06:12 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 517DE65D4029162FB7BF;
        Tue, 21 Jul 2020 18:06:10 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Tue, 21 Jul 2020 18:06:00 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     <linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 3/3] ACPI: NUMA: Remove the useless 'node >= MAX_NUMNODES' check
Date:   Tue, 21 Jul 2020 17:59:06 +0800
Message-ID: <1595325546-63774-4-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1595325546-63774-1-git-send-email-guohanjun@huawei.com>
References: <1595325546-63774-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

acpi_map_pxm_to_node() will never return numa node greater
than MAX_NUMNODES, so 'node >= MAX_NUMNODES' is not needed,
remove it.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/numa/srat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 3d430b0..15bbaab 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -230,7 +230,7 @@ void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
 		pxm &= 0xff;
 
 	node = acpi_map_pxm_to_node(pxm);
-	if (node == NUMA_NO_NODE || node >= MAX_NUMNODES) {
+	if (node == NUMA_NO_NODE) {
 		pr_err("SRAT: Too many proximity domains.\n");
 		goto out_err_bad_srat;
 	}
-- 
1.7.12.4

