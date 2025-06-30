Return-Path: <linux-acpi+bounces-14841-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350EAAED308
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jun 2025 05:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E94A16D1F4
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jun 2025 03:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9564194A44;
	Mon, 30 Jun 2025 03:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="k85nFJXQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB022E403
	for <linux-acpi@vger.kernel.org>; Mon, 30 Jun 2025 03:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751255294; cv=none; b=dY/1gufXdVhY8En94SB7S3Iz1vx2KYNPrl5tUqoCxKiZGZTxLLUkIy/qZrpjL2e3d8BLdtncW0xbL4L+SKr9LB0CBj9xr9uKgGoJerjzaaQ6+hLFEHwEG6Pn7G+/JguceAUBhDAf4JZ8jyljPzER2F20cCuZxFM+JaGU86mq4mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751255294; c=relaxed/simple;
	bh=LBM4mSRpBpLLuf5KUL4CdOdRDoNegAjkYl+r+qplyOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OCHbMF69LrMC9fBNiy9uinz7Fv+MIOKZbv6IJ5/SM2dLL4YzZyG9T/XnDLKwDLPyr8OI16FraP64ukD+EVwo83YrETVnjNfMUdFPmE94GuybnguxcQN7qDfmQ44b4WDWXBP9DzFLCFLw+w3EAn6nWFhcN5cAzh482ZfZJyjphMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=k85nFJXQ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7481600130eso2119874b3a.3
        for <linux-acpi@vger.kernel.org>; Sun, 29 Jun 2025 20:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751255291; x=1751860091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yFeBhYBHOrC/0c43zTo39sGlheeTzLpojcRGicgsOS8=;
        b=k85nFJXQqw9OpJkkpUjRJiY9ByGW7C9hcqMn0usRVc3F/BmQbtn4j/phhDIcp7s6ek
         Ox/ZJ4ICe7Ty+X5q+rbQqOoN/mWPszJnX+dqj/0qH9IXPu8QJx68RSQHbHB5Ng+TrAdL
         CIBvOWXy8Ddd+BL19n6PzkBbz00llTPPeq68j57TppX3ikSGx4lQzWlOnV7uCfEQn6V5
         daCiqaaFmOpvhkz7CqDe1ndxOcKGQx/FZlYGoReEUnBzv7hxYKsSSAKqCiJoqtnM2FH7
         VzndeP7M4esUD7i7eiuao+2fUX0SeXC/Qf0phT3sv522BuunbdU+kH8+UL/xCaKURaFR
         toFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751255291; x=1751860091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFeBhYBHOrC/0c43zTo39sGlheeTzLpojcRGicgsOS8=;
        b=c9dTUSp/AicqJYMEOy+g++bj/Nfn5rGImbj2gQ991jIGCyizCvXoE0P4qip/msRVU8
         dXefOCBduzYFyMPHHgyv3tW0DCO+c3HvKVCJdDe6AHhykwPdsGo+s8heyUbXvaE1oUX6
         0Zi4L/9YrqQ+Q54KKZkjr0TN/Ylja4nxBrmy+gzIzKmM4z89rnKvRriTu/xo2bHMiOJh
         j9Ft3xlJYpy3E1FeeGaEs65kTGNfIoFPkq8KbwRblGJcFEAbvztccNzN0PiS49iYRM3g
         K2YQwmH49f8piz1P5/w+M8fdM7Zt6y+rPZzc/7IQpE5Uw77PO5S5fdEcY+XK3LUVWwn+
         Iq5w==
X-Forwarded-Encrypted: i=1; AJvYcCW+b7QgX43MCYW4g+Fd9PqyC4Auh+CTYOBo7ikkY5jD8Dn2/hMdWENI16A/OjOlrQkyPsQvk+AE9O/Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0K0TADSpUZVzjWE8Zo1RG04ixC2eALwy8DU1MTwFFVnu7POb5
	uNYKRPIfsYdqUWk6OwPqUheLaSBAwGg+tTTaUw8kQQQh1d1N306085TiXXRl4fZ3CrY=
X-Gm-Gg: ASbGncuJQvUIHdq7xa5eytdwwKmtXP4FVFR5NstuE2/EffkqHkCtcY0GfhY0vR+gjZa
	+3wPBbiW5B9tX1umuFKPZnA8294BrSeI6Uc8bjVQrxbAKNXrospga2JTvh7V54yPGYcUzyTkrux
	tbYKSSU3mN6Nr6LxWLoIbJjnrPSg+kvuDJ3JY+uYbUMSVddn4RqA8NIUWYZHZjkGnqxWQJ5doRW
	aD+UpzDEvGwdUM6TF707JIvo5TWpNHhDKyEkj0DlfILe/oabbY0n7l9eXZ8ihVHXA2ZrLH++2+g
	32MYY8NTaebxh79tuDCkqijfIGs/7b81GTXuQ3mdfqDcpBb4iC8z5pFv8Th7r3/pP1JctVhl
X-Google-Smtp-Source: AGHT+IEzTTqz9HI75CbRtfblsCPZ+bl54XYhiD9/Nlz3V+rIBZOaNxNzGv638imyLy83nUUnGEXiUg==
X-Received: by 2002:a05:6a00:3e25:b0:748:2f4e:ab4e with SMTP id d2e1a72fcca58-74af6fcf67emr16315764b3a.11.1751255291494;
        Sun, 29 Jun 2025 20:48:11 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.195.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57efaecsm7837862b3a.161.2025.06.29.20.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 20:48:10 -0700 (PDT)
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
Subject: [PATCH v3 0/3] RISC-V: Add ACPI support for IOMMU
Date: Mon, 30 Jun 2025 09:18:00 +0530
Message-ID: <20250630034803.1611262-1-sunilvl@ventanamicro.com>
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


