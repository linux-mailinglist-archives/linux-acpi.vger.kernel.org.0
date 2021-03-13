Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7CE339D8D
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Mar 2021 11:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhCMK0R (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 13 Mar 2021 05:26:17 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:48398 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhCMKZr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Mar 2021 05:25:47 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 6FA8B1C0B81; Sat, 13 Mar 2021 11:25:45 +0100 (CET)
Date:   Sat, 13 Mar 2021 11:25:45 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     chris.chiu@canonical.com
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: video: Add missing callback back for Sony VPCEH3U1E
Message-ID: <20210313102545.GB11435@duo.ucw.cz>
References: <20210312032430.13664-1-chris.chiu@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
In-Reply-To: <20210312032430.13664-1-chris.chiu@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2021-03-12 11:24:30, chris.chiu@canonical.com wrote:
> From: Chris Chiu <chris.chiu@canonical.com>
>=20
> The .callback of the quirk for Sony VPCEH3U1E was unintetionally
> removed by the commit 25417185e9b5 ("ACPI: video: Add DMI quirk
> for GIGABYTE GB-BXBT-2807"). Add it back to make sure the quirk
> for Sony VPCEH3U1E works as expected.
>=20
> Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
> Reported-by: Pavel Machek <pavel@ucw.cz>

Thanks for doing this.

Reviewed-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,						Pavel
--=20
http://www.livejournal.com/~pavelmachek

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYEyTKQAKCRAw5/Bqldv6
8iQAAJ92pk4aBTA1Dpsj2oO9tUkO/zBAoQCfRCuRYN+WqiliXsRzIzEZW3wqqr8=
=iDmB
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
