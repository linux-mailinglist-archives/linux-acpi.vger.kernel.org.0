Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C70C72084A
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jun 2023 19:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbjFBRUi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Jun 2023 13:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236917AbjFBRUg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jun 2023 13:20:36 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8339C1A7
        for <linux-acpi@vger.kernel.org>; Fri,  2 Jun 2023 10:20:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlZcH8WjfV6iIy4WIqrXmeYue4liBMp0H5SM64SkGUHu1M6G0I9Dy09YSL3AoT+sqfLnoEQ+yZfjcrdxgTIb1vwaRJ54MGU5ddgyehzM2/LVfF2Mn+ItEhd3JT25NXbkctL8LiPJPE8VmgSuR5ZAKiDYpG/zR4MmIqiF2Tj93R+xdiHc8kLypMz7QjxX/++YEUnmf+8U5tCyUrzLGEnHAhXzd94C7y1xcNhsTD3lOugA3ujAiOql0Uhpmj5z/MdAcOoJ1wFwo014oITrH2EHHWGnhYSxbRqhLrAeQREp+dLz5rSiAiFS9aL28SpjLpLMJgct1PhPTgnpXeSNhGZc3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUPYEixeMaOB69hQpVIOghEgySHkURIii4KQPRrtw0Y=;
 b=PAS+vVIIrp90cLjeADYqrz9Q++ylXeFYOoIXbKEt7r1kNM3MZmYPAsG/Aasg1CjcON5MaeajnP5B9PVfcxgG6aAVBFs79Ez+bpy3C57RqDMoOC6GP9j2JaGBg5ZCtXCJQT5HL9K8fK8n8hs8sH6G3464VgtsnoGO8w/Klmgfrjw8Oh/kU4I4Kt4aF7ocMC+mVCINY6NHgwMo7zBRoUN0TljgMXw3vLJU9ww0T+WiB2FL89WnlVnXjksc7qOWYCZwNuba7V6Q4ttaiBOFnpr+v1fhpYdAW4TFg31eIqXCBiq4v+jFRm8OOt/XVX4lSn8jRjfEfm9o1bMq6qZPeb9vAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUPYEixeMaOB69hQpVIOghEgySHkURIii4KQPRrtw0Y=;
 b=sfwj1en7/LjWfvpk/7tniq2Bscd85hk6jCe1TfzmglUPJPQB7nTOhWo056i6P6MroYhFTzZV9kItgBGfsD6l4ZMBKa/iHl2yb9QcuM3J6CbMtADn3pJUizVlFDiszSBG/m+lYPX8VAGLSwiiD2SO+Hg36rZOlNTMg1Ylw+1uHQL5B5BYNdqeo95go5kk35v0RuxV/5nib+n2xrWCF9d6ji7NZZ3bwoXUoJgw0kDSdWempk+j3lZvbMi5CX/5Pe50pb2KpzszDPoBuo/+kMzFTp0YYEbqNYDPYAToihK6K9ythGTio/YAoitKoI86c92g0j3hdDbLm1bzGjxn0cqlyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB7002.namprd12.prod.outlook.com (2603:10b6:806:2c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Fri, 2 Jun
 2023 17:20:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.024; Fri, 2 Jun 2023
 17:20:32 +0000
Date:   Fri, 2 Jun 2023 14:20:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 05/10] iommu: Add iommu_init/deinit_device() paired
 functions
Message-ID: <ZHok3ls1dP7168Mn@nvidia.com>
References: <5-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
 <5bcb5f03-77c9-116e-c436-9d0af21fa82a@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bcb5f03-77c9-116e-c436-9d0af21fa82a@linux.intel.com>
