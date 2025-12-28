Return-Path: <linux-acpi+bounces-19871-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 412B5CE4A70
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Dec 2025 10:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E42BD3004F1A
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Dec 2025 09:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094A22C0323;
	Sun, 28 Dec 2025 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b="E/37fXED"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626271A9FA8
	for <linux-acpi@vger.kernel.org>; Sun, 28 Dec 2025 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766913754; cv=none; b=N8dz61F1f1AVKbMyrsPPVWVkmsc2JovcIMpK9xMHPq/jGS8EsFCphkc57fwMRijuucdZ/t3b2j1vsOCdA51USyJamONNIuh/yW+fDcqXkJq+lLquPSskaq6pamzSXTpO8tznQ3Qf1LN4huyLJ6+Ix0gQCxtrc3LXA4lauEpn9ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766913754; c=relaxed/simple;
	bh=fwoFwoOwZ79brO3bjK4dcnd+sMd5nFLEFPSURVCAeM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RrFgHKK4KEsJDmXU5q6JKThd/e4cNxNDyvCYRc+sSF3l4EsSfAbBnI4lmyYaFDUqfvIEcJEu0OnvI/asoBmV8oRXobEE9Wl1eXmhJKIX8nwgL6pzny3JxwVLDiud6aUZt6xfuPUrg7BYQO+VpbB+6bP9Gx6wT/mVt6bJHvweQYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info; spf=pass smtp.mailfrom=shenghaoyang.info; dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b=E/37fXED; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shenghaoyang.info
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29f08b909aeso15590205ad.2
        for <linux-acpi@vger.kernel.org>; Sun, 28 Dec 2025 01:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenghaoyang.info; s=google; t=1766913753; x=1767518553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=btGrbjMukhkE9Huw3B46VPetYheSVmss50T7F8K/NzU=;
        b=E/37fXEDYXY3oAx8hmtxgG/edTwSRlCExMUE8Azrb7NK1wExgT2Njsl979bs8QFWe4
         +w8qvE5MypD/7xCS72bxhGiXD+QpMTbL46OHV7JIi/P4MFIpWJxZJH1Yg5IM6ks6Lpw1
         hBe4pAZLJuMxlfL9CR3L5efHebx7zldSUangh7A9j1ri2pfeXLTdYXdf0PmDCYvj4COI
         TZ1scNWf6wgb4mOzjUx9Lte2O5Ld+FftuewHaI7JSxJ5kb8KQtM/B3vgzb/5NtdeN5qD
         mPvJ0zH6ySzFBoNjfh1vqqS7VvLoKG/0JvaGd0X6iDLO3de1gz/P822iV+W113gBb6ft
         WAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766913753; x=1767518553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btGrbjMukhkE9Huw3B46VPetYheSVmss50T7F8K/NzU=;
        b=ldt8DaBzeMlFU5M+B6epYPWHZJQBxFysqcdMmYQCHpbiXcKTipLWZ9UE4qFk1JOnLK
         Zm8TtsW9jo79s/DHKNPeLoJWIICyawJZnV3yjr2USYt4TIrKPljhvCzVW0lhNn2E0JU1
         YBk3qiSfO/JgNHuX/N57O4107e/t3fiS83/LYWeSwHmwQ+Iup81edL56HU7jKigX2kvS
         Kk5RwhtZG2U76i0vzJnP74prMmdenmkUTfMNAbVv5snDxMh69QKWwOXQOc4yi0YGY6Dk
         /eZEC+adS3EA3/g37cceVWdOGjkMFzblohjbi56ZsX1xMdYYJonD/SamvIPJ9QHOqeRS
         Og5g==
X-Forwarded-Encrypted: i=1; AJvYcCXe/5iJAcyTKFJ28B6Xo1qoXM3ac+IdJehyv9POzuOFSCt0fB4eDWbTg7cyYsQABgNCrbV21iwgPejT@vger.kernel.org
X-Gm-Message-State: AOJu0YxOLfp4aZ55pLJqbLqWM8q5vUntNH89uq+Rz4oB5nc0zr3vXclL
	8Eyn1Sh2lrOdCHDYdESYqEVQQCFdHJ9K6Zrm/5kVl5fZyEGqYhDsIxLV803JIGTrMI4=
X-Gm-Gg: AY/fxX5CARzmPq7cGxRX5m7QkBgdxG8YzL4Rund7pWjkSzOzcFdUH8PoF1kbCqAUku3
	T2Nglz3FB2la2NilbwhInEiaUU2mp78lDF7Hm9sRmnyIc8QOxVRxkB5PLOrt4Vu6l4z3pz+6EDd
	fwz2sA+KdJsFYG0hl6MLfuuwRv7940P9dpBdvpmitZemYSVq0IFLz7wRnhhmEvq1q9YYGCPC0tL
	0E8B7/jI+srkQyFO9EBf+8WWhKEM2u65BOvVvoYlTD5B9SvG1VXEXUiw9tF6dCmzZEgj9lCc/u/
	gJ2sMvPNQq/Zvwp7s5shfpzb59cK/dQevottdG2JrSOcXuefgZqb/hN+OPPyTNLfVNoxxGmFiAV
	xieFlr/pgIexHYDuBrpqtvEypj1IZTk3sc/9iCxtz2JDAAritFct0tDv8BboQtkVGqI3Rrajqz8
	YK/xLX3PhL
X-Google-Smtp-Source: AGHT+IGdyJfOW5uro74UetUR3eEqSXEEp/H+D4mywZrRrWNe9MzaUu+kyvmohAZoutwkEfrKSGQ6WA==
X-Received: by 2002:a05:6a21:398:b0:35d:1244:177 with SMTP id adf61e73a8af0-376a77f5b4bmr18068554637.1.1766913752615;
        Sun, 28 Dec 2025 01:22:32 -0800 (PST)
Received: from localhost ([132.147.84.99])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-c1e7961c130sm22665096a12.3.2025.12.28.01.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Dec 2025 01:22:32 -0800 (PST)
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
Subject: [PATCH] x86/acpi: Add acpi=spcr to use SPCR-provided default console
Date: Sun, 28 Dec 2025 17:22:22 +0800
Message-ID: <20251228092222.130954-1-me@shenghaoyang.info>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 0231d00082f6 ("ACPI: SPCR: Make SPCR available to x86")
made SPCR available as an earlycon option on x86 but did not add
it as a preferred console to avoid breaking existing setups -
users have to round trip the dumped console options
("SPCR: console: uart,io,0x3f8,115200") back via their
bootloader.

Let users opt in so serial console configuration can be made
automatic.

Signed-off-by: Shenghao Yang <me@shenghaoyang.info>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 ++
 arch/x86/kernel/acpi/boot.c                     | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a8d0afde7f85..f9c5b6e4eda9 100644
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


