Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE161709F41
	for <lists+linux-acpi@lfdr.de>; Fri, 19 May 2023 20:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjESSmi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 May 2023 14:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjESSm3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 May 2023 14:42:29 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ECCE43
        for <linux-acpi@vger.kernel.org>; Fri, 19 May 2023 11:42:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lE29d6Z6f8g1yn3ZLZO/LgIpbMTyMJk33cb6QlT+d2GkNL85ssgMUWpJdtQJdW4qR0VsGSifx42RKyTdI5F+Y5TgfXc8ZFbd1rng8R/u0BLZh7jwBIgwv3hHA3weOvlkdzhIsSLznHb7olSflVJARkamMbRT17H4gaKHPn02KGRczzjbBDAanOcFJJAQAGRMDPceSbe56HzM9Dyh2CRQQdDIhSsXA6+TqwnKQBdvIAQCSjrpnpEk86kI17ig8oWynUn0w2I5QQAN8ZkKoF2FF/cfENGRYbPJ4xd3Gu6FZU+9BuCU+4pXx1WUnM+vRVz8arUZntG9OOyDBYGyafOOmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+Bq9zNXxrmJODoOeGaxt1lJSZMW0NsMqo/oobnZ6JI=;
 b=Pc7EW9Fuz3U0PW20ZXc7uKrSc7yyXHPMt/NDFw/uAEKGJX5gRX37/H5AZBVMqIsPjDk5iBpMCzy+HfOdVGzRbA+H3tPOstqGJ4LwJ2GuUCz5Gy+YL2tl0dsmacIRlbZUaMu/BoBUtBTRQvxEoKHxa32kOaNweeQ6xrLZ5lERkbxYZec5B6l8i2CWPxwezD9OX++rJKat9UNWGVoOfeM0Vj5JUmCVgYSb/buM6sdDUrDR90NDTaldqJe5jf5gVvBxQ2EDwRVLjpOSIezBseoOxewm3Znb+6H1715REM8gSV7WAPgaimHuqILM/Nz+8IJa6etqXT82I6IjQT6Az6eiVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+Bq9zNXxrmJODoOeGaxt1lJSZMW0NsMqo/oobnZ6JI=;
 b=iZYPHgJgiP16hWEezonhtEtEZdHAlqrvyb2RIStNV/ZY4WFYT6mPdbiYiQMjQNy0ijx7G9K/DpiOFS6H5BImwkRHAPYWnidZn42wpDmMtcxw+bev+4jbDvDfGw/fDdb5HWnXoTXKGu9ijkZ34j6u4kEcAtOGIP/0p4e8n/5ohXKDBUyluvvHB07v7tCiF+R1AZAEixfIy2RZgW4QGhOTNKqNybfZ2xRFzPwT7ndguGDZ1+P/tAUlfXw7Lc87s8tWGwzVQ3rjMeDa3dGGLXj9Jko7mNcmPpBLGe+WXykzzeebyQoz4mwffgFNU7qzoAkBq2hiefYMy8VUfvAqNA9ciw==
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
Subject: [PATCH v2 10/10] iommu: Avoid locking/unlocking for iommu_probe_device()
Date:   Fri, 19 May 2023 15:42:19 -0300
Message-Id: <10-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
In-Reply-To: <0-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:208:23d::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: ec6d354e-42ce-497e-f321-08db5898c796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J0IUFTH0K8nR+3M9RtPA8Cpjq/uplvLafmaFPisVAligmab3KovqsA7j2VMKkGbamphiGAwAhscNMnue38w2CtYDgpqa+f+sc75SER8llHEMY27YxABrrXueNhj9tJVcrm2uXd7geaoS6TXv0h7TxIBqxrlU/QRVYAIp8TKDt17hnL9pV31Y64BOQpXCSz01lfE+n7PNuvZsEn/Xu1sYdKLw+f7EjtuXZkqaj1h1/dT6oWzKAc6rA9vmlEv49xXr4mvfQkPLAWCYwWsHaADL990xHoZ2iQQx0pTSJnQzQGtNKcK/A5FT9HRxnChfROjnvFWhtTjhN6TwR76eFxduohYzvVmvUS6HBplbO1K3LhMJMF5HImqfLArDC/4sWB5sBOiuuSvUq7GnDegz+nC8ILNY1JARRLwwjT0g2B5DljC5imwXRdL5OuR5UDexPlLsL/ZdYpQnbKB19Dcul7LA9+SHUGOv2yetJTTsAuKX8Vhv8Z5t8C21j4X2TewbwzzUiad/TdvUMTFawntw10z6c0+cbA06y6HYBQKGgKFGHg/faMiCWBQRWRsgHtHfjKdV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(6512007)(6506007)(2906002)(186003)(107886003)(26005)(86362001)(83380400001)(2616005)(36756003)(38100700002)(316002)(41300700001)(6666004)(4326008)(6486002)(66556008)(66476007)(66946007)(110136005)(54906003)(7416002)(5660300002)(478600001)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VZJ+HZas8OVbE+10g1AJnGELCOmr/9bLysG/NzaM5hKLOJp5jTzVkZeaJlTP?=
 =?us-ascii?Q?1KfiRiGFkZmCLgfnhq4wt7Xy7f9W4B55yL2qql42nR+kDxk9r8KPf3Rvy3Dz?=
 =?us-ascii?Q?inLwQWGJ2Wo4PW+1r8zFBAj9n+3V5GOk1KilBN8BI7o6J+1jc70RtFPhLlVG?=
 =?us-ascii?Q?1ofeTpSqCTRy0tbP/U1QigC7oj3e5knuciIRY+SvKuqxT4W6NCBbUEiamU3G?=
 =?us-ascii?Q?0aEYa1wLPJ6sX/AufjfyPWcUYt0vhtX7WeqgXlk6V7/l9axRkPS2hZdBJfLG?=
 =?us-ascii?Q?ipypzvdxoPEFN8HEI0fbehILbnpzPD75d6eAszAsYpaCwxOlXp37VUmZftEX?=
 =?us-ascii?Q?rWQl+CHTXna83JAet+/E7Zbinc8b3pDANvl6QsHbB3+PolyVX1ClCBCCn9SA?=
 =?us-ascii?Q?oLmjTd2bKfoRtOaKT050T8v0x9vuCuWez/OfymuxSNsIuaQesVLg0Clv+U2S?=
 =?us-ascii?Q?2Uujocma66XJQzi8CXomcOLQth42ygHKXshy8O4VJqIZi0p5dVcXKGKlv9nE?=
 =?us-ascii?Q?ft5BLEFejobSWD/V0GqIqTakJgD5Mssw7day9l7aiUHPefVfxFvS73RmB4yb?=
 =?us-ascii?Q?vXgQvv+47Y1pSJczmYNm8Oatss2yYc3ygHUUobzrxvAOYLZETOanTNJyMzVG?=
 =?us-ascii?Q?BlnQWXAUjTi2tiXzsKsMyMJUHGOPsJoDq1eCbX8LYH50kl68+By0IpKnFkMz?=
 =?us-ascii?Q?looBqxM8ujSKeQoizOfrE9UBq/8LDgb8tU7ORhfxY+xNvAEeEwxob1vShoRp?=
 =?us-ascii?Q?Onv57noGs1p0CLOpuMDgJq18aC9AfjL6xfET8Vrh4zfrAZLcjdda2K2nRdJ9?=
 =?us-ascii?Q?ftCkGlEx+WHA3PWy6Kvhh7SnH7uWxxM6UyLONOd4eQ6mpFp1bBsr7WaYvXcV?=
 =?us-ascii?Q?S2Mt2EAsGLgHbE2qpp8d4xBQbWP3RbcH6WJ09TuwCjKNsu98pM/Uh6SC67aQ?=
 =?us-ascii?Q?OF7ldYjo9hTiPJUEKY843UR8p8KDSFyTkBhKca4zHK4KITklm/Xczeq6dnQx?=
 =?us-ascii?Q?AiIBkix3J7vx2a7n/kzFr+1emzFyLdid5yu6z1BnpnQEvkFA68VYS0R97gYJ?=
 =?us-ascii?Q?gPDkODSVB2sxIBeQgsAqva8votlywrAy1jx2mJbg04BYr5VNg3+wE6cRUw6d?=
 =?us-ascii?Q?IDfp0forrKR3vapONrMOvb4/zdud5kG50GG4VCj1SiSgHIIEgW+RE8Z7MadG?=
 =?us-ascii?Q?ZOhr4AN99sWouH1TeM/1fJQ3vajUT6Neb128vlrhkGq4sTzoa3w99ph9vbvO?=
 =?us-ascii?Q?KQux0Rpcmb+qF6kLq4kNjMC/ZhMn3m22QKTcpDrDt4I9zD0PpkWvBnh3x+7L?=
 =?us-ascii?Q?wp/BJu16vRHdscnzvfup9KvML9lkPTxUW670ajk+bU38GdHqUoAJdt6JWsW/?=
 =?us-ascii?Q?5hcMw+moQ24fITvutK6k2DYqzzkuGgbhmJxUnc/nG9FfBruKCkqWIPOzeUTP?=
 =?us-ascii?Q?mGnDY5SzgeFtRD8NnYgXyl/3jtw6P2iyPy2vcV6fSeFyZ3UCJHQ0mXOkrBzq?=
 =?us-ascii?Q?q58FtOeVBtiwjQD83gJkBTHoBGCbSlHbhYI9JFZyYS6wEvPL859B2Y+bQ5SS?=
 =?us-ascii?Q?xLBMxUGvDimALXAi79PW/9M04wCzKiOPh7f2S2u3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6d354e-42ce-497e-f321-08db5898c796
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 18:42:21.1364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKHZVDZnVV+nioc3LX2s9HZhlCrS/jSTftOeeJowc0f8sQGmNGyDA4vGenJItQC/
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

