Return-Path: <linux-acpi+bounces-20416-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6411AD38D1A
	for <lists+linux-acpi@lfdr.de>; Sat, 17 Jan 2026 08:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16D783003781
	for <lists+linux-acpi@lfdr.de>; Sat, 17 Jan 2026 07:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2F4332914;
	Sat, 17 Jan 2026 07:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b="VkPx0hCy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654973321D4
	for <linux-acpi@vger.kernel.org>; Sat, 17 Jan 2026 07:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768634929; cv=none; b=qGOUUZdS+kuodwzYeaDgDSiAtQU4pJSvv50uxqSEPaIftKfpFHyNq3XwIrbR2ALf+A6sculqbOF401uCj5Xl2taXpPf5EEPbsWDau7+z2f/zWMi2rgZ+T0YYc1qTyNxRz2ckJJco8Iq8MZ8IPJuggGD4Lk1nXlJcTEjEmM2WH78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768634929; c=relaxed/simple;
	bh=0dOjsz9/OTbsiieOE07EM6/GdvbrfPfmq+FYkav8ZqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b0vvC7/fCGgzranXO0pUcLn34EkRpDd0q15jEZmaT0+Kxw2+PJfeS1HTM3JJjezrTaox9Rw7AIr8BZjJyJTdfOUkLDHlOzKPu8cKxXhpZGXDYQ39zWMluK1ME94Zl8b7Yvmgo5ro6MJV7usSLxOMLyPRjW3Vhvz0wAaXceEwZlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info; spf=pass smtp.mailfrom=shenghaoyang.info; dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b=VkPx0hCy; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shenghaoyang.info
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a097cc08d5so5783655ad.0
        for <linux-acpi@vger.kernel.org>; Fri, 16 Jan 2026 23:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenghaoyang.info; s=google; t=1768634926; x=1769239726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h9HAJVA/qJVm3szfavq91Ie6LHNeib+qVQ+QzfxwkO8=;
        b=VkPx0hCyR+Ardk3SmvBKcHd16tEKL5d0DBtd+ralG9v4S4Eks1mkKYOSC/kPRKZxVF
         9mo5klfXK3Bcjm0UYGVnUt9N5TI3aLk8Ws9uThdsay4qWuogFDGQUfjuPTG+V0btOV9B
         RCcjOE8D/cfTAekbk2xnZGD8xp7BHUqQdHNAQYTIqI8PJ8jzoCzE3yNl0gqyFvUQMtGL
         fwRfvZ22lzX+Z1n6e0YovPLvDtc2vvWE553sSzctsX5r20dw7caRj+kXK5yT4SVH8eaQ
         2I20r+cpiwgZ2JoP31a9YcShIUU9lzK839XisxmRA0YtpWARqXQnPZYqVGJB8WSYwvTX
         fIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768634926; x=1769239726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9HAJVA/qJVm3szfavq91Ie6LHNeib+qVQ+QzfxwkO8=;
        b=GqvDr5xY+JEi8uZhAyYPW6tl4xUOsfdYtCnDsGnLhDykBaS6bZ0woPR9/6O9I5wN7C
         W+IsNuyqlFfjSLGv0eiQ8o9UqSs5aAD2bLCXoqf2rVC99aPYtKIQiYRI005u1CS9zQxa
         QKroOHxAR7aCK2gNrTkZv+thGDrFFoLOLbIXCqIs9pDkx8bYTXh3TipwHJm8ZbmXCu0n
         HOWJhvI5s8N32vsMwGaF64V35xS9GsxMqD162Pralam/IzQ0gaPbeDHewfdL85ms9s+X
         znZqW9/F3ntJ7VcGxfWqEN4UIIv/RVIlvb9FdhIv4CTNM2GodkZSVyCJsGh9ExmsxULp
         SPIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCNrO6oeDfTBsD1I5GdKLvljGD7QGQj759WOtb8/3HKSCdKfrNL1RW/w6rz++0OU/07q7Wrt/av71p@vger.kernel.org
X-Gm-Message-State: AOJu0Yws2+6+Mncm+zOFjK0ww1F6uj3e6sgIvmptNZhBPuNMxwAgOZi0
	o/2yDN5ygUw8zCn1RzaqNmQ2YJ9PlYIzO3Xz1EPR8Kfva2AqXvwKjouNOChDvU1OH/E=
