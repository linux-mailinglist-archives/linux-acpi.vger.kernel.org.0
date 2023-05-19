Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AE3709F3D
	for <lists+linux-acpi@lfdr.de>; Fri, 19 May 2023 20:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjESSm2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 May 2023 14:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjESSm0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 May 2023 14:42:26 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2401D1A8
        for <linux-acpi@vger.kernel.org>; Fri, 19 May 2023 11:42:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfNwRc3G6fFk2kIP+wqn2WRELvtAoE0pOD8zVD7iVsUkUk0Aal0Y5zvOq1IflG3/B8XCsDtbmPkKjTav519m2vXEoEuLLA5uAd8YOJ7qFuohBaVRrAr9tqUOang/SkrlbKMBjVqQRksP3EbRv/mu4Fasd7/Ri7m0rKWiiunBw9rHZky3833D7qh+6CQ8Hg0mIQs6wDTf0y3MaTMxp+1h5LcKGXo+eQsqHvMGWpatZKB3n/HoK7MutQC3LpaKy920JX2wQl/v432vaL19fFlHq9D0ll+n8UknsAyJMQ6+v76LvTtOmDBKcigalolX+AqxN+x0EJYhQEG7afQYJGW1hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEFGh2NCg84u6GJbWjbXyhatr3JUaR3D6Q4yUm+j9TE=;
 b=YKnDMVgF1YPDuzhN7Yt5zNSLaaitV/eIioOuLkcxLV2xUZfwIBz0uZN39apRSZ79NZcJoWNuXwwBJjhY1DRerDRlXGG6F0GemiiZhPItmL/jtHdvPjyGU7IZnKc6hfxCF3TELQAJpcZNlfyqy4m2Fd55a/u1tvYOLpguHPUNmcexAfFH/licjlubhvKjXUkLju1NMmM72AEP9I/HYKLN2JN9UU2oJWvVf3DWf5iG1walQJe5Qt7aF+Hy0Wt88DgdL3CV72UVWwtbs3kUX8uN2v7EkgJb9miS2swIfLsBG9gcgnLRMT7QxduAJ3uohdH7G0TvS+rrCUIHezt8dgTOAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEFGh2NCg84u6GJbWjbXyhatr3JUaR3D6Q4yUm+j9TE=;
 b=JTlFNj6AHDbe/kSfVdoblekNjmv/N5rkeWMA/jBg6hTRIhrUuzUucfowHflut7kUAAkeWRntcs+HUzO74d/Wep9W/5ULFOIO0z37l3Kugn2GFdiS5k4xKdUopqYdQvNQjuhyMowapyytlLD/FOr+myEYaCqp7ZuNC++EdnWChpUWKX2AWBXtCja/FZmAVHiLhozgAMVJfN2UUROnAFkdbxQjB8mfQrYfLPCGt37kbXKR8JpuXthey0A6RL/cryJgY7PDIu+3vff/O5kQ0SXYka/JRdI6EGSZDfJHejpdVYUXJ6IAjNu41dAt0eNoPf45Sp7N64bNcTSMUuKKzIaC5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:130::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Fri, 19 May
 2023 18:42:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 18:42:23 +0000
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
Subject: [PATCH v2 04/10] iommu: Simplify the __iommu_group_remove_device() flow
Date:   Fri, 19 May 2023 15:42:13 -0300
Message-Id: <4-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
In-Reply-To: <0-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0277.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: 86af0670-cbf4-44a7-99d8-08db5898c737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F57yI+b33tIT7/lwU5bYqMsAq+d43JRCZHlMajEEh5tD2UqV08v+3FndaUoNi7u79DFtXtAuCiM8q5AkzLh1vkd/C6nTnigenujP7TLaqm1aBfpdPPCQqm0RXkVJ7lD4/CLdF5nEPcveGgwZqTnRVWGix9xDp0TMXzNLOsSciV11JQII0Ri3rbLHU98d3L6+SLRRQ+qEo4jqyb890TqUGvh+cJOwSij/v2Ty9dUW+08p//ScbeykK76uN0FuLCWRlSHta/u5jlmMjUUhXvBeSkzZxXvNMlKNGwYlz1Bf1m8zAWYVMEuJIiUiRTWcOCLoJyJvEHJ3YVZvMDpMiL2l+2IstzWM+FlT8tXDOT0iRTOV2L8urFWjGxyfBHQaZvSxMH3m74cSvrG/UMzeMgiCIhTpFgqm8Bqh8GZAilrXGIkTglOK4EtOqMKaaAxlFhcidYiUCbvAE72zNiMafJh4HeigrV/GxuM4a2Rh4bxmAjGp8iJqOJNSkKEWLoVozyfglIuTMBYrwHUTdDCmdYFvOpqMBpSUlHUaXy+4XeN42QsBwzxNf8uSBejjSKjItffhUpWSVpDUczW+Mh1YeAXihH1sw9co4/IQ19DPuJVkbkY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(6512007)(6506007)(2906002)(186003)(107886003)(26005)(86362001)(83380400001)(2616005)(36756003)(38100700002)(316002)(41300700001)(6666004)(4326008)(6486002)(66556008)(66476007)(66946007)(110136005)(54906003)(7416002)(5660300002)(478600001)(8676002)(8936002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wtmZ3KBFyg2M6VgpirrPlNf4mmhLw+fkIl9yMwGnOv2HqF3EXRH8eH0gKF63?=
 =?us-ascii?Q?ezvmY1T20+D+rSZVaoSyzQycw8X73CagovCmWqKGhRvupB3Qh7SyTkil91hO?=
 =?us-ascii?Q?3SuyOdaZlc7dbxpPFR+HpU3UXhC+6R5bprXbbw9N0yGZMaAeS+IL40db3f4p?=
 =?us-ascii?Q?GsWg4ybEaY3kL0mxHFVOxi1uyUB/A6DScTesqmZBvWdEDkFsRVGGdHrzpxBv?=
 =?us-ascii?Q?p9CE9IV96Zg14xfBc+reVCan7iQ3jCNxgBWFt3Ii5shfCt7GF+wuD1rHDCeo?=
 =?us-ascii?Q?9rUNYt5fxXw9T3tix5fVfkkSP9y+95RtzgJlcHlFVBDktRUcfwRaOg9EoZfB?=
 =?us-ascii?Q?ETn3OlEZc3JScqP1QVrvgtXm64veJvDXmZJQJFh6Kvu0jHQy0Qh0ySf/M8eL?=
 =?us-ascii?Q?uQk+OC0nhffwsVyRdRP7BiCLFy09kLqWhgsLEqgcRri/1J7LBokQC5Tl4r6Q?=
 =?us-ascii?Q?1RyHJhvaOWydxY/kSwTNiR/c5Hp38hQ/z5H1Zu/iaXTH498l7YvLKMPzfHKN?=
 =?us-ascii?Q?ULHzDKYsVQEx6AX2ZNPYcDYEkRA5MmG+XD/ZewBY1AD93bCPSC1z22VIfK+I?=
 =?us-ascii?Q?V+JpXoGqenjey57Ua5zEI477NX7lNjDRo9c27YW/sUbOc0CdHY1qg335eP6N?=
 =?us-ascii?Q?Tlxe8lq1bvKRo/X57QAfxXrMnvsaEAup65xZkzr1KNRK6jEAHhcL2KnztYA0?=
 =?us-ascii?Q?/KIrLF2sSswkFOUiFWRMDu3ZzKsiYAroUNsfPt/VntlMKzwoqQtNHxro9q1O?=
 =?us-ascii?Q?3KCjrsZHzJGA1oI7lQTcPl5eNtxUqyH/eUBMICW+GQxCUqA0Ca5dxT+2bCgR?=
 =?us-ascii?Q?c2CMicU+mqYnpiXLuJ/dNvoxOHGBE01UmiE4JAM4P9+y04mdk0eqxPSiqdb7?=
 =?us-ascii?Q?j2M/hKXG1gVHBPXEMFzdGuTUYqERSD+BVtHCL/NdehMf9VLLAB6gSNXM0I/B?=
 =?us-ascii?Q?u1lArrYwJxrC1z2phM8rZ6wM6hBY9nEictVwsMSJTy9EBO7s3YcPI/ydvAY2?=
 =?us-ascii?Q?UBBtj0+wkdhpcWotjpwZjVn8QMk4VKeAg8hdY4NlEqS2y3sshtNl3gE/6GHM?=
 =?us-ascii?Q?GLPjSs0H/ZKEVALhP38N6m/LgjROYNuB47JdtegxVqksSoJxVhdnm5w3ngsx?=
 =?us-ascii?Q?v6o7p2NejyzouQMWLPf0N2QAaQroW8wX6EXMGrvyTFNfKVrHSetpCIB5HQYH?=
 =?us-ascii?Q?GO867GewDFVIJbUh6Yoyc0YMu82F+rErqmoNtm8sntxCLvjzBVj4RVB0NHw7?=
 =?us-ascii?Q?r+m2DJqDyATFm/nWdVHIBABjpPK0hGqq/vxrlyCRjm9NLUqh2eNvkTwIwktE?=
 =?us-ascii?Q?R61MaUxr8KMt+gsGMoh1Vk2S/LVYkHifkCmFYK4Kn9ferrbAV25M2XykNRlY?=
 =?us-ascii?Q?WsePPuO4iTtmoSAu3fGeCw5VFhVIf/Rn/YPn9sTMQJjYbIRxTgGke7aIjjUw?=
 =?us-ascii?Q?zKbIOOvCh10vbJOhnD0CmZMegOwZFTwdlE4hq85DmTCcXZgkmlzhMUoaCeoW?=
 =?us-ascii?Q?xh4z79KPfIKalowYZDaNryvVL9KvklMjmnAAZz+/OeVPNkGv5hU8A6C5iTtO?=
 =?us-ascii?Q?YQCa9OCgfRX08MDCKfoQqBgl4nMvlGaEvnKyyFpZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86af0670-cbf4-44a7-99d8-08db5898c737
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 18:42:20.5382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /n4Gk87vOg/hDMcOksTCzhNKLVZVUnzMOVnrBZyMM1FTtgNf9yri2YjKEYXRfM/P
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

