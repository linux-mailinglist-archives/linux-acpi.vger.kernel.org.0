Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE08D32F4BC
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Mar 2021 21:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhCEUql (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Mar 2021 15:46:41 -0500
Received: from mga14.intel.com ([192.55.52.115]:42296 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229597AbhCEUqR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 5 Mar 2021 15:46:17 -0500
IronPort-SDR: hOBbZk55vsP5gJ1PLESAXl3oNe85AqvLR1feJph/+WEfdTRZk7Md/l/IbFSS92hj1H9P3YAfLJ
 Y2LnmU1prCxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9914"; a="187079867"
X-IronPort-AV: E=Sophos;i="5.81,226,1610438400"; 
   d="scan'208";a="187079867"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2021 12:46:17 -0800
IronPort-SDR: FSDOPU+Ecb9oaYcAWEbIaVgeWbR9jcCfWi18O3LYCo9o3VpphuII71P0Uh0PILWTq1n2Bo0w5R
 m83440OOYS6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,226,1610438400"; 
   d="scan'208";a="429529858"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga004.fm.intel.com with ESMTP; 05 Mar 2021 12:46:16 -0800
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 5 Mar 2021 12:46:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 5 Mar 2021 12:46:16 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 5 Mar 2021 12:46:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qxaf0vQ9lsrN3uTHxu8wDXKuootf4rKUfGpA7gZViAvCvMdXGDclM5iqiGZfDSFm66O7kA7+7Gq1bYvwUCrXhlMi54sdwh6MP70L3RKSoTpEN67YI8ncVp29FTcFxWPaS3UZIX2hjdIKHb5SFNCgJCq8rNoYgmR/sTK6oa15vfRI41+7wesI/6zsWwhdqH9kJ4YeIaJ6GFcKbR6td+wJzEJryrpuvligCC47Mu04ftRTy0/v/Vvwc9Nqs1EyCs/wQch6rXFCUBkaNPzhWlJWKlrhrax+nyXgnIPDoEg7jddcTnYB/5xqJo9qpVOa7vopW9PMyzq+VxauyLdF0sWeyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7G+s+8STzCXDwvFjW5Zcbxok/JszllK5zlrfejVz4v8=;
 b=Otz73CzmfPvBasKdXKht8iwD17a8xXIOJ2o6BCk6Naxwvik7du2I2MuDgQFRVXNrfvhd/D+QAuCqC8HhypSUK/G/mz598vz3Y6hMJZUAb/dZ/tS8Kj/DWYanpxRJL/IZvDk0ij4ME4TUMww+Ex0oDrapv4HTMMMsevo5G2faLig8emhxTxAGdVYDQ176vfPDXx0VPoGQnIjUdVHT5SoHFt5Q+x4BI/0JHYYIGLESzQhzPRqslfE2XVYEIYnv2aZ8kykxWME6Io1pTN8XSXpgod5NHz0R+tyoUkI/y5EZEWxESnV3erhz0ydWESLjTZwwdPD0iZ5DqvYotTTyUYfghA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7G+s+8STzCXDwvFjW5Zcbxok/JszllK5zlrfejVz4v8=;
 b=B2RwdoHjNc5JM8qweKzUWq8+oEXQsF5MTEg69bb1uIMhG+9B+fbX7pwEsIrqsIShRgckk1Y7Y0PyFbENisDYuRKUYSDV6KHi2sFjGaoHLThzl4Xf81z4WG8UUghecIw1nzKv33BtZpNKA6fl/vrnE3LmeA+o0mrOrffQXxxZRE8=
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by BYAPR11MB3608.namprd11.prod.outlook.com (2603:10b6:a03:b1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.21; Fri, 5 Mar
 2021 20:46:14 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::ac1e:2d22:3f90:4dc]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::ac1e:2d22:3f90:4dc%7]) with mapi id 15.20.3890.032; Fri, 5 Mar 2021
 20:46:14 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     "Moore, Robert" <robert.moore@intel.com>,
        "weidongcui@gmail.com" <weidongcui@gmail.com>
CC:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Xinyang Ge <aegiryy@gmail.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in
 acpi_gbl_default_address_spaces only when ACPI_PCI_CONFIGURED is defined
Thread-Topic: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in
 acpi_gbl_default_address_spaces only when ACPI_PCI_CONFIGURED is defined
