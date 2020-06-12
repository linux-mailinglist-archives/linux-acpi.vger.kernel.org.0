Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E1A1F7C14
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jun 2020 19:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgFLRFI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Jun 2020 13:05:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28437 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726290AbgFLRFI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 Jun 2020 13:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591981506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aJhsLiuB5MJfhLZW+3GQ1NI8Ulud2FZJOWodXiS4/hM=;
        b=GfLF7ROtNq42iFi2xkFP4NuD8AtZ3d//czP9ln540v7x6n9A2VPGdE+o2Yipoyh4UuLEHu
        eG7X/J9B8i4M5BgkMZn6M7jPjy/xITU/QJH/riczVHN5T8a86K37o9ojW2VporGOeJwjvt
        9UDHZdiB4lIXsKB9jOSxnITflMEp16o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-YJ-hleG_Ml--rlD8HlkIgw-1; Fri, 12 Jun 2020 13:04:55 -0400
X-MC-Unique: YJ-hleG_Ml--rlD8HlkIgw-1
Received: by mail-ed1-f69.google.com with SMTP id dh12so3174088edb.9
        for <linux-acpi@vger.kernel.org>; Fri, 12 Jun 2020 10:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aJhsLiuB5MJfhLZW+3GQ1NI8Ulud2FZJOWodXiS4/hM=;
        b=RlI57sqMtbGl6xxDEoFttee1lh6cDUzRaqxXNUCsdwL6bYFbpWAiYSSVZM8EbziOQb
         vvHL9CMoPMWAo4IPQ0Z4Gm0LoQfri3eIMEOfTbUWM8wWxk2T1dBndEml5aUjovf0f4wP
         DeuUZVhbTJDPzUq4j8kLvaH755WEiBlFa2TrkWD1LE0JtGZlbPrvuQhEj/xRVADnki4t
         TkSkNl7r6+RK4maiIZ5e+93GacfzcYh7/kUgn9/eZIWJ9vlH+H7hlydT8gMlAWUMuNlJ
         uuGc0CAmckMs1mn47IdAmPmsa9Kc5ztx+ksxaLpKzx/ndaVp6wiLs6iGgPnbc5/Pfdi+
         i3iQ==
X-Gm-Message-State: AOAM5303Z/Vk+3wk0lkFk2pXQhvl3NGPuCE6XKQHvq9upDOhF3EcZL2v
        UlI0geYG6bIfKydMW6LPPB7xd8Tyu9JmekCH61XSp/C4fd+XNpnKZvly3ATF9AePKPsoACP0f/X
        twmb3J5bAY/lz3THu/yBQSw==
X-Received: by 2002:a17:906:3041:: with SMTP id d1mr14497154ejd.7.1591981493744;
        Fri, 12 Jun 2020 10:04:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8/X6kVaFS8fcJPbnnHMtvzqT2kk50X8Vfwy3lEhe+LE8MdjUbh7IV+C3pCB1j1LapjG6OZw==
X-Received: by 2002:a17:906:3041:: with SMTP id d1mr14497118ejd.7.1591981493412;
        Fri, 12 Jun 2020 10:04:53 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id o5sm3842626eje.66.2020.06.12.10.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 10:04:52 -0700 (PDT)
Subject: Re: pwm/i915: Convert pwm-crc and i915 driver's PWM code to use the
 atomic PWM API
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20200606202601.48410-1-hdegoede@redhat.com>
 <20200608143500.GX20149@phenom.ffwll.local>
 <20200611212144.i7ma7kriznidds4r@taurus.defre.kleine-koenig.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <58972efb-003d-ca87-0637-ece4c93aeeb5@redhat.com>
Date:   Fri, 12 Jun 2020 19:04:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611212144.i7ma7kriznidds4r@taurus.defre.kleine-koenig.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/11/20 11:21 PM, Uwe Kleine-König wrote:
> Hello,
> 
> On Mon, Jun 08, 2020 at 04:35:00PM +0200, Daniel Vetter wrote:
>> On Sat, Jun 06, 2020 at 10:25:45PM +0200, Hans de Goede wrote:
>>> Hi All,
>>>
>>> This patch series converts the i915 driver's cpde for controlling the
>>> panel's backlight with an external PWM controller to use the atomic PWM API.
>>>
>>> Initially the plan was for this series to consist of 2 parts:
>>> 1. convert the pwm-crc driver to support the atomic PWM API and
>>> 2. convert the i915 driver's PWM code to use the atomic PWM API.
>>>
>>> But during testing I've found a number of bugs in the pwm-lpss and I
>>> found that the acpi_lpss code needs some special handling because of
>>> some ugliness found in most Cherry Trail DSDTs.
>>>
>>> So now this series has grown somewhat large and consists of 4 parts:
>>>
>>> 1. acpi_lpss fixes workarounds for Cherry Trail DSTD nastiness
>>> 2. various fixes to the pwm-lpss driver
>>> 3. convert the pwm-crc driver to support the atomic PWM API and
>>> 4. convert the i915 driver's PWM code to use the atomic PWM API
>>>
>>> So we need to discuss how to merge this (once it passes review).
>>> Although the inter-dependencies are only runtime I still think we should
>>> make sure that 1-3 are in the drm-intel-next-queued (dinq) tree before
>>> merging the i915 changes. Both to make sure that the intel-gfx CI system
>>> does not become unhappy and for bisecting reasons.
>>
>> Simplest is if acpi acks the acpi patches for merging through
>> drm-intel.git. Second simplest is topic branch (drm-intel maintainers can
>> do that) with the entire pile, which then acpi and drm-intel can both pull
>> in.
>>
>> Up to the two maintainer teams to figure this one out.
> 
> I'm unclear about the dependencies

There is a runtime dependency of the i915 changes on the PWM changes
and since the intel-gfx folks use a lot of CI, we this need to get the
PWM changes into the drm-intel tree before the i915 changes can land.

> , but the changes to drivers/pwm need
> an ack (or processing) by the PWM team.

Of course, I asked for an Acked-by from the PWM team
(once this passes review) for merging this through
the drm-intel tree, as the i915 driver is the main
(only AFAIK) consumer of the PWMs controlled by these
2 drivers.  Daniel <snip>-ed that bit when he replied.

Regards,

Hans

