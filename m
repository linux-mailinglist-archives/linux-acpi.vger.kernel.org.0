Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6EB7762C4
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 16:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjHIOn7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Aug 2023 10:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbjHIOnz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2023 10:43:55 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16A81FCC
        for <linux-acpi@vger.kernel.org>; Wed,  9 Aug 2023 07:43:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hcx8YrxNeOd5VzW3xP7MAkiLPMqF/ZFLQ92IykEWfrVqxCmB95P2Bwjz6pvCWMV9s4P/tjnNnfBpJCHYoW4BlUxiT0alJf0DJtf6FeujCZ8suBJOuaKDV02CvTAFUifNGSRWXrzEV5g57o90PytW3E7n0RsY44yf3MDtd+wL7Fe7ld3LLs7YVeX0EuC9/B9Ce5ctlM+y+VHUWlKY/CT+R/j8rs2AH2qV/nOWH8DmgJoAlPWY/evZ1D5fCajxS1je7xZkjTv2s6Zf2jmzDbByYrjMLKl1mullz65C0n/reBzJ2CNXPdPrOk5gwwwM53Twk2JDk2XPzvk6wJp0OToy2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkdAutco3x4EvBL+RjTWnfwUrmOSLLFpYQm4R6Yqqzo=;
 b=YLVG4fAF4Fj0jmpkE8rPOqmdx/10bKX0lfylqZEvfo/rA+5A3J+WihrHxVq/gomVkv7F/BoZw2CQh9GQHa81gKC5wubfWzQNb45bsiQJr53zxrMWS7/IhqR+D/ZC7Hyhs6hP0x1rmVEcjYW6qUEV/OsdAe+VQh8IPcAnJKLgwxTWgxoxphYMb9F3424L2LzEqB4VjQA4ib34VycchrD7eXn35CSFD0DqSy0aBT6WSvniNM0UnfCKv5aw8IjbxOSfX653PYtO05cE0vu4O+vT8z8iSIsNLold47UY/34oVigV8QdTDRUex+hBUGm2Y0kfPEQqikDxnZsvgeOa+KLBYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkdAutco3x4EvBL+RjTWnfwUrmOSLLFpYQm4R6Yqqzo=;
 b=BdXcJAXNzivp3xeFHvFQUpkrIJc1PFm8nDM16DFQ36YJZQpVAm9onYKhPiWlCDX6yK/y43pRY5zEO+VjE4CCL1V0BOh33B4oOFRu6xkkRN2rAZz2uW6hsevDZfYCL/21BJTtA/n1DrQVrdjMvUx0PH5CbzsaItDti+s9k/eUwALMKnNmAILJ7AFMsVkNswoR7T/SyzgdjMpPT06he3rXfPN4AuKejzrCbJ23blIkm/BCNGttXd0WeWk/kvCVwdwdwh8tGvrSJegLY2l72qvShgaFocGCK/Rb8qJ6sqENeGjNsxSv6y7QPywUl9KAYMXsKBxZ1vIBaDXZ9Twh/xGe6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5059.namprd12.prod.outlook.com (2603:10b6:610:e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 14:43:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 14:43:52 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v2 1/4] iommu: Provide iommu_probe_device_locked()
