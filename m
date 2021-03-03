Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD9C32C422
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 01:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356724AbhCDALa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Mar 2021 19:11:30 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:14067 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234789AbhCCFE0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Mar 2021 00:04:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614747802; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=DgHG6UchEqSuAHgA1YD7PCkIm0DL6U3dowHnKc88aKA=; b=UDtRIfhlFmvhWZJ5VxXRv9q97vl+VmDSpVrgywa1A46ADQn/6Er1F8jinvRpzwjj/b4WPVRs
 Czzyt/pSY+R5em8Q/HOHikuO7wHvGnSBSNg8xEjvvQN3WRevzNBjClr7x+lAaxaFpC0NpKkC
 ycoGYa9hG0zNa2Lg1TnQPBBFyIM=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyJkOWYwNyIsICJsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 603f187cc008ffc73a20c718 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 03 Mar 2021 05:02:52
 GMT
Sender: jhugo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9D42EC43463; Wed,  3 Mar 2021 05:02:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.226.59.216] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B7C57C433C6;
        Wed,  3 Mar 2021 05:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B7C57C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH] gpiolib: acpi: support override broken GPIO number in
 ACPI table
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shawn Guo <shawn.guo@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
References: <20210226033919.8871-1-shawn.guo@linaro.org>
 <CAHp75Vcb=NO9OWjSpBeVC4c+9=aXE=yiDWVBwLD1DnzwdgFD6Q@mail.gmail.com>
 <20210226093925.GA24428@dragon>
 <CAHp75Vc6xYv+197SOrSefQHD2h4Xy_N20gQajW4uF2PU=sJfLg@mail.gmail.com>
 <YDjZOU+VMWasjzUb@smile.fi.intel.com> <20210227031944.GB24428@dragon>
 <YDzbQqHspfvpYS7Z@smile.fi.intel.com> <20210302002725.GE24428@dragon>
 <YD4twyAGvDDOCv+n@smile.fi.intel.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <abbfcdfa-c287-3828-ed6f-bc1e1f13c6b2@codeaurora.org>
