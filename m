Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E1C303176
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 02:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731925AbhAZBZK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Jan 2021 20:25:10 -0500
Received: from mga07.intel.com ([134.134.136.100]:16504 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731259AbhAYTiS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Jan 2021 14:38:18 -0500
IronPort-SDR: TkCBVuxGWw52kgh8AitYNYTALAiWQ5FVCNzkDIbh1mmStbTdWRyjBJPkzhIozVafwHwHuq4iHV
 DYNiCfoyMUcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="243868031"
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="243868031"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 11:37:37 -0800
IronPort-SDR: iE3wPy+DJAyPeExvewJaXCKoKG7odRpHKlqokaA3AGfZi9qZB3Lz2Jyxr+GoCVs9H/ElwfKNQ/
 oQ453DxRCA0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="402467937"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jan 2021 11:37:36 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 25 Jan 2021 11:37:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 25 Jan 2021 11:37:35 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 25 Jan 2021 11:37:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lu5syrPAOAna7LEOGi53hE4o/n5WFrdaltpPk3qZSr2Nf8M0jN2JnVCFjZS0afWTU4JgzYnvJriTi8Yem40NGaNfdceT8Ueyg8Bb4MSoD24XzjXeeWO/WVPC46LrzR5E9KoZXgF2JQCG9hh58HiI32E+cSMZHrwhM1HzbthDKb39UOpmE+sRcWoPGDMGBvRRI2tFRxOAuiKY++az8KXAnJ+stNF7aSDC8cr+64Ga/W2sXM4cUDX6QLeh0KDVoKvwmD8A74KpOe8MAAMkx9BdD4UEI4Om6GLr6XEBELlWz7XpWsg4U14x4yistt3RkXwLmCwxPUoiXjSxJcBbONO8SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaLEAnqnGbSV8OQDzzQibFvR+wRUYtViE8nTnYyAWlc=;
 b=DnuLx6azyxoBSsRhvUavQ2L1tVMzG+KESmzLXFD/RWQ0ZzYowzBNIi9CQdrGZhDd43E+bVDx5rY4XMfvU9S6KDe3kN3P7Kc37sCR6CmQUgX9BP7mqmHo/qV8hSyevWKBFXqpVtGKoPZ9ZtPD4AX5u2ApkJ3S5eC1CvxSeC4Ge+4/PMT+yimQgcAEKjTPrSmhMHFGBg7PqJeMV5gGnvxJTt8gTC/JBw0jsIbxDMIs8q7NipUR+BboZUbFqfSJOSVnQZlmqaPpHYKE4/G9Terv1sjESiuxnBIwlTPjY5nEGwGp9KWr/Sn/Ej77sYDvfAFsdjrIT5pEng8Ut2fnHyADCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaLEAnqnGbSV8OQDzzQibFvR+wRUYtViE8nTnYyAWlc=;
 b=cY4eRMT3BJ7ZAQ2+Gn8dCKzaHpxS6/E2KzoFtGBc4dfZC9rg59RLzmyazuEiESJROmie48jS2qQ66L7moy7IT5/cRN3GvGoxmMPIOuEQjIDaEtA+c8xTjijJWcOHfHPoTKIpQT06HG+J1+tEZMtbEUPzJePs0MOt0VEHebI8eqk=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by MWHPR11MB1919.namprd11.prod.outlook.com (2603:10b6:300:106::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Mon, 25 Jan
 2021 19:37:31 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::4878:159c:ca1e:f430]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::4878:159c:ca1e:f430%10]) with mapi id 15.20.3784.017; Mon, 25 Jan
 2021 19:37:31 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [Devel] Re: [PATCH] ACPICA: Common: Fix a typo
