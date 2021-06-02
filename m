Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88AC839858B
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jun 2021 11:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbhFBJt0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 05:49:26 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2960 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbhFBJtI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2021 05:49:08 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fw3yf3fhsz68MS;
        Wed,  2 Jun 2021 17:44:26 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:47:24 +0800
Received: from linux-ibm.site (10.175.102.37) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:47:24 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 2/2] ACPI: bus: Call kobject_put() in error path for acpi_init()
Date:   Wed, 2 Jun 2021 17:36:50 +0800
Message-ID: <1622626610-58140-2-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1622626610-58140-1-git-send-email-guohanjun@huawei.com>
References: <1622626610-58140-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Although the system will not in good condition or boot failed
if acpi_bus_init() failed, we still need to put the kobject
in error patch before return, to make the code right.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index f9b5262..008ae29 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1330,6 +1330,7 @@ static int __init acpi_init(void)
 
 	result = acpi_bus_init();
 	if (result) {
+		kobject_put(acpi_kobj);
 		disable_acpi();
 		return result;
 	}
-- 
1.7.12.4

