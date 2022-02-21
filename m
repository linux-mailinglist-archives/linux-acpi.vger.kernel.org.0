Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1B84BE79A
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Feb 2022 19:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379856AbiBUQGR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Feb 2022 11:06:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237970AbiBUQGQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Feb 2022 11:06:16 -0500
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F34F27163
        for <linux-acpi@vger.kernel.org>; Mon, 21 Feb 2022 08:05:53 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id j12so35324157ybh.8
        for <linux-acpi@vger.kernel.org>; Mon, 21 Feb 2022 08:05:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2uIfBrRMuHC0SNO7PY+nJch2NzdiEX0EbPiyh7pxab0=;
        b=l3MAhHR5yOVtA2kFujfxg7WOayl7bW9fORnkOYjcDRJCqRcqniEVGm/ZZGsUqJw/QL
         o55RDCFDuPuhdzTaJky2o1tvAENoNPtiNR5Vgg31cZDSSu/HdKX2P0yOA6A+PXHOMXe8
         fPHnRcZGSwuj43WSEUw2st5INECpf1OD702QaNpka6UGV+aYjSy8GU2Q5ZDfG+AG6X8E
         uuQrt9gvj325J/Iwe6shSJUJFZaXZPjDiefY1c5UWgn16YCdvLJFuOC6RjuXcHAvUwiQ
         sStL8vr0HD/LQ1mp7i+zKS64HBInvTCvGhi2sIzh5JhhwV2kdGHVV6Y2iD2PCgd0RPgI
         Jy0Q==
X-Gm-Message-State: AOAM5312un8U/rXVySDdBkAI7ap8T/tfGREpmaIfEkXhDxGhT35US8Wm
        sDqytV/gixhn9qGDID6ocJykU1AiFc8NX9L5AV0uV4mO
X-Google-Smtp-Source: ABdhPJx8yKpsML2aoeRHoB0EDI6v3+BqxHAG4L6sZTuwboC28b9qmjskQwp5CmYOd7tddj2LxbFPRk32NXJks6YSWfU=
X-Received: by 2002:a25:378f:0:b0:61d:8e8b:6cf5 with SMTP id
 e137-20020a25378f000000b0061d8e8b6cf5mr18355419yba.622.1645459552577; Mon, 21
 Feb 2022 08:05:52 -0800 (PST)
MIME-Version: 1.0
References: <BL1PR12MB5157C5EA5510F0C9D7782AE8E2369@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0g81BmytcjgChXZumsHV5-byzSzDQbp2hc6CYzJ_6N=aw@mail.gmail.com>
 <BL1PR12MB5157E2CDD68BA585C5F4CF2BE2369@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0ho8PHGp0gAUp5KkUstTXLyUMsaQ7wTL=8xDJtjtXjPRw@mail.gmail.com>
 <CAJZ5v0j3Ma1HuUWoTmJvZDsUtm9hi84njJxJbBZMwe76eATSYQ@mail.gmail.com> <BL1PR12MB5157589AB3D9BC55C6D77EB4E2389@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5157589AB3D9BC55C6D77EB4E2389@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Feb 2022 17:05:36 +0100
Message-ID: <CAJZ5v0jmQaeSKj7wB1Jx+cxDHVxtHzbnTKZ4TcxnydHa5NOn+A@mail.gmail.com>
Subject: Re: Regression in 5.16-rc1 with suspend to idle
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000001fe1ac05d889687e"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

--0000000000001fe1ac05d889687e
Content-Type: text/plain; charset="UTF-8"

