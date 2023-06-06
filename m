Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D09472343B
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jun 2023 03:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbjFFBAD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Jun 2023 21:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjFFBAA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jun 2023 21:00:00 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16232EA
        for <linux-acpi@vger.kernel.org>; Mon,  5 Jun 2023 17:59:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBvqdUrSlMJ5XZJrindk9fHFDS+f6lEGg/qetERBxIpnZwVgfntobnBWX2gMI7yBqyiOkV3KDzLcqWg4qAUJggO9C5XkR0C07h4qI7QUZhmxWKOhd4XiFLPVQbB3ug4K4zn5guh16hQX6wuRSYDY4XPMHk+M0fN8Guz9FvSbyefdy7K72xOzqqw4dTPacKZ4jq1eShdMHUnmLaDmwPsDavKBYbvYNtYLl+5Zokb6IE4ztvTsasDo6xshLhb/NhKUQbTKwuuE/N9rRyggLuPSconfAu/SgWpJhV6F9wKjq1QGGLbjYr0hJw3oAyr+Ak5MESXcxohzXKP7rdMhUQWQsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1DLrOvYDbQWSXjFR4azTDBnHASDkxNmjw6udWZrUf4=;
 b=N/MrBhsPmW+ri2daGI5/vVknYqzjRwXDrrQz6pKRz4jeL7NilR+VxaxHJ/VvBPdroI/+tJTsmiKzebzt4PyB0cBJiH0N7knajcnvoPfNnHCnPJjK/At4GxxGx6CjLyr3nFqp204TW7oYk/88amzTgwuVyELSQafOgeZ/OcAkbhdp9BPsv9dFVLr0+cNncR+vS0oo6AGHlmkbHzswbsYvCtv9UtIK+Al0Br12jPiNPhGY0zp2F0PWyZGgYsuzW7VnFh9tC0SE5+2OxEkp//GgsyjAf2auuSGGxLoZvperxdKzeksvOPk3fY+leeEgkUIsMB7KNtBwVV/X3IT9l/pi8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1DLrOvYDbQWSXjFR4azTDBnHASDkxNmjw6udWZrUf4=;
 b=mMXsMf0O94r3+u/YS8Wft+IUqpKAVSkS14B9XjP7qDGDCPi87NVp0/fO6jXLVMeuJ9IPTJnNnXGge5ISL4RKHrSs0maZC98ayRS+eAvh59f6XeX8ykwMVZGzT20y2dkZi5bdyQMbmFC/5QauOM1SrPJI7O98STcmBzEE/iWsTYzuaQ/AnGdkAYZIGFdT+hh2IeStu1xncsMwlM1QZ50q4eTrLLgAB96Sr1eZ1RLTtdbq1YSG1nm+0wXMGwxXdDXCd6P5ti7rRrbfBUyx2Y8S78L4TbWyOhye32Ltq9G6zGjjfg4cOBbH2+jsgauthGs0OVBYZWYkEGHibQwqGYZzCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 00:59:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.028; Tue, 6 Jun 2023
 00:59:54 +0000
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
Subject: [PATCH v3 05/10] iommu: Add iommu_init/deinit_device() paired functions
Date:   Mon,  5 Jun 2023 21:59:43 -0300
Message-Id: <5-v3-328044aa278c+45e49-iommu_probe_jgg@nvidia.com>
In-Reply-To: <0-v3-328044aa278c+45e49-iommu_probe_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0055.namprd11.prod.outlook.com
 (2603:10b6:a03:80::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: aef7ad25-0b21-4f39-4f34-08db66295526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5jHiWt2bt5I7p3uZaZF/+ZuZu+29eaIOQRlTaJUo+RtFfgaxCWfY1KV7KQzO4hBrr1DSNH/ekc+OuL59h0DgEePpjPoPPco+6qAFUg2aH+3lAukuXCB0ZlABgI3JKcpix8nIVs3lEMVeuyOTiJ2PccEx1L86+vCi4Z73UNFT0esgXrKOet6Aii8yGdZI0CmQCZMldqv4gDj4Ud+3UoTTzNZ74rPWMUK4Yp4eY+YmB+T9umPP+tsj4ipjdg0u6L1yWMl1ht5l2Y1HlugYfAuKH/XGy0EqStXONyrwHeCiBg/BdAdPpRlySIf/h7RMt1LJshcPcqlGOaATfy8chZLGTBr0RD0pv2kBk8fVTdSDbloWdilIy2MommFnaBp4/LXy6lPQ0iZ902hxnOBUhbJ/nz+2E1HGgJ2n9XIulM8NzZyiPQkmQenX/5FND98qGZT3IYepeUYvWYXj3FMC0+QPbIiTQImX5ZZvKthT/JvTjgAYe1JxVAbT9SemTHCebVTK0Sll7/uqLFQ7QIfeeeXucH+/KQomAvtzDDuR0H/B2/iuTgCdeHpNa3j12y9DdA+L2Y6wjvPYIFU8z1wiFW7yc17O/vw9cHUoWxfx89TJkgA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199021)(36756003)(110136005)(54906003)(2906002)(478600001)(86362001)(38100700002)(7416002)(41300700001)(8936002)(8676002)(5660300002)(316002)(4326008)(66556008)(66946007)(66476007)(83380400001)(6506007)(2616005)(6512007)(26005)(186003)(6486002)(6666004)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l8JykkAxt2BNrFLitJGhb6QbBtixtzXKH8I2O361v/p6U8gf90m56zsYBLLT?=
 =?us-ascii?Q?KD0MqAOvkgxvv0oWZ1QWXdv/5Zh5TBSZpmVGL3uDLK5++riiFmvccaSO0jR1?=
 =?us-ascii?Q?ehqyF5HK849yuNiXkAytb2OGesTJE7LD+BETDvWRcP+wf3wf86yjRxWTiPWs?=
 =?us-ascii?Q?jRrDbiMK/JQlMlv5W6EVEQISH6wOaiSDPXrRtY4cy4t8CwWlt3ZKoCJOcBoR?=
 =?us-ascii?Q?QRsZkk0UJMGykxxMvzjoDE2TUul9PbdXIG3hpsYvTRZCBR+QuTjE2PWJ4c51?=
 =?us-ascii?Q?C4ogdXd+JDF61vBe7DAWxFAEZDj97kjpA+BJqlhzt9aGefXzhgOUXo/3Ys9h?=
 =?us-ascii?Q?HbQ28mQhsSwJZ+xixFpqkk5f+XkLIIGvbVXBikFOibZ0cd1eQ4y34UMYJ6Bj?=
 =?us-ascii?Q?TNvEq3Rl6H6oC4EoyUBnXFMhlJUpoEhDmsEc8vSNtvfvqVX11Lhgz53QPRgc?=
 =?us-ascii?Q?68mYNUboZr+rXTMkjF59XI926FpXsNgPakju8jN12icNrBdkDHqn53BtYxEO?=
 =?us-ascii?Q?WPebyEjxETeOMz/OZjXUp3fB2SmBaSCnabIDM9XoRA/yBePszJ/1vQ8gmtOS?=
 =?us-ascii?Q?WH9Z27KBzy1NG52pDk+15N2/44lDcc1FxVogwWwEEi9DfIT8f+XVcVyhpHyu?=
 =?us-ascii?Q?OnoIFvsO2FZq2Cyj7sYpY7dN7057tAmRRo27Ma5PnVO1B0OfqlfjoMGzBF1a?=
 =?us-ascii?Q?AgVMXFJoajeLXVjhKpxpEoHsKfxVwa6u+rY/DGBCnj3kRs65TQ/MzlK4xnXN?=
 =?us-ascii?Q?xyRkp427u7rZKf94RM0rmrz61jQUHsGdpF2Uy8Vi80ZV8i56n4bWiiEOM00o?=
 =?us-ascii?Q?2TgdPki2nPYfhVlfhRzQ08LIRDsvfiHJ3WRT5wmhL57uMUzTj4vepmgANQ8q?=
 =?us-ascii?Q?z7O4Skp4vXAX8nhvo76TjuC4XdJerWteO/58BO0WBDZaeErdTcXzBGI11VUV?=
 =?us-ascii?Q?IBLD5lLKwHdETvSF8yafvrdeWDqvtT03/8bbQrTzUSA7WmEDn+ialeH30Oi6?=
 =?us-ascii?Q?Xx4kkOvk/noL/IJosq5XcFUM16qnI+yZ2tLFQFUbMBGLvphi1giMSjTOK165?=
 =?us-ascii?Q?irfJiOv2A8xgokIvkGRd+xQZ9RYrl8Xu2QaygUeIyI/Iw9MYkaPjXkxxWDjz?=
 =?us-ascii?Q?C1B5JwWgsb+E8NCFARTkQd+CvY9aN6foBX+4F+oCbdd8xNPTLdny2dIJ8/Aw?=
 =?us-ascii?Q?eFoepw3K+F+IhWjADEoVXUNlvtlMa+FBpoJmpjFRJyn97DE64k0vFhbbWCBb?=
 =?us-ascii?Q?aXlp1IzGJnAQW7AL3+N1jFtRzkCzkZ5vq/RfeW0Os+lhh15TdQynKrkF0czH?=
 =?us-ascii?Q?j3o6N1YZN+yXWIJUdEhu3r75Z66dthv8aJgzmDAhl/gCrd9HBm5McRt4DAvi?=
 =?us-ascii?Q?7+Gzk4HQ9SwVD73FyW0v+roA2YNcawrhDljJdoF/Iz+j1J/G7JqpbJkdeCP5?=
 =?us-ascii?Q?VIqV7LyrJg9sQm2NnZMujpYPb/epIBL7mx1zDdD9/V/2R8om0C9ZCaprV8BU?=
 =?us-ascii?Q?7l1iDez6BsDkYUdjKyzKIoZbVrcZ3DdR1JIMqebxFaPCfgg4wrlkwHU9WOXS?=
 =?us-ascii?Q?sZcB5kXxfcFyQPAF9lwultWDi0hvJpiDkOksqDND?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aef7ad25-0b21-4f39-4f34-08db66295526
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 00:59:51.4404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozz2VFu98/NCdXFPivWkZORTP/tFcdLiMkG5tmaVfP1fRI/7SzYrG3j5C9pe0jg0
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

