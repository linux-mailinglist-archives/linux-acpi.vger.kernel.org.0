Return-Path: <linux-acpi+bounces-1957-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC91B7FE6C7
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28093B209DD
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D95014281
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VmCs29sT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5517BD71;
	Wed, 29 Nov 2023 17:10:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQVJbe/rCdJ0QNzTO9fjlWVPn8w2reM2zsy9Lk4ds+Joe8BfIeuf7rIwUqAHex7638aZRpGC7if5ex//CJh7TBXd1I/lKNQzwOjdq46UZktDECM3CNr5ETXOIb64swXMJFLbz0mYqLDH7jlE5xDGHl1DVWK5vcFaBspC9QsxKUkzfeXotLuKv+bIffsK3JfFwwiaAbRii1j2GsAKuy9axLszrO8pEVJCRTaaUTnxwmGAeGhNjThvbumaEM+9TR8Rs0OvvD8jJXOtRJzaPEcGrwI3z21hoD6qKPJDn6e5PmKPmMXyTGNZRV7suah11BONLu9JeNt+xqa2iLo909Kz8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29OOCCTk8mlu6NkZfaPP6EDcpKq/iCHGfu7Wm1bl1pw=;
 b=VuTdFH5Vnzqr4N/vWdh6krPCmWArzmXzxyStBnwuQQHVLqA71yrd58cyRMmii7codMAHtAcXMU36CqFeVecgzWN7dAXGpDSVZ50+tfgm52boA2Hv69O5lF4kWbH+aG4S/DfGwehWPv7XwyESWPzgg18HLOUXOdZWyBRn1ei07OdL2XmZm3geydE4HVshqgNrD9ucTa2EHgYbe3t+oXZiw8rfu2dBNhBCu5pvkuN4pVc4pfqVc3PS3tJnZ1QEBvDPShMJQNVPlt5c5uW0YTVplIVHB8fuROgKgZtfzjOewks/Og95G9zPIa7GT3W72yUiCWSAT3efK+WHpfshgFamvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29OOCCTk8mlu6NkZfaPP6EDcpKq/iCHGfu7Wm1bl1pw=;
 b=VmCs29sTdloFDU0uhs+zSCQZzL8qNH+Uwx51x51hGtaQCFPdfm2HblS4GrJ+RunCg9tOa1HDXWB7ryWvCSgJMI4qgpz2QM42QPvVYLl4zE5eX0daDQNLy6AAeY7gd5biWcLQfG3G0zfguHgsC5T1/AhzujTRsqwePdFiwjsWRbkShLP5NPqHgbS9Zxw22FO/B5ByG/t0/aj+Hh9BXImPBYqIzatEc6rWDbBGiTtMiFphGAWJplyLs9A2g3Lw/JQCTM2kPqNWRcAyVw9RGzbL/0dz1WIuIqitaRlG64ZTqxq6U0Sx1sscSLfhdYKsbIw9GdonG418uK61J4QV+BtLcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7607.namprd12.prod.outlook.com (2603:10b6:8:13f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 01:10:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:10:41 +0000
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
Subject: [PATCH 30/30] iommu: Remove fwspec and related
Date: Wed, 29 Nov 2023 21:10:37 -0400
Message-ID: <30-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0143.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: c4722f09-b29e-4ff0-a5f6-08dbf1412a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8f8opki8gPRRpfTdVYujbCXeyCwxplHs9x9hdrq8BuaAgkDpjvJlR7HqqrPfZmdQfpfLweQTX9uwHFtAAD1DiFDbqSEbHP+cG4PUX0FPkmFsuFxCOpTnTYkcAImPvAa2C+HChfKoAZs9c+xCkNXFFSGierl3YXHFZXxrhs9bOJjHaDjTE2x4EWMKxYEdogHetTpECZiX+Ybusk+/JrV7/4LvsDSql+eY5vfdn380BpH7j3W7yOlufSKWsslEdAr0lN/Hk+6YCVjNynBnrqkP9tAXDIi3T5xmTlnOcccF0Htqd6zYT9OiJ++143C2HeOutG8PxFd/7thHgahhZLD2wEzFedi0HrmSAKIqMxsa3XMKoIZ3owtcqd12MQlaQDgjv/WWWqtEsL0vZD7eeslouJ3QJppwstEmR1fz45pdHfw6SicSmermQpc3pOKH/jpHamnck1gbgzS0dD+AQHkWZAC+j0aiUWI6/1K9SbpFppgdfqtD4mWmOD5bkTcvVTqVilt6y+AJvhWIeDb4zVE3wt8mJyggE6PpNzTg8up0sVPkZCnXuMcJHxtp4V+aAgOBuEyYZMWKhvKk0QVrBmZGnHXoNMvzR2QuIv142h1Fs5Feol9NEaKq5Ith+1FekCwD7juASAqP6YbF0EJbaXyi/w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(38100700002)(202311291699003)(83380400001)(1191002)(5660300002)(110136005)(2906002)(30864003)(86362001)(4326008)(8676002)(8936002)(66556008)(7366002)(7406005)(7416002)(66476007)(66946007)(6486002)(478600001)(6666004)(316002)(36756003)(6506007)(41300700001)(6512007)(921008)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8DosQRnQZ4Drp1RHA3HtzdluU8KoMiE33yY+19JeIgEY8m6f2yoY4tEpHjRu?=
 =?us-ascii?Q?XemwQkfhXMvxJbdjq8DE1PNQ7i7i2gR1HAPbwzZ4wgGCLhEAZtCDjNO1f1Dl?=
 =?us-ascii?Q?X9hPP9kP5rTf7VAMWSixVs1XdMTeggSn3KQS9qwNLMLD30iSRAzpzEAteZc4?=
 =?us-ascii?Q?ed8yqRbSGWbttiocjsOeV38LIIpdDQLXFPKF6jNSQeVehmXMfCkpVi/Yv0Uz?=
 =?us-ascii?Q?uemyYMKwvqeT7pgVwuFWDtKh5yKfcZqmjtQ+gEVtxyGD7DwBXwJa4rhECZy3?=
 =?us-ascii?Q?1gfjdDtA+hJpS/dBqP6u/Xq0vigTeBEhIGp3nfrkZ1lj0Yq/UOZUYbHRIL2Z?=
 =?us-ascii?Q?3z3rSzsis9soEvs68pGAG91Bf0+PAURlc5DrmnZSLlyo4jiqf0sN0gObFmA+?=
 =?us-ascii?Q?I3dph2bjyZUkRzEeXcwweVV5iwT5YPL33uqAyYIs3z1jvPJq5lQB1LGJkSAW?=
 =?us-ascii?Q?sqe6sg2RM2GvgpBm/F4d6SwlSI8FR4SnXR1Ps+AiTOrFlUuM5XQmT9qcyb8n?=
 =?us-ascii?Q?1wsG/CMGp8eI2Dv+HBX8IDQnPonwEZrLTwDBVBbkAfsemzf8XRaq+UPGmcep?=
 =?us-ascii?Q?yUVvFEThsWzDVLph4k4VIiHa4RMP/LSJxEpViOo2ziTDAW/ZHVaYHIiSgtvK?=
 =?us-ascii?Q?o++2UMjl7rLr5hHHXI3bnhnS2y06aeu/Z+lsYHrfQ7UxsaPB0NSu26ARcPjn?=
 =?us-ascii?Q?o8SpIie9RwtvfZfmkFRn6VwwQUVxSfRd+9hEVblBfZAbQoTC8eRgnoe9ca69?=
 =?us-ascii?Q?tG+r1SPU8CQdAYdWNspbnNNHYNoRijxabP3BuKr4XazIr5Mvlm+hX5gYubX5?=
 =?us-ascii?Q?K8LDFNif1Xc0/zezDZGaUo0fv9vSBvpMBCy9UJxeHSG+dYF7JQPk7mmdqCQO?=
 =?us-ascii?Q?e5EOimUQySaSq2g5jobu043y4/AsPD77mnbGJIdBELgG9WVPJ82MiDF34WWI?=
 =?us-ascii?Q?1o5HUFxzZ32xr/Z3vR7vsr/rwNJK4seD/A6ohwJt4B+bQhLApMKdhJvjPL2B?=
 =?us-ascii?Q?1pq9iNTWvdNXoOZ79FjlO6DH1c5A8ml18nnlOwNFdKs8r02iM1s4Q+hKJm+E?=
 =?us-ascii?Q?tEfVb4Q+uzSaKiAIMx2lSwpS2H4q2xnU9OERrO9U2Gh7zI1NtKArmolbAPPK?=
 =?us-ascii?Q?dfx6cU0JnqrCvqoEPgAgOvC/iy+eUJwEjk+Q/RGhEMjdTB8N5vdKKgZwrlAQ?=
 =?us-ascii?Q?dhJ7WUFz30js2Z6usksxqiWJzxLqWRrILUjZDiYWHqekiuyONc2cY6CLw37z?=
 =?us-ascii?Q?0OkBvIpcchqxAcsM4u7kjTjLLZErQlGBi2RagHO4AgQPneFZut4VhLgCg4GH?=
 =?us-ascii?Q?7akJvJQWthkSBGyK3rtbtQsKvItOUiNr1EOwwD3Hc0lM4OexL1NWe7nykpKV?=
 =?us-ascii?Q?zBeFltKcpRfxdpvdCtnAlULbN8iM1MRlilyQxMUIidIcYBfQA+BtM6/iTCAO?=
 =?us-ascii?Q?FQ//zvx27n55M1Rvvs8s4jyNQRE6yOMGeCLJtSn5RZBvtYycrdF7u+9AoRef?=
 =?us-ascii?Q?m5pVPbhaZpOiBjKTo9pxj5VR58Wd0P3vQccXTn622oDmxa+f8arPVdSQ+sVL?=
 =?us-ascii?Q?0Kl4G5sXrJNTtUWUsYJDMCLVSbbH/UsLO7hNOY9F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4722f09-b29e-4ff0-a5f6-08dbf1412a45
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:10:39.0115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +jdv7bBgxkvQOVounTyGi/RowmY+Ei9ff0kyyKKUb/aBS+OqSlj4vCLDXJr7s4xt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7607

Delete all the now unused code connected to fwspec.

Remove all IOMMU related FW parsing from the *_dma_configure() functions.

Remove no longer needed includes of iommu-driver.h in the ACPI code.

Return the iommu_probe_device_lock back to being a static inside iommu.c

Make __iommu_probe_device() rely on iommu_find_init_device() for
everything.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/acpi/arm64/iort.c                   | 76 ----------------
 drivers/acpi/scan.c                         | 52 +----------
 drivers/acpi/viot.c                         | 32 -------
 drivers/iommu/apple-dart.c                  |  1 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  1 -
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  1 -
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     |  1 -
 drivers/iommu/dma-iommu.c                   | 24 -----
 drivers/iommu/dma-iommu.h                   |  6 --
 drivers/iommu/exynos-iommu.c                |  1 -
 drivers/iommu/iommu.c                       | 97 +--------------------
 drivers/iommu/ipmmu-vmsa.c                  |  1 -
 drivers/iommu/msm_iommu.c                   |  1 -
 drivers/iommu/mtk_iommu.c                   |  1 -
 drivers/iommu/of_iommu.c                    | 47 ----------
 drivers/iommu/rockchip-iommu.c              |  1 -
 drivers/iommu/sprd-iommu.c                  |  1 -
 drivers/iommu/sun50i-iommu.c                |  1 -
 drivers/iommu/tegra-smmu.c                  |  1 -
 drivers/iommu/virtio-iommu.c                |  1 -
 include/acpi/acpi_bus.h                     |  3 -
 include/linux/acpi_iort.h                   |  3 -
 include/linux/acpi_viot.h                   |  5 --
 include/linux/iommu-driver.h                | 10 ---
 include/linux/iommu.h                       | 70 ---------------
 25 files changed, 8 insertions(+), 430 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index acd2e48590f37a..8457874c789456 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -796,8 +796,6 @@ void acpi_configure_pmsi_domain(struct device *dev)
 }
 
 #ifdef CONFIG_IOMMU_API
