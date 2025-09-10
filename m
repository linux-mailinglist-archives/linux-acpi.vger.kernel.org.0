Return-Path: <linux-acpi+bounces-16570-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB14B51359
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 11:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51C3188C282
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 09:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBE530F7E6;
	Wed, 10 Sep 2025 09:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWfqfLWN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57B9277CBC;
	Wed, 10 Sep 2025 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757498341; cv=none; b=r6WiX8wSmpdf/tDAFB8Ij85+kfuLWbxIJGBENy/43Cdg5DkuEuUmCZ9wTPX9IXJfkmihqu2CR5pEZO0pyfilKqhYBIvZQTauMUKTd97SrbNa/QpvWTAIWdp6+I4Ud4RgmgJEYkp+7XCjHaxFW86KOMCzcg90+ynlEwUg9/7ufF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757498341; c=relaxed/simple;
	bh=DxzMVhHfV1rRoRYKxKzW5EYDaEU4Lk4coPHbLUQqMuY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZXfmrhp8NEsMuu3SPzKG56rJd2GShJSCQOs9gsZpOip/CYKpH9b0bv5L5mpa7xmt40JJt9l1N5VGSmQXu93VWpfRYhmN+ez/J+5xnlSz2sWaT0J2qr5oKpJZQlI5+Y6UifcuuCF8wRDEwzAxuIqe0QvpUb34atuROcOtCN6w/tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWfqfLWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D8FC4CEF0;
	Wed, 10 Sep 2025 09:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757498340;
	bh=DxzMVhHfV1rRoRYKxKzW5EYDaEU4Lk4coPHbLUQqMuY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=sWfqfLWNT0Ht/iegWzeQZRjfuNisxGbQJ8avAx1JY5MsWAlDuGVyqE8SgcHRze5OB
	 i7+9T2du2jByn0NB6PyXHvwub5bo4yZ7uk+NQcYJghdMIb/MoA1+1KgQqG9diaKoaN
	 CPak4yDcFRV1sNGAwdclhYpg+wgSLCNbRgLcuV4glRrntCTaOreh49UbiAspxxR4b/
	 LkiYXX9bshSU82jqQeVOTMd237IHtbbg8E0+IvfBhttb4Qy9fxsyZEpOpPqVVVTcDk
	 8DHc4JRy44zmB3TR9iQzfJDxA73TFVc4tXmmfMBWDfoHNf4KlpyUDjuO2l4QtoS/aR
	 d/9BwaI0WoheQ==
Message-ID: <de4b5ec6-1e42-44b8-b5d3-5a452d7401ef@kernel.org>
Date: Wed, 10 Sep 2025 11:58:57 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: video: Fix missing backlight node creation on
 Zhaoxin platforms
From: Hans de Goede <hansg@kernel.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>,
 "Rafael J . wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Mario Limonciello
 <mario.limonciello@amd.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250910074711.1511753-1-zhangzihuan@kylinos.cn>
 <12816b79-c9b0-43d1-9b99-a1e7c7d73571@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <12816b79-c9b0-43d1-9b99-a1e7c7d73571@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10-Sep-25 11:37 AM, Hans de Goede wrote:
