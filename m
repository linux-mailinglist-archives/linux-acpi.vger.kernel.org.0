Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCAE5A0BD4
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Aug 2022 10:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiHYItq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Aug 2022 04:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiHYIto (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Aug 2022 04:49:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5DDA7A9A
        for <linux-acpi@vger.kernel.org>; Thu, 25 Aug 2022 01:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661417382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TlIztJfK8onvTK3+DzJfXtAMpstrtjDNQoMGfdoz0qA=;
        b=aZz320PyIoYbOJHxg8Vpl+Xn3KsiCCQUrjW5eeJzgFTCOUHUCl/hmH2UP+cKSE5vwGERtY
        4mfQYhciOifopO4KinxmiC++CeEnBs8442ab8tpTm+4hKjvEMlLskXIrPjVO8woNgIdGse
        8jbIjfhrtYO38euTPMDfPJumaOcAqgI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-621-MsGNMXLXP3SC3piWFHjncg-1; Thu, 25 Aug 2022 04:49:41 -0400
X-MC-Unique: MsGNMXLXP3SC3piWFHjncg-1
Received: by mail-ej1-f70.google.com with SMTP id sd6-20020a1709076e0600b0073315809fb5so5979497ejc.10
        for <linux-acpi@vger.kernel.org>; Thu, 25 Aug 2022 01:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=TlIztJfK8onvTK3+DzJfXtAMpstrtjDNQoMGfdoz0qA=;
        b=RSz0+dgVZe1OL8Qgfp8r2aMYv7eiIhEGkSA3BxS9CGvCS84v/VKvMtVfxJFfoLYqRg
         wUn9SUDsdiB3KAG3GGHXiv4SUAk71+t8XUZeWcqWYZAJhS9H7ESESF+cYk8IkDk2XRdT
         F0nh9oil5MStcEDEo6aClAKk+/WGH2xWjdwHwxi3ng9hbqGmoxmSA9hEsLtz8pllgi0M
         G8Ov+DPEBeM009LomEtIU+lmDXxCdSEbjt5WBUOWU1ev/BR0JhiPbyk8i/PKenDCHgyE
         XVP1v7Gf5MqJQ8IXpgZjGyB3ZwJzBjH2Gh1c7iVuRiCJJnvoK56RAKI/EejaDjaG3yVk
         YUgg==
X-Gm-Message-State: ACgBeo0lKv4maZMUhKii4tPhBaWhIQM/itqWBhuqv0kl/V+IIurqf+Hw
        9wDGwFD20hYURz9Cr+9C3ArTc/AR/mCwLGLYA/vKK9FHp/o39tORU1Bc16Y7W1ZD62RS1MZLQMf
        mYcizGDAMuUbrjDc96PpJOg==
X-Received: by 2002:a17:906:7944:b0:73c:838:ac3d with SMTP id l4-20020a170906794400b0073c0838ac3dmr1745840ejo.242.1661417379118;
        Thu, 25 Aug 2022 01:49:39 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5pbEVKcPNS8XdGhBhlI4Qh4gdOtxX9xAZ7HZNA3Q7artXVLzIVe+5/2OuT2ACRv46l/UJlbA==
X-Received: by 2002:a17:906:7944:b0:73c:838:ac3d with SMTP id l4-20020a170906794400b0073c0838ac3dmr1745823ejo.242.1661417378882;
        Thu, 25 Aug 2022 01:49:38 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id x2-20020aa7d382000000b00446473adeacsm4407020edq.82.2022.08.25.01.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 01:49:38 -0700 (PDT)
Message-ID: <9f0a7d34-9d02-1775-0d04-d909c763ca7f@redhat.com>
Date:   Thu, 25 Aug 2022 10:49:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 05/31] drm/nouveau: Don't register backlight when
 another backlight should be used (v2)
Content-Language: en-US
To:     Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
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
        Pan Xinhui <Xinhui.Pan@amd.com>,
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
References: <20220824121523.1291269-1-hdegoede@redhat.com>
 <20220824121523.1291269-6-hdegoede@redhat.com>
 <1463d0d38e97e5664dbc0b67a7a5620bb198bcce.camel@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <1463d0d38e97e5664dbc0b67a7a5620bb198bcce.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Lyude,

Thank you for the review.

