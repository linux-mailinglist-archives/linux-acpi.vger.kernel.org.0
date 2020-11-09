Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323DF2AC1A5
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Nov 2020 18:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgKIRDB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Nov 2020 12:03:01 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51653 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbgKIRDB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2020 12:03:01 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201109170249euoutp01911e4f4735f11beadb22b9e11383bdc2~F5awksuJ12808628086euoutp015;
        Mon,  9 Nov 2020 17:02:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201109170249euoutp01911e4f4735f11beadb22b9e11383bdc2~F5awksuJ12808628086euoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604941369;
        bh=Y08gvbLOatBstHo4wfd0WefF/z4J98MAQRzvoDc3/fk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ni3LLMiJxpuooqWl9YnhaA3Kl4WbUjEqICsezpTikHXdud4d+rFCsfgVx3t4QJV5a
         Da/wghSRo0jCs/p0es2dArrklSp9yPuzKilQPpFZUNoGxv/wqiinFbDST/Ia2KEY7U
         MCYxztmDQvi0UAxhunx7DjJGDFEylgTHdew/TGU8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201109170241eucas1p222a9602e93341a41101578d43b845041~F5apN1BFU2645626456eucas1p2n;
        Mon,  9 Nov 2020 17:02:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 58.DE.05997.13679AF5; Mon,  9
        Nov 2020 17:02:41 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201109170241eucas1p14c2156334d8c6ef15d52664fa4776f41~F5ao1pv5l2538525385eucas1p15;
        Mon,  9 Nov 2020 17:02:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201109170241eusmtrp2ec3b2299bf070afa7deea3d3aad2dc8f~F5ao06u0n2666726667eusmtrp2v;
        Mon,  9 Nov 2020 17:02:41 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-c6-5fa976311179
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 55.5F.06314.13679AF5; Mon,  9
        Nov 2020 17:02:41 +0000 (GMT)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20201109170241eusmtip130af573abaa72bf95d603958af0bc52b~F5aoqTjhc0392803928eusmtip1r;
        Mon,  9 Nov 2020 17:02:41 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v8 3/6] software node: implement reference properties
