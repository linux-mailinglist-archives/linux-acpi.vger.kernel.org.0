Return-Path: <linux-acpi+bounces-11719-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A314CA4BED9
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 12:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B5616744F
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 11:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF53E1FBE85;
	Mon,  3 Mar 2025 11:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtHyLO03"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336A51FBCA6;
	Mon,  3 Mar 2025 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001656; cv=none; b=SL3qrAt7irPBKhoXB3JhluKKLobKo+zZ9UAUDyUhW+Eozc+fQGUad8b5VNAk7FqmwF98qqV5WLvNaxSHzZ3MuEq5blkdh4N0DEwmUJiFJBXcMjUHD77BJZEhUYb9meXnOVsbw7wlvqiGCR7Tsg2TTtRU/5BikEQUsVnl5HUparM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001656; c=relaxed/simple;
	bh=h/6aNDKIJEJax3YQY4YtbeLa1xekm6VvSIFc00ga2qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjqdfL4xdG+Jy82vmxx0U5OZ2+wu+V6kvN2iYK4YtaPFdX1AM50RdEcrK/7SkP5eQHssfw2S/l/V4DF+DkHG7j/FdKm+XZuWFKlcz7JD1bqdb4gjFRp5/yAL9Mouhl06eqffo/AalbFRQA1AiholJuWbNz1nDLor7fVOBnJw8vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtHyLO03; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30615661f98so45009581fa.2;
        Mon, 03 Mar 2025 03:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741001653; x=1741606453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jKyByvqg+jAL9PKNdpeqdSWpvScxjw4N93b4UfEb/Uo=;
        b=YtHyLO0357ECTGFU22Up8x85UJV4NccqO2ot5RpmvHfIPZ3vvnrXJXeWuvH0Y83c0j
         vDzYQjj3Vu7e9vE8pD86bwSQ52XKgbgblv8hN0lYcDNpx8AKWVt18gUW3PjKBCuyLtJc
         xDmrQAktlv31L6f6rSG6CRyBAl26GxvCCWCfu0TDwnItIPIXy5Es01HjrGlFC5OB9nNU
         1Z6W5BmobOIplVYoodfBNtNlBcxp+UrYNBxykmc56WEMcsfCE7JdWLIrpQ2qjJrhMw/4
         ERCfqG4I2Un9Ene8LGq87OLauDH1L2F2yxgjrVI0PmpKJB+NhUMlspnU7tSVKowMU7CY
         MBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741001653; x=1741606453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKyByvqg+jAL9PKNdpeqdSWpvScxjw4N93b4UfEb/Uo=;
        b=k6EQ7q0zetGUI/555PRqH2gjr191Kzn0t0GmkI/e7qOFKNX3DrFfC0I56xI62K972d
         piyNAyGB2lnnHCAwdW+9Dmo4OJ4Ntkg1AvcIr6XrSZ2L8I4MawgRkNegkF0hUKYVh5Lz
         7w+flSPp/H+en5bLzlf8bhUj4Pmiaixqr+RwVbgFqbfZ6vsy5in9nJQ56OCJdqWf9uUr
         OMRs70Brgp8yQJ53Z+Z5OFjNOh2K6Xc9u1BlVmSvJUNerD0/S6+RrVXn3YY+xfA4sWHJ
         h9vfSWNyqmZs+TM0CvUyxvnImBjXcl/GMFi+R10xLGQ9x+lc1WvtaJFJsXsaqOGIeJr9
         72rg==
X-Forwarded-Encrypted: i=1; AJvYcCV631R08IpNvPcBxg+9IMIJ5u/GB3wJZTDY3AkMkRJMS1G2KpcH5q1EOcAGItKcaSF4CMGgE7YQKbAwEu980WG0T0U=@vger.kernel.org, AJvYcCVbbkbKWHL3bqDhxp6wCOEJQ9qI0OhmeHlXqErvvDCPOGC+6C4s4woa8MuH6xckjrGTJMXi332XMhd4@vger.kernel.org, AJvYcCWJyIR02SyElbjgmEBH+WW5F2+fUyiLKu37jGmplrPOYY8/QWchAF2KQ1iZ++ZeCJbc+B8Uu41n8xm+Lg==@vger.kernel.org, AJvYcCWToZiGzVrgaBEL1eyPnyF6/ezpNF/mcrtJNaiXzMAELupn3xwq2e4TeOcHFwNmQPYE0f1arh2ax8P26cwH@vger.kernel.org, AJvYcCXA5vgkNQlQc7KLPxPnBN2lx8vZ/wn5C0H26nZ+1+kEGPXiBfJORVKhPUPiP+mQ3wQb5HnP5pjKmOrA@vger.kernel.org
X-Gm-Message-State: AOJu0YzgzoiniqZGGCdPNS5L1npXo+wc6V/M+XtlOnAPhWDWCSjvTPI3
	8PGaheL5A4J2jrfVIk+tu37p6ahV9fNSh9UUqzFn4JbNmGXppxqK