-#include <linux/iommu-driver.h>
-
 static void iort_rmr_free(struct device *dev,
 			  struct iommu_resv_region *region)
 {
@@ -1218,19 +1216,6 @@ void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode,
 }
 EXPORT_SYMBOL_GPL(iort_put_rmr_sids);
 
-static inline bool iort_iommu_driver_enabled(u8 type)
-{
-	switch (type) {
-	case ACPI_IORT_NODE_SMMU_V3:
-		return IS_ENABLED(CONFIG_ARM_SMMU_V3);
-	case ACPI_IORT_NODE_SMMU:
-		return IS_ENABLED(CONFIG_ARM_SMMU);
-	default:
-		pr_warn("IORT node type %u does not describe an SMMU\n", type);
-		return false;
-	}
-}
-
 static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
 {
 	struct acpi_iort_root_complex *pci_rc;
@@ -1239,36 +1224,6 @@ static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
 	return pci_rc->ats_attribute & ACPI_IORT_ATS_SUPPORTED;
 }
 
-static int iort_iommu_xlate(struct acpi_iort_node *node, u32 streamid,
-			    void *info)
-{
-	struct device *dev = info;
-	struct iommu_device *iommu;
-	struct fwnode_handle *iort_fwnode;
-
-	if (!node)
-		return -ENODEV;
-
-	iort_fwnode = iort_get_fwnode(node);
-	if (!iort_fwnode)
-		return -ENODEV;
-
-	/*
-	 * If the iommu look-up fails, this means that either
-	 * the SMMU drivers have not been probed yet or that
-	 * the SMMU drivers are not built in the kernel;
-	 * Depending on whether the SMMU drivers are built-in
-	 * in the kernel or not, defer the IOMMU configuration
-	 * or just abort it.
-	 */
-	iommu = iommu_device_from_fwnode(iort_fwnode);
-	if (!iommu)
-		return iort_iommu_driver_enabled(node->type) ?
-		       -EPROBE_DEFER : -ENODEV;
-
-	return acpi_iommu_fwspec_init(dev, streamid, iort_fwnode, iommu->ops);
-}
-
 struct iort_pci_alias_info {
 	struct device *dev;
 	struct acpi_iort_node *node;
@@ -1380,40 +1335,9 @@ int iort_iommu_for_each_id(struct device *dev, const u32 *id_in,
 	iort_named_component_init(dev, node);
 	return 0;
 }
-
-/**
- * iort_iommu_configure_id - Set-up IOMMU configuration for a device.
- *
- * @dev: device to configure
- * @id_in: optional input id const value pointer
- *
- * Returns: 0 on success, <0 on failure
- */
-int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
-{
-	struct iort_params params;
-	int err;
-
-	err = iort_iommu_for_each_id(dev, id_in, &params, &iort_iommu_xlate,
-				     dev);
-	if (err)
-		return err;
-
-	if (params.pci_rc_ats) {
-		struct iommu_fwspec *fwspec;
-
-		fwspec = dev_iommu_fwspec_get(dev);
-		if (fwspec)
-			fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
-	}
-	return 0;
-}
-
 #else
 void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head)
 { }
