Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06041709F43
	for <lists+linux-acpi@lfdr.de>; Fri, 19 May 2023 20:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjESSmk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 May 2023 14:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjESSmc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 May 2023 14:42:32 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFDCE47
        for <linux-acpi@vger.kernel.org>; Fri, 19 May 2023 11:42:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+hha18fz6a7De40QrhabatoUuiA5zyQ0RO3tpiLtpSgXE8ZxpA5lkRyDLa64J+PWoviFgQNLg84Ndo456GU8Y6FD1KoTiPe7b9CLwFdnIHTA73io7RRigZdGHfsF+4pV+AoVMubyezGDUFPoJ/C9bpvsjU5uRAr+Jv9uig4jgJqkf9G4gVvF71kv8ze53MfhS4JvE7r8a4BfykrdbgU03S5zE6EdXUEon2SKzzz2mHFYn9MsDhnDKm1wxWcysoBexdjBTSp2M0GjHw4qPT51EcFgTGHSunugyeK6s78iFI0Bx5RDTogM60p5Pn9j9Sd9v4Kc6Bmkcw59frZyTXw9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLCq0rN4b+G0Zc5V7KBmZ80W06Mpx3GOhDrwa6vK/Ug=;
 b=WmZJwgeEMFp0b9v0Ye/zVFuLTBoruI40rvjwidJGeVtfi01CcJhbXW4BC30C4ZgYAM0cKsZMfME+OrzeBEcuB8PLsBfOiuJMuLAMBZ+NbJP89PsOV+Bajow7claYE0VqTvUII0YOkTol2EhDD9Jw4sLTly30UejEERAMpBNMb5kbNl1QO9dl4VqPUeiTzzG2wLgoCcE2rqFdRBtsID73pOhFjvEolycUne8FNJaGVUnPWbgJ7BgRxX3qkSCMTtLJ1+7HBcphRjsl60Lmstox9eTam7txazD3penz5pYuZaYF6TzvHpByr0Pr9mkIk+dqiezk/5SuMvPQcwklezOwJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLCq0rN4b+G0Zc5V7KBmZ80W06Mpx3GOhDrwa6vK/Ug=;
 b=VP4kBQfpL4jVOy+USq7j0Z91is/ZwKj8xE5G/ZBv4wS1JGY/VfG68ed6tJKKfT7OrAoheEwHYASbdsbjM3Mta0dgM9ZXaD9ARX02XHHQpD3KMMq+ZPS14C6ikZTKnft5nkBf6AIVzO2mtFcvd7ukqXOeXvMD8v6RCM1pkxeSyuiY4aPXU6ynUvNFIjAn3BrGsKvrA0uDRiIoWF+hvyuSIeTYr4r8iRe3MejsBCGab+Yf2LMgzTcyy77SkE0q7/jpYvKapOy0VSzn/YtCymFzAtfdG0J7HpA+iFB57TtgVA1Gn/SODgkgfLlxAxtzGWmy0pXL6Q3qOT5bLTRCxJFO6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:130::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Fri, 19 May
 2023 18:42:26 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 18:42:26 +0000
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
Subject: [PATCH v2 01/10] iommu: Have __iommu_probe_device() check for already probed devices
Date:   Fri, 19 May 2023 15:42:10 -0300
Message-Id: <1-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
In-Reply-To: <0-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0356.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: fdbe3b32-d88c-4cf3-16e2-08db5898c7bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mdKeXHRXUW3YYA70p+tWLtjoqjFBLXRt+WD+Zd/IGFKtlfYEnTcWBM8ZdXQTqLJAbrJWy43s9CnOdAZHQK4iXrhQl8047VrFvBtXTP+ZxogBLHWj58J2JxwJchEmlDEhPk81r0chqtDdN9gV09eM2KY4XoOFAQWj1zLY0kspk6GvbuDVBWhDt06xh4hzIEsMKzOU2QYoWXku2edNx6Frdy11q2ThCa7/QC5lOPj34Cfth4XKMLGVarNXo3ZBPi7txcD31LVbsqJt/EinqKzGh43TKqKRl4afAbPmMJYbS1x05RXlngY/qHogAHunjGHySWJ4xMhtanfs3D1Q72hgVkgVQ5PTt/n2CrjD820OX6V0s42gMqvj8MVVJMrvGWKpqTcQqGHWW7zuuT+G4A9q75TZ3l5q2oDHtF6vi8IZFEFhhi2CG1jxtqQzlIZ386C5R0jQgE0ecFLFggrQRhy6KQy4irxFMxN7Y07XoUV0Rp9+dVK00qpN9I9H/I+Xncofdrx5rqfsTlTonlFdkN5R3czkufVWqviWainHNTYjmlBOGTc9H9TbbUuLIDmRcTPMd7x5vfHNVzqfRjQYqacl+kbjKFVaEPPJfvbugwXq1+M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(6512007)(6506007)(2906002)(186003)(107886003)(26005)(86362001)(83380400001)(2616005)(36756003)(38100700002)(316002)(41300700001)(6666004)(4326008)(6486002)(66556008)(66476007)(66946007)(110136005)(54906003)(7416002)(5660300002)(478600001)(8676002)(8936002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mjkzeunwBQvy4G2I0f3OLohx2Pw/oHrPa917505N5ClxJSCcHvAZ07ffwPj5?=
 =?us-ascii?Q?Kb1ye8RfZdM7vCxOG+gk8SL5UwgVfoLzW2AIpMhmQtX1SZYtqUhcNrn5XvY8?=
 =?us-ascii?Q?dev/48U6d4rsLHFoNgT0CeIvGU9ttaml6iKRjSwpFnhLSUgI5jB8UK+hBwxN?=
 =?us-ascii?Q?n9RDxcMqgO2hwAGic8Z2pTE8KqlPMs8EfRPWOZrnroclpxGvYkB++q38mytT?=
 =?us-ascii?Q?ywjNvBDialRkiA+zgY4hwl/ZXy+ou66O/Df7BpZkb16fWp09iIEX4/fG2N08?=
 =?us-ascii?Q?f1BYgMFQuBNdpmKLEvqtoOkRfg1UCvF3mypt90spkH0UTc1HBc7yDvNlJrOZ?=
 =?us-ascii?Q?JnkHRoULDSZsGfa69R6+i0GR0v2/hauSgpuF9nDqQ18ifevz0yfiEZC3d4ly?=
 =?us-ascii?Q?Li2hzCWmagnzZnmkgg2nEuQKYWpFfeWZUmsEjUZ8mh+hhi5YoXnD+n13/f1l?=
 =?us-ascii?Q?75sCQpjYHy8Y1V9mKQ/SDcjdCzenCk/BD7z5MeXxkSuJNG3YODHMTGvwQxle?=
 =?us-ascii?Q?k+9640adVAwoc9TrlE44ZW0FzJ+B8gfNnkJApFMGCuarekAm8nohtOeey/zD?=
 =?us-ascii?Q?gONhCpo4GtJGGYMahbrI6mpCZuhrLcjlMkJ4FAs2YQc1/4U1pggUKG9JvN7g?=
 =?us-ascii?Q?oIvSapTIAji7yoHPCDU7PHiQ5m2Gk3f8i70jzJlOBdIo00UPk1K99+9wN8oJ?=
 =?us-ascii?Q?JJL8G5gv/P0UC+WhM9moAJuIezdrzrjtnpDPcxmuZ8o2WCLEEFRXgb349kyD?=
 =?us-ascii?Q?hQOPN0gIpPhb8evzAICjOFdwSl8BYBMAMx/y6E1bJkdAfD3TPIsIjf5AMXpi?=
 =?us-ascii?Q?bQKgaqKakkMPKdua10rlyBcT/VC6Lo3VhwUfM8Nivugu3vQu/HugGK28dbn8?=
 =?us-ascii?Q?Vh6u3KOJ1k4yaLqmGnzfkNtFawJUYi3jJ8ppPeMo9PqYR/RvTlsYrGOFKtgQ?=
 =?us-ascii?Q?fxoVE9mBl4zFeKt7SfZHoia/NilDORnCSyK/wHE7kO48+etXStVWkkmA6nor?=
 =?us-ascii?Q?gamxI+g3zu2nj4cz3skkoxPJvdhi9iuFNk2FjS/ixJya415IYi/L4T47EEbF?=
 =?us-ascii?Q?8bBXIpkqw+7VH4OUSwHUpgurQ0kEjek0xpMuc/w3CGz0B8NGUHfel34fMDNI?=
 =?us-ascii?Q?4pritYtz//W+IBq6+6wLWSoFQMdmkJq7vECOCrmw2LenakqiJT6XC2wX6zn2?=
 =?us-ascii?Q?QkPjC+KbRpisgQsTijncEWNJtVlNxSz0BcOBieycwHGGDrBSRPYNS5SL0T4S?=
 =?us-ascii?Q?geqdZotKnr6IjnkCBvv35aA9e8mmlB9dRmAYRkTKeJNItPHcjFM/Q6gnx8ME?=
 =?us-ascii?Q?4RduPIbW7lCiSTM5Bdd9qdJNn4uL2wLGayz63I7NMFC6jS2fhcLnrIpdrz7V?=
 =?us-ascii?Q?4aN9rtelpVwluc3GUpluyKkvguC/IcP2NRMcEApnan6EglzBFNf58xfweeJ/?=
 =?us-ascii?Q?SA7X+ow0vzCcW8p7jSlQfcaVdx57xWQbZ2wJ85n9AjP55RfMDmA3x0ia2dPN?=
 =?us-ascii?Q?3mutJ1u0ojVJytJKmMH9F/IptI/3l+XW6He9Zw6ORfoLw0pMbmTMFzOnuCxI?=
 =?us-ascii?Q?7DnLQ1SqExFjuHof79rG4dHup5gaS1UdfvCnrtSI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbe3b32-d88c-4cf3-16e2-08db5898c7bd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 18:42:21.3591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9r4Qaf5Yf09qd+BzAB/S++aP8+uzzyDlkrcZASGHG7Qnim4ISFn9a7qQIdTJyRpm
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
index b871a6afd80321..3c37b50c121c2d 100644
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
index 4d7010f2b260a7..6d4d6a4d692893 100644
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

