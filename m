Return-Path: <linux-acpi+bounces-14789-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C377DAEBF56
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 20:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DEC56407FE
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 18:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA34F1EB9E1;
	Fri, 27 Jun 2025 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3J2Se7s"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC874502A;
	Fri, 27 Jun 2025 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751050616; cv=none; b=uFjE2miKyndMzp998St0Jm8G0cjQtrGYEe6Qky2xXc4z5Xl/rSwpq2ABB9kL1uCm+EDUw103sVremt81A+d1X6E7KcJLPp6c8MbKsR/Q2Gy/bO4fMfL5sQqwQme4mBcMLIPIdphnqGVzF4of7FvSV6ui8quUk2d0f9dN4OjylBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751050616; c=relaxed/simple;
	bh=fGV2wVghKES+xbgi0Xs1dP0uKuM39FmPdt9F2KRasSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZrG6xg1diG5a5Z+MVYpbTEle0xoorEdwx+Syj22BxecdvnVRvGYSXd6pajcNQDCmWxmTu55YEzOdkG9nbUHW5invRc+YyF6VR7MntoWPuMkwj3CKKytASzfhZojYjcSoHKUbhQrOybT4NvCGI5dvIPJ5jdx9GuyePZ+4Gfs6quw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3J2Se7s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CA3C4CEEB;
	Fri, 27 Jun 2025 18:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751050616;
	bh=fGV2wVghKES+xbgi0Xs1dP0uKuM39FmPdt9F2KRasSY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M3J2Se7s+lhwztpTSdc50WqWWde10nq0rDHwVeA8Q1/gEtpEps/KI5lltbjUfhCRf
	 BdLWvEUQKGx0ahk9ahvnQw8v5o0ubmyDGuH5DICkVevuUQEhnzLqbWQdB5H3CbQgP0
	 qxMnodDIOZybxWo0evk1ImbmQZZKTsXcWVPiEu7koR6d2ML5GtAHuyTrd4cl3yD4BS
	 cGijYgFsSxXh5vkvj53LgSn818DHwp+qkc5CGFgv3VtKdU/tvcSfL3Y+6tlTFqFARD
	 Ji2ZWRlXxT88YIbWRAyFi4qPFQqRY/BcANT9r1rt7u7DM0MPMyxGOB5Gr4kInf8vxT
	 piGXDU8Qao86Q==
Message-ID: <9f5e0c21-bc25-44d0-a4d4-6fd6e58a9f2e@kernel.org>
Date: Fri, 27 Jun 2025 13:56:53 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] Input: Don't send fake button presses to wake
 system
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Hans de Goede <hansg@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Mika Westerberg <westeri@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
 "open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..."
 <linux-input@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
References: <CAJZ5v0gKUN1OdqAHnXNcFUAOfhpdRfa_o=L6TA2GZTpe1bMaNQ@mail.gmail.com>
 <exmgckzoakt2ncsdphqvymcadon7k6tl36a3zvrj2pv23dffps@znq23v3qbcm2>
 <CAJZ5v0j3ZyuEqSKQ+3K8M3BwPCxn5Z6KOwjyjt4cJW6HfxjPDw@mail.gmail.com>
 <hyvpl4gvxc6h2r3itfofjduwb3vpobyo7a7z6g3zapzscqtafh@ixsd4amyljva>
 <de548b27-4c43-4f30-af9d-b060101e6fd8@kernel.org>
 <75fixx6rgwsgsw6e765oxdcivcg2nkzx2fp2qywgx4vi3ihywh@ot7gdecsnttw>
 <1b0d2349-dbf7-47aa-95c9-1974e63d111a@kernel.org>
 <13025910-7639-400b-878a-cd0780c6534c@kernel.org>
 <4ajmcrl3bqeikki2etek5bafzszelgevr322tvuubx4pxxyju2@qqxz6lzcb6e5>
 <fdd635ce-5e8e-4123-8e8e-241a57b4d7fe@kernel.org>
 <eaf7bva2skjz6oo2s2f4agooplthvuztyr6tssa7rux764qw35@kscd3rtejfvn>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <eaf7bva2skjz6oo2s2f4agooplthvuztyr6tssa7rux764qw35@kscd3rtejfvn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/27/2025 1:36 PM, Dmitry Torokhov wrote:
