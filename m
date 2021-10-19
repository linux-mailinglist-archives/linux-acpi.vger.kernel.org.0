Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC47B433721
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Oct 2021 15:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbhJSNgA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Oct 2021 09:36:00 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:39339 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230487AbhJSNgA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 Oct 2021 09:36:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UswbPeO_1634650423;
Received: from B-J4ZXMD6R-0327.local(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0UswbPeO_1634650423)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Oct 2021 21:33:45 +0800
Subject: Re: [PATCH] ACPI, APEI, EINJ: Relax platform response timeout to 1
 second.
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "zhangliguang@linux.alibaba.com" <zhangliguang@linux.alibaba.com>,
        "zhuo.song@linux.alibaba.com" <zhuo.song@linux.alibaba.com>
References: <20211015033817.16719-1-xueshuai@linux.alibaba.com>
 <4d492cef3640414d85ecfdb602ad6fa0@intel.com>
 <869f0c92-0800-b24e-9de8-d8c9cb6972a7@linux.alibaba.com>
 <YW2Vbkn5d6r3Y4LA@agluck-desk2.amr.corp.intel.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
Message-ID: <d6e54c7f-c944-3bb1-aa50-d88bc1000c85@linux.alibaba.com>
Date:   Tue, 19 Oct 2021 21:33:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YW2Vbkn5d6r3Y4LA@agluck-desk2.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Tony,

> I'm not at all sure that I'm right that the spin could be replaced
> with an msleep(). It will certainly slow things down for systems
> and EINJ operations that actually complete quickly (because instead
> of returnining within 100ns (or 100us with your patch) it will sleep
> for 1 ms (rounded up to next jiffie ... so 4 ms of HZ=250 systems.
>
> But I don't care if my error injections take 4ms.
>
> I do care that one logical CPU spins for 1 second.
Agree. The side effect of sleep is to slow down the injection that
actually complete quickly and error injection is not concerned with
real-time.

I will send a v2 patch implemented in msleep soon.

Regards.
Shuai


On 2021/10/18 PM11:40, Luck, Tony wrote:
> On Sun, Oct 17, 2021 at 12:06:52PM +0800, Shuai Xue wrote:
>> Hi, Tony,
>>
>> Thank you for your reply.
>>
>>> Spinning for 1ms was maybe ok. Spinning for up to 1s seems like a bad idea.
>>>
>>> This code is executed inside a mutex ... so maybe it is safe to sleep instead of spin?
>>
>> May the email Subject misled you. This code do NOT spin for 1 sec. The period of the
>> spinning depends on the SPIN_UNIT.
> 
> Not just the subject line. See the comment you changed here:
> 
>>> -#define SPIN_UNIT		100			/* 100ns */
>>> -/* Firmware should respond within 1 milliseconds */
>>> -#define FIRMWARE_TIMEOUT	(1 * NSEC_PER_MSEC)
>>> +#define SPIN_UNIT		100			/* 100us */
>>> +/* Firmware should respond within 1 seconds */
>>> +#define FIRMWARE_TIMEOUT	(1 * USEC_PER_SEC)
> 
> That definitely reads to me that the timeout was increased from
> 1 millisecond to 1 second. With the old code polling for completion
> every 100ns, and the new code polling every 100us
>>
>> The period was 100 ns and changed to 100 us now. In my opinion, spinning for 100 ns or 100 us is OK :)
> 
> But what does the code do in between polls? The calling code is:
> 
>         for (;;) {
>                 rc = apei_exec_run(&ctx, ACPI_EINJ_CHECK_BUSY_STATUS);
>                 if (rc)
>                         return rc;
>                 val = apei_exec_ctx_get_output(&ctx);
>                 if (!(val & EINJ_OP_BUSY))
>                         break;
>                 if (einj_timedout(&timeout))
>                         return -EIO;
>         }
> 
> Now apei_exec_run() and apei_exec_ctx_get_output() are a maze of
> functions & macros. But I don't think they can block, sleep, or
> context switch.
> 
> So this code is "spinning" until either BIOS says the operation is
> complete, or the FIRMWARE_TIMEOUT is reached.
> 
> It avoids triggering a watchdog by the call to touch_nmi_watchdog()
> after each spin between polls. But the whole thing may be spinning
> for a second.
> 
> I'm not at all sure that I'm right that the spin could be replaced
> with an msleep(). It will certainly slow things down for systems
> and EINJ operations that actually complete quickly (because instead
> of returnining within 100ns (or 100us with your patch) it will sleep
> for 1 ms (rounded up to next jiffie ... so 4 ms of HZ=250 systems.
> 
> But I don't care if my error injections take 4ms.
> 
> I do care that one logical CPU spins for 1 second.
> 
> -Tony
> 
