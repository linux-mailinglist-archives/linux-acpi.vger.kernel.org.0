Return-Path: <linux-acpi+bounces-14912-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E783AF0A9B
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 07:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF12116E3A7
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 05:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB1E23BCED;
	Wed,  2 Jul 2025 05:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="hBIMJ2Qx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CF9205E3B
	for <linux-acpi@vger.kernel.org>; Wed,  2 Jul 2025 05:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433400; cv=none; b=uQBPAfk40Dh/SywdTL34k7gQQJvgrA3V3mgJXHgm0V5YFgijkCBv7zFup+ThhzaYFE8H05Oa9szoA7MU/dEe+5GKSVFARmN4xrs83+FFoHSqX4e+PJweXi0bi7anxtxrW8PntzE8pHy6cjpuQTjqTSEnTWfzHdFN9Xvjaw9oVUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433400; c=relaxed/simple;
	bh=bbsKQgQKotFffImznTiHFRZUkpn3l2AEmmz1a9sty/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3k4SzYEGh3xNCkw6gs0O4lLSB8sU77sVcN2y1FizwGL3HmZ+9vgmsoNeim/fxvb2cDWy/1WVeQbqz6DHDakHwEoc+iXe7SFLcU6WvkBP+DXmh0UjkppjqwNT6CTOFbysfJSn1t6mvSpFk+7BYbAgyjOqW55DYlcMUcU43Xl7pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=hBIMJ2Qx; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2349f096605so47455255ad.3
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jul 2025 22:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751433398; x=1752038198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFaQ5Zs1hbK8MQOtKnNrpZ/cBeXTMcFHCuSD6j9WtSo=;
        b=hBIMJ2QxGvBn9LASwz6VN2AHYtgG3f1h+RAJXq50OgG/snVrBDiENXdK4ZvlzuX+k+
         fKIRNe45LAHzrcFabnLUvcaXaDxAzGmhW6DWKe79W+8KiiEyHctLD8MxCK7Vp3xu3faO
         1eSwFFlBnqOmH03Wj0mJ7F+JLWUTjYFchFFZ30nFBulWe6WMuDtI2nQfNqe4it7DJU2V
         O0K1sRs6tv+gpwDW1Pq/mdmChe/jGILGmBRgO08IvcmuWUjhbozAZL8IiZ2L15SwQ2Er
         JWOm1UIHk8/TJwxPtqV8NLiZgdJtMGiqE2CPcCdzMfNgsTI+hNaDIxZZEEsLvTocM2eD
         tb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751433398; x=1752038198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFaQ5Zs1hbK8MQOtKnNrpZ/cBeXTMcFHCuSD6j9WtSo=;
        b=QPCHP3ROF1k77elf8L62t0URhm+et/Hanvwphmuc//h2K9zeJL2vT5MsqfoTNKG8/Q
         llxZhdk1Rz7G5TqOyMEpC1uP9QCtMyifrKkDjM0hZt6TVNpx3ES3B9J7djb3NKvqDzWQ
         bKcz7qi+EaMcdKm+0y5TILFWHSqqb2TLn0HyOp+3ukIsVFz7LPyGKsSHx9Rt+6PU5v47
         GX0NTUDogPYXXz9mbDJzLpY0JeCQHYb7Bzh7jF6SChez0a5Gj/RO1t/Ug3vIim4feC34
         89i0cJC0BAZ2IcNOrOK3rcnjyqFtuTyL0CByTZq8jVTj0LBTgO+pHWkVtW2b4KYY4Jlp
         YsjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOwCNqEPBhuJjmFRxo1g5Z1yvspG4OxolteRPXHAKe3kOr7+wLT44Ee3BjKnxblw8Xp6mWW+MjoPGq@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0OtR/zbjr1AOnnbqg8DKEUOoydFNvaPLlnxsaV+xzDoet6DMj
	iSmi1/RYEB2QAYSKmHNKZV8fOAqf9Ijj+NJPb700msU2CDN8ktszPOVRnCXi3a8h4xU=
X-Gm-Gg: ASbGncvb0w1/mumKpSHO5RCszX6gXTfHsSu7A1dyYqSI66M4H3101qxs/uwBFhFq1cg
	O2qzy7K2gXPrPM+Fw/shzvhWXJscBbb9v6T5PbJWTw7l+kEWeDifJnrjq8173G8Aa8NbaG5+VD0
	SB+eDTeaYHwGDyUpKznLLs2fn8Rti2rLJX95vKcjMis1jKqc7K6g790NSJzZwKHvBSNUyNBug11
	YpAnePmDgHETtnhUpYEvDlJL9cpPEyXs89ZzsOvYCcSJ2fuxNDdgOsaJ6Jh+i4KrJZxzJnLThmu
	q/FXKlgV0bcsGUbc8PEzQHEy2dpjUbdtUy88eLI+g6LjFiCjTSpyvSf5pAgE9yDNysaBlifaRlb
	CfWd1rDmcK3WYTNKG
X-Google-Smtp-Source: AGHT+IENCvcAnrrecQXBt5V9LFuZ+rQKh4OUv2G9tNtl1lHXMhnri6Hzogn+Hw60JHYcRZ/blVSc/g==
X-Received: by 2002:a17:903:4b0c:b0:234:c549:da10 with SMTP id d9443c01a7336-23c6e5d6335mr17948045ad.47.1751433398116;
        Tue, 01 Jul 2025 22:16:38 -0700 (PDT)
Received: from localhost.localdomain ([14.141.91.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c6fe31933sm4719595ad.220.2025.07.01.22.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 22:16:37 -0700 (PDT)
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
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v7 20/24] irqchip/irq-riscv-imsic-early: Export imsic_acpi_get_fwnode()
Date: Wed,  2 Jul 2025 10:43:41 +0530
Message-ID: <20250702051345.1460497-21-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702051345.1460497-1-apatel@ventanamicro.com>
References: <20250702051345.1460497-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sunil V L <sunilvl@ventanamicro.com>

ACPI based loadable drivers which need MSIs will also need
imsic_acpi_get_fwnode() to update the device MSI domain so
export this function.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-imsic-early.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
index d9ae87808651..1dbc41d7fe80 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -7,6 +7,7 @@
 #define pr_fmt(fmt) "riscv-imsic: " fmt
 #include <linux/acpi.h>
 #include <linux/cpu.h>
+#include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -215,6 +216,7 @@ struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev)
 {
 	return imsic_acpi_fwnode;
 }
+EXPORT_SYMBOL_GPL(imsic_acpi_get_fwnode);
 
 static int __init imsic_early_acpi_init(union acpi_subtable_headers *header,
 					const unsigned long end)
-- 
2.43.0


