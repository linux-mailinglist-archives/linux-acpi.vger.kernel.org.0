Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A001716552
	for <lists+linux-acpi@lfdr.de>; Tue, 30 May 2023 16:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjE3O5G (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 May 2023 10:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbjE3O5F (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 May 2023 10:57:05 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59931FE;
        Tue, 30 May 2023 07:57:03 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QVwRL2JDhz6DB95;
        Tue, 30 May 2023 22:54:54 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 15:57:00 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-i2c@vger.kernel.org>
CC:     Wolfram Sang <wsa@kernel.org>, Niyas Sait <niyas.sait@linaro.org>,
        Klaus Jensen <its@irrelevant.dk>,
        Andy Shevchenko <andy@kernel.org>,
        <linux-acpi@vger.kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Matt Johnston <matt@codeconstruct.com.au>,
        Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        "Viacheslav A . Dubeyko" <viacheslav.dubeyko@bytedance.com>
Subject: [RFC PATCH v2 2/6] i2c: aspeed: Use platform_get_irq() instead of opencoding
Date:   Tue, 30 May 2023 15:55:57 +0100
Message-ID: <20230530145601.2592-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230530145601.2592-1-Jonathan.Cameron@huawei.com>
References: <20230530145601.2592-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

A cleanup in it's own right.
This has the handy side effect of working for ACPI FW as well
(unlike fwnode_irq_get() which works for ARM64 but not x86 ACPI)

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v2: Andy Schevchenko review.
Added check on whether we have an IRQ from platform_get_irq()
---
 drivers/i2c/busses/i2c-aspeed.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index d3c99c5b3247..21a2f139f445 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -19,7 +19,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
-#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
@@ -1043,7 +1042,10 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
 	ret = devm_request_irq(&pdev->dev, irq, aspeed_i2c_bus_irq,
 			       0, dev_name(&pdev->dev), bus);
 	if (ret < 0)
-- 
2.39.2

