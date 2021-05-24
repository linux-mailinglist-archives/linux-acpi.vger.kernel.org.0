Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E1138E281
	for <lists+linux-acpi@lfdr.de>; Mon, 24 May 2021 10:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhEXIrG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 May 2021 04:47:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5673 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbhEXIrF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 May 2021 04:47:05 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FpW1f1bKmz1BR3G;
        Mon, 24 May 2021 16:42:46 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 16:45:35 +0800
Received: from linux-ibm.site (10.175.102.37) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 16:45:34 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH] ACPI: ipmi: Remove address space handler in error path
Date:   Mon, 24 May 2021 16:35:08 +0800
Message-ID: <1621845308-19052-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The acpi_install_address_space_handler() is coupled with
acpi_remove_address_space_handler() in ipmi module init/exit, but failed
to remove the handler in acpi_ipmi_init() if the ipmi_smi_watcher_register()
failed, so adding the removal of the address space handler in error path.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/acpi_ipmi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
index bbd00d9..a5fe292 100644
--- a/drivers/acpi/acpi_ipmi.c
+++ b/drivers/acpi/acpi_ipmi.c
@@ -597,9 +597,14 @@ static int __init acpi_ipmi_init(void)
 		pr_warn("Can't register IPMI opregion space handle\n");
 		return -EINVAL;
 	}
+
 	result = ipmi_smi_watcher_register(&driver_data.bmc_events);
-	if (result)
+	if (result) {
+		acpi_remove_address_space_handler(ACPI_ROOT_OBJECT,
+										  ACPI_ADR_SPACE_IPMI,
+										  &acpi_ipmi_space_handler);
 		pr_err("Can't register IPMI system interface watcher\n");
+	}
 
 	return result;
 }
-- 
1.7.12.4

