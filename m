Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A343283170
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Oct 2020 10:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgJEIFQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Oct 2020 04:05:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26736 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725925AbgJEIFQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Oct 2020 04:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601885114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=omoN2w562gbkLHMzpyAYqKG3VTaG4dOpjflmkpwJeZU=;
        b=EckKilhgPAkXlkFS4wKbfr92AaRP2AEbO3gYWzrhes9ug7U4ApiiHgnqfBWgG18XbL1di4
        fb3clAc3/PbMfzkDlCCY8Wwu1er8vH+MxVuA3GrbHR8v/rkQsr4RxErEn8wcgdCQS4w54L
        zDTET4MSIGG8Ds6in9FgkLYJabnoobw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-s-Py_5cGN02gcqF8Shw7Nw-1; Mon, 05 Oct 2020 04:05:12 -0400
X-MC-Unique: s-Py_5cGN02gcqF8Shw7Nw-1
Received: by mail-ej1-f70.google.com with SMTP id ga21so3030964ejb.14
        for <linux-acpi@vger.kernel.org>; Mon, 05 Oct 2020 01:05:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=omoN2w562gbkLHMzpyAYqKG3VTaG4dOpjflmkpwJeZU=;
        b=B8JErmov2R+78nfepmxQyACIx+9es2o+WtEbQVTK+VP7HzCSseHPPRuIM5bVyiNq4w
         bzvwKIHuv+dxFWEbBsJIXRSBKwY1CivtTwfj4bs+MWSj9h8nD5DP05htOK4vtuJLnBGX
         8v3kOP4fPXofzR/R2hKeQHzTYIT1T1hpZdGCzUrSzlfWpB3UjO2pUc7df6dfCSW/Qpbq
         ttBg7hVQi4DV1l2w8CY+MHS3gyKIygHjt+S+5PwTSv0xERrSNemYpWlzcB5GC8qqnvsa
         aQP9doSWIz6GaItMJ0qkcpH6ujXBpq/YPRURjNBFEI1kTd2NBstrsVbSjEvJeU6UxOen
         FQlQ==
X-Gm-Message-State: AOAM532tdO99W5G3ojoSzr5nXn4aNpQmaelJuwUl1a3HPMLRAkNdGGZk
        QA71Uqjan2FPT4e/woazC4g53d4ahu0m7re1LkLLNLMsa2P7Q0J5s4RVhM1ltXXw3Ya+bnzzzlX
        +LCFhtSb6o8XLRev/ARAnyg==
X-Received: by 2002:a17:906:1b58:: with SMTP id p24mr15090560ejg.77.1601885111379;
        Mon, 05 Oct 2020 01:05:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaFv2T3kRxY3SbEuDPDKZR9R5ktA4K4cUG+4kIMuvBHB6/Ao6gOSK6T490FAeQ02BbdFszqg==
X-Received: by 2002:a17:906:1b58:: with SMTP id p24mr15090537ejg.77.1601885111130;
        Mon, 05 Oct 2020 01:05:11 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id q27sm7345874ejd.74.2020.10.05.01.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 01:05:10 -0700 (PDT)
Subject: Re: [PATCH] ACPI / button: fix handling lid state changes when input
 device closed
To:     dmitry.torokhov@gmail.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201005051125.GA3245495@dtor-ws>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e7f1d478-b668-7274-2a21-f0e6609db4ef@redhat.com>
Date:   Mon, 5 Oct 2020 10:05:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201005051125.GA3245495@dtor-ws>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 10/5/20 7:11 AM, dmitry.torokhov@gmail.com wrote:
> The original intent of 84d3f6b76447 was to delay evaluating lid state until
> all drivers have been loaded, with input device being opened from userspace
> serving as a signal for this condition. Let's ensure that state updates
> happen even if userspace closed (or in the future inhibited) input device.
> 
> Note that if we go through suspend/resume cycle we assume the system has
> been fully initialized even if LID input device has not been opened yet.
> 
> This has a side-effect of fixing access to input->users outside of
> input->mutex protections by the way of eliminating said accesses and using
> driver private flag.
> 
> Fixes: 84d3f6b76447 ("ACPI / button: Delay acpi_lid_initialize_state() until first user space open")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/acpi/button.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 78cfc70cb320..b8dd51d8f96d 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -154,6 +154,7 @@ struct acpi_button {
>   	int last_state;
>   	ktime_t last_time;
>   	bool suspended;
> +	bool lid_state_initialized;
>   };
>   
>   static struct acpi_device *lid_device;
> @@ -384,6 +385,8 @@ static int acpi_lid_update_state(struct acpi_device *device,
>   
>   static void acpi_lid_initialize_state(struct acpi_device *device)
>   {
> +	struct acpi_button *button = acpi_driver_data(device);
> +
>   	switch (lid_init_state) {
>   	case ACPI_BUTTON_LID_INIT_OPEN:
>   		(void)acpi_lid_notify_state(device, 1);
> @@ -395,13 +398,14 @@ static void acpi_lid_initialize_state(struct acpi_device *device)
>   	default:
>   		break;
>   	}
> +
> +	button->lid_state_initialized = true;
>   }
>   
>   static void acpi_button_notify(struct acpi_device *device, u32 event)
>   {
>   	struct acpi_button *button = acpi_driver_data(device);
>   	struct input_dev *input;
> -	int users;
>   
>   	switch (event) {
>   	case ACPI_FIXED_HARDWARE_EVENT:
> @@ -410,10 +414,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
>   	case ACPI_BUTTON_NOTIFY_STATUS:
>   		input = button->input;
>   		if (button->type == ACPI_BUTTON_TYPE_LID) {
> -			mutex_lock(&button->input->mutex);
> -			users = button->input->users;
> -			mutex_unlock(&button->input->mutex);
> -			if (users)
> +			if (button->lid_state_initialized)
>   				acpi_lid_update_state(device, true);
>   		} else {
>   			int keycode;
> @@ -458,7 +459,7 @@ static int acpi_button_resume(struct device *dev)
>   	struct acpi_button *button = acpi_driver_data(device);
>   
>   	button->suspended = false;
> -	if (button->type == ACPI_BUTTON_TYPE_LID && button->input->users) {
> +	if (button->type == ACPI_BUTTON_TYPE_LID) {
>   		button->last_state = !!acpi_lid_evaluate_state(device);
>   		button->last_time = ktime_get();
>   		acpi_lid_initialize_state(device);
> 

