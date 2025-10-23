Return-Path: <linux-acpi+bounces-18152-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF842C015A2
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 15:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1BF31A62DCE
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 13:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173B9315764;
	Thu, 23 Oct 2025 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoZCcD3j"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D0A314D3F;
	Thu, 23 Oct 2025 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225932; cv=none; b=Zc82l2ShsIh2kZppI3IpnQi41jOvTOjySEMroMxIphUVlOxqOcCIkzM3L4QHBwBq3po/9gfYF5aylmUqqV3kbAM2kZUOqLHH1cE3lDYjUMomJ8tP0TMYNEbbxgJUeyqO+kB226vfeOpA6pGpmDBwE7N/VACUPGnKrxTGGEXL5oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225932; c=relaxed/simple;
	bh=Zlg/UQfIaIuf9IsruPRVzFlKEWA8F1iJyRojvd82SZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BSjNJyVPfj7QxcetpRjP+Xwpfry+aCStTP39EqPyFxEBmnv6Y0i7OQGt07dra+mfsD4BQMEjEMYrb5Xa74BVWGPYhHykiP25FXKI4UgM+FknLlTTj1GzYWY0dmuygIsbWpK4D5NaF7mU3BQoXxwbxKPMTHe10tY03uxhgxAXbI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoZCcD3j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CC5C4CEE7;
	Thu, 23 Oct 2025 13:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761225931;
	bh=Zlg/UQfIaIuf9IsruPRVzFlKEWA8F1iJyRojvd82SZ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PoZCcD3j6lpk6hGUA7zcWc4uqYSs8XX3435JYqTRvSMafzK3INIpVT+lhIczSBzVk
	 mOf5MZcM+fmCN7UnBNGI4wtSMgFJ6PmzJEZu6SJhgpHc9HkYFKjnpJTcy7+rEISglu
	 7NBdIVSY8VzE/p7qYxnyfwnT9pAmkT2YHIhddzU3emnbHPWdPuEteFxaYUa+3rt0ZI
	 WE3vZuvoTGkwr5diZF379L4WBkqZspTGt5Hg0bSoui3a4csiP+7LQZ3Bf5AYOK1w1F
	 LQ0zjSZlQ2f8Qbgjl5zb/fhfLSogt1fbOPOL4lXyUbN//TKwslAwM9i23MAgo32+SV
	 GXZnmw9QyDu2w==
Message-ID: <83852558-0fdc-493c-8f44-95356480c8aa@kernel.org>
Date: Thu, 23 Oct 2025 15:25:27 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ACPI: video: Fix use-after-free in
 acpi_video_switch_brightness()
To: Yuhao Jiang <danisjiang@gmail.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251022200704.2655507-1-danisjiang@gmail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20251022200704.2655507-1-danisjiang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 22-Oct-25 10:07 PM, Yuhao Jiang wrote:
> The switch_brightness_work delayed work accesses device->brightness
> and device->backlight, which are freed by
> acpi_video_dev_unregister_backlight() during device removal.
> 
> If the work executes after acpi_video_bus_unregister_backlight()
> frees these resources, it causes a use-after-free when
> acpi_video_switch_brightness() dereferences device->brightness or
> device->backlight.
> 
> Fix this by calling cancel_delayed_work_sync() for each device's
> switch_brightness_work in acpi_video_bus_remove_notify_handler()
> after removing the notify handler that queues the work. This ensures
> the work completes before the memory is freed.
> 
> Fixes: 8ab58e8e7e097 ("ACPI / video: Fix backlight taking 2 steps on a brightness up/down keypress")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuhao Jiang <danisjiang@gmail.com>
> ---
> Changes in v3:
> - Move cancel_delayed_work_sync() to acpi_video_bus_remove_notify_handler()
>   instead of acpi_video_bus_unregister_backlight() for better logic placement
> - Link to v2: https://lore.kernel.org/all/20251022042514.2167599-1-danisjiang@gmail.com/

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hansg@kernel.org>

Regards,

Hans



> ---
>  drivers/acpi/acpi_video.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 103f29661576..be8e7e18abca 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -1959,8 +1959,10 @@ static void acpi_video_bus_remove_notify_handler(struct acpi_video_bus *video)
>  	struct acpi_video_device *dev;
>  
>  	mutex_lock(&video->device_list_lock);
> -	list_for_each_entry(dev, &video->video_device_list, entry)
> +	list_for_each_entry(dev, &video->video_device_list, entry) {
>  		acpi_video_dev_remove_notify_handler(dev);
> +		cancel_delayed_work_sync(&dev->switch_brightness_work);
> +	}
>  	mutex_unlock(&video->device_list_lock);
>  
>  	acpi_video_bus_stop_devices(video);


