Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AB672343D
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jun 2023 03:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbjFFBAM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Jun 2023 21:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbjFFBAB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jun 2023 21:00:01 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0913D103
        for <linux-acpi@vger.kernel.org>; Mon,  5 Jun 2023 18:00:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnzdzjIXiFyObtGxOEsGGMCmxvXd5Xm4xYTJqb0Fnwh4uKNF2gxi1tHxHjnOAOCeiPmRpEMAY13fkyfXPAFWu6vUPRUg4KKk/f2LWd/XjHuO3uzt8pQLohswStK9EDcnmv+QlfLns/TEICWsuKG8fCG7Ci9YoITLKjg0b5dKYUseRGKK8ud4kh3lepygoeLfHOaJbcKnpd+jhOawlwRatypzKwe2H8JjLlABb6wHKuLfIJ6viCES7b+jrJJzf7HlUn3wdd+o3jEQY5Ax+aaE4jF+qOKVsMj35DRjdOVeP6X51KXYHl0vU6akQIYaYSBzV+Os32wXWbqIEqK4QOgnGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4iqz2hzaOKTbI+JgiOhnJbESdgUoQVVXH6THY/OoRU=;
 b=JVstNn6nAv8qmMGsSMhYDto9sTnNROfZfHpUD3la3Da7ejS1GyPNZFVY8YBqpVEInzR+lZbNLMYmyFM/41XagrPmXO+G1CuPz84icMMfCgjd8eCnh2EZDOTqEsXfpzYNv1zelZpXcLKz/Kpu/iuuMQciEgmnWMsDWqXHehruYvFXd6Mrr6X+mDeGWRGpWcfXbeuH+FbfmOV9Xf6AeizgxlIOr/JCJYJ3idjf1w0Rll0a4Y2Oenhxzet7TO0b2HBD4CT9HWmAaNR2aRH9Z09lK6Y0i9+I4LdiyAiw4nIaM77hoe2qyu3AmcCu/kWYa9kP0sy2eMjE826frBntYBmxqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4iqz2hzaOKTbI+JgiOhnJbESdgUoQVVXH6THY/OoRU=;
 b=SQ9fBhRYsEf3cba1nNktnr/Enusmfa74PcZuSTVY71U00Vs6erAyMoNVLOflMifFpQyGcDMk3VNMDZs55cis/OOxr3/O0YCmS6a5Yj9EP0Js0FoYl3xOuLhg+CxnQiIKZx/TxP3cLD4a6xLkCUCYrrmPATUm8+Cdc3h0YsRMnIBgcmBV8YiCVmYo/Sc03QCfKNJM8TRNIUd/4dSdlYSw+DFjIMRY6MHGgx61bE9UrhPO2eXP47aGBb4BKnTHALrCPOg0oEvB0JXoK4TLEJJZU8ozjyVujfp3qCvs9nLhgq+Xxup61dMR7AgbL/WVg5YJ5PwnZI+yGhmdFpM9s4tpnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:102::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 00:59:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.028; Tue, 6 Jun 2023
 00:59:51 +0000
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
Subject: [PATCH v3 10/10] iommu: Avoid locking/unlocking for iommu_probe_device()
Date:   Mon,  5 Jun 2023 21:59:48 -0300
Message-Id: <10-v3-328044aa278c+45e49-iommu_probe_jgg@nvidia.com>
In-Reply-To: <0-v3-328044aa278c+45e49-iommu_probe_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:a03:255::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: f398f6db-50da-4c47-520f-08db66295507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7wAf+D+yXDSafyou8YPidsIYOJwei0Ncs4gJtOicfdVzX5U9BEBvnJOmdEgA3XUYOK9einGKvDZ0Or2DM9nVnsgRs0NZoHD+FUGif+MwphTbzE0vjfxP5fmgdeula5/qGXj7PR71BUaS/07DJu5ZeV6nDNWinQzJbKfuUO9EvuE2TyN8pqmjMjG525Ag3kbkPTpWMNX7T0Ewaf648k4X9qD9POqTkSrhwY5TtpyNn9XB5M8VBEwchFv32UA23/SN+fGVo8dGamynpVEacE8DyaoKqWrhDKy3e5XHdgXkUQHVz1svzBU3Uf3/C7ekBcbfxGPGmTFMzSRIbGRH8d2IPOu7aNy/61nrWK2KI2CfXitSNETRCPD+NILhD+yX+Kh2QVDA8uOdeH+zA3xosO8ZkMCFixgsRJnQWv9rjB5s0dJyrXD1SeaaDpO7tBqKUkhixgHFlqD6WAXNAJ9Sn44uysttaOkiGM4Yh1HeNtrBfjqmkCnhCMoMkYQvnU+sXKHHFcb4Lwvs87INF+FQasqE7K3A9Pthle56LP07u6zTOYjmGfrqY7JuUxLQUblL19Hy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199021)(54906003)(66946007)(110136005)(478600001)(8936002)(8676002)(38100700002)(66476007)(316002)(41300700001)(66556008)(4326008)(2616005)(186003)(6486002)(6666004)(83380400001)(26005)(6512007)(6506007)(7416002)(86362001)(5660300002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yk/7+0rG0BIpvPfgbWuvsXPgKVZXWZ3tDxTzRxqAK513Dv8QbyStHmADnySL?=
 =?us-ascii?Q?lckRrj8rHbsK5wfoNnNN3imI4P92jmXGyqlUQgdjcPPm/JepoyZynAb+jyRr?=
 =?us-ascii?Q?J2mPURgQznyryi9CJGbwKFYpNuU9Gmu8at2AJAz2UGRiRUPkHaJYo02qiuGF?=
 =?us-ascii?Q?7y5iP1odW/PfwWyIGtpyKRwvq+THD5OKxRKMu2Rb6bguUJ/rw4MWQEX4TVpW?=
 =?us-ascii?Q?ghNvrAWevFsKzR513Y07QiEQOSe1aOPWPrP/NyIdiH2hlYHEzofi1btxZLGS?=
 =?us-ascii?Q?evnUtBNXZ9wad+9iKBom/PDp1qm84QPt93icmvdReeh1EZpr1TZS3HpvrFJ7?=
 =?us-ascii?Q?1cD4yrD7GfUUTJQUP0tJ8N7IoTLZnnZdEhEa3qdwPU0lySEtOkC+DY+3uEq5?=
 =?us-ascii?Q?Jtpk3W1RnLovb8zhbJhVVZNR9kp67DuMy+pI/O2BNEgf2LVXhAwM+pTyXsi2?=
 =?us-ascii?Q?UvK6Q67J0To8dl7tNiGPhGJzlhUUo1GnGoJ5M9y33aiiY1+fY/D/ny3cX/JN?=
 =?us-ascii?Q?m8vTSpRZu7ocEgr1SfdDN8vgqHr8KS+S1FExnga9f4fwEilQu5btnjM9TKQh?=
 =?us-ascii?Q?7hoJBbc8cxNtU+ExwNacTWB3g2mU5Gt2y48OqA+0T58RiPzoqFlL1j7oEwEl?=
 =?us-ascii?Q?t0bZzLN0POK+b1R9yLVNNVHtrPw4B7zcRC5dmu3VmNGFFAZOLIv41VsNpIv4?=
 =?us-ascii?Q?yylAhxVY4KmOLuD0htPfCYY3YWgm6Y9UOgGzHB/cJZf8S9IooGHmcwPtH7qL?=
 =?us-ascii?Q?dTrZbj4T15nco3AFJLE1opd6dvG7IdLmyFNdue1AUrV8be4udl/DKQpaUGvo?=
 =?us-ascii?Q?LJGLSoU1P0yPLh0IRub88puCQ1h3n2VixQ7rUz45amiU2qWQhw5gMTnHijO9?=
 =?us-ascii?Q?BOKVY2nCVMrZ+Yp2MXMo947VpJH3T9xs8Ea3NyDaIZYAKSUDLfumDbzMYNx8?=
 =?us-ascii?Q?tkgS+gXLVZ2JySfdBw1paV2DINdHf2iP14a2GjK0F9CCSrk63wvGs+1Q7IPW?=
 =?us-ascii?Q?kTPnWapUFjHYF7xzGi57ZalXvz6kYIVfHkdaulHR1XxDVmny3frQJSAO/aOD?=
 =?us-ascii?Q?z/D7ZH85BAq5eql180bQ/WXb0HjP9LKNwIcgxVYgSLzBSRBCwymlOu44HHpz?=
 =?us-ascii?Q?zAIGc9A+qDnFEABOO5a0FnZMkm7G2PIi/scQd+2jm1ooSzPL6w4IT83tv00S?=
 =?us-ascii?Q?Ea/Hj7S9pDb8pMPicY6/L3NZt6ywOVYA5vDL8cbrj7cA8T3cAZ9lawPI+mq0?=
 =?us-ascii?Q?kjzT86N1wsnbUIb5djX8bBDgT4XeYte2OuFjTaktP8m8YUO/2H3MB2rXecuW?=
 =?us-ascii?Q?GBd0F1hcNaNSJ1ieQI+ThzSnLU9fGGiNar14DEAOKG/rf7JbE72rPEAKEpsp?=
 =?us-ascii?Q?pvpen/+N9LvFgTPglPAN1Xx5rCl95t8N52y1L6KAYaw+nwWYUJGWy9kPJpSr?=
 =?us-ascii?Q?hj8D/nCw1YyCqAW7Y+M8KWkh2tUziCNNREzF3qffivFDcS49eKeKvbw7dRhk?=
 =?us-ascii?Q?Wjetg6M/zSbpLdZEnMkMfYGXbLlZnbZXDhpL35UniZADmodil6JJ8B1B4I/3?=
 =?us-ascii?Q?m4Pi/nXeHjq51Hax3B7I5W15NCWWe89ijnVSLdVJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f398f6db-50da-4c47-520f-08db66295507
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 00:59:51.0159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wirfNJpE/yMZ84DRjlo1uze7Cyy22UQbH8Z4yMM3P4UyZPk0XKd4KBywS1vXEHpw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765
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

Remove the race where a hotplug of a device into an existing group will
have the device installed in the group->devices, but not yet attached to
the group's current domain.

Move the group attachment logic from iommu_probe_device() and put it under
the same mutex that updates the group->devices list so everything is
atomic under the lock.

We retain the two step setup of the default domain for the
bus_iommu_probe() case solely so that we have a more complete view of the
group when creating the default domain for boot time devices. This is not
generally necessary with the current code structure but seems to be
supporting some odd corner cases like alias RID's and IOMMU_RESV_DIRECT or
driver bugs returning different default_domain types for the same group.

During bus_iommu_probe() the group will have a device list but both
group->default_domain and group->domain will be NULL.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 78 +++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 43 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4da3623d7686a0..a797d860d7c511 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -131,6 +131,8 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 				      const char *buf, size_t count);
 static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
 						     struct device *dev);
