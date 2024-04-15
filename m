Return-Path: <linux-acpi+bounces-5047-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AF88A58A8
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Apr 2024 19:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF571283D4D
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Apr 2024 17:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3F912AAE4;
	Mon, 15 Apr 2024 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="S+2Xh3yf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA0A86151
	for <linux-acpi@vger.kernel.org>; Mon, 15 Apr 2024 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200619; cv=none; b=CyGQgtYFC0HupUzbdyoPbKeD4N0yAnivogB15MPc6LKc4/4C4DFosWYHKBshyrWIplVVwN/M8tuYXko+FBVmn45IJKo3pSbqb4ul71iPB8WY23DC3MyJiZNOlv5Sjpl4aUUl2+Rl8yjrRDLHLmNEXIC7V2uVNil+Yx9ZAg9xs0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200619; c=relaxed/simple;
	bh=egibTauTOK5De6SrAZsOC/2NVkpwGlv29Ym3R/RrsZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q2ptgCcrQrWAVkLYWUqOgaZ06hvgf+Wo03HkjpIoYvmvmH0x+TV606WXxYBBclZaihwQLBnVGC9VeQvlU53g1IgX3Pf5WT2qTGFWbktd1T5Ci+JIr4yBvWZnaCJZTOiyD5ICbdCrNQytW6mAIwIVcHaajV5Z1gy3AAtJCjLBPFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=S+2Xh3yf; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ecff9df447so3555285b3a.1
        for <linux-acpi@vger.kernel.org>; Mon, 15 Apr 2024 10:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713200618; x=1713805418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4XnyCkVtMil3j8A/KjvpJf48jXr01BLYuVmlXnWMII=;
        b=S+2Xh3yfocQEr4U7oungQ9wWoas84CArQ5iojn3Jhxjg1TrR+U9MkCtaGNUzfdaYQ4
         MMrYMjrOHTlj+tbeEssAovI0oz1ao6nlGeW5qP0a7SymcRXQWhx3YejF28sF5aHcn1Gt
         Ik9mvV5L00m+PIpOZFqwuQniQcbJylajPnGnr9hG/Mi2DwfYIw8VB0YxeQad8s3guGYu
         6pc5fat7iv5BLOeaCi5PYs1XkBJGGEBvVRziGRH71ngc33KsAi6WiWRLMgdLvY7P/4XS
         kJkeH/ft//1Pd1QqJ0P2MItbXxxXX6NOKMi1UwXYK6MgKoN21o06Zlbpvedl4VlqKRfP
         Dtvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200618; x=1713805418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4XnyCkVtMil3j8A/KjvpJf48jXr01BLYuVmlXnWMII=;
        b=dhVGPn3qTcZPyFyWc6sA7vIFSZZYg9vTHNn+bxAk1Iulx2irIaQ7sdKUFOpODr3iEG
         VX0KDY99x74sAfe4XmJYwQPTOA9XSARksZ6qMHiHz04EdpWJL1hDxtaS9vMXTh9pymdi
         J5Vml7R2Ivi/hZM6YIkkMO1+vvrurjN/+qhUpQFZepQgEWst4RhrELKXpKbLpFQPQTIk
         6OrvIuRFHhz1JG1G4di6kRinxja82ctdCwfaw6oWvy14jkJeXEhKa2Kx5Vzw2TJHaatT
         Bkk7i75HP6iMokDDVpEC8c+cuxq24jWCt5K1jNUkjFqHoXPkbsTPrH94+X8Hhnhfy4zR
         q9mw==
X-Forwarded-Encrypted: i=1; AJvYcCUem+71y4z/zHuf2k8rkb6tHpBBY5ioRrOLb8y4zJncaGNXgmhl5lYrZK5TGxrPekJjQqmishZVhzqSmpJfQfq76SmjmXybpPHl/w==
X-Gm-Message-State: AOJu0YwEM8fVYWjH6diAMcJFIzn6xhYAVtRvzQjbT565PEk5+NS0opC5
	amGwmb4GOv7Ie8GDlvHstsdx4G87kzgwyJMEncDJP7mHL5Y12hXVR44pYo5KKLg=
X-Google-Smtp-Source: AGHT+IEZ3MSxzXsGAz+ZLkxl8S7XJ3zcQ2NIg6LwPVYoJf81xxbiq6s9OomXLtGiFPJD3YOtkLtUPQ==
X-Received: by 2002:a05:6a00:acb:b0:6ed:21d5:fc2c with SMTP id c11-20020a056a000acb00b006ed21d5fc2cmr12682862pfl.26.1713200617123;
        Mon, 15 Apr 2024 10:03:37 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7433158pfm.25.2024.04.15.10.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:03:36 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Marc Zyngier <maz@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v4 20/20] ACPI: pci_link: Clear the dependencies after probe
Date: Mon, 15 Apr 2024 22:31:13 +0530
Message-Id: <20240415170113.662318-21-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240415170113.662318-1-sunilvl@ventanamicro.com>
References: <20240415170113.662318-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V platforms need to use dependencies between PCI host bridge, Link
devices and the interrupt controllers to ensure probe order. The
dependency is like below.

Interrupt controller <-- Link Device <-- PCI Host bridge.

If there is no dependency added between Link device and PCI Host Bridge,
then the PCI end points can get probed prior to link device unable to
get mapping for INTx.

So, add the link device's HID to dependency honor list and also clear it
after its probe.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/pci_link.c | 3 +++
 drivers/acpi/scan.c     | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index aa1038b8aec4..48cdcedafad6 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -748,6 +748,9 @@ static int acpi_pci_link_add(struct acpi_device *device,
 	if (result)
 		kfree(link);
 
+	if (IS_ENABLED(CONFIG_ARCH_ACPI_DEFERRED_GSI))
+		acpi_dev_clear_dependencies(device);
+
 	return result < 0 ? result : 1;
 }
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 086ae040a5ad..32865af071ce 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -835,6 +835,7 @@ static const char * const acpi_honor_dep_ids[] = {
 	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
 	"RSCV0001", /* RISC-V PLIC */
 	"RSCV0002", /* RISC-V APLIC */
+	"PNP0C0F",  /* PCI Link Device */
 	NULL
 };
 
-- 
2.40.1