-int iort_iommu_configure_id(struct device *dev, const u32 *input_id)
-{ return -ENODEV; }
 #endif
 
 static int nc_dma_get_range(struct device *dev, u64 *size)
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index eb7406cdc9a464..c86ac07a7a6420 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1545,29 +1545,9 @@ int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
 #ifdef CONFIG_IOMMU_API
 #include <linux/iommu-driver.h>
 
-int acpi_iommu_fwspec_init(struct device *dev, u32 id,
-			   struct fwnode_handle *fwnode,
-			   const struct iommu_ops *ops)
-{
-	int ret = iommu_fwspec_init(dev, fwnode, ops);
-
-	if (!ret)
-		ret = iommu_fwspec_add_ids(dev, &id, 1);
-
-	return ret;
-}
-
-static inline const struct iommu_ops *acpi_iommu_fwspec_ops(struct device *dev)
-{
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-
-	return fwspec ? fwspec->ops : NULL;
-}
-
 static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 {
 	int err;
-	const struct iommu_ops *ops;
 	struct iommu_probe_info pinf = {
 		.dev = dev,
 		.is_dma_configure = true,
@@ -1575,29 +1555,14 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 		.is_acpi = true,
 	};
 
-	/* Serialise to make dev->iommu stable under our potential fwspec */
-	mutex_lock(&iommu_probe_device_lock);
-	/*
-	 * If we already translated the fwspec there is nothing left to do,
-	 * return the iommu_ops.
-	 */
-	ops = acpi_iommu_fwspec_ops(dev);
-	if (ops) {
-		mutex_unlock(&iommu_probe_device_lock);
-		return 0;
-	}
-
-	err = iort_iommu_configure_id(dev, id_in);
-	if (err && err != -EPROBE_DEFER)
-		err = viot_iommu_configure(dev);
-	mutex_unlock(&iommu_probe_device_lock);
-
 	/*
 	 * If we have reason to believe the IOMMU driver missed the initial
 	 * iommu_probe_device() call for dev, replay it to get things in order.
 	 */
-	if (!err && dev->bus)
-		err = iommu_probe_device_pinf(&pinf);
+	if (!dev->bus)
+		return 0;
+
+	err = iommu_probe_device_pinf(&pinf);
 
 	/* Ignore all other errors apart from EPROBE_DEFER */
 	if (err == -EPROBE_DEFER) {
@@ -1606,20 +1571,11 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
 		return -ENODEV;
 	}
-	if (!acpi_iommu_fwspec_ops(dev))
-		return -ENODEV;
 	return 0;
 }
 
 #else /* !CONFIG_IOMMU_API */
 
