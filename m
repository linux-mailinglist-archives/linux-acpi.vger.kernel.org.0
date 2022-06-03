Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1011D53C541
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Jun 2022 08:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbiFCGzz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Jun 2022 02:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbiFCGzy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Jun 2022 02:55:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 001BB366B8
        for <linux-acpi@vger.kernel.org>; Thu,  2 Jun 2022 23:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654239351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7E5lR+VTALld2mTfNQxdusQn4aNxYfVVAc9A8NqQeSE=;
        b=FgO2PjeXBmNXC6qJi5/kBJCZDpJXicut2hLaX7C/8tFU2mCFCkj3P2G01BRcJDGIMEazGj
        JjM+ypB1dQeeJpVhu6iMgpNchu8bUlMknxn1LlAwDUOQDxmrNUujVT04t32lLd3+BLS+gg
        eLAtCqs5nHRnvuUXd5N7IDvtQWd2vx4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-2VWICKAtM_OgHjm3VLRivg-1; Fri, 03 Jun 2022 02:55:50 -0400
X-MC-Unique: 2VWICKAtM_OgHjm3VLRivg-1
Received: by mail-wm1-f70.google.com with SMTP id u12-20020a05600c19cc00b0038ec265155fso6365203wmq.6
        for <linux-acpi@vger.kernel.org>; Thu, 02 Jun 2022 23:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7E5lR+VTALld2mTfNQxdusQn4aNxYfVVAc9A8NqQeSE=;
        b=IhNruSUf259/eD+2/B3nfP5wJM9N32AqIhZZ2AYBgl74TwDDUvSltsafRFZs4iAQlg
         NHxxai+F7+9YbwNv7I7Wb9NxquBpaVtqE/BQvRSbIaRyaMgDDoMQsOQm/YsV8kPeDD1B
         iJUVLhvLMu0kOxSlWOe9nJt/H8gtvOKmBSeRKVpjduGYd/3hJDuPK+ZUEHT4eRnG2UOu
         KM16oUyUYsB6hzl3CT1lew6uwZXY+CTxWo8uYDDgxECnVhIMyXOujBu/KoeSS97X/JVh
         i6gV1tbq52O/Zay3DG36u5e748W/fY8+/R2yJ7zUo2K3bhynX7pZcpeKLoMJr1PnxQi7
         EIMw==
X-Gm-Message-State: AOAM530emNx76WA4pLKeVtKousJ5/M3UBnBclx32bGtOAeh8Fvux6kNy
        V4+PNkx+BnXn5OEKwg2+Ctnl3Bl4xsXBPbhvdK4aWbzvHuciVO2Tuur7gdbUM+Eoutdq4L4x+uy
        DOyuQtpmdvQwLiOw3F4+xpw==
X-Received: by 2002:a05:600c:1c86:b0:39c:eeb:39a3 with SMTP id k6-20020a05600c1c8600b0039c0eeb39a3mr7114005wms.40.1654239349163;
        Thu, 02 Jun 2022 23:55:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrSRa5Dxj7z6MY5xtT+kIz0IbbtMCxkQJLgdqcN5Ae38x2SZ7pJ1GoY/N+E8qgoPHMEiuqSQ==
X-Received: by 2002:a05:600c:1c86:b0:39c:eeb:39a3 with SMTP id k6-20020a05600c1c8600b0039c0eeb39a3mr7113980wms.40.1654239348953;
        Thu, 02 Jun 2022 23:55:48 -0700 (PDT)
Received: from [172.28.2.131] (163.106.124.80.rev.sfr.net. [80.124.106.163])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d410a000000b0020fc6590a12sm6256206wrp.41.2022.06.02.23.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 23:55:48 -0700 (PDT)
Message-ID: <a3cd0f3f-9e97-706a-27af-4e5b6f63eb05@redhat.com>
Date:   Fri, 3 Jun 2022 08:55:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 12/14] drm/nouveau: Register ACPI video backlight when
 nv_backlight registration fails
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
 <20220517152331.16217-13-hdegoede@redhat.com>
 <0c9c2c59ca9c351769921c47beb49dda79ddd5de.camel@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <0c9c2c59ca9c351769921c47beb49dda79ddd5de.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Lyude,

Thank you for the reviews.

On 5/18/22 19:39, Lyude Paul wrote:
> On Tue, 2022-05-17 at 17:23 +0200, Hans de Goede wrote:
>> Typically the acpi_video driver will initialize before nouveau, which
>> used to cause /sys/class/backlight/acpi_video0 to get registered and then
>> nouveau would register its own nv_backlight device later. After which
>> the drivers/acpi/video_detect.c code unregistered the acpi_video0 device
>> to avoid there being 2 backlight devices.
>>
>> This means that userspace used to briefly see 2 devices and the
>> disappearing of acpi_video0 after a brief time confuses the systemd
>> backlight level save/restore code, see e.g.:
>> https://bbs.archlinux.org/viewtopic.php?id=269920
>>
>> To fix this the ACPI video code has been modified to make backlight class
>> device registration a separate step, relying on the drm/kms driver to
>> ask for the acpi_video backlight registration after it is done setting up
>> its native backlight device.
>>
>> Add a call to the new acpi_video_register_backlight() when native backlight
>> device registration has failed / was skipped to ensure that there is a
>> backlight device available before the drm_device gets registered with
>> userspace.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/gpu/drm/nouveau/nouveau_backlight.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c
>> b/drivers/gpu/drm/nouveau/nouveau_backlight.c
>> index f56ff797c78c..0ae8793357a4 100644
>> --- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
>> +++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
>> @@ -436,6 +436,13 @@ nouveau_backlight_init(struct drm_connector *connector)
>>  
>>  fail_alloc:
>>         kfree(bl);
>> +       /*
>> +        * If we get here we have an internal panel, but no nv_backlight,
>> +        * try registering an ACPI video backlight device instead.
>> +        */
>> +       if (ret == 0)
>> +               acpi_video_register_backlight();
> 
> Assuming we don't need to return the value of acpi_video_register_backlight()
> here:

The function return type is void, so no return value to check :)

> 
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> 
>> +
>>         return ret;
>>  }
>>  
> 