Instead of returning the struct group_device and then later freeing it, do
the entire free under the group->mutex and defer only putting the
iommu_group.

It is safe to remove the sysfs_links and free memory while holding that
mutex.

Move the sanity assert of the group status into
__iommu_group_free_device().

The next patch will improve upon this and consolidate the group put and
the mutex into __iommu_group_remove_device().

__iommu_group_free_device() is close to being the paired undo of
iommu_group_add_device(), following patches will improve on that.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 83 ++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 44 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6177e01ced67ab..a87e2df5ce1238 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -470,32 +470,8 @@ int iommu_probe_device(struct device *dev)
 
 }
 
-/*
- * Remove a device from a group's device list and return the group device
- * if successful.
- */
-static struct group_device *
-__iommu_group_remove_device(struct iommu_group *group, struct device *dev)
-{
-	struct group_device *device;
-
-	lockdep_assert_held(&group->mutex);
-	for_each_group_device(group, device) {
-		if (device->dev == dev) {
-			list_del(&device->list);
-			return device;
-		}
-	}
-
-	return NULL;
-}
-
-/*
- * Release a device from its group and decrements the iommu group reference
- * count.
- */
-static void __iommu_group_release_device(struct iommu_group *group,
-					 struct group_device *grp_dev)
+static void __iommu_group_free_device(struct iommu_group *group,
+				      struct group_device *grp_dev)
 {
 	struct device *dev = grp_dev->dev;
 
@@ -504,16 +480,45 @@ static void __iommu_group_release_device(struct iommu_group *group,
 
 	trace_remove_device_from_group(group->id, dev);
 
+	/*
+	 * If the group has become empty then ownership must have been
+	 * released, and the current domain must be set back to NULL or
+	 * the default domain.
+	 */
+	if (list_empty(&group->devices))
+		WARN_ON(group->owner_cnt ||
+			group->domain != group->default_domain);
+
 	kfree(grp_dev->name);
 	kfree(grp_dev);
 	dev->iommu_group = NULL;
-	iommu_group_put(group);
+}
+
+/*
+ * Remove the iommu_group from the struct device. The attached group must be put
+ * by the caller after releaseing the group->mutex.
+ */
+static void __iommu_group_remove_device(struct device *dev)
+{
+	struct iommu_group *group = dev->iommu_group;
+	struct group_device *device;
+
+	lockdep_assert_held(&group->mutex);
+	for_each_group_device(group, device) {
+		if (device->dev != dev)
+			continue;
+
+		list_del(&device->list);
+		__iommu_group_free_device(group, device);
+		/* Caller must put iommu_group */
+		return;
+	}
+	WARN(true, "Corrupted iommu_group device_list");
 }
 
 static void iommu_release_device(struct device *dev)
 {
 	struct iommu_group *group = dev->iommu_group;
-	struct group_device *device;
 	const struct iommu_ops *ops;
 
 	if (!dev->iommu || !group)
@@ -522,16 +527,7 @@ static void iommu_release_device(struct device *dev)
 	iommu_device_unlink(dev->iommu->iommu_dev, dev);
 
 	mutex_lock(&group->mutex);
-	device = __iommu_group_remove_device(group, dev);
-
-	/*
-	 * If the group has become empty then ownership must have been released,
-	 * and the current domain must be set back to NULL or the default
-	 * domain.
-	 */
-	if (list_empty(&group->devices))
-		WARN_ON(group->owner_cnt ||
-			group->domain != group->default_domain);
+	__iommu_group_remove_device(dev);
 
 	/*
 	 * release_device() must stop using any attached domain on the device.
@@ -547,8 +543,8 @@ static void iommu_release_device(struct device *dev)
 		ops->release_device(dev);
 	mutex_unlock(&group->mutex);
 
-	if (device)
-		__iommu_group_release_device(group, device);
+	/* Pairs with the get in iommu_group_add_device() */
+	iommu_group_put(group);
 
 	module_put(ops->owner);
 	dev_iommu_free(dev);
@@ -1107,7 +1103,6 @@ EXPORT_SYMBOL_GPL(iommu_group_add_device);
 void iommu_group_remove_device(struct device *dev)
 {
 	struct iommu_group *group = dev->iommu_group;
-	struct group_device *device;
 
 	if (!group)
 		return;
@@ -1115,11 +1110,11 @@ void iommu_group_remove_device(struct device *dev)
 	dev_info(dev, "Removing from iommu group %d\n", group->id);
 
 	mutex_lock(&group->mutex);
-	device = __iommu_group_remove_device(group, dev);
+	__iommu_group_remove_device(dev);
 	mutex_unlock(&group->mutex);
 
-	if (device)
-		__iommu_group_release_device(group, device);
+	/* Pairs with the get in iommu_group_add_device() */
+	iommu_group_put(group);
 }
 EXPORT_SYMBOL_GPL(iommu_group_remove_device);
 
-- 
2.40.1

