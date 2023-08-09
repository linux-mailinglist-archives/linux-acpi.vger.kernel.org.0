Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5727751C3
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 06:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjHIEB6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Aug 2023 00:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjHIEB6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2023 00:01:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D891986
        for <linux-acpi@vger.kernel.org>; Tue,  8 Aug 2023 21:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691553717; x=1723089717;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mlEtarUxQ7iIcbKjY+DO+zWj5PjLER2aIawvfQGmsUQ=;
  b=VFxOiONx2jy5zrKT3bZD+pWGgau2R01beuzhNsfTA+Noo8UPpfBNYIhQ
   L+EGekbD++zhGSDjJ9h9qNKJtRTszoqjXTP3uFHVhavrpjA/G3gQj1RKB
   o55LcHsY+aBwvK/c+leVujRX0MVNNDngvvLAY70abcRgxLYHPDfc3smNF
   MY65gbzfOktBt7ebC0tFHhFrxXPeoLmhPmV6XDwH6MLBvujm2HtAsafg5
   +CVi0AaYpHvv7mX5dzCLECz5I7lE/qxKDeX2n2tguAx0y6AHotTer8fet
   UGzv96jM0/g/cBWiOlKDBrwAboO0WoUk8zBH4/W21RnCLefv9WwOj4Y1S
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="371008381"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="371008381"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 21:01:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="681517690"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="681517690"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 08 Aug 2023 21:01:44 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 21:01:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 21:01:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 21:01:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 21:01:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyjxZuxRgCqk07UGJ6yBDT20cNMkADYDjF26kdLCJxGXedQCJg0Katu6ppeq9WoFUtm+ugyeBgVrVd7WRXp1cqSag4YiBD8v2hdzSUkLdLENwsQR8ypF0mBokSHGdRoT5vHaZ8eWPxbEnQF60PjM37fTLJKdYk+ihJ1oRwNuFZkm2FCFswESGq1otSGM34IwOtypi9pQeFPsrb7Ak1wisXQo1l2WeLdHdq0rrf8FIGGIzn6Xbdr06iD0ZHHxey583cq62h5DxkqW+rS0w1gisaguOQxOlMeC+lE37TUykR8FwNLt8OhYU1DvlG0Voscu5pIqcSKRxZH5HTpgGM7zOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zklLz7vuCtVLx4x9Ne4YIw6rYDvneZKkVqbQoRi50b0=;
 b=NQteSiUGnsGfMPsb81LjxDmwJKCs6QYr05mlpgq0NPlAdS3vMiiA3Gn0UrCq+RFqHhfse+aBwS3Ja1cor+Dy83Q3uTsqpBta0xim7RDi8/UiNXL1P9IsDsqEawVjyxE5u/y3/J801z9tvZw8nioKv/UYwTZqdf7s6RAj+6dj+W3R6/o4jJf6tvM1fKvwrbuV0PKCuilVLKk2lk2jfccY8MpuwxvahqdVoRaaLJV/DPp3NDzQf39p2vLYNRSmfYgO/CMOnDFqtYicOkJl0WsnA2lV3jb1DXKLCyIl8bV64HXMVFnAdXW9DWoXs1QlPBs35J3f4w73tPBu1848JicqDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7412.namprd11.prod.outlook.com (2603:10b6:8:152::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 04:01:42 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 04:01:42 +0000
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
Subject: RE: [PATCH 3/3] iommu: Do not attempt to re-lock the iommu device
 when probing
Thread-Topic: [PATCH 3/3] iommu: Do not attempt to re-lock the iommu device
 when probing
Thread-Index: AQHZyh2akg5YH0F9h0yZdFfxvjRvRa/hVv5g
Date:   Wed, 9 Aug 2023 04:01:42 +0000
Message-ID: <BN9PR11MB5276EA0632C6E65C83397B1A8C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>
 <3-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>
In-Reply-To: <3-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7412:EE_
x-ms-office365-filtering-correlation-id: 8d50e275-1135-4f39-9964-08db988d570b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yzR0uqXVlgG+IIaQZZzIz2bgpGmK8GijQJGB6zW/+Dj1snjlI03H3BwMOzzyO2lVcJsVLuEVP4XinTyZ6pfqPs7VeIX8iACK3IWpg0pyvctbdeV4Yg9u5ZsKf8FqYRTwDNMkkv+QaXLVgyXW/JFTnJJ/kP56ewzDyaeWhfPwbvTJR9gzh9dTVdjZK7TDWnFxrb0c2t7eq/fqldYxaYF/WO49e1BXZaqglWeSYrnN/Vf5Lo7t/uDaGWAXTgKjYbfMCbB9cIv09AZFGx72MzaFnlF14qJirKMmmYP2GpIqlsiV/BtBhkNn2yxZizVec+MwyEyLwo3RaLvla+Zk5m8uMCf1yB6pW4bYNJOzQW0B0l11TvUNymMR4mt+BatAvHUyMb6gNvpS3XSfI0RfGRATvFs9Ww7jfxgDXyjNiawjqAap3Og59p56KaIPDtL0k6CXlFmjI14/yuQVvQ3o9FDeaUxOjCXuUNhHduF4yI52zs6OesLlZf4rvBmIWX1n2gpeumaacuxyWGuK2pVJyJV/X+cHUP65s8/4KfZ0RDvwqM+ZujMMpz9HIb4p16FFPBk6UYrz6q8IkJx00Hu8IpmBSKsIkIZBahFm2TRB9m0YA+xNKvo9XbLdFzzK758FjAJE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(39860400002)(136003)(186006)(1800799006)(451199021)(6506007)(26005)(9686003)(71200400001)(7696005)(122000001)(478600001)(82960400001)(33656002)(38100700002)(110136005)(54906003)(66556008)(66946007)(66476007)(76116006)(66446008)(4326008)(316002)(41300700001)(8676002)(52536014)(5660300002)(38070700005)(7416002)(8936002)(64756008)(4744005)(2906002)(83380400001)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2LYuZIhxyGiYImRklvjiQc7OX/UA6AsPLAoC2AheH4Lum2DCicU0hBENdW7D?=
 =?us-ascii?Q?DpxjU+8WVd9d+BdYCUo68FobUItnBP0xGAu6RPlDmdA53mRGPi1E/ODOeP6J?=
 =?us-ascii?Q?5WHuWHfRJS+cF6C7WVggmUYlE6FBjccGezjbsUMO6b/fRdmhTpeJRkAi0M1i?=
 =?us-ascii?Q?vmjRr8SlWaBtEstSj6RcEnsbEDykA9Zs15SCQLZsorjRe1zwoFu7rY3SWCsX?=
 =?us-ascii?Q?7SofYQmNT9HwP0k6cA69VHOIqzNu+mfHHK8Bi2ijTLhVr0ncG/9pPdauykho?=
 =?us-ascii?Q?J26AC1Vub5piF2iNljaQRZ6O6cn+8CqH99ike3foAmmIPxWSU1I7F8C3BUck?=
 =?us-ascii?Q?7PmmSevJl69+FUPGaRZtjYKP1UV8fs4LoOULzxYKPLaHkZK+REEUPKY+CzIK?=
 =?us-ascii?Q?XoHZH8kY28y7svMm7DI7CduP5fo8MiQs1ZTPqoLw/3Md4uwPWR0H0ohpUz8K?=
 =?us-ascii?Q?vxBXkGcw9Y3uSlYScGlHwOglHq5rM1HEy7r6Kp55tYZNIOtxVOZh2pctm134?=
 =?us-ascii?Q?v9FWIMKdgQjnKaAue+rfwKnSeLXTgy3AdYtL+DSQYjduY1qZapGwrzrnBzGk?=
 =?us-ascii?Q?gU0cyqdTPVBzgS+ghCbtPRqwhq2AtP0jkXhv/ykm6an1YDZm9ezNODjHS2Dw?=
 =?us-ascii?Q?Xo5x/UE2bUJtBU/UaAlTLU+xgnUMC/Uuu315RIILorNGgj7oB+2z9xIPO/Ua?=
 =?us-ascii?Q?M1cC7dt5fvGABhPie2PTRHDC38InopfX6GLWTzY5jfub9c/EtoKYpHZWuPZQ?=
 =?us-ascii?Q?ODKyahReHE+sT3+KUlq2QGOCPZFxRgLLpvkRNYOVJriAiALfh2X340T7txW5?=
 =?us-ascii?Q?ivXMXr+sOjvagnCCIFs2cqJAT4Kx4yvXAcTpl1B2bo1xcvyYgnA1bJp3yNOi?=
 =?us-ascii?Q?0bqGThu3P1Hcez4NSCSdjv//qmjraNhcZKUsinkUY1BC39c/PGyCnTnJMLKk?=
 =?us-ascii?Q?uOwg3MqGw+bV0CRG+yE4iU3jhix0NOAutCY5+wdOaojabnVf4f/+hxE3rI3l?=
 =?us-ascii?Q?HIwgPbMcegnBJKqFk5Ui12TGqKKsgvnBUTcjim3meO2UxIMhnpEL5nUXVZg6?=
 =?us-ascii?Q?Dl7r9Xw+YPsz+nP1J/lggAzWu/RyUyxOlXdU+hps8qQZdys2HoUui9GHU88Q?=
 =?us-ascii?Q?8gYXWfwNi3XRGzlm9aMFRSfimNqTG7t9cnsdyskeBC/2dmgODODFLWwox+QK?=
 =?us-ascii?Q?MZrJWa8l4ZJ/A9IgnBJEiyu7dWUvPqksKOMejBM45mVPbcwQL/pH+93CEUrP?=
 =?us-ascii?Q?PZz0v7HwkXxamzzC/1vuNnd8YzZlDHS1qoUj/jMUU1OzB2rFreNttqIjI7DJ?=
 =?us-ascii?Q?Ukel0Efzn9TkHt5QsQBRXCDOtzFEFJBty9UrP066c+dowsNQuYYw7kBC7P7/?=
 =?us-ascii?Q?TztMDZ2UG0kAu1WNZrqI6ez1RLoU4BkSmt3dKlbm7iuFAl4E+OU6PClsqtxs?=
 =?us-ascii?Q?Oxq/K77nBlVg3uN2lterV8ZWMzLqNMxIhBz8+On+t4SJlIggpuFIXUolajsK?=
 =?us-ascii?Q?aj+KHy9z7F0cA4Rx2XrTG1MofOJ4WSj7Zp/TV64/Cop1OOD/ivt0Rn7/ERd1?=
 =?us-ascii?Q?ivSqzJDfSxO8iXOF1BPDt6XSjH08+/wGot4jq6IA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d50e275-1135-4f39-9964-08db988d570b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 04:01:42.1184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fuaNW/JRnwDG1jE3X95neOf5qEH1I9mUVFNjL5KEOfHAhL/TO3eYunwHcxpNzu5xFeqFbaC/eir5+rNs7siQsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7412
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
> @@ -1800,11 +1801,18 @@ struct probe_iommu_args {
>  static int probe_iommu_group(struct device *dev, void *data)
>  {
>  	struct probe_iommu_args *args =3D data;
> +	bool need_lock;
>  	int ret;
>=20
> -	device_lock(dev);
> +	/* Probing the iommu itself is always done under the device_lock */
> +	need_lock =3D !args->iommu || args->iommu->hwdev !=3D dev;
> +

is !args->iommu a valid case?

btw probably a dumb question. Why do we continue to probe the
iommu device itself instead of skipping it? The group is a concept
for devices which require DMA protection from iommu instead of
for the iommu device itself...
