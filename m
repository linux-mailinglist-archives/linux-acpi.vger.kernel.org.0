Return-Path: <linux-acpi+bounces-7482-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F7394D8C6
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Aug 2024 00:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E78728387F
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 22:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4211316B3AB;
	Fri,  9 Aug 2024 22:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aY7VBeFM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E23C8D1;
	Fri,  9 Aug 2024 22:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723243469; cv=none; b=dS9qf7cDD9Y1loj4E74PYXgHQnVWv+eEKv2jVKvCnrFjcYmCNd5HZdMoXZJzPPvA3kA0BSfdUZAbDfPEncX1NfCMstZ3U1NuBDe2I4ZoA2fzVJD31KwbyF7OIjdd4P+1EY7s3uPEDJ3wLeAnUwk5B19L29oZETZ9XlazQOxMqhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723243469; c=relaxed/simple;
	bh=mGspTgoMGXTo858ann4ORu9Ja4B3B7PSU7tT4rkWJss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rHvRq3RUQX1AyJ8A30/C469FukgE/KQjwwh4W9fDRaQBYJT86lVuk9Lt5RLoMQM/WZsKdAonDfueZ6Nk0DoJyTU8lTx9Xab9h2QeXS2GMUHmgNNKM/9loqGGs15xVrkOV7IRWr2fv8nC7Ep74OYx68DgiDyMewKhjymBPG1hoBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aY7VBeFM; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5bd13ea7604so379820a12.1;
        Fri, 09 Aug 2024 15:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723243465; x=1723848265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OjmtgbXaIAfffQGKX1XNRnGTnXYu+U8y7QcwkcqhF5w=;
        b=aY7VBeFMf5siV3QhQXf74FmGOooA05TZGDFRw6k7imYFUbBXSGnUlt8TXLVFJJ1CEZ
         E6stzeNiK2P7mxL+JT9RNzy2BNzTHIEXKLc70PrkSrQVbQmQBS6dslyfGX5vX9mJ9IS8
         VU9EkaW/dmpLnnEyTpmsIOdVafuRI15GqDXxAgIBTrzZr8RXrl18kr4cpJjIq8gGfPKr
         DjJnaem8lEyiACa7lIsVxw5A0rnOL8ScsehlSzswOa6D4Q6qCl/zfPnOU+vmjDp74+7f
         L3TUdJdZoLB4WTA7YGyngE/LRToZOTmRK9isEYOYtW1/qgFvEttOxvgSdrBMrbW3B1yM
         G8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723243465; x=1723848265;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OjmtgbXaIAfffQGKX1XNRnGTnXYu+U8y7QcwkcqhF5w=;
        b=kDOrtYoLZbrIZyhpKBRPgkohDNaoVqaIqppbd5ekbRUxVq5bxch9hruUo+nxpVR+5Q
         FwhyGEpKN50FB+6br/apnfEchzPTftKgU4L1Os3FCl/mV2BKABcyF9Gg8Vg5ZLj39yCl
         WldKrlKqYVoGtLA1T4vmCQs9N8uVayaILri46WAAhfJ4v6wpfWlls+Ay/FxDcVsywWo/
         yCCTKZrgWn2mqlyONKnEX9V44s3xlPlJtygaa3EIIS/9LMhHd8rydDuRPfyOzXK/Envi
         AW+qxtuvCQ/XZCoe58rb/oxqpxwF14MxYLaDcZE5gCZoNalyQztRrt84oceACAsoHGSq
         5Umw==
X-Forwarded-Encrypted: i=1; AJvYcCVtlXbyV691rbYe8RmHU2aWZxELYhYSHZfW0MiHJOvLNdMTBHR9sCkyfBhjR1dpLnPb2rcr6i9l/CDMNrHlut2StZd9HxuQ9wdylDtmMZz6rxwImwS0aD0qfKXkCuNZtmvJjHRMv5IAnjZYmcmC0m/QU+G7ByoBGqhbmWqxD7nfDKxMOiQBW/OM6W2u2mIKYfdXJ9UFTVVbPSr4jPDvzR/cLHl0J4p3dFKag1wmnP8x3XVxShuypXRmL1nRZSLQayPBN1vFAa2p
X-Gm-Message-State: AOJu0YwJGBYe/+kJ4LZLPdiKXPkfiBvNVIThOzW2pxkHCCsFBMoMYkdx
	Q1PqbTa/bxNYpp4ORGsxYLr0bVp1++fq7gZChx5TLQTHHRqsqtxg
