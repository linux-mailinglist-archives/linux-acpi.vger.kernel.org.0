Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7F82B2624
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Nov 2020 22:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgKMVBa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Nov 2020 16:01:30 -0500
Received: from mga12.intel.com ([192.55.52.136]:45206 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbgKMVBa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 13 Nov 2020 16:01:30 -0500
IronPort-SDR: f5hYRjp30FfcVXfsi0WSACu2xf8LY2P7LAqMtElZxYaR+9UTCd0aGZwFHZecShdlxjr+bmVPVj
 6GtAuL71GNwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9804"; a="149802578"
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="149802578"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 13:01:29 -0800
IronPort-SDR: R92fIIxyE1xDwjm/7Eg7/n2K0Opzico+UPnoBbLY273ECYW8ArWNeYJlbhdra1dmEEeYh/u54K
 FOQWNbJDLP5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="328998506"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 13 Nov 2020 13:01:28 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 13 Nov 2020 13:01:28 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 13 Nov 2020 13:01:28 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 13 Nov 2020 13:01:28 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 13 Nov 2020 13:01:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPvKTdWRu+zN2ydVx1bc5Sx3gNYXlJeZNzTb2qdLFROtIJZs8UN/8AU+dQVJJS7i3YfWerZKdmlXmk4yomTEoy/zgnHes3r0oBAq4EJ0NMs6+bmhAOuMUJVAdxH0Mhyaf2NNMIkQ6nr/m570uo38fAWcogf9grm91NLYoi/ayD0vwwviwHAoIVScOjvReUK/Tygo1VzqmHQnrfDekjxk4yWDeynbFfhv9/TK0NZtc2bL9GIgHSTC6Zu2Q3z/08TvTO9fjOvwvgFj6HNPhttfQiXK7S8CmKrfd/7F0iYmvw540ocSQuOl7sgbqxgjsn0WXLxtwWDaOVtfGgIHlqEJyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zN6OEL0yn6mehCc508tR3MOSawGaCmmZsuPzGMLeB8Y=;
 b=KHNuulBFk+uxX5aSSPck/c5J4Q6UbYJyolnvgKf68N6wFZYjGUFKwmCdRSVL9jY23m4HfNeAlidli0VOJau4lA8+5H8+swkADxefCEv2E8l8xj/xAgi3nj+b6LAMYtixr6cVCX5fyPfmg8PkkKA8iVLgJ+JUC1G5tDw3AJ+xT8Pd6hk+CgX0BMEkdZXluWYTdK708a/mu6nNWxoo7IfeAlVTPOuu1XXdc7eALd8e1LTJpk998Ot56EPGSSWKo5qY+pX8SC4ZOKZh+0LtZ/wNV+nI8eohQ6f8y4E85+3DR3YXBv6LV6rH+1VpV8bCdlvLgHWb03RZfnldMo//eH2oAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zN6OEL0yn6mehCc508tR3MOSawGaCmmZsuPzGMLeB8Y=;
 b=FfmLECtn2Xw1WipED/KxW5eh2lzmez8Rz95bekkHDUEpASuD1IkF87K0/XA5CUlP26JBzy1S7FD0KlCZyzNFyQ7C5inohrGclmKDyFabPlGgpNXIMMcJu9TISzEKETTZViSd8jBi8O0FwcTAu201Kuc7g3AwyAAB32vRdM+UifA=
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by BYAPR11MB2597.namprd11.prod.outlook.com (2603:10b6:a02:c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Fri, 13 Nov
 2020 21:01:24 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::9d74:8937:bd5f:3c6b]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::9d74:8937:bd5f:3c6b%6]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 21:01:24 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Joe Perches <joe@perches.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
