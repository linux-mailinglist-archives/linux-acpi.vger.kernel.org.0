Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A6F231371
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jul 2020 22:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgG1UEE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jul 2020 16:04:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:38581 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728050AbgG1UEE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Jul 2020 16:04:04 -0400
IronPort-SDR: iHGkTGEYJBqdcLFKo+Vipls5s4FbMobh80awlvGzlOQNZZWTOPf4XMO32G6q86qTCoaeA3f8PZ
 ZIY9k5SDFasQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="150475400"
X-IronPort-AV: E=Sophos;i="5.75,407,1589266800"; 
   d="scan'208";a="150475400"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 13:04:02 -0700
IronPort-SDR: ZCEh/MZGwMLr7N8b91imaZoRF4XG5KNs4qHYr+Tj6Xp3jyWJMHvmRGsi6NgVfLc+/K4FXaa8vn
 l9JHalz1w1eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,407,1589266800"; 
   d="scan'208";a="312755529"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jul 2020 13:04:02 -0700
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 28 Jul 2020 13:04:02 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX151.amr.corp.intel.com (10.18.125.4) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 28 Jul 2020 13:04:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 28 Jul 2020 13:04:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JARjguBYlqYWQHrbF1JR6Gl7OieV+/pi0xRxDjm2XFskNxgBHMZXKSu45l7MnWEOSqZTXpIUuaVX1PkniBdQnOlUFP89DbUwX/ljnRj4zSeMtTf2hOVJ37u3qnqy/h5SsAEnPtrHfwEEju/ppY0PnIDibm/Jgwb3zRvDZDGZ9OCBOKoG3PatE8c3Fw5CiFC4TRUwcGaio1Ou2NpG3IBTIC+i0V5WUkMztHSCRebp5G5MbrU7Al867WUhQr8RCtsppNoyGW2dflXgfU1GvIhYNqtAPhIPmir6vzbxxmHL2toZw1ZpYs6joqFBNX6poTd21+7KkqUUuda8KqWWiiTlgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iAxcPjGWNxlGWEI998ED765q8Hz3UF3Lo0FMtU6HhU=;
 b=Y7gAKWioFdPfDX1SQjTn0RlwdjKIctSYJhjd5/D28N7K3t1QUpcfPVOjYqP78+1/75OH7LxRRolfAkvq8E8Q25xWoHVbFKdQAF6KqgNtXfxxyMBS+ij4qK33sIfhR2wHwaaNA32O86JfczxTkovPU2XEuYnCf3t0R+rHGmpaPRdc7M8T0o9OWmeaXtb2NTYkWucxEKJiN4sH0uj8lCjclU7ByFr6z+NBPUNK3Hq1cvoJDnWd0mnAFqFB6TUz6Ui3Qrt5iNRMe8QrfymHc4Zkz5Cm3zhRQ+5ILqr4H9StGPDcYsuoBmgAlzFSUccttEbTNCliLaeHaxrwQjY/Uk7MKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iAxcPjGWNxlGWEI998ED765q8Hz3UF3Lo0FMtU6HhU=;
 b=xDd16hwheQT7qbSIs9ElstGLOmcibYrXy0lyYsO2zQUCbgqLBs6oMAtmWwz93hKDxsn/X5AjjffQwETX1Nijaargwhf0/mj4na8PDJ0NbB3Lpx+BaPepXL0uBFtqMT5YG6wG7/WUFxW5Q7esPRg748koK2q2hoZL3BYhAtWC1aQ=
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by BYAPR11MB3254.namprd11.prod.outlook.com (2603:10b6:a03:7c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Tue, 28 Jul
 2020 20:03:50 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::4ca7:fbfa:78bf:173c]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::4ca7:fbfa:78bf:173c%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 20:03:50 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Garrit Franke <garritfranke@gmail.com>
CC:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "trivial@kernel.org" <trivial@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] trivial: acpi: replace some bitshifts with BIT macro
Thread-Topic: [PATCH] trivial: acpi: replace some bitshifts with BIT macro
Thread-Index: AQHWYdZ+JdA88oPRJEuxGV8RX7TGgakW62CggAAFOQCABn/TEA==
Date:   Tue, 28 Jul 2020 20:03:49 +0000
Message-ID: <BYAPR11MB3256507B360E486810400D7487730@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <alpine.DEB.2.21.2007241814450.2834@hadrien>
        <20200724162050.18077-2-garritfranke@gmail.com>
        <BYAPR11MB325604ACC5F3BCCEB89A58AA87770@BYAPR11MB3256.namprd11.prod.outlook.com>
 <20200724184738.ce10d8db0bbe138e2b24f7a6@gmail.com>
