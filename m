Return-Path: <linux-acpi+bounces-6120-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358518D709D
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Jun 2024 17:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66DEB1C212E4
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Jun 2024 15:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9882152E05;
	Sat,  1 Jun 2024 15:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="GfAJeR4D"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638D1152786
	for <linux-acpi@vger.kernel.org>; Sat,  1 Jun 2024 15:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717254298; cv=none; b=Qi1x0BVMgESCfxciOGf/lqP6KC7ZPyGOYmaoBJMy2Sus57cHzMX4gA//rIG8K00s4biSY2i93LZNxbppw4/zRntk2Can4pfhv8oi871estOWeAAPGL17BBYFHQgZuALxPJWl1IjeFXB14tNIEm60r0iiEvYvDlp95xsbVN5UYnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717254298; c=relaxed/simple;
	bh=5W07LWryv9sCiUT9t9LTI1vN2XJHVgygsyGcyP6/IGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BdCXE8wmknXTBAxMvnk7gRUKJmKrO0GEZTI+AoJF3xls/FuHhaVM08ZIN6Bz7V1AGrkoKNZKblR9gG4P8HSjlsU9rj/aP3BcLGuwRk0SUv/VFq6vuI0ldQRfTHb+S6Jq5Q7hiHKmmQw14OzmwcuYX2Ws+ix1/QBh//gXlNnUo24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=GfAJeR4D; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-702447766fdso1901628b3a.1
        for <linux-acpi@vger.kernel.org>; Sat, 01 Jun 2024 08:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717254297; x=1717859097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMraijh7EdibSWZk0AZcru1m7VB53gCU3iTUEc1cnAQ=;
        b=GfAJeR4DNd3ze1I/onHarHOUb80MzfFqOK47aHFCAnlCbXgyCAsezgUO+g5slf7gCv
         ohWLMd4HlRHy4vi13vVqJQikCrkYdkR1Ep1qDobsmc4VSBqsH2s/9qKo2SU9g6KZvRTX
         BC0ZXc2tPZKVRSNFUuhzheGpO1Esig9LnIpZDnv0ccn/nItMVuOfyXzpypVMecXb1zGC
         aqW+SK937MOegCerIwkYP+PldMEw6OP59LCnt1ux+DKeAw2d9kU5Hsgue03w3DCWLjtY
         l69z0auJU24etcFihoqUasRZ7CfPV1pSwxkHX7nOQBLaqUXAGSA/kCgEysWCqFTP2/0j
         aWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717254297; x=1717859097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMraijh7EdibSWZk0AZcru1m7VB53gCU3iTUEc1cnAQ=;
        b=aPyTly9Gx8VeVcsv/00V5CTwJwzSZgxzVGMB+KXvNIdSljjwd0Z3AWspj/MfGSIUj6
         YDSC8tIL1oIMfCpKlVOoDJ7Owbz5jZv5Av6GvcRfKjLXjFDLsWHlB3zOjT0yRi0g6L4T
         ucyJgz/605vN4nsxNGSmiILulFLz4OPqjpL2/Yoz1onCrYt+E6rPTmG0jauEYkAxBFqN
         8UcjiXFeWTaCO3naG6Te/BQXntz/mp0IFBmaM8M43KSx/8Qayt3MY+wsGM36ac7YVAug
         1RT6DllSevAyWGglyaoac3GRnx2IjdWFHXfMh1087YCHgD472nfUf4Kxr8V+zkU3Tu2h
         baNA==
X-Forwarded-Encrypted: i=1; AJvYcCWOEDDPhH01UFDBoWU7h+XWO4mB9Eb0qYQmEu+a1kvhnAvyofMdiiZAH7GP1FUBpR3FpDL82phdHstlpYI836ROwXerNAzOdszy6g==
X-Gm-Message-State: AOJu0YxOw6SSnJ49syRp8BcwfmOGbKVV+MPfRdsYoKUSS2+ZRxMN9zBe
	2+oWTdzvK3BTTB0+tisTJrw9XVieLyXXHKsDKlwK2UCIVwF5pqehCM/LvtNztqw=
X-Google-Smtp-Source: AGHT+IEKmyacfHakdX0P9GQl4t/BNHOtB7jRjgspK3iaFW5wKEhTYgTuLeBLCF/OOGDElEGcu+f4Dw==
X-Received: by 2002:a05:6a21:32a1:b0:1af:ad46:cd4a with SMTP id adf61e73a8af0-1b26f16ea65mr5996794637.12.1717254296842;
        Sat, 01 Jun 2024 08:04:56 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35a4ba741sm2559410a12.85.2024.06.01.08.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 08:04:56 -0700 (PDT)
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
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v6 05/17] ACPI: scan: Add RISC-V interrupt controllers to honor list
Date: Sat,  1 Jun 2024 20:33:59 +0530
Message-Id: <20240601150411.1929783-6-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240601150411.1929783-1-sunilvl@ventanamicro.com>
References: <20240601150411.1929783-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V PLIC and APLIC will have dependency from devices using GSI. So, add
these devices to the honor list.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/scan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 66038fc731fb..6f3152170084 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -832,6 +832,8 @@ static const char * const acpi_honor_dep_ids[] = {
 	"INTC1095", /* IVSC (ADL) driver must be loaded to allow i2c access to camera sensors */
 	"INTC100A", /* IVSC (RPL) driver must be loaded to allow i2c access to camera sensors */
 	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
+	"RSCV0001", /* RISC-V PLIC */
+	"RSCV0002", /* RISC-V APLIC */
 	NULL
 };
 
-- 
2.40.1


