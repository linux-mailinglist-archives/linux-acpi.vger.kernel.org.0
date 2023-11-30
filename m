Return-Path: <linux-acpi+bounces-1969-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC407FE6DE
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3EEE1C20B79
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB89C134A3
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="toxmJ++4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7265910F4;
	Wed, 29 Nov 2023 17:11:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaVXQ/GdiS4/MM01LjYPDi2mOY7bP8E+B4950aBfBhpifZHopNMCkzj0ZxxYzebYkjiyFR7ZxSsZdNq2W/FqkGlKoIu5/6T7AZHB9qn1ntQ80rwhpdmZg0NRwUz9t+qloicLLOizlIrr8dEi49bIxplOTzIsWdTaUbWlVALHshfrk9VaU7j7teeC/RAc6cFh5cOjgqkgps4nVq1J/5E9cC+NTa4FBj9ElRVn3+M2KxdtGwLz1O9NNF4B7qpnO3TV4QXXlRsSiU0t+8CnwciWLqvd3CcMpPJ7M97ZYsdz7INWwwdMgMCfm/k98tX7CFF66f7qdptACgsyp51LkpcKcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nT1eA7akm0ounCeP3DFqrDerCBMCleCaGNYkjXyX3iQ=;
 b=ElT/gvAKgmUdWDv0i5cSo2BsZNYXsXQ+RMVbxEiLl98I2aTuai/kfvVkkJkFlObkimXRIDnPsCz6F/VivlG5HMDlUaC++p4NwwarzSgeXS6Ncx0sFpPAOjRI/3ht0b7gUmSRpyVoPUqCyz3rbCuo5uASMW6RNTlWiVifj3APoY4IY1TV6g0cNxjQcvToRiCh9XpfMewONkhTUCAvdY8DMQdGM78qjt+4nHzaDLgZQEdoSIdE3b631bgvpLa/9oZ5nbdpgmn1khyILeH4kRSYw/IyuvVZN4US/DCmXY/tUD/SsBw8ieK+JC/ydO/GohDYx9iju0IFQNTb/y27SQxSjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nT1eA7akm0ounCeP3DFqrDerCBMCleCaGNYkjXyX3iQ=;
 b=toxmJ++4iznt30DF6x5fUhU13ZRwZ5HHE3qTyFXMVeAKZbnEr27UdqBR3i+anW0rx6qXEeEtDeMByHVRrE//NB0cfGMxYzcdimqZlX+KXjT/Tcot9bFFojwqtFdPllXsbvC0WIaDzzuUkZd4fISWcQFxOITx7ImGBt5lEgiwQL8O7nsPnJKatbN7fuicXU8aWRHRJInQfEtr/KSYY1QPSi7rKA0eUb/EK0hdrQx6ax5IRSXjheFsTstAy+xAKVKVNeHG9+BKAzRas1jEWFVdUgIlJAgofcd4Ig5/+aqUEAH6KOyvzcKWefrzOABlDOULq+c7JKJmAObpTobP+TTKrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5484.namprd12.prod.outlook.com (2603:10b6:510:eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 01:10:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:10:53 +0000
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
Subject: [PATCH 29/30] iommu: Check for EPROBE_DEFER using the new FW parsers
Date: Wed, 29 Nov 2023 21:10:36 -0400
Message-ID: <29-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR16CA0037.namprd16.prod.outlook.com
 (2603:10b6:805:ca::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5484:EE_
X-MS-Office365-Filtering-Correlation-Id: 66171c9d-1f9d-4572-1f12-08dbf1412c43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ro9hozDsvDBRaqlWAIL453b6IWMtgq8sY73KEXnqBZLfQpodT7lVWkT0fTVHZRCGGHKkSPIwF1yX2Zdu9ChKODkdTWQPKwkE/WCGag0LscHeCf0EudEAla8bJNB95BWP9EGT3TN1aZwo7jTJ+BbDOBMXwhtufEK0pJ1la7h5YvQEOZdFlNGKL40JgVvJJBd+3Or1vrItw+Wr9Fz6XSplY/OU/k3u/uXFNB58Q/AxT2bWHQY5eXyS3sOQcIH5+DC969Nl7HaqHV4WlmUjD+mYJiGGt77A7/kFPfXeY5fDKNeVAIWrN2GtGxKQS9Ee5LemaMBDTjJ+5tTFtuxEH4njgEhz7EZUpAnQIkpJ2/8MVmQYrvn1bXBB8UtSlsjuUM/vjF5TXv3t75V0EBbHsVzLcU7AXZIPxLq8cB4CMygGEHsSPJ2omBAd/XkxV08YT6r/ux6eegC61GXBei+SLo5FvFzeDSNXGRijEobYQP93CnubciRjjNUJhdfVoVHT/LbhRN+Dgq6MUQxz0BCXYmgtqvUYA9gKshw+OYqY+lr3gBI+OPtd7Bke0pj/O+FRWSMQO7MseXVDlqZB4BsX3P6f/dZiQ6NuLBvmd6bwTh8iMb6pNxLYl6NaOBZbII51mQO7M+pPsPDZYII/M+iky53vsQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1191002)(8936002)(110136005)(8676002)(316002)(66556008)(4326008)(86362001)(66476007)(6486002)(478600001)(66946007)(41300700001)(36756003)(921008)(7416002)(7366002)(2906002)(7406005)(5660300002)(38100700002)(2616005)(6512007)(6506007)(6666004)(83380400001)(26005)(202311291699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rhShRIuRt0dRfKgjQd/aw6Vof4e9hin0iG++ZhmNipGFMit3k+Qk7n1F0me6?=
 =?us-ascii?Q?BgKgbo5dBfl8Jcr7Jx1X8k1R4WKspA4U3a6Ltf/SCTrjzSYMYM5mFpb8eLMa?=
 =?us-ascii?Q?ZnT00nVPn+5ZNKk2IAYr1HtJjnbJgKCTcWyEEU9ErlGwo35dmj5uLNaAR9Jp?=
 =?us-ascii?Q?sNIYmTFLCOCfHSCRtLLJKCBXa4r6eqcPFZLopZO2Px0UGYZlaDy4LcaQlTHs?=
 =?us-ascii?Q?70JTj+fm4g+T1mMJW4qMr1tFrE+q8VadUUFFBS9ZyT/a2ZbPWTkAlYNLxbu9?=
 =?us-ascii?Q?DE/mTWoj2/93i4ccnixcab6U/zVjoved/TWvjIxGXnjBF6NHjnd0JUGCPv8u?=
 =?us-ascii?Q?e0AtzFqIUJUElJ/09GHdrF8vNQJuptZ3/oXu8F0g4/aiA1FRBnEmZW/DwFuP?=
 =?us-ascii?Q?zIgAjlC239tG5co8ziMpKz17OnwSDIxPehpPpe9F/56B0xWHpcL7WnXFgh85?=
 =?us-ascii?Q?tlB1ADhClzU6wcrWd5y9Qm2GbuLFf9s7Lr4y/vhFgxFSw/780y8CZ/Qn8KvY?=
 =?us-ascii?Q?zRo4hJCLhDw6iUfNf5a0pqqetaZJo+bjvW+Of6DhyunIIMGPxI2iU8JNYMhw?=
 =?us-ascii?Q?OdVD97vDE8cXjrNUZ94u0r0MahGNlVtA+7IJ/QvWExsMvdPtP0I/hHl/NcCg?=
 =?us-ascii?Q?NQPScc/T2iRuJ2vU2FST44FutXPZ+fUexcTAJSe5VplFv1iKLh1Dqx8IO/uV?=
 =?us-ascii?Q?0xQUPBuV25giob1FBTvWOpVsZhu1yGmiOtd/Q2XFE0gJaiUEXFqGTVQFJWEH?=
 =?us-ascii?Q?d47FbSr+SNgEZT+9Q+/Pp9EvwOksG2XLvGlkUcELQD9lsUykmopSmgFuP6YE?=
 =?us-ascii?Q?lEvyyS+CcZL1dJZ6AoKaEUHLJK1Nhd9nHezWmaiwJXUpJUzkL7vWU0KOYfBt?=
 =?us-ascii?Q?/ABHdbGqCSJCXKR2FqR7gRxOiYuPAgPcMAGX9XmieYkYXFeWbk9YLUW8IDKQ?=
 =?us-ascii?Q?S+f74WLDlLBO/4kePRag6k9yKZaP7k0fj7qprxynEp/MJUrfebclcSSFcuMc?=
 =?us-ascii?Q?d1gJ7MGUyWRjKdlU3WMR5z5v2IUClLplM89W+KZQgxQHV+Wh7moy/IObiKkI?=
 =?us-ascii?Q?7GUytZgCZrpOLqPHl3ZXjL7HknHO+437sPQu+CvyXBpWdKz4EiIaM+hjUUls?=
 =?us-ascii?Q?VelBvi0z/GvHBaxcvmkzPxte4tiGaskSkbr9PsdA7WuOk2Tc+sXJIENyCeTC?=
 =?us-ascii?Q?wmVAanBLVk6tsI73zVPsDGfZ3HUjk/M1PlrdK9X65d6+62e2O4JtawkCDCoO?=
 =?us-ascii?Q?j1xq5IZzeX039+NH60z534g+X72fG6yhaiFVIMZ72KdHWdULgiWG0fxbOsPj?=
 =?us-ascii?Q?F5NVseahXOfyY1WQ0wQXgjqyELgP/Bei7e50KsTQbGj1UUqPDANLRYMR1YAA?=
 =?us-ascii?Q?egI9tnrf1Vy5xvSFrH419F4t9vAFXJs1tKztihpkQlKyW8HghEqxk3q/Y/1r?=
 =?us-ascii?Q?UDGNxV8Cq6wxC+oDjRH5PIcBvtnVXq8n61c02zDGhk603W5bbocMOHmpqXje?=
 =?us-ascii?Q?ampI8g6YSTe8WPoTYTnggi5nTVBbRUe/a/vjucky/xgF9KhEE1Wa6hXQC2Vv?=
 =?us-ascii?Q?7NmPEXh0aya6OuytG/Icqn1IyqqFe4Hd8kjCPNc5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66171c9d-1f9d-4572-1f12-08dbf1412c43
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:10:42.2863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQW+7/rWN+5UNjQSBGx7Wfh2MeJa0w1Iwn+xkWVGL56l/io1FLqeKQfOEjKa/rdP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5484

The last thing the iommu_fwspec logic is doing is to generate an
EPROBE_DEFER if we don't have the iommu driver loaded. The OF side does
this by checking for the iommus OF property and the ACPI side does this by
checking both VIOT and IORT tables.

Duplicate this behavior. If probing gets -ENODEV and we are under a
dma_configure then ensure that all the applicable FW parsers are given a
chance to run.

Keep track of any parsers that may have run during the probe ops call and
don't do them again.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c        | 51 +++++++++++++++++++++++++++++++++---
 drivers/iommu/iort_iommu.c   |  1 +
 drivers/iommu/of_iommu.c     |  2 ++
 drivers/iommu/viot_iommu.c   |  1 +
 include/linux/iommu-driver.h |  3 +++
 5 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 54e3f14429b3b4..c76edc9061f123 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -518,6 +518,48 @@ static void iommu_deinit_device(struct device *dev)
 	dev_iommu_free(dev);
 }
 
