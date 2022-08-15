Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54207592CA0
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Aug 2022 12:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbiHOJWO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Aug 2022 05:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241591AbiHOJVd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Aug 2022 05:21:33 -0400
X-Greylist: delayed 383 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 Aug 2022 02:21:30 PDT
Received: from forward302p.mail.yandex.net (forward302p.mail.yandex.net [77.88.29.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512F1B1FF
        for <linux-acpi@vger.kernel.org>; Mon, 15 Aug 2022 02:21:30 -0700 (PDT)
Received: from iva4-4ce3b18c8342.qloud-c.yandex.net (iva4-4ce3b18c8342.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:1529:0:640:4ce3:b18c])
        by forward302p.mail.yandex.net (Yandex) with ESMTP id 83A822E43323;
        Mon, 15 Aug 2022 12:15:05 +0300 (MSK)
Received: from kernel1.search.yandex.net (kernel1.search.yandex.net [2a02:6b8:c02:550:0:604:9094:6282])
        by iva4-4ce3b18c8342.qloud-c.yandex.net (yaback/Yandex) with ESMTP id jwZoOQADkQ-F4tWpQ4I;
        Mon, 15 Aug 2022 12:15:04 +0300
X-Yandex-Fwd: 1
Authentication-Results: iva4-4ce3b18c8342.qloud-c.yandex.net; dkim=pass
Received: by kernel1.search.yandex.net (Postfix, from userid 55271)
        id A1A99546C08; Mon, 15 Aug 2022 12:15:04 +0300 (MSK)
From:   Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
To:     linux-acpi@vger.kernel.org
Cc:     tony.luck@intel.com, Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: [PATCH] ACPI: APEI: Add bert error log footer
Date:   Mon, 15 Aug 2022 12:14:49 +0300
Message-Id: <1660554889-174857-1-git-send-email-dmtrmonakhov@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Print total number of records found during bert log parsing.
This also simplify dmesg parser implementation for bert events.

Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>

diff --git a/drivers/acpi/apei/bert.c b/drivers/acpi/apei/bert.c
index 45973aa6e06d..c23eb75866d0 100644
--- a/drivers/acpi/apei/bert.c
+++ b/drivers/acpi/apei/bert.c
@@ -90,6 +90,9 @@ static void __init bert_print_all(struct acpi_bert_region *region,
 
 	if (skipped)
 		pr_info(HW_ERR "Skipped %d error records\n", skipped);
+
+	if (printed + skipped)
+		pr_info("Total records found: %d\n", printed + skipped);
 }
 
 static int __init setup_bert_disable(char *str)
-- 
2.7.4

