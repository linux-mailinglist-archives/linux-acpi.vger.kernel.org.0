Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1855A0120
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Aug 2022 20:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbiHXSLl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Aug 2022 14:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240427AbiHXSLi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Aug 2022 14:11:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B186C5FF67
        for <linux-acpi@vger.kernel.org>; Wed, 24 Aug 2022 11:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661364694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Iz5hZYykHc8fiPWbr2FurkIYzVNEHVdT24iSBVPjAY=;
        b=XABvJYUXno3EU1di2KoGTBfkXgR2QrNTBWghp5Xj3LGEITn5TPQGVdxOAD1x24os+oPMQ6
        tJop/OvsdYJgWEjOcycylZJgUgjI9Edf2sz85GRq6hp5LtiRs3vAP0rlC5bexpZRwXMZi2
        haC63/fXxQwPtCSm0ArYxczlsbmc3qI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-660-e901zweGOZ67DgToPiyv1Q-1; Wed, 24 Aug 2022 14:11:33 -0400
X-MC-Unique: e901zweGOZ67DgToPiyv1Q-1
Received: by mail-qt1-f200.google.com with SMTP id h13-20020ac87d4d000000b00342f6c363afso13362723qtb.9
        for <linux-acpi@vger.kernel.org>; Wed, 24 Aug 2022 11:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc;
        bh=7Iz5hZYykHc8fiPWbr2FurkIYzVNEHVdT24iSBVPjAY=;
        b=0U2/CkRTq7xulkKQIL2AJmfl1Bdl5WoDZ8NYOAnrflNjFLRLkO9yCYESTGTL7BLrKf
         3CMKgxAG/JsHEz/Sv4dWJFVVIE3CH9uSqeBhDtPvkxQO1TvIVdf8Zy40clsyq4VbkKmN
         ufypMEBYgvq7a6NoNJAcVET3pfjXIl2kAheOD1W5SwA839RCiG8jT/hTH/oa+kBvZNf1
         WoNdoHJkyGdRwMzxoSmGR2BO5Xkx0feaMunZw1gFFioPQ/8yH0vcOIQbIOZaY21eH2o4
         Muqi32Y/nZiQq+7HX5dNIuKgSzd3EYa3ayUoF7i+NI83UhsW6x5ViekGOgawsdzZcmQ8
         337A==
X-Gm-Message-State: ACgBeo1QQ60hdIXpx8wshxsCL/CrVbqzM6J8A9Dt8Y9rpdzH6njxQ61v
        x3qO1OOfIK21AxGZY8h1y2PalpvEqJ7Tug3eD6pjYPhSzfuHhgaSxUzv2HrQzKav1HpIvl8Azq1
        kKFpEMroDWcmND/rU+f1byg==
X-Received: by 2002:a0c:e34d:0:b0:496:d21e:da0f with SMTP id a13-20020a0ce34d000000b00496d21eda0fmr356249qvm.104.1661364692972;
        Wed, 24 Aug 2022 11:11:32 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5yZfLMMwova0GLIKlzkippPXyfVI1iypDQik96PZEELSzHNsWUSq6kjGN73O12uk25lSgHzw==
X-Received: by 2002:a0c:e34d:0:b0:496:d21e:da0f with SMTP id a13-20020a0ce34d000000b00496d21eda0fmr356221qvm.104.1661364692747;
        Wed, 24 Aug 2022 11:11:32 -0700 (PDT)
Received: from [192.168.8.139] (pool-100-0-245-4.bstnma.fios.verizon.net. [100.0.245.4])
        by smtp.gmail.com with ESMTPSA id p11-20020ac8740b000000b00342fcdc2d46sm12833255qtq.56.2022.08.24.11.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 11:11:31 -0700 (PDT)
Message-ID: <ad03096816395dbfd8113fca51b4ff374f36255f.camel@redhat.com>
Subject: Re: [PATCH v4 12/31] drm/nouveau: Register ACPI video backlight
 when nv_backlight registration fails (v2)
