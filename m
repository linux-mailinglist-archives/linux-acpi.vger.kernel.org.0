Return-Path: <linux-acpi+bounces-7162-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09958942A98
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2024 11:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 813E4B24736
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2024 09:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421641AAE2C;
	Wed, 31 Jul 2024 09:33:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC991A7F7B
	for <linux-acpi@vger.kernel.org>; Wed, 31 Jul 2024 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418396; cv=none; b=iZvN9hK/Y9e+WTy2Rtz3KfqQ9nK7P1BXuj0qpCjK9srma6ogaDPQD3WtNoe7TQ3uNJqQBhLbbZYkcGcTGxs8qPaSRXS8crRjaGdvCXVZkmsKktibbbJ3XXhyDz9o0LWCjR/XgoGX7txc2DrJr0fgBe3++DH7KTCO5rrxkn336nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418396; c=relaxed/simple;
	bh=s8M69EafkyAZlI7GT6lfcKGVxfb5YAnU7ExI2BVZIGw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H6MwXQ5LlOXa82+/HoJ0EKc13Rb0aGRPwFWkkXm/tqWBCXyyUulO9yFat1nBRzw9T16etZ6g0VpeD9yZNgcOCMJbRz5M03+wpxerpxbbXb9oNGTVtRY3zA9qA+uOXpVZRfHuARF49/I6vSzIO6E7k5FeLWeYkvAx3Os5fbQ2tpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WYmxC3ym2z28fyP;
	Wed, 31 Jul 2024 17:28:31 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 42430180042;
	Wed, 31 Jul 2024 17:33:05 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 31 Jul 2024 17:33:04 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <will@kernel.org>, <catalin.marinas@arm.com>, <corbet@lwn.net>,
	<lpieralisi@kernel.org>, <guohanjun@huawei.com>, <sudeep.holla@arm.com>,
	<rafael@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>
CC: <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<xuwei5@huawei.com>, <yangyicong@hisilicon.com>, <hejunhao3@huawei.com>,
	<wanghuiqiang@huawei.com>
Subject: [PATCH] ACPI/IORT: Add PMCG platform information for HiSilicon HIP10/11
Date: Wed, 31 Jul 2024 17:26:58 +0800
Message-ID: <20240731092658.11012-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200014.china.huawei.com (7.221.188.8)

From: Yicong Yang <yangyicong@hisilicon.com>

HiSilicon HIP10/11 platforms using the same SMMU PMCG with HIP09
and thus suffers the same erratum. List them in the PMCG platform
information list without introducing a new SMMU PMCG Model.

Update the silicon-errata.rst as well.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 Documentation/arch/arm64/silicon-errata.rst | 4 ++--
 drivers/acpi/arm64/iort.c                   | 7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index bb83c5d8c675..70634e56cedd 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -231,8 +231,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Hisilicon      | Hip08 SMMU PMCG | #162001800      | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
-| Hisilicon      | Hip08 SMMU PMCG | #162001900      | N/A                         |
-|                | Hip09 SMMU PMCG |                 |                             |
+| Hisilicon      | Hip{08,09,10,10C| #162001900      | N/A                         |
+|                | ,11} SMMU PMCG  |                 |                             |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Qualcomm Tech. | Kryo/Falkor v1  | E1003           | QCOM_FALKOR_ERRATUM_1003    |
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 1b39e9ae7ac1..d76197bf350e 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1703,6 +1703,13 @@ static struct acpi_platform_list pmcg_plat_info[] __initdata = {
 	/* HiSilicon Hip09 Platform */
 	{"HISI  ", "HIP09   ", 0, ACPI_SIG_IORT, greater_than_or_equal,
 	 "Erratum #162001900", IORT_SMMU_V3_PMCG_HISI_HIP09},
+	/* HiSilicon Hip10/11 Platform uses the same SMMU IP with Hip09 */
+	{"HISI  ", "HIP10   ", 0, ACPI_SIG_IORT, greater_than_or_equal,
+	 "Erratum #162001900", IORT_SMMU_V3_PMCG_HISI_HIP09},
+	{"HISI  ", "HIP10C  ", 0, ACPI_SIG_IORT, greater_than_or_equal,
+	 "Erratum #162001900", IORT_SMMU_V3_PMCG_HISI_HIP09},
+	{"HISI  ", "HIP11   ", 0, ACPI_SIG_IORT, greater_than_or_equal,
+	 "Erratum #162001900", IORT_SMMU_V3_PMCG_HISI_HIP09},
 	{ }
 };
 
-- 
2.24.0


