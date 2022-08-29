Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683795A4AD4
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Aug 2022 13:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiH2L7A (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Aug 2022 07:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiH2L6g (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Aug 2022 07:58:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3EA844D2
        for <linux-acpi@vger.kernel.org>; Mon, 29 Aug 2022 04:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661773312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3l2HRNkVfIlxa2ShqNnx3ZVFXVGd+8W6TGzJQVH9z/E=;
        b=NGen50uW2vgSYbocddnt6rDebysUnVb1sCZ2XHQO2WW4AZFT38kux8zyv7f0+hxUbqJ1Ga
        RZ1O+zYxBfGTjO7tlZc6LazcHalxcOVl3IP3iB6xjreLULW18qwQPr4pa9VajOXxQi/hMy
        rjyzndmR9pwDTWGMlQ/YT0FiGtSvutQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-493-t186dx77MT-XXPBBhFiMyw-1; Mon, 29 Aug 2022 07:41:42 -0400
X-MC-Unique: t186dx77MT-XXPBBhFiMyw-1
Received: by mail-ed1-f69.google.com with SMTP id y12-20020a056402358c00b00448898f1c33so938883edc.7
        for <linux-acpi@vger.kernel.org>; Mon, 29 Aug 2022 04:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=3l2HRNkVfIlxa2ShqNnx3ZVFXVGd+8W6TGzJQVH9z/E=;
        b=ZL0lysVE1MGCeCf10yQLaERsc2Vm0Q/toh6zGNIk8tVU8qCuiWgmfTUgOplrrgL0oi
         +JHu370LLvws1grgftuLBzms79B1qCRcQYLHIdv6IMnqDWa5CSKkX3edNhOd4MiSRdTW
         oi0K35cMDJERlR2S3cIeHs5KrdyB/3zK0HigHuQxMtlduDIx9Sw4zPCSnvorL6tp7U6R
         U3mZ3mWYgl2TlKMMYrX7PmC7UQ4SLb++5l5kcyU6DuuZuLspW/mmrN8j0QBvSbv5Mu9E
         lHT+WxJf9w7eMMQE4cTxBrsVoCp3AfXKUn37iLpbtbGslhM19R7SoEMuou4LKJuT4uK8
         GXZQ==
X-Gm-Message-State: ACgBeo17JMEbFjjtsbYtSxWJuH56Cmu9aBefKuHRJeU/fDsODIoRiK5U
        CRk2yX08O5Xdapt3ClQrCxUqX9zYpJjMItkwb6290a95xHiYRR79jHaEvWrK2WWtvOEXobFJN1t
        soekD0RIcrEdqt+6gkDcgrA==
X-Received: by 2002:a17:907:75c1:b0:72f:248d:5259 with SMTP id jl1-20020a17090775c100b0072f248d5259mr13677749ejc.227.1661773301001;
        Mon, 29 Aug 2022 04:41:41 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4EiH7klPrajd4w6phluOAxxP5+QSPfK7S4vRyR/vwmU8/fqFSjch/glWZJuzPXXquQHg2DRA==
X-Received: by 2002:a17:907:75c1:b0:72f:248d:5259 with SMTP id jl1-20020a17090775c100b0072f248d5259mr13677719ejc.227.1661773300758;
        Mon, 29 Aug 2022 04:41:40 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id og4-20020a1709071dc400b0073ddfe1ea69sm4355852ejc.111.2022.08.29.04.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 04:41:40 -0700 (PDT)
Message-ID: <cbbaee7f-8ac3-0a37-9c71-3667e832a6ec@redhat.com>
Date:   Mon, 29 Aug 2022 13:41:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 17/31] ACPI: video: Add Nvidia WMI EC brightness
 control detection (v3)
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
        David Airlie <airlied@redhat.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20220825143726.269890-1-hdegoede@redhat.com>
 <20220825143726.269890-18-hdegoede@redhat.com>
 <a4d786a2-f2a2-fec7-df9d-18418c583301@nvidia.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <a4d786a2-f2a2-fec7-df9d-18418c583301@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 8/26/22 00:21, Daniel Dadap wrote:
> On 8/25/22 9:37 AM, Hans de Goede wrote:
>> On some new laptop designs a new Nvidia specific WMI interface is present
>> which gives info about panel brightness control and may allow controlling
>> the brightness through this interface when the embedded controller is used
>> for brightness control.
>>
>> When this WMI interface is present and indicates that the EC is used,
>> then this interface should be used for brightness control.
>>
>> Changes in v2:
>> - Use the new shared nvidia-wmi-ec-backlight.h header for the
>>    WMI firmware API definitions
>> - ACPI_VIDEO can now be enabled on non X86 too,
>>    adjust the Kconfig changes to match this.
>>
>> Changes in v3:
>> - Use WMI_BRIGHTNESS_GUID define
>>
>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/acpi/Kconfig           |  1 +
>>   drivers/acpi/video_detect.c    | 37 ++++++++++++++++++++++++++++++++++
>>   drivers/gpu/drm/gma500/Kconfig |  2 ++
>>   drivers/gpu/drm/i915/Kconfig   |  2 ++
>>   include/acpi/video.h           |  1 +
>>   5 files changed, 43 insertions(+)
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index 7802d8846a8d..44ad4b6bd234 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -212,6 +212,7 @@ config ACPI_VIDEO
>>       tristate "Video"
>>       depends on BACKLIGHT_CLASS_DEVICE
>>       depends on INPUT
>> +    depends on ACPI_WMI || !X86
>>       select THERMAL
>>       help
>>         This driver implements the ACPI Extensions For Display Adapters
>> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
>> index cc9d0d91e268..4dc7fb865083 100644
>> --- a/drivers/acpi/video_detect.c
>> +++ b/drivers/acpi/video_detect.c
>> @@ -32,6 +32,7 @@
>>   #include <linux/dmi.h>
>>   #include <linux/module.h>
>>   #include <linux/pci.h>
>> +#include <linux/platform_data/x86/nvidia-wmi-ec-backlight.h>
>>   #include <linux/types.h>
>>   #include <linux/workqueue.h>
>>   #include <acpi/video.h>
>> @@ -75,6 +76,36 @@ find_video(acpi_handle handle, u32 lvl, void *context, void **rv)
>>       return AE_OK;
>>   }
>>   +/* This depends on ACPI_WMI which is X86 only */
>> +#ifdef CONFIG_X86
> 
> 
> This could probably also provide the { return false; } stub which you have for non-x86 if the kernel is built without nvidia-wmi-ec-backight, e.g.:
> 
> #if defined(CONFIG_X86) && (defined(CONFIG_NVIDIA_WMI_EC_BACKLIGHT) || defined(CONFIG_NVIDIA_WMI_EC_BACKLIGHT_MODULE))
> 
> Although I suppose that would break things if somebody has a kernel that originally had NVIDIA_WMI_EC_BACKLIGHT=n in Kconfig, and then builds the nvidia-wmi-ec-backlight driver out-of-tree later. I don't know whether that's intended to be a supported use case, so I guess it is fine either way.

