Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC42242BEF9
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Oct 2021 13:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhJMLgN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Oct 2021 07:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbhJMLgG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Oct 2021 07:36:06 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB9BC061570;
        Wed, 13 Oct 2021 04:34:03 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 11BE11F4428B
Received: by earth.universe (Postfix, from userid 1000)
        id 4AC473C0CA8; Wed, 13 Oct 2021 13:33:59 +0200 (CEST)
Date:   Wed, 13 Oct 2021 13:33:59 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@collabora.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        krisman@collabora.com, pgriffais@valvesoftware.com,
        hdegoede@redhat.com
Subject: Re: [PATCH 1/1] acpi: battery: Accept charges over the design
 capacity as full
Message-ID: <20211013113359.redeyos4bc4p5pen@earth.universe>
References: <20211008030529.223682-1-andrealmeid@collabora.com>
 <20211008030529.223682-2-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l3zfvcjemxnaeug5"
Content-Disposition: inline
In-Reply-To: <20211008030529.223682-2-andrealmeid@collabora.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--l3zfvcjemxnaeug5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 08, 2021 at 12:05:29AM -0300, Andr=E9 Almeida wrote:
> Some buggy firmware and/or brand new batteries can support a charge that's
> slightly over the reported design capacity. In such cases, the kernel will
> report to userspace that the charging state of the battery is "Unknown",
> when in reality the battery charge is "Full", at least from the design
> capacity point of view. Make the fallback condition accepts capacities
> over the designed capacity so userspace knows that is full.
>=20
> Signed-off-by: Andr=E9 Almeida <andrealmeid@collabora.com>
> ---
>  drivers/acpi/battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index dae91f906cea..8afa85d6eb6a 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -169,7 +169,7 @@ static int acpi_battery_is_charged(struct acpi_batter=
y *battery)
>  		return 1;
> =20
>  	/* fallback to using design values for broken batteries */
> -	if (battery->design_capacity =3D=3D battery->capacity_now)
> +	if (battery->design_capacity <=3D battery->capacity_now)
>  		return 1;
> =20
>  	/* we don't do any sort of metric based on percentages */

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

--l3zfvcjemxnaeug5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFmxCEACgkQ2O7X88g7
+po9MA/8DG1oHhbWjKEt8+SGlUNplGL9I/lEEtFf/SvxzUeFo9SPoSZ5NIURuftr
VQWRf47Loiz4KaTv9iSJvBixnw+TeS76hHj+AX/C0V1TYv2nHf3A9emP0Ux3liA8
c75TlWWtNrtgxmnTSqkGcvhIAGNHgtZonvckwOb/oVMlO+xXg5o6qvvl31VkoxZe
ZzSuwGJD8oqpEHpBoGbmPJSd7sl2ihdiDau379aQVX9r5fzQ1C+ta1rj5K/RuuQt
hXOhRDv4aZtvsOIkJ8lp6KoVEh5Sl1SbxlSP1GxP6VaTrMzEodi+Tr8nW73cuzij
93ED0RGUYZPzj+TNT+VNgNgbLFNBstzfghxDbQJFYD4kLJIaYDuKaqJ0o2/RSMqS
JMRbRa4xf3opsShE+eW0byKxviWr8SpU9hxyWI33nEdt1n2yLZj7YtpEAG9G/KTC
ovYxwLVO4Xnoe/0bUd1Ls1oQHHIM9EFLFjHKkkCQfUxhAhuJzoQ5FF4L5KMJcfAx
5w/RFcfqDXWWeCanpL7zvHmXaqBCDCXqo4poZUnmdf8ZWk5hWawjwqN/BqdXPb/F
j6JHQg9U6zN75UHhHHllO8oEpc4skXxDvXgteYvvoFEFIQmn5VbHoEsggV7uoHOq
q/omd8xLtWHued0KP7kfEwvYCn1aF8MATbIxE0lk0Dq3xuhs6KI=
=5+4P
-----END PGP SIGNATURE-----

--l3zfvcjemxnaeug5--
