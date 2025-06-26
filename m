Return-Path: <linux-acpi+bounces-14673-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAA0AE988A
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 10:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C4771C26035
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 08:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D464298CDC;
	Thu, 26 Jun 2025 08:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4FazDF2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F73028725E;
	Thu, 26 Jun 2025 08:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750926920; cv=none; b=uhBsLDbq860ZmyO+C3UJE4adtRa5fudbp+PbFeIP9jWsgAKE5li+He2InIqGiNb+h+yYS6cVoSStC1GcuzzR2qQ65ufPLupXI1iEBEx07QXanidggZLzZ2ZsxYTqfh61CmfFmZzzmX4kvYtvRuBh/sry9t8AEQv7IKruQT+IqzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750926920; c=relaxed/simple;
	bh=GSeanSVTJqcRoAxZuultvOwFtKRsYtMb7zSvJhn66LE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eojdRx/wSZjsRi0f5UedO7cc3FysaXmkD8KRIo1dGlCoeNyXY4Jmrg5A44Uz0z6/E930SS0CXLB/GZ3Cm86B6/QzdLowbaICOZ60/CDPrrA3ZVR13rlHrdRmpxfkbOvmZsLerBgPLFHJ3cmtK/iSmR1N2y+JzMFpMjj9KusdKWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4FazDF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9C1C4CEEE;
	Thu, 26 Jun 2025 08:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750926919;
	bh=GSeanSVTJqcRoAxZuultvOwFtKRsYtMb7zSvJhn66LE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A4FazDF2wSrhLTAbJmPvbjDwuc91MvSnBI0j5ADpDsv6iLcjzadaa0QnY0eDmTBT7
	 ongYLAW76RjCpUrQG+Hm6aqj5kqE43psJF9KkKGQEQBmuKr6foh08Jl20xOxIhGfBV
	 EmrJJLJk4fa1QskNpQPtvX3NSzxGjwERXf2/V506blqGxPyRJ/OTc/4dbfjudly0yG
	 rIDEnUPaFjKAaEFsyAn61m6mk12bqE+ZhdS9ODkvt0qUutwUGKHVHcBb9XiSdKNQvG
	 J3xKQWxDV067YfrN5v1iHca1g/yeiqD5LysZkBnx9/K5YGcd5q3P4lzW88irr/vHtS
	 eI09hVF3YI+xQ==
Message-ID: <710f7c04-0099-4611-b2ea-4dd4219ad5e2@kernel.org>
Date: Thu, 26 Jun 2025 10:35:15 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] Input: Don't send fake button presses to wake
 system
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
References: <20250625215813.3477840-1-superm1@kernel.org>
 <20250625215813.3477840-5-superm1@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250625215813.3477840-5-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mario,

On 25-Jun-25 23:58, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Sending an input event to wake a system does wake it, but userspace picks
> up the keypress and processes it.  This isn't the intended behavior as it
> causes a suspended system to wake up and then potentially turn off if
> userspace is configured to turn off on power button presses.
> 
> Instead send a PM wakeup event for the PM core to handle waking the system.
> 
> Cc: Hans de Goede <hansg@kernel.org>
> Fixes: 0f107573da417 ("Input: gpio_keys - handle the missing key press event in resume phase")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/input/keyboard/gpio_keys.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 773aa5294d269..4c6876b099c43 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -420,12 +420,7 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
>  		pm_stay_awake(bdata->input->dev.parent);
>  		if (bdata->suspended  &&
>  		    (button->type == 0 || button->type == EV_KEY)) {
> -			/*
> -			 * Simulate wakeup key press in case the key has
> -			 * already released by the time we got interrupt
> -			 * handler to run.
> -			 */
> -			input_report_key(bdata->input, button->code, 1);
> +			pm_wakeup_event(bdata->input->dev.parent, 0);
>  		}
>  	}
>  

Hmm, we have the same problem on many Bay Trail / Cherry Trail
windows 8 / win10 tablets, so  this has been discussed before and e.g.
Android userspace actually needs the button-press (evdev) event to not
immediately go back to sleep, so a similar patch has been nacked in
the past.

At least for GNOME this has been fixed in userspace by ignoring
power-button events the first few seconds after a resume from suspend.

Regards,

Hans