X-Google-Smtp-Source: AGHT+IHEc06i/bxgwj6cyAZEz+TCJ7zV45O9Hht0ifyqi93/kgKJsehu+mhxqqCIHfkCa2+xYF7w8w==
X-Received: by 2002:a17:907:f769:b0:a7a:84f8:eaef with SMTP id a640c23a62f3a-a80aa5de1d0mr228146666b.35.1723243464838;
        Fri, 09 Aug 2024 15:44:24 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb213782sm16213466b.156.2024.08.09.15.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 15:44:24 -0700 (PDT)
Message-ID: <ea348f62-49e9-4b5e-9041-b0a696aaa736@gmail.com>
Date: Sat, 10 Aug 2024 00:44:21 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] platform/surface: Add OF support
To: Maximilian Luz <luzmaximilian@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <quic_kdybcio@quicinc.com>
References: <20240809-topic-sam-v1-0-05bca1932614@quicinc.com>
 <20240809-topic-sam-v1-3-05bca1932614@quicinc.com>
 <9ee8eb9d-1e1c-439f-a382-c003fbd7259c@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@gmail.com>
In-Reply-To: <9ee8eb9d-1e1c-439f-a382-c003fbd7259c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9.08.2024 8:09 PM, Maximilian Luz wrote:
> Hi,
> 
> Thanks for taking this up! A couple of comments below:

[...]


> Doc needs updating, this is just the one copied from
> ssam_controller_caps_load_acpi().

Oops.

[...]

>>   };
>>     -/* -- ACPI based device setup. ---------------------------------------------- */
>> +/* -- Serial device setup. ---------------------------------------------- */
> 
> Nitpick, but could we maybe keep that at 80 columns please? :)

Sure


