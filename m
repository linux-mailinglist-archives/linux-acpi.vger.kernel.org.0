Return-Path: <linux-acpi+bounces-4715-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0653689B959
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 09:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703B01F20986
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 07:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B5C3985A;
	Mon,  8 Apr 2024 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eN59EnXi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3470E38FA0
	for <linux-acpi@vger.kernel.org>; Mon,  8 Apr 2024 07:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562592; cv=none; b=VWwRxluWk1k6CADTjlOYUpGCNJMAM2Q/qf71uarZyA5DtFpHXNDhyxwN4C/iADy2A56wVSNIJaa78QjOMkiYgfFJOGvHy0GJdTZE9JG9r4FRYn79oS+WlYI8ZUGsIkr+nkwVMQtYHANPU9IFBRSNjfloWwgem6IMBiqEtNdg6vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562592; c=relaxed/simple;
	bh=pdp/S8GTrXp2ZC8n08X2Md+cKastPnDMaOhZ5lzlE8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gqVLtelji3KIo5h7K56VmV+46vSRBLgb8Lei0NJj/ktYpQ4aEEtrCfmdlfWGuiTZZD4rgH4WbLLFMCz5PxlmHppbJhVAVnprmYJm1KX/jPRgEWbhy1r5kRKXIrFoPKGeZnA1W99en0RG0kRL/Yi+9ZnRysI/Jae3ObojoY1Pkok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eN59EnXi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712562590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPb4MvLUOw0ybExZV1Ke1HqJAXEtECafnVx4HaE49Bw=;
	b=eN59EnXiQx8SToRrE8uB3z2nhDpWVn45PeXGsE/XUcQ0JPDL6ao4LzPoLy7bMGQ/Ws6y+G
	ZLTl2oCDFAJNAEqscNDWrzk/7zVFCN+ArTCCJglW6HvupMIqih+OSFPK1Y67iV5LrWbs2u
	AzEi0aLpM4ZUhghwa0QTkHVz2CBkYgQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-Aao-j4_vPhulQR3UU7SC7Q-1; Mon, 08 Apr 2024 03:49:48 -0400
X-MC-Unique: Aao-j4_vPhulQR3UU7SC7Q-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a519e10623bso200288666b.0
        for <linux-acpi@vger.kernel.org>; Mon, 08 Apr 2024 00:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712562587; x=1713167387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPb4MvLUOw0ybExZV1Ke1HqJAXEtECafnVx4HaE49Bw=;
        b=CKvP4CXaMwuEsz4I4QsJUAEweC6iopUHObtYovfuMgpn/WsQA/4McnwIS2kokNtqaN
         z86Cvp36KaDDkgkzRxVsKS+JecTk/UDTC+N4o6kWTOIH8kmxp2rrD/9WGPLoIm/0tGfD
         8Aefhc2McgITwaysk8e53b0rxuMJ10MgGUkiHDTpilK+iQpmTTcL+lK7yO6pjapWtIWn
         WWOkr9xeLs2ITMNzEthDw6xKYwSYs2wbrXB5DUI8I9f+AYdJn0J+5SKhSUteePM8e8wW
         m9va5DhpvnkW2sTkglCP+m8EsV7pP0u0mx7V6WN2r1GndaC130YRH+DVa1cp8VqNWtj6
         dHnA==
X-Forwarded-Encrypted: i=1; AJvYcCXXSfH1zNOKwir7lu1jlxSPO6f7xY73MSn7AXepBCkqT21R0pl+db4lYmq0bjfZ1BJB8wPLm4GaPA1sD5iHZN7IK5TLrNxNpvXSEg==
X-Gm-Message-State: AOJu0YzqZShdAnhAovGHLyprqsZjAmwcIHCX2BOPdtDjChy23haVZOXf
	19qQrVM5QBKrar/8xkauc+wr7QspcOvsnTiQZ7T6S5q2VEC2MrWFnkKvqtHSBV0tj8427eLzWiZ
	MfXomKHqfam2HjWQPmIHXfE12fx4RIMmTo1sMTqx/uDQsv8lZSpabJJzOEqQ=
