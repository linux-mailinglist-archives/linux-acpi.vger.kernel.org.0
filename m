Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11306A71D7
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Mar 2023 18:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCARJp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Mar 2023 12:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjCARJp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Mar 2023 12:09:45 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FAB2A172
        for <linux-acpi@vger.kernel.org>; Wed,  1 Mar 2023 09:09:44 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PRgdf4T1tz6J9SV;
        Thu,  2 Mar 2023 01:07:18 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 17:09:41 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-acpi@vger.kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linuxarm@huawei.com>
Subject: [PATCH] acpi/arm64: Drop extra (struct resource)
Date:   Wed, 1 Mar 2023 17:09:38 +0000
Message-ID: <20230301170938.9278-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DEFINE_RES_IRQ() is a wrapper around the DEFINE_RES_NAMED()
macro which already has the (struct resource) for the compound
literal.

Fixes warnings:
  CC      drivers/acpi/arm64/gtdt.o
  CHECK   drivers/acpi/arm64/gtdt.c
drivers/acpi/arm64/gtdt.c:355:19: warning: cast to non-scalar
drivers/acpi/arm64/gtdt.c:355:19: warning: cast from non-scalar

Fixes: 52c4d11f1dce ("resource: Convert DEFINE_RES_NAMED() to be compound literal")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/acpi/arm64/gtdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index c0e77c1c8e09..24bd479de91f 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -352,7 +352,7 @@ static int __init gtdt_import_sbsa_gwdt(struct acpi_gtdt_watchdog *wd,
 	}
 
 	irq = map_gt_gsi(wd->timer_interrupt, wd->timer_flags);
-	res[2] = (struct resource)DEFINE_RES_IRQ(irq);
+	res[2] = DEFINE_RES_IRQ(irq);
 	if (irq <= 0) {
 		pr_warn("failed to map the Watchdog interrupt.\n");
 		nr_res--;
-- 
2.37.2

