Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78CE774472
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Aug 2023 20:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbjHHST1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Aug 2023 14:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbjHHSTJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Aug 2023 14:19:09 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015F0852B1
        for <linux-acpi@vger.kernel.org>; Tue,  8 Aug 2023 10:27:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZa3Gtr9klBKF84zDDPFcBr2QCEy6A++bQaE7eizY04ukcWpP9VfTg9u/5KnFoL/Uo3nwhvtJZfnCdVTN1yl0Z206VsMAEJiWKqhIaoEIZQ8wNZFVuMfRGU61pQBQxt5z50vpcVZC0MTXok3AOeWR2XSXUblGEYO2aH9SPKD49ttDMQQpkIulKwxY15z4Z9Jjl5DUwxEZ7OIZGjrB6h06k9iT29oU1SnzdVChCTvJiNtrQIQrvyNOAQwgoaen46gJb6ESi8ZaaDc/GCMYEIeEK6cOA9nZzoPboLVmpGcOtBbeBky79K7QeqHooh6v+Yzf8Zkl++52a7b0BbWkSSXGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLYcctTI3W8ECGsmDfLND4gLJA5z01Ug3vcDrYWTKLw=;
 b=iTK1on2CyoHYOMshIpD81lVriyvW3fQaoUTUTyXV8Yorjm0vKRKB3ARpvF5N/ls7DhlOCXltBoeJoW9esQFrHoxr35WZGQqEn7pOIoKkPmq7DJ/O5dnp7bxxU4DJQ39XU+Km2QRxlA1Mgu48piEVER+TQqPoJpHWteSQxmb8HZXoi4Tm/VxuUsbvIiTviO/dDbvsBNccmQtyVnoGCaHAHFEA9uwH7+kqUXSG03Cnori0PqDfuk3HlAi6Z+HjeAIABqeMrA6y8rHQzbKS99CZC0ivMtlN0yC8fbKqyGzhC7cY6s1GDbOMoYpeW65WC0U7VrG1oFXzmT1ukWl9sKECEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLYcctTI3W8ECGsmDfLND4gLJA5z01Ug3vcDrYWTKLw=;
 b=FuHFimSP3b6FdV5OB3KwLJyKlha/UGG3BGPSFQpa5oAP2XXn00RfzwptyczarNEzjrphMLRcttcnzvfEKIqo+92QeaoikNVxBgH3utg6Mf2YSKrYtsY2YKudXOWVcUC+06BEjnq635ZmLi3KiG/GNvMqDCYJSFM3lrw4DdTfvrN9sA1BYFwd618X1GvVWo+CAPVFsZkb/IpQBCajvKxYHwX3+6zmvSXrCxvvgmXgiKUrqPzsmVNoaZZrbkbrYu01aef8Ao8tzwy4+PJYtPgDHVZ3hCpK+n6FUHAvgOKK1lb8WAkeY/2NT2GPbqFHxi9Z2LRLVkWk6hAK08WzVJbz2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ1PR12MB6361.namprd12.prod.outlook.com (2603:10b6:a03:455::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 17:27:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 17:27:08 +0000
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
Subject: [PATCH 3/3] iommu: Do not attempt to re-lock the iommu device when probing
Date:   Tue,  8 Aug 2023 14:27:07 -0300
Message-ID: <3-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>
In-Reply-To: <0-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0146.namprd03.prod.outlook.com
 (2603:10b6:208:32e::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ1PR12MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: 91590f3b-8e48-4762-d9b3-08db9834b149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oSv73DoobQbvmg+d0uDLk1I6RdD0hN03w7dLmqbJDsP0KlH93oiGhnLyLiFVpy+oXIGIUoicE+BTcg69dLMVeOI9UsHJFteqgQ9LcwuOOwB/bYiE99wrMth4wJPShgfUn+dMXtWP37FFhJdul/CQ7ZLuBgpbA/FotZolDPPETAPw0x2JHYDMxiQpqhHCEFkgOMqgOmhZUZQXzUqLu3dfIsVN85cDw1tHzAyZEwhNSqFKWjeCR3vNj6F5eIgDL+cqjCPv7ZXvnX8zkSkhaqj8q/4UaXE/mf4sXrtsGcZk8J6qUK6tgNkSkzJtEKVIa57/2XgRtr9tgu61FYMEYPA1+sW8a4tnA2Zm8SQYvWIV42aospqJ32Aqg7l/6b+nVkpL/HqF7ZHQlv0qrgykkgzkFeGVBJCZmlAgqpG384loQXotEzwj7SlXHe0bPCB5QDr67Fz9HKcHIi2epDNvV7wFNxzGHz3psmUOkoYvMTcoaSsnXjbRaLGM2NO2qEbSXjjxgUJrCcRwJJnMtDJKjV+hQFiiNr6iENJCWQthv9datKOTmlXxISuhlR9mixDbEYZ1a6k4Rm3d/mRgMPkjOFpVTa7sk/6O3LYdostYn5c8YDrpZOQRmPg30uPzNKYWLTuwr17nvBgg0D1D53onOzPsAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199021)(186006)(1800799003)(2616005)(36756003)(6512007)(966005)(4326008)(316002)(54906003)(86362001)(478600001)(38100700002)(110136005)(6486002)(66946007)(66556008)(66476007)(6506007)(26005)(8676002)(41300700001)(8936002)(2906002)(83380400001)(5660300002)(7416002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XZHIeeg/GkD3YsqvcGYze99VfHVuivJXCBkrz2zDfWz/m1C6abmnE39feM+h?=
 =?us-ascii?Q?AFtkucRFUA8qjTKJUUA6trMj+IFUbpuEz7XGlznUW6NYUIyXmeQqZ2YxXdGv?=
 =?us-ascii?Q?hgv05KUzOd2WSoGCrnfRnTfidY4d3wkbi3xwiq78ymn9OiZpnTVXxShw32YT?=
 =?us-ascii?Q?LyELIalzp3OtZn3FB7t85RQTI4vNgOvupokKWSObdGSLP6YbIprnAgccwJSo?=
 =?us-ascii?Q?8y9Y+/X/C+wsaT0r+AZL6w2Q1r+BjP85IVquYLiuICndgRzXG22fzQ64MBK6?=
 =?us-ascii?Q?SgEWZ9+YnhRF5ZLmykGppJsBDd/4pX3bugIAoU8L2wSJCfUNeT3OOAph3jU2?=
 =?us-ascii?Q?6c0W6COjheNK1eD+Mlkv31kjTNgdMWQ9+Kp2fZ522wSbG1MnXHbHgBWxd8XI?=
 =?us-ascii?Q?HaaVUb/MAkf5FaQjEag1/0htxGXIyAF2AewhJ8hSNDGeBk6clszDrrqHPTdi?=
 =?us-ascii?Q?/W2jpOB5BMrG3I21zJlDxC+jgTpU883cnhtj9SiDBe+uQb5U/wd52GMx6hbx?=
 =?us-ascii?Q?fbMizKNHjc7u4YnD1BMS+c1qo43s/Zhkk7AbH9MxZ8GLX6qXjERculn3piwJ?=
 =?us-ascii?Q?3iAfrymzWyxkppmn3nNqlEkfr0tOdvh+hpVXQ3ERuv9Xn/b3X9Bl/eybSFaD?=
 =?us-ascii?Q?GQbpYJo8ASwSxublcrDqsGkUqCWwK5wQ/sSoUhUHl07a/rov/gggK0dxovbt?=
 =?us-ascii?Q?pe0/Q5mOM8YB4z5U9PgWQnqR8M9+PJfoswe7PNHSb27yYsSy7cRDuqGrMaIR?=
 =?us-ascii?Q?0Zeeak/0vLKZX4pkTGsdJrydDiRJn6Wu6yOLKXf8Lwj9fSTO+xppryvItaxQ?=
 =?us-ascii?Q?FR8AmG4M2xzFPgpdcz7D3tAuC74tqfdEZsbDri2NTgqj6KT27lQQevD8g8Di?=
 =?us-ascii?Q?x/MfeOYg7BLkK8iLIivikvpnQYSsdQBtUruyrD0FDmO2QPZnTkJPLGt3PVzw?=
 =?us-ascii?Q?ryWggYqVeTvNABfN+HyyCXR89IRKo7jXOIIJi0icb4bsK0cskUdhLuwtA9EP?=
 =?us-ascii?Q?9kfwOHLGf843dstEZ0mnkWLBIjiTo3jJaa41HlFg44lt29TQVjBeMnQBuxZe?=
 =?us-ascii?Q?R6z758LxWDRslHwq+SF5q5nPs4fJQHwTUMLIuqcF8o1iiPMdtetlrgKQ2Aaw?=
 =?us-ascii?Q?zuT22gbmt1u5wl79/FujPXje4HFWpiOzh9is8Qp6NgLSgyO3wFrzErdKUebt?=
 =?us-ascii?Q?aTEowC8uPlWlKU9bTeeuPwJuMpSGw9jt8X7mCcU+0qbyv47b/82pcJAvaQd0?=
 =?us-ascii?Q?xzE/V9fHHPe6GTuWfNEK9iFbWazSeyk7JWXLIqtPJsFi9Ek50SqUFGRW93VN?=
 =?us-ascii?Q?tJORZ0/OcRqPSyOqvt0nXjUGB6xRmR0WCoiVMhvebqxRZCsBu6sXFyCQ+E41?=
 =?us-ascii?Q?IQPZHYuvFA6r40ZECdz1FVeYtmEo1+HfR06eWVaTwCfdTzqrwVEyseaJgChE?=
 =?us-ascii?Q?TyKyO5RiDQBqrOKPSioC8jx7GRB4ISRrIn+PNzN9jWp7sI+rS042W8LRZIBq?=
 =?us-ascii?Q?kA3N/14drYDEqSTlTY/t4AskTgR5ks0qAf4MD5Q8iGRwSNk5BkzpKr2hLr2q?=
 =?us-ascii?Q?HYmyrM+iljREfRj9pNzWdCoistgOdNANUG7xIrzZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91590f3b-8e48-4762-d9b3-08db9834b149
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 17:27:08.5323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6UE0AyVOna9e7P6k555WdOqNPirp2c+guABW+l3280dbiNUEb3UqXtSbgD22twk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6361
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When bus_iommu_probe() runs it can attempt to probe the iommu itself, for
instance if the iommu is located on a platform_bus. This will cause the
device_lock() to deadlock on itself as the device_driver probe() callback
for the device calling iommu_device_register() already holds the
device_lock():

 probe_iommu_group+0x18/0x38
 bus_for_each_dev+0xe4/0x168
 bus_iommu_probe+0x8c/0x240
 iommu_device_register+0x120/0x1b0
 mtk_iommu_probe+0x494/0x7a0
 platform_probe+0x94/0x100
 really_probe+0x1e4/0x3e8
 __driver_probe_device+0xc0/0x1a0
 driver_probe_device+0x110/0x1f0
 __device_attach_driver+0xf0/0x1b0
 bus_for_each_drv+0xf0/0x170
 __device_attach+0x120/0x240
 device_initial_probe+0x1c/0x30
 bus_probe_device+0xdc/0xe8
 deferred_probe_work_func+0xf0/0x140
 process_one_work+0x3b0/0x910
 worker_thread+0x33c/0x610
 kthread+0x1dc/0x1f0
 ret_from_fork+0x10/0x20

Keep track of the iommu itself and do not attempt to relock the device
while doing the probe_iommu_group scan.

To accommodate omap's use of unregistered struct iommu_device's add a new
'hwdev' member to keep track of the hwdev in all cases. Normally this
would be dev->parent, but since omap doesn't allocate that struct it won't
exist for it.

Fixes: a2dde836050f ("iommu: Complete the locking for dev->iommu_group")
Reported-by: Chen-Yu Tsai <wenst@chromium.org>
Closes: https://lore.kernel.org/linux-iommu/CAGXv+5E-f9AteAYkmXYzVDZFSA_royc7-bS5LcrzzuHDnXccwA@mail.gmail.com
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c      | 12 ++++++++++--
 drivers/iommu/omap-iommu.c |  1 +
 include/linux/iommu.h      |  2 ++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 19fdb1a220240f..8842f4975ec4a8 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -264,6 +264,7 @@ int iommu_device_register(struct iommu_device *iommu,
 		return -EBUSY;
 
 	iommu->ops = ops;
+	iommu->hwdev = hwdev;
 	if (hwdev)
 		iommu->fwnode = dev_fwnode(hwdev);
 
@@ -1800,11 +1801,18 @@ struct probe_iommu_args {
 static int probe_iommu_group(struct device *dev, void *data)
 {
 	struct probe_iommu_args *args = data;
+	bool need_lock;
 	int ret;
 
-	device_lock(dev);
+	/* Probing the iommu itself is always done under the device_lock */
+	need_lock = !args->iommu || args->iommu->hwdev != dev;
+
+	if (need_lock)
+		device_lock(dev);
 	ret = __iommu_probe_device(dev, args->group_list);
-	device_unlock(dev);
+	if (need_lock)
+		device_unlock(dev);
+
 	if (ret == -ENODEV)
 		ret = 0;
 
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 1e4a90ec64322b..20fcc8ebab6ae3 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1241,6 +1241,7 @@ static int omap_iommu_probe(struct platform_device *pdev)
 		 * an iommu without registering it, so re-run probe again to try
 		 * to match any devices that are waiting for this iommu.
 		 */
+		obj->iommu.hwdev = &pdev->dev;
 		bus_iommu_probe(&platform_bus_type, &obj->iommu);
 	}
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index cc47e4086d69ec..96782bfb384462 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -361,6 +361,7 @@ struct iommu_domain_ops {
  * @list: Used by the iommu-core to keep a list of registered iommus
  * @ops: iommu-ops for talking to this iommu
  * @dev: struct device for sysfs handling
+ * @hwdev: The device HW that controls the iommu
  * @singleton_group: Used internally for drivers that have only one group
  * @max_pasids: number of supported PASIDs
  */
@@ -369,6 +370,7 @@ struct iommu_device {
 	const struct iommu_ops *ops;
 	struct fwnode_handle *fwnode;
 	struct device *dev;
+	struct device *hwdev;
 	struct iommu_group *singleton_group;
 	u32 max_pasids;
 };
-- 
2.41.0

