Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751C64BBF5F
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Feb 2022 19:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237823AbiBRSSv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Feb 2022 13:18:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbiBRSSu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Feb 2022 13:18:50 -0500
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C381007
        for <linux-acpi@vger.kernel.org>; Fri, 18 Feb 2022 10:18:33 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id p5so21042803ybd.13
        for <linux-acpi@vger.kernel.org>; Fri, 18 Feb 2022 10:18:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=51XNuUZ/1VxzpvbDm5fgC05YqaI0Cn/y3U/YfB2cXoE=;
        b=7cU8egOWX6aZf9AYuK/WcgzUVmnruZh87M5dKKcJVxUARp5yD2QBNbRAQxC0KtUYnI
         IfWf0+5LPa9VmsWBmeqR90U7HHTVC4u5k0J0l4iNLXaRpjkp1u3pUNxsQP8mwf4MUxoo
         U4ttvgzvZB0i+Z/QV7fPA59uwERORnHah0t4oTV7knczCoVtd4fEOMW393Bchu6g3rWj
         GG2dpzbHfZwpcoZUFnxRrnBfuXFygEpgcbD0jagRX6RkUtSMra9xCxpCDxItNEhZi+Gl
         wqoGu+FOVX0xas9jZW+0NL6BzQp2uDdiGyWn3LKobgdrnSldeGaJsZc2gOLfv8ia9KU9
         QZng==
X-Gm-Message-State: AOAM532wz3t3M+hasVdvVRybgIAc5olhCVqb0NZU2WH7DjiymIb4JjE/
        p5PHj7RJ286yXOlzhCvWEROJOyZWgFoIkVMJ3Pw=
X-Google-Smtp-Source: ABdhPJx2OZgLwBX8dvn9N4Jy1V882iyX4/AmEfW2OPtAQNtuM46o/33a2cip63jtwqLjx/TYfnJjg9sgIlgzzQHEGdk=
X-Received: by 2002:a25:ab73:0:b0:624:3d68:5169 with SMTP id
 u106-20020a25ab73000000b006243d685169mr6271579ybi.633.1645208312257; Fri, 18
 Feb 2022 10:18:32 -0800 (PST)
MIME-Version: 1.0
References: <BL1PR12MB5157C5EA5510F0C9D7782AE8E2369@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0g81BmytcjgChXZumsHV5-byzSzDQbp2hc6CYzJ_6N=aw@mail.gmail.com>
 <BL1PR12MB5157E2CDD68BA585C5F4CF2BE2369@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0ho8PHGp0gAUp5KkUstTXLyUMsaQ7wTL=8xDJtjtXjPRw@mail.gmail.com>
In-Reply-To: <CAJZ5v0ho8PHGp0gAUp5KkUstTXLyUMsaQ7wTL=8xDJtjtXjPRw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Feb 2022 19:18:20 +0100
Message-ID: <CAJZ5v0j3Ma1HuUWoTmJvZDsUtm9hi84njJxJbBZMwe76eATSYQ@mail.gmail.com>
Subject: Re: Regression in 5.16-rc1 with suspend to idle
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000008d28505d84ee9c0"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

