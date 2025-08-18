Return-Path: <linux-acpi+bounces-15775-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AE4B297E2
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 06:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 901A87A31AD
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 04:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544E826A1C1;
	Mon, 18 Aug 2025 04:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="gHN/DfWh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE02266565
	for <linux-acpi@vger.kernel.org>; Mon, 18 Aug 2025 04:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490341; cv=none; b=pVYJYnmDwuqjp5lLhcHmllOHmchnYf88EbVpFicpcr4dC6BO0K32Mo41ICgxs+PMPZ/3Ot7MdO7dPAksARxyTtctEBFcX+zxNFfIzi5rbNbUII82jcK/dcCulPCaLzuOFQ8Iep5Ky862jVfK5gpupml0c+CNtnNw7Y9OOaTaPwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490341; c=relaxed/simple;
	bh=kOJ0GefeAd9UEbFEyV014zsaaRwCNdDHSJBAudKVMFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7vnOw48W+nGIGkj0AxeWwx4bE77+6G5WZzJCvplia3nXvitghvtjt5zjFLOxVVYBPsGZwtuzTJmYBL7U7hQSi8pwGBi/tdADrE70fEEJZQg2hmI8SdJBN681oFaNUxBZODAJ+YeAqMqhIiKlXaBTmFoIAZOAAWIMFkNVCPgG58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=gHN/DfWh; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-323267bc0a8so4747488a91.1
        for <linux-acpi@vger.kernel.org>; Sun, 17 Aug 2025 21:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755490339; x=1756095139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQx4DIh4Piuq7HhjaN41eXcQRyGY2O2ucSjN2pwnllI=;
        b=gHN/DfWhvd9pYjqIf7Ywp47g4kPdbsIoTCKr69b6cmVonTL2k5NcKk9wr/FnDXGzTZ
         hmzBsbbuSIGykBo1Nfci9MhpUoPx/LHe+ybwwGQAnE30YaXokLNp5m1qKpWL/raIuWAu
         qA7XcEf/zzjSMbo3Ef2OMqq1ciOqwqEUaz42VjuF6mWYsnnPd61AXdLVZ+EB3md6zMtp
         ag9gkrg1mrgDX07KLdkktD2Py6KmTgaGMrm5dS+LX20R70w0iJdnHhP2kN4FdRmk8yWe
         HTQufxOr5UFc6ZICD+XFKncwOPxeJ5Y/lIILOtahCcCE27gkThhALtp+uMmoUZIBc8Cd
         p6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755490339; x=1756095139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQx4DIh4Piuq7HhjaN41eXcQRyGY2O2ucSjN2pwnllI=;
        b=nA4LjC8nuyCEs2Sp/90pETTtj0Rnjvi6e8lmEryKaCAX7ib/jBWy7otw6606pzX3XH
         SWUErAla1oXdPGQCKtBJ7u/FOIDVEZmR3wgZJsL3C+v2I13qMwJ9lEHLiS5uaM8H66hR
         hDpNElz+KpYi/kOaDFnmd/PXNmmKCqVyANvjf3jhwVrV2m5VFa060hkl1LTrEp3nDZti
         UuASDQzfmv5oYe34FDFc4pN9985gGR2B21B6rFacHXmDJnQwgs423iAvLbqcDULsMtCy
         p29H5xDDyXMfNlhRivdaeZbWSeNRSG2zbaq6H5cYwtO+/b5VNv2SWi2lTPxtESjUKTol
         fJnA==
X-Forwarded-Encrypted: i=1; AJvYcCVTYqQ6M8wYPX9qG4swJLCgBXTKl2QQtlSpBOGB56a1mO6pK+5SodVXCmKlY6+UvJ2Bl8dVU95JcXLv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2nhPiR3Gp6qSsA01bavzJ7Xb7AhqEgIwPaNgEjf573oBCRApn
	NPRWSgThaMH2kK+cWBOsE0U75ufhUiEa4eloURt3g8J6Rfmv9v0CeXpXTiWkFi6MBMI=
X-Gm-Gg: ASbGncudSw8qRmzIBCJ/fOg4e1FTT3InRaHyybo+4Nmx9bao3CKW0pFDGNK7CtVlL5R
	w1Ad431Ve9n8j/xZsxSxMlAa5xva+NPYLEV4c/aRB3zG0/exjoBCnkx9zuQjhbw83M1b0nJCeX/
	eTuUV4mgWt+WPifrMRg2uGJfz7q3f3C0sjEL/+zI2EjHfc7Y8R031Oh+kriYZ50yVe/2mMfugVD
	gYsBLxV/oY/83V1LuVvyimiHMYLcQNmNr4ThjfHdFbvEzoJLDDhYJQQprYSSQrIiz+UHXJ2JBhr
	pXgAUiHynMzijNdv/wBEgKrPIHQ5D/Gl463SGHYeN583RM1hp8qOWL5RKALYvsdwaW6nIkFngT5
	+e0d7Q9wu8t6935PVnFgk1vBzE2kAscs5LthyCfsKh3Gx2HlT9+VZnNGRY9cyMEwr
X-Google-Smtp-Source: AGHT+IEPxSb/NsG9Zm6Sde3dy+9vjl78ugsOjUnfoDwFeFFug3ocplCGnN7dY2ngRx9phRfT5mXqyQ==
X-Received: by 2002:a17:90b:268c:b0:321:87fa:e1e4 with SMTP id 98e67ed59e1d1-32341df8cfbmr15719154a91.6.1755490338939;
        Sun, 17 Aug 2025 21:12:18 -0700 (PDT)
Received: from localhost.localdomain ([122.171.17.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32343c70356sm6560972a91.25.2025.08.17.21.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:12:18 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Atish Patra <atishp@rivosinc.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v10 16/24] ACPI: scan: Update honor list for RPMI System MSI
Date: Mon, 18 Aug 2025 09:39:12 +0530
Message-ID: <20250818040920.272664-17-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818040920.272664-1-apatel@ventanamicro.com>
References: <20250818040920.272664-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sunil V L <sunilvl@ventanamicro.com>

The RPMI System MSI interrupt controller (just like PLIC and APLIC)
needs to probed prior to devices like GED which use interrupts provided
by it. Also, it has dependency on the SBI MPXY mailbox device.

Add HIDs of RPMI System MSI and SBI MPXY mailbox devices to the honor
list so that those dependencies are handled.

Reviewed-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/acpi/scan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index fb1fe9f3b1a3..54181b03b345 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -858,6 +858,8 @@ static const char * const acpi_honor_dep_ids[] = {
 	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
 	"RSCV0001", /* RISC-V PLIC */
 	"RSCV0002", /* RISC-V APLIC */
+	"RSCV0005", /* RISC-V SBI MPXY MBOX */
+	"RSCV0006", /* RISC-V RPMI SYSMSI */
 	"PNP0C0F",  /* PCI Link Device */
 	NULL
 };
-- 
2.43.0


