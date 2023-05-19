Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA0C709F3B
	for <lists+linux-acpi@lfdr.de>; Fri, 19 May 2023 20:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjESSm0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 May 2023 14:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjESSmZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 May 2023 14:42:25 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276DCE43
        for <linux-acpi@vger.kernel.org>; Fri, 19 May 2023 11:42:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvQaRVm4/nPoPRjp7JacOWb4CVuiKN3+WebDDgnLaLbTJZYROKMxsx4DrOiBMywoS2dHfQH8CPImQDU4O8XiHjLUGdaqEESJQ3QfLaxeVuXWCI9Qdp7QrvkOHP8I7+Dem2TFX3E7j9K1cAYAgsbUjucjA3V05jJe/LibbShn/ZPqU+luo/L6gHDbYR6N9Y2QYKyfb5NSkFbNEm8tGSwm+wPYC2wOSlSAMPd8XMoM/2zX2QJQZDiG91WO00CMWJXST9aG5596OPoGT+is3grBDRPuAHj67b9YTetxV818Am3tv/M9qvcO6jlESu68BcUFbzBUPLYnmCyARoWN3o3yMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unx8iixdguglJ86odjJJQvNzUSqu1X4Rja7CGPmUGK0=;
 b=VvcrneWZuI2TfWVc85Pz0b8b30TQXZyUOPySQPByoO3O+RGr6tIE6VKHOKx4Plw+vbzTBWmKirxKzyfICVHNFnE9LiDjjbY4GQos+qvW02a1JkSOZYdldz3ZwFMDqkoTw1g5hMHEwYsucV/7faf/jZapxAmPdUN5ZLXtd7IaTbjwm1V1fMpKjX04fxvyEkC00GB1i0HleMLMTFn+nVQHhJ4MTRPNpqzeTFG1zjvEOjfEoE/fNjD5eJXP8BjFnlqelm6puWdCaQn+3JiglMspPV3HapxIIYvKtG7YVSPKSp2nB7HAwWfDH2QNzBj0iEmUzlOUypqvy/Q2+FH8X8Nzyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unx8iixdguglJ86odjJJQvNzUSqu1X4Rja7CGPmUGK0=;
 b=MhtGPxW/PrqHqmv2XXFxge3NrPysfPwdGFycl76emEkgMLikHss0wl/sRdjyO3YJD5pXGK/QGj0lHq9SXqJOivz48hVOfi8TbkLuqAYZ5GegLkYx+H0Dso+bJ6r7bDqFP3noOJHVAoUYa4uE8aKA8GvWrqiPVPCeEtPiKX6mOjUawbMWhPBiNBpkIG0PSyadEA1EG4zOoNMzqbE5Y23dZeuaJ7c+kY1voyifWpGlkyZRpDA1+wF1ROXBWDJpWX8IInI//KAsh4oIDSVCVIHg+mdYA7ngeZ1ygcZiD6YxUsSsiSoeFLyOS/tWQtwOCZCuswMk5cAAR/AEz7IsMYVk2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:130::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Fri, 19 May
 2023 18:42:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 18:42:22 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 02/10] iommu: Use iommu_group_ref_get/put() for dev->iommu_group
