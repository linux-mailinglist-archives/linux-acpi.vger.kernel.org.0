Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E400709F3F
	for <lists+linux-acpi@lfdr.de>; Fri, 19 May 2023 20:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjESSmh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 May 2023 14:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjESSm1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 May 2023 14:42:27 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B11E42
        for <linux-acpi@vger.kernel.org>; Fri, 19 May 2023 11:42:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFDGpQhziTcVYF46RXd3Kskk9jHW3YiLz7y7g3c49sWyXXz7Mnj2f/kIpP79qKCkC4tKxTgBY9cRlzI7GZhUQBn/IPFw54NvXUl1ov5xmCDA9Itx4KgJ13J8GGivWWLkXD7qRhwYOJy3PFWyvsAG7e2R1Pg7H/TX3AP0+T4OUHt9jemDtr/HNi/lXnsh3LoXj/g9//40zvFj+1hWMa/vQM+cD8fAItcUkJdQtN5QW9kTQyCBmwB1zO7MkyS/A88jSiL1w7dxP0oeiJr3wdPdO8EweLUTzsZiE28xqED5mWS++sFBVMZLyLTb5o86vLbB8WSGlbv5L+Ty16YRNvpzLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLLlAMqHhR7iIWaLBnWfT09kAEVZXH20lfKKe1NUVHU=;
 b=STnwuimcXn7DXXpsDg42CN1vrdy0LD97AFTjOvoXu5X16Uy8FaSE/8tnotrOgrXOjzLYhm7nxrVMezrE0z4i4ip26aiF81Sp1ZZ1i4QtziXn8GwUKtyubYLJ0VbnbJxWfarsIVQ5BMG9TNh7d6bkkTRar/Na1B+ESqESkbD7Rq6dycm98r03j6cicDjVrBUZVpiOA4UYJqhpe2VxUMW5MLBTp06uAlxRArDqugvo4UDcnL88p0YbLJgebwBuqh2hqp4pebWXpuw7pqv0p7j+pNr+WAk1R82WH/aP0JazJ2i7cODCfNm+jSUQOQA1WMzSQhztf1wWu3PYLbeIUpGwRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLLlAMqHhR7iIWaLBnWfT09kAEVZXH20lfKKe1NUVHU=;
 b=TjR/WdHdVNk7QdVRGSyuU3Lu5uJ2TpxDSaXGWcEKfR6XsGbaakF955wpxy8ZzZg/uLEeMchtM0Vuy6GjX6mNiS68gJAhF8ab3AvahddlKPvCjrE2sMc3ApE3l6bO+WY62vVXZedaCf/va9CXFbsmJSm39D8Bsztc0n3YziO/9CgghPs0pdHDibjAVhyN6T1UQn+a+CErOgX26vmWG6NkbSXrGM+3F4bXfd10SJuDiwIpKctHTZX1B78WLubBkUoirFshY0566rsFB9rYBiIkTUiIQXWBPhShhMeFOG9+HSeGK/Le1YWEI5H8tcRK81v2KYZT+U2CithBosvY6wROGA==
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
Subject: [PATCH v2 09/10] iommu: Split iommu_group_add_device()
Date:   Fri, 19 May 2023 15:42:18 -0300
Message-Id: <9-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
In-Reply-To: <0-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0340.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5fb4d4-584b-427f-e74b-08db5898c745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pOcLTqLZRBfF1CwpQNuKJQYNtS19dmzq5NmJdOQpNBF61vXT0Cjw0SkzwpiRKUvYtZdN0s47IoquZcLBi3GIlczcsMNMnMIYUe3Qy3cL/29OdSDp/aXvCVRy18i8IyDRc4xa7qfUO758UBTPXgkeSMs2A/QPKUbwZ9/d8v0zZjMMfuTxnbH7qAiFxfim6TtpCEd1xkEGrwFXID4W6tjAYcZqO15PRHVgV5WeaQoy1pcPZAII6KKbCGQZZEKZO6IVp1TvjSgMLiZb0zOYAO+rSZ9/jyw9X6uNVnFrFE2KIB36WdQ0QutnOnds4l+hAaSN7yFq8mFYH6QJU96Xt1qbo8AQ1f3qwmz/UpM0O63NvkY5nLyrw4u4xb6GVksaqcWg0T12EdczcTbQosVPsRN3DvSvMzu6e0TynZoWNBmCk2e3dhTv09TeFI+H9ogII2L3AiwcMp3ngh2YYeYDRMmtxAfJzCaKbo5Oujr6dvlTJHMvit+bU2HYAa9uUEux1usWYXAKxoKSd1NKbwkU8ddZ+43ojGqOscKc0r8R5nQ1soHEHE+/GYLruNixjpafQ1ys9OgmLy1c6NtoKgtymfFBEfm2cnq4eGa6Ks7oANbe4yA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(6512007)(6506007)(2906002)(186003)(107886003)(26005)(86362001)(83380400001)(2616005)(36756003)(38100700002)(316002)(41300700001)(6666004)(4326008)(6486002)(66556008)(66476007)(66946007)(110136005)(54906003)(7416002)(5660300002)(478600001)(8676002)(8936002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c0IAfaEJbIIuwjXlKcmsWnX3HWZw+R5vlqvBAiXenl7ePTcnVPqedI3zSAGX?=
 =?us-ascii?Q?/mx4roi3nQnTqDXifCrxfIEm/oPqlZsvWMrv0vrOWHlPpGj6a6J570TvNZCg?=
 =?us-ascii?Q?tVpEBVeNtPWQqM7ZoZ2o1XVlwh1McVPg7hYK3NTLxqEYh6fblXPBaAu/hrga?=
 =?us-ascii?Q?hvVttax962Xg0UVyvvD9T16ti2WizkSnelVkkh6MnWReVahaSbZksoEWhS2H?=
 =?us-ascii?Q?YyEw8gnHhEwZy1s1VrpOrhytiGbqto9/OiDJvb5kO9znY5oero6b1O6Dmdp8?=
 =?us-ascii?Q?OnKHZrKdug2ku4bxmyAtktFU+ijfCUrgoQ6HrwwAkUMq6lf+6oJk6WAKiik8?=
 =?us-ascii?Q?sK7zo27KDO089MVqyFSUUYLG2FEIcKQP3JyVUToake09pDmT0Bpi3jqTKBo1?=
 =?us-ascii?Q?NqOZxVrur09IFMnMjYNfx7JB2oXt5SZh3ho33dx+X7ubSHa4waLwSWG+MsUd?=
 =?us-ascii?Q?ZDWbOafnxbP6dgW2PZNn7OghijiBROz54NX8AmkamEcHvsh0QaNpCkGivS7y?=
 =?us-ascii?Q?ohNmLJ65cLpZIcHnlgZW3mj9ECklCo0LKcC/h/3ZN/oSlROsTCj0NCCeFt6T?=
 =?us-ascii?Q?dh4SRL590MHBKrUljZ8ALEESY6hWgTyItXcgXfd768VqZJWlY41fT6EAzyme?=
 =?us-ascii?Q?1ZQzwmUv6TY5BGaSYZ6ZgsLlyKrX7o7pCJvtVFe15HTcUW7MIuapk/lWqITN?=
 =?us-ascii?Q?fw6aHaNa6AhN/YB0MljntfaVff/SKNIL5AQn+J1xk2j7rz7Fz8HAM7GhUW0w?=
 =?us-ascii?Q?iTIROkA8mM25QmM8xlIwXhIVwpFQEkJqg6O5WUOiNHBditFY7fbSNxzNQ5Bu?=
 =?us-ascii?Q?wS+4TTZs3vtl/HXCKPho7N+Y5r9d94cRqfBqH2ZHmGf6ptedHDsDTCGTRbH5?=
 =?us-ascii?Q?slx+qWI3hwQpJb1rjVpsamHMl27AJKrBRL1zVR+ONtT/CXCCvp65eTBPZ14N?=
 =?us-ascii?Q?DQTEFvovPJyMAGFa/+e2Q0lRsHHgUQB+kjsh64xJK3RittZYLaB1synY/Kzl?=
 =?us-ascii?Q?KOByOQB3m92TlSMsqhFmnZGO4Jq+OZb81FvCUXbtN5D/wRkAfxq8X0BdnVln?=
 =?us-ascii?Q?Z5iYMucNZsNJ1yvktMt3rwAD5fHqJ87jKLx40bxfMPqsLpL7n8fmJqDMiJLK?=
 =?us-ascii?Q?PC32wLYvzK0jd3fB0Lbauyrax3P46TTGZ5cQz7qm8ff9eNItRORDMklAJzWu?=
 =?us-ascii?Q?KnVHjvDCEojS/fxE3brRBlxVDtk6xhNajxoSx27GdYTTNZYibgeWKasdCxmT?=
 =?us-ascii?Q?ZL+6MzG3WBYqKrZSCA8pcrS9rCF0K3F5S+50GbUnj6uFmUz6N1EaxFlIn0Ve?=
 =?us-ascii?Q?/tCvri4r7jINXKo+kpgH6tWot5IoTuKEpD8p61gctS4HF55HRc6U9VJvcwgw?=
 =?us-ascii?Q?y6NhZH93/UsMjD4zg07rkDq3w+C+s/kjPrsaDStYRrS2F3NKRt/SjIhDbOc8?=
 =?us-ascii?Q?nbisuXxUb/4ywJRSuyZtcw4LDwE1cx9+prtpORwbXzcZaKNSgxMpec3CX448?=
 =?us-ascii?Q?r2b6O8QHwcq+BX7WbVlq6J9iY4Yg9NuCr8fGkC9KhKqzg6WjrhfE6nQEhd0a?=
 =?us-ascii?Q?Cr37Pw7pTaxkIRluPljwSx+DGrc+aMcgzxmBZ5KJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5fb4d4-584b-427f-e74b-08db5898c745
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 18:42:20.5760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbxXCQNDL2STiSavQ1pCPaEbP5BlPldJWEDTE0oTTa+66/lNW9UB/S7dbc6pU+wT
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

Move the list_add_tail() for the group_device into the critical region
that immediately follows in __iommu_probe_device(). This avoids one case
of unlocking and immediately re-locking the group->mutex.

Consistently make the caller responsible for setting dev->iommu_group,
prior patches moved this into iommu_init_device(), make the no-driver path
do this in iommu_group_add_device().

This completes making __iommu_group_free_device() and
iommu_group_alloc_device() into pair'd functions.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 66 ++++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6a8cbfd2274770..0d376a3dbd7a42 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -129,6 +129,8 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
 					       struct device *dev);
 static ssize_t iommu_group_store_type(struct iommu_group *group,
 				      const char *buf, size_t count);
