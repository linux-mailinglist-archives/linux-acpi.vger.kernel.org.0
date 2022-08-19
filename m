Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8976659997B
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Aug 2022 12:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348114AbiHSKFl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Aug 2022 06:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348313AbiHSKFh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Aug 2022 06:05:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C43EEF03
        for <linux-acpi@vger.kernel.org>; Fri, 19 Aug 2022 03:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660903534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ClrqC6xI3y34Msl2MghOyY6wxIWtFZ3bYpyy58JPY0M=;
        b=ewMUXRkHFBhfedn4ytU/x0XKNenTNUOPk2ou2/Jqs1n4dRh9xBRkC//rmKfFv03ZJyG8ZX
        2EjSfVgAFo71mew2DTPksFKq7/nF0guIEZCpCM1IcVhkiRYQSvEE5IOpm3IX1vpVcPEWMA
        pEdxzzWUSnasPx8D00eddLc4xsThr4k=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-272-C_6vC5NnNQyKkNQZGPQmIg-1; Fri, 19 Aug 2022 06:05:33 -0400
X-MC-Unique: C_6vC5NnNQyKkNQZGPQmIg-1
Received: by mail-ed1-f69.google.com with SMTP id y16-20020a056402359000b0043db5186943so2572487edc.3
        for <linux-acpi@vger.kernel.org>; Fri, 19 Aug 2022 03:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ClrqC6xI3y34Msl2MghOyY6wxIWtFZ3bYpyy58JPY0M=;
        b=BOiHEKe6dsi6lEXjxAHnrgNDKNQVGjBLcWlAzdqq+FMuHUYOh1cxrHe9BXxke/TmWZ
         L2TWSHBNwaNzL0jsaoBFxhNDNxi+rmgwNiUXqGoh1sNZ2PqHh/HTK75tvJT3piGZHJrd
         6vrsMyCY64/yWtEpXWMdf8iRv2rBLySVZSDvHIKgHNyQOU34q8olTz27VgasuExJ5WO2
         YYJmEQqkAaK1FSPevI0LyQxLYZbri4PVq7NW4T0CVdLY+fs2lHsDI7eXtttcyTpOSBH8
         8p4fdTUrsU2ihSKCyQxzCKoZbFnHQkeA8bO1QwTMeAphp/FmPldate85e1or/47Pn8NC
         d3JA==
X-Gm-Message-State: ACgBeo1pVIxCnhZshUFbfQTAJ4JIhS7l1GrImZLgDMvPKrMCarLQCWvX
        NSTMbnFIdHbntVZC3spPGLRnIzLFM5AdiZ9j1R3+xhKZPMA+A3tENAkoNsSjDfq2rf8v61IVDOk
        g1bjVmncbVEUBQrzepkkuBw==
X-Received: by 2002:a05:6402:84e:b0:440:4bac:be5a with SMTP id b14-20020a056402084e00b004404bacbe5amr5564246edz.103.1660903532650;
        Fri, 19 Aug 2022 03:05:32 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7fU47agb0EFZDnJX43gsuZ1SU7OR4Ob90bb0C5SXvvscJYiU83fnrABD1bw+CGIeNcDMsT+g==
X-Received: by 2002:a05:6402:84e:b0:440:4bac:be5a with SMTP id b14-20020a056402084e00b004404bacbe5amr5564218edz.103.1660903532345;
        Fri, 19 Aug 2022 03:05:32 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id q29-20020a056402249d00b0043ca6fb7e7dsm2780438eda.68.2022.08.19.03.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 03:05:31 -0700 (PDT)
Message-ID: <d5767b2e-a20f-43ca-61d7-6ea577b31188@redhat.com>
Date:   Fri, 19 Aug 2022 12:05:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 15/31] platform/x86: nvidia-wmi-ec-backlight: Move fw
 interface definitions to a header