Date:   Fri, 19 May 2023 15:42:11 -0300
Message-Id: <2-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
In-Reply-To: <0-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0055.prod.exchangelabs.com
 (2603:10b6:208:25::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da57a84-7859-4161-6150-08db5898c71d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PV6J/AaGdVvYazOPEGRj/fc+Qng8EcHnTl59p6WyFk/ndPhgb11/oLGWRXHWxgOmxluYSKSZbJ6r+7FCRaHXsSgdi1LuYGvz1ribj4jBGh5A6eQMuoGMIGl1ELEsdwUB9uuzJB5POIhxye52FkptpDUasngl/2zwHkaiWvRqreE+l08rJGpcM61K1B/jMj9G/igtHVnt2aA5SElpB6Ou/2jdV14ady7wbM2qStNxb9k63IVtMOvOvenrT7+JLjCOK4/NZdUYc9RZOPrV2QKWw6UUh+te7dDWsVvXANUVNctlfLN7r8jRwb7z5iMfAOuDa+67LJ/NF7hYL7idUnaxH2H52T7Lg6p7x88EUoUOfPQI2c3OkfhT29PrZvAtbXUvlPUoQVCePtjFFENbwRqXz8bXw947GVEQNzvgxhBfg7qTQiugVS+sxv91gjZ19yq4J43RWhjIMCqXiDZc1S04h5Pes72nKTP/dhfe6+ADVbjOQ8hHOqz59KHhJA/rQnNJHGD9Kknc20Y2nbdbYEIRYjzwGXRES+tAtl21iF3yZs8vBvBnQ3uiDCEIfKFr/Lgrj4/ar6KD01cNHGzeN5TqBRYO88gZigOTXM773XNamNg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(6512007)(6506007)(2906002)(186003)(4744005)(107886003)(26005)(86362001)(83380400001)(2616005)(36756003)(38100700002)(316002)(41300700001)(6666004)(4326008)(6486002)(66556008)(66476007)(66946007)(110136005)(54906003)(7416002)(5660300002)(478600001)(8676002)(8936002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LChSyLa3fXo4scfl0a2s11EtsVmTQEJeB2PYkDr7cbZlYj6xiHudCE4AlWnz?=
 =?us-ascii?Q?8uPM4gExWrDThHQpm53IUh3i9tG4LfJwv4VwxMRS38DBqlrLa7msKpkOGaZr?=
 =?us-ascii?Q?nciGAnVxnfY61c4Eh2XNd5Thrdu/q0acNZEf22soLz4Unkpy+uG8TL9QjCn3?=
 =?us-ascii?Q?2ei8g91gv70EovaEviOmUDwwpSVRymxSjIDtSUeurlq0cfL669EDPakjGc6R?=
 =?us-ascii?Q?PqEf+dshxzHz5okQVPBis+JY3xntPfw43J/Jq0m8RLVAapmqeISjz6ciT1tz?=
 =?us-ascii?Q?HDb/ziG9GdesS4Bx705V1wRgOQXxsjq1k3GbR3S8prCymUUcZy8fwtI7AMOx?=
 =?us-ascii?Q?Tr4JeWzZScvEAhtAzpZBq1UwVeDenzGoygIUWaP6cQPHFuipYIujJJ7Y9H5A?=
 =?us-ascii?Q?Z2KbtwlcLT4xq7UwKNAKhcrOCgiCHFL/1HbKP/Q3cXCCnDiDoLWS57+Qt+mm?=
 =?us-ascii?Q?jQwNFHSNRHsYHa7KtaazCWQxNnpGmpUyQwpYre8J5/Wddoc6McrZkeyhNk6X?=
 =?us-ascii?Q?HT8Gf9VtMAodkiaWIUmvIdR79TYBLmw1qKSL8UxNMdtnyV00GtxY1uHUUEML?=
 =?us-ascii?Q?Mzk0t+MiOIuCjkU41H5juRty9GVjZ9TX2aA3HTUhlWKbNcmzG6M155YG3Mq9?=
 =?us-ascii?Q?LSi9bYfcsgNJv0xp0soavA0NzfjIFSDsjTMYKn6qcp9RgVcdLpREGuZOJgfP?=
 =?us-ascii?Q?beGzBQ3miMoeLT7LUknwGs5FgCIXaSx6OPWUh8ZEgNvua6lqUZWXL5wNzn47?=
 =?us-ascii?Q?9piIIVQUc6O3q0GyWO/ltfd9BLeWIm0hED7Nc3qkvgXVXCIC2ig9o26bKJ+q?=
 =?us-ascii?Q?tkd9LbB/zkYXeH2DQe+1wc3dGa1kQxm56dBM8EKcqK5mlfDI5isz2n5DHdrP?=
 =?us-ascii?Q?d2w6HeyCa5JrMkxbXDgnJ0pzwv+aKPlI/tnKzevC0eYo440rUepbZnySn+xD?=
 =?us-ascii?Q?X0C/u9YpHHz2/AbhZNSKC6IRaMLbv94gxpvwLTqBMZFiVqF22+QP8bkufduR?=
 =?us-ascii?Q?6ZEoZVPKE66I97TqSu35Yxj48fpkaHQkZvD1dwgaYQH/vonon8z3gKa4Zgiv?=
 =?us-ascii?Q?VZ4sOuHZEWhaIvUA2wLyNQM6FZ531pYJgVCq+n3gPVCq6swNSRR4Uu8bVvZ5?=
 =?us-ascii?Q?BZCAagHSn22mNRwBsP8sdL6ivuTnoQRh5GHr3CKLYpywT3uJKmmZkWsqPJng?=
 =?us-ascii?Q?AxB6oFr6u43/GLJ/mMqne9s874xUH8BiEpK/Bqm2NJs05i9FbWW10/1hnyUQ?=
 =?us-ascii?Q?zLLVlYczE4ZdXj4bBvWTrJjEcUqrgy22ca+aXsPGHu1mp1pCLuwXdHKU3wEC?=
 =?us-ascii?Q?evTtxnMJLzu0tDJ2tNxOARVGVZUuo/iWkFm07n07qN2GO6p+80nqOOAFv3ps?=
 =?us-ascii?Q?ucPi/x0j2RL/Fry5ZjrvX2XsQphkVe03bFXzGgtdOIynhC+2nNqvW4vsLKTF?=
 =?us-ascii?Q?Xhrq/PwLLhYeuLkIQgs3wUAOPYq8WUddfHuUGo8yCpJYl200tijmxvApd5OH?=
 =?us-ascii?Q?qqZAaVFQddoYGKgW8unInyPZNHEYlA9h+jf12o1xOgryNeOLTrl9pOIGIPo5?=
 =?us-ascii?Q?9Uak8i4ON1BGle/h/byMCZeLZj9oMo8Iq97Mpt7D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da57a84-7859-4161-6150-08db5898c71d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 18:42:20.4124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSuk/vG5VPeNWxiDsgibEH55wgYeO/WlHSj9NSdmsg0vERPmbMjK+6s+PWmZnEkf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5688
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

No reason to open code this, use the proper helper functions.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6d4d6a4d692893..35dadcc9999f8b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -500,7 +500,7 @@ static void __iommu_group_release_device(struct iommu_group *group,
 	kfree(grp_dev->name);
 	kfree(grp_dev);
 	dev->iommu_group = NULL;
-	kobject_put(group->devices_kobj);
+	iommu_group_put(group);
 }
 
 static void iommu_release_device(struct device *dev)
@@ -1067,8 +1067,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 		goto err_free_name;
 	}
 
-	kobject_get(group->devices_kobj);
-
+	iommu_group_ref_get(group);
 	dev->iommu_group = group;
 
 	mutex_lock(&group->mutex);
-- 
2.40.1

