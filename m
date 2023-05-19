Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432D0709F40
	for <lists+linux-acpi@lfdr.de>; Fri, 19 May 2023 20:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjESSmh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 May 2023 14:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjESSm2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 May 2023 14:42:28 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE971A8
        for <linux-acpi@vger.kernel.org>; Fri, 19 May 2023 11:42:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1P08YbrmpNxnRdrQndb8YNNHq8wfMno+MQqtPhsi3BVm+WCE/I5dkUGRDSrqYbcmzn8j8iirZJIld9PE7t5iaFwuykW1RBD6ID2et0RLSoG0wy0MVqLO1vLE3LcgpWu6oKMF4rQqecO+cAMPV2kpfKZfbjDUPVf40tvYpxW62biKGmZweuYWnEqabwMZborVYeYRNQyoliz6FuWv02evIp+903RX9D7sffoJyYjssVymzT9Habc/dp5JBRQhsyYVf7fvUeOq8sxgJp0SiRSv6nmBRJZpo3/eRdiPWCqef/26e1w4XiFRTYeKi4NbBmW8T9spzc1GVYOfyIEgnHcNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5sK9T7mR+u37FgOSN9zxH5lJAsl+6bhGCeOIHAvo6k=;
 b=mLN+LrJosFYo2T4WOrdYRRkv1EceFg42FG1EeOaqgbGEd6YagQVKQWQ1EG+xt9GGFPJxW3ysizXYvfsCQQf5w7rv8c87DgI7AXZ8VcoVFQJMAXuvj961Pctxwxuq4Wy8NKOyv6uO12COiUlb1CCjsC/hVN9ajneSWg82nci2klJnKyjDBYyg0KcqK1zXd0V5MN7Xslz3Go+IPHhDSHui/bbqP3YUxjww2yeOxKAt7B8w0/e6mL8xnqMmstz2OViZaoESLZ1W/OtYlDUGcBUCuspLeX7zd/3GBk2ADacSv0KWn4nSfShfQjZxRspJzHn8ag1UWnr6aDENe0gXBk+1LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5sK9T7mR+u37FgOSN9zxH5lJAsl+6bhGCeOIHAvo6k=;
 b=KsvGCEvzfMT+Nu2Jg1TEqZOdV6RQpEVIeuJDk35q+YQhAcH0TwgZvyoxogEXWmgjVnquwDkgpZcizU02TRr6HD+AU8DXq/m+Om3NK2G9Z1zt1os7Rn6o7J2BBOMzIS0nZzUNEqm+gIqQunQcuuJbuMjM4caW8Xhq4FQ2VKc8pIzq1x0qtVa0LCh9Uwo5TolSWFLCcGy1e34GN3zDQ09JOLH9QC306OwLj+DaNso0Y7biRAvIYN5JnSrRI1Bv0Z353InGDkRkqtuE2RHNonoHOoCwYPEe4S7jhKAgNnF0hpkD2sT7kGkc045Qtwwq6Xz24b5lQZXwZo+VNG8Tm+IhDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:130::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Fri, 19 May
 2023 18:42:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 18:42:24 +0000
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
Subject: [PATCH v2 08/10] iommu: Always destroy the iommu_group during iommu_release_device()
Date:   Fri, 19 May 2023 15:42:17 -0300
Message-Id: <8-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
In-Reply-To: <0-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0341.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fdc39ac-84c3-4211-cc6c-08db5898c78f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XQzUP0+pOQoJEZhxEF7hpGPzAc4ux4C4e1YsACw0RlJo0OSUD6SpEA2LEalERvB7yGNQeXGrhr7hXRtiSx0d1WK8bS9Gkp6LysQPyD5QvHuSUjQS5oTmRM4LJPvqlg8VVa6O3dLFOf6+rS1C5PEZLWOaE5pxsDyY+Q+3/Y2mgagaPjVTJJkEA/fY3H3WJ98ggxeghFU+ICtZ7oodhnm35tVdZePwLYFk3EsGyIVbTQSdJiXQVQd2Pwu/szIHj4hbZaJcJgoaKT75hZ5fJXp/npnWPq7pt8NwzFy17hExjo/uR66si4VrMRkZzPpzQ+GPcfU2b0KjW6FTxjPM0Hwu+SZcoehc1x567L02MWyUz1HTR4pTPoPPtxVCly/NhTLejMx45WsvGAZRpZJYs8bcCfupKTZz4S/0hLvBHMJS1PqDSQP1bmMPL9iz72M9x+rTgIpSveTofkk9Vsx+r0G0Y72+f0+3BIVDPIA6wQassL99N5736GzWUx7uiIVoYNNcHt4MQmpQ8ehtky/y8ap+9HeLXFfKOM2fm8dq1QxFC6zg5raie63/qDeZRHBxatXxg/SWuYW1vhiPRlh6TkWlsc8lTwylXETuHqkoftrQbas=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(6512007)(6506007)(2906002)(186003)(107886003)(26005)(86362001)(83380400001)(2616005)(36756003)(38100700002)(316002)(41300700001)(6666004)(4326008)(6486002)(66556008)(66476007)(66946007)(110136005)(54906003)(7416002)(5660300002)(478600001)(8676002)(8936002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ugLYxoKtvwomSLvbUAhQY7ygVELZ6HiESEOyRazqmC2/4Ao38ayG9otHr4pf?=
 =?us-ascii?Q?BcP5nYCADzi+3eVyg65SZNe36f/fRj4jqBXlLMfuJfGHBIIo7LdC/9H30oCr?=
 =?us-ascii?Q?/Qdk+dpNZSmJxpkAvEj58AmftV471B5Xp75s7PvhlaoE13iMtbyUVglf06vO?=
 =?us-ascii?Q?EkfVY+zZnlkzmQHR9syiOHo+GxfkWf2dgQjtEoarFSuGqAoRFOWwQ/Y9aeM/?=
 =?us-ascii?Q?GUXFXDnkCSOKy9/Y5y5sf7I1EqYkqNLmSwV4FwitMnM5PgEva4wCvPvIo7UM?=
 =?us-ascii?Q?f9OMhlnQ4op7/5CnWPLPT/Csq4mGB5YWhn3kyUcOPxek9gwusHThlYbW1vZu?=
 =?us-ascii?Q?LEwXP8llHGH9xir//UGcP8BH7WGUA1NTrvxu+mrqsz2tvOeUmAPGEeDlxY/l?=
 =?us-ascii?Q?gNVXxPzld3h2bQ6hSIwebHYvSbntn5u9BvQbMtjYtZ4Ma7At56Rg1161FUNG?=
 =?us-ascii?Q?n0Vrdp9ROARtvDJqXB3MbxJuZ3Rp49Wxh2Pi3kRpPNqM5JQlylwAM29n+ALk?=
 =?us-ascii?Q?ISh8sYi9yDPxTbjVyWYd3JyQaTK5B5pNWtxkrH0S6tDkc/wziHsWgQtIHTj5?=
 =?us-ascii?Q?VDnqO8gfdGuat+mX6fhkKRzrIrOlAa6FUH3BLVTXzk3WTZdBOMRFKMkUQ9ZS?=
 =?us-ascii?Q?lwGYqtgVeE7moLMGcTlkkvSlMa6lbGO9KJGR3e11aDbSteam/SbAI895VaV4?=
 =?us-ascii?Q?YDc+ti/aLNRDs0RAkEIyd6UyJzVt0A5kms12uMO9+/E7FmenFVNIKdm/zDuc?=
 =?us-ascii?Q?4jtNbKw2n71k8Ayiyjhn0lGsL8wKqZcFwQx6UqI4OtwQToCl/b/xCiLoaZtW?=
 =?us-ascii?Q?Ffmx+xiLImL4RzeSEDxsX+lTn6x2iDU7PGfbTPZsDtMjRcweUXSexA39HtQu?=
 =?us-ascii?Q?iaaRES3Pki6U8vNbWA9gsmyhKibWClIa3/kFtt+C8mNuFh1d97rSNqhmO3P3?=
 =?us-ascii?Q?GBa88xeJ21qEWlWkNBWhKd98wunBBn/Kckqz3BW/ihHOF2Ki9OCizYh1wyAr?=
 =?us-ascii?Q?bS+fvlIqx0mFr1D6sZI/ywf+lYIwQcvX6M8dr5F1hNqerxHmknUL7xSryEZa?=
 =?us-ascii?Q?6+KD89OXIXF25uVJ1DclJA+10apfURTp5ymIBubtJLR3LKRkWK3BQhXVdUPj?=
 =?us-ascii?Q?2izG21JRQt3WuF5SWP6t+tbPtb0YH21d/YbtTvZoB2NHrp6CHBAnioLLKvZd?=
 =?us-ascii?Q?8npHUC793kZ5GUSno8FIQrTQKlkDrc3B1GtCLdbHW808Ms1iihRC7TO3LFom?=
 =?us-ascii?Q?IrcqO8oqEML+6oWIDb97FKrRMzinEBzRMIXqzLyR0XXwpD/NavE11ivhw4gx?=
 =?us-ascii?Q?HWqGOY2VrGN8KnWWUZwP033KqxIaHG3qjugqkreyVuLboRmS9qkcgrIYHMov?=
 =?us-ascii?Q?BmQisTPDoDEziIPRwT/l3gF1a7M6qEZGObyvdz+O/4J/rycSX5I9uSUgHkcZ?=
 =?us-ascii?Q?mxb3mF8qn5OEtfbkqimWTMUkpk8uZrxIw8bzn1ZBaZ2dXBdHrrISJCr2in20?=
 =?us-ascii?Q?NS3vVsLRdBIrlPpyvRWr7SucgzMvZ3GBmWkT9Cs1snKQw4dPYJ/giecUbQYN?=
 =?us-ascii?Q?1e3EiELsfwYOhS861xaTCmk2iIG8d6tr5duUWIGP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fdc39ac-84c3-4211-cc6c-08db5898c78f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 18:42:21.0787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s48bNV2MMp7TRA+0xkdzBwhrB44YRsGTvx1vcvC8+NNeluvtBJXY1wDsIQGV1kGV
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
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 69e4227bb7404f..6a8cbfd2274770 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -575,10 +575,8 @@ static void __iommu_group_remove_device(struct device *dev)
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
@@ -589,10 +587,12 @@ static void iommu_release_device(struct device *dev)
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

