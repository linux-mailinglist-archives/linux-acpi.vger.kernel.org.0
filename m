Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3500B5E96F0
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Sep 2022 01:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbiIYXj5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 25 Sep 2022 19:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiIYXj4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 25 Sep 2022 19:39:56 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364FD12616;
        Sun, 25 Sep 2022 16:39:54 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 10so8349776lfy.5;
        Sun, 25 Sep 2022 16:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=st3O2pRGPWK1FLJTPBGRuCniY8P/u6abQYJb/fEYuJQ=;
        b=W3K2NP/a6+oTI8gFEGt5nGGS9enU+0KpjF9MSWpto/y/e8Pqkyk3KdNROeq1VReuw3
         4tbDUQNzhEsLSU0JCkjVpzqYzoF9pZhg9SvgEiWunM5yC5N0DLguvjWHMxFYGtncW+mc
         vOragtuGv5wtfYTpeKmAEjfsXd4V6tTTTzaNGi8+qtE32bmF4JD4wQ6frMIJoh9GGTge
         RAD/AaBmrSAOC5LqiVErhUkwhGjVz5+qH/Z27UJUyGp+GEOEmwJRfc1RTbiWoQbzjL5M
         mtmY0fn16PQvkz4jleVY/+noMI6YznIJxGIP6waxvJ+sh1wleUqUblTSTP3nNWAH+jkr
         pZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=st3O2pRGPWK1FLJTPBGRuCniY8P/u6abQYJb/fEYuJQ=;
        b=AsP+f8IT85QBbafwbsPWRMd9P/WUw0RjFJYhCQe32abKwsU+vkLttHabZaMLwzTDy6
         1ZjAi0v0u91x8GQTwFzmemjy8gFOOa9Zf6dMFM9SNI7QjAN/UrkRKlkTwKi9LrBKNa4w
         aQcL8RJ3UqnzgHmz2m7YwwJNCHvBDIVSU3+4oH4gj+cNvZQ0JBOH+HlAlxRPzW+yd54R
         cEYz/7zUcz6fsWrbz0RAEPNWvqFYoR0lV0ClnDBF0+uViOUwbLMWWoDiMGVXVt+lt4rw
         ih5A4pFsqVHngO/i7/CrM8t12pgFgolgB6sGCOkB7oIzxLdXJPMhvibEIRDElwf81w3d
         +lwQ==
X-Gm-Message-State: ACrzQf35T3/yVvtE+1LZyKK8CbInZm5zHVGGr7DsU70Tws1Hfm2J422g
        /T2sP9zLw4tBpuLiTwP5TZI=
X-Google-Smtp-Source: AMsMyM5aDKQS2b/KY3xFf9M+RoiDx1qfHHYGi1ptQgxDMi9xIzklVjEJFzIiBqGLPRgxtbvB3OmxiQ==
X-Received: by 2002:a05:6512:2215:b0:49e:ac45:22e1 with SMTP id h21-20020a056512221500b0049eac4522e1mr8247070lfu.33.1664149192424;
        Sun, 25 Sep 2022 16:39:52 -0700 (PDT)
Received: from [192.168.2.145] (109-252-124-206.nat.spd-mgts.ru. [109.252.124.206])
        by smtp.googlemail.com with ESMTPSA id i11-20020ac2522b000000b0048a921664e8sm2351312lfl.37.2022.09.25.16.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 16:39:51 -0700 (PDT)
Message-ID: <f914ceb3-94bd-743c-f8b6-0334086e731a@gmail.com>
Date:   Mon, 26 Sep 2022 02:39:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v5 02/31] drm/i915: Don't register backlight when another
 backlight should be used (v2)
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
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
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220825143726.269890-3-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

25.08.2022 17:36, Hans de Goede пишет:
> Before this commit when we want userspace to use the acpi_video backlight
> device we register both the GPU's native backlight device and acpi_video's
> firmware acpi_video# backlight device. This relies on userspace preferring
> firmware type backlight devices over native ones.
> 
> Registering 2 backlight devices for a single display really is
> undesirable, don't register the GPU's native backlight device when
> another backlight device should be used.
> 
> Changes in v2:
> - Use drm_info(drm_dev,  ...) for log messages
> 
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/gpu/drm/i915/display/intel_backlight.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/gpu/drm/i915/display/intel_backlight.c
> index 681ebcda97ad..03c7966f68d6 100644
> --- a/drivers/gpu/drm/i915/display/intel_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_backlight.c
> @@ -8,6 +8,8 @@
>  #include <linux/pwm.h>
>  #include <linux/string_helpers.h>
>  
> +#include <acpi/video.h>
> +
>  #include "intel_backlight.h"
>  #include "intel_backlight_regs.h"
>  #include "intel_connector.h"
> @@ -952,6 +954,11 @@ int intel_backlight_device_register(struct intel_connector *connector)
>  
>  	WARN_ON(panel->backlight.max == 0);
>  
> +	if (!acpi_video_backlight_use_native()) {
> +		drm_info(&i915->drm, "Skipping intel_backlight registration\n");
> +		return 0;
> +	}
> +
>  	memset(&props, 0, sizeof(props));
>  	props.type = BACKLIGHT_RAW;
>  

This breaks backlight on Acer Chromebook Spin 713 because backlight
isn't registered anymore. Any ideas how to fix it?
