Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7360C52C162
	for <lists+linux-acpi@lfdr.de>; Wed, 18 May 2022 19:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241036AbiERRkI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 May 2022 13:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241058AbiERRkH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 May 2022 13:40:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3ED98216067
        for <linux-acpi@vger.kernel.org>; Wed, 18 May 2022 10:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652895597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gDGt/Rg9AZsxvRBAhR5KeMESGNTYZAfpSxQWVhbVFk4=;
        b=aHVEiwnWBk0+bNDlKvdW7YJL8Bd5u/UpHJTC2PfM55nP+om+NkEm0VXGBuZNeK82X3rl4J
        Ew7sDpjXOoLfcc1oLhXwJ35SWlMepEk+k5JiJtlxWBT1FFIgftvQoE3VIiTCuemUn0i6Pd
        Uy+QcSCH/pJfN66S78Rl3JqSYjGJhc0=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-ejfMjaHeP0SLDTre_LNkDg-1; Wed, 18 May 2022 13:39:56 -0400
X-MC-Unique: ejfMjaHeP0SLDTre_LNkDg-1
Received: by mail-vs1-f69.google.com with SMTP id f18-20020a67ee12000000b00331c758ea7fso314199vsp.19
        for <linux-acpi@vger.kernel.org>; Wed, 18 May 2022 10:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=gDGt/Rg9AZsxvRBAhR5KeMESGNTYZAfpSxQWVhbVFk4=;
        b=0Q+5vDqi8IIK06nwRn7ZviL6ZcAe+2CNMvbv0z4TSlfDAk4ym9PL7/VwVIBnkBOHML
         /EFJc7LRCseyssN6QS2VGrFHJi55lG8HP6FCHk8oglc/ZsryfGed98pghW50GV/tJzKY
         M1Nmasrg37Au4RNOq2QLyqKDhf2mj0TkLOr8qUDE9EXaM6bkdYfsU2ACcNBqJ8dEdn4u
         GwMbPYlaq0H4TB6F7Hjqbc464outsTHqZA5Dja3nqPH22c9KE7GX8MWzADnXttXunNO8
         dLt3x1h2Hp0yxIaOdeCuI2o6qLiS/ClTEuwuzCNhd/Vqbx3iZBadngPfuY6nGIRG5SZn
         hEgQ==
X-Gm-Message-State: AOAM530iYHt4YdI58WXcGomq3kQN5AcUgPuXfVaYcvTBlVWcbHwmlqle
        5ogOhaU+ZhdVmmIaF6bJaqIimz++7ZJNqHvuMYzcVLPIKOFV8EeMskn+VEfdLt+JvSN24pKJ2m4
        RYdeHbo/3Zh14IlTS85AU/Q==
X-Received: by 2002:a05:6102:3706:b0:335:80be:bdf8 with SMTP id s6-20020a056102370600b0033580bebdf8mr527602vst.17.1652895595665;
        Wed, 18 May 2022 10:39:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+wcU/dWMJlXfe/1930TJzCPdcc6Su+ICGYsTy4q9ZBSUQnSN+lF31nL1TGBauw8+rrCkI6g==
X-Received: by 2002:a05:6102:3706:b0:335:80be:bdf8 with SMTP id s6-20020a056102370600b0033580bebdf8mr527593vst.17.1652895595399;
        Wed, 18 May 2022 10:39:55 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net. [71.184.137.158])
        by smtp.gmail.com with ESMTPSA id 143-20020a1f1995000000b0034e6f1fd055sm246132vkz.31.2022.05.18.10.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 10:39:54 -0700 (PDT)
Message-ID: <0c9c2c59ca9c351769921c47beb49dda79ddd5de.camel@redhat.com>
Subject: Re: [PATCH 12/14] drm/nouveau: Register ACPI video backlight when
 nv_backlight registration fails
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
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, Xinhui <Xinhui.Pan@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     nouveau@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Date:   Wed, 18 May 2022 13:39:52 -0400
In-Reply-To: <20220517152331.16217-13-hdegoede@redhat.com>
References: <20220517152331.16217-1-hdegoede@redhat.com>
         <20220517152331.16217-13-hdegoede@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 2022-05-17 at 17:23 +0200, Hans de Goede wrote:
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
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_backlight.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c
> b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> index f56ff797c78c..0ae8793357a4 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> @@ -436,6 +436,13 @@ nouveau_backlight_init(struct drm_connector *connector)
>  
>  fail_alloc:
>         kfree(bl);
> +       /*
> +        * If we get here we have an internal panel, but no nv_backlight,
> +        * try registering an ACPI video backlight device instead.
> +        */
> +       if (ret == 0)
> +               acpi_video_register_backlight();

Assuming we don't need to return the value of acpi_video_register_backlight()
here:

Reviewed-by: Lyude Paul <lyude@redhat.com>

> +
>         return ret;
>  }
>  

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

