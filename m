Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BD661474B
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Nov 2022 10:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiKAJ4s (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Nov 2022 05:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKAJ4p (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Nov 2022 05:56:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABF813FBE
        for <linux-acpi@vger.kernel.org>; Tue,  1 Nov 2022 02:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667296553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OJmHcYA2N2DrTvtWY7W09B5EQ1oCozKKT2Lm1WdA1Gk=;
        b=GwimDc2lmcDB+vRg/WVlMi57QX/ypUrbHPMNRfCdaqpsCEPU3rvif1laN/z0MSDIdn0Z6M
        XFafZ6AdSkGichtDIhlrEX3bJSNBIZ5+nUygpPtPptwdpqPAaHHD4Z8QSNd4c9/q5BQbE1
        GNsAo9IZouyW1iqS3J5i8kC3Yw+uDrY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-553-L31kixlqMm6Kv62bT5Pofg-1; Tue, 01 Nov 2022 05:55:52 -0400
X-MC-Unique: L31kixlqMm6Kv62bT5Pofg-1
Received: by mail-ej1-f70.google.com with SMTP id hs34-20020a1709073ea200b007ad86f91d39so7502879ejc.10
        for <linux-acpi@vger.kernel.org>; Tue, 01 Nov 2022 02:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OJmHcYA2N2DrTvtWY7W09B5EQ1oCozKKT2Lm1WdA1Gk=;
        b=6cyOqeZcW7AZgFZ1DXNqeZeeQqCJ0NVopb/qVcST47GRFyKAp+Vri3rQAxdXwZNbIq
         3voU8We/UcDVVVE172DRm/pgonbwCLkwWjKf+uGIku9265ZRqczM77SQ3bFtTW4UMj9v
         Pb+iP//3FKT1pvewZVsVa9WPTyPy5PL+Lwl50Roqt27UWcKcis0AoGQuOv74zyU2uIld
         cQGz0LUdHeKujF+GlytFdrtM2p0MTLHH8llJZIKQ4+ejnEUrHjmqaZT8oCr9i29sTOWH
         3n4ggN2W8RJEaUHyuYYhJmqN9FWxzdDVeXiIWjhl8J5ZPNiinFDZ5vI/bh4u3MW04YE5
         VkvQ==
X-Gm-Message-State: ACrzQf0DQ0GgYchxMHSN/GMS3eLv4jpfNkxjh3KILSthBwGBdzgEmMXi
        +o7z6mNyCZl1mrbBczXIlabN+Rbp+LOlRIOuIXAXA/LzQQlwOySGfvmvmcI+UOlIfntRBpjEGtZ
        rtoyqZA0ULT9SbOGuF/vnUw==
X-Received: by 2002:a17:907:70a:b0:750:bf91:caa3 with SMTP id xb10-20020a170907070a00b00750bf91caa3mr17574139ejb.711.1667296551214;
        Tue, 01 Nov 2022 02:55:51 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7YlkpL1VXKsBRlm3DctdBo/qJTJ2vMsT+W0orSGBojh0BfvR6eYhFW/vFy+GnF78w+ghaX2Q==
X-Received: by 2002:a17:907:70a:b0:750:bf91:caa3 with SMTP id xb10-20020a170907070a00b00750bf91caa3mr17574128ejb.711.1667296551036;
        Tue, 01 Nov 2022 02:55:51 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id q4-20020a056402248400b004623028c594sm4311786eda.49.2022.11.01.02.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 02:55:50 -0700 (PDT)
Message-ID: <c3c7ca66-979d-a5fa-a116-9fa2926a271d@redhat.com>
Date:   Tue, 1 Nov 2022 10:55:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] ACPI: video: Add backlight=native DMI quirk for Dell G15
 5515
Content-Language: en-US, nl
To:     Daniel Dadap <ddadap@nvidia.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <20221031212556.401618-1-hdegoede@redhat.com>
 <MN0PR12MB6101C2BD5FAEC45B51B61667E2379@MN0PR12MB6101.namprd12.prod.outlook.com>
 <Y2BKSVzCON8PZctU@lenny>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Y2BKSVzCON8PZctU@lenny>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 10/31/22 23:20, Daniel Dadap wrote:
> On Mon, Oct 31, 2022 at 09:51:55PM +0000, Limonciello, Mario wrote:
>> [Public]
>>
>>> -----Original Message-----
>>> From: Hans de Goede <hdegoede@redhat.com>
>>> Sent: Monday, October 31, 2022 16:26
>>> To: Rafael J . Wysocki <rafael@kernel.org>
>>> Cc: Hans de Goede <hdegoede@redhat.com>; Len Brown
>>> <lenb@kernel.org>; linux-acpi@vger.kernel.org; platform-driver-
>>> x86@vger.kernel.org; Daniel Dadap <ddadap@nvidia.com>
>>> Subject: [PATCH] ACPI: video: Add backlight=native DMI quirk for Dell G15
>>> 5515
>>>
>>> The Dell G15 5515 has the WMI interface (and WMI call returns) expected
>>> by the nvidia-wmi-ec-backlight interface. But the backlight class device
>>> registered by the nvidia-wmi-ec-backlight driver does not actually work.
>>>
>>
>> Is there a way to detect this from nvidia-wmi-ec-backlight?  I would think it's
>> cleaner to have that driver return -ENODEV so you end up with just the "working"
>> amdgpu_bl0.
> 
> That would be ideal, although I'm not certain whether this would work
> with the new backlight control type selection model where video.ko
> determines what type of backlight interface the system is supposed to
> have. I am assuming that the below patch is against a kernel predating
> the recent changes that Hans made to rework the backlight subsystem,
> because IIUC it shouldn't be possible for both the EC backlight driver
> and the iGPU's native one to both be active at the same time. I would
> expect that without this patch, there would be no working backlight
> interfaces on this system when running a newer kernel, since
> __acpi_video_get_backlight_type() would return
> acpi_backlight_nvidia_wmi_ec, which means
> acpi_video_backlight_use_native() would return false, and the iGPU
> native driver should not be registering a brightness handler.

The reporter needs to blacklist the nvidia-wmi-ec-backlight module
because with 6.0 they otherwise get both that backlight + the native
amdgpu backlight in /sys/class/backlight and then userspace will
prefer the nvidia-wmi-ec-backlight one which according to the reporter
does not work.

You are correct that with 6.1 the issue is that the native driver
now honors the acpi_video_get_backlight_type() return and no longer
registers. This is fixed by this patch.

The good news is that with 6.1 nvidia-wmi-ec-backlight now also honors
acpi_video_get_backlight_type() so the quirk also avoids the need
to blacklist nvidia-wmi-ec-backlight and with the quirk in 6.1 everything
just works OOTB (with the current BIOS settings for the GPU mode).

Regards,

Hans


>  
>>> The amdgpu_bl0 native GPU backlight class device does actually work,
>>> add a backlight=native DMI quirk for this.
>>>
>>> Cc: Daniel Dadap <ddadap@nvidia.com>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>>  drivers/acpi/video_detect.c | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
>>> index 841f6213b4de..88acc09773bb 100644
>>> --- a/drivers/acpi/video_detect.c
>>> +++ b/drivers/acpi/video_detect.c
>>> @@ -645,6 +645,16 @@ static const struct dmi_system_id
>>> video_detect_dmi_table[] = {
>>>  		},
>>>  	},
>>>
>>> +	/* Models which have nvidia-ec-wmi support, but should not use it.
>>> */
>>> +	{
>>> +	 .callback = video_detect_force_native,
>>> +	 /* Dell G15 5515 */
>>> +	 .matches = {
>>> +		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>>> +		DMI_MATCH(DMI_PRODUCT_NAME, "Dell G15 5515"),
>>> +		},
>>> +	},
>>> +
>>>  	/*
>>>  	 * Desktops which falsely report a backlight and which our heuristics
>>>  	 * for this do not catch.
>>> --
>>> 2.37.3
> 

