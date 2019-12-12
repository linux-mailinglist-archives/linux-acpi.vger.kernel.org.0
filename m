Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1149211CFE8
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Dec 2019 15:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbfLLOek (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Dec 2019 09:34:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56105 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729716AbfLLOek (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Dec 2019 09:34:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576161279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8L0wh57USWeg4kwDbaH2LaCzisTmsJPLc/9WAOqxji8=;
        b=OguXM/3J8LGWIicHGD40uEHW5+9RlEj7anvHDGN5dszY5qvpRfCTf4DVdyWZ6JLmG4maxY
        s50+p22i/xY/WilnnIePcY+kiEpfMA7dRKTrSP4AAmwlNwz5OwHiQdiFYNmYYuneT90qPg
        BLwyjtAOrCrTHOmQ3R5tFDh7cuRmyQM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-_TOoGmWNNUeJJAgIxpXNwQ-1; Thu, 12 Dec 2019 09:34:37 -0500
X-MC-Unique: _TOoGmWNNUeJJAgIxpXNwQ-1
Received: by mail-wm1-f72.google.com with SMTP id l11so1734024wmi.0
        for <linux-acpi@vger.kernel.org>; Thu, 12 Dec 2019 06:34:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8L0wh57USWeg4kwDbaH2LaCzisTmsJPLc/9WAOqxji8=;
        b=P7BDDpM5tSPujgr20VTbpkKDTQ/9TECdZRuU1sMJZ3wZ1mzfnB19SZBLlWzmhe47g4
         ZjkE/LRQP9u+RC61iiW6sx8p3jH5u5tegyAH/PekzmNu26JyaITjlB6yP3oEp+a7LkYc
         vUyHCMfaiELta8SxNoiiVnBUESLE57yG7K+voRE4T8DGKTtqhKFXj00WKJcC3+9rP0rD
         g54xeOJBatWBtYjmFuMuAmt99Pzu0VsEa4M9MSnv6a7Db+yxBDDV7zMEM+aBuG63MnRt
         /UqExXzX+Sf9w9xuluOV/MAS3G0meND087IAWnyI/zKuICEZyquNaFMtpVKNdy968c02
         q+nA==
X-Gm-Message-State: APjAAAUpRjGCL0adMnerETdith15dPt7rveGbFVcSUVTqv6WleAxQXpY
        lV8nLAXtUZeUEDy/zCgXW0GX8jv9k75vknERhZHY3s2ufi62V3Vv3cKl6AqYtkX6REH7MH8EaOL
        NxLxn6yWzPaA84Qoxvgf0dw==
X-Received: by 2002:a1c:a9c6:: with SMTP id s189mr7132905wme.151.1576161276518;
        Thu, 12 Dec 2019 06:34:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqwkMCbj3Al3W02aKWsSaIJItyyUbz24oMkL+40mFm8mAw2FfNeYRrpFtQxw5vg9q9Dyq+2PYg==
X-Received: by 2002:a1c:a9c6:: with SMTP id s189mr7132870wme.151.1576161276268;
        Thu, 12 Dec 2019 06:34:36 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id y20sm6009145wmi.25.2019.12.12.06.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 06:34:35 -0800 (PST)
Subject: Re: [PATCH 2/3] mfd: intel_soc_pmic: Rename pwm_backlight pwm-lookup
 to pwm_pmic_backlight
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20191119151818.67531-1-hdegoede@redhat.com>
 <20191119151818.67531-3-hdegoede@redhat.com> <20191210085111.GQ3468@dell>
 <a05e5a2b-568e-2b0d-0293-aa937c590a74@redhat.com>
 <20191212084546.GA3468@dell>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d22e9a04-da09-0f41-a78e-ac17a947650a@redhat.com>
Date:   Thu, 12 Dec 2019 15:34:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212084546.GA3468@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 12-12-2019 09:45, Lee Jones wrote:
> On Wed, 11 Dec 2019, Hans de Goede wrote:
> 
>> Hi Lee,
>>
>> On 10-12-2019 09:51, Lee Jones wrote:
>>> On Tue, 19 Nov 2019, Hans de Goede wrote:
>>>
>>>> At least Bay Trail (BYT) and Cherry Trail (CHT) devices can use 1 of 2
>>>> different PWM controllers for controlling the LCD's backlight brightness.
>>>>
>>>> Either the one integrated into the PMIC or the one integrated into the
>>>> SoC (the 1st LPSS PWM controller).
>>>>
>>>> So far in the LPSS code on BYT we have skipped registering the LPSS PWM
>>>> controller "pwm_backlight" lookup entry when a Crystal Cove PMIC is
>>>> present, assuming that in this case the PMIC PWM controller will be used.
>>>>
>>>> On CHT we have been relying on only 1 of the 2 PWM controllers being
>>>> enabled in the DSDT at the same time; and always registered the lookup.
>>>>
>>>> So far this has been working, but the correct way to determine which PWM
>>>> controller needs to be used is by checking a bit in the VBT table and
>>>> recently I've learned about 2 different BYT devices:
>>>> Point of View MOBII TAB-P800W
>>>> Acer Switch 10 SW5-012
>>>>
>>>> Which use a Crystal Cove PMIC, yet the LCD is connected to the SoC/LPSS
>>>> PWM controller (and the VBT correctly indicates this), so here our old
>>>> heuristics fail.
>>>>
>>>> Since only the i915 driver has access to the VBT, this commit renames
>>>> the "pwm_backlight" lookup entries for the Crystal Cove PMIC's PWM
>>>> controller to "pwm_pmic_backlight" so that the i915 driver can do a
>>>> pwm_get() for the right controller depending on the VBT bit, instead of
>>>> the i915 driver relying on a "pwm_backlight" lookup getting registered
>>>> which magically points to the right controller.
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>>    drivers/mfd/intel_soc_pmic_core.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> For my own reference:
>>>     Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
>>
>> As mentioned in the cover-letter, to avoid breaking bi-sectability
>> as well as to avoid breaking the intel-gfx CI we need to merge this series
>> in one go through one tree. Specifically through the drm-intel tree.
>> Is that ok with you ?
>>
>> If this is ok with you, then you do not have to do anything, I will just push
>> the entire series to drm-intel. drivers/mfd/intel_soc_pmic_core.c
>> does not see much changes so I do not expect this to lead to any conflicts.
> 
> It's fine, so long as a minimal immutable pull-request is provided.
> Whether it's pulled or not will depend on a number of factors, but it
> needs to be an option.

The way the drm subsys works that is not really a readily available
option. The struct definition which this patch changes a single line in
has not been touched since 2015-06-26 so I really doubt we will get a
conflict from this.

Regards,

Hans

