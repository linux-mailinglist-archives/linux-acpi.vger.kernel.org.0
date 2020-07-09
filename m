Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DC621A250
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jul 2020 16:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgGIOlR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Jul 2020 10:41:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28443 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727092AbgGIOlR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Jul 2020 10:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594305675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xtGo37WFcbzrM1ZvQh+IMQbh1Z4M0Wk13pfOcRFcm88=;
        b=Lirb8rDVcKNobS4w4IbFl6IOfhOSIuhZrrnws97gUaVwrDc0DjuRsxtS7bQWofSIZ4gltk
        v3D+HA3ELocn3+mMvjZuCnfDwmUhfMLShMdiqmM1AQt+MqxiqfJ8tWY33aP0YD1Zra+buc
        UpR82zONPfdfmiUOjl6lOvUJct46lAE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-q3MHViCTPYWIaPnal0TCag-1; Thu, 09 Jul 2020 10:41:01 -0400
X-MC-Unique: q3MHViCTPYWIaPnal0TCag-1
Received: by mail-wm1-f69.google.com with SMTP id g6so2347902wmk.4
        for <linux-acpi@vger.kernel.org>; Thu, 09 Jul 2020 07:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xtGo37WFcbzrM1ZvQh+IMQbh1Z4M0Wk13pfOcRFcm88=;
        b=ZxMW8EYjBE/kE0YIOeftbt4YYJFcA1+JbHP4TFOP4xWc9XqmuFFmmm3kmG7oEVm40L
         uaSuPURYHmhcNbmdOYd2LKoUSiZ25AIK/PxEESaOkvmfCblAKkqTwel5gYaNc0+oCiSp
         ZgpWFAJcX1v/5WnCd204smYFV+DpbsJ2lJw+Oh4NobfSiZuhWYe3hI7iA/VD2OGwfLrU
         XFFD5Mnci3LSYmmFep8Pb0oaDqVvRsZ+8ZnQx6aSKjCKH02kt6nqMPWlKomWuLbhED/p
         UH7Je0rT5GJMF9T5gnWo4nv8HTcqltH5AE/X+rUPEpYXKmMnU3xJimi+eQ6nsapgqeXe
         LyJQ==
X-Gm-Message-State: AOAM532E6U7LVFbf/BE5/vATKZccSXy1DTIkCrXPV7P8LoUPlyRF1EU2
        G+v8dUgUoDkJVgWwlwEpVy1bmvawOStt7Fb4ArIJqb6tYON7awR+prmqM/4VUgCC44xamkdQptY
        uTUETbzSHFD9Zku3khqthSg==
X-Received: by 2002:adf:82a1:: with SMTP id 30mr68204935wrc.210.1594305659640;
        Thu, 09 Jul 2020 07:40:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyC8Qx1lqmqv5eBOWYGriOdRymqExqIMuGFeC+1LPMcpYaZ1AsqSB9SUbO9rPu7uEL1sgHSQQ==
X-Received: by 2002:adf:82a1:: with SMTP id 30mr68204858wrc.210.1594305658678;
        Thu, 09 Jul 2020 07:40:58 -0700 (PDT)
Received: from x1.localdomain ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id j6sm5217876wma.25.2020.07.09.07.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 07:40:57 -0700 (PDT)
Subject: Re: [PATCH v4 00/15] acpi/pwm/i915: Convert pwm-crc and i915 driver's
 PWM code to use the atomic PWM API
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fb370663-9efe-a820-2e57-d43d3af7828c@redhat.com>
Date:   Thu, 9 Jul 2020 16:40:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200709141407.GA226971@ravnborg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 7/9/20 4:14 PM, Sam Ravnborg wrote:
> Hi Hans.
> 
> On Wed, Jul 08, 2020 at 11:14:16PM +0200, Hans de Goede wrote:
>> Hi All,
>>
>> Here is v4 of my patch series converting the i915 driver's code for
>> controlling the panel's backlight with an external PWM controller to
>> use the atomic PWM API. See below for the changelog.
> 
> Why is it that i915 cannot use the pwm_bl driver for backlight?
> I have not studied the code - just wondering.

The intel_panel.c code deals with 7 different types of PWM controllers
which are built into the GPU + support for external PWM controllers
through the kernel's PWM subsystem.

pwm_bl will work for the external PWM controller case, but not for
the others. On top of that the intel_panel code integrates which
the video BIOS, getting things like frequency, minimum value
and if the range is inverted (0% duty == backlight brightness max).
I'm not even sure if pwm_bl supports all of this, but even if it
does the intel_panel code handles this in a unified manner for
all supported PWM controllers, including the ones which are
an integral part of the GPU.

Regards,

Hans



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
>> The involved acpi_lpss and pwm drivers do not see a whole lot of churn,
>> so the plan is to merge this all through drm-intel-next-queued (dinq)
>> once all the patches are reviewed / have acks.
>>
>> In v4 the ACPI patches have been Acked by Rafael and the i915 patches
>> have been acked by Jani. So that just leaves the PWM patches.
>>
>> Uwe can I get your ok / ack for merging this through the dinq branch
>> once you have acked al the PWM patches ?
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
>>
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
>> Changes in v4:
>> - "[PATCH v4 06/16] pwm: lpss: Correct get_state result for base_unit == 0"
>>    - This is a new patch in v4 of this patchset
>> - "[PATCH v4 12/16] pwm: crc: Implement get_state() method"
>>    - Use DIV_ROUND_UP when calculating the period and duty_cycle values
>> - "[PATCH v4 16/16] drm/i915: panel: Use atomic PWM API for devs with an external PWM controller"
>>    - Add a note to the commit message about the changes in pwm_disable_backlight()
>>    - Use the pwm_set/get_relative_duty_cycle() helpers
>>
>> Regards,
>>
>> Hans
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 

