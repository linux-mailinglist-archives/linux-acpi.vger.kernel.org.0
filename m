Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B736B54D136
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jun 2022 20:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358495AbiFOSyN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Jun 2022 14:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358107AbiFOSyK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jun 2022 14:54:10 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60BB38186
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jun 2022 11:54:08 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id h23so20320559lfe.4
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jun 2022 11:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R/+J1Y9yB1sPzolzla9qc2fDqAKL6OPTM1OdQs0CRno=;
        b=abcd5znL1a7ok4I0g4GWuTjmiANg0iKDQGwuE8doxfsT9kdULYDdRiGccgJroEls8X
         5xxZ8c5rwhA/zDqfvtRxTYIP5tKxBkenLEJWpclHtYqcMmHK2uWBV5hfIs0kRo7LEfbt
         tMGhhPywkfqrfCOHEVHsbf6UtAOSJVXPOkoy4/k2815rrk9vAmRWXWK2HhxteiU/wkww
         44eCjmP4UoMmiJFizXetKCX9q31AmKP1NgwtXf+uNkb1VeyaQ1V0Hct4EyPLVHQNq+wd
         0QF+UxZGiWL2qZCF4My/2/U9LTnK3jD4sVBeSS9XopFiK2K4V6xWIYuWYAcSfFSMU5l2
         BWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R/+J1Y9yB1sPzolzla9qc2fDqAKL6OPTM1OdQs0CRno=;
        b=EVZ1WWKdvD9CMXGlVQb3nj+EDYx2PT2ueMOMxo6vOZB+8aZPLIt3M0tLb4sgdGvoxx
         1iWt3rqGkUmiXqzaf4jsQwcDDjOyrAYL6IFCBOQKnGMQx+e7pZB5vymqC/jMspP1qH1+
         sbMSqn91ktVuUH3FyaAkzo0QvUFkfxxRjvIprgReD/jCiPfALZ3ZWt/Cdm1iX84ZdW92
         a1UKzK8K5B5x+TTetWjW6W4+5q7522DnnP1wUhlaBCANu3a1jhPHeX7u3FDCWxWZXPXP
         09mvQQqJueGITwOvSIhAhJD8dFKTOzd1m0KzMUwxBGWTcx7mcwkDqpybV2B6E8cU0tsx
         /HRQ==
X-Gm-Message-State: AJIora8A8+wgEhA1hHkNZ66fEurmG1QT9l4NxlUh3Ex0umCVLXf0LBjw
        HH2Rd77Wif+/TsIUYknYOBtzzKsZnZckb9LlmB9mAQ==
X-Google-Smtp-Source: AGRyM1vZyfNc9JAgC9nEBUVD0Y6H2PaXy7vuk+wdCfIJrdMLJd38EgjmEGlXRwPi+0wxDf1+ARhAiqhg2XaBUYJM7vo=
X-Received: by 2002:a05:6512:2087:b0:479:1615:3afe with SMTP id
 t7-20020a056512208700b0047916153afemr509273lfr.114.1655319247144; Wed, 15 Jun
 2022 11:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220609110337.1238762-1-jaz@semihalf.com> <20220609110337.1238762-2-jaz@semihalf.com>
 <YqIJ8HtdqnoVzfQD@google.com> <CAH76GKNRDXAyGYvs2ji5Phu=5YPW8+SV8-6TLjizBRzTCnEROg@mail.gmail.com>
 <YqNVYz4+yVbWnmNv@google.com>
In-Reply-To: <YqNVYz4+yVbWnmNv@google.com>
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
Date:   Wed, 15 Jun 2022 20:53:56 +0200
Message-ID: <CAH76GKNSfaHwpy46r1WWTVgnsuijqcHe=H5nvUTUUs1UbdZvkQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86: notify hypervisor about guest entering s2idle state
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, Dmytro Maluka <dmy@semihalf.com>,
        Zide Chen <zide.chen@intel.corp-partner.google.com>,
        Peter Fang <peter.fang@intel.corp-partner.google.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sachi King <nakato@nakato.io>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        David Dunn <daviddunn@google.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "open list:KERNEL VIRTUAL MACHINE (KVM)" <kvm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        "open list:HIBERNATION (aka Software Suspend, aka swsusp)" 
        <linux-pm@vger.kernel.org>, Dominik Behr <dbehr@google.com>,
        Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