In-Reply-To: <20200724184738.ce10d8db0bbe138e2b24f7a6@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82f0ab8b-e752-48c8-3720-08d83331586a
x-ms-traffictypediagnostic: BYAPR11MB3254:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB32548DAE5B437F8CFE2E20DF87730@BYAPR11MB3254.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z2cw6YHbDC04U+5Z8zjDKLNGvYoQjP/VRvQbrAw7Tz3+tS4kW9GGsPJ4t3/SBoKvdW5P2fd3X21E4YXy4crXK5z8cUVbL/VuzDJwSRhk6TfclcuS1VDu5C6fDxwHjtG2PnFzgbWoP3DMGwXye2nch5J09hsQHbHFHl3AdiC8ryIzY1RtimAIeb1EsVbz+6qEm69fqrQEduyZOTWeXwkZ8OghauIeNs3bftRbSKZ/McSfTdmbk3CWW99w7VtACft+2GUf6BAuUPo8ZSAoQIxIvZBoGFVqF/V8zpHp5qMruv1TtK1L6L5i9Y3UQ4XXc25GdhDoTZB6HFlK93RMlqyrsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(52536014)(66446008)(86362001)(66556008)(64756008)(4744005)(66476007)(66946007)(478600001)(76116006)(2906002)(6916009)(83380400001)(33656002)(8676002)(26005)(316002)(6506007)(53546011)(8936002)(7696005)(54906003)(186003)(5660300002)(71200400001)(4326008)(55016002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: APHRkVcTHZ0iZ3KgS8nc5FUW8Z715/vBiLafIi91D3mrXQ48x5+5TDMRizP3XfRAeGXerEE72PFBckApgEVcQ8RGcbhk64s4lJ5MuVgkIHfX+9L2EfX+eYl1BlQGmN1oSninYhTylrfENgMd/P3Y1kVPZYcOkn7knR8VAy34ve7u4O7g+31UDYL3q5EpnlV40cJxrbwU4t8Jn4k8J27A1WBisnYufbkL8DTX2UuQqNLwczWfvDtbaUqSf8wY47MVkTkNs3cvMM9N2GEX+eyfsY0DR+RzHPCYVV64GGbyy4bD6Uh8xSKTWW8td4PLaeUJRUDLVx0A45PDroOdU49IGEVJMd5XY1HYhkVLaRWPvKctSWU+ykXzMxYJbnhprj6Rd0ZqgZJ49JxQ5G+wt1h8E2AJ9tvXlbrh6OLeOlYydx2FoR1pVcAMUhAqPa1rc404BcJEY5Sd47NrrLDB/a4Z3mStYYEIsaiaV0KZB+emfNWk6PXbnyWwi4cQZtPODOvO
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f0ab8b-e752-48c8-3720-08d83331586a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 20:03:50.0576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g1LmU503LUZ457rcuR/J9nKEGWfBnXFTCSSzIrGgr2QgWBZznc0BIOOblCTYsYyCCntAVGtiMwxdMtBUue2GGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3254
X-OriginatorOrg: intel.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



-----Original Message-----
From: Garrit Franke <garritfranke@gmail.com>=20
Sent: Friday, July 24, 2020 9:48 AM
To: Moore, Robert <robert.moore@intel.com>
Cc: Wysocki, Rafael J <rafael.j.wysocki@intel.com>; lenb@kernel.org; trivia=
l@kernel.org; linux-acpi@vger.kernel.org; devel@acpica.org; kernel-janitors=
@vger.kernel.org
Subject: Re: [PATCH] trivial: acpi: replace some bitshifts with BIT macro

On Fri, 24 Jul 2020 16:29:14 +0000
"Moore, Robert" <robert.moore@intel.com> wrote:

> Where is "BIT" defined?

It is defined in multiple places (see include/vdso/bits.h for example), the=
refore I blatently assumed that it would be defined. I'm quite new to kerne=
l development, and I'm learning along the way. Thank you for pointing this =
out.

Would it make sense to copy this file to this drivers root, or is it not wo=
rth the effort?

I'm not sure that it is worth the effort. Linux is not the only OS supporte=
d (and GCC is not the only compiler supported) by ACPICA.


Thanks for your time
Garrit
