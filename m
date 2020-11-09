Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C878C2AC550
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Nov 2020 20:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbgKITro (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Nov 2020 14:47:44 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50044 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbgKITro (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2020 14:47:44 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201109194731euoutp02dc2b5775f916ab58f332230eeb90914a~F7qj4e5vP2806728067euoutp02s;
        Mon,  9 Nov 2020 19:47:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201109194731euoutp02dc2b5775f916ab58f332230eeb90914a~F7qj4e5vP2806728067euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604951251;
        bh=zU3RqLMP1ZxNY2Ip2IefIVZjI5rCocFtg9gxdBe+H8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UafEm/wcX6R1fg0NGP/leDOhdX6T+ZjqlXS/q6u7tl14mdUaLpQP/jDC99S2G38Rj
         s23rbbiSRiKd9TjKz8qOkTyDwMWL3YQuq9/H05XrgRXQpatKoSrpWBm1xmuHJWWrGD
         KNSQ+jiwOnPbFOV2cLq6X0cIwtptRtZ1xqO6Rer4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201109194726eucas1p2ed17e3d0984b72a87d7d5568b028a336~F7qeyWGw-2937229372eucas1p2o;
        Mon,  9 Nov 2020 19:47:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F2.13.06456.ECC99AF5; Mon,  9
        Nov 2020 19:47:26 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201109194725eucas1p2cc9357486879a14b2ad2f6ef968ff4b2~F7qd-7ot_3079130791eucas1p2i;
        Mon,  9 Nov 2020 19:47:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201109194725eusmtrp14cee186162607b1199988f8a87c5f0d2~F7qd-PDH41249512495eusmtrp1g;
        Mon,  9 Nov 2020 19:47:25 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-bf-5fa99cce99c2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 24.36.06314.DCC99AF5; Mon,  9
        Nov 2020 19:47:25 +0000 (GMT)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20201109194725eusmtip2e2d1d1b2543253bba1a49bd7f480e1f1~F7qdz7JpX1809818098eusmtip2F;
        Mon,  9 Nov 2020 19:47:25 +0000 (GMT)
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
Date:   Mon, 09 Nov 2020 20:47:14 +0100
In-Reply-To: <20201109190245.GL4077@smile.fi.intel.com> (Andy Shevchenko's
        message of "Mon, 9 Nov 2020 21:02:45 +0200")
Message-ID: <dleftjv9eenwhp.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm2zk7m8PJ2Wb4suzCumGSJoWd6EJpl9UvKxIJyk55UMtN27y0
        fpStEh3eb6thVmKaG1vlZVlZ6RLNrCyVssiE7KIrTVKj2ah2PAv697zP+zzPy/PxCTHpO75c
        mKhOZTRqOklBiHB7h6tnxbOKutiV+dU+VJ7eyKP+TNxF1M3z1/nUw6oRRBkst3Gq1F3Lo2rv
        FyCq704FQVnbBwVU6a12AWVpGcGoi1Nl2CZf5W3ToEBZb84hlG9fthDKyq5dyvxGM1JO1s+P
        IvaJ1scxSYnpjCZ040FRQnVrGS/lwdLjrT+MKBPpFxiQjxDI1TBe0oEbkEgoJa8hOPPL4R2m
        EFhbajBumERQeumMZxDOWu5VBXB8LQJnm9Hr+Izgk74QsSKCDAGrNYY94U+uAVtxFcFqMHIc
        g7HeGT67kJE74Nzo6GwoTi6BmY97WNqH1EHl8AucpcUer8sVxtJzyLXQODIkYLGYlEDXhQ84
        izFSBRd6viI2HkiXAH5UvhFw1bbAVcdXPodl4Oxs9PKB0F2Si3NdTkFJcTjnzUVgr/iJc5p1
        8PbZDMHhzWD51c/n9H4wMCbh7vpBsd3ofRIxZGdJOfVisBW0eFPkkOe8hjishKKyz97nNCCo
        e2zHCtFC0391TP/VMXliMTIIrt8J5ehgqLnyBePwBrDZvuGXEd+MApg0rSqe0YapmYwQLa3S
        pqnjQw4nq+qR56d1/+783oymew85EClECl9xq7smVsqn07U6lQMt9iS9v2F5juS4OlnNKPzF
        EU+7D0jFcbTuBKNJjtWkJTFaB5orxBUB4lVVo/ulZDydyhxlmBRG82/LE/rIM9H8yP4c/aLy
        8KgnN8yFsnhZ+Eh0dVBWZ7TpYpFfRnbT7q1DefOctOV0snzTLiImOCF3cjg6e1nfm9e0fuBI
        83igro5uSP3y+6xE3rtsWuKeiJDx/J3R7tSJyD1Jp2PTA+8ZiqKyRPkN29u3uefgbed2v+KJ
        m4aefpouZ46d3PlorwLXJtBhyzGNlv4LdT+IlXEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7pn56yMN+j+LGzR2zSdyeL/h92M
        FhtnrGe1OLzoBaNF1+qdLBZT/ixnsli+r5/R4vKuOWwWa4/cZbeYsv0Iu8XqPS+YLeZ+mcrs
        wOOxc9Zddo9NqzrZPO5c28PmMe9koEffllWMHp83yQWwRenZFOWXlqQqZOQXl9gqRRtaGOkZ
        WlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlLDkwlalgv1rFgW/TGRsYm+S7GDk4JARM
        JPYuEu9i5OIQEljKKPHk6Gx2iLiUxMq56V2MnECmsMSfa11sEDVPGSU2nnrHClLDJqAnsXZt
        BEiNiIC5xLpJi9hAbGaBB8wSDb+YQGxhAU+J1pcvmUFsIQEziSfv/jGCtLIIqEr8ehoMEuYU
        qJSY9/giC0iYF2jMz5+GIGFRAUuJLS/us4PYvAKCEidnPmGBmJ4t8XX1c+YJjAKzkKRmIUnN
        AprELKApsX6XPkRYW2LZwtfMELatxLp171kWMLKuYhRJLS3OTc8tNtQrTswtLs1L10vOz93E
        CIzFbcd+bt7BeGlj8CFGAQ5GJR7eA3+WxQuxJpYVV+YeYlQBGvNow+oLjFIsefl5qUoivE5n
        T8cJ8aYkVlalFuXHF5XmpBYfYjQF+nIis5Rocj4wfeSVxBuaGppbWBqaG5sbm1koifN2CByM
        ERJITyxJzU5NLUgtgulj4uCUamD0zL48L/TPGuuwS2s8jY12PZwq4q60e93zvyU3XgkcfzX/
        9pV3Jmy7/k79mL/wcXbvCn6HEyU+c4OTJP7amteH3ptX13xN8vWdH9rGKrMYu/say/f63Hr+
        x0du/YbIDPmjE2WmrFLcv8A6XjxOUWJrzdosyySzkz5vBC/JF+4VmGPXt6/DP/S1EktxRqKh
        FnNRcSIAXyHZZOcCAAA=
X-CMS-MailID: 20201109194725eucas1p2cc9357486879a14b2ad2f6ef968ff4b2
X-Msg-Generator: CA
X-RootMTR: 20201109194725eucas1p2cc9357486879a14b2ad2f6ef968ff4b2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201109194725eucas1p2cc9357486879a14b2ad2f6ef968ff4b2
References: <20201109190245.GL4077@smile.fi.intel.com>
        <CGME20201109194725eucas1p2cc9357486879a14b2ad2f6ef968ff4b2@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2020-11-09 pon 21:02>, when Andy Shevchenko wrote:
> On Mon, Nov 09, 2020 at 07:18:37PM +0100, Lukasz Stelmach wrote:
>> It was <2020-11-09 pon 19:24>, when Andy Shevchenko wrote:
>> > On Mon, Nov 09, 2020 at 06:02:29PM +0100, Lukasz Stelmach wrote:
>> >> It was <2019-11-07 czw 20:22>, when Dmitry Torokhov wrote:
>
> ...
>
>> >> I am writing a piece that needs to provide a list of gpios to a
>> >> diriver. The above example looks like what I need.
>> >
>> > Nope.
>> >
>> > It mustn't be used for GPIOs or PWMs or whatever that either should co=
me via
>> > lookup tables or corresponding firmware interface.
>>=20
>> May I ask why? I've read commit descriptions for drivers/base/swnode.c
>> and the discussion on lkml and I understand software nodes as a way to
>> provide (synthesize) a description for a device that is missing a
>> description in the firmware. Another use case seems to be to replace (in
>> the long run) platform data. That is what I am trying to use it for.
>
> Yes. Both are correct. They are simply not applicable for everything
> (it's not a silver bullet).
>
>> I want my device to be configured with either DT or software_nodes
>> created at run time with configfs.
>
> Okay.
>
>> My device is going to use GPIOs
>> described in the DT and it is going to be configured via configfs at run
>> time.
>
> How is this related to swnodes?

I thought I should mention it, because as far as I can tel mixing and
merging information from different fwnode backends seems to be tricky if
supported at all.

> Create GPIO lookup table.
>
>> I could use platform_data to pass structures from configfs but
>> software nodes would let me save some code in the device driver and use
>> the same paths for both static (DT) and dynamic (configfs)
>> configuration.
>>=20
>> Probably I have missed something and I will be greatful, if you tell me
>> where I can find more information about software nodes. There are few
>> users in the kernel and it isn't obvious for me how to use software
>> nodes properly.
>
> gpiod_add_lookup_table().
>

Yes, that is exactly what my POC code does now. But having a lookup
table together with the rest of the device structures has several
advantages.

1) The device may be hotpluggable and there is no
   gpiod_remove_lookup_table().

2) Having the lookup table allocated and managed together with the rest
   of the device seems like a better way to go than on gpio_lookup_list.

3) As of now I've got a minor issue with device naming. I need to set
   dev_id of the table before the device is ready and only after it is
   ready, its name is set (in the hotpluggable use case).

