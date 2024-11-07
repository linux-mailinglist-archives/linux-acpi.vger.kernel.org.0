Return-Path: <linux-acpi+bounces-9415-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 610169C0155
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 10:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127861F22EC1
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 09:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33791E32A0;
	Thu,  7 Nov 2024 09:40:45 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08B2196D8F
	for <linux-acpi@vger.kernel.org>; Thu,  7 Nov 2024 09:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730972445; cv=none; b=tnGfrwDSEli8aD/+h3K8Vg2Vd/qubOZLTWDM5jBPQBXvrtLojifKywnZ4NijLTIgfZ2r351ncQFnhhX1m7d5x3DbcOOAa69JjJFmu7lPF4CGmiwy3jmMrh2MTVQfF1Sb3YlhDWM+L3Lp/+rxjbxDjYqgVbQsjNQEH/7sjs2fRNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730972445; c=relaxed/simple;
	bh=WVAH2tXQNEvSInMbyZ1jEZnC+Ej1AW28DuIC5ch3kXA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cDTyWMvwImyh2zBUSBry/SRmqY6OSNl8DCQcCX8S8ec+N+N5MlNN7flghKnHLKg7kowZb7yur5xQbWIK8Qdiqm7AS5BPA3tIOxXmOHHb4YcAiY9/jSa1mHEwnazAXZTWCcxnGS8mYnBQbIPlZwyo3baEDcqKNpQm7qVja+32xqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XkcTW4cHKz1jwTv;
	Thu,  7 Nov 2024 17:38:55 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id B84131401E9;
	Thu,  7 Nov 2024 17:40:37 +0800 (CST)
Received: from localhost.huawei.com (10.90.30.45) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 Nov 2024 17:40:37 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <lpieralisi@kernel.org>, <guohanjun@huawei.com>, <sudeep.holla@arm.com>
CC: <linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<fanghao11@huawei.com>, <prime.zeng@hisilicon.com>, <yangyicong@huawei.com>,
	<linuxarm@huawei.com>, <xiaqinxin@huawei.com>
Subject: [PATCH] ACPI/IORT: Add PMCG platform information for HiSilicon HIP09A
Date: Thu, 7 Nov 2024 17:40:36 +0800
Message-ID: <20241107094036.2398983-1-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemj200003.china.huawei.com (7.202.194.15)

HiSilicon HIP09A platforms using the same SMMU PMCG with HIP09
and thus suffers the same erratum. List them in the PMCG platform
information list without introducing a new SMMU PMCG Model.

Update the silicon-errata.rst as well.

Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 Documentation/arch/arm64/silicon-errata.rst | 4 ++--
 drivers/acpi/arm64/iort.c                   | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index 65bfab1b1861..b21c0b1ed567 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -255,8 +255,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Hisilicon      | Hip08 SMMU PMCG | #162001800      | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
-| Hisilicon      | Hip{08,09,10,10C| #162001900      | N/A                         |
-|                | ,11} SMMU PMCG  |                 |                             |
+| Hisilicon      | Hip{08,09x,10x, | #162001900      | N/A                         |
+|                | 11} SMMU PMCG   |                 |                             |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Qualcomm Tech. | Kryo/Falkor v1  | E1003           | QCOM_FALKOR_ERRATUM_1003    |
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 4c745a26226b..bf3be532e089 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1703,6 +1703,8 @@ static struct acpi_platform_list pmcg_plat_info[] __initdata = {
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


