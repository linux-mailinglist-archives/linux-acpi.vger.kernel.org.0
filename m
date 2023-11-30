Return-Path: <linux-acpi+bounces-1972-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB037FE6E9
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 697BFB20F51
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB3A134A7
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XUtkMqgI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04F910DD;
	Wed, 29 Nov 2023 17:11:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8h+zVuDBdsEtD8H6TCgJA2MwLSAd/FjtymvxTMAqBuGb59SJb8zhULoxjPFymw/rSehI+9F97nRW90sYQl9orND7GYsSev+18N6mSFpbL4hyo9AoCDYHfrvZQrXO0h1U88QGcVw/2G8218vdEaTCv5i1px80jSALeQtnbeUk2Q3H88vwG5G0LO0FAu6o7s0nt3V0yxAC5SdGwS364wkd0HrAdKjqtJZqBZRHNLZw7uesqzKAKYw2aRTbAj2Ieo55XwT6C+JHogQqb7G/ATWBk7OF8qWkRzVwz1LQTcluBHV7JzsBiDO95gS2+jO9cvlXH3jEwuBs1hXzjo7uJ0WIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwf/8BLazV78Ujjm7q8f4RCgFTKfbzZbel/RjT7b+os=;
 b=DTpFkSYFrAF65h7jTbnVQ4ztMHgT/lA6WKdxLpLCU27OwAo5qKbaeqk6SZzi4vFvpCXYgBR9Q8ZHQCWzl13XCc+3DZeKee6Y//PLgpGgfstRV6S1IXk4598LaAjIvltNSH5KnBRIGN4HEysDYU/xbvd4bTOrnBQ9Dst1/8FVMG+gAscXvoaDFipPgC+KKC+AcPBoLaqgTr9cnOw6SnBPFMpnGk0p8qOW3q8vQtXXI5fpYQl9Hizp5KPfeWl3EjeBxW5skw5ScMprHZzXFIv11Ut/DbGTyaW5jk8iLwEmFsKWCUxyL2Rji+I4s9N6a/lZEIR0l7VDpM2bW7o/Ub3Bzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwf/8BLazV78Ujjm7q8f4RCgFTKfbzZbel/RjT7b+os=;
 b=XUtkMqgIGrf6ZOF3tXgS5FIQKR92exTcBtJzon6HxXDyLHQEWjyPB8XRh9c0wR1fr0ut4L2lW5IUwH4HEicNey7hsZel1YQxgWV7XgL4JwMloeI+L8SrGlJ4JBuGhMGIjmJLTfXiHsOJnCTfYPEf+h/1v1Hp71XFzqYl4T6IJe0A9KRDucrrFS9DHo61m8US4ZgPjVhGzLLJMPjCs4zgBhbR8rqJ4D4m5Q1+vKywoUMzrf0HVIDQPuyzfQtbpOUs2aTii23iUU1AIsNpoBBkQWj6Xd0wFY47k6rc6DP6fwf4fjweH4/8RKcSWHZzZgCb786HCs2HFl/3BQNUkvyGqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5484.namprd12.prod.outlook.com (2603:10b6:510:eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 01:10:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:10:54 +0000
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
Subject: [PATCH 08/30] iommu/of: Add iommu_of_get_single_iommu()
Date: Wed, 29 Nov 2023 21:10:15 -0400
Message-ID: <8-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:806:130::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5484:EE_
X-MS-Office365-Filtering-Correlation-Id: 2af03d14-c665-4974-408c-08dbf1412c44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/p7yVX5PvhbJhf+jSbA+Lp4ito6qpWC6FnoepOt4fRU5t47ibWxL7mKVhMdvVdnpoEZ4tvcCMBBuwCovgUZ0f6yy6UubmKuhDDnkNcRDIz8fBGQRIEBUoXGtJJt9xLQSux0Ibc28YJGlgt6xPc2xj/xfnJwO7jh2kozedCunqXH5SgULqr6ZiSMgsi8mmeXqJWa+sCWdCWjfa5FR+CPAgQ/S49LH1DSUD/dPBc3r1PbOtCJKjh7DDnpcTHXzPYibyp5OqSJzrrc4PhMdEpzHPL2PBwYMDSuSTtc0T1Kk/zzfBXBU3CL5SQpJJdqBDkwonZkDNbPQq46VIL1Hb0fH3XXWtggoNkuj18bsoy0djpaFs8/yt9DnDfMkw3Iwiwes/K0t76HydzDO1YD0aT6bG/2p+RmgS3SAvCieMkfwPq1JqO+851N8UfIj7wtrtfEoa3B1i62FZyyCL4PWPGHK+L3d78IaclUK6xpwnonmACW4K+ElAx6qcbe1VbI9aMkWGD3RJr1CteN/NLoyfmecgiHSbISPZJOtEgociMYJJrb9SVji974A6yLlEM6aRn4iK+FsCQu8XQv/mBOfDAoCk3o7LJ8qSBjL8SkpWwQfikkLSF/POblBw5gQJLTuaeY355WH64D54M9TbbnogTDG1YDY8sgaLvFfZh0GIpUKF5A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1191002)(8936002)(110136005)(8676002)(316002)(66556008)(4326008)(86362001)(66476007)(6486002)(478600001)(66946007)(41300700001)(36756003)(921008)(7416002)(7366002)(2906002)(7406005)(5660300002)(38100700002)(2616005)(6512007)(6506007)(6666004)(83380400001)(26005)(202311291699003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QCwBEix9KdHo9LRLkFEksaEnE1WvxAmGv8Vwjg+oX8rpqxnYUNmOHHKN7ILg?=
 =?us-ascii?Q?SBK8kxGJLoT7nh5SJUq1WgXeFsrNQT1O5Jpp2jYvOAwlmyhb2oRxaEc7JGZ/?=
 =?us-ascii?Q?szraGxa4XFHHdvih4kGr3zs5C5jDKRVuFX2RF8/WWqWJJa78ofIqnItMakLo?=
 =?us-ascii?Q?WDAqPs/8NfwCkTGv7UF0zbrntBJNzsYwxmTdl62V+SxDBx1pOQbhKDIougJp?=
 =?us-ascii?Q?8nUMduriGDcKlpkwhZIZs3UlafUgJgrBgTMBIteOb2E2mvBww29l6oxaAmNO?=
 =?us-ascii?Q?OYQ0a6o52wR/FzfoLzze9PgInnbEPYcoAcW0/TWsW2ffbMpbRGFx6NwbmgaR?=
 =?us-ascii?Q?W8Q6Gthmt+JL1ofKxDTlh9J1ON8q30trpwA97USMPKki5HV0d5RAk0XQtKIF?=
 =?us-ascii?Q?NUF5H/KUk3g2MqSG8wi2OSVX6j/uJshVgPdt1LwdClpa4RrleDD/BOs8vOak?=
 =?us-ascii?Q?TS7lIcspopO8ONkBXwki2GDQ0tV9QJxwlUkzZaqh2NaCZwqxTLDK43U/5a++?=
 =?us-ascii?Q?kEpSO8y9zS5bOST43bxMyNBeRYlgdTiQcF8R46BKub8AUK1rNFeckhYyvWqb?=
 =?us-ascii?Q?OhVaiU3Nu9USjkoUI3TVKcYkEurbTqn7pcYhdsj3jVU14U9IJuxKreunOBx3?=
 =?us-ascii?Q?ukKw4s2zhSUPA+ELJ+aBbtfxOX37Tcd1Of3pge3aYt/5c/2F68FPfxXpiv25?=
 =?us-ascii?Q?Jj2eK3/0DMXqGNFpqDElV60E1dF/lV3HiGh9DN2d6xGMDlSmdBnAIMk9Zkd7?=
 =?us-ascii?Q?bHLbnybYltUcgVQ2gkRba1W5TniN9lruGB17YGtgljrE1QJ7SQU5TNJBEe78?=
 =?us-ascii?Q?GAKZ3rtba/p9BHmiYHK66UITBfkFPK2Wrsq17rBEB28lshRb08i9F7OYCkI5?=
 =?us-ascii?Q?EQPjt2qcIZb0m04GFKFYdSx8bKXZ5kXsM7nNhNv1noCbKl5ivgpRS+ppHtN+?=
 =?us-ascii?Q?9CwJpgGhXLg9QEra0iS46pEuG+VutDMPnBgpQU/3U/JcJnv+tAD+U2VmLGam?=
 =?us-ascii?Q?Jmu6u55vBR6D7TzdEmu984czixNe/9w8SkWIXEn2twIQTlNSk+dRi28hXN7H?=
 =?us-ascii?Q?OmbxulLkx21utdxfu9F8Gwu3b1s7fQeeBwQCYoOZKptT4GvwrNwjoSE11adz?=
 =?us-ascii?Q?SXvOTF1iemvUzjyNL0KKtGYjja9qLoSUZ1rn5ojrD756zQKFFlbJw2SwTSq6?=
 =?us-ascii?Q?cpkM7PNro/zGhVxbhpyAG7D2sOxo2KQaOMsM9a8CrgjHV1OVaz6p45790y5Q?=
 =?us-ascii?Q?GmmNuklwPxOBUXWw0biQzI5P5oOPazXda+bUIRgNCXdLvIKhpTSpOJ34o2Cf?=
 =?us-ascii?Q?bhUQYmuBjumFN37hpLt9RkpZoej4+gGNoGZHuF/q25VFdET7/e/F0v58Wxx3?=
 =?us-ascii?Q?PKs4QxHJGUup/bRznmrtiLNOh47htWo0k6cOUMxceiVXzEnhpZwOr56g7stf?=
 =?us-ascii?Q?orgZFK5kFWmqRs1Qk7EtHrBxOh36OMcQp1AVOPVa5jKmihDx3rE5+dS4MJnN?=
 =?us-ascii?Q?73z18Y1eIXHb9cFaCT2CkMhRqdA+SqqQNeicHpK0dTrvNIs9eMbmufRDj1de?=
 =?us-ascii?Q?L9qhHSE6eqxxeVijkHJ04Gme0Ap+b0rEgm7Ne1S3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af03d14-c665-4974-408c-08dbf1412c44
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:10:42.2995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NR5cfhMwLhdbnNuFdehhk6uCBjt3FpxSFXTHhABOZa+SD093yMXE4FbPKcL1P5sg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5484

This function can be called by drivers in their probe function to return a
single iommu_device instance associated with the current probe.

All drivers need a way to get the iommu_device instance the FW says the
device should be using. Wrap the function with a macro that does the
container_of().

The driver indicates what instances it accepts by passing in its ops.

num_cells is provided to validate that the args are correctly sized.

This function is all that is required by drivers that only support a
single IOMMU instance and no IDs data. Driver's should follow a typical
pattern in their probe_device:

	iommu = iommu_of_get_single_iommu(pinf, &rk_iommu_ops, -1,
					  struct rk_iommu, iommu);
	if (IS_ERR(iommu)) return ERR_CAST(iommu);

	data = kzalloc(sizeof(*data), GFP_KERNEL);
	if (!data) return ERR_PTR(-ENOMEM);
	[..]
	dev_iommu_priv_set(dev, data);
        return &iommu->iommu;

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/acpi/scan.c          |  1 +
 drivers/iommu/iommu.c        | 52 ++++++++++++++++++++++
 drivers/iommu/of_iommu.c     | 59 +++++++++++++++++++++++++
 include/linux/iommu-driver.h | 85 ++++++++++++++++++++++++++++++++++++
 4 files changed, 197 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 9c13df632aa5e0..de36299c3b75bf 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1570,6 +1570,7 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 	const struct iommu_ops *ops;
 	struct iommu_probe_info pinf = {
 		.dev = dev,
+		.is_dma_configure = true,
 	};
 
 	/* Serialise to make dev->iommu stable under our potential fwspec */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 45e6543748fd46..ca411ad14c1182 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3015,6 +3015,58 @@ struct iommu_device *iommu_device_from_fwnode(struct fwnode_handle *fwnode)
 	return NULL;
 }
 
