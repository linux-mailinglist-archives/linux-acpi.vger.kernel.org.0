Return-Path: <linux-acpi+bounces-14260-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 754B0AD3406
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 12:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1D01885B47
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 10:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B9728DB5A;
	Tue, 10 Jun 2025 10:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="HgfHITMA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD1228E569
	for <linux-acpi@vger.kernel.org>; Tue, 10 Jun 2025 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749552429; cv=none; b=ST0n7Iqdgq9gBETNMI7vP+VnzP3vcfoz+3J0PsqpS04hz16tZKp7FbPBJndSNXLUJpwFGZG/hDU7jOJIs9aiiLOoGVW53XQi0BSeOxOkinw8AqU6mYRdmMYKAo6ndtWQ1UFW+Lqn6XgPgG4q3eKiEq9OZEGGP3USwkpyuiV/3dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749552429; c=relaxed/simple;
	bh=ApG+TqazgePfngwgF8UcC0MB1PI19Gz6v9CqRzVQNfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCBDTDqqJeLKCxIKvZiWV7neJjEvTEBFqEOPp+uGfucNQls7w6HQcB/mLC/3oH3lKQ6nQDRlGB2dhXBtcLodvBr/ehxvBBzORO3LzpQjmZmq65vH/8J0LinEyuCqFJ56724GaW5injiyiJB9feSbIfNgY88iqxLrgrUeZjcPkRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=HgfHITMA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-747fc77ba9eso3867065b3a.0
        for <linux-acpi@vger.kernel.org>; Tue, 10 Jun 2025 03:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1749552427; x=1750157227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FP3kf43rac5NeyS0tfBg63Ga8H9gH2daKAu3CycI9m8=;
        b=HgfHITMAhIVRkXauqBRPrw63uqac9O+ZKaVMWuch9oQXJukAafBTM5cbVwygyw0rcg
         GYl4Mg/U0ktzO8zwpNUafcjRAAkJ0gEot6fP+jWMSo37eGNT2yddsQbsa+0ADCu2miFp
         tSitiSvtM0GsRvF8mb/zLs+1uJ0kqCgAIZiT1TiBfBrQCnm4fIVCbbHj0z0oGn2NoXiw
         ZM8rDuQMdNM4p7Y++1i8jfNtN8yN2GTSKvptNfMjW8Z/fz8ovYFSrRKtusZw+3ygRpRT
         ZSlijhFK+U22F5P9P0ls/UbI+ipbRdFrGlLNTgk5CAGWA52klhJdxSiussq+BlliQZsc
         MDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749552427; x=1750157227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FP3kf43rac5NeyS0tfBg63Ga8H9gH2daKAu3CycI9m8=;
        b=kpbh23TC+etmjLQ7EXYR6g42Dkbb1iJz+ZfuPnD7p81yocNZZzdqN4ddqtq2vNi04b
         4loN/S1H2QTxbTgx5rtTIcicPz7z9/sri3U+Y/c9k/2a5nnswDKr2dg0MxJ7OK6ARHWX
         Cymn9Wru7dwMMBLoNnFWScw6vgHwHSrPYe4mADN8MukFHvhQdItpsx9FubUbi+yUufko
         j8KCu73TeQVM3KTZMy5GkALfX4LM1X7Spz99lBMX5v7/Q2wDfbxzGv99LM39gp+hCy3a
         wujMAVaXmkXqYkCstYOIiGgxiU6E5/2YWnZRxNs6uNfNB67FigThplFvnW8/1JlRJY+7
         HxMg==
X-Forwarded-Encrypted: i=1; AJvYcCXluuGcOij75iTWQSBaCyG0GaxAiEZOf1YEwSmJYeFeAONFwpuxdJQLdQoKHwGBeLdJr/hsa0q93jNK@vger.kernel.org
X-Gm-Message-State: AOJu0YxVdvfKE8WRxiwe1JG7oxQRCNJGD2ifm1kwLZSrwHVlFSqEbKEC
	tI56R/Y2L6huQ2qE2oJUYfuzXNg82AwKPEWtMnE2kdjpdT/iFPBIPyxAd6sDtQ4qGAc=
X-Gm-Gg: ASbGncsO0KGxOIbkkksXueFN8CTNWsBRm3wHcBBD1pvXjecDjZurpW1f6GzHuGJbJ5p
	9lop3qREQii7i7zj6/EsOynjz5BO2CxrxXlaKHn6U1qTcpJZjX/SRsv4NG5vpsyJWaRdkwS8be9
	QcaHKZZJYTiQ9dRyrqduQ5jROffEQji7/nieZPsXC/w/tda42oNvvjXXY0ddGBQkN3OkwL9Jjn0
	AmlK2ZFMJ99UMqm1MmBAmq1F5PfoT/pxJM4iSEPy8AXkwHv+0s+FaD7r/JexLY+qWFmQpiTQqgB
	MzCfo7XZrgeq8LbAbWZiug7MTZw5RQGePUtTN5i1Ceq6Dm70U8JLGdlIZqc36erpM5e9wmz6
