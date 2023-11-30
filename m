Return-Path: <linux-acpi+bounces-1954-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 676EC7FE6C3
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D96A9B20EC5
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EA414288
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CN8+7BV7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D415B10CB;
	Wed, 29 Nov 2023 17:10:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjV3rTR3+SA39psoQrZ3kS7cP03e/9qjRlFxkSBeC8e+kiwCpenOl2eoKx8wijlChlBVULb64KGZZTMkHPuWbOIbWnNWMC+kN4RT4YaHvNE0w0y6JWma2awAkc4QlvpluOdhlWhG2h1MgDZeDhErXg/Ya7lyuOPldf5O7qWE/I5TSg90Q5/b/7i+BQvR2z2o1teWEFGI3/t3TC4zymdW7kc29MIjv9BQ08MPxgLD39G5OXGXs94384xux+8uqHJ9m84ya8AScgT06ccVtUqk+u1WQCruAMzvPqFZmMN/Wrteoq6YIv4GIfN8oAxJu8FydsHzJPmZZSkEJ+ujT9O8ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwJ+G8korP3D4LufwIZ/Z16nvSXw1vjgiBys05/mYhQ=;
 b=E4qtsL42FrziqsVoxPf8KU7atR7/UWeVz2+dNMk3qpyMX29dUXDQrWyhaja1xrMM6PDp1BDtTDtXyqgFH+ihqyf+OQCNSzbVdKiZ8LP9VjxiecvPRpohK4rStBWwT7wvRgnf/w9ZAI77GJz2vKyVZKHeMtRMTAxO40Bom2yoxsFEfLZXHrw+Bw46z3HMrvgg+Mv+mb5xeIloH65c6VPFNcn/FW9qyeCxoTrOm9YU8+exf5fJIWsRFHGR/I7O7bgdYIioqSim79J1E/XbELqAObYop+uzGrGdi4kQ9vRPCBPhtg+A27iiQNOJhgvZ25RbXtoABOV7c//jyLUxn0+Wow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwJ+G8korP3D4LufwIZ/Z16nvSXw1vjgiBys05/mYhQ=;
 b=CN8+7BV7GMQRyS4Yh6g7FIO4aRqKaUjMeSM5434CqB5HkuaSUQc+8BaPGMRN0nSzLWfiXuyBHFRY6sN7cEF0oH3hm+M+UcWXUjeUvMqNuSZKiZhgnHYJmrQHnkPgEgXjNKeAnq1Q8N4qYw2FV3fflybi5JUna9j28unf5xurqYRcspaDDZ80oAQb7d32Tz+mPQZ6FsC+aZmYAWP26jX4Qx/vcv+XMBCF9otESqDeMWPsw7Lrn4Sf8uL8lE6cuE8s0okNMAEf5YngS5qaZYvgj9+eairoothKKrZnJjDpYIHEyy4JpOmiBEuiYnsN++Ez4tekK4msNn6cSnZi+nsEHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5484.namprd12.prod.outlook.com (2603:10b6:510:eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 01:10:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:10:46 +0000
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
Subject: [PATCH 26/30] iommu/arm-smmu-v3: Move to iommu_fw_alloc_per_device_ids()
Date: Wed, 29 Nov 2023 21:10:33 -0400
Message-ID: <26-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:805:66::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5484:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d5ace2-3b95-4d23-87a1-08dbf1412b2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	92Xkiy7Ge3EyyeZMq1jHCmrHDof2nfgXnt5krfuyp9sXi5zeS2ZGZyMrV6BODuhKVOxL/AUCDG8k3aP3Q9diTte8jlkNdoNTiQaEQAg1uA5/BzT0l4TrCaV2MkMLSU5bCsDB3Oz8BtjmiY6ToeQJtpjT+YOTO8FW5SnVCUg615BnKNDZBoHvhUF70D5L93CnxfzK1mnAChT1KjyqQHJU6NcloZjQNdI7Zz4W0B6BOIVpK1VVt1sbObC38NKWcahueEozbssTYBNci7B9u0RjxjitSPIxiCypxWTKgNHQJSZ8g70qh2AJn0dWjHpbYzOQJWqk/SRx3BnT3IIixzAHsTKifAShMiXY3nxFT6OicBPkwv38/2jIw+bGZk8Gh8VoPAqa6THx13y9KP3GxVM1Y9Dzqze7kBxN80YpqcT8BOyx+Zq8qhtokRrwuA3Aicz37U2/uMHmqCG06Bj6MqP6JneUuURaUCXBcgVIQgT382RsNifCMTixt+yuCDzwva11J4DFikqxx+pKbo+NeC63iCeUxnJqJuIIP1NwvYUrE62z7QC6kmrU9w5uW1T9PtpUlB+ziRAnilzZrRb9nGhDzmmT3Ck7P9yNIGYCZ4mzrKsLw+3/BnpZzV8gNfejkPvWw1c2yn5WpHJRazxA+uqL6g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1191002)(8936002)(110136005)(8676002)(316002)(66556008)(4326008)(86362001)(66476007)(6486002)(478600001)(66946007)(41300700001)(36756003)(921008)(7416002)(7366002)(2906002)(7406005)(5660300002)(38100700002)(2616005)(6512007)(6506007)(6666004)(83380400001)(26005)(202311291699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sJvPkKnT8OSWWSISjBxvPyOFfkzFZcWpoixVo4xEwL74hOkh8fL0JxMduSr+?=
 =?us-ascii?Q?AvWSIcipMikb42ZUgKnGDZvvDZBR+Ugsinx8GGDY1LACAoRCpOBYFipKMSXv?=
 =?us-ascii?Q?8r+ZfjVFEk9IvOIZkInwyBBzRQdPs2onnnLRZQT/6aKmLbdXmqgcGXfjlLsT?=
 =?us-ascii?Q?eC2DDVCebf0nRYY0/5fOZME9YxM7I9YZ0xF7+GQ1rPAD4qJuNCfB5wOm3UY7?=
 =?us-ascii?Q?4IUQM0Ss1ftMB/8gtpp0dShVgtv3X7p1zQ82a7/2EC8Rz+QQKQfZXAPvUdHz?=
 =?us-ascii?Q?9FAUKJcmIqwyl4b8jNMVLrWFlGxVw+ZDe1pc22HAQ34Uk+mgYPwMeOUEDXEe?=
 =?us-ascii?Q?JqBitoe4N6XDnw1vLSSwbCD+x1XHy4ufGmay8me0gD9x0tdtTicRP6AbVpW7?=
 =?us-ascii?Q?Bd/dFCp2eAS2bjcRiw0OM3I7iY6AK0BbPZ9EuepRBZ9thCy7nHwLm3fCgmQp?=
 =?us-ascii?Q?v1xdAgSU9BbsYQJcUr/sp6QD9j6i1y3LRPZl/PomMsl0NI1XjW7b2qg3voR5?=
 =?us-ascii?Q?Ki22pcY1owZHkJrNfc9u+np6svDjw3Q91BDyh1Sc2RLIcVlL0tKDv+n/TKgy?=
 =?us-ascii?Q?9NN6sGHU5G6SphvazGn0udlfpgyK5ZIMjVe6O3J0mXsBGX3SZeIMDQYoVkDY?=
 =?us-ascii?Q?NN9c2NW67dq0nbq9eKguBuLaB0F7rK2OZ36WCqTNBxbvCqTRSZpDlQ56XBPA?=
 =?us-ascii?Q?B4zsAthR20n9c2ReguPEYgRNJduX94s5PQMF1aECpAPafZhDZYDjh0rnU6l8?=
 =?us-ascii?Q?h6J7Lqa1H6hCVYSZDVYCDxWEz8LRBFq1nBHPDbtZhWcgpBthIAd/6isoxsBx?=
 =?us-ascii?Q?OknvJjkgDZ3MTbf2ZJn8v/Ipos9ft6k3Z6V29yM8BL0tshhVfkuR0lKC4bOA?=
 =?us-ascii?Q?cNXIKMa1j3rJCyogOZFSNrf3QSZ+/3iZoP6e6VMQpH9BYU7cGnfmP6qW6loN?=
 =?us-ascii?Q?phSG78algA7ncihi95VlKwU7WAAgYQoqkwIS/3d2S3V72fDYtYlX6nMaSHvK?=
 =?us-ascii?Q?ZYEZewHnHv4Qw4PKom31Hoz8qQ7zkUoKCd2vZ4F4aZMsfu3p7iFgvRKzRJHF?=
 =?us-ascii?Q?+J7NT1bIqH/222/Nb8UPJ5WnVsrvPszLPtjlSE3e4MHjgSy9uMRsNCIYnhit?=
 =?us-ascii?Q?K70li3C5oqKkgDqlkT6J/MfTRbGfP5hEcCCQR8l13bY+BeQAEEjZ/dM46feM?=
 =?us-ascii?Q?tnYIB3gCheDHlG8/yfYFgGpGxMFqdyCGs+hM2xNjqg9xRkllCTfj80tiSxMC?=
 =?us-ascii?Q?pwIWYsBGQ/6PpXWUS2IK+BALXA6UQNjwSW/WA/lygxzosVeSssxImkZkxWhV?=
 =?us-ascii?Q?dwrd12tS7R6pZHPVu03PT8q9EiVs/eknw/dhTVGTTjT9A04bgz2y24RL2wUX?=
 =?us-ascii?Q?n1KLhmR1IuKdpwA12E7Ap0hcGp+PXF8i1YMEn7HKD3Oj2nvEWWyIT+E1Khqv?=
 =?us-ascii?Q?3DcmFox6rEwkPNbD0vEJZOD0ErHHKRK+eaXaRmOBEEZ6tYddrs4MRiH/LKQs?=
 =?us-ascii?Q?eXA6ogAstefjZux1ay4QWGam54uLgwmZvY/HB33OtAYFNtsZQ2cyJYtIs52n?=
 =?us-ascii?Q?AGmxvsK3I4R+3jWYCkZW8Hi5JEYo2ROcy0q89VgK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d5ace2-3b95-4d23-87a1-08dbf1412b2c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:10:40.4864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4t7oHSiKphoopW92I1Rm+6YwRFEu5JL6Inb7Ybt6vg/SK6SPNORu2XecHKqXHdbE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5484

SMMUv3 supports a single iommu instance with multiple ids.

It has a combined ACPI (via the IORT table) and OF probe path, add
iommu_iort_get_single_iommu() to respresent this.

It already has a per-instance structure, extend it with the ids[]
array and use iommu_fwb_alloc_per_device_ids() to populate it.

Convert the rest of the funcs from calling dev_iommu_fwspec_get() to using
the per-device data and remove all use of fwspec.

Directly call iort_iommu_get_resv_regions() and pass in the internal id
array instead of getting it from the fwspec.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/acpi/arm64/iort.c                   |  2 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 74 +++++++++------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  4 ++
 include/linux/iommu-driver.h                |  2 +-
 4 files changed, 35 insertions(+), 47 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 6b2d50cc9ac180..acd2e48590f37a 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1297,8 +1297,6 @@ static void iort_named_component_init(struct device *dev,
 	props[0] = PROPERTY_ENTRY_U32("pasid-num-bits",
 				      FIELD_GET(ACPI_IORT_NC_PASID_BITS,
 						nc->node_flags));
-	if (nc->node_flags & ACPI_IORT_NC_STALL_SUPPORTED)
-		props[1] = PROPERTY_ENTRY_BOOL("dma-can-stall");
 
 	if (device_create_managed_software_node(dev, props, NULL))
 		dev_warn(dev, "Could not add device properties\n");
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 1855d3892b15f8..1a43c677e2feaf 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -26,9 +26,9 @@
 #include <linux/pci.h>
 #include <linux/pci-ats.h>
 #include <linux/platform_device.h>
+#include <linux/iommu-driver.h>
 
 #include "arm-smmu-v3.h"
-#include "../../dma-iommu.h"
 #include "../../iommu-sva.h"
 
 static bool disable_bypass = true;
@@ -2255,12 +2255,11 @@ static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
 {
 	struct device *dev = master->dev;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
 	if (!(smmu->features & ARM_SMMU_FEAT_ATS))
 		return false;
 
-	if (!(fwspec->flags & IOMMU_FWSPEC_PCI_RC_ATS))
+	if (!master->pci_rc_ats)
 		return false;
 
 	return dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev));
@@ -2382,14 +2381,10 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = 0;
 	unsigned long flags;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_master *master;
 
-	if (!fwspec)
-		return -ENOENT;
-
 	master = dev_iommu_priv_get(dev);
 	smmu = master->smmu;
 
@@ -2529,15 +2524,6 @@ arm_smmu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 
 static struct platform_driver arm_smmu_driver;
 
-static
-struct arm_smmu_device *arm_smmu_get_by_fwnode(struct fwnode_handle *fwnode)
-{
-	struct device *dev = driver_find_device_by_fwnode(&arm_smmu_driver.driver,
-							  fwnode);
-	put_device(dev);
-	return dev ? dev_get_drvdata(dev) : NULL;
-}
-
 static bool arm_smmu_sid_in_range(struct arm_smmu_device *smmu, u32 sid)
 {
 	unsigned long limit = smmu->strtab_cfg.num_l1_ents;
@@ -2568,17 +2554,16 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 	int ret = 0;
 	struct arm_smmu_stream *new_stream, *cur_stream;
 	struct rb_node **new_node, *parent_node = NULL;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
 
-	master->streams = kcalloc(fwspec->num_ids, sizeof(*master->streams),
+	master->streams = kcalloc(master->num_ids, sizeof(*master->streams),
 				  GFP_KERNEL);
 	if (!master->streams)
 		return -ENOMEM;
-	master->num_streams = fwspec->num_ids;
+	master->num_streams = master->num_ids;
 
 	mutex_lock(&smmu->streams_mutex);
-	for (i = 0; i < fwspec->num_ids; i++) {
-		u32 sid = fwspec->ids[i];
+	for (i = 0; i < master->num_ids; i++) {
+		u32 sid = master->ids[i];
 
 		new_stream = &master->streams[i];
 		new_stream->id = sid;
@@ -2627,13 +2612,12 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 {
 	int i;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
 
 	if (!smmu || !master->streams)
 		return;
 
 	mutex_lock(&smmu->streams_mutex);
-	for (i = 0; i < fwspec->num_ids; i++)
+	for (i = 0; i < master->num_ids; i++)
 		rb_erase(&master->streams[i].node, &smmu->streams);
 	mutex_unlock(&smmu->streams_mutex);
 
@@ -2642,26 +2626,27 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 
 static struct iommu_ops arm_smmu_ops;
 
-static struct iommu_device *arm_smmu_probe_device(struct device *dev)
+static struct iommu_device *arm_smmu_probe_device(struct iommu_probe_info *pinf)
 {
 	int ret;
+	struct device *dev = pinf->dev;
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_master *master;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct iort_params params;
 
-	if (WARN_ON_ONCE(dev_iommu_priv_get(dev)))
-		return ERR_PTR(-EBUSY);
+	smmu = iommu_iort_get_single_iommu(pinf, &arm_smmu_ops, &params,
+					   struct arm_smmu_device, iommu);
+	if (IS_ERR(smmu))
+		return ERR_CAST(smmu);
 
-	smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
-	if (!smmu)
-		return ERR_PTR(-ENODEV);
-
-	master = kzalloc(sizeof(*master), GFP_KERNEL);
-	if (!master)
-		return ERR_PTR(-ENOMEM);
+	master = iommu_fw_alloc_per_device_ids(pinf, master);
+	if (IS_ERR(master))
+		return ERR_CAST(master);
 
 	master->dev = dev;
 	master->smmu = smmu;
+	master->pci_rc_ats = params.pci_rc_ats;
+	master->acpi_fwnode = iommu_fw_acpi_fwnode(pinf);
 	INIT_LIST_HEAD(&master->bonds);
 	dev_iommu_priv_set(dev, master);
 
@@ -2670,7 +2655,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 		goto err_free_master;
 
 	device_property_read_u32(dev, "pasid-num-bits", &master->ssid_bits);
-	master->ssid_bits = min(smmu->ssid_bits, master->ssid_bits);
+	master->ssid_bits = min(smmu->ssid_bits,
+				max(params.pasid_num_bits, master->ssid_bits));
 
 	/*
 	 * Note that PASID must be enabled before, and disabled after ATS:
@@ -2687,7 +2673,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 					  CTXDESC_LINEAR_CDMAX);
 
 	if ((smmu->features & ARM_SMMU_FEAT_STALLS &&
-	     device_property_read_bool(dev, "dma-can-stall")) ||
+	     (device_property_read_bool(dev, "dma-can-stall") ||
+	      params.dma_can_stall)) ||
 	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
 		master->stall_enabled = true;
 
@@ -2744,14 +2731,10 @@ static int arm_smmu_enable_nesting(struct iommu_domain *domain)
 	return ret;
 }
 
-static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
-{
-	return iommu_fwspec_add_ids(dev, args->args, 1);
-}
-
 static void arm_smmu_get_resv_regions(struct device *dev,
 				      struct list_head *head)
 {
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct iommu_resv_region *region;
 	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
 
@@ -2762,7 +2745,10 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 
 	list_add_tail(&region->list, head);
 
-	iommu_dma_get_resv_regions(dev, head);
+	if (master->acpi_fwnode)
+		iort_iommu_get_resv_regions(dev, head, master->acpi_fwnode,
+					    master->ids, master->num_ids);
+	of_iommu_get_resv_regions(dev, head);
 }
 
 static int arm_smmu_dev_enable_feature(struct device *dev,
@@ -2851,10 +2837,10 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
-	.probe_device		= arm_smmu_probe_device,
+	.probe_device_pinf	= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
 	.device_group		= arm_smmu_device_group,
-	.of_xlate		= arm_smmu_of_xlate,
+	.of_xlate		= iommu_dummy_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.remove_dev_pasid	= arm_smmu_remove_dev_pasid,
 	.dev_enable_feat	= arm_smmu_dev_enable_feature,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 961205ba86d25d..ac293265b21a13 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -692,6 +692,7 @@ struct arm_smmu_stream {
 struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
 	struct device			*dev;
+	struct fwnode_handle            *acpi_fwnode;
 	struct arm_smmu_domain		*domain;
 	struct list_head		domain_head;
 	struct arm_smmu_stream		*streams;
@@ -702,8 +703,11 @@ struct arm_smmu_master {
 	bool				stall_enabled;
 	bool				sva_enabled;
 	bool				iopf_enabled;
+	bool				pci_rc_ats;
 	struct list_head		bonds;
 	unsigned int			ssid_bits;
+	unsigned int			num_ids;
+	u32				ids[] __counted_by(num_ids);
 };
 
 /* SMMU private data for an IOMMU domain */
diff --git a/include/linux/iommu-driver.h b/include/linux/iommu-driver.h
index c4e133cdef2c78..8f7089d3bb7135 100644
--- a/include/linux/iommu-driver.h
+++ b/include/linux/iommu-driver.h
@@ -252,6 +252,6 @@ __iommu_iort_get_single_iommu(struct iommu_probe_info *pinf,
 						       pinf, ops, params),    \
 					       __iommu_of_get_single_iommu(   \
 						       pinf, ops, -1)),       \
-				 drv_struct, member)                          \
+				 drv_struct, member);                         \
 	})
 #endif
-- 
2.42.0


