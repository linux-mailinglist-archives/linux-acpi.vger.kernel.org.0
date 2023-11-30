Return-Path: <linux-acpi+bounces-1950-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 226CF7FE6BE
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D6F1C209A9
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A464913AC9
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oTWOZQwI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8B3D7D;
	Wed, 29 Nov 2023 17:10:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmKwT6bexloyKBzeBinohdFYv0WwZUO9rnEZLicr75WLrlczS3hQeMqCbSiFw3ShpEhZ7PXv0nb2qDJVqo4/u1iawKSV8LAVK1nYEb0J0ebSiWoqp9dfZR9z6NVl3bzFLRYD3THvaiTixgZKqLc0YUyq/gYJskVfYwj3pRuN/F9vmlIB4gLmmxW1Eoyyq9/rW6N83l6sm0rTXA3ouKYadJsudqxTVdTymvSBuwCfNHkmgkhgzXXYRmV7Sa+kp7P+JRQOWfayOk4F4B1bvAwn1g3SFIW9e8mH27L2mkr81GZU7gq40YEGFahgJxG7hbVRoAVnFuX5Yx7joST9Q3RfQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7aJKu7BohUpFcYIdwpDeid+Mzh23OW02rRcztcHd+0=;
 b=fcXLs3QALOfSwmxljqVm2JObO59htJiL0MrAcI2p8xb0lFsY8T6Fh4al49GD++RA3rRO4WkzN+75h4cWt9dMCymB+kaHtO5Moz0hnpYgLFMDMs1Yq55cEh5cJhfIJBxJnZxw1QsX9e+s28l0xGrKt8KTCjJ2mwsXe70QCps8fDYRcwg9rptArc4KRbxqzrdA53YNpCI0VfGpqWsDOf4KSWKhi64SsvF9Re0+taEpSYE6iiSUVvddhKjZBIT2s7zwo59M2+jCxtDmP/aCHaNSQk7lKcSpUk9SfbDz7G3UJgfXP77U95WU64j1sja7Gtw41e+3MvtYZfjguJ69XDqXQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7aJKu7BohUpFcYIdwpDeid+Mzh23OW02rRcztcHd+0=;
 b=oTWOZQwIRW+sRoJKgscUvtc8f2NmgRZbSzUE4lwGfogXcueSQPihSV+yNIkgGtgLGhTYWFPgCGqjLaQi8kTcTMr4Ay9ADyfKMLLzvZ320Ix4FTYMHwE/kehbAq60SwunwoTODfWNgbYgT5HIl+picAnGxU6I+7+AQHrIC5iwdL3wVszT8M5Ygw8j/iGI6QHn3hs50Jau5bEuCCbvdSxCGQxMpCM9u0d8oWp45gtCO67eUrXmiaOG5fqjRHVJpPAa7F+fk+IGE4Xoj0IBVsTR1idugCRFKtyipchb9giYcpDRZ5U9jP8NoRrRdmAtKJ+a4Vlv2vrgaQJI2/ZmlBuWdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7607.namprd12.prod.outlook.com (2603:10b6:8:13f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 01:10:43 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:10:43 +0000
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
Subject: [PATCH 24/30] iommu/virtio: Move to iommu_fw_alloc_per_device_ids()
Date: Wed, 29 Nov 2023 21:10:31 -0400
Message-ID: <24-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0017.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: f184cbfa-52b3-4d89-5ed6-08dbf1412a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LGVZ66x0Z/c4A6yfd8vLDEdf+b6sgChnN84rSZ7LBwHl2BtRXlBVm+2WpXBl5Lkgt3fvU9Y1jumfYyLXJwVsnSFmOeTPAuBHcQDCgsdIdbAPylZktkseaBYMxfcarg8nttCn/+57uar/E2l1KQB/VJWY9cA+j8Y3mvgbsDbFIa9pp9m991KxuSayertSROc3nPNAz51GFOUAe2rHa9DOrbyDMKntkOq92h+axz5GMHkTRVWdoZdNDpMMl9i6/YGtbvRS6eCqkt022p8DRfU3hoXgunNUV7EgTapOcWYY53teGi+TQoCViuNRCLerPKEKh1ETHIHmW21/uEqIsHCdQQUJnTpHffTwP3Gk8tXacvS3FqFSFc/FMNiAC2it8rjjbfsF1krkCJUfkUJaeBmSV8vOifI0dT6gZfKt0dbN3VQnwDogqEL3voeyWIIaQ/mn8TyHU2gNhhicbFjBJmRK9Ry0te6+5aw9mFHFSJwINCHBl7E6rQbUdzR1hUWbHP4in+htuzLmpRngudq7rkQ4bvcgHBH4gTeu/HwCZUpN60oPIz+0OPu7flsHG5DMHRHgRIQXuwjMFc4H+iKvhhBn7TWz8nARPFxV3Vj5Ug/lbRDB1hF/TzlsGlMMVErzoNN54o4jAv/2JE1X2R/zz8kc1A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(38100700002)(202311291699003)(83380400001)(1191002)(5660300002)(110136005)(2906002)(86362001)(4326008)(8676002)(8936002)(66556008)(7366002)(7406005)(7416002)(66476007)(66946007)(6486002)(478600001)(6666004)(316002)(36756003)(6506007)(41300700001)(6512007)(921008)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nwh4P5igKZINuWBNkgxmbvQVTx47VsyJlltLwDktBJ5Sfp+zWmHQRpNfPorx?=
 =?us-ascii?Q?4iyl/Hgvhh1/FEeVyBF5Zq6fZ+2eyUE5WCbGEENQVCQPOwqldo36I2pczKDd?=
 =?us-ascii?Q?V+eJ8nL0hCElkytr7kOfsogkKAV5pW5CD91YfwGzNL9eaX9C7/qO/l3e1zZU?=
 =?us-ascii?Q?C4n4PaBymBeYddMrCztcXPyYl7P0iWtG5BA6K56QnJaLNcag9o+CbNGC+xFz?=
 =?us-ascii?Q?JOREmljn/ZBaTzekHRAtiL/dYVB8ahqkg5ATjqWO+GoeObHVJ226nME2nEPI?=
 =?us-ascii?Q?kZlS3Bd84gVE4AO/WNv11kXn5i45BoeLjdAi5U/cokM+QZYgLNepxmBaR1f7?=
 =?us-ascii?Q?pMT3mwyfzNKF4jobw40tRv0LrcuUS3zIwhCnEMBKuo3G8fLapkZdyAZEVjfl?=
 =?us-ascii?Q?6DVgov90plihm222NmdccwdRZFkrL7TI9dZwc6moWNNFPYwY+WLwDZQxitzR?=
 =?us-ascii?Q?WQ/QjNcLiHRQPkncotfYaAbRHoNxu/GDxwvi0bRtKMMHMm8coHdM0MwGDWth?=
 =?us-ascii?Q?9m12fNr2jfD+T9dLbuBzDQxgtxSHY0sSrJHPwYH76Jf5+Rcctt/o7vcc0Nbn?=
 =?us-ascii?Q?8dYGs0FU1E/Q7EFdJDiLC3/hVAMfFW7xSkBWxGUpzSce4wKc/VpKg5NdJ9wy?=
 =?us-ascii?Q?yPBItYvh+PG6dHk31G7BUwZ07mmPSX1kB5zisliy+8Qoj9vZh1PKlyjxVgQw?=
 =?us-ascii?Q?W3ygv+MQ2KWlMn2MtxPDCvcxrKw1ngCSVMsgMV9GJUVWRSdUfxiCfF3r9MXq?=
 =?us-ascii?Q?s1UA9ttjsz8173lGm0pI6Z+saOjrid9zq+fFjk1rkxn0Hh+bSnZbIBZ761+3?=
 =?us-ascii?Q?jo5tvjXV3FvnfNx6MZIMnxl7/vGrNyxPDUck+d6l5FkyMs+XOoNLuwE54XUv?=
 =?us-ascii?Q?oOvRlKlx84Tgxis7ttjSB+gqjrGGRqcdAEE9PqyyCgGkuzmB771Xyc/pcnsx?=
 =?us-ascii?Q?Yw3QCS9nQxEp1vztCE/+fcTz/nyaPpvfVdJMyVyDf7KbwZ2c92TAOXEhZykK?=
 =?us-ascii?Q?l6qdXeppjvdL46Ctb2Qpcq5AmP6/x+gQqWM8CXH2sG4LZhcSBjJtrJHpYBs2?=
 =?us-ascii?Q?MJbb8FUuF10DjM1hW3cVwm21wdp+VV1ZEjkKBOqRebIRzp6TpxZNr5zhgl5+?=
 =?us-ascii?Q?Z89NRMG+U5LIDJx3nrveJCfPi/x7GoRMQHsCBx8ZEqBXpBlk8hLdGc8xDQiz?=
 =?us-ascii?Q?KMlQhoKN3t9Vdr+yRgyLqBnxZJhGWl+yhIfdn9qR+l0hnuMt+kfAXcxaS9Hr?=
 =?us-ascii?Q?OfL8TlYf93+7AFXXOt3sZTozi+zH+wkCGvp+hV2mgcV07gtlkVL8wtnDqgvc?=
 =?us-ascii?Q?fTF5PB8xLsxnO2O/8O7WP6fB+3sjijOwEPiRTknInkW8KApty5bMTfglfpsL?=
 =?us-ascii?Q?Xa7eINg9E17IYIJxSn9kQOVk8nRnKTHIKKaaldEG+gFcKPJAJH40I5NEsbdu?=
 =?us-ascii?Q?02UOtY86j9Vv6ttgh/yDZM0X6jl+UnvjA/X921+yeXFPEKlQzJLICs509GYn?=
 =?us-ascii?Q?wWQG/7V4oY/8gV/svW0abeQxthJGvNGt+YWN0/PHHnXxDimEbTQfaLcso3On?=
 =?us-ascii?Q?s4SGokaZcshVdezW+tK1s33bzXmp51Mo0XVv7s+N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f184cbfa-52b3-4d89-5ed6-08dbf1412a6b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:10:39.2211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6f71zxWNLJgkgz6I6UQT2udJEyUgiiFHt2tncVABgwqBz9pvFR9sJ/GUov3TVaZL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7607

virtio supports a single iommu instance with multiple ids.

It has a combined ACPI (via the VIOT table) and OF probe path, add
iommu_viot_get_single_iommu() to respresent this.

It already has a per-instance structure, extend it with the ids[]
array and use iommu_fw_alloc_per_device_ids() to populate it.

Convert the rest of the funcs from calling dev_iommu_fwspec_get() to using
he per-device data and remove all use of fwspec.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/virtio-iommu.c | 67 +++++++++++++-----------------------
 1 file changed, 23 insertions(+), 44 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index b1a7b14a6c7a2f..767919bf848999 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -77,6 +77,8 @@ struct viommu_endpoint {
 	struct viommu_dev		*viommu;
 	struct viommu_domain		*vdomain;
 	struct list_head		resv_regions;
+	unsigned int			num_ids;
+	u32				ids[] __counted_by(num_ids);
 };
 
 struct viommu_request {
@@ -510,19 +512,16 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
 	return 0;
 }
 
-static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
+static int viommu_probe_endpoint(struct viommu_endpoint *vdev)
 {
 	int ret;
 	u16 type, len;
 	size_t cur = 0;
 	size_t probe_len;
+	struct device *dev = vdev->dev;
 	struct virtio_iommu_req_probe *probe;
 	struct virtio_iommu_probe_property *prop;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
-
-	if (!fwspec->num_ids)
-		return -EINVAL;
+	struct viommu_dev *viommu = vdev->viommu;
 
 	probe_len = sizeof(*probe) + viommu->probe_size +
 		    sizeof(struct virtio_iommu_req_tail);
@@ -535,7 +534,7 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
 	 * For now, assume that properties of an endpoint that outputs multiple
 	 * IDs are consistent. Only probe the first one.
 	 */
-	probe->endpoint = cpu_to_le32(fwspec->ids[0]);
+	probe->endpoint = cpu_to_le32(vdev->ids[0]);
 
 	ret = viommu_send_req_sync(viommu, probe, probe_len);
 	if (ret)
@@ -721,7 +720,6 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	int i;
 	int ret = 0;
 	struct virtio_iommu_req_attach req;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
 
@@ -763,8 +761,8 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (vdomain->bypass)
 		req.flags |= cpu_to_le32(VIRTIO_IOMMU_ATTACH_F_BYPASS);
 
-	for (i = 0; i < fwspec->num_ids; i++) {
-		req.endpoint = cpu_to_le32(fwspec->ids[i]);
+	for (i = 0; i < vdev->num_ids; i++) {
+		req.endpoint = cpu_to_le32(vdev->ids[i]);
 
 		ret = viommu_send_req_sync(vdomain->viommu, &req, sizeof(req));
 		if (ret)
@@ -792,7 +790,6 @@ static void viommu_detach_dev(struct viommu_endpoint *vdev)
 	int i;
 	struct virtio_iommu_req_detach req;
 	struct viommu_domain *vdomain = vdev->vdomain;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(vdev->dev);
 
 	if (!vdomain)
 		return;
@@ -802,8 +799,8 @@ static void viommu_detach_dev(struct viommu_endpoint *vdev)
 		.domain		= cpu_to_le32(vdomain->id),
 	};
 
-	for (i = 0; i < fwspec->num_ids; i++) {
-		req.endpoint = cpu_to_le32(fwspec->ids[i]);
+	for (i = 0; i < vdev->num_ids; i++) {
+		req.endpoint = cpu_to_le32(vdev->ids[i]);
 		WARN_ON(viommu_send_req_sync(vdev->viommu, &req, sizeof(req)));
 	}
 	vdomain->nr_endpoints--;
@@ -974,34 +971,21 @@ static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
 static struct iommu_ops viommu_ops;
 static struct virtio_driver virtio_iommu_drv;
 
-static int viommu_match_node(struct device *dev, const void *data)
-{
-	return device_match_fwnode(dev->parent, data);
-}
-
-static struct viommu_dev *viommu_get_by_fwnode(struct fwnode_handle *fwnode)
-{
-	struct device *dev = driver_find_device(&virtio_iommu_drv.driver, NULL,
-						fwnode, viommu_match_node);
-	put_device(dev);
-
-	return dev ? dev_to_virtio(dev)->priv : NULL;
-}
-
-static struct iommu_device *viommu_probe_device(struct device *dev)
+static struct iommu_device *viommu_probe_device(struct iommu_probe_info *pinf)
 {
 	int ret;
+	struct viommu_dev *viommu;
 	struct viommu_endpoint *vdev;
-	struct viommu_dev *viommu = NULL;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct device *dev = pinf->dev;
 
-	viommu = viommu_get_by_fwnode(fwspec->iommu_fwnode);
-	if (!viommu)
-		return ERR_PTR(-ENODEV);
+	viommu = iommu_viot_get_single_iommu(pinf, &viommu_ops,
+					     struct viommu_dev, iommu);
+	if (IS_ERR(viommu))
+		return ERR_CAST(viommu);
 
-	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
-	if (!vdev)
-		return ERR_PTR(-ENOMEM);
+	vdev = iommu_fw_alloc_per_device_ids(pinf, vdev);
+	if (IS_ERR(vdev))
+		return ERR_CAST(vdev);
 
 	vdev->dev = dev;
 	vdev->viommu = viommu;
@@ -1010,7 +994,7 @@ static struct iommu_device *viommu_probe_device(struct device *dev)
 
 	if (viommu->probe_size) {
 		/* Get additional information for this endpoint */
-		ret = viommu_probe_endpoint(viommu, dev);
+		ret = viommu_probe_endpoint(vdev);
 		if (ret)
 			goto err_free_dev;
 	}
@@ -1050,11 +1034,6 @@ static struct iommu_group *viommu_device_group(struct device *dev)
 		return generic_device_group(dev);
 }
 
-static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
-{
-	return iommu_fwspec_add_ids(dev, args->args, 1);
-}
-
 static bool viommu_capable(struct device *dev, enum iommu_cap cap)
 {
 	switch (cap) {
@@ -1070,12 +1049,12 @@ static bool viommu_capable(struct device *dev, enum iommu_cap cap)
 static struct iommu_ops viommu_ops = {
 	.capable		= viommu_capable,
 	.domain_alloc		= viommu_domain_alloc,
-	.probe_device		= viommu_probe_device,
+	.probe_device_pinf	= viommu_probe_device,
 	.probe_finalize		= viommu_probe_finalize,
 	.release_device		= viommu_release_device,
 	.device_group		= viommu_device_group,
 	.get_resv_regions	= viommu_get_resv_regions,
-	.of_xlate		= viommu_of_xlate,
+	.of_xlate		= iommu_dummy_of_xlate,
 	.owner			= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev		= viommu_attach_dev,
-- 
2.42.0


