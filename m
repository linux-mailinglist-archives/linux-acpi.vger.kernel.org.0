Return-Path: <linux-acpi+bounces-1966-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8BE7FE6D7
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44F9C2819A9
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE56F134A6
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BjmT8lbX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AC810EA;
	Wed, 29 Nov 2023 17:11:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ka5+Tn0dtGD82doSLCdRzFAdZU+soCknlkmhpYprPjL/OEtXbLG43HRLzmLKkr86KdFd4lZ16IQm3mc908D2W7OUdSfCIWrg2xjtXemm56kaGKyct8QoRV6MNBE+Lkn//JGELyOgxoMcLTyZHXd8Jj6AV2Jm01O2opSey2ZeZ0+1McByqH8JPhpe3Auv1ufuu7X20oBZKsrz+sANhDt553M+BkaMB9wguQBxHF07TI1GxJfIZ2seqCWPfa+OXOQqD5gM9nOYuPodYuDiBNV2WZWMC+2ztS42sEKCWqCuEKGEcn7SLYuhabPGHG0Unl0c2Tx0hx8Q+SSIimQdjnsevg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWZ926ZLNg56KWjCc5bGDycCVGjrN5wZd1+rheKLVFg=;
 b=OC/gfjy7SmizxL5B+/qJlDZkBscnLWQJM8R1l85aeCrEQsEzkOSg3/CrHa4UbLSsvnDQlrAEKLaEWDkWZEToSD7VbLxsskvdvVWZ+IRZc8e6ZRg7e57mmXNShuGbo5ofD7JvEkkYU2sPru4Bgdh+c1298GWmJ+tk3KpSxyJy2e8jMGB7H6QQlnQaN5Zo5rGIFQVZETzEKBwy6avzhzPec9culajVcwnnvmUtLLfheF3Ebqu+PNm/IChmwu5E8bPWdsj6oECRe1YS1ChmYMHL6nHDlUfEz9Xe22sZdYXxN1JhZbSidmEAqtXx2vrqop6E99pOjUSClW3UGjnHrZraew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWZ926ZLNg56KWjCc5bGDycCVGjrN5wZd1+rheKLVFg=;
 b=BjmT8lbXwnW6JZmFNYNAVEUqwi/eLtYmxKMIapa0cwURuUJa6Z70jxreC7lR9XxwdoljYcubePkyb3R0rhMfX/b9vGzcCNN7Vcav6tuQYd8x/UBEvuE2DohQCvsSI/iydQXQb9TLClZqlaLJJGsjRQuRv60Lm/in1VUWlv59XdyrePUxNn7ymqhnLjUzr2tiiAgZU7e745OS2irqIeyxTLfhPAhjjhyWmXs3oP+xQPOyGVWq37tglWPlKZp8Hwm5gLpCe3p6LR7oBx7lhkR5JTo5MOKATnsHwl1nRGlJxCb76EiQKJUCJnxiQUafxx8EvXtI9V0MjyKmgvzspPyV8Q==
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
Subject: [PATCH 13/30] iommu/dart: Move to iommu_of_xlate()
Date: Wed, 29 Nov 2023 21:10:20 -0400
Message-ID: <13-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0145.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5484:EE_
X-MS-Office365-Filtering-Correlation-Id: 675f93e3-a2ba-4189-b362-08dbf1412c35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PUAlnaI1V8lrqpJYdE+Z5UsVLxDGEt2eWMKw+SPfsu4wisFzlUhqybEK/ow+wJEhdQIneYbkL+7dH9e3M8SZEp5lb/G2Vw6HlIme/Yjow8R6tJRFi0IjHgy1vveoFIycYwkBVZwC3cLHS+lq47XNr/J/p8oZCNvQdK/CA8ZROqFj+KWhzkxeRVfpy93W6zfBtPckOvInRr5L8JnAaalosUGGyxf2V/ptxZkqQR9rDhS7xl5QPa8L/NTiNa4e5kY0+mVIRWhPqNENune8K6f2wUMmFRMtsVOnmrVmKOlsw4x+ILRZ2KGl+RbkEBlKi6M0i0RqCCCXVvsmGElptVU2J5UDFORw0uFD67dbQKsSbm3uATaqAxeo4lD1xzQTvifDD3veT10lHTUKclaojUG6nLOmrb/uo3Gt+BESHpsxzDadonEjgAGtETRQ8/yaU+sNxYgrZKIM3SkuFaCz6h6tqD3Vvu6fOrCMcV6KFQOCdKC5dUQ8DVL0UjH3kepHGLlRYeV7mwnrxNWhe7iz0+doMmm7kcvi39Xs7ZmnN9FxR41OIT1c/kNG46PhH8zktTgxZZpdxvnOs1GuRSz5tnnT8eT5Rz8tL8iupGSV7nPHxt7j1SCffFfg1DFEfeoBP6NjEOdRAJZc90qSgeHw5h7QOg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1191002)(8936002)(110136005)(8676002)(316002)(66556008)(4326008)(86362001)(66476007)(6486002)(478600001)(66946007)(41300700001)(36756003)(921008)(7416002)(7366002)(2906002)(7406005)(5660300002)(38100700002)(2616005)(6512007)(6506007)(6666004)(83380400001)(26005)(202311291699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wYKUGMVw4jTZK9TpVBIlYxZXJsO5zzGTUYhbPmpelFOwHr8icXkROHVlpj5n?=
 =?us-ascii?Q?8xxnJuZHz0o9Y4McQ3bEwIl2fGTleFmlreiZ/vf7pqUYhSj/8zt6k2pgvcAp?=
 =?us-ascii?Q?A6iF88hiWjbrWwd+ESPRo+SrtahSogrBWxyVSbHm42G1eCH8dWRjkdG9wrMz?=
 =?us-ascii?Q?bFE5T2QpvWwBoTEgdnQaC6fASJaxHTNydtWVcZ+FowjAwY4tWvzan27Sd9/l?=
 =?us-ascii?Q?fc7KmDImc+bKm3wRaetPHrleO0CJQhLrM73SHp024RI8AJxFZ92amlKTktHJ?=
 =?us-ascii?Q?TYwZ88LSALxaUJJC3eDWwdwx6cDzH6AqJtg8/OgulO3T3MBq/fHb1ajeHft1?=
 =?us-ascii?Q?+2YihVnWM47fZ+WyQD+TtAkIOIf6fz334fYF9Im4vCGt6fjwp2v2QXLGBbgg?=
 =?us-ascii?Q?TO4PCb/cojUakfec9VQLOo4QG03fbZ4vg3/ugFbj5qgZDTJrz4HiApfaE5oG?=
 =?us-ascii?Q?DQ8BZ9xY88D1DBRPAMOasCoRSXXYNz0k8l81jgBUTkefS0r4DIBqQQ0FRtDo?=
 =?us-ascii?Q?O+jF8AUgcQBLpgiFweNmJr94qXFmKl5SySWi1XBF6WhSNa2ZIOG6aKuG7KUq?=
 =?us-ascii?Q?APM8fV8SUfLHihTj6xkCUGT/YGrz1f+M/27E4senglfWKBIizYdvm6tY4a1w?=
 =?us-ascii?Q?OUTK+fYeix6+11tIXp2DvY5qjCXrKSfTvsA3+qKDr1GFXsHa92nnwabqoQpO?=
 =?us-ascii?Q?Y7TmuMqUD8z5+XmM325AR4QpGwriOiB2Q62kK3o/L/VG19o4amhDQQzd/jzc?=
 =?us-ascii?Q?lbJxJQdZkOvtujpkraGRfwCLgb1NFlLhyGl2LMs6foNv3ZFDvBXgGZ0aYS7u?=
 =?us-ascii?Q?wXZvwLa4PDM8NMlkOO3jh8EPohP0wZdQVgPCDu7xQBgtSsPWrup86XOSEK2x?=
 =?us-ascii?Q?HOgdxm8m+zJGFh/40sCvlow76JtLygZflyH1qb4G7KldqGD7D0g1u/JR9+cz?=
 =?us-ascii?Q?6WHqVrQzEZxWmk5KMAOJ5WzfxOfSXqfjzQ17OLymF1Xg4SeW7w7YOXqfFY7X?=
 =?us-ascii?Q?v/Pi1MLB2NNZroriYSEHx+HgZyYr2oixB01n2eLeffMHuWF0afQz4ok5l2gx?=
 =?us-ascii?Q?kqNVCHXSxHS7mu/7b7jLuMq41Rf2ie7nOYqr+P5j6mQELuSo2pWf0YhiyHnF?=
 =?us-ascii?Q?vHliBDRKs2H91VexVw7h2UMAHxHRl/N0twxk07EqCT1j7objPVMAHglvwUpv?=
 =?us-ascii?Q?78UV36QGHRcC/lE+1iVllZOD7xNKxQsCwQ+MI9Gxl5yaGRrhTyzUswzihWaA?=
 =?us-ascii?Q?DdM15/i98pB5B+BsDxYVC7UZFfDseebYDztILvt7aBCIcO3WhRkqsDS1TcBa?=
 =?us-ascii?Q?jNZaU1mZWnKHdcmtN0IX3FuF2AibZbWkVDJ4Ly9vFTF4tYmc8djT1TyoeaDx?=
 =?us-ascii?Q?YplG9XVQHpTXMvsNop/iMxsbSRHanm/nSaEALTphAqitiqxNASbRpOOtcvgx?=
 =?us-ascii?Q?3+/7fp7BIouXZhUr7N/ZO4E8KuhH0jMh2+E4jipLMu3o5iylv8XolkznNXcJ?=
 =?us-ascii?Q?4Cid2fTynpl+VdUVecnAfJkYmh4an9rOUAPsgADwhSpy0JtuKEgsDh4PMtqZ?=
 =?us-ascii?Q?P1w/vWCYt1t4duwuE7LxA9WzdDo4waGLWcxs6wG6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 675f93e3-a2ba-4189-b362-08dbf1412c35
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:10:42.0795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4Y176JW/ot07qm4b/KpOoXLIROVYY8OkNl8DDPa1VZAbJe+cFFsKswX/8e6EebI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5484

dart supports multiple instances with multiple IDs per instance. It loads
the FW data into a pre-allocated 2d array inside it's per-device data.

Switch over by allocating the per-device data at the top of
probe then calling iommu_of_xlate() to fill in the 2d array. The iommu
instance is located by the core code and container_of() gets to the dart
version.

Solve a few issues:

 - A bus probe was failing by accident because the of_xlate not being
   called left a NULL cfg in the priv, and other code tended to free the
   dev->iommu. iommu_of_xlate() will fail bus probe directly

 - Missing validation that the node in the iommus instance is actually
   pointing at this driver

 - Don't leak the cfg. It is allocated during probe, freed on probe
   failure, and freed in release_device() on probe success. Previously it
   would allocate it in of_xlate and leak it in some possible error flows.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/apple-dart.c | 58 +++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index bb0e5a4577fc03..b796c68ae45ad8 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -268,10 +268,10 @@ struct apple_dart_domain {
 };
 
 /*
- * This structure is attached to devices with dev_iommu_priv_set() on of_xlate
- * and contains a list of streams bound to this device.
- * So far the worst case seen is a single device with two streams
- * from different darts, such that this simple static array is enough.
+ * This structure is attached to devices with dev_iommu_priv_set() on
+ * probe_device and contains a list of streams bound to this device. So far the
+ * worst case seen is a single device with two streams from different darts,
+ * such that this simple static array is enough.
  *
  * @streams: streams for this device
  */
@@ -295,6 +295,9 @@ struct apple_dart_master_cfg {
 static struct platform_driver apple_dart_driver;
 static const struct iommu_ops apple_dart_iommu_ops;
 
+static int apple_dart_of_xlate(struct iommu_device *iommu,
+			       struct of_phandle_args *args, void *priv);
+
 static struct apple_dart_domain *to_dart_domain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct apple_dart_domain, domain);
@@ -721,21 +724,34 @@ static struct iommu_domain apple_dart_blocked_domain = {
 	.ops = &apple_dart_blocked_ops,
 };
 
-static struct iommu_device *apple_dart_probe_device(struct device *dev)
+static struct iommu_device *
+apple_dart_probe_device(struct iommu_probe_info *pinf)
 {
-	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
+	struct device *dev = pinf->dev;
+	struct apple_dart_master_cfg *cfg;
 	struct apple_dart_stream_map *stream_map;
+	int ret;
 	int i;
 
+	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
 	if (!cfg)
-		return ERR_PTR(-ENODEV);
+		return ERR_PTR(-ENOMEM);
+	ret = iommu_of_xlate(pinf, &apple_dart_iommu_ops, 1,
+			     &apple_dart_of_xlate, cfg);
+	if (ret)
+		goto err_free;
 
 	for_each_stream_map(i, cfg, stream_map)
 		device_link_add(
 			dev, stream_map->dart->dev,
 			DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER);
 
+	dev_iommu_priv_set(dev, cfg);
 	return &cfg->stream_maps[0].dart->iommu;
+
+err_free:
+	kfree(cfg);
+	return ERR_PTR(ret);
 }
 
 static void apple_dart_release_device(struct device *dev)
@@ -778,25 +794,15 @@ static void apple_dart_domain_free(struct iommu_domain *domain)
 	kfree(dart_domain);
 }
 