pt., 10 cze 2022 o 16:30 Sean Christopherson <seanjc@google.com> napisa=C5=
=82(a):
>
> On Fri, Jun 10, 2022, Grzegorz Jaszczyk wrote:
> > czw., 9 cze 2022 o 16:55 Sean Christopherson <seanjc@google.com> napisa=
=C5=82(a):
> > Above could be actually prevented if the VMM had control over the
> > guest resumption. E.g. after VMM receives notification about guest
> > entering s2idle state, it would park the vCPU actually preventing it
> > from exiting s2idle without VMM intervention.
>
> Ah, so you avoid races by assuming the VM wakes itself from s2idle any ti=
me a vCPU
> is run, even if the vCPU doesn't actually have a wake event.  That would =
be very
> useful info to put in the changelog.

Just to clarify: I assumed that the VM may wake from s2idle any time a
vCPU is running and got a wake event. So going back to the previous
example:
1. VM0 enters s2idle
2. VMM gets notification about VM0 is in s2idle and during this
notification handling, the vCPU notifying about s2idle is not running
(we are in the middle of handling vCPU exit in VMM). So even if some
wakeup event will arrive it couldn't allow that vCPU to exit the
s2idle. This pending wakeup event wouldn't wakeup the VM0 until VMM
unpark the vCPU and VMM has control over it.

>
> > > > +static void s2idle_hypervisor_notify(void)
> > > > +{
> > > > +     if (static_cpu_has(X86_FEATURE_HYPERVISOR))
> > > > +             kvm_hypercall0(KVM_HC_SYSTEM_S2IDLE);
> > >
> > > Checking the HYPERVISOR flag is not remotely sufficient.  The hypervi=
sor may not
> > > be KVM, and if it is KVM, it may be an older version of KVM that does=
n't support
> > > the hypercall.  The latter scenario won't be fatal unless KVM has bee=
n modified,
> > > but blindly doing a hypercall for a different hypervisor could have d=
isastrous
> > > results, e.g. the registers ABIs are different, so the above will mak=
e a random
> > > request depending on what is in other GPRs.
> >
> > Good point: we've actually thought about not confusing/breaking VMMs
> > so I've introduced KVM_CAP_X86_SYSTEM_S2IDLE VM capability in the
> > second patch, but not breaking different hypervisors is another story.
> > Would hiding it under new 's2idle_notify_kvm' module parameter work
> > for upstream?:
>
> No, enumerating support via KVM_CPUID_FEATURES is the correct way to do s=
omething
> like this, e.g. see KVM_FEATURE_CLOCKSOURCE2.  But honestly I wouldn't sp=
end too
> much time understanding how all of that works, because I still feel quite=
 strongly
> that getting KVM involved is completely unnecessary.  A solution that isn=
't KVM
> specific is preferable as it can then be implemented by any VMM that enum=
erates
> s2idle support to the guest.

Sure, thank you for the explanation and an example.

>
> > > The bigger question is, why is KVM involved at all?  KVM is just a du=
mb pipe out
> > > to userspace, and not a very good one at that.  There are multiple we=
ll established
> > > ways to communicate with the VMM without custom hypercalls.
> >
> > Could you please kindly advise about the recommended way of
> > communication with VMM, taking into account that we want to send this
> > notification just before entering s2idle state (please see also answer
> > to next comment), which is at a very late stage of the suspend process
> > with a lot of functionality already suspended?
>
> MMIO or PIO for the actual exit, there's nothing special about hypercalls=
.  As for
> enumerating to the guest that it should do something, why not add a new A=
CPI_LPS0_*
> function?  E.g. something like
>
> static void s2idle_hypervisor_notify(void)
> {
>         if (lps0_dsm_func_mask > 0)
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT_HYPERVISOR_NOTIFY
>                                         lps0_dsm_func_mask, lps0_dsm_guid=
);
> }

Great, thank you for your suggestion! I will try this approach and
come back. Since this will be the main change in the next version,
will it be ok for you to add Suggested-by: Sean Christopherson
<seanjc@google.com> tag?

Best regards,
Grzegorz
