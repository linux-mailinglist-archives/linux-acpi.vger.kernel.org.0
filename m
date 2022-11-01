Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86511614742
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Nov 2022 10:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiKAJxJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Nov 2022 05:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiKAJxI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Nov 2022 05:53:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8590193C3
        for <linux-acpi@vger.kernel.org>; Tue,  1 Nov 2022 02:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667296328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ixoTAvrdki507b7MkiviwG5z9O5rlwU7YLzuBElexw=;
        b=gGvB72hFal9egLOd24YjTZnJi+dZjX45xCl2FMJXdaDbS6aFpkS/WnBMnjANyor25BMwyX
        RmHi/tqPlIHWLOsXkwPFwG0F6PpdPL5omS2rCMXLrze12DuCTESsUDdTiQvJqAr0JCVTVj
        pjUM8T7U2jAChiBMC9ZJ2xNdFUdWxfE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-12-ciZBmEJ5Po-hAwT0FK9-6Q-1; Tue, 01 Nov 2022 05:52:06 -0400
X-MC-Unique: ciZBmEJ5Po-hAwT0FK9-6Q-1
Received: by mail-ej1-f70.google.com with SMTP id hq18-20020a1709073f1200b007ade8dd3494so1308782ejc.2
        for <linux-acpi@vger.kernel.org>; Tue, 01 Nov 2022 02:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ixoTAvrdki507b7MkiviwG5z9O5rlwU7YLzuBElexw=;
        b=NKXTED4QUGaELFdA2EaVwFii4PKQipFy5hvI6nh6snJYtdGPNwJ5I4RzjEU+novRs5
         MFiIp5zUxWngdvJ7fX2BTVIFdhPyuW96GcnpwEnf0K1qiOayhij+0m4BSWA4193AOSq8
         jOaed7xSgq2Pi0dzwy+xVxw4pLlhQoxr7qa6cZzMO3w2M+i6brZnOo10JQzf7Usi2wc6
         huwPKdrK/uFT8TB7kwbWxXzppA6MPW8hab2X+1gHavqx+B5aQcehT2Bcjh0MXwX3/wMk
         39G3KapstPE+dR6DeXXoKhjeTgaKLCG9pG8ZelF60aR5JZuJrlyltTRLR36UcuHWzDyT
         fBuw==
X-Gm-Message-State: ACrzQf1erFEHmROmp9p/pEPSyaTObCya3CxFpumxEgoKJgBUtVH/WEti
        WUUjY05U1/V8hI6/Vzd96VVlRoT/xnqBSLSzJyl5yi+OzTLshb9Ho+li9t6cIPiNL9OArkN/dfI
        H0usB5IQRCnAPQYeYJjxZsw==
X-Received: by 2002:a17:907:86a0:b0:78d:df8b:4d17 with SMTP id qa32-20020a17090786a000b0078ddf8b4d17mr17020432ejc.254.1667296325427;
        Tue, 01 Nov 2022 02:52:05 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6Nxr23Dm7cVeOT8KLoB8ETNcuodjAJY+jRPBwaaWgsTEG1p5FlB9eMk8hSJB9/ymzw/0sHtQ==
X-Received: by 2002:a17:907:86a0:b0:78d:df8b:4d17 with SMTP id qa32-20020a17090786a000b0078ddf8b4d17mr17020414ejc.254.1667296325187;
        Tue, 01 Nov 2022 02:52:05 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id y34-20020a50bb25000000b00462bd673453sm4381230ede.39.2022.11.01.02.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 02:52:04 -0700 (PDT)
Message-ID: <edb8e436-739d-1c91-d697-142681520e8c@redhat.com>
Date:   Tue, 1 Nov 2022 10:52:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] ACPI: video: Add backlight=native DMI quirk for Dell G15
 5515
Content-Language: en-US, nl
To:     Daniel Dadap <ddadap@nvidia.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20221031212556.401618-1-hdegoede@redhat.com>
 <Y2BHpKxWitLSMFER@lenny>
From:   Hans de Goede <hdegoede@redhat.com>
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

Hi,

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

Isn't the whole idea behind nvidia-wmi-ec-backlight that the backlight's
pwm input is connected to the EC (it is sorta in the name) and then always
is controlled by the EC independent of the mode ?

At least I was under the impression that that was the whole idea?

I will forward your email to the reporter and ask them to get
in touch with you and then lets see from there.

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

