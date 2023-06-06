Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FA6723441
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jun 2023 03:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjFFBAZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Jun 2023 21:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjFFBAC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jun 2023 21:00:02 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F49106
        for <linux-acpi@vger.kernel.org>; Mon,  5 Jun 2023 18:00:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5hkTxuUIOLyeJvLtdM+RmeqBAXb3JeuP4Ejn7vVs+aXUObX/sbfCX1Hwb91/e4z0VXPAPv+xyFRTtYAVhf6JnDx1Okgjy0Tdpxf4OOXnBFmhRJAcGsDEog0x5Juo0phEIVJcpfTnfgJitRMDY9yUuoPVa1kEgKw+CyYK7OUQ8apzUhNcdaD2ap0Lhrrnpjk4P9WowAF8MleVPJKdmISrX4eCOdrjaQjr9E3gm4Hi2xQob2ZX0dw+RznZtSgPFoYRoB86zgUA3xJwu56iLUPnfyM9M2v+/Sa/UGBpblN3YmPm9xCA3MKpdDg8xW8NAlR0Dy89wdwbx9Wn1r9v+LLdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWztvG5qzwtJvxZjAKbwxApkK7ultrIqaGPBbkHXrp4=;
 b=SxDvLSeBjsGRFoXuk7TZGfd0Ehts5ovc9rsZKQrilY0tTtTZ3g/NUifbXOAnIoRTOGMOKn9uG4Ap/WRosFuHFn0jTSHuY5WXKhBaCJ4kslLh8a/pZXEnJl0EQTCfhTmtb4YDShZwpESUvPhLeovxri7UaBz2P4Q19n+0/92L45KqZDp0z1y8iWLEL4BIsZ0gLjc/IJURurWven0xETg5fS67pejOmHri8YG1wGyuNgC2Y1JJEYZgfTBlern/NDXJCI3EAPU0If7Vt+rctVwdgstZ22i44bCg2/mvgdmwYYNk9My0PlKIUJnoxyXQ/NX7cx2s2AyCMt/4u0UBSczU7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWztvG5qzwtJvxZjAKbwxApkK7ultrIqaGPBbkHXrp4=;
 b=tVb3sItgpxL+4xI1KcilkuZVFLAetSDb8H+wK8HEgDrp/CKhqs/L/cdoji4jVFw+cx66zjujll2lmBDMU7gbV9gL9kCO+C39BTCDwoFNJNYSbFgB4SRCz6bSJBlqhGp2eDXHfHDKKj7mG9dvRlSmZQNCx9nGGWV7M4WvAE6xVfwNx5Q8MkpIG2PVITIkjqZQ7g7cXy0VN4w+6TIZeuTqrylOV/EFNrETY5pT8UDQShTz0Hfc3iCF2uqFpP16mHxt6Y2O2qZLIl9ujTfwePiegIHLG3nGAzp4y1Bnv+34t+OlKLDigs05+DSFiLPCUEYzC3mCYABCiOcgsviRU2daNA==
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
Subject: [PATCH v3 04/10] iommu: Simplify the __iommu_group_remove_device() flow
Date:   Mon,  5 Jun 2023 21:59:42 -0300
Message-Id: <4-v3-328044aa278c+45e49-iommu_probe_jgg@nvidia.com>
In-Reply-To: <0-v3-328044aa278c+45e49-iommu_probe_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:a03:255::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: caf3bffb-f4e5-420e-ae6c-08db66295547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GlzJCExG1HsOJD9MfPAn8puHxQH8FHinNqnl6y0HWnBVEtPOZeyx6Gg8b1IQZxgiO145Ebl/n6QAHyjF2P+dtjQ/Sj6zkcRMVHhKgHRtoqLCiW2n4uthZWikNAPn7CZd7UQGg21CT5aS9S38MyBEgtkU67HTUg8O6Z2OXkGCaNeQwb+pGPPFupBO9AUjXlEctkfLYevOtUw1jgKewe77h1oTa1s+M42UJvWXPfNNhLj2DoXmSzy9MP0/sTuI3oChhoNQgUm2QLxlcEmnpAlv/0mEOFPk4/4H5LbDbQyMnQ1xg3nYcmGfVNx/BoAOwTxNr08zTVu6LdHO1sIEZWcfJ035hf02QNTx7kLvHILact65szHLmtGya8N3uFdcFFdDZ1+P3miMwtm7pfW0H0AOCWqm1Lq58qdW2rUe9yNzz9DkSHvX7xhj+Z//E8PTwDCmTGtJ67Ct1B3XdIIzwfNS/MyMHLWLrG9g3FzvEGKXhxlBtXiuQxUhSbtKwaV/cK3BcIkogPFVJZDPTWL9QQtwjZF+mLOzWbR11qjQ3PruRWJMhTMS7OyBG25qg8V0kk5k21IXH1A8foexe5ZMcZkH2JFhXUaS0awNJtzlRgnw3A4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199021)(36756003)(110136005)(54906003)(2906002)(478600001)(86362001)(38100700002)(7416002)(41300700001)(8936002)(8676002)(5660300002)(316002)(4326008)(66556008)(66946007)(66476007)(83380400001)(6506007)(2616005)(6512007)(26005)(186003)(6486002)(6666004)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/1Tp3w6JPcWwNHvTNZ06iAgl+Z3tPLRYLcDgfAtgFlpb9FfVfHBXi/BjPGBK?=
 =?us-ascii?Q?4w5AmXFO/YTfPjEr6Wvs3bjwHpcdw05gOs5J01QoxNO3dQx0QT/BXzHg2P4W?=
 =?us-ascii?Q?CkMIYWORHq26R6GCN5IUy6eU1VP9aEBH4BMdeDoEkcY9KBaJEI5k4ieMewiA?=
 =?us-ascii?Q?8nPqg/rn3msaRL9iORybR9LWArR6gH9UDumpitEy6UeK7/JWHazVs7Ar2gkI?=
 =?us-ascii?Q?zgUhngHslUNch35X1L/WmeR3Xec/CekKSvqK8czFgn0TkReByuJdt0HQ0Do0?=
 =?us-ascii?Q?Fxf1sTXbEmvfIdMPN900jyJOH27NzUxPKpJnM7lBdCIA31YCkbrD3ChhDw2T?=
 =?us-ascii?Q?TbMhUR620rx4MZYcqj2uKajq0lNUOo2aDpaQtZwNhaoKKbKfGhEN5rMPO//k?=
 =?us-ascii?Q?uRhHi+hKtKGSdmEKpK4Nd1EJWyhhitapgGI1vnIIbPOB7eMSRpz8YLwfM6nh?=
 =?us-ascii?Q?FKG2EcqUHka8iFNECY7sTnpHJBNup9IiB+wMtFR+VrbfaNluhfqMQzR5vJ/n?=
 =?us-ascii?Q?DkR1OXB3drEGFGbLsiY3zzHb7laGqOeUiDnk41UPFyFgQKC3uESO8657sPwb?=
 =?us-ascii?Q?seGh9SRbrNTO+g0/N0VSPnWGOpKFOFgmiiaxC58lJNwPENI0ZOLcDxRub0NY?=
 =?us-ascii?Q?MaVyFc4MFuN7wh6gQ1xj/lBXQZLz7o87mkPm3J4GjKVDxPxSmCnxWBsHsJQR?=
 =?us-ascii?Q?wZX/xz53tjQHqJmNNUg7Ey2jfKkaqJpDd6iLWLYWkuB45bVGyhq+pYDCvLIM?=
 =?us-ascii?Q?fS80DkCMHYGMYrh/fdH99ND7KrXRvjuHrhb+VnKNMs0FF11iHQ1vgxfH1QDg?=
 =?us-ascii?Q?hC6ExlWsHZG+LWpTe5l1sy3fiA+mA1wvDb/iruRmhvKXTedqJYrK26hGZvZ4?=
 =?us-ascii?Q?A/gUUzPPTf3mb2y25DzbtsV9MSsoknZdjJ/Jm8rWU/NJQ6ZxhsL+iUcAETQf?=
 =?us-ascii?Q?AfgfpAqRlje6eWl3NLDJMTf5ypYU4l4oQNANBfx5pTN8AdkKsS7MHrDpW/Bh?=
 =?us-ascii?Q?K4fdPV1/lhXorAcHRR9BxL7zOCpvB2E9qXPNkw+NMvsiOxZXrNJGMJqkklnD?=
 =?us-ascii?Q?bxMM4HNKjYUdxdwYI2OYw/Vd1YvO1C4bUg8pNZkXBW1CqkTx3HtW8C73Wy5n?=
 =?us-ascii?Q?TGrMk4ReNurEcwckrUu301la6ubjduDZajIQyB0bipWPUU7mdUEy3k7ZUyDT?=
 =?us-ascii?Q?TDQNwa8vsF+A5Ts6OeiQRS1YQ7NK6Pcc25KK2HqckKZxd09G2qo4h1pEqK9e?=
 =?us-ascii?Q?ptbXltQ8DC0cEPmuGqswopCrGQJU1TN7O5ni9MV6qsBcTjWLWMQWLX1NNREN?=
 =?us-ascii?Q?1C0oPgBGEOnqOgYQjh6t7Nzs3PNwxeHh+uWqmIM21sff+Kv3TXmM9edMmA3N?=
 =?us-ascii?Q?TQh/CI/e+iA33gB4ySa7uYYrphhzcm4h2Kuf1ck4dWEX6fjcRDznKRdUcNrj?=
 =?us-ascii?Q?IKGO+237DWQ6L60Upl+9O+SlLiXOtQQVI6Mly2yEMnmHj4E9w5sUNi2JQRcW?=
 =?us-ascii?Q?WAVg3hykDl6USnRcHWQQNiKdRmZiN4IMgPjgqGCUccdpdHxGSLw66qxISA4X?=
 =?us-ascii?Q?9YOFAJ47Gf3ns1E0UGq7VO/ujrS6cRtIX1hJ2u+j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caf3bffb-f4e5-420e-ae6c-08db66295547
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 00:59:51.4765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +STJ60y6Ltv9Q88w21xtBh8OlGSwMf2+SHrS4JMtXWTiQLvHKd55ex9MXWZb+Vam
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
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 83 ++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 44 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 480a3640d94c3d..456c2d2934896c 100644
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

