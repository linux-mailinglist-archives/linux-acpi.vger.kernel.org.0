Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76A3773B88
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Aug 2023 17:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjHHPwJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Aug 2023 11:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjHHPun (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Aug 2023 11:50:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1844C4C11
        for <linux-acpi@vger.kernel.org>; Tue,  8 Aug 2023 08:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691509281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xeJkZiO3OJE7hMvROujUxKI2mbpdsUguGw9W7kaWg1M=;
        b=c5rJPVnRRz8xKrI1DFVYd6FAVpdQZrs1/DCvQGhYY64TSHrjEMZCcPH2vdioCsj0Kv8Fv6
        wx98ITjGFXoTqdlLhxFWqdybIeizVKLp98dnKL5fmHxaCqImDY3/h9jGSqV1P7DpVIHnz3
        AlRTAG92EBCHTj42MWFt9Rs/LkrcWOE=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-RD3dkByZOKu5mi6EWAow4Q-1; Tue, 08 Aug 2023 06:33:49 -0400
X-MC-Unique: RD3dkByZOKu5mi6EWAow4Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD8EE3C11C64;
        Tue,  8 Aug 2023 10:33:48 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.194.191])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3C0140C2076;
        Tue,  8 Aug 2023 10:33:47 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
Subject: [PATCH v2 3/3] ACPI: resource: Honor MADT INT_SRC_OVR settings for IRQ1 on AMD Zen
Date:   Tue,  8 Aug 2023 12:33:35 +0200
Message-ID: <20230808103335.95339-4-hdegoede@redhat.com>
In-Reply-To: <20230808103335.95339-1-hdegoede@redhat.com>
References: <20230808103335.95339-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On AMD Zen acpi_dev_irq_override() by default prefers the DSDT IRQ 1
settings over the MADT settings.

This causes the keyboard to malfunction on some laptop models
(see Links), all models from the Links have an INT_SRC_OVR MADT entry
for IRQ 1.

Fixes: a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217336
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217394
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217406
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/x86/include/asm/acpi.h | 1 +
 arch/x86/kernel/acpi/boot.c | 4 ++++
 drivers/acpi/resource.c     | 4 ++++
 3 files changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 8eb74cf386db..2173b7c19adf 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -31,6 +31,7 @@ extern int acpi_skip_timer_override;
 extern int acpi_use_timer_override;
 extern int acpi_fix_pin2_polarity;
 extern int acpi_disable_cmcff;
+extern int acpi_irq1_int_src_ovr;
 
 extern u8 acpi_sci_flags;
 extern u32 acpi_sci_override_gsi;
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 21b542a6866c..f69ffb9a35c1 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -52,6 +52,7 @@ int acpi_lapic;
 int acpi_ioapic;
 int acpi_strict;
 int acpi_disable_cmcff;
+int acpi_irq1_int_src_ovr;
 
 /* ACPI SCI override configuration */
 u8 acpi_sci_flags __initdata;
@@ -588,6 +589,9 @@ acpi_parse_int_src_ovr(union acpi_subtable_headers * header,
 
 	acpi_table_print_madt_entry(&header->common);
 
+	if (intsrc->source_irq == 1)
+		acpi_irq1_int_src_ovr = 1;
+
 	if (intsrc->source_irq == acpi_gbl_FADT.sci_interrupt) {
 		acpi_sci_ioapic_setup(intsrc->source_irq,
 				      intsrc->inti_flags & ACPI_MADT_POLARITY_MASK,
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 840b938a5fb0..8b0c641db1e8 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -551,6 +551,10 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
 		return true;
 
 #ifdef CONFIG_X86
+	/* If the override comes from an INT_SRC_OVR MADT entry honor it */
+	if (acpi_irq1_int_src_ovr)
+		return true;
+
 	/*
 	 * IRQ override isn't needed on modern AMD Zen systems and
 	 * this override breaks active low IRQs on AMD Ryzen 6000 and
-- 
2.41.0

