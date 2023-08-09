Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D90E7751B9
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 05:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjHIDzY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Aug 2023 23:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjHIDzX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Aug 2023 23:55:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C49210DC
        for <linux-acpi@vger.kernel.org>; Tue,  8 Aug 2023 20:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691553322; x=1723089322;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YdZQEER9JfpqwIZs4EyxNzPlZr9ag1tZLfxAridhh+Q=;
  b=S1WI5qcuM/wLBiV7VGKr7v4Aur7FWqgeoU0C+1D+EqcKpZI60wHdtEj/
   RaIrrOzb86quSpLRRFjs//vG+/PsGVa7MSZb9UwD4QStULqG1mkqyJBeZ
   zZvonCLFVPyiG5HuyIQHmA/LJ8kuFeVOsTMB7w7DwNk1Z22gMinbawuMD
   FavEWRjRrZkkxEaGm87XtQ2VhLzH0OMOmkLZkatnNHBlXBI7DDFh3fbMa
   8KyJkp7DiUC7n1Dj66HaRaJaw2s2cG3bfxJE2741yBZUbSrLfbvGI3VnU
   6+8FUNlTqVD1ZxYdZ1vvanz1JinRUQHfe+IifADvWCHx19i+WYNf/M1IY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="371007255"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="371007255"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 20:55:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="766647922"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="766647922"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 08 Aug 2023 20:55:21 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 20:55:21 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 20:55:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 20:55:20 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 20:55:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pu1PrH3TE/54Xjt+Z6JaRl9fl0toGnLl47TMrbxzi9qJrVzAi0mckXTshFa9O/L4Rrwzp2vbspIi3cgC73TbBYIWRwFQJQdEfMKv3UJQ2hxz+j6QgtnfOtMV6tGJAYcgZmy1eNMz+ZSDUYcGxFcOcVOKFb4/iId95Ym5Qoo62i8gwzZlHER0goGI6BvlaEXILq+dv19gK7Hi65j8bR9E8gRA3/WziJ4PvieUoOzXPGJ9wOFh5QidtoWpXKJvHyygqcMshEwRwnFG8o6tEUCqmBL/z+MbvX8SkjG/RK2U6aWAQTqNHl39/xDQ/CUwU+30PmzLmzx4jNrB5fCxw6gCLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgcHgAU2hPB46jX/oBKfS5wmmjv8PfdTZB5F7o8Ua4Q=;
 b=Ly77bsEYLJumtNvRlMLAebdzlzKGTk2AJd5mrdbX1oax6zDYaA6cTRioGLD8FSXMrGI0txywwtkhesQxtBuJoWkaOa4JXgbcVvsxSuK41z+WGa5yum4hRNWm2XSHvlOzmjOnZoTThpRFTBELkoMm+GkMLJuPJ5kOwTZ6rfqcowaX1Q4turXks/QglcsJ3Skm14yo6Qu1qOq3xfE+Wee/ru6R9zZoh6uPpZD80NQFnp8iaBZUkHwhmNTDSaFIle1ey6Mh6MCGZ/LYre4hv6+S7X8NHlgUeLV2gDXSC3NNN3WxRBfExjoQ6tgRCn4gCLdJ6/+fDMbqhOQuX5k6GrjODw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB4988.namprd11.prod.outlook.com (2603:10b6:806:f8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 03:55:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 03:55:18 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: RE: [PATCH 1/3] iommu: Provide iommu_probe_device_locked()
Thread-Topic: [PATCH 1/3] iommu: Provide iommu_probe_device_locked()
Thread-Index: AQHZyiM1Si0mFJlZd0eUtOdYewfh8a/hVgYQ
Date:   Wed, 9 Aug 2023 03:55:18 +0000
Message-ID: <BN9PR11MB52763112BCA3B0C8151624D18C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>
 <1-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>
In-Reply-To: <1-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB4988:EE_
x-ms-office365-filtering-correlation-id: 5c6ba0a5-d83b-4b27-51b0-08db988c7243
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CW6G5DJHQkPD51j02pvtZdBTPck3Z3ZcS9UBcbdh2VoGAFS76VGqtFQRbiOnr6k0tKOsWxOk1+FdfGM/ZNeQQ75h8daDHN+b7b7UawIDBUhlmASNIM90KM414f0bKYCr3AekRE4hEyIl6mwk5VLRMHG05unTO6yBQHwEUzMBU3rBb6H1dh/Q9QkV6oqM+3HY5uryi2czeAn+2awqShMHOtWwfF6WAOKcwSZ730aqEA3Cunc3IoQ8gmEnOt65NtKpLgqM9czS2sg3EYTg4fMdHa7tT9aYAr165S2blx9ssnoLYtef5RM9N3tkPi98yUjeMygvt6jKfeGM000ldcu9Vf5cgejqRTIILxvYrC5g8pFVrtkwqQ5a7z/Zw5pQjGILuq3Wj1z48aK3LXVXut2KrKpBj3M9ezU7/qQ7OzDuihNckQTAQ3n2hmXsKK0ynZCTsRxmYUCMhAOFIkWIZVnTe5o9KXITOgR9Sky2oaCRA2dkQFSHpYNthXtc6QEUOAA/vXvR4txkd4ujURghiviMaMbQNxoP/keWjL+R0w9PWfSbJiDFA1TfcXeN5pBUk3XgaqpCnB88ShooIfKoJMuwvA9xHdD9HgPR3O1tMsCtWfs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(366004)(376002)(39860400002)(186006)(451199021)(1800799006)(26005)(6506007)(9686003)(966005)(71200400001)(7696005)(82960400001)(478600001)(33656002)(122000001)(54906003)(110136005)(38100700002)(66476007)(66446008)(66946007)(76116006)(66556008)(316002)(41300700001)(64756008)(5660300002)(52536014)(8936002)(38070700005)(7416002)(8676002)(4326008)(2906002)(83380400001)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ac7MSTloDG9zHFMtewPNRuvR6Ce33LaZMa/Ej2b4IE2mhGe4TDaeZxHy98i6?=
 =?us-ascii?Q?wIfPLsVGF0s5CKbM5xXI5XHMlYYtZyyjRm6xY/Fhna/sVNG98o2B4nnfX63k?=
 =?us-ascii?Q?/Gv41WTUY1ZHcnTkgl7hu4g1RC7S7VlDY07GlvCiHKjO2KHiNukafg8/7rxf?=
 =?us-ascii?Q?lgu103iOwx3utWpEtKenWmH8FE5VhPrNscvS5Ku4gg9V20wSQIAjdsD75HMr?=
 =?us-ascii?Q?LlyyGAIyk/z1CP7WzIsz7WcZJiQZl5i2leQoZAHBBddrtY53NafyZ2M3OIo2?=
 =?us-ascii?Q?HQVH8J2A78hy6C7kM7ENSRDFduB+UrsOtZPkFCy9VqKxb0lPV5xoHOcfKbNq?=
 =?us-ascii?Q?KYm0JosRa/mu2T9nvaBw9hUvh4HD1lquveqDcGJzeDv2GwMaUTlyC98rSLG0?=
 =?us-ascii?Q?Tp6z17BQDrWs3F5YQxtXMZQBM5iaseHM5wt9k47W9N7Yv7z040hheycwRZaH?=
 =?us-ascii?Q?QxPudze5llMishypYlCFep0LMfOlr7q3NNni4Nn14AmTi/eSftC4MHhVfdnr?=
 =?us-ascii?Q?Cn5eOyF488uZk8IxNFnX0SQyqdoixPPJLKwgDF210BmN79tDMqphFR9QwVLY?=
 =?us-ascii?Q?FFbhVidUh7b5/2Io+BaOJexdbUNY7mR8obsENYCWjDtvNPVj34bAKp77KmRQ?=
 =?us-ascii?Q?q2lp87n0Xd06KAb8GGyjQeNSQ9g9gBXhna1ekvQ5cK4dHuX8eJVczHb7cDG0?=
 =?us-ascii?Q?J0CuWjMC5edpI9LSedvhcrB7TRpp9uMXMoFtXd4s/QMuAF7Wm0SyfXVswfxl?=
 =?us-ascii?Q?p+a/Ec2Hd2ZPXx7hIPSRGJAn6Eh2nvbkroaawtv358Ni3VSyXh1QPsxzvegN?=
 =?us-ascii?Q?E4vMmbJrYYClzixFLrupNv+eE8WTXsjzrU5KAHtY9joZVohlfIBBmQ+qQ1X4?=
 =?us-ascii?Q?DNWZRMiov4tC58HoCueJMAHO+hC09bAG/PdmeJksBR9w98BDw/yNEZefeRh2?=
 =?us-ascii?Q?P0vCG33/gZ6XY6w/wwkUIRnZNpdzpYPDwz0X7CgrvPVnFC2SlqeqYfYyHqph?=
 =?us-ascii?Q?7xTTTGfDuCVHcpScoJdVDWtu562kepw2mMKAFOgNPiKWpHIE0GFHg1Lw0hvo?=
 =?us-ascii?Q?0MEMImnArh4Omo3fnrPGrMrkx3+Rv4i8f+wI5x0yj+dohkR+h5uVuVqFHDxP?=
 =?us-ascii?Q?MzNlum6BdV8TB1p5onUmqcDcXf8ftuAim5eCLLbJTzNR6hiuHYB/lFd6PiEC?=
 =?us-ascii?Q?Nnkd1UMkv7kASwQB3OaVGh35fUk3jIwQd17M5xGaIeS000TJys60MnF73VRs?=
 =?us-ascii?Q?xpNEQ2rQ+2hlOXRc+T7dlryhXoVSnBoB9Kt0j+ctdaKAm03z/I1O0BTXsOvc?=
 =?us-ascii?Q?ezTwpjclGrb1wa+nzh4J0+aVUxfcapHE+Jow/AIhWr2LzCNtIB1FNrPx9nAt?=
 =?us-ascii?Q?u54EowUIERogYFx9Kuvtb8pqhcPVAldl+XFF4mdT5KKlPMkxkzn5yw4PPUHF?=
 =?us-ascii?Q?1ARELBp6njWR54VuHS7A3Q+ubnyEV16X+zRJlfR/INtxW/5GbQyXgHCYvZmb?=
 =?us-ascii?Q?qHByaksMLmTDJDjFPi3LIaeS3mvML8aMKbFE7yEsMx2VJNAk+ZkIuFsocD0+?=
 =?us-ascii?Q?8IdFgXCvDfsBoU/Fstfz8Nr3rLcdKgynGFPpiDyn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6ba0a5-d83b-4b27-51b0-08db988c7243
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 03:55:18.2801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5C6+GIEiJmDGe3wBqjF2unDM3MDbaU4UCszTpMX0Qn7s+RISdNXpDVWEMCyHBsb4pGs3idwkuK8/ROhb+bVn7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4988
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, August 9, 2023 1:27 AM
>=20
> The two callers coming from bus_tye -> dma_configure() already have the

s/bus_tye/bus_type/

> device_lock held for the device being probed. Mark this in the API so tha=
t
> the core code doesn't attempt to re-acquire the same lock and deadlock.
>=20
>   __iommu_probe_device from iommu_probe_device+0x10/0x40
>   iommu_probe_device from of_iommu_configure+0xf8/0x1c8
>   of_iommu_configure from of_dma_configure_id+0x188/0x450
>   of_dma_configure_id from platform_dma_configure+0x24/0x60
>   platform_dma_configure from really_probe+0xac/0x3d4
>   really_probe from __driver_probe_device+0xa0/0x1e8
>   __driver_probe_device from driver_probe_device+0x30/0xd0
>   driver_probe_device from __driver_attach+0x10c/0x190
>   __driver_attach from bus_for_each_dev+0x60/0xb4
>   bus_for_each_dev from bus_add_driver+0xe0/0x208
>   bus_add_driver from driver_register+0x7c/0x118
>   driver_register from exynos_drm_init+0xe0/0x14c
>   exynos_drm_init from do_one_initcall+0x6c/0x318
>   do_one_initcall from kernel_init_freeable+0x1c4/0x214
>   kernel_init_freeable from kernel_init+0x18/0x12c
>   kernel_init from ret_from_fork+0x14/0x2c
>=20
> Internally make __iommu_probe_device() require the caller to get the
> device_lock().
>=20
> The three remaining callers of iommu_probe_device() don't seem to hold th=
e
> device_lock():
>=20
>  powerpc/kernel/iommu.c: iommu_add_device()
>  iommu/iommu.c: iommu_bus_notifier()/BUS_NOTIFY_ADD_DEVICE/
>  intel/iommu.c: probe_acpi_namespace_devices()
>=20
> Fixes: a2dde836050f ("iommu: Complete the locking for dev->iommu_group")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Closes: https://lore.kernel.org/linux-iommu/bc5d6aa8-e8ca-c896-2f39-
> af074d55e436@samsung.com
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
