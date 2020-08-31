Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C35257877
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Aug 2020 13:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgHaL34 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 31 Aug 2020 07:29:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56405 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727843AbgHaL1C (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 31 Aug 2020 07:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598873212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fuaQ/Ta0zfzTBJPiJYMWIV501bVUz4gD20AOCLXdBj0=;
        b=Uu/sa48ayy6yb8hQKHrUsqZunooNNnkBslDGAyLZS50KHFlVfkAllbIlftt0HZbDGRkH/G
        vVzeeEjcMmC7yW4vda6IrdjtRIFYPqgVDEqf9xdJ8NNBBYCwtG0xh7X4bI4kiPud4i8oqr
        bdH5cEEeXdp/UWcgSkDX/IggJ4TOoKI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-w8aNZhecPPa-GvfHw5GeVw-1; Mon, 31 Aug 2020 07:26:50 -0400
X-MC-Unique: w8aNZhecPPa-GvfHw5GeVw-1
Received: by mail-ej1-f72.google.com with SMTP id i3so374891ejh.5
        for <linux-acpi@vger.kernel.org>; Mon, 31 Aug 2020 04:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fuaQ/Ta0zfzTBJPiJYMWIV501bVUz4gD20AOCLXdBj0=;
        b=o+RH0u7seW8QD71wt1FctkN2wvDChNjqCyREIuFsbvghMJLTXp5ysPLzAwTMsg7b8F
         l4bTzF5MnPYTFxiIXFI4/kgH8YhkQyK0EEo7KG9EZFbistzo/r/ZAA4kGRHgfInhkoh8
         zyb8Tn+R5E7Fc7z3qi1oGcUGcPD3xfAN6Ulzn1d/aiqlU8wrAsldwwl9QoqYEeHlGYz4
         ZF1IuSmdtfr+HStLksJioQW3yf9/vJMdRxok6TlCdBoSYemg4Dti2IQmMHJh6yY6Eh+u
         DDtqVql8J/dmae3IM2a0jj7Q/lTyBxM1fUBaG9VarAIrPqlT8xDSLfzOXmQNCoypV3Lw
         X4kg==
X-Gm-Message-State: AOAM533qCuUhLIDQCSTTBW5nVfvA29KlclCGBQMd48MXigWi9fgiRtKb
        azoIse+8fSt/5WpO+PIlFKts7u3rGoLOfzXx3wxq67JsddzfMgCmlJcb9wy+CXrcIeRTSYPt1TF
        E4VWbZeUPw34dbOmbVw3+mg==
X-Received: by 2002:a17:906:2d42:: with SMTP id e2mr690599eji.10.1598873208249;
        Mon, 31 Aug 2020 04:26:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeUuotkoeQnDKZksUQtCZDpV8lwHMl9QZwPIJyS7ooX1/0k7MtmpbRvZI8kZetJIA+SyDyYw==
X-Received: by 2002:a17:906:2d42:: with SMTP id e2mr690574eji.10.1598873208015;
        Mon, 31 Aug 2020 04:26:48 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id jx22sm7877046ejb.36.2020.08.31.04.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 04:26:47 -0700 (PDT)
Subject: Re: [PATCH v8 07/17] pwm: lpss: Always update state and set update
 bit
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
References: <20200830125753.230420-1-hdegoede@redhat.com>
 <20200830125753.230420-8-hdegoede@redhat.com> <20200831111334.GE1688464@ulmo>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ac7375d0-f59b-cc9e-576a-91969d0d7cfb@redhat.com>
Date:   Mon, 31 Aug 2020 13:26:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200831111334.GE1688464@ulmo>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 8/31/20 1:13 PM, Thierry Reding wrote:
> On Sun, Aug 30, 2020 at 02:57:43PM +0200, Hans de Goede wrote:
>> This commit removes a check where we would skip writing the ctrl register
>> and then setting the update bit in case the ctrl register already contains
>> the correct values.
>>
>> In a perfect world skipping the update should be fine in these cases, but
>> on Cherry Trail devices the AML code in the GFX0 devices' PS0 and PS3
>> methods messes with the PWM controller.
>>
>> The "ACPI / LPSS: Resume Cherry Trail PWM controller in no-irq phase" patch
>> earlier in this series stops the GFX0._PS0 method from messing with the PWM
>> controller and on the DSDT-s inspected sofar the _PS3 method only reads
>> from the PWM controller (and turns it off before we get a change to do so):
>>
>>      {
>>          PWMB = PWMC /* \_SB_.PCI0.GFX0.PWMC */
>>          PSAT |= 0x03
>>          Local0 = PSAT /* \_SB_.PCI0.GFX0.PSAT */
>>      }
>>
>> The PWM controller getting turning off before we do this ourselves is
>> a bit annoying but not really an issue.
>>
>> The problem this patch fixes comes from a new variant of the GFX0._PS3 code
>> messing with the PWM controller found on the Acer One 10 S1003 (1):
>>
>>      {
>>          PWMB = PWMC /* \_SB_.PCI0.GFX0.PWMC */
>>          PWMT = PWMC /* \_SB_.PCI0.GFX0.PWMC */
>>          PWMT &= 0xFF0000FF
>>          PWMT |= 0xC0000000
>>          PWMC = PWMT /* \_SB_.PCI0.GFX0.PWMT */
>>          PWMT = PWMC /* \_SB_.PCI0.GFX0.PWMC */
>>          Sleep (0x64)
>>          PWMB &= 0x3FFFFFFF
>>          PWMC = PWMB /* \_SB_.PCI0.GFX0.PWMB */
>>          PSAT |= 0x03
>>          Local0 = PSAT /* \_SB_.PCI0.GFX0.PSAT */
>>      }
>>
>> This "beautiful" piece of code clears the base-unit part of the ctrl-reg,
>> which effectively disables the controller, and it sets the update flag
>> to apply this change. Then after this it restores the original ctrl-reg
>> value, so we do not see it has mucked with the controller.
>>
>> *But* it does not set the update flag when restoring the original value.
>> So the check to see if we can skip writing the ctrl register succeeds
>> but since the update flag was not set, the old base-unit value of 0 is
>> still in use and the PWM controller is effectively disabled.
>>
>> IOW this PWM controller poking means that we cannot trust the base-unit /
>> on-time-div value we read back from the PWM controller since it may not
>> have been applied/committed. Thus we must always update the ctrl-register
>> and set the update bit.
> 
> Doesn't this now make patch 6/17 obsolete?

No, there is no guarantee we will get any changes soon after resume,
so we must restore the state properly on resume, before 5.17
we were just blindly restoring the old ctrl reg state, but
if either the freq-div or the duty-cycle changes, we should
also set the update bit in that case to apply the new freq-div/
duty-cycle.

This actually also helps with that case since patch 6/17 uses
pwm_lpss_prepare and this makes pwm_lpss_prepare set the
update but unconditionally.

Also on resume we most do the set the enable bit vs set
the update bit in the right order, depending on the
generation of the SoC in which the PWM controller is
embedded. 6/17 fixes all this by resume, by treating
resume as a special case of apply() taking all the
steps apply does.

Regards,

Hans


