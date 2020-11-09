Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BEC2AC391
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Nov 2020 19:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgKISTK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Nov 2020 13:19:10 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37392 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729831AbgKISTJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2020 13:19:09 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201109181857euoutp01a40f1fc9ea28f4b18ac6be650a6d7e1d~F6dOYGxIQ2204622046euoutp01P;
        Mon,  9 Nov 2020 18:18:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201109181857euoutp01a40f1fc9ea28f4b18ac6be650a6d7e1d~F6dOYGxIQ2204622046euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604945937;
        bh=hEijv8xa/SnJvVvwXRCSatXg245l9YxPOQF8AHgArII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SLqTjBiBj/ncJ4+P5Luus1W1XdCqIpWFBnTU9Uv5xt0JKInOk03yptknvOonw9ooZ
         nkg7E7sXr9cIUQHeuNCofBT0YSk/unQKE7cez4yqtgFI78UCMjHMA2pFWjEY9ObpLi
         Oc5X/y4hsgt5lW7PCrTDhcOCso3HG0k1zq2zAPko=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201109181851eucas1p171733bf8b9a4fae009a725620106c481~F6dJHMakv3011430114eucas1p13;
        Mon,  9 Nov 2020 18:18:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 5B.3F.06456.B0889AF5; Mon,  9
        Nov 2020 18:18:51 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201109181851eucas1p241de8938e399c0b603c764593b057c41~F6dIuXzFY2728227282eucas1p2H;
        Mon,  9 Nov 2020 18:18:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201109181851eusmtrp1b079afa9e0cc942b1f2e4d865583414b~F6dItq2sh1795617956eusmtrp1Q;
        Mon,  9 Nov 2020 18:18:51 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-89-5fa9880badd2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 28.E0.06017.B0889AF5; Mon,  9
        Nov 2020 18:18:51 +0000 (GMT)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20201109181850eusmtip2832d1e7f6ba4a8f6714ac5240b84ee0b~F6dIk0vlD0139201392eusmtip2V;
        Mon,  9 Nov 2020 18:18:50 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v8 3/6] software node: implement reference properties
Date:   Mon, 09 Nov 2020 19:18:37 +0100
In-Reply-To: <20201109172435.GJ4077@smile.fi.intel.com> (Andy Shevchenko's
        message of "Mon, 9 Nov 2020 19:24:35 +0200")
Message-ID: <dleftj4klypf5u.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfVCLcRy/355nz56WuV+r+JqQlT9wlY7j6bwcjjP+IHf+6NyR0aPQVvYo
        4pxeSHa9uEKKvCxa1m0p3aZt5NouulHUHZ13FW2R5O3URVrP3Pnv8/u8fN/uRxPSN0IZvUd9
        gNWolclySkyaW4bbIvzzbsQvGHKEMAXZpQJm7IsNMXXna4WMQ+dGjLamkWTOjOoFjP5uEWI6
        rRcpxuh8JWLOWJwipsbuJpiK72eJlZMUjeWvRIp6wylK8fKpnVJcat2sKGwwIMW3+pmx1Fbx
        sgQ2eU86q4lasUOcdM5molLHZhz6MdKPMlEPaJEfDXgRWK87SC0S01JcjeDP+1yBV5Di7wic
        FoYXviEw/nZT/xI93T2IF/QIGi9kC/hHH4LCc0MiLaJpCkeC0RjnDQThJWAq1lFeD4E/EzDQ
        MSL0CoF4PZzweAgvJvEcGDN1TvB+OAPas/tEXiwZDxtNTyc6B+MYaHC/8fEB0FrWS3oxgVVQ
        1v5pYiLAwyJ4N3BHwI+6BiouvyB5HAj99xtEPA4BV0k+6R0U8DEoKV7MZ/MRmC/+8vmXwsu2
        Ed/Kq8CSUyfk/ZOhayCA7zsZis2lBE9LIC9XyrvDwVRk91WRQUF/NeKxAh4a+CNKsRaBx55w
        GoWW/7dN+X/blI9XJfBcqLVG8fR8qLr6keDxcjCZBskrSGhAU9k0TpXIctFq9mAkp1RxaerE
        yF0pqno0/tVcf+5/vY1+dOxsRphG8kmSe6NV8VKhMp3LUDWj8PFK3TdrHiMZqU5Rs/IgyepH
        ru1SSYIy4zCrSYnXpCWzXDOaTpPyqZKFOs82KU5UHmD3sWwqq/mnCmg/WSba2JVjFQU37fb/
        EF4bU6q7+tOotNmer82P2eSaJntduS7PHIr2HyUtHfuTM473tpBBWzp79x7BD0Ny4vSKt3HD
        N2Y3nbzmrBza8uVWpcZR8rkurmvjrDBhYFbElAfHmazCR+7Y3CfPsgLCVuzegNMzUUTTaM+O
        Y6Z0apAbSQpzuOQkl6SMnkdoOOVfWgu/E3IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xe7rcHSvjDW4dZbfobZrOZPH/w25G
        i40z1rNaHF70gtGia/VOFospf5YzWSzf189ocXnXHDaLtUfusltM2X6E3WL1nhfMFnO/TGV2
        4PHYOesuu8emVZ1sHneu7WHzmHcy0KNvyypGj8+b5ALYovRsivJLS1IVMvKLS2yVog0tjPQM
        LS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQypu1ex1bwX7bi669XjA2MjyW6GDk5JARM
        JB4/eszYxcjFISSwlFFi8v+1rF2MHEAJKYmVc9MhaoQl/lzrYoOoecoocW8uSAMHB5uAnsTa
        tREgNSIC5hLrJi1iA7GZBR4wSzT8YgKxhQU8JVpfvmQGsYUEzCTefO8Gq2ERUJX4v+4yK4jN
        KVApcb7pOTuIzQs0Z+26a2A1ogKWElte3IeKC0qcnPmEBWJ+tsTX1c+ZJzAKzEKSmoUkNQvo
        OmYBTYn1u/QhwtoSyxa+ZoawbSXWrXvPsoCRdRWjSGppcW56brGRXnFibnFpXrpecn7uJkZg
        RG479nPLDsaud8GHGAU4GJV4eA/8WRYvxJpYVlyZe4hRBWjMow2rLzBKseTl56UqifA6nT0d
        J8SbklhZlVqUH19UmpNafIjRFOjPicxSosn5wCSSVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZI
        ID2xJDU7NbUgtQimj4mDU6qBMWjKLfXtc9YdiBW4WaV1Wum57JdqM4+n5ROF7dYf1Nr/oDDa
        cf+3vg3bUmfaPMp+zHKBS2jdjRQJ89KpNwo/L1l76onnko4t96bLfjj1+oHC3m/yzD8b2pwC
        56V4ZWs47Wu5s226VY5L9M7ldzbMk3z2ZBb3Y4a2/XHcjsduvLpXEHO54Vl+wzwlluKMREMt
        5qLiRACi8Uu96gIAAA==
