Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BCF776E23
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Aug 2023 04:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjHJCho (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Aug 2023 22:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjHJChn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2023 22:37:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909D61BF7
        for <linux-acpi@vger.kernel.org>; Wed,  9 Aug 2023 19:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691635063; x=1723171063;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NVNplHDxqeI8+/c3kLCKf87zKFy9nL4z+g09AGAGtuY=;
  b=LBxDI8GYWfxr0EdCmz1L2zhZmVBAol99HB+wdSs8cU5R1/3+TBw8NJUa
   r0n8Y1fFytDbSjhD9HuD1R6zmB2vPej7P091OdF3/LRFUOFsgPWj/PQ8k
   40fjnfAn4iqc2aM9daP2lbkkTVF7YBqbD+ivLFIBNNDQIrWV5N2GvHOzg
   7F+gb+QeIlf6TbAwBIB2c6Al64M9NGAb18UyvYuRceQvXkjbTl1QBUDp3
   f2oJNBF/NWFsd9p/7vM5dDmVbLESYDyqVaweSantnLcGHvd+yVcXf436q
   M23jE3WJJ5Hl/5xG0F1ztls2znhddVmZIfe3M8cpXFfkKNfrptiPUSJX5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="437637811"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="437637811"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 19:37:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="905877672"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="905877672"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 09 Aug 2023 19:37:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 19:37:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 19:37:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 19:37:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAzHsIzJ1yuf5V1Y+wLnJHtNAzdQ68xz+KYAe9zRXYb5cx8biBbROMbQjRQXRhMBQQKDXDxXPnrBIi4zFdgV6KifmwCyOrWyLT4uXPu3AcS9xsPjT3P2fAuU1GCmyun1twJkpBTc0axp3eJzKxwokgVIBneg+5m+w68CqApM4vbLh5dee4MbDKqa2SD6fGYVZAeJO8RRcH/ilGkaKqA0SllwBUrr512NLQtiMozuF3yhxMo1R5RPGLEu3HJ+DnsoyRJNrHFv/hHIr2UaTCqDTDuK4iagV5AL8vyRzxIh8jUOJvjgIwG4E2sB2qclWhnCkqYKbE962ytt2jyAayCODw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkRptwKkrnz2Ykg8D50SZ6PjHDFFn7NRA756rx348YU=;
 b=OmBvnsv1Kz3/2ZwqE1forhVyM5Gkr/lbRs2Fn3T4axVV0dCAipjP9465sYebT8J/4NJfL8UQmIr0/dASlzil+O7ockHq2+J3VmwVYGPxMtpajNg4Hur+lrEuu10GA5C+V32Mo5k7ecvG6W+yrj4IsoMg0MrtMEecKYHo6BVltJtiIql/2faR8MeH3/6uD7XH0xIV2qakZnPVazFpi9ByPu1C65Di0/Pt3t8YEl8j6zde1EjXtM2xjkxqNkd1jIqZGznmLZ58PxkTHWXYJc+oBZi+4Gi3D+UE2HEuK0pSM0HWZmroecibfU18nkE5mjQSOTBvoIz4EGK2WpporC7nJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB7176.namprd11.prod.outlook.com (2603:10b6:208:418::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 02:37:41 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 02:37:40 +0000
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
Subject: RE: [PATCH v2 4/4] iommu: dev->iommu->iommu_dev must be set before
 ops->device_group()
Thread-Topic: [PATCH v2 4/4] iommu: dev->iommu->iommu_dev must be set before
 ops->device_group()
Thread-Index: AQHZys/2nwYChGiNH0a5WZggwO/jpK/i0Yfg
Date:   Thu, 10 Aug 2023 02:37:40 +0000
Message-ID: <BN9PR11MB52769845D11B3B23401644098C13A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
 <4-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
In-Reply-To: <4-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB7176:EE_
x-ms-office365-filtering-correlation-id: 0f18d164-a8b7-4cbf-f26a-08db994ac4a6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n5pJhAPfRAaV08BjOo9AWrC3Z0xXt61oAg7x4EtDuDL/ktdDiwUATiOBdqHpc2oveawffnSRWl8X2sHXAzdyY3f+o3rzY1HeMdWd47Y7954Y2njA2mKS2rbmOYYKSJmaTYir6fLYfd9FUr0KOc6YCA5QCL5QOYNterSAcuZKK1GjCRZNTzgJ2hSHM4BlCz8ufHjqmRNELneHRjv/p6MqNbxpnWkrvAja1cdyq7RRePCnpenJZSDE9Tt4hy7gg4AvhxdHGYlz5EBj4xtyNGz0gS6YLUeXTMuWDLk7qRqFyXIN+bQ4ZyodUqIwoNKn4e/tPLYNz6rcPrjp3+s+VhuQ252EZ6bTkOJasfKaOYouqNzYnGmJih7Fy1MLzFUYXG10Nyf+rO6CZhjrqdkKkW9MdZCT7uG3pG1Gi6OdqJdT6yIwiFBGAPpn1tnZZyUWztdOG5TycZRXocHJgfLXYttdyrCEFFMlX22H+2xnSDTt7AthjwbzWTCQV79vePi9UU/TEE1+HfOzTkkbES/3ZKcpnWD/NT9ARdic/A82QyMNyvQzQDWygacy7V8yeCzbRV89l0/uhEMqgRcTFlx5SKfha+aKuwrmLbZKzn0fmp9v4gs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199021)(1800799006)(186006)(83380400001)(2906002)(38100700002)(110136005)(54906003)(478600001)(122000001)(86362001)(55016003)(7416002)(5660300002)(71200400001)(38070700005)(52536014)(6506007)(26005)(82960400001)(316002)(9686003)(966005)(7696005)(8936002)(8676002)(33656002)(41300700001)(76116006)(64756008)(66556008)(66476007)(66446008)(66946007)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ALQdh/KWB5zl6b1Z8oXhuh+AmGtBjC+xNDDE4jceXu42BG3BwZZ9ga5LnI8W?=
 =?us-ascii?Q?7Q8TFMdV6d4QcGqZsJwEq9pDj8ZsQVdtc7alNxb+0+OmQqVRJJ0xXcRVKt73?=
 =?us-ascii?Q?FC+f9nGJw3d+rmg3T6jFNVe1/Y1mjhiCW5USc/Oy+YNF4/0ebiixUhjlJHKG?=
 =?us-ascii?Q?SLXkU2DdO4hZ7JHUcYPOhAC3hKsvg1QVtKpDG1YK3dNiIaIy+NM20FufgVIs?=
 =?us-ascii?Q?YQhJoLRdiL5u6we/5lXagNtRbg8oVNmyx9JJBpkTziLs/e8l+UgXianZMTsZ?=
 =?us-ascii?Q?G6r9AUY+AlWIS94BPUCPAi6jupyiFtF0vX0Wse3cLA+rsU0NUw4kHikd5xjU?=
 =?us-ascii?Q?14SXE08Ph27isvdX463KX0eOfFP+RQa8kavfD8/3dNoBT7Or6MvkpsJz39fE?=
 =?us-ascii?Q?dHMvZKtQoapm4qBTISg5GcBEXigRo91gU7+gb20VtbMaJmQvbqsc4F6i2ii4?=
 =?us-ascii?Q?S8TJ3sg9+rF/DUMGy5YHZGfThkuy/ONL4k4Na+BVgkhpqzYP4DRVtnenrO7w?=
 =?us-ascii?Q?R38nMKOPnVRMKjUNe9pj8KAbuGZBx39vSW4Dw6jUBbYFUtIEU0pd16tGJLZI?=
 =?us-ascii?Q?k6sjfPOxNeHqUGdIn8i2acg7u3Fqd9p0DH5wKRXCOtvc9WwFbe2AR4vvKHgU?=
 =?us-ascii?Q?yAHF2VE1o6LvPxOxPdXWUZSzFmltr8X2Riy4jiwkJC6K5QcSZGnsIjunvIbw?=
 =?us-ascii?Q?RNT7LO01Okd3tu/OhgMWsFDBA9thWkJEa5Hgw8orDkP39e8MfNYEpE/e/LtF?=
 =?us-ascii?Q?n1q/tO1RBpc5LmnrBrjsXGefQkGMRtwcnpMd9GbjqgJt6eItyTU0V0Z6nEgb?=
 =?us-ascii?Q?w/C5/mgvyUZ0wTWKuRvpt6opbwuj2Y0OfmkTCO6D3fdy9CHAP9Ma/AaKoGpr?=
 =?us-ascii?Q?2JoIsVWW3jukTiyF//Bbftc+R/Y0vd3roiuggtR4njhLhQUx0qfnAgUco2ec?=
 =?us-ascii?Q?5z/Zb70+0v0TebVuVPn50MmXv/Y/PikjlV4MqLCxES4ZVuHdJXC2LNVEcUHU?=
 =?us-ascii?Q?L0cnHwoazUYGuPK1r6YO24UvFj95ttoHYUzmnyXIdUfSMgvGBX32ysFba2PT?=
 =?us-ascii?Q?JaEDHipkXbe3UaWuaIfuKH5Ofu/u5ouxQZuM4c7UcKxoDPN4XnDvJvONvBfu?=
 =?us-ascii?Q?meK7HhWVCkHTaYkz3JWGD8EchdYbDkIfTv05KVR7N88Vqx/xJM9v0rb49IAV?=
 =?us-ascii?Q?493VF9Eh8Sf3SzXmghZf5SufTNJLM41l5fFF5K9yyVI4wUohZsI7lfVhoWS0?=
 =?us-ascii?Q?OYYNTk0t7nphW9Vea8tjkMv4SRZ42kEg0vi6xFo4SzSWOlzyiXFgGmfMmAcV?=
 =?us-ascii?Q?2UMpVxt4avoMRPDWyH0GNXmbFayu8BRsck2IP5AaQh0ySJN58NxPLWUIxkV2?=
 =?us-ascii?Q?92wF5rgcwMGR0yV+h/Qg8SPN/JWZYadZR6Oh5NbotHU23nCZuk5tyc+5osb2?=
 =?us-ascii?Q?Yhe00GIA3KEQdVdiJ68zaiv4Fym5BciiC5j/HEF8IiXhKkX3wfCNki4Rpd4U?=
 =?us-ascii?Q?11rnRuOsDSAXoy4v2+Z82lvLU6ZoanSLVJaqiJwN3oLtChXrFMGTREXVrl2u?=
 =?us-ascii?Q?bEsYQhyonxM5hLakEXdq/Z/FO0RfFAoQjsp1R4dJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f18d164-a8b7-4cbf-f26a-08db994ac4a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 02:37:40.8408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EXbRgqws7q4ITCqest0gZQ9fFWDGrqdR4xudgzWLQi7e8YaC1dEgZhLyQmf2hd85SWeu6NwY+5kMmlIwmNVjaA==
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
> As generic_single_device_group() requires it. Otherwise it crashes:
>=20
>   generic_single_device_group+0x24/0x88
>   __iommu_probe_device+0xe8/0x444
>   iommu_probe_device+0x1c/0x54
>   of_iommu_configure+0x10c/0x200
>   of_dma_configure_id+0x1e0/0x3b4
>   platform_dma_configure+0x30/0x78
>   really_probe+0x70/0x2b4
>   __driver_probe_device+0x78/0x12c
>   driver_probe_device+0x3c/0x160
>   __driver_attach+0x9c/0x1ac
>   bus_for_each_dev+0x74/0xd4
>   driver_attach+0x24/0x30
>   bus_add_driver+0xe4/0x1e8
>   driver_register+0x60/0x128
>   __platform_driver_register+0x28/0x34
>   hantro_driver_init+0x20/0x1000 [hantro_vpu]
>   do_one_initcall+0x74/0x2f0
>   do_init_module+0x58/0x1ec
>   load_module+0x1a20/0x1c64
>   init_module_from_file+0x84/0xc0
>   idempotent_init_module+0x180/0x250
>   __arm64_sys_finit_module+0x64/0xa0
>   invoke_syscall+0x48/0x114
>   el0_svc_common.constprop.0+0xec/0x10c
>   do_el0_svc+0x38/0xa4
>   el0_svc+0x40/0xac
>   el0t_64_sync_handler+0xc0/0xc4
>   el0t_64_sync+0x190/0x194
>=20
> Fixes: 5dd59857af60 ("iommu: Add generic_single_device_group()")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Closes: https://lore.kernel.org/all/e5e75222-13a9-ee01-0c25-
> 8311b622fe0d@samsung.com/
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
