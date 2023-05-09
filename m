Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2266FC683
	for <lists+linux-acpi@lfdr.de>; Tue,  9 May 2023 14:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjEIMfz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 May 2023 08:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjEIMfy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 May 2023 08:35:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDD71721
        for <linux-acpi@vger.kernel.org>; Tue,  9 May 2023 05:35:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pwMZE-00086G-J5; Tue, 09 May 2023 14:35:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pwMZD-002Ezk-JG; Tue, 09 May 2023 14:35:43 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pwMZC-002m6k-QM; Tue, 09 May 2023 14:35:42 +0200
Date:   Tue, 9 May 2023 14:35:42 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI: LPSS: Add pwm_lookup_table entry for second PWM on
 CHT/BSW devices
Message-ID: <20230509123542.rbtjp64urvwl5ioh@pengutronix.de>
References: <20230509115226.287318-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="42ebuihwwgvq5od2"
Content-Disposition: inline
In-Reply-To: <20230509115226.287318-1-hdegoede@redhat.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-acpi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--42ebuihwwgvq5od2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2023 at 01:52:26PM +0200, Hans de Goede wrote:
> BSW PWM2 is used for backlight control for fixed (etched into the glass)
> touch controls on some models.
>=20
> Add an entry for the second PWM controller to bsw_pwm_lookup,
> so that drivers can use pwm_get() to get a referene to it.
>=20
> These touch-controls have specialized drivers which bind to different
> devices on different models, so the consumer-device-name in the lookup
> table entry is set to NULL, so that only con-id matching is used.
>=20
> The con-id is set to "pwm_soc_lpss_2" which describes the PWM controller
> rather then the usual approach of describing its function.
> The specialized (model specific) drivers which need access to the PWM
> controller know they need the "pwm_soc_lpss_2" con-id.
>=20
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

I don't understand the conditional before the call to pwm_add_table, but
I guess that's ok.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--42ebuihwwgvq5od2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRaPh0ACgkQj4D7WH0S
/k6EOwf/QtIP7YcOwGRmMVMKWzpEBqGZ0X7FIZD8anlh9SGaf0+MVUPHt1zz23CM
2u45X9NShi2FbcMcgEUYSSi/J6vE1KysT/FCL1lcfwwblfQKyhOKHeg+wsHJ8jfR
h+rSKWzb9/zgmW8bJwqsL5JAjaIRFT1w1lgsnHF+fIRD2uK735Xm8uJpq0egG9MC
kLhCSr97RomApoM8vJv66Rjt2Uk88y96EiuH+l3o6L6FELxpqLxf+rvJVQoNvBGx
Q7o0zKzj9TALuFnCmMmZykvu+eUNVl4WIGneyxOXESxbu6h5OIdCkkBFyCGkudSs
y/bfRnrEY7PdpRofG/XrKMLoP+R8vA==
=sD7T
-----END PGP SIGNATURE-----

--42ebuihwwgvq5od2--
