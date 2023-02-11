Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B26A693398
	for <lists+linux-acpi@lfdr.de>; Sat, 11 Feb 2023 21:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjBKUOr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 11 Feb 2023 15:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjBKUOq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Feb 2023 15:14:46 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A4E18B22
        for <linux-acpi@vger.kernel.org>; Sat, 11 Feb 2023 12:14:45 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id 5so9747948qtp.9
        for <linux-acpi@vger.kernel.org>; Sat, 11 Feb 2023 12:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fmwjK45aJ0Krq9ccPbdSF/ZA+/tswByzhwCweBSTPkY=;
        b=UnzAE8GYconI4+/VwLmom5CSX4APdY/ZMPl0fsGCyM0wiVS1jsC9RCvv4dKbk/Y6Qu
         Q2Ejt0TcVo1KXIxz5FdUduutnY6m/SXG8sDsj5lCcz6agmazoLwmcX/IuohRP2tEM3uY
         zrOzDTdeqJQZDKNt/hB7C2VRbcMbppXmbNDx1gjMxtBGBl1VBIpJ574ecQTgQIgc4NSI
         iVx/WXKmSXb5YMqTpTBOzKeP2NUXhqFXk1ksbF7u/7A97Ic4vOEt6vynkW6CsM9gMxUL
         EQgtMnIhp2NoJsurzTNTg+/6XiwFrFk2jAXr3rD26ilntZxK4O+6GCJM0AyFIBNl7yzC
         aNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fmwjK45aJ0Krq9ccPbdSF/ZA+/tswByzhwCweBSTPkY=;
        b=Ek549kimw5PAW1Ihwi8h6UtKuYu4U2DmBUAK0dhVvw8nDfq37oQ8j1Gw8SGlv9L2vH
         +ldArbmM7hic1dxzj4xfvnYjgPV1/E5VDVh9YzPl0Mm0krNwoYWtm1hmd3p1jZUbZFvY
         vpd7VYPOkxot2W9JYqtdU7v33EZqTXh+XtllJ4GX4Ya75MQbSyYR+Err3lknU7Nxhdx/
         tiAiy1twoiYLKDfYB+BgF83dAiMrAoQpzzU+ULKw136VSsgObWaxBSL+3H3EHEHVPyub
         4BcNtED5a0xNh3QFdZND+CjjsF4TRw5LsmzgfvqZ7HCsNYmMVhN5EGin092WuBB7GMjV
         rTiw==
X-Gm-Message-State: AO0yUKXnpvZSLK7Qa4g/yHP7AugKJ28tDv7GNrCBBjItZHjwlTt6uj9B
        j5Uo394Rv3dnhYwg6ojyLws1RW6B5ShoGop5
X-Google-Smtp-Source: AK7set8Gjus08qisohZPkcNypJlNlvCHI7yr6RTpeREoGd38DBVQnqksa5yqwrhFiKB1Ly7v4jE7Ww==
X-Received: by 2002:ac8:5a87:0:b0:3ab:a3d9:c5c8 with SMTP id c7-20020ac85a87000000b003aba3d9c5c8mr36004991qtc.3.1676146484884;
        Sat, 11 Feb 2023 12:14:44 -0800 (PST)
Received: from pc.fios-router.home (pool-72-94-185-71.phlapa.fios.verizon.net. [72.94.185.71])
        by smtp.gmail.com with ESMTPSA id j13-20020ac8404d000000b003b6953fbb8fsm5955157qtl.32.2023.02.11.12.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 12:14:44 -0800 (PST)
From:   Adam Niederer <adam.niederer@gmail.com>
To:     linux-acpi@vger.kernel.org
Cc:     adam.niederer@gmail.com, lenb@kernel.org, rafael@kernel.org
Subject: [PATCH] Add IRQ overrides for MAINGEAR Vector Pro 2 models
Date:   Sat, 11 Feb 2023 15:13:33 -0500
Message-Id: <20230211201333.369286-1-adam.niederer@gmail.com>
X-Mailer: git-send-email 2.39.1
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

Fix a regression introduced by commit 9946e39fe8d0 ("ACPI: resource: skip
IRQ override on AMD Zen platforms") on MAINGEAR Vector Pro 2 systems, which
causes the built-in keyboard to not work. This restores the functionality
by adding an IRQ override.

No other IRQs were being overridden before, so this should be all that is
needed for these systems. I have personally tested this on the 15" model
(MG-VCP2-15A3070T), and I have confirmation that the issue is present on
the 17" model (MG-VCP2-17A3070T).

Signed-off-by: Adam Niederer <adam.niederer@gmail.com>

---
 drivers/acpi/resource.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 192d1784e409..1d9d3364bc2b 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -478,6 +478,24 @@ static const struct dmi_system_id schenker_gm_rg[] = {
 	{ }
 };
 
+static const struct dmi_system_id maingear_laptop[] = {
+	{
+		.ident = "MAINGEAR Vector Pro 2 15",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Micro Electronics Inc"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-15A3070T"),
+		}
+	},
+	{
+		.ident = "MAINGEAR Vector Pro 2 17",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Micro Electronics Inc"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-17A3070T"),
+		},
+	},
+	{ }
+};
+
 struct irq_override_cmp {
 	const struct dmi_system_id *system;
 	unsigned char irq;
@@ -493,7 +511,7 @@ static const struct irq_override_cmp override_table[] = {
 	{ lenovo_laptop, 6, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
 	{ lenovo_laptop, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
 	{ schenker_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
+	{ maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
 };
 
 static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
--
2.39.1

