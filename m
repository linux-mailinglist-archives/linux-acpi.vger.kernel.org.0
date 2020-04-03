Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEE8E19D9B0
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Apr 2020 17:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403852AbgDCPDY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Apr 2020 11:03:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28493 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727431AbgDCPDY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Apr 2020 11:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585926202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AyMiQZBYNObrGTC5/0a1f5GECR6R9fTBrBZGyOFzxdk=;
        b=atVkYFhaC4JAYwHCxhtXCshF8b9S6L9/wUkJI8La/P0eJN2WqM5pobjYzTwubI7vWmezjT
        ecSmNnHKFnOJuOyONkJ0Rez9FTIbmlnxQvkD1JcNZP7VB8S6gKduNITea3FFUHHKSxpUJR
        tJZKJxi2rmWuZtsWpF7FIvNsbB4iwDg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-TyeHoRX5OoagowJeVn8c0w-1; Fri, 03 Apr 2020 11:03:21 -0400
X-MC-Unique: TyeHoRX5OoagowJeVn8c0w-1
Received: by mail-wm1-f70.google.com with SMTP id v8so2868564wml.8
        for <linux-acpi@vger.kernel.org>; Fri, 03 Apr 2020 08:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AyMiQZBYNObrGTC5/0a1f5GECR6R9fTBrBZGyOFzxdk=;
        b=RRuAgizFeHRdNBI9thfqKgXgZC3aZJMC9sKPD1l+jpymiiA+1vDj3ZeiEbkbEhPv96
         CXbDnZp18zTsNyQIl7nMsXonwkaVE7Q2gCE/Tflenc5AyTdXLSTMI5iRxwJpJYT7vB2y
         2wqtobPOuP1A0o8Njw8OJPxdq0eyvxNBh4U1nJRg7qYIwGsEKeuiDcG4exmLFD3h5KUz
         AMJHsAhRc2gjuDmMZ2XBSXCs7Y1eygbTBvEfCu3vLh77E9Ar3hbSEWW/lO7dN9MSOr3r
         oPR3H+R0PMT17bJBit2i0/n2gjuEHWpZRHy/bU9DibxuomOE3ykeen7xyaRqbMA6aGld
         Io6w==
X-Gm-Message-State: AGi0PubGYSlGlHWOBc05mTOhtFW2jlpJIorrbwTDg/GEzP/r+aTiyEIS
        q176A14uPRRS4lHskZaMEj+nEqZ2Bx37YR4vgZ7bxtK9Gr8pRusn78qqX/HBtlJpEPIyhqSn/Tb
        9KxrFNIEZxBmLV7lJm7jZhA==
X-Received: by 2002:adf:fcc8:: with SMTP id f8mr10004948wrs.132.1585926200161;
        Fri, 03 Apr 2020 08:03:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypKRAL+3/jSICo54b+5w03Rl9FI4HrOdsnmfDTGRCDp1bwdcrlu1b5fzPMA6R6d27iYl+ZX8Qw==
X-Received: by 2002:adf:fcc8:: with SMTP id f8mr10004919wrs.132.1585926199965;
        Fri, 03 Apr 2020 08:03:19 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id 189sm12149137wme.31.2020.04.03.08.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 08:03:19 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] platform/x86: intel_int0002_vgpio: Use
 acpi_register_wakeup_handler()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "5 . 4+" <stable@vger.kernel.org>
References: <20200403105235.105187-1-hdegoede@redhat.com>
 <20200403105235.105187-2-hdegoede@redhat.com>
 <CAJZ5v0gcRgTTRfCKHS00y599NBhWPgAYQF0RfFo6-vDegYA6Eg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <873c0209-c335-a9fe-d17b-b8e089bdcc04@redhat.com>
Date:   Fri, 3 Apr 2020 17:03:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gcRgTTRfCKHS00y599NBhWPgAYQF0RfFo6-vDegYA6Eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 4/3/20 3:25 PM, Rafael J. Wysocki wrote:
> On Fri, Apr 3, 2020 at 12:52 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> The Power Management Events (PMEs) the INT0002 driver listens for get
>> signalled by the Power Management Controller (PMC) using the same IRQ
>> as used for the ACPI SCI.
>>
>> Since commit fdde0ff8590b ("ACPI: PM: s2idle: Prevent spurious SCIs from
>> waking up the system") the SCI triggering, without there being a wakeup
>> cause recognized by the ACPI sleep code, will no longer wakeup the system.
>>
>> This breaks PMEs / wakeups signalled to the INT0002 driver, the system
>> never leaves the s2idle_loop() now.
>>
>> Use acpi_register_wakeup_handler() to register a function which checks
>> the GPE0a_STS register for a PME and trigger a wakeup when a PME has
>> been signalled.
>>
>> With this new mechanism the pm_wakeup_hard_event() call is no longer
>> necessary, so remove it and also remove the matching device_init_wakeup()
>> calls.
>>
>> Fixes: fdde0ff8590b ("ACPI: PM: s2idle: Prevent spurious SCIs from waking up the system")
>> Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> - Adjust for the wakeup-handler registration function being renamed to
>>    acpi_register_wakeup_handler()
>> ---
>>   drivers/platform/x86/intel_int0002_vgpio.c | 14 ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel_int0002_vgpio.c b/drivers/platform/x86/intel_int0002_vgpio.c
>> index f14e2c5f9da5..9da19168b4f6 100644
>> --- a/drivers/platform/x86/intel_int0002_vgpio.c
>> +++ b/drivers/platform/x86/intel_int0002_vgpio.c
>> @@ -122,11 +122,17 @@ static irqreturn_t int0002_irq(int irq, void *data)
>>          generic_handle_irq(irq_find_mapping(chip->irq.domain,
>>                                              GPE0A_PME_B0_VIRT_GPIO_PIN));
>>
>> -       pm_wakeup_hard_event(chip->parent);
>> -
> 
> If the event occurs before the "noirq" phase of suspending devices, it
> can be missed with this change AFAICS.
> 
>>          return IRQ_HANDLED;
>>   }
>>
>> +static bool int0002_check_wake(void *data)
>> +{
>> +       u32 gpe_sts_reg;
>> +
>> +       gpe_sts_reg = inl(GPE0A_STS_PORT);
>> +       return (gpe_sts_reg & GPE0A_PME_B0_STS_BIT);
>> +}
>> +
>>   static struct irq_chip int0002_byt_irqchip = {
>>          .name                   = DRV_NAME,
>>          .irq_ack                = int0002_irq_ack,
>> @@ -220,13 +226,13 @@ static int int0002_probe(struct platform_device *pdev)
>>                  return ret;
>>          }
>>
>> -       device_init_wakeup(dev, true);
>> +       acpi_register_wakeup_handler(irq, int0002_check_wake, NULL);
> 
> So I would just add the wakeup handler registration here.

Ok, will fix for the upcoming v3 of the series.

Regards,

Hans



> 
>>          return 0;
>>   }
>>
>>   static int int0002_remove(struct platform_device *pdev)
>>   {
>> -       device_init_wakeup(&pdev->dev, false);
>> +       acpi_unregister_wakeup_handler(int0002_check_wake, NULL);
>>          return 0;
>>   }
>>
>> --
> 

