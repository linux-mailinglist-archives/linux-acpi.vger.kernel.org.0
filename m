Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9343723442
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jun 2023 03:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjFFBA0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Jun 2023 21:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjFFBAD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jun 2023 21:00:03 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5DF10A
        for <linux-acpi@vger.kernel.org>; Mon,  5 Jun 2023 18:00:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7cznAkqGj09NE08ZrDyfl8/iNgWYhzjTzlPLH7Sr+siQzj+r+2aqAn5HUfqBZ1QnI81pDghGtLruIRchu5DdevLmN0/Ggk/rLAEm+qe7CFp7lZMiCQ+VsUwj/PBhg1ylRJ0aH0N+MyYgmLJcWUaU+KSpQRx5l0MCNa6cTNFb+0R/+IwZlqIXNQMGvZHQgHYmJfF0eHaL+5bJhszeBtOYOHJ2QjP//Qy0s99zcAJ0EYu5GFQ8XeOnWiTiZJu8kJGZxPsVmG5FE0gub4TYMTwdmAUN6LKD+ucpEioxM16ScgY/arjWIPoglCPdg5rehInXzHCnVr8XoX3HsQelQ0cNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfwabyxfmnwXdSrTfsfPnrJGW806V4BjcvUqcAm7T0Q=;
 b=dO+7w7uJeJK8w7rvlieA/eS6cfa7Mmoo9m55r+Pi1uaW3ElTDpBU4/8UCcNTWoIEZlelWwQWQ96SnLhGcIKrMKcnDl9qzsh7SLcmiuaxGZCqd9pKCp7FKgcUV6EkmCSf85LD2aPK4nQ948kFXUE5LoPuikZQVSHCifrS2TMDxCkP8WUtUBC4WQRRG86NwKRSXBQMwYmZxG82n8NA1Fe7of7SwYvq2VgU8oqXuVtVDfYvHh1es4dRE2rdHNX6UrrFmOZvk3ihCxua7tKNTuY0dBfqI1dJlDirLxYoKaKeLOkXP4wX+jUf8P0K9QMBBHfjEIqzxCUUsadACqXPeZ3iig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfwabyxfmnwXdSrTfsfPnrJGW806V4BjcvUqcAm7T0Q=;
 b=KKwPx0n1SJ2KMJ1JiFU9OwC6NyNXWFCZRBhfnB4xwZuYQe1DwTG6CXa0pVO2cz2Av3l4jo2+sYPLz+eJOuqb1bqDavxJRbj2qf0A4J3ha6KiLtMD/ODnz//B6d4nvGysNBG6246Jbc/B6GdC4xB1+Xl93AMK/9ZlfWDKm6h/mq00mwVDGHHd8/eoO7+HeirlqDczA6vgfJcR1m/7kWXqRlHqUJiiM1q9r/t2p0EPDSwgJQc0qnazaFlBzE4w8HPXA+c/aD4QR3mV+dknqgx9IoqEmV3AMK3J4zYRZ0UQO8EXy0pY9Kk48xFWPwW9lkCfgExQGPtNdzATeKDeXf6u0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:102::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 00:59:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.028; Tue, 6 Jun 2023
 00:59:50 +0000
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
Subject: [PATCH v3 01/10] iommu: Have __iommu_probe_device() check for already probed devices
Date:   Mon,  5 Jun 2023 21:59:39 -0300
Message-Id: <1-v3-328044aa278c+45e49-iommu_probe_jgg@nvidia.com>
In-Reply-To: <0-v3-328044aa278c+45e49-iommu_probe_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a03:505::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: cabbfab3-88c9-4607-f2ce-08db662954e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0nzMcQLN6TL8BfR2XZMnzDWxEtgsKfYTM5Aser1gycSqqURM88ou3vl/oqcUcrmTSUp31i4rbHt0njgBdmqpxJ0kHrkRXFmBxxdOSRwEs8myvmycePrpROxPDCGRUEBdM6wstWjraIfQz/6D5oNBzfTOcV0+iyMqzSfpm+WDlbArTKlLf/zamWrwBnQJfNsCrA2wlXHjfz7LkRJHs3uHkCvYDrcWtLSmJpH/jbWGuNKCyAQNhtgAUPY2H30+Ndse7hRi73FMm0Mq2YgCAH02M36HQDdrTamoqrBDhrmxAMAvJGXclcMISH61fdjuSnFdTB8vHRTaEU+iu1xKkBhkuc1Cnkh23hyvh8DqtVucDXOfzMGHKRvKHrx002hc9OOY4zggts34AhR6CPuO4+gHTPcp9otx/PmiHBmKNOvD2TcP0MgJfmPizbky58CjmsRovfSATkgIWSSNEG0U1ytxhl7sVWisRrtiniV97Sn0LTabBPS6L2MerGPEnmNlSLOn9Y8me9FATGIm9X5HDyu00sr+FqXdesyCnOk40Ra+ORMqt4Fq93igKmf6ARRYE44frwJrhiPUG8k6509PBG9KYqGeuOxM5HfUOm962x9BMbE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199021)(54906003)(66946007)(110136005)(478600001)(8936002)(8676002)(38100700002)(66476007)(316002)(41300700001)(66556008)(4326008)(2616005)(186003)(6486002)(6666004)(83380400001)(26005)(6512007)(6506007)(7416002)(86362001)(5660300002)(2906002)(36756003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xsq2FV4NutbGQkqzGLGxUzkk1ggKUVx/M44ECRUHitojpwmAEfatr6yo/VjQ?=
 =?us-ascii?Q?0RsIcV28BzkoiX+kYU4kH/z+qxcuW/e602wDX23N+xryPF3Dl4phC4yJeyX5?=
 =?us-ascii?Q?9XWcsyA5rgl4tIutW8kfEIhjdyynRIhMdEQqYLCQV6+unkBTjrWAbOgwSRsZ?=
 =?us-ascii?Q?l28HP/gCJxaRCRDS0OgOpArTafBXhQ3ykFt/1WutaJ/Bf+0S6xX08ffL4UmX?=
 =?us-ascii?Q?vWVcakSYpTEUXI8Tz1wqYCnBruE1HPva83gOpNQ+V+vCTYnyrMWr1a3nqH3T?=
 =?us-ascii?Q?kFYcyOrU/Bhn9kmcTFT6Bv4RdfbTi5GHQaPEJxyNcvn5u0ULmV2uL4zRQsyK?=
 =?us-ascii?Q?cjkokqhtCl5jAFud1wrm9/OwKEyKwz2P3e/VEUgyW6ETnRNOffprswnFC1P/?=
 =?us-ascii?Q?XpsFXotS6rOY7kUmvy2dtNwXVeSqp0GHvX5aEzx+Y2rOL/p1H4lhPiqCE9rN?=
 =?us-ascii?Q?uRp5VMkapNZhuESu8VL8PFSNjgI5P5OMG3S1Fq6tUGMBl19XHLGW4sehqHL6?=
 =?us-ascii?Q?JvWmWfDBz39czws/2GufnsjrX9Sj4DxxMaPjscw27xHz4FXy+Q3oIGy1pC9H?=
 =?us-ascii?Q?tJNqFGnb1gz6z1gkBnzPQYsYw7DL/bXY/ov71cmsTX9wCNGtWehHel/lJYQc?=
 =?us-ascii?Q?Gj8BvbSd8O4s0F95k4oi0bOvuTfo1iwcBh3z5M2sdE65gMPR9IWvasP2l/lb?=
 =?us-ascii?Q?ulWB4OwD49KCV61ZvXSU54WJyouch8VSyhIc8My2dBSL9n0RE3E29Xqj+jPE?=
 =?us-ascii?Q?ItwaSbS5Mi2GpoAGKxQJx3pBv4DHCGFqHpGgJz9xgPq8mDps/tFJMmhNA7Ys?=
 =?us-ascii?Q?2cQMGZGUAwlvn5Ycr1sB2++AoaIUR00WgxncR+DXSehHFRHDKXPcCKhTCszQ?=
 =?us-ascii?Q?lOktmVfjShqgx/415n1UPhkxOley0h5/x/lSLkOF6lBGIsJafR95CEoy5DJ9?=
 =?us-ascii?Q?k1DCBvld51TxAL13M1QtIO4atYMEXm/d8XVnYq993O8TZ/FUCcARjpFf/O89?=
 =?us-ascii?Q?D0xUKDIGJeq9QOPn/hRdYe3fF80NxUzBgfiU577vYnVyC4VF/rBrNXiIgQ3j?=
 =?us-ascii?Q?P2bnDKwetcygVQ+pfTBLFiFjuWXp3VZLzM8jrQRaLEk/vmADNbdL7mEgbGXL?=
 =?us-ascii?Q?Y4FnVkA/oFxOFILONLgP/6kbm/wri9Jt9eTO1axvy6Q8a4mzoG+lWBSP0n+d?=
 =?us-ascii?Q?uv5fKEuUaN8gd/Kj3R1PYtW4S6gcgQi3/j8UpU7Ix3/lGRxR0Oyy3SW77yGW?=
 =?us-ascii?Q?pIUGqKB7HFboRr06w+U5aAtZg8GYIFaPbkYMWgCM9sw1Uu4/Tdb3ll7xTt1s?=
 =?us-ascii?Q?v/g5zzRKpjlOBIQSDMqJp4PrGVGV4fDBaLn4BAalw23bkbn0864fZIEEo7F4?=
 =?us-ascii?Q?oJI2pcyUl7jDUK0r7pIfPWzIkNSnmrYPEnh+NbH9YevgUxVE4dkIER5gv8pL?=
 =?us-ascii?Q?+hk0gPjNgPG3U5TubWEsRLh938dUVTWN1rbLGVneRh04hkmc2ddnNO4wWfvP?=
 =?us-ascii?Q?Ant7+ctoxWxR4LW72tViexrBwrR1um/mEWVeJdEjiB13vR1QalEDhDJUS1+u?=
 =?us-ascii?Q?gyTpiJiqPfXklg0uzl0Dn5fZVmSaZZSGC7WuBmzN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cabbfab3-88c9-4607-f2ce-08db662954e5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 00:59:50.8397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZKgUmU85DMlOmHwSpCOGZabbktxTDBAU0bxK7rHf/dJ72lwwsAJDIqnXOKKztBea
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

This is a step toward making __iommu_probe_device() self contained.

It should, under proper locking, check if the device is already associated
with an iommu driver and resolve parallel probes. All but one of the
callers open code this test using two different means, but they all
rely on dev->iommu_group.

Currently the bus_iommu_probe()/probe_iommu_group() and
probe_acpi_namespace_devices() rejects already probed devices with an
unlocked read of dev->iommu_group. The OF and ACPI "replay" functions use
device_iommu_mapped() which is the same read without the pointless
refcount.

Move this test into __iommu_probe_device() and put it under the
iommu_probe_device_lock. The store to dev->iommu_group is in
iommu_group_add_device() which is also called under this lock for iommu
driver devices, making it properly locked.

The only path that didn't have this check is the hotplug path triggered by
BUS_NOTIFY_ADD_DEVICE. The only way to get dev->iommu_group assigned
outside the probe path is via iommu_group_add_device(). Today the only
caller is VFIO no-iommu which never associates with an iommu driver. Thus
adding this additional check is safe.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/acpi/scan.c         |  2 +-
 drivers/iommu/intel/iommu.c |  7 -------
 drivers/iommu/iommu.c       | 19 +++++++++----------
 drivers/iommu/of_iommu.c    |  2 +-
 4 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 0c6f06abe3f47f..945866f3bd8ebd 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1579,7 +1579,7 @@ static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
 	 * If we have reason to believe the IOMMU driver missed the initial
 	 * iommu_probe_device() call for dev, replay it to get things in order.
 	 */
-	if (!err && dev->bus && !device_iommu_mapped(dev))
+	if (!err && dev->bus)
 		err = iommu_probe_device(dev);
 
 	/* Ignore all other errors apart from EPROBE_DEFER */
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 8096273b034c3a..61cfae38c8ba96 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3763,7 +3763,6 @@ static int __init probe_acpi_namespace_devices(void)
 		for_each_active_dev_scope(drhd->devices,
 					  drhd->devices_cnt, i, dev) {
 			struct acpi_device_physical_node *pn;
-			struct iommu_group *group;
 			struct acpi_device *adev;
 
 			if (dev->bus != &acpi_bus_type)
@@ -3773,12 +3772,6 @@ static int __init probe_acpi_namespace_devices(void)
 			mutex_lock(&adev->physical_node_lock);
 			list_for_each_entry(pn,
 					    &adev->physical_node_list, node) {
-				group = iommu_group_get(pn->dev);
-				if (group) {
-					iommu_group_put(group);
-					continue;
-				}
-
 				ret = iommu_probe_device(pn->dev);
 				if (ret)
 					break;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9e0228ef612b85..8e77e12a180116 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -351,9 +351,16 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	 * but for now enforcing a simple global ordering is fine.
 	 */
 	mutex_lock(&iommu_probe_device_lock);
+
+	/* Device is probed already if in a group */
+	if (dev->iommu_group) {
+		ret = 0;
+		goto out_unlock;
+	}
+
 	if (!dev_iommu_get(dev)) {
 		ret = -ENOMEM;
-		goto err_unlock;
+		goto out_unlock;
 	}
 
 	if (!try_module_get(ops->owner)) {
@@ -399,7 +406,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 err_free:
 	dev_iommu_free(dev);
 
-err_unlock:
+out_unlock:
 	mutex_unlock(&iommu_probe_device_lock);
 
 	return ret;
@@ -1711,16 +1718,8 @@ struct iommu_domain *iommu_group_default_domain(struct iommu_group *group)
 static int probe_iommu_group(struct device *dev, void *data)
 {
 	struct list_head *group_list = data;
-	struct iommu_group *group;
 	int ret;
 
-	/* Device is probed already if in a group */
-	group = iommu_group_get(dev);
-	if (group) {
-		iommu_group_put(group);
-		return 0;
-	}
-
 	ret = __iommu_probe_device(dev, group_list);
 	if (ret == -ENODEV)
 		ret = 0;
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 40f57d293a79d4..157b286e36bf3a 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -159,7 +159,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 	 * If we have reason to believe the IOMMU driver missed the initial
 	 * probe for dev, replay it to get things in order.
 	 */
-	if (!err && dev->bus && !device_iommu_mapped(dev))
+	if (!err && dev->bus)
 		err = iommu_probe_device(dev);
 
 	/* Ignore all other errors apart from EPROBE_DEFER */
-- 
2.40.1

