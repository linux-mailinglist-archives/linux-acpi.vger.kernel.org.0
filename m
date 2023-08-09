Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01CF7762C2
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 16:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbjHIOny (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Aug 2023 10:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233915AbjHIOny (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2023 10:43:54 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE7E1FCC
        for <linux-acpi@vger.kernel.org>; Wed,  9 Aug 2023 07:43:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJJOfhiHmBYYie9s8RijIdLy4z5qgrS6Y/1E1aAZ3RD3wUdEh151pfz3SLcAXREbIu4CdtUg4Of0Pq5V/ZDI+I6hO2HBvJgS/ZbiLiALi/BsmxyVPkgEcI10lH6CpXx0gNlduBZ3i2KnJ5EMI4+l9ITc6E6Uneg5DGam6p/CD8hoqAyNKlXg2atH4T3x68cXag2D9rQz827d4iaIOfLWtBNgb2+BTaXZiIXNh6r/C1hc2OH3/LWQZ9pCw9E1HZI0JhwsGNR7ECKVwjGJnqcpLrU513r5we2LWidEmrzCVnccU0gOgERHPgTn4E+oZHYzLO5XzL7Y3VGl/EDgS69v4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06Yo9x3XaDiNwBSd+cBJ+EDGP18o813wTppg8YKH9eE=;
 b=JeI9kM3KAuMLSXF6y5uK46YjZEmEakQSu+tFQWNbCz7vj0+WhrYlYr/v7nr7okwM/M51qPiK9jhCf8CVzE3Wo690ngyrgzLpOzxq/343oWsvxFKApF+SeGMu15ta1zAC+UTX1S9uUMIQzvhYuuEB9nhXhpZm5wcQeyyZkZWAjT6TjnxCbxhctMzhiONYW5mfW86Kr9uD7HgMhipn+27NDIwK5fkG0xTba7wB31Y8OVnC9wwVUwFxJpE0suYZ9wVozlN62sNx7IPffCEJmSaXK23krezLEjuDHBRGn5vq9/wNkYDHSsc5zkmi/xJWjsHaBgPKS1rDobAyGiEznEhEOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06Yo9x3XaDiNwBSd+cBJ+EDGP18o813wTppg8YKH9eE=;
 b=QTTHkOnmE+eCtQ4GCitVQst0wO9FwprwjwzqSvK5t/lHeL5jG1Ts2hPyhgi6D7sUXZawuT9sKk4V8xUklUo5mNoY05AwA/pmxQ3iv+nbW+wgSPcDrndF9vyRgxcBiBZ7cOj2P8Ohn1OvoLIiMKAhZWm2tCIYZvKSANrVvTq3NDOHy7UI03EB1csRVgazQdglmgwAf2sZSp3ytSnLH4zr5qze9YUf87G8xiYLcKyQ68A2DGZMTp+m1PPrisEmayhmTTXmmmML1Mx86Da3mPObK+mLMQHVbV8fldcFtzMnbfNCZbI8U6uxJVFVzQWjXgXeWlTOT+RhigxI/cJE3KY0PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5059.namprd12.prod.outlook.com (2603:10b6:610:e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 14:43:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 14:43:51 +0000
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
Subject: [PATCH v2 3/4] iommu: Do not attempt to re-lock the iommu device when probing
Date:   Wed,  9 Aug 2023 11:43:49 -0300
Message-ID: <3-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
In-Reply-To: <0-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0071.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5059:EE_
X-MS-Office365-Filtering-Correlation-Id: 8920be56-5cc5-4eb4-30a0-08db98e70c09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SHKNJPO05+5qI91u47DZa6C7KI/iR6oV5Li59+fYa2lMmlCFR/7YAlv79gYLVv7upXZgswaeByYw9srQS1sJ9nc/HHmtr1Dsazl2Ff2h81ly0GBev1BFKZA3zpNNBKhqJjAIMjvF4tJ7EjDMTrfMu84nI9irPFWOqYPmF6HQ/YacGhICWl14XAnVKH85j8bbCwSnErzMZa8wFBXcQXYF3KDO9zhDi4lZpYIrRIAlZNYFOrn/yiEmUk6bkPyWgBCCEKpaN0NcpYpLr7r6PJ1ZCv3A4MWrH0aYjdxncseMPjnQYa9MomF+j2xaym+lE1nj7UcmHruZCkKw2kHxARhOP8yJtLKMIxzfRlJT9sSZ0Qps/quptR4DKhsZ+l7NRjRTlkU8U9hEsLH+841xpp5ndDJM19OD4taxHZhOJ/+in77l23PdLnNGIHkry2TO+Ke8crefGChVZBTKXaewIvDBwHYcVmlPKBOxG9cSUrn7ARvWnQnepLxhe/BHktiL6qLA7lvJnZ9FdNVpD0Hwrrhjpciv8SOSClMixCIdvqQSlIHU900bnLhkhIRFjXALCtwqnkvN4ICw9qVi8o8CirmSxZK92SUXMlxndzrJmckZd54BfcXobbVdXfsuCDrifKS5wi10Kw8iHu/cwCGnxIcGew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199021)(186006)(1800799006)(36756003)(110136005)(478600001)(66556008)(66476007)(66946007)(54906003)(26005)(6506007)(6512007)(6486002)(4326008)(966005)(2906002)(41300700001)(7416002)(316002)(5660300002)(8936002)(8676002)(38100700002)(86362001)(83380400001)(2616005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K5shcIF1KdStL7oG4w4sfRnAB1qzsXr/7yGC/1LBDbERIaMOv8gJMyNsEfFP?=
 =?us-ascii?Q?spoVcpApdd5cxhPMwGtxM0LfAHnozHz8snRH8DXxVCj5XO2ndvirERXkTkNo?=
 =?us-ascii?Q?Ow6pWMK88BvDfoL7hVMWaOo9Ekc6swvUawYVssCo7mILTF1ZKIJlSoQcFfVy?=
 =?us-ascii?Q?W9hDMKhNc+FreyATddWcMU9OXNQjpMWuTGJqL31wb5KKoHRlsjdKaEy2VIev?=
 =?us-ascii?Q?2EMiO4mS6DY/LYR79g4tdOKSjg+/hv8yw/L2deshOEIXzz01kpobY462G7cy?=
 =?us-ascii?Q?7rkHD4rMsoowgW2DEi8htyT1EXNXp/cCWsCQbdvu5Flsc798f335s8MNuSpm?=
 =?us-ascii?Q?6oOYat+N2eehlpfzdxHJj5Ws6Ia3uuQAxe+KRDOkx61zhUd87t7gvVFcDtOU?=
 =?us-ascii?Q?JmmqfS+ajSaP4ZW8o/rIcjDQ1VdcHT69lCU84cRVBUEFdemNqV8ylnHR1vhe?=
 =?us-ascii?Q?uW6eaUdwxdpwnV1lx42Ajs5EE1acNihjGgakkn6U8ZF1DA2ElcMX7q0EPHSb?=
 =?us-ascii?Q?XGW5so8hf+9Jr2R5kvQVln6nLf487usHXmdReG/uJkqGTGbf5NUHRvtqc75j?=
 =?us-ascii?Q?IMMkNWZAS7374H/fX3mS9++43am87dif7Fr5GuSXV1fT2Bi6Xt33UIv37JPX?=
 =?us-ascii?Q?f9Y0+X5B/GM0RAi/vnbLcxzMCDY/V5S3g3WmOEnmxwKtA4AEQ+OPU1PEZt3u?=
 =?us-ascii?Q?55YefmzMINnXu+qU8MsumW9aOo/uiWRkV5SoLhd7VzSxSrARd4pCVHkWfUmZ?=
 =?us-ascii?Q?x3VzP1bcPkBqLjFG2vu3gjdlSZHr4H0pVtCX5+iajTpLBzofBxEtqcXw3o2j?=
 =?us-ascii?Q?5x/aNQsJ4jKeAGcDOWR1h+aKOjWD+uadXa1YxNovyi+U5oChVP9d2vVz5Wab?=
 =?us-ascii?Q?vSIfgOLHstw9S6awibc97jR5MJGnuekYXwYHwCIbcKZY4cUrZZo+pdzR9lee?=
 =?us-ascii?Q?bey/ZGj8DfWRfKzjc0mJkby3fsNcOlxQud4G7vzTpzgPajR3oo29zOyFcj92?=
 =?us-ascii?Q?i6hkCs4Lwzp9SgUuhHQ/FRqbBFDU3qc4NGE4WkmavOcXfcpm6VaEkOTXKfao?=
 =?us-ascii?Q?ELDHuCUrgjnujWuUsIdYOm8GBPJE+VT/d+v0639TODUBx67dJ8pIH8o7RzgI?=
 =?us-ascii?Q?UtbC6iERvSz6YWs5+C6v7RKvx62WQ7y8RsSpT9chaeIif9vF171tlbNe0/C8?=
 =?us-ascii?Q?/VHXrh25idq+/FbTZWS20Pq9BtnBangHnXwD8Iz07jexYVe8vI6Fue51hefA?=
 =?us-ascii?Q?IRRTDOdCQutw1f2Tyd8kULEKTZkaNtzABqX7TqgxailX56MBhhkWtwR89tiy?=
 =?us-ascii?Q?saGPbA7rCQypjPkXHE44vWAsGnlISMP7TH4lyu1iBFrmxpBQ5N5WRHYB+81z?=
 =?us-ascii?Q?JakLSLwYtk9Mpanwn1V5jAT0DrC/w62SqaWslvsPw60e8GwQa3tbkgl1g2VN?=
 =?us-ascii?Q?rGsaqUNsxVQl/kP3JSwN1dP2JLPWAdSqqaj3e2NrnU5zWJrr2P87JQKpcQn3?=
 =?us-ascii?Q?jyKYIEjjC2ziF0O+mpW/vodbMKrRGqwJONsLZ6KhF/3GWWqhXtu90VF0663I?=
 =?us-ascii?Q?1+ptLugODIBVb8I6MOv0iN5YqSD16WtMIDj+iJDG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8920be56-5cc5-4eb4-30a0-08db98e70c09
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 14:43:51.2057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9W1GpR7/spaXVUxjSDZG3WTqeHKu1RhRlFn43IUVP91iUjgXw9FfpdBnYRG9j4p9
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

Fixes: a16b5d1681ab ("iommu: Complete the locking for dev->iommu_group")
Reported-by: Chen-Yu Tsai <wenst@chromium.org>
Closes: https://lore.kernel.org/linux-iommu/CAGXv+5E-f9AteAYkmXYzVDZFSA_royc7-bS5LcrzzuHDnXccwA@mail.gmail.com
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c      | 10 ++++++++++
 drivers/iommu/omap-iommu.c |  1 +
 include/linux/iommu.h      |  2 ++
 3 files changed, 13 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 19fdb1a220240f..3ff365c9117850 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -264,6 +264,7 @@ int iommu_device_register(struct iommu_device *iommu,
 		return -EBUSY;
 
 	iommu->ops = ops;
+	iommu->hwdev = hwdev;
 	if (hwdev)
 		iommu->fwnode = dev_fwnode(hwdev);
 
@@ -1802,9 +1803,18 @@ static int probe_iommu_group(struct device *dev, void *data)
 	struct probe_iommu_args *args = data;
 	int ret;
 
+	/*
+	 * The iommu device itself is not probed, in part because no sane iommu
+	 * should self-attach to its own HW, but specifically because we already
+	 * hold the device_lock for the hwdev when calling here.
+	 */
+	if (args->iommu->hwdev == dev)
+		return 0;
+
 	device_lock(dev);
 	ret = __iommu_probe_device(dev, args->group_list);
 	device_unlock(dev);
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