--00000000000008d28505d84ee9c0
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 18, 2022 at 5:15 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Feb 17, 2022 at 9:16 PM Limonciello, Mario
> <Mario.Limonciello@amd.com> wrote:
> >
> > [Public]
> >
> > > > I've found recently that on kernel 5.17-rc4 some OEM AMD laptops are
> > > shutting down when entering suspend to idle.
> > >
> > > Interesting.  Can you identify the exact point when the shutdown occurs?
> >
> > It looks like it's a platform firmware crash that causes the shutdown not a kernel
> > crash.
>
> It looks like we'll need to quirk the system in question then.
>
> > > > What would you suggest to be done in this case?  Revert both commits?  Or
> > > would you prefer to have a fixup on top
> > > > of that?
> > >
> > > I would prefer to fix the problem on top of the current 5.16-rc.
> > >
> >
> > Here is the minimal patch I can come up with on top of 5.17-rc4 that fixes it:
> >
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index 04ea92cbd9cf..f5bf46782043 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -32,6 +32,7 @@
> >  #include <linux/suspend.h>
> >  #include <trace/events/power.h>
> >  #include <linux/cpufreq.h>
> > +#include <linux/cpuidle.h>
> >  #include <linux/devfreq.h>
> >  #include <linux/timer.h>
> >
> > @@ -1350,6 +1351,8 @@ int dpm_suspend_noirq(pm_message_t state)
> >  {
> >         int ret;
> >
> > +       cpuidle_pause();
>
> Can you replace this with wake_up_all_idle_cpus() and remove the
> cpuidle_resume()/cpuidle_pause() calls from s2idle_enter() and see
> what happens?
>
> > +
> >         device_wakeup_arm_wake_irqs();
> >         suspend_device_irqs();
> >
> > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > index 6fcdee7e87a5..1708a643ba5d 100644
> > --- a/kernel/power/suspend.c
> > +++ b/kernel/power/suspend.c
> > @@ -97,6 +97,7 @@ static void s2idle_enter(void)
> >         raw_spin_unlock_irq(&s2idle_lock);
> >
> >         cpus_read_lock();
> > +       cpuidle_resume();
> >
> >         /* Push all the CPUs into the idle loop. */
> >         wake_up_all_idle_cpus();
> > @@ -104,6 +105,7 @@ static void s2idle_enter(void)
> >         swait_event_exclusive(s2idle_wait_head,
> >                     s2idle_state == S2IDLE_STATE_WAKE);
> >
> > +       cpuidle_pause();
> >         cpus_read_unlock();
> >
> >         raw_spin_lock_irq(&s2idle_lock);
> >
> >
> > * Removing the cpuidle_pause call from s2idle_enter will fix the crash,
> >   but the system doesn't enter the deepest sleep state.
>
> I think you mean that removing it doesn't make a difference except
> that it prevents the deepest state from being entered.
>
> Pausing cpuidle here is kind of redundant, because it just flips the
> "initialized" flag that's going to be flipped again by
> cpuidle_resume() in the next iteration.  [BTW, your patch is missing
> one an additional cpuidle_resume() in the resume path to match this
> cpuidle_pause().]  Also calling  wake_up_all_idle_cpus() is not likely
> to make a difference, so I'm guessing that synchronize_rcu() does the
> trick.
>
> > * removing the cpuidle_pause call from dpm_suspend_noirq the firmware continues to
> >    crash.
>
> So the crash occurs while running dpm_suspend_noirq().
>
> > I also confirmed that reverting both of these commits together on top of 5.17-rc4 fixes it:
> >
> > 8d89835b0467 ("PM: suspend: Do not pause cpuidle in the suspend-to-idle path")
> > 23f62d7ab25b ("PM: sleep: Pause cpuidle later and resume it earlier during system transitions")
> >
> > The commit messages at least make it sound like it was just a rework for unification of the codepaths,
> > not supposed to be for anything to be actually fixed, so I would think it should be safe to revert.
>
> There is a deeper issue related to these commits and I'm not inclined
> to go back to the old code if there is only one system affected by
> this and the problem is related to the platform firmware on that
> system.
>
> > So please advise which way you want to go and I'll send up a patch (or if you want to write one
> > I'm happy to take it and test it since I can readily reproduce it).
>
> To start with, please test the attached debug patch on top of -rc4.

Attached is another patch to try, testing the hypothesis that the
observed crash is related to CPUs being in idle state that are too
deep for some reason during late suspend and early resume.

--00000000000008d28505d84ee9c0
Content-Type: text/x-patch; charset="US-ASCII"; name="pm-suspend-cpu-latency-qos.patch"
Content-Disposition: attachment; filename="pm-suspend-cpu-latency-qos.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kzsqiq2j0>
X-Attachment-Id: f_kzsqiq2j0

LS0tCiBrZXJuZWwvcG93ZXIvc3VzcGVuZC5jIHwgICAxOCArKysrKysrKysrKysrKysrKysKIDEg
ZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspCgpJbmRleDogbGludXgtcG0va2VybmVsL3Bv
d2VyL3N1c3BlbmQuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC1wbS5vcmlnL2tlcm5lbC9wb3dlci9z
dXNwZW5kLmMKKysrIGxpbnV4LXBtL2tlcm5lbC9wb3dlci9zdXNwZW5kLmMKQEAgLTIzLDYgKzIz
LDcgQEAKICNpbmNsdWRlIDxsaW51eC9tbS5oPgogI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KICNp
bmNsdWRlIDxsaW51eC9leHBvcnQuaD4KKyNpbmNsdWRlIDxsaW51eC9wbV9xb3MuaD4KICNpbmNs
dWRlIDxsaW51eC9zdXNwZW5kLmg+CiAjaW5jbHVkZSA8bGludXgvc3lzY29yZV9vcHMuaD4KICNp
bmNsdWRlIDxsaW51eC9zd2FpdC5oPgpAQCAtMzY3LDYgKzM2OCwyMCBAQCBzdGF0aWMgaW50IHN1
c3BlbmRfcHJlcGFyZShzdXNwZW5kX3N0YXRlCiAJcmV0dXJuIGVycm9yOwogfQogCitzdGF0aWMg
c3RydWN0IHBtX3Fvc19yZXF1ZXN0IHBtX3N1c3BlbmRfY3B1X2xhdGVuY3lfcW9zX3JlcTsKKwor
c3RhdGljIHZvaWQgcG1fc3VzcGVuZF9jcHVfbGF0ZW5jeV9xb3Nfc2V0KHZvaWQpCit7CisJY3B1
X2xhdGVuY3lfcW9zX2FkZF9yZXF1ZXN0KCZwbV9zdXNwZW5kX2NwdV9sYXRlbmN5X3Fvc19yZXEs
IDMpOworCXdha2VfdXBfYWxsX2lkbGVfY3B1cygpOworfQorCitzdGF0aWMgdm9pZCBwbV9zdXNw
ZW5kX2NwdV9sYXRlbmN5X3Fvc19jbGVhcih2b2lkKQoreworCWNwdV9sYXRlbmN5X3Fvc19yZW1v
dmVfcmVxdWVzdCgmcG1fc3VzcGVuZF9jcHVfbGF0ZW5jeV9xb3NfcmVxKTsKKwl3YWtlX3VwX2Fs
bF9pZGxlX2NwdXMoKTsKK30KKwogLyogZGVmYXVsdCBpbXBsZW1lbnRhdGlvbiAqLwogdm9pZCBf
X3dlYWsgYXJjaF9zdXNwZW5kX2Rpc2FibGVfaXJxcyh2b2lkKQogewpAQCAtNDAzLDYgKzQxOCw4
IEBAIHN0YXRpYyBpbnQgc3VzcGVuZF9lbnRlcihzdXNwZW5kX3N0YXRlX3QKIAlpZiAoZXJyb3Ip
CiAJCWdvdG8gRGV2aWNlc19lYXJseV9yZXN1bWU7CiAKKwlwbV9zdXNwZW5kX2NwdV9sYXRlbmN5
X3Fvc19zZXQoKTsKKwogCWVycm9yID0gZHBtX3N1c3BlbmRfbm9pcnEoUE1TR19TVVNQRU5EKTsK
IAlpZiAoZXJyb3IpIHsKIAkJcHJfZXJyKCJub2lycSBzdXNwZW5kIG9mIGRldmljZXMgZmFpbGVk
XG4iKTsKQEAgLTQ1Nyw2ICs0NzQsNyBAQCBzdGF0aWMgaW50IHN1c3BlbmRfZW50ZXIoc3VzcGVu
ZF9zdGF0ZV90CiAJZHBtX3Jlc3VtZV9ub2lycShQTVNHX1JFU1VNRSk7CiAKICBQbGF0Zm9ybV9l
YXJseV9yZXN1bWU6CisJcG1fc3VzcGVuZF9jcHVfbGF0ZW5jeV9xb3NfY2xlYXIoKTsKIAlwbGF0
Zm9ybV9yZXN1bWVfZWFybHkoc3RhdGUpOwogCiAgRGV2aWNlc19lYXJseV9yZXN1bWU6Cg==
--00000000000008d28505d84ee9c0--
