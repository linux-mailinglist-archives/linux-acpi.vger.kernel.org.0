Return-Path: <linux-acpi+bounces-14618-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E022FAE8BF3
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 20:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9BC4A4C6C
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 18:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C992D8DCA;
	Wed, 25 Jun 2025 18:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bjmELD06"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EE22D5C61
	for <linux-acpi@vger.kernel.org>; Wed, 25 Jun 2025 18:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750874663; cv=none; b=UKjWmCGfCBjQwLbEpyDA1Kk4KghWxkroxbSYmuPbzM4f9kistrPrqr0El4AD1c6HPkm9luncFhsoGm3VCKS1o932ftP1u4jWFprqKKsvKzOY2bkiYA1CghQU8rj7wNKHJbbSuvbYf5jk9bmehDPmbH2SWagLEyVwo2tdT8xdJm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750874663; c=relaxed/simple;
	bh=48xvgcmkUBQs34OE57IapH+u204bYNCW7yP1JTu6HJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5JaxHWKOBMAqao/mwltbsC8U/Rsl78fd/BHqKyehvTTVAAui6G01PYkIOg4EWseHVbczJu/Gc+bqJf471YO1SMPD82m+3gR7g4k8HJdC+sQvB6wKm8ZNN8jhteNCn80JpyKlSdyFtMCR6KPcrN5HhcsSz9fb6Ywzx8tO0QrCwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bjmELD06; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60c63a9bbabso548706a12.0
        for <linux-acpi@vger.kernel.org>; Wed, 25 Jun 2025 11:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750874658; x=1751479458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oihXXsJcdhsaCMLFGzt/RL9o7QBnAbZVpnUdfz0Lgsc=;
        b=bjmELD06kK1+NMtSp33xeh7S9vPiskaTou26P254tBZJzGofTmhDerbLj2uB7OyjT4
         0UMHLbKc7tHFmi71bzriVsGcS/Pkbzt6QbDRaFsO4T7Gl2tfAuIFF8uIzivsnUaCKYrD
         UFysDFsLC0zQxgxEaD7VQNbGyiPhjrhAjSNNhAVYsFzo1K9kOAMV4rXcxodjk4OOjI3d
         pJ8kkg2iSHlVbgYsW1sgPsj1Nxp/aK+fSdeyMXtzDiHdgnJvpdAPLt4VlZAtt7cVjC8K
         juP1A6suOdrzEDqUUnWnfcjPx/AmrB/YQFP9NNd/8mTv9ZnRGjoVGW9LsyLJSfH+9idM
         gWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750874658; x=1751479458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oihXXsJcdhsaCMLFGzt/RL9o7QBnAbZVpnUdfz0Lgsc=;
        b=kIqA7s9+JmfYrq1Q764UF9xNtYQ/XmZB/pZYXsc/FZVw3OZI9Q2P3PFpYPxlmJiBYn
         JBkDwuP9bBq/p1BA9RR5oxOpYjk28aPSK+71GhvbDvvWOq3/kPQniEIW65b9FhqquDe/
         HRSsBs8+FlCQtxE/fE54dmKg93z3CIVXqPcsLOZ3Q1Bq32dFd+ngHF3l3sei8kduEcPr
         HFdtJVfca2FhMF/7xUHeR3VZI+ltSwkzgiiD0JCWTJitNNGYDNRTsdR1y3GKeMo5WOTa
         2CowqDF0NUlTeJjF4Lr1qKIkf1ImZjEKrCoap4UnmYZJlfYc3zmGNQ+Tz9WbLpk7xEJZ
         kztg==
X-Forwarded-Encrypted: i=1; AJvYcCWHzOzVan0A7o164s8MknWPK4xLJbD49J1Md52/zAaA0NBI3G/o9TNfyDHrNuShLtecgjLkLWHhQZhP@vger.kernel.org
X-Gm-Message-State: AOJu0YyajyUBxwqDsx+tpI5QHQTDcjS9UKmYkK8ar1TDfrHvEAj8NKtf
	Y6Peom8hRoz/9uHNchBL2BfBs4asf1C3JKOCBNciZuSys0nX/A3vbNtWIRpA1D7dJ2k=
