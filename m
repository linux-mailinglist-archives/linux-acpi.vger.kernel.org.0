Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A89B709F44
	for <lists+linux-acpi@lfdr.de>; Fri, 19 May 2023 20:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjESSml (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 May 2023 14:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjESSmg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 May 2023 14:42:36 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B66E49
        for <linux-acpi@vger.kernel.org>; Fri, 19 May 2023 11:42:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxLn8C1xQqF9MusjRoQo7X/4Ib+BYLUJf+oUQSeQUWAjxvU8/kQciV1Llds9TACgW7F7vOC9gYL3Xy9MsYbJMh7ZE2W9RJCfV6OTutYjTergUWhUVa80JYFPWazbqlLswCRNrcoXBUJ6Mj+PSec2pdZxYk3d84TSNDLIac/q7+pSUETzlZt9ndQs0I1HjXkVhj7wSz6WNHLFlwiXrV3eXIFwAZrwVMQdkwit615H9s34Af4XzwGMsacT2uYxdrCTK2ioJ/gjzslPEgHlLba6eotNBJl8FIKk5HMiYDWd7bL7qsrtynOgnRnm3BGwP9pxO/nqliToGzyRFtkRpGBtOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=712VHjNOOVUFixxgXWW99vsUB1tfz91eMtL0qnr03R4=;
 b=oQHvvEZ/0ujJZhgoejkKkmqUK5zipw5FuzLBnwJIf0IHvpUFcgIUgUHu3eWtE2MzyExGvFaNoftUXGyvVzUpDT9AB2WzHTdKY6isDBBVK5+u2Jf5jr3/fJZmF/ezOP4WqagBaY7ZHPSlwRtml1H26DVWaQr9CSqD9wdaUCN8id/e2oKOtUesaCYU+ZjqB7nENdnu2dzwGoCvrG+pNqJ/HpsZeKzI8ZRuId7I9FVAYtYIciW3mMxTX0ps+ZCHW+JClup2zSpjUd7m/tLtX/gPpvwlhj3qcO46uorFSgQlSxFqLjhHFIdIUaVJcQnC2FpWuaSPoOd3njJykRIkBgpLJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=712VHjNOOVUFixxgXWW99vsUB1tfz91eMtL0qnr03R4=;
 b=goAMQhX5IpKC4exK99Sc5wBEWcfFspNTp5Kli7fOBoIRQVHt54l5hS9G7kQItm9B+1bhv9oasj9KIxTPM1UUKxExYjfQmGiuHelrdst2g9c+mAs1FcRTJga7NYaaYbON1KdiXNT4xudwomknQfGqHFCXlOsUEw3mGjVqJ+CUc0vZZw0KZNoBfDvfxc2lL9JdHjSgrF2asHGbBJuzyDi2hllrx1p49QicBprpiaXSa09DWLvhNXDMOewtcsjIMFNFFzJT08uv/LMk1TgRwtyWYUdfpkr86dzL9QdrGoJDv7R1a1xP7us5e4ODrLGfjLUk+q1BQyOAiyUaOTiOfbmZxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:130::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Fri, 19 May
 2023 18:42:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 18:42:27 +0000
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
Subject: [PATCH v2 06/10] iommu: Move the iommu driver sysfs setup into iommu_init/deinit_device()
Date:   Fri, 19 May 2023 15:42:15 -0300
Message-Id: <6-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
In-Reply-To: <0-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0354.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: c4bac90b-93c4-4023-c679-08db5898c7cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B8jXa+xmx6K+1BsxP4lqyG2PMlkpRxXOgToxlrVmAGK7flXxuVHs03PPHHjo9HAlv6Kv3QANrXYk2kvkCz8G+xetV0oI474UZtWoF8YJ9tGYf6HEzYzU1347uENPpNeSRJjnrkUjdyWNYZpmxY0wvkrk3xCnVOdE7WnuWApa2Vc7aK3Ioi+7TVNZbry1ioZRw1wyjf0PbcUNgEaW3Re+Xpwcj2XiNh3sgXX8V1gEqAbWjmeN/7GmCfREToqPzICKTAjm/xbFxJ6brrtyrm0hKpbSMYNWqDePLbHwAIHqV1KiYsU2/+OHSS7ZzjZBnd4mqu8dz/w08WhPYUrlFWK1ckRQqesT4QGsnD1s05ccgo5t/QrkxqXBcnbIBeUB/RA6r+TPD6fUWQzVDECNbeQwd7FW72l3XCf5MrrxT1tt5tNYtiIA3VyYn1PN+4/FtMeA0hCjR17cXiIGVQlh3KR1NDedmjSayGIKrVEEPJk5Pva48ztbgRV253nq4vS2cOCdJJPlvPsZSPrUnwxXTvb2zubLs8kgo766Q1yxHbZHyiUb/FfspL6SIRYuvvYOcxqgo7LXYFiqeSsNiw9tEAKKzC9ReGKSz0dC5SQrkbZ6luE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(6512007)(6506007)(2906002)(186003)(107886003)(26005)(86362001)(83380400001)(2616005)(36756003)(38100700002)(316002)(41300700001)(6666004)(4326008)(6486002)(66556008)(66476007)(66946007)(110136005)(54906003)(7416002)(5660300002)(478600001)(8676002)(8936002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7HyjBfKFmp/QrTEoCGozRwOcY+i5M9FZYDhwKIGvG57209879w7X/7RfHJa8?=
 =?us-ascii?Q?gX7aqDsfJ7lyZYjFX50BmewC/YrBNfR3qISYNCUSZ+jU3aLHm0vUGQ370Fya?=
 =?us-ascii?Q?21cILaG+Ze1s3ZU1d2PgjgNZJ2Pk6aQxpZkWHIPM7UOT+00HeTLjh2QJdJDN?=
 =?us-ascii?Q?o/LWOiXT8eAcDU1isv/EtNTilcu3FI+Y27c52QuMQ1dOR4+MRKdmgtMdNgsa?=
 =?us-ascii?Q?95LWSO36HBrjrDsP2AKyx7jLjLM91F0hnF6gsIwODOMxkAFQcv1EKLRdBjB7?=
 =?us-ascii?Q?M3CDDF4dmgP39i+qE0u/jAErfeDTfZhdDqAlTvj1dvCtEDY8zePU4x1nvquE?=
 =?us-ascii?Q?+JJaXK3ivMcLU3W+Yqu725LYQNPWLZeVH24hMtn7cbCmn4tL63POAYmwwWPT?=
 =?us-ascii?Q?bO3yMr0OlH3WE7LyNYuF+6dkzaHcW3w+iuZVg9PeativGmreq6Bpeyy9SDpk?=
 =?us-ascii?Q?Ckjph4I4068gB5aA64mCJiIMjVocHST2Eg/QI3ig9ZrAEXRKCLN3XOj4VM0L?=
 =?us-ascii?Q?HpvwILi5efnRvyyWrCzZtP2YqPWJQxZ3YyN4NFb5ZXRDUNxU1CJ6yXcRRk96?=
 =?us-ascii?Q?RCSbw6OKahK7EVhUcU4zmLR5VZrqAXyXyIldXTb10Zq/v1DwsD72zQAkA2B+?=
 =?us-ascii?Q?BNseVh9kEfmXeRpYE8HbOvo2UFOxnfrd6I4TSzh/1yIU4T+dueb9G8J8Cc8/?=
 =?us-ascii?Q?RQl19g3m+zCQ1hEvPRdbI/cKChU+gt1wbjJIYy6PcWK+WZltz/OZbBRx3vbF?=
 =?us-ascii?Q?0Hmu5kjZo/jc+YB4IwEA99AhPSdJFLz5ZhwMhYvAl1dBPsfgrlAish/eBNZB?=
 =?us-ascii?Q?k23tQmcu8gGHv1uz4KW0dcSmVLV233PGwzvyQoIimiGPKsknhdAe4+IjsFkb?=
 =?us-ascii?Q?cyO7npTU9QmxJ/SzwDmnlpjO4CXx1K9L+NPO33digJTuud5Fn3nY/uE/Elpe?=
 =?us-ascii?Q?XEf7yk4mSLonS+1q2gxOpPHewwlEVDFU5NGWl/c3l6ewC3TsVaLGrj8xJjfk?=
 =?us-ascii?Q?K8QlLhTH3LyJplPZmnvi6gxbvqTFSlL0+PFGFmmLWNHjiKIB1TlLMZxIp/ns?=
 =?us-ascii?Q?8kVt3vC/7jxEGnf6Q6g/msyKdE6ITxZT/KLXAW5xekkxrmHOazEVrdMUlWnP?=
 =?us-ascii?Q?AE582ot5sfGLy4/Soz4DmayguU8/M1s5NZrce7jkmlEPTg+A1HHNxRugptnq?=
 =?us-ascii?Q?3KnKYUalz99Gj8+951QIb5//9JAft3exiLGueVDOrWDqsZR3PX5iFzF3HzYJ?=
 =?us-ascii?Q?65Bl9nijKv7kJ7Jq7QqBoW4K4f9DethX794OJp/bXf2GQiGDL1y6EmT3WIMV?=
 =?us-ascii?Q?7O6NeyqKTdwo38mlfBw0Yxle5V/m8I1fU5BfCEobpm43JieLD8Ns9yn94uHX?=
 =?us-ascii?Q?G7WlD+O6p8YCMbsTCP2j371AElRTHIzaCyh2yk4u4dNQdBv8l0EuP3YOUfy6?=
 =?us-ascii?Q?p6aWbi2jlAD0EPE/usJKmDKcW1OdTWWr9cl9P4IqrLiplD7oNU20QUkImniq?=
 =?us-ascii?Q?B+uuE7obQiTGyO18DPH7snNtqnO9tled2yA6aeCaE3FFMHB8X4OgBSkzdNH+?=
 =?us-ascii?Q?QOXmStUXS6uvyRdJDTh0ANcY9iHmsJ8RlFSWSAdQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4bac90b-93c4-4023-c679-08db5898c7cd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 18:42:21.5155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWASQLtxX8Ft0238blhe2BoEpsV6zfK4rBV9SNmaIxBNKbNdIqPhzaKMn9s3+bUh
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

It makes logical sense that once the driver is attached to the device the
sysfs links appear, even if we haven't fully created the group_device or
attached the device to a domain.

Fix the missing error handling on sysfs creation since
iommu_init_device() can trivially handle this.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu-sysfs.c |  6 ------
 drivers/iommu/iommu.c       | 13 +++++++++----
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/iommu-sysfs.c b/drivers/iommu/iommu-sysfs.c
index 99869217fbec7d..c8aba0e2a30d70 100644
--- a/drivers/iommu/iommu-sysfs.c
+++ b/drivers/iommu/iommu-sysfs.c
@@ -107,9 +107,6 @@ int iommu_device_link(struct iommu_device *iommu, struct device *link)
 {
 	int ret;
 
-	if (!iommu || IS_ERR(iommu))
-		return -ENODEV;
-
 	ret = sysfs_add_link_to_group(&iommu->dev->kobj, "devices",
 				      &link->kobj, dev_name(link));
 	if (ret)
@@ -126,9 +123,6 @@ EXPORT_SYMBOL_GPL(iommu_device_link);
 
 void iommu_device_unlink(struct iommu_device *iommu, struct device *link)
 {
-	if (!iommu || IS_ERR(iommu))
-		return;
-
 	sysfs_remove_link(&link->kobj, "iommu");
 	sysfs_remove_link_from_group(&iommu->dev->kobj, "devices", dev_name(link));
 }
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2031cb4782b9b5..69e4227bb7404f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -356,12 +356,16 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
 		goto err_module_put;
 	}
 
+	ret = iommu_device_link(iommu_dev, dev);
+	if (ret)
+		goto err_release;
+
 	group = ops->device_group(dev);
 	if (WARN_ON_ONCE(group == NULL))
 		group = ERR_PTR(-EINVAL);
 	if (IS_ERR(group)) {
 		ret = PTR_ERR(group);
-		goto err_release;
+		goto err_unlink;
 	}
 	dev->iommu_group = group;
 
@@ -371,6 +375,8 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
 		dev->iommu->attach_deferred = ops->is_attach_deferred(dev);
 	return 0;
 
+err_unlink:
+	iommu_device_unlink(iommu_dev, dev);
 err_release:
 	if (ops->release_device)
 		ops->release_device(dev);
@@ -388,6 +394,8 @@ static void iommu_deinit_device(struct device *dev)
 
 	lockdep_assert_held(&group->mutex);
 
+	iommu_device_unlink(dev->iommu->iommu_dev, dev);
+
 	/*
 	 * release_device() must stop using any attached domain on the device.
 	 * If there are still other devices in the group they are not effected
@@ -462,7 +470,6 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	iommu_group_put(group);
 
 	mutex_unlock(&iommu_probe_device_lock);
-	iommu_device_link(dev->iommu->iommu_dev, dev);
 
 	return 0;
 
@@ -585,8 +592,6 @@ static void iommu_release_device(struct device *dev)
 	if (!dev->iommu || !group)
 		return;
 
-	iommu_device_unlink(dev->iommu->iommu_dev, dev);
-
 	__iommu_group_remove_device(dev);
 }
 
-- 
2.40.1

