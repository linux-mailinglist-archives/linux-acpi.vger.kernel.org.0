Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A750F2160AB
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Jul 2020 22:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgGFUyD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Jul 2020 16:54:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58584 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725941AbgGFUyD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Jul 2020 16:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594068841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vEF+yCsN+6XHx9V9f6oNlSB58cV9j+Ug5Yuy3EiBSKQ=;
        b=Hv7cfkl1F6k0XRc4m2OycjdTjJw8aAp5uO3RMfjt8gAZTyTARipBfMghnrTO7frwgsIb8x
        3hfd1kYRc5LaoopHkXKuf/K5SrVI0hbm9ObMRlbNiYs+YqsbZMVLWSakoQpaC3TyoPo50Z
        D4ULj+YT8p2X6n4l3UypPu4b1BSWxd0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-6wMF3ZohMo6Vk1udfGqBsg-1; Mon, 06 Jul 2020 16:54:00 -0400
X-MC-Unique: 6wMF3ZohMo6Vk1udfGqBsg-1
Received: by mail-ej1-f70.google.com with SMTP id a26so33041329ejr.7
        for <linux-acpi@vger.kernel.org>; Mon, 06 Jul 2020 13:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vEF+yCsN+6XHx9V9f6oNlSB58cV9j+Ug5Yuy3EiBSKQ=;
        b=uQ7Z61aM3cl1KGzzgyQEA8x2PpdlW47O2FD04KhzMmeFmGU+XjOLV+JQHJdwYB0IvL
         3Niw9lNy3Kzy3ZjAMMj7eav+Wy9Q07YfAcoUbfmymladNjuWHMCnq6lxdVtUXchh5mXX
         4Zc86aCdRtHNQdX5FJ4RafA9Dxpas4bfX4fNR6WHN2yhvNlBXzZQTewMWHqTbl6TfgRY
         EYcXzcM418oJlg7Th/Fle1q8DFXK3JG57Pt+MWIvOMhnSItIz+UW7X8wz1pp+RrEdLLL
         xnzLL7Lzdi+EwitQ6ZP02qqyvc0Uol2KUd2CFfswKi51paMt5nAMvcg/WYdSzR7GpCIf
         B5JQ==
X-Gm-Message-State: AOAM530x79+nuuIaLc2rOkACJZ0B4eGTGhmm5jxAKsni/hGf5s2uk8oA
        KoJaS48it95dVUjoCJ0A+JdtETGBHlqSqunVwIk3ISgEgqfcrnwWKGlQjR//2esY/MzlNCei5TG
        wOksjnaRYwBGEW2nbUNIhQQ==
X-Received: by 2002:a17:906:af43:: with SMTP id ly3mr43705718ejb.381.1594068838885;
        Mon, 06 Jul 2020 13:53:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwG3xi6GqlmGrRaMYnTUYRfwj4wKQDVaHVYVyFfexsal0TLn7Hg1JyExGqz4B90ev91uqzbkQ==
X-Received: by 2002:a17:906:af43:: with SMTP id ly3mr43705696ejb.381.1594068838562;
        Mon, 06 Jul 2020 13:53:58 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id s7sm23495977edr.57.2020.07.06.13.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 13:53:57 -0700 (PDT)
Subject: Re: [PATCH v3 00/15] acpi/pwm/i915: Convert pwm-crc and i915 driver's
 PWM code to use the atomic PWM API
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
References: <20200620121758.14836-1-hdegoede@redhat.com>
 <874kqsmzk9.fsf@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <04ed1c4d-9611-ba6f-6c7b-5df418b61980@redhat.com>
