Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D749052B754
	for <lists+linux-acpi@lfdr.de>; Wed, 18 May 2022 12:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbiERKGo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 May 2022 06:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234941AbiERKGm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 May 2022 06:06:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADD45134E3C
        for <linux-acpi@vger.kernel.org>; Wed, 18 May 2022 03:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652868399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C2r1rWBmdtu0FZ4mggyVs/7L7uA3dpDog4rnPbZik/0=;
        b=h/8VbWj8GQ51056RjyL73PtFFfJfK6K49+ftweCWop2hdFAYol19TeioeczScsJymLaJ7C
        tfXK45oLf4zcHk+i4AgOzrotVvLbn5GL9xe6rIaDEUpJwP7MEpUUbI5kyBbEaboowJPWn2
        oPtPvqF1AtOhIDedJVUNUSx7DrAQcoI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-643oZZlNPcSPYLL3Ymqt_Q-1; Wed, 18 May 2022 06:06:38 -0400
X-MC-Unique: 643oZZlNPcSPYLL3Ymqt_Q-1
Received: by mail-ej1-f70.google.com with SMTP id gs6-20020a170906f18600b006fe7a9ffacbso713323ejb.3
        for <linux-acpi@vger.kernel.org>; Wed, 18 May 2022 03:06:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C2r1rWBmdtu0FZ4mggyVs/7L7uA3dpDog4rnPbZik/0=;
        b=Bj67TVGFuX4XhyG+tsmO92MjceNCBb2lQS0+hCkvYAzmbnfI8GjKIJMzNrdRJ9haCt
         leKbzBJZ/O4o7rvyyyGjnGfH/auozIVJjEETI1tL7siPURNEH4ApMuS4NSJHcqZfByW3
         LJdXyH9K27y1++C4LM4bZ1V6EQNP4Um96sz3TA/ffEb1uI4x4fxdnzNtiQM7SeEeGuCu
         N70KqmIpKX7dZ32GT/Ujs6KBD2h81iv1Ym3wnO1uiXZfaAEIwYQKut8eTr+svPu+TiA3
         rscvVDMk4EQOVvKYtvAEeCBvnvKmNxxIoIrEFZlHor0i4HfvNN9Nt3m341bkKoXbqEyK
         alyA==
X-Gm-Message-State: AOAM530HKfff1yM8dlqRSOot8nwK/C9c2XPfac+1VS/9/ZcRDepJCYhg
        PGNCrVSC5csicUlfKazTY+38Xqe95q1dmEWeiKufGjhvcuS6Zz2oI2nJziPkiKLAuS7CYuF7zub
        C3J02TvvvrcsJY2c9Rj6FQg==
X-Received: by 2002:aa7:d2cf:0:b0:42a:c1b1:9d6b with SMTP id k15-20020aa7d2cf000000b0042ac1b19d6bmr10645132edr.405.1652868397496;
        Wed, 18 May 2022 03:06:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxW5N5eEgYNDxxR01FDnen1+ArS6hUX6UjT6X85gxiN1WIP+fe7U2YYHCi6kVoLRTzUEVBJfw==
X-Received: by 2002:aa7:d2cf:0:b0:42a:c1b1:9d6b with SMTP id k15-20020aa7d2cf000000b0042ac1b19d6bmr10645102edr.405.1652868397330;
        Wed, 18 May 2022 03:06:37 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id gx3-20020a1709068a4300b006f3ef214e0csm774697ejc.114.2022.05.18.03.06.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 03:06:36 -0700 (PDT)
Message-ID: <dc30ddc2-b00e-234e-5ec3-b1ea79c74082@redhat.com>
Date:   Wed, 18 May 2022 12:06:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 01/14] ACPI: video: Add a native function parameter to
 acpi_video_get_backlight_type()
Content-Language: en-US
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>, Lyude <lyude@redhat.com>,
        Daniel Dadap <ddadap@nvidia.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
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
References: <20220517152331.16217-1-hdegoede@redhat.com>
 <20220517152331.16217-2-hdegoede@redhat.com> <87y1yzdxtk.fsf@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <87y1yzdxtk.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 5/18/22 10:55, Jani Nikula wrote:
> On Tue, 17 May 2022, Hans de Goede <hdegoede@redhat.com> wrote:
>> ATM on x86 laptops where we want userspace to use the acpi_video backlight
>> device we often register both the GPU's native backlight device and
>> acpi_video's firmware acpi_video# backlight device. This relies on
>> userspace preferring firmware type backlight devices over native ones, but
>> registering 2 backlight devices for a single display really is undesirable.
>>
>> On x86 laptops where the native GPU backlight device should be used,
>> the registering of other backlight devices is avoided by their drivers
>> using acpi_video_get_backlight_type() and only registering their backlight
>> if the return value matches their type.
>>
>> acpi_video_get_backlight_type() uses
>> backlight_device_get_by_type(BACKLIGHT_RAW) to determine if a native
>> driver is available and will never return native if this returns
>> false. This means that the GPU's native backlight registering code
>> cannot just call acpi_video_get_backlight_type() to determine if it
>> should register its backlight, since acpi_video_get_backlight_type() will
>> never return native until the native backlight has already registered.
>>
>> To fix this add a native function parameter to
>> acpi_video_get_backlight_type(), which when set to true will make
>> acpi_video_get_backlight_type() behave as if a native backlight has
>> already been registered.
>>
>> Note that all current callers are updated to pass false for the new
>> parameter, so this change in itself causes no functional changes.
> 
> 
>> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
>> index becc198e4c22..0a06f0edd298 100644
>> --- a/drivers/acpi/video_detect.c
>> +++ b/drivers/acpi/video_detect.c
>> @@ -17,12 +17,14 @@
>>   * Otherwise vendor specific drivers like thinkpad_acpi, asus-laptop,
>>   * sony_acpi,... can take care about backlight brightness.
>>   *
>> - * Backlight drivers can use acpi_video_get_backlight_type() to determine
>> - * which driver should handle the backlight.
>> + * Backlight drivers can use acpi_video_get_backlight_type() to determine which
>> + * driver should handle the backlight. RAW/GPU-driver backlight drivers must
>> + * pass true for the native function argument, other drivers must pass false.
>>   *
>>   * If CONFIG_ACPI_VIDEO is neither set as "compiled in" (y) nor as a module (m)
>>   * this file will not be compiled and acpi_video_get_backlight_type() will
>> - * always return acpi_backlight_vendor.
>> + * return acpi_backlight_native when its native argument is true and
>> + * acpi_backlight_vendor when it is false.
>>   */
> 
> Frankly, I think the boolean native parameter here, and at the call
> sites, is confusing, and the slightly different explanations in the
> commit message and comment here aren't helping.

Can you elaborate the "slightly different explanations in the
commit message and comment" part a bit (so that I can fix this) ?

> I suggest adding a separate function that the native backlight drivers
> should use. I think it's more obvious all around, and easier to document
> too.

Code wise I think this would mean renaming the original and
then adding 2 wrappers, but that is fine with me. I've no real
preference either way and I'm happy with adding a new variant of
acpi_video_get_backlight_type() for the native backlight drivers
any suggestion for a name ?

Regards,

Hans

