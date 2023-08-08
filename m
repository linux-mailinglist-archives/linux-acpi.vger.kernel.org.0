Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC226774E39
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 00:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjHHW0Y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Aug 2023 18:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHHW0X (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Aug 2023 18:26:23 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41E4DD
        for <linux-acpi@vger.kernel.org>; Tue,  8 Aug 2023 15:26:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOhm3gd2GEqpqrHLN7GjEoYYOyyVWIr04wqq7r69kcj+aXbEJgZQoqtZg78kkC/ULs+SxfSVdd5ESuMNDNSEOP73lcyHtCHVbHKRAS7kjxUeEqio6MwpWRykzdBdqZeBdw6EDTjmq050W3MuBZm1uUq7dxs3n7uILCEJvffIFMY6RtF3hGmDoLACsmsRll/HbVRX81BdijigesMQH+L8xmYPVStn/xKS/oW/S/CE94m1qmMn/89dB2xH79Ll/BtFbXbKRCaLr7LEf8BTEHg1tGe0yNS1fuJMt4hdArO6COQZ4LJ76wFeCjvr/PDBQujXpOzw9mOlPND3C86fzr2Fdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lWnudNm1+nGGo868S4i5wxJrwA0IBIn+tjX/jRdet8=;
 b=bknF2I/xX0Gzh5CvOmz3uS3wBI9lwnGw+sfipyCT/cFA35EDO49KmGSYMvsMxZjfhFTupJ58YaibKhdqXRPpKhx91UwmJMrsiGUM7ZO7S3MqwtBZsbiGv++bwHmP+DI32AYltowi0LgAtP+U8K3xEBTICXwh8rsUpkydw7nteEsGROdGWNxcxO1Gh1FqY8kuhYphR8J2fuxCktWKYuf3SR861Ml4VBnsSBnf8txjg9VVLI/JTUIJ6TsirNCvC8oXdk68d7vBUMtNYKRg3Tz5JnRUklftBnoqz+qh2f6U8qHY/TDm14bZbXlJhHqexa3f6VVtx8Msh5Mwg8CL5Bg0/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lWnudNm1+nGGo868S4i5wxJrwA0IBIn+tjX/jRdet8=;
 b=QBqKHsHTK7EhIN/1rb8k/03IYRZvB9hmN0Dx54x9Ys+7pxpF/5jyPtO7+Dydbewh3mmXUyWTgtmJmycf9QJQjOcFGZHXihtISSU1JeXVOvOR2YeeXS3dD4PEZjEN6H4QY9GHlq37/KexpNdpv8CHfB80TunzmNwNUC+I6eE2OLy7tYYdr5Doh796TaG7EP+EFVwzc8zMdXBbIzeWtf73OwZPdZFwljKGZRfeh8MiQwwuOdUmwuOXkmktlL72tKEBzsZmNOdQO60+QK9CrVlplh2+I/v9LjbKR/osIfAPMrIn3XPkoEITNfn/OIzHAoXk66f/vLE1/dt1Hz2kqDYMgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17)
 by SJ2PR12MB9238.namprd12.prod.outlook.com (2603:10b6:a03:55d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 22:26:17 +0000
Received: from MN0PR12MB5859.namprd12.prod.outlook.com
 ([fe80::79ca:2fea:f0a2:d1e9]) by MN0PR12MB5859.namprd12.prod.outlook.com
 ([fe80::79ca:2fea:f0a2:d1e9%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 22:26:16 +0000
Date:   Tue, 8 Aug 2023 19:26:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chen-Yu Tsai <wenst@chromium.org>, Aishwarya.TCV@arm.com
Subject: Re: [PATCH 0/3] Fix device_lock deadlock on two probe() paths
Message-ID: <ZNLBB64lnWZhJ4vI@nvidia.com>
References: <0-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>
 <0bf0557d-1dd9-45e7-a4a3-8b2527eeff7e@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bf0557d-1dd9-45e7-a4a3-8b2527eeff7e@sirena.org.uk>
X-ClientProxiedBy: BL0PR02CA0091.namprd02.prod.outlook.com
 (2603:10b6:208:51::32) To MN0PR12MB5859.namprd12.prod.outlook.com
 (2603:10b6:208:37a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5859:EE_|SJ2PR12MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8e5155-506a-407c-30b9-08db985e7ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HN7pKQGhuTHk8b1UvhZMfqtThHz9BRZCNU7TdvqMnwrCLWhmDbBX0g4Bp8jI2wpmUZW7WXYbBT33fbb8pwv3hQgs3Cmvo+Xy9H+Adw5H8FUQT4bMgBy8OsqNCSN5wthmyAQdTZnupGePEM1T25C1AhzaToRSwwR4HZuNhPqAhlCiyM+YmPljbAuCU4MLTGC9+oPQtP8yAADsowNbcBT6VI6pE5+/Iv7K5b5O/G/+4p6brmGYpJ++sqEbN3P4k84PrJPEsBUcuyMSreG4SgoDag3uls8NoIwHHdc1/c/ISzI5pN7cydb1GTYlq/HuEx7TCek2dHmmuLNYbz8yrNjzQXtb1GJxBUzfO6y/CN07Hd463KfmKrLGrj7Agi1XwbT2oGD6KI91T7dKWyEubqnRRHXoEVHmFr31zDCIJWvqeWkkRg4JbOX3rOAggvOypFEPsBSsu/syCeJXsoTPzsa6DAzFS5yCE1Fj4ukWO6N8ARX4vxAdGOHu4QEqa9+XMl1rx91kT4sr7DA0/+EbsnVOnG8nUd4SrELvcXIW4JDEhlk8V+IgTDdSAYgHKk+9d1lc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5859.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(1800799005)(451199021)(186006)(2616005)(6916009)(86362001)(6486002)(478600001)(41300700001)(6512007)(26005)(6506007)(36756003)(7416002)(8936002)(316002)(8676002)(5660300002)(38100700002)(54906003)(2906002)(66476007)(66556008)(66946007)(4326008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W3ASpBKF3KDbwJAnkCCiRyUjjMuKUkzl8i/FDJ2APwVDAAru4DJtDO/A/K4/?=
 =?us-ascii?Q?ii6Hd6Ak47b3wnRnmdHVBd0vZlbQZxIYVttY9pyRxNiRHw0EuwTCLDUbttBQ?=
 =?us-ascii?Q?GVVXqopHk0/QLXFxZEVjOlD3ilrvwB0N6dcVNbZkQwGaEbMNTMEVhgljIvdm?=
 =?us-ascii?Q?HDMGOsLQAdovJpbUEwunY1sqYJHPNshNMQQjHzkFyvuvMAM6x0d9XKUqc3GS?=
 =?us-ascii?Q?880djGnd2Qv1bXVmtOYgkw2siC5zxHQJArKTID8ql6USoC0amawdF3JJILsY?=
 =?us-ascii?Q?YAwSL6d+lvje2+w4KOgaSXgC71D/K25F4N9NR2+ZHZnDA2vIkZ4NNxY60mBS?=
 =?us-ascii?Q?/Dd3z6rvO9rrDlhQpQqWahL1LD1zCwEAgIJNtVyGU/uqIoI2DkQ5ZpydrhNq?=
 =?us-ascii?Q?ysN73AzG3yR4EKLxhoI9Bri1PTFI7ScWXK1YULjwKd7ANVYvmiASPIQ+CErX?=
 =?us-ascii?Q?jc+vtBxJNi/fqoldDSLKVfbmwTmIbafPV+5qf2w6RwvwmDoTNuai1UGTJBFn?=
 =?us-ascii?Q?oUqeGN9ehs5WzN9mdEajPrsZagH1L3ItKuxUuFqAGTPmcalRA7hD6/bU0hGg?=
 =?us-ascii?Q?zWq5PDtaQn5rHZ2NuPbNAY/kQq5SC6qaGTx+zG6L+b6dokrs1K0uIFEEg38D?=
 =?us-ascii?Q?Xa90bbHghPb0Q1RvGtMVxoc8HxHAq/v8Pvurh4igIffzZua5RXCGEaQ49DKp?=
 =?us-ascii?Q?c+n5A6+/ygTid30hPxmrmA70I+b85v8OpjH5FWzlHyin0EI4FOR9L8NXPsRe?=
 =?us-ascii?Q?Uwb5nzSGp207re8ckiAyHg/KIpDfX3ZoDh/odqYLx9gUJQJ8gBuVdxx5b0HF?=
 =?us-ascii?Q?Lj7rqvE8M4yy9+XkWS/gTBK1YFvxBLQOryoUStP/O6F9pguvUSR5WxivEM3E?=
 =?us-ascii?Q?Dhc2TjHPB4BAaSpCRK39z14uyRVWWhEzLOswy7Qc71ZP97XNQsd2fjPJIb/D?=
 =?us-ascii?Q?vsIrmflnnft1V/WeC/JyHrBVzCRjrgSPfURjd23ZZQvWYFk6I0FtgsM9ydZW?=
 =?us-ascii?Q?EVtH9ocVwVeQdK77JIxVUurMuJEwOn9gSMnhY9aaFEiyIbb70OxOgefk7ls2?=
 =?us-ascii?Q?OZFuAB0q6jTp9ycntdzV+S33WbfBuSUpfzwCqx9fSCj91ikepZXSUFB4DFE7?=
 =?us-ascii?Q?cKIkI72ja6/lrwY3SmMHNacnAr/T/F9JpJgDxjlKvzYAcsd1nEgtOyu/FZiY?=
 =?us-ascii?Q?PE2UKdzjAirOFh2REQvVY7LKNGdApeHBphAQPKcXXPHz7aezQon2moTqOcYS?=
 =?us-ascii?Q?80IlL/f+azUjQmphvbYD3frqIvz+xxdiCiXCAITMlfkTDZFF2e3/70I927z4?=
 =?us-ascii?Q?VcWkodmf5v/vI9v9vZdJGJqwb2y8GeFacrHCVfR+VtcxRQEitJgpPP2Eg3AU?=
 =?us-ascii?Q?8HWilQLr0iFVpzCNJPwrm7EVE3jioaF4sJ/sOMPHTSeXbMsZxsJG6J7Il2La?=
 =?us-ascii?Q?JuAUlLoLfFe64Ytaza6yn45j2Z2hSYLvXs44ZjSdvWcdunVk/C79CeYGj+r/?=
 =?us-ascii?Q?NGKUpHxVXf0UeeWL7RKeV7lndxRckAlPtYIe49lGt+wp/RuBl7yLvshCfSZf?=
 =?us-ascii?Q?29uQ37OllAD+ahgb5i1xWqov3siQFu6dQymovzjz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8e5155-506a-407c-30b9-08db985e7ae6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5859.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 22:26:16.3684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nhfNIvKs5uY6bV8dgvv+TFYKtH1XpndIsXzQ6agDE34MWsYmSuXQtmzWqkigsQ1B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9238
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 08, 2023 at 09:18:51PM +0100, Mark Brown wrote:
> On Tue, Aug 08, 2023 at 02:27:04PM -0300, Jason Gunthorpe wrote:
> > I missed two paths where __iommu_probe_device() can be called while
> > already holding the device_lock() for the device that is to be probed.
> > 
> > This causes a deadlock because __iommu_probe_device() will attempt to
> > re-acquire the lock.
> > 
> > Organize things so that these two paths can re-use the existing already
> > held device_lock by marking the call chains based on if the lock is held
> > or not.
> > 
> > This is an incremental on top of Joerg's next, but it could also be handled by
> > respinning the last patch in that series. Please let me know.
> 
> The issues this series fixes have been causing quite a bit of breakage
> in a range of CI systems (Arm's internal stuff, KernelCI and my personal
> CI).  Both the KernelCI bot and my colleague Aishwarya (CCed) bisected
> which pointed to this series so I've tested them - I didn't cover every
> board but this does fix at least some boots so:
> 
> Tested-by: Mark Brown <broonie@kernel.org>
> 
> It'd be great to get these fixes into -next, thanks for getting the
> patches out so quickly.

Yes, sorry about that, this series didn't get picked up by any arm testing
before getting merged..

Thanks,
Jason
