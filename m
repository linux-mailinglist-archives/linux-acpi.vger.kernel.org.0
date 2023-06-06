Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3541872343A
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jun 2023 03:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjFFBAA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Jun 2023 21:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjFFA77 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jun 2023 20:59:59 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C697103
        for <linux-acpi@vger.kernel.org>; Mon,  5 Jun 2023 17:59:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2iTZCQt7igALPBPGVCm927qt5+3HVyhVZIOx52jnU6KD6JCxWkG4Xs4vmHnbJt3V6pBDfgH8E3lY/k0Hc9hGJWBoAOOwoh/8QGt/jEzXA82xA9FRWQBTJKgvNcw+SX3XKBv406RzQzEmzx+OGGXqUWbO41aoEs7WNkENHKytu5u1fT1izIFjQqgKv1xTA2O1Hp3oiTR+EKMWifD3OW7tdxBEFL6cRrTvRmXLFWl2QnWLZPyft3GH6M+CLy74UtKtbhl1tPdRPRYyRwO0l2wgnAvYKVJ/vs5aumtS5s63NF6VNA+LhgumnBvkrIUt93+aHzxM5zQLdmWjxb090ialQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LD+aZxD7prbAKwYhMNTTFLzpZAebdsaAwXEyKTBB+9Y=;
 b=HuxGzFSktC2SWcdujUYkvbGpr2k+GtvDd3+/HTmhZcEul1IETCCKzU2cMMzcQrRKWW956pOVZzYPhO0h18wh91kjgJivVo3JS4nc3mMd/dyEvvav6/dzAUZRHahcYNkPWAGjf3M4URfn3GkFtcuiYgSBx6Lu1vD+JcVwN8p2oJrC81ZiRuSha/KQXcFTH0Jp+4y4JSr5bg0HOF0F37MndbQ3I+F4i+Qk8pjEYVkddoZ+OfRr6sCxGLIh6ORTatH7oNEyNVs3MyavdR4PRvi2miL5UY2LBjS6Xhx2piSA6UA3ovrq3pY84d4kA1ahcSylvbHTsFbQfeG8yK0HFzFxiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LD+aZxD7prbAKwYhMNTTFLzpZAebdsaAwXEyKTBB+9Y=;
 b=rwsNx0Fwx42sPRhGCaIZrL8r2D7lrxx0ETn9dxaxo93UfI/SGhQIv3Yav6GyLhm4TFU35E+G5KDAesnCESAKxPiubOKq/7hEJEyrpDYdFtOiRF4FJ+SBcdBfKGi+VGKzFT1dH2PbwdASjvws2fefLOZ0AQ1R4QwAZkSpBFINyqtLtWaaMe7DwWQRewV+K8Bf164nEkWQovDvJtWDREJ0o4/xszKgkGDYBdVDQF87NFyiAW1rbWRUf32VFF7QA526RPgDrQttLF5vYBZpYK4+68vmYCeXxqUb/7bed/qyHhhEL5spKhJwpzY0NE+FeHrO8EMpZv8hIXmZJfYAumDJXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:102::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 00:59:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.028; Tue, 6 Jun 2023
 00:59:52 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 08/10] iommu: Always destroy the iommu_group during iommu_release_device()
