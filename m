Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2E1546842
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jun 2022 16:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbiFJOaJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Jun 2022 10:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiFJOaI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Jun 2022 10:30:08 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B552619C3A
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jun 2022 07:30:02 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q140so9869171pgq.6
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jun 2022 07:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iZkxFrCdz5HGHbN5AvcrMQrT1OxBg7CaPmIJCaX17lQ=;
        b=KP4HYvtz1/r9i95F1wjVEcLG8E0YRVrsbrMUEtJAGlXCThtn4I+AwBI020BZ8QkENk
         VkYJUza7vjx9KRxYxYn1blwfJ4DmHGeHYEfXLV2JLucPyU1CcT6RyAiFEGz5xNB1qNs3
         /H8oz5Osobi0eyKYL6Jxc/SkFRW8e6Rmy5hPD/ePq+GzeBSEpX/JtBIT336CQfQT3h78
         bJKW+VdriFLI+sUb13QBvbPpKxYpaG4Rm0NEHazp3sA5OclNymsh1q+DI3F/mUVofBjx
         5cE40h+i7ZQvqjZzKy99OzoR963rVw88+d7oUzCl+YjMBsKs03AJB7Mm5xf283OcfSp5
         whAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iZkxFrCdz5HGHbN5AvcrMQrT1OxBg7CaPmIJCaX17lQ=;
        b=6okzyPCgAdBU7SHq06ZElGdUfZUB5w5jKHyY3jaFrf6sdzHhgVLteu2gq3BR2/Isp8
         YcjOQ+TlTlJ8m/MmPIocPqzOAJEDCYWTdvhKIBGrBAUCpi0oNRjmpngFoSAKVpshSRkq
         9fOMDAuCP26p4+SwYUXJxXBFR/4JLT2Ni9zkvt7GPC/K1aUOsX/1yY7yHP/Bvycnfbn6
         QgxdDfUO6cbKUFuQnASBShLDugtYjvxnB7F8qJgsncv4HyueGJ1Jdjm6INs/zMWk93aL
         UfdYOaxVmJadHj4DoqcWOMhRFjCMDrUK6SfkVyJy6CG9BT0upZrOb6vbZVIxQ9jwfMXf
         yYsQ==
X-Gm-Message-State: AOAM533AoSChSQPm2ESLiBnZyN2aARV4d4mgBZ1YArTozIls1/F4wUAe
        3Ryde2de9Y4a1Wf5qQHYarCinA==
X-Google-Smtp-Source: ABdhPJy9lH+YdGeVgxW6k3OvjfR+G0rlnFgBcN96oP7+X/9Ctfac88M6IIzXUkvNd0dbwRRp3m0BqA==
X-Received: by 2002:a63:8241:0:b0:3fe:2e64:95f0 with SMTP id w62-20020a638241000000b003fe2e6495f0mr13325930pgd.190.1654871401611;
        Fri, 10 Jun 2022 07:30:01 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id h11-20020a62830b000000b0050dc7628150sm19477473pfe.42.2022.06.10.07.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 07:29:59 -0700 (PDT)
Date:   Fri, 10 Jun 2022 14:29:55 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Grzegorz Jaszczyk <jaz@semihalf.com>
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
        <linux-pm@vger.kernel.org>, dbehr@google.com, dtor@google.com
Subject: Re: [PATCH 1/2] x86: notify hypervisor about guest entering s2idle
 state
Message-ID: <YqNVYz4+yVbWnmNv@google.com>
References: <20220609110337.1238762-1-jaz@semihalf.com>
 <20220609110337.1238762-2-jaz@semihalf.com>
 <YqIJ8HtdqnoVzfQD@google.com>
 <CAH76GKNRDXAyGYvs2ji5Phu=5YPW8+SV8-6TLjizBRzTCnEROg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH76GKNRDXAyGYvs2ji5Phu=5YPW8+SV8-6TLjizBRzTCnEROg@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 10, 2022, Grzegorz Jaszczyk wrote:
> czw., 9 cze 2022 o 16:55 Sean Christopherson <seanjc@google.com> napisał(a):
> Above could be actually prevented if the VMM had control over the
> guest resumption. E.g. after VMM receives notification about guest
> entering s2idle state, it would park the vCPU actually preventing it
> from exiting s2idle without VMM intervention.

Ah, so you avoid races by assuming the VM wakes itself from s2idle any time a vCPU
is run, even if the vCPU doesn't actually have a wake event.  That would be very
useful info to put in the changelog.

> > > +static void s2idle_hypervisor_notify(void)
> > > +{
> > > +     if (static_cpu_has(X86_FEATURE_HYPERVISOR))
> > > +             kvm_hypercall0(KVM_HC_SYSTEM_S2IDLE);
> >
> > Checking the HYPERVISOR flag is not remotely sufficient.  The hypervisor may not
> > be KVM, and if it is KVM, it may be an older version of KVM that doesn't support
> > the hypercall.  The latter scenario won't be fatal unless KVM has been modified,
> > but blindly doing a hypercall for a different hypervisor could have disastrous
> > results, e.g. the registers ABIs are different, so the above will make a random
> > request depending on what is in other GPRs.
> 
> Good point: we've actually thought about not confusing/breaking VMMs
> so I've introduced KVM_CAP_X86_SYSTEM_S2IDLE VM capability in the
> second patch, but not breaking different hypervisors is another story.
> Would hiding it under new 's2idle_notify_kvm' module parameter work
> for upstream?:

No, enumerating support via KVM_CPUID_FEATURES is the correct way to do something
like this, e.g. see KVM_FEATURE_CLOCKSOURCE2.  But honestly I wouldn't spend too
much time understanding how all of that works, because I still feel quite strongly
that getting KVM involved is completely unnecessary.  A solution that isn't KVM
specific is preferable as it can then be implemented by any VMM that enumerates
s2idle support to the guest.

> > The bigger question is, why is KVM involved at all?  KVM is just a dumb pipe out
> > to userspace, and not a very good one at that.  There are multiple well established
> > ways to communicate with the VMM without custom hypercalls.
> 
> Could you please kindly advise about the recommended way of
> communication with VMM, taking into account that we want to send this
> notification just before entering s2idle state (please see also answer
> to next comment), which is at a very late stage of the suspend process
> with a lot of functionality already suspended?

MMIO or PIO for the actual exit, there's nothing special about hypercalls.  As for
enumerating to the guest that it should do something, why not add a new ACPI_LPS0_*
function?  E.g. something like

static void s2idle_hypervisor_notify(void)
{
	if (lps0_dsm_func_mask > 0)
		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT_HYPERVISOR_NOTIFY
					lps0_dsm_func_mask, lps0_dsm_guid);
}