Move the driver init and destruction code into two logically paired
functions.

There is a subtle ordering dependency in how the group's domains are
freed, the current code does the kobject_put() on the group which will
hopefully trigger the free of the domains before the module_put() that
protects the domain->ops.

Reorganize this to be explicit and documented. The domains are cleaned up
by iommu_deinit_device() if it is the last device to be deinit'd from the
group.  This must be done in a specific order - after
ops->release_device() and before the module_put(). Make it very clear and
obvious by putting the order directly in one function.

Leave WARN_ON's in case the refcounting gets messed up somehow.

This also moves the module_put() and dev_iommu_free() under the
group->mutex to keep the code simple.

Building paired functions like this helps ensure that error cleanup flows
in __iommu_probe_device() are correct because they share the same code
that handles the normal flow. These details become relavent as following
patches add more error unwind into __iommu_probe_device(), and ultimately
a following series adds fine-grained locking to __iommu_probe_device().

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 191 +++++++++++++++++++++++++-----------------
 1 file changed, 112 insertions(+), 79 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 456c2d2934896c..7e8f5edcff2145 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -332,10 +332,99 @@ static u32 dev_iommu_get_max_pasids(struct device *dev)
 	return min_t(u32, max_pasids, dev->iommu->iommu_dev->max_pasids);
 }
 
