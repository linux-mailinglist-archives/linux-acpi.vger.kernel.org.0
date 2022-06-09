Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767E8544FE4
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jun 2022 16:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245452AbiFIOzw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Jun 2022 10:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241636AbiFIOzv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Jun 2022 10:55:51 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884AF37F04B
        for <linux-acpi@vger.kernel.org>; Thu,  9 Jun 2022 07:55:49 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id w21so21338210pfc.0
        for <linux-acpi@vger.kernel.org>; Thu, 09 Jun 2022 07:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ERqpHHB15unBSTeHEqEMR3UFvMYfb3/GCbSADTuIbHA=;
        b=AkkQ1lNNSImZ+9IyPfR9U+c4QA+kolWUMUz3suIATQi0Q2AT516ThrNMDTDlnvc7YE
         /ZhYeyTdnRriWNOxky9myWCfBKm4Sn1EWd1VrHKfPD1yEyHRqP4S1+QQbz/iIxwNIBjn
         JQ7GFOFH08vZ6a6OHq94eZcvHzamYR/fbyvHYugF2OElBhX86mXkX1rNNeZpILEQFfBF
         dE7hNmYosDvhTkksbpmcq2gzj7a/JVXxBPr73g/1Daer4sv0xHXFMfv/WYodigfXFFLF
         X02RmIDCx9AtutgUj4ELTanbechY5vI8hnlVa9VUMddqUEjvdpZtsBkslYmL32KxgL8H
         lhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ERqpHHB15unBSTeHEqEMR3UFvMYfb3/GCbSADTuIbHA=;
        b=RNkcdQfRZUYSZAVgM1pO/xKRiEwnA8gUTFzVP0a36PIZSnNKyop1rWNQrlsDyJ5qOj
         w327xfdI6psItoht3jr1KUsqWQT+seP8nrog5WK63llN+rM6oaMdehwl7+/KwDQZZeSJ
         eYmC62/1dqPWH2xTm+MjEca7Fbk8TvkUZBcKmEfgLySMJPKs5FQOdf+Ez7SjTdXwDWGP
         HEnXbn6bLhULnRPvMK0LhgvTCC+dzkGrZ1S4ombVYRs4l7hf191Br6zG3qIWxknX3zLZ
         R/CK3iXN4KaHG1sfjJoGhmqY4VeRkG4WKFlcImGl+UpTXMbEKUaIjVuhi4q+ILNeXuT8
         UZpg==
X-Gm-Message-State: AOAM531RYaQgrVRUtplCtwb3vnW3ZulaBen9do8wz2DFxROtzLnV+32w
        luFyLtDwwjdmU3ZZAUCCMGx4XQ==
X-Google-Smtp-Source: ABdhPJy8b0sXVZ9mcdG0q6aDwplLKBr+elC41y+xW9yxBNhIl6TnCHVg9fqa2vtTLTESAaaUZeU85A==
X-Received: by 2002:aa7:8d0f:0:b0:518:d867:bae8 with SMTP id j15-20020aa78d0f000000b00518d867bae8mr39566603pfe.13.1654786548865;
        Thu, 09 Jun 2022 07:55:48 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id j188-20020a62c5c5000000b0051c77027d7fsm2702846pfg.218.2022.06.09.07.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 07:55:48 -0700 (PDT)
Date:   Thu, 9 Jun 2022 14:55:44 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Grzegorz Jaszczyk <jaz@semihalf.com>
Cc:     linux-kernel@vger.kernel.org, dmy@semihalf.com,
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
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
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86: notify hypervisor about guest entering s2idle
 state
Message-ID: <YqIJ8HtdqnoVzfQD@google.com>
References: <20220609110337.1238762-1-jaz@semihalf.com>
 <20220609110337.1238762-2-jaz@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609110337.1238762-2-jaz@semihalf.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 09, 2022, Grzegorz Jaszczyk wrote:
> +9. KVM_HC_SYSTEM_S2IDLE
> +------------------------
> +
> +:Architecture: x86
> +:Status: active
> +:Purpose: Notify the hypervisor that the guest is entering s2idle state.

What about exiting s2idle?  E.g.

  1. VM0 enters s2idle
  2. host notes that VM0 is in s2idle
  3. VM0 exits s2idle
  4. host still thinks VM0 is in s2idle
  5. VM1 enters s2idle
  6. host thinks all VMs are in s2idle, suspends the system

> +static void s2idle_hypervisor_notify(void)
> +{
> +	if (static_cpu_has(X86_FEATURE_HYPERVISOR))
> +		kvm_hypercall0(KVM_HC_SYSTEM_S2IDLE);

Checking the HYPERVISOR flag is not remotely sufficient.  The hypervisor may not
be KVM, and if it is KVM, it may be an older version of KVM that doesn't support
the hypercall.  The latter scenario won't be fatal unless KVM has been modified,
but blindly doing a hypercall for a different hypervisor could have disastrous
results, e.g. the registers ABIs are different, so the above will make a random
request depending on what is in other GPRs.

The bigger question is, why is KVM involved at all?  KVM is just a dumb pipe out
to userspace, and not a very good one at that.  There are multiple well established
ways to communicate with the VMM without custom hypercalls.

I bet if you're clever this can even be done without any guest changes, e.g. I
gotta imagine acpi_sleep_run_lps0_dsm() triggers MMIO/PIO with the right ACPI
configuration.
