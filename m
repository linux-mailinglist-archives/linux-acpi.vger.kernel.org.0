Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FAE60F2D7
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Oct 2022 10:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbiJ0Ivw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Oct 2022 04:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbiJ0Ivv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Oct 2022 04:51:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43FC15D0B2
        for <linux-acpi@vger.kernel.org>; Thu, 27 Oct 2022 01:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666860710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=piG9yqT6xAhiMXdKpX5Y3Qo1FGMuiTJ1yFwdVO4p5IY=;
        b=dwYz04UHrcf076Jv8JUz4W+UlHiqJpRkLArwBwh941B4c60JCcws4VKI3lrXPKHIrPipNN
        PSzjnMNiqHj0lTgV8iq+z9JITdG5PxlAevhXNPbCit9kI+ryXfrbSgm94zSPEF+EC5o3fi
        xf5oRbDnfe3FY92iAKZxWszEUnHssNM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-558-Uscknc19M4S1jPoJ8HCicQ-1; Thu, 27 Oct 2022 04:51:48 -0400
X-MC-Unique: Uscknc19M4S1jPoJ8HCicQ-1
Received: by mail-ed1-f72.google.com with SMTP id b13-20020a056402350d00b0045d0fe2004eso640441edd.18
        for <linux-acpi@vger.kernel.org>; Thu, 27 Oct 2022 01:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=piG9yqT6xAhiMXdKpX5Y3Qo1FGMuiTJ1yFwdVO4p5IY=;
        b=G4gep0Js/b36+aScV0Kd+ARj+I60Or+A9c3PNIlZi3IwmdOen1QHl1n9O1hGu6o5hV
         2VvhJt0fQzdeFiL/bzJS9z7MxGfS3IrCpOmSmhruoXIbUGNJSQHQrtjFh3kzbEq6h8Cl
         fAOD1WmHCb021OH1suxF6amUFhOdVkoC5qr8Y3H8f/G08KCwI+xMuFgTk8AxcS7eqmSr
         nT6OArbTHSu/xvqcpYJXKFwD/cvj5xQAoS6Gs0mqCYP+rxb1GxBCsYzYreb/Jtw+n+LN
         OqE7dhEYHpxWrROJR2IbxA+0TVfft4ml2g61kybdWydCln9wk5XeMO5jc7MA/nkBknvC
         5N+w==
X-Gm-Message-State: ACrzQf2R7nhjTcIHFTYqUJsdBphraWkAHUh7RfNKOsGG/zRNcHHSj7w5
        XbhhnUYL1UyHd/znRkuzpxRRn/4dW/y3O3N5jbmBl0NrDM7OK+cr5iZiuN1iH87vdtgnwC2jtLv
        vviUOAQBLvOhrvmNm5H21cw==
X-Received: by 2002:a05:6402:ea0:b0:454:38bf:aa3d with SMTP id h32-20020a0564020ea000b0045438bfaa3dmr19108198eda.291.1666860707415;
        Thu, 27 Oct 2022 01:51:47 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4M97BY+DJtCFsy6QaUdWwayGL+u3zLh+pSJfoHcV6/8JnsSecEzthndHQaTneGvNUsC3XcVA==
X-Received: by 2002:a05:6402:ea0:b0:454:38bf:aa3d with SMTP id h32-20020a0564020ea000b0045438bfaa3dmr19108164eda.291.1666860707189;
        Thu, 27 Oct 2022 01:51:47 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id w15-20020a056402268f00b004615bea1d5bsm635132edd.35.2022.10.27.01.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 01:51:46 -0700 (PDT)
Message-ID: <099dee98-8aeb-af36-828c-110f5ac6e9a3@redhat.com>
Date:   Thu, 27 Oct 2022 10:51:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v5 02/31] drm/i915: Don't register backlight when another
 backlight should be used (v2)
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
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
        Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org,
        Jani Nikula <jani.nikula@intel.com>,
        nouveau@lists.freedesktop.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        David Airlie <airlied@redhat.com>, Len Brown <lenb@kernel.org>
