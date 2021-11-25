Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4EB145D236
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Nov 2021 01:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245240AbhKYAph (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Nov 2021 19:45:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48288 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344014AbhKYAnh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Nov 2021 19:43:37 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637800825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F69UvwpCpRoQAqkbLIoksVxoxGdLAobfXGDN4csUD+Q=;
        b=bV+skfSf60xh0yOXVYR1dc2nCEZuImWfPfbIsUHKD84XX5O0RHH6bwMDnScCDnqiYoMGlP
        NUSL5BXi6d7Jl8p6O7t7jydDyGc+BQcWVI3Sa1bhXJFoy3kQ87c+BL8oi7kYIHysJ3wiTV
        SdkGHMcXs/eUCQZXHqy6FuHYLhoW6ji4xDcWpfLG1FzQazTo+IxU8Gc/O3ENE1Ppa5xyBl
        tFErAhVHbWHnAVYrdw3jQHYL5JsXSFdk2y6F3pAlrs1vDK/Jwb+3clt+nNNfKAXuP3aQoS
        wsAKKOUTycKxZ5zNXy3QfXweOdW+P+UMTr87OVU9cFnZ1I6OgampiBg53fvc6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637800825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F69UvwpCpRoQAqkbLIoksVxoxGdLAobfXGDN4csUD+Q=;
        b=MlLZ1YMbzXaERVOkQI4tY007Cd2VaKm4rFJ/vuQwZ2eaB7lzPkk9CYaHg17wuGmCTVEVdX
        0UPvRM4By1apIkDQ==
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2] x86: Skip WBINVD instruction for VM guest
In-Reply-To: <20211119040330.4013045-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <YZPbQVwWOJCrAH78@zn.tnic>
 <20211119040330.4013045-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Date:   Thu, 25 Nov 2021 01:40:24 +0100
Message-ID: <87pmqpjcef.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Kuppuswamy,

On Thu, Nov 18 2021 at 20:03, Kuppuswamy Sathyanarayanan wrote:
> ACPI mandates that CPU caches be flushed before entering any sleep
> state. This ensures that the CPU and its caches can be powered down
> without losing data.
>
> ACPI-based VMs have maintained this sleep-state-entry behavior.
> However, cache flushing for VM sleep state entry is useless. Unlike on
> bare metal, guest sleep states are not correlated with potential data
> loss of any kind; the host is responsible for data preservation. In
> fact, some KVM configurations simply skip the cache flushing
> instruction (see need_emulate_wbinvd()).

KVM starts out with kvm->arch.noncoherent_dma_count = 0 which makes
need_emulate_wbinvd() skip WBINVD emulation. So far so good.

VFIO has code to invoke kvm_arch_register_noncoherent_dma() which
increments the count which will subsequently cause WBINVD emulation to
be enabled. What now?

> Further, on TDX systems, the WBINVD instruction causes an
> unconditional #VE exception.  If this cache flushing remained, it would
> need extra code in the form of a #VE handler.
>
> All use of ACPI_FLUSH_CPU_CACHE() appears to be in sleep-state-related
> code.

C3 is considered a sleep state nowadays? Also ACPI_FLUSH_CPU_CACHE() is
used in other places which have nothing to do with sleep states.

git grep is not rocket science to use.

> This means that the ACPI use of WBINVD is at *best* superfluous.

Really? You probably meant to say:

  This means that the ACPI usage of WBINVD from within a guest is at
  best superfluous.

No?

But aside of that this does not give any reasonable answers why
disabling WBINVD for guests unconditionally in ACPI_FLUSH_CPU_CACHE()
and the argumentation vs. need_emulate_wbinvd() are actually correct
under all circumstances.

I'm neither going to do that analysis nor am I going to accept a patch
which comes with 'appears' based arguments and some handwavy references
to disabled WBINVD emulation code which can obviously be enabled for a
reason.

The even more interesting question for me is how a TDX guest is dealing
with all other potential invocations of WBINVD all over the place. Are
they all going to get the same treatment or are those magically going to
be never executed in TDX guests?

I really have to ask why SEV can deal with WBINVD and other things just
nicely by implementing trivial #VC handler functions, but TDX has to
prematurely optimize the kernel tree based on half baken arguments?

Having a few trivial #VE handlers is not the end of the world. You can
revisit that once basic support for TDX is merged in order to gain
performance or whatever.

Either that or you provide patches with arguments which are based on
proper analysis and not on 'appears to' observations.

Thanks,

        tglx
