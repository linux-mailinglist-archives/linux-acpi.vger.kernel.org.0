Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1779774473
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Aug 2023 20:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbjHHSTf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Aug 2023 14:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbjHHSTM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Aug 2023 14:19:12 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5226E86245
        for <linux-acpi@vger.kernel.org>; Tue,  8 Aug 2023 10:27:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiqjWxAYEfy04oKvswfkAdIt95JCTpAXoDS60EhxcniXtirPk8+H8aSngemLfbNWtlhZ92hgjunkSVdYN5q66mUp6Iyu5kt2reUhD49iZPgdRl8lRQynhtc+vPDpqGqaz55lP+BeoG8Gf6GvACu886M0JW1iMIqlc5AyjQQeikbjfrNLoNWlJWjXc4pj0pV/Jx22ZsRSga/V/ilw9Gp7A2VlnQw4NAj/HzulGZ0O9KPsOs8YPzULCS1YWp7ZIMgXC8N41ELDGWTL1AJeSN6SkgLWti/vzutHLxgM44i4v4jn+6ctA5r3/RwF/7RtQkZ+f6nYp8bvBJGUzc3XfWg/Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfgpzjJZZ6/Ui1wndcrkZRbSTYjZz4VLwaE9NiBJD9U=;
 b=dZY2F/xsKyA/Fa5LMG5iyqb3JIqLta3VNqWwYv1dbb8gInLRs8iHoOQGyv6I1PIgZTjMMQwH2xNdXcCBStWX6L+8a4xqjn0lf3is5/0oIE4PkehLluctKFuMxMbki0kIpg2kRIGSx/mIaFoRpFtgSIu3MaF22wrI9TEtug7v7vtjS5hkK5/9ijDb3/9ShWpYUwZH2SjrN/aJtkLbElD0A68Klk/1x3Xm0bkhdH9grX9KeZwgP1xM3WrJ81rA6QGeSFu6c+pgH8CJyUp7fbUFDQDPk7RMfz9VFl7erUAS4lOVkmhyDVCzHVfhGGXxiI5iFfgdIFxP75L50riJdtBtiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfgpzjJZZ6/Ui1wndcrkZRbSTYjZz4VLwaE9NiBJD9U=;
 b=K92QKo2Q2aW3ojyiREAr2ofRTAQPfkonj2ejfsdNUScLZimfxfSmi3o4R7k14fUCFTJn+kXfn1oN+wgyzuYuLHLku2M0Zt76Pm5H3Rc07JN+fhNrg/yAnSorsSMJ2zvy/gvHwBq32b4n2l+SP7AojxUYfIB9nPa5U6nCJzkLrP9TsdDU33dqlUMo3y9b/QVCEcy092Rhk/1q2uQRrsLgR8z6oPtvl45tYWBpwU0SoqB9Qww9/4j2JWL4ZZS1UbX4QHnrgnWv6SErrzw5HoKubcVEXPxdc7677XjngPz3Wh/EF1upfN6bc3Ev2XGLMENEGPalgPwdXuVkM2HjDr6+3Q==
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
Subject: [PATCH 1/3] iommu: Provide iommu_probe_device_locked()
Date:   Tue,  8 Aug 2023 14:27:05 -0300
Message-ID: <1-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>
In-Reply-To: <0-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0409.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fb43edd-eeea-45aa-fae5-08db9834b18e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pk/qNwlDAxL3koeq5LCvbJ9jU4Xir0Zs+Aroc/dq//ViMmwUI1sR22SFe1BgbwP5WPXPBhOM69bTznODJntadICAKBDnwYvLSVU1l1A/P4afQIUN/S6yl7/XmQapHlNjFLTOn1SbtBqdLVrXMvji2SAZ5KaeNgX5fFfuTkZ7h0Mvly94GnqvNU24S0maZ6UFct8rm9F82a2YIBEE6fchaB4gd2Py5lGs/62y/QbYnXrdv3IKd/iZkFPCv4XPsypaUyk1eTS72DVEl+igYQiNTnsCvfp2DVWCpr7PtMijYX/FP3BPK1eiysqOvhPCvqB/CB++hWQmRPCoqYC1C5LHNIm3Kft7d2wMfIcgRskgoH/jrmbJoFItOL0Bb61xQDh1lUmdfPjAe89+sf7Df++UPTi+1mtXVHIHH2+qowvYcHjlQawm8rF/e/zO6/vyYyg4JXuN9ll4xzNWNYU7joGl7IAy/55TpANlCKcPd+TalxW5N0y+pniQRduthxaa+7WI+gdAVYGONoma6EgcC/etZxaGT8MAf7F5tQHf90ahJI2arCX9ATTyONzDMhzZeC7FrfQ7Q0Q3ukfhM89RflLZIS5fWMShpfhTrFpO/k5QhzmHO5PAvdMkrRzAIgVY8OG84ZRDckSGrgyUvnAE9rRCGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(186006)(1800799003)(451199021)(83380400001)(2616005)(2906002)(110136005)(54906003)(4326008)(316002)(8936002)(5660300002)(7416002)(8676002)(38100700002)(66476007)(66556008)(66946007)(6512007)(478600001)(966005)(6666004)(6486002)(41300700001)(86362001)(26005)(36756003)(6506007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?riz/zgYugOtlMv0C/B4GNkuUSOHA+BNCzTprFJGZ76UoPqAstZerkADg3D48?=
 =?us-ascii?Q?gb4YqGY2beVDFMittEdxXpuXurMLtYudqFA8pV/mFHu6TUX+dR8sr8GT+wNw?=
 =?us-ascii?Q?G9whG24VVFmvyVLirEHgv+YJoSHbKWaCL4NLjM2XyvqfJzC7mi7A8X0ZIP5z?=
 =?us-ascii?Q?zlh4DIJBKeQJlsQrAiMlfnMJ6kcGGlX7I3sTIEMUUniYHnqo/OODqSSVqkJj?=
 =?us-ascii?Q?mMGS20A26sQg0REYCOjl8yRhbZ4CtmgLTbJYweKwtR4TAYOBO4PecdaFUFDP?=
 =?us-ascii?Q?VeDH9anYL8MUY/3+A9JPHlZ12Fn+dJu4jO4uWcR7OpCg5M+c3UD7V8KcyeCl?=
 =?us-ascii?Q?IP8GUd73VlxRwQQbkdUV/V0hrbErjxx7/CpGEJrkhJWZrdnyupOlHt6pAl0o?=
 =?us-ascii?Q?ZY/oEbh9QuhArff9m2aj2VdYKVbo+IUhD58geSaH3vqlQ5uEAdmAXmy56uMo?=
 =?us-ascii?Q?6ok1t8HPv+9qjbX1DmTae6qkWh/cK3yHLBpJp70eB+fbbcsX7WRJDlaCclJw?=
 =?us-ascii?Q?q1md0qJQl/vbn7DuH7IO0RmTbLN9Y9k71l4oMf9fOjYNYAo70p6p/BlkwUzw?=
 =?us-ascii?Q?M5XHgDB7fsAmn2a17/juFaLXxSusmwymVFT8nlk2vUB1o55gpStBS9zjrCaB?=
 =?us-ascii?Q?i0h0SfAFlWWLVyEfdy1reZ/kZhohn2fDhhozDk41VOqxG0FGtbHfu+1sgEjD?=
 =?us-ascii?Q?p3SQ3HvLABaB2t4ytSNuSfIuJ5uDGPIhvb0zHKQmpGAjQbpBaSCet7qhSIYZ?=
 =?us-ascii?Q?gr3mkG8Jjse8Ry0LAaYZ1G3Q2j2rNPEEIauVDqVSKD7jqzPEliuWQM7qkpxU?=
 =?us-ascii?Q?cb6/gx0qeehoiFiDSU+ajIWeMSg3bcw278WJmLqeduT4QG2BFT6EjKc71Ld5?=
 =?us-ascii?Q?NhmpKUuLRJEVP6y/SqL1JyE2mLBimq1HReyYV7+xTduZ0Q9CPC08WyPQbBWD?=
 =?us-ascii?Q?JDxhEzJAtDAcRMcwpCIVYkcPd1dctFKSZDh3XUYtq6jXJiRNPJdDJN7JuA5x?=
 =?us-ascii?Q?DYJCW83EBQchQgCzAbZ1eoOc4cjaQbBKrtOhwP5sGe1KEAur51vmZLNb9Zae?=
 =?us-ascii?Q?zzvFNfD+VD+PNC3tuEy0uoNNYtNMaCtOO57ySPZREh2k0Kvz0/hlTEG7iqds?=
 =?us-ascii?Q?KvZT7Rqq+yCZVSrCufPjPR88wW9WW1V2Ls/JkLGiLEEM8Oa8XzQGmA0iyWd1?=
 =?us-ascii?Q?YI+hUIbS0m0t8oF+I1FM5fwAJwaVdxLKB8tXdwxClR6ELcplHBbRVfk0uSQq?=
 =?us-ascii?Q?eqlmP47IEALhtx7oNTcFUnInz3xYpUIirJuaLorprkq2AYwcc/Qvn8n4zDdd?=
 =?us-ascii?Q?V4Ne0n7fAF9p++2iC54auNwQUMAnxox3c1XdpFA0vh27JNr5Up5TfxU4N8xp?=
 =?us-ascii?Q?blR/kNt/8QClcUruOlHsewvAzCX1NU8/SqZRaXxP/JlKGftKoeYmDJD8mvmE?=
 =?us-ascii?Q?MjcJb+UkFtLzQDi3tUJz0BqpHb59fyyj2cvKn+sqgbyqiB+uyEagXzWwc9A+?=
 =?us-ascii?Q?1IVYeDwdoKYOh8DI7urMQBiGzvtGIulWMgu85Yujjte+z4stvOEt1uKotcUu?=
 =?us-ascii?Q?JjdHhgl3uioJAp3hhmQ6w3UCJcz4umSZfvO8HHOv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb43edd-eeea-45aa-fae5-08db9834b18e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 17:27:08.9078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+XGFlFunQw543fwgQNl/B/i95V0HZsFRu8dvS1i4vnNY7bODVm2RwpfnLJuqz1l
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

