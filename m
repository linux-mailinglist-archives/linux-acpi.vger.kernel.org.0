Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0674BBD36
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Feb 2022 17:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237625AbiBRQQF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Feb 2022 11:16:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237617AbiBRQQE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Feb 2022 11:16:04 -0500
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0662B3198
        for <linux-acpi@vger.kernel.org>; Fri, 18 Feb 2022 08:15:46 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2d641c31776so71448477b3.12
        for <linux-acpi@vger.kernel.org>; Fri, 18 Feb 2022 08:15:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CPxoXK0/olmWwbkZqNK914sbd4kj5aD/Pd8VowNos4o=;
        b=qcJvnHQ2APZYaYJajK69KzOKj3HBF+rMjv5YTi6C2fxbEGtpgAlWBCZ9eoqS0Mn0ii
         7iOe3vmHZlD+YrZRHO52Ma8Qhew5jO7wWvs0yNinzLvtfym48UkGYUcMdwSFKIM2ice6
         mSY/IJSVVfXUvx9KMVP5vLtfB+WxKDsogjxdgil2I9ssPZYskTX4LH4kCMlmvtocBM5J
         xC6F431k0ABq/NODVQ4NEJcwSlXGkl3d16+wBqdXhrpIfZTLKOPQ62s2Mzgxtd6Wt1an
         yZI6JbxbiTNxcECNOUEjESgSSn6a2EuSocbhWRN0c9QRREv/QBdHT+0mkJS+d5HE2GX0
         jCVA==
X-Gm-Message-State: AOAM530q4n+vE4sPGWnMUpsLTLsoV8Cs1XgVQTagex+Och4GNx21c9Mo
        o5plBIKsSjux6DI4lNBUfSy+ehQeygBTut4KUd8=
X-Google-Smtp-Source: ABdhPJzLgNLzO/j7ReENn6110Bnnm5j/7BENJx0PhWrqhHQSJQSshMVcOyFeH8WtRfS1c3AFl1AMk7i5M2naNy1Ce2w=
X-Received: by 2002:a81:b65f:0:b0:2d6:d29c:63fd with SMTP id
 h31-20020a81b65f000000b002d6d29c63fdmr2167750ywk.196.1645200945120; Fri, 18
 Feb 2022 08:15:45 -0800 (PST)
MIME-Version: 1.0
References: <BL1PR12MB5157C5EA5510F0C9D7782AE8E2369@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0g81BmytcjgChXZumsHV5-byzSzDQbp2hc6CYzJ_6N=aw@mail.gmail.com> <BL1PR12MB5157E2CDD68BA585C5F4CF2BE2369@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5157E2CDD68BA585C5F4CF2BE2369@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Feb 2022 17:15:34 +0100
Message-ID: <CAJZ5v0ho8PHGp0gAUp5KkUstTXLyUMsaQ7wTL=8xDJtjtXjPRw@mail.gmail.com>
Subject: Re: Regression in 5.16-rc1 with suspend to idle
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000eb460805d84d310f"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

--000000000000eb460805d84d310f
Content-Type: text/plain; charset="UTF-8"

On Thu, Feb 17, 2022 at 9:16 PM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [Public]
>
> > > I've found recently that on kernel 5.17-rc4 some OEM AMD laptops are
> > shutting down when entering suspend to idle.
> >
> > Interesting.  Can you identify the exact point when the shutdown occurs?
>
> It looks like it's a platform firmware crash that causes the shutdown not a kernel
> crash.

It looks like we'll need to quirk the system in question then.

