Return-Path: <linux-acpi+bounces-11928-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC4EA56A6B
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Mar 2025 15:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365C41899360
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Mar 2025 14:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3174121ABC3;
	Fri,  7 Mar 2025 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSxEsxKH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CE618DF65;
	Fri,  7 Mar 2025 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357989; cv=none; b=dUm6cG/VlFtnnylnjSWoUHZeNJL/sqajrlQrRA7evBSb1hLLh5rAUL2+r445gNVqad/kVyDRKYFwun60aSTxYbqjnmiKu1uS+9FKOXd9+3f//F+fLcPj/zNC2cChXvAJVgyb1GSfFmsHfCOqnSAS/SMq3x5IBCG0+nNYksKXscU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357989; c=relaxed/simple;
	bh=ds39+UT+aZiDWG3+FmAy+kmjG+K/c4hUCSELmdIo4Fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rg+ob9KTk3azPJvHosDAKRsJ34pxqAntY9Nzs9MHQe4C3y6AQ/lmbluETwrJPiLiTCPKC7A7smib4cEcXyW1bkaoz9RXptLN9J26tiMCPj4fDWr3Kd7KB1kRoHvTnmHecETeOE0lzBpFpj+fYB9SSfc/Mp+sVitJtfvFZaW+gYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSxEsxKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8217AC4AF09;
	Fri,  7 Mar 2025 14:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741357988;
	bh=ds39+UT+aZiDWG3+FmAy+kmjG+K/c4hUCSELmdIo4Fs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iSxEsxKHrZKkSv69CV0oyLo9XY/IEtAQP+OVmd5Eji/VCGmSflSQx2Xk3ShK3aV6t
	 FQNiCi88PXWl+VqrB1xQDz3wQouQvtLlnmwTfI56cpYicTjxbwjvW9XWKxk/DTYiff
	 JOwaPS32dxf/IERj2B1q2RG+t/Hwg5tjEtr0z7iVGKu6UlirxVaZym90lQHx7TRk+K
	 lU6mG2LxM/fdbg+w12ceNuC3j65fRL7yKogF7L2sgmR/MRwWwdmlgUn0dBeYzuU3tQ
	 QoktyLg6x/+WHT67gilsX0cz5uhqerg5IqA+nvJbh3mO9Bozb7IFvzCny87k6cQ4Wb
	 5APjyKPO2+Uxw==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2c1caacc1f7so848743fac.3;
        Fri, 07 Mar 2025 06:33:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW/i296+vbQpF6RCKhNHN76jsw7zFLrOhzvZDTvnVIgxXW4aFKl2s7VAJTeldD6UUH1koGK9C0JBy/cXA==@vger.kernel.org, AJvYcCX+k04vWiWTWTVegfmcPvyUEL8j7oxsdWJlrJKRx0JQJEIK2O+VS3RnpcClRR9rVy8O9lQWkN31m4VI@vger.kernel.org, AJvYcCXoeYKWqNjhgjF4f9dtzUNpKCDBwF/4qqI6vss3oq18HlG77zCdupd1csC4X0dWMCINS7drPwvKTkEEOs/o@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu2Tik03CcA1AcmwC/insTcEpFXLt6Ic6upd4wfS4e4PHVwJsT
	eI5lg/rfTpnEda72tZbYx+IUgC+ax3phwQRoMgEcrBRAJTksk4CpmFS2l66ylo++mcdIvii/UQA
	eQO35cr2U0XJSb1IjCobFVFUlEIE=
X-Google-Smtp-Source: AGHT+IEt3zlQUUPbBL6LHpYSds1N4KB969mEzkID/JSA1s1gOufOIYs8i94paT4BSKGX064yhi3F8GRg1IzUCoBinHk=
X-Received: by 2002:a05:6871:690:b0:2c2:3da4:6389 with SMTP id
 586e51a60fabf-2c26118b91cmr1769283fac.23.1741357987744; Fri, 07 Mar 2025
 06:33:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305220146.3932955-1-superm1@kernel.org> <20250305220146.3932955-2-superm1@kernel.org>
In-Reply-To: <20250305220146.3932955-2-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Mar 2025 15:32:56 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iXrDULryT-t9Rt+Cq2i2uBH8tedobtk7h76gZocmiXWg@mail.gmail.com>
X-Gm-Features: AQ5f1JrafWPBJkZcYccu4WhT2uufjUlU94EY1oPKJoCJoEFBC0DLhifgZdOBnmk
Message-ID: <CAJZ5v0iXrDULryT-t9Rt+Cq2i2uBH8tedobtk7h76gZocmiXWg@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND 1/2] ACPI: Add missing prototype for non
 CONFIG_SUSPEND/CONFIG_X86 case
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, 
	"open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	linux-acpi@vger.kernel.org, Basavaraj Natikar <Basavaraj.Natikar@amd.com>, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 11:01=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> acpi_register_lps0_dev() and acpi_unregister_lps0_dev() may be used
> in drivers that don't require CONFIG_SUSPEND or compile on !X86.
>
> Add prototypes for those cases.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502191627.fRgoBwcZ-lkp@i=
ntel.com/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v3:
>  * Add struct acpi_s2idle_dev_ops outside defines too
> ---
>  include/linux/acpi.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 4e495b29c640f..8d2abe5dede93 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1115,13 +1115,13 @@ void acpi_os_set_prepare_extended_sleep(int (*fun=
c)(u8 sleep_state,
>
>  acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
>                                            u32 val_a, u32 val_b);
> -#if defined(CONFIG_SUSPEND) && defined(CONFIG_X86)
>  struct acpi_s2idle_dev_ops {
>         struct list_head list_node;
>         void (*prepare)(void);
>         void (*check)(void);
>         void (*restore)(void);
>  };
> +#if defined(CONFIG_SUSPEND) && defined(CONFIG_X86)
>  int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
>  void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg);
>  int acpi_get_lps0_constraint(struct acpi_device *adev);
> @@ -1130,6 +1130,13 @@ static inline int acpi_get_lps0_constraint(struct =
device *dev)
>  {
>         return ACPI_STATE_UNKNOWN;
>  }
> +static inline int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg=
)
> +{
> +       return -ENODEV;
> +}
> +static inline void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *=
arg)
> +{
> +}
>  #endif /* CONFIG_SUSPEND && CONFIG_X86 */
>  void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
>  #else
> --

Applied as 6.15 material, thanks!

