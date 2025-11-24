Return-Path: <linux-acpi+bounces-19225-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 446B2C8254A
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Nov 2025 20:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E5A65349397
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Nov 2025 19:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D296332BF32;
	Mon, 24 Nov 2025 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3k0olT/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2AB17C21B
	for <linux-acpi@vger.kernel.org>; Mon, 24 Nov 2025 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764013715; cv=none; b=RHCt+GiV2/XcZBDZkTZuSPrXmGF0QkZRvHCB3UhlMjrrgP9hOPfA57jQEG2XejL2qNAjHPeJrGBeX/O//ThPX1OJSitHTT2fL3uYv3ukALS2oheth8/Yht6CT56SKHL1eykD1MAk+Ehuv29IdXXL6DLK7kl6voxmLz7IMg9cwHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764013715; c=relaxed/simple;
	bh=sY3rd0HLeplEVC41aDxA7AejzbWgUjGB9NpXAOLR1L4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+M92Hzvy/2n3HdEWdlLMQVS5Aw74t4AtM4nTXfcve4QFweWqUoc+lDfTRmiBGu33LTY3OjU9jMn+F3uxL1UBpR22xHfd1D8vvYx2UkMHVnf01VezV97hxvFQpZjo6R0k3oFv8W3gWEBxFHDk1bQmX4C5EweE/totKvjNksaLfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3k0olT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55959C16AAE
	for <linux-acpi@vger.kernel.org>; Mon, 24 Nov 2025 19:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764013715;
	bh=sY3rd0HLeplEVC41aDxA7AejzbWgUjGB9NpXAOLR1L4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p3k0olT/8rxajtBlogXSRRY/lPMcgXTUa4m4VhK+i5TwxNnW9Z4k2bL7EfyARqY33
	 X0GQlOkD28hZjneynEQeojeTGK+tPoE8fr1Li3sei7/dYZIQGLb0rJ1KNPq/6/1loB
	 oT7ZDv41s/ivbmN2Rq2ndTRhLd6YDcALtqrQuS9bbxTvLjgqHY36tBVL5bLjVURJYs
	 TwF8p+8DpZZZaedsIcLuHyVRGywYH9Oa6MQUcP7EhHJiwmuat0MxhSYcGHcyB6+vsY
	 0a/0W5+VooydJ/n7lLp4P2Cz6k2su5vhSFd3lAshsMazY8+rFUjVHAjZX2RJFJ5t4R
	 BlM+6nc8G6bPQ==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-656b0bd47b8so829004eaf.0
        for <linux-acpi@vger.kernel.org>; Mon, 24 Nov 2025 11:48:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWCkpaZehdIbHEFxkSDvFMT4vNtvVMI3J3/LrV/wUH1jyNr6E5DKei5lm0yYHFNCgr/W794UoeBw61X@vger.kernel.org
X-Gm-Message-State: AOJu0YxwmS4kf2mT+u4jsY7fIVZPyJAjMsSqxIYeKyHjO/f1i8dSf3FF
	adyQjcvQ5Heg1xGAgBn1f/1/qc+bVckWwDgojZ7zpef+WjNnQ2IMknidVEjk6Cb8HnnbvUsPfhT
	W1fYBevOoCf2DDZp6hcdxgsK5ahK+aWA=
X-Google-Smtp-Source: AGHT+IGLSS9U4Votx+vmCmhwlez+Pj59L7x+YU/qZ4G9iwcC3Y9Hq6yxI+jUYzkAwb/Gf/HnmkimHI519A0rHsGoO6Q=
X-Received: by 2002:a05:6820:4dc3:b0:657:17a5:b314 with SMTP id
 006d021491bc7-65791d46c32mr4484922eaf.0.1764013714661; Mon, 24 Nov 2025
 11:48:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119224140.8616-1-david.laight.linux@gmail.com> <20251119224140.8616-14-david.laight.linux@gmail.com>
In-Reply-To: <20251119224140.8616-14-david.laight.linux@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 24 Nov 2025 20:48:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jQwp6dkqaAo+bxzmQJe_3+UDX8_7e0r0=fr1gY59iWZA@mail.gmail.com>
X-Gm-Features: AWmQ_bmlJAvhdPvEHZN3paBeqGwg4qTb25owDbrUB5aBcvfCA-R_3-BOal4pE2w
Message-ID: <CAJZ5v0jQwp6dkqaAo+bxzmQJe_3+UDX8_7e0r0=fr1gY59iWZA@mail.gmail.com>
Subject: Re: [PATCH 13/44] drivers/acpi: use min() instead of min_t()
To: david.laight.linux@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 11:42=E2=80=AFPM <david.laight.linux@gmail.com> wro=
te:
>
> From: David Laight <david.laight.linux@gmail.com>
>
> min_t(unsigned int, a, b) casts an 'unsigned long' to 'unsigned int'.
> Use min(a, b) instead as it promotes any 'unsigned int' to 'unsigned long=
'
> and so cannot discard significant bits.
>
> In this case the 'unsigned long' value is small enough that the result
> is ok.
>
> Detected by an extra check added to min_t().
>
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
>  drivers/acpi/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 43d5e457814e..e427ab24cde7 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1280,7 +1280,7 @@ static int acpi_data_prop_read(const struct acpi_de=
vice_data *data,
>                 ret =3D acpi_copy_property_array_uint(items, (u64 *)val, =
nval);
>                 break;
>         case DEV_PROP_STRING:
> -               nval =3D min_t(u32, nval, obj->package.count);
> +               nval =3D min(nval, obj->package.count);
>                 if (nval =3D=3D 0)
>                         return -ENODATA;
>
> --

Applied as 6.19 material with adjusted subject, thanks!