+static void __iommu_group_free_device(struct iommu_group *group,
+				      struct group_device *grp_dev);
 
 #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
 struct iommu_group_attribute iommu_group_attr_##_name =		\
@@ -469,14 +471,39 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 		goto err_put_group;
 	}
 
+	/*
+	 * The gdev must be in the list before calling
+	 * iommu_setup_default_domain()
+	 */
 	list_add_tail(&gdev->list, &group->devices);
-	if (group_list && !group->default_domain && list_empty(&group->entry))
-		list_add_tail(&group->entry, group_list);
+	WARN_ON(group->default_domain && !group->domain);
+	if (group->default_domain)
+		iommu_create_device_direct_mappings(group->default_domain, dev);
+	if (group->domain) {
+		ret = __iommu_device_set_domain(group, dev, group->domain, 0);
+		if (ret)
+			goto err_remove_gdev;
+	} else if (!group->default_domain && !group_list) {
+		ret = iommu_setup_default_domain(group, 0);
+		if (ret)
+			goto err_remove_gdev;
+	} else if (!group->default_domain) {
+		/*
+		 * With a group_list argument we defer the default_domain setup
+		 * to the caller by providing a de-duplicated list of groups
+		 * that need further setup.
+		 */
+		if (list_empty(&group->entry))
+			list_add_tail(&group->entry, group_list);
+	}
 	mutex_unlock(&group->mutex);
 	mutex_unlock(&iommu_probe_device_lock);
 
 	return 0;
 
