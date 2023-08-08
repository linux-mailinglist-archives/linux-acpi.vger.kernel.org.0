Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A5F774471
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Aug 2023 20:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjHHST0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Aug 2023 14:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbjHHSTJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Aug 2023 14:19:09 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A199852B3
        for <linux-acpi@vger.kernel.org>; Tue,  8 Aug 2023 10:27:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHFecMHuto7F/X0edR0PBMAi8DL6Q07ZAwsg3cJ9o+MqKYyuiHVn1PBfJUhNy0A36Z8khzX9wLyaw1bVi/jd/EsLBJEL44+aXWQ8NHlbTWGWXflSaCeiJqKzd4WJX/qnyVTzAL52Mm9wce4At+IOTwRggd0kg7520104NuRtUo/kKfwIYmFmq79OEyW74vlopGyTsW0bOLUyDkxz4NKTksCDN+00ylJnP3oCSxFNfZpENkCQ2VkWwseoLiDE1JpOMrBr2QwS/RxcOyllo9+ikvZS4L3oZrNe3H3Ad5tzgg3IWZLqke1BCskI3qnda36Kwra1fVNb3IZIFW0za9rQwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4N6sKNg5kBlQPH9HkjBr3JFaOQhx8ALNhkUkeq9GWk=;
 b=jUHXoF/iwKxRxMcwJvO8HYGCpeThu3w2i2bfRqlvQqymszvzjU31/TLf5cbLxdwSS0OcqNuhXQ0x4THmfd4alY7BgEYzRhvtfhEd5lGy2dVGMUV0HYSfptpnGlayJs6+LCUk7N1XZYLdiSJiKo/KRT2SrzJi2uI/OOGhU8f3PteRfSotLsb0eOdy1Rn/dgPoV5IVb8BSGm6FgMaIgsunw6unDLl6M5u9wL+NEy4V0Bhym+dkHzeHC0WlaUnU4NM023ToI2csGGJk7uyeliibr8IFLfif8Av1io2hjO00G/qig8NITrjJLGrSM6wp5mAJcUU3ocZojqEcEt8KB7iK+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4N6sKNg5kBlQPH9HkjBr3JFaOQhx8ALNhkUkeq9GWk=;
 b=bVKK61NmeBCObwlWvccRi1njrSKy78uQ7Q05KAhGE/395WyDDhcx5KDeKUT4k73sURZSewl1S3pbZmfxujWN+y/NnhB9BLngpM2j7bdbiMRRsfEZ3rsRR36BVqypVkfMZXCUAZpLlyk48JrwnE6NLWM2p6qkoMmDVZ95XEMK1iGcf1KchP+tTzPgZxW585mkzqzoFH85YhnHgaaQEwx3kZCwW5z2IodQ3Nl+dS6vwoPp7mjvUyetNmgJHBRHo40j+NArfxDtTzNXTqxjyDqFn1WCMvTcpLSJuwMRI1Nfsd8aGyymR/HyYgEmYlaC/eL3xn2GVeLEyWwfmJxGGhvB6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8454.namprd12.prod.outlook.com (2603:10b6:8:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 17:27:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 17:27:09 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH 0/3] Fix device_lock deadlock on two probe() paths
