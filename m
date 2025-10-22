Return-Path: <linux-acpi+bounces-18078-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D5DBFB2A2
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 11:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 357164E7B96
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 09:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4D13148DB;
	Wed, 22 Oct 2025 09:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdeNMqRw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6823002D3;
	Wed, 22 Oct 2025 09:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125326; cv=none; b=p3WzBH39YwnEOzo8vzcIDidtwSbRW5L04ri7qHwnqigah7AuMrUQDVRY6/SA1Gru6ypYRb8PrYjXBEIrmA1pzHh5rxHrW8/3RaqaFRy+D+bKb6WS550hsIJCN5F9/NnA2y3nxwssl30ApmmJgtf/NNMpegSbRMEMKdrFhYnGF30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125326; c=relaxed/simple;
	bh=PzmT9bOi5L5W//m+sGKE4LxzKu79eK7ALWdU2ExZfjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fZPLad1VFSTY8goeHGD4+mc6nOZhO9P8ag9+/ojtpJTQ3i6JeyHDUMO4WXd8I5fhVRsWCzLZM4o6CiBaaBtrWt/sQWUY/FIp6GBH1WDGDWvNlHHTynqQAyAz/SoW3nSKNfxkx7CJCJwRO6zeeaR/1VjeGSIZpMV09lzD80d6eG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdeNMqRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7525DC4CEE7;
	Wed, 22 Oct 2025 09:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761125325;
	bh=PzmT9bOi5L5W//m+sGKE4LxzKu79eK7ALWdU2ExZfjg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EdeNMqRwTie0xxZxH0sJunH9Ahe/B/k8GLy9MwZ9XsXsAFdn1H7/tXxcjYKAbYwxx
	 yP4MNAkkne1aqljLTRXPk8KzjO1xA1fwoewxzVBCJW9bSOxnomweJN7ezhMY8pYQT9
	 cSgPbbDilKF2hii5AW4lru1AylHLtYA/qfd2MBAHTMPjuwLGkLJgWSUQPXmO24dNe4
	 M4h9ZYRxzhPmJ4Kcv3s4qMcyr44F+QCsINzRG4CVPn9MLJ+MmjTqZ5KticuNLmS+rO
	 UT2ptbsWsPBEMC8YBdgksklKzEZ7LPD0HbUyjq/Mkr611JKqZemRTnIO6xVKy0/lME
	 3OKvEOxZcUibA==
Message-ID: <cf501c1e-94eb-4855-b3ad-e0b8c68d1a74@kernel.org>
Date: Wed, 22 Oct 2025 11:28:42 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: video: Fix use-after-free in
 acpi_video_switch_brightness()
To: Yuhao Jiang <danisjiang@gmail.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251022042514.2167599-1-danisjiang@gmail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20251022042514.2167599-1-danisjiang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yuhao,

On 22-Oct-25 6:25 AM, Yuhao Jiang wrote:
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
> switch_brightness_work before unregistering its backlight resources.
> This ensures the work completes before the memory is freed.
> 
> Fixes: 8ab58e8e7e097 ("ACPI / video: Fix backlight taking 2 steps on a brightness up/down keypress")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuhao Jiang <danisjiang@gmail.com>

Thank you for your patch, this is a good catch.

> ---
> Changes in v2:
> - Move cancel_delayed_work_sync() to acpi_video_bus_unregister_backlight()
>   instead of acpi_video_bus_put_devices() for better logic clarity and to
>   prevent potential UAF of device->brightness
> - Correct Fixes tag to point to 8ab58e8e7e097 which introduced the delayed work
> - Link to v1: https://lore.kernel.org/all/20251022040859.2102914-1-danisjiang@gmail.com
> ---
>  drivers/acpi/acpi_video.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 103f29661576..64709658bdc4 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -1869,8 +1869,10 @@ static int acpi_video_bus_unregister_backlight(struct acpi_video_bus *video)
>  	error = unregister_pm_notifier(&video->pm_nb);
>  
>  	mutex_lock(&video->device_list_lock);
> -	list_for_each_entry(dev, &video->video_device_list, entry)
> +	list_for_each_entry(dev, &video->video_device_list, entry) {
> +		cancel_delayed_work_sync(&dev->switch_brightness_work);
>  		acpi_video_dev_unregister_backlight(dev);
> +	}
>  	mutex_unlock(&video->device_list_lock);
>  
>  	video->backlight_registered = false;

As you mention in your changelog, the cancel_delayed_work_sync() needs
to happen before acpi_video_dev_unregister_backlight().

Since this needs to happen before unregistering things I think it would be
more logical to put the cancel_delayed_work_sync(&dev->switch_brightness_work);
call inside acpi_video_bus_remove_notify_handler().

So do the cancel in the loop there, directly after the
acpi_video_dev_remove_notify_handler(dev) call which removes the handler
which queues the work.

E.g. make the loop inside acpi_video_bus_remove_notify_handler() look like
this:

        mutex_lock(&video->device_list_lock);
        list_for_each_entry(dev, &video->video_device_list, entry) {
                acpi_video_dev_remove_notify_handler(dev);
                cancel_delayed_work_sync(&dev->switch_brightness_work);
        }
        mutex_unlock(&video->device_list_lock);

This cancels the work a bit earlier, but more importantly this feels
like the more logical place to put the cancel call.

Regards,

Hans



