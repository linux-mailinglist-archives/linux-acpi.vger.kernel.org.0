Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5626337FC
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Nov 2022 10:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbiKVJI5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Nov 2022 04:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbiKVJIk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Nov 2022 04:08:40 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6848831FBE
        for <linux-acpi@vger.kernel.org>; Tue, 22 Nov 2022 01:08:39 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NGdcW3VtTzqSWN;
        Tue, 22 Nov 2022 17:04:43 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 17:08:37 +0800
Received: from linux-ibm.site (10.175.102.37) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 17:08:37 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH] ACPI: fan: Bail out if extract package failed
Date:   Tue, 22 Nov 2022 16:53:28 +0800
Message-ID: <1669107208-16226-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Bail out if we extract the _FIF package failed, or we will end
of referencing the garbage information in fields[], the fan control
will be in mess, fix it.

Fiexes: d445571fa369 ("ACPI: fan: Optimize struct acpi_fan_fif")
Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/fan_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 52a0b30..9dccbae 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -236,6 +236,7 @@ static int acpi_fan_get_fif(struct acpi_device *device)
 	if (ACPI_FAILURE(status)) {
 		dev_err(&device->dev, "Invalid _FIF element\n");
 		status = -EINVAL;
+		goto err;
 	}
 
 	fan->fif.revision = fields[0];
-- 
1.7.12.4