The two callers coming from bus_tye -> dma_configure() already have the
device_lock held for the device being probed. Mark this in the API so that
the core code doesn't attempt to re-acquire the same lock and deadlock.

  __iommu_probe_device from iommu_probe_device+0x10/0x40
  iommu_probe_device from of_iommu_configure+0xf8/0x1c8
  of_iommu_configure from of_dma_configure_id+0x188/0x450
  of_dma_configure_id from platform_dma_configure+0x24/0x60
  platform_dma_configure from really_probe+0xac/0x3d4
  really_probe from __driver_probe_device+0xa0/0x1e8
  __driver_probe_device from driver_probe_device+0x30/0xd0
  driver_probe_device from __driver_attach+0x10c/0x190
  __driver_attach from bus_for_each_dev+0x60/0xb4
  bus_for_each_dev from bus_add_driver+0xe0/0x208
  bus_add_driver from driver_register+0x7c/0x118
  driver_register from exynos_drm_init+0xe0/0x14c
  exynos_drm_init from do_one_initcall+0x6c/0x318
  do_one_initcall from kernel_init_freeable+0x1c4/0x214
  kernel_init_freeable from kernel_init+0x18/0x12c
  kernel_init from ret_from_fork+0x14/0x2c

Internally make __iommu_probe_device() require the caller to get the
device_lock().