X-CMS-MailID: 20201109181851eucas1p241de8938e399c0b603c764593b057c41
X-Msg-Generator: CA
X-RootMTR: 20201109181851eucas1p241de8938e399c0b603c764593b057c41
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201109181851eucas1p241de8938e399c0b603c764593b057c41
References: <20201109172435.GJ4077@smile.fi.intel.com>
        <CGME20201109181851eucas1p241de8938e399c0b603c764593b057c41@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2020-11-09 pon 19:24>, when Andy Shevchenko wrote:
> On Mon, Nov 09, 2020 at 06:02:29PM +0100, Lukasz Stelmach wrote:
>> It was <2019-11-07 czw 20:22>, when Dmitry Torokhov wrote:
>> > It is possible to store references to software nodes in the same fashi=
on as
>> > other static properties, so that users do not need to define separate
>> > structures:
>> >
>> > static const struct software_node gpio_bank_b_node =3D {
>> > 	.name =3D "B",
>> > };
>> >
>> > static const struct property_entry simone_key_enter_props[] =3D {
>> > 	PROPERTY_ENTRY_U32("linux,code", KEY_ENTER),
>> > 	PROPERTY_ENTRY_STRING("label", "enter"),
>> > 	PROPERTY_ENTRY_REF("gpios", &gpio_bank_b_node, 123, GPIO_ACTIVE_LOW),
>> > 	{ }
>> > };
>> >
>> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> > ---
>>=20
>> I am writing a piece that needs to provide a list of gpios to a
>> diriver. The above example looks like what I need.
>
> Nope.
>
> It mustn't be used for GPIOs or PWMs or whatever that either should come =
via
> lookup tables or corresponding firmware interface.
>

May I ask why? I've read commit descriptions for drivers/base/swnode.c
and the discussion on lkml and I understand software nodes as a way to
provide (synthesize) a description for a device that is missing a
description in the firmware. Another use case seems to be to replace (in
the long run) platform data. That is what I am trying to use it for.

I want my device to be configured with either DT or software_nodes
created at run time with configfs. My device is going to use GPIOs
described in the DT and it is going to be configured via configfs at run
time. I could use platform_data to pass structures from configfs but
software nodes would let me save some code in the device driver and use
the same paths for both static (DT) and dynamic (configfs)
configuration.

Probably I have missed something and I will be greatful, if you tell me
where I can find more information about software nodes. There are few
users in the kernel and it isn't obvious for me how to use software
nodes properly.

>> At the moment the driver gets the list from fwnode/of_node. The list
>> contain references to phandles which get resolved and and the driver
>> ends up with a bunch of gpio descriptors. Great.
>>=20
>> This example looks nice but does the code that reads the reference from
>> the gpios property and returns a gpiod actually exist? If it doesn't, I
>> am willing to write it.
>>=20
>> At first glance it makes more sense to me to pass (struct gpiod_lookup
>> *) instead of (struct software_node *) and make gpiolib's gpiod_find()
>> accept lookup tables as parameter instead of searching the
>> gpio_lookup_list? Or do you think such temporary table should be
>> assembled from the above structure and then used in gpiod_find()?
>>=20
>> Any other suggestions on how to get a bunch of gpios (the description
>> for gpios is available in the devicetree) for a device described with a
>> software nodes?

Kind regards,
=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl+ph/0ACgkQsK4enJil
gBA91AgAj98l1zGpb3nRueRTilcBsdviqDIZ+R4Iiyz8nqVDngoMFwU4ARNQ595W
tiPfxtYiPFvvTqaTBv0xo4MAe0ckmKrdcMfu4gc1j9MafTMt2UT8y7VYeHoVK2JZ
onDISNxyOEloXwN7YlgZ6qq1m2c4hLJ34mGw0FfLl1nnm1ZpYHRvnuqSOXV1bMY8
RRxfIitR1v1N13EYKjj9bOmxfOPA7lkXqAnU46auseQprgaMtDoAIQbPnH0ceDKS
AFgQa2IhTySWtemReu82kf1+2Jg7EFtB4CB7DpCT3uLz8Ji4XwK9ryRM3Gj1X1rD
r6DJElSF1hJ9eaqK11DASHKUNfB8Ow==
=5HRX
-----END PGP SIGNATURE-----
--=-=-=--
