Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1503781352
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Aug 2023 21:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379590AbjHRTTE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Aug 2023 15:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379604AbjHRTSl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Aug 2023 15:18:41 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A073C31
        for <linux-acpi@vger.kernel.org>; Fri, 18 Aug 2023 12:18:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j15aoS30kOJRNJWk0TDTdscLQThfdJkVM7Pccv1acJzrw6CoJ2gc1QwzXO1PgwBW9p3zm0LNguqgsMPcS6r4qs5xGgPaGEp4TADGnTMm6SeMSOuiwD38pQQMZxCemgkQmh4u3T43lSyu0SiVI38kGMG3IqP3HEGv3HzyAVtoY2DXdz0l+7ZTeddUW0J0KFm97QqquTijHdBkV0AftT9hjA2PyWTNb7rwN/GxBIbPVtmOfH4NA4y2ajBqpS89+5Hov7Cpt77Fw9CXozNnaIxi8GwjJweAIhNuX+FLwtoRQx6ZjZFkKdSr/4kBhZIFBRrpo8cgugBEwnn+kqsTrfgzjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGdJHoHD2Fp12Iftq2j1yhuG6CGqzhHvABZ7SIDIHfU=;
 b=llXxorbqA96YWBNnSxXn22YHrXXDQp6GkzR20E1si7XBcqpXfzmgl8gzZkvqOlV+80pkUoOuX5XsPQkfqCe6MUmX96YCqTBth/ahBAnsBt55pzyuV2m+kDXdc3JZTJBY4N6AEFny7cfuRr+YnfGOo2aa2fuM83G3VlrsaSSc2xR3lXYaGImK1nbEQZjDeHDODaN1yJ+5evmQU44YGXMD4Yva2Odd1kx+oQmvliVTQzUqJThA3gO+B0BoL9k4c3bKXRD3mDtCccBqTZwBNjASOAdPgDaaDuI3tZR8OCJzdfKcby3AMdQ+QCVyQPlBHSmN543o/LfzTz6hnd/vzWYxzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGdJHoHD2Fp12Iftq2j1yhuG6CGqzhHvABZ7SIDIHfU=;
 b=ofC/BAWwGw2DfvQQy/RPELJ9avi6UM2YgJD9ecL6UepAxqwvP1XZzeKI9a62VUscdfaz9CI88QnKb+yr9zYTUOvaj3gO+3cwOcu+rXlswF7Rerp9QGgNzdqvfFQx7oKS5nerJ+EfOEpxfhxYpYM1f1yuJ159dipt7CSH68Nu2XB3UG7D/i5328/0a5rIlpd6FniCUZSv5YO5vZrS+sMu8mVH8dfecIoMrHGhAtTZ1btHcTF9P0eIfPF5MJRjIUiPGyhicmlnyiDoXGvPBIJ7FCaT7jwWZdtPetAzmHB6gFMJn76M6NdQjd8DFXXHkfe7tp+TOfm80Ii2xJPCY/NHAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB8177.namprd12.prod.outlook.com (2603:10b6:510:2b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Fri, 18 Aug
 2023 19:18:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 19:18:36 +0000
Date:   Fri, 18 Aug 2023 16:18:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2 0/4] Fix device_lock deadlock on two probe() paths
Message-ID: <ZN/EC4ULF84CZUmh@nvidia.com>
References: <CGME20230809144403eucas1p1345aec6ec34440f1794594426e0402ab@eucas1p1.samsung.com>
 <0-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
 <d090f196-a5c2-b188-31bf-e42553d8d251@samsung.com>
 <ZN5n7GnlrTS6s5Yg@nvidia.com>
 <ZN-UpDFHab0vGuXp@suse.de>
 <ZN+XE7dk04f2C3D7@nvidia.com>
 <ZN-3Qfp3CyNiwJBK@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN-3Qfp3CyNiwJBK@suse.de>
