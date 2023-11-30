Return-Path: <linux-acpi+bounces-1959-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2017C7FE6C9
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AB84B209DD
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8A41426E
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t9NhqxCR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D5F10E6;
	Wed, 29 Nov 2023 17:10:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oH+7EL3W6Oc2sBQZfrO5SXnZsJh09wEJbKsTB1yKAIiPI/3bt3wGb+Qz4SVbXrZfi3FtUrmdh5QlIbK4UPSQG/W9cI02V4ptbutCUjh6zBQH53njaSysoNAD1c1RPehMEj8FB6Zl/gweDCzuQUhV0CHDDwXZ4gTjK/51xTHOiWtHqFGwORx3CNO6tLu2Wdo0FDPtSBfwYVrQXYkNaWmFLiTBIU9dUnCDaALsL1VGO3qfTVMzNvbnkhzbX+B9Z7z7PbBOe+z4g1/btxGPhz3DAm7O7CMNlMN82E04hyu0+xU0SFIdbwmQbr8/4ZnWrjuM3fWQ1rFaYk2yJZznWpU4yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VONoI5R3dY9brGBShgi69AqKHU3yQbManu8ZQ6jk5IU=;
 b=UZQM4r3z3vP0zD2KE6B/i1fqSzTCLkHMiLjja4kQyEDT9Ad9hKxbzQVii3kADuNTHRhtXhtuhSA4rcgd/YqZJ1O4qQv22Pul+ZvG3PjOl8LDDsRoQZlxoc+Kd9DtyI4UnNWPIVIZpl/UOmqQFQC41l7Poh90571KDB3AUmXvi9Zvh6AJYUjes+ezRqU0HzvjtVHQEE68eEhZfTYwb9sFUEkn59FprWZ7u0kFzlAmKVKb5IpMkt3RkoGVT+kcvX1Kpdlu7eQa8cw+JqUuwbd5XL955vy77wEvZmkdUg9ufN8hmeVpnAh8kR7oGwjPT5ho63YyFodjC+z7W6kSnqnBBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VONoI5R3dY9brGBShgi69AqKHU3yQbManu8ZQ6jk5IU=;
 b=t9NhqxCR/HnnlufMSXxVICsXoXOrHordY+coscGIHglAavA8+T3ahEkQDwzGE/JHDesJVCujmF1yzWIZ5bdoOjT/9HdOWlIlGZ/s45LFCEDxMFhWXaKm4Y1c8mnML16W13y6iGqWHGMM3R+aWo/1GHUU+7ZD0j9nCdZpHPo+Y/Zf0ePKdTBxVI2TpSmz6M3TBPg29hXdwRykdUKt7vvU10WzkwBqZgSmLjg/iR+tYK37jXY2XHAOSWeOr3IrwTLldKT8OHrGNnLKuPTSvWcOJEMw0lzdjyqv1Dl1cbbj8OSADnDLlql4Y5XJsfNL3jh9IgN6TaFzvTIPmlmzJoSGHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5484.namprd12.prod.outlook.com (2603:10b6:510:eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 01:10:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:10:49 +0000
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
Subject: [PATCH 17/30] iommu: Add iommu_fw_alloc_per_device_ids()
Date: Wed, 29 Nov 2023 21:10:24 -0400
Message-ID: <17-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0133.namprd11.prod.outlook.com
 (2603:10b6:806:131::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5484:EE_
X-MS-Office365-Filtering-Correlation-Id: d05d55fc-83fa-40da-adad-08dbf1412b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Tr+LUjzPbR/EMxIsP4k8AZp6N5+iW3J5X8G1RATSwPjWGh9xxXNVltEtIrqWdTIercGf9TVpdos8gGSMwdZjarqc9Y4l3IdZcTjSPbJtUzYqWOs7/wmeFcCtRHabz5UfMEs7RcKXgwp0Z/DBuklARetQycO3QTIlAiGQhoG7UnagAHKq9KN5oACY0YEMusMEI3fpjjMQiH0eZAQAYCi/YixLmDN5omOQD6PM6Cz0N0aF7JiyPai3r84p8rYNd6k/1TJh4iAU/bw+xFQvHDZPzvoG6GXB05C0QassWWaJweOuXjmQZi2ZZYkbZ/0D1VvthKk7sDANh9vBczurwSjgTVOwyeZz3kzOqvPy7pGf3ZgjQBRiUoWcaCmmjPQnn4wrPTcWS+MKf/31PF5glLbBnMspp5tt6DdpgZWlY24mrGf+VbBOeOBMHglkW4VxLbwWJJ3IVDEyZYiR5Ht5P8LQINCeFNe+VX3BiBVbNovwlg880vifKQ2S9YPdWFuEDYeedPfn0vrE0N8BJ+7Wy+bFesuJ5DTnXUPKesVyms6Ui+pTfswTxhh1Vofo3hVP34X7K4fnpKF/Vsxue+IHOVXkxYTi3f2uEZzs/UAw4/fuJeLNXDTNlkD8fFGYRpgVnso+NgNhvAYDUAgNZ8Wc3x666A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1191002)(8936002)(110136005)(8676002)(316002)(66556008)(4326008)(86362001)(66476007)(6486002)(478600001)(66946007)(41300700001)(36756003)(921008)(7416002)(7366002)(2906002)(7406005)(5660300002)(38100700002)(2616005)(6512007)(6506007)(6666004)(83380400001)(26005)(202311291699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Yzl4YfQS2zKnePlOPeSel1Vs1Tv5UcL1D64L8yrayHAfw3LNALIMcFZEk3L?=
 =?us-ascii?Q?WfQ8uFNs57Wa3ytF14ETFJrW99CYML/xYOk6MvZWUqdc+coXpyGluKJAPsTL?=
 =?us-ascii?Q?4IIISIdwxyeldzkWwjkpJzMMOB+Ngp5pDdTEXAcMv7eBWGhCEvtSWLXFI6s+?=
 =?us-ascii?Q?eQuEeDag6HxxvAYZUPxHbZ1WzNM0I0q0dselbiWMx3sKJS8djiM7v5b5/QMD?=
 =?us-ascii?Q?QMPM0BzSw6vYrYq1skYnCXZazM6WYHUDtM/hHTbj62b+07sXAjj+XOSmyejI?=
 =?us-ascii?Q?heaEf6qs0gfAaS3qEniqsXr/VaKaD0IwIVTrQSAyJmNNOyLjj0bDZrQqM8Al?=
 =?us-ascii?Q?5MjPtsz5oC8EA/ueLC9ZAxye1y1m10TAqf+ZBlnzyjv3mm4TesG80F7IG/ie?=
 =?us-ascii?Q?aCFPIfWzYZAU16j6ZWqHYhnWB6huvQIKexm+F/savsqxbJADwtvvzgktfUew?=
 =?us-ascii?Q?H7oM/3RzRXcXonvWTRnr3dcPF3fPKPuS288PlGA5Skf+Z29GK6VRrhcFfzV0?=
 =?us-ascii?Q?K+Y8QpAHPZgcqJkC5eddrIFZLRea0qkqrmNcgc9traNnBfYNP7M5xjK1cXyT?=
 =?us-ascii?Q?7P6X85uZjPupg62+XVdltTo3Drscbp2Us6mnA7rCDTGTDjZKHFv+p5cNW+7s?=
 =?us-ascii?Q?GsLBp3S0ZVFb5VDF0OXfT7w92V3pwZsCJOgWhIzDGUkHiVm1Pr3KSWJ75j5E?=
 =?us-ascii?Q?kFKMrs93shN4nOjypcD41LvNWeWZPRo7Aeo/yz/XJQN5rJeNp+JYQzZ8irHh?=
 =?us-ascii?Q?sn8yR/MnwPX7PyUu06PTy3/IcGYnFmkofi1wiaZQiSs5Y2hDx21c5tJPJtru?=
 =?us-ascii?Q?f8KrtM4NCBMHzJFf8Yy/ZHCnE2XgMlmV/ZiFWSpGh5ceq99sxvmSiglB0mQj?=
 =?us-ascii?Q?gJinhny47f9rAw3fV2fqAQGznD5sEJTrdWEMBpW08p7+Di+fR4Ztlarmwk6B?=
 =?us-ascii?Q?uAUNkRryd84NYwlHDBNyz9+gnAVjYgZfoYXXXwl3rihlRtKWOSxfamV7376q?=
 =?us-ascii?Q?GIcyDJe8nYnT06HxGh51+ST8HkiVmOVevavVzV/mMX/+0imKOIHvhR7Bd41x?=
 =?us-ascii?Q?TFn9rXRbJt+7IjE30CGNvtbPIJzADHM+TN9nFxnu5NdNQWh7C8VJMhG/WiNc?=
 =?us-ascii?Q?VVdaWvPE/UPcxCfp2SsE5v63sTTh/YxyFNESI3rXiTGwB3OWmhKAbx6rLlcR?=
 =?us-ascii?Q?DiKA1VBZYxpNBY2TZd/zvm7i9TgxQRiG8Y1KuGYMoSnlsWBqJV/OpPJoPP+/?=
 =?us-ascii?Q?psFV4VpTsqDkKBuWppy+Sm2EntJAHIe5OUX82oK0HBF2HCQaI6Aw2N+WKFbR?=
 =?us-ascii?Q?ARV5DTdzX48/SFpjAVDWtjcbpvXaXn7engxXekv5084b2LIoGZTLC7xBOqSE?=
 =?us-ascii?Q?10PuXXlDr7BYvoVm81EERVgwUZXrLnv+/dUqNNrqZyFMofrAlNZwqM2v4Gxa?=
 =?us-ascii?Q?3QipqVcx0qoczm75KeA0HbV+HxYB8tJ+8hnKp7beobt+n0ZmDhX+n3og1Ufu?=
 =?us-ascii?Q?bQzCas/6ZWXdQ61w4rxKFIadOqvW6ZqSZRE8Kz4QdBy4MeeGAriJIxGMETAF?=
 =?us-ascii?Q?r9axiMK8nw1sHU7Nif/43zueLzG44Z/o6k5YhoqE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d05d55fc-83fa-40da-adad-08dbf1412b80
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:10:40.9994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJMyQNqWZ/e4wRCik6bJ1jQSIxUV6HrStxdFZB1eOQs1MQv1EnzIX48OQ8PEU0V1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5484

This helper can be called after iommu_of_get_single_iommu() to
automatically extract the raw list of IDs. It can be used by drivers that
expect to have a list of simple u32 IDs for a single IOMMU instance.

The driver must provide a per-driver structure with a trailing flex array
to hold the IDs. This helper will allocate the structure, size the ids
flex array, and fill it in with data.

Driver's should follow a typical pattern in their probe_device:

  struct tegra_smmu_device {
	  struct tegra_smmu *smmu;
	  unsigned int num_ids;
	  u32 ids[] __counted_by(num_ids);
  };

	smmu = iommu_of_get_single_iommu(pinf, &tegra_smmu_ops, 1,
					 struct tegra_smmu, iommu);
	if (IS_ERR(smmu)) return ERR_CAST(smmu);

	smmu_device = iommu_fw_alloc_per_device_ids(pinf, smmu_device);
	if (IS_ERR(smmu_device)) return ERR_CAST(smmu_device);
	[..]
	dev_iommu_priv_set(dev, data);
        return &iommu->iommu;

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c        | 21 ++++++++++++++
 drivers/iommu/of_iommu.c     | 21 +++++++++++++-
 include/linux/iommu-driver.h | 56 ++++++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ca411ad14c1182..caf14a53ed1952 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3067,6 +3067,27 @@ struct iommu_device *iommu_fw_finish_get_single(struct iommu_probe_info *pinf)
 	return pinf->cached_iommu;
 }
 
+/*
+ * This function shouldn't be called directly without a pretty good reason,
+ * prefer to structure the driver to use iommu_fw_alloc_per_device_ids()
+ * instead.
+ */
+int iommu_fw_get_u32_ids(struct iommu_probe_info *pinf, u32 *ids)
+{
+	if (WARN_ON(!pinf->get_u32_ids))
+		return -EINVAL;
+
+	/*
+	 * We pre-parse a small number if IDs and keep it on the stack. If that
+	 * isn't enough then just reparse again.
+	 */
+	if (pinf->num_ids > ARRAY_SIZE(pinf->cached_ids))
+		return pinf->get_u32_ids(pinf, ids);
+	memcpy(ids, pinf->cached_ids, pinf->num_ids * sizeof(*ids));
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_fw_get_u32_ids);
+
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops)
 {
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 8d5495f03dbbcb..6f6e442f899ded 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -332,10 +332,28 @@ static int parse_single_iommu(struct of_phandle_args *iommu_spec, void *_info)
 	iommu = parse_iommu(info, iommu_spec);
 	if (IS_ERR(iommu))
 		return PTR_ERR(iommu);
-	info->pinf->num_ids++;
+	iommu_fw_cache_id(info->pinf, iommu_spec->args[0]);
 	return 0;
 }
 
