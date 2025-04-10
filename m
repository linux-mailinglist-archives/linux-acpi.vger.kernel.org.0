Return-Path: <linux-acpi+bounces-12943-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD1BA843B7
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 14:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64BBA8C787E
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 12:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1B82853EC;
	Thu, 10 Apr 2025 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0DUz9FT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D44328153D;
	Thu, 10 Apr 2025 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744289430; cv=none; b=tnHeemmji0chetH9/v4LxE6C9rWiMbKjUZ6+78I5N/k7ckEL0bUJoZ5oZ3IF4NtgaMwkM+3boVISsXH6kz4v8iUk+ytcJstodwwlMjXOxp9qvKgOGpyFC9mkh9RTWY8gPq/PJFuig/mePzCR5cvz7xmSImMCcKy0VYKQ7Jcn3mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744289430; c=relaxed/simple;
	bh=uJzUxpoNSO6SWcqYR35HQPnvYoeY0LWgy7coqirlstg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYSKKAqKbNYSOwi8BKV1ukFdpYuY0ch86EqukkUeOItan5oQRlSDOxCgdXWn4GlaCzeBtC6WCD1JQ3iyP8BYoAHADgahUeBbtFCwtiQ/eau8bs5qKM0hjFVmA+Nx7cqUJpGXOvzxKKXDAVzezabxUQ+vqaDc6PNCXQWQl2mmaQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0DUz9FT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE541C4CEDD;
	Thu, 10 Apr 2025 12:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744289429;
	bh=uJzUxpoNSO6SWcqYR35HQPnvYoeY0LWgy7coqirlstg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j0DUz9FTKNj2gjUqBFMmONzn95DngrwIB+bJg525Q/17vIK3mOWA46ScRy438ZmX+
	 xmHWouAO96GFdSeSLWpdN+w4YMT6EfoDpRPMt7rGvYKvBOkKC3PTmsSDFhIzYvTFIT
	 qTum3w9VG/1AuGPWjz8yU8JPm5u1rZUXtmvieNOP2l9UJY8RXoum59FZTRQ3Ic3wNk
	 6Mli8bCrI+Q0QlPbR6Wxe6hvVDRSDpj/zZap+FF1WaaDbFAj4Z27us71C+f5utpP8A
	 kzY18RmT1SBAyRxpyoeqOTEcaGysjJHPccDrNc7N4DWdAQAP78E9LzpDkGLDTBWoy1
	 ohIQ31V11tsuQ==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2c873231e7bso426073fac.3;
        Thu, 10 Apr 2025 05:50:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1g2IjV+3AzaGC275j1FC0cAuopYQQIr/YIWmKwGczmRxmCdVqMERMpvAQCccvbnRl60+FNKgiRKfqU9Tq@vger.kernel.org, AJvYcCVDKYz9FrM50lUOp1DXXBkvPy3jIM9ptmiQJaQariBz6PYnaMypSGNRn36zlIUXBp8uehAlj2l+kfvJGg==@vger.kernel.org, AJvYcCWpcnP9co+phdQ09hr3denHA6cd4ULoU7W+kpOWy22eDVtWpQV2/jfZGdxB3ZoTd/KpwqiO0q7FE0en@vger.kernel.org
X-Gm-Message-State: AOJu0YzMUZDyXYvE97zuoNdPhf7HIaaZ6sJdJKjFY00bDKA6M0/xsdST
	AagLw2cekF92uDHYFTNkGY1y2FcQfn3fjiaSdnHMB99yPIp7Twu8nvnMDJenfYkzD9j7Fz3GF2m
	Wh6XeQI9wCbjoQLA/vGUEeM0jtx4=
X-Google-Smtp-Source: AGHT+IHFzwPrEmySuJaupjRzR4Wv7Ke41Xi8JgorWkvFGR+1FexOkaeXGD1OVzHfGT9xJtKTy8iP8aJb0FxwdY6g3WM=
X-Received: by 2002:a05:6871:2011:b0:29e:1325:760a with SMTP id
 586e51a60fabf-2d0b35731e4mr1319762fac.8.1744289429041; Thu, 10 Apr 2025
 05:50:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409213521.2218692-1-superm1@kernel.org>
In-Reply-To: <20250409213521.2218692-1-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 10 Apr 2025 14:50:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h9v+OmqzRDuBAXBHY1oWq3BizP9FxyzdqkmJ353KjO1w@mail.gmail.com>
X-Gm-Features: ATxdqUHP9ee7eBOj6IHh8hkBv0pJjYFDy8ridrhNBZLbpKo84c9kY5vKmXoj2m0
Message-ID: <CAJZ5v0h9v+OmqzRDuBAXBHY1oWq3BizP9FxyzdqkmJ353KjO1w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: amd: Fix use of undeclared identifier 'pinctrl_amd_s2idle_dev_ops'
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, 
	"open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	linux-acpi@vger.kernel.org, Basavaraj Natikar <Basavaraj.Natikar@amd.com>, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 11:35=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> `pinctrl_amd_s2idle_dev_ops` is hidden under both `CONFIG_ACPI` and
> `CONFIG_PM_SLEEP` so the functions that use it need the same scope.

Shouldn't this be CONFIG_SUSPEND given what's going on in acpi.h?

Also, there is one more report regarding pinctrl_dev being unused:

https://lore.kernel.org/linux-acpi/202504101106.hPCEcoHr-lkp@intel.com/T/#u

Any chance to address all of this in one patch?

> Adjust checks to look for both.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202504100420.88UPkUTU-lkp@i=
ntel.com/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pinctrl/pinctrl-amd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.=
c
> index b6fafed79b289..472a5aed4cd05 100644
> --- a/drivers/pinctrl/pinctrl-amd.c
> +++ b/drivers/pinctrl/pinctrl-amd.c
> @@ -1209,7 +1209,7 @@ static int amd_gpio_probe(struct platform_device *p=
dev)
>
>         platform_set_drvdata(pdev, gpio_dev);
>         acpi_register_wakeup_handler(gpio_dev->irq, amd_gpio_check_wake, =
gpio_dev);
> -#ifdef CONFIG_ACPI
> +#if defined(CONFIG_ACPI) && defined(CONFIG_PM_SLEEP)
>         acpi_register_lps0_dev(&pinctrl_amd_s2idle_dev_ops);
>  #endif
>
> @@ -1230,7 +1230,7 @@ static void amd_gpio_remove(struct platform_device =
*pdev)
>
>         gpiochip_remove(&gpio_dev->gc);
>         acpi_unregister_wakeup_handler(amd_gpio_check_wake, gpio_dev);
> -#ifdef CONFIG_ACPI
> +#if defined(CONFIG_ACPI) && defined(CONFIG_PM_SLEEP)
>         acpi_unregister_lps0_dev(&pinctrl_amd_s2idle_dev_ops);
>  #endif
>  }
> --
> 2.43.0
>
>

