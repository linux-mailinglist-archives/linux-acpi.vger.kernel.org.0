Return-Path: <linux-acpi+bounces-14277-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06223AD4253
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 20:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEF327A3D9E
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 18:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFBD256C93;
	Tue, 10 Jun 2025 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyasEQut"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05A1256C73;
	Tue, 10 Jun 2025 18:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749581811; cv=none; b=ZQ3UTy0PTtXl2fskSugvVkfleAsq0D1lwhUNB5xNU4QYySBINaPogsGEjAtn3USKrt/1r7ioCxq89ypT2RGpbIqFAcGhLnjaQFCJrqEVgMFfoyUy7yqn4KibUs/53Jh36RjjWcOdESPhpiQ47fVTenpAZNrF4I7qg7S2G1c2v3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749581811; c=relaxed/simple;
	bh=pryyr1i31pIjJR6VwtjXcpq4HuW0SJmdaFXt2MAmv1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a0dXwBTTcKrEuOKXqLHcVjXAPVyLrWl4ceXQJO7tlReWZVqj62HtjrnP3QuwBmDvDT1f7EWEYc0syNs8PtqQiwujP8sFy4iY63e9zPZ3KX9YA3GCCBrvgKkigTHTXjPukAve0qPqsxOL6lFiKqoU5CMM8cVYWHKKVSumAxVbQdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyasEQut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D26BC4CEED;
	Tue, 10 Jun 2025 18:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749581811;
	bh=pryyr1i31pIjJR6VwtjXcpq4HuW0SJmdaFXt2MAmv1c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dyasEQutnFNsEmCY6adDQlSZkSb6OjTjnTKxJ0h4MGWrtKUX6Cu8IVfWzNbW18bkC
	 HWxNUFhf+lGTdXTLV6ptAc+2mXAPlkc/0ofhT4RDvLh+B99eTCtlZH5gxYKZtgibsa
	 lvFJyTzRAQbXcXqWw0Udkl+8OYC9Ji/Stnm4zNi/F++VsrW+cMPB0n/bA0Pc9vyNMK
	 F+UrX/I7tqsbINQ1J7jG4aB8PmYonengdwv1UdmfZceJLLEHlT921etli0TVFcnC88
	 L6f0UmXhxrnzFXIZH6Y1LCMNeM0Qo5Bq5Ru7exBEkSQRQXBdxE18yUeMEfijG4WLK9
	 LvfuIbcVw3OSg==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2e9071e3706so2944615fac.0;
        Tue, 10 Jun 2025 11:56:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/lj6IvifAXohyQfGnX43DhwSP6bkktYUICBm7UJq+YA6K4gdKE5/vNXh8A1uM3nEmVGJxp1FLpvUk@vger.kernel.org, AJvYcCXXOTDnD+xKAGGOe4dKoaGu/EWT4suGxtZleycWn9kZaQhu/vWH1nnSX35vmzz0CzYpoLyU5a2qxyln+/OF@vger.kernel.org
X-Gm-Message-State: AOJu0YwFA5ZffFGUWWaSGyzQ1VJPS0xAVDLgKKeAqQs7Xdt8ugnE1PwB
	s0qtB7nMkeavfsPv8I4zApe6gpnCMPDOfrIE9Tx6/QzkR3BHcpwc6XinNbkBY7IoQsbGKHf9NCO
	Yca3b2cXoNi+kLUJOPWPfKY2oxQzJVmA=
X-Google-Smtp-Source: AGHT+IEiqMAs3VwBo4z5rbrJ77CuOTpPixo7IesmIBEY9g9gMK/j0uqLTF5wWCFJW4wUxt+rxTVjBwh3+CHxEGEYw8o=
X-Received: by 2002:a05:6871:2d06:b0:2bc:7d6f:fa85 with SMTP id
 586e51a60fabf-2ea96cc229emr307395fac.16.1749581810329; Tue, 10 Jun 2025
 11:56:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529235310.540530-1-W_Armin@gmx.de>
In-Reply-To: <20250529235310.540530-1-W_Armin@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Jun 2025 20:56:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iWS=tHAuauHNHb+N9_GjJTX2-RY01eAS8-sjS_2UZaoA@mail.gmail.com>
X-Gm-Features: AX0GCFudS5db3IvFItOfoZb8IDBDd4WIt62v3pF3Er-HjcfbRdESTlpHy76SWTY
Message-ID: <CAJZ5v0iWS=tHAuauHNHb+N9_GjJTX2-RY01eAS8-sjS_2UZaoA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: EC: Ignore ECDT tables with an invalid ID string
To: Armin Wolf <W_Armin@gmx.de>
Cc: rafael@kernel.org, lenb@kernel.org, glpnk@proton.me, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 1:53=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote:
>
> On the MSI Modern 14 C5M the ECDT table contains invalid data:
>
>         UID : 00000000
>  GPE Number : 00        /* Invalid, 03 would be correct */
>    Namepath : ""        /* Invalid, "\_SB.PCI0.SBRG.EC" would
>                          * be correct
>                          */
>
> This slows down the EC access as the wrong GPE event is used for
> communication. Additionally the ID string is invalid.
>
> Ignore such faulty ECDT tables by verifying that the ID string has
> a valid format.
>
> Tested-by: glpnk@proton.me
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/acpi/ec.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 6f4203716b53..75c7db8b156a 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -23,8 +23,10 @@
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/list.h>
> +#include <linux/printk.h>
>  #include <linux/spinlock.h>
>  #include <linux/slab.h>
> +#include <linux/string.h>
>  #include <linux/suspend.h>
>  #include <linux/acpi.h>
>  #include <linux/dmi.h>
> @@ -2031,6 +2033,21 @@ void __init acpi_ec_ecdt_probe(void)
>                 goto out;
>         }
>
> +       if (!strstarts(ecdt_ptr->id, "\\")) {
> +               /*
> +                * The ECDT table on some MSI notebooks contains invalid =
data, together
> +                * with an empty ID string ("").
> +                *
> +                * Section 5.2.15 of the ACPI specification requires the =
ID string to be
> +                * a "fully qualified reference to the (...) embedded con=
troller device",
> +                * so this string always has to start with a backslash.
> +                *
> +                * By verifying this we can avoid such faulty ECDT tables=
 in a safe way.
> +                */
> +               pr_err(FW_BUG "Ignoring ECDT due to invalid ID string \"%=
s\"\n", ecdt_ptr->id);
> +               goto out;
> +       }
> +
>         ec =3D acpi_ec_alloc();
>         if (!ec)
>                 goto out;
> --

Applied as 6.16-rc material, thanks!