+static int parse_read_ids(struct of_phandle_args *iommu_spec, void *_info)
+{
+	struct parse_info *info = _info;
+	u32 *ids = info->priv;
+
+	*ids = iommu_spec->args[0];
+	info->priv = ids + 1;
+	return 0;
+}
+
+static int iommu_of_get_u32_ids(struct iommu_probe_info *pinf, u32 *ids)
+{
+	struct parse_info info = { .pinf = pinf, .priv = ids };
+
+	return of_iommu_for_each_id(pinf->dev, pinf->of_master_np,
+				    pinf->of_map_id, parse_read_ids, &info);
+}
+
 struct iommu_device *__iommu_of_get_single_iommu(struct iommu_probe_info *pinf,
 						 const struct iommu_ops *ops,
 						 int num_cells)
@@ -353,6 +371,7 @@ struct iommu_device *__iommu_of_get_single_iommu(struct iommu_probe_info *pinf,
 				   pinf->of_map_id, parse_single_iommu, &info);
 	if (err)
 		return ERR_PTR(err);
+	pinf->get_u32_ids = iommu_of_get_u32_ids;
 	return iommu_fw_finish_get_single(pinf);
 }
 EXPORT_SYMBOL_GPL(__iommu_of_get_single_iommu);
diff --git a/include/linux/iommu-driver.h b/include/linux/iommu-driver.h
index 622d6ad9056ce0..632c7b4a389abe 100644
--- a/include/linux/iommu-driver.h
+++ b/include/linux/iommu-driver.h
@@ -40,7 +40,9 @@ struct iommu_probe_info {
 	struct iommu_device *cached_iommu;
 	struct device_node *of_master_np;
 	const u32 *of_map_id;
+	int (*get_u32_ids)(struct iommu_probe_info *pinf, u32 *ids);
 	unsigned int num_ids;
+	u32 cached_ids[8];
 	bool defer_setup : 1;
 	bool is_dma_configure : 1;
 	bool cached_single_iommu : 1;
@@ -123,6 +125,60 @@ static inline unsigned int iommu_of_num_ids(struct iommu_probe_info *pinf)
 	return pinf->num_ids;
 }
 
