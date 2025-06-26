Return-Path: <linux-acpi+bounces-14752-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1CCAEA8EC
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 23:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 673513BAC24
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 21:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5391625F985;
	Thu, 26 Jun 2025 21:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxRRdYeQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6D021B91F;
	Thu, 26 Jun 2025 21:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750973979; cv=none; b=Q4ypz9XxeVNNSq2hmd6tuJqGwadi2oAdF/q+dB/WLaT3l7odYPYw1fxLS5LTEDamAA0LQpxad0x10IiLcKu5c/pRQwc7OpsN11KlxVql3HYnOIJZ+MWEwbw7jsnXIc1uK0i1pQH+Mbgx1+5qhQpq4dnCLY6vc1PVTyXMhJsdb8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750973979; c=relaxed/simple;
	bh=Nz2jVvW7wO9Ij5hiZw9zZN5i8COpgPRaAQssyAZqtDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ClZxJDpzw6SXWvjHGV9phrH/ncV8HwLr1KP0xm0dhc710l+sdsz8/i7LqcgbAcwVNUiZ8xciZqwyUueq2WQH3VhAAK/uQQn0xzCPXOFX0ChxbZd0jYz+a2vQwhTaQETARuXGGEEdV51PzV41omdLulgeSPKG93JDaTM3bAveSas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxRRdYeQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F33C4CEEF;
	Thu, 26 Jun 2025 21:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750973976;
	bh=Nz2jVvW7wO9Ij5hiZw9zZN5i8COpgPRaAQssyAZqtDs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IxRRdYeQyv9NBNR6rNQcw0DM5gPTjCLsCpdfUKcd4geT+ihlaAv0CbTmCFR6qEkjD
	 58JeEqQMvAVE1rP0qgZ38pWOLKshdRJq1IsVoRnPKX6ua2VAL859sFEZHM9LkYhqrb
	 +24UMiLRX3hjtt33EvzbVpcjXaaL4pRh+LWuTOUOFVPNjiVOLhP0TuCiSl8gRJSHmb
	 AxrsQhZXLA0o019PxXrsxFa4sX7VAxcao8n2J9Gd/abWwCJKozYayBTP53zXMUnuvI
	 +idFgQYhU1111GpMh1+b0ZqJj9qUslbajdWe7LutL120smoAiQKHHiAEdaYWyDdSAT
	 Iq45ItSgBuF2Q==
Message-ID: <90ff69f1-0308-4591-9374-5319922f0870@kernel.org>
Date: Thu, 26 Jun 2025 16:39:34 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] Input: soc_button_array: Only debounce cherryview
 and baytrail systems
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>, Mika Westerberg <westeri@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
 "open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..."
 <linux-input@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
References: <f5e1d50f-d85e-45a3-a131-f2da603c620c@kernel.org>
 <57e9b1d5-faf1-4c7a-87fc-047e0dc102f9@kernel.org>
 <a9bed0b4-b050-468b-91cb-bc4c81352046@kernel.org>
 <8fc9051f-bef3-43fc-83a1-172a0eb599dc@kernel.org>
 <du46jt3mmkvceestjadbqmxbztp5xcurg4pzwzmqavo3pnfmak@tcfnufcu6de5>
 <55b4cd56-1812-4048-bf16-4b5b94a842d7@kernel.org>
 <vmjnwfg2mqr2anugefjtzezimcep27gi64d4wsctiu476w73rl@oo6r4o33jk44>
 <06ad432d-e138-4457-8180-bc35f08feed6@kernel.org>
 <blkvhrhch4y7psjqi6mlpn4q2qqrggwosw47plwizbxnjvlh5o@dux3as52kbqd>
 <5297e128-1906-4617-9c6c-f16498ef4907@kernel.org>
 <mkgtrb5gt7miyg6kvqdlbu4nj3elym6ijudobpdi26gp4xxay5@rsa6ytrjvj2q>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <mkgtrb5gt7miyg6kvqdlbu4nj3elym6ijudobpdi26gp4xxay5@rsa6ytrjvj2q>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/26/2025 2:54 PM, Dmitry Torokhov wrote:
