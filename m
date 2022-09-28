Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BACB5EEA52
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Sep 2022 01:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbiI1Xzh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Sep 2022 19:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbiI1Xzg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Sep 2022 19:55:36 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20615.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::615])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1E4101971
        for <linux-acpi@vger.kernel.org>; Wed, 28 Sep 2022 16:55:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6IayVQ53jw9h7/VzPFO78A5UbZ9gq/GYBpI2xHZqEVlLh/Jei5l1Ezppeoz2M+pDpIK4ChdioCerP0yIdwDAdJYShFUSMhgzK0jpfyvXt7NMZKVkKNiwrMn2G3CzooJiLr9NPKXvnB2Ta6fk8K3R6JRYbA68hmXLeJBEJRiEr/s1cfobFSPrlelA3FvoKUEHSx6up6noNQ50muOgsruOdJQlEgBuHbSZ0BBljjEuNsM2JF2we3oJ+smFZ+iTqqmpaU8I5YiDziJKlkRZTj+SeqCfmEZSezy8brPsk90tInGcs7xd+ixONLJ2/cMAdt1MhtE6Tb9WLEL+3Su3GYwbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZe7SZqQvYrb35NpM7XV/1RmeRkmcdmS7e7BNdemkv8=;
 b=LRNJ8o3XbP6CU71P+6n0gI4aiqn3dh+e7pxPIJxFH2MQFdWXN3X0HjNPqzr8AWNX9nFV2a4+mf7ezLpBwB0o7GgF0LIcazWmTrS8a6EL2uHwJb/4p4O+M7BPptOQpOeciyl3ZGST5bo/PkyjKafS8Tthq2LFJkrcPcxM+aNRUI3AKEvpfauhX0lanlEJXRtd3rV1H/SkIeBBWEBwHmvSVGICeqvUmZQVdCEhwvo/pBsIteqyvlZwh6i9nO+hGTJEajo3VrM+pmZDlMqe7an+kverLb5ueg0h2nm+va53FxMHdJB1JT4R5l3dx9wMgto5c3/M9fyRelM+qR4u1SG78g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZe7SZqQvYrb35NpM7XV/1RmeRkmcdmS7e7BNdemkv8=;
 b=ktppUC4pECEXkPrJ2w+iOhdgCfBK7IKwqcLyv7ZPipziiuYuL6ENaw6wnESMUfpKCyA8VrYeRN5rtSDa3vNsRSXg6uqAzGoYZ/rCj9FGNE776NoJk7oneGESaR6p/K7tRrPIwZMnX388cO1hNfB4I1RGYaxEsV5ciLNfdBSXCEVLOj7uKaQTkVFhV3kaYeba3JjqAq28PyaMFPFL6+8ehtsel+qswABjfsClB3YEnLXkavmnJYJani7xdPtBwhLBDpM/TVl+RJklZLmMUHkhVazRtxQRhY234LS3StiZNYLq0qtNsrggJdsI2poblrLdgxMvUFrT4MW1fRiXTegaqA==
