Return-Path: <linux-acpi+bounces-1970-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B47DE7FE6E3
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A1EAB20EF7
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82959134A9
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iHAsBDjE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A12810FD;
	Wed, 29 Nov 2023 17:11:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GESKahWtw+xHbGN+sQu71KsveenbTNe52XJz5ajDxjTPdqDXbUFZqbFbYhCyxt7hzV8eYrscSilb/QXycGI/L8AUlq7xIlD+m7G/sZzP7JuRvyMgJZ2eoxnT5fZoemQtUNfejol96DQ58rT9wRyPUHlR19JqGBFYaLQqYpfDzqMdtbwA+CCE79Eu+ZEY+4foyFX0/pDhDQWnoQnAFeEYhUX/lyCTrljlGX9Xgldggh3534i7deo1F6KaBM8K5VuUeSiUe/6oJ6a1qq+udJDUGtQpD4V/ebdCFAhVU6BbRCxWkvTz488xr/L4oUIq7W9IRRDIcKeR1MkBpDQFumBZ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/4MHf/uztcI2ZbwWSG0abT7rilc4zmCRB6JzHjLkew=;
 b=lxJ4rjt4VUAHC4cgfPbMgW6vv4qx/zjY2cbbk6OSkAdKk74c56sfo3cA3ouXsYjEd0n4PDezqbNW8bygO202TVcbLor5xTrP4ziOvtT2ngrR6hf3lEoEiZ3v5h4k7WoTApd7ud6/X8SkiY51TC62fMaRKWfwrzeFbMpzBWxGwI5xcLym7jXUCRR86eRV7Q7ezrz/F7QETdm3VPWTD2VXCgwERN5D3jYvVMv7VDm2OBjDhp4xorqUTmooho0ANLiTJkSEpMwPJr/vHK2ikfD/XTCc05NlKDY8J9TA650ikJLLOi5ZflVHzPl1PpmWU/LsNAbe8CPHFsjA1339CUzPtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/4MHf/uztcI2ZbwWSG0abT7rilc4zmCRB6JzHjLkew=;
 b=iHAsBDjEocOSjiCmAFZLIsmZLQJbWnOFDlG5bJOsDT/M2us1Qxt3M3b64SrYwtR7jTH2RWeng+D8+WMdRE6YZz5X9BOJck02NtaXEC7GL8q8kmdg5H9tPmuORhSOu2inaOhwTM5OYOit5WwV7UFnXqKqjIpWiHiU11CG4LWyd5qpPifb/yi3A8dlgU3QYgoZgIUVXuOo0S7FsQdzEEs9CmEKHjh5mBIJQh2L8xQLiFg+P6b+p9K/KMY797nHT3AwLe9b0X9KEdy3FOGExDv9/O9V+i5wsticiOuJu8lOSqFAGekdULvSvpN/MRqgzVjQ9qGavpS6XT6YL56K0Cbo5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5484.namprd12.prod.outlook.com (2603:10b6:510:eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 01:10:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:10:55 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: acpica-devel@lists.linux.dev,
	Andy Gross <agross@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Bjorn Andersson <andersson@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	asahi@lists.linux.dev,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	devicetree@vger.kernel.org,
	Frank Rowand <frowand.list@gmail.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	iommu@lists.linux.dev,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	Kees Cook <keescook@chromium.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Hector Martin <marcan@marcan.st>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Clark <robdclark@gmail.com>,
	Robert Moore <robert.moore@intel.com>,
	Rob Herring <robh+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Sven Peter <sven@svenpeter.dev>,
	Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	virtualization@lists.linux.dev,
	Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>,
	Yong Wu <yong.wu@mediatek.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	patches@lists.linux.dev
Subject: [PATCH 16/30] iommu/tegra: Route tegra_dev_iommu_get_stream_id() through an op
Date: Wed, 29 Nov 2023 21:10:23 -0400
Message-ID: <16-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:806:130::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5484:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa0a03f-6310-43d0-24b9-08dbf1412c67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Axh8U+OgK236KJem6Iaft/R29G17WDEEqRxR7Rr4raKiNOFcmS/xiPA8dVUZAVj76ELIGL6kcnCOseDPR4UiT1kKUgsoSOC4Ci/+yaArbMdg9TmUQuobOj2Ih8pr3/h9Ax/NeWCedkAbVRUFtTEU1XKUVmFz0+NGQ8FL/rsr+JAqfvCLkh7sSo7JmDycadl/WBOaqY0I8FTRGoKHlE/IHhOP/GZKRJIpunsrAK61qDtsd6u8I6C6S0a1Np+XZmNjHU4Kw/dRIyIrtVdhwDpy4RS7o9EiM5ApOPJug3osS55yoiRySSDzqu26u0Ps067gA69lOfReRFnqehMydb7B8IPyLJyd5/Xtgessu7FuH1D9qQNTsS3gWaMlh8zl+MhlWoV+/4ILD2ei7gHNYf9z1KuS1DyhccY1stcfsAhiH02+VJuUsJ5rRibvZ6GGafW4UnaDw2XICrn6+P5RymLd7jfaBBZxe6DrD1KzATkwLzsV1SpLXGBBFlR1O3yNMiy50ALFeVBz24aceugfoaA6NylrMcLMtgz6L2WBDTuepoIllsa6hlI58zClhm98ma7TuoYnpU+GHp5Whp4uuAKvaxsEDQPju3YFXuJnZfHolA3htnIKbY/gYLnE+iUBPs6AAmraj4Lsueqzpkn9NSQXCg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1191002)(8936002)(110136005)(8676002)(316002)(66556008)(4326008)(86362001)(66476007)(6486002)(478600001)(66946007)(41300700001)(36756003)(921008)(7416002)(7366002)(2906002)(7406005)(5660300002)(38100700002)(2616005)(6512007)(6506007)(6666004)(83380400001)(26005)(202311291699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z9MsOw3PN68N9nhL4dgg2jPuSd3/ZVUH/tXz8cV6NR04UuOdUsaOzVUKW+Xt?=
 =?us-ascii?Q?1G76h8/g2QWFVoxtqjjKr9+r6yiPYHQojPyMZXVmxOSr8t9dPWxGLIeDwKDE?=
 =?us-ascii?Q?N1fOe+kmtrsFXSAX7LGBUlUfjuONfjzSENrSOEWxSlSU3aclJ48kCZpi4rpH?=
 =?us-ascii?Q?zzIDXgzDhE9KQ1ONfMlAyq48+8+LUfCIH+3muiZvDtLjOLI/6QXxkgZsq1dB?=
 =?us-ascii?Q?9g8R5iuDVAPuYM6u2Mas1oJBQ2X7cFiplz7RWbn7tT2HC0iaVUICBy32qdwe?=
 =?us-ascii?Q?xeZVYikSeNdsoAObiSHZ/+zdfZKrW88pigBkUyPgmg6+sBbsBMSc4MiWETyL?=
 =?us-ascii?Q?qkVgUymaqNiGH73RQsm3kAPCnweJFhRkKaCt1BT2htNw6Gz4CslKV6d+ainY?=
 =?us-ascii?Q?Twi55XIaI7//7g4s6mAj519KVmYNdfjGxvkeyLpnr5zAOK00hm7I9nnd6VRm?=
 =?us-ascii?Q?xkAS/2lqaGLtoTTwCbxz1odrsr/V9b9H6oO1qtCR8UOc3lnTDM0tdoTO6Opd?=
 =?us-ascii?Q?eu/Zj1HOBdDT5pvXJAS8bvP+v04Bt95CqV74q0q5N2yytqpq0RZBCRsu0BAN?=
 =?us-ascii?Q?yrKAWLyX2EQBx68Za8TqsJa9/mDAZR8O3EVP2uoZX6LZi5E98LFzQGqbEq42?=
 =?us-ascii?Q?n6xUq2XIfmtFDWD15PPLv8oZDeEpyTmKt95VBe1LygNebFIs8x6DdhaF4/BD?=
 =?us-ascii?Q?qOl9IAhVQaPMpU97c86daZ7M0SwLSb/euvnqeQ1HkzHFaJrPVYOV67wI3NeI?=
 =?us-ascii?Q?9Z8yetxeer0WHOGY45xV7dzcs94iKD/6YjM99vMf3B5hH9vq0XbbTYQIaCnr?=
 =?us-ascii?Q?jyjieoK9rUNU7bD2cK59l8Nn+rKMqXqwobVzqXyRDAsAeS+usC1xdrOdyKMs?=
 =?us-ascii?Q?35an+g9hHsK9ZP4s44/uDK1OHqxRKSdESCdLHJIi0iwpgTDBzOigJHcsZ+jN?=
 =?us-ascii?Q?VWxoZTtc0jrsZG5H01llvPUbI/jw+kGSmkgSiDanFSaZ8vDYGJqk8GcFFAxY?=
 =?us-ascii?Q?RWt8PIGecyyPibjzvbf+vHcstfUNRUNCIgW0P9RS2wclbN8lJYPU+A6GEKDd?=
 =?us-ascii?Q?JblErW8up5uwItiCHq1OEqKLywMOdimZZ3GVgFrMNiDy6DjR11T4yr0bKW8W?=
 =?us-ascii?Q?D94UdXfhkGI96qc8bTRVOGciDY3ga7QC6jW3LV+DiSdKOxUU642u1IyQ9U3A?=
 =?us-ascii?Q?eKsknh0308zoYqoFXdTZ4E4qEauK9xo9s7aHNbTbrYK2plmO+xLgPHparKPC?=
 =?us-ascii?Q?zN0vv1LVj+JKADIy2iPBaBwT7bvcVuxn25oNi+uJFizdAV23+VlcpARqAnCZ?=
 =?us-ascii?Q?wExQtS++k6OdNgozLHrfoFQJmTVUZ81d1nSWehjmYa5veCfLn1HyriIuUbfG?=
 =?us-ascii?Q?1NZZscgdDilYIK1cWdOVaUR2Iici6Z+vEbKrSHwfuDypFLOeLVZ1GU+VKJSu?=
 =?us-ascii?Q?O73w6svB3sdz3R1wtpF65+rg0QffMLaOQvCF+B5Xf2IVGWWjPFlfnJ9YAz8n?=
 =?us-ascii?Q?YT4sLEA09lafvmmKz7PwZ91uviX/r7D8kq33kwP/F19pIVw2bySsRV+/MlCi?=
 =?us-ascii?Q?QtNAdk2OHopfdalcmvucTYAF+UqilW6FuKlT/f2J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa0a03f-6310-43d0-24b9-08dbf1412c67
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:10:42.4987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: off+h7Q9ytz3pN0OV/1oNmNUkPZa/PPDwqMZoDF0RmPqU8XgV4E0cA/poIxlgnLW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5484

This special function exists because fwspec->ids is intended to be private
to the driver but tegra needs to program the FW ID into registers on the
initiating units. The function allows such units, only for tegra, to get
the IDs they are supposed to program.

The tegra HW that needs this function only supports tegra-smmu and
arm-smmu, so implement the function there.

This makes way to moving the id list into the private memory of the
driver.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 11 +++++++++++
 drivers/iommu/of_iommu.c              | 18 ++++++++++++++++++
 drivers/iommu/tegra-smmu.c            | 11 +++++++++++
 include/linux/iommu.h                 | 21 +++++++--------------
 4 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index adc7937fd8a3a3..02b8dc4f366aa9 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1551,6 +1551,16 @@ static int arm_smmu_def_domain_type(struct device *dev)
 	return 0;
 }
 
