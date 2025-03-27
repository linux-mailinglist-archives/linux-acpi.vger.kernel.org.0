Return-Path: <linux-acpi+bounces-12517-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DBCA73F0E
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 20:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1F21894A1B
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 19:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EB718DB1D;
	Thu, 27 Mar 2025 19:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+wGHd0j"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A09317A31E;
	Thu, 27 Mar 2025 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743104812; cv=none; b=GCYfgEOGp6ErVhnppGSvHf3XFam6onl78RNydR+ywDCxx6kGxLweBrK3Sh9j4DHjIg0zuRLbtt61ak0yREHjjp1lSSVuZW777I0D7PKXlx/fVzd2OeihNomCgg3TiLcua8FtW6gF71aEAzvHiHgSduI9582tiQk7BGopLibYeTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743104812; c=relaxed/simple;
	bh=G+IvgSSxf03QxdrXqf4oA5QDm8+4pu6nUPAL6AFGWWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACjXDpSW9v7Svtqrxk0bd6oFM1btp5wTYRVKhF+wFpUTcQ1kZPK9gLH4HzTAYqwibfGFI0P1fluDIM9hv07lc7Sf0fXUtF4PSh5YC6PS5tORyzfuapf5hByR9CQKtsWDUN6USKoVDnc7jE4geTZIC0GtXELTMCMI9cy5HH2Rgy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+wGHd0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C14C4CEEA;
	Thu, 27 Mar 2025 19:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743104811;
	bh=G+IvgSSxf03QxdrXqf4oA5QDm8+4pu6nUPAL6AFGWWA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=q+wGHd0jqt2Mox/v94TUPNV9dbIbflPQ0/fdHi6Zuxb0dHxSPAdEwt4tygBhB1vK5
	 MIvRzbfS70oXrTrYZUCycdtlFaHC/lctUQTNDb+Y70HSSRhfSBIgi5yIjqJ08C0CxT
	 r8papoUYf7gXxyigYb+slYZj6aJJhJpKw5EKbWIRHLmzvfHmthS0Uc7voh/LOhkVrF
	 tNKkgWsjK7/+QK3PhbA8LYE3BgYK4+M+gwyVsHTNIhwAH04W7BxO1Xcw/kvBqvjX9P
	 hkH8JabdfTK8sgaCZs0zNAqWFkQq9n/39O71qj7roZHYAagoqpb4Gpc51qddncw/e4
	 fJo+hXn/3mGFQ==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6021e3daeabso685579eaf.3;
        Thu, 27 Mar 2025 12:46:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJaOECgYLkYoYH8ZwKKvEfpcV4oWnj8idYzD+Ypke4TP//w9gYNbeXp2yiYUKd5cY/usC34YbYcsQC@vger.kernel.org, AJvYcCWD6vXw5uBa2ogDbRwhml7wSeqN4vDrTxz0fie66oGDAqqLnTNX9Y7+l7VHf1GncQu6twVwzIN7VcOCDO8y@vger.kernel.org
X-Gm-Message-State: AOJu0YyZZ7PGRxbY3hRRssMC5ZnXSNXAc6MUGWpqOpEqKlVddMzio7iP
	+FY8YjvWoCr0Iy3QqAJONmI3fnW9OkRbqYTRVG11ABpRQsJbYVDY6LkMTyJdJ+VEf/+5DiCkKOy
	52OYjN+jOgW6oWK9UoGC6V+Q445U=
X-Google-Smtp-Source: AGHT+IFMQyPwbcNKyMRZpCjpAs+Uf7Ikd/W8SMlkC2cuuDmkyjvM9a2S5KPWs53tkbS1aJHu2BNapSsJRNnDpfffeYE=
X-Received: by 2002:a05:6870:1606:b0:2c2:5c2b:3ae5 with SMTP id
 586e51a60fabf-2c847efd6a2mr3009771fac.3.1743104810632; Thu, 27 Mar 2025
 12:46:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325-pprof-opt-v2-1-736291e6e66b@gmail.com>