Date:   Mon, 6 Jul 2020 22:53:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <874kqsmzk9.fsf@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/30/20 3:51 PM, Jani Nikula wrote:
> On Sat, 20 Jun 2020, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi All,
>>
>> Here is v3 of my patch series converting the i915 driver's code for
>> controlling the panel's backlight with an external PWM controller to
>> use the atomic PWM API. See below for the changelog.
>>
>> Initially the plan was for this series to consist of 2 parts:
>> 1. convert the pwm-crc driver to support the atomic PWM API and
>> 2. convert the i915 driver's PWM code to use the atomic PWM API.
>>
>> But during testing I've found a number of bugs in the pwm-lpss and I
>> found that the acpi_lpss code needs some special handling because of
>> some ugliness found in most Cherry Trail DSDTs.
>>
>> So now this series has grown somewhat large and consists of 4 parts:
>>
>> 1. acpi_lpss fixes workarounds for Cherry Trail DSTD nastiness
>> 2. various fixes to the pwm-lpss driver
>> 3. convert the pwm-crc driver to support the atomic PWM API and
>> 4. convert the i915 driver's PWM code to use the atomic PWM API
>>
>> So we need to discuss how to merge this (once it passes review).
>> Although the inter-dependencies are only runtime I still think we should
>> make sure that 1-3 are in the drm-intel-next-queued (dinq) tree before
>> merging the i915 changes. Both to make sure that the intel-gfx CI system
>> does not become unhappy and for bisecting reasons.
>>
>> The involved acpi_lpss and pwm drivers do not see a whole lot of churn, so
>> it likely is the easiest to just merge everything through dinq.
>>
>> Rafael and Thierry, can I get your Acked-by for directly merging this into
>> dinq?
>>
>> This series has been tested (and re-tested after adding various bug-fixes)
>> extensively. It has been tested on the following devices:
>>
>> -Asus T100TA  BYT + CRC-PMIC PWM
>> -Toshiba WT8-A  BYT + CRC-PMIC PWM
>> -Thundersoft TS178 BYT + CRC-PMIC PWM, inverse PWM
>> -Asus T100HA  CHT + CRC-PMIC PWM
>> -Terra Pad 1061  BYT + LPSS PWM
>> -Trekstor Twin 10.1 BYT + LPSS PWM
>> -Asus T101HA  CHT + CRC-PMIC PWM
>> -GPD Pocket  CHT + CRC-PMIC PWM
> 
> For the drm/i915 patches 12-15,
> 
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> 
> I eyeballed through them, and didn't spot anything obviously wrong, but
> at the same time didn't have the time to do an in-depth review. That
> said, I do have a lot of trust in you testing this with all the above
> devices. I think that's enough for merging.
> 
> As for that matter, I'm fine with merging this via whichever tree you
> find best. Kind of stating the obvious, but please do ensure you have
> the proper acks in place for this.

Thank you. I plan to push the entire series to dinq once I have a
full set of acks for the PWM changes (I already have acks for the rest).

Regards,

Hans



>> Changelog:
>>
>> Changes in v2:
>> - Fix coverletter subject
>> - Drop accidentally included debugging patch
>> - "[PATCH v3 02/15] ACPI / LPSS: Save Cherry Trail PWM ctx registers only once (
>>    - Move #define LPSS_SAVE_CTX_ONCE define to group it with LPSS_SAVE_CTX
>>
>> Changes in v3:
>> - "[PATCH v3 04/15] pwm: lpss: Add range limit check for the base_unit register value"
>>    - Use base_unit_range - 1 as maximum value for the clamp()
>> - "[PATCH v3 05/15] pwm: lpss: Use pwm_lpss_apply() when restoring state on resume"
>>    - This replaces the "pwm: lpss: Set SW_UPDATE bit when enabling the PWM"
>>      patch from previous versions of this patch-set, which really was a hack
>>      working around the resume issue which this patch fixes properly.
>> - PATCH v3 6 - 11 pwm-crc changes:
>>    - Various small changes resulting from the reviews by Andy and Uwe,
>>      including some refactoring of the patches to reduce the amount of churn
>>      in the patch-set
>>
>> Regards,
>>
>> Hans
>>
> 