+/*
+ * Init the dev->iommu and dev->iommu_group in the struct device and get the
+ * driver probed
+ */
+static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
+{
+	struct iommu_device *iommu_dev;
+	struct iommu_group *group;
+	int ret;
+
+	if (!dev_iommu_get(dev))
+		return -ENOMEM;
+
+	if (!try_module_get(ops->owner)) {
+		ret = -EINVAL;
+		goto err_free;
+	}
+
+	iommu_dev = ops->probe_device(dev);
+	if (IS_ERR(iommu_dev)) {
+		ret = PTR_ERR(iommu_dev);
+		goto err_module_put;
+	}
+
+	group = ops->device_group(dev);
+	if (WARN_ON_ONCE(group == NULL))
+		group = ERR_PTR(-EINVAL);
+	if (IS_ERR(group)) {
+		ret = PTR_ERR(group);
+		goto err_release;
+	}
+	dev->iommu_group = group;
+
+	dev->iommu->iommu_dev = iommu_dev;
+	dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
+	if (ops->is_attach_deferred)
+		dev->iommu->attach_deferred = ops->is_attach_deferred(dev);
+	return 0;
+
+err_release:
+	if (ops->release_device)
+		ops->release_device(dev);
+err_module_put:
+	module_put(ops->owner);
+err_free:
+	dev_iommu_free(dev);
+	return ret;
+}
+
+static void iommu_deinit_device(struct device *dev)
+{
+	struct iommu_group *group = dev->iommu_group;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+
+	lockdep_assert_held(&group->mutex);
+
+	/*
+	 * release_device() must stop using any attached domain on the device.
+	 * If there are still other devices in the group they are not effected
+	 * by this callback.
+	 *
+	 * The IOMMU driver must set the device to either an identity or
+	 * blocking translation and stop using any domain pointer, as it is
+	 * going to be freed.
+	 */
+	if (ops->release_device)
+		ops->release_device(dev);
+
+	/*
+	 * If this is the last driver to use the group then we must free the
+	 * domains before we do the module_put().
+	 */
+	if (list_empty(&group->devices)) {
+		if (group->default_domain) {
+			iommu_domain_free(group->default_domain);
+			group->default_domain = NULL;
+		}
+		if (group->blocking_domain) {
+			iommu_domain_free(group->blocking_domain);
+			group->blocking_domain = NULL;
+		}
+		group->domain = NULL;
+	}
+
+	/* Caller must put iommu_group */
+	dev->iommu_group = NULL;
+	module_put(ops->owner);
+	dev_iommu_free(dev);
+}
+
 static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
