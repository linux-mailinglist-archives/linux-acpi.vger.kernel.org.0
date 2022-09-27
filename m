Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8CC5EC08A
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Sep 2022 13:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiI0LHA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Sep 2022 07:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiI0LGK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Sep 2022 07:06:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CADD28E2B
        for <linux-acpi@vger.kernel.org>; Tue, 27 Sep 2022 04:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664276698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l/JllRVsLXk1mVK18+Kbna9TAwN4318CnjejoNa5Zl0=;
        b=gZAjk6H8gWJECoBIIhNiwqXc5KCVo90F51v+Rw5bgK7hfqSDrULB+l3Y2XAPNwRVVYBaj3
        01+oivgd7dHOkn1sc8xQGb+cZbb2eIiRxV0S8HxJDQufNkegA3/uV8ByzRjHGk114AWHdd
        ur8VagvaLIrkUA/It12FuQqgYIhScUI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-380-R4YkMKJ8PmOSziMafZUBiQ-1; Tue, 27 Sep 2022 07:04:56 -0400
X-MC-Unique: R4YkMKJ8PmOSziMafZUBiQ-1
Received: by mail-ed1-f72.google.com with SMTP id m3-20020a056402430300b004512f6268dbso7605448edc.23
        for <linux-acpi@vger.kernel.org>; Tue, 27 Sep 2022 04:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=l/JllRVsLXk1mVK18+Kbna9TAwN4318CnjejoNa5Zl0=;
        b=i1AzvZAmXCm5qs4lWW6fvNrGgegQnO3FMzy8Movv7ZPnxBb75EAKwsQehdvmRI55NF
         Y0DaW8gI/JTK8vIc+GMWyo5kY21H12hJ2oWOEPMPzvZbcaaPjutUzYtsIDWUfAmvmRfI
         phoGRR8ot93eS3TazvG85v6pQwHFphXxzOOtlm6S+Vvyh4t8FOGOrABMbaVQBnhIkPnz
         iEakb2QOxMBnpenZmDqRPe1UYzPEowp+tnz/8AqiSjVTXm3MIzCep/69tXtG4bE+s8gU
         mWSNXyw387sa7QcUWCx3iE9Z2CcPQHhiHJOB3QVFvEMD0OZ7WYHj6aAokoCwQePA9I8z
         sKzw==
X-Gm-Message-State: ACrzQf0LcaG7+81hus4bpiF9tv+u6iIVPR/Libgsfr+//L5y9TZm2ZtI
        M29/yqILEt6/IQRGwPox5D7hDfsJlWJTPZEUQQnq4lyW896U7j0gYQiInigknrBHTxkWjOW377X
        E6kikteTXUVQQcBU4vgm7rw==
X-Received: by 2002:a17:906:eecb:b0:73c:5bcb:8eb3 with SMTP id wu11-20020a170906eecb00b0073c5bcb8eb3mr22169264ejb.284.1664276695558;
        Tue, 27 Sep 2022 04:04:55 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7D5QZjU/upOCee7GoUO2AdF8ylwZyk3AjCM/1ND7XlQnca3IxNEAVjdAeeHSEga9s+yI8OrQ==
X-Received: by 2002:a17:906:eecb:b0:73c:5bcb:8eb3 with SMTP id wu11-20020a170906eecb00b0073c5bcb8eb3mr22169235ejb.284.1664276695270;
        Tue, 27 Sep 2022 04:04:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id a3-20020a50e703000000b0044657ecfbb5sm1058230edn.13.2022.09.27.04.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 04:04:54 -0700 (PDT)
Message-ID: <42a5f2c9-a1dc-8fc0-7334-fe6c390ecfbb@redhat.com>
Date:   Tue, 27 Sep 2022 13:04:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v5 02/31] drm/i915: Don't register backlight when another
 backlight should be used (v2)
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>, Lyude <lyude@redhat.com>,
        Daniel Dadap <ddadap@nvidia.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Pan@freedesktop.org, Xinhui <Xinhui.Pan@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-acpi@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>,
        nouveau@lists.freedesktop.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        David Airlie <airlied@redhat.com>, Len Brown <lenb@kernel.org>
References: <20220825143726.269890-1-hdegoede@redhat.com>
 <20220825143726.269890-3-hdegoede@redhat.com>
 <f914ceb3-94bd-743c-f8b6-0334086e731a@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <f914ceb3-94bd-743c-f8b6-0334086e731a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Dmitry,

On 9/26/22 01:39, Dmitry Osipenko wrote:
> 25.08.2022 17:36, Hans de Goede пишет:
>> Before this commit when we want userspace to use the acpi_video backlight
>> device we register both the GPU's native backlight device and acpi_video's
>> firmware acpi_video# backlight device. This relies on userspace preferring
>> firmware type backlight devices over native ones.
>>
>> Registering 2 backlight devices for a single display really is
>> undesirable, don't register the GPU's native backlight device when
>> another backlight device should be used.
>>
>> Changes in v2:
>> - Use drm_info(drm_dev,  ...) for log messages
>>
>> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/gpu/drm/i915/display/intel_backlight.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/gpu/drm/i915/display/intel_backlight.c
>> index 681ebcda97ad..03c7966f68d6 100644
>> --- a/drivers/gpu/drm/i915/display/intel_backlight.c
>> +++ b/drivers/gpu/drm/i915/display/intel_backlight.c
>> @@ -8,6 +8,8 @@
>>  #include <linux/pwm.h>
>>  #include <linux/string_helpers.h>
>>  
>> +#include <acpi/video.h>
>> +
>>  #include "intel_backlight.h"
>>  #include "intel_backlight_regs.h"
>>  #include "intel_connector.h"
>> @@ -952,6 +954,11 @@ int intel_backlight_device_register(struct intel_connector *connector)
>>  
>>  	WARN_ON(panel->backlight.max == 0);
>>  
>> +	if (!acpi_video_backlight_use_native()) {
>> +		drm_info(&i915->drm, "Skipping intel_backlight registration\n");
>> +		return 0;
>> +	}
>> +
>>  	memset(&props, 0, sizeof(props));
>>  	props.type = BACKLIGHT_RAW;
>>  
> 
> This breaks backlight on Acer Chromebook Spin 713 because backlight
> isn't registered anymore. Any ideas how to fix it?

