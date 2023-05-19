Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9302709F42
	for <lists+linux-acpi@lfdr.de>; Fri, 19 May 2023 20:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjESSmj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 May 2023 14:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjESSma (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 May 2023 14:42:30 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A625FE46
        for <linux-acpi@vger.kernel.org>; Fri, 19 May 2023 11:42:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZu3ldiixcawenS8p6RNYgvP3e3YEkiJdRoQ1NWIX8LUFODx+u55QhxqzdpsNFfNkv3/+bFSmSqCxYdyvfidZ88NXksGPdE2qsZg8x0aKDYdQVRdL286MdEwkvP2u4C/w+Du9iwYcPdMzXgR24jGJ4cJnWNSwiK7Q6V0sH/18z3RkEk2dIenN9tHPKLVrYOmMq5H/+HyJZBBiP+gXX575EJ72m+5Zgt5/GL9tPGTIsBXTjIoCV+IomwoX0qSegDKkOKEjVKLsiudlYwt9s8R/vNWbcSNtyvV03SUw8AIs9A8LKcKzLEDfH26vp4BMNYVduHEUpDrUpJ5h6ty8GnobA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8eyityGz2Z9BPkDXqtjTwMJyakT/MLhPoAbbHxF9QY=;
 b=JgkNIjMm2AskmqbbStaisHOCLezDda94cb0bzZVouokxrw6CdWTaVunbw8e+q1tHYS2aLhQEIcCDjToF6c8Myai+Vi4uue4ae5h898R5D4tTq0QiGDJN4Wr374PWeMFQ6QZmimF2FxZaJCZEFvWGohx/0vdZxHhAumjz5bDw809MeQAa0ASDUl6/pRID6Qpo+0Z4I7QvN2s28hROPLhHBCW39gjodggbhpGizLZ3TAEyqdOMY3sSDBfyY5Swlxo8j48v003aKsSmvRfsqPTd6fnB47R84Ts1tBpM1Wmfsrz2n4yu7zyTgFJ4y0vwk4HMPSJ8NShYmAecxiJsTYG2OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8eyityGz2Z9BPkDXqtjTwMJyakT/MLhPoAbbHxF9QY=;
 b=sEggHflAevHd0yAq9/LKFNsqkKuFGOy1l4ZkRV+SmxInSrUiMhH4js64SB72mFG9vzO1iDtGSPKa+wyAJFInyiM45Q9ZpnOv7XCVs9SIDMezxDtehnF64tr92XBwshai033CpQjiOWyB+Fa6yjJM6UKZXqwa9SSHr/LievvqYWuRhE/skSMMlBapVr1fq9wdpmEYTsWLR61P7nlBQExeCBjGyRDrKW7jPPBtoQ6yMkp+DrQGilzJb35Vk2rRkLPyml1lDw1ZHvZ99QG8L9U1lQYKBYkG1srth5gIRNj40smsPOFv/C6TxtG3NruK5MSNFa1TN9XS2r7Q2cf6lJ9NQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:130::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Fri, 19 May
 2023 18:42:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 18:42:25 +0000
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
Subject: [PATCH v2 03/10] iommu: Inline iommu_group_get_for_dev() into __iommu_probe_device()
Date:   Fri, 19 May 2023 15:42:12 -0300
Message-Id: <3-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
In-Reply-To: <0-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0357.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: a4087fa3-a73e-4e44-19da-08db5898c79e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PMqT1YPDnGRobDGdyKflaLsFJNDJRWNcWvtbv5cpqhZfs5065pS3BOtP/6/SXWQdJoFu0AI/VnPOHIB/xRrQzdyzC7p8X7d4Kt1wfJBgZoaGJJ4trUNaDY/Ub9zjTnaSYJzLg4aQo5+nGb+VpX1aVLrIglVIMlg8tWgLmUl2XCDuc0CmhoAj96H3Y0xxY4GDNIA0zZvsXMUqMIwkhW2ni1V0BkC3ZhbLJre0tN5glLRebD6UP+5qtakscbJExSO0ZH6HGbSNxSHe4aqeum+oL2lp51QIx3TeaFhQD3cEsSTLJyrZ6BQy/8eGw7JRMo1Uyj/gEZcm+4SZF8xOwAajYRz7hrT+i5KLuJlkR18BMQNLx6OcmPzBgqPTV0nqmTLe9Kv/gwr7VY63RIohHzQqc7KbMFaYNfR/H6PzzoTcojdEQdXqdpsmOcJZRyMANAiM56P3cK9dnBKxX4Z2+2j3jfM4UeYvlxl+RHRtcaSBH8syc/2Bjcw7ISka23SUTAnFwDJY2kRhaZrrXhKEmPWzBL10kAPvXjXpOiTTVX30WdQGIvZdRMMFQQw/aYzMv76FdDcs4UQp/41138d3PO6O/BYyjV7Bx0jP9YRX2r7otAo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(6512007)(6506007)(2906002)(186003)(107886003)(26005)(86362001)(83380400001)(2616005)(36756003)(38100700002)(316002)(41300700001)(6666004)(4326008)(6486002)(66556008)(66476007)(66946007)(110136005)(54906003)(7416002)(5660300002)(478600001)(8676002)(8936002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rShZpthHw13x53VssbGTrnpaEQfDCBso2yfFLfpryjLNDEtKwj4LGOHHVvCF?=
 =?us-ascii?Q?f4/fxZp0MGahMlGtznlVhCwcMIgx8R0itszrzN+P1cSm0+TWYctqUJe/6rtp?=
 =?us-ascii?Q?Nh0wlbVhU3OaskfN6ElOTSwmZi7/aZOH20tvwwSP34Bzv1G/e5lTF39aa3Gu?=
 =?us-ascii?Q?iqpJCdSvqzYGqZ4spxrrjK66p9+9KQZIlhYiWuKOR9EOZuPqj16jP3M/3auw?=
 =?us-ascii?Q?dbVeIN+evNI/zPbyScqzZNiQt9zwlaffGkIzQIdB1bmHT5dLYrcNrsAJ6UBv?=
 =?us-ascii?Q?pTCC+OmHIEV8QWmZl88/wvEfdP5Ac5IpKEmlXIqi2cLlGMzsKLiVjqke/TIV?=
 =?us-ascii?Q?OA6IHfSJWq/trJjeDJOyzKnirGVxh8dOA7AvUd+2tKnzGixvhzEZOgLX8dxo?=
 =?us-ascii?Q?EIsLV/Cp9UXAYTYfRqug20Y0Um3BPWqnWjp1luw8vzPGQf+gite9j76EEzCe?=
 =?us-ascii?Q?80/n7zFjEimrgOs7QMZl90kvxf3dDLtm4GqtcF5rSoffx8sLi5ZY0mlDQ25S?=
 =?us-ascii?Q?h0oM1apmeOjjCxA1w6pevaEAU2s9OFWnU1puPOG4N8kg6EuglLhlS8fPOCAR?=
 =?us-ascii?Q?OVLwTSi6iPciTLNfLbMWLb7gdNdKg4OPbaRUGVzBswCQdHXjnSkx82i+r/aI?=
 =?us-ascii?Q?O6WXxMudCcAjhZsRkssFkSlhEF/0PBdqDwpY4GT4FvMOFinbTdiig5Lg8urN?=
 =?us-ascii?Q?VZ9eBvuZojXoVaZBJjxrXpsnUK0oFLyNmfyoPHuHM6MrBjIl8NfXmPnwJ92r?=
 =?us-ascii?Q?TicXyc99FwykpmKT7HyZArPaJbdCkQarhSqpjI3llaCBH12bu1pzTAtVYb0Y?=
 =?us-ascii?Q?2RqkfwSYXScfeU6yKQvO//mUtrlpZUvY3vscHqiVYgKpOai6+WCMZC+cKpVo?=
 =?us-ascii?Q?36iI1dQRjFmLCFcFrHz1VpKb4V5yK/x7wh9h9sEHhWNbx9VpUfJdZs4Kz9aF?=
 =?us-ascii?Q?W3Z4/cVa78RxwlYigq7jImCqQbK+oB/zfbCS0KdKQYivxLUX89nbwkZwNbl7?=
 =?us-ascii?Q?9l3dahwNiPJwBuxw67xMNta4G4vGg+SiKNUgWz7B+/YLDLFjKGnyU/ViqXTm?=
 =?us-ascii?Q?CCMcstV2qv9rjNsasCJmiNkgaT8MT/BUODVaLtNOcYWZ0NmoOpyP+bXsA5Om?=
 =?us-ascii?Q?JsQC4JU84+7P0CXeqcp45JOdhhJQa6DMUo6JBMm7MQXiqw2QFKlWlncYDd0A?=
 =?us-ascii?Q?nzKqiyVfvxR8AlFHORaLUjxPIO5/1H+YEsICjyBw6Zh24BYdfpkAXK69bENV?=
 =?us-ascii?Q?yvWB3KrjXupjv6WSKmSeTZq9fWi1Ekz6n14U24p8sC7buInHMNCO83ibO1Dk?=
 =?us-ascii?Q?xJXg0hhw0/2epJR6Q0L5hHgvmUf3hh86AgveROuqXP+rENVAqR0KbdNwTvYo?=
 =?us-ascii?Q?ml51pvxZN+aywJPVTVe3j/5VcdKeMM+IiIfikn1oHw8hGgq1n5brDnLqIxVg?=
 =?us-ascii?Q?U6FDsPEII0cNqqpl32DsoZUMSJnpmto5HxtiULWoM9On1c1IvJ9d5iPTONr1?=
 =?us-ascii?Q?5DFJlnzkxeE2cph32v3Ge2P67LY57xpSS7o5o8Vk9u8rNc41HNy2R6J8EwZS?=
 =?us-ascii?Q?65VN37tt0QARPCsw1tIq4mtZu78UtBk2UOGUoCv8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4087fa3-a73e-4e44-19da-08db5898c79e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 18:42:21.1854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Shj7aqnkhPHd94Take0M2oonw3ZPge6g/baocjIfDtNLwttci4h3rC9Y5nMBaWUN
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

This is the only caller, and it doesn't need the generality of the
function. We already know there is no iommu_group, so it is simply two
function calls.

Moving it here allows the following patches to split the logic in these
functions.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 50 ++++++++-----------------------------------
 1 file changed, 9 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 35dadcc9999f8b..6177e01ced67ab 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -127,7 +127,6 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 				      int target_type);
 static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
 					       struct device *dev);