Remove the race where a hotplug of a device into an existing group will
have the device installed in the group->devices, but not yet attached to
the group's current domain.

Move the group attachment logic from iommu_probe_device() and put it under
the same mutex that updates the group->devices list so everything is
atomic under the lock.

We retain the two step setup of the default domain for the
bus_iommu_probe() case solely so that we have a more complete view of the
group when creating the default domain for boot time devices. This is not
generally necessary with the current code structure but seems to be
supporting some odd corner cases like alias RID's and IOMMU_RESV_DIRECT or
driver bugs returning different default_domain types for the same group.

During bus_iommu_probe() the group will have a device list but both
group->default_domain and group->domain will be NULL.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 78 +++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 43 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0d376a3dbd7a42..1bc75774626303 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -131,6 +131,8 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 				      const char *buf, size_t count);
 static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
 						     struct device *dev);
+static void __iommu_group_free_device(struct iommu_group *group,
+				      struct group_device *grp_dev);
 
 #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
 struct iommu_group_attribute iommu_group_attr_##_name =		\
@@ -469,14 +471,39 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 		goto err_put_group;
 	}
 
+	/*
+	 * The gdev must be in the list before calling
+	 * iommu_setup_default_domain()
+	 */
 	list_add_tail(&gdev->list, &group->devices);
