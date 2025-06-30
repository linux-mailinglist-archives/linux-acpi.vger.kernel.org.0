Return-Path: <linux-acpi+bounces-14844-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 162C3AED315
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jun 2025 05:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A13A188D4C8
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jun 2025 03:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5391E25E3;
	Mon, 30 Jun 2025 03:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="S/eNlpek"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4968B19E975
	for <linux-acpi@vger.kernel.org>; Mon, 30 Jun 2025 03:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751255309; cv=none; b=XnqZSwq9XkvGp5N9ck2NRoJ3LwGQZ5WaqGD58U65ul/0Q7EAKuzkdVqRx7Y7KOGAWjGUnpVk3InyEz2ihJ0FKWP5Wsd3M/QC10O5uO8kQQWr9rgbpwTZv4zS/expRqK9hfIJZ4cdxvti2fWIf+DxpZjaDwVEQxrG6Htq0cQyn3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751255309; c=relaxed/simple;
	bh=zBDL8jl2yYKCOKeT2sHBQjAT4aZWYWRMcZe2xu7lPsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aabZo5GuzKjNH2kE2cpwA4YeJRjRJI/F2+rn+4PLB+eJzGJOfh08C2isuHhG7eWCzFJU1Gjofll5r3G2Y7YY+8x9WyQZEBVyYXO2LDl7YkIKl+70aR5ZYa+4BV/9UXGempHbKNpglz97STXQyggNpr1YO2yHCRBAGEuo+rp4fqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=S/eNlpek; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso1398623b3a.2
        for <linux-acpi@vger.kernel.org>; Sun, 29 Jun 2025 20:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751255307; x=1751860107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFQsxLCkN/yrCHNlyEV/dF68pPJedJM8kd/qOCB51Kk=;
        b=S/eNlpekPy0hj6/Z5XwIYAJf6mYX1syJVcYTP60MjttTTDOqqnwiJ7xZgXLG58XTCT
         +V7yQGv/zzbSDHvIe3Y5hySJs0ZMqquBf5jREQ0Exg5utfi/59uO2nG1o3uNWNYyXdwM
         gPaB0zCcpLoPzyTOhcZbOpkDU1THPqN64qArEvfv4Le1RUwAjz6cNYGcjHaqnvBXH1DW
         8w44zKXQPqIakgJqLogb3BPBCcr5xB23cC2zBzxIvol0mxIlYk8CnLdAaQdLQW7oO9kp
         jH57FILayuDEWxkfJc87xMNlvZsCMmuO2j5SeqC1V/ylQ3ogXPdT1xv59tXj0/tKYMLQ
         9+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751255307; x=1751860107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFQsxLCkN/yrCHNlyEV/dF68pPJedJM8kd/qOCB51Kk=;
        b=QklwMqMWoCE+tQZCgphgxG2G+VVJGpx5w5i6s8iNDv+8nG7jh7zq+6SB01fMfQXPnn
         p85AR8PPombBt4StKeO4qfdyyReVzw+B4qLbH5EzkTN53GvuTcUNgpuEXAKsLDWmBsK2
         zRagCB3Ok9q1duE3YDWN1NSyoXRct8M/P3nr7lZtZx2hW77nJ90w1rRKSx6IMxNuKE0a
         udGR0JNWENQiuCCbSzqraYSyLSieTnaZGvd0jmfyLeyMFWE5tVMp86nmxtbR/YGpKKNQ
         4c8fcRU3A+zD7zeJN2tHOfCWDYpMAmiAFJK+M2R+J0/fWZx+DZ47JLbngw2bczB3+1dM
         GmPA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ5Vqnh4dB73/Kw5aTlqzY4eHhoVTcUObItMki7+nVWb4YVHdjARX07TSWW+reP8dsxshzyZ50vGRo@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5lluzTWzzRmAGv4mrs5p9wpB/c3Zy7v6ZMB4LheHqVQV84Vu5
	KFDOvW83KV4X7Px/4ehXi3m65PpOVQuAVV/cU0ZZxak2nD9kKigIlboD1E/I8hXZSv4=
X-Gm-Gg: ASbGncsNry2SS8QKPUUxc68odJ1COJDc80oN5UGCsqutkpWzLY5L6joy6MCN2eRfpJ5
	2rnA+XZtlWD+6YInZWri+6jd3mGryVTMw8yaRrDGHeMtSELKStfskk5LOBLXllpKP+EvFcoPrcX
	O0l/R2Dy0iTjQtNjip18UaRCPmsrIU37MzPd8S2J+36nPLmtKGBccc5mWXFUFwYvT/M50Z2pQIZ
	XCcAg08k7hgC0VvRXdskTr3rwkEP0BrkTRgyQkE3bTLGdSkSPt6u1+cm7lUXupBpYvcyvrHOnFn
	N9F1NFWXzuVO0QBihh/fSlsOe5d9v/6oDRUQLUHP0CP1z38AbWBEON7/OmtbcfGj544MtGxp
X-Google-Smtp-Source: AGHT+IHpHBjPFAAATJQptsjtLS2j6ZPZrkAWrRRMr3WRaNURjmZvw7lQa5uyyPBco66LK582kKThmA==
X-Received: by 2002:a05:6a00:b4b:b0:73d:fa54:afb9 with SMTP id d2e1a72fcca58-74af6eab8cbmr16901576b3a.7.1751255307612;
        Sun, 29 Jun 2025 20:48:27 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.195.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57efaecsm7837862b3a.161.2025.06.29.20.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 20:48:27 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v3 3/3] iommu/riscv: Add ACPI support
Date: Mon, 30 Jun 2025 09:18:03 +0530
Message-ID: <20250630034803.1611262-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630034803.1611262-1-sunilvl@ventanamicro.com>
References: <20250630034803.1611262-1-sunilvl@ventanamicro.com>
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


