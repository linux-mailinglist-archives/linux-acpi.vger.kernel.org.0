Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF635BB7A3
	for <lists+linux-acpi@lfdr.de>; Sat, 17 Sep 2022 12:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiIQKB0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 17 Sep 2022 06:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiIQKBY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 17 Sep 2022 06:01:24 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51975356DF
        for <linux-acpi@vger.kernel.org>; Sat, 17 Sep 2022 03:01:22 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MV5xv1J6yzHnVp;
        Sat, 17 Sep 2022 17:59:15 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 17 Sep 2022 18:01:20 +0800
Received: from linux-ibm.site (10.175.102.37) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 17 Sep 2022 18:01:20 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH] ACPI: AC: Remove the leftover struct acpi_ac_bl
Date:   Sat, 17 Sep 2022 17:45:09 +0800
Message-ID: <1663407909-17686-1-git-send-email-guohanjun@huawei.com>
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

In commit 57a183222271 ("ACPI / x86: Introduce an
acpi_quirk_skip_acpi_ac_and_battery() helper"), the usage of struct
acpi_ac_bl was removed, but left the definition of the struct in
the file, so remove the useless code.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/ac.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index c29e41b..bb9fe79 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -36,11 +36,6 @@
 static int acpi_ac_remove(struct acpi_device *device);
 static void acpi_ac_notify(struct acpi_device *device, u32 event);
 
-struct acpi_ac_bl {
-	const char *hid;
-	int hrv;
-};
-
 static const struct acpi_device_id ac_device_ids[] = {
 	{"ACPI0003", 0},
 	{"", 0},
-- 
1.7.12.4

