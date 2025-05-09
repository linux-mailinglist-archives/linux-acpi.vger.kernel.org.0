Return-Path: <linux-acpi+bounces-13658-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAFAAB1C61
	for <lists+linux-acpi@lfdr.de>; Fri,  9 May 2025 20:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1381C283BD
	for <lists+linux-acpi@lfdr.de>; Fri,  9 May 2025 18:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1087223D2A3;
	Fri,  9 May 2025 18:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qX/Ab8Lb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC86B221F2A;
	Fri,  9 May 2025 18:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746815740; cv=none; b=J9use75IKQ9oztvDSd5kkDGwOmA0ARIAWuRgO+VvL4ocDAxvYknV2vI1WRlKyd3t9mBG/VToLCoFS9YCwzqyhkF7wqXeubacwQ8abV5odKmdXVgBfj91s0qJLsC69LrKSmW8VJ0eLtb7QECRGpUnjBVDk7RHNniAuPjZFkmC7Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746815740; c=relaxed/simple;
	bh=wiN4AJff2MO36hmjwhZf+fINxMwx2HjjM3httjuWa28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UnuVsa5E7eJ0L8WjFRKBdGiLTrULmoxiI4jQpQVE8qzBOXrnnxqmQwKw2Kh2ol5v0TBd1j72dXITWWwpIpXh+Mxy6ui9Geqduy2uJ93dljjEBZi5JNkncntDWRLBbuIEJ5+UNE8hPclZGuosMtV1Qv6Ai1JE7p/XVtXUNStk8XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qX/Ab8Lb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2001C4CEE4;
	Fri,  9 May 2025 18:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746815739;
	bh=wiN4AJff2MO36hmjwhZf+fINxMwx2HjjM3httjuWa28=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qX/Ab8LbNArebA2y7bD0xiEXc5oErGX27J/17wbeGMOGfdtQrmUbrPY9U9Vw/v0mY
	 K4izXVnck7Hc+aQhGxlJyTsvqPfjPPjc22vTqwXYsRWgDLHWNN417zOwf2TafSGdmW
	 SZA8QMNQALolBp9ioZcm9MNYdJHl3Zc8IZO70DKDUKPHPKEG/uAJZSaAG3Fud8HQWw
	 FenMpmValBrGY4GAk/Rp14I004htsyrr/AWFMjLQBAnPkZopLMSawbRq6fQzyoRrgW
	 6NRVKErQ53bmlIvIT/ZUcci6W2StZ9Gvb6EGi3t1cOxK1zyHM0FdlUlVzBY1navjZF
	 +uKaEd4hoDYdw==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6060200710bso1181121eaf.3;
        Fri, 09 May 2025 11:35:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUogpclHAwKG1P4ylqZrs7DpNarDRzqb6rUKkiYTRroZB/TjA7BjUlV2kW0AMesZHhAF67HKYXkvApossIV@vger.kernel.org, AJvYcCXd/uOCZPH6jkF5C9Uk6gaVgE2pnz9N6B0iLIo1ac4Ue2su5ORzW9DZ3NnUQ8nRk7qkQq1zFYpIX5yg@vger.kernel.org
X-Gm-Message-State: AOJu0YwEAb6c0uCdDPrekmGN3xPZGiDGTwEWRuBZvkILjks8A5kRN+Fp
	4h34kE6xNo5EiqNY8imcCcxkNfwJUjxM2OiXf0r4tlcSsFYUNHDpwYjbKa6KQoxXpKEXT2ybg0b
	ufU3tVC3UuqyYoO+riBWF5F6an9c=
X-Google-Smtp-Source: AGHT+IGGn0vDEehPeNqlUtedxboRCybrz4zYXidXM7cBpigTl7pwBY2hMHApX1VtwDCEdJw6r5inABIrv8+5+lCDmSU=
X-Received: by 2002:a05:6870:1d4:b0:2c1:5dbb:ecb6 with SMTP id
 586e51a60fabf-2dba455ed9amr2833539fac.38.1746815739079; Fri, 09 May 2025
 11:35:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423085637.38658-1-bsz@amazon.de>
In-Reply-To: <20250423085637.38658-1-bsz@amazon.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 May 2025 20:35:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i4iPn=_AWWDUA5R87k0zENcPoHVRrS+ka2PD0LHWqhaA@mail.gmail.com>
X-Gm-Features: ATxdqUHjMPHTd4DyOmVZL6zLJgEKHRKVz8ze0QDmO-a70pcNwJ8HlOLRbYZHqtY
Message-ID: <CAJZ5v0i4iPn=_AWWDUA5R87k0zENcPoHVRrS+ka2PD0LHWqhaA@mail.gmail.com>
Subject: Re: [PATCH] drivers/acpi: Improve logging around acpi_initialize_tables
To: Bartosz Szczepanek <bsz@amazon.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, nh-open-source@amazon.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 10:56=E2=80=AFAM Bartosz Szczepanek <bsz@amazon.de>=
 wrote:
>
> Emit warning that includes return code in a readable format. Example:
>   ACPI: Failed to initialize tables, status=3D0x5 (AE_NOT_FOUND)
>
> This commit intends to make no other functional change.
>
> Signed-off-by: Bartosz Szczepanek <bsz@amazon.de>
> ---
>  drivers/acpi/tables.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 2295abbecd14..6a017cc92d4e 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -719,8 +719,12 @@ int __init acpi_locate_initial_tables(void)
>         }
>
>         status =3D acpi_initialize_tables(initial_tables, ACPI_MAX_TABLES=
, 0);
> -       if (ACPI_FAILURE(status))
> +       if (ACPI_FAILURE(status)) {
> +               const char *msg =3D acpi_format_exception(status);
> +
> +               pr_warn("Failed to initialize tables, status=3D0x%x (%s)"=
, status, msg);
>                 return -EINVAL;
> +       }
>
>         return 0;
>  }
> --

Applied as 6.16 material, thanks!

