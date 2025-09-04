Return-Path: <linux-acpi+bounces-16382-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC27B44629
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 21:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36005AA20AE
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 19:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDB826463A;
	Thu,  4 Sep 2025 19:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfoHF/ho"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBCD2417D4;
	Thu,  4 Sep 2025 19:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012929; cv=none; b=GQKj0U3w14cLmVFU3/7sG06AJSF3V6GhlE1gonAOL3Kv2TGnFttkAdEgNWnAk3C1r8wMxZcu9hQAqk8N5mphUq0cRyU390/ppEnverCFeDKxRgyBC2LhAc2CCxnar1oCOnnvjckT/AjPF61VCZbHu/3xtWmxtLEnerMiNFvDcOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012929; c=relaxed/simple;
	bh=t+c0v2ur5TLaW4XhXaB4CR45lCrauYfOCz2+q4bGReU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBBhNe+LpfDnKeisjpi/fJZaWdJkFAYQiMt40ezcr6k5MFVODYNhSyQHn7LhxVgj8MBs4IoyXGfvDBTlnTRMfQ/Fu6sbRMD390LFFd1p2w4Kl453zXR99n1CH7OEZ1wiPZCF5ILl+xBmA+xbkrlikKJkotubh3Yrsk8DVMpIr/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfoHF/ho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC25C4CEF0;
	Thu,  4 Sep 2025 19:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757012928;
	bh=t+c0v2ur5TLaW4XhXaB4CR45lCrauYfOCz2+q4bGReU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pfoHF/hoADW0pe8O/bGGGd2a0LhFzVNs0NDfuLyFdBmDB85IOoTOEfV5lsbqz7cfU
	 7yCGSwq6lpiDtFEOr+iy/vwhTgKrH8pFcycJIgUw/y1HFDNnv8kAX8fmQ0iYLof7/f
	 Vnpto91YW3QYUj581K/5rgy8sv7aAhPzZbdm8Mq3mUH2ItBRlocibrHqLc0UK79FHZ
	 ryWYNVAYFZxXRYFloNK1+1E7Onfjn5w8mvzHFhbrz2C95RnVnLz2+k56a2kPQcA9kp
	 3slY5fuTvbaaKDVBknIQHPdG4BeKDSOA5M5nYqzXwB1eSpvZdZJ/o7A5aaGHUQKH2/
	 ViCi0X8s8MBhQ==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7456d2b49f5so860313a34.0;
        Thu, 04 Sep 2025 12:08:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUF7WBEBYfGwvLqEX6jHOBUw0oe055XNq9Yhk+xDxAomIMB9oUvemHJRVKYcZlHXiuFjWxmx9orYe3F@vger.kernel.org, AJvYcCV8aRU/jY3YY4WKv9I86I2voXhj/padNGYA9V2BHU8ptyioqesa7raYbC486SC1CD8drbWcpT7XirRgUDPB@vger.kernel.org, AJvYcCXK40L4qUwPRFDELgkFHTBF4+FsyfJpXI29SAahyNige8U7H2dw4c2WpAkWu9zLacAfVYr1PM+zx7mK@vger.kernel.org
X-Gm-Message-State: AOJu0YzH2QB8hoirJzi+C4LGBVb3MUBNjKErh3Qj4ohXyuSaufz4Oxmf
	x/0Ffqu+5EVprTC07n/gJf8jZvXGEPUU5ou0zRdP4Q6JlMKLpxMu5jmjkp68kkHTOVBOU4DUC5N
	ITPkZnamBY/xDIdFcxKhzm9zRpa1ggvw=
X-Google-Smtp-Source: AGHT+IHNgDNQOE0rAXRLs65sHYP8dJkh6/SkGrwmDaRfsiYWq/8taut6vhsUcqBrE5ugz4uHHzjukMlsQzCco9VsHN8=
X-Received: by 2002:a05:6830:d83:b0:745:9a08:c9b2 with SMTP id
 46e09a7af769-7459a08ced9mr3347248a34.5.1757012927953; Thu, 04 Sep 2025
 12:08:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904184801.47498-1-dave@stgolabs.net>
