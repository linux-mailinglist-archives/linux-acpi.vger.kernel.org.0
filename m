Return-Path: <linux-acpi+bounces-15785-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DB0B298AC
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 06:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 717FA1964A4F
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 04:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB55C269B0D;
	Mon, 18 Aug 2025 04:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="YKomWJQC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800EE267F57
	for <linux-acpi@vger.kernel.org>; Mon, 18 Aug 2025 04:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755493097; cv=none; b=rG6ra9kmHX0eUCf9Oh+jwjbH26pT9ETFYb3ZRD5pH3+luhTvv+e0kpzWWSTRcfR7Bp6oB5xNXKHP9eteuzX9E1YYwrRmNGfydmf+ZbmEo2hCoaMtwowNdiln32AZB/jI7T+NmAKXXavMxDW5feX1DpS9T2VlrRzAA9tWj4fmKCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755493097; c=relaxed/simple;
	bh=uWmg/md3Uur5G0azfupdlm5O0QlvtlmbG7Yvpw9yQX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XzV+aRvGB9JqERGWSa0BUPnexm8NKK/b8kfcuipQ+JUk39OkmKj9EkZ3wKFk+F+Tvr3GyA9t2HyXUTqlJrY6HSyp2dB/MuOqEsaij3FNx6yLoh9EfOwxsMeIF8FTl2dIAm8kwAoH7vOVaH4/rIwMpZtGVQuxO46naXK3xuSEEbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=YKomWJQC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24458272c00so37617375ad.3
        for <linux-acpi@vger.kernel.org>; Sun, 17 Aug 2025 21:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755493096; x=1756097896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E3V/meoXkl+wsGtPedKQJxOsDVawZ6HAz5fY7bg7lxk=;
        b=YKomWJQCVQbP2laEtnHM/dTCuEN2DiNZWbLNLN65ci1VpfgltyDkUeEK2Ts0MkNsXJ
         ai5DC2/086zs1qwo91DTxXW49Hzkmm2pqMo/WmORynKGJWw9ojBR1Ba59TYUVrH5SFcv
         A8++dAdrtxccWkOOVDY/m721gVcAz+/pGW2cLUxXKvb3YGv++MMkqn/LygHey68VPXHd
         j2qm7ZpzkOPB/xJSMyNPQIGWQPb9miVlzWD7uLUg2jnEkHkLo52pP2dxGt7a1o1T2+ks
         I34Us8ziBCRPGJYYlATDnph175iMRN37ZByqAyp2NGIZ7ME//JKhu4CchuV4nWXgak8E
         L4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755493096; x=1756097896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E3V/meoXkl+wsGtPedKQJxOsDVawZ6HAz5fY7bg7lxk=;
        b=prAcl8X6bg9M4hKyZTWxwUWYVSFW08A5b64oGuPqcDVsDavt1r5mdSnJJ8E03ibQes
         o7z2AhBNxr3eNE0PbtFYqphCJIEqAaFiAbpWjN4gJJmwCv8/NMWxe5I7zX6pDw6ipCQO
         j4rlnmaK9LWikdmcyIodRpYy2uIo6p2MOidFkXXibHzlwA1bo6NN9WtAzBtgqJ5VxPRt
         pBag6Ep0InBo14TMzGLbQ6TJIrHkHhLUDS6BUFOYlqjQwGlDQfd2KwtbVB/6ihKHQKu1
         f+rygYxCV4sZe0ZNG2yPxBCBruq03albST7sYWlFUYgSXPXy7eOcuW3Ynu/D0S/KKhJR
         c+dw==
X-Forwarded-Encrypted: i=1; AJvYcCXJIZ+MUbZhR9fnGH8QcEWq6uN1DP1OQ0Qv0z0GEyytN+vTkWotAiqR8CxHyx5/Z9lmF+kAgSg8JsPB@vger.kernel.org
X-Gm-Message-State: AOJu0YyUMdHQeco7bS1efSzG5zE9uzQ4UG9sSbXyEO51sWfJRi97AgWd
	wj6iQRXaOI8xWUdrknsVAv8OEosGKHA55ghU4iwEzonz/0a9Y18Hv1pSLsmIW47w4iQ=
X-Gm-Gg: ASbGncvlY9f+dCYbaoC1BamRvBjrvAoBuz4IvhfCGxqgR5NDSoH34wHfocz9i1Cu7/e
	19YF1Fdm1bNOIHkz2O1crtLLuENucrkjfXoQCqM5EgdQhQ1wSTzlzJHFEA86OPf69R0fBoKy2lq
	LTSHrGZWE4wl33MMhcBAdIa1XbjHSMwgkiVmWpSB3x9svdaD+TLX0wjZBPIbUJJEKFjWj0EW1fc
	H3Vm0+lUhXZSU/iveBcZdEiM1qSfWrpqtDnCDv3Tlsb3t1Q5ayBFvklMMX3BpJ6ndeaWDYCuRrK
	m/EynJgw+9mb4IuIqihAadaXI0dkPEz4BMtK9mim7BopdaBjgo1FEVWTBErnhIdOVNoWZC1kay4
	wOd2Kg5zpDaV32KcJ0KqqpL9bHviVPg==
X-Google-Smtp-Source: AGHT+IFCk2BSwqNgThH6PEkau6i2nlNB+untLX8ay7e+tXj4jOXYDkG8+9f1odmZ7Mh1rjQjGkHVpw==
X-Received: by 2002:a17:903:b07:b0:243:7cf:9bcf with SMTP id d9443c01a7336-2446d71ab96mr143054605ad.2.1755493095547;
        Sun, 17 Aug 2025 21:58:15 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.199.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4528c264sm6124047b3a.43.2025.08.17.21.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:58:14 -0700 (PDT)
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
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v6 0/3] RISC-V: Add ACPI support for IOMMU
Date: Mon, 18 Aug 2025 10:28:04 +0530
Message-ID: <20250818045807.763922-1-sunilvl@ventanamicro.com>
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

Changes since v5:
	1) Rebased to 6.17-rc2
	2) Fixed incorrect id_out assignment (Reported by Xianliang)

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


