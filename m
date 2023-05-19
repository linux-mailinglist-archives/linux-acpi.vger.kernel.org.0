Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F18D709F3E
	for <lists+linux-acpi@lfdr.de>; Fri, 19 May 2023 20:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjESSmg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 May 2023 14:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjESSm0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 May 2023 14:42:26 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C43AE45
        for <linux-acpi@vger.kernel.org>; Fri, 19 May 2023 11:42:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3bm22A31VPOwA3BhEUO5y/0DDOUEVJIwHzrXQR82KK+g/jkTMDmHUBrWFqUwv9BFxAVSRT8kF2l1wZqbzIXe5hXBcDok84VHfzFn3MikN7WsU8amV0ho7uUAO+BjOQRSLiFQ+FkFxMb8+3GWaSuwty8kCOwJpbZV2/SeT43gp5ercGh2/kHq90/S7xBc7B3RRNwe6yBIhL0gjD36QKMg73KGYCFc34KONEz1jSl1AICz0erIBn7v2rhgnRu6o87OtTUAftml+f8u+HOxuHpWekP8UgU/CLxgMGd9Ls7aLokMC/amioMjMuEmM9Gsu/ZJItK677dKUKDEIuF8QiM/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jH9Jl56rSpnUcoEUOFPh2zlO+rLVhjBuds5HodTQek0=;
 b=Pf2l+h1bwPVjGZXVAb/74WWV6SldM3IB8qFi03deUJVQ+WPJzTr1ixgCC9luX2FrfUE/6Ydavgx4sYJr1PbmW+YoDeylb2/9sKQ+CK3upaSK+HB6+oqlMSStYoHYzNWiBpZBJcSBuCe4XECF4Ahmma9GvPtlJtnoCutq109hBDEOC0508386qbE7kSeVwjK+FjoamM0wrXvC0K6xBIQSfIIhOe488IP7jYsmnZHpBoiyFV7gKNek+hnkk/9NBiqEMAFalzZ6BJZdu048gzJdSZz2HGwXJvDFGxkbchoPG1+wehYtsGhIaBdKyXyQ41PJa6tfWn8xITlNb0bV100klQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jH9Jl56rSpnUcoEUOFPh2zlO+rLVhjBuds5HodTQek0=;
 b=IzEvg1ZOjrKVOpsM/f8Osw9TtSexu8Y4d1LRvKFgsWroyIrZ8yMMVrObT/qspdMWw8xBuDgg95LOX4eQ/4WVqWwBlhi0haNh+DjXsJkIF0rwhPomn6yn2z9RQn92pE5tsOxgDTTt40hk1HdgmFEO/1hvjGmfcfsYQhdWr0MV7HJ9v8d0f1lIkOS9fIuoCZTAP0Z8BWOTDsBemQ8hEK8mcNlMw7uUoUsemKgWSvRoyWqZC8YyZtDVcK1XgNZ+H3b2s/yXSbdL0qOd+vuVI9uRp7NT1giCWC+wa32K3VJKFBhU2x/6xMOZ4S5FCImkrW/7mjQCMFE6Lc0W4RgMOkkKFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4395.namprd12.prod.outlook.com (2603:10b6:303:5c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 18:42:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 18:42:21 +0000
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
Subject: [PATCH v2 00/10] Consolidate the probe_device path
Date:   Fri, 19 May 2023 15:42:09 -0300
Message-Id: <0-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0028.namprd06.prod.outlook.com
 (2603:10b6:208:23d::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4395:EE_
X-MS-Office365-Filtering-Correlation-Id: c90b8b18-c409-49c7-3aa6-08db5898c716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YRAvT61Hd+bsB/vPvZCOzmdmyoLvfdDIzZuE1bU9gBHEzFLfmlkTSCl302qiQPzfehhJL8imbIkvzDGLjvyBSy1pbS1pj6f3h+WGuy475oRGAfl9/vb6VGO3w5PTmdCByxkqB+V6AcDXOuijsc5GdW3UocQIwXHUqTh8hxSUz7zxd4UEnim+QRGQNb4AWFwmR1CtG4iRzDTU63nR5F//WHWEcpz7znRwUbDFj0wsXeTukFuwpsKYmbheTLj1dwCcQ1tHVSkVnLFJw97WvTEEnBFWLxP81IraSJuYewkxGmbnOUEDHyQW8D2+NvjJM1Ux9B7uP71TXDNf4GMzFFIBcesNbMlDj1daXp0EJCYppT0Ej/JjF+KBOcwPe/0IUezhRQD8QMw0QVWl6vfqbTxPUslRw0td5f4mWHB9PUjMzxxCQKT1KuqaOLhauDv7QfCBgUoQWafapNYLYd0jqncnpJx1Ua8C9WoJuwDP8GIDPetQJvEwQeB/PPRwjxpKEMauIoibUfSMWzJYHA2GueougydL6l5tbUqiJQtWRPNjjDEl6vZNMSU7KvNQ/KCxofCAArlap5Z63xzW4JBWXc4Xqw6CSmFnQpyJ2LSGgrp4aVk14KPxUJkryU3Wde6Cs3FAfZ8mHhbbeYArSTipA51FYYgSxV6iSsXvHSl+lVn5E8oH+ThJIsAvN1Iujnhdjt2B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199021)(2906002)(316002)(478600001)(41300700001)(8936002)(8676002)(4326008)(6486002)(7416002)(110136005)(54906003)(5660300002)(6666004)(66946007)(66556008)(66476007)(966005)(6512007)(26005)(107886003)(6506007)(38100700002)(186003)(83380400001)(36756003)(2616005)(86362001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pklTAl8hU9FSQEruc6OXEq5XAJlwAzA35gUgrlluCzJc3rW/zvfSQiMz6Qfb?=
 =?us-ascii?Q?uRCikdWCo1UFyv6dBPopf+AKvIzUZystylUk52IUTa1fObMZ2uklrjfagbRT?=
 =?us-ascii?Q?DN56KcSBbxPTz3gB6fceVQ1mOdYM7X17xlMVeQpqVqwjna9PnsVsQePOp9kF?=
 =?us-ascii?Q?KMlLEwyWlEV1i9GJHgsMbXjFpOZKUOcoLbQ1Zxq/tSCN7AXuJl2gCPSE6fbe?=
 =?us-ascii?Q?5C4xUV9Ua3imwlZX2jbq+FS4FWkrSDO1LY0ipDKVu3zBDihuOreq5cw3BAz7?=
 =?us-ascii?Q?rqNSsbVFdYHvt3EDtyTDqFAU8dMCTDeSfwGVVHAQVG4DZfMf8kQXIxoUqejJ?=
 =?us-ascii?Q?M4UE+w8I14+yLBdH44sBrdETiZp/9rI+W5WX6TpiV26uc/bY07qvg0eLBZLd?=
 =?us-ascii?Q?EoWcxk2lOD3KXgvdXFk79MFv67iX/vrpWMmP7Nmn98W7lsQFAs3UVdL5gG2B?=
 =?us-ascii?Q?SiPWAI1b1Ip37OPpCuf81yecSOPM/K/VXpWIiAgBH19Bi+E9GtWKIMknBmD8?=
 =?us-ascii?Q?Tv9atJi9hLQnDoO0B93/RJHUvfX43IH0Fqtb/N4PCATK97WlavMUnrtAb9Ps?=
 =?us-ascii?Q?dPsWxThjSSj879w2wjvUmWKpXiug596WBovEl6DD9H3NRkiVypo4OIZlaKvr?=
 =?us-ascii?Q?DeDzThfQP0XebHhr4YmLybN4/Ii2pqMsZI6o1tXCc5xlMDzYWuYy47fr0CZz?=
 =?us-ascii?Q?Dkip1Q8SR8CXEoGQ6rFf1JM27QnbtKKOJA28hJlHRoL/7QUQIYEUZ2SRJcd0?=
 =?us-ascii?Q?NiMFNsZsE8OOGb5gUgpUOmAqN9EUvoGbtuG6F4BmZo/52eVitwQEyWTXFM9V?=
 =?us-ascii?Q?MA0vs11+Nd6GN6Z6jegovZhMXdpQnFG/z0DXHz/G2NdqlLiWWpLyLVQgadF1?=
 =?us-ascii?Q?0ZWGRCKQq8PTuaY+7EDTvxwoYz/rR5ZnGxFDU2I3/why5HYUnU+aKigFFlK+?=
 =?us-ascii?Q?QCKlo88r5RFxKCd0EF0oV3ugouz1hV9Z9NqTRuxVGbwqGP/eV2zARdeoPRKe?=
 =?us-ascii?Q?7NNyaK7ucWJktn3zOVJBpGMvlodQthWM/c6nQCrd0Jg5V7FqCJCYvSceuavE?=
 =?us-ascii?Q?Wja1DpApO/ecB+9yfKtzmR67Mq4rwkLUImCSJsK56kU6JX3ZMvh1kAgtAfpw?=
 =?us-ascii?Q?XeOADPkeegprnY8mP0uBBQsn6q6TVICE1BCpyrxBJdtP+4Z63fr+Re7aMt57?=
 =?us-ascii?Q?7pYdSsWcZeAT0iznUMe3Y8qmgTZlSp+HNB+W3lWka/trrTEyke9yHiyp2CeD?=
 =?us-ascii?Q?EywUrMuXkRPeMSV4bfmbK1mJMlgzTJfO6t3BCXoAHwUD72amDKLbyfbA9bc7?=
 =?us-ascii?Q?LYwedOAOAr8FyrrGm51NCKraSjb77kEvbE0PBOM6WnYoySze4rrfvoYH8Tah?=
 =?us-ascii?Q?yIKJdDgFKCvTyYzecUy4FvVHyeY7E3bdcoIrZpBTSbeK/g1cmWMO+fAMnF8z?=
 =?us-ascii?Q?SRrjkKwqV2Oo8a92/IUf743EPAfKHl/3Wv/mB8ccQtlFhuQmm8us8Hb8pT2S?=
 =?us-ascii?Q?mQTAa4oIOsZ82vdBbYtpkbUlw6XbGMiOhEFrwycVpf0MWnRONUlwrjYH86rK?=
 =?us-ascii?Q?QB41/rgpJmGftQGZEcj0KjbwqlW+scDzpZc6hLkg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c90b8b18-c409-49c7-3aa6-08db5898c716
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 18:42:20.3175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RzusZkm4y3AnJ7VFR8uFeFuRP8YhWaiyL2BWgMIsDs7YR7l8p8o622je1juyscXR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4395
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

Now that the domain allocation path is less duplicated we can tackle the
probe_device path. Details of this are spread across several functions,
broadly move most of the code into __iommu_probe_device() and organize it
more strictly in terms of paired do/undo functions.

Make the locking simpler by obtaining the group->mutex fewer times and
avoiding adding a half-initialized device to an initialized
group. Previously we would lock/unlock the group three times on these
paths.

This locking change is the primary point of the series, creating the
paired do/undo functions is a path to being able to organize the setup
code under a single lock and still have a logical, not duplicated, error
unwind.

The reorganizing is done with the idea that a following series will
consolidate all of the different places calling arm_iommu_create_mapping()
and iommu_setup_dma_ops() into the new consolidated probe path and get rid
of probe_finalize.

This follows the prior series:

 https://lore.kernel.org/r/0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com

And while it doesn't really depend on, some of the explanations around the
add/remove group logic assume these two:

 https://lore.kernel.org/r/0-v1-1421774b874b+167-ppc_device_group_jgg@nvidia.com
 https://lore.kernel.org/r/0-v2-ce71068deeec+4cf6-fsl_rm_groups_jgg@nvidia.com

This is on github: https://github.com/jgunthorpe/linux/commits/iommu_probe

v2:
 - Rebase to v6.4-rc2
 - Move the POWER cleanup to an independent -rc fix due to the iommu driver
   being merged
 - Update commit messages
 - Rename iommu_init_driver() to iommu_init_device()
 - Simplify __iommu_group_remove_device()
v1: https://lore.kernel.org/r/0-v1-8aecc628b904+2f42-iommu_probe_jgg@nvidia.com

Jason Gunthorpe (10):
  iommu: Have __iommu_probe_device() check for already probed devices
  iommu: Use iommu_group_ref_get/put() for dev->iommu_group
  iommu: Inline iommu_group_get_for_dev() into __iommu_probe_device()
  iommu: Simplify the __iommu_group_remove_device() flow
  iommu: Add iommu_init/deinit_device() paired functions
  iommu: Move the iommu driver sysfs setup into
    iommu_init/deinit_device()
  iommu: Do not export iommu_device_link/unlink()
  iommu: Always destroy the iommu_group during iommu_release_device()
  iommu: Split iommu_group_add_device()
  iommu: Avoid locking/unlocking for iommu_probe_device()

 drivers/acpi/scan.c         |   2 +-
 drivers/iommu/intel/iommu.c |   7 -
 drivers/iommu/iommu-sysfs.c |   8 -
 drivers/iommu/iommu.c       | 462 ++++++++++++++++++------------------
 drivers/iommu/of_iommu.c    |   2 +-
 5 files changed, 239 insertions(+), 242 deletions(-)


base-commit: 8f6c3fcaa76a9222f435230972b4f0f5c3672cad
-- 
2.40.1

