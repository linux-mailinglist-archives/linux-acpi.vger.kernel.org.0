Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF6432C439
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 01:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380030AbhCDAL7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Mar 2021 19:11:59 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:47134 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244831AbhCCPL5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Mar 2021 10:11:57 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614784304; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=sRQIESzJzYRECzNj+RqCqmuf8C0lz4OU1zfKTclwppQ=; b=NoJnl1Fkp/6rzoZs3SNPswUyq9hpc/cbrHF8imontf+/mVu3X5MifrkFChZzt9ZbG0Cw7hy0
 BD7CGEIjybNq9tg2lwg5ODKpfxBYQxnMVA63ebDIV+QGJ0PgG4oLF4BA5otmxpvPetUdFEZg
 hbLTH9oR93jSPn9lwGEhBx27u24=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyJkOWYwNyIsICJsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 603fa6ffc862e1b9fdd2a74b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 03 Mar 2021 15:10:55
 GMT
Sender: jhugo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 47FB3C43463; Wed,  3 Mar 2021 15:10:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [10.226.59.216] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A73D8C433C6;
        Wed,  3 Mar 2021 15:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A73D8C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH] gpiolib: acpi: support override broken GPIO number in
 ACPI table
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
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
 <abbfcdfa-c287-3828-ed6f-bc1e1f13c6b2@codeaurora.org>
 <20210303094300.GB17424@dragon>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <41593c7e-368b-cfb8-b24a-2e4dca48b465@codeaurora.org>
Date:   Wed, 3 Mar 2021 08:10:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210303094300.GB17424@dragon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 3/3/2021 2:43 AM, Shawn Guo wrote:
> On Tue, Mar 02, 2021 at 10:02:49PM -0700, Jeffrey Hugo wrote:
>> Sorry, just joining the thread now.  Hopefully I'm addressing everything
>> targeted at me.
>>
>> I used to do kernel work on MSMs, then kernel work on server CPUs, but now I
>> do kernel work on AI accelerators.  Never was on the firmware team, but I
>> have a lot of contacts in those areas.  On my own time, I support Linux on
>> the Qualcomm laptops.
>>
>> Its not MS that needs to fix things (although there is plenty of things I
>> could point to that MS could fix), its the Qualcomm Windows FW folks.  They
>> have told me a while ago they were planning on fixing this issue on some
>> future chipset, but apparently that hasn't happened yet.  Sadly, once these
>> laptops ship, they are in a frozen maintenance mode.
>>
>> In my opinion, MS has allowed Qualcomm to get away with doing bad things in
>> ACPI on the Qualcomm laptops.  The ACPI is not a true hardware description
>> that is OS agnostic as it should be, and probably violates the spec in many
>> ways.  Instead, the ACPI is written against the Windows drivers, and has a
>> lot of OS driver crap pushed into it.
>>
>> The GPIO description is one such thing.
>>
>> As I understand it, any particular SoC will have a number of GPIOs supported
>> by the TLMM.  0 - N.  Linux understands this.  However, in the ACPI of the
>> Qualcomm Windows laptops, you will likely find atleast one GPIO number which
>> exceeds this N.  These are "virtual" GPIOs, and are a construct of the
>> Windows Qualcomm TLMM driver and how it interfaces with the frameworks
>> within Windows.
>>
>> Some GPIO lines can be configured as wakeup sources by routing them to a
>> specific hardware block in the SoC (which block it is varies from SoC to
>> SoC).  Windows has a specific weird way of handling this which requires a
>> unique "GPIO chip" to handle.  GPIO chips in Windows contain 32 GPIOs, so
>> for each wakeup GPIO, the TLMM driver creates a GPIO chip (essentially
>> creating 32 GPIOs), and assigns the added GPIOs numbers which exceed N.  The
>> TLMM driver has an internal mapping of which virtual GPIO number corresponds
>> to which real GPIO.
>>
>> So, ACPI says that some peripheral has GPIO N+X, which is not a real GPIO.
>> That peripheral goes and requests that GPIO, which gets routed to the TLMM
>> driver, and the TLMM driver translates that number to the real GPIO, and
>> provides the reference back to the peripheral, while also setting up the
>> special wakeup hardware.
>>
>> So, N+1 is the first supported wakup GPIO, N+1+32 is the next one, then
>> N+1+32+32, and so on.
> 
> Jeffrey,
> 
> Thanks so much for these great information!
> 
> May I ask a bit more about how the virtual number N+1+32*n maps back to
> the real number (R)?  For example of touchpad GPIO on Flex 5G, I think
> we have:
> 
>    N+1+32*n = 0x0280
>    N = 191
>    R = 24
> 
> If my math not bad, n = 14.  How does 14 map to 24?


So, if this was 845, the wakeup hardware would be the PDC.  Only a 
specific number of GPIOs are routed to the PDC.  When the TLMM is 
powered off in suspend, the PDC pays attention to the GPIOs that are 
routed to it, and are configured in the PDC as wakeup sources.  When the 
GPIO is asserted, the signal to the TLMM gets lost, but the PDC catches 
it.  The PDC will kick the CPU/SoC out of suspend, and then once the 
wakup process is complete, replay the GPIO so that the TLMM has the signal.

In your example, 14 would be the 14th GPIO that is routed to the PDC. 
You would need SoC hardware documentation to know the mapping from PDC 
line 14 to GPIO line X.  This is going to be SoC specific, so 845 
documentation is not going to help you for SC8XXX.

Chances are, you are going to need to get this documentation from 
Qualcomm (I don't know if its in IPCatalog or not), and put SoC specific 
lookup tables in the TLMM driver.

Does that make sense, or did I not answer the question you were actually 
asking?

-- 
Jeffrey Hugo
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