-	struct iommu_device *iommu_dev;
 	struct iommu_group *group;
 	static DEFINE_MUTEX(iommu_probe_device_lock);
 	int ret;
@@ -357,62 +446,30 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 		goto out_unlock;
 	}
 
-	if (!dev_iommu_get(dev)) {
-		ret = -ENOMEM;
+	ret = iommu_init_device(dev, ops);
+	if (ret)
 		goto out_unlock;
-	}
-
-	if (!try_module_get(ops->owner)) {
-		ret = -EINVAL;
-		goto err_free;
-	}
-
-	iommu_dev = ops->probe_device(dev);
-	if (IS_ERR(iommu_dev)) {
-		ret = PTR_ERR(iommu_dev);
-		goto out_module_put;
-	}
-
-	dev->iommu->iommu_dev = iommu_dev;
-	dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
-	if (ops->is_attach_deferred)
-		dev->iommu->attach_deferred = ops->is_attach_deferred(dev);
-
-	group = ops->device_group(dev);
-	if (WARN_ON_ONCE(group == NULL))
-		group = ERR_PTR(-EINVAL);
-	if (IS_ERR(group)) {
-		ret = PTR_ERR(group);
-		goto out_release;
-	}
 
+	group = dev->iommu_group;
 	ret = iommu_group_add_device(group, dev);
+	mutex_lock(&group->mutex);
 	if (ret)
 		goto err_put_group;
 
-	mutex_lock(&group->mutex);
 	if (group_list && !group->default_domain && list_empty(&group->entry))
 		list_add_tail(&group->entry, group_list);
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
 
 	mutex_unlock(&iommu_probe_device_lock);
