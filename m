Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8633560F3DA
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Oct 2022 11:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbiJ0Jjx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Oct 2022 05:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbiJ0Jjr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Oct 2022 05:39:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A6122512
        for <linux-acpi@vger.kernel.org>; Thu, 27 Oct 2022 02:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666863583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SPLb3w6K7DrqCekqNfHb7k0C69BoLOUk/AH12Hh9eUE=;
        b=gfp3Dbk98LBVK0C55dZC2FOGanT9lklwOWaXY6b88Cq7cd3Jz23cxzbkU/dpBVA2pHhkBt
        lDkoUlavV5LagSIjYGPX0TrjW3T/zHDncZSJ/DDnNj6dtskCVI/Z5I+lVf/JN1ZGNsUE8R
        R8bp0DlkUuE1fExVxXZkkzKSWQT5cD4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-640-aPAshSb6NBu4KyKJREjL9Q-1; Thu, 27 Oct 2022 05:39:42 -0400
X-MC-Unique: aPAshSb6NBu4KyKJREjL9Q-1
Received: by mail-ej1-f70.google.com with SMTP id hs34-20020a1709073ea200b007ad86f91d39so678094ejc.10
        for <linux-acpi@vger.kernel.org>; Thu, 27 Oct 2022 02:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SPLb3w6K7DrqCekqNfHb7k0C69BoLOUk/AH12Hh9eUE=;
        b=qW5tZfduzlgvloMWOscHYR2W5EAcZdP/X9mzUtA359kACMdaLOXkLHyU5UA6+fiFjF
         /MxVhvqK3xohuY1X9KXyDqlUzRrPx0PEGJB2UR6aZ+NVADvPpglaXyPbDbnK/LvAveQH
         kJB4I5n154BiBfVtftJsrH53Vu8m9InLxCJWu9DFD/aXUH3XKDQbx+bAKb+IVi9YzM8/
         OUFC+P96Hkmn0IdnOKVMTx/5gJ8Z3I6xOhUVKAAcIRpvq7sOAjdxpkWwX9wX0Pyeh+uY
         VrMPla8L9vVKTZ/Yeeyg3YScuxOIQ2ziYrYPNprVqKmZYlxZem039yWCcaKhIZN63IPF
         Hztg==
X-Gm-Message-State: ACrzQf2wpyPXfsYfZRXlDEWZq2tC30vHtg7Nsa5EalJk38NvtlYkBnSI
        FmVbedY8k/G5/Y7ohZHhcS9rStt6c4OFhzDCgC8rUhZBfx9nXpU+SJWbDGeqrVomAN2lObWoGax
        hxiJ/OI50DkejKdR7jINU+w==
X-Received: by 2002:a17:906:8a4b:b0:7a7:3e17:7f91 with SMTP id gx11-20020a1709068a4b00b007a73e177f91mr19223701ejc.331.1666863580772;
        Thu, 27 Oct 2022 02:39:40 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7QQCa4ZhbSxyNv8ySSfoneULT0DuJcUzkyJosCmR+F+sIN0nbLZtmTKn4Yv2n7c7oDN6G+Jg==
X-Received: by 2002:a17:906:8a4b:b0:7a7:3e17:7f91 with SMTP id gx11-20020a1709068a4b00b007a73e177f91mr19223685ejc.331.1666863580511;
        Thu, 27 Oct 2022 02:39:40 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id ds12-20020a0564021ccc00b00461aebb2fe2sm672031edb.54.2022.10.27.02.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 02:39:39 -0700 (PDT)
Message-ID: <933be908-0bc2-56cc-8d6f-38f2d208ef20@redhat.com>
Date:   Thu, 27 Oct 2022 11:39:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v5 02/31] drm/i915: Don't register backlight when another
 backlight should be used (v2)
Content-Language: en-US, nl
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
References: <20221024203057.GA28675@srcf.ucam.org>
 <8f53b8b6-ead2-22f5-16f7-65b31f7cc05c@redhat.com>
 <20221025193248.GA21457@srcf.ucam.org>
 <144cd47e-42dc-2b84-1a90-ea5e080e08a3@redhat.com>
 <20221025204043.GA23306@srcf.ucam.org>
 <cb5add36-c13c-ccd5-1b4b-71b45163a170@redhat.com>
 <20221025234040.GA27673@srcf.ucam.org>
 <fa6cc1d9-6740-b495-2c72-cae18c429ca6@redhat.com>
 <20221026204920.GA15326@srcf.ucam.org>
 <099dee98-8aeb-af36-828c-110f5ac6e9a3@redhat.com>
 <20221027091123.GA28089@srcf.ucam.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221027091123.GA28089@srcf.ucam.org>
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

Hi Matthew,

On 10/27/22 11:11, Matthew Garrett wrote:
> On Thu, Oct 27, 2022 at 10:51:45AM +0200, Hans de Goede wrote:
> 
>> In their backlight register paths and this has been present since
>> circa 2015.
>>
>> So both before and after my 6.1 refactor vendor is only preferred
>> on devices which don't implement the ACPI video bus control method.
> 
> Sorry, yes, that's the case I meant.
> 
>> Just because a vendor interface is present does not mean that it will
>> work. Unfortunately for none of the 3 main native/acpi_video/vendor
>> backlight control methods the control method being present also guarantees
>> that it will work. Which completely sucks, but it is the reality we
>> have to deal with.
> 
> But traditionally that's been logic that we've encoded into the vendor 
> drivers, which can take other factors into account when determining 
> whether the exposed interface works. You've now discarded that 
> knowledge.

As I already mentioned in my previous email, the vendor drivers have
been using something like:

	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
		return;

In their backlight register paths *since 2015* and even before
then most of them called some acpi_video helper function to determine
if ACPI video backlight control was available and skipped registering
their backlight device if that returned true. And calling that
acpi_video helper is as smart as they traditionally were. That +
DMI quirks and we still have all those quirks.

I was very careful with the refactoring landing in 6.1 to *not*
change any of this.

The *only* behavior which actually is new in 6.1 is the native GPU
drivers now doing the equivalent of:

	if (acpi_video_get_backlight_type() != acpi_backlight_native)
		return;

In their backlight register paths (i), which is causing the native
backlight to disappear on your custom laptop setup and on Chromebooks
(with the Chromebooks case being already solved I hope.).

I am fully aware that this may turn out to also impact other laptops.
I'm keeping out an eye for this and I have specifically reached-out
to the coreboot community asking them to test 6.1 .

> The only way you can maintain the degree of functionality 
> that 6.0 had is to move that determination into core code, or 
> alternatively support dynamic reattachment of backlight interfaces based 
> on vendor drivers loading later. An alternative would be to just revert 
> all of this, and instead only use this logic for the output property 
> interface (which would still result in different outcomes, but only for 
> userland that's choosing to use the new interface, so that's a different 
> problem).

Yes I am considering dropping the "acpi_video_get_backlight_type() !=
acpi_backlight_native" check from at least the i915 driver if we get more
bug reports and then indeed only do the equivalent of that check in
the code for the new output property.

I agree this is a possible solution if this turns out to break more
systems and there is no other easy/clean way to fix those. But I would
greatly prefer to keep this change and stop the IMHO bad kernel behavior
of "registering multiple backlight-devices for a single panel and then
let userspace sort it out".

Regards,

Hans


i) Before this, the kernel was relying on userspace preferring acpi_video
or vendor backlight devices over native if both are present and the
native backlight devices were registered unconditionally.



