Return-Path: <linux-acpi+bounces-15067-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4541AFCA70
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jul 2025 14:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03FC1AA3657
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jul 2025 12:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FAB21C9E4;
	Tue,  8 Jul 2025 12:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdM6olfS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C162D78A;
	Tue,  8 Jul 2025 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751977847; cv=none; b=SkeP2IQV4Fmm7rtp4i+VRArYtpDg6sg8qzGps5bUbgGiGT01g+Vfau5yQj773CmFnRQH5GJLu9b+Rre1lxEJIS906X6IwO6qfdUdMUnBtsV7RkjFG1JoJDjxPWpGCx2W+JYiozijK3EA1gAZrQpQSbIusDYRjwT5QU9kuLwVu/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751977847; c=relaxed/simple;
	bh=VxWPbYy47hxFeuAvpDo2msL5xXtgStGf3sel4pyoE6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IzqxRK58ZgMsUp4FtnWQG/EvSy/NwVViZfxXp/Gc3vQ7X3332R68d1rEnmOITJn/wAQQy6hBGOBpsW2T1PQuHFNNCuRS8+tT9QUZ1XqVvwBvVuDU1aeL8wLrHYRhlV4MiA6RcgrRJv4tc2PAAI21QaZ+P0no+7Z5bCKcIEDYAK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdM6olfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5CDC4CEF0;
	Tue,  8 Jul 2025 12:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751977846;
	bh=VxWPbYy47hxFeuAvpDo2msL5xXtgStGf3sel4pyoE6g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CdM6olfSRydJ4Pi7Z0mp8j3SiUiPeCNtlXyFMmck+qZGfW2/s+ACX1hdER2WFMdYj
	 pUmzP9ZdokPqxRXukANQ27mzBq4o+zQBA+eZ4WorV2YkeIanvgksLjCZBj/AHBzVLd
	 vwMjaG9zsFEFazMjlicmTNyb/5CDcg9sgJmeFVyQEK9nUggVVVYMIiGWsQ4LtKlYFY
	 J3Ab+Jopyd1+Ln4OoISZPsupV3/LM44SA1IUxBpnOQ8rcqKPoUHL6YNZ6p+0i9Q8Jd
	 uKvJD6dDD3knO/bQ40UL+N5Rp6VQ7F5B6GfTbIelvFuGjFiN0Jv0RBeeZ1tXtysTFO
	 VqlbX26wAdM4A==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-60bd30dd387so2180443eaf.3;
        Tue, 08 Jul 2025 05:30:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXb5U+nRyvVnWfommcXeavanXqEsBucYEJ/p08etavuaA+2/bGs51wN+unSEuAmKOpaPQQgqdMYjk25dRLz@vger.kernel.org, AJvYcCXjFyGdVNI/0KT49KCn1iuwzxpe9VSYxDTgR2uEe3Ktnt35pUlRMMZTtF8BKrUkTzDvPK8S8voTtx2y@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8uxU7vNJegkAzxAPMe7a8G3Gi1RXIYc0Jy9oO1QsR//RsVpSF
	7DeIMlNvT7XBSWwp6fJ95V9Pl2JkXwDjsk1uQAdtcAy3nOlprZBv5eoNAO3cu3hGoD6ZLWx8E5j
	0xxtO1SELZZzwQxC/7KIRIxVo9m0+OYw=
X-Google-Smtp-Source: AGHT+IETAJtmGBN08soEtncji4XHreUje+WAwVtHThVp2b9Gouo01A+sN2Nql6kk+loSzitExvYV60GmT6cBjHBchnA=
X-Received: by 2002:a05:6820:818f:b0:611:bdaa:5b01 with SMTP id
 006d021491bc7-6138fdb94c0mr12579362eaf.6.1751977845926; Tue, 08 Jul 2025
 05:30:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_3A33B864BD5DC73CBBE10CB481E4C546E107@qq.com>
In-Reply-To: <tencent_3A33B864BD5DC73CBBE10CB481E4C546E107@qq.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 8 Jul 2025 14:30:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h6-LsYoMnPjOWoWpo7DS0hYeT0B6cgYc5sUo+N6-V2pQ@mail.gmail.com>
X-Gm-Features: Ac12FXzoyF7gIcapKdTZDBv6ktKJU2r6O9IM6gtlpVlm35UmTtFicN3i0Tr2am8
Message-ID: <CAJZ5v0h6-LsYoMnPjOWoWpo7DS0hYeT0B6cgYc5sUo+N6-V2pQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: PRM: Update address check for NULL handler
To: shangsong <shangsong2@foxmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shang song <shangsong2@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 11:40=E2=80=AFAM shangsong <shangsong2@foxmail.com> =
wrote:
>
> From: Shang song <shangsong2@lenovo.com>
>
> According to section "4.1.2 PRM Handler Information Structure" in the
> Platform Runtime Mechanism specification, the static data buffer and ACPI
> parameter buffer may be NULL if not required. Therefore, when either
> buffer is NULL, adding a check can prevent invalid virtual address
> conversion attempts.
>
> Without this patch, the following dmesg log could be misleading or
> confusing to users:
>
>   kernel: Failed to find VA for GUID: 7626C6AE-F973-429C-A91C-107D7BE298B=
0, PA: 0x0
>
> Signed-off-by: Shang song <shangsong2@lenovo.com>
> ---
>  drivers/acpi/prmt.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index e549914a636c..a97f0f3a6590 100644
> --- a/drivers/acpi/prmt.c
> +++ b/drivers/acpi/prmt.c
> @@ -155,11 +155,21 @@ acpi_parse_prmt(union acpi_subtable_headers *header=
, const unsigned long end)
>                 th->handler_addr =3D
>                         (void *)efi_pa_va_lookup(&th->guid, handler_info-=
>handler_address);
>
> -               th->static_data_buffer_addr =3D
> -                       efi_pa_va_lookup(&th->guid, handler_info->static_=
data_buffer_address);
> +               /*
> +                * Per section "4.1.2 PRM Handler Information Structure" =
in
> +                * spec "Platform Runtime Mechanism", the static data buf=
fer
> +                * and acpi parameter buffer may be NULL if they are not
> +                * needed.
> +                */
> +               if (handler_info->static_data_buffer_address) {
> +                       th->static_data_buffer_addr =3D
> +                               efi_pa_va_lookup(&th->guid, handler_info-=
>static_data_buffer_address);
> +               }
>
> -               th->acpi_param_buffer_addr =3D
> -                       efi_pa_va_lookup(&th->guid, handler_info->acpi_pa=
ram_buffer_address);
> +               if (handler_info->acpi_param_buffer_address) {
> +                       th->acpi_param_buffer_addr =3D
> +                               efi_pa_va_lookup(&th->guid, handler_info-=
>acpi_param_buffer_address);
> +               }
>
>         } while (++cur_handler < tm->handler_count && (handler_info =3D g=
et_next_handler(handler_info)));
>
> --

This

https://lore.kernel.org/linux-acpi/20250704014104.82524-1-qiyuzhu2@amd.com/

has already been applied.

Thanks!