Date:   Tue, 2 Mar 2021 22:02:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YD4twyAGvDDOCv+n@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 3/2/2021 5:21 AM, Andy Shevchenko wrote:
> On Tue, Mar 02, 2021 at 08:27:26AM +0800, Shawn Guo wrote:
>> On Mon, Mar 01, 2021 at 02:17:06PM +0200, Andy Shevchenko wrote:
>>> On Sat, Feb 27, 2021 at 11:19:45AM +0800, Shawn Guo wrote:
>>>> On Fri, Feb 26, 2021 at 01:19:21PM +0200, Andy Shevchenko wrote:
>>>>> On Fri, Feb 26, 2021 at 12:57:37PM +0200, Andy Shevchenko wrote:
>>>>>> On Fri, Feb 26, 2021 at 11:39 AM Shawn Guo <shawn.guo@linaro.org> wrote:
>>>>>>> On Fri, Feb 26, 2021 at 11:12:07AM +0200, Andy Shevchenko wrote:
>>>>>>>> On Fri, Feb 26, 2021 at 5:42 AM Shawn Guo <shawn.guo@linaro.org> wrote:
>>>>>>>>> Running kernel with ACPI on Lenovo Flex 5G laptop, touchpad is just
>>>>>>>>> not working.  That's because the GpioInt number of TSC2 node in ACPI
>>>>>>>>> table is simply wrong, and the number even exceeds the maximum GPIO
>>>>>>>>> lines.  As the touchpad works fine with Windows on the same machine,
>>>>>>>>> presumably this is something Windows-ism.  Although it's obviously
>>>>>>>>> a specification violation, believe of that Microsoft will fix this in
>>>>>>>>> the near future is not really realistic.
>>>>>>>>>
>>>>>>>>> It adds the support of overriding broken GPIO number in ACPI table
>>>>>>>>> on particular machines, which are matched using DMI info.  Such
>>>>>>>>> mechanism for fixing up broken firmware and ACPI table is not uncommon
>>>>>>>>> in kernel.  And hopefully it can be useful for other machines that get
>>>>>>>>> broken GPIO number coded in ACPI table.
>>>>>>>>
>>>>>>>> Thanks for the report and patch.
>>>>>>>>
>>>>>>>> First of all, have you reported the issue to Lenovo? At least they
>>>>>>>> will know that they did wrong.
>>>>>>>
>>>>>>> Yes, we are reporting this to Lenovo, but to be honest, we are not sure
>>>>>>> how much they will care about it, as they are shipping the laptop with
>>>>>>> Windows only.
>>>>>>>
>>>>>>>> Second, is it possible to have somewhere output of `acpidump -o
>>>>>>>> flex5g.dat` (the flex5g.dat file)?
>>>>>>>
>>>>>>> https://raw.githubusercontent.com/aarch64-laptops/build/master/misc/lenovo-flex-5g/dsdt.dsl
>>>>>
>>>>> Looking into DSDT I think the problem is much worse. First of all there are
>>>>> many cases where pins like 0x140, 0x1c0, etc are being used. On top of that
>>>>> there is no GPIO driver in the upstream (as far as I can see by HID, perhaps
>>>>> there is a driver but for different HID. And I see that GPIO device consumes a
>>>>> lot of Interrupts from GIC as well (it's ARM platfrom as far as I understand).
>>>>
>>>> Yes, it's a laptop built on Qualcomm Snapdragon SC8180X SoC.  The GPIO
>>>> driver is generic for all Snapdragon SoCs, and has been available in
>>>> upstream for many years (for DT though). It can be found as the gpio_chip
>>>> implementation in MSM pinctrl driver [1].  The SC8180X specific part can
>>>> be found as pinctrl-sc8180x.c [2], and it's already working for DT boot.
>>>> The only missing piece is to add "QCOM040D" as the acpi_device_id to
>>>> support ACPI boot, and it will be submitted after 5.12-rc1 comes out.
>>>>
>>>>> Looking at the Microsoft brain damaged way of understanding GPIOs and hardware
>>>>> [1], I am afraid you really want to have a specific GPIO driver for this. So,
>>>>> for now until we have better picture of what's going on, NAK to this patch.
>>>>
>>>> Thanks for the pointer to Microsoft document.  On Snapdragon, we have
>>>> only one GPIO instance that accommodates all GPIO pins, so I'm not sure
>>>> that Microsoft GPIOs mapping layer is relevant here at all.
>>>>
>>>> Please take a look at the GPIO driver, and feel free to let me know if
>>>> you need any further information to understand what's going on.
>>>
>>> Yes, I looked into the driver and see that it has 3 blocks of GPIOs (we call
>>> them communities, but in the driver the term 'tiles' is used) AFAIU (correct me
>>> if I'm wrong). And who knows how many banks in each of them.
>>
>> I'm not sure that the 3 'tiles' means 3 blocks of GPIOs.  Maybe, @Bjorn
>> can help clarify.  But the ACPI table shows that there is only 'GIO0'
>> with 'QCOM040D' HID.
> 
> Yeah, I already got that ACPI there is screwed up...
> 
>>> I'm afraid that MS does on his way and not yours.
>>>
>>> Can we have TRM for GPIO IP used there and any evidence / document from
>>> firmware team about the implementation of the GPIO numbering in the ACPI
>>> (at Intel we have so called BIOS Writers Guide that is given to the customers
>>> where such info can be found)?
>>
>> Unfortunately, I do not have the access to any sort of these documents.
>> But I looped in Jeffrey who is part of Qualcomm kernel/firmware team,
>> and should be able to help clarify GPIO numbering in the ACPI table.
> 
> Thanks! Will wait for new information then.

Sorry, just joining the thread now.  Hopefully I'm addressing everything 
targeted at me.

I used to do kernel work on MSMs, then kernel work on server CPUs, but 
now I do kernel work on AI accelerators.  Never was on the firmware 
team, but I have a lot of contacts in those areas.  On my own time, I 
support Linux on the Qualcomm laptops.

Its not MS that needs to fix things (although there is plenty of things 
I could point to that MS could fix), its the Qualcomm Windows FW folks. 
  They have told me a while ago they were planning on fixing this issue 
on some future chipset, but apparently that hasn't happened yet.  Sadly, 
once these laptops ship, they are in a frozen maintenance mode.

In my opinion, MS has allowed Qualcomm to get away with doing bad things 
in ACPI on the Qualcomm laptops.  The ACPI is not a true hardware 
description that is OS agnostic as it should be, and probably violates 
the spec in many ways.  Instead, the ACPI is written against the Windows 
drivers, and has a lot of OS driver crap pushed into it.

The GPIO description is one such thing.

As I understand it, any particular SoC will have a number of GPIOs 
supported by the TLMM.  0 - N.  Linux understands this.  However, in the 
ACPI of the Qualcomm Windows laptops, you will likely find atleast one 
GPIO number which exceeds this N.  These are "virtual" GPIOs, and are a 
construct of the Windows Qualcomm TLMM driver and how it interfaces with 
the frameworks within Windows.

Some GPIO lines can be configured as wakeup sources by routing them to a 
specific hardware block in the SoC (which block it is varies from SoC to 
SoC).  Windows has a specific weird way of handling this which requires 
a unique "GPIO chip" to handle.  GPIO chips in Windows contain 32 GPIOs, 
so for each wakeup GPIO, the TLMM driver creates a GPIO chip 
(essentially creating 32 GPIOs), and assigns the added GPIOs numbers 
which exceed N.  The TLMM driver has an internal mapping of which 
virtual GPIO number corresponds to which real GPIO.

So, ACPI says that some peripheral has GPIO N+X, which is not a real 
GPIO.  That peripheral goes and requests that GPIO, which gets routed to 
the TLMM driver, and the TLMM driver translates that number to the real 
GPIO, and provides the reference back to the peripheral, while also 
setting up the special wakeup hardware.

So, N+1 is the first supported wakup GPIO, N+1+32 is the next one, then 
N+1+32+32, and so on.

I see how this creates a nice mess for running Linux on these laptops, 
but I don't have a good idea how to work around it.  Per SoC, you'd need 
to know the mapping and translate it for ACPI when running the Windows 
version of the FW (yes most Qualcomm MSMs have OS specific firmware), 
but reject such gpio numbers when running other firmware, or I guess on 
different targets.

> 
>>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pinctrl/qcom/pinctrl-msm.c#n713
>>>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pinctrl/qcom/pinctrl-sc8180x.c
> 


-- 
Jeffrey Hugo
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