Thread-Index: AQHW/pI3ruT7cwkxjEOUSsZ8OrOy5apyuR4AgAF306CAAANRAIAABwjQgAHIQiA=
Date:   Fri, 5 Mar 2021 20:46:14 +0000
Message-ID: <BYAPR11MB3256B80EC10AF4965083CCD087969@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <20210209031744.26474-1-weidongcui@gmail.com>
 <MWHPR11MB1599D81078925FFD128E954EF0989@MWHPR11MB1599.namprd11.prod.outlook.com>
 <BYAPR11MB325658379DB73F6EEDD6C76F87979@BYAPR11MB3256.namprd11.prod.outlook.com>
 <CADFYyO73g8LkgwZv4m5N2bXq0XcZru4m9+K0uudCLmcp7yewpQ@mail.gmail.com>
 <BYAPR11MB3256FD804E3F3CE584B6D3B387979@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB3256FD804E3F3CE584B6D3B387979@BYAPR11MB3256.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 890d839d-8cdf-4014-a31a-08d8e017b7ae
x-ms-traffictypediagnostic: BYAPR11MB3608:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3608E878E81A3328DC0ABCF387969@BYAPR11MB3608.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PLXcau5YDA+uOlkmjXr9Y3dMJ1KuvyW7J8adNIRZezZ0PLBA4IEkAUGLiYbKdtbR4nOM/igNNjzWfUKI+Zm7yjUo/pfJcfYO+0qgNQNyXOic61BFddCR/HYmteTAx7F3uq6IazChn99/7qIckDMI95axDvToMKvND1dj5VtuBZHYgNQnVaOC5CHxAsL3fJa5KdDcR89ogIB+J5Qm6NkcLPziM4CD7g6XTW1gAben34rnz5ElxYwbJavdyTNb7S48qE3QuVMu0aBB81KpcVsYxteV9fTjWs0DlaMgEF+6S61HHjEPizs0Z5kq4dgeXkKrwkf8xoEFgZfnipA4V7Tvq80+Mpk28RcNGYJLsB8UeRIT6m1ngxYWwo82ThAl+uiRGq6PyZiiTCH19l584/QQei2D8TpMqoGGYHu/ltbquBWOWbWcYc2XT5jBlpKUH8635MV3aBPIh1n2QxJdQnN7RfkGR7icExQyCsXgS0NnHPIG61i+kpAkJouDtQ/iuRCTw7mBiDkpw1wO1mGustq8cQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(396003)(39860400002)(136003)(186003)(33656002)(8676002)(5660300002)(26005)(83380400001)(4326008)(6506007)(76116006)(8936002)(86362001)(66556008)(64756008)(66476007)(66946007)(71200400001)(66446008)(110136005)(316002)(2906002)(53546011)(54906003)(7696005)(52536014)(478600001)(55016002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Wyy2UlXir79RGYukGul6zS8kJ5aCjuNLDa4PWu51HRK6EpH16ZqyUryQk2pe?=
 =?us-ascii?Q?gYOWec2BYey8gDNqnMksbym/SoHLDeErBRELJqvft+TcwGZNH8EFwYBtZe2O?=
 =?us-ascii?Q?Grmxlr+7IcQ1+GVg/fd07gkmBE6jMZ2Pk4JiFy4yXMm/+A3lcAhFaAh7gCCg?=
 =?us-ascii?Q?W/F/YSAO2iG/FqnH/2nxxucGc7ILTJL4LeG/qRBXkWf64ZixWe1ciGDRSfLK?=
 =?us-ascii?Q?ov7MDa4ONQnburzBsVf+yzvDbARz2trK2nx26YotGtHG5582mygUAYLKnWkg?=
 =?us-ascii?Q?pXm27mRBC+TKwiQ4y4XOT+DjOB7MHl53y8IG+IPut/fjlHL6UzAVDCufjwdU?=
 =?us-ascii?Q?3vpC5v7rWGOAG9iiLn058zLMVwZHCJCDn6Q0q8M8B/r05Pc3Puay2cGdIQxU?=
 =?us-ascii?Q?IpFqCCm1a8H0McTrHXrJ6UM/p++w5/LWebz20GW7Z/mRbwpcQNWzlHX0ZZqB?=
 =?us-ascii?Q?mRxzQV6oVaNg63SVKj6+qp7FwGWoZJdCXSqlM/jS7B1JlkqAiuy8HCcIDlE7?=
 =?us-ascii?Q?ml4BsbbC/9/5Vi+YlDfB8R/zgU1Ai9IO1jjUHz+rSDNCAY66f6ALg+SlndQl?=
 =?us-ascii?Q?2nwXXSYeEsH6G/T4qZXVpRnRh6XYGwYuLzJmRsWwclUX9k1bfWwgANV53cTk?=
 =?us-ascii?Q?efUULz/7i4SqIswhA0Emdnj5dwGB85VN9W9vO6GPKejkXd+WkfhEeQeet41n?=
 =?us-ascii?Q?rPuTngfwqWgQfva/g6/Z0r88BAi9VtaJvlDd78/KPJWUuz0E2TKLcYtt1hcU?=
 =?us-ascii?Q?rykNIy1fN0QLx6YXpIFpD2xRvfidCaJ7DVRDuh76q6CJEOH3CE7qhiLLh7qB?=
 =?us-ascii?Q?Enxd8bcSPlfh8it3iezcQFUp+RsK++hk18rId5oiM79A9YMLHQ9rEwhxKaYi?=
 =?us-ascii?Q?qpIcNtuA1TTywq13pep1K+ORrQemGIiNe5e8XA81fMaM7eQyWhxJm45+cmw6?=
 =?us-ascii?Q?VaRB8CPxx91DH3xoJ4IAxfyHgQKlSJUksVhazNw29jP7WAAIyPQsJOiRQSpM?=
 =?us-ascii?Q?3NJq2JkccdO9vXSXXTOqgwEH8ExKwFZMgucaA22H6AeLvNTF9+ytXNZCgpsN?=
 =?us-ascii?Q?zwkWqNKrlIUQWkLjuHJg9ogcQDOVRarwHA43YFBL3OnO8vubiipa1GhjTuSY?=
 =?us-ascii?Q?7MTuhMNjdBJrmf6e5GRPutRL5W8PfAbtLlnFBKGDx3fjtDxYhvyjrK/mARbz?=
 =?us-ascii?Q?S/Ly0qpvUlypN0ziYkwznAVBX11nHEb6v3NPb0UMqSQ1ZjhVQ9M8TLxEJDNX?=
 =?us-ascii?Q?G5I3T6PcALaUlivde6aH93DBkjRkLoyU3HuWiNkCpaOb80/JYzekL+dw5Drr?=
 =?us-ascii?Q?AiZPxEgV5LjA5YeZKTRNdv1D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 890d839d-8cdf-4014-a31a-08d8e017b7ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2021 20:46:14.2191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YWYAU3XCGtNNG02WyTqsEMAGhgqZCpUQcmAbKFokrBBe41yBsuEm0EhqQXXaQhV3L6rnPhSoxSpsPLWt06ARBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3608
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

After giving this some thought, I think we can #define ACPI_PCI_CONFIGURED =
in the global configuration file (I think it is acconfig.h) - and document =
why and when it should be removed.
Bob


-----Original Message-----
From: Moore, Robert <robert.moore@intel.com>=20
Sent: Thursday, March 04, 2021 9:37 AM
To: weidongcui@gmail.com
Cc: Kaneda, Erik <erik.kaneda@intel.com>; Wysocki, Rafael J <rafael.j.wysoc=
ki@intel.com>; Xinyang Ge <aegiryy@gmail.com>; linux-acpi@vger.kernel.org; =
devel@acpica.org; linux-kernel@vger.kernel.org
Subject: [Devel] Re: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in acpi_gbl_d=
efault_address_spaces only when ACPI_PCI_CONFIGURED is defined



-----Original Message-----
From: Weidong Cui <weidongcui@gmail.com>
Sent: Thursday, March 04, 2021 9:06 AM
To: Moore, Robert <robert.moore@intel.com>
Cc: Kaneda, Erik <erik.kaneda@intel.com>; Wysocki, Rafael J <rafael.j.wysoc=
ki@intel.com>; Xinyang Ge <aegiryy@gmail.com>; linux-acpi@vger.kernel.org; =
devel@acpica.org; linux-kernel@vger.kernel.org; Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in acpi_gbl_default_a=
ddress_spaces only when ACPI_PCI_CONFIGURED is defined

> Well, I don't like the fact that PCI_CONFIGURED would have to be defined =
by each current host:
>
> > +#ifdef ACPI_PCI_CONFIGURED
>
> I would rather the logic be reversed:
>
> > +#ifdef ACPI_PCI_NOT_CONFIGURED

Thank you for the comments, Erik and Bob!

ACPI_PCI_CONFIGURED is defined in aclinux.h (see below) and used in several=
 places in evhandler.c and exregion.c.
I'm not sure why we want to introduce ACPI_PCI_NOT_CONFIGURED.  Bob, I don'=
t understand your concerns about "have to be defined by each current host".=
  Can you please shed some light on it?

It is required in aclinux.h, and thus it is required in every host-dependen=
t configuration file (acfreebsd.h, acmacosx.h, acnetbsd.h, achaiku.h, etc.)=
 I would rather not force these host-specific header files to change.
Bob


#ifdef CONFIG_PCI
#define ACPI_PCI_CONFIGURED
#endif

> -----Original Message-----
> From: Kaneda, Erik <erik.kaneda@intel.com>
> Sent: Wednesday, March 03, 2021 10:29 AM
> To: Weidong Cui <weidongcui@gmail.com>; Moore, Robert=20
> <robert.moore@intel.com>; Wysocki, Rafael J=20
> <rafael.j.wysocki@intel.com>
> Cc: Xinyang Ge <aegiryy@gmail.com>; linux-acpi@vger.kernel.org;=20
> devel@acpica.org; linux-kernel@vger.kernel.org; Len Brown=20
> <lenb@kernel.org>
> Subject: RE: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in=20
> acpi_gbl_default_address_spaces only when ACPI_PCI_CONFIGURED is=20
> defined
>
> This looks good to me. Bob, do you have any comments?
>
> Erik
>
> > -----Original Message-----
> > From: Weidong Cui <weidongcui@gmail.com>
> > Sent: Monday, February 8, 2021 7:18 PM
> > To: Moore, Robert <robert.moore@intel.com>; Kaneda, Erik=20
> > <erik.kaneda@intel.com>; Wysocki, Rafael J=20
> > <rafael.j.wysocki@intel.com>; Len Brown <lenb@kernel.org>
> > Cc: Weidong Cui <weidongcui@gmail.com>; Xinyang Ge=20
> > <aegiryy@gmail.com>; linux-acpi@vger.kernel.org; devel@acpica.org;
> > linux- kernel@vger.kernel.org
> > Subject: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in=20
> > acpi_gbl_default_address_spaces only when ACPI_PCI_CONFIGURED is=20
> > defined
> >
> > Signed-off-by: Weidong Cui <weidongcui@gmail.com>
> > Signed-off-by: Xinyang Ge <aegiryy@gmail.com>
> > ---
> >  drivers/acpi/acpica/evhandler.c | 2 ++
> >  include/acpi/acconfig.h         | 4 ++++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/drivers/acpi/acpica/evhandler.c=20
> > b/drivers/acpi/acpica/evhandler.c index 5884eba04..4c25ad433 100644
> > --- a/drivers/acpi/acpica/evhandler.c
> > +++ b/drivers/acpi/acpica/evhandler.c
> > @@ -26,7 +26,9 @@ acpi_ev_install_handler(acpi_handle obj_handle,
> >  u8 acpi_gbl_default_address_spaces[ACPI_NUM_DEFAULT_SPACES] =3D {
> >       ACPI_ADR_SPACE_SYSTEM_MEMORY,
> >       ACPI_ADR_SPACE_SYSTEM_IO,
> > +#ifdef ACPI_PCI_CONFIGURED
> >       ACPI_ADR_SPACE_PCI_CONFIG,
> > +#endif
> >       ACPI_ADR_SPACE_DATA_TABLE
> >  };
> >
> > diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h index
> > a225eff49..790999028 100644
> > --- a/include/acpi/acconfig.h
> > +++ b/include/acpi/acconfig.h
> > @@ -162,7 +162,11 @@
> >  /* Maximum space_ids for Operation Regions */
> >
> >  #define ACPI_MAX_ADDRESS_SPACE          255
> > +#ifdef ACPI_PCI_CONFIGURED
> >  #define ACPI_NUM_DEFAULT_SPACES         4
> > +#else
> > +#define ACPI_NUM_DEFAULT_SPACES         3
> > +#endif
> >
> >  /* Array sizes.  Used for range checking also */
> >
> > --
> > 2.24.3 (Apple Git-128)
>
_______________________________________________
Devel mailing list -- devel@acpica.org
To unsubscribe send an email to devel-leave@acpica.org %(web_page_url)slist=
info%(cgiext)s/%(_internal_name)s