> On Fri, Jun 27, 2025 at 05:56:05PM +0200, Hans de Goede wrote:
>> Hi Dmitry,
>>
>> On 27-Jun-25 4:44 PM, Dmitry Torokhov wrote:
>>> On Fri, Jun 27, 2025 at 04:14:38PM +0200, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 27-Jun-25 4:06 PM, Mario Limonciello wrote:
>>>>> On 6/26/2025 11:56 PM, Dmitry Torokhov wrote:
>>>>>> On Thu, Jun 26, 2025 at 05:21:35PM -0500, Mario Limonciello wrote:
>>>>>>> On 6/26/2025 2:40 PM, Dmitry Torokhov wrote:
>>>>>>>> On Thu, Jun 26, 2025 at 09:31:12PM +0200, Rafael J. Wysocki wrote:
>>>>>>>>> On Thu, Jun 26, 2025 at 9:28 PM Dmitry Torokhov
>>>>>>>>> <dmitry.torokhov@gmail.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On Thu, Jun 26, 2025 at 09:18:56PM +0200, Rafael J. Wysocki wrote:
>>>>>>>>>>> On Thu, Jun 26, 2025 at 9:16 PM Hans de Goede <hansg@kernel.org> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> Hi,
>>>>>>>>>>>>
>>>>>>>>>>>> On 26-Jun-25 21:14, Dmitry Torokhov wrote:
>>>>>>>>>>>>> On Thu, Jun 26, 2025 at 08:57:30PM +0200, Hans de Goede wrote:
>>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On 26-Jun-25 20:48, Dmitry Torokhov wrote:
>>>>>>>>>>>>>>> On Thu, Jun 26, 2025 at 01:20:54PM -0500, Mario Limonciello wrote:
>>>>>>>>>> [...]
>>>>>>>>>>>>>>>> I want to note this driver works quite differently than how ACPI power
>>>>>>>>>>>>>>>> button does.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> You can see in acpi_button_notify() that the "keypress" is only forwarded
>>>>>>>>>>>>>>>> when not suspended [1].  Otherwise it's just wakeup event (which is what my
>>>>>>>>>>>>>>>> patch was modeling).
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> https://github.com/torvalds/linux/blob/v6.16-rc3/drivers/acpi/button.c#L461
>>>>>>>>>>>>>>>> [1]
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> If you check acpi_button_resume() you will see that the events are sent
>>>>>>>>>>>>>>> from there. Except that for some reason they chose to use KEY_WAKEUP and
>>>>>>>>>>>>>>> not KEY_POWER, oh well. Unlike acpi button driver gpio_keys is used on
>>>>>>>>>>>>>>> multiple other platforms.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Interesting, but the ACPI button code presumably only does this on resume
>>>>>>>>>>>>>> for a normal press while the system is awake it does use KEY_POWER, right ?
>>>>>>>>>>>>>
>>>>>>>>>>>>> Yes. It is unclear to me why they chose to mangle the event on wakeup,
>>>>>>>>>>>>> it does not seem to be captured in the email discussions or in the patch
>>>>>>>>>>>>> description.
>>>>>>>>>>>>
>>>>>>>>>>>> I assume they did this to avoid the immediate re-suspend on wakeup by
>>>>>>>>>>>> power-button issue. GNOME has a workaround for this, but I assume that
>>>>>>>>>>>> some userspace desktop environments are still going to have a problem
>>>>>>>>>>>> with this.
>>>>>>>>>>>
>>>>>>>>>>> It was done for this reason IIRC, but it should have been documented
>>>>>>>>>>> more thoroughly.
>>>>>>>>>>
>>>>>>>>>> I assert that it should not have been done and instead dealt with in
>>>>>>>>>> userspace. There are numerous drivers in the kernel emitting
>>>>>>>>>> KEY_POWER. Let userspace decide how to handle this, what keys to ignore,
>>>>>>>>>> what keys to process and when.
>>>>>>>>>
>>>>>>>>> Please see my last message in this thread (just sent) and see the
>>>>>>>>> changelog of commit 16f70feaabe9 ("ACPI: button: trigger wakeup key
>>>>>>>>> events").
>>>>>>>>>
>>>>>>>>> This appears to be about cases when no event would be signaled to user
>>>>>>>>> space at all (power button wakeup from ACPI S3).
>>>>>>>>
>>>>>>>> Ahh, in S3 we do not know if we've been woken up with Sleep or Power
>>>>>>>> button, right? So we can not send the "right" event code and use
>>>>>>>> "neutral" KEY_WAKEUP for both. Is this right?
>>>>>>>>
>>>>>>>> Thanks.
>>>>>>>>
>>>>>>>
>>>>>>> I did some more experiments with this affected system that started this
>>>>>>> thread (which uses s2idle).
>>>>>>>
>>>>>>> I only applied patch 3 in this series to help the debounce behavior and
>>>>>>> figure out impacts from patch 4 with existing Linux userspace.
>>>>>>>
>>>>>>> If suspended using systemd in GNOME (click the GUI button) on Ubuntu 24.04
>>>>>>> the GNOME workaround mitigates this problem and no visible impact.
>>>>>>>
>>>>>>> If I suspend by hand using the kernel interface and then press power button
>>>>>>> to wake:
>>>>>>>
>>>>>>> # echo mem | sudo tee /sys/power/state:
>>>>>>>
>>>>>>> * When GNOME is running:
>>>>>>> I get the shutdown popup and it eventually shuts down.
>>>>>>>
>>>>>>> * When GNOME isn't running (just on a VT):
>>>>>>> System shuts down.
>>>>>>
>>>>>> For the latter you may want to raise an issue with systemd, and for the
>>>>>> former I guess it is being too clever and does not activate the
>>>>>> workaround if suspend was not initiated by it? I think Gnome is being
>>>>>> too careful.
>>>>>>
>>>>>> Thanks.
>>>>>>
>>>>>
>>>>> Sure I could file bugs with both the projects.
>>>>>
>>>>> But before I do if all userspace needs to account for this with a series of workarounds at resume time, you still think that is that really the best way forward?
>>>>>
>>>>> Hans, you have a lot of experience in the GNOME community.  Your thoughts?
>>>>
>>>> I guess it would be good to fix this in the kernel, sending
>>>> KEY_WAKEUP from gpio_key when the event is KEY_POWER and
>>>> we are going through the special wakeup path in gpio_keys.
>>>>
>>>> When this was discussed quite a while ago the ACPI button
>>>> driver simply did not send any event at all on wkaeup
>>>> by ACPI power-button. Know that it does send an event
>>>> it would be good to mimic this, at least when the gpio_key
>>>> devices where instantiated by soc_button_array.
>>>>
>>>> So maybe add a new field to struct gpio_keys_button
>>>> called wakeup_code and when that is not 0 use that
>>>> instead of the plain "code" member on wakeups ?
>>>>
>>>> That would keep the gpio_keys code generic while
>>>> allowing to mimic the ACPI button behavior.
>>>>
>>>> And then set wakeup_code to KEY_WAKEUP for
>>>> the power-button in soc_button_array.
>>>>
>>>> To me this sounds better then trying to fix all userspace
>>>> code which does something on KEY_POWER of which there
>>>> is quite a lot.
>>>>
>>>> The special GNOME power-button handling was always
>>>> a workaround because last time a kernel fix was
>>>> nacked. But now with the KEY_WAKEUP done by the ACPI
>>>> button code it looks like we do have a good way
>>>> to fix this in the kernel, so that would be better
>>>> IMHO.
>>>>
>>>> Dmitry, what do you think of adding a wakeup_code
>>>> field to struct gpio_keys_button and let the code
>>>> creating the gpio_keys_button decide if a different
>>>> code should be used on wakeup or not ?
>>>
>>> And what is the plan on dealing with all other drivers that emit
>>> KEY_POWER?
>>
>> There actually aren't that many that I'm aware of.
> 
> dtor@dtor-ws:~/kernel/work $ git grep -l KEY_POWER -- drivers/{input,hid,platform}/ | wc -l
> 51
> 
> Additionally:
> 
> dtor@dtor-ws:~/kernel/work $ git grep -l KEY_POWER -- arch/arm*/boot/dts | wc -l
> 254
> 
>>
>> Note that this gpio_keys KEY_POWER evdev event generation
>> on resume issue goes way back until the last time we had
>> this conversation and it still has not really been fixed.
> 
> I am sorry to hear that. I am not involved in Gnome so I am not sure why
> it takes so long, I guess not tablets or detachables are a minority of
> deployments so it is not prioritized? Android seems to have a handle on
> this as does Chrome OS...
> 
>>
>> And I've not seen any bug-reports about the same problem
>> with any other drivers.
> 
> I guess you will next want to patch cros_ec_keyb in case someone uses
> generic distro with x86 Chromebooks, and then matrix keypad, and then
> all drivers that are used outside of x86.
> 
>>
>>> What about acpi button behavior when using S0ix?
>>
>> AFAIK it is the same as with S3, at least it is not
>> causing any issues. I've never seen the ACPI button code
>> cause re-suspend immediately on wakeup by what for all
>> intends and purposes is a spurious KEY_POWER event.
> 
> Rafael has made assertion that in S3 it is impossible to differentiate
> whether the button is power button or not. But looking at this I do not
> think it is correct assertion. "Notify Wake" is sent for a given
> button. Or maybe I misunderstood and he meant that the *state* if button
> is not available in "Notify Wake"?
> 
> In fact, I think login in the ACPI button is pretty broken and needs to
> be undone/reverted:
> 
> 1. The driver sends KEY_WAKEUP events on every resume. It does not
> matter if wakeup is done by pressing power button, wake or lan packet,
> or an act of God, it will send KEY_WAKEUP as part of the button *device*
> resume.

This seems like a real bug.  IMO you're right it should only be sending 
it when the key was received.

> 
> 2. There is a patch from Mario (a8605b0ed187) suppressing sending
> KEY_POWER as part of "normal" wakeup handling, pretty much the same as
> what he and you are proposing to do in gpio-keys (and eventually in
> every driver keyboard or button driver in the kernel). This means we no
> longer can tell if wakeup is done by power button or sleep button (on
> systems with dual-button models, see ACPI 4.8.3.1).

Actually a8605b0ed187 was about a runtime regression not a suspend 
regression.  I didn't change anything with sending KEY_POWER during 
wakeup handling.

> 
> To me it seems we are piling workarounds on top of workarounds. We
> should report either KEY_POWER or KEY_SLEEP in the notify event for both
> "Notify Wake" and "Notify State", and let userspace make decision on how
> to handle this best.
> 
>>
>> Last time we discussed this I wasn't really happy with
>> the outcome of the discussion but I just went for it
>> because of Android's reliance on the event and we
>> lacked a better plan.
>>
>> Now that we've a fix for this in the form of KEY_WAKEUP
>> it is time to properly fix this instead of doing userspace
>> kludges.
> 
> I do not understand why you call KEY_WAKEUP being "proper". Especially
> with gpio-keys you do not know if wakeup is really due to this
> particular button being pressed, or the system woke up for some other
> reason and user also happened to have the button pressed. ACPI button is
> really an outlier here because firmware interface defines a dedicated
> event for waking up.
> 
>>
>>> What about
>>> holding power button for too long so that normal reporting "catches" the
>>> pressed state?
>>
>> The key-down event is send as KEY_WAKEUP instead,
>> so userspace sees KEY_WAKEUP pressed not KEY_POWER.
> 
> This assumes the driver does not report state between press and release,
> which is not guaranteed. Or we now require drivers to keep track whether
> release for KEY_WAKEUP has been done and that it can return to reporting
> KEY_POWER.
> 
>>
>>> Kernel reports hardware events, interpreting them and applying certain
>>> policies is task for userspace.
>>
>> And atm it is actually doing a shitty job of reporting
>> hwevents because there is no way for userspace to be able
>> to differentiate between:
>>
>> 1. User pressed power-button to wakeup system
>> 2. User pressed power-button after resume to do
>>     power-button-action (e.g. suspend system)
>>
>> Even though *the kernel* does *know* the difference.
> 
> Does it really? Aside of ACPI button you have no idea if button press
> coincided with some other event waking up the system. You can guess, but
> that is it, a guess.
> 
>>
>> So the suggested change actually makes the kernel
>> do its job of reporting hw-events better by making
>> the reporting more accurate.
> 
> No, you are making assumptions, but instead of doing it in userspace
> where you can give user choice to adjust the behavior you are
> hard-coding it.
> 
>>
>> ATM if I resume say a tablet with GNOME and then
>> change my mind and press the power button within
>> 3 seconds of resume to suspend it again the second
>> power-button press will outright be ignored
> 
> Please fix Gnome. It is possible to handle rapid power button presses
> (because other OSed/environments do that).
> 
>>
>> The current userspace workaround is racy like this,
>> again the whole workaround in GNOME is just an ugly
>> kludge which I did back then because we couldn't
>> agree on a better way to deal with this in the kernel /
>> because just suppressing sending KEY_POWER would break
>> Android.
>>
>> The suggested use of KEY_WAKEUP is lightyears better
>> then doing ignore KEY_POWER events for xx seconds
>> after resume which is simply always going to be racy
>> and always was just an ugly hack / never was
>> a great solution.
> 
> My opinion is that KEY_WAKEUP is not much better and we are actually
> losing information if we try to implement that (again, because you do
> not know if button press was the real cause of wakeup or it simply
> coincided with something else).
> 
> Thanks.
> 

FTR I did test Hans suggestion and it does work effectively (code below).

diff --git a/drivers/input/keyboard/gpio_keys.c 
b/drivers/input/keyboard/gpio_keys.c
index f9db86da0818b..3bc8c95e9943b 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -425,7 +425,8 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void 
*dev_id)
                          * already released by the time we got interrupt
                          * handler to run.
                          */
