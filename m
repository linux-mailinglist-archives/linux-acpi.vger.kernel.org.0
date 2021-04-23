Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B72036999F
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 20:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243561AbhDWSaF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Apr 2021 14:30:05 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:35474 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbhDWSaF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Apr 2021 14:30:05 -0400
Received: by mail-oi1-f176.google.com with SMTP id e25so20087604oii.2;
        Fri, 23 Apr 2021 11:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hn2ZcalQMf1zWjqze+P91WzURaNyzdTYLcJnyDlbbDU=;
        b=gqO7D2EHyvJ22IzClJSgIHrwbboGvirPo2J9aMun0v/PAU0buVd69Ij7a7hHOIEr0K
         oc2YR6+cVAgwveOWINXXhNasM2hMcAbiRYTIWUfVbOd6Zka3tgIpwvJCQvdX4STzzI8k
         rlySH1+UYXqjo3VdDeF4Y0y3qvauuAOIX+33stZ5m2p60zl8H9WvkgQJM4IWovyswx+c
         6luLwTYpowI2bOFZZqfnFtxaLQBbyDH1gsVxT/grDgTFhVrthNKISG5Ocxzk2eymeAWJ
         GfrBWjoMEm8jv7I0Ru+tXJc4gfjCTRIWeCP1GPAfhcpGeTspc3xPrY/0vucw97H+/iy5
         /lnQ==
X-Gm-Message-State: AOAM533Wt/2kOmOTI00Ihi+T7GMqlifJLZD9T1t+8lSYozro3EC6DCmh
        4m+w041D4DwYc7BLl7MPgDOfX49Kx9LTwC19mx4=
X-Google-Smtp-Source: ABdhPJzRn7LUW/2xl/6xnu2Th+5lmg9/l9qlSwX354B0I7YDAStqpHmWc2Rgu06HSj2m/CVBU1T2JRNJU/IK3kSJPGQ=
X-Received: by 2002:a54:4501:: with SMTP id l1mr5072767oil.157.1619202567364;
 Fri, 23 Apr 2021 11:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210422214708.716164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210422214708.716164-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAJZ5v0iv0r3x0rDiB6+M+CZcAPcFK8i6R1n=v1NPcNg16invTQ@mail.gmail.com> <789781a4-026b-f023-6192-5a0099fd88fd@linux.intel.com>
In-Reply-To: <789781a4-026b-f023-6192-5a0099fd88fd@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 23 Apr 2021 20:29:16 +0200
Message-ID: <CAJZ5v0jonk2Pb2HUHMoe69vnCV4+EV9XZpo2LwKrnYPF3CxD_A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] x86/acpi, x86/boot: Add multiprocessor wake-up support
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Apr 23, 2021 at 7:58 PM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 4/23/21 6:05 AM, Rafael J. Wysocki wrote:
> > Although I've looked at this patch already, I now realize that
> > according to the spec the mailbox is only suitable for the first AP
> > wakeup during system initialization.
> >
> > Shouldn't the original handler be restored then to handle subsequent wakeups?
>
> For TDX use case, since it does not support CPU hotplug/offline features, once
> the AP is turned on, it will never be off-lined and hence need not support
> subsequent wakeups.
>
> AFAIK, this MADT wake table is mainly defined for TDX use case.
>
> Please also check the TDX GHCI spec, sec 4.1.
>
> For each TD-guest, application processor, the mailbox can be used once for the
> wakeup command. After the guest-application processor takes the action according
> to the command, the intention is the mailbox will no longer be checked by the
> guest-application processor. Other guest processors can continue using the mailbox
> for the next command.

But this patch modifies generic code and the ACPI mechanism used by it
is generic.  TDX is not even mentioned by the spec section pointed to
by the changelog.

IMO it should at least ensure that the AP wakeup callback will return
an error on an attempt to use it more than once on a given CPU.