The three remaining callers of iommu_probe_device() don't seem to hold the
device_lock():

 powerpc/kernel/iommu.c: iommu_add_device()
 iommu/iommu.c: iommu_bus_notifier()/BUS_NOTIFY_ADD_DEVICE/
 intel/iommu.c: probe_acpi_namespace_devices()

Fixes: a2dde836050f ("iommu: Complete the locking for dev->iommu_group")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Closes: https://lore.kernel.org/linux-iommu/bc5d6aa8-e8ca-c896-2f39-af074d55e436@samsung.com
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/acpi/scan.c      |  5 +++--
 drivers/iommu/iommu.c    | 34 ++++++++++++++++++++++------------
 drivers/iommu/of_iommu.c |  2 +-
 include/linux/iommu.h    |  1 +
 4 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index daa64dd687524b..3771164af60279 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1579,10 +1579,11 @@ static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
 
 	/*
 	 * If we have reason to believe the IOMMU driver missed the initial
-	 * iommu_probe_device() call for dev, replay it to get things in order.
+	 * iommu_probe_device_locked() call for dev, replay it to get things in
+	 * order.
 	 */
 	if (!err && dev->bus)
-		err = iommu_probe_device(dev);
+		err = iommu_probe_device_locked(dev);
 
 	/* Ignore all other errors apart from EPROBE_DEFER */
 	if (err == -EPROBE_DEFER) {
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 25d7327e8013e7..ecf61bd3cfb076 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -452,24 +452,23 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	struct group_device *gdev;
 	int ret;
 
-	if (!ops)
-		return -ENODEV;
 	/*
 	 * Allow __iommu_probe_device() to be safely called in parallel,
 	 * both dev->iommu_group and the initial setup of dev->iommu are
 	 * protected this way.
 	 */
-	device_lock(dev);
+	device_lock_assert(dev);
+
+	if (!ops)
+		return -ENODEV;
 
 	/* Device is probed already if in a group */
-	if (dev->iommu_group) {
-		ret = 0;
-		goto out_unlock;
-	}
+	if (dev->iommu_group)
+		return 0;
 
 	ret = iommu_init_device(dev, ops);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	group = dev->iommu_group;
 	gdev = iommu_group_alloc_device(group, dev);
@@ -505,7 +504,6 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 			list_add_tail(&group->entry, group_list);
 	}
 	mutex_unlock(&group->mutex);
