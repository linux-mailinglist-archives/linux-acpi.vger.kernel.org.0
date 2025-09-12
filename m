Return-Path: <linux-acpi+bounces-16733-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CDFB5503D
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 16:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C925189A97A
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 14:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC98F2C11E6;
	Fri, 12 Sep 2025 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1Q8ddkK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AE926FDB6
	for <linux-acpi@vger.kernel.org>; Fri, 12 Sep 2025 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757685790; cv=none; b=h5it2DtPQI7l9mt647LAUtROnQWT3SPiNFr9u2EFXPdELNxCUkj0GWZL3PGdp+OlPh1v3MBWktpIjCdHaek9y4FKFXkovAOVUTPibUlTogMVNKLgaNl6PBg51JeCKZcN4RpdyG7SrLu1+i9EY5zYaodXAay3zuB/mKznNoqKrlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757685790; c=relaxed/simple;
	bh=P6j52c1ZBID9nSzuMUN4OsHR4CI2OCt0NbRs7SSigUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eVMuqOyRupfMVNgFnNM4RLyCpF50h3LPzw/zZdxB+++z5G1CDfoSEugevu1xlO+jt1xz80eT+dh5/jwUennXxr23Ny9Xpsa3igfHjrahlpRroh4JVwQUMB3gcGVSm3BGtVuRagUdXs5SxDBHO9Eu2/yuDGN/6c8qHGzVRC4YEC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1Q8ddkK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C6DC4CEF1
	for <linux-acpi@vger.kernel.org>; Fri, 12 Sep 2025 14:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757685790;
	bh=P6j52c1ZBID9nSzuMUN4OsHR4CI2OCt0NbRs7SSigUY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n1Q8ddkKGw+dh/3W9+Abb6EQMna0gOjdCFY8WTNm2BFWky5TtzdBvWHYy0aMNUUGs
	 SsRWbu8mzs0M8xSM9v+iT4bHK2ifbN20A91E6bIcbTanRKfA0hOaJZuLrI8aNFk1Oa
	 5dVxgQCebFJMDA5/KbJF5dN3yRMduV2lh/FV42RwoVj8YRZkQN2zkiHwb6nZhecifB
	 fQWVQbjqxHTCCWL/EsUopMllLZyulJZIqhEoIHflgxh1sqh333j4+kS+iQN2XjHIL7
	 iSK4AFRMb74jsGwkoqfLjmyGDDo4+XOw6b4XR7jzP2VJIeyLi6YFbCkuFPLRzJSIUz
	 cGHDUhJ9tpWFQ==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-746d7c469a8so1750489a34.3
        for <linux-acpi@vger.kernel.org>; Fri, 12 Sep 2025 07:03:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfiFj4PNLsbvlQ0mF79f/XHnNB6RKL1RQrZH7p7aiTCNP7TL4MUrQN4vBBvK4cClTNj6W20qpJ6vzM@vger.kernel.org
X-Gm-Message-State: AOJu0YyTsdAWHiVzIODQ8qomxahvbsTY5c77Y8fglibguzseckGXbWxE
	f88o8KK9SR8v7C3pX0PdoxKfbsZ1HlQqETkz9vNpuTlAs5AVWKWlrn4hkreA05L8QJClw5T2VA+
	xvZksSIqS9xQkm5buB9Pdyu3MSfVapVA=
X-Google-Smtp-Source: AGHT+IGhBy1gpmzVXCHhAB87qYksRZOt/cHDn7hmpgZGeeYQzrGTyprkXl4IqCCdm6dUgWcM9326p9pUbWRwlMnbBF8=
X-Received: by 2002:a05:6830:699b:b0:745:5653:15d4 with SMTP id
 46e09a7af769-753550e2c1dmr1524988a34.22.1757685789582; Fri, 12 Sep 2025
 07:03:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912122514.2303-1-cp0613@linux.alibaba.com>
In-Reply-To: <20250912122514.2303-1-cp0613@linux.alibaba.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 12 Sep 2025 16:02:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j1xJ04dWZWKaM_jxZ9aKfZWg40kvxS4s+meWitasRJng@mail.gmail.com>
X-Gm-Features: Ac12FXxe51JvThurYq7qgUlL7CMkQrsbXiNHC29_jlLEdpWm8TKb3U462SEUkAs
Message-ID: <CAJZ5v0j1xJ04dWZWKaM_jxZ9aKfZWg40kvxS4s+meWitasRJng@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: SPCR: Support Precise Baud Rate filed
To: cp0613@linux.alibaba.com
Cc: rafael@kernel.org, lenb@kernel.org, guoren@kernel.org, 
	jeeheng.sia@starfivetech.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 2:25=E2=80=AFPM <cp0613@linux.alibaba.com> wrote:
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
>  drivers/acpi/spcr.c | 54 ++++++++++++++++++++++++++-------------------
>  1 file changed, 31 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> index cd36a97b0ea2..a97b02ee5538 100644
> --- a/drivers/acpi/spcr.c
> +++ b/drivers/acpi/spcr.c
> @@ -146,29 +146,37 @@ int __init acpi_parse_spcr(bool enable_earlycon, bo=
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
> +       else switch (table->baud_rate) {

Please do not change the indentation below.

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
>         }
>
>         /*
> --
> 2.49.0
>

