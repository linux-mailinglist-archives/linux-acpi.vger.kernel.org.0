Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16EC723440
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jun 2023 03:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbjFFBAY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Jun 2023 21:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbjFFBAD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jun 2023 21:00:03 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3490310D
        for <linux-acpi@vger.kernel.org>; Mon,  5 Jun 2023 18:00:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHSLxbSWmirPQ0yHN45JcRwIXzVMm7u5Qna4bFm/qhvFWuYY8WL5tXRizW4odw9Tr37azARB/H49cYCAXIQVZs48QbKnkZcgb0c5shSlSIJ/lc2PD6kmzxMZ5vfPrKzdVxM0YLYxVeft5Ozb1lZ6+CPV1OKUH+bxW4jnxAIalCOyGzOFnAh1z0PjKnc6qv4uxQ/j4fxBkPiseByzc57uEZy0tgOqCVmIY+ErStvhCAkD0a+bo2i8iMXsGnaxc+Tf+6aojUn/j5cEkSNpJH7XaIdvLM5gd5ct/AyhcS0DMiDflGeEdigCXB4qG1HHsH3GloLobySvLLXPXsQozxE8KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QV0fBNdP8q2LSAZbZz7kY45ymHKMpmGt0ba2hCmRtME=;
 b=W2VzX7AIUIJ/8WZy0otp+uIb2af+B/Aw1r6thdUHznu4YIpwpe3EcRhiam8kzIUBfQJmQt37oAPOjw9I2HNM/f42XbDvp5AOI4BLYT1vmrgVLPFDdyLZWi0R1ESCJlNrxMJZhQfk2umPu/Xt+xY83jOFvOKCIzs8kXqQ7W5+vKnwwmfHxhmrKMjecHwNwVVEiFfo04qUyCRczZejoA0MAfwGGyYNO2MpmCocvUvdHGtKh9tcsjNYdp1Juj8ZZi87VlFJci8mggR6zIuKVGj3VbhAq/QZxuzxf2ucoga2JIm+X+TIG9P54bLIz6zmH5AsUGuemFmGP/qQb5DjPkkcBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QV0fBNdP8q2LSAZbZz7kY45ymHKMpmGt0ba2hCmRtME=;
 b=FbHi/fV3bHIppvEaf0CG9CKlqq4RyBBZ21VLtReur7oqNV+s9uME9sWypiemjb1siXmpTfZK/BeNYlWncxaDnM1vHLPeh7IOfZJ6iuZubTxVcocLOiI+KfTbCz9H4j8bvpVAN4mr+pTMYXMvlU59Nsey0FOJao8UUTMHa7NV+xdTpqXho4SVVdgX2U6kLXh6J3rwFabuz81uVqg7y4z/GeUrObEfYTuqtuyDq1IXIPGFAPrcVWnatZj17RGYgZluFqEqfweM7v2Dd9+JAQMc+Be0KZ4VYJmKTuXi5qjidfB/2/kL3NevuNEq/IxHCbLGOIdpzCkEqtocVq6/wCBdTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 00:59:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.028; Tue, 6 Jun 2023
 00:59:57 +0000
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
Subject: [PATCH v3 09/10] iommu: Split iommu_group_add_device()
Date:   Mon,  5 Jun 2023 21:59:47 -0300
Message-Id: <9-v3-328044aa278c+45e49-iommu_probe_jgg@nvidia.com>
In-Reply-To: <0-v3-328044aa278c+45e49-iommu_probe_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0050.namprd11.prod.outlook.com
 (2603:10b6:a03:80::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: e2b420a8-1add-45f3-cf98-08db66295726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YNyXvDHyLSyIwtYbqJ2iggFj0YOO2OonV0mUFottWAUJ3xMugNQvOqwc/L7GrEqSWAUnSdnYWODsC75ht0ajYH/DZYtBMLuDLVmEA6WBCIXVZ9msCsyFPCiMXqz+oIGXUSlXIN9qsWevbzd5rWbyzkTRV4ZcUZ0OSLZNvR8G6+vDvk9RF3DUdImqe8VqjsMGBUuyGo0Bt11d2806UGVi9vl6wiiuEe5SOmd3TPwBhOpa0zKHBOKUuV0Ee1u9nG+ci7s1Ycyq1BhHNeXGhqjVmNAJ8ZfhDTxgQEHCmQn6UHTdVRQ4cGwLT4A6oKP4I3yGiha2Lq5WWgLZL48CmrArHPeH/pWE04PrUHDghcQMWUyTMXGgDMIeMfoLWhaxUMt4idb6tGGcLdcWSTL7ZlmeNHFOFcwKLR1t28hzeD2UJ0uFOUkjMxZ40+u6G65X0FnTq5bGWGWxfbSD+FTKm7XNOXXLYbclpu0VstID/b2xithNZD3qBI9M3cXMLNLcBg+A90GlSUX0sX+Ovwu4AoudajS5E5NT1diY3ZcHayh2o93yyPw2jizbVDacdg2jG59uejt3hJNnfsfapcW/5ABilsc8Ib/cMD//4EHzPjF/VZ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199021)(36756003)(110136005)(54906003)(2906002)(478600001)(86362001)(38100700002)(7416002)(41300700001)(8936002)(8676002)(5660300002)(316002)(4326008)(66556008)(66946007)(66476007)(83380400001)(6506007)(2616005)(6512007)(26005)(186003)(6486002)(6666004)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/IsU54zcRCHQQRtlR/mT2RICXuYvZmTBkcp6P6HzjgFp2fhBZsBxkMAcaQ+k?=
 =?us-ascii?Q?n2FaZukftnoNbfcO3ljnbAcENEqdyVHkjdsP2lqIJmk0aRmP4O3vvOZMLXIH?=
 =?us-ascii?Q?uJ9AnZbezPg7VcSO0keO0oCy/DDPLnzPqHaHOlg9HQKE5SICxsw9YrxADlss?=
 =?us-ascii?Q?r3uwkiOdYfq060IKZ23BPRFKFXuAgAh39QVmUxx65HJtn33dmPCn6MSg+S29?=
 =?us-ascii?Q?QISfI29TS4Z+rv/DmzSgi9hfgmEJBcY3eOFmDL/19n6q9GuLnf9yHJnnCay+?=
 =?us-ascii?Q?fIhPhw4PTNC+xMPgRWQxZwCPnWuU2LNNYwjhq8ybj2Rhbt2HmJKGFhm92eCP?=
 =?us-ascii?Q?DOEBAjmv+gMtKAUyOeLtlvFJ4blhHwxfOlIdLKUPKUbUF5+/XVkX/8hbiDG1?=
 =?us-ascii?Q?xUngmYDbUgjwD2hiMEM2N+iTiGrPqNbI5xFd5n0KfAkzKT8O94EfPusKMaN4?=
 =?us-ascii?Q?0MyRBRYP3A3W0XWoS/8CTM5oQCupnQ6+6UmN3WhfZuqCWrE4/KkE/PVd+oPg?=
 =?us-ascii?Q?69/c5QCWrlE454LzZNT/Dg/FH3Q7MrVgcAsQH+8+SrL+9p6lwm3I7s/a064L?=
 =?us-ascii?Q?SA64dPWJ0SrmfwUTgu7U1+Zp4hGqqv36vclc9xDKMVKjJEBoh96f7TcdEDWZ?=
 =?us-ascii?Q?wEn9jueEezZGxH/pY1T+Q+dcxtDkjq1m+MYSOQSsp5PBspn1h8W+0ig0d6kl?=
 =?us-ascii?Q?LwX2mqs7JsmD3Y3cgkAlSD//UCDOD7XuOmPlDxcL5qL2Lw1FxmS7TvZTixDG?=
 =?us-ascii?Q?YxduINtURcnPWHw/Z5W6Spa+ZMhgJHyBYzU+GWkgh1mAQfaFWl8XuWndJlC2?=
 =?us-ascii?Q?GfE40Bc/NqcGPMKfiw6EzXcTdbshnhWD7aR7qpcctsNdU5akKoOk6BzKtetr?=
 =?us-ascii?Q?YbOMroBCpm5R9UdQLxw1J64tZIKkpYrIhhHetmw5BNE1KNmwTAdT3+9gpfxQ?=
 =?us-ascii?Q?dE6HL/+9CseP+nY3Dq6m+i32vy82Y6U8j7Jfk2FIvsFirH3jE+/3f2+P9/jO?=
 =?us-ascii?Q?Q7jJ98xwAM/Bhz33617zEGO2x7InSN4x/TAQnQorTVyciWmXpMDIrd0Qp0wd?=
 =?us-ascii?Q?blcUvwqoxlJijJ1rXRZt4tjgYLwALPLW369ebRaT6N7qSXUPowhALpByvlfM?=
 =?us-ascii?Q?PA9Oh770ZSGaSYIuO0rSXCccWSr4LZx1rtk3SUNOzHKWsEZoAtK2EVghYEEF?=
 =?us-ascii?Q?HobbT6f33ZxQPy1xR1J2KJKm1JiFpd3w99eZjq1e/k2dWzqPJ47fp+HzsyV5?=
 =?us-ascii?Q?2Iry2jXvaSy/nQ0eIopVDK+/7Pdot2VcgotuKBmg0nMMoTdTUsijReJ53Xo/?=
 =?us-ascii?Q?aqa/P0rr9Nm2+AAPss//OX7QJPB6jfmciEpxC4ZfkPPR/Skz/lOZG71PjvOt?=
 =?us-ascii?Q?7L7kYm0o+FoyPrdTFIWKfDpWLcnzv1JKIzTuFWQRnsp49BL9Kr5UcjnRfZlg?=
 =?us-ascii?Q?Uwqlx5lvev8SK5Cgi/dozSrjbBdH8z0iZAGnyiU3V3gRvwsTMZxlPJhbNEHj?=
 =?us-ascii?Q?MwhS8q2afAr2XZXNA4jhgy0EBXIWq90j6uUxsi3Lgy1TtM604sSqnUQ7NPpu?=
 =?us-ascii?Q?Y7lfUuoAW+sQ8QpKeG+gTGxtjLIgbwuhYz/26Ba6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b420a8-1add-45f3-cf98-08db66295726
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 00:59:54.5940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HChCLQprQRLVl40nTvxrdl0d/rGUe8IUoHNfRGwXMPx7yIhsscl8PtQuWJJ3uQne
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
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

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 66 ++++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 45d69462ddedab..4da3623d7686a0 100644
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
@@ -578,7 +582,10 @@ static void __iommu_group_remove_device(struct device *dev)
 	}
 	mutex_unlock(&group->mutex);
 
-	/* Pairs with the get in iommu_group_add_device() */
+	/*
+	 * Pairs with the get in iommu_init_device() or
+	 * iommu_group_add_device()
+	 */
 	iommu_group_put(group);
 }
 
@@ -1067,22 +1074,16 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
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
 
@@ -1113,17 +1114,11 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
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
@@ -1132,7 +1127,32 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
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