X-Gm-Gg: ASbGnctMXOJYk2KWe5QicNveYvz22NDz9ldkO5DF5qazqFGmw4nAqAI5yKo+JHOOf+h
	4BoShuL+25/AGZ3ZA/lahsBJyB48YfvV6xERaY169nQ5kJl0+yS9J3IuiMhroX12wmjYTWIz2aW
	+Bsq1IMibSqK0tXXVLvhAm1cRUvzifYbgNeuyi4qGpF/X7b0wY8H5tqBXo8C/pJnGRCVz/vHrmr
	CaeDb5C6MMWFaFsverBLsgCm3X9vw7RRmrkGvVbnq87uS4GiyJDlmXZyXxgtDXFH9mwLqWWQ9R4
	pbrKNKrHxYmvVrtfLgzDK02EDFnWkwG6rpIcAdrX/R8CU13uR+AfCH0DrHMLjaAxf/g=
X-Google-Smtp-Source: AGHT+IHW3xALuLpA0Km8XLLkrjiT9rszCMsd+A5h3Jcrnhiw9gpzJpQq9tRc2bxXPWrW9O0XyeuYHQ==
X-Received: by 2002:a17:907:3f10:b0:ae0:a351:4ed3 with SMTP id a640c23a62f3a-ae0d25435a0mr64606766b.7.1750874658310;
        Wed, 25 Jun 2025 11:04:18 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae053e801c1sm1106130166b.17.2025.06.25.11.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 11:04:17 -0700 (PDT)
Date: Wed, 25 Jun 2025 20:04:14 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Zaid Alali <zaidal@os.amperecomputing.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Ira Weiny <ira.weiny@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams <dan.j.williams@intel.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 next] ACPI: APEI: EINJ: prevent memory corruption in
 error_type_set()
Message-ID: <ks34mfmv2vhwojpxlzv7tyordcjdo6zclcflplvs2wsl6gkbn5@3v5kguelmita>
References: <c71e7ba6-f127-4f49-acbf-20063dd26553@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ptbrymcsrvczjpgn"
Content-Disposition: inline
In-Reply-To: <c71e7ba6-f127-4f49-acbf-20063dd26553@sabinyo.mountain>


--ptbrymcsrvczjpgn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 next] ACPI: APEI: EINJ: prevent memory corruption in
 error_type_set()
MIME-Version: 1.0

Hello Dan,

On Wed, Jun 25, 2025 at 11:34:38AM -0500, Dan Carpenter wrote:
> The "einj_buf" buffer is 32 chars.  Verify that "count" is not too large
> for that.  Also leave the last character as a NUL terminator to ensure
> the string is properly terminated.
>=20
> Fixes: 0c6176e1e186 ("ACPI: APEI: EINJ: Enable the discovery of EINJv2 ca=
pabilities")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: I messed up the sizeof() calculation in the copy_from_user() and I put
>     the parentheses in the wrong place in v1.
>=20
>  drivers/acpi/apei/einj-core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index d6d7e36e3647..2206cbbdccfa 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -826,8 +826,11 @@ static ssize_t error_type_set(struct file *file, con=
st char __user *buf,
>  	int rc;
>  	u64 val;
> =20
> +	if (count > sizeof(einj_buf))
> +		return -EINVAL;
> +
>  	memset(einj_buf, 0, sizeof(einj_buf));
> -	if (copy_from_user(einj_buf, buf, count))

I would add a comment here to explain the -1. It's in the commit log,
but that doesn't help a future reader.

> +	if (copy_from_user(einj_buf, buf, min(count, sizeof(einj_buf) - 1)))
>  		return -EFAULT;
> =20
>  	if (strncmp(einj_buf, "V2_", 3) =3D=3D 0) {

Further down there is:

	return count;

Is that still correct given that you read less now?

Best regards
Uwe

--ptbrymcsrvczjpgn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhcOhsACgkQj4D7WH0S
/k6cJwgAupQfrAOEsCT3Li13xjhy4pAavJR3JfuVMkHXekCQWSrKV5BWXUutetzY
kAvzyw2lhw5PcgwGyDkAfhDZgxdjFBgEB1tQP2YWfOVDDh8xATzfRO+PpkhbDivS
Lg/KJxs2wA5mdO929JhtZcYNrWtPE56bwIiEa7H77nKy5unurir6oAoW/0VcIR9x
EjjVcOHrBFCquVz4psSyHT73cQiQRfoYAuMkrnhyX5fWrEhBkB10S8BdtNMC9hye
NF78T61G/+YAAlKfjaUtzi0obQq8JBov+Pqx4jikfuGKMwEfPkGaz0qDmruhV7PZ
wkyZPbgXuVNP1MYf5c/Jp/oQ+bF10w==
=ezLl
-----END PGP SIGNATURE-----

--ptbrymcsrvczjpgn--