+static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
+						     struct device *dev);
 
 #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
 struct iommu_group_attribute iommu_group_attr_##_name =		\
@@ -435,6 +437,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
 	struct iommu_group *group;
 	static DEFINE_MUTEX(iommu_probe_device_lock);
+	struct group_device *gdev;
 	int ret;
 
 	if (!ops)
@@ -459,16 +462,17 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 		goto out_unlock;
 
 	group = dev->iommu_group;
-	ret = iommu_group_add_device(group, dev);
+	gdev = iommu_group_alloc_device(group, dev);
 	mutex_lock(&group->mutex);
-	if (ret)
+	if (IS_ERR(gdev)) {
+		ret = PTR_ERR(gdev);
 		goto err_put_group;
+	}
 
+	list_add_tail(&gdev->list, &group->devices);
 	if (group_list && !group->default_domain && list_empty(&group->entry))
 		list_add_tail(&group->entry, group_list);
 	mutex_unlock(&group->mutex);
-	iommu_group_put(group);
-
 	mutex_unlock(&iommu_probe_device_lock);
 
 	return 0;
@@ -579,7 +583,10 @@ static void __iommu_group_remove_device(struct device *dev)
 	}
 	mutex_unlock(&group->mutex);
 
-	/* Pairs with the get in iommu_group_add_device() */
+	/*
+	 * Pairs with the get in iommu_init_device() or
+	 * iommu_group_add_device()
+	 */
 	iommu_group_put(group);
 }
 
