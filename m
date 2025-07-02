Return-Path: <linux-acpi+bounces-14955-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF235AF60DD
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 20:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5BD84A73D6
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 18:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9620730E837;
	Wed,  2 Jul 2025 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMEdRPZb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDCE146585;
	Wed,  2 Jul 2025 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751480018; cv=none; b=KAkzod9Y2kVHky51fpGxeigyev82h6RRdqptaa+nqf354kqFT6n0H1sHGmYdrqeng4s2O+Zib7TJbA0Vycdf2jnt7olyy9bR+F7EYnNylom9OiCsGZHKcAIWxUJbf35aAkKp0NjFn/JSeHkmQqQuJhSC/30UpmcWHw7hX/2Woko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751480018; c=relaxed/simple;
	bh=WF/0dHVdirppJqFpIVaFs89IP6yovH3r/B0isPubmUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hu6abqakQr+8rVR6asKv7dYF/tcWvIma4GinNPcLMWFyF3VGM2RKYG2eBXyRoUqdZLJCsByLWbAZ1M8SBaK8VDiBs6G4n6Ft7G9Z6ji2twa8JlZb+5FPTRAHo6Kt11OuVix7j0qEL6vJ3BBwl50OS/WTasewGNXOyqCywWAt4lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMEdRPZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB502C4CEEE;
	Wed,  2 Jul 2025 18:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751480016;
	bh=WF/0dHVdirppJqFpIVaFs89IP6yovH3r/B0isPubmUk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KMEdRPZbvcDGTMdQLIFR/HU/n70x4rhpeKMmbz9JXV80U3aH9VAKMPk16sR8Y8sti
	 d2fPjw0MT/z2j4cD9F3Z6qqbEYkIJuNS/dChoZ6uQQdl61fRUEdbea5OO8gU9vOfgC
	 U/hgIhQbdXk9JO3PrdwFxluH+G0mV71M7yw+A+AS9Xh1nIvxFHkIYgPZ7rhtVv8AxT
	 P2O52bG7bXqblUuwhdXU3sR5Y1fA6Ly6TSH8FiJN8gVZkbZj/l4/uSGGo7iMJOYikZ
	 AdOzGYKfeD1G4LtNhOgfdfzdihYezvRFhA7uaZh6se1H1pueN97yexrebiDAHB93X5
	 yB8dVr6Uw4yKw==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-40ad1f7c23bso3097031b6e.2;
        Wed, 02 Jul 2025 11:13:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5u2y/2QdVYFIBuN4NjCQCOxr4mStNGk1xuB9Lg0HVNRORl5jUGrLvYTSckEZqbg2nCo/tR4VF953TfHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdHIOlBXfRuzqpWsFvyiaD53YJHZEuk7omca4cj7Rt79JnK8jU
	VVulzlG47qDx8JJ2G3GTY45ppf979mxl8hk2Lyrg8mXmyooXxeOwCVGu8QY8/OC8+RKoUe8jhbo
	CHJNd8G3/Kd9pIkcF5B5LwB4Q8MdVhZM=
X-Google-Smtp-Source: AGHT+IGrn3yRCfGv0z9KufBXr+rbIFC/+VTu20HxGSbK5HNdnevoICw0BmOeORpf1WCwvMX6JjF0vsxfvxBKD40abWA=
X-Received: by 2002:a05:6808:4f47:b0:401:e721:8b48 with SMTP id
 5614622812f47-40b8851fe75mr3071513b6e.8.1751480016128; Wed, 02 Jul 2025
 11:13:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626132635.221064-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250626132635.221064-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Jul 2025 20:13:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0huv1YM4koNy_bsj-m0MPyjAi2LDBEv3beATvMgmzowMA@mail.gmail.com>
X-Gm-Features: Ac12FXxQQ2otL1ghgDVvYSmWMCHpUTJL3RW-VtDHDEqYqqUroiDCbxw6I8103R8
Message-ID: <CAJZ5v0huv1YM4koNy_bsj-m0MPyjAi2LDBEv3beATvMgmzowMA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ACPI: LPSS: Remove AudioDSP related ID
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Cezary Rojewski <cezary.rojewski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 3:26=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The AudioDSP drivers are in control for all functions of the hardware
> they have (they are multi-functional devices). The LPSS driver prepares
> for enumeration only single devices, such as DMA, UART, SPI, I=C2=B2C. He=
nce
> the registration of AudioDSP should not be covered. Moreover, the very
> same ACPI _HID has been added by the catpt driver a few years ago.
>
> And even more serious issue with this, is that the register window at
> offset 0x800 is actually D-SRAM0 in case of AudioDSP and writing to it
> is a data corruption.
>
> That all being said, remove the AudioDSP ID from the LPSS driver,
> where it doesn't belong to.
>
> Fixes: c2f8783fa2d0 ("ASoC: Intel: Add common SST driver loader on ACPI s=
ystems")
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
> Tested-by: Cezary Rojewski <cezary.rojewski@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>
> v2: fixed Fixes (Cezary), added tags (Cezary)
>
>  drivers/acpi/x86/lpss.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/acpi/x86/lpss.c b/drivers/acpi/x86/lpss.c
> index 258440b899a9..6daa6372f980 100644
> --- a/drivers/acpi/x86/lpss.c
> +++ b/drivers/acpi/x86/lpss.c
> @@ -387,9 +387,6 @@ static const struct acpi_device_id acpi_lpss_device_i=
ds[] =3D {
>         { "INT3435", LPSS_ADDR(lpt_uart_dev_desc) },
>         { "INT3436", LPSS_ADDR(lpt_sdio_dev_desc) },
>
> -       /* Wildcat Point LPSS devices */
> -       { "INT3438", LPSS_ADDR(lpt_spi_dev_desc) },
> -
>         { }
>  };
>
> --

Applied as 6.17 material, thanks!

