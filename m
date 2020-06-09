Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F3C1F3CF4
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jun 2020 15:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgFINoZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Jun 2020 09:44:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44940 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726803AbgFINoY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Jun 2020 09:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591710262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ciM2j9nevs9rj7f3kAoWqHnY0nARQeatB2ntlMR/UQk=;
        b=OcnNoqIzeLLbl4kL5KfiQkPLu65hqWlRhRaoT5YcRDlzmTaKZbA6B0oTRYqaFDi0SJuw+p
        WM9rMb/NIJLFSSORoJ3JHDGCN0oN6XCKNvE84+wQhPQuJ3PTK/ZYkk0/EXy254Zph3w+T7
        gNnrbOV2K5/aqYRT4tLQaYQ1e/WkEwo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-dD0WI53qOReeFEvxskPyBA-1; Tue, 09 Jun 2020 09:44:21 -0400
X-MC-Unique: dD0WI53qOReeFEvxskPyBA-1
Received: by mail-ed1-f69.google.com with SMTP id x3so7941516eds.14
        for <linux-acpi@vger.kernel.org>; Tue, 09 Jun 2020 06:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ciM2j9nevs9rj7f3kAoWqHnY0nARQeatB2ntlMR/UQk=;
        b=TzD/WEWPbdFlq6cE+9zKTZkAsp+GqMtcezFhriyjDMb5qvr563+J2bk6ciwam/g3sf
         +nLXI+5/EZC3dDH8jomdMAaoE1ehFHzYtb2KO3DcIfuk7tS6mq4a38EcrLr7yK46956E
         QaRUx6fWoD1ejdVsXMpyrtwKtS6iJxq3ugCRBRG1dlhSPxBb103lL9tR9yu1rcDzcCYq
         BIq2/qkMA9RatMLlcohjRiljkIZZqXOt0zlm7IqT2SXdMqQBLPm2shP9n5MozejrUSO+
         uM7GWUbPmx8CUQL347wPJC5BL35B3kCT6c2BurEwwvbc1OLqLFw5/XjLjnFVVCbx9vOh
         TgwQ==
X-Gm-Message-State: AOAM530j8gRkzVqVRTTno6F0ZrbbeEuqyQo1Y8BCGYQzjfblA2n07TzP
        nlHFN9E29V8/7P3mwyrTPjK1KPyWZcn+Q0aFAekX9V5ZOnsWl4fCZ9spUp5tLlrSQdJd/uP5iT/
        g7pl1YDn2kwsBSa8fXIfqFQ==
X-Received: by 2002:a17:906:aec5:: with SMTP id me5mr26966105ejb.54.1591710259647;
        Tue, 09 Jun 2020 06:44:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKA4dtsW1lefAvu07pIsZYL8eurJ7KGixlwM3PoADUunSCQ5qYiEPYeJz/bkLkGnOdTBQrmg==
X-Received: by 2002:a17:906:aec5:: with SMTP id me5mr26966096ejb.54.1591710259476;
        Tue, 09 Jun 2020 06:44:19 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id gj10sm13143604ejb.61.2020.06.09.06.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 06:44:18 -0700 (PDT)
Subject: Re: [PATCH v2 10/15] pwm: crc: Implement apply() method to support
 the new atomic PWM API
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
 <20200607181840.13536-11-hdegoede@redhat.com>
 <20200609113220.GM2428291@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <93c7843d-1225-c8c6-9eb7-1f11b44bec34@redhat.com>
Date:   Tue, 9 Jun 2020 15:44:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609113220.GM2428291@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/9/20 1:32 PM, Andy Shevchenko wrote:
> On Sun, Jun 07, 2020 at 08:18:35PM +0200, Hans de Goede wrote:
>> Replace the enable, disable and config pwm_ops with an apply op,
>> to support the new atomic PWM API.
> 
> ...
> 
>> -static int crc_pwm_calc_clk_div(int period_ns)
>> +static int crc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			 const struct pwm_state *state)
>>   {
>> -	int clk_div;
>> -
>> -	clk_div = PWM_BASE_CLK_MHZ * period_ns / (256 * NSEC_PER_MHZ);
>> -	/* clk_div 1 - 128, maps to register values 0-127 */
>> -	if (clk_div > 0)
>> -		clk_div--;
>> -
>> -	return clk_div;
>> -}
> 
> ...
> 
>> +		clk_div = PWM_BASE_CLK_MHZ * state->period /
>> +			  (256 * NSEC_PER_MHZ);
>> +		/* clk_div 1 - 128, maps to register values 0-127 */
>> +		if (clk_div > 0)
>> +			clk_div--;
> 
> And again... :-(

Well yes I cannot help it that the original code, as submitted by Intel,
was of very questionable quality, so instead of just converting it to the
atomic PWM API I had to do a ton of bugfixes first...   I tried to do
this all in small bits rather then in a single big rewrite the buggy
<beep> commit to make life easier for reviewers.

I can introduce the crc_pwm_calc_clk_div helper earlier as you suggested
in an earlier mail. I guess I could also keep the helper here, and then
fold it into the function in a later commit (*).

Would that work for you ?

Regards,

Hans



*) Because having a helper for 3 lines of code when it is used only
once is not helpful IMHO, it only makes it harder to figure out what
the code is exactly doing when readin the code.

