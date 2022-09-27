Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D259A5EC4BF
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Sep 2022 15:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiI0NmE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Sep 2022 09:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiI0NmB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Sep 2022 09:42:01 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9C2E1187
        for <linux-acpi@vger.kernel.org>; Tue, 27 Sep 2022 06:42:00 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4McLKM5fB6zlW43;
        Tue, 27 Sep 2022 21:37:43 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 27 Sep
 2022 21:41:58 +0800
From:   Yuan Can <yuancan@huawei.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>
CC:     <yuancan@huawei.com>
Subject: [PATCH] ACPI: AC: Remove unused struct acpi_ac_bl
Date:   Tue, 27 Sep 2022 13:39:21 +0000
Message-ID: <20220927133921.103852-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

After commit 57a183222271("ACPI / x86: Introduce an
acpi_quirk_skip_acpi_ac_and_battery() helper"), no one use struct acpi_ac_bl,
so remove it.

Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/acpi/ac.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index c29e41bfcf35..bb9fe7984b1a 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -36,11 +36,6 @@ static int acpi_ac_add(struct acpi_device *device);
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
2.17.1

