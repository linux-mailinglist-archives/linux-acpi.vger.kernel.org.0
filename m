Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026AE774474
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Aug 2023 20:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbjHHSTg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Aug 2023 14:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235183AbjHHSTO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Aug 2023 14:19:14 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DB120985
        for <linux-acpi@vger.kernel.org>; Tue,  8 Aug 2023 10:27:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9W74M9kz9vE1t5PmxdLKkQcDCcAaGaEhkhkUxQ7+ynOaRh7b0o7zItkKxiU4lmyat0nf/6c2cHySbvnqVZezrrfr5Kvhm/oA+b17bqwYXRLxBaqhQ6g/AW2lxBczmCKRzeG4DIxJ9VAC5v4GliRiGTB8MD0azdHEp9evcpKJBIH6HcC3Fgmu9vCHQrxMMHem6MmCmMyuww7FwZ+4MudShZepdkhQHrn6tu7EQGkmtz6hjaMnk/pc4oq6EeYPlTO3nll6CpkfeAr4W5kZ6tYTLBgrS+sTHRNgGT1bmU/vIJnELauHsVR7wADQU0YlrftmgkIJFvu9R5F07fO/xN9rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLWSa1Fy2Et4vOyC1QAtF3m1NDrrbd6PByBqssQjnrw=;
 b=NiBnbEbdRUmPWLTFT6u1wGQEFB5mViWG+l0rbnOutI0JoRhFyEtY8xTJirzZ6gcw8Y7jZi+kBzNr4aUY6p1f95kOmDjVZx2knvhGVYb4r/5GBu5K8+5cCtI2VdpJoZUaKEnMwPiO03xpuYRaNiSuRDF8YM9dkhS7jF1WRtL33RdD/LiGaHTh+24fhmHSfVcDbbZkYngsc0yuU35qsR/DM0JltjbZNGsV68R4ap0iH9TfPxUjOHYh5ozCUMXxNFV5N9Om7yimT0C7IX0lOcvejqK5T152WtWZ7BrcKFYHcSzNbluFnjGqNX8x2rEcaiDXG5dL0JI533v7O75TR9VZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLWSa1Fy2Et4vOyC1QAtF3m1NDrrbd6PByBqssQjnrw=;
 b=NihWRgb2JDEEYk/s3KqzIjKBvQuTsrrQzwtro25vgTR2rBDayAgYLQ9pirZATYzlg2+Gpfm5MHBEQbogn0Qc6e5uCEdlzuRKUy3BQP16Dc1XoCWYX+w80XgfNXYg53l5NYRTLtNidHdhZnblYDqbMiyPnwfvY9rAfgmMVQkbW180qwfdckETKkvQMw1CPGAB5V8QD/I8wywxrhWv8p35xSs8GSCeP9pTAxl8F4UrbK06qEsWiP+084CvYU87ZUg+FwtzTqACRUwnBQsEJXhvdxo2PIOoRPIc3C+DrEf4Edyo4VpWFWKCIYRx0M3fnvAWPS5ZFWTMFcRIUe/V8nXvOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8454.namprd12.prod.outlook.com (2603:10b6:8:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 17:27:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 17:27:10 +0000
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
Subject: [PATCH 2/3] iommu: Pass in the iommu_device to probe for in bus_iommu_probe()
Date:   Tue,  8 Aug 2023 14:27:06 -0300
Message-ID: <2-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>
In-Reply-To: <0-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0402.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: 88751fab-3764-49de-e61c-08db9834b19a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oNXW+9nzyNDF2CbHcoejyi/KhD14dyOsDyLZAfpNY3rC0g/LTwXUw2rbnAzwk54AFqJttePTLEx2lVMBr359LvA5ltOjTzsicISIKs8hbQthKXRP2gmz8mZCKN4vPrWU9PdrgjUwLf8tdW4UpZTbYivmvbLxiE9x+PJTUsOx8fRGvGU+WBcVK+AEPKI0dwHLTwigRRM9yhx69Y9/sivJg7+gsdSvCUH0D6gd4joNckkCRbaphhJbPXEzosD9SCLeiaBdin3TzliJlQAF5dvOi909MdfylQCjQUcpnOfqVVO4mLPImhXBY7lv/Kzn5ky7kS0lfaebnl9egrX1XssZd2YoiJqbUrEDwQvZdX8luq6kuEbYvFW5nAV+vmaaDkeSXWgrTOTlGNE/k3PJVk9suD43xtWSasctnFZTrBLJ1iBJZS7kh+vrUxQTIfti5/ZNXSGuaI8FgpdWwCJGM0CarffdNXqFsqOxSmFeiZos1ywk8HixW25MkKG5Vze+MbJLcmTi4ui9rZ6V0iskGrKzIUBrcWE66Ep8V6hkOWoAunPVF14srNDU2M1xRvWKhee1Z4Gqe7bhjXkU34lIHxj0BN2o6AO3O0qGe8AxDwCiPIs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(186006)(1800799003)(451199021)(83380400001)(2616005)(2906002)(110136005)(54906003)(4326008)(316002)(8936002)(5660300002)(7416002)(8676002)(38100700002)(66476007)(66556008)(66946007)(6512007)(478600001)(6666004)(6486002)(41300700001)(86362001)(26005)(36756003)(6506007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?duaKhjSvS7gpaty/tODcb+nR8vf53ON3tTSD42JsMMsh5LHJ818LY4WpzTQU?=
 =?us-ascii?Q?PhwNqjSCtA+HK2d0MEqwkoPjJfwzZex/9z5XaBMOv0goCpDAza+qhGUui3cS?=
 =?us-ascii?Q?waGCORLU9G33ZRFFWxKKqRpd17Xy799DeL1q1i/eoZPnEAZXxALK1QZ1eTS4?=
 =?us-ascii?Q?VS076B1y4JFUTPVCt2BrRt7mxtBQSqR9gPejkkuimVxiXRPEJwaCVyJEj/Bc?=
 =?us-ascii?Q?+4/whbydDB3n/D96bdYLQ9GgBNRi4sPwY99YTY512734dkOqTGg1+k9wPYmQ?=
 =?us-ascii?Q?JaJrr+tf/mIW0XdEVobTo3RT9j0sj1XMtn6+vk4bPDMwDW/kuND7icrG8S3V?=
 =?us-ascii?Q?CP6MOcIAYLOULBuVfWP0+0Z/V/3uKajmqbNk0JjzRQtNKHYXwaCOZVqfjE/1?=
 =?us-ascii?Q?4HLoCvQeAsAz12nqYHuOkPUqeapdJDsJvxNn5AP7qOKfKkyvnD3sBNjZsr6W?=
 =?us-ascii?Q?ZmHWjDOm4IgNK8Aq1xc3orU6lg2hF5q6ERMnH9aCcQvPQrrn0DKfXMeeGRmQ?=
 =?us-ascii?Q?HkwKSUIofbuuBJH/kUofpHFiAoJ0RJ3ESEBSFZqCVGbUrR29G0m5WpoXa7lC?=
 =?us-ascii?Q?oiippAVvR4/pRfTUXyhW5gjvh8kgF0W90SOIfyEjEbhxDJVL3SvM6ROqpksh?=
 =?us-ascii?Q?lAZOSug5yJSCRvgNGreU7wt/87PDaRzvMubSOnRf2d+FID+Xrt07J2POEnVC?=
 =?us-ascii?Q?b9ST90StQXaTBVpq39NVNUF7bfrG0GGifngVXZS4etCO+F+EOiAn2joEHBH8?=
 =?us-ascii?Q?Pjby594nLQ8ftZEKzhtO+eBFTqMVv/ZnEYk9jFezFgQf+zQ33xQ26mG0W036?=
 =?us-ascii?Q?8lz7vHgKMqKxZDpfOiFuJx4hOO28hBnn0VeRFhD849r4r4DEfZI0TGSePAFy?=
 =?us-ascii?Q?LbR8OouW2l55nlDdAls6w8nizdcJ7z4v387d6PpF8K8f1pYTKqb/sI0fAySG?=
 =?us-ascii?Q?IO5E7g4rrLH4XXSQjzUuiM0H2UsudUjiWiNjK12ah+iJ8RM7N4hjRRyLinXU?=
 =?us-ascii?Q?Y9vpdwWG6ObcsVdwIKQf3+UWQlTXwGZLNXp4mmFMj/ZkEvsl/bJOi3+H4Tjl?=
 =?us-ascii?Q?vtkZUvb5SwWUZ9M5yjgiwFC+Ew1EPtwMRBHHuS2jbdtXUUI/5lNaBNS4Uivq?=
 =?us-ascii?Q?PvYUbHI7YHt6W6TXcl6rEHuDae02EOA6rL7CeFFZ8UTq6lQPtE6WB9Icffx6?=
 =?us-ascii?Q?vT4yTPG01j7hZadqzG+O+omlFHIqYzDKq1meLzvOY0fWZZ6VNYngDNAd4sd7?=
 =?us-ascii?Q?gX+roLZMmP3fhQ4ZS8nFQPZ/WdNrnOVk/H+0PX54nFDD761er0dvYC7veFqt?=
 =?us-ascii?Q?fTLv5BobgO8pBECB/C8fSCqIJe1ZkzZPttKJaJXfVXRkn8XOllLNhmm8mHQ5?=
 =?us-ascii?Q?bFDeAPMwZ0tzksFk/SOHbAdtZ0Evzxtr31O31zMsuHPjpydg65CT8Ip7O5/y?=
 =?us-ascii?Q?YweUlQ4ogpfwZ+KxCuDNh3mB7Nk6bP071TR9kKiD5uxs6fkFDDEOKQG15m9p?=
 =?us-ascii?Q?LMgRKvdwlLDXILV+blOK9DezfDnhOkV/NCXzhhnyLlAvoMvxqAgRojTir7Sf?=
 =?us-ascii?Q?Lll1JmohaD8Rq1inDOAT6zs3i5Kjb5xVtgMPe56g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88751fab-3764-49de-e61c-08db9834b19a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 17:27:08.9678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3bvBXO9kpiJhpS5GxlTxgH7Vz0MGAON55ahSKXHZfdycnmY73rpg06zqV01HeA6+
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

This is preparation for the next patch.

Each iommu driver is associated with a 'struct iommu_device' handle. Pass
in the iommu_device to bus_iommu_probe() and all the way through to
probe_iommu_group().

omap is weird, it has a whole bunch of iommu devices that it creates a
struct omap_iommu for, but it only registers some of then with the
subsystem. In the case it doesn't register then it has to open code the
call to bus_iommu_probe() as it's omap_iommu_probe_device() function is
sensitive. Pass in the unregistered iommu_device struct and move this code
into an else block since there is no sense in calling bus_iommu_probe()
twice in a row.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c      | 18 +++++++++++++-----
 drivers/iommu/omap-iommu.c | 11 ++++++++---
 include/linux/iommu.h      |  3 ++-
 3 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ecf61bd3cfb076..19fdb1a220240f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -273,7 +273,7 @@ int iommu_device_register(struct iommu_device *iommu,
 
 	for (int i = 0; i < ARRAY_SIZE(iommu_buses) && !err; i++) {
 		iommu_buses[i]->iommu_ops = ops;
-		err = bus_iommu_probe(iommu_buses[i]);
+		err = bus_iommu_probe(iommu_buses[i], iommu);
 	}
 	if (err)
 		iommu_device_unregister(iommu);
@@ -1792,13 +1792,18 @@ struct iommu_domain *iommu_group_default_domain(struct iommu_group *group)
 	return group->default_domain;
 }
 
+struct probe_iommu_args {
+	struct list_head *group_list;
+	struct iommu_device *iommu;
+};
+
 static int probe_iommu_group(struct device *dev, void *data)
 {
-	struct list_head *group_list = data;
+	struct probe_iommu_args *args = data;
 	int ret;
 
 	device_lock(dev);
-	ret = __iommu_probe_device(dev, group_list);
+	ret = __iommu_probe_device(dev, args->group_list);
 	device_unlock(dev);
 	if (ret == -ENODEV)
 		ret = 0;
@@ -1868,13 +1873,16 @@ static void iommu_group_do_probe_finalize(struct device *dev)
 		ops->probe_finalize(dev);
 }
 
-int bus_iommu_probe(const struct bus_type *bus)
+int bus_iommu_probe(const struct bus_type *bus, struct iommu_device *iommu)
 {
+	struct probe_iommu_args args = {};
 	struct iommu_group *group, *next;
 	LIST_HEAD(group_list);
 	int ret;
 
-	ret = bus_for_each_dev(bus, NULL, &group_list, probe_iommu_group);
+	args.group_list = &group_list;
+	args.iommu = iommu;
+	ret = bus_for_each_dev(bus, NULL, &args, probe_iommu_group);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 97c45f50bf4332..1e4a90ec64322b 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1234,6 +1234,14 @@ static int omap_iommu_probe(struct platform_device *pdev)
 		if (err)
 			goto out_sysfs;
 		obj->has_iommu_driver = true;
+	} else {
+		/*
+		 * omap_iommu_probe_device() requires all the iommus associated
+		 * with a device to have been probed to succeed. We just created
+		 * an iommu without registering it, so re-run probe again to try
+		 * to match any devices that are waiting for this iommu.
+		 */
+		bus_iommu_probe(&platform_bus_type, &obj->iommu);
 	}
 
 	pm_runtime_enable(obj->dev);
@@ -1242,9 +1250,6 @@ static int omap_iommu_probe(struct platform_device *pdev)
 
 	dev_info(&pdev->dev, "%s registered\n", obj->name);
 
-	/* Re-probe bus to probe device attached to this IOMMU */
-	bus_iommu_probe(&platform_bus_type);
-
 	return 0;
 
 out_sysfs:
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index cb4fc518797039..cc47e4086d69ec 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -465,7 +465,8 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 	return dev->iommu->iommu_dev->ops;
 }
 
-extern int bus_iommu_probe(const struct bus_type *bus);
+extern int bus_iommu_probe(const struct bus_type *bus,
+			   struct iommu_device *iommu);
 extern bool iommu_present(const struct bus_type *bus);
 extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
 extern bool iommu_group_has_isolated_msi(struct iommu_group *group);
-- 
2.41.0

