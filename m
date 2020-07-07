Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D72E217819
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jul 2020 21:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgGGTln (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Jul 2020 15:41:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35257 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726763AbgGGTlm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Jul 2020 15:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594150902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u6LSVtn4v8gZHllzz2UNn3EgKUqKY14zb/jR9VXFi0I=;
        b=EVPVbcjF6CoYoWrVoxnKypJWHAqV6R6JP5dOz/LpLYzxE6sNdOBO6YsscpZyxCiCTRFI1R
        X6nB2EfruQ52crWeUH8QVGq/yKQXZcts+pHDsoWLFOQ+8gpMtT6SftwaJvhuJQ5rGG7KR5
        l6dtf17pOOgSECl6d29i9lor9K5TQyc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-kI_DahfsObmc2NjNP1tqEA-1; Tue, 07 Jul 2020 15:41:38 -0400
X-MC-Unique: kI_DahfsObmc2NjNP1tqEA-1
Received: by mail-ed1-f72.google.com with SMTP id y66so48243132ede.19
        for <linux-acpi@vger.kernel.org>; Tue, 07 Jul 2020 12:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u6LSVtn4v8gZHllzz2UNn3EgKUqKY14zb/jR9VXFi0I=;
        b=H8KJ05eXmHzfFYOb4cSrS10AUa2Hr08LfmeW8CI2sxS0KKEXNGeAVTTrjMqW48ErqA
         cxuvow9gKsScWViyMw0Bty+eq3kLzV9Oa4qT2y+68yX63xLLOJXMRJBY1x6ARU5gqR+T
         ODJ5HIDC6GzHHbVYDJ248uSpPpvkw87s38hlg61b9i0Qrzd8bX7OgTeuqJU873C6OhYB
         gNQFgc6n/HCpYpiNgWLcA9rAveXAQj6j3DvDDyhUEEzcXpLc0/iMYMDOwRXe8QgP/qHz
         b6PWwK9Vnbj+ZTGJB8kzQf6MinWJNOX6N2tSbPNSGREsCC3bE0W1420jGH2bwfbG6JYL
         a66Q==
X-Gm-Message-State: AOAM5327fnB5SWVzSbAAld4qLy9p3aJwt9Q6Eri337S6K9VXd7lOjpff
        9S0NpCS7IiwLiumlx2YnRoQbZZfjwLyNQ2kFW6MxB1QrHTgCXEvCGp25NGsmiJOHVqdAw8sSdFU
        F9fx2qzCgwXiHinmqbYX/zw==
X-Received: by 2002:a17:906:410a:: with SMTP id j10mr37321715ejk.201.1594150897295;
        Tue, 07 Jul 2020 12:41:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXnVXEx7nXmWizq3WBrz1vcGCOHcpBwHufxNZFJvl6CfoS1RtIACGSwq90uZ4QNzldiNsZ3g==
X-Received: by 2002:a17:906:410a:: with SMTP id j10mr37321708ejk.201.1594150897067;
        Tue, 07 Jul 2020 12:41:37 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id d16sm787486ejo.31.2020.07.07.12.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 12:41:36 -0700 (PDT)
Subject: Re: [PATCH v3 04/15] pwm: lpss: Add range limit check for the
 base_unit register value
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, kernel@pengutronix.de
References: <20200620121758.14836-1-hdegoede@redhat.com>
 <20200620121758.14836-5-hdegoede@redhat.com>
 <20200622073554.wf3smq3tvnr6t2xy@taurus.defre.kleine-koenig.org>
 <e07a7dd6-c361-32b8-c4e7-91e022f9c21d@redhat.com>
 <20200707073424.w6vd6e4bhl56kosd@pengutronix.de>
 <1496178b-ce39-9285-ff75-cd39bc0e9aa7@redhat.com>
 <20200707190955.e7wzmphdgi5reeyg@pengutronix.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0e79b176-7e58-7ecb-0f82-ebfd0c777af3@redhat.com>
Date:   Tue, 7 Jul 2020 21:41:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707190955.e7wzmphdgi5reeyg@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 7/7/20 9:09 PM, Uwe Kleine-König wrote:
> Hello Hans,
> 
> On Tue, Jul 07, 2020 at 07:31:29PM +0200, Hans de Goede wrote:
>> On 7/7/20 9:34 AM, Uwe Kleine-König wrote:
>>> On Mon, Jul 06, 2020 at 10:53:08PM +0200, Hans de Goede wrote:
>>>> But if we do then I think closest to the truth would be:
>>>>
>>>> state->period     = UINT_MAX;
>>>> state->duty_cycle = 0;
>>>
>>> I'd say state->period = 1 & state->duty_cycle = 0 is a better
>>> representation.
>>
>> But that would suggest the output is configured for an
>> infinitely high output frequency, but the frequency is
>> actually 0, the reason why get_state needs to treat a
>> base_unit val of 0 special at all is to avoid a division
>> by 0, and in math dividing by 0 gives infinite, isn't
>> UINT_MAX a better way to represent infinity ?
> 
> Given that duty_cycle is 0, how can to tell anything about the period
> when only seeing the signal (= a constant low)?
> 
> Given that (ideally) a period is completed when pwm_apply_state() is
> called, a short period is much more sensible.

Ok, I will add a patch to v4 of the patch-set to adjust the pwm-lpss
driver's get_state method accordingly.

Regards,

Hans

