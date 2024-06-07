Return-Path: <linux-acpi+bounces-6274-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFCF900DC8
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Jun 2024 00:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE7B1F23A86
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2024 22:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AAD1553BF;
	Fri,  7 Jun 2024 21:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJT8mVM7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556511553B5;
	Fri,  7 Jun 2024 21:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717797598; cv=none; b=rhMV5Jo9pP9lC5Yc3FJyhAh1KBgLrmJod+6ZewHLe0Zx2YvkS2p9Ag2TQ4CNGalIQzsbyEeaiJ/2PzkBMbGhtxDZxaMX3OYYlp3iXQeScFl3Nm1lA1XZFQV1PPU1tEtZVw2AcYlhlxoIzhn3onCAw9CQywwyzSQns9RWYQ3O78A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717797598; c=relaxed/simple;
	bh=y150U5xq5qY1Ynt2HAmIdz9hMVvuRo0oKK6kNH1FLjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrCBbQ7dN6Mo515j4I8NJuGwkevVK9evmVK5dEaWPJipC9c+vCDfD7SON97ogjXBQNevg0HpF+HtSWgPDz4zrS2T42dRe9mLmZCvHUXDObiIi3R8+lz5kA5/a6A4d22xEFCmfzN+mknDvcMUQQnl7KLKD2XN56oTSzF3kteUPnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJT8mVM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D350C32782;
	Fri,  7 Jun 2024 21:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717797598;
	bh=y150U5xq5qY1Ynt2HAmIdz9hMVvuRo0oKK6kNH1FLjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JJT8mVM71YBv1FMI9RzlTppOqjMlJND79eJH8cwlad6KFykXM53wN05xBPj1mli8F
	 u3d3Ps2qyZDKDaj7uVHV84F+6OFx7d0L3Ozz0ZE4xwaIH/KYVefkKGJl41RvaSffD2
	 XkiYcix09suVmd6Jx//BjrT26l6eFVp9ybyxzWmC3Tw1XS5zOioGI6sy1daRgZkUyx
	 whhj2bWZLMQaXpvRcNqpRPV8JA/gRm+ECx1P98aMLxNUH8A7kblS1Q2MGLJrZEx/pe
	 Ytz3c5oiKl74UpDhW1T4h6CgECPecukhdJjvqioxVnBU1QZNlnmM8/DnPI03/UBi+3
	 P/zsBdr3ODQYg==
Date: Fri, 7 Jun 2024 22:59:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org, tiwai@suse.de, vkoul@kernel.org,
	andriy.shevchenko@linux.intel.com,
	=?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] ACPI: utils: introduce acpi_get_local_u64_address()
Message-ID: <ZmOC2rDhOmxBQ9VI@finisterre.sirena.org.uk>
References: <20240528192936.16180-1-pierre-louis.bossart@linux.intel.com>
 <20240528192936.16180-2-pierre-louis.bossart@linux.intel.com>
 <CAJZ5v0g8aW5FBbceYJDvDrMHRxT6i71O_LTWKALb=qr+m1BJ7w@mail.gmail.com>
 <998d53cf-c22b-4706-93af-ab38802dc531@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LB93vw5p49CVxXfi"
Content-Disposition: inline
In-Reply-To: <998d53cf-c22b-4706-93af-ab38802dc531@linux.intel.com>
X-Cookie: Your love life will be... interesting.


--LB93vw5p49CVxXfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 07, 2024 at 10:33:00PM +0200, Pierre-Louis Bossart wrote:
> On 6/7/24 20:51, Rafael J. Wysocki wrote:

> > Do you want me to apply this or do you want me to route it along with
> > the rest of the series?

> > In the latter case feel free to add

> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> Thanks Rafael. I think it's easier if Mark Brown takes the series in
> ASoC, I have additional ASoC patches that use the u64 helper.

> Mark?

Sure, no problem taking it via ASoC.

--LB93vw5p49CVxXfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZjgtkACgkQJNaLcl1U
h9CzQgf/bzAA0c9gFMT6UUp49/iI3Ki58T1R6v9d85wC7P6o2x7ZxcqY+VTfrGnk
DPCDNhIxHvWMXWlRrl9J1UVSQUt5FatD8+HyD5wRMUsOIbt9Llyow4Inds6vCjhT
eerz25yq4Dp3eNU3xGZLnatDScFONvNVQbKZ6lSkpSojlRIJMipglXmSn9yVAwk8
/p6kY3CbVA/sa98u6DqQQxqH05GkADSTNOSPUXzsXB65yl8wy8wn3nTEAH0thiZc
Fh8ffR/J/k7jKok+h02cIxbTOd6WZ1S7qK783GKhAYrDynLW92KlrajAsFqXxa8B
lihr6cHLXz8kOSWrwD+x6Ff4za8GRQ==
=UueQ
-----END PGP SIGNATURE-----

--LB93vw5p49CVxXfi--