Date:   Tue,  8 Aug 2023 14:27:04 -0300
Message-ID: <0-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0419.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b0e63a-cd7a-482b-3925-08db9834b16b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7UQ0GJEGICi2rLd1sdH2nukkDJVHkktOgxPV9flHvO11BL+0Dt3j/8/aECwR2TGrKcJVFWmz6AMKW0Al2gG6OQGiLX3vCYgUK5TtcR5xYg3MdR88GC06SZn878mVU+aZ06avgIXtGY2uAo3yHGUm2Qu1YYiTBliLlevKZEbx5DVYXdhudsAc09yJPZSa6RULZkKG/48XRFdfixuYgYOsm5VgQKkUp2/80dObQtntanwZYTMoHokKnAG6kf9jw73Cr/BWrc74fLAn0hXzgeEFGN8aRIrBvusRhlb7UV9qAcbZKEmyTMr3wQTsCZ642VWeq4DZ4tRG9AZxVsPJiapCxDB0oG9h92FHcki1CxgOzJ4hm/kv9utN4VYFgPrPjdr6lyrqJCORNOpB7q+S/JkTJgR3vOSN2YIEEvuWDcD+MTNBErTnaJM/tHQ4yATVFIGz1EKP0JY1qfNWYcpbYqsTSHO1Afyl9qfxH/jd115bbhnN5K/Me73I8qzJv1/5yDUx5D/GrXPLM7hnk5iMv5CLPrBQaelBFnqd39/CjSN0zgEfV+IpzFce5MZQMWN9k1shXrRheZGxQgj8qeP1PxGHPMoRtZexisgAep+IjLhqORw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(186006)(1800799003)(451199021)(83380400001)(2616005)(2906002)(110136005)(54906003)(4326008)(316002)(8936002)(5660300002)(7416002)(8676002)(38100700002)(66476007)(66556008)(66946007)(6512007)(478600001)(6666004)(6486002)(41300700001)(86362001)(26005)(36756003)(6506007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tOSAIqrwnQc9/lzreYpxyfPB503aOIvFI2G1cV4TOLhHJdu7tbEg8GUEwBqI?=
 =?us-ascii?Q?xdlbSwzeHP7chNBPeXJlSxU0J6pit3yhKouMljZ+UutN0s1iOsdF+4YhAN1X?=
 =?us-ascii?Q?nWNPU0MGy+pJayqzaTI/yXUBOKwZK9WrYWlYikZ04NfZOtuV2NZCoH26JbWM?=
 =?us-ascii?Q?8nuCmvz3veBLeCxM1Sh4f2qTf9ntthHdN2f21NCBYk7lmp3oQkUPZigGzV6t?=
 =?us-ascii?Q?Nxq1JdaYuPI3vLb5ggCmeI86QVkDJXWfZNgo8/t6+3R++EF/kWK3UrVUtFBK?=
 =?us-ascii?Q?hvw/JjhawwF0HFEQO+EF5BGioZyafeqoU3xMBu8nbb9hEnduIMdGT9OOL4C+?=
 =?us-ascii?Q?CuUZEIlnJ1zbcimDWgmJVty/Uq8GTqkrQJHMUFIgkOnIPqSspsobAWUG4QE4?=
 =?us-ascii?Q?ZtVUq5MmS3+Q+1Ukl/xlD/9aYhIurWYcJ9VmOZsxJXaAXhIc9EvN8vZMXa10?=
 =?us-ascii?Q?kfSLa+V0mrn3e7/ZL/kpi4w8H/6F55MOVPGBfASN7PxKTZpPjwooewyU8liU?=
 =?us-ascii?Q?ng546xWnsPQnQb7VE1K7htpOQZgCy2kbKnCzKp1m19nkUQ6+kgla+GhS/Kiv?=
 =?us-ascii?Q?/HoOOCbbCL78Iw1sII7HHu33wlswk3zWhnd3OOWQWzyrbBXBdHofEwwkAJqb?=
 =?us-ascii?Q?axeBhLAwbe8co5aDc217xfs7uVIrdvjkHVdQjP8cmhwTF0fs0H5LFBmH3enJ?=
 =?us-ascii?Q?vSZ/4xPuSEXMUzxb0uIrCIGUlweosi/QhnZvAxN6FgGKaluNFNg1psWc5Fy3?=
 =?us-ascii?Q?g1RofBDmQXbcNgpBfCghUiSRJAC36gzUZeYmLgB1zuqTjR5gNLEDUgPNdiny?=
 =?us-ascii?Q?TxkH/WWs/HC7G2cX56J6Tyevafd4Nm1FYVOTMJkbCysCLPRxly1ATd/LTaFx?=
 =?us-ascii?Q?Cg79M+gF5OWvogZq2XsziKVVDZ+eGTsGXxxGzpIMaay/zijfGKSSo7Z5n7MX?=
 =?us-ascii?Q?tUV6Teuj+nrRlypOi+7p+v/N9Ijm9vm5vXRWN6my2zySe69hIPHumsSN6rDi?=
 =?us-ascii?Q?lxVhEZr6kDtW3hylwd/i9DGIKegl71bIGRsq4M/ZdcJlbnWCTKx8b1rCsUtd?=
 =?us-ascii?Q?wJGBlYvkuYtIqoRM1+NeFavIfUmSF0Yjz6Y9WRFOQxpbQ7i5vf3MHl1U0nc3?=
 =?us-ascii?Q?mF90OBUGnSNLMpzrnxK+r3T+dWI5lEbLUmmjH1U7CVHbE5oloAzq9ySmc9jD?=
 =?us-ascii?Q?olMqm1sXYcH4xDpoBZWtjPku30Vyo/o1ff/8TWkjM22jG8bzuw7ZakVN1rUE?=
 =?us-ascii?Q?5xJfT1vZZgv97NTK6BnRZ8wog9d4Y5Vn/Dl1mcdPMJkL9xJTjleRd8paUzmk?=
 =?us-ascii?Q?YgPfWCbz/p012+BDk5ILZe9oBuekqMfmIb5rpYn4EgLfBpKkOZrvyo6NLzCF?=
 =?us-ascii?Q?RjncYkhZhfE2CGOjlO2XGLf5QmuKIvqC4VMdjy+gL85DgvTcUS7gKRQTHwbB?=
 =?us-ascii?Q?4+ZsGtu0SFUYYcPsew2y4nznOg0xa9mrVxxvACY76x3yCZaHcI5FOn5n64/4?=
 =?us-ascii?Q?gz/8RJR3n94ayXxycrS2ukEabgR553ub+19Ftu5b/5JklCArR30w6pvZqeaS?=
 =?us-ascii?Q?YzqJLAmToqi2x9tPlUvL1GMkdEUcmtL7YAs1eE8l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b0e63a-cd7a-482b-3925-08db9834b16b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 17:27:08.6430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NUnQJiQ3U9OdPOeYJYgfQOno7ESXzAVpb7AAqnZIf82SuOWOWQDffUQmdWzwSOQf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8454
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

I missed two paths where __iommu_probe_device() can be called while
already holding the device_lock() for the device that is to be probed.

This causes a deadlock because __iommu_probe_device() will attempt to
re-acquire the lock.

Organize things so that these two paths can re-use the existing already
held device_lock by marking the call chains based on if the lock is held
or not.

This is an incremental on top of Joerg's next, but it could also be handled by
respinning the last patch in that series. Please let me know.

Jason Gunthorpe (3):
  iommu: Provide iommu_probe_device_locked()
  iommu: Pass in the iommu_device to probe for in bus_iommu_probe()
  iommu: Do not attempt to re-lock the iommu device when probing

 drivers/acpi/scan.c        |  5 ++--
 drivers/iommu/iommu.c      | 60 +++++++++++++++++++++++++++-----------
 drivers/iommu/of_iommu.c   |  2 +-
 drivers/iommu/omap-iommu.c | 12 ++++++--
 include/linux/iommu.h      |  6 +++-
 5 files changed, 61 insertions(+), 24 deletions(-)


base-commit: 8d3740021d5d461e1ec4c17fc5625b9b4237c2f8
-- 
2.41.0