+err_remove_gdev:
+	list_del(&gdev->list);
+	__iommu_group_free_device(group, gdev);
 err_put_group:
 	iommu_deinit_device(dev);
 	mutex_unlock(&group->mutex);
@@ -490,52 +517,17 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 int iommu_probe_device(struct device *dev)
 {
 	const struct iommu_ops *ops;
-	struct iommu_group *group;
 	int ret;
 
 	ret = __iommu_probe_device(dev, NULL);
 	if (ret)
-		goto err_out;
-
-	group = iommu_group_get(dev);
-	if (!group) {
-		ret = -ENODEV;
-		goto err_release;
-	}
-
-	mutex_lock(&group->mutex);
-
-	if (group->default_domain)
-		iommu_create_device_direct_mappings(group->default_domain, dev);
-
-	if (group->domain) {
-		ret = __iommu_device_set_domain(group, dev, group->domain, 0);
-		if (ret)
-			goto err_unlock;
-	} else if (!group->default_domain) {
-		ret = iommu_setup_default_domain(group, 0);
-		if (ret)
-			goto err_unlock;
-	}
-
-	mutex_unlock(&group->mutex);
-	iommu_group_put(group);
+		return ret;
 
 	ops = dev_iommu_ops(dev);
 	if (ops->probe_finalize)
 		ops->probe_finalize(dev);
 
 	return 0;
-
-err_unlock:
-	mutex_unlock(&group->mutex);
-	iommu_group_put(group);
-err_release:
-	iommu_release_device(dev);
-
-err_out:
-	return ret;
-
 }
 
 static void __iommu_group_free_device(struct iommu_group *group,
@@ -1815,11 +1807,6 @@ int bus_iommu_probe(const struct bus_type *bus)
 	LIST_HEAD(group_list);
 	int ret;
 
-	/*
-	 * This code-path does not allocate the default domain when
-	 * creating the iommu group, so do it after the groups are
-	 * created.
-	 */
 	ret = bus_for_each_dev(bus, NULL, &group_list, probe_iommu_group);
 	if (ret)
 		return ret;
@@ -1832,6 +1819,11 @@ int bus_iommu_probe(const struct bus_type *bus)
 		/* Remove item from the list */
 		list_del_init(&group->entry);
 
+		/*
+		 * We go to the trouble of deferred default domain creation so
+		 * that the cross-group default domain type and the setup of the
+		 * IOMMU_RESV_DIRECT will work correctly in non-hotpug scenarios.
+		 */
 		ret = iommu_setup_default_domain(group, 0);
 		if (ret) {
 			mutex_unlock(&group->mutex);
-- 
2.40.1

