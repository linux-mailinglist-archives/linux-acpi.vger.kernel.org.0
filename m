Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE571DD467
	for <lists+linux-acpi@lfdr.de>; Thu, 21 May 2020 19:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgEURaV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 May 2020 13:30:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:15517 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbgEURaV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 21 May 2020 13:30:21 -0400
IronPort-SDR: 1gCFes3yvQGm3VIdz8ZdHVjcXVdI0sVPkI5Ma4Qapcmh3wcLqR9nvPA+VBPjPzfMIydnRxxecU
 KdwmRJ/ZpxOw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 10:30:15 -0700
IronPort-SDR: 1jb3CluUYf3Gx+oCuTsHuwxDflRgxIgNDChnR6xO8Wr4RG8OdHkdr97xqHVQpmsoS26R9jOWIR
 joKC+5rcRVBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,418,1583222400"; 
   d="scan'208";a="374495882"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga001.fm.intel.com with ESMTP; 21 May 2020 10:30:14 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 21 May 2020 10:30:14 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 21 May 2020 10:30:14 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 21 May 2020 10:30:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 21 May 2020 10:30:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=My8nqA7Q/IWESAl+P774tkR98gR1X9ElytwTcpFevmO3czfRfaK5WOAXNcztz+0PsBPbLpb+mqUhbfDdhBo5XnouzX53/cgykbnQesj73Lewg1zJWvn+pOwEmJhJuk5ee26CQGyxOH3u6sOAcQQHpadzcLWjwpwx4Rnq5vOt2tktHOgCOaTRZppZZuIoP9ZIHE+c+WAy9vXpnwLmE1k/XCGfVcF2nHjEtogCIU2NA6YxjNcA9++kbDP+EDvQqs9qs3u1FUX9jYLcV3n5v8YPd765BqA8swGmutOk9q/U5WZIp6wWGIjpy28WB73CwWH3e8Ql3oHo0dwGxz9WYuyVzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvca2crIzD0BMGjrAaJSCEUa8AuaIs1cxStLbulV9FY=;
 b=RvX9Vx8ZbQNZUNTRaZnV6GXgn1x/WNgt1IEGIRaJqfrKPfrPcDnhE9Tfc/mgPncbHp4vpAKMpv19aGC7AFz0dJC2chtXXkDB/giVvL0idSRNQmT+MczZkALvc6SNnsaXtr8w4jxuqx5DzOrqrWkFanIXcnCPQimkykgkqLpEjVa73VMeXDZs6NB1p9TxZ1clNeaFPk/PpNQYooikWFC5lhPsaPjLZXCA/JLeCHXD5fIZClPjSHc18d5DKh6OtFxhXu6OJn3HYR/ZEoO8VfuxYRXFVrJkgLLRxoegNz2Vh5HrFbSeOxJCScL7U2haNTvpLMGrFWXhmZ9DGVydvBY6gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvca2crIzD0BMGjrAaJSCEUa8AuaIs1cxStLbulV9FY=;
 b=nVSGpmXmZybn7v2pU7ZFoy+e8sD/WjBIN1jLeS4W57Gj6okrwtfEuEIYI4vp8fns+Jf5tNldvnSP41percwOmtGUZGyIYu6ZpJekf4AJ3NlpHwxuh1rN4jPgz8FOfuTcUFReAliFczA1xRlYMD4iH6rcraBYA+aVwpZh5/SVTc0=
