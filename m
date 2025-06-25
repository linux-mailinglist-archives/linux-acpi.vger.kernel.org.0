Return-Path: <linux-acpi+bounces-14582-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E478AE7B92
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 11:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7A617A23B
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 09:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AA92877F9;
	Wed, 25 Jun 2025 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aeb4qS6+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3511F2868B0;
	Wed, 25 Jun 2025 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750842570; cv=none; b=Ij2yBAdDR7yp8Q7SVzk9MGmtrRk9/HbdPRbFtn4XROyv1cpqdsON+zI4UzV4pfIzoNFLmrkbom6kHPI96RMHir8lfLTtmcJtecmYTDpk6XjSHu5r0H6TjR60NoYbD2oD91W/h8ctQcOK7epgKh7k4warQWan79yBWj8ojs7JJvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750842570; c=relaxed/simple;
	bh=V7vBNEydW/amovR7HdFYagGMzsF2AlhBDhoAZzPiFLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sE9TbEjk7AjEZnv9Ye83wOZQxdHQZAkCJBM10YRyGBWX6YnzKSGRakDNa3nNACbv+ocMoy7V3iVx2/s6yxDkPDsOoNBun8aD19ViH5p3UraNaSlnM8d3eOJ8Ui5YG+3tMrTpSsKD15049EiCqAJcVR/ixTJ5qwuGB3Gg8Vo0wv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aeb4qS6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9490AC4CEEA;
	Wed, 25 Jun 2025 09:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750842569;
	bh=V7vBNEydW/amovR7HdFYagGMzsF2AlhBDhoAZzPiFLg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Aeb4qS6+iSx5NBdAf2CwapAU13Y0cQ8XFTH1s3biTjv3vB+OqElVo0KBd7L0j5hQc
	 c3LNriL7pCBmZWwznVJWhkwhywx028azM7lgM5RtdhHZxknoMNi038iLXwT3iXv/Qn
	 qOS3vyiAnZVxUWgI2VNEY+rEHLl91Kds/xRp+/lDx3lMWfkJzFwFtQ9Nq+behErpJg
	 4srLJl/OZfOlhlbSSgdFEtALl2CwBLZSdEGTDqqkBDNSX7ieevsaI48AFhOFLIK8eB
	 oTzzGZpmQo4ZC5Hl+yTHds3+93791L9dMIlT1+wsx3cbPYorHXIr01c6Cym7eBKQok
	 +WcolL9/ZziZw==
Message-ID: <4a4d577b-a085-46e8-97b9-6df27461c870@kernel.org>
Date: Wed, 25 Jun 2025 11:09:25 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Revert "Input: soc_button_array - debounce the
 buttons"
To: Mario Limonciello <superm1@kernel.org>,
 Mika Westerberg <westeri@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
 "open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..."
 <linux-input@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
References: <20250624202211.1088738-1-superm1@kernel.org>
 <20250624202211.1088738-3-superm1@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250624202211.1088738-3-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mario,

On 24-Jun-25 10:22 PM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> commit 5c4fa2a6da7fb ("Input: soc_button_array - debounce the buttons")
> hardcoded all soc-button-array devices to use a 50ms debounce timeout
> but this doesn't work on all hardware.  The hardware I have on hand
> actually prescribes in the ASL that the timeout should be 0:
> 
> GpioInt (Edge, ActiveBoth, Exclusive, PullUp, 0x0000,
>          "\\_SB.GPIO", 0x00, ResourceConsumer, ,)
> {   // Pin list
>     0x0000
> }
> 
> Let the GPIO core program the debounce instead of hardcoding it into a
> driver.
> 
> This reverts commit 5c4fa2a6da7fbc76290d1cb54a7e35633517a522.

This is going to cause problems I'm afraid I just checked and
based on randomly checking a few DSDTs of the tablets this driver
is used on, it seems the DSDT always specifies a debounce timeout
of 0 like your example above. And on many many devices using
the soc_button_array driver debouncing is actually necessary.

May I ask what problem you are seeing with the 50ms debounce timeout /
what problem you are exactly trying to fix here ?

drivers/input/keyboard/gpio_keys.c first will call gpiod_set_debounce()
it self with the 50 ms provided by soc_button_array and if that does
not work it will fall back to software debouncing. So I don't see how
the 50 ms debounce can cause problems, other then maybe making
really really (impossible?) fast double-clicks register as a single
click .

These buttons (e.g. volume up/down) are almost always simply mechanical
switches and these definitely will need debouncing, the 0 value from
the DSDT is plainly just wrong. There is no such thing as a not bouncing
mechanical switch.

Regards,

Hans



> 
> Cc: Hans de Goede <hansg@kernel.org>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/input/misc/soc_button_array.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
> index b8cad415c62ca..99490df42b6f2 100644
> --- a/drivers/input/misc/soc_button_array.c
> +++ b/drivers/input/misc/soc_button_array.c
> @@ -219,8 +219,6 @@ soc_button_device_create(struct platform_device *pdev,
>  		gpio_keys[n_buttons].active_low = info->active_low;
>  		gpio_keys[n_buttons].desc = info->name;
>  		gpio_keys[n_buttons].wakeup = info->wakeup;
> -		/* These devices often use cheap buttons, use 50 ms debounce */
> -		gpio_keys[n_buttons].debounce_interval = 50;
>  		n_buttons++;
>  	}
>  


