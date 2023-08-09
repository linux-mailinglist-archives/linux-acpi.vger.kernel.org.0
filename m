Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07CD7762C5
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 16:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbjHIOn7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Aug 2023 10:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbjHIOn4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2023 10:43:56 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CBD2109
        for <linux-acpi@vger.kernel.org>; Wed,  9 Aug 2023 07:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ay2aytO3Y+l9XIYpabhOnfQHLC8tjvrum0T11ChZ5IRgr5fGeUyGzJxgcPwiZ/obOECzmZ5QoX5qdnhVIr7Ii4bq4gAwCelsKraA9f7fH93wL7ts8lgKXb0Kn/zy5IzrRNmty9ZrE4xd3CS2uvYRD08u6B6vla+wzDTyIg/AoRwAVv9tpopJ0R/wVPcU72DmQ07ClJ8rpzBwonSM4N7TqCXG9ZgOGDZm5zcf84//iqaoBgZlhB1/WlTHImc/f3z5AafOn9kVPgV5eELgLkzQ19nDBLdz53TaxVF7dLD1FKzTf9OXn2Ibe/HwDf4gWc2myV4RtPPRnSc0oikUWFd1hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKAR5bavY/ywkaKA+NiyFP7gx3dDXMGnoQA53giOlzM=;
 b=PMC7svhLuAprcK3MWOConXw8sBaUd4GiiGVQKzFAa8TlSMIY5ihcrGJBdG3vpL0tQvh5nQyh1ZMu9RbX5vK6mjnwavts4NBEKdLgSS4c2b8UQQFvnJIhqm6/n0ZBCASHECbvaOJ3ZhTjim4TpTV65D3h87Cr6wpET68VgsQhildb3xhHIAq61tft7GwNXmedaOTBDAyr7VwSAc0i9j1860TfNUrYAQjehrnJzWKG1s62/ThLt1TQlUn//gTnWf8LbSxg/pApar8UluVHsoDbpbngsOIfNo28sm+bF/HEPgmPYAuNGmpbTKqJ6pP09sIE2hcMHp1iubrg7AKKyj97fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKAR5bavY/ywkaKA+NiyFP7gx3dDXMGnoQA53giOlzM=;
 b=HwwpwnuTp1Lwx5oLvwrdGN+Iv747zu8ol1UtDXHZpEtDq44xt6ycOeKh4PnPLm9ipFvvNfsUMG+OoalNH6RtQGw1T9r14Uy4E4iPgV6ks3sc+jS07osC8ropQSyzk7fbEyZ4oOR3+vfXICO4Mu6o4FQ9PgnSuOkANZAS43wpbOx6756CfC2NtbNiBuZ01k62nfr7JGgfvxcg3KOtRkzB/8+eazeYCHEgdLhtSG6Z7et5RgxwQsGGz7XMVAtD5hD90ufKPRvkrdCb8s8mA1fdDQsFg9EWrU92mYzMCy1RN5b7m9sL1sRUesxmxwYASVMg+olL/bJ3/EVklx5rFAfUmw==
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
Subject: [PATCH v2 4/4] iommu: dev->iommu->iommu_dev must be set before ops->device_group()
Date:   Wed,  9 Aug 2023 11:43:50 -0300
Message-ID: <4-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
In-Reply-To: <0-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0053.namprd15.prod.outlook.com
 (2603:10b6:208:237::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5059:EE_
X-MS-Office365-Filtering-Correlation-Id: d72049bf-cca0-4a77-014d-08db98e70c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fp8z0J7rGNQnGVqEgaZ3pJf+Hkzi5KiYVBL6hTPPoY+fPHVmat+bRtJWXotIKbRicWpwdM5/GxVCRk9RYLdXWOZL4sa271K9y/0stU2D5wDEsWv08aj2hHVVkAXAHNe6xiXMV+gVs7XcJ0lV9KcNmv9juWpEimxyODICh5Q29UojWmIYy7y55do3o6P9fvLcuCjU3+p40Wl49Rqz/KhEAtVG/yi9dASzalklR6OmpKR3Bwz2rH+ZFAkO/KPE3slF6krcdAPS94oSv6PUy4Rgc9Kdv48/Q29Wv7ma0deKSN49X1k6Rc0R5Fjmws0ZUXNXJC6mHp741hXVCfZRZSPrEnjyTOKDxlpCq0OKAc7iTDGeyW9eXyYRNXqWNGSfr/qqyyHcud0GVuQk4BRC1qEmDZH3MBRcQGbwiZG/J3xW3tN/QBlErQ7LnFjsEAzaSfvG2W+UtCIOZ7+0SBdKkbHuYXlTKMVbT4j7GKEs8eb7xBS7aNbHfF3cCY17v5y1KDI0EjZqDR2etLQu3FweHB+kH80tlDhqCS64293AZfQ7Kk13ca4+9ZkvgmyA7cSSmU+baPTsarhWTDDcOPRh+TP7ajFM1JlzHSJH1MZuwvFEFIyGiT31xtDWK1OqlaaX3kRSJXvZTsU7XcmLz9Ee0q1EAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199021)(186006)(1800799006)(36756003)(110136005)(478600001)(66556008)(66476007)(66946007)(54906003)(26005)(6506007)(6512007)(6486002)(4326008)(966005)(2906002)(41300700001)(7416002)(316002)(5660300002)(8936002)(8676002)(38100700002)(86362001)(83380400001)(2616005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VRCmXIkVeEqz493JP7LTAOA6nCRX3l61bk3Cri+kWEKAF+s5OXFhYSCPf7tS?=
 =?us-ascii?Q?lX5FhmQ/kYfyBh7174nTFJAOU+e1k6GwIo2iXjOb4mvSYUkC87Aiu/yRCCiX?=
 =?us-ascii?Q?NhylKZWTIVPxJssS0lUQcDPfuZq9iZfdaScbOJnaRZ9WAeKIIbWbXkY3+b6f?=
 =?us-ascii?Q?MSY4oQjXG436gD4YmvW7j2KaywU738s3UM9xVHd7CKxhT+zR8b9rxlvWnBFR?=
 =?us-ascii?Q?sGSKeDwMKH7kT5I9TFSaq14zy/YDxQHpQxJTUCFIOv4q+D2xSbbG6RfevhG4?=
 =?us-ascii?Q?BEk7Tf9Wc2eyxri6RixiAUjVz+69vaJGxUzaa5cPKa/ZeFCcaUgr5nZqfPJO?=
 =?us-ascii?Q?h03+3wfpNQVaWJpF7u+l1sYOmnTJSRk0pBowQALtBOeQljBlHoVKLYBhGLHU?=
 =?us-ascii?Q?/WQFTqe/uYVrKJ81tEAX8Y7HrcgNnOueOW5RrA8s9SAbirXo3NgGNZfeeYFL?=
 =?us-ascii?Q?gRs/WEndKMU4jfv4zuqtCZYwRNVZW5Em1/3baTZWO41CDbiBqlWVczfpgCz0?=
 =?us-ascii?Q?VECayuPLlwDF8bUoAy3/3s/VoiBuHphBYNmw300pl1bkRSWVCnt99OiDW3lG?=
 =?us-ascii?Q?ViPfEOP+/naSgGpUsYEB7Y7NCasrcTQ+qSSgvm5HRrjmqinQKJHsqDT71+3K?=
 =?us-ascii?Q?LenNE3xfDNpn0Qk41IjNObHSuJe6aLt8Dv7H0VEfqGrH4YwV5vUkIbkkpVla?=
 =?us-ascii?Q?RWVF5LuIXfic7K0ndXNT4Kjmi+5bx4WhNbo8IEyR58jSoz1+QhS5dHsY1RpE?=
 =?us-ascii?Q?puKrF0seyvevjNGZiFJiMtG925K44RtLU6hLEnBjRVZWCgEOtqHwPAb8pvnR?=
 =?us-ascii?Q?ryJ/vJDgZTSwsEBxVRrOVmmub9IkVas5S3BhR2quVrqG6UooQkOvsXBiYW0z?=
 =?us-ascii?Q?hbdOExc6ZS1Yi20DAOkIbKFJcrby7iohB2f1KRqqRYiP7rxVJdTw8gj1Y9C6?=
 =?us-ascii?Q?pxD82VGApYNQVb7cdhXzELY+fAoEdhrjj//7qS6azDSN/WurL5GR+5wpwH1a?=
 =?us-ascii?Q?e0j/Tl2IguefVNkHp/Me8y3iw6aQf6fUtDOfKtWwgslx+JNGPj1913wov9cN?=
 =?us-ascii?Q?lemsnofV3m1Uzyya7n7zLSGD0I0WieAenRJQkY+E8jI6hj/CaqR3wFtUUqwh?=
 =?us-ascii?Q?OIA6cNOtKexpLXafHoiPKLJ7puAXc/1vC0QpGxqxX1HiMJcKNVEeGQYe2edy?=
 =?us-ascii?Q?oIzQ+M7VKVDOszqy8j3qtap2xbuBsUFr1vMKd9mw1O+arWEfLbV8RrrWh2C4?=
 =?us-ascii?Q?i2HhNrAWhIfkUoek+N4FZ3EcuJrK7LtNkUqhgf974MItaMrrqczX0nLiPkgB?=
 =?us-ascii?Q?zyrkaDEBqsyFarQiOgH+GKyD5I+AX8ebng5sz7BUWGaOwJMgnFcjjSFSQ0L8?=
 =?us-ascii?Q?HkMaVhgbxnTJPLicrU278sXKIWH5bjD/yZjmOxus5Cp5Pc3B71CMk5YeisuQ?=
 =?us-ascii?Q?XsBYY+3/7LxS/w+6UpWdVZLmz8269fgtLqaRO2jcP0ePi/OWCEQN4wvqRQT0?=
 =?us-ascii?Q?0IspvyTZmL/nuD5LReHeQUwzAYy6/8ZFkG5eXt/gpZbQwJaPognTWd0AE4Kk?=
 =?us-ascii?Q?+oeiuGZ6O5lxHWZ2t+8umC8qAsY3mi0nLGLV8l93?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d72049bf-cca0-4a77-014d-08db98e70c5f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 14:43:51.7137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yw3kmwqcBEGxCJQ4X7kLSKCLhAc7zUz49TowIk444bEKE8Zc2O9MkiA64/2HHhXz
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

As generic_single_device_group() requires it. Otherwise it crashes:

  generic_single_device_group+0x24/0x88
  __iommu_probe_device+0xe8/0x444
  iommu_probe_device+0x1c/0x54
  of_iommu_configure+0x10c/0x200
  of_dma_configure_id+0x1e0/0x3b4
  platform_dma_configure+0x30/0x78
  really_probe+0x70/0x2b4
  __driver_probe_device+0x78/0x12c
  driver_probe_device+0x3c/0x160
  __driver_attach+0x9c/0x1ac
  bus_for_each_dev+0x74/0xd4
  driver_attach+0x24/0x30
  bus_add_driver+0xe4/0x1e8
  driver_register+0x60/0x128
  __platform_driver_register+0x28/0x34
  hantro_driver_init+0x20/0x1000 [hantro_vpu]
  do_one_initcall+0x74/0x2f0
  do_init_module+0x58/0x1ec
  load_module+0x1a20/0x1c64
  init_module_from_file+0x84/0xc0
  idempotent_init_module+0x180/0x250
  __arm64_sys_finit_module+0x64/0xa0
  invoke_syscall+0x48/0x114
  el0_svc_common.constprop.0+0xec/0x10c
  do_el0_svc+0x38/0xa4
  el0_svc+0x40/0xac
  el0t_64_sync_handler+0xc0/0xc4
  el0t_64_sync+0x190/0x194

Fixes: 5dd59857af60 ("iommu: Add generic_single_device_group()")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Closes: https://lore.kernel.org/all/e5e75222-13a9-ee01-0c25-8311b622fe0d@samsung.com/
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3ff365c9117850..18162049bd2294 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -366,6 +366,7 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
 		ret = PTR_ERR(iommu_dev);
 		goto err_module_put;
 	}
+	dev->iommu->iommu_dev = iommu_dev;
 
 	ret = iommu_device_link(iommu_dev, dev);
 	if (ret)
@@ -383,7 +384,6 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
 	dev->iommu_group = group;
 	mutex_unlock(&dev_iommu_group_lock);
 
-	dev->iommu->iommu_dev = iommu_dev;
 	dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
 	if (ops->is_attach_deferred)
 		dev->iommu->attach_deferred = ops->is_attach_deferred(dev);
@@ -397,6 +397,7 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
 err_module_put:
 	module_put(ops->owner);
 err_free:
+	dev->iommu->iommu_dev = NULL;
 	dev_iommu_free(dev);
 	return ret;
 }
-- 
2.41.0

