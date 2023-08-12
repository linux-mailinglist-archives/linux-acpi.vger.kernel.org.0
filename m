Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE737779DD5
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Aug 2023 09:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjHLHPB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 12 Aug 2023 03:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjHLHPA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Aug 2023 03:15:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A6B30D2;
        Sat, 12 Aug 2023 00:14:58 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RNBh86g8bzTmN8;
        Sat, 12 Aug 2023 15:12:56 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 12 Aug
 2023 15:14:55 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <linux-gpio@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] gpiolib: acpi: Use LIST_HEAD() to initialize the list_head
Date:   Sat, 12 Aug 2023 15:14:23 +0800
Message-ID: <20230812071423.3481790-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Use LIST_HEAD() to initialize the list_head instead of open-coding it.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/gpio/gpiolib-acpi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index fbda452fb4d6..db8e8e967bda 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -809,11 +809,9 @@ static int acpi_gpio_resource_lookup(struct acpi_gpio_lookup *lookup,
 				     struct acpi_gpio_info *info)
 {
 	struct acpi_device *adev = lookup->info.adev;
-	struct list_head res_list;
+	LIST_HEAD(res_list);
 	int ret;
 
-	INIT_LIST_HEAD(&res_list);
-
 	ret = acpi_dev_get_resources(adev, &res_list,
 				     acpi_populate_gpio_lookup,
 				     lookup);
@@ -1472,13 +1470,12 @@ int acpi_gpio_count(struct device *dev, const char *con_id)
 
 	/* Then from plain _CRS GPIOs */
 	if (count < 0) {
-		struct list_head resource_list;
+		LIST_HEAD(resource_list);
 		unsigned int crs_count = 0;
 
 		if (!acpi_can_fallback_to_crs(adev, con_id))
 			return count;
 
-		INIT_LIST_HEAD(&resource_list);
 		acpi_dev_get_resources(adev, &resource_list,
 				       acpi_find_gpio_count, &crs_count);
 		acpi_dev_free_resource_list(&resource_list);
-- 
2.34.1