+static bool arm_smmu_get_stream_id(struct device *dev, u32 *stream_id)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
+	if (fwspec->num_ids != 1)
+		return false;
+	*stream_id = fwspec->ids[0] & 0xffff;
+	return true;
+}
+
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
@@ -1561,6 +1571,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.def_domain_type	= arm_smmu_def_domain_type,
+	.tegra_dev_iommu_get_stream_id = arm_smmu_get_stream_id,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 	.owner			= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 9c1d398aa2cd9c..8d5495f03dbbcb 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/iommu.h>
 #include <linux/iommu-driver.h>
+#include "iommu-priv.h"
 #include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -281,6 +282,23 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 }
 EXPORT_SYMBOL(of_iommu_get_resv_regions);
 
+#if IS_ENABLED(CONFIG_TEGRA_IOMMU_SMMU) || IS_ENABLED(CONFIG_ARM_SMMU)
+/*
+ * Newer generations of Tegra SoCs require devices' stream IDs to be directly
+ * programmed into some registers. These are always paired with a Tegra SMMU or
+ * ARM SMMU which provides an implementation of this op.
+ */
+bool tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream_id)
+{
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+
+	if (!ops || !ops->tegra_dev_iommu_get_stream_id)
+		return false;
+	return ops->tegra_dev_iommu_get_stream_id(dev, stream_id);
+}
+EXPORT_SYMBOL_GPL(tegra_dev_iommu_get_stream_id);
+#endif
+
 struct parse_info {
 	struct iommu_probe_info *pinf;
 	const struct iommu_ops *ops;
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 310871728ab4b6..cf563db3e3b48d 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -989,6 +989,16 @@ static int tegra_smmu_def_domain_type(struct device *dev)
 	return IOMMU_DOMAIN_IDENTITY;
 }
 
