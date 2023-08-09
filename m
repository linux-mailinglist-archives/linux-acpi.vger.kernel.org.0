Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4864E7762C6
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 16:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbjHIOoA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Aug 2023 10:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbjHIOn6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2023 10:43:58 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F67210B
        for <linux-acpi@vger.kernel.org>; Wed,  9 Aug 2023 07:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSYTfR8OgPmEoCmhG5DjVNFMZNRscXOeRJHLfTtMlNMuc7qyZY2iV2ITu47J6CuJiJ+jgGYEjtmCG1heWY5ATQqsjih2C3w5t/s1i6kpQ2MqKzswOW2ABOtJ1ZL/DQcf6ZgaQc1jYukdgBX+9xTj2/gclFu+psScfQnsuxE1h5LRnqB9kYnhMxGP+lhcL5PUnIdEwmNo4dHfMPGKQ5BcPymHVmCgZDTRLF3srm6lt0ilyBfLibx8DhD9bKj7STVGa3USkkKnvCYXjLAXJp6bzMKyPOczL1CPSbnLQEQpKjHiWrlglT1DR4dbJ8ePCdC0ov3Q5Sje2Ka5lpZdjXCaTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVU9xQXGUwb2BJP2PBDltxr922QF7zao2nZtVwfYBwM=;
 b=h0CgvAeEulK8NBSsMw5c8kzVz9qCaIpYPoLVHGlQgHd7SPmUcJXdl5mRYx3WPXedRxJ7uM3YGQP8qa+dCcLP8BNdNodsK81qqtt51ZFSsU0z4r/PbpbTU7LrJfdPAc82IcIZA6fD/4WKT1YtKtwjK/m4Ols17qR7VzQqyBfXndDrB2TCQZmWtgZJkoKv3i6RNm7GORohic6ylYwLA4SvNDzRzMBofaJcmgMFJVVDrL8fdaEn08KpsR9RvO+QxE9C9Uik+vDMI3o2FJCddCAo23Efu/e6BKeBcq3cvDlPA2Mx/z/91CSufl7TGgwo8cvNuyvtpY/d9abehblTz79jGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVU9xQXGUwb2BJP2PBDltxr922QF7zao2nZtVwfYBwM=;
 b=coRTLBM0lSUAq3RMnPvZZVGPVTHYswE7M9mlCQWrAUD0vBEC785uuuPXJfI1BCryb7+JgBAtMELTBWD9VGV1bVZ578ahN6QFvfvFTpch/yAv1iJGSreIQvYo2FQOOY/OOS7sbNIj+A9LylHxvM86xHo7ayVnQkbm2nUvrpG4Nr4ZM/evzU2t8SsSYoHfErlUbvFa4BncUT6ue9TpokiDvwIjiJ2/lLMCmiE0RWqT4sDq6xt8Yp8arl5fV/ncrssE8oKg2rqCjwDupkoTbJnj+N20SQ9S8CP9OdrdlD1jz1K05RPglRBSZDrFFqI++ubU9MwfRww/lT5f323Kw1FFJg==
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
Subject: [PATCH v2 2/4] iommu: Pass in the iommu_device to probe for in bus_iommu_probe()
Date:   Wed,  9 Aug 2023 11:43:48 -0300
Message-ID: <2-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
In-Reply-To: <0-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0064.namprd15.prod.outlook.com
 (2603:10b6:208:237::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5059:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e16c2cf-2f25-4e71-c5bc-08db98e70c63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +8F1o+8gggqk5QxuhVH0Zl0zEHwbJfs1EVMAMpmBqybAo2iEfYxulHJbXYDjnAITSnarP9NYVcFxM2UwZgdWh3zEwMXLTCoxV3AADWuAZXPQoTstm8Ds294c1UjoJ4cNHbUWz3DDz+83i20bRLZsR6c9kYS3gDbG0PsGJQWG1Evq0OzqLYxp6mnUJgB89pfAY5pXIHZsJQ60FuCExbiPHRjpZD0u+64QPLwc4ejKP9ziGgwz7hop5QRZsW7IZrNSo5B2/a7+dltIfCsF92R+qDx0Pey9n6HWZGbMyW8QACG/Km8aq26cIhdSlVLEnhIZdQzavhKsjD5QUPRP9tRO8mN52abmbUWIJYs+a8pidgcuJ9f79gcQhBK3xUaFuUXVJvPkOeoffZhdB8kgtfVa3BjbDEbVjVV4MxwjkkumzYioKVdxDVmKwfF52JL9wDQlgIHUq3yND0lrR5tGeW96SQcbNLtrRWMLpXxr7OV+BdmMv25FapigO5f9m8J69I124QLLUccnqQRNyyYiIfj2axBq/d78gGWcuIPNILzeIMEj0+5FDGbTG6XqCY7F5WYHYojQvDz6FDDXmWcvUC01jgkuKMUOab82I2KdS6c2H8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199021)(186006)(1800799006)(36756003)(110136005)(6666004)(478600001)(66556008)(66476007)(66946007)(54906003)(26005)(6506007)(6512007)(6486002)(4326008)(2906002)(41300700001)(7416002)(316002)(5660300002)(8936002)(8676002)(38100700002)(86362001)(83380400001)(2616005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J85xXTTW15tMAhTP9VCrjneossx3Ofi24XQMJ5G+oD43PurpXEP32LpyNk8T?=
 =?us-ascii?Q?8BVh6SK1gtKsSGFGeaeEJFD/7xMBPiU9ACIIk4kPDqMNCVTGMO7doGeNINdZ?=
 =?us-ascii?Q?JvQf70zCInnM6cwnqqoMdyiPsIZW7Yqloe7ydvdajF8145NZT4k0LIX6v9N6?=
 =?us-ascii?Q?anQfKCIajLJzlWtVQAMDaiGu+UaTA5Qt5bcsqXkkcG16Ai3gaNjtNMeCq6BW?=
 =?us-ascii?Q?vZPKvtSOJvm34pfdAHRyx2rupBv9t23gj8R2QPy5sP2SS18rfUsEzaIBInEq?=
 =?us-ascii?Q?YplDRYBwpmbNHkeikk5m4/63+Wl6IRg5hNOBPxpQOHH2eLfCjFK2JdkEfgaj?=
 =?us-ascii?Q?ldKuUJpnIChSTlEQolohT2gluuVFsQX4ZljnyEhqN54EZ+WoSeeGo+hxlJMh?=
 =?us-ascii?Q?oMwLN7/yCnpyeQ4GZ/lddU5zOXCywsaaYabttRHfrvWU8gI1XHVazpYAMZxx?=
 =?us-ascii?Q?5O1V4BwKOZxlQsBzm67zE7PmKXjjDWWbSwL9cO/Z+NbchpNXKRnnulWtPZ3e?=
 =?us-ascii?Q?7BmvyIvuv1wmMaYWgbdjSGQLRlP3/Al+YBH+0MSxJCAFl2tCdmItfeCjc+Ib?=
 =?us-ascii?Q?eMTKMqEiO1m9pFmSzRMybmoZka7GZ5FsYbXl19YflSTEA7b4vtdwzBZf9E6m?=
 =?us-ascii?Q?fn5QXbXNCjsql9/3tSF0RhEKQYdURcgZrBgmdXsgVKl5sBr1AatMIMh6h1yI?=
 =?us-ascii?Q?+CEmc/9JWfn03Qzb/BuHoyKj6a0dgSuctiXMjcHXAErbwBayMe8XiqPm3uvc?=
 =?us-ascii?Q?CBYaXYQwb9HUpdO2ITI+cE8AGcoHhOnD2KErsdwnIyKF3jD0mYcSn6K9rFFv?=
 =?us-ascii?Q?M+6Dp68zGTrnQEo2fSOVA+v0SwIPJ1xkBXhZB8Wu4UBm4j4jmf34eII+Q/gE?=
 =?us-ascii?Q?efS0NzdTrWiDoiJp25skfAEOQvfz5NosH2BKyrupGayFTU7j0W3oewF0n6uM?=
 =?us-ascii?Q?apAAK8noC/FNAUca8jnPcoXbF+5XOpydGht+jyIauI0bSZ+2ns7SD1vzL3k9?=
 =?us-ascii?Q?mEZjf1LSfOfgk94zvUgtQE6E0dXIOZ3seoakfwQ13fyR6f0bKyXZ0XwhcLOR?=
 =?us-ascii?Q?wft+dYUHvX+WUguc6KNbxUc+iWutuudltAy27cGsRLcDvE2hR4uVNemrtE56?=
 =?us-ascii?Q?/0nPPhsEhdhY7+e0w5Zfrr1sPFWndPvH2rtKg272MFCU/N5YRUdBrgbGVjQ9?=
 =?us-ascii?Q?x99n/Be7z7KCIbZeVrga9KQp+ojBntwu2s740K0H6FAS27KMlyOtSeWwEdKx?=
 =?us-ascii?Q?8WgaiLk//dmVfYD2wrDm+FdKuCU1XIr8BLwO468boL6KOdnase9zY9aDsH3K?=
 =?us-ascii?Q?kir6M9w0TK1A0ivjFDGmSivD+sxBWRxowc2lC6ZMldRdgNntmNUNDRZWg4C6?=
 =?us-ascii?Q?u8XiYdsJ2eTRM1tpNxYbcOkMYl8lwYioeg605u8RrZz1kRew7zADZJViTbjl?=
 =?us-ascii?Q?8GgtvkUzrLBOtVKpDm/u3tH0w459jcUFjg1lUv8ixGu/tDqnENj0kwo/8OdR?=
 =?us-ascii?Q?kdwFwm3Omurc2zvo8KR3reaImWlAb6cbjfOaBdhWPExjMR7As6+doapZm8Rl?=
 =?us-ascii?Q?DsHVnxTNZgmesA0beVmNtjAeu2lZXgXHxTLZagW9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e16c2cf-2f25-4e71-c5bc-08db98e70c63
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 14:43:51.7312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgPi3bcUWGxMCtlgTBTYQXPBoqikdddQYK+knsDFejZoP9/1IwkdpE6zciBNPZJm
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

This is preparation for the next patch.

Each iommu driver is associated with a 'struct iommu_device' handle. Pass
in the iommu_device to bus_iommu_probe() and all the way through to
probe_iommu_group().

omap is weird, it has a whole bunch of iommu devices that it creates a
struct omap_iommu for, but it only registers some of them with the
subsystem. In the case it doesn't register then it has to open code the
call to bus_iommu_probe() as it's omap_iommu_probe_device() function is
sensitive. Pass in the unregistered iommu_device struct and move this code
into an else block since there is no sense in calling bus_iommu_probe()
twice in a row.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
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

