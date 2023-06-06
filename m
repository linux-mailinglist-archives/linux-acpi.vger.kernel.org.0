Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE33972343F
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jun 2023 03:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbjFFBAX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Jun 2023 21:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbjFFBAD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jun 2023 21:00:03 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346D310C
        for <linux-acpi@vger.kernel.org>; Mon,  5 Jun 2023 18:00:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHR9fPlaUNNybOoW1Kbtvpz21D5rbw8+W+QpmYnkCf0vy6oL/AjjgqAYJnVpSzzaiuJfFX67TXZQe7qWfjeXuPcTFxS57R5qWEotLCfrZdYYBYvdrL4X0To9F21ABt9thoLrtnHti+ppIOF41UeUUfUE1BStwoLp5BdZMWHi8V3A3eDcEsC2mQwFQYUjd28dXAVN+qIyMR8OphYLymZPcZC/ZX5zP6AyBjH2cmYyVLee35LlfjwrS67mNXEISYqF9ASx/w0w744r9j01okCuQb4aMQMTaMjjgTP1gWt/EvO5nSY+zFLP/IOCn8M06UiNRfBpdwy9k0drO40MTU+NqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqumP1TwnGsdCBdnFQgc+/cmD85C2CTFGgn+PqtoZgM=;
 b=DsPmyZhuIcvVtAE9bqt6/4Td/4FpGILG89LxFmgbuxSVmJbtAx9r5PtCz0wBktTmbjfxNECJOzouJdLD5cZVWPzKCMNphhGx+Zh485gOFIdAVKKWEDWxdcJqpIl533BPgx3iCvlC2h43GBU8pwCFM1RTCnkV4YUn9dIzw2SjT4KmglsV3dHFAqrcvFlTl8ozZGYGwM6WU8DjGDIgKjvtm9Tsaz3iu2gUKtKwQIEd/qQr1gvzE1mNrRiorMzF8efyM4C5cbhdAIQTW8EapcPbD/SQbdjd0f59RLr4KpkuMQHxM+Hi0xinS0+lvtUqrEYVv/+eNHUr/+pXz7jddoS0eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqumP1TwnGsdCBdnFQgc+/cmD85C2CTFGgn+PqtoZgM=;
 b=qmL0Tu8lLTgF/UYn6MY9Klz2410AYWmdpBiKf/Weq2B1zppIKGqekuzWO+vzsLTFiOYr7pS+ssPqg3wUyCR8ucO8kNfm2lyQUt8bWRHcX1AOXGfBh0k4ZnJ51doJzsIF5+UAd36vgFAaU5Nl7mL8222IM+Q9KtvzPSBKzEhISly8b7bnlBVJI/dH0ddLz9lzK9Ze6mvW+cjZ5KzvNtuA+x38qG20NaDV4qFk3l9dtCXKJCM5i9yQbaaxpACI4lhpCewqtQXYpSXzMp37I2sAwoGwByHY88XddzSdqOQvZEPqsZGiUJaasjaqwzy6/udeGFxs2tQ7hhoBdGL2Dyp9aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 00:59:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.028; Tue, 6 Jun 2023
 00:59:58 +0000
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
Subject: [PATCH v3 03/10] iommu: Inline iommu_group_get_for_dev() into __iommu_probe_device()
Date:   Mon,  5 Jun 2023 21:59:41 -0300
Message-Id: <3-v3-328044aa278c+45e49-iommu_probe_jgg@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5af472db-47e4-4a63-f350-08db6629574c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vm9sVFdF18/zsshs9k4cfXlPUla+1AxcFJU0bZJM5u7DsKYd3MyXRmz1TGORvRjRsNq3QJZr/KoFx0kdHQizOayjS6/TpOhZmcb1kU0Q/HrF1UPsGHdpSjG7vFkfJeudsb54BUGN5c3UPXU4okolKYyn94wjX2dz2N3zHRVyzjX09e7Q0iC+swPr1QzpraWEus0dE/y05knPwQgrciAwbrCyjXF8+rtPkRvS9TrK+l6KJg5+wkidRJCqhVJP73OUAScMHlwqxlJyhb4wXOKJt2T39hKFgEaIPTLrcxayst+vrr804UMQQA0KA+C4mHehlftVYMmqUJ98prvkmuPNHS0iErZ7oKDuLlK5yMIlK/TSNNIz5+DkVV/X7xTsc2G5QqW7/SqirMSiA2p6mxB57bjpy9zxFhlotyMTlv+s6mHewc0VGlpYiUF4CfnQmXSn/drAdFScCFPXm5MUY7e5KB4I595zLzFikGAjnKoH2+Pa/bUVrms0wIwBUCHiZdKG5Yo2opWnm2W6BpIN4YRFIvAyyMUK/I78mKtMCKHAGoJG26wPlVYu0xx72+ifrKEUsyAJPx3oSVra/4D4IeYSEfRQRA7Ks49SDKwu4QHCBrg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199021)(36756003)(110136005)(54906003)(2906002)(478600001)(86362001)(38100700002)(7416002)(41300700001)(8936002)(8676002)(5660300002)(316002)(4326008)(66556008)(66946007)(66476007)(83380400001)(6506007)(2616005)(6512007)(26005)(186003)(6486002)(6666004)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wtR3FrXBvV0i+Hs3vVDJk4F6AO3/0hKDvSisLwK4VAD8+4RG9Lm2AEsN6ucb?=
 =?us-ascii?Q?Itiy69ESY1+Knb0qvOR3qfNtHt1gnO8mpBB/itthJgPjfTkptPRvMUQ3oXek?=
 =?us-ascii?Q?9JBrTq8dcT6GqqAHZIu2W/fzqboTVWGM3DBpytFoXZGIHGMuYjQulHtA7EM3?=
 =?us-ascii?Q?QmPpXhn+TGp7acnr0gH1+lqTrbfs04C9gG8CtUrHSPUBUXcQuQfW4ob44R1g?=
 =?us-ascii?Q?v3dtupDZSiDTON8ESa7tOd/79n/w8rN/bz71h04mojhikkOHp8EPabGupfSR?=
 =?us-ascii?Q?ubG8WM6jB3hw9etIE9jxAUgwKBp8XBxWn6QOeS6FOdoJ54vF+Eggrab0sAjo?=
 =?us-ascii?Q?jgzv6Ce3XcEUssuqMNClywikfImyVcc0Z0djRirB3Lwg/I3X6ZqkKJJDd7NP?=
 =?us-ascii?Q?usNb8MjPW/hHDFNwKUwbf7JmpBbeYqaGo9r0OoFbZyV/S5cuLJ5fErURf77d?=
 =?us-ascii?Q?EJtijhRRgg5phHsKbO5sA1O5zR0/7EIvBpiXKLI/vPlfoKrv4PDSkK956MEM?=
 =?us-ascii?Q?9z4w7JVrnZKod/TzxDixTRCmxB7GbXmUelFtkDqIO7eNi+0/dYV+M5IqBGyc?=
 =?us-ascii?Q?nbnJQIvCvOrpHUxcXlH2q5hhmY0mHQ0sFQS3aeWuB9aIkq2Kp7HPYtfq3CEM?=
 =?us-ascii?Q?1OXD1EO03Hec7Y+YHR1uODHy9kTa33zz5qd+bCKoX/ZGgJTxwdT0WiXV4Ka8?=
 =?us-ascii?Q?kG9XKO/fX+yTkquf+chVo8O8+nL+m2P+IrB9Hfn/WmJxz9RLXKzlsp8wir7X?=
 =?us-ascii?Q?MsJsirLsoAygwmk70WYoGvvbm2I0ki02rKers9skj8Kkv8ql9x0/seySyYTF?=
 =?us-ascii?Q?eO3DIPCTAe8Tv5wQ8b6QxdqU9wL8gl+fZRZSFweh2hvhwhLjjh2FjYvYFNO5?=
 =?us-ascii?Q?ceLiSplT+SEsfgMpbHQOXe/9xDZn5LvOWad0WAehIObfEJbW0mMme2oz8F2W?=
 =?us-ascii?Q?OEN9HkV3UGBCEggsRghAmZP0Qyr09BabTObiRw8EExpC6wpCd/SVDVKfzHqZ?=
 =?us-ascii?Q?E9jdMVTN0BKEWVtIczotWQsZQW6H94f4l2XF9X/2OK19zchr8Qn5ZMFb1y/1?=
 =?us-ascii?Q?9tbMDq+bPhu4GpL6GYORTF6VZMpqaBxP8/tYnUGoAbx8IXmf0sNnaJWQf1rf?=
 =?us-ascii?Q?mPKW5OZzJiWiTB6/puLOKfK1XFD+Lz5CH7bwWZ/t0N46wfj1znCERmdfhFMm?=
 =?us-ascii?Q?dRzMq5WB/NY1V1NoK/W/ivZiC1aQmG23tjHlyX4Lon0BUqY7uHIYcY4ahXDA?=
 =?us-ascii?Q?3J8ptMspVh7ZJ5KkjaLxNGxHJG+iF+NJ1fYKiLMeXrWZWWaLw2dfIuBawwrd?=
 =?us-ascii?Q?2gHgG31ga/CTkI/rwsbsgchnldq10EIN+xgbR68SHNaLlbvvrs0gwtIQdSHB?=
 =?us-ascii?Q?OYHaCTAgCC4dd2YrH7jrS+HhIxogeOS/bPovg86H9EbeFV5G/iG34zlAcWuU?=
 =?us-ascii?Q?96anmkNC6PNatevypzdwvC3g7a9CKOBFQ/ZH5tZpHyi3hWhrYIeBvwCuZ9a6?=
 =?us-ascii?Q?3BKtOCMuGFY+iDyGtFooJyG8ABRDLW/ctszcHF8C/1GgJogWj5uKY6zSYAEA?=
 =?us-ascii?Q?uKqpFK+Zydo2vsp5AHHaEEDkBGbqMpsdmuBwoWMv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af472db-47e4-4a63-f350-08db6629574c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 00:59:54.8202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GmKMU0ZDmNqzstOZBa+Uqex7mT/CepH1mqEl9Qoi5ULhq/grjv0z2EiUV34aL2q
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

This is the only caller, and it doesn't need the generality of the
function. We already know there is no iommu_group, so it is simply two
function calls.

Moving it here allows the following patches to split the logic in these
functions.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 50 ++++++++-----------------------------------
 1 file changed, 9 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index aa162b48c7dc64..480a3640d94c3d 100644
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

