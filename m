Return-Path: <linux-acpi+bounces-1962-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E418F7FE6CE
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F1E9B20A31
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C979715485
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RPbLdFCJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9A8D7F;
	Wed, 29 Nov 2023 17:10:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXFEYKsOQXGSHNx/lvA5mDO//TOdy7bfcifppRBhtOk3lMlTDZXyLuLUyQOM0sInG48Z1OH8gbAkvmd60w3QitMNrobafMPtoRw0PPwpX4p33zTo8QxaXbEFi226AxFq/kiv4luxEAOZ4WkOd3jIlFMZJRUwn6/Q9ULPtirlOCof6oPb9P4kHsFc9+RL4YDUCWA8Qytcrwyfkf+/bxw3LffLrYW7fYBK5qJS+ZlkZK95hhwxEj1a+jHXEjXfZ6DIsBEfMvpMUNw+xSPNslmMfFCAAZwDhTcyDmi71Ys1Ofz5o0T1N7M1xB4S/y+IlUY9gmEOEDre/Hwm5tX2eIHDdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeNlyomNkLn0vDrMhnXRZEG4tXI6kjRAm58pilBJJWY=;
 b=J9v0skXnxpK9wrcH0+M+LX/agrU7B+TBYzOCgWwnrkMPJ2GSxp1CeR90bsQSa63Laebo8gZpo36vDmvI8FS1C0ZMfyc7zcLPSZV4nEfBW7HRuIN83wHvlx+QXgOpXWEQXAjcAugw8q+hLl6mkhYMKUmzmiC69zBv/UYCiDpIRasdfpqolxiE6i8zF9++cvyiDZfBg7T1q7q3F8cCwRKpDjsz2jwWKXoJ75G8TzFy/izBfNPP56tXwAHjDpjJDP/lILvMdDmNqnY7Ucz2XdM+OBVu1/cFv5lfbJf9hxhjtQxShGfD6sBSkvkrQP2/wQRVkewrz8sEbJJ9T1PWnVEhWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeNlyomNkLn0vDrMhnXRZEG4tXI6kjRAm58pilBJJWY=;
 b=RPbLdFCJzmrVks0WTIxkHSvZFDRokh9D3A7VdSiGc2sYySwYag6Kfpx6OI7CAo3CqIn6jXsG21Y8YRvyXFy+tdLhxLrOHdwOttpmFN2k3hgwf4gmYYCzFHkgR6cMhMkJb4lZjoNRvphOb5NpNAC83xrXtFPs6WphKkcWll8pTgm1KKuquyWYvBVWG4e234AsGUGQ1Sq+wrQlXJhmeWlU+bzrrzkbiydliXllW2XLkRA35Ukrffo3A6F7mna9xp8ko5K3ztkX1chvOAy2y9gvwBL4TTxIajqFkVUt5ypfeQpAaOgaGp8X+9uhO/4FoIF53ojtO2Bo+d8NLuTNq2gYTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 01:10:56 +0000
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
Subject: [PATCH 03/30] ACPI: IORT: Make a iort_iommu_for_each_id()
Date: Wed, 29 Nov 2023 21:10:10 -0400
Message-ID: <3-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0128.namprd11.prod.outlook.com
 (2603:10b6:806:131::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d5393b6-bc80-4b4e-b90c-08dbf1412d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WACztOEs8ClSQyQdofD6SX2bBXzfuSg2e7e3+uDtfk99ONwwvVbPkCjQh7TK2zT3OKVQESNy+e3Z51zhWf81cOrl5Nu3GL5sNi79w7k59rEbqA/JAmG5Vm2LmlvvBgBZz0HQsoc2FPIh0dnp5AdiZaPFjFf7RmKKjldH/SQCrDt+2VWUFGj/vL2oMzXtI3GD+KFiX8KXxwCq7cTLou4caG3KSGsVuLRswSfT3CZw+2BdW2kNB6SDpjw4yTSizCpVsXSF90tNhXTBLEJ25WXYjfRhXkgy/7XZWBs3jXJxucSdcjN488G0WclTa0TqryykNvp1Y+bZBzwpeEFxLZPzeZcpetiH+2EPn8f2Uj3KihUdoxyrmqvkkopqrexACNFWjcl5lnv+7sZHAZGGFnT9B2nbKyR4oGHkf/1azWtq2rVxEPnIGkeY6DSMShC58tqlrfcsq5NHsQd+eKj0CHP3EWJSvo9Yg0b3g0GMoqGpRgwhjBfS+G6rX9+1t/ru1JQNVT4oGTUybHWfS7gbOiHzn7hvaWbhHVHyP8WCOqsrwdbMIRO6wzJNPKGiODXjHBpDcNaq9dQQO6u00YNzR1hGvc+6jdHppRN7yorUJl8bBf5QcfUhih0WFb8koHc2LtjqtBQRuuRnW7Uh6d1dYzJsl0bhk5jFOJJlnTLNdUpn9U0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(1191002)(2616005)(26005)(921008)(66476007)(66946007)(66556008)(7406005)(7366002)(7416002)(110136005)(2906002)(8676002)(4326008)(8936002)(86362001)(5660300002)(41300700001)(6506007)(6666004)(6512007)(36756003)(316002)(478600001)(6486002)(202311291699003)(38100700002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jbOz4qPPEyiOOTp5vSMtAdERSp4SLZpY5rsvqdaXGkZetG8bfl5rmfpr/jib?=
 =?us-ascii?Q?gOqs/O+W3tXSVdFUlV7d52t8GJt7XGeakPRSsUutrfHLe/HReDathpx+nlzH?=
 =?us-ascii?Q?TnV8Nr+O1L25XeMDMFb2/JP82vgQ07DF/uV76YUZUW8KTPqsh9CdgzJRG4GN?=
 =?us-ascii?Q?Ck9OBf5YLuFynV7gr+HInimMfbobXW8UfD7p3q4zUapr6rArgHsn6KAwPL7U?=
 =?us-ascii?Q?zZrwvOx1vsXnkcxEkKKqW27tHYGj/MKNJaALJpDDyJk9HZ19BvmAyybXsSps?=
 =?us-ascii?Q?fLqGjezKayT+3VagLHNtMdyVeed0ux857Ymg5k/xU9bHUluBx374QGxoPaPv?=
 =?us-ascii?Q?sWJi/k87uw/N+AgouafHOObrLrmW2TW1U9pDMnCCo6pU7upfHWHxu7ZY2DBN?=
 =?us-ascii?Q?yaLkb0EusqHviqde9tq+uPhjhc6NNrTuSkyEMc1dPnzANU6WFiJlFdW1ZaNx?=
 =?us-ascii?Q?pLJAUJ0nnUqRTCZ1+f2AVkbBn7tyta8cKWvM343hDQNy8q6MKICys+bp5JzL?=
 =?us-ascii?Q?30camvF8studYCoGEvG9hi7iRVFRuShf7Yu8XHfQv45ftoW2KhO7oxiX2MeI?=
 =?us-ascii?Q?wWSUPK89byMgXH6EGaRuDgEYNAFAQHY7FHMaB+jOCGY+2EUWtpFm+lPZy0C5?=
 =?us-ascii?Q?WD6I64CjmNm5SPXuhckTmqOMMOdVoIELYZQWJTvspap4uLY5wILPfaqMg7C/?=
 =?us-ascii?Q?lPiQbEx1pxZ4W+GinXfKom4ou43Kk/19ZQFtZKog6Zr7SvUo/uaNaP/D5bC1?=
 =?us-ascii?Q?3IOOD/+qGmD7kHxpeSvnZs+lVkgMUXRDYd8XGoR2meMKKERnXxS+o9674npH?=
 =?us-ascii?Q?TmS6yzEZTOgU5Dkw7xOCj0mwa7trt1YAK/8bDRcOUxNhhztSlYXDB9lNJAH0?=
 =?us-ascii?Q?SzOSkxf9U+A2vWEVtgIZ+2uGeWIyis33W6ifAolk6goH+3sqLRGV77psDnrV?=
 =?us-ascii?Q?bcm8GJsuxmnSC+QtzUMDGoBsdKUIFuxS9Dmf++6UWY+K+zAnsw2ToF3vzE+H?=
 =?us-ascii?Q?OOL23bkDVxVZhnjyi+fOZl+/G3YDTQkxWPLGdrZbTCOtSy1fqqCHkhLAy+gO?=
 =?us-ascii?Q?7FpmJrN3SOfCdk9Cgx3SEHdqGDNqZirux0idGI2EXnev8Av4c5vAvDk22LMB?=
 =?us-ascii?Q?zGFg39qsbJlpZm5vueasytknE2aL+nyF2d4FzTei2bg301kupvqwynViN5PF?=
 =?us-ascii?Q?UUH2+QJBodisS/dwZRWeYoqnE8RV+AcsSlRbAH6jvSoHyFrcl8Nl6LIXd9ya?=
 =?us-ascii?Q?7qKyLjahOuoim4ME3oBJKPXxCO2q0oRVNqtnUD3LhUmd1FK2KoAOMVdmlEHd?=
 =?us-ascii?Q?T9a7Ek25F22/K3T4CLTDaKWR6pq8deXZyMsqZBAI0NY1sBC4QI5pf+T5i3AQ?=
 =?us-ascii?Q?yB7EhJRyDtSYeN/B74YWRTsGjyXZ4K+HqopGBtEzaDK3GtpABJOGXFDFqRzj?=
 =?us-ascii?Q?RHkhnSnAmsduT4eHtuQVLYIGavpxwJQ1kvnkDeqo0ICuKWqwjXtlgiEflWWJ?=
 =?us-ascii?Q?h/V3AcDk8NHzd0NZwq4iQEQDAU0nLX/FzAMRIVgIxQGgI/PArMr6ak81G1VI?=
 =?us-ascii?Q?9PftkTde/kUz8rIuTaXCYLK1O+KyX+0kSGwLRp6Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5393b6-bc80-4b4e-b90c-08dbf1412d33
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:10:43.8387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pF7veoymWuGvxp3HCnmKxo4u/Evh7vjWDzMhm1eLL0GoG6jimlV8Bbu2oexvxU3B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484

Similar to of_iommu_for_each_id() this parses the IORT ACPI description
and invokes a function over each entry in the table.

Have iort_iommu_configure_id() use the new function to call
iort_iommu_xlate().

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/acpi/arm64/iort.c | 118 ++++++++++++++++++++++++--------------
 include/linux/acpi_iort.h |  12 ++++
 2 files changed, 86 insertions(+), 44 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index bdaf9256870d92..5c9b4c23f96a87 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1218,9 +1218,10 @@ static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
 	return pci_rc->ats_attribute & ACPI_IORT_ATS_SUPPORTED;
 }
 
-static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
-			    u32 streamid)
+static int iort_iommu_xlate(struct acpi_iort_node *node, u32 streamid,
+			    void *info)
 {
+	struct device *dev = info;
 	const struct iommu_ops *ops;
 	struct fwnode_handle *iort_fwnode;
 
@@ -1250,9 +1251,11 @@ static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
 struct iort_pci_alias_info {
 	struct device *dev;
 	struct acpi_iort_node *node;
+	iort_for_each_fn fn;
+	void *info;
 };
 
-static int iort_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
+static int __for_each_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
 {
 	struct iort_pci_alias_info *info = data;
 	struct acpi_iort_node *parent;
@@ -1260,7 +1263,7 @@ static int iort_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 
 	parent = iort_node_map_id(info->node, alias, &streamid,
 				  IORT_IOMMU_TYPE);
-	return iort_iommu_xlate(info->dev, parent, streamid);
+	return info->fn(parent, streamid, info->info);
 }
 
 static void iort_named_component_init(struct device *dev,
@@ -1280,7 +1283,8 @@ static void iort_named_component_init(struct device *dev,
 		dev_warn(dev, "Could not add device properties\n");
 }
 
-static int iort_nc_iommu_map(struct device *dev, struct acpi_iort_node *node)
+static int __for_each_platform(struct acpi_iort_node *node, iort_for_each_fn fn,
+			       void *info)
 {
 	struct acpi_iort_node *parent;
 	int err = -ENODEV, i = 0;
@@ -1293,27 +1297,71 @@ static int iort_nc_iommu_map(struct device *dev, struct acpi_iort_node *node)
 						   i++);
 
 		if (parent)
-			err = iort_iommu_xlate(dev, parent, streamid);
+			err = fn(parent, streamid, info);
 	} while (parent && !err);
 
 	return err;
 }
 
