Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC537755F7
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 10:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjHII5H (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Aug 2023 04:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjHII5G (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2023 04:57:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD2A1FD4
        for <linux-acpi@vger.kernel.org>; Wed,  9 Aug 2023 01:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691571337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s3VBFXxI2pbsP1ZmcIb5tJNksNxfiIu3X88w43HuLHw=;
        b=bB0DqbLbpUwkzhLAb11OxIkm9ei+IlUE+pe5/dXO0tjfZL4QsIqFCt5JsCy42eT2jb5yOX
        kw7dXTupY5jKY7OIY0/xxNeWtrqy5FfkRP0GP4Ek+KoZ82C2rS2iHgCq4IfCyF848VEeXk
        d5cSYWE9PTNXY53fHAJj3HUmXulT4KE=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-UJb9c5GZOCeulE0Mbv0kpg-1; Wed, 09 Aug 2023 04:55:32 -0400
X-MC-Unique: UJb9c5GZOCeulE0Mbv0kpg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACBDE3C1015A;
        Wed,  9 Aug 2023 08:55:31 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.194.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 962081121314;
        Wed,  9 Aug 2023 08:55:30 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        August Wikerfors <git@augustwikerfors.se>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
Subject: [PATCH v3 3/3] ACPI: resource: Honor MADT INT_SRC_OVR settings for IRQ1 on AMD Zen
Date:   Wed,  9 Aug 2023 10:55:25 +0200
Message-ID: <20230809085526.84913-4-hdegoede@redhat.com>
In-Reply-To: <20230809085526.84913-1-hdegoede@redhat.com>
References: <20230809085526.84913-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Changes in v3:
- Make acpi_int_src_ovr an array which keep track of the status
  of all legacy IRQs and not just IRQ 1
---
 arch/x86/include/asm/acpi.h | 2 ++
 arch/x86/kernel/acpi/boot.c | 4 ++++
 drivers/acpi/resource.c     | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 8eb74cf386db..6bc00fddf8dd 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -15,6 +15,7 @@
 #include <asm/mpspec.h>
 #include <asm/x86_init.h>
 #include <asm/cpufeature.h>
+#include <asm/irq_vectors.h>
 
 #ifdef CONFIG_ACPI_APEI
 # include <asm/pgtable_types.h>
@@ -31,6 +32,7 @@ extern int acpi_skip_timer_override;
 extern int acpi_use_timer_override;
 extern int acpi_fix_pin2_polarity;
 extern int acpi_disable_cmcff;
+extern int acpi_int_src_ovr[NR_IRQS_LEGACY];
 
 extern u8 acpi_sci_flags;
 extern u32 acpi_sci_override_gsi;
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 21b542a6866c..b88e5e0135ab 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -52,6 +52,7 @@ int acpi_lapic;
 int acpi_ioapic;
 int acpi_strict;
 int acpi_disable_cmcff;
+int acpi_int_src_ovr[NR_IRQS_LEGACY];
 
 /* ACPI SCI override configuration */
 u8 acpi_sci_flags __initdata;
@@ -588,6 +589,9 @@ acpi_parse_int_src_ovr(union acpi_subtable_headers * header,
 
 	acpi_table_print_madt_entry(&header->common);
 
+	if (intsrc->source_irq < NR_IRQS_LEGACY)
+		acpi_int_src_ovr[intsrc->source_irq] = 1;
+
 	if (intsrc->source_irq == acpi_gbl_FADT.sci_interrupt) {
 		acpi_sci_ioapic_setup(intsrc->source_irq,
 				      intsrc->inti_flags & ACPI_MADT_POLARITY_MASK,
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 380cda1e86f4..a0bb53868e18 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -551,6 +551,10 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
 	if (gsi != 1 && gsi != 12)
 		return true;
 
+	/* If the override comes from an INT_SRC_OVR MADT entry honor it */
+	if (acpi_int_src_ovr[gsi])
+		return true;
+
 	/*
 	 * IRQ override isn't needed on modern AMD Zen systems and
 	 * this override breaks active low IRQs on AMD Ryzen 6000 and
-- 
2.41.0