+/*
+ * When being called from dma_configure it is necessary to check if an ENODEV
+ * result indicates that we haven't loaded the driver yet. Since we may not have
+ * any drivers registered yet we have no way to predict what kind of FW
+ * description could need to be parsed. Check the widely used ones we have
+ * common parsers for.
+ *
+ * Drivers that use FW descriptions other than these common ones (AMD, Intel,
+ * etc) must probe the iommus during early boot otherwise they will have
+ * problems with probe ordering.
+ *
+ * The *_get_single_iommu() implementations will generate EPROBE_DEFER if they
+ * detect a FW description with no registered iommu driver which will cause
+ * the driver binding from dma_configure to abort and try later.
+ */
+static int iommu_fw_check_deferred(struct iommu_probe_info *pinf)
+{
+	struct iommu_device *iommu;
+
+	if (!pinf->is_dma_configure)
+		return -ENODEV;
+
+	if (!pinf->cached_checked_of && pinf->of_master_np) {
+		iommu = __iommu_of_get_single_iommu(pinf, NULL, -1);
+		if (iommu != ERR_PTR(-ENODEV))
+			return PTR_ERR(iommu);
+	}
+
+	if (!pinf->cached_checked_iort && pinf->is_acpi) {
+		iommu = __iommu_iort_get_single_iommu(pinf, NULL, NULL);
+		if (iommu != ERR_PTR(-ENODEV))
+			return PTR_ERR(iommu);
+	}
+
+	if (!pinf->cached_checked_viot && pinf->is_acpi) {
+		iommu = __iommu_viot_get_single_iommu(pinf, NULL);
+		if (iommu != ERR_PTR(-ENODEV))
+			return PTR_ERR(iommu);
+	}
+	return -ENODEV;
+}
+
 DEFINE_MUTEX(iommu_probe_device_lock);
 
 static int iommu_find_init_device(struct iommu_probe_info *pinf)
