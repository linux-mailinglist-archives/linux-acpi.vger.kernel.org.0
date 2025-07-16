Return-Path: <linux-acpi+bounces-15186-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73851B073B1
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 12:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B7D583703
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 10:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1D92F363F;
	Wed, 16 Jul 2025 10:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="h1bCVaSc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2702D2F237D
	for <linux-acpi@vger.kernel.org>; Wed, 16 Jul 2025 10:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752662469; cv=none; b=bm4INkfjlQg6q9nalI8G4n8s54pVkVXROk57jBG9UdBRCRRQ10skmMaCX/nr5LCJ71zKh0g79+EVz2H6Y/blPeaxixtWTrvSTJzzzBiVSi6membB15yl5lt9y4H36S0B+7Dh1/Uj1U0ZdDz4sD3yBMVF6XshwnYQQkKf9lbWKno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752662469; c=relaxed/simple;
	bh=eEuw9YtoJmJDZlsM1s2G9AuMfudEACJhCJfjNjUaCAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cu/p9TvTFpW7CrDjKDOSDlpCbHnYlnmKFnMkscv3eRwJfAOHiPc4m8aHZMetnaKBw18tgdhdZY/G+WUR2PyFi4kWE4OaezNMlBjQzWfsWVtqxKq6ogImNfP+pUzVTw9yss2VkvdzK8HQiNGQoPUI7UVAg2vYXV20ckaTQsIPMe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=h1bCVaSc; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7490acf57b9so4608124b3a.2
        for <linux-acpi@vger.kernel.org>; Wed, 16 Jul 2025 03:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1752662467; x=1753267267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4apPAacfnG+LIip3esQe+tr2nBhJ26sQmQ443HLd2x4=;
        b=h1bCVaScdqJkjG5qBPVc0KNZ3S0I8Snt1dF1vhkuF2VUyClX7bMRCKmHKRL6NgOJMm
         kssvtaiziWy9t5w8UGIeM51Vc/9t0TnXivmKeYAZM/MikqsnxtetHkHeyRQG9FKwctP+
         isLQWf/51m7Y3FsVWWy370GLTncgFJ9x9bdCu3tbd9dPaT+iPaP1ffYGopiDIs4b6ZI2
         /U2UN+j2wZmE9FwPaQGQ6n2BKyS4bf0jY7R6al3wJOePhhsfm/x2tLASXovIR1V1G/Lc
         sCnPI5j5ls2bCtjmtE7uUPLfTAAzHwqJI1U5kW9Y7thHuvmF1+KGPk7Ld++RQbkNSBSf
         UiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752662467; x=1753267267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4apPAacfnG+LIip3esQe+tr2nBhJ26sQmQ443HLd2x4=;
        b=r+Pw/fJaywf3SvODCVaCJ8znBi9rHNpXXcPyP8lBVkBp9L8nbyXFPwBepthhavIjPO
         q0SJvI5m+Ele+8rVV0auvDKVw59962HqyccOhrcucwoVPlHSu+M8gHaAlYCM0nu/cDUO
         kdfg63y1x/XqQXpObkf8EITbRVboz1Z9poUATF/RQAhabwa84rwe6sR4/Pt38bCX7GTo
         9QYxS/yv4pvuPDH7UflYAJK/eugYQnBMhMiUepx6ZAcpvuapbBuhfKcXP/3KkkqC0q2L
         QaozqygqYynOFy5T2/k/GUKP0317C0L04yyWrHxf8M3R09Dy5QsOpPtJe86UwBlViqVp
         JwIw==
X-Forwarded-Encrypted: i=1; AJvYcCVtZ3SAbxukgc/G5lF0E/KBEsrRgTOT0KXkz9vYexrs8NxP0LBR0/lox/GLS3RWu6xcdC/hLDaXI7rB@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/zIJQQkFZb1i9C7380yykwNxB23/GcfSK1M1AUMZABD9Dq1A8
	8mnECyowl3Iurvblz5IGr1p/gucXRdESfIiRUdE8SLlHuRd+vY333hb1zGQzWp+YHRI=
X-Gm-Gg: ASbGncvrp1Q19UJ3IKNH+RwUwNzMt2lf2oeOnjW738tJ2CJUlJEAltZkXBciiqeX/h0
	XsAkQhvapiRm0DQDbPp/hlSRaziRY/SJqWDrBitXjEMAHZElY7Vor0yFRLoncLC0t2FZZkadAbh
	S2NXW+3B6B2HEmTieBXtlx6DHr26Fee2x3PAdsCp7TXmWkTcx8hqMxCWI/sI21E8m4A9vDYPTc4
	3a3W05rt25io5pg2NvBH154yC3qhvYR5uLrWZpTqOe6cwMUCdCT71iThWB1w5snTaHQTeCgA8La
	7wxdP3zvJ9s+n3st21IqmMUHPKAZFhqwCn1N6IdpfQVlxK9N2gCKNntUXHctHwg6H9eLhB0MvzF
	GdTMWhLk/B1chRW6UhPY735zzWXErNH4NrLgtLbJNWO0=
X-Google-Smtp-Source: AGHT+IE3037YRMGIAaI7C47Ttp1jNsxpPaygBpXftTBTzmjePBr4Bv4yntp0VcQZcAzTwEwQx0RJ2A==
X-Received: by 2002:a05:6a00:2e28:b0:748:e1e4:71e7 with SMTP id d2e1a72fcca58-75724872367mr3013646b3a.23.1752662467352;
        Wed, 16 Jul 2025 03:41:07 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.195.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1af40sm13946709b3a.72.2025.07.16.03.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 03:41:06 -0700 (PDT)
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
Subject: [PATCH v5 0/3] RISC-V: Add ACPI support for IOMMU
Date: Wed, 16 Jul 2025 16:10:56 +0530
Message-ID: <20250716104059.3539482-1-sunilvl@ventanamicro.com>
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

Changes since v4:
	1) Rebased to 6.16-rc6
	2) Addressed Anup's feedback on formatting.
	3) Added RB tag from Will and Anup.

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


