Return-Path: <linux-acpi+bounces-1960-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 613EA7FE6CB
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1014B20EDE
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA881427F
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WTeVm8yC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917D5122;
	Wed, 29 Nov 2023 17:10:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfDXirknL7L1BUCs8bc0tSs5Bu4CkkWpVp6Qq0z/Qc4hGiBnGVve7/OGkvEp49n/egXdGqIZa71tbmulM/d8nWqWUNjYeIa/wW5BmHNEsh5muKcWpIHoVDhLkxZ2d3DJ/atqkSPAi6F1Feouuj1o+uQkOl4vKiX8oMoiUvUFOxf1kM3fzQmq8U8hN/9ePVo8BBR/b6BoRuU5WARcb8wfSLSR8UHKdMgvwpbvGLhXdIUadzEwwB61w1a4faUk8FXcPCBYbGjhQjNa660t3n7gbO5BOn09FKNp5bON8ngxJ14YYnD+ahx1MD0lsmaCjryToDGbjTThoOyB1GdYX9hN/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=at3ERfr6LNQE1weSlr6/SqXNAe3XLITf/XZmwv1CCw8=;
 b=kdDdHPTRHJzQFCJS+uU9G0X6tl97txATwKrM8u6EUWw+yDjEA85OcxGHOEz8MR4HK43kzzNYKol/sUGUpo0TK8/t44Alfk8zAqpgDua7TisGBYR8ouNNRgwEzP3cwhOaLJ8WhIZt9gKEVHYSwV9tPIYgpcXmdEIlYVBTWc33JLBBwc6wHYRJFXolZJwu1drCcOPaQmh2H1LH0qiSr0hNybD6isge74gj6E9xTsRuhVCk3Wsg2VEOSeoPfv3omWrj7cbY2uYaiwHOK77rXHHStD35HjkhSMrv5hj/hWYtcULHU+ZmiPpZpxr+aQxUn01c7H52/b187+F2huaxgwrflQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=at3ERfr6LNQE1weSlr6/SqXNAe3XLITf/XZmwv1CCw8=;
 b=WTeVm8yC8YoCWKayhEb92LyMM+ZHBIcQUVWj+Dx9ePMAEynIA88CXUkA8/ZT9N/KWM63fOvFtIyh8uydbNDYDsPZfZ2p9ni1U9sI8O9VvmqN4lYr9HtrwoqPD2HPTywBUo9m2wR54IqgqsUllx5Ko2DYJb5RnzD0rP4KHmY8eHXnyMITWM7ltIoGub7Dtwk63g+6rZD73jlSSHYDYkCma1AW6+aWMVa9NiZrtbfImc+V2sIByhNiyM0VVmeDxVilxTNIpJ0J+EyU7mbTHN68hW8HoXVqGaB5fnG3vaa/WSprmBAKqKEbYaViHm23lZm6lnSbB9el0+DD1M+UKX5pGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5484.namprd12.prod.outlook.com (2603:10b6:510:eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 01:10:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:10:47 +0000
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
Subject: [PATCH 12/30] iommu/of: Add iommu_of_xlate()
Date: Wed, 29 Nov 2023 21:10:19 -0400
Message-ID: <12-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5484:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f806ee4-4326-45e2-79e6-08dbf1412b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TIZFqfzvtr2YcYNETFF/PTb94RNIUhTKxEEbcXysqAEzMAQoDXWV8aJFOi75zFaI0Il5TP4NPzByEX5F4XAhxGeE4tISihfjAz+eiHGxeNjT5XRrLukZy5iM2DLqlBNBSsBLqaXUUoO+tKjMsDsTVHkav75R34Yu1u5OQnfWYlp65PLg4mvIH4VJTfqV2FSsvPoEj1TASVrSAOkWsi1BMTHSMvlpSMReWwo5cDJoyzm6GcwrCmzB+zdkAxAP9htTkvIfi2vwU6Zw3jTV1A8/81ee52LNiTs6vtGNG0uuAJW7DGu+c+rmLV8pfxCiYjOL4p7wWpCN4wqDPYny4RUkKhxPRGhx1kGJnnQsViyHw6NxLspRbntoCnW7xEImAmedCqwHbZMngmgII4hR7G319RNBMiGxoCIv0BVsr19KkObtLnQOStGLEsSYVLRNU8qATn3Zn6wBiYaAnr1DIk47DQIdGs3l1h36pYGLA6RHiwM+6mm+G+ZB3SN7nOAy6P6KOHYrQlt3ptvtb5bN4dg+NZ2EOOf802I9EEbRwRjgYIeE8QTE/QcykFH/p+EkZez9d1lrBHCKQKAE9dtlxUPjBQ4trFIjKwjAT5H3dNvQJazHUc8/+NQhK2vYHdRsJXH20357ODwmeYDRCPFUicWPNw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1191002)(8936002)(110136005)(8676002)(316002)(66556008)(4326008)(86362001)(66476007)(6486002)(478600001)(66946007)(41300700001)(36756003)(921008)(7416002)(7366002)(2906002)(7406005)(5660300002)(38100700002)(2616005)(6512007)(6506007)(6666004)(83380400001)(26005)(202311291699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HkGVBSCT9IGS1U/algNjEDu00nCBkERPgTh2ZudgjMK8/qB6HPEgafNREsBl?=
 =?us-ascii?Q?G/4vTMnQ2uEbm33HKDHnsBzo2gHoqRyCyTKwrTiy7KuuEvxyJ9fnW5NrYqgG?=
 =?us-ascii?Q?MVMTzIgR/TbZ5Es1Yp6KrUHGYmDTdfcfOzmMLiatRNaprFWGMXwruJWUhsDc?=
 =?us-ascii?Q?97Fkdk/NgN+nl2HdEXVqrWJ7um1bn0sTa4MtAsTlcXTJI6XX3ZtJtW44YsPt?=
 =?us-ascii?Q?A8paIVNJOp62CnVpeCufgbEx0Z9qfvLOMHWVnCcza5gMdxA0Yz9/adQkhU36?=
 =?us-ascii?Q?+6wZR13bY+97HyPMaKhQLytgld10nHj3k+ToGH+n3c5CJ+VNlK3Qs+YcNJzF?=
 =?us-ascii?Q?wGPa1wJrA9FFg/o3M2pTJSXpE+GiLVJNLSbd89RZBYFOsRESPH62svGVBTeL?=
 =?us-ascii?Q?aupliGjznLkHf7hCR2FYm0W6RgoIi522IzjJuayYKq/leLq28CN8+L1lTyuj?=
 =?us-ascii?Q?vAiMDbuVg+7UxXH63FmuX2jFoN+U92G+W3Mgs2TrpMROhIllFkRqKeJjCH21?=
 =?us-ascii?Q?+KAbZREINMDlNME3LO0W8ITTDcqT30lHRvb+bJFEts0y7y2knmVBJEZf5WAx?=
 =?us-ascii?Q?oganc61AncBesmxvrOm/ByG2ZCzZYzE8tmZCS3A2qsvf4CcaYoEKGF3HWZgh?=
 =?us-ascii?Q?njeJJwJT2VbfUAA+Z/gRu4wsekJZ8Pd2eUEQDiXHJhXnANp6hK4Tl4uJXui9?=
 =?us-ascii?Q?fH/sNS7lUVNs55ukLC2lioLTNlRH0RFKT9wH8i4iMhqzpnMnaZ6KhSXh5LmP?=
 =?us-ascii?Q?W+yOeTiSvUWZ8wH6ISJOvv5k3rforInSAFHs/k7YjTaCGn5Iu0dwvk1dfFw7?=
 =?us-ascii?Q?cREWbdkx3iict5BWt0zfdnn7KQv4msGTSPKLouj4YtkS1TA5CoT4vUwOf1gW?=
 =?us-ascii?Q?vPZlwVkIXjMDxYakxxsjrNf5RPkZkDRXeQOtZmqruseceH+xS02Pc3xFboBj?=
 =?us-ascii?Q?ciTW4G78EYMdHz2YgveI5cN5qlMuvNHg6u5H9CP8AWVr5YhHiaLYCG5qR6mV?=
 =?us-ascii?Q?0Pns850dXm/wl5MDaV6qQgatKQTo7bD5lwyY7V4znNnAMEvCyuILT9BGlZcg?=
 =?us-ascii?Q?OF42a4nKeftmaiElEK+wTWoLzNbSWj89X6yA35n6UoKqNNtUf4qCGvUFzgaJ?=
 =?us-ascii?Q?U2owZNycMrYws4k8aQ/zV38tu/+3ue9ZTI9GexHRYdJln3hxM0/J/PWFjji6?=
 =?us-ascii?Q?BuTfDaM72ZTovBPeNJa7RgXZgru217vUnpUSQarBCG2TKMdesqeQlgOB2bPF?=
 =?us-ascii?Q?Vu9iHOnUeLtEIugulnONacvWYvPmtf5xlzUqf8yCeeEIGrax8xM28YXBgn3h?=
 =?us-ascii?Q?MhVIl5P10WFM3bBIMMb0oKcG4KxdSuTLrlnGeD/T/IDYfvGxuNk8rxuXuiyl?=
 =?us-ascii?Q?pRcvv0t/NQ//gbJurtiIBVoSzEYKDaigCwVWNgy5zA8286mdTkYk5BqGaZ2U?=
 =?us-ascii?Q?SznxpIhd/eVfUF3CAxzkYWbzScdVtZvSr9XfPLPEE05aN03mDvoz+tH4A6CL?=
 =?us-ascii?Q?xKRgiFLWzTsJi2eegK2zXIx0x2tKWQT33djZzavCGPecHCoN0ZznnjQ1Yj2u?=
 =?us-ascii?Q?utamU7fneNgVD2rWJbpV5NxW+XyYVflFPKa529Hn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f806ee4-4326-45e2-79e6-08dbf1412b63
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:10:40.7736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqSzRYknoJdjHiGX0z3ucmQf7nPG+CbmvO67yHZIMSADsmvKJUkHoPYZETTpR9Ko
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5484

This function can be called by drivers in their probe function if they
want to parse their own ID table, almost always because the driver
supports a multi-instance configuration and needs to extract the list of
iommu_driver's and data from the ID into some internal format.

The core code will find the iommu_driver for each ID table entry and
validate that it matches the driver's ops. A driver provided function is
called to handle the (iommu_driver, ID) tuple.

Before calling this function the driver should allocate its per-driver
private data and pass it through the opaque cookie priv argument.

Driver's should follow a typical pattern in their probe_device:

 static int apple_dart_of_xlate(struct iommu_device *iommu,
                                struct of_phandle_args *args, void *priv);
[..]

	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
 	if (!cfg) return ERR_PTR(-ENOMEM);

	ret = iommu_of_xlate(pinf, &apple_dart_iommu_ops, 1,
			     &apple_dart_of_xlate, cfg);
	if (ret) goto err_free;

	dev_iommu_priv_set(dev, cfg);
        return &??->iommu; // The first iommu_device parsed

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/of_iommu.c     | 58 ++++++++++++++++++++++++++++++++++++
 include/linux/iommu-driver.h | 13 ++++++++
 2 files changed, 71 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 37af32a6bc84e5..9c1d398aa2cd9c 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -285,6 +285,8 @@ struct parse_info {
 	struct iommu_probe_info *pinf;
 	const struct iommu_ops *ops;
 	int num_cells;
+	iommu_of_xlate_fn xlate_fn;
+	void *priv;
 };
 
 static struct iommu_device *parse_iommu(struct parse_info *info,
@@ -336,3 +338,59 @@ struct iommu_device *__iommu_of_get_single_iommu(struct iommu_probe_info *pinf,
 	return iommu_fw_finish_get_single(pinf);
 }
 EXPORT_SYMBOL_GPL(__iommu_of_get_single_iommu);
+
+static int parse_of_xlate(struct of_phandle_args *iommu_spec, void *_info)
+{
+	struct parse_info *info = _info;
+	struct iommu_device *iommu;
+
+	iommu = parse_iommu(info, iommu_spec);
+	if (IS_ERR(iommu))
+		return PTR_ERR(iommu);
+	info->pinf->num_ids++;
+	return info->xlate_fn(iommu, iommu_spec, info->priv);
+}
+
+/**
+ * iommu_of_xlate - Parse all OF ids for an IOMMU
+ * @pinf: The iommu_probe_info
+ * @ops: The ops the iommu instance must have
+ * @num_cells: #iommu-cells value to enforce, -1 is no check
+ * @fn: Call for each Instance and ID
+ * @priv: Opaque cookie for fn
+ *
+ * Drivers that support multiple iommu instances must call this function to
+ * parse each instance from the OF table. fn will be called with the driver's
+ * iommu_driver instance and the raw of_phandle_args that contains the ID.
+ *
+ * Drivers that need to parse a complex ID format should also use this function.
+ */
+int iommu_of_xlate(struct iommu_probe_info *pinf, const struct iommu_ops *ops,
+		   int num_cells, iommu_of_xlate_fn fn, void *priv)
+{
+	struct parse_info info = { .pinf = pinf,
+				   .ops = ops,
+				   .num_cells = num_cells,
+				   .xlate_fn = fn,
+				   .priv = priv };
+
+	pinf->num_ids = 0;
+	return of_iommu_for_each_id(pinf->dev, pinf->of_master_np,
+				    pinf->of_map_id, parse_of_xlate, &info);
+}
+EXPORT_SYMBOL_GPL(iommu_of_xlate);
+
+/*
+ * Temporary approach to allow drivers to opt into the bus probe. It configures
+ * the iommu_probe_info to probe the dev->of_node. This is a bit hacky because
+ * it mutates the iommu_probe_info and thus assumes there is only one op in the
+ * system. Remove when we call probe from the bus always anyhow.
+ */
+void iommu_of_allow_bus_probe(struct iommu_probe_info *pinf)
+{
+	if (pinf->is_dma_configure)
+		return;
+	pinf->of_master_np = pinf->dev->of_node;
+	pinf->is_dma_configure = true;
+}
+EXPORT_SYMBOL_GPL(iommu_of_allow_bus_probe);
diff --git a/include/linux/iommu-driver.h b/include/linux/iommu-driver.h
index 597998a62b0dd6..622d6ad9056ce0 100644
--- a/include/linux/iommu-driver.h
+++ b/include/linux/iommu-driver.h
@@ -60,9 +60,16 @@ iommu_device_from_fwnode_pinf(struct iommu_probe_info *pinf,
 			      struct fwnode_handle *fwnode);
 struct iommu_device *iommu_fw_finish_get_single(struct iommu_probe_info *pinf);
 
+typedef int (*iommu_of_xlate_fn)(struct iommu_device *iommu,
+				struct of_phandle_args *args, void *priv);
+void iommu_of_allow_bus_probe(struct iommu_probe_info *pinf);
+
 #if IS_ENABLED(CONFIG_OF_IOMMU)
 void of_iommu_get_resv_regions(struct device *dev, struct list_head *list);
 
+int iommu_of_xlate(struct iommu_probe_info *pinf, const struct iommu_ops *ops,
+		   int num_cells, iommu_of_xlate_fn fn, void *priv);
+
 struct iommu_device *__iommu_of_get_single_iommu(struct iommu_probe_info *pinf,
 						 const struct iommu_ops *ops,
 						 int num_cells);
@@ -71,6 +78,12 @@ static inline void of_iommu_get_resv_regions(struct device *dev,
 					     struct list_head *list)
 {
 }
+static inline int iommu_of_xlate(struct iommu_probe_info *pinf,
+				 const struct iommu_ops *ops, int num_cells,
+				 iommu_of_xlate_fn fn, void *priv)
+{
+	return -ENODEV;
+}
 static inline
 struct iommu_device *__iommu_of_get_single_iommu(struct iommu_probe_info *pinf,
 						 const struct iommu_ops *ops,
-- 
2.42.0


