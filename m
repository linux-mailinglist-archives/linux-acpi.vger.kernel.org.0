Return-Path: <linux-acpi+bounces-1974-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173637FE6F2
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04F8282023
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7496B13ADB
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s3wngbFb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3151ED71;
	Wed, 29 Nov 2023 17:11:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzoFXtmWBXzsPfBCwYx586ekbkp1+qHKZh6BimWR46HgE3gyyfriSfRSmbG0D7Y81af21i14Fb8iL7C844qkYPBInD1a0QbktcINRNQyzahGpaBP7t9ePgh5Vz4Dl2hdl0nWnWWRo42I/cmzD/v9srOCDfYtbW5rFzeCP8jJZ7sELg3zO/rVs5oY+sF9lZvm6A9gFxjcUMqxZL4cpfO8teEG/8GOtoHkHAuJ/506qsGY50R2g/IZFM8dp+9zvewetUIDZTK/RDRDXNODbQzIzBzyJx52xqVdeUZDfPOKGkTAeNJVFGgrDuzdAiK1Jj1g8kWswR8q7YlNohc5GoPfyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXP8tNimHbY+P2znJMc85H2A6muYmbWuFS7YeFp+CTM=;
 b=gB3u+y5bfwmO+JiD8taKxphua9V4E4F1xCTnY1IfV/EdVNzQ002T3/7jzz32vSZaflO+Rl3fp6OJLw/M70fLqrMj6L98QBOb/tVT6eG5QdfmHPz+pRXaOfBGUO1lGFEh8LjMToDAGgauwSR22fRCBq92PbrOlzatG9X5a6SlMPe4xe0e6Rnq+xllgRMF3a41u2sRhB31r9cSAKqSo3iUzIAjCN2qYTcmQm/C2FvLRqFuGhbjcQ8CXRMHEShicrKFI1rC4/+YrnCCEU04Rym/KeHXrvZHuOpn1M7lyN0JdUjCCfJ56hlMkkIPPbAvq0jdtYJaekgXE+5LYY0S1P7+lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXP8tNimHbY+P2znJMc85H2A6muYmbWuFS7YeFp+CTM=;
 b=s3wngbFbOoI2792SiKY/cUYh0g3S/j/PfpsXAVbdXLwe7wtU2iYmslRfI0pPSyDaYwjw+XNbPImOs0OJtaDhhr1Y+fX0bdqksGx6Tm72ntPFEMxVcMeXGh8Skb83zpt+tzNAULuPvtyeGRhGOYFthRIx1v3q+SJzi2ysXLrRLopngcbtLxlhqtabzYWoxKORAqW/xxK4lA2S0X0Zp3z9ymmJcne/TOuKM6leMWkT5AmS74ktBgH97DvW6mIzZs4Fq8uHIklV2+RBmkjXeCyD4OEaMlAI/8LuVkbBBELasb2mwNpdqFQh/u8+VE/KD3fsy194xsE6HPj5dW+amIbUtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 01:11:26 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:11:26 +0000
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
Subject: [PATCH 28/30] iommu: Call all drivers if there is no fwspec
Date: Wed, 29 Nov 2023 21:10:35 -0400
Message-ID: <28-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:806:130::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: f67500fe-40c5-4676-d4a3-08dbf1412d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kU3T7H5J57NLM9QajWOnU7z7Xu9y794iVNtOqReqjjMT9Tu3yv2lFF8WAgFzrOqUWvpglv1Igb3RhXi2xM94Vmx3ebqu31En5zdMgZdN2j6yCnaFCTlapBrEjZ07EFM02cLu5UlvXpr0O2YLeKQqySJlZPiFsZy6iPky8VAIaywxdG4vGtMxVL6Up4OzMueg6OGciJxgdCDn7Jbcn0ZUqHn3K1ym+q5+8vyrxsqmsFB1GWogzupFWDt4RGofVfAoS2bMJ9h+j/OlqIOZ0CcUv709vKKkqEIsu00l4IOoZmX6C5Zd3noH4KZSQ5tAfdJXpP5uiZBR3eX8cVBF0HAQCyY3Erel1ZQ0UzCBMLqd27W+pQvoKQ4CqvObpWlzzj3xtlt+jxiLwH+ZKkGyOeg7Gmnb018jPv6bkNLgPvGyE48yby4y2X43+C/mhKh9gib9m26cHq4bcioT+oSPmn90EvCigfgVy+3RpxEkuZ+9Er4LN91nrNVkLndQxMeBUneW/bnjVEPaAklk5VZZgViEQtZAqC6+wAKPyfQRp7dGgdwKpe0gAQSfo5tdmEBQE8GmA3Plk89UnM/zCCZBQgJoIkEAHk2ynbKiPI2fFEEsp6gsEOnFprXEbm5h9DHRPEffpcudc1+f/Lwiy5bAvwmgww==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(1191002)(2616005)(26005)(921008)(66476007)(66946007)(66556008)(7406005)(7366002)(7416002)(110136005)(2906002)(8676002)(4326008)(8936002)(86362001)(5660300002)(41300700001)(6506007)(6666004)(6512007)(36756003)(316002)(478600001)(6486002)(202311291699003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r3OsdJrBhVIA+ZSfZKD6MQxElvohXeb8xslb73RAKupEeYHmd/CydVrE2+CY?=
 =?us-ascii?Q?UsrVOF42DMuBW55zsqBMyZfs3OztqOw7he9GYAcFZWzjCohoE9tKzYE2FqeW?=
 =?us-ascii?Q?vjKPp6Nf2one0OYjZOr82gRrisxHrTSr9Wz8H6jRtEcoLRAqoQw45RzZytR6?=
 =?us-ascii?Q?L/qzh1ORcI0wqFwIdJX170WWoyymABvPtUsxx8ndY47CWtF9PDXc7JsI2VQn?=
 =?us-ascii?Q?MXPI+t7gfrNqy/b/junKEaltSde2B4oFoN+RLhhF75uEn07pd7Z2coRkUxMd?=
 =?us-ascii?Q?8jtnKfuJ+EmzimuXyl43yk4NgZdNRJIxG5ftLTVndNOGZYDDgoSiLn0KVlaB?=
 =?us-ascii?Q?bXH09SRjC8ktap8vOUrigULSwYkkQLkmFxNjTLO5phGmL302qpMNCuChIQoR?=
 =?us-ascii?Q?iB6fx6oSWImvMPRe38EFmoG1DBXN3S/EMjEmFAmabNOoACaTVUEbFxJs3nsx?=
 =?us-ascii?Q?K/o3M10UhlzCmkgMnapIZOgKG0YulADBN7a0hkP4/0uEqTS9ff8WxMJSqgpZ?=
 =?us-ascii?Q?GmWZMxlKu48TmxDe3lzvm6ZoUZAP+s+0afKgfKaC2BO01jB2pHrIqt5paOVU?=
 =?us-ascii?Q?cNLy/8GlmNsrgU3gST+fu1wP99Q4vsfs27xb/8hc8vKkQQTebLIKmy6YuOyp?=
 =?us-ascii?Q?0LWchuAsiIlCQ+ARMHJFND8/JjyoRIJCFzZCT5uVScLUPEAknF1G36sveW68?=
 =?us-ascii?Q?SYquR4aFSMqgGmustnm46nElOaMsD9JxKApJmpCuOyePfWsC1H6HBA5kiGxD?=
 =?us-ascii?Q?l+lSMhX36/lQO2hosmef4wv+g9eMH9WhInszOlcyv0kzlYohlobDGDn5g+3i?=
 =?us-ascii?Q?s3cpXZkmmdDjetyzZRH0jo+IInH+0CFZu5hnr70BgM1FomN4k4bxk72unbpx?=
 =?us-ascii?Q?u8US3TckRuZSna1CnHOL8/u69s+zlUY34gWeOi/JKrgKmj9rR9C6qKaqrh81?=
 =?us-ascii?Q?YNmpmk0t2S5nHsrUtHQvU/k30worvyMFLRgJIwKjV7S9jLDijlBR/meGUe0s?=
 =?us-ascii?Q?zE35nLA2KoFlQ2w7+rNGUKEd0nlUGYU3CVqHoRjtyaXBWFBSotVufp0RNMip?=
 =?us-ascii?Q?3TqoAzkCGfHDkl6Lj2Bn2xmbsA/+etx8sGi+KYVwdOQXrJV+8+Fe+LuRLLZM?=
 =?us-ascii?Q?dFIfS3Y7iVfYro+LjMjuudXkHKzTvz3ZmR1F7diUEGIsn0whZHpx928lNtBv?=
 =?us-ascii?Q?/o2F0ZXzp+bwI2VEpyrVMdViYLe9JmUzwJeCr5c6RMN4AQFWEtqRRGYZPE9U?=
 =?us-ascii?Q?6sTbxhAns2JwdjZEcW/AvwN7TkVInvdsF7ipvMh4W1WEMOcdJ57rbCqqZAb4?=
 =?us-ascii?Q?ZzKkwVo2nSC5h/Wycs/x4NtJddua7xgmfLB/mdUALnjhVLTkop+qUyI88cUB?=
 =?us-ascii?Q?F3xg2/6N0TbLQvfNtw0tl8p8OXQAHQJG9PzP4wygd2/lUT1RTkFxY/4hzYv1?=
 =?us-ascii?Q?MsbtpUn9s8N/txi65RSuNHz92nwSkUxFZX0DtV2L8vYXWKP7qFP9GDkgieHe?=
 =?us-ascii?Q?UG6FnvNnLSCgIDdL4W7N4/sHJn53Z8AX9avvGuRSJuKR8PK1kVhI9ts7sIUm?=
 =?us-ascii?Q?I716MAo0H1am2tjWz5DvuvRKDkLJNmFhmWnXwUhd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f67500fe-40c5-4676-d4a3-08dbf1412d51
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:10:43.9426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TEOSbs4TX0OsynOw7k+u1QMSzSAFEHuPp5BjKVlPQuf9rZ/slvmuhCDeEsWEh4zy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484

Now all the iommu drivers can self probe by checking the struct device to
see if it has an appropriate FW attached to it. We don't need the concept
of "global" drivers with a NULL fwspec, just invoke all the ops.

Real systems only have one ops, so this effectively invokes the single op
in the system to probe each device. If there are multiple ops we invoke
each one once, and drivers that don't understand the struct device should
return -ENODEV.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 59 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7468a64778931b..54e3f14429b3b4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -241,6 +241,26 @@ static int remove_iommu_group(struct device *dev, void *data)
 	return 0;
 }
 
