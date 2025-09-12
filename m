Return-Path: <linux-acpi+bounces-16702-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622E0B547AA
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 11:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1C2585C89
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 09:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45A527B4EB;
	Fri, 12 Sep 2025 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPfuMEFO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892A727B34B
	for <linux-acpi@vger.kernel.org>; Fri, 12 Sep 2025 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669399; cv=none; b=th3X1A0Dxk2gSelStvMmyrN9skjS/K/uhoiQ76Ck2SpBaiXN8504udWrM+wF2GlG1kADPMxo1fdOK/6x1NQxoRS/9djz51jjlrmIFNjG9u/uVnX3wylMeHvWw2zEcG7YpmuMSiw6ccOIVOjVDjbSGSN+z7YKY5pWgyEpd2hU4EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669399; c=relaxed/simple;
	bh=ues0s9adPEQYWl+VgmLi4AZpQ7GxaxuZKJ7J9dlYyjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lr+LgRGVl2h80ymCbGj+UXJ75NJAwDMhLOv8Whk4C4zqmMPjgK2gn2QtL+nj/3BtTp9K5FWsRi0PiAAhDFgIySJ3pqFNG9HpAzki6yyx8wtmLd97VOHl9c387h85UZq+WCm6juKCjhLCTzJuLqB6nSKUjJ5gC7VcV2zmdWlE/SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPfuMEFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEDEC4CEFB
	for <linux-acpi@vger.kernel.org>; Fri, 12 Sep 2025 09:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757669399;
	bh=ues0s9adPEQYWl+VgmLi4AZpQ7GxaxuZKJ7J9dlYyjU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IPfuMEFO3BxQhVLp5GInrSYY90Yhw5P8EfhKkDMqTxKpZyhrApqi3Dd+uzrx86aqR
	 QtNb2vsLPD6HClXeNovAGHhcVO2nEQBu1jBnBxgJK2vdTT3q/5SKC41ji8cIlHMkvu
	 29EsfrEQq4gesIjVpIX0ISt3Bj+VvZJWn5zLRsHgMT7nK7/uuR/0SHpeQQxfBg1fbe
	 X6rwOSMaXbdjksArs/PSTBsT2QxRpSY/hGiMU8HflChSxmwDUaSsLe8yJKK4a8VH6N
	 nP0v3ugl3JjXct/XHxm+o8B+4lpblFs/LZQhApC0U3SFh/4O1lHV08isEMa5lTadAs
	 ymiL5B9iNTkgQ==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-74c1251df00so930652a34.0
        for <linux-acpi@vger.kernel.org>; Fri, 12 Sep 2025 02:29:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXn86DGYWnVmxkl8/GVzcufcXlR+ozDY95CUF/MfmVECePW5falu+x6xpjGIUKQHqpytEQKx4ere8/2@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuju/Ot1m9BDbmjIUgr7gQ0OZnQ+coj2gRWf3Azi+vqRWgwWW7
	GqSoOB3bYyWAuIBQ8FNosAJ4W1LO9zbh5aSKDSeO8wzOTQ7QikTLcDfKcinnKZqSvVT8MKPBHCC
	Baqb04aDER82IH+XoXZEX3h2QsjbuBpc=
X-Google-Smtp-Source: AGHT+IGeWfmmiVD+ssLwRhwIZTTBYCiDGcJ3RZ6TNsf81JV/srbaGDAdqu1Iuuwl39G/3fqEJgOJVVT8vD+V8j6+K7Y=
X-Received: by 2002:a05:6830:f8c:b0:744:f08d:15fd with SMTP id
 46e09a7af769-75356769c81mr1159075a34.35.1757669398210; Fri, 12 Sep 2025
 02:29:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912085756.1742-1-cp0613@linux.alibaba.com>
In-Reply-To: <20250912085756.1742-1-cp0613@linux.alibaba.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 12 Sep 2025 11:29:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iZmHCOzcTD6b4XGNXWUWEoO0v_qLMDFNtA43XLAOmhZQ@mail.gmail.com>
X-Gm-Features: Ac12FXxsc-mPa-B2SuO9WYf97fhF_zumJJvBySHCsZ_mNDXoskJXIYgRlmfjhvU
Message-ID: <CAJZ5v0iZmHCOzcTD6b4XGNXWUWEoO0v_qLMDFNtA43XLAOmhZQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: SPCR: Support Precise Baud Rate filed
To: cp0613@linux.alibaba.com
Cc: rafael@kernel.org, lenb@kernel.org, guoren@kernel.org, 
	jeeheng.sia@starfivetech.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 10:58=E2=80=AFAM <cp0613@linux.alibaba.com> wrote:
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
>  drivers/acpi/spcr.c | 56 ++++++++++++++++++++++++++-------------------
>  1 file changed, 33 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> index cd36a97b0ea2..69142c2ac4b3 100644
> --- a/drivers/acpi/spcr.c
> +++ b/drivers/acpi/spcr.c
> @@ -146,29 +146,39 @@ int __init acpi_parse_spcr(bool enable_earlycon, bo=
ol enable_console)
>                 goto done;
>         }
>
> -       switch (table->baud_rate) {
> -       case 0:
> -               /*
> -                * SPCR 1.04 defines 0 as a preconfigured state of UART.
> -                * Assume firmware or bootloader configures console corre=
ctly.
> -                */
> -               baud_rate =3D 0;
> -               break;
> -       case 3:
> -               baud_rate =3D 9600;
> -               break;
> -       case 4:
> -               baud_rate =3D 19200;
> -               break;
> -       case 6:
> -               baud_rate =3D 57600;
> -               break;
> -       case 7:
> -               baud_rate =3D 115200;
> -               break;
> -       default:
> -               err =3D -ENOENT;
> -               goto done;
> +       /*
> +        * SPCR 1.09 defines Precise Baud Rate Filed contains a specific
> +        * non-zero baud rate which overrides the value of the Configured
> +        * Baud Rate field. If this field is zero or not present, Configu=
red
> +        * Baud Rate is used.
> +        */
> +       if (table->precise_baudrate)
> +               baud_rate =3D table->precise_baudrate;
> +       else {

The outer braces here are redundant and if you combined the "else"
above with the "switch ()" statement below in one line, the patch
would be smaller.

> +               switch (table->baud_rate) {
> +               case 0:
> +                       /*
> +                        * SPCR 1.04 defines 0 as a preconfigured state o=
f UART.
> +                        * Assume firmware or bootloader configures conso=
le correctly.
> +                        */
> +                       baud_rate =3D 0;
> +                       break;
> +               case 3:
> +                       baud_rate =3D 9600;
> +                       break;
> +               case 4:
> +                       baud_rate =3D 19200;
> +                       break;
> +               case 6:
> +                       baud_rate =3D 57600;
> +                       break;
> +               case 7:
> +                       baud_rate =3D 115200;
> +                       break;
> +               default:
> +                       err =3D -ENOENT;
> +                       goto done;
> +               }
>         }
>
>         /*
> --