In-Reply-To: <20250904184801.47498-1-dave@stgolabs.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Sep 2025 21:08:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j9r6bKOXuo+o0gdhryR1ne3WY3B0o0DufEHB9y3j0Leg@mail.gmail.com>
X-Gm-Features: Ac12FXxMZElNIwd5D-TfEllMoPYRQzeOSpYa1MsH1gHzWXLyA0sPb5Vh9GDA8Mk
Message-ID: <CAJZ5v0j9r6bKOXuo+o0gdhryR1ne3WY3B0o0DufEHB9y3j0Leg@mail.gmail.com>
Subject: Re: [PATCH] acpi, tables: Rename coherency CFMW restrictions
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: rafael.j.wysocki@intel.com, dave.jiang@intel.com, dan.j.williams@intel.com, 
	jonathan.cameron@huawei.com, alejandro.lucero-palau@amd.com, 
	ira.weiny@intel.com, alison.schofield@intel.com, a.manzanares@samsung.com, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 8:48=E2=80=AFPM Davidlohr Bueso <dave@stgolabs.net> =
wrote:
>
> ACPICA commit 710745713ad3a2543dbfb70e84764f31f0e46bdc
>
> This has been renamed in more recent CXL specs, as
> type3 (memory expanders) can also use HDM-DB for
> device coherent memory.
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

A link to the corresponding upstream commit, please?

