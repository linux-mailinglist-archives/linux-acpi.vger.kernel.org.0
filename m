Return-Path: <linux-acpi+bounces-6727-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EEB923C95
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 13:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A310B20C8F
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 11:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEF415B12F;
	Tue,  2 Jul 2024 11:41:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C9F153BE3;
	Tue,  2 Jul 2024 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719920465; cv=none; b=rWRzm2MERs/pHH8qVOwmY2VOy3LFwDRHdjJ5c3NXpTkgo34W2/LmG1Msr7mMYP2dKhUuvYBp2ai6Pfg9C1BOlQWewtQP550Km0jx9NQs/z2mn8GdE/8eUXhdeDY7ysBOdi+O7aNTFM/jodB92OQBgpnpbLGaydQJDBlDLXQ4XSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719920465; c=relaxed/simple;
	bh=MazqkPQLGCdEENp3CH5TVyh893tKDOXYUhdGCU9mDSA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=frqE257Q2svs2W/rn7+WtlcWsMBdzDj3apEC/NDnBqtB0kRFVfa/Gqzo198FA4czQErTG2VgJpQ4LFiHFjlDc3j8iPpMWMJzQ7vkvQnQ/rhBPhy65ZUrrtDV8HgJf0MuYcinpGzFRMTLvuifAe/rTMvc1Gts1NbHXyS8KXxQFxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2A88339;
	Tue,  2 Jul 2024 04:41:26 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1E7473F762;
	Tue,  2 Jul 2024 04:40:58 -0700 (PDT)
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
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH v3 0/5] iommu: Remove iommu_fwspec ops
Date: Tue,  2 Jul 2024 12:40:46 +0100
Message-Id: <cover.1719919669.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2: https://lore.kernel.org/linux-iommu/cover.1718994350.git.robin.murphy@arm.com/

Hi all,

Just a quick update with an extra patch to avoid the mediatek-v1 driver
breaking (and I have now build-tested ARCH=arm to make sure, apologies
for being lazy before...)

Thanks,
Robin.


Robin Murphy (5):
  iommu/mediatek-v1: Clean up redundant fwspec checks
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
 drivers/iommu/mtk_iommu_v1.c          | 12 ++-----
 drivers/iommu/of_iommu.c              | 50 ++++++++++-----------------
 drivers/iommu/tegra-smmu.c            |  2 +-
 drivers/of/device.c                   | 30 ++++++----------
 include/acpi/acpi_bus.h               |  3 +-
 include/linux/iommu.h                 | 15 ++------
 12 files changed, 67 insertions(+), 141 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty


