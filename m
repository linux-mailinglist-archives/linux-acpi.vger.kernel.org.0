Return-Path: <linux-acpi+bounces-10900-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF63A29AEC
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Feb 2025 21:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69E14160CF0
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Feb 2025 20:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4A521D58D;
	Wed,  5 Feb 2025 20:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbaX20jb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835B821C9F4;
	Wed,  5 Feb 2025 20:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738786268; cv=none; b=jOoZHHqW2ggz74ZFR8+sHaD9q1cohUphJGhWo04xJ5v/xBcdTiSwBQcpDy5OT4Ab88JUt6MPOtjMMK1nkQx+sFkHqE0JlaNioPHX4M3sM50ihJ1M6/fG9Zx2arU+PUqByPjF7zG0aXESRSWvUFEQaq81pwust+XhaTdtLvzfiIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738786268; c=relaxed/simple;
	bh=9a7UioTVaxHTaOU4ZCX1Thsww93p8RmrWV73B+lK1Kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7X/qkmObnZP365cFbpWY9QNWiP50QrZSRuPZvoidcrgT5ePJmNEyKyy2aZR1zAxXVe/wxmshcVkyugq6dXLRBUT1dG1l1N1MoET4R6U3nESuVhTVteoAs2tddyTStMP6pZSqyTfZBIWkABZmK5/82gIZGxIpc83i9eWzd7TIUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbaX20jb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5B1C4CEE2;
	Wed,  5 Feb 2025 20:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738786268;
	bh=9a7UioTVaxHTaOU4ZCX1Thsww93p8RmrWV73B+lK1Kk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YbaX20jb69QW9712DGeaRktPyYTLbjGvUIeHEnQJjxvje2RXQYJQ7jmOfeEjyHR6s
	 4ksGqB36ar0hkqXsZQhIWs5oZu43nJe9qNqeNZ+lxTQOmjlpBOPUV8Q4QTaavZSfIF
	 yx8HvCtY/KN5KdM/Ke1G3obuPCQehan72WzNyQWjLG06siVQmbwwGrPLNp8zKyYXHT
	 g+FZ2Yx3TPEzL0A4887/nJ8s8sE0xpaDz+HN/SQIiSwFMdsN5VBZrnyOZ0ycGHNana
	 gX905bkuUcAiKBW+bPNrVzsrlhwk/thz8/86mNxkE0cgjK4mcy8O04zhQ+8BDsRo/R
	 raa6q/H65C6mA==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3ebc678b5c9so108022b6e.3;
        Wed, 05 Feb 2025 12:11:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXZhtDIq6LBaqmI9P/TS3P7PNq0AmlPwN9hFcI4vqO1pebW9R96P2OHBVbIb9Ln4UDOHFb7zfYahX2RM80=@vger.kernel.org
X-Gm-Message-State: AOJu0YymHeyz6qO47h78Db/3asuRel+O8vNlfolbBLeru2cmx8oGC9Rf
	Jk7eSZKLzGJiaTBqb2jbWTwi0YH0TsOckGRS6/1E4LhiKnJI+0qnFQtKM5dwe2DSj24SkmNKdW8
	5jqnDTMAft7lBsW8VyGrUTGSC+Zk=
X-Google-Smtp-Source: AGHT+IH3wnWfxZRWb/zSgQ3nBGQosJZpmsv1OqAeGH25zYt8qfzjjEFNXvT27hs1V/QMRpSA5kjheYzCgtw9qY8vjDI=
X-Received: by 2002:a05:6808:4495:b0:3ea:5413:1a24 with SMTP id
 5614622812f47-3f37c0c8dedmr3272201b6e.13.1738786267435; Wed, 05 Feb 2025
 12:11:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203194629.3731895-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250203194629.3731895-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 5 Feb 2025 21:10:56 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hr0W+MPFw99-TEf1_Lw6cb2gv3ScL06Jd8rZh06phgow@mail.gmail.com>
X-Gm-Features: AWEUYZnUzJzHOUSIHC56AjJNqA-mcuwnwChvyv-JqDxZTeMxXOQcYAjFO0P6Fnw
Message-ID: <CAJZ5v0hr0W+MPFw99-TEf1_Lw6cb2gv3ScL06Jd8rZh06phgow@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: property: Fix return value for nval == 0 in acpi_data_prop_read()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 8:47=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> While analysing code for software and OF node for the corner case when
> caller asks to read zero items in the supposed to be an array of values
> I found that ACPI behaves differently to what OF does, i.e.
>
> 1. It returns -EINVAL when caller asks to read zero items from integer
> array, while OF returns 0, if no other errors happened.
>
> 2. It returns -EINVAL when caller asks to read zero items from string
> array, while OF returns -ENODATA, if no other errors happened.
>
> Amend ACPI implementation to follow what OF does.
>
> Fixes: b31384fa5de3 ("Driver core: Unified device properties interface fo=
r platform firmware")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/property.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 1144c2368d89..7d7f4974c5b1 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1189,8 +1189,6 @@ static int acpi_data_prop_read(const struct acpi_de=
vice_data *data,
>                         return -EOVERFLOW;
>                 break;
>         }
> -       if (nval =3D=3D 0)
> -               return -EINVAL;
>
>         if (obj->type =3D=3D ACPI_TYPE_BUFFER) {
>                 if (proptype !=3D DEV_PROP_U8)
> @@ -1214,9 +1212,10 @@ static int acpi_data_prop_read(const struct acpi_d=
evice_data *data,
>                 ret =3D acpi_copy_property_array_uint(items, (u64 *)val, =
nval);
>                 break;
>         case DEV_PROP_STRING:
> -               ret =3D acpi_copy_property_array_string(
> -                       items, (char **)val,
> -                       min_t(u32, nval, obj->package.count));
> +               nval =3D min_t(u32, nval, obj->package.count);
> +               if (nval =3D=3D 0)
> +                       return -ENODATA;
> +               ret =3D acpi_copy_property_array_string(items, (char **)v=
al, nval);
>                 break;
>         default:
>                 ret =3D -EINVAL;
> --

Applied as 6.14-rc material, thanks!