> Hi Zihuan,
> 
> On 10-Sep-25 9:47 AM, Zihuan Zhang wrote:
>> Some recent Lenovo and Inspur machines with Zhaoxin CPUs fail to create
>> /sys/class/backlight/acpi_video0 on v6.6 kernels, while the same hardware
>> works correctly on v5.4.
>>
>> Our analysis shows that the current implementation assumes the presence of a
>> GPU. The backlight registration is only triggered if a GPU is detected, but on
>> these platforms the backlight is handled purely by the EC without any GPU.
>> As a result, the detection path does not create the expected backlight node.
>>
>> To fix this, move the following logic:
>>
>> /* Use ACPI video if available, except when native should be preferred. */
>> if ((video_caps & ACPI_VIDEO_BACKLIGHT) &&
>>     !(native_available && prefer_native_over_acpi_video()))
>>         return acpi_backlight_video;
>>
>> above the if (auto_detect) *auto_detect = true; statement.
>>
>> This ensures that the ACPI video backlight node is created even when no GPU is
>> present, restoring the correct behavior observed on older kernels.
>>
>> Fixes: 78dfc9d1d1ab ("ACPI: video: Add auto_detect arg to __acpi_video_get_backlight_type()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> 
> Thank you for your patch.
> 
>> ---
>>  drivers/acpi/video_detect.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
>> index d507d5e08435..c1bb22b57f56 100644
>> --- a/drivers/acpi/video_detect.c
>> +++ b/drivers/acpi/video_detect.c
>> @@ -1011,6 +1011,11 @@ enum acpi_backlight_type __acpi_video_get_backlight_type(bool native, bool *auto
>>  	if (acpi_backlight_dmi != acpi_backlight_undef)
>>  		return acpi_backlight_dmi;
>>  
>> +	/* Use ACPI video if available, except when native should be preferred. */
>> +	if ((video_caps & ACPI_VIDEO_BACKLIGHT) &&
>> +	     !(native_available && prefer_native_over_acpi_video()))
>> +		return acpi_backlight_video;
>> +
>>  	if (auto_detect)
>>  		*auto_detect = true;
>>  
>> @@ -1024,11 +1029,6 @@ enum acpi_backlight_type __acpi_video_get_backlight_type(bool native, bool *auto
>>  	if (dell_uart_present)
>>  		return acpi_backlight_dell_uart;
>>  
>> -	/* Use ACPI video if available, except when native should be preferred. */
>> -	if ((video_caps & ACPI_VIDEO_BACKLIGHT) &&
>> -	     !(native_available && prefer_native_over_acpi_video()))
>> -		return acpi_backlight_video;
>> -
>>  	/* Use native if available */
>>  	if (native_available)
>>  		return acpi_backlight_native;
> 
> There is a very specific ordering, as the comment in the function says:
> 
>         /*
>          * The below heuristics / detection steps are in order of descending
>          * presedence. The commandline takes presedence over anything else.
>          */
> 
> You cannot just move one fo the detect steps like this, this will break
> many many other systems.
> 
> NACK for this patch, sorry.
> 
> We will need to figure out some other way to fix your issue.
> 
> For starters I do not understand how this patch helps.

Oh wait, now I understand the trick is that you now return
acpi_backlight_video without setting *auto_detect = true.

Which in turn causes this code in drivers/acpi/acpi_video.c:

        /*
         * If backlight-type auto-detection is used then a native backlight may
         * show up later and this may change the result from video to native.
         * Therefor normally the userspace visible /sys/class/backlight device
         * gets registered separately by the GPU driver calling
         * acpi_video_register_backlight() when an internal panel is detected.
         * Register the backlight now when not using auto-detection, so that
         * when the kernel cmdline or DMI-quirks are used the backlight will
         * get registered even if acpi_video_register_backlight() is not called.
         */
        acpi_video_run_bcl_for_osi(video);
        if (__acpi_video_get_backlight_type(false, &auto_detect) == acpi_backlight_video &&
            !auto_detect)
                acpi_video_bus_register_backlight(video);

To immediately register the backlight rather then waiting for the native
GPU driver to call acpi_video_register_backlight() after the native GPU
driver has completed probing for native GPU backlight control which is
often preferred.

So as you say the issue is that you have no native GPU driver calling
acpi_video_register_backlight().

But this patch really is not a good way to fix this and will break
things on many other systems. So still NACK.

First of all I assume that there is some sort of builtin GPU on these
Lenovo and Inspur machines with Zhaoxin CPUs. Even if the GPU driver
is not in the mainline kernel then I assume there is some out of tree
driver. Can that driver not call acpi_video_register_backlight() ?

acpi_video_register_backlight() is deliberately EXPORT_SYMBOL() rather
then EXPORT_SYMBOL_GPL() so that even proprietary GPU drivers can call
it.

Having your out of tree GPU driver call acpi_video_register_backlight()
would really be the best solution here as that would be using the
video_detect.c / acpi_video.c code as designed.

If this is not possible then we will need to add some quirk based
on CPUID matching e.g. something like this:

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index d507d5e08435..24dd79ec1b72 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -1011,6 +1011,18 @@ enum acpi_backlight_type __acpi_video_get_backlight_type(bool native, bool *auto
 	if (acpi_backlight_dmi != acpi_backlight_undef)
 		return acpi_backlight_dmi;
 
+	/*
+	 * ATM Zhaoxin CPU systems have no native GPU driver, instead ACPI video
+	 * should be used to control the backlight. The lack of a GPU driver
+	 * means that acpi_video_register_backlight() will never get called
+	 * causing things to not work.
+	 * This special case for these systems returns acpi_backlight_video
+	 * without setting auto_detect = true, causing acpi_video.c to
+	 * immediately register the backlight, working around this issue.
+	 */
+	if ((video_caps & ACPI_VIDEO_BACKLIGHT) && cpu_is_zhaoxin())
+		return acpi_backlight_video;
+
 	if (auto_detect)
 		*auto_detect = true;
 

Note you will need to provide a cpu_is_zhaoxin() helper for this.

Regards,

Hans





