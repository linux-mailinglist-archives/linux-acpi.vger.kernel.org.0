Return-Path: <linux-acpi+bounces-1964-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AEF7FE6D4
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF639281FF6
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F08A1548F
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="INXWqdqc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA3DD54;
	Wed, 29 Nov 2023 17:10:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdI03JHoSpNb6wfkhxmvINBZ5QE3A1X7JT0qNXTCqxTSnw9/G5qjD1TxxRyE8cnk0mU4W05J9+24jseiY0nLbPcz226Z/UXgtcHZUUll7xgF9HMqiBw4Ns8weogdaYbAMFZj3bRt4nIjxx7+c5A14sRbSytt9kP/7LoL/2HZRDMv/j5aOtxz19rPmXjRlZ1MdJqvqna8vUS+FMRpBkwzjrJjPKe5XdvIx6YmHaIuYoUSL8WlhhGY4bHqn9zxuygVF/l+JOXg8QMem/w3QkdSFj0GGnDAKa0bKDDPkhyYL/cSj8XgGzVKrQ9TqXX5dFEeA/Xd1Z8cHQyJuz3Cjrlx1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNc0i8b19f67qGg7jaCMO7gIkmzVDan6cC8FlSSYH2o=;
 b=PVFYPcyxvDMzXhe1i/g0aqirYRrbXjl7/xMmKcK3yWNwrjaHQMe/Q9MvRBUnMrR9lKrMwHW/z4pgj2ikNbQGZUGtQKz2SdJM8aX3ZZz8yXJgWf0RHx7LnDbviOQwHIslqon/FK5+CC9qhj5DtjNVrZVpsJQ2kBSmvfkY2Z8KTXsdbUcrQZQlrwevWAC/GT2PMMUmFUr5VsIsAFyrhQVJM4wnyQqrd1Le5RD/wXslCDWrrPVwoiP0BPFMRIzqtfnQYVwoKI1WoKG1TxvQtB3/JI53UGmYDhKi9ETC/DqnrPx8kmE0xFB57LvGprjMnImIJRjiRt6+IFX6OaJtEKleaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNc0i8b19f67qGg7jaCMO7gIkmzVDan6cC8FlSSYH2o=;
 b=INXWqdqclBICUJjjXFuMPgFLO24Al4fug/47pDUXnE+dt1EFdrhWsovH259yZyK99z8XSxR4I1TkDubuSn4KmxnLbYUuSqkFYH0U6lNYIGg1A4wJErBXg8VA0c3CFT4XSnTEepmicUaBzj37Xa1J+JY1UfIH4R3tFnSskHMB/uHbAIQIkfSKEZ4W1Fka1eEqpHqjfb+3D1FPWxUb5jnMrjrEHYByhvZDEAhvLmGD+wIXq0Ofr0EXtTb80ygvF75xkmQ8oAZa/O01ND5rfMm/3Pb2LnZ2tn57AAJUt33N6cPKlEq936U3CUKjiPmBatbxI9D1yj7RWPYqM1tC2rR8jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5484.namprd12.prod.outlook.com (2603:10b6:510:eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 01:10:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:10:48 +0000
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
Subject: [PATCH 19/30] iommu/mtk: Move to iommu_fw_alloc_per_device_ids()
Date: Wed, 29 Nov 2023 21:10:26 -0400
Message-ID: <19-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5484:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d3c6e54-176d-498f-da95-08dbf1412b79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EXY2ttH4pyhsm2YJc/WuQ+XxNnXTnWaCedP+qxpCDaXJuBY7Tnu6X3q/091tlNCC51kpIbTaV+RhcD0QTjd9Wn31YcPOcpLPqPFZ2idU9CL24yyyLpMxYkxNIjqawWiQJfWFzsKlC+0cStc9n7I7OFBViRdl7j3L1TFzbKltsBS0yN3nwdpzkDFkOR05+zo2V+9kWqmk/tCTPetycKAUMb+k6uoVs9HIMiMJnWGBkSDm3Q3+0fmyD4y8Q5osfIPiOzvEcY54fo5SEd2EYrKtrH6/UQTsTvtQjKzYbxcRf25toMrpwSgvung13rUy657rXuy0YLCCYOqwM5naOAf2Jgj1ldhmcWLjtLHIlh0yTZHOn6XofOzXdv+yN3yrzfuh3i0mpY6r4tLI4zw4r3Ca3RGIPRgR/k7/r4H7OZg65TMBsx1j08VyZ/t1ELExLLCG4FjJylPecIfH1Fw/QgRxmNm/GfUEHUNx6kdmAprvP2NNKtH4UFpchmT01d40+nEaxXlXfgjRvHiAIYliKu5HY4ilGKQjFyaRMlTbAowRCHO6L/TGuwqvf9MVkygm9SGIpxqzS6RoXFCRcSdAkIxOBYZNfwf6swBYZnf/H4Znb/SQhHLfreFkaiYHM7vKzKx0Kt6GxYsj2RdD1xCZpQoMrg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1191002)(8936002)(110136005)(8676002)(316002)(66556008)(4326008)(86362001)(66476007)(6486002)(478600001)(66946007)(41300700001)(36756003)(921008)(30864003)(7416002)(7366002)(2906002)(7406005)(5660300002)(38100700002)(2616005)(6512007)(6506007)(6666004)(83380400001)(26005)(202311291699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m/tpZQKcluujheAqzGnsfhypUuiVioZwVqtFoS6Q8reZVg9Zvx1h+ck+rqme?=
 =?us-ascii?Q?/IFQXOPfDArHdTxbN5Qka4omTa/liI0RQTbxtrQiH9h7KjMpn7Q46tLjqL35?=
 =?us-ascii?Q?V3QoIp2OVmHeX0zUV0lexS7xuwH3jodV6j2wBf7Y48ARZEwHR1ndObPARt5D?=
 =?us-ascii?Q?voqLcEV7proUdCQtWgXqoOuAN96KOifHDPX0jbMx3I+ee5idllzMTlQaHzEC?=
 =?us-ascii?Q?bJbWzQBzcEQoDKGeSiTYBhbwXHkQNm0jJu36TucLgk88rpLncdj9/IzvnAaF?=
 =?us-ascii?Q?T+NMTTAdg/2RJfNLJjO0giloleI05kNDngZ6sCxTVY5csnFPwX0l5c0Jr3KD?=
 =?us-ascii?Q?PUy7YUx85Jzq9G9FjhZ8L2b0u09ZXt8BXwGEl556I8ca5BVcfdfE7gGWxe3J?=
 =?us-ascii?Q?lgVorbhV2kG0hxDsYVzs7eUIhQPaXfMmq+dQzi3yI6Pz+1cDEoAVONG9/Mkb?=
 =?us-ascii?Q?JEkGIyUJCjBKcwDl3WC6/CmONsaCpzcLgyam+GYbKDJ/Xwz4Wdxl039/i+X+?=
 =?us-ascii?Q?BgP5u6YndVo58649BClQx9i8jDfTlpqTLEF5pwJA1mA5g7XUgziOga06oymn?=
 =?us-ascii?Q?UbybEPCiOxyMIQG256kegwt/x2YyfEQSFBqDxsSZZ+O9mBrH5VBrZRfPks57?=
 =?us-ascii?Q?jb4n57JK39llHLHGjpAbrI9L/HthwY7Gwi+S7P5Qfzgg5kZnNxYZ3PD/fPUp?=
 =?us-ascii?Q?Cvv/shtva1wsV0e3W1W56v/9hMbwyL8x42Zru8/y2qlavaP9Aqgs9eETqasD?=
 =?us-ascii?Q?hcRVFFShTGN9rRcTlYD6UnzLaTOcOeASXFQ01RsjJn3h+CbKXlH+RqXA2Jtr?=
 =?us-ascii?Q?dIBPGVi5AqpyT12aC5q+9ce1P0WnNkreDaawWIs8cuKjv5oXMpq0D9j8eYlo?=
 =?us-ascii?Q?dJwq0SetltIwuMbX3cPJo+1zZRm972yo7JHsj0B0CjvSl/uE1F8yNXC/vMSn?=
 =?us-ascii?Q?mC6Ko9d3eZ4nwuYX/1sH0r4pYs2mghmt3QPuCS5RT6SK16tBaifBr4MC7sQq?=
 =?us-ascii?Q?tF9KvcUb0EAzw5n8JsSg4Dfs6zX4I2VUD5fDfgXVK4tXAAobuS/ZH8JjDzwr?=
 =?us-ascii?Q?ss/KYsy24HniPbN/sqR0VOK/jmN0P1mDhCWO3zIW5LVilY1ZelPqQ1KIU54p?=
 =?us-ascii?Q?eTMiDpzZ5JkyBKwRTU0KM3eh9KRdWrLXhDi6qNDxn40E60HtuMDaNP4dQbwt?=
 =?us-ascii?Q?27NbK87+MrR8cCM+WG8xgjhNjZ2ZhJnZBaOz4QcIVSKcIhxaoKMtQQNiL4eE?=
 =?us-ascii?Q?LSvLc/8YnE6y7dSlR4Uzdpz2PTIX64jy/X/8VxI7M+O92spUPjKEmuZQ2Il1?=
 =?us-ascii?Q?4f/jeP6239QQ8iehu+v/KIqtdWsVezVpdY6FpREB4866WE2I7QkWAuVWR9S3?=
 =?us-ascii?Q?JTUOeU9FLEAcTyPdfkctEpfcnelFPTpwr6wgOHgrMqzj22KRo3JYJbzuAZBc?=
 =?us-ascii?Q?NufjsPruG6rg4K8rp5GM0Vhvv44yOhYagbJlhlVJ1CwSFipPCtf5KOupaqaw?=
 =?us-ascii?Q?558DhHJIdqLQNEN9DGppCNN30Oi6DwHjpSPoEJl17j6/twzaVcaH9jPaGYfP?=
 =?us-ascii?Q?7goRcjFeKuBAqkSUooyq1SO+J5Rv7WWdj2YW4DOQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3c6e54-176d-498f-da95-08dbf1412b79
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:10:40.9319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5iQCpGHG8rrK0heO2B4CQgapUNp1ZK85FyWiYHYC54oG2yQrFPC3AxQeYD/nYFkY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5484

mtk was doing a lot of stuff under of_xlate, and it looked kind of like it
might support multi-instances. But the dt files don't do that, and the
driver has no way to keep track of which instance the ids are for.

Enforce single instance with iommu_of_get_single_iommu().

Introduce a per-device data to store the iommu and ids list. Allocate and
initialize it with iommu_fw_alloc_per_device_ids(). Remove
mtk_iommu_of_xlate().

Convert the rest of the funcs from calling dev_iommu_fwspec_get() to using
the per-device data and remove all use of fwspec.

Covnert the places using dev_iommu_priv_get() to use the per-device data
not the iommu.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/mtk_iommu.c | 116 ++++++++++++++++++++------------------
 1 file changed, 62 insertions(+), 54 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 7abe9e85a57063..477171e83eaa6e 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -13,6 +13,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/iopoll.h>
 #include <linux/io-pgtable.h>
 #include <linux/list.h>
@@ -277,6 +278,12 @@ struct mtk_iommu_data {
 	struct mtk_smi_larb_iommu	larb_imu[MTK_LARB_NR_MAX];
 };
 
+struct mtk_iommu_device {
+	struct mtk_iommu_data *iommu;
+	unsigned int num_ids;
+	u32 ids[] __counted_by(num_ids);
+};
+
 struct mtk_iommu_domain {
 	struct io_pgtable_cfg		cfg;
 	struct io_pgtable_ops		*iop;
@@ -526,14 +533,14 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 static unsigned int mtk_iommu_get_bank_id(struct device *dev,
 					  const struct mtk_iommu_plat_data *plat_data)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct mtk_iommu_device *mtkdev = dev_iommu_priv_get(dev);
 	unsigned int i, portmsk = 0, bankid = 0;
 
 	if (plat_data->banks_num == 1)
 		return bankid;
 
-	for (i = 0; i < fwspec->num_ids; i++)
-		portmsk |= BIT(MTK_M4U_TO_PORT(fwspec->ids[i]));
+	for (i = 0; i < mtkdev->num_ids; i++)
+		portmsk |= BIT(MTK_M4U_TO_PORT(mtkdev->ids[i]));
 
 	for (i = 0; i < plat_data->banks_num && i < MTK_IOMMU_BANK_MAX; i++) {
 		if (!plat_data->banks_enable[i])
@@ -550,7 +557,7 @@ static unsigned int mtk_iommu_get_bank_id(struct device *dev,
 static int mtk_iommu_get_iova_region_id(struct device *dev,
 					const struct mtk_iommu_plat_data *plat_data)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct mtk_iommu_device *mtkdev = dev_iommu_priv_get(dev);
 	unsigned int portidmsk = 0, larbid;
 	const u32 *rgn_larb_msk;
 	int i;
@@ -558,9 +565,9 @@ static int mtk_iommu_get_iova_region_id(struct device *dev,
 	if (plat_data->iova_region_nr == 1)
 		return 0;
 
-	larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
-	for (i = 0; i < fwspec->num_ids; i++)
-		portidmsk |= BIT(MTK_M4U_TO_PORT(fwspec->ids[i]));
+	larbid = MTK_M4U_TO_LARB(mtkdev->ids[0]);
+	for (i = 0; i < mtkdev->num_ids; i++)
+		portidmsk |= BIT(MTK_M4U_TO_PORT(mtkdev->ids[i]));
 
 	for (i = 0; i < plat_data->iova_region_nr; i++) {
 		rgn_larb_msk = plat_data->iova_region_larb_msk[i];
@@ -579,22 +586,22 @@ static int mtk_iommu_get_iova_region_id(struct device *dev,
 static int mtk_iommu_config(struct mtk_iommu_data *data, struct device *dev,
 			    bool enable, unsigned int regionid)
 {
+	struct mtk_iommu_device *mtkdev = dev_iommu_priv_get(dev);
 	struct mtk_smi_larb_iommu    *larb_mmu;
 	unsigned int                 larbid, portid;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	const struct mtk_iommu_iova_region *region;
 	unsigned long portid_msk = 0;
 	struct arm_smccc_res res;
 	int i, ret = 0;
 
-	for (i = 0; i < fwspec->num_ids; ++i) {
-		portid = MTK_M4U_TO_PORT(fwspec->ids[i]);
+	for (i = 0; i < mtkdev->num_ids; ++i) {
+		portid = MTK_M4U_TO_PORT(mtkdev->ids[i]);
 		portid_msk |= BIT(portid);
 	}
 
 	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
 		/* All ports should be in the same larb. just use 0 here */
-		larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
+		larbid = MTK_M4U_TO_LARB(mtkdev->ids[0]);
 		larb_mmu = &data->larb_imu[larbid];
 		region = data->plat_data->iova_region + regionid;
 
@@ -618,7 +625,7 @@ static int mtk_iommu_config(struct mtk_iommu_data *data, struct device *dev,
 		} else {
 			/* PCI dev has only one output id, enable the next writing bit for PCIe */
 			if (dev_is_pci(dev)) {
-				if (fwspec->num_ids != 1) {
+				if (mtkdev->num_ids != 1) {
 					dev_err(dev, "PCI dev can only have one port.\n");
 					return -ENODEV;
 				}
@@ -708,7 +715,9 @@ static void mtk_iommu_domain_free(struct iommu_domain *domain)
 static int mtk_iommu_attach_device(struct iommu_domain *domain,
 				   struct device *dev)
 {
-	struct mtk_iommu_data *data = dev_iommu_priv_get(dev), *frstdata;
+	struct mtk_iommu_device *mtkdev = dev_iommu_priv_get(dev);
+	struct mtk_iommu_data *data = mtkdev->iommu;
+	struct mtk_iommu_data *frstdata;
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 	struct list_head *hw_list = data->hw_list;
 	struct device *m4udev = data->dev;
@@ -777,12 +786,12 @@ static int mtk_iommu_identity_attach(struct iommu_domain *identity_domain,
 				     struct device *dev)
 {
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
-	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
+	struct mtk_iommu_device *mtkdev = dev_iommu_priv_get(dev);
 
 	if (domain == identity_domain || !domain)
 		return 0;
 
-	mtk_iommu_config(data, dev, false, 0);
+	mtk_iommu_config(mtkdev->iommu, dev, false, 0);
 	return 0;
 }
 
@@ -860,14 +869,28 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 	return pa;
 }
 
-static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
+static struct iommu_device *
+mtk_iommu_probe_device(struct iommu_probe_info *pinf)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
+	struct mtk_iommu_device *mtkdev;
+	struct device *dev = pinf->dev;
+	struct mtk_iommu_data *data;
 	struct device_link *link;
 	struct device *larbdev;
 	unsigned int larbid, larbidx, i;
 
+	data = iommu_of_get_single_iommu(pinf, &mtk_iommu_ops, 1,
+					 struct mtk_iommu_data, iommu);
+	if (IS_ERR(data))
+		return ERR_CAST(data);
+
+	mtkdev = iommu_fw_alloc_per_device_ids(pinf, mtkdev);
+	if (IS_ERR(mtkdev))
+		return ERR_CAST(mtkdev);
+	mtkdev->iommu = data;
+
+	dev_iommu_priv_set(dev, mtkdev);
+
 	if (!MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM))
 		return &data->iommu;
 
@@ -876,42 +899,46 @@ static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
 	 * The device that connects with each a larb is a independent HW.
 	 * All the ports in each a device should be in the same larbs.
 	 */
-	larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
+	larbid = MTK_M4U_TO_LARB(mtkdev->ids[0]);
 	if (larbid >= MTK_LARB_NR_MAX)
-		return ERR_PTR(-EINVAL);
+		goto err_out;
 
-	for (i = 1; i < fwspec->num_ids; i++) {
-		larbidx = MTK_M4U_TO_LARB(fwspec->ids[i]);
+	for (i = 1; i < mtkdev->num_ids; i++) {
+		larbidx = MTK_M4U_TO_LARB(mtkdev->ids[i]);
 		if (larbid != larbidx) {
 			dev_err(dev, "Can only use one larb. Fail@larb%d-%d.\n",
 				larbid, larbidx);
-			return ERR_PTR(-EINVAL);
+			goto err_out;
 		}
 	}
 	larbdev = data->larb_imu[larbid].dev;
 	if (!larbdev)
-		return ERR_PTR(-EINVAL);
+		goto err_out;
 
 	link = device_link_add(dev, larbdev,
 			       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
 	if (!link)
 		dev_err(dev, "Unable to link %s\n", dev_name(larbdev));
 	return &data->iommu;
+
+err_out:
+	kfree(mtkdev);
+	return ERR_PTR(-EINVAL);
 }
 
 static void mtk_iommu_release_device(struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct mtk_iommu_data *data;
+	struct mtk_iommu_device *mtkdev = dev_iommu_priv_get(dev);
+	struct mtk_iommu_data *data = mtkdev->iommu;
 	struct device *larbdev;
 	unsigned int larbid;
 
-	data = dev_iommu_priv_get(dev);
 	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
-		larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
+		larbid = MTK_M4U_TO_LARB(mtkdev->ids[0]);
 		larbdev = data->larb_imu[larbid].dev;
 		device_link_remove(dev, larbdev);
 	}
+	kfree(mtkdev);
 }
 
 static int mtk_iommu_get_group_id(struct device *dev, const struct mtk_iommu_plat_data *plat_data)
@@ -931,7 +958,9 @@ static int mtk_iommu_get_group_id(struct device *dev, const struct mtk_iommu_pla
 
 static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 {
-	struct mtk_iommu_data *c_data = dev_iommu_priv_get(dev), *data;
+	struct mtk_iommu_device *mtkdev = dev_iommu_priv_get(dev);
+	struct mtk_iommu_data *c_data = mtkdev->iommu;
+	struct mtk_iommu_data *data;
 	struct list_head *hw_list = c_data->hw_list;
 	struct iommu_group *group;
 	int groupid;
@@ -957,32 +986,11 @@ static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 	return group;
 }
 
-static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
-{
-	struct platform_device *m4updev;
-
-	if (args->args_count != 1) {
-		dev_err(dev, "invalid #iommu-cells(%d) property for IOMMU\n",
-			args->args_count);
-		return -EINVAL;
-	}
-
-	if (!dev_iommu_priv_get(dev)) {
-		/* Get the m4u device */
-		m4updev = of_find_device_by_node(args->np);
-		if (WARN_ON(!m4updev))
-			return -EINVAL;
-
-		dev_iommu_priv_set(dev, platform_get_drvdata(m4updev));
-	}
-
-	return iommu_fwspec_add_ids(dev, args->args, 1);
-}
-
 static void mtk_iommu_get_resv_regions(struct device *dev,
 				       struct list_head *head)
 {
-	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
+	struct mtk_iommu_device *mtkdev = dev_iommu_priv_get(dev);
+	struct mtk_iommu_data *data = mtkdev->iommu;
 	unsigned int regionid = mtk_iommu_get_iova_region_id(dev, data->plat_data), i;
 	const struct mtk_iommu_iova_region *resv, *curdom;
 	struct iommu_resv_region *region;
@@ -1012,10 +1020,10 @@ static void mtk_iommu_get_resv_regions(struct device *dev,
 static const struct iommu_ops mtk_iommu_ops = {
 	.identity_domain = &mtk_iommu_identity_domain,
 	.domain_alloc_paging = mtk_iommu_domain_alloc_paging,
-	.probe_device	= mtk_iommu_probe_device,
+	.probe_device_pinf = mtk_iommu_probe_device,
 	.release_device	= mtk_iommu_release_device,
 	.device_group	= mtk_iommu_device_group,
-	.of_xlate	= mtk_iommu_of_xlate,
+	.of_xlate = iommu_dummy_of_xlate,
 	.get_resv_regions = mtk_iommu_get_resv_regions,
 	.pgsize_bitmap	= SZ_4K | SZ_64K | SZ_1M | SZ_16M,
 	.owner		= THIS_MODULE,
-- 
2.42.0