-int acpi_iommu_fwspec_init(struct device *dev, u32 id,
-			   struct fwnode_handle *fwnode,
-			   const struct iommu_ops *ops)
-{
-	return -ENODEV;
-}
-
 static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 {
 	return -ENODEV;
diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
index 9780b1d477503e..67b7c4e21eeeb3 100644
--- a/drivers/acpi/viot.c
+++ b/drivers/acpi/viot.c
@@ -21,7 +21,6 @@
 #include <linux/acpi_viot.h>
 #include <linux/fwnode.h>
 #include <linux/iommu.h>
-#include <linux/iommu-driver.h>
 #include <linux/list.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
@@ -298,26 +297,6 @@ void __init acpi_viot_init(void)
 	acpi_put_table(hdr);
 }
 
-static int viot_dev_iommu_init(struct viot_iommu *viommu, u32 epid, void *info)
-{
-	struct iommu_device *iommu;
-	struct device *dev = info;
-
-	if (!viommu)
-		return -ENODEV;
-
-	/* We're not translating ourself */
-	if (device_match_fwnode(dev, viommu->fwnode))
-		return -EINVAL;
-
-	iommu = iommu_device_from_fwnode(viommu->fwnode);
-	if (!iommu)
-		return IS_ENABLED(CONFIG_VIRTIO_IOMMU) ?
-			-EPROBE_DEFER : -ENODEV;
-
-	return acpi_iommu_fwspec_init(dev, epid, viommu->fwnode, iommu->ops);
-}
-
 struct viot_pci_iommu_alias_info {
 	struct device *dev;
 	viot_for_each_fn fn;
@@ -378,14 +357,3 @@ int viot_iommu_for_each_id(struct device *dev, viot_for_each_fn fn, void *info)
 		return __for_each_platform(to_platform_device(dev), fn, info);
 	return -ENODEV;
 }