Content-Language: en-US
To:     Daniel Dadap <ddadap@nvidia.com>, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>, Lyude <lyude@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Xinhui <Xinhui.Pan@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     nouveau@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20220818184302.10051-1-hdegoede@redhat.com>
 <20220818184302.10051-16-hdegoede@redhat.com>
 <12cc48c5-b54f-1eb7-c268-beb98bce2a5d@nvidia.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <12cc48c5-b54f-1eb7-c268-beb98bce2a5d@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 8/18/22 21:38, Daniel Dadap wrote:
> 
> On 8/18/22 1:42 PM, Hans de Goede wrote:
>> Move the WMI interface definitions to a header, so that the definitions
>> can be shared with drivers/acpi/video_detect.c .
>>
>> Suggested-by: Daniel Dadap <ddadap@nvidia.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   MAINTAINERS                                   |  1 +
>>   .../platform/x86/nvidia-wmi-ec-backlight.c    | 66 +----------------
>>   .../x86/nvidia-wmi-ec-backlight.h             | 70 +++++++++++++++++++
>>   3 files changed, 72 insertions(+), 65 deletions(-)
>>   create mode 100644 include/linux/platform_data/x86/nvidia-wmi-ec-backlight.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8a5012ba6ff9..8d59c6e9b4db 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -14526,6 +14526,7 @@ M:    Daniel Dadap <ddadap@nvidia.com>
>>   L:    platform-driver-x86@vger.kernel.org
>>   S:    Supported
>>   F:    drivers/platform/x86/nvidia-wmi-ec-backlight.c
>> +F:    include/linux/platform_data/x86/nvidia-wmi-ec-backlight.h
>>     NVM EXPRESS DRIVER
>>   M:    Keith Busch <kbusch@kernel.org>
>> diff --git a/drivers/platform/x86/nvidia-wmi-ec-backlight.c b/drivers/platform/x86/nvidia-wmi-ec-backlight.c
>> index 61e37194df70..e84e1d629b14 100644
>> --- a/drivers/platform/x86/nvidia-wmi-ec-backlight.c
>> +++ b/drivers/platform/x86/nvidia-wmi-ec-backlight.c
>> @@ -7,74 +7,10 @@
>>   #include <linux/backlight.h>
>>   #include <linux/mod_devicetable.h>
>>   #include <linux/module.h>
>> +#include <linux/platform_data/x86/nvidia-wmi-ec-backlight.h>
>>   #include <linux/types.h>
>>   #include <linux/wmi.h>
>>   -/**
>> - * enum wmi_brightness_method - WMI method IDs
>> - * @WMI_BRIGHTNESS_METHOD_LEVEL:  Get/Set EC brightness level status
>> - * @WMI_BRIGHTNESS_METHOD_SOURCE: Get/Set EC Brightness Source
>> - */
>> -enum wmi_brightness_method {
>> -    WMI_BRIGHTNESS_METHOD_LEVEL = 1,
>> -    WMI_BRIGHTNESS_METHOD_SOURCE = 2,
>> -    WMI_BRIGHTNESS_METHOD_MAX
>> -};
>> -
>> -/**
>> - * enum wmi_brightness_mode - Operation mode for WMI-wrapped method
>> - * @WMI_BRIGHTNESS_MODE_GET:            Get the current brightness level/source.
>> - * @WMI_BRIGHTNESS_MODE_SET:            Set the brightness level.
>> - * @WMI_BRIGHTNESS_MODE_GET_MAX_LEVEL:  Get the maximum brightness level. This
>> - *                                      is only valid when the WMI method is
>> - *                                      %WMI_BRIGHTNESS_METHOD_LEVEL.
>> - */
>> -enum wmi_brightness_mode {
>> -    WMI_BRIGHTNESS_MODE_GET = 0,
>> -    WMI_BRIGHTNESS_MODE_SET = 1,
>> -    WMI_BRIGHTNESS_MODE_GET_MAX_LEVEL = 2,
>> -    WMI_BRIGHTNESS_MODE_MAX
>> -};
>> -
>> -/**
>> - * enum wmi_brightness_source - Backlight brightness control source selection
>> - * @WMI_BRIGHTNESS_SOURCE_GPU: Backlight brightness is controlled by the GPU.
>> - * @WMI_BRIGHTNESS_SOURCE_EC:  Backlight brightness is controlled by the
>> - *                             system's Embedded Controller (EC).
>> - * @WMI_BRIGHTNESS_SOURCE_AUX: Backlight brightness is controlled over the
>> - *                             DisplayPort AUX channel.
>> - */
>> -enum wmi_brightness_source {
>> -    WMI_BRIGHTNESS_SOURCE_GPU = 1,
>> -    WMI_BRIGHTNESS_SOURCE_EC = 2,
>> -    WMI_BRIGHTNESS_SOURCE_AUX = 3,
>> -    WMI_BRIGHTNESS_SOURCE_MAX
>> -};
>> -
>> -/**
>> - * struct wmi_brightness_args - arguments for the WMI-wrapped ACPI method
>> - * @mode:    Pass in an &enum wmi_brightness_mode value to select between
>> - *           getting or setting a value.
>> - * @val:     In parameter for value to set when using %WMI_BRIGHTNESS_MODE_SET
>> - *           mode. Not used in conjunction with %WMI_BRIGHTNESS_MODE_GET or
>> - *           %WMI_BRIGHTNESS_MODE_GET_MAX_LEVEL mode.
>> - * @ret:     Out parameter returning retrieved value when operating in
>> - *           %WMI_BRIGHTNESS_MODE_GET or %WMI_BRIGHTNESS_MODE_GET_MAX_LEVEL
>> - *           mode. Not used in %WMI_BRIGHTNESS_MODE_SET mode.
>> - * @ignored: Padding; not used. The ACPI method expects a 24 byte params struct.
>> - *
>> - * This is the parameters structure for the WmiBrightnessNotify ACPI method as
>> - * wrapped by WMI. The value passed in to @val or returned by @ret will be a
>> - * brightness value when the WMI method ID is %WMI_BRIGHTNESS_METHOD_LEVEL, or
>> - * an &enum wmi_brightness_source value with %WMI_BRIGHTNESS_METHOD_SOURCE.
>> - */
>> -struct wmi_brightness_args {
>> -    u32 mode;
>> -    u32 val;
>> -    u32 ret;
>> -    u32 ignored[3];
>> -};
>> -
>>   /**
>>    * wmi_brightness_notify() - helper function for calling WMI-wrapped ACPI method
>>    * @w:    Pointer to the struct wmi_device identified by %WMI_BRIGHTNESS_GUID
>> diff --git a/include/linux/platform_data/x86/nvidia-wmi-ec-backlight.h b/include/linux/platform_data/x86/nvidia-wmi-ec-backlight.h
>> new file mode 100644
>> index 000000000000..d83104c6c6cb
>> --- /dev/null
>> +++ b/include/linux/platform_data/x86/nvidia-wmi-ec-backlight.h
>> @@ -0,0 +1,70 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
> 
> 
> Should the copyright notice from nvidia-wmi-ec-backlight be copied here as well?

Ah right, I forgot that. I'll fix that for version 4 of the series.

I'll also make the GUID a #define for version 4 of the series as
you mentioned in one of your other remarks.

>> +#ifndef __PLATFORM_DATA_X86_NVIDIA_WMI_EC_BACKLIGHT_H
>> +#define __PLATFORM_DATA_X86_NVIDIA_WMI_EC_BACKLIGHT_H
>> +
>> +/**
>> + * enum wmi_brightness_method - WMI method IDs
>> + * @WMI_BRIGHTNESS_METHOD_LEVEL:  Get/Set EC brightness level status
>> + * @WMI_BRIGHTNESS_METHOD_SOURCE: Get/Set EC Brightness Source
>> + */
>> +enum wmi_brightness_method {
>> +    WMI_BRIGHTNESS_METHOD_LEVEL = 1,
>> +    WMI_BRIGHTNESS_METHOD_SOURCE = 2,
>> +    WMI_BRIGHTNESS_METHOD_MAX
>> +};
> 
> 
> It might be nice, but certainly not essential, to namespace these better, now that they're no longer internal to the EC backlight driver. I did that in the version of this change that I had started working up, but got kind of annoyed that it made a lot of lines go over 80 columns, and then got distracted by other work and never ended up finishing the change up. I guess it's probably fine to leave them as is, since there won't be many files that include this header.