+static void iommu_device_add(struct iommu_device *iommu)
+{
+	struct iommu_device *cur;
+
+	/*
+	 * Keep the iommu_device_list grouped by ops so that
+	 * iommu_find_init_device() works efficiently.
+	 */
+	mutex_lock(&iommu_probe_device_lock);
+	list_for_each_entry(cur, &iommu_device_list, list) {
+		if (cur->ops == iommu->ops) {
+			list_add(&iommu->list, &cur->list);
+			goto out;
+		}
+	}
+	list_add(&iommu->list, &iommu_device_list);
+out:
+	mutex_unlock(&iommu_probe_device_lock);
+}
+
 /**
  * iommu_device_register() - Register an IOMMU hardware instance
  * @iommu: IOMMU handle for the instance
@@ -262,9 +282,7 @@ int iommu_device_register(struct iommu_device *iommu,
 	if (hwdev)
 		iommu->fwnode = dev_fwnode(hwdev);
 
-	mutex_lock(&iommu_probe_device_lock);
-	list_add_tail(&iommu->list, &iommu_device_list);
-	mutex_unlock(&iommu_probe_device_lock);
+	iommu_device_add(iommu);
 
 	for (int i = 0; i < ARRAY_SIZE(iommu_buses) && !err; i++)
 		err = bus_iommu_probe(iommu_buses[i]);
@@ -502,6 +520,29 @@ static void iommu_deinit_device(struct device *dev)
 
 DEFINE_MUTEX(iommu_probe_device_lock);
 
+static int iommu_find_init_device(struct iommu_probe_info *pinf)
+{
+	const struct iommu_ops *ops = NULL;
+	struct iommu_device *iommu;
+	int ret;
+
+	lockdep_assert_held(&iommu_probe_device_lock);
+
+	/*
+	 * Each unique ops gets a chance to claim the device, -ENODEV means the
+	 * driver does not support the device.
+	 */
+	list_for_each_entry(iommu, &iommu_device_list, list) {
+		if (iommu->ops != ops) {
+			ops = iommu->ops;
+			ret = iommu_init_device(pinf, iommu->ops);
+			if (ret != -ENODEV)
+				return ret;
+		}
+	}
+	return -ENODEV;
+}
+
 static int __iommu_probe_device(struct iommu_probe_info *pinf)
 {
 	struct device *dev = pinf->dev;
@@ -524,13 +565,6 @@ static int __iommu_probe_device(struct iommu_probe_info *pinf)
 		ops = fwspec->ops;
 		if (!ops)
 			return -ENODEV;
-	} else {
-		struct iommu_device *iommu;
-
-		iommu = iommu_device_from_fwnode(NULL);
-		if (!iommu)
-			return -ENODEV;
-		ops = iommu->ops;
 	}
 
 	/*
@@ -546,7 +580,10 @@ static int __iommu_probe_device(struct iommu_probe_info *pinf)
 	if (dev->iommu_group)
 		return 0;
 
-	ret = iommu_init_device(pinf, ops);
+	if (ops)
+		ret = iommu_init_device(pinf, ops);
+	else
+		ret = iommu_find_init_device(pinf);
 	if (ret)
 		return ret;
 
-- 
2.42.0