-static int iort_nc_iommu_map_id(struct device *dev,
-				struct acpi_iort_node *node,
-				const u32 *in_id)
+int iort_iommu_for_each_id(struct device *dev, const u32 *id_in,
+			   struct iort_params *params, iort_for_each_fn fn,
+			   void *info)
 {
-	struct acpi_iort_node *parent;
-	u32 streamid;
+	struct acpi_iort_named_component *nc;
+	struct acpi_iort_node *node;
+	int err = -ENODEV;
 
-	parent = iort_node_map_id(node, *in_id, &streamid, IORT_IOMMU_TYPE);
-	if (parent)
-		return iort_iommu_xlate(dev, parent, streamid);
+	memset(params, 0, sizeof(*params));
+	if (dev_is_pci(dev)) {
+		struct pci_bus *bus = to_pci_dev(dev)->bus;
+		struct iort_pci_alias_info pci_info = { .dev = dev,
+							.fn = fn,
+							.info = info };
 
-	return -ENODEV;
+		node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
+				      iort_match_node_callback, &bus->dev);
+		if (!node)
+			return -ENODEV;
+
+		pci_info.node = node;
+		err = pci_for_each_dma_alias(to_pci_dev(dev),
+					     __for_each_pci_alias, &pci_info);
+
+		if (iort_pci_rc_supports_ats(node))
+			params->pci_rc_ats = true;
+		return 0;
+	}
+
+	node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
+			      iort_match_node_callback, dev);
+	if (!node)
+		return -ENODEV;
+
+	if (id_in) {
+		struct acpi_iort_node *parent;
+		u32 streamid;
+
+		parent = iort_node_map_id(node, *id_in, &streamid,
+					  IORT_IOMMU_TYPE);
+		if (!parent)
+			return -ENODEV;
+		err = fn(parent, streamid, info);
+	} else {
+		err = __for_each_platform(node, fn, info);
+	}
+	if (err)
+		return err;
+
+	nc = (struct acpi_iort_named_component *)node->node_data;
+	params->pasid_num_bits = FIELD_GET(ACPI_IORT_NC_PASID_BITS,
+						nc->node_flags);
+	if (nc->node_flags & ACPI_IORT_NC_STALL_SUPPORTED)
+		params->dma_can_stall = true;
+
+	iort_named_component_init(dev, node);
+	return 0;
 }
 