Date:   Mon, 09 Nov 2020 18:02:29 +0100
In-Reply-To: <20191108042225.45391-4-dmitry.torokhov@gmail.com> (Dmitry
        Torokhov's message of "Thu, 7 Nov 2019 20:22:22 -0800")
Message-ID: <dleftjeel2pioq.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7djP87qGZSvjDd5NMLTobZrOZPH/w25G
        i40z1rNaHF70gtGia/VOFospf5YzWSzf189ocXnXHDaLtUfusltM2X6E3WL1nhfMFnO/TGV2
        4PHYOesuu8emVZ1sHneu7WHzmHcy0KNvyypGj8+b5ALYorhsUlJzMstSi/TtErgy+j5tYC14
        J1SxpjmogfEXfxcjJ4eEgInEhWedjCC2kMAKRokZH8sh7C+MEhMuaUHYnxkl/i91gan//HwO
        WxcjF1B8OaPEir4WdgjnOaNEe387SxcjBwebgJ7E2rURIA0iAvoS22f/AlvALPCNWWL9X20Q
        W1jAU6L15UtmkHIWAVWJTyuTQcKcAo2MEhvvlIOEeQXMJVYfYwcJiwpYSmx5cR/M5hUQlDg5
        8wkLxMRciZnn3zCCXCAh8JNd4lTbPBaIO10k1t2+yg5hC0u8Or4FypaR+L9zPhPIfAmBeonJ
        k8wgensYJbbN+QHVay1x59wvNgjbUeLx4gXsEPV8EjfeCkLs5ZOYtG06M0SYV6KjTQiiWkVi
        Xf8eqClSEr2vVjBC2B4S92d9YIEE1HFGiYOvzrBOYFSYheSdWUjemQU0lllAU2L9Ln2IsLbE
        soWvmSFsW4l1696zLGBkXcUonlpanJueWmyUl1quV5yYW1yal66XnJ+7iRGYyk7/O/5lB+Ou
        P0mHGAU4GJV4eA/8WRYvxJpYVlyZe4hRBWjSow2rLzBKseTl56UqifA6nT0dJ8SbklhZlVqU
        H19UmpNafIhRmoNFSZzXeNHLWCGB9MSS1OzU1ILUIpgsEwenVANjicHuc8lpti4z9kz8GFNv
        8OYf51/Br2KTvu+647Hj97Vnb0XEujXuVedduSEvetgiKUA+TWld1yfrr9vaf5cZl+xnZtQ8
        uDdj91lntv1GydkOzJ8/ro2WTzrpfNdy21/W1q7yO6evTp2j/PTXtPrCLumuLWlpO2uDkhSS
        jnuKyLc/9OnzbFdWYinOSDTUYi4qTgQAdcarjG0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xu7qGZSvjDXqOiln0Nk1nsvj/YTej
        xcYZ61ktDi96wWjRtXoni8WUP8uZLJbv62e0uLxrDpvF2iN32S2mbD/CbrF6zwtmi7lfpjI7
        8HjsnHWX3WPTqk42jzvX9rB5zDsZ6NG3ZRWjx+dNcgFsUXo2RfmlJakKGfnFJbZK0YYWRnqG
        lhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZfZ82sBa8E6pY0xzUwPiLv4uRk0NCwETi
        8/M5bF2MXBxCAksZJb4tWszcxcgBlJCSWDk3HaJGWOLPtS6omqeMElN/rWQBqWET0JNYuzYC
        pEZEQF9i++xfjCA1zALPmCWOLZ7FApIQFvCUaH35khnEFhIolvh5tYcdpJdFQFXi08pkkDCn
        QCOjxMY75SBhXgFzidXH2EHCogKWElte3AezeQUEJU7OfAI2kVkgW+Lr6ufMExgFZiFJzUKS
        mgU0iVlAU2L9Ln2IsLbEsoWvmSFsW4l1696zLGBkXcUoklpanJueW2yoV5yYW1yal66XnJ+7
        iREYjduO/dy8g/HSxuBDjAIcjEo8vAf+LIsXYk0sK67MPcSoAjTm0YbVFxilWPLy81KVRHid
        zp6OE+JNSaysSi3Kjy8qzUktPsRoCvTlRGYp0eR8YALJK4k3NDU0t7A0NDc2NzazUBLn7RA4
        GCMkkJ5YkpqdmlqQWgTTx8TBKdXAWLbPwm32N4WZBwvqVmx/ub26Z4q1i5ytzdWvFgtmNH3s
        Zkvpk+BMF+Ph7Hu7LzJ5unTT8nWZknsPR516smfmGuu2BxnzPa4tubo865LfqoTrkeXpvBvT
        VvY2fIx8lvSrsu6iiYLAyuojCd8/W097OGGW7KbvF9fU+38tn/T7Zn3o3wnunlMUDJRYijMS
        DbWYi4oTAZM86yjoAgAA
X-CMS-MailID: 20201109170241eucas1p14c2156334d8c6ef15d52664fa4776f41
X-Msg-Generator: CA
X-RootMTR: 20201109170241eucas1p14c2156334d8c6ef15d52664fa4776f41
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201109170241eucas1p14c2156334d8c6ef15d52664fa4776f41
References: <20191108042225.45391-1-dmitry.torokhov@gmail.com>
        <20191108042225.45391-4-dmitry.torokhov@gmail.com>
        <CGME20201109170241eucas1p14c2156334d8c6ef15d52664fa4776f41@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2019-11-07 czw 20:22>, when Dmitry Torokhov wrote:
> It is possible to store references to software nodes in the same fashion =
as
> other static properties, so that users do not need to define separate
> structures:
>
> static const struct software_node gpio_bank_b_node =3D {
> 	.name =3D "B",
> };
>
> static const struct property_entry simone_key_enter_props[] =3D {
> 	PROPERTY_ENTRY_U32("linux,code", KEY_ENTER),
> 	PROPERTY_ENTRY_STRING("label", "enter"),
> 	PROPERTY_ENTRY_REF("gpios", &gpio_bank_b_node, 123, GPIO_ACTIVE_LOW),
> 	{ }
> };
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

I am writing a piece that needs to provide a list of gpios to a
diriver. The above example looks like what I need.

At the moment the driver gets the list from fwnode/of_node. The list
contain references to phandles which get resolved and and the driver
ends up with a bunch of gpio descriptors. Great.

This example looks nice but does the code that reads the reference from
the gpios property and returns a gpiod actually exist? If it doesn't, I
am willing to write it.

At first glance it makes more sense to me to pass (struct gpiod_lookup
*) instead of (struct software_node *) and make gpiolib's gpiod_find()
accept lookup tables as parameter instead of searching the
gpio_lookup_list? Or do you think such temporary table should be
assembled from the above structure and then used in gpiod_find()?

Any other suggestions on how to get a bunch of gpios (the description
for gpios is available in the devicetree) for a device described with a
software nodes?

Kind regards,
=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl+pdiUACgkQsK4enJil
gBAtoQf+PVFYMyk5VSXcEzxbOfAudd3xzQezGMekETrSzHkWkccYeM6J1qmYZiDd
YZUfignacyP1J3K8DYByXeyz8JpeTyd5wjrI0R4WLr5FFTw6uZuhKjlJqz22+o+l
YPla7v2m3nC0vh6j62c8d4ZVGNliYvbmHKA2Vp1gfiler+SCRQmKoFtkcoGiGDcD
r38D5qLDV8aqd9sCGKgLB2zZQlHzE9F59MKHcD2HBYmnzvyZVmiyTy2CVGd2v/44
i1qqg1V+u5QSrCm5HroAnRjGnzEk/tZyseYCghicg5QCY6+EW9RJ+2VRTMqiLtYC
WY4WU1iS6TccGts+T8OUHb8nMbb6mQ==
=bcdp
-----END PGP SIGNATURE-----
--=-=-=--