This header is only used in 2 .c files, as such I'm not worried about
namespacing the defines, so my plan for version 4 is to just keep
this as is.

Regards,

Hans


> 
> 
>> +
>> +/**
>> + * enum wmi_brightness_mode - Operation mode for WMI-wrapped method
>> + * @WMI_BRIGHTNESS_MODE_GET:            Get the current brightness level/source.
>> + * @WMI_BRIGHTNESS_MODE_SET:            Set the brightness level.
>> + * @WMI_BRIGHTNESS_MODE_GET_MAX_LEVEL:  Get the maximum brightness level. This
>> + *                                      is only valid when the WMI method is
>> + *                                      %WMI_BRIGHTNESS_METHOD_LEVEL.
>> + */
>> +enum wmi_brightness_mode {
>> +    WMI_BRIGHTNESS_MODE_GET = 0,
>> +    WMI_BRIGHTNESS_MODE_SET = 1,
>> +    WMI_BRIGHTNESS_MODE_GET_MAX_LEVEL = 2,
>> +    WMI_BRIGHTNESS_MODE_MAX
>> +};
>> +
>> +/**
>> + * enum wmi_brightness_source - Backlight brightness control source selection
>> + * @WMI_BRIGHTNESS_SOURCE_GPU: Backlight brightness is controlled by the GPU.
>> + * @WMI_BRIGHTNESS_SOURCE_EC:  Backlight brightness is controlled by the
>> + *                             system's Embedded Controller (EC).
>> + * @WMI_BRIGHTNESS_SOURCE_AUX: Backlight brightness is controlled over the
>> + *                             DisplayPort AUX channel.
>> + */
>> +enum wmi_brightness_source {
>> +    WMI_BRIGHTNESS_SOURCE_GPU = 1,
>> +    WMI_BRIGHTNESS_SOURCE_EC = 2,
>> +    WMI_BRIGHTNESS_SOURCE_AUX = 3,
>> +    WMI_BRIGHTNESS_SOURCE_MAX
>> +};
>> +
>> +/**
>> + * struct wmi_brightness_args - arguments for the WMI-wrapped ACPI method
>> + * @mode:    Pass in an &enum wmi_brightness_mode value to select between
>> + *           getting or setting a value.
>> + * @val:     In parameter for value to set when using %WMI_BRIGHTNESS_MODE_SET
>> + *           mode. Not used in conjunction with %WMI_BRIGHTNESS_MODE_GET or
>> + *           %WMI_BRIGHTNESS_MODE_GET_MAX_LEVEL mode.
>> + * @ret:     Out parameter returning retrieved value when operating in
>> + *           %WMI_BRIGHTNESS_MODE_GET or %WMI_BRIGHTNESS_MODE_GET_MAX_LEVEL
>> + *           mode. Not used in %WMI_BRIGHTNESS_MODE_SET mode.
>> + * @ignored: Padding; not used. The ACPI method expects a 24 byte params struct.
>> + *
>> + * This is the parameters structure for the WmiBrightnessNotify ACPI method as
>> + * wrapped by WMI. The value passed in to @val or returned by @ret will be a
>> + * brightness value when the WMI method ID is %WMI_BRIGHTNESS_METHOD_LEVEL, or
>> + * an &enum wmi_brightness_source value with %WMI_BRIGHTNESS_METHOD_SOURCE.
>> + */
>> +struct wmi_brightness_args {
>> +    u32 mode;
>> +    u32 val;
>> +    u32 ret;
>> +    u32 ignored[3];
>> +};
>> +
>> +#endif
> 

