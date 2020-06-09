Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06ADA1F3CFE
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jun 2020 15:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgFINpe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Jun 2020 09:45:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31810 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgFINpd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Jun 2020 09:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591710331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fvpsAccmwpkGhYKxsT7pHl6ms2pXYRlDnYwLyHWCq1I=;
        b=bIQdoR7D43VhxZ7+rHH9ocBEjGr5IctczyWhwCx/hdRAuPGoaE3LBkE7E9I4fzI8JhDI45
        o+MhTT6o1d3NNNSkvCzV8TnwqwmMKSDdXJOPLaWmsch2DOTbde0iW94GzpP6pyZ7vIibkh
        VY7Hehl4Gvh4lsXEXU3LXsReRj70Xa4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-I3jEpnGoOeWqv_JNy6ltKg-1; Tue, 09 Jun 2020 09:45:28 -0400
X-MC-Unique: I3jEpnGoOeWqv_JNy6ltKg-1
Received: by mail-ed1-f70.google.com with SMTP id y4so8207555edo.16
        for <linux-acpi@vger.kernel.org>; Tue, 09 Jun 2020 06:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fvpsAccmwpkGhYKxsT7pHl6ms2pXYRlDnYwLyHWCq1I=;
        b=p80zPiQN62oXC48Rrik6ZS3DYamF4Ja1IaKWAKmHBsA+eZStNRkvVpNCgsWnGZZgd+
         sSj566ev55BpJaN5t8gECX5kXVRTOVRQgtO8z+Kf38bniHdkXNKCsuiLRk4ehHuYkZ0x
         t8YFhzNiXPj2a2DcN8g1XsfOaycLTLVbR4BvidEiTjiH7XtyDAZRbb6p8s5nsiuFHO4C
         kmD2BjZ7kGLR4hdqVovS/BtbF/3mG9a7g0iD/o6+tWtUODIKrr32EskDuNI/NYK+UHsD
         zwvAtgFRASBMSZyZf8nn5WqjlLfpItUlvS8OZGr+M3fD7xVPWxubEQOZ+O0RO1KMdfP3
         ZEGw==
X-Gm-Message-State: AOAM532xQVT9D2FaaOlQyzj4sJuYvvkTNj05jPqfWYnEQXxLjv1wCbWf
        AOGHtkdSICy+UcpE6DDj4lHU+4XUxLBusJynaNC79VsBcl+V/EYbKC9uH/JfsDu8vSjQgCI+RZu
        iTtdQJdQ5RxPWdp1lLRKFpg==
X-Received: by 2002:a17:906:344c:: with SMTP id d12mr23943645ejb.130.1591710326726;
        Tue, 09 Jun 2020 06:45:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxunOyD5XPkDfbblW74CXvBtjgUGkZRw2EP+zRYxbRvuH44U47dy20JU3ob/DBn+LIrrsRQOQ==
X-Received: by 2002:a17:906:344c:: with SMTP id d12mr23943614ejb.130.1591710326418;
        Tue, 09 Jun 2020 06:45:26 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id rp21sm13345743ejb.97.2020.06.09.06.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 06:45:25 -0700 (PDT)
Subject: Re: [PATCH v2 06/15] pwm: crc: Fix period / duty_cycle times being
 off by a factor of 256
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
References: <20200607181840.13536-1-hdegoede@redhat.com>
 <20200607181840.13536-7-hdegoede@redhat.com>
 <20200609112905.GK2428291@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fd839acc-9e25-14aa-d1ac-dbc262c7860e@redhat.com>
Date:   Tue, 9 Jun 2020 15:45:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609112905.GK2428291@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/9/20 1:29 PM, Andy Shevchenko wrote:
> On Sun, Jun 07, 2020 at 08:18:31PM +0200, Hans de Goede wrote:
>> While looking into adding atomic-pwm support to the pwm-crc driver I
>> noticed something odd, there is a PWM_BASE_CLK define of 6 MHz and
>> there is a clock-divider which divides this with a value between 1-128,
>> and there are 256 duty-cycle steps.
>>
>> The pwm-crc code before this commit assumed that a clock-divider
>> setting of 1 means that the PWM output is running at 6 MHZ, if that
>> is true, where do these 256 duty-cycle steps come from?
>>
>> This would require an internal frequency of 256 * 6 MHz = 1.5 GHz, that
>> seems unlikely for a PMIC which is using a silicon process optimized for
>> power-switching transistors. It is way more likely that there is an 8
>> bit counter for the duty cycle which acts as an extra fixed divider
>> wrt the PWM output frequency.
>>
>> The main user of the pwm-crc driver is the i915 GPU driver which uses it
>> for backlight control. Lets compare the PWM register values set by the
>> video-BIOS (the GOP), assuming the extra fixed divider is present versus
>> the PWM frequency specified in the Video-BIOS-Tables:
>>
>> Device:		PWM Hz set by BIOS	PWM Hz specified in VBT
>> Asus T100TA 	200			200
>> Asus T100HA 	200			200
>> Lenovo Miix 2 8	23437			20000
>> Toshiba WT8-A	23437			20000
>>
>> So as we can see if we assume the extra division by 256 then the register
>> values set by the GOP are an exact match for the VBT values, where as
>> otherwise the values would be of by a factor of 256.
>>
>> This commit fixes the period / duty_cycle calculations to take the
>> extra division by 256 into account.
> 
> ...
> 
>> +#define NSEC_PER_MHZ		1000
> 
> This is against physics. What this cryptic name means actually?
> Existing NSEC_PER_USEC ?

Yes, using existing NSEC_PER_USEC is better I will use that for the
next version.

Regards,

Hans