-
 /**
  * iort_iommu_configure_id - Set-up IOMMU configuration for a device.
  *
@@ -1324,40 +1372,22 @@ static int iort_nc_iommu_map_id(struct device *dev,
  */
 int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
 {
-	struct acpi_iort_node *node;
-	int err = -ENODEV;
+	struct iort_params params;
+	int err;
 
-	if (dev_is_pci(dev)) {
+	err = iort_iommu_for_each_id(dev, id_in, &params, &iort_iommu_xlate,
+				     dev);
+	if (err)
+		return err;
+
+	if (params.pci_rc_ats) {
 		struct iommu_fwspec *fwspec;
-		struct pci_bus *bus = to_pci_dev(dev)->bus;
-		struct iort_pci_alias_info info = { .dev = dev };
-
-		node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
-				      iort_match_node_callback, &bus->dev);
-		if (!node)
-			return -ENODEV;
-
-		info.node = node;
-		err = pci_for_each_dma_alias(to_pci_dev(dev),
-					     iort_pci_iommu_init, &info);
 
 		fwspec = dev_iommu_fwspec_get(dev);
-		if (fwspec && iort_pci_rc_supports_ats(node))
+		if (fwspec)
 			fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
-	} else {
-		node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
-				      iort_match_node_callback, dev);
-		if (!node)
-			return -ENODEV;
-
-		err = id_in ? iort_nc_iommu_map_id(dev, node, id_in) :
-			      iort_nc_iommu_map(dev, node);
-
-		if (!err)
-			iort_named_component_init(dev, node);
 	}
-
-	return err;
+	return 0;
 }
 
 #else
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 1cb65592c95dd3..5423abff9b6b09 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -29,6 +29,18 @@ void iort_deregister_domain_token(int trans_id);
 struct fwnode_handle *iort_find_domain_token(int trans_id);
 int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
 
+struct iort_params {
+	unsigned int pasid_num_bits;
+	bool dma_can_stall : 1;
+	bool pci_rc_ats : 1;
+};
+
+typedef int (*iort_for_each_fn)(struct acpi_iort_node *iommu, u32 streamid,
+				void *info);
+int iort_iommu_for_each_id(struct device *dev, const u32 *id_in,
+			   struct iort_params *params, iort_for_each_fn fn,
+			   void *info);
+
 #ifdef CONFIG_ACPI_IORT
 u32 iort_msi_map_id(struct device *dev, u32 id);
 struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
-- 
2.42.0


