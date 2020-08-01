Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08AF22352C6
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Aug 2020 16:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgHAOiZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 1 Aug 2020 10:38:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36273 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725280AbgHAOiY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Aug 2020 10:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596292702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rPMJouJ664IpIpYWMWyBiWUEHfHruXWhEFW6i4OWc6U=;
        b=FeJ3Xm2gkjHQYWHqkYt1paF+/2NAQZI8ekmuMWZdhsi1odwET8gxDphM9xx1mjleN3ta0j
        sLdUt0RTtxo2JRYzVXLLv3dXGDWos7+mYsjcGCL2EXsOkyw76fa6bqreK6Pk3zNhGHwV0U
        K4f8iLDXCXwpAkp9uDtzmSYncBeJwbw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-DYV-uXywPg-lXCP9PuPpxw-1; Sat, 01 Aug 2020 10:38:21 -0400
X-MC-Unique: DYV-uXywPg-lXCP9PuPpxw-1
Received: by mail-ed1-f69.google.com with SMTP id t9so10200125edw.22
        for <linux-acpi@vger.kernel.org>; Sat, 01 Aug 2020 07:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rPMJouJ664IpIpYWMWyBiWUEHfHruXWhEFW6i4OWc6U=;
        b=kSQ+Exqb7kHemW8W/02opJs3kr53rFpI+CmSiNMj+GMZMQxNVlZtFNyAROScOa3QFb
         Grd+BPfF899pLjZPoUpxAE1U4LGtXmnAoDHrPKFSQtAv7mGjvjXMBYkJ9x4sqUy9UMl4
         kvV5YzUt5yp78boWMg0/taGIWbqjjq0D826mXyoZFuweo3B2CyCrF8M1hDAycF6XigAY
         JAJZbR9eBFn/EFQSNgUna+4v81WFk8vwf44sIcpnbvkyHneFOomg30vYQhXxrUCxOHZF
         0ibMY2TYBV9Xtl2vdu9C2SnAU51pXtOArsIpx82bO1CoIcLL2h2CzBS/rtqmI0258xBu
         Cfdg==
X-Gm-Message-State: AOAM532IksR4iGqJNeTDe9EzfQl9m92m4L2CCyxhTnFvIo/jAPDh0/mp
        n8FoSWO0YxOqBfzg7uk6euOShOohWA9WoxLGULAnZxgOyVo9TACDrHpN7tu8i+pOh1IRlaBwX0k
        W1uYE4KfIbd8O9rAJXVl4Kw==
X-Received: by 2002:a17:906:25c4:: with SMTP id n4mr8776590ejb.3.1596292699673;
        Sat, 01 Aug 2020 07:38:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjPcX/bFiAUHtXwuAaF05a6ZsFXjiF7gt7+jMKXpyprGcBXZ8zklO4Fxg9U+zmr2eCv0rfuA==
X-Received: by 2002:a17:906:25c4:: with SMTP id n4mr8776564ejb.3.1596292699441;
        Sat, 01 Aug 2020 07:38:19 -0700 (PDT)
Received: from x1.localdomain ([109.38.137.213])
        by smtp.gmail.com with ESMTPSA id o9sm11813057edz.81.2020.08.01.07.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2020 07:38:18 -0700 (PDT)
Subject: Re: [PATCH v5 00/16] acpi/pwm/i915: Convert pwm-crc and i915 driver's
 PWM code to use the atomic PWM API
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
References: <20200717133753.127282-1-hdegoede@redhat.com>
 <20200729105436.GT3703480@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e8f93474-1775-b20c-f9f2-e33592a02028@redhat.com>
Date:   Sat, 1 Aug 2020 16:38:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729105436.GT3703480@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 7/29/20 12:54 PM, Andy Shevchenko wrote:
> On Fri, Jul 17, 2020 at 03:37:37PM +0200, Hans de Goede wrote:
>> Hi All,
>>
>> Here is v5 of my patch series converting the i915 driver's code for
>> controlling the panel's backlight with an external PWM controller to
>> use the atomic PWM API. See below for the changelog.
>>
>> This series consists of 4 parts:
>>
>> 1. acpi_lpss fixes workarounds for Cherry Trail DSTD nastiness
>> 2. various fixes to the pwm-lpss driver
>> 3. convert the pwm-crc driver to support the atomic PWM API and
>> 4. convert the i915 driver's PWM code to use the atomic PWM API
>>
>> The involved acpi_lpss and pwm drivers do not see a whole lot of churn,
>> so the plan is to merge this all through drm-intel-next-queued (dinq)
>> once all the patches are reviewed / have acks.
>>
>> Specifically patches 5-9, 11 still need an Acked- / Reviewed-by
>>
>> Andy, can you please take a look at the unreviewed patches? Specifically
>> patches 5-6 should address your review remarks from v4 of this set
>> and I've addressed your review remarks on patches 7-9 in v3 already.
>> A review of patch 11 would also be welcome
> 
> Done. Sorry for a delay.
> 
> One comment to consider, though. There are three channels in that PWM AFAIU.
> One of them is backlight control, another one can be attached to haptics. The
> concern is how this series may (or may not?) affect haptics behaviour.

When you say "in that PWM" do you mean the LPSS one or the CRC one ?

The LPSS patches are all fixes, they don't change behavior, so those
should be fine for the haptics.

The CRC PWM driver patches do make it honor the requested output frequency,
where before, because of a bug, it would stick with the out frequency
setup by the firmware (or the power-on-reset value if no value is set
by the firmware). This fix causing this is very clearly correct, but
it could have unexpected side-effects.

However I guess that you are talking about the LPSS PWM controllers
and there I expect no impact on haptic or other non backlight users
from these changes.

Regards,

Hans

