Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 167D51820B3
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Mar 2020 19:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbgCKSZG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Mar 2020 14:25:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24879 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730768AbgCKSZE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Mar 2020 14:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583951103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uaZ9c6mFKi33dS6s6gMieJUilQtBx6d2khI9AiP0fEw=;
        b=GnFp9Q6R9V9YUM8PpY6V3jh8tEs59S1e3DYKkTuGdiZK+If02pWGhhvsFXl6d7+/SgSOvY
        qhymuAFuDmPokuRqIMj4lebPUHEh/DBR8dqmdl0hBUq59UjBQ8W5Oc0eT4QM1NFgttI4SC
        QreM21i7cmShf3pUuqkKz6ttl5ORrJ0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-Z-SuiJWUOlOqNOtdZ_J18A-1; Wed, 11 Mar 2020 14:24:59 -0400
X-MC-Unique: Z-SuiJWUOlOqNOtdZ_J18A-1
Received: by mail-wm1-f72.google.com with SMTP id f207so1200216wme.6
        for <linux-acpi@vger.kernel.org>; Wed, 11 Mar 2020 11:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uaZ9c6mFKi33dS6s6gMieJUilQtBx6d2khI9AiP0fEw=;
        b=UyliZCJJ0844S/CO227l0HAUjBq2sdDNhw9cEZVU/GQhM4qrQe0quTkmOxV0cdtNGl
         00T79MWXIyIQsakbeF39es40JoIZrsq3SIsUyc44c4T4oYI8KwrGiHKoHWS/EmNOXSdo
         rr78k7Bc5B59jFvVtbhEMzHD0V0I/3ZMd4MqLygT81iAifNeqWBtI5vU9mdYh4tFpUHK
         dmWZXA6A1cS7pzXEFQjfPOHhbEqKa1jWpmdUOfVe0lNb5QWBpm+37coA3E5K5DSEOQr9
         xUBoD2qXJoAAh7sG5knqxgRhSnNHx1lQnLaYV8GLkSWmzS1TClzuwhKM2oK/nWsXeusY
         UzzQ==
X-Gm-Message-State: ANhLgQ3CpJu2HLLUBY2Qw3LvH1jut3yZshvzDouEdGPcttpal3r/cp1o
        yb2HyHoE2K0hwCX2Td2NwqKJOxJ9tXrGT7qQJaZDDLo8I+pLtVC4z2V8h1aTGTnR2wN9h9xdnrd
        te8QrTUbeqwrwQoseMvFxNQ==
X-Received: by 2002:a5d:4683:: with SMTP id u3mr6044458wrq.251.1583951098564;
        Wed, 11 Mar 2020 11:24:58 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuFwa2rQIlp3Ndabf9/ozMQ9Cr3LXBZlBnnVx+Xl6lybR3w5KhAONmLioZJaJ7wCHoT+edMNw==
X-Received: by 2002:a5d:4683:: with SMTP id u3mr6044427wrq.251.1583951098327;
        Wed, 11 Mar 2020 11:24:58 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id 12sm9267987wmo.30.2020.03.11.11.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 11:24:56 -0700 (PDT)
Subject: Re: [RFC v2] x86: Select HARDIRQS_SW_RESEND on x86
To:     Thomas Gleixner <tglx@linutronix.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <87sgk4naqh.fsf@nanos.tec.linutronix.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0e5b484d-89f5-c018-328a-fb4a04c6cd91@redhat.com>
Date:   Wed, 11 Mar 2020 19:24:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87sgk4naqh.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Thomas,

On 1/24/20 4:19 PM, Thomas Gleixner wrote:
> Hans,
> 
> Hans de Goede <hdegoede@redhat.com> writes:
>>
>> The Intel GPIO controllers do not allow implementing irq_retrigger without
>> emulating it in software, at which point we are better of just using the
>> generic HARDIRQS_SW_RESEND mechanism rather then re-implementing software
>> emulation for this separately in aprox. 14 different pinctrl drivers.
> 
> Indeed.
> 
>> I'm sending this out as a RFC since I'm not %100 sure this is the best
>> solution and it seems like a somewhat big change to make.
> 
> It's not that bad. The only affected interrupt chips on x86 should be
> secondary interrupt chips like the GPIO controller.
> 
> ioapic/msi/... have irq_retrigger() functionality, so it won't do the
> software resend.
> 
> I just need to stare at the legacy PIC and the virt stuff.
> 
>> Also maybe we should add a Cc: stable@vger.kernel.org ??? This seems like
>> somewhat a big change for that but it does solve some real issues...
> 
> Yes. Let me stare at the couple of weird irqchips which might get
> surprised. I'll teach them not to do that :)

I know that you are very busy, still I'm wondering is there any progress
on this ?

Regards,

Hans

