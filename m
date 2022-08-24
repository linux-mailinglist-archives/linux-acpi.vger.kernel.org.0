Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEA359FAE6
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Aug 2022 15:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237983AbiHXNJV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Aug 2022 09:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237977AbiHXNJU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Aug 2022 09:09:20 -0400
X-Greylist: delayed 447 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 24 Aug 2022 06:09:17 PDT
Received: from forward300o.mail.yandex.net (forward300o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A8697537
        for <linux-acpi@vger.kernel.org>; Wed, 24 Aug 2022 06:09:17 -0700 (PDT)
Received: from iva5-7aaec7404f99.qloud-c.yandex.net (iva5-7aaec7404f99.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:74a5:0:640:7aae:c740])
        by forward300o.mail.yandex.net (Yandex) with ESMTP id B8A96D0C10B;
        Wed, 24 Aug 2022 16:01:17 +0300 (MSK)
Received: from kernel1.search.yandex.net (kernel1.search.yandex.net [2a02:6b8:c02:550:0:604:9094:6282])
        by iva5-7aaec7404f99.qloud-c.yandex.net (yaback/Yandex) with ESMTP id XWJnCd0PPj-1Guq6PSM;
        Wed, 24 Aug 2022 16:01:16 +0300
X-Yandex-Fwd: 1
Authentication-Results: iva5-7aaec7404f99.qloud-c.yandex.net; dkim=pass
Received: by kernel1.search.yandex.net (Postfix, from userid 55271)
        id 6BE17580F9C; Wed, 24 Aug 2022 16:01:16 +0300 (MSK)
From:   Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
To:     linux-acpi@vger.kernel.org
Cc:     tony.luck@intel.com, rafael@kernel.org,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: [PATCH] ACPI: APEI: Add BERT error log footer
Date:   Wed, 24 Aug 2022 16:01:13 +0300
Message-Id: <1661346073-730819-1-git-send-email-dmtrmonakhov@yandex-team.ru>
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

Print total number of records found during BERT log parsing.
This also simplify dmesg parser implementation for BERT events.

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

