Return-Path: <linux-acpi+bounces-19463-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79318CAA44D
	for <lists+linux-acpi@lfdr.de>; Sat, 06 Dec 2025 11:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 644E1309F83D
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Dec 2025 10:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AF7239570;
	Sat,  6 Dec 2025 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGRRSX/c"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4BE3B8D62
	for <linux-acpi@vger.kernel.org>; Sat,  6 Dec 2025 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765018009; cv=none; b=YnKBFZKGrijRfbgMVEvIs1FS9Fx1iC4QEG+WsAHgGZfwZ3mZQM2/qoEOGRzF1SbgpA4OcmX+VK0S9bcBhl4pjeyMNYdXJqszL3EL4dGvcszYTqVT5hFb8cphwq/IuBxruuM9OlBzG5m5bALh+QBOYiysS6sDKS1ciQ+PWJn/4s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765018009; c=relaxed/simple;
	bh=3Ne55HYvIGzsxE6lBs+J9kvbp/auKRJ4342PVym7TfI=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NeOHwPhoUVq6KafzYcKEsnC9V1wF4m6SVS6bubDc+CE+DVgmBiL7LODAfkniX1a95Jc4S5r8z5idC3MJzXz8t+luQ8pzCEl2a4niNlmMW2rkGqL0qUrNWozydOzyBc9/bJX6itr1Kn42SQshfAatU45lnX28jnzfCKJI67HKFkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGRRSX/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4F0C19422
	for <linux-acpi@vger.kernel.org>; Sat,  6 Dec 2025 10:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765018009;
	bh=3Ne55HYvIGzsxE6lBs+J9kvbp/auKRJ4342PVym7TfI=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=uGRRSX/c/aOb4dI6VJNdlNlbmzU46hSBfEyJaA5zKbQKru9u/AoK2sOldX3gKjK9N
	 d/KfMOwSXCaTGUf9BwsRg6SyXEbcUqUEzEC2L5FfgMhQjxfG4SAaoidfpKaDYL8kEh
	 63upVZQzv6DZa1guZ7MRu89mjuVtgo/rNSDe3eSbWyH4sUjRMiEuGzyEfNArJLIU7o
	 dNGTqvb7AUP50XvVBdDpDCDoTCv4sqWBimFVrIeXtZdqedNR3lgiK4Hu76aClV0juY
	 MEO+dl7lRUWUPJrp9ig37qISGVezESFoIM8dkFMA4hg3fJZHJKdINZDNwMfuAJW4+l
	 GWZh9oPB+vMLQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-597d57d8bb3so2518143e87.3
        for <linux-acpi@vger.kernel.org>; Sat, 06 Dec 2025 02:46:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXQ88Qw/tqkrZsxC3a3uRGJWbPeJkiYeuLTcXpbz0+iU26EdkbJrOctkqJi8nzpPiBO/hAIniii/IwD@vger.kernel.org
X-Gm-Message-State: AOJu0YxVvK2MM23p6tNd/mBHpxqAit1vgHbo+eX2NjUfizVLDY6Bj1YY
	ntaUfRpegcUY3EMWDYlZnmMxzdas9Feckd0IMutvSGfhd5D+DHnfDmu0dCRpCVj7ca68t0EXia7
	8/dS5c9zuFf1Lqsk4QA4dpddj4Qq0U32i9d3wNZJ32Q==
X-Google-Smtp-Source: AGHT+IHjoTCsoXdOpEYFwbC11jycFi+lPXHBD3lo6btqHsUrnQCOleubWzoKMCLteiJ+hJuRMdyLLJxIfO2MOTTbpPY=
X-Received: by 2002:a05:6512:a96:b0:595:7e9c:ce00 with SMTP id
 2adb3069b0e04-5987e8be416mr630010e87.25.1765018007594; Sat, 06 Dec 2025
 02:46:47 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 6 Dec 2025 02:46:46 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 6 Dec 2025 02:46:46 -0800
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20251205230724.2374682-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205230724.2374682-1-safinaskar@gmail.com>
Date: Sat, 6 Dec 2025 02:46:46 -0800
X-Gmail-Original-Message-ID: <CAMRc=MfN_gak+b2hmaZQKno1ehCKPDrH0UvGcXDsdye-MjDVow@mail.gmail.com>
X-Gm-Features: AQt7F2p5gAad-Rcjwp1NtHEEbD32fqDeg8j4vtF6lmcmVkYXUW6ISuG07Qo4dTw
Message-ID: <CAMRc=MfN_gak+b2hmaZQKno1ehCKPDrH0UvGcXDsdye-MjDVow@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: Add quirk for Dell Precision 7780
To: Askar Safin <safinaskar@gmail.com>
Cc: Mika Westerberg <westeri@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, Dell.Client.Kernel@dell.com, 
	Mario Limonciello <superm1@kernel.org>, patches@lists.linux.dev, 
	Askar Safin <safinaskar@zohomail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi!

Thanks for the patch.

On Fri, 5 Dec 2025 23:32:42 +0100, Askar Safin <safinaskar@gmail.com> said:
> Dell Precision 7780 often wakes up on its own from suspend. Sometimes
> wake up happens immediately (i. e. within 7 seconds), sometimes it happens
> after, say, 30 minutes.
>
> Fixes: 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
> Reported-by: Askar Safin <safinaskar@zohomail.com>
> Link: https://lore.kernel.org/linux-i2c/197ae95ffd8.dc819e60457077.7692120488609091556@zohomail.com/
> Cc: <stable@vger.kernel.org>
> Tested-by: Askar Safin <safinaskar@gmail.com>
> Signed-off-by: Askar Safin <safinaskar@gmail.com>

Please don't add Tested-by, Reported-by, etc. if you're the author of the.
Tested-by should be added by someone else who tested your patch, it doesn't
make much sense otherwise because I sure do expect you test your changes if
you have access to the right hardware. :)

> ---
>  drivers/gpio/gpiolib-acpi-quirks.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
> index 7b95d1b03361..a0116f004975 100644
> --- a/drivers/gpio/gpiolib-acpi-quirks.c
> +++ b/drivers/gpio/gpiolib-acpi-quirks.c
> @@ -370,6 +370,28 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
>  			.ignore_wake = "ASCP1A00:00@8",
>  		},
>  	},
> +	{
> +		/*
> +		 * Spurious wakeups, likely from touchpad controller
> +		 * Dell Precision 7780
> +		 * Found in BIOS 1.24.1
> +		 *
> +		 * Found in touchpad firmware, installed by Dell Touchpad Firmware Update Utility version 1160.4196.9, A01
> +		 * ( Dell-Touchpad-Firmware-Update-Utility_VYGNN_WIN64_1160.4196.9_A00.EXE ),
> +		 * released on 11 Jul 2024
> +		 *
> +		 * https://lore.kernel.org/linux-i2c/197ae95ffd8.dc819e60457077.7692120488609091556@zohomail.com/
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_FAMILY, "Precision"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Precision 7780"),
> +			DMI_MATCH(DMI_BOARD_NAME, "0C6JVW"),
> +		},
> +		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
> +			.ignore_wake = "VEN_0488:00@355",
> +		},
> +	},
>  	{} /* Terminating entry */
>  };
>

Looks good to me, but I'll give GPIO ACPI maintainers time to chime in.

Bart