+static bool tegra_smmu_get_stream_id(struct device *dev, u32 *stream_id)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
+	if (fwspec->num_ids != 1)
+		return false;
+	*stream_id = fwspec->ids[0] & 0xffff;
+	return true;
+}
+
 static const struct iommu_ops tegra_smmu_ops = {
 	.identity_domain = &tegra_smmu_identity_domain,
 	.def_domain_type = &tegra_smmu_def_domain_type,
@@ -996,6 +1006,7 @@ static const struct iommu_ops tegra_smmu_ops = {
 	.probe_device = tegra_smmu_probe_device,
 	.device_group = tegra_smmu_device_group,
 	.of_xlate = tegra_smmu_of_xlate,
+	.tegra_dev_iommu_get_stream_id = tegra_smmu_get_stream_id,
 	.pgsize_bitmap = SZ_4K,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= tegra_smmu_attach_dev,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f0aaf55db3c09b..0ba12e0e450705 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -412,6 +412,9 @@ struct iommu_ops {
 	int (*def_domain_type)(struct device *dev);
 	void (*remove_dev_pasid)(struct device *dev, ioasid_t pasid);
 
+	bool (*tegra_dev_iommu_get_stream_id)(struct device *dev,
+					      u32 *stream_id);
+
 	const struct iommu_domain_ops *default_domain_ops;
 	unsigned long pgsize_bitmap;
 	struct module *owner;
@@ -1309,26 +1312,16 @@ static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_m
 
 #endif	/* CONFIG_IOMMU_DMA */
 
-/*
- * Newer generations of Tegra SoCs require devices' stream IDs to be directly programmed into
- * some registers. These are always paired with a Tegra SMMU or ARM SMMU, for which the contents
- * of the struct iommu_fwspec are known. Use this helper to formalize access to these internals.
- */
 #define TEGRA_STREAM_ID_BYPASS 0x7f
 
+#if IS_ENABLED(CONFIG_TEGRA_IOMMU_SMMU) || IS_ENABLED(CONFIG_ARM_SMMU)
+bool tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream_id);
+#else
 static inline bool tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream_id)
 {
-#ifdef CONFIG_IOMMU_API
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-
-	if (fwspec && fwspec->num_ids == 1) {
-		*stream_id = fwspec->ids[0] & 0xffff;
-		return true;
-	}
-#endif
-
 	return false;
 }
+#endif
 
 #ifdef CONFIG_IOMMU_SVA
 static inline void mm_pasid_init(struct mm_struct *mm)
-- 
2.42.0


