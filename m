Return-Path: <linux-acpi+bounces-17204-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1955AB925E2
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 19:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A30175CE0
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 17:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF807312826;
	Mon, 22 Sep 2025 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMyqgK38"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADA33112BF
	for <linux-acpi@vger.kernel.org>; Mon, 22 Sep 2025 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758561298; cv=none; b=lkGtJfbVV4ydO/QM6nAWgR0PNGjwRdbtzIzeUHNAh5+10PJZTD3445FQFR8yVfoYR7k/Rn9lTJlY//bhHBIYxshIP+Hlc7FFFOq9lGN/4XIrP393ZpCwzAE0ZyDbY1EvgDpKFiIIdvvjf6Y/KcJKRMLLBy0cSx3WxAi0NcpaxZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758561298; c=relaxed/simple;
	bh=a1r0r0TSA89SaKwMYCfi9ANMQ+wCKT0/BhQJ2SndRLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+rziQUG/Mq+pOR+cFI6mcHJah7TyKsILuNVhXEaRyADbyVNSJPnCJPzEBDp4WfdFedWzKA4N6UwFVAgvTvpKcZyzi2t06yoCYZ0rWjSrQW8Wv5S0LPaAVh09dPwzVo6q4i7rXKlUDaoxhF9F6fqmpk1EmIt3I2Jh7O62o50Osk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMyqgK38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF9DC16AAE
	for <linux-acpi@vger.kernel.org>; Mon, 22 Sep 2025 17:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758561298;
	bh=a1r0r0TSA89SaKwMYCfi9ANMQ+wCKT0/BhQJ2SndRLE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cMyqgK38zg6m6dpjMr41Z9ocP2fsQHeGWq+8wOzTACUhmcDIgcBJjpIhcpa2jHJ6H
	 8Omwjjh6x22f7U9lG6+Ry9vqYUEsOs1XrqVc5NsZIVtCBxbfHLkNVsh2NT30rJ0Bpu
	 cH8T4t8jyaUP61AuJldlfKadS94CUlCd7RlDzWhm7ZAbB0Q3GozJ5/J0FD0ZB851Le
	 /u29YXzRu1HnhSuaQWzUDGMozfJ7czHbfc14vmtknAKpnp7aF53wIUIB6+YIKpE/Nu
	 Av8l9fT2lHBQubjBgsr1s1QkRYjCEJ00BglH0NOsEVQ1ZcfRiqGbh7NAJcedlTeGnE
	 nW1l//T/fRaqA==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-74381df387fso2402736a34.0
        for <linux-acpi@vger.kernel.org>; Mon, 22 Sep 2025 10:14:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURgxV2LIKSmAMCHySiPMbJsCwPOTsZrOD0D/TzfGxiSSOcBVzpnEH8M95jvDVrhyNC854DdcTZi6M+@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn1IbLAjt3RICteKc9kvIhAB+jSFARO1eBMbWnNsl6Ju8QRUZq
	E3WUV9pPUWNVAwnYL3lLevGMk0OfUpAEgzIfHfdxulrcteqNrqE8oPJSXiOJmR35n7gw4jAgFcq
	Xhnc0m61/OWNrO9nPqwXokiKCkYL7+Ug=
X-Google-Smtp-Source: AGHT+IFoyvpmsryuYjn0yD+5eF81OucTOCkV+sagJA7gs6bndPjgf1u8pTwbWEwH6QYV/HDhktrDVDHIr/TK+SvSqZA=
X-Received: by 2002:a05:6808:3c43:b0:43f:1de2:fe8f with SMTP id
 5614622812f47-43f1de30b6emr1194994b6e.15.1758561297628; Mon, 22 Sep 2025
 10:14:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913070815.16758-1-cp0613@linux.alibaba.com>
In-Reply-To: <20250913070815.16758-1-cp0613@linux.alibaba.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Sep 2025 19:14:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gHw7ECzDF-tVQ=Ve0LO3m3Gm5DfF6=vxi_CFsZ6y_xAQ@mail.gmail.com>
X-Gm-Features: AS18NWCffy2507SFBviCJ4RIz5qzwqrhqL1BewYamJizV-QpOeCQbeOV8GBXrxQ
Message-ID: <CAJZ5v0gHw7ECzDF-tVQ=Ve0LO3m3Gm5DfF6=vxi_CFsZ6y_xAQ@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: SPCR: Support Precise Baud Rate filed
To: cp0613@linux.alibaba.com
Cc: rafael@kernel.org, lenb@kernel.org, guoren@kernel.org, 
	jeeheng.sia@starfivetech.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 9:08=E2=80=AFAM <cp0613@linux.alibaba.com> wrote:
>
> From: Chen Pei <cp0613@linux.alibaba.com>
>
> The Microsoft Serial Port Console Redirection (SPCR) specification
> revision 1.09 comprises additional field: Precise Baud Rate [1].
>
> It is used to describe non-traditional baud rates (such as those
> used by high-speed UARTs).
>
> It contains a specific non-zero baud rate which overrides the value
> of the Configured Baud Rate field. If this field is zero or not
> present, Configured Baud Rate is used.
>
> Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports=
/serial-port-console-redirection-table # 1
>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> ---
>  drivers/acpi/spcr.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> index cd36a97b0ea2..fa12e740386d 100644
> --- a/drivers/acpi/spcr.c
> +++ b/drivers/acpi/spcr.c
> @@ -146,7 +146,15 @@ int __init acpi_parse_spcr(bool enable_earlycon, boo=
l enable_console)
>                 goto done;
>         }
>
> -       switch (table->baud_rate) {
> +       /*
> +        * SPCR 1.09 defines Precise Baud Rate Filed contains a specific
> +        * non-zero baud rate which overrides the value of the Configured
> +        * Baud Rate field. If this field is zero or not present, Configu=
red
> +        * Baud Rate is used.
> +        */
> +       if (table->precise_baudrate)
> +               baud_rate =3D table->precise_baudrate;
> +       else switch (table->baud_rate) {
>         case 0:
>                 /*
>                  * SPCR 1.04 defines 0 as a preconfigured state of UART.
> --

Applied as 6.18 material, thanks!

