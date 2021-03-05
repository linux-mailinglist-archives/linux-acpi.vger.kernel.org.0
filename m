Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5262F32E467
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Mar 2021 10:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhCEJLB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Mar 2021 04:11:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47354 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229679AbhCEJKz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Mar 2021 04:10:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614935455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p76f0tFfvhj2aVzmHnFVmcyeAHMCxMDkRo7RjUvpiWk=;
        b=UxwZinUSUX6HyKKtFdL2Z27feDlBXvR9ru2xzsRnLGy2yo7do+ErQHIaWglmYMSxwqNX3+
        1FZUSdQIZ62DaKM52tiUduhlrCPx5Uj/4H5IcK2fNrv+jIRlbJxGJv9Xa7A4L0TB96nMJF
        0cETbtJAVMSIRc/A+fXLctUPDe2/RZU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-l5AfgcpHMfSfehHSQFgE_Q-1; Fri, 05 Mar 2021 04:10:53 -0500
X-MC-Unique: l5AfgcpHMfSfehHSQFgE_Q-1
Received: by mail-ej1-f72.google.com with SMTP id h14so586389ejg.7
        for <linux-acpi@vger.kernel.org>; Fri, 05 Mar 2021 01:10:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p76f0tFfvhj2aVzmHnFVmcyeAHMCxMDkRo7RjUvpiWk=;
        b=KRr2REFhjOe+ShNcPpEDHtJncOHBdcCy+oZIKFx+7IWlf4bG700o+XIb1sdnL0jb/7
         cOoWfzA3f/5+Ce0E17x/RmutIr1v3ykIblRuhtqPJedTViYjjv0/08C/U6J6jKBgLB3A
         tvojfsy18ekRdsis3YP9gdklPr+0d13oR0TH8gIhNUJt5OLwLXNzC1EG+fuNb/yuSGYU
         YLG3PXpBNI1oh8gK74kfRJZXzgaO68/DU271imIWt2Ht4pIA+fPG6MQb5FuZYy6vUlWH
         dmiVGjeAlXTP8Psq4kBMi9XngMDVf701FdBksBM3eq4gwgdpKucjnsnQkHsEIOmI3q0o
         I86Q==
X-Gm-Message-State: AOAM533WfSHyPP6BZoAMC6V2Kn1sV+PpsbNYeuWH3IfZKYm+2eHKOb+g
        8WzZkZBqsHKheYBjS0itdSxO31MNG4dz7b8eRN5y7bvFKTxYBAMDQVIMylCtF9AMeTq1D0N5b6G
        2MwnKeYc8WxxMvmjunuEtTA==
X-Received: by 2002:a05:6402:38d:: with SMTP id o13mr8111381edv.337.1614935452084;
        Fri, 05 Mar 2021 01:10:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyOzAJaApoXq1IuCFNt8uLS4VzhRj4P3ZQEkLpTPakYxSBW5z3+6Y8BGOjMFHM7HxzjSiSoBg==
X-Received: by 2002:a05:6402:38d:: with SMTP id o13mr8111370edv.337.1614935451946;
        Fri, 05 Mar 2021 01:10:51 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id b12sm1216158eds.94.2021.03.05.01.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 01:10:51 -0800 (PST)
Subject: Re: [PATCH] gpiolib: acpi: support override broken GPIO number in
 ACPI table
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20210226033919.8871-1-shawn.guo@linaro.org>
 <YD9bQXBD+9k3Lf/4@smile.fi.intel.com>
 <2ed0d4dc-2756-9a55-3f54-1377732e35fc@redhat.com>
 <20210305011429.GH17424@dragon>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f7aa417e-42b5-0c42-6f59-7311b060384f@redhat.com>