+unsigned int iommu_of_num_ids(struct iommu_probe_info *pinf);
+int iommu_fw_get_u32_ids(struct iommu_probe_info *pinf, u32 *ids);
+
+static inline void iommu_fw_cache_id(struct iommu_probe_info *pinf, u32 id)
+{
+	if (pinf->num_ids < ARRAY_SIZE(pinf->cached_ids))
+		pinf->cached_ids[pinf->num_ids] = id;
+	pinf->num_ids++;
+}
+
+static inline void *
+__iommu_fw_alloc_per_device_ids(struct iommu_probe_info *pinf, void *mem,
+				unsigned int num_ids, unsigned int *num_ids_p,
+				u32 *ids_p)
+{
+	int ret;
+
+	if (!mem)
+		return ERR_PTR(-ENOMEM);
+
+	ret = iommu_fw_get_u32_ids(pinf, ids_p);
+	if (ret) {
+		kfree(mem);
+		return ERR_PTR(ret);
+	}
+
+	*num_ids_p = num_ids;
+	return mem;
+}
+
+/**
+ * iommu_fw_alloc_per_device_ids - Allocate a per-device struct with ids
+ * @pinf: The iommu_probe_info
+ * @drv_struct: Name of a variable to a pointer of the driver structure
+ *
+ * Called by a driver during probe this helper allocates and initializes the
+ * driver struct that embeds the ids array with the trailing members:
+ *
+ *	unsigned int num_ids;
+ *	u32 ids[] __counted_by(num_ids);
+ *
+ * The helper allocates the driver struct with the right size flex array,
+ * and initializes both members. Returns the driver struct or ERR_PTR.
+ */
+#define iommu_fw_alloc_per_device_ids(pinf, drv_struct)                    \
+	({                                                                 \
+		unsigned int num_ids = iommu_of_num_ids(pinf);             \
+		typeof(drv_struct) drv;                                    \
+                                                                           \
+		drv = kzalloc(struct_size(drv, ids, num_ids), GFP_KERNEL); \
+		drv = __iommu_fw_alloc_per_device_ids(                     \
+			pinf, drv, num_ids, &drv->num_ids, drv->ids);      \
+	})
+
 /*
  * Used temporarily to indicate drivers that have moved to the new probe method.
  */
-- 
2.42.0


