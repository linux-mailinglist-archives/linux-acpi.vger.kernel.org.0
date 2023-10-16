Return-Path: <linux-acpi+bounces-661-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CDA7CAFF4
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 18:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B241F21FC5
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 16:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C0F30F91
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVdNKSrL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8781D55F
	for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 14:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8587C433C8;
	Mon, 16 Oct 2023 14:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697467643;
	bh=DRdrnJg10Y4r+9wXQmc5/yfXdc+PtrcGCHG6+FdzrP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qVdNKSrLH+3IDVW3itVBwVO5W7gIFiEgX9J2wr+WV/Og6LJ7jqD9HLZI/lIrYSmwU
	 2V5rgTk35JPzPNeuO8hOmc1t05//HRfJXB6e2t6rajW6et5Bp//1tcbhlJ/RSRh1yA
	 Zo60kDD//5tEaqjSu6zZUVoRUJxC7gpOExq8P75tZtC9ZV9krJ7EIeWrfpeILEnU8w
	 l8Vwy7bnSFBJ25Kqg2WZ/Uzix3RLToIwB9mWd6lmXD0IfCrkaUU+iCwks9du17ffol
	 qqGLDZg9ERfD4fuYZL5J2Qk8C4STEg4W/bJx76tzTIuJ1bE+fdRaHxuEwap2M6AKlR
	 HgUzqHOgXsRgg==
Date: Mon, 16 Oct 2023 15:47:19 +0100
From: Mark Brown <broonie@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 4/4] platform/x86: x86-android-tablets: Add audio codec
 info for Lenovo Yoga Tab 3 Pro YT3-X90F
Message-ID: <5d777654-4700-46ad-bec2-3921d0b7d0fc@sirena.org.uk>
References: <20231014205314.59333-1-hdegoede@redhat.com>
 <20231014205314.59333-5-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jlne6lNoJTR0ySyH"
Content-Disposition: inline
In-Reply-To: <20231014205314.59333-5-hdegoede@redhat.com>
X-Cookie: If you're happy, you're successful.


--jlne6lNoJTR0ySyH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 14, 2023 at 10:53:14PM +0200, Hans de Goede wrote:

> +	.micd_force_micbias = 1,
> +	.micd_configs = lenovo_yt3_wm5102_micd_config,
> +	.num_micd_configs = ARRAY_SIZE(lenovo_yt3_wm5102_micd_config),
> +        .micbias={
> +           [0]={ /*MICBIAS1*/
> +                 .mV =2800 ,
> +                 .ext_cap=1,

The indentation of this section seems weird - .micbias is indented and
the lack of spaces around =s is odd.  There's also an extra space before
the , consistently on the mV lines.

--jlne6lNoJTR0ySyH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUtTPYACgkQJNaLcl1U
h9CfZAf9GHbQ6wahif1bW+w/xlbkNLRtKO49yLrZ9WoNgv6AXjxFrY6+4udvxOhO
93jiuepZ/Y216CR5SLJ/uzQhsg/VNEqUPKpd/pSRHboBygknSuwtyjRwc05urReO
k/LQK44Jy/Eni1KPV/jWDp+EWK1ZT+8eCB9ciemH06rgbzQSKJodlG32trhtGQUO
+tOg8xTkIHppVBnR89Y6kCRzritu7RLjNSy5zPw9U6a1k76G0ykQam+XAu+5ri6g
JCmjvsC1BI/vxXWNbzIv3RL6TunINhXds2WcCA8Fey5g32hrwZYGC89DKcGkmUPI
nWsPV48aBxa9qMaTaFl3E1sJGGEHsw==
=9A+C
-----END PGP SIGNATURE-----

--jlne6lNoJTR0ySyH--