-static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
 static ssize_t iommu_group_store_type(struct iommu_group *group,
 				      const char *buf, size_t count);
 
@@ -379,12 +378,18 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	if (ops->is_attach_deferred)
 		dev->iommu->attach_deferred = ops->is_attach_deferred(dev);
 
-	group = iommu_group_get_for_dev(dev);
+	group = ops->device_group(dev);
+	if (WARN_ON_ONCE(group == NULL))
+		group = ERR_PTR(-EINVAL);
 	if (IS_ERR(group)) {
 		ret = PTR_ERR(group);
 		goto out_release;
 	}
 
+	ret = iommu_group_add_device(group, dev);
+	if (ret)
+		goto err_put_group;
+
 	mutex_lock(&group->mutex);
 	if (group_list && !group->default_domain && list_empty(&group->entry))
 		list_add_tail(&group->entry, group_list);
@@ -396,6 +401,8 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 
 	return 0;
 
+err_put_group:
+	iommu_group_put(group);
 out_release:
 	if (ops->release_device)
 		ops->release_device(dev);
@@ -1670,45 +1677,6 @@ iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 	return dom;
 }
 
-/**
- * iommu_group_get_for_dev - Find or create the IOMMU group for a device
- * @dev: target device
- *
- * This function is intended to be called by IOMMU drivers and extended to
- * support common, bus-defined algorithms when determining or creating the
- * IOMMU group for a device.  On success, the caller will hold a reference
- * to the returned IOMMU group, which will already include the provided
- * device.  The reference should be released with iommu_group_put().
- */
-static struct iommu_group *iommu_group_get_for_dev(struct device *dev)
-{
-	const struct iommu_ops *ops = dev_iommu_ops(dev);
-	struct iommu_group *group;
-	int ret;
-
-	group = iommu_group_get(dev);
-	if (group)
-		return group;
-
-	group = ops->device_group(dev);
-	if (WARN_ON_ONCE(group == NULL))
-		return ERR_PTR(-EINVAL);
-
-	if (IS_ERR(group))
-		return group;
-
-	ret = iommu_group_add_device(group, dev);
-	if (ret)
-		goto out_put_group;
-
-	return group;
-
-out_put_group:
-	iommu_group_put(group);
-
-	return ERR_PTR(ret);
-}
-
 struct iommu_domain *iommu_group_default_domain(struct iommu_group *group)
 {
 	return group->default_domain;
-- 
2.40.1

