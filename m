Return-Path: <linux-acpi+bounces-6575-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A02912D6B
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jun 2024 20:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D25DB21112
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jun 2024 18:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0635717B42F;
	Fri, 21 Jun 2024 18:47:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2E2160884;
	Fri, 21 Jun 2024 18:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995619; cv=none; b=O1rPGVRBklRniAsmi4kEsVwB6TcSF4ungxIiInX/P2520MmTTt+Heh7pkOoedgaCWmChgb32sDHHf6EegvkBsynqaqrQ57LvUE8tzNcjRNh1rHvwK8eIscAJGUNvI3VeD4guY3TF4Ji0uvrxXH8f0+T60qRGiAUmYCr6wmYS9mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995619; c=relaxed/simple;
	bh=dGT4dgbECCSETLnU6P1PQ+5vhuty449UEm/lYZBGr6I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SQJ6Z2b4p0gGakELZENbWmWcj6MYR5P2jli8W6FkD8Aq036gz5yHHO5PWp6tZVqUC5xVoeVMEgeiU4K10x+spjZlKgO13RkL+NndilwgU8egsbPoccdgSyQ08PyDrd2f9m8WugYs7t+m/R8abEk/aAWvwYmbyPxmsCMOJm+m4EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 632E4DA7;
	Fri, 21 Jun 2024 11:47:20 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 34B373F6A8;
	Fri, 21 Jun 2024 11:46:53 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>
Cc: linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 0/4] iommu: Remove iommu_fwspec ops
Date: Fri, 21 Jun 2024 19:46:35 +0100
Message-Id: <cover.1718994350.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/linux-iommu/cover.1713523251.git.robin.murphy@arm.com

Hi all,

Here's v2 of this little cleanup, with acks and the additional cosmetic
tweak suggested by Andy. There were some slightly non-trivial changes in
the rebase so I've left off Jean-Philippe's tested-by from v1, but I've
given it a quick spin on arm64 ACPI and DT and all seems well still.

Thanks,
Robin.


Robin Murphy (4):
  iommu: Resolve fwspec ops automatically
  ACPI: Retire acpi_iommu_fwspec_ops()
  OF: Simplify of_iommu_configure()
  iommu: Remove iommu_fwspec ops

 drivers/acpi/arm64/iort.c             | 19 +++-------
 drivers/acpi/scan.c                   | 36 +++++--------------
 drivers/acpi/viot.c                   | 11 ++----
 drivers/iommu/arm/arm-smmu/arm-smmu.c |  3 +-
 drivers/iommu/iommu-priv.h            |  7 ++++
 drivers/iommu/iommu.c                 | 20 +++++------
 drivers/iommu/mtk_iommu_v1.c          |  2 +-
 drivers/iommu/of_iommu.c              | 50 ++++++++++-----------------
 drivers/iommu/tegra-smmu.c            |  2 +-
 drivers/of/device.c                   | 30 ++++++----------
 include/acpi/acpi_bus.h               |  3 +-
 include/linux/iommu.h                 | 15 ++------
 12 files changed, 65 insertions(+), 133 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty


