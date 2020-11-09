Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9652AC58D
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Nov 2020 20:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbgKITzS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Nov 2020 14:55:18 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50944 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730952AbgKITzR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2020 14:55:17 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201109195505euoutp02bc352735b45aef247a5dfb978a3d818b~F7xKe19X50079000790euoutp02D;
        Mon,  9 Nov 2020 19:55:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201109195505euoutp02bc352735b45aef247a5dfb978a3d818b~F7xKe19X50079000790euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604951705;
        bh=jnOfB+OgvVPZ78iz7kLNUCSzkcrxoXhuBH9az0x99sM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p2uoqs6MppxOcXRiqOOAaiSMGheIDQglOYf50J5PhI9NOh0dQMUCKu0piTo4U5LWC
         kBIR+obilZiAew5mtWiwtXwHcwKqJqYKCxHYOidzTH2v8rGzEDhPhByLbG1lOQch/k
         DZB8PSlgLKLfcyMCPnt0F2/fglKc6gcjdsX3iQUA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201109195504eucas1p1ce7307af408a8dd879e1474dd205e30f~F7xJ60Y1f2806328063eucas1p1y;
        Mon,  9 Nov 2020 19:55:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C5.53.06456.89E99AF5; Mon,  9
        Nov 2020 19:55:04 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201109195504eucas1p19d493c947d8752e39c26202cf0978fc0~F7xJUnd_D2807128071eucas1p1e;
        Mon,  9 Nov 2020 19:55:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201109195504eusmtrp1e13153a69360711e0908aab0509c151a~F7xJTR5Gd1820718207eusmtrp1I;
        Mon,  9 Nov 2020 19:55:04 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-22-5fa99e98b93d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 01.66.06314.49E99AF5; Mon,  9
        Nov 2020 19:55:00 +0000 (GMT)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20201109195500eusmtip2d42034bc8abfbcd6904ac41a95850e76~F7xFwHqVw3224332243eusmtip2J;
        Mon,  9 Nov 2020 19:55:00 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Date:   Mon, 09 Nov 2020 20:54:59 +0100
In-Reply-To: <20201109185305.GT1003057@dtor-ws> (Dmitry Torokhov's message
        of "Mon, 9 Nov 2020 10:53:05 -0800")
Message-ID: <dleftjr1p2nw4s.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUiTcRjH+e19926OJq/zetCwHNlh6bKi3tAso2hFRFGkFGVTX1R00zaP
        9J9keKRoigfqMkkr73OK54y0lYl5hhF4FCJ4luGdebTXV8H/Ps/3+T7Xjx8fEw1xrfj+ihBa
        qZAFigkBXvfpb7dDVm6x5/GN2RNUkjqTQ23+aUZUdVYll/qQP4GohNJGnEpfK+RQhe+SEfW1
        KYegyvXDPCq9Xs+jSnUTGPVyIQO7sEfaqBnmSbUl8YR06JuOkOZ23JI+ry1B0nmtzU3insDF
        hw70D6OVEtdHAr8+dSwW/NH6ybhuBkWhzxYJyIgP5CkoW1okGBaRRQh0anuWFxDoh8ITkMDA
        8wiqstW8nYKfswMEmyhEsNSfth2MI+hZTTYEfD5BOkJ5uQdTYEZKoP7FKmI8GLmCQWNKHM4k
        TMmrEDM5iTGMk3bwZVO3NcGIfAz9GcUchoXkGWgYX0cMm5NnoXbiB4/VTaAje2yrD0bKIbtn
        BrHbrfNgtPYwswOQl0CjdmdlU5hqr90+YC90piXirOUppKWeZlYDMhFBXc4KznqcYah7lWDZ
        DZbjNwnWbwzff5mwU40htS4TY2UhPIsVse4DUJGs2+5iBUlTRYi1SKF18g77UGoE/7QvOClo
        v2bXLZpdt2gMJRh5BCqbJKx8FArypjGWz0FFxSz+CnFLkCUdqpL70ionBR3uqJLJVaEKX0fv
        ILkWGf5Z50b7XANa7PdqQyQfifcI368VeIq4sjBVhLwNHTB0Gq0q7UVWuCJIQYvNhBe7Oh+K
        hD6yiEhaGeSpDA2kVW3Imo+LLYUn8ycfiEhfWQgdQNPBtHIny+EbWUWh4Mqs6TjkP7bpdDX2
        Z3jKd0lplXuM/kqs7WC9MqFrMPRuX8h95+uHzGpsvdoou+klj7jI2bm3Zc775myutY60SByO
        RR70jw6paYl2Hnld1uDmKl7tNV/4Fm25rC1uHntT6OLO+91yW59zOd07r8ypSq8x4W5UC6jz
        NzTjrgEWA8NiXOUnc7LHlCrZf2Q0dMBvAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsVy+t/xe7pT5q2MN9g2U8Git2k6k8X/D7sZ
        LTbOWM9qcXjRC0aLrtU7WSym/FnOZLF8Xz+jxeVdc9gs1h65y24xZfsRdovVe14wW8z9MpXZ
        gcdj56y77B6bVnWyedy5tofNY97JQI++LasYPT5vkgtgi9KzKcovLUlVyMgvLrFVija0MNIz
        tLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLuNjUxlxwVLri+Z43jA2MJ8S6GDk5JARM
        JB68v8rWxcjFISSwlFHi4eU1rF2MHEAJKYmVc9MhaoQl/lzrgqp5yijx8+0/ZpAaNgE9ibVr
        I0BqRAT0JbbP/sUIUsMs8IJZYkn7RFaQhLCAp0Try5fMILYQUP32OZvAbBYBVYkz//ewg9ic
        AoUSc9/1s4HYvALmEjue/2UEsUUFLCW2vLjPDhEXlDg58wkLiM0skC3xdfVz5gmMArOQpGYh
        Sc0COo9ZQFNi/S59iLC2xLKFr5khbFuJdevesyxgZF3FKJJaWpybnltsqFecmFtcmpeul5yf
        u4kRGJPbjv3cvIPx0sbgQ4wCHIxKPLwH/iyLF2JNLCuuzD3EqAI05tGG1RcYpVjy8vNSlUR4
        nc6ejhPiTUmsrEotyo8vKs1JLT7EaAr050RmKdHkfGAaySuJNzQ1NLewNDQ3Njc2s1AS5+0Q
        OBgjJJCeWJKanZpakFoE08fEwSnVwJgxO8x3n71Il3TOQfNOzjnS98XOHHzOwya7jqGNMeT4
        Ass5Nxbc3Pbh1p5nt9WalTf1XdAR+dC1OFtkacg888XLdX4ejmq99M5ukZ5Prl/e7Q3O67Wj
        P+fJ96t/VnsxJWxV7pLvyg7pfPrRPOtkw0IXaWxqLToxieXO7G8rtn916L93bIuRo44SS3FG
        oqEWc1FxIgAxMy+F6wIAAA==