> > > What would you suggest to be done in this case?  Revert both commits?  Or
> > would you prefer to have a fixup on top
> > > of that?
> >
> > I would prefer to fix the problem on top of the current 5.16-rc.
> >
>
> Here is the minimal patch I can come up with on top of 5.17-rc4 that fixes it:
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 04ea92cbd9cf..f5bf46782043 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -32,6 +32,7 @@
>  #include <linux/suspend.h>
>  #include <trace/events/power.h>
>  #include <linux/cpufreq.h>
> +#include <linux/cpuidle.h>
>  #include <linux/devfreq.h>
>  #include <linux/timer.h>
>
> @@ -1350,6 +1351,8 @@ int dpm_suspend_noirq(pm_message_t state)
>  {
>         int ret;
>
> +       cpuidle_pause();

Can you replace this with wake_up_all_idle_cpus() and remove the
cpuidle_resume()/cpuidle_pause() calls from s2idle_enter() and see
what happens?

> +
>         device_wakeup_arm_wake_irqs();
>         suspend_device_irqs();
>
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 6fcdee7e87a5..1708a643ba5d 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -97,6 +97,7 @@ static void s2idle_enter(void)
>         raw_spin_unlock_irq(&s2idle_lock);
>
>         cpus_read_lock();
> +       cpuidle_resume();
>
>         /* Push all the CPUs into the idle loop. */
>         wake_up_all_idle_cpus();
> @@ -104,6 +105,7 @@ static void s2idle_enter(void)
>         swait_event_exclusive(s2idle_wait_head,
>                     s2idle_state == S2IDLE_STATE_WAKE);
>
> +       cpuidle_pause();
>         cpus_read_unlock();
>
>         raw_spin_lock_irq(&s2idle_lock);
>
>
> * Removing the cpuidle_pause call from s2idle_enter will fix the crash,
>   but the system doesn't enter the deepest sleep state.

I think you mean that removing it doesn't make a difference except
that it prevents the deepest state from being entered.

Pausing cpuidle here is kind of redundant, because it just flips the
"initialized" flag that's going to be flipped again by
cpuidle_resume() in the next iteration.  [BTW, your patch is missing
one an additional cpuidle_resume() in the resume path to match this
cpuidle_pause().]  Also calling  wake_up_all_idle_cpus() is not likely
to make a difference, so I'm guessing that synchronize_rcu() does the
trick.

> * removing the cpuidle_pause call from dpm_suspend_noirq the firmware continues to
>    crash.

So the crash occurs while running dpm_suspend_noirq().

> I also confirmed that reverting both of these commits together on top of 5.17-rc4 fixes it:
>
> 8d89835b0467 ("PM: suspend: Do not pause cpuidle in the suspend-to-idle path")
> 23f62d7ab25b ("PM: sleep: Pause cpuidle later and resume it earlier during system transitions")
>
> The commit messages at least make it sound like it was just a rework for unification of the codepaths,
> not supposed to be for anything to be actually fixed, so I would think it should be safe to revert.

There is a deeper issue related to these commits and I'm not inclined
to go back to the old code if there is only one system affected by
this and the problem is related to the platform firmware on that
system.

> So please advise which way you want to go and I'll send up a patch (or if you want to write one
> I'm happy to take it and test it since I can readily reproduce it).

To start with, please test the attached debug patch on top of -rc4.

--000000000000eb460805d84d310f
Content-Type: text/x-patch; charset="US-ASCII"; name="pm-suspend-cpuidle-debug.patch"
Content-Disposition: attachment; filename="pm-suspend-cpuidle-debug.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kzsm4qn50>
X-Attachment-Id: f_kzsm4qn50

LS0tCiBkcml2ZXJzL2Jhc2UvcG93ZXIvbWFpbi5jIHwgICAgNiArKysrKysKIDEgZmlsZSBjaGFu
Z2VkLCA2IGluc2VydGlvbnMoKykKCkluZGV4OiBsaW51eC1wbS9kcml2ZXJzL2Jhc2UvcG93ZXIv
bWFpbi5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LXBtLm9yaWcvZHJpdmVycy9iYXNlL3Bvd2VyL21h
aW4uYworKysgbGludXgtcG0vZHJpdmVycy9iYXNlL3Bvd2VyL21haW4uYwpAQCAtMzIsNiArMzIs
NyBAQAogI2luY2x1ZGUgPGxpbnV4L3N1c3BlbmQuaD4KICNpbmNsdWRlIDx0cmFjZS9ldmVudHMv
cG93ZXIuaD4KICNpbmNsdWRlIDxsaW51eC9jcHVmcmVxLmg+CisjaW5jbHVkZSA8bGludXgvY3B1
aWRsZS5oPgogI2luY2x1ZGUgPGxpbnV4L2RldmZyZXEuaD4KICNpbmNsdWRlIDxsaW51eC90aW1l
ci5oPgogCkBAIC0xMjk0LDYgKzEyOTUsOCBAQCBzdGF0aWMgaW50IGRwbV9ub2lycV9zdXNwZW5k
X2RldmljZXMocG1fCiAJa3RpbWVfdCBzdGFydHRpbWUgPSBrdGltZV9nZXQoKTsKIAlpbnQgZXJy
b3IgPSAwOwogCisJY3B1aWRsZV9wYXVzZSgpOworCiAJdHJhY2Vfc3VzcGVuZF9yZXN1bWUoVFBT
KCJkcG1fc3VzcGVuZF9ub2lycSIpLCBzdGF0ZS5ldmVudCwgdHJ1ZSk7CiAJbXV0ZXhfbG9jaygm
ZHBtX2xpc3RfbXR4KTsKIAlwbV90cmFuc2l0aW9uID0gc3RhdGU7CkBAIC0xMzM2LDYgKzEzMzks
OSBAQCBzdGF0aWMgaW50IGRwbV9ub2lycV9zdXNwZW5kX2RldmljZXMocG1fCiAJfQogCWRwbV9z
aG93X3RpbWUoc3RhcnR0aW1lLCBzdGF0ZSwgZXJyb3IsICJub2lycSIpOwogCXRyYWNlX3N1c3Bl
bmRfcmVzdW1lKFRQUygiZHBtX3N1c3BlbmRfbm9pcnEiKSwgc3RhdGUuZXZlbnQsIGZhbHNlKTsK
KworCWNwdWlkbGVfcmVzdW1lKCk7CisKIAlyZXR1cm4gZXJyb3I7CiB9CiAK
--000000000000eb460805d84d310f--