> ---
>  drivers/cxl/acpi.c           |  4 ++--
>  include/acpi/actbl1.h        |  4 ++--
>  tools/testing/cxl/test/cxl.c | 18 +++++++++---------
>  3 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 26c494704437..2cf75b553f26 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -128,9 +128,9 @@ static unsigned long cfmws_to_decoder_flags(int restr=
ictions)
>  {
>         unsigned long flags =3D CXL_DECODER_F_ENABLE;
>
> -       if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE2)
> +       if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_DEVMEM)
>                 flags |=3D CXL_DECODER_F_TYPE2;
> -       if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE3)
> +       if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM)
>                 flags |=3D CXL_DECODER_F_TYPE3;
>         if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
>                 flags |=3D CXL_DECODER_F_RAM;
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 99fd1588ff38..eb787dfbd2fa 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -560,8 +560,8 @@ struct acpi_cedt_cfmws_target_element {
>
>  /* Values for Restrictions field above */
>
> -#define ACPI_CEDT_CFMWS_RESTRICT_TYPE2      (1)
> -#define ACPI_CEDT_CFMWS_RESTRICT_TYPE3      (1<<1)
> +#define ACPI_CEDT_CFMWS_RESTRICT_DEVMEM      (1)
> +#define ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM (1<<1)
>  #define ACPI_CEDT_CFMWS_RESTRICT_VOLATILE   (1<<2)
>  #define ACPI_CEDT_CFMWS_RESTRICT_PMEM       (1<<3)
>  #define ACPI_CEDT_CFMWS_RESTRICT_FIXED      (1<<4)
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 6a25cca5636f..ba50338f8ada 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -210,7 +210,7 @@ static struct {
>                         },
>                         .interleave_ways =3D 0,
>                         .granularity =3D 4,
> -                       .restrictions =3D ACPI_CEDT_CFMWS_RESTRICT_TYPE3 =
|
> +                       .restrictions =3D ACPI_CEDT_CFMWS_RESTRICT_HOSTON=
LYMEM |
>                                         ACPI_CEDT_CFMWS_RESTRICT_VOLATILE=
,
>                         .qtg_id =3D FAKE_QTG_ID,
>                         .window_size =3D SZ_256M * 4UL,
> @@ -225,7 +225,7 @@ static struct {
>                         },
>                         .interleave_ways =3D 1,
>                         .granularity =3D 4,
> -                       .restrictions =3D ACPI_CEDT_CFMWS_RESTRICT_TYPE3 =
|
> +                       .restrictions =3D ACPI_CEDT_CFMWS_RESTRICT_HOSTON=
LYMEM |
>                                         ACPI_CEDT_CFMWS_RESTRICT_VOLATILE=
,
>                         .qtg_id =3D FAKE_QTG_ID,
>                         .window_size =3D SZ_256M * 8UL,
> @@ -240,7 +240,7 @@ static struct {
>                         },
>                         .interleave_ways =3D 0,
>                         .granularity =3D 4,
> -                       .restrictions =3D ACPI_CEDT_CFMWS_RESTRICT_TYPE3 =
|
> +                       .restrictions =3D ACPI_CEDT_CFMWS_RESTRICT_HOSTON=
LYMEM |
>                                         ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>                         .qtg_id =3D FAKE_QTG_ID,
>                         .window_size =3D SZ_256M * 4UL,
> @@ -255,7 +255,7 @@ static struct {
>                         },
>                         .interleave_ways =3D 1,
>                         .granularity =3D 4,
> -                       .restrictions =3D ACPI_CEDT_CFMWS_RESTRICT_TYPE3 =
|
> +                       .restrictions =3D ACPI_CEDT_CFMWS_RESTRICT_HOSTON=
LYMEM |
>                                         ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>                         .qtg_id =3D FAKE_QTG_ID,
>                         .window_size =3D SZ_256M * 8UL,
> @@ -270,7 +270,7 @@ static struct {
>                         },
>                         .interleave_ways =3D 0,
>                         .granularity =3D 4,
> -                       .restrictions =3D ACPI_CEDT_CFMWS_RESTRICT_TYPE3 =
|
> +                       .restrictions =3D ACPI_CEDT_CFMWS_RESTRICT_HOSTON=
LYMEM |
>                                         ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>                         .qtg_id =3D FAKE_QTG_ID,
>                         .window_size =3D SZ_256M * 4UL,
> @@ -285,7 +285,7 @@ static struct {
>                         },
>                         .interleave_ways =3D 0,
>                         .granularity =3D 4,
> -                       .restrictions =3D ACPI_CEDT_CFMWS_RESTRICT_TYPE3 =
|
> +                       .restrictions =3D ACPI_CEDT_CFMWS_RESTRICT_HOSTON=
LYMEM |
>                                         ACPI_CEDT_CFMWS_RESTRICT_VOLATILE=
,
>                         .qtg_id =3D FAKE_QTG_ID,
>                         .window_size =3D SZ_256M,
> @@ -302,7 +302,7 @@ static struct {
>                         .interleave_arithmetic =3D ACPI_CEDT_CFMWS_ARITHM=
ETIC_XOR,
>                         .interleave_ways =3D 0,
>                         .granularity =3D 4,
> -                       .restrictions =3D ACPI_CEDT_CFMWS_RESTRICT_TYPE3 =
|
> +                       .restrictions =3D ACPI_CEDT_CFMWS_RESTRICT_HOSTON=
LYMEM |
>                                         ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>                         .qtg_id =3D FAKE_QTG_ID,
>                         .window_size =3D SZ_256M * 8UL,
> @@ -318,7 +318,7 @@ static struct {
>                         .interleave_arithmetic =3D ACPI_CEDT_CFMWS_ARITHM=
ETIC_XOR,
>                         .interleave_ways =3D 1,
>                         .granularity =3D 0,
> -                       .restrictions =3D ACPI_CEDT_CFMWS_RESTRICT_TYPE3 =
|
> +                       .restrictions =3D ACPI_CEDT_CFMWS_RESTRICT_HOSTON=
LYMEM |
>                                         ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>                         .qtg_id =3D FAKE_QTG_ID,
>                         .window_size =3D SZ_256M * 8UL,
> @@ -334,7 +334,7 @@ static struct {
>                         .interleave_arithmetic =3D ACPI_CEDT_CFMWS_ARITHM=
ETIC_XOR,
>                         .interleave_ways =3D 8,
>                         .granularity =3D 1,
> -                       .restrictions =3D ACPI_CEDT_CFMWS_RESTRICT_TYPE3 =
|
> +                       .restrictions =3D ACPI_CEDT_CFMWS_RESTRICT_HOSTON=
LYMEM |
>                                         ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>                         .qtg_id =3D FAKE_QTG_ID,
>                         .window_size =3D SZ_512M * 6UL,
> --
> 2.39.5
>
>