Thread-Topic: [Devel] Re: [PATCH] ACPICA: Common: Fix a typo
Thread-Index: AQHW8kS4E8C8ipHfBU2nooIzsXIvGao4jBWAgAAx+PA=
Date:   Mon, 25 Jan 2021 19:37:31 +0000
Message-ID: <MWHPR11MB15997833BCB69D4AC45AD245F0BD9@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20210124113252.733716-1-christophe.jaillet@wanadoo.fr>
 <CAJZ5v0hooTkVjXg-Emsr49aqV3PukEJYSJw03PEXxPYtSu+j0w@mail.gmail.com>
In-Reply-To: <CAJZ5v0hooTkVjXg-Emsr49aqV3PukEJYSJw03PEXxPYtSu+j0w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [174.25.99.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91f6e6ee-9981-4941-e862-08d8c168a80d
x-ms-traffictypediagnostic: MWHPR11MB1919:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1919FDB164AB30A4A07D01FFF0BD9@MWHPR11MB1919.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:210;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aAAekYwzmeirfmxPArwD8E288opXR+SDqufRLKS2e1JGtEd0qY52b0SMUduoC2nozBad7hI4NHM25Vno7R6dzkJNzY4Cn54jpiy6QdTgJXNVcOLSKvspk6t0CuBVzJ1VGrxRVWtuAKSFp9lZOw7xS9rSUiiE9tVKnOEqE2gSruaKp4crL7voEbBBcf8Kws1EhVg34lkpGRku5mbNWoiAooXa1yB0BXm4a6me3HHa2Nx/NBKMeV+uwU4611yRnPVc4SWlMXO/1pbvaw46pCCwVLZQF32f0p27BH2ZZm53LM1WHezcIhlH5/9s3KUYAsEOT0m3+P5XRflYhG5SB5BEcLCzkxoZF153BPo2WQDWe/I9JxDLv20PGRq7GdPxLVhM8IYIHaTDaMoRJwatzAXcz7xVcjNTWCFuYJF80KDOS1M0IVOGkWeQnWucgax2tgJUL0Oy/VX/lPHIewb8bCT+Ow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(8936002)(86362001)(83380400001)(186003)(71200400001)(7696005)(6506007)(66476007)(66556008)(66946007)(66446008)(64756008)(8676002)(9686003)(53546011)(4326008)(110136005)(76116006)(966005)(33656002)(55016002)(478600001)(316002)(2906002)(26005)(54906003)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UKsryPjtu+yGwC6ER1/lBFjmo+OQjwBX8DhSFPcmELdcqNlr89RUatR+cEL8?=
 =?us-ascii?Q?vN418I9Rf9yLXUq7nU8ZGjI+r+XFMTGOSNqIUFmgbpMPv+ZOyBYLNfYZ0Mwf?=
 =?us-ascii?Q?Vy2YAG6LcmKVUrcv1gZewPuKs1hbBXq6Xpl1tUmf0mhxznLjkGdKySBnmUgo?=
 =?us-ascii?Q?f0I4Me25L/zUzhRY96ehC8fwRBZxfr/t8lRxddaBQnQ/MSECQglaY7SXDyy7?=
 =?us-ascii?Q?IP2U1Z+ouw4Nh8rtaOE+zr2G8QF4P8qgRB9H6t4LuRMzi3cB7wzdOVrSeh/H?=
 =?us-ascii?Q?gv9D1j7jCBqBmPA3sUXXVDlVFs/7z9OgQecnjJ6NC0DVt/oFV0UuHgdiNShX?=
 =?us-ascii?Q?TtBkHPgXG1mmQTJCuDU4sV2KB/1sYFSqfWgB/gb9Q7igucOzgBshF+NbgqNA?=
 =?us-ascii?Q?Ljo+tEMm1aQ53zj1U7h5PSXlVsbATwcMRyFb4S/eenq0VU+/j1aZoAI4wL9+?=
 =?us-ascii?Q?RlSCnEFBF+qC3NkHs+2DrlFnU8Sg4VoT8BZ1K8AsJrMreH95iGbgTOEYr6sc?=
 =?us-ascii?Q?bBtOzsHzj06YJumMBfv3oIT+caLaRlCvNmiEycNspvFJz4CMmk/kQah61XVH?=
 =?us-ascii?Q?hnF5rIC4iW88Hs/kIRxwBz92JaF6/mpKDIrpXx356Ok3Pj9cv8j9biaCbqCl?=
 =?us-ascii?Q?u65J3kCKtwrM9Rg2FtQeDGqUMgwHxHae7gUoCldAJSjlmqQq0pVZdmPTtMfo?=
 =?us-ascii?Q?ubSj2JPkA8tQyAr9d3XRqsQaZQu5XrXlYsEcyCr5GIjjbYR2msHiq3Gur6kY?=
 =?us-ascii?Q?nYBA+5N+876LLLFjzGVormZcCuivMS24t9nf/+M6KJz4ek7/qMxE4gMAcnpi?=
 =?us-ascii?Q?g1tiAgDthk/B3+vwVYdm7xhVelH5i6dXNGM6tX3LG30xHnfcTZqKzNBVuvDZ?=
 =?us-ascii?Q?AT8ptPjGz+2DA69ChYm5yyt8j8NhvJFdhOhSKMaedjmlXxZjIMeLrgr3Pkz+?=
 =?us-ascii?Q?RsnXuSY/N2Nqpt6OyCrPXqrZHtGfNkd6xijvqL2VEqd7tTJ2vDEP3JD30nZu?=
 =?us-ascii?Q?HNwuoDzpgCRfGN4jUAn+PLVZ3kxkhhEa6saVGdcVYhDQd4cFFqKxLa8KnJYr?=
 =?us-ascii?Q?ssu5xfxl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f6e6ee-9981-4941-e862-08d8c168a80d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2021 19:37:31.1949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aie0W0Q8j3E9OPbGbeBgMUnCBkHP+cIHTUqa9N9OA7ATuM9zWNwBwNXS7YE6SE6k1QTvCcFr7YjCPxQ+5aTQxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1919
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Rafael J. Wysocki <rafael@kernel.org>
> Sent: Monday, January 25, 2021 8:37 AM
> To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Cc: Kaneda, Erik <erik.kaneda@intel.com>; Wysocki, Rafael J
> <rafael.j.wysocki@intel.com>; ACPI Devel Maling List <linux-
> acpi@vger.kernel.org>; open list:ACPI COMPONENT ARCHITECTURE
> (ACPICA) <devel@acpica.org>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; kernel-janitors@vger.kernel.org
> Subject: [Devel] Re: [PATCH] ACPICA: Common: Fix a typo
>=20
> On Sun, Jan 24, 2021 at 12:35 PM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
> >
> > This module is 'cmfsize', not 'cfsize'.
> > Fix it.
> >
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>=20
> I'm leaving this one to Bob and Erik, thanks!

Pull request available here: https://github.com/acpica/acpica/pull/661
Once this is merged, it will be included as a part of the next ACPICA relea=
se and as a part of Linuxized patch series.

Thanks,
Erik
>=20
> > ---
> >  tools/power/acpi/common/cmfsize.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/power/acpi/common/cmfsize.c
> b/tools/power/acpi/common/cmfsize.c
> > index 9ea2c0aeb86c..185b8c588e1d 100644
> > --- a/tools/power/acpi/common/cmfsize.c
> > +++ b/tools/power/acpi/common/cmfsize.c
> > @@ -1,7 +1,7 @@
> >  // SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
> >
> /**********************************************************
> ********************
> >   *
> > - * Module Name: cfsize - Common get file size function
> > + * Module Name: cmfsize - Common get file size function
> >   *
> >   * Copyright (C) 2000 - 2021, Intel Corp.
> >   *
> > --
> > 2.27.0
> >
> _______________________________________________
> Devel mailing list -- devel@acpica.org
> To unsubscribe send an email to devel-leave@acpica.org
> %(web_page_url)slistinfo%(cgiext)s/%(_internal_name)s
