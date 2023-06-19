Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23AF735DAD
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Jun 2023 21:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjFSTEB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Jun 2023 15:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFSTEA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Jun 2023 15:04:00 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08FB101
        for <linux-acpi@vger.kernel.org>; Mon, 19 Jun 2023 12:03:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJDjPlr5KAREgvMlXQ5zfjFxi4vma4ti7sVPeo0MFoT8gTcQ6IvYqJQkzXGgZOxxRYD9omxLfroVvyZzG5PJ6525RVbrZjjb2MQZrbUWOH9G7i4unWYZGG9dFgEhdkD8YTTr1BNAu0GHtG3Re9IzCAb3FNbxaoc8kNdWHmS65+qGlW+XOgqyucks7EoiWsYk0wVQGNxvmsgx4KNOHuQSJ5HYkS2y0lXel+KJ4UrUSgtJKmF6ELQeqySEqUOAVW811DeIYmTQvZhuYhPWEn6O6rW0kZgv7GoVGQes0559in/NarN3T8aZSWkYK9PwXO6CHE5el4UF6ojGNS7/kmn9Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9c6sa6PK0e6vI2axfJU8OxH9NyI8VWyo6tGo2GDH2c=;
 b=d7IG/IwGcBBs/T3PFogcgbEfcsFk/LNR9EDqYkiWt4RQue+Y+DxDejqrd9EoMOnQKaOy6ilmCnuWeu+9DkX4QFtRhw/QkLl9JsKHSNy5k1FqfW1TSvxSbrD9eZjsOrVJeX+e4v5rO/MJT2M099rX+KDkK3Buz6z6D9T/4f3Frg8HlFkraB1q4KGbf4kwgaAPsyvs+LnIz59Hdgsudn9hEWMP6B69cGZDm+nb0sH9kLXNlxjMBszyHEKEzItp1oP9RFmih2ek3qV35JGCpiHAtEJPT2Cx+W2fqyF+C71lCWcOX1uPJv6yBGtfvOyROlJ1RilFaFgZ2FoGP25VjidqVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9c6sa6PK0e6vI2axfJU8OxH9NyI8VWyo6tGo2GDH2c=;
 b=l0nfinx4sqUjCt1CKPyJ4Fl7S3kEp71V3zkqOMwuQFInRy/Ko2HjU+cPxIT7DX/RCAfXcFe41f9sNwRqn19gup/40/bMdIZyzqqM/XhFwmgL9LBRWKYU+8VE2o3ooMhUkLPtpNft2kysgtROg57mhOYacvg+brsJx4UHrZv6C8CCdC7HYAwQxBn72QjcGu4JeDcV92OF5TPe9rksf9UBPEgUvBAiim8WSPs82NFPrYBaFCjCSXACejrEVQpQrwknbb7ObIflZRhj87pKVLPOvyeWd5lV/Eq+W/5j+spZDJyb5UuxmcBGZpudKErvyGJwQLlF4j/giJjZspAZjs2Dxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Mon, 19 Jun
 2023 19:03:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6500.031; Mon, 19 Jun 2023
 19:03:55 +0000