X-Google-Smtp-Source: AGHT+IHO3whMIsadT1gQS1uvXLzDhfAzklgArmoSaPyZ84SGmfZlfdnm+MiFoYtdG6mfvNnmI8Mwbw==
X-Received: by 2002:a05:6a00:194d:b0:740:b394:3ebd with SMTP id d2e1a72fcca58-74827e7faa7mr22225344b3a.7.1749552427592;
        Tue, 10 Jun 2025 03:47:07 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.196.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0842c0sm7152448b3a.73.2025.06.10.03.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 03:47:07 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>
Subject: [PATCH v2 3/3] iommu/riscv: Add ACPI support
Date: Tue, 10 Jun 2025 16:16:41 +0530
Message-ID: <20250610104641.700940-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610104641.700940-1-sunilvl@ventanamicro.com>
References: <20250610104641.700940-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V IO Mapping Table (RIMT) provides the information about the IOMMU
to the OS in ACPI. Add support for ACPI in RISC-V IOMMU drivers by using
RIMT data.

The changes at high level are,

a) Register the IOMMU with RIMT data structures.
b) Enable probing of platform IOMMU in ACPI way using the ACPIID defined
   for the RISC-V IOMMU in the BRS spec [1]. Configure the MSI domain if
   the platform IOMMU uses MSIs.

[1] - https://github.com/riscv-non-isa/riscv-brs/blob/main/acpi-id.adoc

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Link: https://lore.kernel.org/r/20250514055723.1328557-5-sunilvl@ventanamicro.com
Signed-off-by: Anup Patel <anup@brainfault.org>
---
 drivers/iommu/riscv/iommu-platform.c | 17 ++++++++++++++++-
 drivers/iommu/riscv/iommu.c          | 10 ++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iommu-platform.c
index 725e919b97ef..83a28c83f991 100644
--- a/drivers/iommu/riscv/iommu-platform.c
+++ b/drivers/iommu/riscv/iommu-platform.c
@@ -10,6 +10,8 @@
  *	Tomasz Jeznach <tjeznach@rivosinc.com>
  */
 
+#include <linux/acpi.h>
+#include <linux/irqchip/riscv-imsic.h>
 #include <linux/kernel.h>
 #include <linux/msi.h>
 #include <linux/of_irq.h>
@@ -46,6 +48,7 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
 	enum riscv_iommu_igs_settings igs;
 	struct device *dev = &pdev->dev;
 	struct riscv_iommu_device *iommu = NULL;
+	struct irq_domain *msi_domain;
 	struct resource *res = NULL;
 	int vec, ret;
 
@@ -76,8 +79,13 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
 	switch (igs) {
 	case RISCV_IOMMU_CAPABILITIES_IGS_BOTH:
 	case RISCV_IOMMU_CAPABILITIES_IGS_MSI:
-		if (is_of_node(dev->fwnode))
+		if (is_of_node(dev_fwnode(dev))) {
 			of_msi_configure(dev, to_of_node(dev->fwnode));
+		} else {
+			msi_domain = irq_find_matching_fwnode(imsic_acpi_get_fwnode(dev),
+							      DOMAIN_BUS_PLATFORM_MSI);
+			dev_set_msi_domain(dev, msi_domain);
+		}
 
 		if (!dev_get_msi_domain(dev)) {
 			dev_warn(dev, "failed to find an MSI domain\n");
@@ -150,6 +158,12 @@ static const struct of_device_id riscv_iommu_of_match[] = {
 	{},
 };
 
+static const struct acpi_device_id riscv_iommu_acpi_match[] = {
+	{ "RSCV0004", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, riscv_iommu_acpi_match);
+
 static struct platform_driver riscv_iommu_platform_driver = {
 	.probe = riscv_iommu_platform_probe,
 	.remove = riscv_iommu_platform_remove,
@@ -158,6 +172,7 @@ static struct platform_driver riscv_iommu_platform_driver = {
 		.name = "riscv,iommu",
 		.of_match_table = riscv_iommu_of_match,
 		.suppress_bind_attrs = true,
+		.acpi_match_table = riscv_iommu_acpi_match,
 	},
 };
 
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index bb57092ca901..45a263c9e0d5 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -12,6 +12,8 @@
 
 #define pr_fmt(fmt) "riscv-iommu: " fmt
 
+#include <linux/acpi.h>
+#include <linux/acpi_rimt.h>
 #include <linux/compiler.h>
 #include <linux/crash_dump.h>
 #include <linux/init.h>
@@ -1651,6 +1653,14 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 		goto err_iodir_off;
 	}
 
+	if (!acpi_disabled) {
+		rc = rimt_iommu_register(iommu->dev);
+		if (rc) {
+			dev_err_probe(iommu->dev, rc, "cannot register iommu with RIMT\n");
+			goto err_remove_sysfs;
+		}
+	}
+
 	rc = iommu_device_register(&iommu->iommu, &riscv_iommu_ops, iommu->dev);
 	if (rc) {
 		dev_err_probe(iommu->dev, rc, "cannot register iommu interface\n");
-- 
2.43.0