-	iommu_device_link(iommu_dev, dev);
+	iommu_device_link(dev->iommu->iommu_dev, dev);
 
 	return 0;
 
 err_put_group:
+	iommu_deinit_device(dev);
+	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
-out_release:
-	if (ops->release_device)
-		ops->release_device(dev);
-
-out_module_put:
-	module_put(ops->owner);
-
-err_free:
-	dev_iommu_free(dev);
-
 out_unlock:
 	mutex_unlock(&iommu_probe_device_lock);
 
@@ -491,63 +548,45 @@ static void __iommu_group_free_device(struct iommu_group *group,
 
 	kfree(grp_dev->name);
 	kfree(grp_dev);
-	dev->iommu_group = NULL;
 }
 
-/*
- * Remove the iommu_group from the struct device. The attached group must be put
- * by the caller after releaseing the group->mutex.
- */
+/* Remove the iommu_group from the struct device. */
 static void __iommu_group_remove_device(struct device *dev)
 {
 	struct iommu_group *group = dev->iommu_group;
 	struct group_device *device;
 
-	lockdep_assert_held(&group->mutex);
+	mutex_lock(&group->mutex);
 	for_each_group_device(group, device) {
 		if (device->dev != dev)
 			continue;
 
 		list_del(&device->list);
 		__iommu_group_free_device(group, device);
-		/* Caller must put iommu_group */
-		return;
+		if (dev->iommu && dev->iommu->iommu_dev)
+			iommu_deinit_device(dev);
+		else
+			dev->iommu_group = NULL;
+		goto out;
 	}
 	WARN(true, "Corrupted iommu_group device_list");
+out:
+	mutex_unlock(&group->mutex);
+
+	/* Pairs with the get in iommu_group_add_device() */
+	iommu_group_put(group);
 }
 
 static void iommu_release_device(struct device *dev)
 {
 	struct iommu_group *group = dev->iommu_group;
-	const struct iommu_ops *ops;
 
 	if (!dev->iommu || !group)
 		return;
 
 	iommu_device_unlink(dev->iommu->iommu_dev, dev);
 
-	mutex_lock(&group->mutex);
 	__iommu_group_remove_device(dev);
-
-	/*
-	 * release_device() must stop using any attached domain on the device.
-	 * If there are still other devices in the group they are not effected
-	 * by this callback.
-	 *
-	 * The IOMMU driver must set the device to either an identity or
-	 * blocking translation and stop using any domain pointer, as it is
-	 * going to be freed.
-	 */
-	ops = dev_iommu_ops(dev);
-	if (ops->release_device)
-		ops->release_device(dev);
-	mutex_unlock(&group->mutex);
-
-	/* Pairs with the get in iommu_group_add_device() */
-	iommu_group_put(group);
-
-	module_put(ops->owner);
-	dev_iommu_free(dev);
 }
 
 static int __init iommu_set_def_domain_type(char *str)
@@ -808,10 +847,9 @@ static void iommu_group_release(struct kobject *kobj)
 
 	ida_free(&iommu_group_ida, group->id);
 
-	if (group->default_domain)
-		iommu_domain_free(group->default_domain);
-	if (group->blocking_domain)
-		iommu_domain_free(group->blocking_domain);
+	/* Domains are free'd by iommu_deinit_device() */
+	WARN_ON(group->default_domain);
+	WARN_ON(group->blocking_domain);
 
 	kfree(group->name);
 	kfree(group);
@@ -1109,12 +1147,7 @@ void iommu_group_remove_device(struct device *dev)
 
 	dev_info(dev, "Removing from iommu group %d\n", group->id);
 
-	mutex_lock(&group->mutex);
 	__iommu_group_remove_device(dev);
-	mutex_unlock(&group->mutex);
-
-	/* Pairs with the get in iommu_group_add_device() */
-	iommu_group_put(group);
 }
 EXPORT_SYMBOL_GPL(iommu_group_remove_device);
 
-- 
2.40.1

