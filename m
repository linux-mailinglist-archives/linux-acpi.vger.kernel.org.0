Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CC472343C
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jun 2023 03:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjFFBAE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Jun 2023 21:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjFFBAB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jun 2023 21:00:01 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029F0102
        for <linux-acpi@vger.kernel.org>; Mon,  5 Jun 2023 18:00:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dfg0vBe/D0Xi54pwdADXToBHSj+YGN9wV0anmGM+baOEf8bcsGz5c+AHsG/Wn3Tb0SlP9VkLap0rojsJX0f43cFonCahfcBln61S7py1u+Taf7NohasYPlttPmuiDvsvVoqmWrxjk8WDuNnUfc6//M1zJXngyTbyzFadYm0qpMSGx2sGpjHzyir/CL/2xvL720jaZcpkP4IRgHlKg/5uVU6YHSJyHk4gp7VDLDmYpZJSjrGoLT4lMV2/i1Zzv1cQNW0aV56Jna9Hn5BTEWKWCMdUAoFgwoTmHOoP5gdxj0Kwm2jQ4FPSEuYqeFdAcxOFuUSTbc2cgLMdgkalKk3CoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYBf0AK7hbCXqXwso/9VcXX3AL5HJHKoPMemFXl/wjc=;
 b=ET5ALWLfqCglMV34HBIma1ARwyFwE4Qf4VlI+srzuEdxVbnS97O6fiyvPyXzsKRt9RtquwU7jpJZ6pZiRhsVaiEZ9plDqt00y/g7VnnCyb6G+1g6UL+DFLSZwIx6sCzdPpTUub1TdTkrQQr4mcdXwnHu1K5kJ6lvaYQzJ9F8Aed+OYwEnW8heuXvtWg9HQfazBr5ZLFWLUkRK0tq2rdL2hj8lDRY4O2ZglZ8HMqFUvLMDUkILiyvB6/nEzXaTLwzBeJHZ6LFSwmtYyd8h6zFkGVu0guGxzS9EEKAOWzBVyJcprfbBqpcLa2/gBdZj78IvNsGMgT/TkG1NHeBiPmBAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYBf0AK7hbCXqXwso/9VcXX3AL5HJHKoPMemFXl/wjc=;
 b=CpXFncrMOxzyUvjwQCzJXg+nC44dx09xr8nur52fK9bCGtakREC9uFc2owu3v68hY66E1egp9oKQn4ElN+9fdOWVAhWN8tj5/x6KQ0BS8NUI4/mf3BXzxq588+mckd34EusK1TaqZ59EleMytqPY1gUL0LTanwmoVa/V/JlJRf9nd318zzkwTfjgnrd7ZI2GYtu5irDKdI6XHyhuzq78GUPD5k8tWnrJSOXEyZGtE+8+CFckCxnlOnblOcopIQpBqEpWUjpQh+mnwoME26hJLNPQpxLPRuSNUMzU/WioGxk329r9dto8JkOrlq8uysTnu3oU6Ro3HmGs5voCzuBF6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 00:59:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.028; Tue, 6 Jun 2023
 00:59:53 +0000
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
Subject: [PATCH v3 06/10] iommu: Move the iommu driver sysfs setup into iommu_init/deinit_device()
Date:   Mon,  5 Jun 2023 21:59:44 -0300
Message-Id: <6-v3-328044aa278c+45e49-iommu_probe_jgg@nvidia.com>
In-Reply-To: <0-v3-328044aa278c+45e49-iommu_probe_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0076.namprd05.prod.outlook.com
 (2603:10b6:a03:332::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: 615ef9a2-0048-4b95-ef01-08db66295542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L8lW5SZDFjFq57/Z9oJqbcEvIMj7wVVFc9YTKNkEpBI6AEHotuPmz34w92wHV+1HdjGrDC8RqS2V18wSfV3cKHaTmaGVQkNs12/JGexoCWWCO++ZxrQ2euDxw7+2OsaoZFWp3OA2UQGy0iuKQspL+T67MVP2Ed7Y1gSw81f3oLmIWv/RX80yqPwZuPXQTrw5C9sTL53rGCDckUy4uiPUWG4c/W7o+qnHpodIWTqz3C7n1fUlYVsbBrkv5jry3WKT6H5RxYKc9LmTUiaM5UJC4jK+vcvq556mPxOIG+Ee0JmZVCVqthXAKYNFy0K9d4uzD05+rdjknPCzb8NsLcZY0qpeE9J0fIDptuWAxafminwdPZJxmyO/1x6QWWIT1yLmSXQ4IGBXEfz/YFS07bSyyXcsN0TohUOLBZsTfdOmYYQn25910A4YbpyAVhoFI+qh1FklqFBZzm/yHB4mGzU73R7jlyrcTdj0xJ1dq1ehuBJdNTXcxxYyezg9nGP1+/8Evt8FrIxp1mSosMNDk3pw8dEJiFxeiNL7JxPVD570+vn7jSPhTto9n3axxgSlGm0SJZoT3oGW+LxKqSwTYHt26ioRgGiA9ik9PRRPTe4s0Sk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199021)(36756003)(110136005)(54906003)(2906002)(478600001)(86362001)(38100700002)(7416002)(41300700001)(8936002)(8676002)(5660300002)(316002)(4326008)(66556008)(66946007)(66476007)(83380400001)(6506007)(2616005)(6512007)(26005)(186003)(6486002)(6666004)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tBhLT3pblBZemCMXQKKhXE27jto3OF/B/IsC8RcA7HGWd6ns3b08CEyuef+g?=
 =?us-ascii?Q?0tU2Zs3MIxmcqd2I8gYKv4b7PI2KOAHD+wXj1PwVI0bsaDyM6FhozV84eBtP?=
 =?us-ascii?Q?xSSUczF9eeSe2q5WxulilG8V1JDKSrbHbfE7o1cs8XaB+hMwVAhWsN6ZgQvT?=
 =?us-ascii?Q?In4uVrCMiNJ6fHIckztoin3oJ7/Tm81EUgGjy4qzjMFomEhBtdBHPwk4jrpC?=
 =?us-ascii?Q?kvbIUWXlpa57I86m3v054EthE0VHvwVeIWVw47YUcejavLgkPWjyPVraVrkX?=
 =?us-ascii?Q?/J+Ku3IkSceLcNqwVcaGuuWGXr4DKMbrQKJ1tvocNflL498HFQI1ElJMU1N/?=
 =?us-ascii?Q?WX/GXfPCkX6Najf8GL5D66vR0W0jRPs/SZ0DmCoLUDqBSBlqf9LYLKUg2YEA?=
 =?us-ascii?Q?3VTsaBSG1zMaupEyE2WiIj7UMYrxXK+HQqxIz2sAPieN4xJGtAXtWnF39sxQ?=
 =?us-ascii?Q?Psxydj37haeNzYop7oY2P3WwPKVpuElANMCEdt4DdDOkaoxQ207uNqDnUPzR?=
 =?us-ascii?Q?B9niUFzv3dxnu6S4N2INITlNLtc39yjAhcRoB/avtxw/1hRh2+r1MFSmxq4i?=
 =?us-ascii?Q?wAJ2lk1SnK+AVS/2hCIuzKcRZ9CyJRWdGxWUnxtTB7aL5bLTivppdFH60Z9b?=
 =?us-ascii?Q?UqaPFZIjD/OhbnEcnAySo7XI+tA4bMYlSszhZkw2E3qVppf9oZnYqVWiDH0e?=
 =?us-ascii?Q?1szlxUyK3NTlQbADMhdZUM8lXutv3xGiq3Q6xyBWyVNDew4DjbO6bGg9N1Ha?=
 =?us-ascii?Q?Ee8OVtxwGL0auA+2L12MPmHhg5q6B/KMPR+R8nK/ohyir+r2zwtU/3nwPYTL?=
 =?us-ascii?Q?19jXy2et1Rg6A2fSvbdEdrpUiSmxj+T0V6F3d7xvqYl79BgSURuhRTsckuX3?=
 =?us-ascii?Q?B+8N5UvYxdHCuUAuGziBq0R6XNZx9MLA3E0vmDPDQMWfVQi+EYKZhkEX1tGV?=
 =?us-ascii?Q?gIWjVdQOZOvBbCnrDKIe8XiIe/+4r72XMpt5xn0pas8JZ5U5shoe6yuv8xRO?=
 =?us-ascii?Q?eOLV3mZED41mZhPJo1VVt/tSRV69BjmqX2m9dGyUGdRJpwFY5D1sblkij4lQ?=
 =?us-ascii?Q?d72TnOa7cRswQcgPft40Ot5tPLDmxnT6vPGPUYFyoSH5TKKQYZxVjB5wR9Ok?=
 =?us-ascii?Q?HYhCEQQi8VZX/SBkEEuTbTAaQbc4atdFvvRua2uILceLweUX8kO+LJIlY6jE?=
 =?us-ascii?Q?fYOOgh/omBhn+GkYMWVSjioMXG+Vm+un5JAdhpiEzfkpGD+pW01PXn/K0U2M?=
 =?us-ascii?Q?beSYD1NDimL/iHtgkZUvldoxPEO4rtbFYcV4dLPlHKHL27CWYD89e2kyCoyl?=
 =?us-ascii?Q?HrWrxN2QsEtqeachujqdHwpPkMshjik3IXhy1hztsrF0o2Ey8Qw5pTPNz5fz?=
 =?us-ascii?Q?J5zsZ4LpQXW7JfCxdasUa3yIWZRpmgbFab+rD7xLZC5hM4i/lVTxtB5KAK/9?=
 =?us-ascii?Q?YJYDVnZ3uGMYJuHbVO/L2oREaCgz0qG7J4XLD8eJTDqCDcfFNL0uJdobHRsT?=
 =?us-ascii?Q?IqKWAlU5RxZU00DY9pRp7UHkwMD4si7pcgYvQu4MtJvgQDSS+gR2JgaWKIWl?=
 =?us-ascii?Q?0Xc6eIU5qgIhQ94DrXN8xzumDNNyd+4OfvsNHPBx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615ef9a2-0048-4b95-ef01-08db66295542
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 00:59:51.4243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6mtNpcyXs/qad0nlBHIPerYvHEMq/WerRmVk2RyhSNkU+CrjGyYnMt2hYIFVl1Hj
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

It makes logical sense that once the driver is attached to the device the
sysfs links appear, even if we haven't fully created the group_device or
attached the device to a domain.

Fix the missing error handling on sysfs creation since
iommu_init_device() can trivially handle this.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
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
index 7e8f5edcff2145..2281f3281ea4a0 100644
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
 
@@ -584,8 +591,6 @@ static void iommu_release_device(struct device *dev)
 	if (!dev->iommu || !group)
 		return;
 
-	iommu_device_unlink(dev->iommu->iommu_dev, dev);
-
 	__iommu_group_remove_device(dev);
 }
 
-- 
2.40.1

