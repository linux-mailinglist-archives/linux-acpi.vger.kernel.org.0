Return-Path: <linux-acpi+bounces-7238-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D31945F54
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Aug 2024 16:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1258E1C21F2F
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Aug 2024 14:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41761EA0DA;
	Fri,  2 Aug 2024 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWSla9Q3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5B31EA0D4;
	Fri,  2 Aug 2024 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722608642; cv=none; b=fB8b7ghkMx3WiWaXKdy7v1pJfUggtq05ykjqZY56KgGUMIfFsXYeLIPiNBZ3/tvq9hupxG49ZETWnNhLBjubPpuzd1f2W8wz8y0BRyrRFLkDMYRJn6AtQ7hIZSXG2om3/EjiWy/RSMqO9BY7eFMCx5djp2ni6lXq7NZvjx/9WMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722608642; c=relaxed/simple;
	bh=46QlCBB+1hN0SZBoBABFSlnj7zqU24o/5wNPtJxQFgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=be+eH2f3AMtU1Nb0oJWIpGFAWbNGNB5xntMQL4jSfPU+GYvw3E/5Dh+0hXZrG1I8xyxey70iAf+jCvREeEy5Ey2GdstANQaX0HUYy9996Q/drTVwevmYQ6QflqPIezfQsTyJf8dwvp+7bgtNgSFvBe1S71M65eUZ6N1mS7vEAtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWSla9Q3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCA7C4AF0B;
	Fri,  2 Aug 2024 14:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722608642;
	bh=46QlCBB+1hN0SZBoBABFSlnj7zqU24o/5wNPtJxQFgc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bWSla9Q34WGx4VuUn7wSWA3x7XI+Ap51mZmpMOt38gvC/y/WxDWWfPsG78LJwEZ88
	 j6qTYvgDO9F/8GSwbehT4Wb+laAGQDzryoz1USvNX2b3FyLXk03r3rAvQfYHuzaBrG
	 1x3deNGj04PnGvwoxFlRANS4g7NFz3ZBNE+28rufA65n8qBkrCcu8oc/8K6sdGAd88
	 0B7iTQuog7Z38IwLubQvepQEHrBTitZelyWpJxwdMMr6YRY/MxC06FI7SYIV3hmr3W
	 sr8j3yPwlhLC17AjQBmpV44aHm1Z5cXefRG3WuLDMrjq8X8Bk+281/W5AiuNeUDZDs
	 iEAxhOl8D3lgg==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3db165f8211so866991b6e.1;
        Fri, 02 Aug 2024 07:24:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5GPdmkRHyZ0OfNgmfqiOUwrwm5RnYwmgfs3MH76M6Xj2DzrxSNvLEdBg2o4Y5SjVJdf+IOn4scRsaMlUHEComRaU2GGWmXM6JOn3jmXp7hRiBVuwMWK2Ix9oYVzxd5FGfSgM6C4Vyyw==
X-Gm-Message-State: AOJu0YzqYLi/dEB1v7gm/cfdS6/u9iYot8WnaWDHx6WOZh60ebZCtikD
	bQvRgxCUgOFMoTxUTW/kiLUOUWCU8UDDQVrAWPu8mqiH09jWCEfk1xdnCMs9yu0exVP8UYQxFIf
	2izKWrGOUXFfdbzh6B+ZHcolNJ48=
X-Google-Smtp-Source: AGHT+IGv8UvWDvLYqW1hoya2m/CZASyuzRIsBXiBlKQ4IxQC1gojNpR288+kN35MNwngUqyndyUtOBiOdfPy4taPIU4=
X-Received: by 2002:a05:6870:ac10:b0:260:23eb:5669 with SMTP id
 586e51a60fabf-26891a9437fmr2324342fac.2.1722608641617; Fri, 02 Aug 2024
 07:24:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731095345.2878-1-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20240731095345.2878-1-ilpo.jarvinen@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Aug 2024 16:23:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iVwXLBZJx3xcgqO6mWEz9ho3MgcCE71mxy8z=RT3HU6w@mail.gmail.com>
Message-ID: <CAJZ5v0iVwXLBZJx3xcgqO6mWEz9ho3MgcCE71mxy8z=RT3HU6w@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: battery: Remove redundant NULL initalizations
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 11:54=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> A local 'battery' variable is initialized to NULL on two occassions
> where it is unconditionally rewritten later. Remove the unnecessary
> initializations.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/acpi/battery.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index da3a879d638a..06e84d21ba3b 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -1207,7 +1207,7 @@ static int acpi_battery_update_retry(struct acpi_ba=
ttery *battery)
>  static int acpi_battery_add(struct acpi_device *device)
>  {
>         int result =3D 0;
> -       struct acpi_battery *battery =3D NULL;
> +       struct acpi_battery *battery;
>
>         if (!device)
>                 return -EINVAL;
> @@ -1260,7 +1260,7 @@ static int acpi_battery_add(struct acpi_device *dev=
ice)
>
>  static void acpi_battery_remove(struct acpi_device *device)
>  {
> -       struct acpi_battery *battery =3D NULL;
> +       struct acpi_battery *battery;
>
>         if (!device || !acpi_driver_data(device))
>                 return;
> --

Applied as 6.12 material, thanks!

