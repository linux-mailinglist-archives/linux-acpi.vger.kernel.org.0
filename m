Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF64698E37
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Feb 2023 09:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjBPIBW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Feb 2023 03:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjBPIBV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Feb 2023 03:01:21 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD47D40F8
        for <linux-acpi@vger.kernel.org>; Thu, 16 Feb 2023 00:01:20 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id fj20so1646923edb.1
        for <linux-acpi@vger.kernel.org>; Thu, 16 Feb 2023 00:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676534479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m/m6+VBdUaynOjkvVtFK5UD3A4MliI5pNrcINToMFQY=;
        b=hrKoKJFhtL1ptLX4WMeBQeM0dBKEE+W96lVbVr5Rfwv2GPbnKfxO1q17nd5sje70gg
         d7IgH1OoMep7dlWW/d2qUzupXvNafzVYGjqplDjebSQlUyipmh3Fprqe6bu+aWyXBRyP
         F2ndwHgSbqRsHiW8PB4nOWjWbHM7MxH/kpfzPLqTa9gsjV5Tvf0nz41iwPE7mFaQSxSQ
         Hgfr2J/GeKDjMFZ37PgkVqKpl0372d/lZXWqaiSeU9MN0LO69/N6zdzZtI5en5bZJAWC
         xj1F3Ch0XhxjdwduD5iT6N4N1PwSt/518BEGrp4J8k1x4Gq02Qg2GKalFlxWFXU8xgac
         stYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676534479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/m6+VBdUaynOjkvVtFK5UD3A4MliI5pNrcINToMFQY=;
        b=5A9n+wsxM90ryh+F+vwKAZ0IvHHWwEf5M3uhgXMEWyeOzZP6T57CHzRil3+R99cCc5
         TeMVDfps4Wn7Jbl2j1LQ6dJrPyY1/PXaMowLM8xL3xHS440e9owxn1OOqt5Bagv9Wc/4
         c3ngQ0+ZxCKT0Wz3zFyjKn1nzTZGwKGiupe+5Yv5tXYpPBBgS+Dv2xaDoRsreeK2z53B
         fljf+4Re29E7tZdnK3V0dGDSzSAY7rnQZZ07cuGmrbfqWyDdQKvNzzj3ZJwtTyYFfAme
         AjDiDD7yHLdmMMg5+yiDszSwVQV69NOZh5Ze1NwqLRY050/Iahg/P8/KMFEyL77jY13D
         clkg==
X-Gm-Message-State: AO0yUKWRWw5xw/SMgqLhFXkU9Q6WSgvoFomrUGOxlHYoI3ZwP+LfYEk7
        HyICCn24ZW1dVWCnftKuywg=
X-Google-Smtp-Source: AK7set9K7aXeV/wdBWnd+A0CC7MSCQgH33ZcjHZgCsdeAsfzl34mPzUzVzT6nrXe0wp1XrmneZG8Pw==
X-Received: by 2002:a05:6402:2688:b0:49b:67c5:3044 with SMTP id w8-20020a056402268800b0049b67c53044mr5711790edd.4.1676534479257;
        Thu, 16 Feb 2023 00:01:19 -0800 (PST)
Received: from hades.lan (host-81-200-60-238.ip.nej.cz. [81.200.60.238])
        by smtp.gmail.com with ESMTPSA id n25-20020a5099d9000000b004acd3bccb0asm435591edb.10.2023.02.16.00.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 00:01:18 -0800 (PST)
From:   Vojtech Hejsek <hejsekvojtech@gmail.com>
X-Google-Original-From: Vojtech Hejsek <hejsekvojtech@tutanota.com>
To:     rafael@kernel.org
Cc:     linux-acpi@vger.kernel.org,
        Vojtech Hejsek <hejsekvojtech@gmail.com>
Subject: [PATCH] ACPI: resource: Skip IRQ override on Asus Expertbook B2402FBA
Date:   Thu, 16 Feb 2023 09:01:15 +0100
Message-Id: <20230216080115.36485-1-hejsekvojtech@tutanota.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Vojtech Hejsek <hejsekvojtech@gmail.com>

The Asus Expertbook B2502FBA has IRQ 1 described as Active_Low
in its ACPI table. However, the kernel overrides this and sets it to
Edge_High, which prevents the internal keyboard from working properly.

Adding this laptop model to the override_table fixes the issue.

Signed-off-by: Vojtech Hejsek <hejsekvojtech@gmail.com>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 192d1784e..950883799 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -439,6 +439,13 @@ static const struct dmi_system_id asus_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "B2402CBA"),
 		},
 	},
+	{
+		.ident = "Asus ExpertBook B2402FBA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "B2402FBA"),
+		},
+	},
 	{
 		.ident = "Asus ExpertBook B2502",
 		.matches = {
-- 
2.39.2

