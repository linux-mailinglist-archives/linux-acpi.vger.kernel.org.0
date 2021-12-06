Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0ED546A192
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Dec 2021 17:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239265AbhLFQnf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Dec 2021 11:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239263AbhLFQne (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Dec 2021 11:43:34 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8B9C061746
        for <linux-acpi@vger.kernel.org>; Mon,  6 Dec 2021 08:40:05 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so11226594pjb.5
        for <linux-acpi@vger.kernel.org>; Mon, 06 Dec 2021 08:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YZGwgQr9TnHSsdDrZ5O2tR1cNzcd9zE3EQ/xZk4GMoE=;
        b=pps9LsdHCr/+0G93zCgdY6KFzzavFCEtsMBdBBPVQ2MCsrQOm22c+4Y/nbd0h4ypsh
         e0O8ECzGQcWOxIOjJO27y+kHGpu116DX4nNyFa6IAr6DGRkhGG6kcwN3VACy0fnxaV5u
         xkWVGHZojBZtyeIv8Ng2309i5u2/oaSqBglOrhxI2llqrEguLegZ3lLKCuRuuOAgktUZ
         LvBCwdIg3kqNOSinr3tp3Ne6GmpfiCMmeYZRyjPcKvQrA0aBIXguzK8HVqpa94ixBU8Q
         WXSk+JUUfHleNTBc6ZZtgMezcDU4RXVeOIY+rAXi4gOn4cPDuPaM3oKAAhm1it9fG2ww
         BS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YZGwgQr9TnHSsdDrZ5O2tR1cNzcd9zE3EQ/xZk4GMoE=;
        b=W+5G+8AQdjiQXgms7Z0yvjBXGvVsfSRq/Rv+IqOL0umaOkN3nt46hu6Up8X9cJ5Z4/
         BdaetBTqZBhvJKX7fr4s+l9iKWiogv//9v+dwIf5ijLh/ZoHyEZps4HBK7v5P7y0NJOz
         ylGv4uhEaDrS5xDCg+cnh/HK5fZwoTL1gCOnSc262M9v+xau9YBbQ25gwZK/MYKqidYK
         EgmaWpD7YJGyR0DHpbp9dl7KcVsTsq7AZdLVfCdGr6LSQ+mJ2KxZmM5sj+M4XnTHUn6R
         YQABBHh03NS1N+4bVqgjuaUGQyfq7coyylnZn/qSX0Rzz/IYqOfbpbLJKqWz5ndJjbAh
         0xtA==
X-Gm-Message-State: AOAM530kF4WCtzaEIziooFXfRCmVhR7V95tTFWoQAbULUYObS20edHhw
        oLpxNBHPh86uFvLLRLyuFss9eoZJdI5WKFN6DFq4VQ==
X-Google-Smtp-Source: ABdhPJxGtcQevov5D/XI/psX3kLHSsRbDJt2oL/VfWvEC8u/+Tfeehru/r8gsZyIjb2JjirHQpRbHk5qOUMpxtRqWiw=
X-Received: by 2002:a17:90b:1e49:: with SMTP id pi9mr38600776pjb.220.1638808804583;
 Mon, 06 Dec 2021 08:40:04 -0800 (PST)
MIME-Version: 1.0
References: <YZPbQVwWOJCrAH78@zn.tnic> <20211119040330.4013045-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <87pmqpjcef.ffs@tglx> <20211202222109.pcsgm2jska3obvmx@black.fi.intel.com>
 <87lf126010.ffs@tglx> <20211203234915.jw6kdd2qnfrionch@black.fi.intel.com>
 <2519e6b6-4f74-e2f8-c428-0fceb0e16472@intel.com> <20211204005427.ccinxlwwab3jsuct@black.fi.intel.com>
 <5bc40889-445d-5cac-3396-d39d53ee92c7@intel.com>
In-Reply-To: <5bc40889-445d-5cac-3396-d39d53ee92c7@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 6 Dec 2021 08:39:53 -0800
Message-ID: <CAPcyv4gHK=-gxxYexV8jtycPGE15yDWe7jYutbcqKc-1Zhmx8Q@mail.gmail.com>
Subject: Re: [PATCH v2] x86: Skip WBINVD instruction for VM guest
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Dec 6, 2021 at 7:35 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 12/3/21 4:54 PM, Kirill A. Shutemov wrote:
> > On Fri, Dec 03, 2021 at 04:20:34PM -0800, Dave Hansen wrote:
> >>> TDX doesn't support these S- and C-states. TDX is only supports S0 and S5.
> >>
> >> This makes me a bit nervous.  Is this "the first TDX implementation
> >> supports..." or "the TDX architecture *prohibits* supporting S1 (or
> >> whatever"?
> >
> > TDX Virtual Firmware Design Guide only states that "ACPI S3 (not supported
> > by TDX guests)".
> >
> > Kernel reports in dmesg "ACPI: PM: (supports S0 S5)".
>
> Those describe the current firmware implementation, not a guarantee
> provided by the TDX architecture forever.
>
> > But I don't see how any state beyond S0 and S5 make sense in TDX context.
> > Do you?
>
> Do existing (non-TDX) VMs use anything other than S0 and S5?  If so, I'd
> say yes.
>
> >> I really think we need some kind of architecture guarantee.  Without
> >> that, we risk breaking things if someone at our employer simply changes
> >> their mind.
> >
> > Guarantees are hard.
> >
> > If somebody change their mind we will get unexpected #VE and crash.
> > I think it is acceptable way to handle unexpected change in confidential
> > computing environment.
>
> Architectural guarantees are quite easy, actually.  They're just a
> contract that two parties agree to.  In this case, the contract would be
> that TDX firmware *PROMISES* not to enumerate support for additional
> sleep states over what the implementation does today.  If future
> firmware breaks that promise (and the kernel crashes) we get to come
> after them with torches and pitchforks to fix the firmware.
>
> The contract let's us do things in the OS like:
>
>         WARN_ON(sleep_states[ACPI_STATE_S3]);
>
> We also don't need *formal* documentation of such things.  We really
> just need to have a chat.
>
> It would be perfectly sufficient if we go bug Intel's TDX architecture
> folks and say, "Hey, Linux is going to crash if you ever implement any
> actual sleep states.  The current implementation is fine here, but is it
> OK if future implementations are restricted from doing this?"
>
> But, the trick is that we need a contract.  A contract requires a
> "meeting of the minds" first.

The WBINVD requirement in sleep states is about getting cache contents
out to to power preserved domain before the CPU turns off. The bare
metal host handles that requirement. The conversation that needs to be
had is with the ACPI specification committee to clarify that virtual
machines have no responsibility to flush caches. We can do that as a
Code First proposal to the ACPI Specification Working Group.
