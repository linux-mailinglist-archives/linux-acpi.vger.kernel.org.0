Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCB8614C47
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Nov 2022 15:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiKAOKG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Nov 2022 10:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiKAOKF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Nov 2022 10:10:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5FD1AF25
        for <linux-acpi@vger.kernel.org>; Tue,  1 Nov 2022 07:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667311748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fVSeLqpEVoToYlNB+tKBI6A4oOh8H8g9nR5Hfp9ngAc=;
        b=BP6A7EndqBLa/wBWqhPvhVhQg3HSJwlJXLQBJd4kMnI8gMaAYpso5ByFlDzcdqIif3MTk/
        R4i1DErAibwtaB+uE5+GIptTwIV59J6/wrkuzuWvJTRYi0fetWwx9Hay4LWlGXpI9wpNX9
        P8RCUAmL6uil0AgL8ldV6/O1S8smDzc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-634-gxpDgUAmMLmhcZ4KVbqH1w-1; Tue, 01 Nov 2022 10:09:06 -0400
X-MC-Unique: gxpDgUAmMLmhcZ4KVbqH1w-1
Received: by mail-ej1-f72.google.com with SMTP id gt15-20020a1709072d8f00b007aaac7973fbso8016992ejc.23
        for <linux-acpi@vger.kernel.org>; Tue, 01 Nov 2022 07:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fVSeLqpEVoToYlNB+tKBI6A4oOh8H8g9nR5Hfp9ngAc=;
        b=AovrqoKmN5ARyS7SZhjG5VSI0CLhWL+l+VBeKQugvJHsGKiyzSeHpWcR65AbW1v6ao
         6/o1SXtLxeDm2KDkiK3/YU6l8wvpfNB6nYdkMzMipzbMuPA+Lh+9e6iKvBjnNecW0uoc
         br1pUNgcit9pO6P1RuwoZSLmKiO7RC61F3koPkxPOPVxyJX0mRtlWylv8C6D1lzsnp6y
         UENifS9xTl0uik3r15VRPF5KFEiMSYX7U2+m3BfaxcMAkadfDbsIQ/KS/26vaRBCXZzp
         x5bmHb95o5rOCfYV6oyFXZGuWfc85dGL0Qb6DmdDkhJnkRg1XKg0QyewVhOayRjQDOx9
         ht5g==
X-Gm-Message-State: ACrzQf3xWlj4vbsqKF/3LWN/mliNxYikgx1O1NKf2kk0hdEvy2z9VItV
        +3yEdjY8TRJ07VXgFc1rrg4RTO1gqRW6WmK3EItu7srlactvfqSNxDKxGpV4wicFUNUzQap5Nge
        q3ZL65IHcBMfndbivk1yYtQ==
X-Received: by 2002:a05:6402:2550:b0:462:38d7:a6e1 with SMTP id l16-20020a056402255000b0046238d7a6e1mr19667148edb.337.1667311745778;
        Tue, 01 Nov 2022 07:09:05 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5S5mVcDyO7NrTT7mMA5hRTBT5QtYNZB/bXn+Byv+W3Kdzn9nZnmDtCt27JDD/HMDZZJlx/qQ==
X-Received: by 2002:a05:6402:2550:b0:462:38d7:a6e1 with SMTP id l16-20020a056402255000b0046238d7a6e1mr19667118edb.337.1667311745537;
        Tue, 01 Nov 2022 07:09:05 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090676c700b007ad94422cf6sm4220162ejn.198.2022.11.01.07.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 07:09:04 -0700 (PDT)
Message-ID: <0cd572ac-fdda-f364-8558-2b6da9a0b901@redhat.com>
Date:   Tue, 1 Nov 2022 15:09:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ACPI: video: Add backlight=native DMI quirk for Dell G15
 5515
To:     Daniel Dadap <ddadap@nvidia.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20221031212556.401618-1-hdegoede@redhat.com>
 <Y2BHpKxWitLSMFER@lenny>
