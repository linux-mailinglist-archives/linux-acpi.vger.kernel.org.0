Return-Path: <linux-acpi+bounces-15081-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF98AFFCFF
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jul 2025 10:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 506725882A7
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jul 2025 08:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B34628DB49;
	Thu, 10 Jul 2025 08:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="HcuQsPCL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F1328C5A0
	for <linux-acpi@vger.kernel.org>; Thu, 10 Jul 2025 08:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137832; cv=none; b=MPE3P6ClbiH0r393kk344Cc8jMQp0c+WtzMXIpaPPcWljiwnzu5f7iSRC3hvoGQ9qhv/6jRnaTVX97gmPmPsO2wL12CQBtlszuydM+MBHs+H4yRa+HltXF6zK80wECFP4Na8f86QqXUKSNvNGdHkSkigjt4zIYeGa34NK3ufguA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137832; c=relaxed/simple;
	bh=Gv1WJClC1tC4/sg2T2gWmouJ8BsKHIBADGTH0c7EWHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gembFypFoufy/XkE6702zNDXzZj4yJj5+Yu7ek71UkXVkRJsPWfHQ6uIqXnjUzuffr/h5ZZsYfg68R2yvIkG5a7OdqWduFlP8CPEw5KhBTB+r9qrTF/ug4hK6pZdxNrAJz1mZa5w0QoGe1jATbo6IyiE6fIeSzE7O5x9ayRHWKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=HcuQsPCL; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-748feca4a61so491274b3a.3
        for <linux-acpi@vger.kernel.org>; Thu, 10 Jul 2025 01:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1752137830; x=1752742630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tlwOdpvqm2WGBMA6L87u6T1227AEA6wpnUUMMQcTASk=;
        b=HcuQsPCLmZHfUda8h6LyQmzEN3qWUHkwnh8HPBhq6eXWFv6T0X4B3mBZ603xf5Tai7
         rpyyXL92hAgWqff43i8QNhVSAKOsDracXU6ZNeVscwdfIBQ3Xv6oJYofAhWabQ/34fSJ
         zjeqva1t95akf3d+9L2VtkAXMyb32E3BJ8ne4QBD5THd2MixI52lEwW4lOA/OafKthrC
         e4oELqwJSaGhI051GpIUnXFJpowvAB6fA15tfudbV2i+fIFa4oRi7lJ0CW4QplSPFT/w
         BTaBhGypuarKr+9rhB9jDTJlOztDfzsRTbTB0xo6iNn1VwbyVx+AGryyGzyuCtcx0fli
         Jt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752137830; x=1752742630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tlwOdpvqm2WGBMA6L87u6T1227AEA6wpnUUMMQcTASk=;
        b=PQlAc43NdTlF6jUlTrgV6LklBk65W7z1vh9Bxu4Ye6moMo18wZswfmgo217nVZEn/I
         GUfASw0pKVDavGbd/4FZrDuZnTOFDEp8d9msrrIDesPOpmd3aIT5xro9pZ35/1XfAgMd
         lQFEi2ihnqaRrFEbGNxfIAek8LYGUBpiFnNQPoNBwSoKMkwt5Q6zCuvDG/RQYwKOK6bs
         FzoD/7h0QqvGKzwvf5nJfWIymYGt0eaBEfJIdLIS5z5XLlOvxxCXf3PEgsWtbdF4agnk
         d4gwN+2sKC5Kbymm/xtcBdNF+0v63E5M8AOFKRYubyX9WT/I1ocb/AWjPiePodiAKrmn
         Sg0A==
X-Forwarded-Encrypted: i=1; AJvYcCWGjmTiac+RyvAB90LbTM9RptHPi1vAOx8U4P7akkjNhs4Aa9nPJ3c1FPiZ94IfqGGoYqApXW2e/gRT@vger.kernel.org
X-Gm-Message-State: AOJu0YyZp/q9OsI2OkEPiGJXPt88Zer6hcx4cBB/48cVTIKGu6dIPhX5
	dXlCvT2PNmC9SilHwaaVKW8cgYl5eO4C1HOgYgrAcAMT8Bb3TJX7cbKew9BY44abz8ynvFjFOCT
	l3k2+
