Return-Path: <linux-acpi+bounces-18062-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F23ABF8E96
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 23:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD6AD4E64A0
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 21:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76C028504F;
	Tue, 21 Oct 2025 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTIHK7sK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97826280308;
	Tue, 21 Oct 2025 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761081142; cv=none; b=EdJ98DtWzTTrjQmPVmkQyGCvkRLuKtLRVqTtyDZykr6DBinwdT/USppJxy6XaAgb/hmtpvh0VNnkjq014T4k1/S85aOOqaz4ktWgcNenjEz8Ap83FeYHRc5sUGRzBatC/1IBgCs/MGlbWfVokYY9nirhWD7Sg6L9xoSaurjxI8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761081142; c=relaxed/simple;
	bh=uACZEAVySp9vh+DxTCIfkIUewQNFDjmyapYv1iuSR/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yx7Ks0KFCYLx9Gziy6SLa1RjMSxZ3hqb5qx1dXWzMM88bq2fd60dxYDcul/ceNjz1SM4oGGxT3lgFTYDIxRnxakDtuZxLPtEpoS4B0jdANSr6qsgban3vCkEwtnBtnSPffZALF0m1cGrnJDKsMBrelRTBNok5A9CKvPpww+KmQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTIHK7sK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65068C4CEF1;
	Tue, 21 Oct 2025 21:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761081141;
	bh=uACZEAVySp9vh+DxTCIfkIUewQNFDjmyapYv1iuSR/U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hTIHK7sK/hQXFD663p/SfuxsBbpnA4IyGPA8y4dpT8qW3hsfsM1CgRDWiGrD+NLQx
	 sY516T92duqBF/MqRjLXUh4ykzn5fLvlRK/F2oLBWqvgPZiNP3RuNB/AllpmXDQjNq
	 o66cfww8W3jT4h1QfERQBUcGrrNPYlq8fO3YDCGzHEQR1Jbc12SdQKMpVZAUWgcGq2
	 tAiSrMqjFV9MAT0M9onn+MTt66ufzPy41HeIT2Z2YMJq8zn2XxIt+m1sCecCWbWFq4
	 5IryYgxRGWzEaU9DMexjULNRxTIc/cJ714QGud3CPXcaw6CT0Cb6HM5PBbnMI7fq3v
	 ulZQINhVxu67A==
Message-ID: <c1c72b45-1f0b-48da-98e5-47f5d63463a2@kernel.org>
Date: Tue, 21 Oct 2025 16:12:19 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/4] ACPI: button: Cancel hibernation if button is pressed
 during hibernation
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Pavel Machek <pavel@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-input@vger.kernel.org
Cc: kernel@collabora.com
References: <20251018142114.897445-1-usama.anjum@collabora.com>
 <20251018142114.897445-3-usama.anjum@collabora.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20251018142114.897445-3-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/18/2025 9:21 AM, Muhammad Usama Anjum wrote:
> acpi_pm_wakeup_event() is called from acpi_button_notify() which is
> called when power button is pressed. But system doesn't wake up as
> pm_wakeup_dev_event() isn't called with hard parameter set in case of
> hibernation. It gets set only for s2idle cases.
> 
> Call acpi_pm_wakeup_event() if power button is pressed and hibernation
> is in progress. Set the hard parameter such that pm_system_wakeup()
> gets called which increments pm_abort_suspend counter. Hence hibernation
> would be cancelled as in hibernation path, this counter is checked if it
> should be aborted.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   drivers/acpi/button.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 0a70260401882..4a2575c0c44e3 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -20,6 +20,7 @@
>   #include <linux/acpi.h>
>   #include <linux/dmi.h>
>   #include <acpi/button.h>
> +#include <linux/suspend.h>
>   
>   #define ACPI_BUTTON_CLASS		"button"
>   #define ACPI_BUTTON_FILE_STATE		"state"
> @@ -458,11 +459,16 @@ static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
>   	acpi_pm_wakeup_event(&device->dev);
>   
>   	button = acpi_driver_data(device);
> -	if (button->suspended || event == ACPI_BUTTON_NOTIFY_WAKE)
> -		return;
> -
>   	input = button->input;
>   	keycode = test_bit(KEY_SLEEP, input->keybit) ? KEY_SLEEP : KEY_POWER;
> +	if (event == ACPI_BUTTON_NOTIFY_STATUS && keycode == KEY_POWER &&
> +	    hibernation_in_progress()) {
> +		pm_wakeup_dev_event(&device->dev, 0, true);

The comments for pm_wakeup_dev_event() say that hard is used 
specifically for suspend to idle, but now you're overloading it.

So I think the comment in pm_wakeup_dev_event() needs to be updated if 
this is the way forward.

> +		return;
> +	}
> +
> +	if (button->suspended || event == ACPI_BUTTON_NOTIFY_WAKE)
> +		return;
>   
>   	input_report_key(input, keycode, 1);
>   	input_sync(input);


