Return-Path: <linux-acpi+bounces-9692-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EC09D3641
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 10:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6519AB26BA0
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 09:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6AD199E94;
	Wed, 20 Nov 2024 09:01:50 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED5818A935;
	Wed, 20 Nov 2024 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732093310; cv=none; b=sC9r6ojpFnXl/fC4It2aN1gspC0bc/lZqkA1s+ATtLkDEHNQjjdHt79LO2tAf1HlGa9JZPR6X+/YyJqsJVgvNnlfi+InzO+lFLwBWWii5GQSvmatoOu0PtmcY4WcdWIDU4FW4p4G3rGgDLyk+Ysc+v7lZoCSNaxui4AmdCOd//w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732093310; c=relaxed/simple;
	bh=Yze2IvZa6vi32TXVTNVGdJkV2KwARY1b3fM8sQWPC14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s7pMJ2hWNNxqkCEzj6JjuRAV8H3ltMaU9rQY44Apf4bool+AAKZzUtyM2jMDmS+XV45x9uz+y5dS44toCPt7Yellj+y59YZBfW/vtdKakq/zJvr2xOvcoUUw2cXJcOL5zJEfskCRLpItsyOeYArpVwbsAFI0+Q7KXErDBtQSP6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20E891007;
	Wed, 20 Nov 2024 01:02:16 -0800 (PST)
Received: from [10.57.25.111] (unknown [10.57.25.111])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C5FE3F6A8;
	Wed, 20 Nov 2024 01:01:42 -0800 (PST)
Message-ID: <4daf0c32-9799-4eb5-8334-175d8089bc39@arm.com>
Date: Wed, 20 Nov 2024 10:01:39 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: Replace msleep() with usleep_range() in
 acpi_os_sleep().
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>
Cc: Len Brown <lenb@kernel.org>, anna-maria@linutronix.de,
 tglx@linutronix.de, peterz@infradead.org, frederic@kernel.org,
 corbet@lwn.net, akpm@linux-foundation.org, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Len Brown <len.brown@intel.com>, Arjan van de Ven <arjan@linux.intel.com>,
 Todd Brandt <todd.e.brandt@intel.com>
References: <c7db7e804c453629c116d508558eaf46477a2d73.1731708405.git.len.brown@intel.com>
 <CAJZ5v0iC3mX7Yh_ETTw4FY3xUbZeAUgS0Nc9_88fnT1q5EGWyA@mail.gmail.com>
 <60f8eac0-9144-486b-983f-4ed09101cf0a@redhat.com>
 <CAJZ5v0g7rpdUjrS969stJiqqtO5zG+FTr4TOxg+SYN2dPC_9jA@mail.gmail.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <CAJZ5v0g7rpdUjrS969stJiqqtO5zG+FTr4TOxg+SYN2dPC_9jA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/18/24 13:02, Rafael J. Wysocki wrote:
