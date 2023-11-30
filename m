Return-Path: <linux-acpi+bounces-1963-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D38F7FE6D2
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC3B1C20966
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E361548E
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="doEttS/l"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1D110CB;
	Wed, 29 Nov 2023 17:11:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HORhBOqFrxfTFHe3FuDPVTyBPEWQkdsesYUlMZPPB/PV1+nha7Sx3tZqUEDwqK/RyTn/VvDUfNXbMh4O2Y3MS4q3HAb+CLMQhrGuHubL3GLcAreTh1+iE/3CIrje6cyH65XJ3zvhfE2rKmstu179fGH5CmPzXEhE3Z/3/slbLpTpaz1SyCuD3RThDLXOV8Uwg8i1QYl2jztVJIpSfHMb8Q93HpPF5y0x6FrXqypHabLyDWRPTgWsV6MdDqMuLJolcN9j/nHHZCnMBQ99LNLxvm3RJthe36g9B3XrnJiVBGEfyTveNU2GI3Abx2gqZrhLfk9pcxuPZlOMSU0d3lRlWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1otHA+LIL3W1WZMWhBTV+rqHH68xzfh1OFbgeJsyAew=;
 b=dIzx2Ow2yuwP8iT0OWYVSHQEpkPqxbjqRm2Cn0wg3J13QvBEAJjFA2iaXJK15n612Gm+EMQRd3TY13xWecpUctJHJUm+M+H8o1WjVa1twVae21ulKjyqsm7L8Mf78R0r5+DYnVyypPYpxoEXXRdeEREiHSUnPSt6wapzXeeAcfTrdp77z0m04b1tR5B6kMNrExIYgrHlzz/8ifB892SmyyakxdlK+3IbrnmqoCvmBsB7uSgxZL/4VXV5Rvz5ktR4bcq/ynEMl2LT83B9yRRJ3uzd5B0QCXKs0h4397I4mFfdRk+W8aTXizj+Q9NTqHIhANvbifhfuR0U696EDoMtEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1otHA+LIL3W1WZMWhBTV+rqHH68xzfh1OFbgeJsyAew=;
 b=doEttS/lS7F+WQ093rXr+f1jzMGxAYZ/ZFHsN0NuBff5/S67oZASEaVROX1bTDHL2faxMu9E/W7Fcl7wXUzFw7b0vR8RPM1NimFG94/Qcyo/5TT6PBsvKylYx3MaypZOrZGa0BPQ/MAa9VBM/UErjL4SQtc5fOQ6CpqWlIyjtEbSsQC84neUevIH1P5AaG6wDmplLuAjGbSM363ruUoNCanwqpxK7M67qrfp48EhTwmSrFWklUMvxNJUvG3wgD9UMz9zsxA8f/W4vVQcpbvENRDHvYKW8bY0y7HIqhbF/k1N6290ZmqjZWf+3BsFhWuBv8kmrBp23yNggPQbsA6EkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5484.namprd12.prod.outlook.com (2603:10b6:510:eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 01:10:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:10:52 +0000
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
Subject: [PATCH 02/30] ACPI: VIOT: Make a viot_iommu_for_each_id()
Date: Wed, 29 Nov 2023 21:10:09 -0400
Message-ID: <2-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:805:66::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5484:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b7c2a46-bde1-43ba-de9f-08dbf1412c2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2i71bxGKun33R1DeXVHUpr3CXstj44PRyf0JQC09JOqxra+4rpqi5V/a+/WNw06/dj83EGkjEtD9uRBPznXeSDDkNdiSHgywYfHFohfJfP5b4rz7XPeQjq9TcVX9mDGt1dEHDjb0iasrFInbtiy7uLqrvF3BfAh/nQqbR5aEWR/lmLQoDZEiu3TUE8unhP/ke6+ROgtIBc/402OUrVaT5sn4QOgTnOAOctotEwEkLjyyh3IjWXYFRh+aBAV/94KDX6IUP8AGOGvnVOvMSmj8UWwnH6bZFKZcCddZBBxbb11988ipr7g7OlpVTCplEPjQj2GAyLjdL26mzDwDi7+FqE1dYFb7uZmb0cgcf0Nmd9dcI9FZOjs/qlRwk+m0CQ0XlMVu2WvTh9o4YVkntL2HGmFrNPEK01LJc0rtP/hUGEgdVJuqdhLr6akwU3miEWqKf5QGHKUhvRYdLUBNhVbblfanJ0na3Z/TL4VY9SLfFNvfR6z0I29DRgxucRw+JF1oP8gv1fBVfNUFRWM8qHkySEglkzkqh8mV/m0sg929hf/Rux4IUzNyRAuu4q+WRIzPGBGmIYbFwvAm6le49EmunEZVWerPmJYb+CGZZBkheEqksA/whO/VlZDCoH+wheChpCp9NkzpFNPFDAIG8aJgQaKelX7TxfkNz45ZEVkrcGo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1191002)(8936002)(110136005)(8676002)(316002)(66556008)(4326008)(86362001)(66476007)(6486002)(478600001)(66946007)(41300700001)(36756003)(921008)(7416002)(7366002)(2906002)(7406005)(5660300002)(38100700002)(2616005)(6512007)(6506007)(6666004)(83380400001)(26005)(202311291699003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o93vOzgPifG1P4VbkFhWTGFFahkhlARUTrm73NWNXsXUnTuxLZ6yq8GJaBMt?=
 =?us-ascii?Q?RGwqFGsGLuWRFp2q4YQM+9D6gQ2MePrzhiz3/gU5Tz7/NS2z6BpVbDiAE96w?=
 =?us-ascii?Q?35u0Or/eXUXm7Xzcm66fLtslM1UNp/ABFr1THw/JegH0NWolq9xqMS/B9eKU?=
 =?us-ascii?Q?vF42pJnrTnWuXpMPEh/0ho4iEbriw+9e97QbTc7u9ChjUxcuyWqjOsaNUWM7?=
 =?us-ascii?Q?QkDTq6renXotM9hzoq8AYz079eSg/zH3WlZxVmGM9Q8pTWPOoU7JmBQUMBgb?=
 =?us-ascii?Q?9ScqzzwZEDu8Jb+sOTGlw5v0/SGatkYAof4EaHSJRcLg10NyzoGR5/BxOtZD?=
 =?us-ascii?Q?t5AhVtdK29nbvqsA9/b1YaVDJB+crL7vk9KHdCW5MsJ9BxDv8DBnX7phfHXt?=
 =?us-ascii?Q?U/CP+v8bwACV1XYaqxLdnvrhqHGZeoQjFdTnRZQ9T1AUVFybd0E7i6ZOyPyT?=
 =?us-ascii?Q?Z/lEh9Eww4cvKsifl0XR9CITk+a2HNLdoQoCZXiyddBKcgzN5Fk3TAN1uAnC?=
 =?us-ascii?Q?ZLr/+imCvCuj+GYyja5AMJODWY23umKFYSXk1+k9P2S3E4vWYZ94ORdethA5?=
 =?us-ascii?Q?gzpFfcwui0/4PH8ZV065Ab7oxpqMLEoEMEnM9fVFiwEKLXiBnMZKCBGatPCF?=
 =?us-ascii?Q?iHo5DwA+/dZzYuC79TNgGZV2sdYy8DM9L2HYn8qbFGtwkGfrXOr+6yeMyVrd?=
 =?us-ascii?Q?4RP2ZcgQn1Xos4hD09ifvRxnlNFlfLVTHfcARbXWOKB+58PNw67IoAfRCyJi?=
 =?us-ascii?Q?paIjfyYlP89rG7CAzERtn3z/Zawhmxz+rzvGQ74acndrk5d8IKMcQWk2xBiX?=
 =?us-ascii?Q?RMNQLsfTvGfYfswXq5Eu3m85TH75mJpP6g4me/zdldZWhhnNg0zyBY+PgSd5?=
 =?us-ascii?Q?sMErvND4/es1Mfs5LcrawXiZgf+eGoDU8/e9tekzm9nOLsGPIMnNi3ToMJm8?=
 =?us-ascii?Q?qO1f/LvCu3NM0jAYkwQngplTWjNLO9M+ntuwb3gIGIok4S5qFVjuyorrRSls?=
 =?us-ascii?Q?VeXH++qLaQH1K9ECUvEWvl5wInCKkuVlknqJSXTzpi+BMmQRb0jPIX7Kh4u8?=
 =?us-ascii?Q?6A1cBehBlgFKUSYguRzYsIdXOnl8ZoYgm3YEzhxikhb+z5Q2L5ym33IWUAN7?=
 =?us-ascii?Q?8djx5V7kye2dMNgxdEQ2fDn1ilL0+hzS6iCS4h4wCHOkAogroJvChs/vYvEF?=
 =?us-ascii?Q?osBnG4/9YwZ0D6NcdyPBGV3OgKjxGSG0F8ka1V7wNuImt6rDWS+6o7BOz74Q?=
 =?us-ascii?Q?7kpmKCjTUANR+WtMC8pgtquDAa2sA72tJoDK3u4QNN/4wWok5W4iwD4KbFUP?=
 =?us-ascii?Q?olUV0qqSQAB8+v2fZBNRwpwohOJO/CKMXug58RFtgNjr78jkLMLFFf2k34bc?=
 =?us-ascii?Q?zjUkiG637PQFFk0Di7IA7p8VWD2Yoadii1L+fg/yoDNZKQftOFxt8d+6yMGO?=
 =?us-ascii?Q?FeVLUoXg7W7pfWz8UghOhbZw+BwvmmNayRhwoKZx9VvkzeifYv5vOL7UxN7y?=
 =?us-ascii?Q?kuTl/OFazFw4QI4R9nCU5aDUSB2IjT2XfOsHZEPfShSoSsAv4nhyziF9zCGB?=
 =?us-ascii?Q?M7GJztsQySxonQWwzySNF2zDj+GDqo1w+/1oVIOb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7c2a46-bde1-43ba-de9f-08dbf1412c2b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:10:42.0115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKRdU3xUv0YfjqjwVjOiGYZpIlTC16NPNlmHBn1LiMBDSU/VmIXb/gDGNS0ISUvI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5484

Similar to of_iommu_for_each_id() this parses the VIOT ACPI description
and invokes a function over each entry in the table.

Have viot_iommu_configure() use the new function to call
viot_dev_iommu_init().

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/acpi/viot.c       | 54 +++++++++++++++++++++++----------------
 include/linux/acpi_viot.h | 11 ++++++++
 2 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
index c8025921c129b2..7ab35ef05c84e0 100644
--- a/drivers/acpi/viot.c
+++ b/drivers/acpi/viot.c
@@ -25,13 +25,6 @@
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 
-struct viot_iommu {
-	/* Node offset within the table */
-	unsigned int			offset;
-	struct fwnode_handle		*fwnode;
-	struct list_head		list;
-};
-
 struct viot_endpoint {
 	union {
 		/* PCI range */
@@ -304,10 +297,10 @@ void __init acpi_viot_init(void)
 	acpi_put_table(hdr);
 }
 
-static int viot_dev_iommu_init(struct device *dev, struct viot_iommu *viommu,
-			       u32 epid)
+static int viot_dev_iommu_init(struct viot_iommu *viommu, u32 epid, void *info)
 {
 	const struct iommu_ops *ops;
+	struct device *dev = info;
 
 	if (!viommu)
 		return -ENODEV;
@@ -324,11 +317,17 @@ static int viot_dev_iommu_init(struct device *dev, struct viot_iommu *viommu,
 	return acpi_iommu_fwspec_init(dev, epid, viommu->fwnode, ops);
 }
 
-static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
+struct viot_pci_iommu_alias_info {
+	struct device *dev;
+	viot_for_each_fn fn;
+	void *info;
+};
+
+static int __for_each_pci_alias(struct pci_dev *pdev, u16 dev_id, void *data)
 {
 	u32 epid;
 	struct viot_endpoint *ep;
-	struct device *aliased_dev = data;
+	struct viot_pci_iommu_alias_info *info = data;
 	u32 domain_nr = pci_domain_nr(pdev->bus);
 
 	list_for_each_entry(ep, &viot_pci_ranges, list) {
@@ -339,14 +338,14 @@ static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
 			epid = ((domain_nr - ep->segment_start) << 16) +
 				dev_id - ep->bdf_start + ep->endpoint_id;
 
-			return viot_dev_iommu_init(aliased_dev, ep->viommu,
-						   epid);
+			return info->fn(ep->viommu, epid, info->info);
 		}
 	}
 	return -ENODEV;
 }
 
-static int viot_mmio_dev_iommu_init(struct platform_device *pdev)
+static int __for_each_platform(struct platform_device *pdev,
+			       viot_for_each_fn fn, void *info)
 {
 	struct resource *mem;
 	struct viot_endpoint *ep;
@@ -357,12 +356,28 @@ static int viot_mmio_dev_iommu_init(struct platform_device *pdev)
 
 	list_for_each_entry(ep, &viot_mmio_endpoints, list) {
 		if (ep->address == mem->start)
-			return viot_dev_iommu_init(&pdev->dev, ep->viommu,
-						   ep->endpoint_id);
+			return fn(ep->viommu, ep->endpoint_id, info);
 	}
 	return -ENODEV;
 }
 
+int viot_iommu_for_each_id(struct device *dev, viot_for_each_fn fn, void *info)
+{
+	if (dev_is_pci(dev)) {
+		struct viot_pci_iommu_alias_info pci_info = {
+			.dev = dev,
+			.fn = fn,
+			.info = info,
+		};
+		return pci_for_each_dma_alias(to_pci_dev(dev),
+					      __for_each_pci_alias, &pci_info);
+	}
+
+	if (dev_is_platform(dev))
+		return __for_each_platform(to_platform_device(dev), fn, info);
+	return -ENODEV;
+}
+
 /**
  * viot_iommu_configure - Setup IOMMU ops for an endpoint described by VIOT
  * @dev: the endpoint
@@ -371,10 +386,5 @@ static int viot_mmio_dev_iommu_init(struct platform_device *pdev)
  */
 int viot_iommu_configure(struct device *dev)
 {
-	if (dev_is_pci(dev))
-		return pci_for_each_dma_alias(to_pci_dev(dev),
-					      viot_pci_dev_iommu_init, dev);
-	else if (dev_is_platform(dev))
-		return viot_mmio_dev_iommu_init(to_platform_device(dev));
-	return -ENODEV;
+	return viot_iommu_for_each_id(dev, viot_dev_iommu_init, dev);
 }
diff --git a/include/linux/acpi_viot.h b/include/linux/acpi_viot.h
index a5a12243156377..fce4eefcae4aad 100644
--- a/include/linux/acpi_viot.h
+++ b/include/linux/acpi_viot.h
@@ -5,6 +5,17 @@
 
 #include <linux/acpi.h>
 
+struct viot_iommu {
+	/* Node offset within the table */
+	unsigned int			offset;
+	struct fwnode_handle		*fwnode;
+	struct list_head		list;
+};
+
+typedef int (*viot_for_each_fn)(struct viot_iommu *viommu, u32 epid,
+				void *info);
+int viot_iommu_for_each_id(struct device *dev, viot_for_each_fn fn, void *info);
+
 #ifdef CONFIG_ACPI_VIOT
 void __init acpi_viot_early_init(void);
 void __init acpi_viot_init(void);
-- 
2.42.0


