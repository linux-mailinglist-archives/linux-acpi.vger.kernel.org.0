Return-Path: <linux-acpi+bounces-4737-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DD689BD45
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 12:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC3328329A
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 10:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA965A115;
	Mon,  8 Apr 2024 10:32:32 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EC057885;
	Mon,  8 Apr 2024 10:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572352; cv=none; b=DljJ4tsIW/4L6cLl4NH/XdITArOWMU6Be96WtQD55fwvSc31qkWIAyOgCNWYaxzr32hAoeu6wBNIk8cNiw0FnG30EGWAtq0x4HNa8TmPRnKmFfo/L/PB0fOLyE3XpUZAzXOvIQI0zyTxUGxGYNac486fDSlcOP093B5pQnq52Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572352; c=relaxed/simple;
	bh=+hYDOeBeIk1HSQh5+r8LsDK14MmGxozbWb/i83GBvfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NZwRBLnzK6TpMuyS8MSm5k53pJI/B7YXNh3I9rhjOe6RXx8EW24QvXKALkNXP6xTx+wb2l3MJdlq/ME94c85O/h8ke3dISZPZuIf7WQ0KqNyHGhhzrmOD+jsZcR38wQL1hZKEIzeVDk0TUjnotcdbfEqv6LrVGkIWw2R1M6u+KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 685FD2F20275; Mon,  8 Apr 2024 10:32:29 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id A72702F20254;
	Mon,  8 Apr 2024 10:32:09 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	pavel@ucw.cz,
	hdegoede@redhat.com,
	linux-acpi@vger.kernel.org,
	kovalev@altlinux.org
Subject: [PATCH 6.1.y 04/14] ACPI: resource: Honor MADT INT_SRC_OVR settings for IRQ1 on AMD Zen
Date: Mon,  8 Apr 2024 13:31:57 +0300
Message-Id: <20240408103207.197423-5-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20240408103207.197423-1-kovalev@altlinux.org>
References: <20240408103207.197423-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

commit c6a1fd910d1bf8a0e3db7aebb229e3c81bc305c4 upstream.

On AMD Zen acpi_dev_irq_override() by default prefers the DSDT IRQ 1
settings over the MADT settings.

This causes the keyboard to malfunction on some laptop models
(see Links), all models from the Links have an INT_SRC_OVR MADT entry
for IRQ 1.

Fixes: a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217336
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217394
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217406
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 arch/x86/include/asm/acpi.h | 2 ++
 arch/x86/kernel/acpi/boot.c | 4 ++++
 drivers/acpi/resource.c     | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 8eb74cf386dbe5..2888c0ee4df045 100644
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
+extern bool acpi_int_src_ovr[NR_IRQS_LEGACY];
 
 extern u8 acpi_sci_flags;
 extern u32 acpi_sci_override_gsi;
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 2252340b2133e2..b045e20872d107 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -52,6 +52,7 @@ int acpi_lapic;
 int acpi_ioapic;
 int acpi_strict;
 int acpi_disable_cmcff;
+bool acpi_int_src_ovr[NR_IRQS_LEGACY];
 
 /* ACPI SCI override configuration */
 u8 acpi_sci_flags __initdata;
@@ -591,6 +592,9 @@ acpi_parse_int_src_ovr(union acpi_subtable_headers * header,
 
 	acpi_table_print_madt_entry(&header->common);
 
+	if (intsrc->source_irq < NR_IRQS_LEGACY)
+		acpi_int_src_ovr[intsrc->source_irq] = true;
+
 	if (intsrc->source_irq == acpi_gbl_FADT.sci_interrupt) {
 		acpi_sci_ioapic_setup(intsrc->source_irq,
 				      intsrc->inti_flags & ACPI_MADT_POLARITY_MASK,
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 2a3b8bf58b7ac4..8e28e76158894f 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -617,6 +617,10 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
 	if (gsi != 1 && gsi != 12)
 		return true;
 
+	/* If the override comes from an INT_SRC_OVR MADT entry, honor it. */
+	if (acpi_int_src_ovr[gsi])
+		return true;
+
 	/*
 	 * IRQ override isn't needed on modern AMD Zen systems and
 	 * this override breaks active low IRQs on AMD Ryzen 6000 and
-- 
2.33.8