Date:   Fri, 5 Mar 2021 10:10:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210305011429.GH17424@dragon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 3/5/21 2:14 AM, Shawn Guo wrote:
> On Thu, Mar 04, 2021 at 08:32:14PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 3/3/21 10:47 AM, Andy Shevchenko wrote:
>>> On Fri, Feb 26, 2021 at 11:39:19AM +0800, Shawn Guo wrote:
>>>> Running kernel with ACPI on Lenovo Flex 5G laptop, touchpad is just
>>>> not working.  That's because the GpioInt number of TSC2 node in ACPI
>>>> table is simply wrong, and the number even exceeds the maximum GPIO
>>>> lines.  As the touchpad works fine with Windows on the same machine,
>>>> presumably this is something Windows-ism.  Although it's obviously
>>>> a specification violation, believe of that Microsoft will fix this in
>>>> the near future is not really realistic.
>>>>
>>>> It adds the support of overriding broken GPIO number in ACPI table
>>>> on particular machines, which are matched using DMI info.  Such
>>>> mechanism for fixing up broken firmware and ACPI table is not uncommon
>>>> in kernel.  And hopefully it can be useful for other machines that get
>>>> broken GPIO number coded in ACPI table.
>>>
>>>
>>> +Cc: Hans.
>>>
>>> Hans, would appreciate your opinion on this thread. Maybe I'm mistaken in my
>>> conclusions.
>>
>> So I've read the entire thread here:
>> https://lore.kernel.org/linux-gpio/20210226033919.8871-1-shawn.guo@linaro.org/T/#u
>>
>> And I agree wih Andy, this is not something which should be fixed up in the
>> generic gpiolib-acpi code.
>>
>> Note that we have similar things going on on x86 platforms. There are cases
>> there where there are e.g. holes in the GPIO ranges advertised by the Intel
>> pinctrl drivers. And in the beginning as i2c (and thus GpioIRQ) HID devices
>> started to become more common there were also several rounds of work to make
>> sure that the GPIO numbering (per ACPI-device / island) exported to the rest
>> of the kernel (and thus to gpiolib-acpi) matched with the numbering which
>> the ACPI tables expected (so the numbering which the Windows driver use).
>>
>> It seems to me, esp. in the light that there are a lot of "crazy high" GPIO
>> indexes in the DSDT of the Lenovo Flex 5G, that the right thing to do here
>> is to fix the qualcom pinctrl/GPIO driver to number its GPIOs in the way
>> expected by these ACPI tables. This will break use of existing devicetrees,
>> so it will likely need to detect if the main firmware of the system is ACPI
>> or DT based and then use 2 different numbering schemes depending on the
>> outcome of that check.
>>
>> Please also do not try ti fix this with some quirks in e.g. the i2c-hid driver,
>> I will definitely NACK such attempts. From what we can see now any fix clearly
>> should be done inside the qualcom GPIO driver.
> 
> Thanks for your opinion on this, Hans.  Yeah, with the information from
> Jeffrey, I now agree with Andy that these high GPIO numbers are not
> broken but have some meaning, and we should map them back to real GPIO
> number in Qualcomm GPIO driver.
> 
> So we reach a consensus that this is not the right solution for Lenovo
> Flex 5G. But what about for Andy's Galileo Gen 2 case, where the GPIO
> number in ACPI is truly broken?

Well if the ACPI table truely simply has a wrong number in it, like in
this case, then we clearly need a workaround.

>   ba8c90c61847 ("gpio: pca953x: Override IRQ for one of the expanders on Galileo Gen 2")

And we have one in place, so I'm not sure what the question is?

I guess the question is of your generic GPIO renumber patch would not
be a better answer to that ?

IMHO no, we want to keep quirks out of the core as much as possible,
for example the code which Andy added a quirk to is build as a module
in the generic Fedora distro kernel, so for most users the code will
not be loaded into memory. Where as if we add it to the core it would
use up extra memory for everyone.

Also if, in the future, we were to ever add a generic GPIO renumber quirk
mechanism to the core, then your code would need more work. Because to be
truely generic it would need to remap one gpiochip-name:pin-number on
another gpiochip-name:pin-number pair. There might very well be a case
with multiple gpiochips with pin number 32 being referenced in the DSDT
and where we need to remap one of those 32-s to a different number
(or possibly even to a different chip + number).

Regards,

Hans

