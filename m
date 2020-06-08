Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070A01F1757
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Jun 2020 13:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbgFHLNK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Jun 2020 07:13:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56357 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729425AbgFHLNI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Jun 2020 07:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591614786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UhgJTWJr6h9G9PmHmPph9dyAvRbYjMyPRPIHK6pK8vc=;
        b=F3ud4RqtpYEnSlAIqACKsQMg5ASW2izchYkv3CVtcNWQjPqbBwzWS6S48od+Nz0ynkQkZw
        vtczwO1sQSSFygLoq249xhUIFJvxJJIYts2bNHyDNOOfsTUUO1BM+aV6rGyn+V+ZTawnll
        cc6kJwAOmosqAmI0dkufWoG5XAEU2zU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-IU1c1aYEPK-4H8pxg9WNfQ-1; Mon, 08 Jun 2020 07:13:05 -0400
X-MC-Unique: IU1c1aYEPK-4H8pxg9WNfQ-1
Received: by mail-wm1-f70.google.com with SMTP id 11so3819347wmj.6
        for <linux-acpi@vger.kernel.org>; Mon, 08 Jun 2020 04:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UhgJTWJr6h9G9PmHmPph9dyAvRbYjMyPRPIHK6pK8vc=;
        b=HrlI02gFK0HSD/a22bQ5FZJDC+ApmwIhJrMwecxzzMAU5ZPPBc8olhkIdUgxDK2v38
         0eFykIVHjRR2lXoGSy+CTN4OZTTarowbXBvE73mzyHCNL9s03MsTp89d//i8aJUkCe6e
         KNNVbQBqH9wpXUa/p+73CYU9N6cRTaHBoDQiSNKuoD5XegKvzXM+GYjxl2DnrdIwZuP4
         9g46vOBhVeQ5NN+Dh3e8vS7CZJJLzFDMN/MTDKFCoCyurMN6b8KAuUlsM/rvaQjnNvXZ
         u2KfjH1aIhje9FZ6JzlBVUkyjRFvMUcknjWrlLhiGKPNBsdPvV56kKRCfLwvF5Ru9NHl
         sfZw==
X-Gm-Message-State: AOAM533cr+1BOYRvUGn60j1s9EKDib3uF8AhwtvK5kX1yngC8wC7xSL2
        Tgg1zCfZ1KxVgah2oH4kXE6m7U55x+BYcFVdJTZYWZ2sbgCB1NYLBI3ZhhQAfaUwx/zsALuqTOn
        1+GPtuT8cKQ20vlMkX2jKtA==
X-Received: by 2002:a05:6000:10cf:: with SMTP id b15mr22474425wrx.214.1591614783674;
        Mon, 08 Jun 2020 04:13:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsVhaPysSkuHY7OnSe0IptFhwBN2fdZnKtM5beXPetYqOZNC7m8APlsFf+Xeln1lc8xR47Kg==
X-Received: by 2002:a05:6000:10cf:: with SMTP id b15mr22474396wrx.214.1591614783396;
        Mon, 08 Jun 2020 04:13:03 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id v19sm21737311wml.26.2020.06.08.04.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 04:13:02 -0700 (PDT)
Subject: Re: [PATCH v2 04/15] pwm: lpss: Fix off by one error in base_unit
 math in pwm_lpss_prepare()
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
 <20200607181840.13536-5-hdegoede@redhat.com>
 <20200608035512.GA2428291@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c8a8d466-9b4a-9021-ca74-01d315e99117@redhat.com>
Date:   Mon, 8 Jun 2020 13:13:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200608035512.GA2428291@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/8/20 5:55 AM, Andy Shevchenko wrote:
> On Sun, Jun 07, 2020 at 08:18:29PM +0200, Hans de Goede wrote:
>> According to the data-sheet the way the PWM controller works is that
>> each input clock-cycle the base_unit gets added to a N bit counter and
>> that counter overflowing determines the PWM output frequency.
>>
>> So assuming e.g. a 16 bit counter this means that if base_unit is set to 1,
>> after 65535 input clock-cycles the counter has been increased from 0 to
>> 65535 and it will overflow on the next cycle, so it will overflow after
>> every 65536 clock cycles and thus the calculations done in
>> pwm_lpss_prepare() should use 65536 and not 65535.
>>
>> This commit fixes this. Note this also aligns the calculations in
>> pwm_lpss_prepare() with those in pwm_lpss_get_state().
> 
> This one sounds like a bug which I have noticed on Broxton (but thought as a
> hardware issue). In any case it has to be tested on various platforms to see
> how it affects on them.

If you like at the datasheet / read my commit description then it
becomes obvious that because of the way the PWM controller works that
it takes the full 2^(base-unit-bits) for the counter to overflow,
not 2^(base-unit-bits) - 1. This will make a difference of a factor
65535/65536 in the output frequency which will be tricky to measure.

IOW I'm not sure we can really test if this helps, but it is
obviously the right thing to do and it aligns the pwm_apply code
with the pwm_get_state code which already does not have the - 1.

Regards,

Hans

