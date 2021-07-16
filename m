Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C463CB69E
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jul 2021 13:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhGPLQ3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Jul 2021 07:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhGPLQ2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jul 2021 07:16:28 -0400
X-Greylist: delayed 936 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 16 Jul 2021 04:13:34 PDT
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EE1C06175F
        for <linux-acpi@vger.kernel.org>; Fri, 16 Jul 2021 04:13:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 20AC2BFA0D;
        Fri, 16 Jul 2021 12:57:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1626433074; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=ApEu5jM+9Di4uAZMdri6SHSsbLmG0Nz1bYVfx2MKlz8=;
        b=ppmT5vU7nExF6jNTK3Ql3+uVWgEANJZFcEsdzsQa81tBEhLr0pBxTESzcXbhvP0wRTmjsA
        a2/5uE4TMzP+nsitbWoTEuRdeOTeh290/1dyvsaRxjDBIxGrOctpP3KZcliDcJ5c57bl1q
        UVJjgDQvvEobqFHmhav6lJyXUEJnnyWc5RnoZcExCa9oPim2zD998kYKez+w8UC5+HoWh0
        TxgiuXdpy2BigUKd7E5lxzZLerprKsWSAHQpN0kCXw8izv9YpN2gS0kHqspUQrJAO17Luq
        qM6bpD9WrZ+/00nQv7Is5slPrC6KNWGXLX+AmJCGWA0GZitNlmWOj163buNjyw==
Subject: Re: [PATCH] ACPI: PM: Only mark EC GPE for wakeup on Intel systems
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Julian Sikorski <belegdol@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>
References: <20210630194606.530-1-mario.limonciello@amd.com>
From:   Frieder Schrempf <frieder@fris.de>
Message-ID: <704855e5-fad4-a002-a16a-1f3fbddbf5f0@fris.de>
Date:   Fri, 16 Jul 2021 12:57:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210630194606.530-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 30.06.21 21:46, Mario Limonciello wrote:
> When using s2idle on a variety of AMD notebook systems, they are
> experiencing spurious events that the EC or SMU are in the wrong
> state leading to a hard time waking up or higher than expected
> power consumption.
> 
> These events only occur when the EC GPE is inadvertently set as a wakeup
> source. Originally the EC GPE was only set as a wakeup source when using
> the intel-vbtn or intel-hid drivers in commit 10a08fd65ec1 ("ACPI: PM:
> Set up EC GPE for system wakeup from drivers that need it") but during
> testing a reporter discovered that this was not enough for their ASUS
> Zenbook UX430UNR/i7-8550U to wakeup by lid event or keypress.
> Marking the EC GPE for wakeup universally resolved this for that
> reporter in commit b90ff3554aa3 ("ACPI: PM: s2idle: Always set up EC GPE
> for system wakeup").
> 
> However this behavior has lead to a number of problems:
> 
> * On both Lenovo T14 and P14s the keyboard wakeup doesn't work, and
> sometimes the power button event doesn't work.
> * On HP 635 G7 detaching or attaching AC during suspend will cause
> the system not to wakeup
> * On Asus vivobook to prevent detaching AC causing resume problems
> * On Lenovo 14ARE05 to prevent detaching AC causing resume problems
> * On HP ENVY x360  to prevent detaching AC causing resume problems
> 
> As there may be other Intel systems besides ASUS Zenbook UX430UNR/i7-8550U
> that don't use intel-vbtn or intel-hid avoid these problems by only
> universally marking the EC GPE wakesource on non-AMD systems.
> 
> Link: https://patchwork.kernel.org/project/linux-pm/cover/5997740.FPbUVk04hV@kreacher/#22825489
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1230
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1629
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

As this seems to fix quite some issues for the AMD systems, is there any 
reason why this is not tagged as fix for stable? Are there any plans for 
backporting?

> ---
>   drivers/acpi/x86/s2idle.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 816bf2c34b7a..1c507804fb10 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -417,11 +417,15 @@ static int lps0_device_attach(struct acpi_device *adev,
>   		mem_sleep_current = PM_SUSPEND_TO_IDLE;
>   
>   	/*
> -	 * Some LPS0 systems, like ASUS Zenbook UX430UNR/i7-8550U, require the
> -	 * EC GPE to be enabled while suspended for certain wakeup devices to
> -	 * work, so mark it as wakeup-capable.
> +	 * Some Intel based LPS0 systems, like ASUS Zenbook UX430UNR/i7-8550U don't
> +	 * use intel-hid or intel-vbtn but require the EC GPE to be enabled while
> +	 * suspended for certain wakeup devices to work, so mark it as wakeup-capable.
> +	 *
> +	 * Only enable on !AMD as enabling this universally causes problems for a number
> +	 * of AMD based systems.
>   	 */
> -	acpi_ec_mark_gpe_for_wake();
> +	if (!acpi_s2idle_vendor_amd())
> +		acpi_ec_mark_gpe_for_wake();
>   
>   	return 0;
>   }
> 
