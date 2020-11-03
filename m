Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D942A4ED1
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Nov 2020 19:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgKCS2V (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Nov 2020 13:28:21 -0500
Received: from mga17.intel.com ([192.55.52.151]:59359 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbgKCS2V (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 3 Nov 2020 13:28:21 -0500
IronPort-SDR: 7eq3wc5W8ZuMAax5MI3YtwMmh8W9Oa5tjGpiMqAKw1f9f3LhQtYOof6fbv7pwmsNJhl8YOhYii
 15Ckzwb4zRww==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="148957005"
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="148957005"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 10:28:20 -0800
IronPort-SDR: O5fKZvgz+esJOOHM+C/rm4ss5Myz6XWMq6b8eYuBLpfIIUJ8ehOdNOv7oeL9YilPpIblFGOw2H
 z4qm8VBQC4Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="325321395"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 03 Nov 2020 10:28:20 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 3 Nov 2020 10:28:19 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 3 Nov 2020 10:28:19 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 3 Nov 2020 10:28:19 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 3 Nov 2020 10:28:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ufbc1Fevrj2uJpqSYyMLe0eMypunJKgR/DdJEYAIcaAd1cfYMZDzggZunV0KNyz1vmPgKjBbqJpOXrRO++6LYX9xt0Cy3dLJ4cH0Gq3x01jlhvIL/wjudCr2xNGnOfp5T3pQsAT5g2hcxLs8qdoPbfiqfxDAvf9N5+92S2/8RjQfjyaBBzcx8J6p+umvDpZ7aeuMmLd63kGnoahGwea0iEPB3aEooQ1cWhh5zjgamh3EI4UaJsRuF2X3ebmRfy4ciKwICmWh+6r5UajRLjnW3dgGP6Rz1S8/3EvXwhX2MDbUU54Cg4XmrTGzQYgIFdBqZ23uaFiysOuoYqIxG8gZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjIJVfJhGDqNo7YrXj23AqJ3DhGzaTD6Garv3701P1g=;
 b=du0niWl9kjKWtlZItlL1ZsUfa2sc6nkA07bwC0C2OQ7WIuY8xvgpypKQmbu5ylL0MTYsAmngKddgihGTGqgQbGp7/7zr7dAwAzgMgop49gCh0t7BEDoXAL6SyyqnABOaFjxmTvch53KB0DSA+sCrqfC7DHVi7NuvHoSstu6hPi3LPDgmxMwskYBtsmP3Df6+X7nzGm0+YosThrN1vVvu2/x42oi9/rnyIjFBQSQxdQLIfllBEAiwTCuIR2pEM7WPm+vILnqlmT+YoYrMY0fxAjLYR2ha4GCMARzj2JMVESW0CIWkCLkP8h1iUWhbIlAEMI+2+IVp2Q+5++LtsUVsDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjIJVfJhGDqNo7YrXj23AqJ3DhGzaTD6Garv3701P1g=;
 b=q6JFYWDrPMTVoFfZ4FbQMb42iHK75WzFwh5uFdsK3NlPapw1c0mKaroeg6txeO0aU2ep1UXeRzVUM8ITuQJi4OdVNeFBA36uSX+91k/04mR1b3E5zu+SbQwz5zpBWRYbZgenmzjcp4yJU03VnRfE1bPJHuUmoyRNUa3QU4pY+8A=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by MWHPR11MB0064.namprd11.prod.outlook.com (2603:10b6:301:64::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.30; Tue, 3 Nov
 2020 18:28:14 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::95ce:8aed:2361:1f31]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::95ce:8aed:2361:1f31%10]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 18:28:14 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     Mark Asselstine <mark.asselstine@windriver.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPICA: avoid double free when object already has a zero
 reference count
Thread-Topic: [PATCH] ACPICA: avoid double free when object already has a zero
 reference count
Thread-Index: AQHWrZgqUSUAS5yOM0Kd9m5guNYbU6mungEAgAaNfICAAAuOgIABicEQ
Date:   Tue, 3 Nov 2020 18:28:14 +0000
Message-ID: <MWHPR11MB1599FF403112D4C33FFEA4E5F0110@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20201028200523.111028-1-mark.asselstine@windriver.com>
 <CAJZ5v0hr4xFA9bGJM+0e4i-QpESPnwy5ZT4KPwfJgby5Sz3UBw@mail.gmail.com>
 <MWHPR11MB15993189246B6AC609247D69F0100@MWHPR11MB1599.namprd11.prod.outlook.com>
 <5891030.cEBGB3zze1@yow-masselst-lx1>
In-Reply-To: <5891030.cEBGB3zze1@yow-masselst-lx1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: windriver.com; dkim=none (message not signed)
 header.d=none;windriver.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [50.45.176.77]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce6eb1fa-24a6-4386-3736-08d880263a18
x-ms-traffictypediagnostic: MWHPR11MB0064:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB0064B28150FCB0EFBF1F4467F0110@MWHPR11MB0064.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X7ovARmqR4/F3PNTuC2XwvQp11qsz2CG3OXxSvqmzRwXtLjhSQz/BzCadrZNJOq5yWaIS7AjKj+TklS51VlIs+XPuwDdWqu6dXdAPYE+H8bhgkL8D450jpddo4trZxaakttW8GLKVtXt+ZXFAu5tzXhKjYabg55f/FOl/iXB0d7f8O44dy2kqz55wnYPGNSgqrN2CucV0Ymr/kt/VPWTgZ3Xc/35tMPdeEk3QNf2KpxbkkFCp5H507/zYyc7/Z3nYdiNTDjpWfmusgCLYPJyADLyUYbDeuxCkSWIPNNASIlJ44aDCE0tSz0lsyVifynd5am8kI4NL+BCf7GTEZK9/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(64756008)(83380400001)(8936002)(8676002)(66446008)(76116006)(52536014)(66946007)(66476007)(5660300002)(110136005)(316002)(54906003)(66556008)(4326008)(71200400001)(86362001)(7696005)(6506007)(53546011)(186003)(9686003)(55016002)(33656002)(107886003)(26005)(478600001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: hG+1mAZXwDY7S9F5HFN2MnipGzqknYMHRi+BOrAYgy6ofVETgISo9NXc0N4ZQGnVrNlTpXDnfkOUyBJRw+5Z3qZathLZznvtzDbtUgXJGris9Qfj9MA9tfd3uKn1bieCI57zKAnfYd0BdwsE6ObW8un6/zxHLbEvzXgXBYD8rFpbZrUJt+/Hlx60vYWZ9+QfIRIkKCEUcZy1tlIA2P2L4paUdaJXTmOS+2TZXRneSGss1G/fTTJ5v3ug4zB2/QCvVliWRapMXZrH8BKPG7g53VFLJ7785b1Mu7aN7QGh13DI9/lgRfHQxAiEo8pPRb/Zio0MxkzRVcpG09dhXikwTIGAsiHupel8noGggtxVvBw+ozV8iHUaRnbmgCliUlmxSsgdqdX6vLam5LJNUq89WMr/GTKXP+JmhjuA44gGbnKujQsp4yEw1Zini9Wc4cYJT3dydMDK51/QxHRXxqYEc8JB6/f4MHLN0ee7HOY+Js5UvK2v/akYFlbQyy2/NhNSLm6j5luVriNihZdyfa+XBVWFLLZllOK6hR/0zvq7kHOe8e0+Xo19I1zdgL5uB6+0tV3foTbovbSbZRnYbQctGv9TrvK8yeGxoil6wjH/tcKxiHxB40FxdFve5qLOc/H6O6jtG2U8Tbe3K0oabLoHtA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6eb1fa-24a6-4386-3736-08d880263a18
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 18:28:14.2974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XXicwXWZFNdDfCpOLZzAaivdVqVRlaz9R9cxhNXYeA3UI3oC1bVznCOWQ839lltWFH9ojrOdysOcHbTCKDDcCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0064
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Mark Asselstine <mark.asselstine@windriver.com>
> Sent: Monday, November 2, 2020 10:51 AM
> To: Rafael J. Wysocki <rafael@kernel.org>; Kaneda, Erik
> <erik.kaneda@intel.com>
> Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>; Moore, Robert
> <robert.moore@intel.com>
> Subject: Re: [PATCH] ACPICA: avoid double free when object already has a
> zero reference count
>=20
> On Monday, November 2, 2020 1:11:22 P.M. EST Kaneda, Erik wrote:
> >
> >
> > > -----Original Message-----
> > > From: Rafael J. Wysocki <rafael@kernel.org>
> > > Sent: Thursday, October 29, 2020 7:06 AM
> > > To: Mark Asselstine <mark.asselstine@windriver.com>
> > > Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>; Kaneda, Erik
> > > <erik.kaneda@intel.com>; Moore, Robert <robert.moore@intel.com>
> > > Subject: Re: [PATCH] ACPICA: avoid double free when object already ha=
s
> a
> > > zero reference count
> > >
> > >
> > >
> > > +Erik and Bob
> > >
> > >
> > >
> > > On Thu, Oct 29, 2020 at 3:05 AM Mark Asselstine
> > > <mark.asselstine@windriver.com> wrote:
> > >
> > > >
> > > >
> > > > The first trip into acpi_ut_update_ref_count() for an object where
> > > > 'object->common.reference_count' is 1 and we are performing a
> > > > REF_DECREMENT will result in 'new_count' being 0 and thus the objec=
t
> > > > is deleted via acpi_ut_delete_internal_obj().
> > > >
> > > >
> > > >
> > > > If for some reason we make a subsequent trip into
> > > > acpi_ut_update_ref_count() with the same object,
> > > > object->common.reference_count' will be 0 and performing a
> > > > REF_DECREMENT will produce a warning msg "Reference Count is
> already
> > > > zero, cannot decrement", 'new_count' will again be 0 and the alread=
y
> > > > deleted object will be attempted to be deleted again via
> > > > acpi_ut_delete_internal_obj().
> >
> >
> > Mark, Do you have an example of AML/ASL that you used to determine
> this
> > double free?
>=20
> Unfortunately no. It is a rare occurance and a consequence of several act=
ions
> taking place at the same time during boot, including a PCI rescan.
> Unfortunately due to circumstances I am sure you would rather not have to
> be
> concerned about, we have so far had to focus our efforts on an older kern=
el
> which also has the preempt-rt patchset applied. It is for this reason I a=
lso
> didn't include the dmesg and eventual kernel BUG_ON in my submission.
>=20
> It is unclear at this time if the additional locking or other changes tha=
t
> have been merged since the kernel version we are on would prevent this
> from
> occuring on an up to date kernel.
>=20
> I have reviewed the code in the latest linux kernel and as far as I can t=
ell
> the deficiency is still present. If you do go into acpi_ut_update_ref_cou=
nt()
> with an object with a reference count of 0 and an action of REF_DECREMENT
> the
> following may be called:
>=20
> acpi_ut_update_ref_count
>   -> acpi_ut_delete_internal_obj
>     -> acpi_ut_delete_object_desc
>       -> acpi_os_release_object
>         -> kmem_cache_free
>=20
> I completely understand if you have concerns about the change since I can=
't
> hand you a reproducer. I was hoping the merrits of the change would stand
> on
> their own as there is no reason to call acpi_ut_delete_internal_obj() if =
we
> have already done so, even if the rest of the call chain was well behaved=
. In
> our case the eventual slab corruption ended up affecting the 'Acpi-Operan=
d'
> dedicated cache. We see the corruption happen shortly after we see the ms=
g
> warning that the reference count is already at zero.
>=20
> Please let me know if there is anything else I can provide to help out an=
d
> thanks for your time reviewing this change.

Since this is such a sensitive part of the codebase, I would like to see if=
 it's possible to come up with ASL that reproduces this on our userspace in=
terpreter (acpiexec).

I can try reproduce this from your explanations but it would be helpful to =
also get an acpidump and dmesg so that we can understand which named object=
s are causing this issue. This gives us a clue on how to reproduce this in =
user space.

Could you provide an acpidump of the machine and 2 dmesg logs? I need one n=
ormal dmesg that shows this error and a custom kernel built with CONFIG_ACP=
I_DEBUG=3Dy and booting with the following commandline parameters:

acpi.debug_level=3D0x80000 acpi.debug_layer=3D0xffffffff

Thanks,
Erik
>=20
> Thanks,
> Mark
>=20
>=20
> > Thanks,
> > Erik
> >
> >
> > > >
> > > >
> > > > Since the object deletion doesn't NULL the object the calls to
> > > > acpi_ut_delete_internal_obj(), acpi_ut_delete_object_desc(),
> > > > acpi_os_release_object(), kmem_cache_free() will operate on the
> object
> > > > as if it hasn't been deleted. In many cases this can result in no
> > > > issues, but if you are using the slab and a new object has been
> > > > created with the same address this can be the cause slab corruption=
.
> > > >
> > > >
> > > >
> > > > Adding a check if we are decrementing to 0 for the first time and o=
nly
> > > > calling acpi_ut_delete_internal_obj() in this case will prevent
> > > > another attempt at deleting the object.
> > > >
> > > >
> > > >
> > > > Signed-off-by: Mark Asselstine <mark.asselstine@windriver.com>
> > > > ---
> > > >
> > > >  drivers/acpi/acpica/utdelete.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > >
> > > >
> > > > diff --git a/drivers/acpi/acpica/utdelete.c
> > > > b/drivers/acpi/acpica/utdelete.c
>  index 4c0d4e434196..c6b860fd9eb5
> > > > 100644
> > > > --- a/drivers/acpi/acpica/utdelete.c
> > > > +++ b/drivers/acpi/acpica/utdelete.c
> > > > @@ -421,9 +421,9 @@ acpi_ut_update_ref_count(union
> > >
> > > acpi_operand_object *object, u32 action)
> > >
> > > >                                       ACPI_GET_FUNCTION_NAME, objec=
t,
> > > >                                       object->common.type, new_coun=
t));
> > > >
> > > >
> > > >
> > > > -               /* Actually delete the object on a reference count =
of
> > > > zero */
>  +               /* If we haven't already, actually delete the
> > > > object on a reference>
> > > count of zero */
> > >
> > > >
> > > >
> > > > -               if (new_count =3D=3D 0) {
> > > > +               if (new_count =3D=3D 0 && original_count !=3D 0) {
> > > >
> > > >                         acpi_ut_delete_internal_obj(object);
> > > >
> > > >                 }
> > > >                 message =3D "Decrement";
> > > >
> > > > --
> > > > 2.17.1
> > > >
> > > >
>=20
>=20
>=20