-	device_unlock(dev);
 
 	if (dev_is_pci(dev))
 		iommu_dma_set_pci_32bit_workaround(dev);
@@ -519,16 +517,16 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	iommu_deinit_device(dev);
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
-out_unlock:
-	device_unlock(dev);
 	return ret;
 }
 
-int iommu_probe_device(struct device *dev)
+int iommu_probe_device_locked(struct device *dev)
 {
 	const struct iommu_ops *ops;
 	int ret;
 
+	device_lock_assert(dev);
+
 	ret = __iommu_probe_device(dev, NULL);
 	if (ret)
 		return ret;
@@ -540,6 +538,16 @@ int iommu_probe_device(struct device *dev)
 	return 0;
 }
 
+int iommu_probe_device(struct device *dev)
+{
+	int ret;
+
+	device_lock(dev);
+	ret = iommu_probe_device_locked(dev);
+	device_unlock(dev);
+	return ret;
+}
+
 static void __iommu_group_free_device(struct iommu_group *group,
 				      struct group_device *grp_dev)
 {
@@ -1789,7 +1797,9 @@ static int probe_iommu_group(struct device *dev, void *data)
 	struct list_head *group_list = data;
 	int ret;
 
+	device_lock(dev);
 	ret = __iommu_probe_device(dev, group_list);
+	device_unlock(dev);
 	if (ret == -ENODEV)
 		ret = 0;
 
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 157b286e36bf3a..b5b7d4bd2cefb9 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -160,7 +160,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 	 * probe for dev, replay it to get things in order.
 	 */
 	if (!err && dev->bus)
-		err = iommu_probe_device(dev);
+		err = iommu_probe_device_locked(dev);
 
 	/* Ignore all other errors apart from EPROBE_DEFER */
 	if (err == -EPROBE_DEFER) {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f1e18e81fca78b..cb4fc518797039 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -709,6 +709,7 @@ static inline void dev_iommu_priv_set(struct device *dev, void *priv)
 }
 
 int iommu_probe_device(struct device *dev);
+int iommu_probe_device_locked(struct device *dev);
 
 int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
 int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);
-- 
2.41.0

