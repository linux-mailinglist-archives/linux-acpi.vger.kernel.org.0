Return-Path: <linux-acpi+bounces-9934-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2109E4BDA
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 02:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE57285247
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 01:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77432482ED;
	Thu,  5 Dec 2024 01:33:45 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2235D47A73
	for <linux-acpi@vger.kernel.org>; Thu,  5 Dec 2024 01:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733362425; cv=none; b=hzUvxgrQzOoFKzgBrBQXusVrZQV44qp0hO1vZHOYVNMxho9hIOoILOI3MW26VSn3geyy7erR6EUwBuhx5XQLuiX+KIja0xQl+Dlg430fv51c9x8eWxW8NdNfGuWsCBpwB8b3RxowgNeig4C3hzi5FfOh0dJIa2una6Ay1fWAqSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733362425; c=relaxed/simple;
	bh=2U89hio9pBpr1NuEmBFP1ej6/Jf5a1pxWhVBe99HR+M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G9FoOBbRxyK/rb9TZvQaS+Mgj+/fUjJOXR4MuODqa+UVfsNkCYVHLZfsism6F1DAETvVIZRV2Ul8Jia1qOu1zBMFarP+HyjlD4QE5e9YlmTAbvh2kF/zb3dEmXGge16m8ptQ7ZhftDypfi61YgEzbYVy7pqYByDDZozzKAoR8I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Y3cNs1XkRz1yrY2;
	Thu,  5 Dec 2024 09:33:49 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 72AB21A016C;
	Thu,  5 Dec 2024 09:33:33 +0800 (CST)
Received: from localhost.huawei.com (10.90.30.45) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 5 Dec 2024 09:33:32 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <guohanjun@huawei.com>, <lpieralisi@kernel.org>, <sudeep.holla@arm.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <fanghao11@huawei.com>, <prime.zeng@hisilicon.com>,
	<yangyicong@huawei.com>, <linuxarm@huawei.com>, <xiaqinxin@huawei.com>
Subject: [PATCH v2] ACPI/IORT: Add PMCG platform information for HiSilicon HIP09A
Date: Thu, 5 Dec 2024 09:33:31 +0800
Message-ID: <20241205013331.1484017-1-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemj200003.china.huawei.com (7.202.194.15)

HiSilicon HIP09A platforms using the same SMMU PMCG with HIP09
and thus suffers the same erratum. List them in the PMCG platform
information list without introducing a new SMMU PMCG Model.

Update the silicon-errata.rst as well.

Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>
Acked-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>

---

Changes since V1:
- Change the description of PMCG HIP09x to HIP09A in silicon-errata.rst
- Link: https://lore.kernel.org/linux-arm-kernel/4ac9e057-725c-a0ae-e2db-612ea359bec1@huawei.com/T/#mf90dd6937b2aee3895a1b2cc9d0ec8a6061e5c8a

Documentation/arch/arm64/silicon-errata.rst | 5 +++--
drivers/acpi/arm64/iort.c                   | 2 ++
2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index 77db10e944f0..b42fea07c5ce 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -255,8 +255,9 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Hisilicon      | Hip08 SMMU PMCG | #162001800      | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
-| Hisilicon      | Hip{08,09,10,10C| #162001900      | N/A                         |
-|                | ,11} SMMU PMCG  |                 |                             |
+| Hisilicon      | Hip{08,09,09A,10| #162001900      | N/A                         |
+|                | ,10C,11}        |                 |                             |
+|                | SMMU PMCG       |                 |                             |
 +----------------+-----------------+-----------------+-----------------------------+
 | Hisilicon      | Hip09           | #162100801      | HISILICON_ERRATUM_162100801 |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 1f7e4c691d9e..98759d6199d3 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1716,6 +1716,8 @@ static struct acpi_platform_list pmcg_plat_info[] __initdata = {
 	/* HiSilicon Hip09 Platform */
 	{"HISI  ", "HIP09   ", 0, ACPI_SIG_IORT, greater_than_or_equal,
 	 "Erratum #162001900", IORT_SMMU_V3_PMCG_HISI_HIP09},
+	{"HISI  ", "HIP09A  ", 0, ACPI_SIG_IORT, greater_than_or_equal,
+	 "Erratum #162001900", IORT_SMMU_V3_PMCG_HISI_HIP09},
 	/* HiSilicon Hip10/11 Platform uses the same SMMU IP with Hip09 */
 	{"HISI  ", "HIP10   ", 0, ACPI_SIG_IORT, greater_than_or_equal,
 	 "Erratum #162001900", IORT_SMMU_V3_PMCG_HISI_HIP09},
-- 
2.33.0