X-Received: by 2002:a17:907:31c9:b0:a51:ddc6:edc1 with SMTP id xf9-20020a17090731c900b00a51ddc6edc1mr602312ejb.28.1712562587771;
        Mon, 08 Apr 2024 00:49:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgOWLDn5yru8pvspLB9zoJuHB1EBRYuc3ghKmJuv14iqTtLuHSwCTMepoQBWEwYt3BJrgfUQ==
X-Received: by 2002:a17:907:31c9:b0:a51:ddc6:edc1 with SMTP id xf9-20020a17090731c900b00a51ddc6edc1mr602300ejb.28.1712562587383;
        Mon, 08 Apr 2024 00:49:47 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id jy15-20020a170907762f00b00a4e26570581sm4102467ejc.108.2024.04.08.00.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 00:49:47 -0700 (PDT)
Message-ID: <0a05cadf-562d-4516-86bb-51afacb7e167@redhat.com>
Date: Mon, 8 Apr 2024 09:49:46 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: quickstart: Fix race condition when
 reporting input event
To: Armin Wolf <W_Armin@gmx.de>, ilpo.jarvinen@linux.intel.com
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240327214524.123935-1-W_Armin@gmx.de>
 <f662fab0-0f47-4b71-ab71-2b9492253483@gmx.de>
 <b5d808fd-f9c4-48d5-b888-c4ded4b0cad6@redhat.com>
 <2cbad5c6-8c70-45dd-8281-3bbffb4e8daf@gmx.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <2cbad5c6-8c70-45dd-8281-3bbffb4e8daf@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 4/8/24 8:01 AM, Armin Wolf wrote:
> Am 07.04.24 um 17:32 schrieb Hans de Goede:
> 
>> Hi,
>>
>> On 4/6/24 8:57 PM, Armin Wolf wrote:
>>> Am 27.03.24 um 22:45 schrieb Armin Wolf:
>>>
>>>> Since commit e2ffcda16290 ("ACPI: OSL: Allow Notify () handlers to run
>>>> on all CPUs"), the ACPI core allows multiple notify calls to be active
>>>> at the same time. This means that two instances of quickstart_notify()
>>>> running at the same time can mess which each others input sequences.
>>>>
>>>> Fix this by protecting the input sequence with a mutex.
>>>>
>>>> Compile-tested only.
>>> Any thoughts on this?
>> I wonder if we need this at all ?
>>
>> The input_event() / input_report_key() / input_sync() functions
>> which underpin sparse_keymap_report_event() all are safe to be called
>> from multiple threads at the same time AFAIK.
>>
>> The only thing which can then still go "wrong" if we have
>> 2 sparse_keymap_report_event() functions racing for the same
>> quickstart button and thus for the same keycode is that we may
>> end up with:
>>
>> input_report_key(dev, keycode, 1);
>> input_report_key(dev, keycode, 1); /* This is a no-op */
>> input_sync(); /* + another input_sync() somewhere which is a no-op */
>> input_report_key(dev, keycode, 0);
>> input_report_key(dev, keycode, 0); /* This is a no-op */
>> input_sync(); /* + another input_sync() somewhere which is a no-op */
>>
>> IOW if 2 racing notifiers hit the perfect race conditions then
>> only 1 key press is reported, instead of 2 which seems like
>> it is not a problem since arguably if the same event gets
>> reported twice at the exact same time it probably really
>> is only a single button press.
>>
>> Also I think it is highly unlikely we will actually see
>> 2 notifiers for this racing in practice.
>>
>> So I don't think we need this at all. But if others feel strongly
>> about adding this I can still merge it... ?
>>
>> Regards,
>>
>> Hans
> 
> Hi,
> 
> the locking issue was originally brought up by Ilpo Jarvinen during the review of the lenovo-wmi-camera driver.
> Also the race condition can cause an invalid input sequence to be emitted:
> 
> input_report_key(dev, keycode, 1);
> input_sync();
> input_report_key(dev, keycode, 0);    // Possible invalid sequence?
> input_report_key(dev, keycode, 1);
> input_sync();
> input_sync();
> input_report_key(dev, keycode, 0);
> input_sync();
> 
> 
> I think this input sequence would be invalid, so we need the locking.

The:

input_report_key(dev, keycode, 0);    // Possible invalid sequence?
input_report_key(dev, keycode, 1);
input_sync();

Part is equivalent of:

input_report_key(dev, keycode, 1);
input_sync();

Since there is no sync() after the release event it will
never reach userspace.

With that said, I'm still happy to merge this if you
prefer to have the locking in place.

Either way please let me know how you want to proceed.

Regards,

Hans





> 
> Thanks,
> Armin Wolf
> 
>>>> Fixes: afd66f2a739e ("platform/x86: Add ACPI quickstart button (PNP0C32) driver")
>>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>>> ---
>>>> This applies on the branch "review-hans". Maybe we could somehow
>>>> document the concurrency rules for ACPI notify handlers?
>>>> ---
>>>>    drivers/platform/x86/quickstart.c | 17 +++++++++++++++++
>>>>    1 file changed, 17 insertions(+)
>>>>
>>>> diff --git a/drivers/platform/x86/quickstart.c b/drivers/platform/x86/quickstart.c
>>>> index ba3a7a25dda7..e40f852d42c1 100644
>>>> --- a/drivers/platform/x86/quickstart.c
>>>> +++ b/drivers/platform/x86/quickstart.c
>>>> @@ -18,6 +18,7 @@
>>>>    #include <linux/input/sparse-keymap.h>
>>>>    #include <linux/kernel.h>
>>>>    #include <linux/module.h>
>>>> +#include <linux/mutex.h>
>>>>    #include <linux/platform_device.h>
>>>>    #include <linux/sysfs.h>
>>>>    #include <linux/types.h>
>>>> @@ -35,6 +36,7 @@
>>>>
>>>>    struct quickstart_data {
>>>>        struct device *dev;
>>>> +    struct mutex input_lock;    /* Protects input sequence during notify */
>>>>        struct input_dev *input_device;
>>>>        char input_name[32];
>>>>        char phys[32];
>>>> @@ -73,7 +75,10 @@ static void quickstart_notify(acpi_handle handle, u32 event, void *context)
>>>>
>>>>        switch (event) {
>>>>        case QUICKSTART_EVENT_RUNTIME:
>>>> +        mutex_lock(&data->input_lock);
>>>>            sparse_keymap_report_event(data->input_device, 0x1, 1, true);
>>>> +        mutex_unlock(&data->input_lock);
>>>> +
>>>>            acpi_bus_generate_netlink_event(DRIVER_NAME, dev_name(data->dev), event, 0);
>>>>            break;
>>>>        default:
>>>> @@ -147,6 +152,13 @@ static void quickstart_notify_remove(void *context)
>>>>        acpi_remove_notify_handler(handle, ACPI_DEVICE_NOTIFY, quickstart_notify);
>>>>    }
>>>>
>>>> +static void quickstart_mutex_destroy(void *data)
>>>> +{
>>>> +    struct mutex *lock = data;
>>>> +
>>>> +    mutex_destroy(lock);
>>>> +}
>>>> +
>>>>    static int quickstart_probe(struct platform_device *pdev)
>>>>    {
>>>>        struct quickstart_data *data;
>>>> @@ -165,6 +177,11 @@ static int quickstart_probe(struct platform_device *pdev)
>>>>        data->dev = &pdev->dev;
>>>>        dev_set_drvdata(&pdev->dev, data);
>>>>
>>>> +    mutex_init(&data->input_lock);
>>>> +    ret = devm_add_action_or_reset(&pdev->dev, quickstart_mutex_destroy, &data->input_lock);
>>>> +    if (ret < 0)
>>>> +        return ret;
>>>> +
>>>>        /* We have to initialize the device wakeup before evaluating GHID because
>>>>         * doing so will notify the device if the button was used to wake the machine
>>>>         * from S5.
>>>> -- 
>>>> 2.39.2
>>>>
>>>>
>>
> 