Date:   Wed,  9 Aug 2023 11:43:47 -0300
Message-ID: <1-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
In-Reply-To: <0-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0079.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5059:EE_
X-MS-Office365-Filtering-Correlation-Id: f4169639-b686-4252-041c-08db98e70c40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 88/uqWvUCZ17wtN9uj0Z3kPHCvetZAsrHq+gK+7MSZhRNaa6I9B84YQGJagVtuB9HO3fUlFSNkydRFPICEefFTOWaVQ+O5CBygUho4jHh+AWRTwH0NzpI8xSrV1V15WCJEEt/MXqJVbLjdO8eaEe6VJsJzsJAnj92WVg8ITzCX+x4m9tegHgYaMvjhcqoYWvLCb+cPzjYLchMTQEf6ThwKz+MMunDFgibXEyM8hKpO+50anKuO7BfFMlPTK3fb9nzz0995hoOgzTkTCYSF8qZTARN8pOpS9bKOIHaj2Ujt3R5OhzAZ8wqvtQmbsyewODdFxqRYPyu6RBy6oVIcTOOeRwWaMDwKSIr9XpSzm6Ul2Bi4XggbK/6XMMnSaMEOo7b8Yri9ZMbWF5iAXOjTgiFa4UT+zocj01jcMKPnVPQa9oCJzlnuINlw9kW6NH0CpuM+X93jscVSSwyj+gsevEFuKauio8DuCtTBSCFt2+Xpj2fCfMdfdHSe1McFH5436IeTEVHbGokHOBQosv8PfREqyUzYXaVpxQYOzqgvJYNXwRN2tHKzfp0VsHUjgC+qoqznD0yzhTHrp7vo6L7s8Wcf6PYiUVb3q3q2jFKwdKSyUAsURyvmH4aENK6qGwmH6YOsF5IxwOng6yNtlBfu86UA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199021)(186006)(1800799006)(36756003)(110136005)(6666004)(478600001)(66556008)(66476007)(66946007)(54906003)(26005)(6506007)(6512007)(6486002)(4326008)(966005)(2906002)(41300700001)(7416002)(316002)(5660300002)(8936002)(8676002)(38100700002)(86362001)(83380400001)(2616005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r2GhyyZrOG6vPPUsgYCxJxMNIx1G7GHb9AlGcUDDjiVYlE4A7K5cYedINmcc?=
 =?us-ascii?Q?nQws4hOXdNM3A/QgXQhUDtwRu9Q59uqi0mWZ9nCRO+FtcABTEurUfSE2KMKv?=
 =?us-ascii?Q?j4JmiRaPi2KBpeksCsetHMXplYsUfcNOWGv/GcCPgUal5H89bg2JOnF2S4TI?=
 =?us-ascii?Q?+V/ue17l2w4eHZ+dore2f8h6vGbElWifu8OtqqRyX7yMYjovJ37fx6j+hcGZ?=
 =?us-ascii?Q?+fC5eyP8r01lmNV12gPotsT6ls8Du1hfwfAtUUIGyFaD5s7TDODWDNV9+lJa?=
 =?us-ascii?Q?pCfNGfP0azK7jFiXio4vWbi8vp4OgN3ATgQAlbtUqR2S9UBRYDbnRoWTOJEe?=
 =?us-ascii?Q?vvDFzJ4VODiPgtneKdZqaqzV6Hbr+6znSGmycOiv0aZeHuHcXTdsS9uPrOys?=
 =?us-ascii?Q?op4YuLOM1m9F/cc5uQebTTtyroxoIEDphTAYgHXz1Whn1ZbITkjnOq+ZumFG?=
 =?us-ascii?Q?Tvf7spG43OhEKMJTe9gnjf2sL0oyovijXz9yPDK/820gubGGRBTfHiHzEPFX?=
 =?us-ascii?Q?kQY0gBWI79fBog+32z2YXKE+WiSKO+evgkjtafF9UgfW2xExF/BwT5tLb4uQ?=
 =?us-ascii?Q?WsULuoLb3lIUbAN5L3ykoIjFxdYT0VEoDbS76v3rnqmRdKczWctA3JvXjIx/?=
 =?us-ascii?Q?QjAxtE6oIufIwDZFPExGtwWX9sWYWjrJa5ee2xF4OJuB1NtKdzIUn17unHAq?=
 =?us-ascii?Q?VqLOCslZkSsll30pyCnfyrXzoIGb8JSxQ7vqfFGv/j5RIbBv/ErDxOdIqajx?=
 =?us-ascii?Q?VWu/jGQE5k5jUd7WKv0ToMCBKHfKiiZoj6Nzri3IO/6ZkV/5Y8DZEUzva6ji?=
 =?us-ascii?Q?KWZhAyM9UGfDA9V6F2U2GM3G/YcIZP8KXLTXlM0456PXAfRK1goMAg9mLSTS?=
 =?us-ascii?Q?z6pK3aiQ4d20DNzdUuq4UEMq3ErfUhx/va+/16d9gsYvEjnP3P9o2orf8/P8?=
 =?us-ascii?Q?ylfVyrG7vWOI7feQQ19NtUyA1U62zXkSF3OjCLN2sT2oDvj1P5l/L3anF5c/?=
 =?us-ascii?Q?LHMaMNYwWZWaZxaADnpg1MUM+N7y0AwL2ER4skJwYVtAUsZ0RTLoPVEvw8Vd?=
 =?us-ascii?Q?dbtGoLfKSNPh4N0QgywbN3yNxy57j8p8psJWGXYB+B0Z9LoSEu1au+bQBIAG?=
 =?us-ascii?Q?fqw+TcrGTiSXvIjqkCt/bn3HOqz8hWL8G8ZdcCL47FJHzR2nWE76zZml8QIP?=
 =?us-ascii?Q?eBnBjYzFbHGEaa/wXrF95hWNE3prioeZRyh2ylQKGMsWJi/36KsgSbMU5cjt?=
 =?us-ascii?Q?iyNwUrCTBMTvH0CvJWU60MqJzVVfGS6ctH2PSMvqkvPukqIqCxZY9JYC86O8?=
 =?us-ascii?Q?znKKFe8n+6HHPuQEeeYIkJO0ULP7tGWTLYIDiufqvhmYwOpjX6RV7rUVCuwS?=
 =?us-ascii?Q?+oRVtp1bEywPiiDqvp3Eap+zmoCiLSd0nkS0Y77oNEIqE962JkbkMz4JYRaP?=
 =?us-ascii?Q?A3Xq+t8Jtly0dD4j+rafxLwzz0PTaRJvee/n7fncpmBJmEVNtHrYPl9wA6H0?=
 =?us-ascii?Q?bcH5vEtXKCa8lVdPwTM7de5DpCjGrEG9VKivNJN2TV181w+TYylIc/hJ2b2z?=
 =?us-ascii?Q?Lwr9S1ZLNbNhJPhu12+KTk9cqoa8XGYMWwIrwPYf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4169639-b686-4252-041c-08db98e70c40
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 14:43:51.4857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NFf6o3AQ/hQH07ERzuWwVqp5SHbBMbTzhvxk8lTSXhn1Rc98JzLXKQ4PS70h23KL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5059
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The two callers coming from bus_type -> dma_configure() already have the
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

Fixes: a16b5d1681ab ("iommu: Complete the locking for dev->iommu_group")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Closes: https://lore.kernel.org/linux-iommu/bc5d6aa8-e8ca-c896-2f39-af074d55e436@samsung.com
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
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