The video-detect code is about detecting what interface should be used.
So far it does this independently of the driver implementing that interface
actually being enabled or not.

If someone has a system which needs the nvidia-wmi-ec-backlight driver,
but it is disabled then they / their distro should enable that driver,
rather then trying to fallback on e.g. acpi_video.

Taking which drivers are enabled into account would both make
the code more complicated and would also explode the test matrix.

All of this is already somewhat fragile, so lets not make it
extra complicated :)

Regards,

Hans



> 
> 
>> +static bool nvidia_wmi_ec_supported(void)
>> +{
>> +    struct wmi_brightness_args args = {
>> +        .mode = WMI_BRIGHTNESS_MODE_GET,
>> +        .val = 0,
>> +        .ret = 0,
>> +    };
>> +    struct acpi_buffer buf = { (acpi_size)sizeof(args), &args };
>> +    acpi_status status;
>> +
>> +    status = wmi_evaluate_method(WMI_BRIGHTNESS_GUID, 0,
>> +                     WMI_BRIGHTNESS_METHOD_SOURCE, &buf, &buf);
>> +    if (ACPI_FAILURE(status))
>> +        return false;
>> +
>> +    /*
>> +     * If brightness is handled by the EC then nvidia-wmi-ec-backlight
>> +     * should be used, else the GPU driver(s) should be used.
>> +     */
>> +    return args.ret == WMI_BRIGHTNESS_SOURCE_EC;
>> +}
>> +#else
>> +static bool nvidia_wmi_ec_supported(void)
>> +{
>> +    return false;
>> +}
>> +#endif
>> +
>>   /* Force to use vendor driver when the ACPI device is known to be
>>    * buggy */
>>   static int video_detect_force_vendor(const struct dmi_system_id *d)
>> @@ -541,6 +572,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>>   static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
>>   {
>>       static DEFINE_MUTEX(init_mutex);
>> +    static bool nvidia_wmi_ec_present;
>>       static bool native_available;
>>       static bool init_done;
>>       static long video_caps;
>> @@ -553,6 +585,7 @@ static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
>>           acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
>>                       ACPI_UINT32_MAX, find_video, NULL,
>>                       &video_caps, NULL);
>> +        nvidia_wmi_ec_present = nvidia_wmi_ec_supported();
>>           init_done = true;
>>       }
>>       if (native)
>> @@ -570,6 +603,10 @@ static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
>>       if (acpi_backlight_dmi != acpi_backlight_undef)
>>           return acpi_backlight_dmi;
>>   +    /* Special cases such as nvidia_wmi_ec and apple gmux. */
>> +    if (nvidia_wmi_ec_present)
>> +        return acpi_backlight_nvidia_wmi_ec;
>> +
>>       /* On systems with ACPI video use either native or ACPI video. */
>>       if (video_caps & ACPI_VIDEO_BACKLIGHT) {
>>           /*
>> diff --git a/drivers/gpu/drm/gma500/Kconfig b/drivers/gpu/drm/gma500/Kconfig
>> index 0cff20265f97..807b989e3c77 100644
>> --- a/drivers/gpu/drm/gma500/Kconfig
>> +++ b/drivers/gpu/drm/gma500/Kconfig
>> @@ -7,6 +7,8 @@ config DRM_GMA500
>>       select ACPI_VIDEO if ACPI
>>       select BACKLIGHT_CLASS_DEVICE if ACPI
>>       select INPUT if ACPI
>> +    select X86_PLATFORM_DEVICES if ACPI
>> +    select ACPI_WMI if ACPI
>>       help
>>         Say yes for an experimental 2D KMS framebuffer driver for the
>>         Intel GMA500 (Poulsbo), Intel GMA600 (Moorestown/Oak Trail) and
>> diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
>> index 7ae3b7d67fcf..3efce05d7b57 100644
>> --- a/drivers/gpu/drm/i915/Kconfig
>> +++ b/drivers/gpu/drm/i915/Kconfig
>> @@ -23,6 +23,8 @@ config DRM_I915
>>       # but for select to work, need to select ACPI_VIDEO's dependencies, ick
>>       select BACKLIGHT_CLASS_DEVICE if ACPI
>>       select INPUT if ACPI
>> +    select X86_PLATFORM_DEVICES if ACPI
>> +    select ACPI_WMI if ACPI
>>       select ACPI_VIDEO if ACPI
>>       select ACPI_BUTTON if ACPI
>>       select SYNC_FILE
>> diff --git a/include/acpi/video.h b/include/acpi/video.h
>> index 0625806d3bbd..91578e77ac4e 100644
>> --- a/include/acpi/video.h
>> +++ b/include/acpi/video.h
>> @@ -48,6 +48,7 @@ enum acpi_backlight_type {
>>       acpi_backlight_video,
>>       acpi_backlight_vendor,
>>       acpi_backlight_native,
>> +    acpi_backlight_nvidia_wmi_ec,
>>   };
>>     #if IS_ENABLED(CONFIG_ACPI_VIDEO)
> 

