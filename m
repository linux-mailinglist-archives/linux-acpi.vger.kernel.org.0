Return-Path: <linux-acpi+bounces-13710-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C95BAB629A
	for <lists+linux-acpi@lfdr.de>; Wed, 14 May 2025 07:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06E5D460DE9
	for <lists+linux-acpi@lfdr.de>; Wed, 14 May 2025 05:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A509B1F4CB3;
	Wed, 14 May 2025 05:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="GYtqIJdm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B152940B
	for <linux-acpi@vger.kernel.org>; Wed, 14 May 2025 05:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747202256; cv=none; b=Vjl2VYiWcNwW8T0caD9/HNsbaPfMB08vD3UGm6gPCDi6Mu5RktrS/pRo7tdtjLV7eTCvTS6810CARBzWuYbPdddJKe3xVVA+SI8WUdHg/hXNCvqiYeoNqCxaooxY73ZfFNm+l6lO1BfxNOZ2QfPo6YxGPBKmJcwiT9zc5TUNLlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747202256; c=relaxed/simple;
	bh=k9d4wVwHo5YZav/2fiCXaibFEPXpZ3HGlFkqOL063qM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SU69DoGj/Db3lyREtqaSkfJnlv7OdbjA+vjnOqH5zjMsbIfP7R3Js7D2TPNDg3dNgBj/KHXMtyGCKbYnQnoFW43xEuD2LBm1a8oAQXFQDP6AAGkyjR332j1FWVQOVmbxz1yMeA+L+PIYigUR/6/afkTzhlSBDYKZe3WiE2mJoQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=GYtqIJdm; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-74068f95d9fso6010936b3a.0
        for <linux-acpi@vger.kernel.org>; Tue, 13 May 2025 22:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1747202254; x=1747807054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u7VBon2ln4fM6kR0PL6UdXDhBglynbmL1e31ZWLd3nM=;
        b=GYtqIJdm+r2Tdrtr0kO2Xd0sNWjRY8u1An6rcEX5i6fhxCvZHe0NzvW7Lbfy7nRxJk
         CS2WUYs1kUUu6NpIg44klitER2Psbxns8V1mGgjP7dpcAi68B1GuMAYkVrfIMYGsVviX
         3vn2sbakLynLhF/Pg+iuM4pvI1cRE2IaxzBK6wJQUrBNgfl82tnOFsXY1JxnMJGQ6b7G
         x/opdskgj1LIQKT3hJYdUkg/ilRPeiRw16N3a0nXqCv8DM7z1LjFmXdQX1BEYcZCfVDi
         7dAa17OJHiyUxMc2sxIy1GF+4duYU9uG6E6nUcputDILgeN4B83CA9/PD8k5tTSnS3vz
         d3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747202254; x=1747807054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7VBon2ln4fM6kR0PL6UdXDhBglynbmL1e31ZWLd3nM=;
        b=Ng/GO4weFW6D9v5KupPf8lejQbW4m0EcpA+yXYDbnJwHgcluG2grDlfwbe/t+PINR9
         qssGmMeTqL6gNTEskF/tJjCGZB71ybrBP003YWMqfmZPzznbOYPQmOu3lLXxjd/T0P3F
         f7GfhNZnWb9/n3EFlBR6bD8sfNTaiCHj3/f1tPJLOALKmZ2GVXDKJ4cSai5d74XPgWA+
         c/50OLw/n3jTwEHItI+xu2fMq6ar10cIqaPeSMb+txQeKGRKJRuWYTlg3yO7pSS4QnL2
         n6yJ4OqplxGNDfrJX4u04CmZkUNXujFoQk6pUlRJ/YZhJXEybMRzOaCaA902V3G61DfQ
         FpOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7lnTRhU2SOzOpbXkqLtQ5mueJ8UIPcpCu0F1gAoDenw/IHtYNl4qCfaMSkLvbZJV8MojGGC9RKxpP@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcsb/aNWI4i2RRCqB9vU6ZY0gHbM/sSPsSCjabzPp0c45wGbxi
	M9MbLCazXHIKnPG8C4oM76RPpsfl2A3N9XSa2o5yeUwp9N7ah9Vd3qcSLMnAqxg=
X-Gm-Gg: ASbGncvUB4iapY18lDQqT960t0+ls01KOgaKsV8lUWc/PzhIiTsO3FYgSphnqbDd9UL
	7kPRtjt4NJhUKW/71Qc9BmWBM5NN6I6T7b1BLFOW/+oVeRjRx4QNrXKr6AvZ9SOwwzaEzPUpsH+
	c7sdPJRQ0nsZF06f2iF/7onoAm/MhOrFxQx+vneJkyTkPCD0lfg0V2pXU/QCMaIjnMq6n30dJet
	dMuo12zsuygODXa5ObRr5EYEkNvytvtSqlnOY02duNh9MoVaHh0FGr/iQu2e7OFVKa94kD+I+wZ
	4UN+1O+/R07Lpx3NhOZqP+AHT3nIxxFyNIwZ5kwD5CSQ7yLnNisc3DOd+FoG/Q==
X-Google-Smtp-Source: AGHT+IHXp/JfgXqigWBcidR4kq8OP+kMXnDiqEfkci8MHcvamvdKxF9wFw2bKIstdi8Xr6ptuIylqQ==
X-Received: by 2002:a17:902:f644:b0:21f:7880:8472 with SMTP id d9443c01a7336-231981c8d93mr39801485ad.35.1747202254322;
        Tue, 13 May 2025 22:57:34 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.196.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc8271c2dsm91721615ad.135.2025.05.13.22.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 22:57:33 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev,
	acpica-devel@lists.linux.dev
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
	Atish Kumar Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 0/4] RISC-V: Add ACPI support for IOMMU
Date: Wed, 14 May 2025 11:27:19 +0530
Message-ID: <20250514055723.1328557-1-sunilvl@ventanamicro.com>
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

The first patch in the series is a ACPICA patch which is already
available in linux-next but included in this series for completeness
only.

[1] - https://github.com/riscv-non-isa/riscv-acpi-rimt/releases/download/v1.0/rimt-spec.pdf

Sunil V L (4):
  ACPICA: actbl2: Add definitions for RIMT
  ACPI: RISC-V: Add support for RIMT
  ACPI: scan: Add support for RISC-V in acpi_iommu_configure_id()
  iommu/riscv: Add ACPI support

 MAINTAINERS                          |   1 +
 arch/riscv/Kconfig                   |   1 +
 drivers/acpi/Kconfig                 |   4 +
 drivers/acpi/riscv/Kconfig           |   8 +
 drivers/acpi/riscv/Makefile          |   1 +
 drivers/acpi/riscv/init.c            |   2 +
 drivers/acpi/riscv/init.h            |   1 +
 drivers/acpi/riscv/rimt.c            | 537 +++++++++++++++++++++++++++
 drivers/acpi/scan.c                  |   9 +-
 drivers/iommu/riscv/iommu-platform.c |  17 +-
 drivers/iommu/riscv/iommu.c          |  10 +
 include/acpi/actbl2.h                |  83 +++++
 include/linux/acpi_rimt.h            |  21 ++
 13 files changed, 692 insertions(+), 3 deletions(-)
 create mode 100644 drivers/acpi/riscv/Kconfig
 create mode 100644 drivers/acpi/riscv/rimt.c
 create mode 100644 include/linux/acpi_rimt.h

-- 
2.43.0