X-Gm-Gg: ASbGncu7haFeXXOgJcaB2VdkAH8CjYLEVLRMyGOsnB6XymcSsz414jORsB+yk7Cn7Tt
	xco+h2H+J8oN5eltI8MXjQ0LuAoD50irpO9zJGQ3bxbyZZFofV+IKuw8OAx+9OQsGEl9S5mTRrL
	FSxWN3gVqTWWIqQeUTXwt8zlchbvhfvlWz98MmjNQZY5fTb5RcKzRqgPPYDYviZZnkRusT8T003
	mpM5ynOlMUrhMjnk6xki08udKgkk1fBdFNkiOKCjR+x2Dcd91kYd/nL53B05KFVzis105jlmAqe
	jilsYjxsQaBZTsf3IoKpGwve01Qn4yzQrAPtWeh2l3K1J44inYSHfUSGzetoUUmizFdFqHUpcy1
	pMD7MqRODbhc=
X-Google-Smtp-Source: AGHT+IH2q/EQ50OKDdOvQmK3DgcD8QV9qiZg9HjaiRlsRxpoAX3Icmu9TOCjXHgkc5dFCtxPesT+sQ==
X-Received: by 2002:a2e:9515:0:b0:307:dc1f:e465 with SMTP id 38308e7fff4ca-30b9326b162mr42530121fa.22.1741001653116;
        Mon, 03 Mar 2025 03:34:13 -0800 (PST)
Received: from mva-rohm (mobile-access-2e8451-125.dhcp.inet.fi. [46.132.81.125])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b86875b76sm14035841fa.91.2025.03.03.03.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:34:12 -0800 (PST)
Date: Mon, 3 Mar 2025 13:34:06 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v5 08/10] MAINTAINERS: Add IIO ADC helpers
Message-ID: <78c18b224cd18b1bd83eea51c7e52dcea28e3d50.1740993491.git.mazziesaccount@gmail.com>
References: <cover.1740993491.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5Rvc/P61F8vV1THI"
Content-Disposition: inline
In-Reply-To: <cover.1740993491.git.mazziesaccount@gmail.com>


--5Rvc/P61F8vV1THI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add undersigned as a maintainer for the IIO ADC helpers.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
RFC v1 =3D> v2:
 - New patch
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e0736dc2ee0..5b96fb864227 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11208,6 +11208,13 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/rc/iguanair.c
=20
+IIO ADC HELPERS
+M:	Matti Vaittinen <mazziesaccount@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/iio/adc/industrialio-adc.c
+F:	include/linux/iio/adc-helpers.h
+
 IIO BACKEND FRAMEWORK
 M:	Nuno Sa <nuno.sa@analog.com>
 R:	Olivier Moysan <olivier.moysan@foss.st.com>
--=20
2.48.1


--5Rvc/P61F8vV1THI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfFk64ACgkQeFA3/03a
ocUpgwf/SNY3Pn6d3XX6wgquUJWMeNypZTRBxzVX+t3Nm+6wYifiTOOpcNdIYHfV
UEO/B8hbJ6BzXcUxHFFEUnq5pTr/a1gbQvg+rtBnZiXV95/wnLJjJgx9guw7IW48
BjUoZhymuhP201Y3/EzSSXwe7MnrOTaUfcTwBxZQSsipdd8PK9co9V1EzEGGIeO+
LqTyj2W1KqdWOE5qqnTZhzLj3fdEYfJoxyUdXWiHJEcmDyoc9qZ0HNnsLa59j5Co
d+8xCLwqyB6CFOJWkl7gL/92nAyFvn1XzEvpuQGyz2Ouoo1cZexz/6s+UvexWkuo
Hh1QZj0U9ni99bqIrOfrEk7zUk5lMQ==
=gikD
-----END PGP SIGNATURE-----

--5Rvc/P61F8vV1THI--