X-Gm-Gg: ASbGncvCibM3KJ3VFTLUlcUSNkul2pWPaPtgmsMpUGz3gRdINPPdZEtTJw4icTVknNj
	94vpQF4yVSqw6yhVvEXURqPA7UR0OW6G3ive5ZIOOxp0xIWpfJI9qkBYWFg+fm1jiyRtVYdgg4I
	M3FN8U8ga9FWBcuxdXA0F2OFPk0Wf2gtIqX/VvZJw5wbdckdNqWytM5QO/q30hAYskVbpOCSC7h
	Ycbp4ovvS5GgjB3IVsFl+yxZWyLN9j4Skim+cxCbnYx/5Arpqbid/We70OqpfotdMBQCFiOQvH2
	q5ioHFc5CL+88ZuHirMGThK6eZSGtradjEDRfYu9JQ+omYIbcpu8ZIW/x5Ar2+uFEwP5DV7G
X-Google-Smtp-Source: AGHT+IG3AYRQgNXjyXFYNRoL/ZLuNKUvG5hVCj8blaqb5ns3MkUlB3z7gJs1Bhkd61noA6Imw9KgzA==
X-Received: by 2002:a05:6a20:e607:b0:216:1476:f71 with SMTP id adf61e73a8af0-23006851993mr3438087637.39.1752137830282;
        Thu, 10 Jul 2025 01:57:10 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.195.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe52ecdcsm1522323a12.14.2025.07.10.01.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 01:57:09 -0700 (PDT)
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
Subject: [PATCH v4 0/3] RISC-V: Add ACPI support for IOMMU
Date: Thu, 10 Jul 2025 14:26:54 +0530
Message-ID: <20250710085657.2844330-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for RISC-V IOMMU on ACPI based platforms.
RISC-V IO Mapping Table (RIMT) is a new static ACPI table [1] introduced
to communicate IOMMU information to the OS.

[1] - https://github.com/riscv-non-isa/riscv-acpi-rimt/releases/download/v1.0/rimt-spec.pdf

Changes since v3:
	1) Rebased to 6.16-rc5
	2) Addressed Drew's feedback on v3.
		a) Reordered calling rimt_iommu_configure_id().
		b) Removed unnecessary inline.
		c) Added pr_fmt.
		d) Removed redundant rimt_iommu_configure_id() stub.
	3) Added Drew's RB tag in PATCH 3.

Changes since v2:
	1) Rebased to 6.16-rc4
	2) Removed Anup's SOB and link tags added by mistake in v2.

Changes since v1:
	1) Rebased to v6.16-rc1.
	2) Dropped ACPICA patch since it is already available in 6.16-rc1.
	3) Added Rafael's ACK.
	4) Fixed few issues found by bots.

Sunil V L (3):
  ACPI: RISC-V: Add support for RIMT
  ACPI: scan: Add support for RISC-V in acpi_iommu_configure_id()
  iommu/riscv: Add ACPI support

 MAINTAINERS                          |   1 +
 arch/riscv/Kconfig                   |   1 +
 drivers/acpi/Kconfig                 |   4 +
 drivers/acpi/riscv/Kconfig           |   7 +
 drivers/acpi/riscv/Makefile          |   1 +
 drivers/acpi/riscv/init.c            |   2 +
 drivers/acpi/riscv/init.h            |   1 +
 drivers/acpi/riscv/rimt.c            | 520 +++++++++++++++++++++++++++
 drivers/acpi/scan.c                  |   4 +
 drivers/iommu/riscv/iommu-platform.c |  17 +-
 drivers/iommu/riscv/iommu.c          |  10 +
 include/linux/acpi_rimt.h            |  28 ++
 12 files changed, 595 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/riscv/Kconfig
 create mode 100644 drivers/acpi/riscv/rimt.c
 create mode 100644 include/linux/acpi_rimt.h

-- 
2.43.0


