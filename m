Return-Path: <linux-acpi+bounces-18316-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5B2C1A056
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 12:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AA911899664
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 11:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B88328626;
	Wed, 29 Oct 2025 11:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="em1SahIN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF81D3321DF
	for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 11:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737235; cv=none; b=IZtsk7m6T0FcKJFIw8KQruH7631wqY0u6cUMi7lP9vl+mJbxwlv0g1EMmkl+lplkdiKyxpX8l0Dt8aCKaRUbYooGEA41bTCOdvjbPYRhrvVzfebZSscXiggbBxOLCELtCeMVR8A9f6O4ZyIsgTyPKRZccyXC6HtJr+KBO/faiA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737235; c=relaxed/simple;
	bh=TlIOJZgzYRa0uSdvlZ7h4NFliLwrLJg52Wgu33BrOfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ks1YZtnVyaN3sGr1CBi93eeHdz/vxzr1Y38oQyjU3ChR4lhL6WUA5ArME7GXvStdHr2pSVCENzN/bTSCZjNZmADBk/v0ZB78ER+XW4poua3mPxGgEOki0rA0QkFzjc5lmstPyZ1J0us9vrV8QgJGDHg/VsKMotnD5RxXE2t/gdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=em1SahIN; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33d896debe5so7876682a91.0
        for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 04:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737233; x=1762342033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFXZa2m3ScC7B7xgAgov/Ch2E5BoKfJoACxjrPDC6sE=;
        b=em1SahINqI9aligF0Gu6ZxnaWEOy3AyeSt/BH5otjJ5N6Guxb7T15aPyvpikXyvIOB
         PAeaK7x1ebaA5l0tbRtFEaG7oXzbwrNdWN8v2fHuDlqgAvP689okJocJHrhvo1A+O8yQ
         T/oV5Gv+Ciu7mu/HNX2mwh7t1eLXVArP4yCkOSvDVyNtyQD0hi/CCWueL+EcFMWvTIeo
         WdQtEdz5iUmh3hXRi/sXCIAAxSuajDs6gBPT3Bv7V8xCgC5GV2eNvJnqQoMeaBFRlsWM
         6U2wnjBM7fkqNILfUm/hlm1nJcseJ7oEcaXv8QY/7XZpEavz1infr969bu7OPiCyWGU8
         VkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737233; x=1762342033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFXZa2m3ScC7B7xgAgov/Ch2E5BoKfJoACxjrPDC6sE=;
        b=FMpzDHxnlyQ2DWEviQguDRL9jy9104BjMsuNAVLrmu3+j2F0lAc6g/1xAjCnESQA+L
         mNT1PwoQd7Pt7CqrU3Dhi+7pQeSy2scvv5jHRvfSrCcvHDS/x2ruxPl0HsaQ4JyhwJdT
         lhuynuvPfXO9cTA/SA2v3L8NEPz0M+Zljg2fuVgsGI4LFU1om1S8XXLtYpYmdiK7CWyW
         h2eMz5FHfcM++cSnN2ZMpuYx0TzYZIERjQAITl9TW39HHqV7y6jkBN3PcGac3+JAQSxx
         NXBJxVlpNdNh5aRVmCOVLnNE5uT/5pM0IAE92PapWB4TquM9s1hCxQJvHibf1dS2mnAB
         DrVg==
X-Forwarded-Encrypted: i=1; AJvYcCUGTR7cPJiESqso/3tKSg1RwKW7iIM6WvQZftrY4KigCGk/Oed76yGXt/onvkPZUTLVBHL9n+6muei9@vger.kernel.org
X-Gm-Message-State: AOJu0YxhARLBlBgh4492EmKwLCNt8LzHAz3oVvjKMLtIaqe4YvUS6E2O
	zdT0cPnwprPp9RQaV7VaV2QNiHDDrk1AWZj2U9gMzSQgIB/u3ySHk36qgbeZhj81uFI=
X-Gm-Gg: ASbGncvxtW4GNKzu1aqocgkrKmvBJvF5M8KkCjLqSCuAkbfFWtpxqBqpWRqvWMlmxiO
	5JLBxt/r2qQ1vat21xy+uZbLNVj6KFPe302KaMcyA0FHNZO7at1nZaF/uy/6ekX/9ZkjWrL8u/b
	W3kPxEKVdfd7ZEJQjiyp/6djjfeAihWGxNxkTC5FN3CtCPPFy1AMJkS3NB5IsnrF6NR8yB1SO/D
	rjJoL8cm3GR4P5WI7HSxZA3DRCqbM+dSg2cs2OMf7cilU7MN2uMRQXgJDikRvS5HvXHT9QdJ26r
	bOTi+dPiWVWhMaKAckMSTadpXBX07gemNczuV6BAKtlRxygTpEudA8SHX47zpyVSod6ztC5lOJw
	Y2XbhceGABJOC+jlq7mMZWpfnRMU83/1ZxcrIf2PmPaBeuLoLqrvcYzGSeXo3NZTqdVL/Kqicyk
	k3Vn4BRAlRNSYrHyTE9AaxRVSWRRSY
X-Google-Smtp-Source: AGHT+IFGkvDWy4UC3Hg/jmsLKRMLWCVuS3Q0brKoM+EvGQYG5cGXwRa91mgG3g+8I8GSaWTf36w5eA==
X-Received: by 2002:a17:90b:4a11:b0:330:6c5a:4af4 with SMTP id 98e67ed59e1d1-3403a29bc2cmr3385152a91.35.1761737233246;
        Wed, 29 Oct 2025 04:27:13 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:13 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-efi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	ardb@kernel.org,
	conor@kernel.org,
	cleger@rivosinc.com,
	robert.moore@intel.com,
	sunilvl@ventanamicro.com,
	apatel@ventanamicro.com,
	Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [RFC PATCH v2 02/10] riscv: Define arch_apei_get_mem_attribute for RISC-V
Date: Wed, 29 Oct 2025 16:56:40 +0530
Message-ID: <20251029112649.3811657-3-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
References: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ghes_map function uses arch_apei_get_mem_attribute to get the
protection bits for a given physical address. These protection
bits are then used to map the physical address.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/include/asm/acpi.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 6e13695120bc..0c599452ef48 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -27,6 +27,26 @@ extern int acpi_disabled;
 extern int acpi_noirq;
 extern int acpi_pci_disabled;
 
+#ifdef	CONFIG_ACPI_APEI
+/*
+ * acpi_disable_cmcff is used in drivers/acpi/apei/hest.c for disabling
+ * IA-32 Architecture Corrected Machine Check (CMC) Firmware-First mode
+ * with a kernel command line parameter "acpi=nocmcoff". But we don't
+ * have this IA-32 specific feature on ARM64, this definition is only
+ * for compatibility.
+ */
+#define acpi_disable_cmcff 1
+static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
+{
+	/*
+	 * Until we have a way to look for EFI memory attributes.
+	 */
+	return PAGE_KERNEL;
+}
+#else /* CONFIG_ACPI_APEI */
+#define acpi_disable_cmcff 0
+#endif /* !CONFIG_ACPI_APEI */
+
 static inline void disable_acpi(void)
 {
 	acpi_disabled = 1;
-- 
2.43.0