-static int apple_dart_of_xlate(struct device *dev, struct of_phandle_args *args)
+static int apple_dart_of_xlate(struct iommu_device *iommu,
+			       struct of_phandle_args *args, void *priv)
 {
-	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
-	struct platform_device *iommu_pdev = of_find_device_by_node(args->np);
-	struct apple_dart *dart = platform_get_drvdata(iommu_pdev);
-	struct apple_dart *cfg_dart;
-	int i, sid;
+	struct apple_dart *dart = container_of(iommu, struct apple_dart, iommu);
+	struct apple_dart_master_cfg *cfg = priv;
+	struct apple_dart *cfg_dart = cfg->stream_maps[0].dart;
+	int sid = args->args[0];
+	int i;
 
-	if (args->args_count != 1)
-		return -EINVAL;
-	sid = args->args[0];
-
-	if (!cfg)
-		cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
-	if (!cfg)
-		return -ENOMEM;
-	dev_iommu_priv_set(dev, cfg);
-
-	cfg_dart = cfg->stream_maps[0].dart;
 	if (cfg_dart) {
 		if (cfg_dart->supports_bypass != dart->supports_bypass)
 			return -EINVAL;
@@ -978,10 +984,10 @@ static const struct iommu_ops apple_dart_iommu_ops = {
 	.identity_domain = &apple_dart_identity_domain,
 	.blocked_domain = &apple_dart_blocked_domain,
 	.domain_alloc_paging = apple_dart_domain_alloc_paging,
-	.probe_device = apple_dart_probe_device,
+	.probe_device_pinf = apple_dart_probe_device,
 	.release_device = apple_dart_release_device,
 	.device_group = apple_dart_device_group,
-	.of_xlate = apple_dart_of_xlate,
+	.of_xlate = iommu_dummy_of_xlate,
 	.def_domain_type = apple_dart_def_domain_type,
 	.get_resv_regions = apple_dart_get_resv_regions,
 	.pgsize_bitmap = -1UL, /* Restricted during dart probe */
-- 
2.42.0