On Sat, Feb 19, 2022 at 4:01 AM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [Public]
>
> > it:
> > > >
> > > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > > index 04ea92cbd9cf..f5bf46782043 100644
> > > > --- a/drivers/base/power/main.c
> > > > +++ b/drivers/base/power/main.c
> > > > @@ -32,6 +32,7 @@
> > > >  #include <linux/suspend.h>
> > > >  #include <trace/events/power.h>
> > > >  #include <linux/cpufreq.h>
> > > > +#include <linux/cpuidle.h>
> > > >  #include <linux/devfreq.h>
> > > >  #include <linux/timer.h>
> > > >
> > > > @@ -1350,6 +1351,8 @@ int dpm_suspend_noirq(pm_message_t state)
> > > >  {
> > > >         int ret;
> > > >
> > > > +       cpuidle_pause();
> > >
> > > Can you replace this with wake_up_all_idle_cpus() and remove the
> > > cpuidle_resume()/cpuidle_pause() calls from s2idle_enter() and see
> > > what happens?
> > >
> > > > +
> > > >         device_wakeup_arm_wake_irqs();
> > > >         suspend_device_irqs();
> > > >
> > > > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > > > index 6fcdee7e87a5..1708a643ba5d 100644
> > > > --- a/kernel/power/suspend.c
> > > > +++ b/kernel/power/suspend.c
> > > > @@ -97,6 +97,7 @@ static void s2idle_enter(void)
> > > >         raw_spin_unlock_irq(&s2idle_lock);
> > > >
> > > >         cpus_read_lock();
> > > > +       cpuidle_resume();
> > > >
> > > >         /* Push all the CPUs into the idle loop. */
> > > >         wake_up_all_idle_cpus();
> > > > @@ -104,6 +105,7 @@ static void s2idle_enter(void)
> > > >         swait_event_exclusive(s2idle_wait_head,
> > > >                     s2idle_state == S2IDLE_STATE_WAKE);
> > > >
> > > > +       cpuidle_pause();
> > > >         cpus_read_unlock();
> > > >
> > > >         raw_spin_lock_irq(&s2idle_lock);
> > > >
> > > >
> > > > * Removing the cpuidle_pause call from s2idle_enter will fix the crash,
> > > >   but the system doesn't enter the deepest sleep state.
> > >
> > > I think you mean that removing it doesn't make a difference except
> > > that it prevents the deepest state from being entered.
> > >
> > > Pausing cpuidle here is kind of redundant, because it just flips the
> > > "initialized" flag that's going to be flipped again by
> > > cpuidle_resume() in the next iteration.  [BTW, your patch is missing
> > > one an additional cpuidle_resume() in the resume path to match this
> > > cpuidle_pause().]  Also calling  wake_up_all_idle_cpus() is not likely
> > > to make a difference, so I'm guessing that synchronize_rcu() does the
> > > trick.
> > >
> > > > * removing the cpuidle_pause call from dpm_suspend_noirq the
> > firmware continues to
> > > >    crash.
> > >
> > > So the crash occurs while running dpm_suspend_noirq().
> > >
> > > > I also confirmed that reverting both of these commits together on top of
> > 5.17-rc4 fixes it:
> > > >
> > > > 8d89835b0467 ("PM: suspend: Do not pause cpuidle in the suspend-to-
> > idle path")
> > > > 23f62d7ab25b ("PM: sleep: Pause cpuidle later and resume it earlier
> > during system transitions")
> > > >
> > > > The commit messages at least make it sound like it was just a rework for
> > unification of the codepaths,
> > > > not supposed to be for anything to be actually fixed, so I would think it
> > should be safe to revert.
> > >
> > > There is a deeper issue related to these commits and I'm not inclined
> > > to go back to the old code if there is only one system affected by
> > > this and the problem is related to the platform firmware on that
> > > system.
> > >
> > > > So please advise which way you want to go and I'll send up a patch (or if
> > you want to write one
> > > > I'm happy to take it and test it since I can readily reproduce it).
> > >
> > > To start with, please test the attached debug patch on top of -rc4.
> >
> > Attached is another patch to try, testing the hypothesis that the
> > observed crash is related to CPUs being in idle state that are too
> > deep for some reason during late suspend and early resume.
>
> I tried 3 test kernels:
> * 5.17-rc4 + Your second debugging patch
> * 5.17-rc4+ Your first debugging patch
> * 5.17-rc4 + A hack I wrote that pushed amd-pmc into "later" in the suspend
> using a global symbol called after LPS0 instead of letting it run in noirq stage
>
> It works properly on all of those, tried about 5x time in each.
>
> Then I confirmed I could still crash it on 5.17-rc4 with my control kernel.

I would do something like the attached patch, then (provided that it works).

--0000000000001fe1ac05d889687e
Content-Type: text/x-patch; charset="US-ASCII"; name="amd-pmc-suspend.patch"
Content-Disposition: attachment; filename="amd-pmc-suspend.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kzww0dmi0>
X-Attachment-Id: f_kzww0dmi0

LS0tCiBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9hbWQtcG1jLmMgfCAgIDM2ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyks
IDggZGVsZXRpb25zKC0pCgpJbmRleDogbGludXgtcG0vZHJpdmVycy9wbGF0Zm9ybS94ODYvYW1k
LXBtYy5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LXBtLm9yaWcvZHJpdmVycy9wbGF0Zm9ybS94ODYv
YW1kLXBtYy5jCisrKyBsaW51eC1wbS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9hbWQtcG1jLmMKQEAg
LTIxLDYgKzIxLDcgQEAKICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KICNpbmNsdWRlIDxsaW51
eC9wY2kuaD4KICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4KKyNpbmNsdWRlIDxs
aW51eC9wbV9xb3MuaD4KICNpbmNsdWRlIDxsaW51eC9ydGMuaD4KICNpbmNsdWRlIDxsaW51eC9z
dXNwZW5kLmg+CiAjaW5jbHVkZSA8bGludXgvc2VxX2ZpbGUuaD4KQEAgLTE0NCw2ICsxNDUsNyBA
QCBzdGF0aWMgc3RydWN0IGFtZF9wbWNfZGV2IHBtYzsKIHN0YXRpYyBpbnQgYW1kX3BtY19zZW5k
X2NtZChzdHJ1Y3QgYW1kX3BtY19kZXYgKmRldiwgdTMyIGFyZywgdTMyICpkYXRhLCB1OCBtc2cs
IGJvb2wgcmV0KTsKIHN0YXRpYyBpbnQgYW1kX3BtY193cml0ZV9zdGIoc3RydWN0IGFtZF9wbWNf
ZGV2ICpkZXYsIHUzMiBkYXRhKTsKIHN0YXRpYyBpbnQgYW1kX3BtY19yZWFkX3N0YihzdHJ1Y3Qg
YW1kX3BtY19kZXYgKmRldiwgdTMyICpidWYpOworc3RhdGljIHN0cnVjdCBwbV9xb3NfcmVxdWVz
dCBhbWRfcG1jX3BtX3Fvc19yZXE7CiAKIHN0YXRpYyBpbmxpbmUgdTMyIGFtZF9wbWNfcmVnX3Jl
YWQoc3RydWN0IGFtZF9wbWNfZGV2ICpkZXYsIGludCByZWdfb2Zmc2V0KQogewpAQCAtNTMxLDYg
KzUzMywxNCBAQCBzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIGFtZF9wbWNfc3VzcGVuCiAJdTgg
bXNnOwogCXUzMiBhcmcgPSAxOwogCisJLyoKKwkgKiBQcmV2ZW50IENQVXMgZnJvbSBnZXR0aW5n
IGludG8gaWRsZSBzdGF0ZXMgd2hpbGUgcnVubmluZyB0aGUgY29kZQorCSAqIGJlbG93IHdoaWNo
IGlzIGdlbmVyYWxseSBzYWZlIHRvIHJ1biB3aGVuIG5vbmUgb2YgdGhlIENQVXMgYXJlIGluCisJ
ICogaWRsZSBzdGF0ZXMuCisJICovCisJY3B1X2xhdGVuY3lfcW9zX3VwZGF0ZV9yZXF1ZXN0KCZh
bWRfcG1jX3BtX3Fvc19yZXEsIDApOworCXdha2VfdXBfYWxsX2lkbGVfY3B1cygpOworCiAJLyog
UmVzZXQgYW5kIFN0YXJ0IFNNVSBsb2dnaW5nIC0gdG8gbW9uaXRvciB0aGUgczBpMyBzdGF0cyAq
LwogCWFtZF9wbWNfc2VuZF9jbWQocGRldiwgMCwgTlVMTCwgU01VX01TR19MT0dfUkVTRVQsIDAp
OwogCWFtZF9wbWNfc2VuZF9jbWQocGRldiwgMCwgTlVMTCwgU01VX01TR19MT0dfU1RBUlQsIDAp
OwpAQCAtNTM5LDcgKzU0OSw3IEBAIHN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgYW1kX3BtY19z
dXNwZW4KIAlpZiAocGRldi0+Y3B1X2lkID09IEFNRF9DUFVfSURfQ1pOKSB7CiAJCXJjID0gYW1k
X3BtY192ZXJpZnlfY3puX3J0YyhwZGV2LCAmYXJnKTsKIAkJaWYgKHJjIDwgMCkKLQkJCXJldHVy
biByYzsKKwkJCWdvdG8gb3V0OwogCX0KIAogCS8qIER1bXAgdGhlIElkbGVNYXNrIGJlZm9yZSB3
ZSBzZW5kIGhpbnQgdG8gU01VICovCkBAIC01NTEsMTAgKzU2MSwxMSBAQCBzdGF0aWMgaW50IF9f
bWF5YmVfdW51c2VkIGFtZF9wbWNfc3VzcGVuCiAKIAlpZiAoZW5hYmxlX3N0YikKIAkJcmMgPSBh
bWRfcG1jX3dyaXRlX3N0YihwZGV2LCBBTURfUE1DX1NUQl9QUkVERUYpOwotCWlmIChyYykJewor
CWlmIChyYykKIAkJZGV2X2VycihwZGV2LT5kZXYsICJlcnJvciB3cml0aW5nIHRvIFNUQlxuIik7
Ci0JCXJldHVybiByYzsKLQl9CisKK291dDoKKwljcHVfbGF0ZW5jeV9xb3NfdXBkYXRlX3JlcXVl
c3QoJmFtZF9wbWNfcG1fcW9zX3JlcSwgUE1fUU9TX0RFRkFVTFRfVkFMVUUpOwogCiAJcmV0dXJu
IHJjOwogfQpAQCAtNTY1LDYgKzU3NiwxNCBAQCBzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIGFt
ZF9wbWNfcmVzdW1lCiAJaW50IHJjOwogCXU4IG1zZzsKIAorCS8qCisJICogUHJldmVudCBDUFVz
IGZyb20gZ2V0dGluZyBpbnRvIGlkbGUgc3RhdGVzIHdoaWxlIHJ1bm5pbmcgdGhlIGNvZGUKKwkg
KiBiZWxvdyB3aGljaCBpcyBnZW5lcmFsbHkgc2FmZSB0byBydW4gd2hlbiBub25lIG9mIHRoZSBD
UFVzIGFyZSBpbgorCSAqIGlkbGUgc3RhdGVzLgorCSAqLworCWNwdV9sYXRlbmN5X3Fvc191cGRh
dGVfcmVxdWVzdCgmYW1kX3BtY19wbV9xb3NfcmVxLCAwKTsKKwl3YWtlX3VwX2FsbF9pZGxlX2Nw
dXMoKTsKKwogCW1zZyA9IGFtZF9wbWNfZ2V0X29zX2hpbnQocGRldik7CiAJcmMgPSBhbWRfcG1j
X3NlbmRfY21kKHBkZXYsIDAsIE5VTEwsIG1zZywgMCk7CiAJaWYgKHJjKQpAQCAtNTc5LDEyICs1
OTgsMTIgQEAgc3RhdGljIGludCBfX21heWJlX3VudXNlZCBhbWRfcG1jX3Jlc3VtZQogCS8qIFdy
aXRlIGRhdGEgaW5jcmVtZW50ZWQgYnkgMSB0byBkaXN0aW5ndWlzaCBpbiBzdGJfcmVhZCAqLwog
CWlmIChlbmFibGVfc3RiKQogCQlyYyA9IGFtZF9wbWNfd3JpdGVfc3RiKHBkZXYsIEFNRF9QTUNf
U1RCX1BSRURFRiArIDEpOwotCWlmIChyYykJeworCWlmIChyYykKIAkJZGV2X2VycihwZGV2LT5k
ZXYsICJlcnJvciB3cml0aW5nIHRvIFNUQlxuIik7Ci0JCXJldHVybiByYzsKLQl9CiAKLQlyZXR1
cm4gMDsKKwljcHVfbGF0ZW5jeV9xb3NfdXBkYXRlX3JlcXVlc3QoJmFtZF9wbWNfcG1fcW9zX3Jl
cSwgUE1fUU9TX0RFRkFVTFRfVkFMVUUpOworCisJcmV0dXJuIHJjOwogfQogCiBzdGF0aWMgY29u
c3Qgc3RydWN0IGRldl9wbV9vcHMgYW1kX3BtY19wbV9vcHMgPSB7CkBAIC03MjIsNiArNzQxLDcg
QEAgc3RhdGljIGludCBhbWRfcG1jX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybQogCWFtZF9wbWNfZ2V0
X3NtdV92ZXJzaW9uKGRldik7CiAJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgZGV2KTsKIAlh
bWRfcG1jX2RiZ2ZzX3JlZ2lzdGVyKGRldik7CisJY3B1X2xhdGVuY3lfcW9zX2FkZF9yZXF1ZXN0
KCZhbWRfcG1jX3BtX3Fvc19yZXEsIFBNX1FPU19ERUZBVUxUX1ZBTFVFKTsKIAlyZXR1cm4gMDsK
IAogZXJyX3BjaV9kZXZfcHV0Ogo=
--0000000000001fe1ac05d889687e--