4) Because no other devices would use this lookup table "publishing" it
   rather than keeping together with the device seems at least slightly
   odd.

When the lookup table is attached to the devices and can be passed
around  the final lookup can be done with a function like

static struct gpio_desc *gpiod_find_from_table(struct device *dev,
                             const char *con_id, unsigned int idx,
                 unsigned long *flags, struct gpiod_lookup *table)

>>>> At the moment the driver gets the list from fwnode/of_node. The list
>>>> contain references to phandles which get resolved and and the driver
>>>> ends up with a bunch of gpio descriptors. Great.
>>>>=20
>>>> This example looks nice but does the code that reads the reference from
>>>> the gpios property and returns a gpiod actually exist? If it doesn't, I
>>>> am willing to write it.
>>>>=20
>>>> At first glance it makes more sense to me to pass (struct gpiod_lookup
>>>> *) instead of (struct software_node *) and make gpiolib's gpiod_find()
>>>> accept lookup tables as parameter instead of searching the
>>>> gpio_lookup_list? Or do you think such temporary table should be
>>>> assembled from the above structure and then used in gpiod_find()?
>>>>=20
>>>> Any other suggestions on how to get a bunch of gpios (the description
>>>> for gpios is available in the devicetree) for a device described with a
>>>> software nodes?

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl+pnMIACgkQsK4enJil
gBA/CAgAgRGt51GRc/FwUYLJYpBnpz3zmRlpdawjo+dI3ADXtXLtXXc7JEBhmNi2
NW+2KaILi/e0X/ErBqf9Q0C6I0gcOtvhmRKfZjLUvuJ3Ugn8T5Q/Y1pSRS2ynYGs
D+xWWxdyLhMqHvywaeeufQM9uIJflil0H5nm8YJNXFmP5jl/Xrcgrw9AmGTi9Bve
MtgcT34hTelIyUGp3A7Fqgk6VvKakoh5prSmHTkCM+z12Q3N0P/jGeVyytzU2ClW
T2xta1r8T3YbNaGdVxIpZ3su53bzNezuDDIi8rto0wtiAyx6WPN4Irnx7/jWRMMh
ksGTzZ+Ts5vJfwTuvE+fR2yA+UA1jw==
=Q9Be
-----END PGP SIGNATURE-----
--=-=-=--