+/*
+ * Helper for FW interfaces to parse the fwnode into an iommu_driver. This
+ * caches past search results to avoid re-searching the linked list and computes
+ * if the FW is describing a single or multi-instance ID list.
+ */
+struct iommu_device *
+iommu_device_from_fwnode_pinf(struct iommu_probe_info *pinf,
+			      const struct iommu_ops *ops,
+			      struct fwnode_handle *fwnode)
+{
+	struct iommu_device *iommu = pinf->cached_iommu;
+
+	if (!pinf->num_ids)
+		pinf->cached_single_iommu = true;
+
+	if (!iommu || iommu->fwnode != fwnode) {
+		iommu = iommu_device_from_fwnode(fwnode);
+		if (!iommu)
+			return ERR_PTR(
+				driver_deferred_probe_check_state(pinf->dev));
+		pinf->cached_iommu = iommu;
+		if (pinf->num_ids)
+			pinf->cached_single_iommu = false;
+	}
+
+	/* NULL ops is used for the -EPROBE_DEFER check, match everything */
+	if (ops && iommu->ops != ops) {
+		if (!pinf->num_ids)
+			return ERR_PTR(-ENODEV);
+		dev_err(pinf->dev,
+			FW_BUG
+			"One device in the FW has iommu's with different Linux drivers, expecting %ps FW wants %ps.",
+			ops, iommu->ops);
+		return ERR_PTR(-EINVAL);
+	}
+	return iommu;
+}
+
+struct iommu_device *iommu_fw_finish_get_single(struct iommu_probe_info *pinf)
+{
+	if (WARN_ON(!pinf->num_ids || !pinf->cached_iommu))
+		return ERR_PTR(-EINVAL);
+	if (!pinf->cached_single_iommu) {
+		dev_err(pinf->dev,
+			FW_BUG
+			"The iommu driver %ps expects only one iommu instance, the FW has more.\n",
+			pinf->cached_iommu->ops);
+		return ERR_PTR(-EINVAL);
+	}
+	return pinf->cached_iommu;
+}
+
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops)
 {
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 20266a8edd5c71..37af32a6bc84e5 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -138,6 +138,9 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 {
 	struct iommu_probe_info pinf = {
 		.dev = dev,
+		.of_master_np = master_np,
+		.of_map_id = id,
+		.is_dma_configure = true,
 	};
 	struct iommu_fwspec *fwspec;
 	int err;
@@ -277,3 +280,59 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 #endif
 }
 EXPORT_SYMBOL(of_iommu_get_resv_regions);
+
+struct parse_info {
+	struct iommu_probe_info *pinf;
+	const struct iommu_ops *ops;
+	int num_cells;
+};
+
+static struct iommu_device *parse_iommu(struct parse_info *info,
+					struct of_phandle_args *iommu_spec)
+{
+	if (!of_device_is_available(iommu_spec->np))
+		return ERR_PTR(-ENODEV);
+
+	if (info->num_cells != -1 && iommu_spec->args_count != info->num_cells) {
+		dev_err(info->pinf->dev,
+			FW_BUG
+			"Driver %ps expects number of cells %u but DT has %u\n",
+			info->ops, info->num_cells, iommu_spec->args_count);
+		return ERR_PTR(-EINVAL);
+	}
+	return iommu_device_from_fwnode_pinf(info->pinf, info->ops,
+					     &iommu_spec->np->fwnode);
+}
+
+static int parse_single_iommu(struct of_phandle_args *iommu_spec, void *_info)
+{
+	struct parse_info *info = _info;
+	struct iommu_device *iommu;
+
+	iommu = parse_iommu(info, iommu_spec);
+	if (IS_ERR(iommu))
+		return PTR_ERR(iommu);
+	info->pinf->num_ids++;
+	return 0;
+}
+
+struct iommu_device *__iommu_of_get_single_iommu(struct iommu_probe_info *pinf,
+						 const struct iommu_ops *ops,
+						 int num_cells)
+{
+	struct parse_info info = { .pinf = pinf,
+				   .ops = ops,
+				   .num_cells = num_cells };
+	int err;
+
+	if (!pinf->is_dma_configure || !pinf->of_master_np)
+		return ERR_PTR(-ENODEV);
+
+	iommu_fw_clear_cache(pinf);
+	err = of_iommu_for_each_id(pinf->dev, pinf->of_master_np,
+				   pinf->of_map_id, parse_single_iommu, &info);
+	if (err)
+		return ERR_PTR(err);
+	return iommu_fw_finish_get_single(pinf);
+}
+EXPORT_SYMBOL_GPL(__iommu_of_get_single_iommu);
diff --git a/include/linux/iommu-driver.h b/include/linux/iommu-driver.h
index c572620d3069b4..597998a62b0dd6 100644
--- a/include/linux/iommu-driver.h
+++ b/include/linux/iommu-driver.h
@@ -13,25 +13,110 @@
 #endif
 
 #include <linux/types.h>
+#include <linux/err.h>
+#include <linux/slab.h>
 
+struct of_phandle_args;
 struct fwnode_handle;
+struct iommu_device;
+struct iommu_ops;
+
+/*
+ * FIXME this is sort of like container_of_safe() that was removed, do we want
+ * to put it in the common header?
+ */
+#define container_of_err(ptr, type, member)                       \
+	({                                                        \
+		void *__mptr = (void *)(ptr);                     \
+								  \
+		(offsetof(type, member) != 0 && IS_ERR(__mptr)) ? \
+			(type *)ERR_CAST(__mptr) :                \
+			container_of(ptr, type, member);          \
+	})
 
 struct iommu_probe_info {
 	struct device *dev;
 	struct list_head *deferred_group_list;
+	struct iommu_device *cached_iommu;
+	struct device_node *of_master_np;
+	const u32 *of_map_id;
+	unsigned int num_ids;
 	bool defer_setup : 1;
+	bool is_dma_configure : 1;
+	bool cached_single_iommu : 1;
 };
 
+static inline void iommu_fw_clear_cache(struct iommu_probe_info *pinf)
+{
+	pinf->num_ids = 0;
+	pinf->cached_single_iommu = true;
+}
+
 int iommu_probe_device_pinf(struct iommu_probe_info *pinf);
 struct iommu_device *iommu_device_from_fwnode(struct fwnode_handle *fwnode);
+struct iommu_device *
+iommu_device_from_fwnode_pinf(struct iommu_probe_info *pinf,
+			      const struct iommu_ops *ops,
+			      struct fwnode_handle *fwnode);
+struct iommu_device *iommu_fw_finish_get_single(struct iommu_probe_info *pinf);
 
 #if IS_ENABLED(CONFIG_OF_IOMMU)
 void of_iommu_get_resv_regions(struct device *dev, struct list_head *list);
+
+struct iommu_device *__iommu_of_get_single_iommu(struct iommu_probe_info *pinf,
+						 const struct iommu_ops *ops,
+						 int num_cells);
 #else
 static inline void of_iommu_get_resv_regions(struct device *dev,
 					     struct list_head *list)
 {
 }
+static inline
+struct iommu_device *__iommu_of_get_single_iommu(struct iommu_probe_info *pinf,
+						 const struct iommu_ops *ops,
+						 int num_cells)
+{
+	return ERR_PTR(-ENODEV);
+}
 #endif
 
+/**
+ * iommu_of_get_single_iommu - Return the driver's iommu instance
+ * @pinf: The iommu_probe_info
+ * @ops: The ops the iommu instance must have
+ * @num_cells: #iommu-cells value to enforce, -1 is no check
+ * @drv_struct: The driver struct containing the struct iommu_device
+ * @member: The name of the iommu_device member
+ *
+ * Parse the OF table describing the iommus and return a pointer to the driver's
+ * iommu_device struct that the OF table points to. Check that the OF table is
+ * well formed with a single iommu for all the entries and that the table refers
+ * to this iommu driver. Integrates a container_of() to simplify all users.
+ */
+#define iommu_of_get_single_iommu(pinf, ops, num_cells, drv_struct, member)  \
+	container_of_err(__iommu_of_get_single_iommu(pinf, ops, num_cells), \
+			  drv_struct, member)
+
+/**
+ * iommu_of_num_ids - Return the number of iommu associations the FW has
+ * @pinf: The iommu_probe_info
+ *
+ * For drivers using iommu_of_get_single_iommu() this will return the number
+ * of ids associated with the iommu instance. For other cases this will return
+ * the sum of all ids across all instances. Returns >= 1.
+ */
+static inline unsigned int iommu_of_num_ids(struct iommu_probe_info *pinf)
+{
+	return pinf->num_ids;
+}
+
+/*
+ * Used temporarily to indicate drivers that have moved to the new probe method.
+ */
+static inline int iommu_dummy_of_xlate(struct device *dev,
+				       struct of_phandle_args *args)
+{
+	return 0;
+}
+
 #endif
-- 
2.42.0