CC:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ACPICA: fix -Wfallthrough
Thread-Topic: [PATCH] ACPICA: fix -Wfallthrough
Thread-Index: AQHWt9BSaSJ92WwBRk6cKvxE5xanpKnDCsOAgAA8BQCAAVTWIIAASWOAgAAmHECAACelgIAAh4CAgACKigCAAEiToA==
Date:   Fri, 13 Nov 2020 21:01:24 +0000
Message-ID: <BYAPR11MB3256ECDE31F1900EE1D9254687E60@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <20201111021131.822867-1-ndesaulniers@google.com>
         <BYAPR11MB3256E0C1DCB4F01D18DF709F87E80@BYAPR11MB3256.namprd11.prod.outlook.com>
         <CAKwvOdk2U5+DcXYyMoBAhyaa67EukhB6QMEUbRPcOF7P3Sz21w@mail.gmail.com>
         <BYAPR11MB3256C9711620932685C368F887E70@BYAPR11MB3256.namprd11.prod.outlook.com>
         <CAKwvOdnu07S8ZtGVe0eVFP=6hLSRa58EtDYOJUK_zGWFaqUboA@mail.gmail.com>
         <BYAPR11MB3256BEF30840D4AB440A359C87E70@BYAPR11MB3256.namprd11.prod.outlook.com>
         <CAKwvOdnYpmf=ydFVWSqVkWeUpn+M2v9PfdQd71T3oqQ9_1WQaQ@mail.gmail.com>
         <CANiq72k13K_zA5aH5hameoe4TSf2o5cA294bA4UEZG0M6S3DXQ@mail.gmail.com>
 <61039da395c8a28444e2f3958d29deda4c0d49b3.camel@perches.com>
In-Reply-To: <61039da395c8a28444e2f3958d29deda4c0d49b3.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: perches.com; dkim=none (message not signed)
 header.d=none;perches.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09431a5d-6795-46da-5c4e-08d888174807
