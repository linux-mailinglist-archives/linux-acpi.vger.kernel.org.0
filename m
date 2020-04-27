Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C099F1BA3DA
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Apr 2020 14:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgD0Mve (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Apr 2020 08:51:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22826 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726769AbgD0Mva (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Apr 2020 08:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587991888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vRiQmFzoZrXUGpwWxPLuF6siHGrPTOYeQlcSJvIJ/rE=;
        b=BviJlWNnuBwu4EOaTImMyBXe929z2tIC81SVqzDd0TOhee6XEZjMi7ux6H3Q+NUi1CMCBZ
        742XGtSaMzsnc1YkAW085YQcG3URuKHNmPQxbkr+4a+SIOyqKTSQ3jkZ0LInGrUFrKd0vL
        3tZPGbuswwq2q9XUUYa6FwydY/qETOs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-M_-zxk6VOEOO5mmOPmBsew-1; Mon, 27 Apr 2020 08:51:26 -0400
X-MC-Unique: M_-zxk6VOEOO5mmOPmBsew-1
Received: by mail-wr1-f71.google.com with SMTP id p16so10434260wro.16
        for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2020 05:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vRiQmFzoZrXUGpwWxPLuF6siHGrPTOYeQlcSJvIJ/rE=;
        b=gErz6qGk7rXsvOTensUYKjzNav4THzljKnJHFWBQ8Is2zOjw4iuBn5NHa24urHGzsw
         zGplXrR2WweOGYn9maQfMIOo9m5nP6yVxCq+wj9rpI0X8V3olV+fkIIxvIfMQOs+LHiH
         pWALTQ9RYnVeoEqOq8UsjPWqnX4JIDGRhWG0kg17JEa8lfenhTSiU+O9QtsO+c8mWW6o
         nXlA9a8yXG/utUBHfjmvYJ/USCmhWME5cSnRBR6gpqF8RA2oBDgmAYRMOtApBp3WZcto
         +Hg9b1prr2btDKK/thZMPVewgDFOw4ZKbuJ+JrobDS+MZjFN4cW4rU5gOPEC81NWhyLD
         Qoyg==
X-Gm-Message-State: AGi0PuaIljl5y3whOdx6RvLO5vQKsHsLK2NiJuR80uOPVajCBiZi1K6J
        GCPwxJ8D5GZQWkM8Obdba/4ezLaDKY0tZ58mLqLGJqRT7Ok3/QsX429aSeHI7nheNN3QD6zIJCM
        HMc3qE1AUH0K0KX5TrTD3tQ==
X-Received: by 2002:a1c:668a:: with SMTP id a132mr27023574wmc.46.1587991885027;
        Mon, 27 Apr 2020 05:51:25 -0700 (PDT)
X-Google-Smtp-Source: APiQypJyDf/OX4OYcDKrzqBAjDFKNR+NN09aMBK95aTkzZozir/CCz+7irJYgimIBbyH7YrcfSq2zw==
X-Received: by 2002:a1c:668a:: with SMTP id a132mr27023550wmc.46.1587991884778;
        Mon, 27 Apr 2020 05:51:24 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id m15sm15230473wmc.35.2020.04.27.05.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 05:51:23 -0700 (PDT)
Subject: Re: [PATCH 1/2] platform/x86: i2c-multi-instantiate: Add flag for
 passing fwnode
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200426104713.216896-1-hdegoede@redhat.com>
 <20200426104713.216896-2-hdegoede@redhat.com>
 <CAHp75VdOd6C36oR7HAnqrKiinVBr4YcqqJ=dv3NpR3=Xp0QQ-Q@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b5bdffb4-0af2-abb7-21f7-2f5da56d5dc6@redhat.com>
Date:   Mon, 27 Apr 2020 14:51:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdOd6C36oR7HAnqrKiinVBr4YcqqJ=dv3NpR3=Xp0QQ-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 4/26/20 7:59 PM, Andy Shevchenko wrote:
> On Sun, Apr 26, 2020 at 1:47 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> In some cases the driver for the i2c_client-s which i2c-multi-instantiate
>> instantiates may need access some fields / methods from to the ACPI fwnode
>> for which i2c_clients are being instantiated.
>>
>> An example of this are CPLM3218 ACPI device-s. These contain CPM0 and
>> CPM1 packages with various information (e.g. register init values) which
>> the driver needs.
>>
>> Passing the fwnode through the i2c_board_info struct also gives the
>> i2c-core access to it, and if we do not pass an IRQ then the i2c-core
>> will use the fwnode to get an IRQ, see i2c_acpi_get_irq().
> 
> I'm wondering, can we rather do it in the same way like we do for
> GPIO/APIC case here.
> Introduce IRQ_RESOURCE_SHARED (or so) and
> 
> case _SHARED:
>   irq = i2c_acpi_get_irq();
> ...
> 
> ?

I think you are miss-understanding the problem. The problem is not that
we want to share the IRQ, the problem is that we want to pass the single
IRQ in the resources to only 1 of the instantiated I2C-clients. But if we
do not pass an IRQ (we leave it at 0) and we do pass the fwnode then
i2c-core-base.c will see that there is an ACPI-node attached to the
device and will call i2c_acpi_get_irq().

So the solution is definitely not calling i2c_acpi_get_irq() inside
i2c-multi-instantiate.c we want to avoid the i2c_acpi_get_irq(),
leaving the other 2 clients for the BSG1160 device without an IRQ
and thus avoiding the IRQ mismatch (it is a mismatch because the
drivers do not set the shared flag; and that is ok, we do not want
to share the IRQ, it is just for the accelerometer AFAIK).

Regards,

Hans


> 
>>
>> This is a problem when there is only an IRQ for 1 of the clients described
>> in the ACPI device we are instantiating clients for. If we unconditionally
>> pass the fwnode, then i2c_acpi_get_irq() will assign the same IRQ to all
>> clients instantiated, leading to kernel-oopses like this (BSG1160 device):
>>
>> [   27.340557] genirq: Flags mismatch irq 76. 00002001 (bmc150_magn_event) vs. 00000001 (bmc150_accel_event)
>> [   27.340567] Call Trace:
>> ...
>>
>> So we cannot simply always pass the fwnode. This commit adds a PASS_FWNODE
>> flag, which can be used to pass the fwnode in cases where we do not have
>> the IRQ problem and the driver for the instantiated client(s) needs access
>> to the fwnode.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/platform/x86/i2c-multi-instantiate.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
>> index 6acc8457866e..dcafb1a29d17 100644
>> --- a/drivers/platform/x86/i2c-multi-instantiate.c
>> +++ b/drivers/platform/x86/i2c-multi-instantiate.c
>> @@ -20,6 +20,8 @@
>>   #define IRQ_RESOURCE_GPIO      1
>>   #define IRQ_RESOURCE_APIC      2
>>
>> +#define PASS_FWNODE            BIT(2)
>> +
>>   struct i2c_inst_data {
>>          const char *type;
>>          unsigned int flags;
>> @@ -93,6 +95,10 @@ static int i2c_multi_inst_probe(struct platform_device *pdev)
>>                  snprintf(name, sizeof(name), "%s-%s.%d", dev_name(dev),
>>                           inst_data[i].type, i);
>>                  board_info.dev_name = name;
>> +
>> +               if (inst_data[i].flags & PASS_FWNODE)
>> +                       board_info.fwnode = dev->fwnode;
>> +
>>                  switch (inst_data[i].flags & IRQ_RESOURCE_TYPE) {
>>                  case IRQ_RESOURCE_GPIO:
>>                          ret = acpi_dev_gpio_irq_get(adev, inst_data[i].irq_idx);
>> --
>> 2.26.0
>>
> 
> 

