Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE15776E1F
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Aug 2023 04:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjHJChO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Aug 2023 22:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjHJChN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2023 22:37:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729A01BFB
        for <linux-acpi@vger.kernel.org>; Wed,  9 Aug 2023 19:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691635028; x=1723171028;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=coZ8hOzdXA68vFFayDVq76iWwD/xDEOjF3UORyNimzQ=;
  b=j2vvpGYZ3Skhyt82Fli/UsyEx8GQw9fxkgSKUqFATrKapi6t5GA3zyhD
   OYhIFfR3MrZVIw/RgFotiNtgTUDE8oSWYr6HnEoYpsf4bIGvQhNoOMrVT
   sbOVD+WGo4IoHKYjTFDbpcRblmZjZZo638P4LLJtRlbX9iQxhJ7yjpO7v
   rQZgIPH02o6+UFlqLnjdDJMk1BwxAVW3ztvn//DrRAmwlhMA8EIdJvxkX
   twLc8Aq9hK3x3iHGmMNgLYH2OHTvtLMvA2JPu6mNiApq+BViDCRBxWAOk
   U07o5gBh2YcAamCiHn5QAhVY4Kt8qRQIJ2ivemv0LXq485zW81S7gVIM6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="350860353"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="350860353"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 19:37:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="735230078"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="735230078"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 09 Aug 2023 19:37:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 19:37:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 19:37:05 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 19:37:05 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 19:37:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X15g7oeg9g9F2bQUCnG+rUoz4cLjPUs2FKTcnWY07DzEnGxDPn8JkDKHq5pu2qJJUX3aaEh7tbIdSxLiLbzMsl7a5lqxi7xgVW5z3G5pty2a7lF3RS7pdtT6SHKwVMyahomzvVMI3z+x14qUcVTrkZTHa+zN2wL0/L8X0Dqs8yuPksBYndm2BOs0Uimlf0DBFIkm3GkC2qK6qoRnJVZkED57AU21YPOAzLbQtBlMuDeAMWKzJLPt0b1UXjP+1YlZKHC5dxlbZhjyAlBGeYvUbcAYjoLzwv5eKgDJKce3FWD5TADMLIyzNR1FbBqlyUD/5p76LFhLQ+jEwKRXBIOElA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMqK8CDk/sOc72z/PNINdElRyxGFXeq2z7pv3QcpIok=;
 b=GuWkcyDi8HKywINgUkmTOnHXIpNKvVtGk/Dj5fLYpmrtRXz59NkA8FY5CpGgiQjp2CxXo9EHNYwSc1GlDKpSDFU9CV40979+l8NoirrsfgAReOXVBwzLXSUo7CJNcciX6oGowUc2ohH6t5vdxzJ5g9GZfU3jIlp5+a48GTY9pBtYAjTkI6DnUx7nyLVdlPLHexWnqlKcEohHqJJzeIwO1v/M9Kcwd774TmMaPhrBm5JPOhVpC8zEUkznnID3NztcQVgTk8NH+QiHB4Fh0On4E0LF9j8qAnS8W5qnzBUvKHfzIVVug8gwE5S81K4aIZLJ6gBZgae8LTTsi7ByJeZstw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB7176.namprd11.prod.outlook.com (2603:10b6:208:418::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 02:37:01 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 02:37:01 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        "Rodel, Jorg" <jroedel@suse.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: RE: [PATCH v2 3/4] iommu: Do not attempt to re-lock the iommu device
 when probing
Thread-Topic: [PATCH v2 3/4] iommu: Do not attempt to re-lock the iommu device
 when probing
Thread-Index: AQHZys/uw/8ka6Tyz0a8lt6OgqUeJK/i0VmA
Date:   Thu, 10 Aug 2023 02:37:01 +0000
Message-ID: <BN9PR11MB5276E38BDF369FE71E6E56E78C13A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
 <3-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
In-Reply-To: <3-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB7176:EE_
x-ms-office365-filtering-correlation-id: aa927e61-70a9-4eab-f192-08db994aad2f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 16K+9hqZeCNmClsc9QD5rjehmNYduFGcVOJdtK8in2DfWeUQk6ORk1Y3p8df3URI11vfPrVipcV18ofKpo3BF36FPDwiBVq39g7XeeqKgvjub3SQraqwInbXteV/wjHKCrhJLhjZi3LfjlN21RF4yZp/GDxx8c0fsqBYEr4Zl4oW+0yknX3hMC57GYCUXAbL3oGQwig3k+SnueOhGzqO+Y6rnTokCQ41UMSfBbntvQLeiTj4fl2bFpyxTlLsnrxW0p8ppuQT2IzBdOMFc5X9iXMrJ3sU0KRRxTUtIX11dWL/SiCinLAJ35jgr1ddDRgb8fd//XIGdIN1lHIs1bHfzWhSR0xVYftNWZeQRSv3iUdx8+hO7Mj31LUn+EVOoZNPZtOGU3FZvq3GQDFjFncH50p7RsUvl6t31o7uB2WpV08Ulkwby3Ax1orGc2ddKVAEgT8GJsOv6k0le38YuFGKcLwkqiM+Z3Kig3zrTv/Lf5gaGpDIh6CLyMyuvtzzKw22/rRP3sM08vkrelNezTD9fLxwlCBrMEjBhGuvHv6RZZEsjjez5g5rOMtpO6yuoe3CHv9q+OgYg4kp882gPgWHtPMPgRCV6CGV5S+HLq2PVU0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199021)(1800799006)(186006)(83380400001)(2906002)(38100700002)(110136005)(54906003)(478600001)(122000001)(86362001)(55016003)(7416002)(5660300002)(71200400001)(38070700005)(52536014)(6506007)(26005)(82960400001)(316002)(9686003)(966005)(7696005)(8936002)(8676002)(33656002)(41300700001)(76116006)(64756008)(66556008)(66476007)(66446008)(66946007)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?irc44I+DUn3ggVJVPfNz57fDmhLYC5urUKTYmyH3OfP9GBQ0LmkeRtY7qjON?=
 =?us-ascii?Q?O35qQiymXJ9nxdCD9X2vfEmWrINlSg5wBj6A4+tbLTfUw5Q0rPVqJ5NQeXet?=
 =?us-ascii?Q?RBTyi6T1WLhc0Zh7wufUquIQuWctM0VFVicXK+ofyFM3R64eAeg8FWL8BlXc?=
 =?us-ascii?Q?LYqMQyhgm22NbLRD7++UuQ6GQiDdp3hqEZOB3h2LtAINbOAQLV4ccRR763Ek?=
 =?us-ascii?Q?Hirf/HQ4JH9JtiIrIQvgfD+T5Q/xZCgxcmL+stA5c9QnMBKsdD0f8J+J+JFs?=
 =?us-ascii?Q?CHyUNSIU4W66FmSNYXuV+rcbpIu7xUYhWpOmqrg799OcixTKGhKgnD/RI1IX?=
 =?us-ascii?Q?qgwyF0dOL3oP9Ta38oK1s5p0J6OQavhLgD/KPkYrfPB1FppPMhhF3gKa/nUt?=
 =?us-ascii?Q?yXknKZm/quuP7+duX4CJdZTlVMSinDIax7MTKkILSrqGK7GGDcjpgQ6CXHno?=
 =?us-ascii?Q?aS8ZzO3LiEuxf3Vf+g6egTIB2i2nYvQp9P9SuQPQyipHzUEDcmCx+/tr4LJi?=
 =?us-ascii?Q?/dFQXN0KLItRTDsbeaihPyMBiCSwgZn1B7N5NFPPf/dVmL7h8wTBN3sZLwWN?=
 =?us-ascii?Q?rmGISDdgrYIS9MTr1Tb/7Jvzo41C+X6RWRJhsYLUK6e1nOrs9QGX0iMSrv5+?=
 =?us-ascii?Q?4JAPqCriFCI0i3EfCrRAo91KhVK1BSBZ20MQknbSlobxDYwtBzQLe2jnwLOn?=
 =?us-ascii?Q?YUZCgvXcLZOHAwRiSkBLSFl1X50Ndhr4OkSLnOu1ji/8pH/rQMDX6gJgcyFk?=
 =?us-ascii?Q?VcIg0mX4IPtGJOdL4krpxtcZOGSrhHAxlaIYIAwHrBssPIrZ/lI/WXyXX/ok?=
 =?us-ascii?Q?MFslZrq4mACr8VlCg0hZaNWnD6D46cCkH9MKxB/XDq9WApfKcMG5YC5n4uQA?=
 =?us-ascii?Q?41yze7dcCS1dxqlp9cPUXvGtbo1o7Kev8FG6FmbginNSAiQ409LvEc6IJt+I?=
 =?us-ascii?Q?m83cVJtszLDg9t8PJNNrQ3Mrj6xDcwOikL+HouapVEsOYRjAa4cgn63PvQ9w?=
 =?us-ascii?Q?dEuCVIfHqBPIHpMTcgUUUzDkKgHTvC9Zq8O/Cl1vYUhVPejEl17iH0fAkE3V?=
 =?us-ascii?Q?qx4s445YzGXTPQa9G8JMSb8GwPKY5f7lFaj6uJo+6d3Icv+vwy84YGVPfzOn?=
 =?us-ascii?Q?BCyKMcwXHqrDcWrsA2z4U75ym7MQpOECx8cMG81tQQueex69dtKOChUOKb8W?=
 =?us-ascii?Q?ooLNJBc6l+FJHV6BELnIhw6tZoNKYvwLpDwOT/C5KQCs06EKV5iMJJKRmNZ6?=
 =?us-ascii?Q?7H5vzmAMIjHpgb6KbAJd6x1gi8oPgg9v8V6QrVfocUTFI347l5AfSmVpXv5i?=
 =?us-ascii?Q?Tsl9+vZ0MSFwJGXGLayr/uH1TfmJbcEbG2I7osTMIgKqarCbmpgBWIS3OBe7?=
 =?us-ascii?Q?9RVC3Xx/4y7hZvNE7pjFq5LeKpxgHrNQ1ZJtLhltRHD4MIDHm7RcRtH78JvX?=
 =?us-ascii?Q?5krUM3T5HBFfauCYNv0hkVVQLZvV8xB655AyO1f0ypTeuGNjAFGuPJczYc/8?=
 =?us-ascii?Q?wxSK8Q3t6SaikcfnmIL7l8LY0fQz4XgAMSJUFFFrkg1LILnNJYp0FABoDAH1?=
 =?us-ascii?Q?Vm+0iF8A8cNm9xBEVgs0+3qEEyFngBxX9/RiGmu/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa927e61-70a9-4eab-f192-08db994aad2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 02:37:01.4836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YHJnvSQMU/RTpP2KMx3CWfj8RH/+mW24M3R2QIPue+IyRmybhZyVGRMagqNlcszkhNN9OUv3306oR+2Few4FyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7176
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, August 9, 2023 10:44 PM
>=20
> When bus_iommu_probe() runs it can attempt to probe the iommu itself, for
> instance if the iommu is located on a platform_bus. This will cause the
> device_lock() to deadlock on itself as the device_driver probe() callback
> for the device calling iommu_device_register() already holds the
> device_lock():
>=20
>  probe_iommu_group+0x18/0x38
>  bus_for_each_dev+0xe4/0x168
>  bus_iommu_probe+0x8c/0x240
>  iommu_device_register+0x120/0x1b0
>  mtk_iommu_probe+0x494/0x7a0
>  platform_probe+0x94/0x100
>  really_probe+0x1e4/0x3e8
>  __driver_probe_device+0xc0/0x1a0
>  driver_probe_device+0x110/0x1f0
>  __device_attach_driver+0xf0/0x1b0
>  bus_for_each_drv+0xf0/0x170
>  __device_attach+0x120/0x240
>  device_initial_probe+0x1c/0x30
>  bus_probe_device+0xdc/0xe8
>  deferred_probe_work_func+0xf0/0x140
>  process_one_work+0x3b0/0x910
>  worker_thread+0x33c/0x610
>  kthread+0x1dc/0x1f0
>  ret_from_fork+0x10/0x20
>=20
> Keep track of the iommu itself and do not attempt to relock the device
> while doing the probe_iommu_group scan.
>=20
> To accommodate omap's use of unregistered struct iommu_device's add a
> new
> 'hwdev' member to keep track of the hwdev in all cases. Normally this
> would be dev->parent, but since omap doesn't allocate that struct it won'=
t
> exist for it.
>=20
> Fixes: a16b5d1681ab ("iommu: Complete the locking for dev-
> >iommu_group")
> Reported-by: Chen-Yu Tsai <wenst@chromium.org>
> Closes: https://lore.kernel.org/linux-iommu/CAGXv+5E-
> f9AteAYkmXYzVDZFSA_royc7-bS5LcrzzuHDnXccwA@mail.gmail.com
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