X-ClientProxiedBy: MN2PR15CA0030.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::43) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 36591bb8-6d66-4640-7616-08dba01fec0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YUpC8fsAuPWNsY5V9nmRow6lxWhm2bRk4uFG+E3y74itYwB+bMDrmYI1H7Jg7Mo+gVL/MvizvCxq8CQDw+xgxw0vWYx0vrbJ6/GJnnMtY4E+OHxtuxVF/wtfp22+yQ8NFlSLI0QZzpVPykMD/+3CDCgjQwjvgeOOPsADnHFg2uczdBv6aNmtoXtGFpXR8heCRGJmGVpXfzfo/vJ/2orGlbIOf+5tF+miS6/EMunncv9RVgyLYOo2ajtBrsX1p3d1kgvamAV3U3SZ89IBsLdSl57e1NbNxRkrZfUkBZ8TOOlh7Zpsm6eRsxtlI/+eVtKnN8bhNP3ky+wyHrG6oGcyZJjMjab+7Eta8KteOk/nDP2us47ZYxg4aXVPEqypAF0ugg8BZdzNKJqiyZylHmbqnKtNqFNHICUprBMTC2r3qNUqCGI2eV/RVqjIc/sSWVT/iSdmRtOP9rQiSiDoh6A9wjp5Y/JU5awJT2m+UaY1Stk5lybuidSeec0GsLuZo9dzcZXI32LMBjRsr/7+LeNDT3e8dpObU5GrL0BSwet8xjF4etbUyfyYCGIshw0oL623
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199024)(186009)(1800799009)(54906003)(66946007)(316002)(66556008)(66476007)(6916009)(41300700001)(5660300002)(38100700002)(4326008)(8676002)(8936002)(26005)(2906002)(83380400001)(478600001)(86362001)(7416002)(6506007)(6512007)(36756003)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rGsZOEzvWfIw6pWXX1bWnW6pPIS2LDzFhxjHDap2zOC4MRc3B/6jSav4vzt2?=
 =?us-ascii?Q?fcmsGzPoXu0753V/yijhsxjF612xvIbz06inaZgUTPD5eoNA+/JGA0N1MJ0e?=
 =?us-ascii?Q?8l2k9PcfmF6vTvKnV20Mc8F9EPPea1jOVz3yzgZ1VEbmPY+lC9tS5fu3iP0e?=
 =?us-ascii?Q?06qbKgsDp0cJJHJyDuah6YFsHjLM2OtbO8wgvCTqoXA/TsXppUc5g+gPubEx?=
 =?us-ascii?Q?XsTMoMT6KCWbs/V7vICq7EfZjUkPtve8UTplv6SykYLXfwmaCVf6LBACG6rq?=
 =?us-ascii?Q?KXTQuJpuAAN1SNTjbn9UvEtPDveGwC+jJL8egsi/3EDJVW7A12FHkJ3edLn/?=
 =?us-ascii?Q?mZZ9msNgcEnRW8BOWMHOBryHGrFgKM/EKwtJdsw+oUCJ9/EbiN+cPv/gPzmC?=
 =?us-ascii?Q?Diin8dN+tMU5cBnO+0Qt0Et1UdMvMwPPSmJfpcpl2eQ71DStRAfMFWeFb5SU?=
 =?us-ascii?Q?si3j6/bfMHxoSsmW2Y8f2Q6qQa/4DBw1NPwyB8hhXbtJw7UbZoWQNtInGFuZ?=
 =?us-ascii?Q?EwK7Rpjs9jpBev0qzWRyWGtDRlfAvHSCnCJ4IuTSuWW+L1dDIXucHXe62lAx?=
 =?us-ascii?Q?VJLoAbTiJ7cewyQ3mho+mGEIZX3Xn0q6xatkNpS0T8N/76Rb06U9JbBqjQP0?=
 =?us-ascii?Q?aYroAE0x9kmRGL+w1HkXVslJuv0nKPJ6U7Wlu2klaivDlryCmGHen4l9F7hX?=
 =?us-ascii?Q?1BrL7vzlpKXp6lO5qlFbt33xt93EUNq9b4phaXvn5zAm/AOL/AGKwYeAlHrD?=
 =?us-ascii?Q?D/1r+42go/yRAcVMnuCLyblGsQrghU+HwB6n+pr14WFjaO+G2eQGUDjZcc2f?=
 =?us-ascii?Q?9/gV6+D90z6RiZWYZFTgZflRsUjkHpqrDlzeWX4ZUrrfTy/jtVj3kX9j9StZ?=
 =?us-ascii?Q?wuXpeZs00OBS6i+3NV3J3JuwNYyEcqvt5Zs6Ey9C1RN7qAgB6crHZ3t9z5da?=
 =?us-ascii?Q?bJAkc95aEuytuWaAtmVpWAlJYJTQagWU4+LCpjMh3kTBXXOrRtxDAeLCp8yS?=
 =?us-ascii?Q?dvu8EUD9NAe2PX8N3PWE6GedG50QK7cwI2Yd7Hw1d9y0rlI/NdWir6kCsSQT?=
 =?us-ascii?Q?PTaN+9nj/52K1LekDGUiSzFJVQfs3Qugjs4cObbuwvO/O2oZKVUHqaf3Olyj?=
 =?us-ascii?Q?aC6J9ApO8h/GmmjPbn8bsWMY3AADF1U3TgBUZRgmuiE2uFEhNpsauPpWUlxK?=
 =?us-ascii?Q?TRDJ4dr65ebqgLnWvds6PFm/a+p1WiwpMa5HIcyrlelkhOlxFAber0bapwyT?=
 =?us-ascii?Q?TV+GAZc6bOnhwd9w8dyh/8NLjp0bgRH53otaOsMFJLkePMOanoLGpxboQ+ed?=
 =?us-ascii?Q?isHKAtHp6zUAbxE9v/EwJAuDGKP6ogcqIX6JGFXCOIcQR00cvF1BlXHxlaZ4?=
 =?us-ascii?Q?ett4RNLVY92fZ9ZRin16HNtmNI9gZOjH5+eS0O9eNv4c7c+BB4HkuHIi50rI?=
 =?us-ascii?Q?r51T/Gb1rmWdh2rJ8Aa0DkQ9URLss2nyOfI8RcTF0iAVkf9x8ShyFBS0vlxJ?=
 =?us-ascii?Q?GX3S348IdK+8XcK/HEpZ5yzA7HqHIhtvBeqIUi6ramp4ZYAPbN+o4SIDpMxw?=
 =?us-ascii?Q?Z/I5TYb/92SvZL0Pkq5RNULwI4uz7O2RjOsRVvD6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36591bb8-6d66-4640-7616-08dba01fec0b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 19:18:36.8504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obVXbO05oChKOv6j8MSH5WfWrPPTQm9oHUuy+R5irXBZF18aWr1FnJ5lspVnpO15
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8177
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 18, 2023 at 08:24:01PM +0200, Joerg Roedel wrote:
> On Fri, Aug 18, 2023 at 01:06:43PM -0300, Jason Gunthorpe wrote:
> > On Fri, Aug 18, 2023 at 05:56:20PM +0200, Joerg Roedel wrote:
> > > On Thu, Aug 17, 2023 at 03:33:16PM -0300, Jason Gunthorpe wrote:
> > > > Bascially.. Yikes!
> > > 
> > > Hmm, that is a difficult situation. Even if the problem is a misuse of
> > > the APIs we can not just blindly break other drivers by our core
> > > changes.
> > 
> > They are not broken, they just throw a lockdep warning and keep going
> > as before. This is what triggers:
> > 
> > static inline void device_lock_assert(struct device *dev)
> > {
> > 	lockdep_assert_held(&dev->mutex);
> > }
> > 
> > So non-debug builds won't even see anything.
> 
> But this still means that a function is called without holding the
> proper lock.