-
-/**
- * viot_iommu_configure - Setup IOMMU ops for an endpoint described by VIOT
- * @dev: the endpoint
- *
- * Return: 0 on success, <0 on failure
- */
-int viot_iommu_configure(struct device *dev)
-{
-	return viot_iommu_for_each_id(dev, viot_dev_iommu_init, dev);
-}
diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index b796c68ae45ad8..81b129ed81cc03 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -987,7 +987,6 @@ static const struct iommu_ops apple_dart_iommu_ops = {
 	.probe_device_pinf = apple_dart_probe_device,
 	.release_device = apple_dart_release_device,
 	.device_group = apple_dart_device_group,
-	.of_xlate = iommu_dummy_of_xlate,
 	.def_domain_type = apple_dart_def_domain_type,
 	.get_resv_regions = apple_dart_get_resv_regions,
 	.pgsize_bitmap = -1UL, /* Restricted during dart probe */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 1a43c677e2feaf..71c47d3a5cdde9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2840,7 +2840,6 @@ static struct iommu_ops arm_smmu_ops = {
 	.probe_device_pinf	= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
 	.device_group		= arm_smmu_device_group,
-	.of_xlate		= iommu_dummy_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.remove_dev_pasid	= arm_smmu_remove_dev_pasid,
 	.dev_enable_feat	= arm_smmu_dev_enable_feature,
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index f18d40532af433..537b47cb0da2b6 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1577,7 +1577,6 @@ static struct iommu_ops arm_smmu_ops = {
 	.release_device		= arm_smmu_release_device,
 	.probe_finalize		= arm_smmu_probe_finalize,
 	.device_group		= arm_smmu_device_group,
-	.of_xlate		= iommu_dummy_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.def_domain_type	= arm_smmu_def_domain_type,
 	.tegra_dev_iommu_get_stream_id = arm_smmu_get_stream_id,
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 4baca45df99971..308b439b955be6 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -597,7 +597,6 @@ static const struct iommu_ops qcom_iommu_ops = {
 	.probe_device_pinf = qcom_iommu_probe_device,
 	.release_device = qcom_iommu_release_device,
 	.device_group	= generic_device_group,
-	.of_xlate	= iommu_dummy_of_xlate,
 	.pgsize_bitmap	= SZ_4K | SZ_64K | SZ_1M | SZ_16M,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= qcom_iommu_attach_dev,
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 5a828c92cd38b2..e66aacc12b5ee1 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -23,7 +23,6 @@
 #include <linux/memremap.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
-#include <linux/iommu-driver.h>
 #include <linux/pci.h>
 #include <linux/scatterlist.h>
 #include <linux/spinlock.h>
@@ -456,29 +455,6 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 	domain->iova_cookie = NULL;
 }
 
-/**
- * iommu_dma_get_resv_regions - Reserved region driver helper
- * @dev: Device from iommu_get_resv_regions()
- * @list: Reserved region list from iommu_get_resv_regions()
- *
- * IOMMU drivers can use this to implement their .get_resv_regions callback
- * for general non-IOMMU-specific reservations. Currently, this covers GICv3
- * ITS region reservation on ACPI based ARM platforms that may require HW MSI
- * reservation.
- */
-void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
-{
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-
-	if (!is_of_node(fwspec->iommu_fwnode)) {
-		iort_iommu_get_resv_regions(dev, list, fwspec->iommu_fwnode,
-					    fwspec->ids, fwspec->num_ids);
-	}
-
-	of_iommu_get_resv_regions(dev, list);
-}
-EXPORT_SYMBOL(iommu_dma_get_resv_regions);
-
 static int cookie_init_hw_msi_region(struct iommu_dma_cookie *cookie,
 		phys_addr_t start, phys_addr_t end)
 {
diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
index c829f1f82a991c..69196f421b9b10 100644
--- a/drivers/iommu/dma-iommu.h
+++ b/drivers/iommu/dma-iommu.h
@@ -14,8 +14,6 @@ void iommu_put_dma_cookie(struct iommu_domain *domain);
 
 int iommu_dma_init_fq(struct iommu_domain *domain);
 
-void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
-
 extern bool iommu_dma_forcedac;
 static inline void iommu_dma_set_pci_32bit_workaround(struct device *dev)
 {
@@ -38,10 +36,6 @@ static inline void iommu_put_dma_cookie(struct iommu_domain *domain)
 {
 }
 
-static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
-{
-}
-
 static inline void iommu_dma_set_pci_32bit_workaround(struct device *dev)
 {
 }
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index c301aa87fe0ff0..80cca10e8dfdcb 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1473,7 +1473,6 @@ static const struct iommu_ops exynos_iommu_ops = {
 	.probe_device_pinf = exynos_iommu_probe_device,
 	.release_device = exynos_iommu_release_device,
 	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
-	.of_xlate = iommu_dummy_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= exynos_iommu_attach_device,
 		.map_pages	= exynos_iommu_map,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c76edc9061f123..ba0c0c7f251ace 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -42,6 +42,7 @@
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
 static DEFINE_IDA(iommu_global_pasid_ida);
+static DEFINE_MUTEX(iommu_probe_device_lock);
 
 static unsigned int iommu_def_domain_type __read_mostly;
 static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_STRICT);
@@ -371,10 +372,6 @@ static void dev_iommu_free(struct device *dev)
 	struct dev_iommu *param = dev->iommu;
 
 	dev->iommu = NULL;
-	if (param->fwspec) {
-		fwnode_handle_put(param->fwspec->iommu_fwnode);
-		kfree(param->fwspec);
-	}
 	kfree(param);
 }
 
@@ -560,8 +557,6 @@ static int iommu_fw_check_deferred(struct iommu_probe_info *pinf)
 	return -ENODEV;
 }
 
-DEFINE_MUTEX(iommu_probe_device_lock);
-
 static int iommu_find_init_device(struct iommu_probe_info *pinf)
 {
 	const struct iommu_ops *ops = NULL;
@@ -588,27 +583,10 @@ static int iommu_find_init_device(struct iommu_probe_info *pinf)
 static int __iommu_probe_device(struct iommu_probe_info *pinf)
 {
 	struct device *dev = pinf->dev;
-	const struct iommu_ops *ops;
-	struct iommu_fwspec *fwspec;
 	struct iommu_group *group;
 	struct group_device *gdev;
 	int ret;
 
-	/*
-	 * For FDT-based systems and ACPI IORT/VIOT, drivers register IOMMU
-	 * instances with non-NULL fwnodes, and client devices should have been
-	 * identified with a fwspec by this point. Otherwise, we can currently
-	 * assume that only one of Intel, AMD, s390, PAMU or legacy SMMUv2 can
-	 * be present, and that any of their registered instances has suitable
-	 * ops for probing, and thus cheekily co-opt the same mechanism.
-	 */
-	fwspec = dev_iommu_fwspec_get(dev);
-	if (fwspec && fwspec->ops) {
-		ops = fwspec->ops;
-		if (!ops)
-			return -ENODEV;
-	}
-
 	/*
 	 * Serialise to avoid races between IOMMU drivers registering in
 	 * parallel and/or the "replay" calls from ACPI/OF code via client
@@ -622,13 +600,7 @@ static int __iommu_probe_device(struct iommu_probe_info *pinf)
 	if (dev->iommu_group)
 		return 0;
 
-	if (ops) {
-		ret = iommu_init_device(pinf, ops);
-		if (ret == -ENODEV)
-			return iommu_fw_check_deferred(pinf);
-	} else {
-		ret = iommu_find_init_device(pinf);
-	}
+	ret = iommu_find_init_device(pinf);
 	if (ret)
 		return ret;
 
@@ -3085,7 +3057,8 @@ bool iommu_default_passthrough(void)
 }
 EXPORT_SYMBOL_GPL(iommu_default_passthrough);
 
-struct iommu_device *iommu_device_from_fwnode(struct fwnode_handle *fwnode)
+static struct iommu_device *
+iommu_device_from_fwnode(struct fwnode_handle *fwnode)
 {
 	struct iommu_device *iommu;
 
@@ -3173,68 +3146,6 @@ int iommu_fw_get_u32_ids(struct iommu_probe_info *pinf, u32 *ids)
 }
 EXPORT_SYMBOL_GPL(iommu_fw_get_u32_ids);
 
-int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
-		      const struct iommu_ops *ops)
-{
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-
-	if (fwspec)
-		return ops == fwspec->ops ? 0 : -EINVAL;
-
-	if (!dev_iommu_get(dev))
-		return -ENOMEM;
-
-	/* Preallocate for the overwhelmingly common case of 1 ID */
-	fwspec = kzalloc(struct_size(fwspec, ids, 1), GFP_KERNEL);
-	if (!fwspec)
-		return -ENOMEM;
-
-	of_node_get(to_of_node(iommu_fwnode));
-	fwspec->iommu_fwnode = iommu_fwnode;
-	fwspec->ops = ops;
-	dev_iommu_fwspec_set(dev, fwspec);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(iommu_fwspec_init);
-
-void iommu_fwspec_free(struct device *dev)
-{
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-
-	if (fwspec) {
-		fwnode_handle_put(fwspec->iommu_fwnode);
-		kfree(fwspec);
-		dev_iommu_fwspec_set(dev, NULL);
-	}
-}
-EXPORT_SYMBOL_GPL(iommu_fwspec_free);
-
-int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
-{
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	int i, new_num;
-
-	if (!fwspec)
-		return -EINVAL;
-
-	new_num = fwspec->num_ids + num_ids;
-	if (new_num > 1) {
-		fwspec = krealloc(fwspec, struct_size(fwspec, ids, new_num),
-				  GFP_KERNEL);
-		if (!fwspec)
-			return -ENOMEM;
-
-		dev_iommu_fwspec_set(dev, fwspec);
-	}
-
-	for (i = 0; i < num_ids; i++)
-		fwspec->ids[fwspec->num_ids + i] = ids[i];
-
-	fwspec->num_ids = new_num;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
-
 /*
  * Per device IOMMU features.
  */
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index ba984017065f98..96a6a13538ed77 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -872,7 +872,6 @@ static const struct iommu_ops ipmmu_ops = {
 	.device_group = IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA)
 			? generic_device_group : generic_single_device_group,
 	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
-	.of_xlate = iommu_dummy_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= ipmmu_attach_device,
 		.map_pages	= ipmmu_map,
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 6f21eec857c7d7..acb4858032f22e 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -674,7 +674,6 @@ static struct iommu_ops msm_iommu_ops = {
 	.probe_device_pinf = msm_iommu_probe_device,
 	.device_group = generic_device_group,
 	.pgsize_bitmap = MSM_IOMMU_PGSIZES,
-	.of_xlate = iommu_dummy_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= msm_iommu_attach_dev,
 		.map_pages	= msm_iommu_map,
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 477171e83eaa6e..53099af3908ea3 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1023,7 +1023,6 @@ static const struct iommu_ops mtk_iommu_ops = {
 	.probe_device_pinf = mtk_iommu_probe_device,
 	.release_device	= mtk_iommu_release_device,
 	.device_group	= mtk_iommu_device_group,
-	.of_xlate = iommu_dummy_of_xlate,
 	.get_resv_regions = mtk_iommu_get_resv_regions,
 	.pgsize_bitmap	= SZ_4K | SZ_64K | SZ_1M | SZ_16M,
 	.owner		= THIS_MODULE,
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 463d17ab5057d6..1daf16323fdbc3 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -19,33 +19,6 @@
 #include <linux/slab.h>
 #include <linux/fsl/mc.h>
 
-static int of_iommu_xlate(struct of_phandle_args *iommu_spec, void *info)
-{
-	struct device *dev = info;
-	struct iommu_device *iommu;
-	struct fwnode_handle *fwnode = &iommu_spec->np->fwnode;
-	int ret;
-
-	iommu = iommu_device_from_fwnode(fwnode);
-	if ((iommu && !iommu->ops->of_xlate) ||
-	    !of_device_is_available(iommu_spec->np))
-		return -ENODEV;
-
-	ret = iommu_fwspec_init(dev, &iommu_spec->np->fwnode, iommu->ops);
-	if (ret)
-		return ret;
-	/*
-	 * The otherwise-empty fwspec handily serves to indicate the specific
-	 * IOMMU device we're waiting for, which will be useful if we ever get
-	 * a proper probe-ordering dependency mechanism in future.
-	 */
-	if (!iommu)
-		return driver_deferred_probe_check_state(dev);
-
-	ret = iommu->ops->of_xlate(dev, iommu_spec);
-	return ret;
-}
-
 typedef int (*of_for_each_fn)(struct of_phandle_args *args, void *info);
 
 static int __for_each_map_id(struct device_node *master_np, u32 id,
@@ -143,34 +116,14 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		.of_map_id = id,
 		.is_dma_configure = true,
 	};
-	struct iommu_fwspec *fwspec;
 	int err;
 
 	if (!master_np)
 		return -ENODEV;
 
-	/* Serialise to make dev->iommu stable under our potential fwspec */
-	mutex_lock(&iommu_probe_device_lock);
-	fwspec = dev_iommu_fwspec_get(dev);
-	if (fwspec) {
-		if (fwspec->ops) {
-			mutex_unlock(&iommu_probe_device_lock);
-			return 0;
-		}
-		/* In the deferred case, start again from scratch */
-		iommu_fwspec_free(dev);
-	}
-
 	if (dev_is_pci(dev))
 		pci_request_acs();
 
-	err = of_iommu_for_each_id(dev, master_np, id, of_iommu_xlate, dev);
-	mutex_unlock(&iommu_probe_device_lock);
-	if (err == -ENODEV || err == -EPROBE_DEFER)
-		return err;
-	if (err)
-		goto err_log;
-
 	err = iommu_probe_device_pinf(&pinf);
 	if (err)
 		goto err_log;
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 4cff06a2a24f74..72ee43d3230f5c 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1141,7 +1141,6 @@ static const struct iommu_ops rk_iommu_ops = {
 	.release_device = rk_iommu_release_device,
 	.device_group = generic_single_device_group,
 	.pgsize_bitmap = RK_IOMMU_PGSIZE_BITMAP,
-	.of_xlate = iommu_dummy_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= rk_iommu_attach_device,
 		.map_pages	= rk_iommu_map,
diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index f1b87f8661e199..6e7634872bfcb7 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -404,7 +404,6 @@ static const struct iommu_ops sprd_iommu_ops = {
 	.domain_alloc_paging = sprd_iommu_domain_alloc_paging,
 	.probe_device_pinf = sprd_iommu_probe_device,
 	.device_group	= generic_single_device_group,
-	.of_xlate = iommu_dummy_of_xlate,
 	.pgsize_bitmap	= SPRD_IOMMU_PAGE_SIZE,
 	.owner		= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 84038705cf657d..e91aacdb7104b6 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -845,7 +845,6 @@ static const struct iommu_ops sun50i_iommu_ops = {
 	.pgsize_bitmap	= SZ_4K,
 	.device_group	= generic_single_device_group,
 	.domain_alloc_paging = sun50i_iommu_domain_alloc_paging,
-	.of_xlate = iommu_dummy_of_xlate,
 	.probe_device_pinf	= sun50i_iommu_probe_device,
 	.release_device = sun50i_iommu_release_device,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 1daa92f524452b..1c14f8b5ed847d 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -945,7 +945,6 @@ static const struct iommu_ops tegra_smmu_ops = {
 	.probe_device_pinf = tegra_smmu_probe_device,
 	.release_device = tegra_smmu_release_device,
 	.device_group = tegra_smmu_device_group,
-	.of_xlate = iommu_dummy_of_xlate,
 	.tegra_dev_iommu_get_stream_id = tegra_smmu_get_stream_id,
 	.pgsize_bitmap = SZ_4K,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 767919bf848999..f6b8e796a792e7 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1054,7 +1054,6 @@ static struct iommu_ops viommu_ops = {
 	.release_device		= viommu_release_device,
 	.device_group		= viommu_device_group,
 	.get_resv_regions	= viommu_get_resv_regions,
-	.of_xlate		= iommu_dummy_of_xlate,
 	.owner			= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev		= viommu_attach_dev,
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 89079787905d40..79dea7bea7a6f0 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -631,9 +631,6 @@ struct iommu_ops;
 
 bool acpi_dma_supported(const struct acpi_device *adev);
 enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
-int acpi_iommu_fwspec_init(struct device *dev, u32 id,
-			   struct fwnode_handle *fwnode,
-			   const struct iommu_ops *ops);
 int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map);
 int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
 			   const u32 *input_id);
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index bacba2a76c3acb..9e64a18676a4c7 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -53,7 +53,6 @@ void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode,
 		       struct list_head *head);
 /* IOMMU interface */
 int iort_dma_get_ranges(struct device *dev, u64 *size);
-int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
 void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head,
 				 struct fwnode_handle *iommu_fwnode,
 				 const u32 *fw_ids, unsigned int fw_num_ids);
@@ -72,8 +71,6 @@ void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode, struct list_head *hea
 /* IOMMU interface */
 static inline int iort_dma_get_ranges(struct device *dev, u64 *size)
 { return -ENODEV; }
-static inline int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
-{ return -ENODEV; }
 static inline
 void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head,
 				 struct fwnode_handle *iommu_fwnode,
diff --git a/include/linux/acpi_viot.h b/include/linux/acpi_viot.h
index fce4eefcae4aad..0bc01d456bcb6b 100644
--- a/include/linux/acpi_viot.h
+++ b/include/linux/acpi_viot.h
@@ -19,14 +19,9 @@ int viot_iommu_for_each_id(struct device *dev, viot_for_each_fn fn, void *info);
 #ifdef CONFIG_ACPI_VIOT
 void __init acpi_viot_early_init(void);
 void __init acpi_viot_init(void);
-int viot_iommu_configure(struct device *dev);
 #else
 static inline void acpi_viot_early_init(void) {}
 static inline void acpi_viot_init(void) {}
-static inline int viot_iommu_configure(struct device *dev)
-{
-	return -ENODEV;
-}
 #endif
 
 #endif /* __ACPI_VIOT_H__ */
diff --git a/include/linux/iommu-driver.h b/include/linux/iommu-driver.h
index aa4cbf0cb91907..7ddd0b94e13c0d 100644
--- a/include/linux/iommu-driver.h
+++ b/include/linux/iommu-driver.h
@@ -62,7 +62,6 @@ static inline void iommu_fw_clear_cache(struct iommu_probe_info *pinf)
 }
 
 int iommu_probe_device_pinf(struct iommu_probe_info *pinf);
-struct iommu_device *iommu_device_from_fwnode(struct fwnode_handle *fwnode);
 struct iommu_device *
 iommu_device_from_fwnode_pinf(struct iommu_probe_info *pinf,
 			      const struct iommu_ops *ops,
@@ -201,15 +200,6 @@ __iommu_fw_alloc_per_device_ids(struct iommu_probe_info *pinf, void *mem,
 			pinf, drv, num_ids, &drv->num_ids, drv->ids);      \
 	})
 
-/*
- * Used temporarily to indicate drivers that have moved to the new probe method.
- */
-static inline int iommu_dummy_of_xlate(struct device *dev,
-				       struct of_phandle_args *args)
-{
-	return 0;
-}
-
 #define __iommu_first(a, b)                              \
 	({                                               \
 		struct iommu_device *a_dev = a;          \
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 0ba12e0e450705..456b9b16599ce0 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -354,7 +354,6 @@ static inline int __iommu_copy_struct_from_user(
  *                  group and attached to the groups domain
  * @device_group: find iommu group for a particular device
  * @get_resv_regions: Request list of reserved regions for a device
- * @of_xlate: add OF master IDs to iommu grouping
  * @is_attach_deferred: Check if domain attach should be deferred from iommu
  *                      driver init to device driver init (default no)
  * @dev_enable/disable_feat: per device entries to enable/disable
@@ -398,7 +397,6 @@ struct iommu_ops {
 	/* Request/Free a list of reserved regions for a device */
 	void (*get_resv_regions)(struct device *dev, struct list_head *list);
 
-	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
 	bool (*is_attach_deferred)(struct device *dev);
 
 	/* Per device IOMMU features */
@@ -534,7 +532,6 @@ struct iommu_fault_param {
  *
  * @fault_param: IOMMU detected device fault reporting data
  * @iopf_param:	 I/O Page Fault queue and data
- * @fwspec:	 IOMMU fwspec data
  * @iommu_dev:	 IOMMU device this device is linked to
  * @priv:	 IOMMU Driver private data
  * @max_pasids:  number of PASIDs this device can consume
@@ -550,7 +547,6 @@ struct dev_iommu {
 	struct mutex lock;
 	struct iommu_fault_param	*fault_param;
 	struct iopf_device_param	*iopf_param;
-	struct iommu_fwspec		*fwspec;
 	struct iommu_device		*iommu_dev;
 	void				*priv;
 	u32				max_pasids;
@@ -787,29 +783,6 @@ extern struct iommu_group *generic_device_group(struct device *dev);
 struct iommu_group *fsl_mc_device_group(struct device *dev);
 extern struct iommu_group *generic_single_device_group(struct device *dev);
 
-/**
- * struct iommu_fwspec - per-device IOMMU instance data
- * @ops: ops for this device's IOMMU
- * @iommu_fwnode: firmware handle for this device's IOMMU
- * @flags: IOMMU_FWSPEC_* flags
- * @num_ids: number of associated device IDs
- * @ids: IDs which this device may present to the IOMMU
- *
- * Note that the IDs (and any other information, really) stored in this structure should be
- * considered private to the IOMMU device driver and are not to be used directly by IOMMU
- * consumers.
- */
-struct iommu_fwspec {
-	const struct iommu_ops	*ops;
-	struct fwnode_handle	*iommu_fwnode;
-	u32			flags;
-	unsigned int		num_ids;
-	u32			ids[];
-};
-
-/* ATS is supported */
-#define IOMMU_FWSPEC_PCI_RC_ATS			(1 << 0)
-
 /**
  * struct iommu_sva - handle to a device-mm bond
  */
@@ -818,25 +791,6 @@ struct iommu_sva {
 	struct iommu_domain		*domain;
 };
 
-int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
-		      const struct iommu_ops *ops);
-void iommu_fwspec_free(struct device *dev);
-int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
-
-static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
-{
-	if (dev->iommu)
-		return dev->iommu->fwspec;
-	else
-		return NULL;
-}
-
-static inline void dev_iommu_fwspec_set(struct device *dev,
-					struct iommu_fwspec *fwspec)
-{
-	dev->iommu->fwspec = fwspec;
-}
-
 static inline void *dev_iommu_priv_get(struct device *dev)
 {
 	if (dev->iommu)
@@ -847,7 +801,6 @@ static inline void *dev_iommu_priv_get(struct device *dev)
 
 void dev_iommu_priv_set(struct device *dev, void *priv);
 
-extern struct mutex iommu_probe_device_lock;
 int iommu_probe_device(struct device *dev);
 
 int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
@@ -878,7 +831,6 @@ void iommu_free_global_pasid(ioasid_t pasid);
 
 struct iommu_ops {};
 struct iommu_group {};
-struct iommu_fwspec {};
 struct iommu_device {};
 struct iommu_fault_param {};
 struct iommu_iotlb_gather {};
@@ -1153,23 +1105,6 @@ static inline void iommu_device_unlink(struct device *dev, struct device *link)
 {
 }
 
-static inline int iommu_fwspec_init(struct device *dev,
-				    struct fwnode_handle *iommu_fwnode,
-				    const struct iommu_ops *ops)
-{
-	return -ENODEV;
-}
-
-static inline void iommu_fwspec_free(struct device *dev)
-{
-}
-
-static inline int iommu_fwspec_add_ids(struct device *dev, u32 *ids,
-				       int num_ids)
-{
-	return -ENODEV;
-}
-
 static inline int
 iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features feat)
 {
@@ -1182,11 +1117,6 @@ iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
 	return -ENODEV;
 }
 
-static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
-{
-	return NULL;
-}
-
 static inline int iommu_device_use_default_domain(struct device *dev)
 {
 	return 0;
-- 
2.42.0