> Hi Hans,
> 
> On Mon, Nov 18, 2024 at 12:38 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Rafael, Len,
>>
>> On 18-Nov-24 12:03 PM, Rafael J. Wysocki wrote:
>>> On Sat, Nov 16, 2024 at 12:11 AM Len Brown <lenb@kernel.org> wrote:
>>>>
>>>> From: Len Brown <len.brown@intel.com>
>>>>
>>>> Replace msleep() with usleep_range() in acpi_os_sleep().
>>>>
>>>> This has a significant user-visible performance benefit
>>>> on some ACPI flows on some systems.  eg. Kernel resume
>>>> time of a Dell XPS-13-9300 drops from 1943ms to 1127ms (42%).
>>>
>>> Sure.
>>>
>>> And the argument seems to be that it is better to always use more
>>> resources in a given path (ACPI sleep in this particular case) than to
>>> be somewhat inaccurate which is visible in some cases.
>>>
>>> This would mean that hrtimers should always be used everywhere, but they aren't.
>>>
>>> While I have nothing against addressing the short sleeps issue where
>>> the msleep() inaccuracy is too large, I don't see why this requires
>>> using a hrtimer with no slack in all cases.
>>>
>>> The argument seems to be that the short sleeps case is hard to
>>> distinguish from the other cases, but I'm not sure about this.
>>>
>>> Also, something like this might work, but for some reason you don't
>>> want to do it:
>>>
>>> if (ms >= 12 * MSEC_PER_SEC / HZ) {
>>>          msleep(ms);
>>> } else {
>>>         u64 us = ms * USEC_PER_MSEC;
>>>
>>>        usleep_range(us, us / 8);
> 
> Should be
> 
>        usleep_range(us, us + us / 8);
> 
> (I notoriously confuse this API).
> 
>>> }
>>
>> FWIW I was thinking the same thing, that it would be good to still
>> use msleep when the sleep is > (MSEC_PER_SEC / HZ), not sure
>> why you added the 12 there ? Surely something like a sleep longer
>> then 3 timerticks (I know we have NOHZ but still) would already be
>> long enough to not worry about msleep slack ?
> 
> The typical msleep() overhead in 6.12 appears to be 1.5 jiffy which is
> 1.5 * MSEC_PER_SEC / HZ and I want the usleep() delta to be less than
> this, so
> 
> delta = ms / 8 <= 1.5 * MSEC_PER_SEC / HZ
> 
>> And I assume the usleep_range(us, us / 8); is a typo ? Ma can
>> never be less then max, maybe you meant: usleep_range(us, us + 8) ?
> 
> No, please see above.
> 
>> OTOH it is not like we will hit these ACPI acpi_os_sleep()
>> calls multiple times per second all the time. On a normal idle
>> system I expect there to not be that many calls (could still
>> be a few from ACPI managed devices going into + out of
>> runtime-pm regularly). And if don't hit acpi_os_sleep() calls
>> multiple times per second then the chances of time coalescing
>> are not that big anyways.
>>
>> Still I think that finding something middle ground between always
>> sleeping the exact min time and the old msleep() call, as Rafael
>> is proposing, would be good IMHO.
> 
> Thanks for the feedback!
> 
> 
>>>> usleep_range(min, min) is used because there is scant
>>>> opportunity for timer coalescing during ACPI flows
>>>> related to system suspend, resume (or initialization).
>>>>
>>>> ie. During these flows usleep_range(min, max) is observed to
>>>> be effectvely be the same as usleep_range(max, max).
>>>>
>>>> Similarly, msleep() for long sleeps is not considered because
>>>> these flows almost never have opportunities to coalesce
>>>> with other activity on jiffie boundaries, leaving no
>>>> measurably benefit to rounding up to jiffie boundaries.
>>>>
>>>> Background:
>>>>
>>>> acpi_os_sleep() supports the ACPI AML Sleep(msec) operator,
>>>> and it must not return before the requested number of msec.
>>>>
>>>> Until Linux-3.13, this contract was sometimes violated by using
>>>> schedule_timeout_interruptible(j), which could return early.
>>>>
>>>> Since Linux-3.13, acpi_os_sleep() uses msleep(),
>>>> which doesn't return early, but is still subject
>>>> to long delays due to the low resolution of the jiffie clock.
>>>>
>>>> Linux-6.12 removed a stray jiffie from msleep: commit 4381b895f544
>>>> ("timers: Remove historical extra jiffie for timeout in msleep()")
>>>> The 4ms savings is material for some durations,
>>>> but msleep is still generally too course. eg msleep(5)
>>>> on a 250HZ system still takes 11.9ms.
>>>>
>>>> System resume performance of a Dell XPS 13 9300:
>>>>
>>>> Linux-6.11:
>>>> msleep HZ 250   2460 ms
>>>>
>>>> Linux-6.12:
>>>> msleep HZ 250   1943 ms
>>>> msleep HZ 1000  1233 ms
>>>> usleep HZ 250   1127 ms
>>>> usleep HZ 1000  1130 ms
>>>>
>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=216263
>>>> Signed-off-by: Len Brown <len.brown@intel.com>
>>>> Suggested-by: Arjan van de Ven <arjan@linux.intel.com>
>>>> Tested-by: Todd Brandt <todd.e.brandt@intel.com>
>>>> ---
>>>>   drivers/acpi/osl.c | 4 +++-
>>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
>>>> index 70af3fbbebe5..daf87e33b8ea 100644
>>>> --- a/drivers/acpi/osl.c
>>>> +++ b/drivers/acpi/osl.c
>>>> @@ -607,7 +607,9 @@ acpi_status acpi_os_remove_interrupt_handler(u32 gsi, acpi_osd_handler handler)
>>>>
>>>>   void acpi_os_sleep(u64 ms)
>>>>   {
>>>> -       msleep(ms);
>>>> +       u64 us = ms * USEC_PER_MSEC;
>>>> +
>>>> +       usleep_range(us, us);
>>>>   }
>>>>
>>>>   void acpi_os_stall(u32 us)
>>>> --
>>>> 2.43.0
>>>>
>>>
>>
> 


FWIW, testing the above version on an Arm Juno platform by executing
the following method:

Method (SLEE, 1, Serialized)  {
   Sleep(Arg0)
}

_wo: without patch
_w: with patch
- Values in ns.
- Requesting to sleep X ms
- Tested over 10 iterations
- HZ=250
+------+------------+----------+------------+---------+-----------+
|   ms |    mean_wo |   std_wo |    mean_w  |  std_w  |     ratio |
+------+------------+----------+------------+---------+-----------+
|    1 |    8087797 |  2079703 |    1313920 |   55066 | -83.75429 |
|    2 |    7942471 |  2201985 |    2416064 |  111604 | -69.58044 |
|    3 |    8373704 |   144274 |    3632537 |  111037 | -56.61970 |
|    4 |    7946013 |  2214330 |    4606028 |  255838 | -42.03346 |
|    5 |   11418920 |  1673914 |    5955548 |  131862 | -47.84490 |
|    6 |   11427042 |  1677519 |    7045713 |  211439 | -38.34176 |
|    7 |   12301242 |   221580 |    8174633 |  330050 | -33.54628 |
|    8 |   11411606 |  1672182 |    9191048 |  431767 | -19.45877 |
|    9 |   16722304 |  1288625 |   10517284 |  103274 | -37.10625 |
|   10 |   16746542 |  1280385 |   11564426 |  417218 | -30.94439 |
|   20 |   24294957 |    70703 |   22756497 |  673936 |  -6.33243 |
|   30 |   36284782 |    74340 |   34131455 |  391473 |  -5.93452 |
|   40 |   44703162 |  1199709 |   45407108 |  289715 |   1.57471 |
|   50 |   56311282 |   281418 |   56098040 |  607739 |  -0.37868 |
|   60 |   64225811 |   247587 |   64302246 |  132059 |   0.11901 |
|   70 |   76299457 |    99853 |   76282497 |   83910 |  -0.02223 |
|  100 |  104214393 |    38642 |  104212524 |  244424 |  -0.00179 |
| 1000 | 1016131215 |   245725 | 1017051744 | 2748280 |   0.09059 |
| 2000 | 2007711297 |  1325094 | 2007628922 | 1421807 |  -0.00410 |
+------+------------+----------+------------+---------+-----------+
- With the patch, the min sleep duration is never below the requested
   sleep duration

So indeed the penalty of using msleep is big for small sleep durations.

