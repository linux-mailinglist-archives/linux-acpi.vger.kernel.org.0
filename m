Return-Path: <linux-acpi+bounces-14257-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B00BFAD3401
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 12:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B153B425E
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 10:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816AF28BA8B;
	Tue, 10 Jun 2025 10:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="aBInlypV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3412253EB
	for <linux-acpi@vger.kernel.org>; Tue, 10 Jun 2025 10:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749552414; cv=none; b=Xo1y+H7kxHHmi9/JlXxjafzN2M6CteVa7HGnVaXy3moMgMnYZPobhOW8oV70ld02qHpDmPutt1P9QArSiDXEJB3ZeqmayjX8i2AFA1nmkWgsC3BF3ljKOEqG0pSNMmB1P8VoPrD/5j5TvLUcP1wTPjzD/KGUdXlTDzUJBmeHKCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749552414; c=relaxed/simple;
	bh=rFU2UJPmZv4id90emePuWsRP9dfAuwHCWZzl/IU3wDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i5+Om4p6tCNl48N0BQF58Emg43k0ZVCwV6ZJ7O2BGdySMkdoJ6hh1MvA7ech0d4PbWdNlRzLBJ+qv/s2R36DlWRxofaymredXf/CtX0omAC8fDYIs5gag1OCCC3dUgDT4zYY1cJmYg+63p4S9vqUK5guluX/Nbv07/9UBuyQre8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=aBInlypV; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7485bcb8b7cso1029883b3a.1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Jun 2025 03:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1749552412; x=1750157212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h7MV4ZMTiUsINwR8be14xviGNX2303UWr44QeNbdncU=;
        b=aBInlypV6krwWqwYqPhiPDeIv8ArxgQoeKtsZfMW7o1aji+zlQxSt4gIbkuQsKRa5P
         zuXIIi9WjzmYniHWc2ddeYEuyGDGGoDM4flzIXFgTpXcjChNe7F1/Xr7HFSJPGk6qX/v
         zwzVHHX5CFGNWSTqpwdS8cnDtlL7nHKJwxmkH/RF898swbTGW13DtjlNQqiM5f/czn2k
         M6z0xOMsOqvDBNmgHg+Pg53MGDnUxFLftRuUl8S804TPsVtbub9+lzfxzkldGfUF6c9b
         YYfIWOs6qB/V1kJAo9J8y5+VKzZAeeFffacuYwFLlXYuZENesepqQ6cqyh3pXDvAVWmV
         Uqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749552412; x=1750157212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7MV4ZMTiUsINwR8be14xviGNX2303UWr44QeNbdncU=;
        b=FjQpSlcchcKH2FhoorgwnJfEo2xybeK5PU+ZRndfQReWEtMGx21rGZVwlNqnW5wwUB
         ANIqPifsnpAJdSNMc/O4V63dGaMBFozpgC3mXeMYDpd14VoNr5rJWTNyZGwPGEO2rYMG
         8k6x1apR79+XCFwWDaCOkKLaJI6QkxHDoFcmaKeAf/2RgybO19szsyR6cFS/w5te56Yy
         laEH+LxZmRucXY1A6vQ1/2x9cY2ApM2WT0Y7wdXOx4eHV35vseOgo9Bqeojagu9TROeY
         J8Z+fN+f6X9fRtVFzLfIjTjsUQT5C5PccrpBJp1LA3zbh6Wj5VOCv4wlR4Tg1gwxupWb
         +vOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEcgp8rfIqpYqht2gm8LoKuXNYUVhGpLPw1EZXrIutUb2855vx3I0uAeztFh0WIHWJG2cIIwBAVppW@vger.kernel.org
X-Gm-Message-State: AOJu0YwPCFWKClyoRJkE1INRpjwE9fC/aT9v0GlheCAOb27zWfha4w2E
	nunq1AJ10777UXCPzNMUVl9tlzu4nJYPSo743K2FkyVQq1Awv/1Kxu0Kb2Vlewj9dh4=
X-Gm-Gg: ASbGncsbt8yG7OxZ4ElFj5lnR4/9S8gAwXVpzIIW8NazB+b+PSvNLDcSMjWw7cgSNOq
	4KG/YG+DutXCdKT+OuZyLailLfCCFuOeLQf1DLCYttjn3B036/awuilmE0Art23lWRcm0qE0A6N
	e8GPC8QpKwbhgzywhmq7TrZW5X2GDIIo5UQlsZrZGtXD2ulXYziFnO9DEBp2kQ98nXEM1a3NjtH
	qjETsR5rmBmKZZ8CLu1oLpxhNlGXIpEkZihDfeyGTGFiuQv2ZmT9DdftIfovYcNGqalnwiqaCBf
	ZX0RuTBphSBGnWlDne1MIPIlfykJLmaZPq77GVBB/9kSxDRvkxnJX+PtLYEOu1zhYtX/I/KVoWP
	38z3LqY0=
X-Google-Smtp-Source: AGHT+IHiwomQ11rrELOJ2Yf8/Tcge6XeBMEJudTG7v72UH6QPTwRLqU3OkHUxntGY1aE+8OCZaxGTQ==
X-Received: by 2002:a05:6a00:10c2:b0:736:6d4d:ffa6 with SMTP id d2e1a72fcca58-748618a8e87mr2593505b3a.15.1749552412214;
        Tue, 10 Jun 2025 03:46:52 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.196.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0842c0sm7152448b3a.73.2025.06.10.03.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 03:46:51 -0700 (PDT)
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
Subject: [PATCH v2 0/3] RISC-V: Add ACPI support for IOMMU
Date: Tue, 10 Jun 2025 16:16:38 +0530
Message-ID: <20250610104641.700940-1-sunilvl@ventanamicro.com>
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
 drivers/acpi/riscv/rimt.c            | 523 +++++++++++++++++++++++++++
 drivers/acpi/scan.c                  |   9 +-
 drivers/iommu/riscv/iommu-platform.c |  17 +-
 drivers/iommu/riscv/iommu.c          |  10 +
 include/linux/acpi_rimt.h            |  26 ++
 12 files changed, 599 insertions(+), 3 deletions(-)
 create mode 100644 drivers/acpi/riscv/Kconfig
 create mode 100644 drivers/acpi/riscv/rimt.c
 create mode 100644 include/linux/acpi_rimt.h

-- 
2.43.0


