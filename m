Return-Path: <linux-acpi+bounces-16566-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1FDB512A8
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 11:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C4441892BAB
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 09:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465063128A4;
	Wed, 10 Sep 2025 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrFC/fE/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1003A285CAF;
	Wed, 10 Sep 2025 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497034; cv=none; b=PNFY0hCVDnORwLBd33VA+ct3KDB/Kjf/uW5k/tBs1MTd+uWDwC0Opf3qXco2i80xpe8x9Y0+y5DK7TmA51Hgrs3LN7l+q3kKY6wexomVp9PxgeGwgazj38gPOpWhafjYH6O5iswmywFFR59/3UYVIwEMZKiNjI7kp7+Og9OfoFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497034; c=relaxed/simple;
	bh=28Z83TYU1HcXY9gGFlYZe5FSkvWNJL9vWbrzyGS+5pM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=doJN3gpdvbbUb//4eIH52v2gf2qkcsjNQXMn4kcz4uAZmehq45rgNzMGVYCBCqynlNbE+z4g5WgBqnbAN/eA8uQtfJ/l2py+xWiBxKdMLTrvE6AU83Ycy1wfdTGvqnp3FM3NljqTKEXkBV1FNu3lAi3BwAErFaaiwubLqcMmiH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrFC/fE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8B1C4CEF8;
	Wed, 10 Sep 2025 09:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757497033;
	bh=28Z83TYU1HcXY9gGFlYZe5FSkvWNJL9vWbrzyGS+5pM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LrFC/fE/oDv/+Dn6Np09etM9Npqz03ErTqdlyl7GKVA9kDhwpcpp4HvrUmXaxz6Lo
	 PKnUha90vZwmj5z5nri8qBNVmZnEnuIEgLcKVUsy2EU7IHPyot8jgZRE3o2p2R6ujq
	 wE1hGalT7vT8CI2atXShbN0g5NOIOz2S39qEtH5pvXqLSg6bY7SOvY33Q8bR8s0mSa
	 umY/oqnMyLkWte8iHy9yhhP30C3FDhBGtjZjiPWDfPALd9LJ9diSrYxZPnyZbwMe5i
	 SnowW6qqWGUwd34SGJReguDbIKG5SBEkYaR80Xp9JLIdXMPGRNa+AfwpUhyFq2kpeF
	 /tOMZGmjuVLDw==
Message-ID: <12816b79-c9b0-43d1-9b99-a1e7c7d73571@kernel.org>
Date: Wed, 10 Sep 2025 11:37:10 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: video: Fix missing backlight node creation on
 Zhaoxin platforms
To: Zihuan Zhang <zhangzihuan@kylinos.cn>,
 "Rafael J . wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Mario Limonciello
 <mario.limonciello@amd.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250910074711.1511753-1-zhangzihuan@kylinos.cn>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20250910074711.1511753-1-zhangzihuan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Zihuan,

On 10-Sep-25 9:47 AM, Zihuan Zhang wrote:
> Some recent Lenovo and Inspur machines with Zhaoxin CPUs fail to create
> /sys/class/backlight/acpi_video0 on v6.6 kernels, while the same hardware
> works correctly on v5.4.
> 
> Our analysis shows that the current implementation assumes the presence of a
> GPU. The backlight registration is only triggered if a GPU is detected, but on
> these platforms the backlight is handled purely by the EC without any GPU.
> As a result, the detection path does not create the expected backlight node.
> 
> To fix this, move the following logic:
> 
> /* Use ACPI video if available, except when native should be preferred. */
> if ((video_caps & ACPI_VIDEO_BACKLIGHT) &&
>     !(native_available && prefer_native_over_acpi_video()))
>         return acpi_backlight_video;
> 
> above the if (auto_detect) *auto_detect = true; statement.
> 
> This ensures that the ACPI video backlight node is created even when no GPU is
> present, restoring the correct behavior observed on older kernels.
> 
> Fixes: 78dfc9d1d1ab ("ACPI: video: Add auto_detect arg to __acpi_video_get_backlight_type()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>

Thank you for your patch.

> ---
>  drivers/acpi/video_detect.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index d507d5e08435..c1bb22b57f56 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -1011,6 +1011,11 @@ enum acpi_backlight_type __acpi_video_get_backlight_type(bool native, bool *auto
>  	if (acpi_backlight_dmi != acpi_backlight_undef)
>  		return acpi_backlight_dmi;
>  
> +	/* Use ACPI video if available, except when native should be preferred. */
> +	if ((video_caps & ACPI_VIDEO_BACKLIGHT) &&
> +	     !(native_available && prefer_native_over_acpi_video()))
> +		return acpi_backlight_video;
> +
>  	if (auto_detect)
>  		*auto_detect = true;
>  
> @@ -1024,11 +1029,6 @@ enum acpi_backlight_type __acpi_video_get_backlight_type(bool native, bool *auto
>  	if (dell_uart_present)
>  		return acpi_backlight_dell_uart;
>  
> -	/* Use ACPI video if available, except when native should be preferred. */
> -	if ((video_caps & ACPI_VIDEO_BACKLIGHT) &&
> -	     !(native_available && prefer_native_over_acpi_video()))
> -		return acpi_backlight_video;
> -
>  	/* Use native if available */
>  	if (native_available)
>  		return acpi_backlight_native;

There is a very specific ordering, as the comment in the function says:

        /*
         * The below heuristics / detection steps are in order of descending
         * presedence. The commandline takes presedence over anything else.
         */

You cannot just move one fo the detect steps like this, this will break
many many other systems.

NACK for this patch, sorry.

We will need to figure out some other way to fix your issue.

For starters I do not understand how this patch helps.

You are moving the:

	/* Use ACPI video if available, except when native should be preferred. */
	if ((video_caps & ACPI_VIDEO_BACKLIGHT) &&
	     !(native_available && prefer_native_over_acpi_video()))
		return acpi_backlight_video;

Above the nvidia_wmi_ec_present, apple_gmux_present and dell_uart_present
checks, but I would expect all of these to be false on Lenovo and Inspur
machines with Zhaoxin CPUs ?  So this patch should not make a difference.

Please double check that this patch fixes things for you.

And if it does really fix things then please add printk()
calls printing the value of nvidia_wmi_ec_present, apple_gmux_present 
and dell_uart_present these should all be false, but maybe we get
a false-positive and one of them is set to true ?

Regards,

Hans