-	if (group_list && !group->default_domain && list_empty(&group->entry))
-		list_add_tail(&group->entry, group_list);
+	WARN_ON(group->default_domain && !group->domain);
+	if (group->default_domain)
+		iommu_create_device_direct_mappings(group->default_domain, dev);
+	if (group->domain) {
+		ret = __iommu_device_set_domain(group, dev, group->domain, 0);
+		if (ret)
+			goto err_remove_gdev;
+	} else if (!group->default_domain && !group_list) {
+		ret = iommu_setup_default_domain(group, 0);
+		if (ret)
+			goto err_remove_gdev;
+	} else if (!group->default_domain) {
+		/*
+		 * With a group_list argument we defer the default_domain setup
+		 * to the caller by providing a de-duplicated list of groups
+		 * that need further setup.
+		 */
+		if (list_empty(&group->entry))
+			list_add_tail(&group->entry, group_list);
+	}
 	mutex_unlock(&group->mutex);
 	mutex_unlock(&iommu_probe_device_lock);
 
 	return 0;
 
+err_remove_gdev:
+	list_del(&gdev->list);
+	__iommu_group_free_device(group, gdev);
 err_put_group:
 	iommu_deinit_device(dev);
 	mutex_unlock(&group->mutex);
@@ -490,52 +517,17 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 int iommu_probe_device(struct device *dev)
 {
 	const struct iommu_ops *ops;
-	struct iommu_group *group;
 	int ret;
 
 	ret = __iommu_probe_device(dev, NULL);
 	if (ret)
-		goto err_out;
-
-	group = iommu_group_get(dev);
-	if (!group) {
-		ret = -ENODEV;
-		goto err_release;
-	}
-
-	mutex_lock(&group->mutex);
-
-	if (group->default_domain)
-		iommu_create_device_direct_mappings(group->default_domain, dev);
-
-	if (group->domain) {
-		ret = __iommu_device_set_domain(group, dev, group->domain, 0);
-		if (ret)
-			goto err_unlock;
-	} else if (!group->default_domain) {
-		ret = iommu_setup_default_domain(group, 0);
-		if (ret)
-			goto err_unlock;
-	}
-
-	mutex_unlock(&group->mutex);
-	iommu_group_put(group);
+		return ret;
 
 	ops = dev_iommu_ops(dev);
 	if (ops->probe_finalize)
 		ops->probe_finalize(dev);
 
 	return 0;
-
-err_unlock:
-	mutex_unlock(&group->mutex);
-	iommu_group_put(group);
-err_release:
-	iommu_release_device(dev);
-
-err_out:
-	return ret;
-
 }
 
 static void __iommu_group_free_device(struct iommu_group *group,
@@ -1816,11 +1808,6 @@ int bus_iommu_probe(const struct bus_type *bus)
 	LIST_HEAD(group_list);
 	int ret;
 
-	/*
-	 * This code-path does not allocate the default domain when
-	 * creating the iommu group, so do it after the groups are
-	 * created.
-	 */
 	ret = bus_for_each_dev(bus, NULL, &group_list, probe_iommu_group);
 	if (ret)
 		return ret;
@@ -1833,6 +1820,11 @@ int bus_iommu_probe(const struct bus_type *bus)
 		/* Remove item from the list */
 		list_del_init(&group->entry);
 
+		/*
+		 * We go to the trouble of deferred default domain creation so
+		 * that the cross-group default domain type and the setup of the
+		 * IOMMU_RESV_DIRECT will work correctly in non-hotpug scenarios.
+		 */
 		ret = iommu_setup_default_domain(group, 0);
 		if (ret) {
 			mutex_unlock(&group->mutex);
-- 
2.40.1

