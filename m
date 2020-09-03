Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA17725C00F
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Sep 2020 13:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgICLVn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Sep 2020 07:21:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30329 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728415AbgICLPh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Sep 2020 07:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599131701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=efREBgpIuAxc+bnBJ5R3S/pFsZS/Ey21En4F0jCEO9A=;
        b=DkTuQfrXIjNzJobZILFiPZlFO8O60VfZFVCgROtNwecTFcgUk4LniK/oiyu7yQS4fT7Byy
        6smTIMnOvUmwb+30ikT406egzOTQlU/GdD3hC/dZExusHccEhf5IBruFGD3XMPucBpYtwY
        X+sFopp9c95+dRWx0ybCxkq+dSOGjjk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-_vdtrHPiNIibqid-RCXg3Q-1; Thu, 03 Sep 2020 07:12:34 -0400
X-MC-Unique: _vdtrHPiNIibqid-RCXg3Q-1
Received: by mail-ed1-f71.google.com with SMTP id d13so1123281edz.18
        for <linux-acpi@vger.kernel.org>; Thu, 03 Sep 2020 04:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=efREBgpIuAxc+bnBJ5R3S/pFsZS/Ey21En4F0jCEO9A=;
        b=CGf179XWZWVs6G5ScwdMANdXlAfwW/O1ACE0261yeuawRQwR++bJujmECoGiGH/oOe
         5WV14hO9Bte3LFWklPjoq/yq+yMfQVEEpOkAQQ6AscWx0eM88RTWW3NNkBB1B43SEEs3
         q5B28aPwX9DnZz85gTAI5uIymyFZrdHXI7CI9SWvzpOj2Ql8mwV2mU6lFpk/i5ZhjojQ
         1k9ASaBKng02ZAsxQ/THVNIU1siSjuVd/aLZXV1xZc8EKwZChqFgpf6ipi9wADfboi3e
         hku1M7KXIZQff+bpiykt8VWclOwbZ92W5HDySwPyn0XmIyGv7HbE4O3PXvDXPxNLFB/d
         Q8nA==
X-Gm-Message-State: AOAM530nNN6fgVg/k6pfgU5H+WL94xS8iINMMfYGxLXiccfUssZYJiNM
        Nqed6esIG83iKpmp3Pmh36dbYOpmeT0L8DoCo8u+tSjp4QuBrZML/qvPlMepaFg/60ZkvHmJAxI
        HXwr0/eP1fHgarvBNd8qDBQ==
X-Received: by 2002:a17:906:c7da:: with SMTP id dc26mr1490813ejb.491.1599131553512;
        Thu, 03 Sep 2020 04:12:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwz45IHe95vEABByf1/DSG38NFHvqU3XHec96U37Ufe0eGhD/vOjFiqWQ2lkLsAJDGyIGIi4Q==
X-Received: by 2002:a17:906:c7da:: with SMTP id dc26mr1490775ejb.491.1599131553140;
        Thu, 03 Sep 2020 04:12:33 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id r16sm2909233ejb.110.2020.09.03.04.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 04:12:32 -0700 (PDT)
Subject: Re: [PATCH v9 06/17] pwm: lpss: Make pwm_lpss_apply() not rely on
 existing hardware state
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
References: <20200903105114.9969-1-hdegoede@redhat.com>
 <20200903105114.9969-7-hdegoede@redhat.com> <20200903105909.GA3756465@ulmo>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e342aee0-c7a6-62db-e4b7-9d72554fd55c@redhat.com>
Date:   Thu, 3 Sep 2020 13:12:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903105909.GA3756465@ulmo>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 9/3/20 12:59 PM, Thierry Reding wrote:
> On Thu, Sep 03, 2020 at 12:51:03PM +0200, Hans de Goede wrote:
>> Before this commit pwm_lpss_apply() was making 2 assuming
>> 2 pre-conditions were met by the existing hardware state:
> 
> I think that "making 2" is too much.

You're right at first the sentence had something about making
2 assumptions, then I added pre-conditions in there for it
to better describe the problem...

>> 1. That the base-unit and on-time-div read back from the
>> control register are those actually in use, so that it
>> can skip setting the update bit if the read-back value
>> matches the desired values.
>>
>> 2. That the controller is enabled when the cached
>> pwm_state.enabled says that the controller is enabled.
>>
>> As the long history of fixes for subtle (often suspend/resume)
>> lpss-pwm issues shows, this assumptions are not necessary
>> always true.
>>
>> 1. Specifically is not true on some (*) Cherry Trail devices
>> with a nasty GFX0._PS3 method which: a. saves the ctrl reg value.
>> b. sets the base-unit to 0 and writes the update bit to apply/commit
>> c. restores the original ctrl value without setting the update bit,
>> so that the 0 base-unit value is still in use.
>>
>> 2. Assumption 2. currently is true, but only because of the code which
>> saves/restores the state on suspend/resume. By convention restoring the
>> PWM state should be done by the PWM consumer and the presence of this
>> code in the pmw-lpss driver is a bug. Therefor the save/restore code will
>> be dropped in the next patch in this series, after which this assumption
>> also is no longer true.
>>
>> This commit changes the pwm_lpss_apply() to make any assumptions about the
> 
> Did you mean to say "... to _not_ make any assumptions ..."?

Yes, oops. That is a small but important difference.

I'll do a v10 with your 2 Acked-by's added and both commit msg issues fixed.

Hopefully that will be the last version.

>> state the hardware is in. Instead it makes pwm_lpss_apply() always fully
>> program the PWM controller, making it much less fragile.
>>
>> *) Seen on the Acer One 10 S1003, Lenovo Ideapad Miix 310 and 320 models
>> and various Medion models.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/pwm/pwm-lpss.c | 21 +++++++++------------
>>   1 file changed, 9 insertions(+), 12 deletions(-)
> 
> Other than the two small nits, this looks much more idiomatic and true
> to the atomic API, so:
> 
> Acked-by: Thierry Reding <thierry.reding@gmail.com>

Thank you.

Regards,

Hans

