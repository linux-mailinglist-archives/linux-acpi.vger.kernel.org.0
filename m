Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029DF397DE6
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jun 2021 03:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhFBBKF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Jun 2021 21:10:05 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2938 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhFBBKF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Jun 2021 21:10:05 -0400
Received: from dggeme764-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FvrRl5vgBz65SL;
        Wed,  2 Jun 2021 09:05:23 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggeme764-chm.china.huawei.com (10.3.19.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 2 Jun 2021 09:08:21 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <rui.zhang@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH] ACPI: tables: fixes the missed acpi_put_table() in acpi_init_fpdt()
Date:   Wed, 2 Jun 2021 09:17:23 +0800
Message-ID: <20210602011723.23666-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme764-chm.china.huawei.com (10.3.19.110)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

acpi_init_fpdt() misses to call acpi_put_table() in an error path. Add
the missed function call to fix it.

Fixes: d1eb86e59be0 ("ACPI: tables: introduce support for FPDT table")
Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/acpi/acpi_fpdt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
index a89a806a7a2a..4ee2ad234e3d 100644
--- a/drivers/acpi/acpi_fpdt.c
+++ b/drivers/acpi/acpi_fpdt.c
@@ -240,8 +240,10 @@ static int __init acpi_init_fpdt(void)
 		return 0;
 
 	fpdt_kobj = kobject_create_and_add("fpdt", acpi_kobj);
-	if (!fpdt_kobj)
+	if (!fpdt_kobj) {
+		acpi_put_table(header);
 		return -ENOMEM;
+	}
 
 	while (offset < header->length) {
 		subtable = (void *)header + offset;
-- 
2.26.0.106.g9fadedd