In-Reply-To: <20250325-pprof-opt-v2-1-736291e6e66b@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Mar 2025 20:46:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iFMM5G48OfkZjnqkBK5rOLxKh=C-O5r3=WsWpTF8aXtA@mail.gmail.com>
X-Gm-Features: AQ5f1Jpe9zjZoU3IUgo-B5zwgNJl1jDpqgt-p6SqwbR_gPDsTj5EHK-z5MZ_lBo
Message-ID: <CAJZ5v0iFMM5G48OfkZjnqkBK5rOLxKh=C-O5r3=WsWpTF8aXtA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: platform_profile: Optimize _aggregate_choices()
To: Kurt Borja <kuurtb@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, Mario Limonciello <mario.limonciello@amd.com>, 
	Armin Wolf <W_Armin@gmx.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 9:40=E2=80=AFPM Kurt Borja <kuurtb@gmail.com> wrote=
:
>
> Choices aggregates passed to _aggregate_choices() are already filled
> with ones, therefore we can avoid copying a new bitmap on the first
> iteration.
>
> This makes setting the PLATFORM_PROFILE_LAST bit on aggregates
> unnecessary, so drop it as well.
>
> While at it, add a couple empty lines to improve style.
>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
> Changes in v2:
> - Mention bitmap requirements in kernel-doc
> - Link to v1: https://lore.kernel.org/r/20250322-pprof-opt-v1-1-105455879=
a82@gmail.com
> ---
>  drivers/acpi/platform_profile.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_prof=
ile.c
> index ef9444482db1982b19d2a17884e1c3ab0e5cb55c..26d7ba49e9dcff1fded246cb6=
b5c836b180e07e8 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -245,7 +245,8 @@ static const struct class platform_profile_class =3D =
{
>  /**
>   * _aggregate_choices - Aggregate the available profile choices
>   * @dev: The device
> - * @arg: struct aggregate_choices_data
> + * @arg: struct aggregate_choices_data, with it's aggregate member bitma=
p
> + *      initially filled with ones
>   *
>   * Return: 0 on success, -errno on failure
>   */
> @@ -256,12 +257,10 @@ static int _aggregate_choices(struct device *dev, v=
oid *arg)
>         struct platform_profile_handler *handler;
>
>         lockdep_assert_held(&profile_lock);
> +
>         handler =3D to_pprof_handler(dev);
>         bitmap_or(tmp, handler->choices, handler->hidden_choices, PLATFOR=
M_PROFILE_LAST);
> -       if (test_bit(PLATFORM_PROFILE_LAST, data->aggregate))
> -               bitmap_copy(data->aggregate, tmp, PLATFORM_PROFILE_LAST);
> -       else
> -               bitmap_and(data->aggregate, tmp, data->aggregate, PLATFOR=
M_PROFILE_LAST);
> +       bitmap_and(data->aggregate, tmp, data->aggregate, PLATFORM_PROFIL=
E_LAST);
>         data->count++;
>
>         return 0;
> @@ -305,7 +304,6 @@ static ssize_t platform_profile_choices_show(struct d=
evice *dev,
>         };
>         int err;
>
> -       set_bit(PLATFORM_PROFILE_LAST, data.aggregate);
>         scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock)=
 {
>                 err =3D class_for_each_device(&platform_profile_class, NU=
LL,
>                                             &data, _aggregate_choices);
> @@ -422,7 +420,7 @@ static ssize_t platform_profile_store(struct device *=
dev,
>         i =3D sysfs_match_string(profile_names, buf);
>         if (i < 0 || i =3D=3D PLATFORM_PROFILE_CUSTOM)
>                 return -EINVAL;
> -       set_bit(PLATFORM_PROFILE_LAST, data.aggregate);
> +
>         scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock)=
 {
>                 ret =3D class_for_each_device(&platform_profile_class, NU=
LL,
>                                             &data, _aggregate_choices);
> @@ -502,7 +500,6 @@ int platform_profile_cycle(void)
>         enum platform_profile_option profile =3D PLATFORM_PROFILE_LAST;
>         int err;
>
> -       set_bit(PLATFORM_PROFILE_LAST, data.aggregate);
>         scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock)=
 {
>                 err =3D class_for_each_device(&platform_profile_class, NU=
LL,
>                                             &profile, _aggregate_profiles=
);
>
> ---

Applied as 6.15-rc material, thanks!