References: <f914ceb3-94bd-743c-f8b6-0334086e731a@gmail.com>
 <42a5f2c9-a1dc-8fc0-7334-fe6c390ecfbb@redhat.com>
 <20221024203057.GA28675@srcf.ucam.org>
 <8f53b8b6-ead2-22f5-16f7-65b31f7cc05c@redhat.com>
 <20221025193248.GA21457@srcf.ucam.org>
 <144cd47e-42dc-2b84-1a90-ea5e080e08a3@redhat.com>
 <20221025204043.GA23306@srcf.ucam.org>
 <cb5add36-c13c-ccd5-1b4b-71b45163a170@redhat.com>
 <20221025234040.GA27673@srcf.ucam.org>
 <fa6cc1d9-6740-b495-2c72-cae18c429ca6@redhat.com>
 <20221026204920.GA15326@srcf.ucam.org>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221026204920.GA15326@srcf.ucam.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 10/26/22 22:49, Matthew Garrett wrote:
> On Wed, Oct 26, 2022 at 11:59:28AM +0200, Hans de Goede wrote:
> 
>> Ok, so this is a local customization to what is already a custom BIOS
>> for a custom motherboard. There is a lot of custom in that sentence and
>> TBH at some point things might become too custom for them to be expected
>> to work OOTB.
> 
> But it *did* work OOTB before. You broke it. I accept that I'm a 
> ludicrously weird corner case here, but there are going to be other 
> systems that are also affected by this.
> 
>> I'm afraid things are not that simple. I assume that with
>> "if ACPI backlight control is expected to work" you mean don't
>> use ACPI backlight control when (acpi_osi_is_win8() && native_available)
>> evaluates to true because it is known to be broken on some of
>> those systems because Windows 8 stopped using it ?
> 
> Correct.
> 
>> Unfortunately something similar applies to vendor interfaces,
>> When Windows XP started using (and mandating for certification
>> IIRC) ACPI backlight control, vendors still kept their own
>> vendor specific EC/smbios/ACPI/WMI backlight interfaces around for
>> a long long time, except they were often no longer tested.
> 
> The current situation (both before your patchset and with its current 
> implementation) is that vendor is preferred to native, so if the vendor 
> interface is present then we're already using it.

All vendor drivers that I'm aware of have:

	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
		return;

In their backlight register paths and this has been present since
circa 2015.

So both before and after my 6.1 refactor vendor is only preferred
on devices which don't implement the ACPI video bus control method.

>>> The 
>>> problem you're dealing with is that the knowledge of whether or not 
>>> there's a vendor interface isn't something the core kernel code knows 
>>> about. What you're proposing here is effectively for us to expose 
>>> additional information about whether or not there's a vendor interface 
>>> in the system firmware, but since we're talking in some cases about 
>>> hardware that's almost 20 years old, we're not realistically going to 
>>> get those old machines fixed.
>>
>> I don't understand why you keep talking about the old vendor interfaces,
>> at least for the chromebook part of this thread the issue is that
>> the i915 driver no longer registers the intel_backlight device which
>> is a native device type, which is caused by the patch this email
>> thread is about (and old vendor interfaces do not come into play
>> at all here). So AFAICT this is a native vs acpi backlight control
>> issue ?
> 
> I'm referring to your proposed patch that changed the default from 
> backlight_vendor to backlight_native, which would fix my machine and 
> Chromebooks but break anything that relies on the vendor interfaces.

I see. I agree that preferring native over vendor on machines
which do not have ACPI video backlight control will cause issues
on older machines. Avoiding this scenario is exactly why currently
the native check is conditional on the presence of ACPI video
backlight control.

>> I really want to resolve your bug, but I still lack a lot of info,
>> like what backlight interface you were actually using in 6.0 ?
> 
> Native.
> 
>>         {
>>          .callback = video_detect_force_video,
>>          /* ThinkPad X201s */
>>          .matches = {
>>                 DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>                 DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X201s"),
>>                 },
>>         },
>>
>> will trigger.
> 
> In this case you'd break anyone else running the system who isn't using 
> the hacked EC and different ACPI tables - obviously there's ways round 
> this, but realistically since I'm (as far as I know) the only person in 
> this situation it makes more sense for me to add a kernel parameter than 
> carry around an exceedingly niche DMI quirk. I'm fine with that. But the 
> point I'm trying to make is that the machines *are* telling you whether 
> they'd prefer vendor or native.

I wish that that ("telling you whether they'd prefer vendor or native")
were true. But that does not match my experience at all and I've been
working on making the kernel pick the right backlight interface on
laptops since 2014.

Just because a vendor interface is present does not mean that it will
work. Unfortunately for none of the 3 main native/acpi_video/vendor
backlight control methods the control method being present also guarantees
that it will work. Which completely sucks, but it is the reality we
have to deal with.

> , and you're not taking that into account 
> in the video_detect code.

Regards,

Hans