> 
>>     static acpi_status ssam_serdev_setup_via_acpi_crs(struct acpi_resource *rsc,
>>                             void *ctx)
>> @@ -352,13 +355,28 @@ static acpi_status ssam_serdev_setup_via_acpi_crs(struct acpi_resource *rsc,
>>       return AE_CTRL_TERMINATE;
>>   }
>>   -static acpi_status ssam_serdev_setup_via_acpi(acpi_handle handle,
>> -                          struct serdev_device *serdev)
>> +static int ssam_serdev_setup_via_acpi(struct serdev_device *serdev, acpi_handle handle)
>>   {
>> -    return acpi_walk_resources(handle, METHOD_NAME__CRS,
>> -                   ssam_serdev_setup_via_acpi_crs, serdev);
>> +    acpi_status status;
>> +
>> +    status = acpi_walk_resources(handle, METHOD_NAME__CRS,
>> +                     ssam_serdev_setup_via_acpi_crs, serdev);
>> +
>> +    return status ? -ENXIO : 0;
>>   }
>>   +static int ssam_serdev_setup(struct acpi_device *ssh, struct serdev_device *serdev)
>> +{
>> +    if (ssh)
>> +        return ssam_serdev_setup_via_acpi(serdev, ssh->handle);
>> +
>> +    /* TODO: these values may differ per board/implementation */
>> +    serdev_device_set_baudrate(serdev, 4 * HZ_PER_MHZ);
> 
> Isn't this defined in the DT spec that you're adding as "current-speed"
> in patch 2? Why not load it from there?

Yeah and it's not under `required:`.. i added it for future proofing

> 
>> +    serdev_device_set_flow_control(serdev, true);
>> +    serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
>> +
>> +    return 0;
>> +}
>>     /* -- Power management. ----------------------------------------------------- */
>>   @@ -624,13 +642,15 @@ static int ssam_serial_hub_probe(struct serdev_device *serdev)
>>       acpi_status astatus;
> 
> This can be removed, see below.
> 
>>       int status;
>>   -    status = gpiod_count(dev, NULL);
>> -    if (status < 0)
>> -        return dev_err_probe(dev, status, "no GPIO found\n");
>> +    if (ssh) {
>> +        status = gpiod_count(dev, NULL);
>> +        if (status < 0)
>> +            return dev_err_probe(dev, status, "no GPIO found\n");
>>   -    status = devm_acpi_dev_add_driver_gpios(dev, ssam_acpi_gpios);
>> -    if (status)
>> -        return status;
>> +        status = devm_acpi_dev_add_driver_gpios(dev, ssam_acpi_gpios);
>> +        if (status)
>> +            return status;
>> +    }
>>         /* Allocate controller. */
>>       ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
>> @@ -655,7 +675,7 @@ static int ssam_serial_hub_probe(struct serdev_device *serdev)
>>           goto err_devopen;
>>       }
>>   -    astatus = ssam_serdev_setup_via_acpi(ssh->handle, serdev);
>> +    astatus = ssam_serdev_setup(ssh, serdev);>       if (ACPI_FAILURE(astatus)) {
> 
> ssam_serdev_setup() returns an int, so this should now just use
> "status".

Right


> 
>>           status = dev_err_probe(dev, -ENXIO, "failed to setup serdev\n");
>>           goto err_devinit;
>> @@ -717,10 +737,31 @@ static int ssam_serial_hub_probe(struct serdev_device *serdev)
>>        *       For now let's thus default power/wakeup to false.
>>        */
>>       device_set_wakeup_capable(dev, true);
>> +
>> +    /*
>> +     * When using DT, we have to register the platform hub driver manually,
>> +     * as it can't be matched based on top-level board compatible (like it
>> +     * does the ACPI case).
>> +     */
>> +    if (!ssh) {
>> +        struct platform_device *ph_pdev =
>> +            platform_device_register_simple("surface_aggregator_platform_hub",
>> +                            0, NULL, 0);
>> +        if (IS_ERR(ph_pdev))
>> +            return dev_err_probe(dev, PTR_ERR(ph_pdev),
>> +                         "Failed to register the platform hub driver\n");
>> +    }
>> +
>> +    status = ssam_register_clients(&serdev->dev, ctrl);
>> +    if (status)
>> +        goto err_clients;
> 
> Is the ssam_register_clients() call required or is it a remnant from a
> previous version? We're now not adding any children to the controller
> itself but model ACPI and do all of that with the platform hub. So
> unless I'm missing something, I think this should not be necessary.

Yeah, the platform hub driver calls it anyway

[...]

>> +static const struct software_node *ssam_node_group_sl7[] = {
>> +    &ssam_node_root,
>> +    &ssam_node_bat_ac,
>> +    &ssam_node_bat_main,
>> +    &ssam_node_tmp_perf_profile_with_fan,
>> +    &ssam_node_fan_speed,
>> +    &ssam_node_hid_sam_keyboard,
> 
> Did you check if there are any other HID devices connected? In the past,
> keyboard and touchpad have been split into two separate devices, so is
> it a combo keyboard + touchpad device this time? Some models also had
> HID-based sensor and other devices.

No, touchpad is wired directly to the SoC via QSPI, same for the touch
panel

> 
> Would just be good to know if this can be assumed to be complete or if
> we're maybe missing something here.
> 
>> +    /* TODO: evaluate thermal sensors devices when we get a driver for that */
> 
> FYI I've posted the driver at [1]. It needs a small Kbuild dependency
> fix but apart from that I think it should be final, if you want to give
> that a try.
> 
> [1]: https://lore.kernel.org/lkml/20240804230832.247852-1-luzmaximilian@gmail.com/T/

I'll give it a shot, thanks

> 
> The rest looks fine. I'll try to find some time to update my SPX branch
> this weekend and give it a spin.

About time that thing lands upstream ;)

Konrad