Thank you for reporting this.

Let me start with some background info on this change:

As you may have noticed sometimes on laptops there are multiple
backlights registered under /sys/class/backlight and we just let
userspace figure out which one to use, which is quite bad.

This patch is part of a series fixing this, this is also preparation
for adding a new display brightness control API where the brightness is
a property on the drm_connector object for the panel/display, which
of course requires the kernel to know which backlight control method
to use.

If you are want to know more about the new userspace API see:
https://lore.kernel.org/dri-devel/b61d3eeb-6213-afac-2e70-7b9791c86d2e@redhat.com/

What this series does is on x86/ACPI platforms make all the possible
/sys/class/backlight providers call: acpi_video_get_backlight_type()
(acpi_video_backlight_use_native() is a special wrapper) and only if
that returns their type then have them register their backlight device.

So to fix this we need to make acpi_video_get_backlight_type()
return native on the Acer Chromebook Spin 713.

The heuristics used in acpi_video_get_backlight_type() is
explained by comments in the function:

        /*
         * The below heuristics / detection steps are in order of descending
         * presedence. The commandline takes presedence over anything else.
         */
        /* DMI quirks override any autodetection. */
        /* Special cases such as nvidia_wmi_ec and apple gmux. */

None of these apply here, so we end up in the core of this function:

        /* On systems with ACPI video use either native or ACPI video. */
        if (video_caps & ACPI_VIDEO_BACKLIGHT) {
                /*
                 * Windows 8 and newer no longer use the ACPI video interface,
                 * so it often does not work. If the ACPI tables are written
                 * for win8 and native brightness ctl is available, use that.
                 *
                 * The native check deliberately is inside the if acpi-video
                 * block on older devices without acpi-video support native
                 * is usually not the best choice.
                 */
                if (acpi_osi_is_win8() && native_available)
                        return acpi_backlight_native;
                else
                        return acpi_backlight_video;
        }

        /* No ACPI video (old hw), use vendor specific fw methods. */
        return acpi_backlight_vendor;


The acpi_video_backlight_use_native() wrappers causes native_available to
be true, so one or both of these 2 conditions fail:

1.      if (video_caps & ACPI_VIDEO_BACKLIGHT)
2.	if (acpi_osi_is_win8())

I assume that 2. will actually likely fail on quite a few chromebooks.
So to fix this you could do something like this:

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 0d9064a9804c..660ea46fbee8 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -75,6 +75,12 @@ find_video(acpi_handle handle, u32 lvl, void *context, void **rv)
 	return AE_OK;
 }
 
+static bool is_chromebook(void)
+{
+	// FIXME return true when running under ChromeOS (coreboot) firmware
+	return false;
+}
+
 /* This depends on ACPI_WMI which is X86 only */
 #ifdef CONFIG_X86
 static bool nvidia_wmi_ec_supported(void)
@@ -724,7 +730,7 @@ static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
 		 * block on older devices without acpi-video support native
 		 * is usually not the best choice.
 		 */
-		if (acpi_osi_is_win8() && native_available)
+		if (native_available && (acpi_osi_is_win8() || is_chromebook()))
 			return acpi_backlight_native;
 		else
 			return acpi_backlight_video;

The ACPI video bus is a pretty standard thing (and part of the ACPI standard),
still I would not be surprised if it is missing from the ACPI tables on some
Chromebooks, so a slightly bigger hammer approach would be:

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 0d9064a9804c..ff950be472a7 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -75,6 +75,12 @@ find_video(acpi_handle handle, u32 lvl, void *context, void **rv)
 	return AE_OK;
 }
 
+static bool is_chromeos_firmware(void)
+{
+	// FIXME return true when running under ChromeOS (coreboot) firmware
+	return false;
+}
+
 /* This depends on ACPI_WMI which is X86 only */
 #ifdef CONFIG_X86
 static bool nvidia_wmi_ec_supported(void)
@@ -713,6 +719,10 @@ static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
 	if (apple_gmux_present())
 		return acpi_backlight_apple_gmux;
 
+	/* On Chromebooks always use native if available */
+	if (is_chromeos_firmware() && native_available)
+		return acpi_backlight_native;
+
 	/* On systems with ACPI video use either native or ACPI video. */
 	if (video_caps & ACPI_VIDEO_BACKLIGHT) {
 		/*

I assume you are more familiar with Chromebooks ACPI tables (or at least
are better capable to sample a couple of them) so I will leave which
approach to take is best up to you.

Regards,

Hans