> On Thu, Jun 26, 2025 at 02:37:19PM -0500, Mario Limonciello wrote:
>> On 6/26/2025 2:32 PM, Dmitry Torokhov wrote:
>>> On Thu, Jun 26, 2025 at 09:04:22PM +0200, Hans de Goede wrote:
>>>> Hi Dmitry,
>>>>
>>>> On 26-Jun-25 20:53, Dmitry Torokhov wrote:
>>>>> On Thu, Jun 26, 2025 at 01:30:15PM -0500, Mario Limonciello wrote:
>>>>>> On 6/26/2025 1:27 PM, Dmitry Torokhov wrote:
>>>>>>> On Wed, Jun 25, 2025 at 03:34:07PM -0500, Mario Limonciello wrote:
>>>>>>>> On 6/25/25 2:42 PM, Hans de Goede wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> On 25-Jun-25 9:23 PM, Mario Limonciello wrote:
>>>>>>>>>> On 6/25/25 2:03 PM, Hans de Goede wrote:
>>>>>>>>>>> Hi,
>>>>>>>>>>>
>>>>>>>>>>> On 25-Jun-25 8:13 PM, Mario Limonciello wrote:
>>>>>>>>>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>>>>>>>>>
>>>>>>>>>>>> commit 5c4fa2a6da7fb ("Input: soc_button_array - debounce the buttons")
>>>>>>>>>>>> hardcoded all soc-button-array devices to use a 50ms debounce timeout
>>>>>>>>>>>> but this doesn't work on all hardware.  The hardware I have on hand
>>>>>>>>>>>> actually prescribes in the ASL that the timeout should be 0:
>>>>>>>>>>>>
>>>>>>>>>>>> GpioInt (Edge, ActiveBoth, Exclusive, PullUp, 0x0000,
>>>>>>>>>>>>               "\\_SB.GPIO", 0x00, ResourceConsumer, ,)
>>>>>>>>>>>> {   // Pin list
>>>>>>>>>>>>          0x0000
>>>>>>>>>>>> }
>>>>>>>>>>>>
>>>>>>>>>>>> Many cherryview and baytrail systems don't have accurate values in the
>>>>>>>>>>>> ASL for debouncing and thus use software debouncing in gpio_keys. The
>>>>>>>>>>>> value to use is programmed in soc_button_array.  Detect Cherry View
>>>>>>>>>>>> and Baytrail using ACPI HID IDs used for those GPIO controllers and apply
>>>>>>>>>>>> the 50ms only for those systems.
>>>>>>>>>>>>
>>>>>>>>>>>> Cc: Hans de Goede <hansg@kernel.org>
>>>>>>>>>>>> Fixes: 5c4fa2a6da7fb ("Input: soc_button_array - debounce the buttons")
>>>>>>>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>>>>>>>
>>>>>>>>>>> I'm not a fan of this approach, I believe that we need to always debounce
>>>>>>>>>>> when dealing with mechanical buttons otherwise we will get unreliable /
>>>>>>>>>>> spurious input events.
>>>>>>>>>>>
>>>>>>>>>>> My suggestion to deal with the issue where setting up debouncing at
>>>>>>>>>>> the GPIO controller level is causing issues is to always use software
>>>>>>>>>>> debouncing (which I suspect is what Windows does).
>>>>>>>>>>>
>>>>>>>>>>> Let me copy and pasting my reply from the v1 thread with
>>>>>>>>>>> a bit more detail on my proposal:
>>>>>>>>>>>
>>>>>>>>>>> My proposal is to add a "no_hw_debounce" flag to
>>>>>>>>>>> struct gpio_keys_platform_data and make the soc_button_array
>>>>>>>>>>> driver set that regardless of which platform it is running on.
>>>>>>>>>>>
>>>>>>>>>>> And then in gpio_keys.c do something like this:
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
>>>>>>>>>>> index f9db86da0818..2788d1e5782c 100644
>>>>>>>>>>> --- a/drivers/input/keyboard/gpio_keys.c
>>>>>>>>>>> +++ b/drivers/input/keyboard/gpio_keys.c
>>>>>>>>>>> @@ -552,8 +552,11 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>>>>>>>>>>>               bool active_low = gpiod_is_active_low(bdata->gpiod);
>>>>>>>>>>>                 if (button->debounce_interval) {
>>>>>>>>>>> -            error = gpiod_set_debounce(bdata->gpiod,
>>>>>>>>>>> -                    button->debounce_interval * 1000);
>>>>>>>>>>> +            if (ddata->pdata->no_hw_debounce)
>>>>>>>>>>> +                error = -EINVAL;
>>>>>>>>>>> +            else
>>>>>>>>>>> +                error = gpiod_set_debounce(bdata->gpiod,
>>>>>>>>>>> +                        button->debounce_interval * 1000);
>>>>>>>>>>>                   /* use timer if gpiolib doesn't provide debounce */
>>>>>>>>>>>                   if (error < 0)
>>>>>>>>>>>                       bdata->software_debounce =
>>>>>>>>>>>
>>>>>>>>>>> So keep debouncing, as that will always be necessary when dealing with
>>>>>>>>>>> mechanical buttons, but always use software debouncing to avoid issues
>>>>>>>>>>> like the issue you are seeing.
>>>>>>>>>>>
>>>>>>>>>>> My mention of the BYT/CHT behavior in my previous email was to point
>>>>>>>>>>> out that those already always use software debouncing for the 50 ms
>>>>>>>>>>> debounce-period. It was *not* my intention to suggest to solve this
>>>>>>>>>>> with platform specific quirks/behavior.
>>>>>>>>>>>
>>>>>>>>>>> Regards,
>>>>>>>>>>>
>>>>>>>>>>> Hans
>>>>>>>>>>
>>>>>>>>>> I mentioned on the v1 too, but let's shift conversation here.
>>>>>>>>>
>>>>>>>>> Ack.
>>>>>>>>>
>>>>>>>>>> So essentially all platforms using soc_button_array would always turn on software debouncing of 50ms?
>>>>>>>>>
>>>>>>>>> Yes that is what my proposal entails.
>>>>>>>>>
>>>>>>>>>> In that case what happens if the hardware debounce was ALSO set from the ASL?  You end up with double debouncing I would expect.
>>>>>>>>>
>>>>>>>>> A hardware debounce of say 25 ms would still report the button down
>>>>>>>>> immediately, it just won't report any state changes for 25 ms
>>>>>>>>> after that, at least that is how I would expect this to work.
>>>>>>>>>
>>>>>>>>> So the 50 ms ignore-button-releases for the sw debounce will start
>>>>>>>>> at the same time as the hw ignore-button-release window and basically
>>>>>>>>> the longest window will win. So having both active should not really
>>>>>>>>> cause any problems.
>>>>>>>>>
>>>>>>>>> Still only using one or the other as you propose below would
>>>>>>>>> be better.
>>>>>>>>>
>>>>>>>>>> Shouldn't you only turn on software debouncing when it's required?
>>>>>>>>>>
>>>>>>>>>> I'm wondering if considering the first two patches we should have gpio-keys look up if hardware can support debounce, and then "only if it can't" we program the value from soc button array.
>>>>>>>>>>
>>>>>>>>>> It can be done by having gpio_keys do a "get()" on debounce.  Iff the driver returns -ENOTSUPP /then/ program the software debounce.
>>>>>>>>>
>>>>>>>>> Any special handling here should be done in soc_button_array since
>>>>>>>>> this is specific to how with ACPI we have the GPIO resource
>>>>>>>>> descriptors setting up the hw-debounce and then the need to do
>>>>>>>>> software debounce when that was not setup.
>>>>>>>>>
>>>>>>>>> As for checking for -ENOTSUPP I would make soc_button_array
>>>>>>>>> do something like this.
>>>>>>>>>
>>>>>>>>> ret = debounce_get()
>>>>>>>>> if (ret <= 0)
>>>>>>>>> 	use-sw-debounce;
>>>>>>>>>
>>>>>>>>> If hw-debounce is supported but not setup, either because
>>>>>>>>> the exact debounce value being requested is not supported
>>>>>>>>> or because the DSDT specified 0, then sw-debouncing should
>>>>>>>>> also be used.
>>>>>>>>>
>>>>>>>>> Note this will still require the use of a new no_hw_debounce
>>>>>>>>> flag so that we don't end up enabling hw-debounce in
>>>>>>>>> the hw-debounce is supported but not setup case.
>>>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>>
>>>>>>>>> Hans
>>>>>>>>>
>>>>>>>>
>>>>>>>> I did some experiments with your proposal (letting SW debounce get
>>>>>>>> programmed) and everything seems to work fine*.  I think you're right that
>>>>>>>> setting a double debounce would be worst one wins.
>>>>>>>
>>>>>>> I am confused, can you explain why do we need this new no_hw_debounce
>>>>>>> flag? If AMD gpio driver is unable to program 50 ms debounce for a given
>>>>>>> pin but does not return an error (or returns an error but leaves system
>>>>>>> in a bad state) that is the issue in that driver and needs to be fixed
>>>>>>> there? Why do we need to change soc_button_driver at all?
>>>>>>>
>>>>>>> Thanks.
>>>>>>>
>>>>>>
>>>>>> The requested 50ms HW debounce gets programmed to the hardware register
>>>>>> successfully.  It is within bound that the GPIO controller can support.
>>>>>>
>>>>>> The problem is the power button does not function with a 50ms debounce.
>>>>>> The firmware asserted that 0ms should have been programmed (by the _CRS
>>>>>> value in GpioInt).
>>>>>
>>>>> I do not understand how debounce that is within the controller's
>>>>> supported range can not work. The button is a switch that reports on and
>>>>> off, there is nothing more to it, is there?
>>>>>
>>>>> I feel there is a deeper problem that we simply trying to paper over.
>>>>
>>>> Note that on x86 wakeup events and GPIO IRQs typically use a different
>>>> event mechanism / path under the hood (PME events to resume from suspend).
>>>> It is not just a case of marking the IRQ used while running as a wakeup
>>>> source.
>>>>
>>>> So it is possible that setting the hw-debouncing is in some way interfering
>>>> with the reporting of x86 PME events while the system is suspended.
>>>
>>> Still this looks like platform issue, not driver issue. Should GPIO
>>> driver refuse programming debounce if pin is configured as potential
>>> wakeup source then?
>>
>> How can the driver intricate details about the hardware connected to the
>> GPIO and how it behaves?
>>
>> The driver is "dumb" and programs the registers according to the calls given
>> to it.
> 
> I do not think driver needs to know details of hardware connected to
> GPIO. I know you mentioned that it may be connected to an EC that does
> its own debouncing, however this should make no difference from AP
> standpoint: you are still dealing with a GPIO line and your GPIO
> controller does debouncing for that line (which may be unnecessary
> because the line will not be bouncing).
> 
> Hans mentioned that it is possible that this debounce interferes with
> the platform reporting wakeup events. I can easily believe that. But
> that means that if there is another peripheral device similarly attached
> to such GPIO configured for wakeup, device that does not use gpio_keys
> driver, it will have the same issue. And I wonder if the solution is for
> your GPIO provider driver to refuse programming debounce for GPIOs that
> are marked as wake capable.

Hmm; how would we guarantee there was no regressions for other systems 
with such a heuristics change?

IE what if there is a system that doesn't use soc-button-array and has a 
non-zero debounce value in the GpioInt from _AEI() and is wake capable? 
"Today" that would be programmed to the GPIO register.

If we're aiming for a driver specific heuristic another alternative is 
to clear debounce for everything at suspend and restore it at resume.

I actually did that and it seems to work fine on this affected system, 
so I'll draft it up as an alternative to patch v3 3/4.

> 
>>
>>>
>>>>
>>>> Most systems where soc_button_array is used don't support hw-debouncing
>>>> in the first place, so on most systems this change is a no-op.
>>>
>>> The change is not limited to soc_button_array driver, we need to add
>>> flags to gpio_keys as well...
>>
>> That's exactly what the patch v3 3/4 is doing.
> 
> What I was trying to say is that we are not only touching
> soc_button_array driver but also have to make changes to more generic
> gpio_keys driver which I would like to avoid if possible.
> 
> Thanks.
> 