X-ClientProxiedBy: BYAPR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fcee1db-c2dd-478d-e6a7-08db638dabb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1BJnEtQBEk5PCDfyLIIQ94pktk2aV74RvzPTw/66WDrX3moIb1+ofgm+KfSU7gYFEQZiUVeXrGy/vXVBkXGtKlsPi4c6RYGB//QU0+ZHD7HbM5YYUZu0v6TuKthTQXQ2T4cIIdmHg6eFIfrn/HLyVHxxeCg8k2/XS4KwNxE1Yj1rI0YXHw9MegnNNRjGCWX8+gDvgNSwma6VphWkSD6K6XuljFbg91P8PGZi0HSj5p2yxeWy4sj69bvazU3tkZ7lk5YRy8ZDc1E+AcJiYThE21Hu/cA+Icc2JvA5OuZZV0CIF1FxCSZLQgkGm8/Z+h13TN6sm+2mf9iPFhkwUZhsCa6DkLg0q4/f9BnvudxZhzQuuyRKGvKi32oDFNx1lvJVJYtmX2bPgyq5ubTxWJga2zBSSIADNypkvCWjAh4vxe+aciKeX7bYJeBDAGPXsBAbouc8eebxY6EWgn0vm3Q8Q3z4VE6FggsBtlwm9UagvpFob5/kMlJjt5JIng5jGkkvVsT6QOo+DQD5UFsEnCfnXFk3mLy46Xz8zHP2Tkp+26dEFYiev4usl0/xau6AW7SH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199021)(38100700002)(86362001)(54906003)(478600001)(6916009)(66476007)(66556008)(66946007)(36756003)(6486002)(4326008)(53546011)(186003)(26005)(6512007)(107886003)(6506007)(316002)(5660300002)(2906002)(8676002)(8936002)(7416002)(2616005)(41300700001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X9Df8OGBS8KD+RcB5QEvvXKI2HfgWIu6/V59S49OGVDpMxMeH1enjysmDRMw?=
 =?us-ascii?Q?xi7exsRZPxe+R6KPXHumEXM7GWvkk1WIoNFtMezPuUEVVlr+1Abpw2zVT/1l?=
 =?us-ascii?Q?ku6mCkSz9tYN9chfOE0Lg2I+qFPMBorRU03IBAbnsxBKumNtRAPkvK7ghG+o?=
 =?us-ascii?Q?hJp/MaeojijX3oNcIXUBzBfras6R5OuhAfcB53ODZjHS2VnaECqu3k5S8y/g?=
 =?us-ascii?Q?3/uAm3aww+trRzQLqo5lI0CJc6xqjghe5lf0+Cdwzri635mvKbNlXkJkq8lo?=
 =?us-ascii?Q?phaeXR5o7ekeIIDwEgFAScUH0/031UEfcs/jgTcJjRpM/CO6SOsc8Q5MnRSI?=
 =?us-ascii?Q?WzPEWz6NbzNI1kFjSqKnzgLxeRqZG0HkvDY8vTIaUy9145NFuMth8lZyApa1?=
 =?us-ascii?Q?4Be3dhqwmEFVwuoEanYjRUocMUTB3cdbEbuzU9luZqg4oZ59n7fkzCZiCQko?=
 =?us-ascii?Q?BhY94B8I/Vi7kvD6WR31r2Jau4KzKDWa2neDXOzuRLvIWZ0KRzyrcjKLk+5e?=
 =?us-ascii?Q?SvMRRtDQgicW4vNjz2ImsRLt+SyOxrgOJ+Q7FCU5qX7/qvmvGdxiYw6SjRo5?=
 =?us-ascii?Q?NTClzR6/aVG5nWBsI3zgHCaIxDDNrpPv2uQ8T85DaY0fSkbPzBRUakrNj6KA?=
 =?us-ascii?Q?Hecp8zQ2vUq8v18CoqtDjEbgZ3CsYZP8Cc4rBoMwNNYh505mP/iRLlJDkSPV?=
 =?us-ascii?Q?5osX1xfIqPoX1m1qzo5MmAVXtv1rh2yhsZiiCG1iant/0CU4LXXubarQ9EEl?=
 =?us-ascii?Q?ZFL1UG9UwJoPhVJlAND2fPOTbLIGBJm0zgKPMpfDL9/rnSfh7sKARugBDgNm?=
 =?us-ascii?Q?Z9ch14qYOv4PKNTJ9r3YTJANmKaA0Ki7UqK+CMfmNXQPARlwo02ZssVyf1Jy?=
 =?us-ascii?Q?GdEeQGMeQUv3Uz4ZDA7Rn8RT+tbAzkSJIqrI6mRvKYdhuIuZZBTXn/RYV11/?=
 =?us-ascii?Q?qjjwgvzV2NNN0lvWmzO2Z4/sHR3fDD+JCVkZbRNXrMOmhQkRpdWbBD7tpFnc?=
 =?us-ascii?Q?21xYNfo+QvdRKnDilphsNapsoS/HwEXNWFqHzRMlrz+ubzTjwwCciKfy95LR?=
 =?us-ascii?Q?B75hwQecFCsLWIsAEk1DJaJ+1gC7wRB1lp0aBZ5f1flddaLQ56cJgvwdPBs8?=
 =?us-ascii?Q?G/rKv3NvqCol/zbuBIsBEdI8vAkQnmK3nAobNQCrnQtxODkH5nTmLpRjoduY?=
 =?us-ascii?Q?eIGjdeKMg3AMqFzwruX3Swki2zfOKfE/KIEnPlh3HS0MWjlnpxra4FJo789p?=
 =?us-ascii?Q?4Yt+KKWHeexWrMY1GK4e3FQjEsWNzRe+5nJt6lIfmJ5i5gqqknOshgrR7LBF?=
 =?us-ascii?Q?Q+RVS4BYZh/la1BVovFQXiPZ85RL3t8B012SorNnG974GKJ5Vvo5jPFOhU7r?=
 =?us-ascii?Q?KjKbyMmwrrsuVTb1xypjpd6ZkOxnhke2OjhEfd2FZ6abz4rXWdUaRYdSm262?=
 =?us-ascii?Q?z98ZIdESZ82zwAKqFpIsQJtQojYwWLWSwUDmDIhRkfRE3NH3+nv2UATxeBGp?=
 =?us-ascii?Q?+QiJmqPFJj1GTQMKMy554qwt66gCiNBPtqt9oHGVruKuMSWg+j9bmt6t41/Y?=
 =?us-ascii?Q?APiIjaAQ5LTK1ZP3kX/ZFGNyFrcYcecF/IcWbX8O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fcee1db-c2dd-478d-e6a7-08db638dabb9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 17:20:32.7290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u87EmXaX2f0/IMETGt+onOizj7IiOq8h86xO2ZLM9VFR+ZevlNhQpjbjn/YJmiwb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7002
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, May 21, 2023 at 07:31:38PM +0800, Baolu Lu wrote:
> I revisited this patch. And I still have some questions.
> 
> On 5/20/23 2:42 AM, Jason Gunthorpe wrote:
> > -/*
> > - * Remove the iommu_group from the struct device. The attached group must be put
> > - * by the caller after releaseing the group->mutex.
> > - */
> > +/* Remove the iommu_group from the struct device. */
> >   static void __iommu_group_remove_device(struct device *dev)
> >   {
> >   	struct iommu_group *group = dev->iommu_group;
> >   	struct group_device *device;
> > +	mutex_lock(&group->mutex);
> >   	lockdep_assert_held(&group->mutex);
> 
> By moving mutex_lock/unlock into this helper, above
> lockdep_assert_held() is unnecessary.

Woops, got it thanks

> The group->devices_kobj was increased on the probe device path twice:
> 
> - iommu_init_device() - allocate the group
> - iommu_group_add_device() - add device to the group
> 
> But, on the release path, it seems that group->devices_kobj is only
> decreased once.
> 
> Did I overlook anything? Otherwise, the group will never be released,
> right?

Your answer was right, when VFIO uses add/remove device it doesn't do
init_device.

Jason