Received: from BYAPR11MB3096.namprd11.prod.outlook.com (2603:10b6:a03:8f::14)
 by BYAPR11MB3173.namprd11.prod.outlook.com (2603:10b6:a03:1d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Thu, 21 May
 2020 17:30:11 +0000
Received: from BYAPR11MB3096.namprd11.prod.outlook.com
 ([fe80::94e7:471d:f545:3c3e]) by BYAPR11MB3096.namprd11.prod.outlook.com
 ([fe80::94e7:471d:f545:3c3e%5]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 17:30:11 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     Kees Cook <keescook@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: RE: [PATCH] ACPICA: Replace one-element array and use struct_size()
 helper
Thread-Topic: [PATCH] ACPICA: Replace one-element array and use struct_size()
 helper
Thread-Index: AQHWLr0g3tIHe82D7UK/h7k3pA0Ak6iyyoPQ
Date:   Thu, 21 May 2020 17:30:11 +0000
Message-ID: <BYAPR11MB3096B2FE15AAC6A0C8BCC4CAF0B70@BYAPR11MB3096.namprd11.prod.outlook.com>
References: <20200518222722.GA7791@embeddedor>
 <CAJZ5v0goZpvRQ6du214FqvFNQnqZHR9-kz=WhEgRsMJ3Zx0WiQ@mail.gmail.com>
 <20200519225058.GA14138@embeddedor>
 <CAJZ5v0jg9HoE2KEm45hxKNB1g61DzCn-GWH74w1goeHH3AKRaA@mail.gmail.com>
 <202005200831.41DA095B2@keescook>
In-Reply-To: <202005200831.41DA095B2@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.52.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6cde263f-de6e-4c00-268e-08d7fdac9da8
x-ms-traffictypediagnostic: BYAPR11MB3173:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB31736B53BBFBD9D6332AFFB7F0B70@BYAPR11MB3173.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 041032FF37
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S6Y4RE1idC+orSyiIAVQBupANWyiaDSPat0Y4EXaaB48zbx2BcgJqMcmsvWoLv/uyvNMYi9f+831s7KKJdVfWIFvjbowQpIhYUQgAqk0Tb7VD50erItZEIDtPkTVp2xTVWGklxqD+N7WpH5emYiEINlz9wsTvnPfQR6Xf1bdTx97Cy9q26qXqxRHoGHJg2Rfx3s1v5Hdo0C29UOB475u8k1WLU1yM153Dnxni1ccItYvIDxAwP6Ley8qmz7Irj5Zxw1sKkwWeFeB2XQm7aMO+xAB5s5IR0Ctp5ExN3ZiZxguXQZuXy+6Xtmisulnlksefa3MLaxPdc+vbXU9J5nIA8InDKW73ZGkAM86v/OyylBTnkRZPwxzrk2H40ECgO++7Fb/BmbXzEvj1Xg4vd48ZX7IPMe9l90Wu0Uor/XoYW00gs7fwzCtQf0wl7/P4oVn4+aXrDQOme0vA9gBrPaqBuBIKySZdtYQU1XVC8DaDhJ0pEoFzsYyvD2QY2y4udjqgh+d2LlpEQ83JThagGufhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3096.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(366004)(136003)(396003)(376002)(346002)(54906003)(110136005)(316002)(7696005)(71200400001)(66476007)(66556008)(66446008)(52536014)(66946007)(64756008)(6506007)(26005)(53546011)(76116006)(86362001)(33656002)(186003)(8936002)(5660300002)(478600001)(966005)(55016002)(4326008)(2906002)(8676002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: xLt/Ysgl2sESE7l/s7cClCQcbtatPa5WWzAvhZKtMZ08pMa00h23ra1ZvRpTazSWPnlZsojvEqPaEg19eLgiMcXO91HEBxi1H7zeVqUU1Y1hjT4O1XWl9NfCUuyU2hUBpsIgnQhdLy173lx6LBhIK7wpMm3irEcb1TmUkiH02Nxw11rMpU4T1wGwdbZ6VX8ksWnH89ryj5jzi9dDE8mmqma9ijgj5N2tbvrasLAjhbPfslYofo7QOpOnnDE9ilZBNX9xxMHY9VMi7fvLaRd3qbXdlW0/gCJOOsdmTAn2gFnarkgUIXJa4HFz49hGsH8fm/4FXRn6pGA7QAufJYe6fky8eSnv2qVa2KtnhjeEa3PVxn/RmejgmI4q2XeXSBt6Rtf38DrVdzs/joU31S9p/TkwCsFqRoX9X7vaTlKIeSZrAnY5YRBUKtbmDaeH4J337Vjm/Us3wl7DMguwrm8fGgGI7ZFrbS0O5LBO2Yurs6U=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cde263f-de6e-4c00-268e-08d7fdac9da8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2020 17:30:11.6160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4+0egUVjlckp79EFfYbWFRvjuzAVWhfGwTpe4ADCYLqwrblOEeVOFm5rgPz8PPR+L1ZIx9MRvxrSCe641kPfmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3173
X-OriginatorOrg: intel.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org <linux-acpi-
> owner@vger.kernel.org> On Behalf Of Kees Cook
> Sent: Wednesday, May 20, 2020 8:41 AM
> To: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>; Moore, Robert
> <robert.moore@intel.com>; Kaneda, Erik <erik.kaneda@intel.com>; Wysocki,
> Rafael J <rafael.j.wysocki@intel.com>; Len Brown <lenb@kernel.org>; ACPI
> Devel Maling List <linux-acpi@vger.kernel.org>; open list:ACPI COMPONENT
> ARCHITECTURE (ACPICA) <devel@acpica.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; Gustavo A. R. Silva
> <gustavo@embeddedor.com>
> Subject: Re: [PATCH] ACPICA: Replace one-element array and use
> struct_size() helper
>=20
> On Wed, May 20, 2020 at 11:15:18AM +0200, Rafael J. Wysocki wrote:
> > On Wed, May 20, 2020 at 12:46 AM Gustavo A. R. Silva
> > <gustavoars@kernel.org> wrote:
> > >
> > > On Tue, May 19, 2020 at 12:25:13PM +0200, Rafael J. Wysocki wrote:
> > > > On Tue, May 19, 2020 at 12:22 AM Gustavo A. R. Silva
> > > > <gustavoars@kernel.org> wrote:
> > > > >
> > > > > The current codebase makes use of one-element arrays in the
> > > > > following
> > > > > form:
> > > > >
> > > > > struct something {
> > > > >     int length;
> > > > >     u8 data[1];
> > > > > };
> > > > >
> > > > > struct something *instance;
> > > > >
> > > > > instance =3D kmalloc(sizeof(*instance) + size, GFP_KERNEL);
> > > > > instance->length =3D size;
> > > > > memcpy(instance->data, source, size);
> > > > >
> > > > > but the preferred mechanism to declare variable-length types
> > > > > such as these ones is a flexible array member[1][2], introduced i=
n C99:
> > > > >
> > > > > struct foo {
> > > > >         int stuff;
> > > > >         struct boo array[];
> > > > > };
> > > > >
> > > > > By making use of the mechanism above, we will get a compiler
> > > > > warning in case the flexible array does not occur last in the
> > > > > structure, which will help us prevent some kind of undefined
> > > > > behavior bugs from being inadvertently introduced[3] to the
> codebase from now on.
> > > >
> > > > However, the ACPICA code in the kernel comes from an external
> > > > project and changes of this type are generally not applicable to
> > > > it unless accepted upstream.
> > >
> > > Hi Rafael,
> > >
> > > By _accepted upstream_, in this case, you mean the adoption of the
> > > flexible-arrays in the whole codebase, first?
> >
> > I meant whether or not the patch is accepted by the ACPICA upstream.
>=20
> Is that here? https://github.com/acpica/acpica/commits/master
>=20
> >
> > >  If this is the case
> > > notice that there are hundreds of these flexible-array conversions
> > > in mainline, already:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/l
> > > og/?qt=3Dgrep&q=3Dflexible-array
> > >
> > > Is this what you mean?
> >
> > I'm not actually sure what you mean here.
>=20
> I think this was just a misunderstanding about what "upstream" meant. :)
>=20
> I hope ACPICA will take these changes -- it seems like we keep running in=
to
> these issues with the kernel's language feature clean-ups and ACPICA
> upstream, though each have been resolved so far! :) Flexible array member=
s
> are a C99 feature, so it's hardly a new way to express things.
> In fact, it looks like ACPICA already builds with -c99 by default:
> https://github.com/acpica/acpica/blob/master/generate/unix/Makefile.conf
> ig#L202
> https://github.com/acpica/acpica/blob/master/generate/efi/Makefile.config
> #L93
>=20
> MSVC has supported them (called "unsized arrays") since 7.1 in 2003.
>=20
> Gustavo, can you build a merge request for the ACPICA project directly?

The flexible array members will be fine.

The struct_size helper uses the typeof operator which is a GCC extension.

ACPICA codebase is intended to be compiled by many different compilers (not
just GCC and MSVC) so we cannot support struct_size.

Erik
>=20
> --
> Kees Cook
