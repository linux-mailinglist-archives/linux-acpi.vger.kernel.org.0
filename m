Return-Path: <linux-acpi+bounces-2545-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF760818E7E
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Dec 2023 18:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E46E1C24879
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Dec 2023 17:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DA2374CF;
	Tue, 19 Dec 2023 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="VYk5jQLL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E68381CD
	for <linux-acpi@vger.kernel.org>; Tue, 19 Dec 2023 17:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d3e6c86868so4410005ad.1
        for <linux-acpi@vger.kernel.org>; Tue, 19 Dec 2023 09:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703007952; x=1703612752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmjC4RdyrxsTphcSUlyn0FA/9YESGtMGM8wLh/XfFs8=;
        b=VYk5jQLLM4AbCuQyveyo78khOaNC9MRdSg+6Dx5b9GxOcudFQ7e7UJJJaklvbLhJnY
         bY3e0algfYGfVnuOZzN6+rEPV3BJ2dMv4ITFO/bMo259fRd4gvzv2evbiomE3p+VL0mi
         qkS5wrT0bn44s7/FLO5cQ3NkS43mVdlsW5aO62DAyjN/tI/bnl0uBiSiGjC19PR4cHyS
         QPQYwzYHxESdkXgQb4APPQ1zW/RFmjylwuF4IAwghlOoYX9MSFCxnjhNAp0UMo6ICWe/
         vqzJZBAh6R5RGgQA7HW5CG9B5IS8SM6UjtYz6NyMcIzTUpxdcgmPKkr06SiKeM/OKO9m
         wG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703007952; x=1703612752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmjC4RdyrxsTphcSUlyn0FA/9YESGtMGM8wLh/XfFs8=;
        b=YEpoqZA6OaWydpS6BcdDFmdWa570/YTnIgAhgakrF18y1XGGyZHJgYyPwXNJasYZAR
         4R8FT6HO2d3Ay+WnVM6vypOvYEAsngFqYcjjEmKbAmgPMqn7byCFccCVF5YvJ6Dt1c97
         ntmFWIAELavJlrQf+Mup9URQkp78XkeqUx2t4vXrQVgEaPpQdLl0XzT9B2q9MbVB8MO+
         ig64zaeKPEXeiWBc1v1XG1JxQGAVZgQeoLXM7XnE0w5OGRUSiY/SSpVnlCDnUhvaTxKe
         I1WIhGeNtRCNrcF/Bj/ouQJ+T/mCa72jb/JtFFMyQkBArtxv+j5csBFPIBu5UBIckrll
         SaBg==
X-Gm-Message-State: AOJu0YwPByuy2FiBfM+vargqWOW5wAqoEq07vZsWcGjnCb6xGHtxiS2h
	9IYwCrLeKzhOJVJW8Jg3y+zaMA==
X-Google-Smtp-Source: AGHT+IGWi2Va1Qi6uqFOhvnkUNZMLVftSlFBeT8Hj5dDFOU/lfjLFJQW6CDFmhglgioUotv/TL88Sg==
X-Received: by 2002:a17:903:32c9:b0:1d3:c201:3bbb with SMTP id i9-20020a17090332c900b001d3c2013bbbmr3333704plr.18.1703007952281;
        Tue, 19 Dec 2023 09:45:52 -0800 (PST)
Received: from sunil-pc.Dlink ([106.51.188.200])
        by smtp.gmail.com with ESMTPSA id n16-20020a170903111000b001d3320f6143sm14453015plh.269.2023.12.19.09.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:45:51 -0800 (PST)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v3 03/17] PCI: Make pci_create_root_bus() declare its reliance on MSI domains
Date: Tue, 19 Dec 2023 23:15:12 +0530
Message-Id: <20231219174526.2235150-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231219174526.2235150-1-sunilvl@ventanamicro.com>
References: <20231219174526.2235150-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to [1], declare this dependency for PCI probe in ACPI based
flow.

This is required especially for RISC-V platforms where MSI controller
can be absent.

[1] - https://lore.kernel.org/all/20210330151145.997953-12-maz@kernel.org/

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/pci/probe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 795534589b98..9e941cf55d87 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3054,6 +3054,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	bridge->sysdata = sysdata;
 	bridge->busnr = bus;
 	bridge->ops = ops;
+	bridge->msi_domain = true;
 
 	error = pci_register_host_bridge(bridge);
 	if (error < 0)
-- 
2.39.2


