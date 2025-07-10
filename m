Return-Path: <linux-acpi+bounces-15084-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E735CAFFD36
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jul 2025 10:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F7293AF13B
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jul 2025 08:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF526290BA2;
	Thu, 10 Jul 2025 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="SMdGDKMe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A2828E604
	for <linux-acpi@vger.kernel.org>; Thu, 10 Jul 2025 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137848; cv=none; b=vBHzqIVrhFoBOgZv8l1QWvLUUJbn7J1whWCgp1H4YoVeugVzVlAVpi5zTJNShWIlVT6ko+dHCgTlhDgiSu3FM6qRCoRALHWTzHxuAj4E89zlVUFHUzCH2vGLZFs76Bz70S+CUsllAa+BO+Tadl7xYMZ66uy21mWL9ZKr0uxAQrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137848; c=relaxed/simple;
	bh=2e7cipO2Wjm9I6n98Mbg+M1DHcoWVB2Xyn33ipE5d9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0WSva659WjO24PnMaUaGIlghQl1UPI2covrXSkgmBckLMIBiJy/04tKC9kdQQg9kBHJm2/MWC+FE7NLGGDuaTr3FHLVkjI4GM0F1+ZIQmzvzllZE4G8GqO/9gyu75WpMJOtyP+ubDSsJuL+wFcceWYXwPfUVcjgfgzvJqYYba8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=SMdGDKMe; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74af4af04fdso1524087b3a.1
        for <linux-acpi@vger.kernel.org>; Thu, 10 Jul 2025 01:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1752137846; x=1752742646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VS7oZDoGeD1L8wjMbt7OByfnbNqci5pMCt79WKJZtII=;
        b=SMdGDKMetW2S4VoRWhfwfsQBIFICn5kepaG5HqFMMa75ZMFzj+V63oTjoQS2pN/HNG
         MWg9BcMvPlddDnpOfVOVXngNk/IxMHxmFMfAnMvDHhzhSJW1nf4tuhM/7iupasDewI+K
         +ff6wJpBbuTq1D69NxoiVRGtaaVJ5DzESCI+G6eBNuKt1P04MVtmM+vGvrYAu6o/ynoG
         QOvM1HYgLX/bRVFEONbNaIDl0dPNITyVB+NiK4Ze0EmdL9zTJ9ylfn1JhmxeqQWp+1Km
         O1f4g2R5Q7KUTs75r9ytp/uiKY0fbqU8JN8NId3PeLq9bUltY1fjR5LQ7y3SaB7oQqcO
         HG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752137846; x=1752742646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VS7oZDoGeD1L8wjMbt7OByfnbNqci5pMCt79WKJZtII=;
        b=Km6QeaLMSNw4r7eqFOAVevEnxpnMiCfn1vQpfE56eJN1VKxsC0eruB4pIErewQ7ooj
         PAg7p31y+pwknOtmg0JclP5PV2wQOwla9RgFyuYLIF5oinDvs/cnZJjnHOZQzchU/afO
         3QmxVnJj9xkk5QCVggnQRW8bVj8VPOdU/kRQzJ94ukTWJ0vqkdhl4zS0EurkSMNQGZ8T
         r1zvjPo/l1FkCCn+Mw+DX9CPAAJ4bhIf/Z4iRvVKvIw4rvpYGpqE711BYAgpAYqz7aTT
         jgWv0CUcCFoHrSc4XXeO7yZYMf/iKcs93Jr+Tjw8HE3VRqauTs2zFz2yi2KSmyL7+aoh
         LNWA==
X-Forwarded-Encrypted: i=1; AJvYcCV00vmpyMZgOJZ8OkkCDnOfiwDrkzdWB7kk9fO8BCnt2Dllt6sx54TEv3slUOmOOW4Ri4X7YWzb15wQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyvquD4YNXzalQEIl7xBAdjUBa8+lxZOa8oRyAdatgojbSMyiJA
	G2amMtEqsvgHcBevJCqbeqqod9+PqewqWNFL7MGa9Ht77UE2lZRI5gkNwMtX7OmqB24=
X-Gm-Gg: ASbGncs0u2kpQ67o1Pj1dAe7r75UPuEOHO8DC/kYj5KKz0W03KEd4C8ip8EP5p4tVSB
	qW8kixAZbTqyIGKXU4xD0cZF8YFuFtkCCv/qHq7eSrvVtguRgg5aXF6kXMsQzrIuF1XBoHjnrnc
	7i18e7BL/NU8Qlq6arwce23N0d9w1sOSh6OOTR8AH+Vs5Za3De0pXAcVG2EXzS5YOX+iLkHOaEB
	zdriL3x0tmiw+JJnY6O2/wdbOH9oQ2YAyQesAUXxE8rNdY+dJzhyffM1OjstSDy/FqjSG5FLySF
	r84P/z4lqhGXa+wvPNcZUQjCvAJqjbhIch9+XFk+j8hQ4RLqmmyYPOGculbul0NsYMsWr983Adr
	vkTyrtvM=
X-Google-Smtp-Source: AGHT+IHUdOd3Xm2iDHKE4tkW13G5yAQLxHKJQpWVcXGjXWDJYkcMmbOblQIeJliUDTeryLpJLtOVqQ==
X-Received: by 2002:a05:6a21:69c:b0:222:c9d0:7aac with SMTP id adf61e73a8af0-22fc4dfafddmr4472974637.15.1752137845826;
        Thu, 10 Jul 2025 01:57:25 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.195.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe52ecdcsm1522323a12.14.2025.07.10.01.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 01:57:25 -0700 (PDT)
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
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v4 3/3] iommu/riscv: Add ACPI support
Date: Thu, 10 Jul 2025 14:26:57 +0530
Message-ID: <20250710085657.2844330-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710085657.2844330-1-sunilvl@ventanamicro.com>
References: <20250710085657.2844330-1-sunilvl@ventanamicro.com>
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
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
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