Content-Language: en-US, nl
In-Reply-To: <Y2BHpKxWitLSMFER@lenny>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Daniel,

On 10/31/22 23:09, Daniel Dadap wrote:
> Thanks, Hans:
> 
> On Mon, Oct 31, 2022 at 10:25:56PM +0100, Hans de Goede wrote:
>> The Dell G15 5515 has the WMI interface (and WMI call returns) expected
>> by the nvidia-wmi-ec-backlight interface. But the backlight class device
>> registered by the nvidia-wmi-ec-backlight driver does not actually work.
>>
>> The amdgpu_bl0 native GPU backlight class device does actually work,
>> add a backlight=native DMI quirk for this.
> 
> I'm not certain whether you have direct access to the system, but I am
> curious as to what mode the system is in when it exposes a non-working
> WMI backlight interface. The expectation is that the WMI EC backlight
> interface should only be exposed when the system is in dynamic mode
> (different vendors may call this differeint things in the EFI setup
> menus), and the native backlight interfaces for the GPUs, be they
> discrete or integrated, should only be exposed when a mode that keeps
> only one of the GPUs connected to the panel; i.e., in discrete-only mode
> the discrete GPU should have a working native backlight interface, and
> in integrated-only mode, or a hybrid mode which does not allow dynamic
> mux switching, the integrated GPU should have a working native backlight
> interface.
> 
> For this notebook the AMD GPU would be the integrated one, so if the
> system is *not* in dynamic switch mode, and the WMI interface is
> reporting that the backlight should be handled by the EC, then that is
> certainly a bug in the system, and this would be the correct workaround,
> when the system is operating in an iGPU-only or non-dynamic hybrid mode.
> However, if the system is switched to a dynamic mode, then this would
> break the EC backlight, which should be the corect backlight interface
> for that case. Another possible system bug would be if the condition
> described in the change description occurs when the system *is* in a
> dynamic mode, but is routing backlight control to the iGPU anyway. That
> would be a messier bug to deal with, since it would also be necessary to
> determine which backlight interface is functional when the display is
> switched over to the dGPU.
> 
> If it's not too much trouble could you (or the reporter, if you don't
> have the system) check which backlight interfaces are exposed, and which
> of those actually work, for each of the different hybrid GPU modes? I am
> not certain what they would be called on the setup screen, but the
> possible modes should be:
> 
> * Integrated only
> * Discrete only
> * Hybrid, without dynamic switching
> * Hybrid, with dynamic switching
> 
> , or a subset thereof. Usually I would expect the minimal subset to be
> discrete only plus one or both of the hybrid modes. Since we're not sure
> what these are called on the setup screen it is probably best to simply
> report the names of the mode as they are listed in the UI.

I have heard back from the reporter about this and they report that
there is no option in the BIOS to select the mode. And currently the
machine is running in Hybrid mode, with it being unclear if this
supports dynamic switching or not.

Regards,

Hans



> 
>> Cc: Daniel Dadap <ddadap@nvidia.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/acpi/video_detect.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
>> index 841f6213b4de..88acc09773bb 100644
>> --- a/drivers/acpi/video_detect.c
>> +++ b/drivers/acpi/video_detect.c
>> @@ -645,6 +645,16 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>>  		},
>>  	},
>>  
>> +	/* Models which have nvidia-ec-wmi support, but should not use it. */
>> +	{
>> +	 .callback = video_detect_force_native,
>> +	 /* Dell G15 5515 */
>> +	 .matches = {
>> +		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>> +		DMI_MATCH(DMI_PRODUCT_NAME, "Dell G15 5515"),
>> +		},
>> +	},
>> +
>>  	/*
>>  	 * Desktops which falsely report a backlight and which our heuristics
>>  	 * for this do not catch.
>> -- 
>> 2.37.3
>>
> 