@@ -1068,22 +1075,16 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
 	return ret;
 }
 
-/**
- * iommu_group_add_device - add a device to an iommu group
- * @group: the group into which to add the device (reference should be held)
- * @dev: the device
- *
- * This function is called by an iommu driver to add a device into a
- * group.  Adding a device increments the group reference count.
- */
-int iommu_group_add_device(struct iommu_group *group, struct device *dev)
+/* This is undone by __iommu_group_free_device() */
+static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
+						     struct device *dev)
 {
 	int ret, i = 0;
 	struct group_device *device;
 
 	device = kzalloc(sizeof(*device), GFP_KERNEL);
 	if (!device)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	device->dev = dev;
 
@@ -1114,17 +1115,11 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 		goto err_free_name;
 	}
 
-	iommu_group_ref_get(group);
-	dev->iommu_group = group;
-
-	mutex_lock(&group->mutex);
-	list_add_tail(&device->list, &group->devices);
-	mutex_unlock(&group->mutex);
 	trace_add_device_to_group(group->id, dev);
 
 	dev_info(dev, "Adding to iommu group %d\n", group->id);
 
-	return 0;
+	return device;
 
 err_free_name:
 	kfree(device->name);
@@ -1133,7 +1128,32 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 err_free_device:
 	kfree(device);
 	dev_err(dev, "Failed to add to iommu group %d: %d\n", group->id, ret);
-	return ret;
+	return ERR_PTR(ret);
+}
+
+/**
+ * iommu_group_add_device - add a device to an iommu group
+ * @group: the group into which to add the device (reference should be held)
+ * @dev: the device
+ *
+ * This function is called by an iommu driver to add a device into a
+ * group.  Adding a device increments the group reference count.
+ */
+int iommu_group_add_device(struct iommu_group *group, struct device *dev)
+{
+	struct group_device *gdev;
+
+	gdev = iommu_group_alloc_device(group, dev);
+	if (IS_ERR(gdev))
+		return PTR_ERR(gdev);
+
+	iommu_group_ref_get(group);
+	dev->iommu_group = group;
+
+	mutex_lock(&group->mutex);
+	list_add_tail(&gdev->list, &group->devices);
+	mutex_unlock(&group->mutex);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_group_add_device);
 
-- 
2.40.1

