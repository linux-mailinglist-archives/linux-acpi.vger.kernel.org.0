Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0FD396D8E
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jun 2021 08:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhFAGwW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Jun 2021 02:52:22 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3486 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhFAGwV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Jun 2021 02:52:21 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FvN5R5Lz4zYrx3;
        Tue,  1 Jun 2021 14:47:55 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 14:50:39 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 14:50:38 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] ACPI: OSL: Use DEFINE_RES_IO_NAMED() to simplify code
Date:   Tue, 1 Jun 2021 14:50:32 +0800
Message-ID: <20210601065032.10042-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

No functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/acpi/osl.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 327e1b4eb6b096f..f40d34776a3528c 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1487,12 +1487,7 @@ EXPORT_SYMBOL(acpi_check_resource_conflict);
 int acpi_check_region(resource_size_t start, resource_size_t n,
 		      const char *name)
 {
-	struct resource res = {
-		.start = start,
-		.end   = start + n - 1,
-		.name  = name,
-		.flags = IORESOURCE_IO,
-	};
+	struct resource res = DEFINE_RES_IO_NAMED(start, n, name);
 
 	return acpi_check_resource_conflict(&res);
 }
-- 
2.26.0.106.g9fadedd