Date:   Mon, 19 Jun 2023 16:03:52 -0300
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
Subject: Re: [PATCH v3 00/10] Consolidate the probe_device path
Message-ID: <ZJCmmOfR7Cl+OtOc@nvidia.com>
References: <0-v3-328044aa278c+45e49-iommu_probe_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v3-328044aa278c+45e49-iommu_probe_jgg@nvidia.com>
X-ClientProxiedBy: BY3PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4327:EE_
X-MS-Office365-Filtering-Correlation-Id: 07213c02-7102-49d6-8a99-08db70f7ee0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fPhrbIDHDY6QHOJ85xWajcNnYif5MHAIogpFkm/Tea48chDnMJsL/I+ZamdIlTqS6qF1ZZ4eeXNL0u3Nv/cnvbqQOngjY0C2pXlEX5LLDfzbIpCMM/Hiov86cS/JyB7M4g1n/8HX9yUM78EBMhGKM5OCTVsDjVNel0p4vXwjxHgdIex7lg0Jmazw0WJn3vOyLnDTOi2dg60PgUTJr5bt2Q5dBexJAAwIUEsPsw1JJT57EF+mtyldoqIrAHTJ31pO8IMflpke4F/bLNRGRQOseBWsRqWJxL1/SvcbDVbhsFF7TcrIA/AiLiPBLH5wdl7LTHxNoIS7VqjTs20as+CbdZa4tnfm8gqa1ZwUsO94j+VKF8fkxULe8AE0fsv6t5O42+ndpsERr+tiP6PDhCEwM24hD5L3FNt53Q+93cUzrk4B1eBuat8k/4iDC7k1l2vMGp4Jx7SyE3TseXZEBOPHjR9Fy/xDPNIQVOsz05eVMlA1SmvhCHXVZUB25eGdBIpQ91glQE/xF9qd2ERNv/KmpBCwF+6kNPPXSlVZvaqM/mGTHGJ7wCQFmoyGWmogyTQ42WZ3cRi79+XTcDYyJ5IAHx6EzPHttSJcLAdJ73kPzdi1UodcPmIfQzDDIZre1l6VwS3wZuP6RbyF+WCOLDhWi2QIBUvU1KxnR8iYso76ZzotSwbS4PAXakF18ZRsf6nf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(478600001)(83380400001)(86362001)(6666004)(6486002)(966005)(66556008)(66476007)(54906003)(66946007)(110136005)(316002)(38100700002)(26005)(6506007)(6512007)(186003)(4326008)(2616005)(8676002)(8936002)(5660300002)(2906002)(7416002)(41300700001)(36756003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mJSE0CoNblufC0EYGkmCJgEW+/gPVCKZ3y3QmSOK2wgpgputIhrZBQAnAaws?=
 =?us-ascii?Q?4EpPhUdOTA9RW1a+5kvuLTSQ3KrVyOrhJfwJ1d4XBAZXcj0lTk8R9uBb2+Yw?=
 =?us-ascii?Q?v6rH0fAvwZgS5zrdMPO9vMppJdDh1kbHRMMpxaRyaXH/0TppIp0aKVw2jhO0?=
 =?us-ascii?Q?Bcc7QWr7SHYKoEyYlYvbT+L6c5uB+kjyeRRjAYO7lP2a6XzYFjcGawxo6Zuk?=
 =?us-ascii?Q?NxnKS67+H1hqDVmrHSgj531Ie9C+goz4Tnhs9TFqGLpSMv0Tyl3xjuVNqb4W?=
 =?us-ascii?Q?W9K3/oontj2k5rgbiHrRO8mmUVDn/tAU5ZvPiMSldWxjAAMmKEy2Coe87x4E?=
 =?us-ascii?Q?4jCbHof6bTcwLgSOeILjNkX7fJlsAt0NX4HLUkj6t+BItjIQkTfeAh+uLRT1?=
 =?us-ascii?Q?WvEzVMgjOzBXDfBSCpSaMLn8GcSwf7GkRbOIdrzPIL3bz9PoDr+RAkfGgq+j?=
 =?us-ascii?Q?afZUrwBMwWuXdXvKURRMDmCftzufZlf4J+iRfNduccMA1LFN5HMc+kfJ+Knw?=
 =?us-ascii?Q?EG/6wzzkLWf9w/1rud5QXHg24YeGZaWVBM5pog4R01qyZwPQn4RtT0+ZuNOs?=
 =?us-ascii?Q?B5hxbvKZ9jaqgMxd8VifUQaY1q4XcyAObFUVetFJZD1JCjxqy7K/MueMllPp?=
 =?us-ascii?Q?w7Fh7fvSX1Tsp+vg3lCojz7lM4fJGPVW7f3CAqaejtENA3JDhS9SOmVCCLK5?=
 =?us-ascii?Q?J9Xpmf1/LczKUEyXTPwqjiCrOzXuYFDl40N3vVxvd0zBBg6O/ys+5B8xouz8?=
 =?us-ascii?Q?+g1X+z9gB6cGX7LSA02oIXOvi1P/Pr//kpMYi9F271/YvSBrKR/dG7yqCevc?=
 =?us-ascii?Q?1YvCKfPDHIBsEOPNUrR+dI1H6oLih8htRthzZCugRgVHWugxfcU8XhTwesm8?=
 =?us-ascii?Q?fnR/UlpSq+QiDxrfqACn/Rqzy2cgtLMgQS4/iI8nsIHOudtWhnKF1D1sSxeE?=
 =?us-ascii?Q?GTHmcW8jiZKLlI/FT4LuA2Lr3YGh+bVRPHgNuupVbFcI7wLCpDoKP649aNA9?=
 =?us-ascii?Q?3rQUsLbsu5kj9d5gzf+tu2VRwP5k767U6Gi7CGvTvuZca3JBBn9z7Fwe7vIy?=
 =?us-ascii?Q?FjlMIl6JBRlzjSbfRriEHbiAQMweEaX06gjSpnW2zQZCJdOm3edB37xZpUsz?=
 =?us-ascii?Q?x/4JCU6jJq3d4Jz8WSJYjuBg7ZBjWZtyq4RKE50awJsSINJh3v0FXNWHWfzo?=
 =?us-ascii?Q?yIdR7Taofq9yY3IG6yV7+ikQtWN+rH/54XV2kzzuUl6/cliFu5L/JrJGVJWB?=
 =?us-ascii?Q?/+dyP4oVKh/I+a4adgW1L6r88j0kzXjr8rcYTCsjeE6/LV+svewcSlprF1V6?=
 =?us-ascii?Q?alm7KEx8gfo5M7WW41TE8/NfJRnQeyzOwHLKbsnNB9GrFwILQiZwC4lLwc9m?=
 =?us-ascii?Q?BMns9YbFmBsp1sm1ozR9DhYaDDv8QXEilrfoKXFvgtRwiAz6ha+qz89jZbI5?=
 =?us-ascii?Q?9982Eb7wLS7+gI4q/swdI7dZONrk2/o//HUSVz37hPrLpXyGf1V2Mijs8ehp?=
 =?us-ascii?Q?1MUkyK40e1mK9UdUrjz504MXqFaDDUvnIWuhWvDEAMF2iJSFPCok37tvpx2j?=
 =?us-ascii?Q?4VjSer8JJLQmr2ZdVpX13KE9k6f2f6iciDjQQwdU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07213c02-7102-49d6-8a99-08db70f7ee0b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 19:03:55.7444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DSa8OvxQUhBv6/rzSBGR2o1J/NMMkwquO9w8+Gr2D6YdTJYOlgyrfAClaJY4qRT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 05, 2023 at 09:59:38PM -0300, Jason Gunthorpe wrote:
> Now that the domain allocation path is less duplicated we can tackle the
> probe_device path. Details of this are spread across several functions,
> broadly move most of the code into __iommu_probe_device() and organize it
> more strictly in terms of paired do/undo functions.
> 
> Make the locking simpler by obtaining the group->mutex fewer times and
> avoiding adding a half-initialized device to an initialized
> group. Previously we would lock/unlock the group three times on these
> paths.
> 
> This locking change is the primary point of the series, creating the
> paired do/undo functions is a path to being able to organize the setup
> code under a single lock and still have a logical, not duplicated, error
> unwind.
> 
> The reorganizing is done with the idea that a following series will
> consolidate all of the different places calling arm_iommu_create_mapping()
> and iommu_setup_dma_ops() into the new consolidated probe path and get rid
> of probe_finalize.
> 
> This is on github: https://github.com/jgunthorpe/linux/commits/iommu_probe
> 
> v3:
>  - Rebase to Joerg's tree with both iommu_group_add/remove patchsets and
>    the iommu_err_unwind series
>  - Remove redundant lockdep_assert_held()
>  - No functional change from v2
> v2: https://lore.kernel.org/r/0-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com
>  - Rebase to v6.4-rc2
>  - Move the POWER cleanup to an independent -rc fix due to the iommu driver
>    being merged
>  - Update commit messages
>  - Rename iommu_init_driver() to iommu_init_device()
>  - Simplify __iommu_group_remove_device()
> v1: https://lore.kernel.org/r/0-v1-8aecc628b904+2f42-iommu_probe_jgg@nvidia.com
> 
> Cc: Nicolin Chen <nicolinc@nvidia.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason Gunthorpe (10):
>   iommu: Have __iommu_probe_device() check for already probed devices
>   iommu: Use iommu_group_ref_get/put() for dev->iommu_group
>   iommu: Inline iommu_group_get_for_dev() into __iommu_probe_device()
>   iommu: Simplify the __iommu_group_remove_device() flow
>   iommu: Add iommu_init/deinit_device() paired functions
>   iommu: Move the iommu driver sysfs setup into
>     iommu_init/deinit_device()
>   iommu: Do not export iommu_device_link/unlink()
>   iommu: Always destroy the iommu_group during iommu_release_device()
>   iommu: Split iommu_group_add_device()
>   iommu: Avoid locking/unlocking for iommu_probe_device()

Joerg? I think we are good on this one now, it has been quite for two weeks

Thanks,
Jason