x-ms-traffictypediagnostic: BYAPR11MB2597:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB25979D7AE1669C0DF105C75A87E60@BYAPR11MB2597.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T+T+T4S3uMulT+xBRK9ZkHnL268j03Ca239sKpUnfmU8+aVUD8Uo1WyurkjdDQuWi4BFovP1gmRfCTEjtV6JrpR31zDtvI1F5kAUcJRpOIcjUFJnOIkY5GiqDTAnRMesjlGeiYEOToAwCNZJ02F4FssgAVjeYA0K1j5S/8G2Z5/h3YA4bMwiSOYQn03VkOGU5W5gP+JB5MengEWR417yqF261WOkbgt6md8z7cD7uH8SEh8cjD1VTAqpNi2IAfHnbUKoCIaaJlV3EkKJ6073hUijscwG992dtrq4mJEn2GzspgToaQ+8zkjOQpJHSDkkjEGl7CYVnJXxtRr3V21rK/Mymk9SOng+1FRZd66BuyR3B43Co+skDt0AmuBXr/9MCNJIOdlGpe1W7V+ukqS7gQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(83380400001)(8936002)(66946007)(966005)(71200400001)(64756008)(66446008)(8676002)(26005)(76116006)(186003)(33656002)(4001150100001)(2906002)(7696005)(9686003)(316002)(55016002)(4326008)(86362001)(53546011)(6506007)(66556008)(478600001)(54906003)(5660300002)(66476007)(110136005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: XBfW0mjATPzmkx9PFpyBNfrtbEKbk+20TQKRfjm1wSDQKUDXeREmpAW3TpoeIGf0VkWIHN8FZbEiKK0WUfLT/ij3TUk3IQpwHhbmUz8RZYCvq93H4pk3OViDNqooLCri0FWCoie+/MiMaYlIVP0pO9uWRMXkxc9e6pC30LIPRfx4TCaSftIMRp6Guo/Xb9Khrl6z8ny83LHp6tvzPHjD+BCRBd94LFUKMHWE2yhjOGM54wVwA5Rkhfxql1IacEE+Cx9FTRwpM9TWj0q1sxsacjocoDOUEuKSF1C69Hm38zEiMfe8/4rujuMz4yLbMde/yhUdvDB4qx/nlckJsY1D2nCrWi1zeH/p9y4R4yPvqnIhnldVbNTC68DkTf9dBPe644YInuWvlkBv6FSlhv/wkaU5oYCXD4CHkGxYM6BqIekRsjdo7g18e0CdoUjdxCHteOtR0oaMm5ILputFHeOCNJNJnHz1m0sBT3cQ6piwF3xkInbkc5xG1v44978amyumCAVxOQ8/2HFLgJrvMEhYOKI24va6ocJwf8qwLZG9flQvLqUO/hddmf19KaOaD+PH3f64dS1kMRJDKMgq/IIpF3R6kRWzuDSfEOvu6uq1PgFssT9BzifDaI2H2HDOE8EAT2sIe8dRwC7+fdiF6dwVYQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09431a5d-6795-46da-5c4e-08d888174807
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2020 21:01:24.5583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X+UBQBVovbl7bsHnkQktPEv8vx0vJBM4ss/4FTROOsct6buHtTvbJIHAHz6YODtE2/V8WRRaLUROXWZSu0An/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2597
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

I can do it this way:

In the global header actypes.h:

#ifndef ACPI_FALLTHROUGH
#define ACPI_FALLTHROUGH
#endif

In the gcc-specific header (acgcc.h):

#define ACPI_FALLTHROUGH        __attribute__((__fallthrough__))

This would not be #defined in the MSVC-specific header (acmsvc.h) -- thus u=
sing the default (null) in actypes.h (The per-environment headers are alway=
s included first).

(We do all macros in upper case, prefixed with "ACPI_")

If you can update your patch to use ACPI_FALLTHROUGH, I can do the rest (ab=
ove).

Thanks,
Bob

-----Original Message-----
From: Joe Perches <joe@perches.com>=20
Sent: Friday, November 13, 2020 8:30 AM
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>; Nick Desaulniers <ndesa=
ulniers@google.com>
Cc: Moore, Robert <robert.moore@intel.com>; Kaneda, Erik <erik.kaneda@intel=
.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>; Gustavo A . R . Silv=
a <gustavoars@kernel.org>; clang-built-linux@googlegroups.com; Len Brown <l=
enb@kernel.org>; linux-acpi@vger.kernel.org; devel@acpica.org; linux-kernel=
@vger.kernel.org
Subject: Re: [PATCH] ACPICA: fix -Wfallthrough

On Fri, 2020-11-13 at 09:14 +0100, Miguel Ojeda wrote:
> On Fri, Nov 13, 2020 at 1:09 AM Nick Desaulniers=20
> <ndesaulniers@google.com> wrote:
> >=20
> > Thank you for the explicit diagnostics observed.  Something fishy is=20
> > going on though, https://godbolt.org/z/Gbxbxa is how I expect MSVC=20
> > to handle include/linux/compiler_attributes.h.
> >=20
> > The C preprocessor should make it such that MSVC never sees=20
> > `__attribute__` or `__fallthrough__`; that it does begs the question.
> > That would seem to imply that `#if __has_attribute(__fallthrough__)`=20
> > somehow evaluates to true on MSVC, but my godbolt link shows it does=20
> > not.
> >=20
> > Could the upstream ACPICA project be #define'ing something that=20
> > could be altering this? (Or not #define'ing something?)
> >=20
> > Worst case, we could do as Joe Perches suggested and disable=20
> > -Wfallthrough for drivers/acpi/acpica/.
>=20
> I agree, something is fishy. MSVC has several flags for conformance=20
> and extensions support, including two full C preprocessors in newer=20
> versions; which means we might be missing something, but I don't see=20
> how the code in compiler_attributes.h could be confusing MSVC even in=20
> older non-conforming versions.

I believe this has nothing to do with linux and only to do with compiling a=
cpica for other environments like Windows.

From: https://acpica.org/

The ACPI Component Architecture (ACPICA) project provides an operating syst=
em (OS)-independent reference implementation of the Advanced Configuration =
and Power Interface Specification (ACPI).

It can be easily adapted to execute under any host OS.


