Return-Path: <linux-acpi+bounces-1951-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 284B87FE6BF
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85E45B209DD
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085D313FF6
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jkbVXW+I"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3467510A;
	Wed, 29 Nov 2023 17:10:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdZphUtFo5f7+HshrnrVT2ElTpdEX3piZXWQU9e91QuvpueItNGgqWOMQpUufqEOwHs+fna8OP9sRP8P5WZ+r9O30UQySwKq6x5UK/x2PT0HXS0n9GHugj5l7+RHKBVgSh9ZG1OZ4DsJok8AMz1fDhwgAo7aI+EM8sruQCtlE6Zm2upN2fJfh4+Uo5DDbo/GM1dqUrNOTYBeyKwP0HAIpuEaNSu9PSU+jj+MB5EZH+cJ8ZoCHfFWqxsBoKhrWXRqXzAF0bRS2JlHFgwEu85ByaAnHzJ5Y9mAndsuDxMytD+YXovmwbM/zaQAfNNvzjT1RsZRGxJ56T3cwp1Hjeaasw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jd6rraoB++P6AMiBToFZHHrXvI/RmL6YR5zTlW3nQ/A=;
 b=UUV8mbcVuZfDpNwsQYFFY5sVApaQRGkSiBbcM6q6ixW01LgDBoUZ02UQFW5NGlCGXV/3gZkgPIHCqIvgY4M8s6dvjFTN2dgf78dz5TIoQPGQVAW6P1usobX42DXUVOsZsp+0vuOSBw/0JqNRoTIq9pOkCpwMzEb1eEassg2h3XHcSA9V6bHV+od8NIvcAt+mpz4kCpr0u+KQPa7QEpe9zSJhkp+gkZH+VS4fMMVKgA+QBU9OELrcMroMS37DueDGZB/wCAZOU8isAx1vtpoD3kchf6mNrjhVAc9Wdbmswe0njvQqPVcVBxWvGLyHX30PGieugicHjMbasChwc5giGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jd6rraoB++P6AMiBToFZHHrXvI/RmL6YR5zTlW3nQ/A=;
 b=jkbVXW+I36uEb7RpaYsXBgPfJclZ2J1G8rwVEJ6ikOne1prRFU3VT2iVC250MZMhbmrCrw6Ce5i7T7CWazdH5rCepvzoenjVkMZ1KieO8TEEVZJXdVC5FJ/tp0j3JAr0Jeq81CJxn+pP0NJoe9RAhuPdhhpQsIeb/VOpEfmEO0Tom7P6ps5evoRB+SRAcbzLKoWgYTggGI+ctUrCWI+xgT77cHR5wi9eudQbjNrINhxySQ9ioeile8ZtGhMyiRXfjC202+0V8Z7aLFtZnfXzJrJy44DYwPfgYY3FLvbWSY4qvavcO5lsRViHm8uoiaRTvlYXv+Y+RSS4W1pvPvC42A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5484.namprd12.prod.outlook.com (2603:10b6:510:eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 01:10:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:10:44 +0000
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
Subject: [PATCH 01/30] iommu/of: Make a of_iommu_for_each_id()
Date: Wed, 29 Nov 2023 21:10:08 -0400
Message-ID: <1-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR16CA0052.namprd16.prod.outlook.com
 (2603:10b6:805:ca::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5484:EE_
X-MS-Office365-Filtering-Correlation-Id: 761ff352-228f-423a-dff5-08dbf1412b18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dF5RqqeD+DfHp5aKbbhPoFkoVOqcUsijVbfeew9+x8rzSMGkdUAfIzodZB9dX9DJQC2YjhOHU5FTb/CLsxaW2GLnQHMGbujbteTiQwO4yWRWPQu8ZCIYpcw5Cj5ZIYdeVFfxF0Gpqw1L9/Wo0yyaH5LjhTrO23LjRstBHio9BaBnPjaiYcONy30a8S7TGUblkiW8wbatsQQ4603DrkcX22XCY6u+y9jMHL9JiRq/dJPwP0iRY0AZJNTwczM+psAKOZ3dKXwvDnS+5zSnIe/Ah9YjtEBnsWtfAAYbHPjqxPfz4/JLaoBqob6KfOQQjbesYvMkdrtcawRwjHQFhQ2l24XfBDhav0TXLAmy8soT9d5Rpy+rZq4WNcXiDKkQd7+Mzh2KGKI/qH3ax6r84w+IeIyYDsUDIez4JYJJQIHkb9tAJLB6LNub9kPMiT3iynefh6DopagtpkECR1xq/mz9AV6RXBelYJcH/oyfP+rUO9/xrbH39J2RpryZ9TwayPsjOBuKfJzOYmECSx4TWOLPRof2177pk4x6MYPFWq3Xs7gsOHJ+6xpO9RAri85SNJItnaAvupPpan814AWkquC/k/mUNGFyOrbvqqTsI8UV+2VzgsjH7dxaNvWmrklE4IelrqBa5rHBqXJpLlyBPBhqlUCTb+Eld8Yjw3AMe0p6xZ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1191002)(8936002)(110136005)(8676002)(316002)(66556008)(4326008)(86362001)(66476007)(6486002)(478600001)(66946007)(41300700001)(36756003)(921008)(7416002)(7366002)(2906002)(7406005)(5660300002)(38100700002)(2616005)(6512007)(6506007)(6666004)(83380400001)(26005)(202311291699003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7GboM41ZeDYsHWH1VFgz5aZUzKHpZLODWUia5EldzFmgi28B/JSnY3iScioX?=
 =?us-ascii?Q?rcaZQ4o7KDnLsOWE8KhHqZcAGg9Sw2E06FHdf+rzSB80OKICSvHmLSB8Cm6S?=
 =?us-ascii?Q?6o1639PsfP4T09LffkPimgOD9sI2EEITlgNVlTPPJK0b5auWQ0mrT0QbqmBr?=
 =?us-ascii?Q?TG9p3Avlm8I0AkVNX1TjyWqVwIILQweO2TRruY1IPKfDD9MdnfZeC+QOOQ4Q?=
 =?us-ascii?Q?SlhwqJKv8CwR1AFNe32R/D6c/DPxMRr4ymP2qw0N/KnUtHIe6v7WyYaoyMtK?=
 =?us-ascii?Q?tUqA+3y822q5+R3GSbziRyrJIwZ2epxLm1VpzFoHz8OTFm0OZPUsflla7A3n?=
 =?us-ascii?Q?O7wUeHRG/my1yQM1kMJKIOYg9zu9+rgxPn7ZDG61seOhhamy25qADDQ2ddak?=
 =?us-ascii?Q?MeDP4O2+VM//LvTe6Kry2+Flgr9pUYiS53LY/LubMDdQB/iHdEcjQuiYKge7?=
 =?us-ascii?Q?3FGELwEJLxDC/Jj7mhTpdIAgj81AgTrgMX/qzlkV8bjggdNOF0i9+WhTuVu1?=
 =?us-ascii?Q?rki3Ipunz1d1WFQnE+ya5/RDvZZP8D6n4py+f+0sfC0xHPzEa80U1ahyUY5k?=
 =?us-ascii?Q?FW/bG2VwURu7JV1LRQ+X4rVFHZ0evwVlYKdVyoUdI8NmFqIIHecBCZR8NBtE?=
 =?us-ascii?Q?J4IZyPqrTr31RgcvXvQpIGFUJojWfF9Z5Hw+q0Rx57iF0mOgws830Dnfok2M?=
 =?us-ascii?Q?FStUiGm5CSy0CE6pTK3fz3Oqmn5LLkIO1I8k3Fgr/HjUV7fzSzyASgMzwvgW?=
 =?us-ascii?Q?L157sx3b5sJyrXYC5u4jOTuZdljnUyUdao7BbuJzmaBpIycMGYNmmjYqes3g?=
 =?us-ascii?Q?4rEWZN1ceej7UZpnVCO/r5WFkTeMQuvSgdiJeozNvFCdkwAbFK0cQeh8fCa/?=
 =?us-ascii?Q?2l+8IB6nOtUIKFDFAx34Q2SqF8WRzWg964O9Yi+WTea3rSbILkcpVn1uwk69?=
 =?us-ascii?Q?UE7xu0LAMzYOYY80mQt227GDYp6OKo4gL1WEAlXhHOXXODDU9BydRgmZTs5n?=
 =?us-ascii?Q?dGh1fLKQO03BkvGZvsq0TXQWwO9ZaLqLTcvqVQgg2lrZJzAUyl9vI6gURxzu?=
 =?us-ascii?Q?hPYEaja1bCnpynqadlTOSQnUnd3pflUDps2y4qgbI/XPopUpqbmRbRHVjimG?=
 =?us-ascii?Q?WWSH/bs/y6oXrwoaM64i4k10Mghtm6czO03GettDtsJWg2eZRk6q3YByqbhK?=
 =?us-ascii?Q?pGxK7fUtmfJfXMtwR4hwGBJ9TsHrYy0NQahmU7LsSWOAnQNXBaNhsS0nUUhe?=
 =?us-ascii?Q?qMsZ1eAeD89zoFd2Jpqfq8tfWZPrbetvmvnmWMZm2SioKE/R4o+v47rEMS5w?=
 =?us-ascii?Q?l+y56N7SH3YpqGPXt4T8JLMSxsJOodov6cr0cLaKF6MLTEfaAiomRg7aL2pn?=
 =?us-ascii?Q?Wl+KxISHewbjEdnoAgLHTNSGJd4ogpP/je9YepV8Q2rk88dXVpnFY7uPfoLf?=
 =?us-ascii?Q?7vLfM5zvk4W/RcAqTsmh2qO5nWk6Ar1p1V3tyGOL8i+jeoQcs1lBSIHNoj1s?=
 =?us-ascii?Q?wiFaK/7yG7FhgvTkXns5/bum+aM3q/FIqqrJ6stn3AN3IYD4wDQGkkDYt870?=
 =?us-ascii?Q?2myM9mhPICq/6F5VevtnaGDE/ckgAc1viNl3lGlt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761ff352-228f-423a-dff5-08dbf1412b18
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:10:40.2229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AckvpZbtNsA7bKWlureRMMN8ajHkKkPruqCt1LQrkOtA7SIQ09cRozP0XupBMFvX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5484

Take the existing machinery that was wired to invoking of_xlate on each id
through the various maps and aliases and allow it to call a function
pointer with an opaque.

Call of_iommu_xlate() using the existing of_iommu_for_each_id().

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/of_iommu.c | 82 ++++++++++++++++++++++------------------
 1 file changed, 46 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 164317bfb8a81f..3d4580f1fbb378 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -17,9 +17,9 @@
 #include <linux/slab.h>
 #include <linux/fsl/mc.h>
 
-static int of_iommu_xlate(struct device *dev,
-			  struct of_phandle_args *iommu_spec)
+static int of_iommu_xlate(struct of_phandle_args *iommu_spec, void *info)
 {
+	struct device *dev = info;
 	const struct iommu_ops *ops;
 	struct fwnode_handle *fwnode = &iommu_spec->np->fwnode;
 	int ret;
@@ -48,26 +48,27 @@ static int of_iommu_xlate(struct device *dev,
 	return ret;
 }
 
-static int of_iommu_configure_dev_id(struct device_node *master_np,
-				     struct device *dev,
-				     const u32 *id)
+typedef int (*of_for_each_fn)(struct of_phandle_args *args, void *info);
+
+static int __for_each_map_id(struct device_node *master_np, u32 id,
+			     of_for_each_fn fn, void *info)
 {
 	struct of_phandle_args iommu_spec = { .args_count = 1 };
 	int err;
 
-	err = of_map_id(master_np, *id, "iommu-map",
+	err = of_map_id(master_np, id, "iommu-map",
 			 "iommu-map-mask", &iommu_spec.np,
 			 iommu_spec.args);
 	if (err)
 		return err;
 
-	err = of_iommu_xlate(dev, &iommu_spec);
+	err = fn(&iommu_spec, info);
 	of_node_put(iommu_spec.np);
 	return err;
 }
 
-static int of_iommu_configure_dev(struct device_node *master_np,
-				  struct device *dev)
+static int __for_each_iommus(struct device_node *master_np, of_for_each_fn fn,
+			     void *info)
 {
 	struct of_phandle_args iommu_spec;
 	int err = -ENODEV, idx = 0;
@@ -75,7 +76,7 @@ static int of_iommu_configure_dev(struct device_node *master_np,
 	while (!of_parse_phandle_with_args(master_np, "iommus",
 					   "#iommu-cells",
 					   idx, &iommu_spec)) {
-		err = of_iommu_xlate(dev, &iommu_spec);
+		err = fn(&iommu_spec, info);
 		of_node_put(iommu_spec.np);
 		idx++;
 		if (err)
@@ -86,23 +87,46 @@ static int of_iommu_configure_dev(struct device_node *master_np,
 }
 
 struct of_pci_iommu_alias_info {
-	struct device *dev;
 	struct device_node *np;
+	of_for_each_fn fn;
+	void *info;
 };
 
-static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
+static int __for_each_map_pci(struct pci_dev *pdev, u16 alias, void *data)
 {
-	struct of_pci_iommu_alias_info *info = data;
-	u32 input_id = alias;
+	struct of_pci_iommu_alias_info *pci_info = data;
 
-	return of_iommu_configure_dev_id(info->np, info->dev, &input_id);
+	return __for_each_map_id(pci_info->np, alias, pci_info->fn,
+				 pci_info->info);
 }
 
-static int of_iommu_configure_device(struct device_node *master_np,
-				     struct device *dev, const u32 *id)
+static int of_iommu_for_each_id(struct device *dev,
+				struct device_node *master_np, const u32 *id,
+				of_for_each_fn fn, void *info)
 {
-	return (id) ? of_iommu_configure_dev_id(master_np, dev, id) :
-		      of_iommu_configure_dev(master_np, dev);
+	/*
+	 * We don't currently walk up the tree looking for a parent IOMMU.
+	 * See the `Notes:' section of
+	 * Documentation/devicetree/bindings/iommu/iommu.txt
+	 */
+	if (dev_is_pci(dev)) {
+		struct of_pci_iommu_alias_info pci_info = {
+			.np = master_np,
+			.fn = fn,
+			.info = info,
+		};
+
+		/* In PCI mode the ID comes from the RID */
+		if (WARN_ON(id))
+			return -EINVAL;
+
+		return pci_for_each_dma_alias(to_pci_dev(dev),
+					     __for_each_map_pci, &pci_info);
+	}
+
+	if (id)
+		return __for_each_map_id(master_np, *id, fn, info);
+	return __for_each_iommus(master_np, fn, info);
 }
 
 /*
@@ -133,25 +157,11 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		iommu_fwspec_free(dev);
 	}
 
-	/*
-	 * We don't currently walk up the tree looking for a parent IOMMU.
-	 * See the `Notes:' section of
-	 * Documentation/devicetree/bindings/iommu/iommu.txt
-	 */
-	if (dev_is_pci(dev)) {
-		struct of_pci_iommu_alias_info info = {
-			.dev = dev,
-			.np = master_np,
-		};
-
+	if (dev_is_pci(dev))
 		pci_request_acs();
-		err = pci_for_each_dma_alias(to_pci_dev(dev),
-					     of_pci_iommu_init, &info);
-	} else {
-		err = of_iommu_configure_device(master_np, dev, id);
-	}
-	mutex_unlock(&iommu_probe_device_lock);
 
+	err = of_iommu_for_each_id(dev, master_np, id, of_iommu_xlate, dev);
+	mutex_unlock(&iommu_probe_device_lock);
 	if (err == -ENODEV || err == -EPROBE_DEFER)
 		return err;
 	if (err)
-- 
2.42.0