From:   Lyude Paul <lyude@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
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
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
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
Date:   Wed, 24 Aug 2022 14:11:30 -0400
In-Reply-To: <20220824121523.1291269-13-hdegoede@redhat.com>
References: <20220824121523.1291269-1-hdegoede@redhat.com>
         <20220824121523.1291269-13-hdegoede@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Wed, 2022-08-24 at 14:15 +0200, Hans de Goede wrote:
> Typically the acpi_video driver will initialize before nouveau, which
> used to cause /sys/class/backlight/acpi_video0 to get registered and then
> nouveau would register its own nv_backlight device later. After which
> the drivers/acpi/video_detect.c code unregistered the acpi_video0 device
> to avoid there being 2 backlight devices.
> 
> This means that userspace used to briefly see 2 devices and the
> disappearing of acpi_video0 after a brief time confuses the systemd
> backlight level save/restore code, see e.g.:
> https://bbs.archlinux.org/viewtopic.php?id=269920
> 
> To fix this the ACPI video code has been modified to make backlight class
> device registration a separate step, relying on the drm/kms driver to
> ask for the acpi_video backlight registration after it is done setting up
> its native backlight device.
> 
> Add a call to the new acpi_video_register_backlight() when native backlight
> device registration has failed / was skipped to ensure that there is a
> backlight device available before the drm_device gets registered with
> userspace.
> 
> Changes in v2:
> - Add nouveau_acpi_video_register_backlight() wrapper to avoid unresolved
>   symbol errors on non X86
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_acpi.c      | 5 +++++
>  drivers/gpu/drm/nouveau/nouveau_acpi.h      | 2 ++
>  drivers/gpu/drm/nouveau/nouveau_backlight.c | 7 +++++++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
> index 1592c9cd7750..8cf096f841a9 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
> @@ -391,3 +391,8 @@ bool nouveau_acpi_video_backlight_use_native(void)
>  {
>  	return acpi_video_backlight_use_native();
>  }
> +
> +void nouveau_acpi_video_register_backlight(void)
> +{
> +	acpi_video_register_backlight();
> +}
> diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.h b/drivers/gpu/drm/nouveau/nouveau_acpi.h
> index 3c666c30dfca..e39dd8b94b8b 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_acpi.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_acpi.h
> @@ -12,6 +12,7 @@ void nouveau_unregister_dsm_handler(void);
>  void nouveau_switcheroo_optimus_dsm(void);
>  void *nouveau_acpi_edid(struct drm_device *, struct drm_connector *);
>  bool nouveau_acpi_video_backlight_use_native(void);
> +void nouveau_acpi_video_register_backlight(void);
>  #else
>  static inline bool nouveau_is_optimus(void) { return false; };
>  static inline bool nouveau_is_v1_dsm(void) { return false; };
> @@ -20,6 +21,7 @@ static inline void nouveau_unregister_dsm_handler(void) {}
>  static inline void nouveau_switcheroo_optimus_dsm(void) {}
>  static inline void *nouveau_acpi_edid(struct drm_device *dev, struct drm_connector *connector) { return NULL; }
>  static inline bool nouveau_acpi_video_backlight_use_native(void) { return true; }
> +static inline void nouveau_acpi_video_register_backlight(void) {}
>  #endif
>  
>  #endif
> diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> index d2b8f8c13db4..a614582779ca 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> @@ -436,6 +436,13 @@ nouveau_backlight_init(struct drm_connector *connector)
>  
>  fail_alloc:
>  	kfree(bl);
> +	/*
> +	 * If we get here we have an internal panel, but no nv_backlight,
> +	 * try registering an ACPI video backlight device instead.
> +	 */
> +	if (ret == 0)
> +		nouveau_acpi_video_register_backlight();
> +
>  	return ret;
>  }
>  

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

