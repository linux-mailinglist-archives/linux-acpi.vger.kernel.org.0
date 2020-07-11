Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8222821C477
	for <lists+linux-acpi@lfdr.de>; Sat, 11 Jul 2020 15:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgGKNrD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 11 Jul 2020 09:47:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57945 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726342AbgGKNrD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 11 Jul 2020 09:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594475221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ypJLZNaMeKtGfv3TVsmWUfAoJ1cM0/nyBbZwCNLwYBE=;
        b=guVjGdZEHPe2nFdRwRfyXsYS/++OynnjaWVR2v7+wgnCqY792PKdCksvrqDQ3N/6JFWKQ0
        bck/fu6HbXm08GZ+mqg7kHVyknmZGzauibg8SA3Rf3LtIzQF0nxr0QvH0Ulmx6JIaklU8+
        M08WMgpt/mSQKb5PzwTHg25Qad8B3VA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-ZQvHO13KP-eWYzhXlyLf1w-1; Sat, 11 Jul 2020 09:46:59 -0400
X-MC-Unique: ZQvHO13KP-eWYzhXlyLf1w-1
Received: by mail-ed1-f71.google.com with SMTP id u25so11478673edq.1
        for <linux-acpi@vger.kernel.org>; Sat, 11 Jul 2020 06:46:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ypJLZNaMeKtGfv3TVsmWUfAoJ1cM0/nyBbZwCNLwYBE=;
        b=Ou33ORBwIEilKgyGmXQTBHj0variwfd688ScTinexW4K/PXxPTJLg9RM0lU/tc3NDk
         w9xLxZ42jtZZngtF39Jc1UIxjlczgNAgAqJTMLLzOzMD/TnzjB+B14L6LWcedYcQnhxb
         UaOGg0e4tSLDh9PwnM3/jW8r+02suFGt55hBIWnSUs+5UsEf/jHSxvVuKSALwnqivCIJ
         tw2Kn3g7nlSSsftlewVEwDP7QmdKTCKF16We43f4Y0HOCJ8lMpcaGU/sT/pzNiSLNff4
         oEC2gJDNJtCpV4+58qEpTCM/JAeUiHdIopJ2LBjnNeOBz1JsSEx6b+EWs9edfK0Z3kVH
         /AGQ==
X-Gm-Message-State: AOAM53089P/T73GgD5q20UeBFdtpR/pElczjaC20/EUSybSfkd0GTEXK
        B/8JpcgSHeQ+5CUBmmbk2Ss7VPNMW989ogZCuWJCrAH3r8rra/N/EfzKDMHmNvl01rWeKIPDs/G
        AUZE13cTW2ZXPi4bXIcmIMA==
X-Received: by 2002:a17:906:6442:: with SMTP id l2mr63973640ejn.383.1594475218082;
        Sat, 11 Jul 2020 06:46:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcDIT5JUOvQ8Y96Gig/aI8F/ZHtJpqKvkvPxprUQyKyKFjT1eV0H1cE4/1/UPdyq8qGvVKjA==
X-Received: by 2002:a17:906:6442:: with SMTP id l2mr63973627ejn.383.1594475217866;
        Sat, 11 Jul 2020 06:46:57 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id y24sm5521015ejj.97.2020.07.11.06.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2020 06:46:57 -0700 (PDT)
Subject: Re: [PATCH v4 00/15] acpi/pwm/i915: Convert pwm-crc and i915 driver's
 PWM code to use the atomic PWM API
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20200708211432.28612-1-hdegoede@redhat.com>
 <20200709141407.GA226971@ravnborg.org>
 <fb370663-9efe-a820-2e57-d43d3af7828c@redhat.com>
 <20200711061901.njwx3xofo4awcflg@pengutronix.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d9079987-1c98-7542-8900-b2cc7b17446f@redhat.com>
Date:   Sat, 11 Jul 2020 15:46:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200711061901.njwx3xofo4awcflg@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 7/11/20 8:19 AM, Uwe Kleine-König wrote:
> Hi Hans,
> 
> On Thu, Jul 09, 2020 at 04:40:56PM +0200, Hans de Goede wrote:
>> On 7/9/20 4:14 PM, Sam Ravnborg wrote:
>>> On Wed, Jul 08, 2020 at 11:14:16PM +0200, Hans de Goede wrote:
>>>> Here is v4 of my patch series converting the i915 driver's code for
>>>> controlling the panel's backlight with an external PWM controller to
>>>> use the atomic PWM API. See below for the changelog.
>>>
>>> Why is it that i915 cannot use the pwm_bl driver for backlight?
>>> I have not studied the code - just wondering.
>>
>> The intel_panel.c code deals with 7 different types of PWM controllers
>> which are built into the GPU + support for external PWM controllers
>> through the kernel's PWM subsystem.
>>
>> pwm_bl will work for the external PWM controller case, but not for
>> the others. On top of that the intel_panel code integrates which
>> the video BIOS, getting things like frequency, minimum value
>> and if the range is inverted (0% duty == backlight brightness max).
>> I'm not even sure if pwm_bl supports all of this, but even if it
>> does the intel_panel code handles this in a unified manner for
>> all supported PWM controllers, including the ones which are
>> an integral part of the GPU.
> 
> pwm_bl handles inverted PWM just fine. I'm unsure what "integrates which
> the video BIOS" means,

Integrating with the video BIOS means reading the VBT (Video BIOS Tables)
and extracting info about which PWM controller to use, what frequency
to program the output at, minimum allowed duty-cycle and if the scale
is inverted.

> but I don't see how "handling 7 different types
> of PWM controllers explicitly and others using the PWM API" can be seen
> as "unified manner" compared to "provide a pwm driver for whatever might
> be in the GPU and then use generic code (PWM API, pwm_bl) to drive it".

Part of this is historical, the main x86 GPU drivers have always treated
backlight control as integral part of the display pipeline and in some
cases it really is, e.g. for eDP panels in some cases the backlight
is controlled through the DP aux channel, there is no PWM controller
(visible to the kernel involved). So the intel_panel.c code really
is a backlight-control de-multiplexer, picking the right "plugin"
to control the backlight, which may also be the eDP backlight control
code. Using a PWM controller supported by the PWM-core/class is just
one of the many supported "plugins".

Also the GPU currently is treated as a single device, not as a MFD
device, so we cannot have an isolated PWM driver. We could have code
inside the GPU driver which exports a PWM-controller to the PWM-core,
to then get a reference to the exported PWM-controller but that would
be very roundabout.

The devices which are using an external PWM controller are actually
the exception here, 99.9% of all devices use the GPU integrated PWM
controller.

Anyways changing over the other PWM-like controllers support by
the intel-panel code falls way outside of the scope of this
patch-set.

Regards,

Hans