-                       input_report_key(bdata->input, button->code, 1);
+                       input_report_key(bdata->input, *bdata->code, 1);
+                       input_sync(bdata->input);
                 }
         }

@@ -644,6 +645,14 @@ static int gpio_keys_setup_key(struct 
platform_device *pdev,
         bdata->code = &ddata->keymap[idx];
         *bdata->code = button->code;
         input_set_capability(input, button->type ?: EV_KEY, *bdata->code);
+       if (button->wakeup_code) {
+               /*
+                * If wakeup_code is specified, we use it to report
+                * the button press during resume from suspend.
+                */
+               input_set_capability(input, button->type ?: EV_KEY,
+                                    button->wakeup_code);
+       }

         /*
          * Install custom action to cancel release timer and
@@ -1009,6 +1018,8 @@ gpio_keys_enable_wakeup(struct gpio_keys_drvdata 
*ddata)
                         if (error)
                                 goto err_out;
                 }
+               *bdata->code = bdata->button->wakeup_code ?
+                              bdata->button->wakeup_code : 
bdata->button->code;
                 bdata->suspended = true;
         }

@@ -1034,6 +1045,7 @@ gpio_keys_disable_wakeup(struct gpio_keys_drvdata 
*ddata)
         for (i = 0; i < ddata->pdata->nbuttons; i++) {
                 bdata = &ddata->data[i];
                 bdata->suspended = false;
+               *bdata->code = bdata->button->code;
                 if (irqd_is_wakeup_set(irq_get_irq_data(bdata->irq)))
                         gpio_keys_button_disable_wakeup(bdata);
         }
diff --git a/drivers/input/misc/soc_button_array.c 
b/drivers/input/misc/soc_button_array.c
index b8cad415c62ca..7afebc23b6f85 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -216,6 +216,8 @@ soc_button_device_create(struct platform_device *pdev,

                 gpio_keys[n_buttons].type = info->event_type;
                 gpio_keys[n_buttons].code = info->event_code;
+               if (info->event_code == KEY_POWER)
+                       gpio_keys[n_buttons].wakeup_code = KEY_WAKEUP;
                 gpio_keys[n_buttons].active_low = info->active_low;
                 gpio_keys[n_buttons].desc = info->name;
                 gpio_keys[n_buttons].wakeup = info->wakeup;
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index 80fa930b04c67..9759f2d4015f9 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -22,6 +22,7 @@ struct device;
   * @value:             axis value for %EV_ABS
   * @irq:               Irq number in case of interrupt keys
   * @wakeirq:           Optional dedicated wake-up interrupt
+ * @wakeup_code:       code to report when the button is during resume 
from suspend
   */
  struct gpio_keys_button {
         unsigned int code;
@@ -36,6 +37,7 @@ struct gpio_keys_button {
         int value;
         unsigned int irq;
         unsigned int wakeirq;
+       unsigned int wakeup_code;
  };

  /**

