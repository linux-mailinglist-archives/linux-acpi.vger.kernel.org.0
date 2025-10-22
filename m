Return-Path: <linux-acpi+bounces-18122-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AB8BFE02C
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 21:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 23DEB345C3C
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 19:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E22333741;
	Wed, 22 Oct 2025 19:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDpet//4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D87123BD01
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 19:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761160894; cv=none; b=Tbe5/ZuhyptqqbvmxeoFgFS3UUAEwqMVNHYpMuRYrwE0P3I/VOuSPsWEWh+Co0/XgQycolyqActQxHC/y/jLvYXpd600xmrPgYL0VQOyilm83s0ts0JERNhv5HUnt5u6Z5I/qrYP3nft1iBIubkJv2FdzDe9obeq9cqXjdW7VCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761160894; c=relaxed/simple;
	bh=VifYTsQoyvbCPF6OfW5N5tw43b5HlY5MZDAkbyTJ1Ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZvubiU6h/XWF+lcFhZ8FdRYggdVIb049tcJoay9kXlK1dh/msn/3wL6YGlWllaq8nvaQ9nVHugVOe9kJEudPTwthN/zLZovtBnm/uYsHAu4ELM3pm7b3lo6K6An6bav/PLjLujtAdw3s1mIiutkcbmhytqgzElzDysIwiBHdqO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDpet//4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B153C4CEE7
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 19:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761160893;
	bh=VifYTsQoyvbCPF6OfW5N5tw43b5HlY5MZDAkbyTJ1Ow=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JDpet//4YjCEeLBHHxVA9PJ4xuAYcDPBnSmGxUfNaZyg7HeUn6gvSCH4y+FRJ+fjY
	 pLYzi++ZrKwPQ0VW2rQOq4OPt6MAiAuwoSFOYrvSaslD9CY9/My8fMcQI06PGBnRCg
	 37vxtCUaTWAtadeQjCqgy/ThvTC1c5EE6S6jcv/tBMow9Aa8648PHX5nZoIfnuUf11
	 M/TOOkM2FVFCWGVcC4CjjMpllvUXLCWOYlISrzUlafk0zMV8bCcrFrM3/Vp2MAhDjO
	 tdQW4q7WoteMcwKtPAcc2NIdD5cM+i30MYutWFSQAAsXH3Fs/ISKXMOzESve41QTk0
	 YJR33nXPAJ0yg==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c28bf230feso1195192a34.0
        for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 12:21:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4bbN9+D/9G6nnDHciDV/GzNm6jHufeI3j8YJliFWy+CzBYBcYHh/ERrX4Pk2Bf8zW/Ix8Gum3/wau@vger.kernel.org
X-Gm-Message-State: AOJu0YzNmv4k08iiuw7dshylXEgFRfcJvgU5CxgieLHEFp0haVQW7Z2r
	7vnyrEyheg0uJ1SxDo5gvOqcdTzpKdS2266yiLXt3n3IgyI2GEnXUec2BaS6/ZuYv9HbNkoH6Nk
	tVPKpaWpSnpy9VvHx3ylg1zMM9STnBSQ=
X-Google-Smtp-Source: AGHT+IHkUPidAZyreZwTdyCTYpepJ7oePcTo2MzxfCT/awXNwbZFzJktS7UZY5D5CcHSoom0v1yBGSw4e9CZ1ZWyAG4=
X-Received: by 2002:a05:6808:1512:b0:443:a4aa:4a8b with SMTP id
 5614622812f47-44bbca5e7e2mr1112893b6e.14.1761160892986; Wed, 22 Oct 2025
 12:21:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006084706.971855-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20251006084706.971855-1-kaushlendra.kumar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 22 Oct 2025 21:21:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hRDSqyUz0GxA7U6Az75uXuaxQz=jTymtBWKmgHkyJQkQ@mail.gmail.com>
X-Gm-Features: AS18NWB6u0Q9qSnbmlC72f1nOPG7m4GMspUXh9vT_V_4h492_HLc1YJsjk8USDU
Message-ID: <CAJZ5v0hRDSqyUz0GxA7U6Az75uXuaxQz=jTymtBWKmgHkyJQkQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI / button: Add input_free_device() on registration failure
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 10:49=E2=80=AFAM Kaushlendra Kumar
<kaushlendra.kumar@intel.com> wrote:
>
> Add input_free_device() call when input_register_device() fails to
> prevent memory leak. According to input_register_device() documentation,
> "If function fails the device must be freed with input_free_device()",
> but the current code only jumps to err_remove_fs without freeing the
> allocated input device.
>
> This ensures proper cleanup of the input device structure when device
> registration encounters an error, preventing resource leaks in the ACPI
> button driver.
>
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>  drivers/acpi/button.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 0a7026040188..3c6dd9b4ba0a 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -619,8 +619,10 @@ static int acpi_button_add(struct acpi_device *devic=
e)
>
>         input_set_drvdata(input, device);
>         error =3D input_register_device(input);
> -       if (error)
> +       if (error) {
> +               input_free_device(input);
>                 goto err_remove_fs;
> +       }
>
>         switch (device->device_type) {
>         case ACPI_BUS_TYPE_POWER_BUTTON:
> --

Applied as 6.18-rc material with rewritten subject and changelog, thanks!

