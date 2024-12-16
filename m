Return-Path: <linux-acpi+bounces-10154-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EF19F3AA2
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 21:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936F6188142A
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 20:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2B41CEEA4;
	Mon, 16 Dec 2024 20:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTNvLBw5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FD413D29A;
	Mon, 16 Dec 2024 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734380260; cv=none; b=aHSE0XFXKM1UIsghy1kvC6m3WhNQwprmS4yuCKTNFBmUpq8AFW5f63sjdWWE4Z+i5TymhEkxaKWW2N36ma+wPqChN9YVUnmw0tXFvpqcVsLbJi4q//aJbViollU8wLlwKfeNqzc+3XvRRZgNrvwLxxrDjCtPN5p4ouqivRmLB9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734380260; c=relaxed/simple;
	bh=KXqvjWiMSVH5syUt6Sl7U8sBOsToQ7b/XVL13BAKR14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Et3BhB0fvDmoscHtLPEMvNjuVzURVOTpCID/RH6aX+i9yaKsZoRkokav9aLOtXNGhaoFdsDLxrcst940ZbXVIEhA2C3u9Q1yC7yCpzjbhgPPD4RK7MtpAcKMNgePxiQU0+9q0KZONWMz+07zLWQW0cMhpICPfVTlcpWzLSSHtqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTNvLBw5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6278C4CED4;
	Mon, 16 Dec 2024 20:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734380259;
	bh=KXqvjWiMSVH5syUt6Sl7U8sBOsToQ7b/XVL13BAKR14=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VTNvLBw5wBLHf0Ga1JK0h6B9YiQeKA2ODJR9b0ytg8fvIetTWHS9/jW/YhD2RjUGy
	 7+gjIZFRM23RyMqqO/zV85QeJqNJHH9nxaZFlCIbzIT+PWQFyl7lyfr0sD1JnK93/W
	 D0ICdqzmXDgJuuc6HicyHgEajlwQRQ4PtE6qf4e/37ulOSSOVADTgFObzuBa2W9LGs
	 d51tsx4Oii+Rzhd/1KOA6Nqtj8BcdC1hIU99kKbM7xNhZCE48WM+xcVHE03Ud863yf
	 n2r0s+AodheEiaVv75sNLHu9kyQifGlkQ7m+yEQzUs85Lwbc8Lp6hSMtzYG2Xtf/sw
	 KDnbajW9a564g==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3eb9a0a2089so2590904b6e.1;
        Mon, 16 Dec 2024 12:17:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUg2JpqQt+lZGG9dKq5rXqPTPEYRk8barkF6leEIxJNrkI60tD7josemvvMI3krOkEZ7RJGh4sd7LHZ@vger.kernel.org, AJvYcCXpK2VH2lLZv3CQ6/R07UO4LGCC+jhwgGZb5U0tQkdpNNES5KP1YNLbVDKi3oRV7KRFQLad8GaUrXBQMYwp@vger.kernel.org
X-Gm-Message-State: AOJu0YzziqRloQhqPhP4PmWLOuoGM1Fj0TIkKU7Pw0PKstyfkLqU4mzI
	JuZ4admZ2uqtMq64F1gSxKN4T+5mtoAyo4tE5eR0UrWoZ62pdc2IAK5qDDBsjKYsNtgvUozIDsG
	uuSFG5sgEnCtrBidcpbmtGD+09AA=
X-Google-Smtp-Source: AGHT+IEiShw8w54t2n+KxDLI4IZEJWF1mNySxa+8zBzEosJsmwh5xKbuP+ot2fbuSzq3zRpqTEUHr9IPWYc7TNJbuAY=
X-Received: by 2002:a05:6808:1907:b0:3eb:44a7:d3f8 with SMTP id
 5614622812f47-3ebcb3ae9fbmr57086b6e.39.1734380259145; Mon, 16 Dec 2024
 12:17:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211-fix-ipu-v4-0-4102e97aceb6@chromium.org> <20241211-fix-ipu-v4-2-4102e97aceb6@chromium.org>
In-Reply-To: <20241211-fix-ipu-v4-2-4102e97aceb6@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Dec 2024 21:17:28 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gmN6+y2DveaBjSqWpTRWqm9zo2t0uDdvGwnVXcdQ777A@mail.gmail.com>
Message-ID: <CAJZ5v0gmN6+y2DveaBjSqWpTRWqm9zo2t0uDdvGwnVXcdQ777A@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] ACPI: bus: implement acpi_get_physical_device_location
 when !ACPI
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 5:07=E2=80=AFPM Ricardo Ribalda <ribalda@chromium.o=
rg> wrote:
>
> Provide an implementation of acpi_get_physical_device_location that can
> be used when CONFIG_ACPI is not set.
>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  include/acpi/acpi_bus.h | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 2b09e513ecf3..b312a72f48ad 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -43,9 +43,6 @@ acpi_status
>  acpi_evaluate_ost(acpi_handle handle, u32 source_event, u32 status_code,
>                   struct acpi_buffer *status_buf);
>
> -acpi_status
> -acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_in=
fo **pld);
> -
>  bool acpi_has_method(acpi_handle handle, char *name);
>  acpi_status acpi_execute_simple_method(acpi_handle handle, char *method,
>                                        u64 arg);
> @@ -60,6 +57,9 @@ bool acpi_check_dsm(acpi_handle handle, const guid_t *g=
uid, u64 rev, u64 funcs);
>  union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const guid_t *g=
uid,
>                         u64 rev, u64 func, union acpi_object *argv4);
>  #ifdef CONFIG_ACPI
> +acpi_status
> +acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_in=
fo **pld);
> +
>  static inline union acpi_object *
>  acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 rev,
>                         u64 func, union acpi_object *argv4,
> @@ -1003,6 +1003,12 @@ static inline int unregister_acpi_bus_type(void *b=
us) { return 0; }
>
>  static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
>
> +static inline acpi_status
> +acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_in=
fo **pld)
> +{
> +       return AE_ERROR;
> +}

I overlooked this before, sorry.

It generally is not OK to use acpi_status and/or AE_ error codes
without CONFIG_ACPI and they really only should be used in
drivers/acpi/ (and not everywhere in there for that matter).

So acpi_get_physical_device_location() needs to be redefined to return
something different from acpi_status (preferably bool) in order to be
used in !CONFIG_ACPI code.

> +
>  #define for_each_acpi_dev_match(adev, hid, uid, hrv)                   \
>         for (adev =3D NULL; false && (hid) && (uid) && (hrv); )
>
>
> --