X-CMS-MailID: 20201109195504eucas1p19d493c947d8752e39c26202cf0978fc0
X-Msg-Generator: CA
X-RootMTR: 20201109195504eucas1p19d493c947d8752e39c26202cf0978fc0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201109195504eucas1p19d493c947d8752e39c26202cf0978fc0
References: <20201109185305.GT1003057@dtor-ws>
        <CGME20201109195504eucas1p19d493c947d8752e39c26202cf0978fc0@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2020-11-09 pon 10:53>, when Dmitry Torokhov wrote:
> On Mon, Nov 09, 2020 at 07:18:37PM +0100, Lukasz Stelmach wrote:
>> It was <2020-11-09 pon 19:24>, when Andy Shevchenko wrote:
>> > On Mon, Nov 09, 2020 at 06:02:29PM +0100, Lukasz Stelmach wrote:
>> >> It was <2019-11-07 czw 20:22>, when Dmitry Torokhov wrote:
>> >> > It is possible to store references to software nodes in the same fa=
shion as
>> >> > other static properties, so that users do not need to define separa=
te
>> >> > structures:
>> >> >
>> >> > static const struct software_node gpio_bank_b_node =3D {
>> >> > 	.name =3D "B",
>> >> > };
>> >> >
>> >> > static const struct property_entry simone_key_enter_props[] =3D {
>> >> > 	PROPERTY_ENTRY_U32("linux,code", KEY_ENTER),
>> >> > 	PROPERTY_ENTRY_STRING("label", "enter"),
>> >> > 	PROPERTY_ENTRY_REF("gpios", &gpio_bank_b_node, 123, GPIO_ACTIVE_LO=
W),
>> >> > 	{ }
>> >> > };
>> >> >
>> >> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> >> > ---
>> >>=20
>> >> I am writing a piece that needs to provide a list of gpios to a
>> >> diriver. The above example looks like what I need.
>> >
>> > Nope.
>> >
>> > It mustn't be used for GPIOs or PWMs or whatever that either should co=
me via
>> > lookup tables or corresponding firmware interface.
>> >
>>=20
>> May I ask why? I've read commit descriptions for drivers/base/swnode.c
>> and the discussion on lkml and I understand software nodes as a way to
>> provide (synthesize) a description for a device that is missing a
>> description in the firmware. Another use case seems to be to replace (in
>> the long run) platform data. That is what I am trying to use it for.
>>=20
>> I want my device to be configured with either DT or software_nodes
>> created at run time with configfs. My device is going to use GPIOs
>> described in the DT and it is going to be configured via configfs at run
>> time. I could use platform_data to pass structures from configfs but
>> software nodes would let me save some code in the device driver and use
>> the same paths for both static (DT) and dynamic (configfs)
>> configuration.
>>=20
>> Probably I have missed something and I will be greatful, if you tell me
>> where I can find more information about software nodes. There are few
>> users in the kernel and it isn't obvious for me how to use software
>> nodes properly.
>
> Yeah, I disagree with Andy here. The lookup tables are a crutch that we
> have until GPIO and PWM a taught to support software nodes (I need to
> resurrect my patch series for GPIO, if you have time to test that would
> be awesome).

It will be great to help. I=C2=A0am not sure if I have means to test PWMs,
but I can do GPIOs.

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl+pnpMACgkQsK4enJil
gBByKQgAkxubb9+fQ8Q8CxUOcAoEFhm9/mGmiqvKYt3tMj8QFl6Ns4SKyo5koe2g
CfZvxmo64cv2mOOkcRCxVqU7A3WbNvhJoaJUmnvOURCT/nTSfx5fJGYzwshQz30N
wUFPjhWO8N2K7vyL+xUUor5ZHe2By0k9b0PHPLe7w1mprQ9TBFlTvDIK4eDDTY8b
c3omtlW9HX6GR0tc7UCcTRpNofSuD66+Ya66AtvxS/jTvICxDM7n68A6h/X5o2Km
ZGUwN7itkAg/0BbQjBgQiR6+PZ41wm8PFls3P5U3uc4qMeyVE87bhMnyyiabg8oQ
x7XZ8zMJbikCqLWP386saRHAiYkvSw==
=c5q9
-----END PGP SIGNATURE-----
--=-=-=--
