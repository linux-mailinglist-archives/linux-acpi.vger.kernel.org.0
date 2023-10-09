Return-Path: <linux-acpi+bounces-538-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD787BE32C
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Oct 2023 16:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8662628124D
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Oct 2023 14:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3314535887
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Oct 2023 14:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Je6qy/HQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AB9321D
	for <linux-acpi@vger.kernel.org>; Mon,  9 Oct 2023 12:50:22 +0000 (UTC)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CDD94
	for <linux-acpi@vger.kernel.org>; Mon,  9 Oct 2023 05:50:21 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7abda795363so1931125241.0
        for <linux-acpi@vger.kernel.org>; Mon, 09 Oct 2023 05:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696855820; x=1697460620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLWvYmUYdE0xN9B1W9TIs+PCJHSr+Ef1uMZQZXLtR8Q=;
        b=Je6qy/HQlt5Hkfn9IEapBH554UeU88MfqfZt1pn6t5s6wDL9yIA556SHfZoUL5ktJw
         KZKxnpcd0cnSRXgduMozKgoi1y9azdM82GvWUoY9mhnXKlPe8HyXQW/sSEtEKAocc6Ta
         3jrd8ORUnEP1ohvqdwyp7/SeOzfDDFn+gdVJ4ykslCFf9uq3DBHA10an1iTfKVirjowF
         KlW97dBnBMJtyOvec4VpM2hHNWcsaw96im4ram3LUMsaI3wGVk5bSxS0RgbKRSQZaW89
         Z+RNx+3dLgniBxSO++ILFkhuMvBtVZYqbt/IXAiJclu9dkbBX4ZqwiByIE/AdqExqMza
         aN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696855820; x=1697460620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLWvYmUYdE0xN9B1W9TIs+PCJHSr+Ef1uMZQZXLtR8Q=;
        b=fmp7j2fTdflCeQfmTRjmQkEr9Cc/d8iR4Ger4KnSXd150xzDzk4rFabKAoENRIVQbV
         1Jeh2W7mhlpA0E9ppRJ60YBkh6q6VaRgwzW3OtLwVMnxSFHRgoOhVAbJ5FRJx2kCp5Nw
         6wHR/mzdFw8SVbP/mXFBb+0I3F+X6TgjdXrJu4Qu2tgE1su/1SvpRmIDigebUx2pDLGt
         ksaujb+xmZjXuD5OibP2VvAvuGuoE282nBiiAYRDUJ3agst2NHImuu5R4uARzFIM0OHe
         SYIHpwtu4N42re9TamTOmBd4FIlq5sODxtNGV2ywxmnHlFe3tv+G0Y384ssyNUiQZw1A
         V5mw==
X-Gm-Message-State: AOJu0YwcKzvevSuXqrmVLpT/xy3iN7bYxylQVc/FEyEAACwQ8UdAJhUI
	RfDX50SFvsK1PIWgyjPG77MXHZIov2zZiBdnTofDIHdpGYPWaql1ab0=
X-Google-Smtp-Source: AGHT+IFaZQHpN4+6inudkN2uqYcpszhAsxEnHU1O2xqvZth+Gse3cBocqCIrOYJ5YrFBZ+hMfeSkQnSqbZAQE39Z67Y=
X-Received: by 2002:a1f:ed02:0:b0:4a0:6fd4:4333 with SMTP id
 l2-20020a1fed02000000b004a06fd44333mr2557626vkh.13.1696855820403; Mon, 09 Oct
 2023 05:50:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8bbffb51-96bc-c4b-8d13-f3bbf9a72c2@linux.intel.com>
In-Reply-To: <8bbffb51-96bc-c4b-8d13-f3bbf9a72c2@linux.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 9 Oct 2023 14:50:09 +0200
Message-ID: <CAMRc=MfJ0fkFdXffe+yMqj4aVeq830q4TT05YGszyAa=dqd2UQ@mail.gmail.com>
Subject: Re: [GIT PULL] Immutable branch between pdx86 int3472 branch and GPIO
 due for the v6.7 merge window.
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, platform-driver-x86@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 2:19=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> Hi Bart, Linus, et. al.,
>
> Here's a pull-req for merging into the GPIO tree.
> This removes the users for acpi_get_and_request_gpiod() so it
> can be removed.
>
>  - i.
>
>
> The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d=
1d:
>
>   Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-=
x86.git tags/platform-drivers-x86-ib-int3472-v6.7
>
> for you to fetch changes up to 5ccf9873ab2bcb7c480bc2ccea55ec235d9db175:
>
>   platform/x86: int3472: Switch to devm_get_gpiod() (2023-10-06 13:34:58 =
+0300)
>
> ----------------------------------------------------------------
> Immutable branch between pdx86 int3472 branch and GPIO due for the v6.7 m=
erge window.
>
> platform-drivers-x86-ib-int3472-v6.7: v6.6-rc1 + platform-drivers-x86-int=
3472
> for merging into the GPIO subsystem for v6.7.
>
> ----------------------------------------------------------------
> Bartosz Golaszewski (1):
>       platform/x86: int3472: Add new skl_int3472_gpiod_get_from_temp_look=
up() helper
>
> Hans de Goede (3):
>       platform/x86: int3472: Add new skl_int3472_fill_gpiod_lookup() help=
er
>       platform/x86: int3472: Stop using gpiod_toggle_active_low()
>       platform/x86: int3472: Switch to devm_get_gpiod()
>
>  .../platform/x86/intel/int3472/clk_and_regulator.c |  54 ++---------
>  drivers/platform/x86/intel/int3472/common.h        |   7 +-
>  drivers/platform/x86/intel/int3472/discrete.c      | 103 +++++++++++++++=
+-----
>  drivers/platform/x86/intel/int3472/led.c           |  24 +----
>  4 files changed, 94 insertions(+), 94 deletions(-)

Pulled, thank you!

Bart