Received: from DM6PR02CA0151.namprd02.prod.outlook.com (2603:10b6:5:332::18)
 by MN2PR12MB4504.namprd12.prod.outlook.com (2603:10b6:208:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 23:55:31 +0000
Received: from DM6NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::a5) by DM6PR02CA0151.outlook.office365.com
 (2603:10b6:5:332::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 23:55:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT080.mail.protection.outlook.com (10.13.173.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 23:55:30 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 28 Sep
 2022 16:55:18 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 28 Sep 2022 16:55:18 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Wed, 28 Sep 2022 16:55:17 -0700
Date:   Wed, 28 Sep 2022 16:55:16 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <lpieralisi@kernel.org>, <guohanjun@huawei.com>,
        <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>
Subject: Re: [PATCH] ACPI/IORT: Update SMMUv3 DeviceID support
Message-ID: <YzTe5AaGDauUyzDB@Asurada-Nvidia>
References: <4b3e2ead4f392d1a47a7528da119d57918e5d806.1664392886.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4b3e2ead4f392d1a47a7528da119d57918e5d806.1664392886.git.robin.murphy@arm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT080:EE_|MN2PR12MB4504:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fd3483b-f465-4141-66f4-08daa1aced0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gUj0QB3RXOpQKImy9EnGrtYoeael95Bm+1/yfQ2sDGQU5WVwEn5g358tvUt+zcNOkh2yR1wP3j9HR1lrp1G7EljsTcJF4cdh9oG7eOinC6y9Zl8Z8ENf9of6vvjqE3f1XP9jhpUSuodQDsGP0mCGFOQcYINf2FLnxh3KduIn1TcW+0Nb8v5jBXhhBomPLLtO7sMNSyY6D5IvYsBWTb8ptOMpBOgIjoJKjxmqNw8Eu17JtoKZzNEUH+nlPGAPgg6YiNMIW4/cDlRSqQiX+1sKUzxqmZzX+PwKMdSRerxoVAtvRxxM8OFTZVM+9TpwYtLEIiLSG3tyyefzgfaM6SZOhx0QuWCeyU2SBbTW18vEMg2LU51kzht1OANK/5WRFJ0V//8Cky+QK2O639Z3z1h20GRUT7upZOxAIdTPHzPt7L17dGRGFcomoWJtlNp4CZ2dD2OtyS5wziwh828aBK0zoNQesVK7AT3pKfemhu+7x3moqg4Rsvf88JFtxe3mAap/jLhdltTr8MAWRglCXQ9GnSjNwnj3ZPsl7J+qPsQsekaePIUBytI35i3cR145CB6lSy9rudJAoA4moQVCz7ft1BEKm6XIFyWdH9yKOUWr7nKlc4hO+TF9BtPoZVtyPv/bLa3D2xjjpUS1zfA49UuXkRLlvTbl+sAtBvMn1CTISx72arwva8KXPN0o1pnvomLeRPgTfK4h1i0c7AY3sC1NanGhf6ZHSh+Shox7geBiYUjX1muEnm/HSBhSHXiqjEhpptk+ABBhvkYHlBe9N0Yv7Q==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199015)(36840700001)(40470700004)(46966006)(4326008)(54906003)(8676002)(86362001)(6916009)(356005)(47076005)(36860700001)(186003)(5660300002)(82740400003)(83380400001)(426003)(7636003)(336012)(9686003)(26005)(41300700001)(55016003)(70206006)(478600001)(8936002)(316002)(2906002)(40460700003)(70586007)(33716001)(40480700001)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 23:55:30.8334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd3483b-f465-4141-66f4-08daa1aced0b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4504
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 28, 2022 at 08:21:26PM +0100, Robin Murphy wrote:
> External email: Use caution opening links or attachments
> 
> 
> IORT E.e now allows SMMUv3 nodes to describe the DeviceID for MSIs
> independently of wired GSIVs, where the previous oddly-restrictive
> definition meant that an SMMU without PRI support had to provide a
> DeviceID even if it didn't support MSIs either. Support this, with
> the usual temporary flag definition while the real one is making
> its way through ACPICA.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

All the indentations in this patch are using white spaces vs. tabs,
so it fails at git-apply. I manually fixed them and tested the PATCH
by applying a small revision hack to the IORT binaries:

---------
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 3269a888fb7a..5a4eef7b937c 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -333,8 +333,20 @@ void __iomem __ref
 		return NULL;
 	}
 
-	if (!acpi_permanent_mmap)
-		return __acpi_map_table((unsigned long)phys, size);
+	if (!acpi_permanent_mmap) {
+		virt = __acpi_map_table((unsigned long)phys, size);
+		if (!strncmp((char *)virt, "IORT", 4)) {
+			u8 *tmp = virt;
+			int i = 0x30;
+			while (i < size) {
+				if (tmp[i] == 0x4) /* SMMUv3 */
+					tmp[i + 3] = 0x5; /* Revision */
+				i += tmp[i + 1]; /* next node */
+				continue;
+			}
+		}
+		return virt;
+	}
 
 	mutex_lock(&acpi_ioremap_lock);
 	/* Check if there's a suitable mapping already. */
---------

Once the indentations are fixed,

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

Thanks!
Nicolin

> ---
>  drivers/acpi/arm64/iort.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index ca2aed86b540..51bc3c1d8d42 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -402,6 +402,10 @@ static struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
>         return NULL;
>  }
> 
> +#ifndef ACPI_IORT_SMMU_V3_DEVICEID_VALID
> +#define ACPI_IORT_SMMU_V3_DEVICEID_VALID (1 << 4)
> +#endif
> +
>  static int iort_get_id_mapping_index(struct acpi_iort_node *node)
>  {
>         struct acpi_iort_smmu_v3 *smmu;
> @@ -418,12 +422,16 @@ static int iort_get_id_mapping_index(struct acpi_iort_node *node)
> 
>                 smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
>                 /*
> -                * ID mapping index is only ignored if all interrupts are
> -                * GSIV based
> +                * Until IORT E.e (node rev. 5), the ID mapping index was
> +                * defined to be valid unless all interrupts are GSIV-based.
>                  */
> -               if (smmu->event_gsiv && smmu->pri_gsiv && smmu->gerr_gsiv
> -                   && smmu->sync_gsiv)
> +               if (node->revision < 5) {
> +                       if (smmu->event_gsiv && smmu->pri_gsiv &&
> +                           smmu->gerr_gsiv && smmu->sync_gsiv)
> +                               return -EINVAL;
> +               } else if (!(smmu->flags & ACPI_IORT_SMMU_V3_DEVICEID_VALID)) {
>                         return -EINVAL;
> +               }
> 
>                 if (smmu->id_mapping_index >= node->mapping_count) {
>                         pr_err(FW_BUG "[node %p type %d] ID mapping index overflows valid mappings\n",
> --
> 2.36.1.dirty
> 