On 8/24/22 19:41, Lyude Paul wrote:
> Just one tiny nitpick below:
> 
> On Wed, 2022-08-24 at 14:14 +0200, Hans de Goede wrote:
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
>> - Add nouveau_acpi_video_backlight_use_native() wrapper to avoid unresolved
>>   symbol errors on non X86
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/gpu/drm/nouveau/nouveau_acpi.c      | 5 +++++
>>  drivers/gpu/drm/nouveau/nouveau_acpi.h      | 2 ++
>>  drivers/gpu/drm/nouveau/nouveau_backlight.c | 6 ++++++
>>  3 files changed, 13 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
>> index 6140db756d06..1592c9cd7750 100644
>> --- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
>> +++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
>> @@ -386,3 +386,8 @@ nouveau_acpi_edid(struct drm_device *dev, struct drm_connector *connector)
>>  
>>  	return kmemdup(edid, EDID_LENGTH, GFP_KERNEL);
>>  }
>> +
>> +bool nouveau_acpi_video_backlight_use_native(void)
>> +{
>> +	return acpi_video_backlight_use_native();
>> +}
>> diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.h b/drivers/gpu/drm/nouveau/nouveau_acpi.h
>> index 330f9b837066..3c666c30dfca 100644
>> --- a/drivers/gpu/drm/nouveau/nouveau_acpi.h
>> +++ b/drivers/gpu/drm/nouveau/nouveau_acpi.h
>> @@ -11,6 +11,7 @@ void nouveau_register_dsm_handler(void);
>>  void nouveau_unregister_dsm_handler(void);
>>  void nouveau_switcheroo_optimus_dsm(void);
>>  void *nouveau_acpi_edid(struct drm_device *, struct drm_connector *);
>> +bool nouveau_acpi_video_backlight_use_native(void);
>>  #else
>>  static inline bool nouveau_is_optimus(void) { return false; };
>>  static inline bool nouveau_is_v1_dsm(void) { return false; };
>> @@ -18,6 +19,7 @@ static inline void nouveau_register_dsm_handler(void) {}
>>  static inline void nouveau_unregister_dsm_handler(void) {}
>>  static inline void nouveau_switcheroo_optimus_dsm(void) {}
>>  static inline void *nouveau_acpi_edid(struct drm_device *dev, struct drm_connector *connector) { return NULL; }
>> +static inline bool nouveau_acpi_video_backlight_use_native(void) { return true; }
>>  #endif
>>  
>>  #endif
>> diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
>> index a2141d3d9b1d..d2b8f8c13db4 100644
>> --- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
>> +++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
>> @@ -38,6 +38,7 @@
>>  #include "nouveau_reg.h"
>>  #include "nouveau_encoder.h"
>>  #include "nouveau_connector.h"
>> +#include "nouveau_acpi.h"
>>  
>>  static struct ida bl_ida;
>>  #define BL_NAME_SIZE 15 // 12 for name + 2 for digits + 1 for '\0'
>> @@ -405,6 +406,11 @@ nouveau_backlight_init(struct drm_connector *connector)
>>  		goto fail_alloc;
>>  	}
>>  
>> +	if (!nouveau_acpi_video_backlight_use_native()) {
>> +		NV_INFO(drm, "Skipping nv_backlight registration\n");
>> +		goto fail_alloc;
>> +	}
> 
> We should probably make this say something like "No native backlight
> interface, using ACPI instead" instead. With that fixed

But that would not be correct. If we get to this point then before
the change we would continue with registering the native backlight
interface.

In other words, the native backlight interface is known to
be available at this point so saying "No native backlight interface"
would not be correct.

The reason the registration is being skipped is because the
drivers/acpi/video_detect.c heuristics (or DMI quirk or cmdline
override) say that another method to control the backlight is
preferred and we want to stop registering the native backlight
alltogether in that case so that there is only
1 /sys/class/backlight entry (on a 1 GPU 1 panel system).

Also "using ACPI instead" is not correct, on older systems
it might e.g. by a vendor specific control method such as
the one from dell-laptop. And on newer systems it might
e.g. be the new nvidia-wmi-ec-backlight driver instead.

So you could say the log message is a bit vague on purpose
because making it detailed would make it very long.

The idea behind the log message is to have something to
check for in dmesg if users start complaining about
/sys/class/backlight/nouveau_bl disappearing.

Normally users should not notice this, because indeed typically
they will then also have an /sys/class/backlight/acpi_video0
which is already preferred over the native one by userspace,
so nothing should change for them.  But they could e.g.
have scripts pointing directly at the native one, or
some other special case.

In those special cases having the log message to tell us why
/sys/class/backlight/nv_backlight disappeared will help
greatly with debugging.

After writing all this I have not been able to come up
with a better log message then the one from the original
patch, so my proposal here is to just keep the log message
as is. Is that ok?

Regards,

Hans




> 
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> 
>> +
>>  	if (!nouveau_get_backlight_name(backlight_name, bl)) {
>>  		NV_ERROR(drm, "Failed to retrieve a unique name for the backlight interface\n");
>>  		goto fail_alloc;
> 