@@ -540,7 +582,7 @@ static int iommu_find_init_device(struct iommu_probe_info *pinf)
 				return ret;
 		}
 	}
-	return -ENODEV;
+	return iommu_fw_check_deferred(pinf);
 }
 
 static int __iommu_probe_device(struct iommu_probe_info *pinf)
@@ -580,10 +622,13 @@ static int __iommu_probe_device(struct iommu_probe_info *pinf)
 	if (dev->iommu_group)
 		return 0;
 
-	if (ops)
+	if (ops) {
 		ret = iommu_init_device(pinf, ops);
-	else
+		if (ret == -ENODEV)
+			return iommu_fw_check_deferred(pinf);
+	} else {
 		ret = iommu_find_init_device(pinf);
+	}
 	if (ret)
 		return ret;
 
diff --git a/drivers/iommu/iort_iommu.c b/drivers/iommu/iort_iommu.c
index 9a997b0fd5d5f1..2174ae477486a6 100644
--- a/drivers/iommu/iort_iommu.c
+++ b/drivers/iommu/iort_iommu.c
@@ -88,6 +88,7 @@ __iommu_iort_get_single_iommu(struct iommu_probe_info *pinf,
 		params = &unused_params;
 
 	iommu_fw_clear_cache(pinf);
+	pinf->cached_checked_iort = true;
 	err = iort_iommu_for_each_id(pinf->dev, pinf->acpi_map_id, params,
 				     parse_single_iommu, &info);
 	if (err)
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 6f6e442f899ded..463d17ab5057d6 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -367,6 +367,7 @@ struct iommu_device *__iommu_of_get_single_iommu(struct iommu_probe_info *pinf,
 		return ERR_PTR(-ENODEV);
 
 	iommu_fw_clear_cache(pinf);
+	pinf->cached_checked_of = true;
 	err = of_iommu_for_each_id(pinf->dev, pinf->of_master_np,
 				   pinf->of_map_id, parse_single_iommu, &info);
 	if (err)
@@ -412,6 +413,7 @@ int iommu_of_xlate(struct iommu_probe_info *pinf, const struct iommu_ops *ops,
 				   .priv = priv };
 
 	pinf->num_ids = 0;
+	pinf->cached_checked_of = true;
 	return of_iommu_for_each_id(pinf->dev, pinf->of_master_np,
 				    pinf->of_map_id, parse_of_xlate, &info);
 }
diff --git a/drivers/iommu/viot_iommu.c b/drivers/iommu/viot_iommu.c
index e35bd4099e6c6a..32abda73eb3b6c 100644
--- a/drivers/iommu/viot_iommu.c
+++ b/drivers/iommu/viot_iommu.c
@@ -61,6 +61,7 @@ __iommu_viot_get_single_iommu(struct iommu_probe_info *pinf,
 		return ERR_PTR(-ENODEV);
 
 	iommu_fw_clear_cache(pinf);
+	pinf->cached_checked_viot = true;
 	err = viot_iommu_for_each_id(pinf->dev, parse_single_iommu, &info);
 	if (err)
 		return ERR_PTR(err);
diff --git a/include/linux/iommu-driver.h b/include/linux/iommu-driver.h
index 8f7089d3bb7135..aa4cbf0cb91907 100644
--- a/include/linux/iommu-driver.h
+++ b/include/linux/iommu-driver.h
@@ -50,6 +50,9 @@ struct iommu_probe_info {
 	bool is_dma_configure : 1;
 	bool is_acpi : 1;
 	bool cached_single_iommu : 1;
+	bool cached_checked_of : 1;
+	bool cached_checked_iort : 1;
+	bool cached_checked_viot : 1;
 };
 
 static inline void iommu_fw_clear_cache(struct iommu_probe_info *pinf)
-- 
2.42.0


