Return-Path: <linux-acpi+bounces-19912-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A82CEA2BE
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Dec 2025 17:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD7D23026AE5
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Dec 2025 16:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C6B320CA9;
	Tue, 30 Dec 2025 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5gUCBMw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA823203B2
	for <linux-acpi@vger.kernel.org>; Tue, 30 Dec 2025 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767112042; cv=none; b=gn+SntevBS0MvbfCno6Dg1neKv0g10bSYIrGVWck4LdWtffhm9QGl1opziThQ1/aPdh8XFKtRSr8v+khIzEIpxWRW/ZZQgDKMU7LxssBUBfY8zSeZbfcQRzlCkzn56ggRrNb2K6918hnhetPJa4hER8ydmSVxRlI8MmgYHaOsO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767112042; c=relaxed/simple;
	bh=dWzgmS30+08etAJmaADuKq0gmF/cfIle0Dvj4mqcL6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUYbuFog6jFRzOu6OGq3fUtK09ZJirKqw69fBG64pUkJDo8p9bO9kaceJz2ozW/PmodQHhNsfCr2aHLklrcYJalqNzLSNC+wP6yI/ILd4tkf5E3DvJvTe4Sq+S2+c7J3D+GIpakCRS+R9VFY2wL9gq2KFkFvi67UH1cmqix4W5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5gUCBMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C51C116D0
	for <linux-acpi@vger.kernel.org>; Tue, 30 Dec 2025 16:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767112042;
	bh=dWzgmS30+08etAJmaADuKq0gmF/cfIle0Dvj4mqcL6s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u5gUCBMw8inOHcHnhaNml6D4XODtz1q0u9/ybtTdPW2d2F4avgFGWHA9vW6T876by
	 vmHvEaA8z9oA0XIh1St2NMzWJE91IDXH9sVEvJA4VAW3JwA3n+QwpBBsdJv72LX42/
	 9uQOEXubsndBDp5Jf8Wg2HRZslGygFJYgSWzhzelHIUYxbDXT7wQTDtGryHi8GDzeF
	 Unmggu5yurkXv18iZOWHO0bcGxp5/7+2H6eJ8UHNcYNhTJhFgdd7PS6R73t/dFOKgx
	 /T+Ggb56oVf9+V+G0sK6g0Lf2xgo8rSyxMk324QuoCPYGqNDPbZsSLU9Ba3H0vlQFw
	 bwIJuUpe4UMOw==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c7533dbd87so7507301a34.2
        for <linux-acpi@vger.kernel.org>; Tue, 30 Dec 2025 08:27:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1UfTGa9fXgP3o4n8e4f0zr4P8Byztat0ND5RGB9/TQEmuGScYuXfFtH85o8jQPFxUV7ILvpQ56shk@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0oEVqt/rDt17GeNXYo4nPvArXBzx5+N1FtAzWW/KwaaCRzpay
	rCs+9a6WQ3lJSKFb3DhLKqvQFu//f899PTFoib6EmJAkZtA1RU15KAfa3ewxOAlbJv66LIeVJhZ
	3ZtbdBB13KiGrcgxL9bstgd5ctnoP34A=
X-Google-Smtp-Source: AGHT+IHv2/Ndaop9Z6uq1VD9/PZzp1tT54HyUh3hNpSyGFZGtVnfI1FCSYdidJQOrPR0xz/jdihvjuGmTmpR+JtKzK8=
X-Received: by 2002:a05:6820:1628:b0:65d:ef:b937 with SMTP id
 006d021491bc7-65d0ea99d06mr12939563eaf.33.1767112041157; Tue, 30 Dec 2025
 08:27:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230160644.100439-1-Julia.Lawall@inria.fr>
In-Reply-To: <20251230160644.100439-1-Julia.Lawall@inria.fr>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 30 Dec 2025 17:27:08 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iyRKisGu6OWmA6i_9bcPXp6K-DNAoOAVm8+i57BsL3Ug@mail.gmail.com>
X-Gm-Features: AQt7F2r3B5bH2lBVYpGlBPCWih6F6TCYGAt6-wkQrv1ntzhKmA8iZR7uLsfYp8E
Message-ID: <CAJZ5v0iyRKisGu6OWmA6i_9bcPXp6K-DNAoOAVm8+i57BsL3Ug@mail.gmail.com>
Subject: Re: [PATCH] ACPI: scan: removed outdated comment
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, yunbolyu@smu.edu.sg, kexinsun@smail.nju.edu.cn, 
	ratnadiraw@smu.edu.sg, xutong.ma@inria.fr, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 5:06=E2=80=AFPM Julia Lawall <Julia.Lawall@inria.fr=
> wrote:
>
> The function acpi_video_get_capabilities() was removed from
> drivers/acpi/video_detect.c by commit 87521e16a7ab
> ("acpi-video-detect: Rewrite backlight interface selection logic") in
> 2015.  At the time, comments about this function were just removed,
> and no replacement seemed to be proposed.  So drop the reference to
> acpi_video_get_capabilities() here as well.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>
> ---
>  drivers/acpi/scan.c |    2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 416d87f9bd10..9297461045a2 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1294,8 +1294,6 @@ acpi_backlight_cap_match(acpi_handle handle, u32 le=
vel, void *context,
>   * The device will get a Linux specific CID added in scan.c to
>   * identify the device as an ACPI graphics device
>   * Be aware that the graphics device may not be physically present
> - * Use acpi_video_get_capabilities() to detect general ACPI video
> - * capabilities of present cards
>   */
>  long acpi_is_video_device(acpi_handle handle)
>  {

Applied as 6.20 material, thanks!