Date:   Mon,  5 Jun 2023 21:59:46 -0300
Message-Id: <8-v3-328044aa278c+45e49-iommu_probe_jgg@nvidia.com>
In-Reply-To: <0-v3-328044aa278c+45e49-iommu_probe_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0054.namprd11.prod.outlook.com
 (2603:10b6:a03:80::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 89ffdc29-26bb-46f4-4f34-08db66295526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lLvThqBC81+Hm0NtJtBR8miyk/qrjN3uju9KVNz/ZGKItxYqhPkMR8aYgOKZPVZ50FYaNfZ/wZ6HUd4I09zLVHpksUguKie2vYsGEPDkdRgC1fQwh7Cy+m67AonD+Z2PQD4am9M6oRGweciLZ8wYM6zBOoDl1b3cjfcBRNWSgvB4NZk8L07b1Wh6GPIF4qRA16rXpFqtWeYkzdpryIcvXHWIOTuKUqEkLRvUBX2GGvqZPdtXDwUSSEO+Ax95EJ0H1qmEgK/bCFeDJ4/BvsmQ9qx03DAjFIHIxbG3Ml6CuX66pdwuzXqc9l7QhKv7ploGl7SVccb8VdoFBFExPkR7YiuFJrKbymGyzJtXYXfqEKbYZtXXBFmnBSzhyq7rTPle9l5wIPQBd2yPKoDw9ImmZCRXS6/kHfH21ASO5lHEBEFcsDs7p3eMgNADq+MkuRuuNdeGij5K0F63oqbOHcIEIYaip/CDLxq0aHbbkhOy0D4kyCWsM7/mfD8TlrHZPPzp+ABdq6PkfIDVdExR7gFyoNAI0gk2vgroR+H4biNlt/ioKJ9kXMYdJ+zems+stV0AteabyXaRMQB2wEgj/zuE1VRMsk35mVl0IbDy8H98jMg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199021)(54906003)(66946007)(110136005)(478600001)(8936002)(8676002)(38100700002)(66476007)(316002)(41300700001)(66556008)(4326008)(2616005)(186003)(6486002)(6666004)(83380400001)(26005)(6512007)(6506007)(7416002)(86362001)(5660300002)(2906002)(36756003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zkf9UnjogYNDIsuy9AifvqTeAfAEthpMWQzC4D6DF4h8L9+rfqnn9gw+fc+B?=
 =?us-ascii?Q?gPo8FaA0HsA5AGWHL04Aq+oSYQlRO9h5rdV0KuOmn3EOvPSb4+McMd0A6o+v?=
 =?us-ascii?Q?aaUql4bZsCOSa6OdeUKeB8E3ySubO9FPC8Qjd4pbM0Q0tq56w0JTWc0padAV?=
 =?us-ascii?Q?P9VvQt3+f8mVlxE2XY5zm4fCp1CryWXJCIr/WB1AkZFKDqKdrkmLUKOMIbeT?=
 =?us-ascii?Q?3SgZx217cYUFyRfPlnAY9LklCRFXG7QH19iVWlffLgVRAo0Dja+lSFciCiqt?=
 =?us-ascii?Q?27n6mZI9WFtEymGYuZfIO5Hg0833ZIlVnds0Q/Tc6LdhutCTyUs5Wx9p7tL0?=
 =?us-ascii?Q?Yz25UI8pyU2SpPwFtFOBPPCnssYkqg6VPW8VfC4rA4KxB+0dPrW1P+qr/C4l?=
 =?us-ascii?Q?eG4COaeEC5yauJ3GimC7qPx3Vd2pI9t0V4cj/ajS5V3Wn9kBzLvPNaE+5VTf?=
 =?us-ascii?Q?OU0ndJTSo22j0HGUSfQ4Igk8Y3qFY6bc/hpitiwEARi1B6VQWRaM1Ynp4LjX?=
 =?us-ascii?Q?dMPlDU3T6ojpSCYOapGkecuJOFoHE1EMuJNseCTom79ZmWbzr7Q0+eKNFWfm?=
 =?us-ascii?Q?QOd6cuISKunw46pFdjc3fzF+egmsGIQWmdo/N89heGLJIFJeft6mJf+SAWbA?=
 =?us-ascii?Q?TNK5F9ccXhH5n62YhA3jjdmL1gq5iPSOYUB/ilF+Z5B6wtH2DYfiL+wuPmrR?=
 =?us-ascii?Q?nQuJKLwafjPWrPugsXUCCbJ/ZTHigQF++E3EY2Rtoo+qvwsTKDyMoCjaI2Tt?=
 =?us-ascii?Q?mCWfG/vXkRccElu4RIewtXVegJsgUppKaXg5+1C4nB2IM1vJSXYMvxpufVLj?=
 =?us-ascii?Q?L1nXOS/rPLC43mdjM2hsKdd53fxWuexnTgnIUI/ZQGIjnRHEfs64WxUEbmbv?=
 =?us-ascii?Q?W7ghGSiPXZFege0PVnvo43z55dMBOCvaHILBEQ3SE0dG2DG1WMqdViRZS13/?=
 =?us-ascii?Q?lR92MF0ve2bnl1C9vi9MLbvb1kxyonLQmY2X9oBm6g47NYSDnYg7vYp9/6VD?=
 =?us-ascii?Q?29NiKaN9Z7AU91FteHaomaTD7zkjbCnjUHsiLdl2c7ZNLVvB0qlJ5QBZY7Ca?=
 =?us-ascii?Q?hqtn1XBc2H0TQzGeoitl1QHF2RpIBzBiP7TLDPIn6ZMDqg32FtDlBIh2zvlP?=
 =?us-ascii?Q?ygEECkd7rjb82d16PnIpCoMD1FWVinXYPPcHB5MymiiLWhkjSd+Bv4d6mSfY?=
 =?us-ascii?Q?w0Hwhf/v964qu79k5e2My4W8vp2L2E7Ne/o1eP4w8cORQE/1F0HwZc7+V1Nu?=
 =?us-ascii?Q?Y+c6n2HY3Ou+LkB8Ds8IWG4pbiwL7rNMY0IYbbf31jdNBVWywz1sOl++qtBE?=
 =?us-ascii?Q?JNpfNcDHj/oj/PqANqcvsVGb+pIIBPvLDGaxHGmDf+2yrfgXifLCUiWWRhLs?=
 =?us-ascii?Q?b36VFQMvBpYddewQVMwVEUQw0jn5ZQX+p7HSfUSTDx82C4Ms5ArswZoOe9+k?=
 =?us-ascii?Q?yaz9GI59zlnUnwXzN5hPniQA/AqbyuoDisvSm/z/iEGD4SteAX+jk/2YMpN0?=
 =?us-ascii?Q?Wg4xTLZdyNkKeg1lNCXyG1KXoO6BM4djPEkQcyMQcZS1j1SRGkS8Ey7NauC8?=
 =?us-ascii?Q?Uf7O0vTFIeVTTgimo7rk6uyoAW9Z0f+55j2sAvgZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ffdc29-26bb-46f4-4f34-08db66295526
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 00:59:51.2304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLonQWtX8tJ/V+/Kw2CLzR8HsTmO3oTa+UcSViFtj94DpU12sqp98WZbe10pcAJa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765
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

Have release fully clean up the iommu related parts of the struct device,
no matter what state they are in.

Split the logic so that the three things owned by the iommu core are
always cleaned up:
 - Any attached iommu_group
 - Any allocated dev->iommu and its contents including a fwsepc
 - Any attached driver via a struct group_device

This fixes a minor bug where a fwspec created without an iommu_group being
probed would not be freed.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2281f3281ea4a0..45d69462ddedab 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -574,10 +574,8 @@ static void __iommu_group_remove_device(struct device *dev)
 			iommu_deinit_device(dev);
 		else
 			dev->iommu_group = NULL;
-		goto out;
+		break;
 	}
-	WARN(true, "Corrupted iommu_group device_list");
-out:
 	mutex_unlock(&group->mutex);
 
 	/* Pairs with the get in iommu_group_add_device() */
@@ -588,10 +586,12 @@ static void iommu_release_device(struct device *dev)
 {
 	struct iommu_group *group = dev->iommu_group;
 
-	if (!dev->iommu || !group)
-		return;
+	if (group)
+		__iommu_group_remove_device(dev);
 
-	__iommu_group_remove_device(dev);
+	/* Free any fwspec if no iommu_driver was ever attached */
+	if (dev->iommu)
+		dev_iommu_free(dev);
 }
 
 static int __init iommu_set_def_domain_type(char *str)
-- 
2.40.1