It has alway been like that. of_dma_configure_id() always required the
device_lock to be held!

eg as one example:

 of_iommu_configure
  of_iommu_configure_device
   of_iommu_configure_dev
    of_iommu_xlate
     iommu_fwspec_init
       dev_iommu_get

It is subtle, but the device_lock is what protects the store to
dev->iommu inside dev_iommu_get(). In v6.5-rc1 many callers held the
device lock here, and after this series only these broken drivers
don't.

The driver assumes it has exclusive use of the platform device it
steals. Not just for this call, but in general it does other stuff
that rests on this assumption. Since it is exclusive it doesn't
actually need any locking - this is why it works reliably as is today.

Again, there is no practical bug here, the driver works fine. On
non-debug kernels there is no warning or functional issue. Debug
kernels rightly highlight that the API is being used wrong.

It is wrong use of the APIs because someone could go and use sysfs to
attach, say, VFIO to the stolen platform_device and cause all kinds of
kernel problems.

> I can't send anything with known problems upstream.

In my view this is not creating a new problem. It is exposing existing
problems with a debugging message only on debug kernels.

However, if you view the debug message as a problem then I suggest we
simply comment out with a note the device_lock_assert() from the iommu
code. This would be sad because the vast majority of systems don't use
these badly designed drivers.

This puts it back to the v6.5-rc1 behavior where of_dma_configure_id()
won't make any prints if it is called with wrong locking.

Please let me know.

Jason