X-Gm-Gg: AY/fxX4b/6jJcVKawkcccXaoVQ/hEejt3LFW5TyPrY5jFW1lV3KwcPX9asWgyYlLMR1
	TqqkmbTRqYbgFbb30re1vtqPSbJcVk498Wi50ordXUjRLz39qtaB5OS88kG6dHgZ452LD61gX37
	b//fCPs2K0n0SVLkjHp6Ajid8iA4WLtxlerXnBzx3z9GjDvqb5VkF04TO2bEySqKiIpkQ2HxQ8i
	aGRMQUWA0Pt/s7hyHStKoJLNFQqcEKtjMqwxmuwVkYC+mm2o9AjI8kh4gyqm6Ighcs7PBKEqbxE
	xdasXtJf1UDvFHFnhkYe9m3LSoMtsHP2dbOa/lBxJ3pHkVtb6dvT/iZFVlub0RbJ4taOpgwquOX
	OgXdwP68cHeFfzfdcgXdRQ35LMjrFI1mNTTcaTBuKRj83fQqTuAs90+de3eEoy49CCTzWD88jbu
	ks4skOJS8y
X-Received: by 2002:a17:90b:58e4:b0:340:b8f2:250c with SMTP id 98e67ed59e1d1-35272ec84efmr3763296a91.1.1768634926224;
        Fri, 16 Jan 2026 23:28:46 -0800 (PST)
Received: from localhost ([132.147.84.99])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-c5edf32d68asm3686559a12.18.2026.01.16.23.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 23:28:45 -0800 (PST)
From: Shenghao Yang <me@shenghaoyang.info>
To: x86@kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Shenghao Yang <me@shenghaoyang.info>
Subject: [PATCH v2] x86/acpi: Add acpi=spcr to use SPCR-provided default console
Date: Sat, 17 Jan 2026 15:28:27 +0800
Message-ID: <20260117072827.355360-1-me@shenghaoyang.info>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SPCR provided console on x86 is only available as a boot
console when earlycon is provided on the kernel command line,
and will not be present in /proc/consoles.

While it's possible to retain the boot console with the
keep_bootcon parameter, that leaves the console using the less
efficient 8250_early driver.

Users wanting to use the firmware suggested console (to avoid
maintaining unique serial console parameters for different
server models in large fleets) with the conventional driver
have to parse the kernel log for the console parameters and
reinsert them.

[    0.005091] ACPI: SPCR 0x000000007FFB5000 000059 (v04 ALASKA A M I    01072009 INTL 20250404)
[    0.073387] ACPI: SPCR: console: uart,io,0x3f8,115200

In commit 0231d00082f6 ("ACPI: SPCR: Make SPCR available to x86") [1]
the SPCR console was only added as an option for earlycon but
not as an ordinary console so users don't see console output
changes.

So users can opt in to an automatic SPCR console, make ACPI
init add it if acpi=spcr is set.

[1]: https://lore.kernel.org/lkml/20180118150951.28964-1-prarit@redhat.com/

Signed-off-by: Shenghao Yang <me@shenghaoyang.info>
---
v2: Reworded commit with more detail.

[v1]: https://lore.kernel.org/lkml/20251228092222.130954-1-me@shenghaoyang.info/

 Documentation/admin-guide/kernel-parameters.txt | 2 ++
 arch/x86/kernel/acpi/boot.c                     | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1058f2a6d6a8..9b65ec0b5e0a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -125,6 +125,8 @@ Kernel parameters
 			may result in duplicate corrected error reports.
 			nospcr -- disable console in ACPI SPCR table as
 				default _serial_ console on ARM64
+			spcr -- enable console in ACPI SPCR table as
+				default _serial_ console on X86
 			For ARM64, ONLY "acpi=off", "acpi=on", "acpi=force" or
 			"acpi=nospcr" are available
 			For RISCV64, ONLY "acpi=off", "acpi=on" or "acpi=force"
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 9fa321a95eb3..83bbfa1d6f1f 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -47,6 +47,7 @@ EXPORT_SYMBOL(acpi_disabled);
 
 int acpi_noirq;				/* skip ACPI IRQ initialization */
 static int acpi_nobgrt;			/* skip ACPI BGRT */
+static int acpi_spcr_add __initdata;		/* add SPCR-provided console */
 int acpi_pci_disabled;		/* skip ACPI PCI scan and IRQ initialization */
 EXPORT_SYMBOL(acpi_pci_disabled);
 
@@ -1666,7 +1667,7 @@ int __init acpi_boot_init(void)
 		x86_init.pci.init = pci_acpi_init;
 
 	/* Do not enable ACPI SPCR console by default */
-	acpi_parse_spcr(earlycon_acpi_spcr_enable, false);
+	acpi_parse_spcr(earlycon_acpi_spcr_enable, acpi_spcr_add);
 	return 0;
 }
 
@@ -1703,6 +1704,10 @@ static int __init parse_acpi(char *arg)
 	/* "acpi=nocmcff" disables FF mode for corrected errors */
 	else if (strcmp(arg, "nocmcff") == 0) {
 		acpi_disable_cmcff = 1;
+	}
+	/* "acpi=spcr" adds the SPCR-provided console as a preferred one */
+	else if (strcmp(arg, "spcr") == 0) {
+		acpi_spcr_add = 1;
 	} else {
 		/* Core will printk when we return error. */
 		return -EINVAL;
-- 
2.52.0


