Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BE868AF4F
	for <lists+linux-acpi@lfdr.de>; Sun,  5 Feb 2023 11:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjBEKM7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 5 Feb 2023 05:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBEKM7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Feb 2023 05:12:59 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679F2B771;
        Sun,  5 Feb 2023 02:12:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 90128CE0E7F;
        Sun,  5 Feb 2023 10:12:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7B5C433EF;
        Sun,  5 Feb 2023 10:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675591972;
        bh=07vseOO+bkMKl0Rl1FzCfpn6EqMSEMLBKqQXGh3SEPk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DoOsgC0qRgto2YORcUBWvV6iOdL3uElZk9c1nP4vdvnW7UJ0cfOzO3KFQKeGO+VoT
         lG5o4CEP2bYQB54SUPK+LBFo7FMjbKUplHCl4bDIwWpTzEouuKsF0rpYgMtLrj6WDp
         H9n6I/CA4cHgLaFDNCbQYTT7vcyhGFJmYijImsPsI/4Q5uIWFpOnPAJAD6OWCAYpbq
         XW4C2a1Bp+bMsIAU2ZYwpWCbNJq7RPvEn3rPCgoAGbT4jFAUAilaaXkOZe3H9OPJI5
         ENvwnY/2trtsxGYReAVlXWGJZfv291skBc8Gm3ylJfKUd99TlZf+kkTBtBIuHPTHhY
         1rRJCG3l8FGQA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1pOc0w-007W73-29;
        Sun, 05 Feb 2023 10:12:50 +0000
Date:   Sun, 05 Feb 2023 10:12:49 +0000
Message-ID: <865ycg1kv2.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     James Morse <james.morse@arm.com>
Cc:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Len Brown <lenb@kernel.org>,
        Rafael Wysocki <rafael@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [RFC PATCH 29/32] KVM: arm64: Pass hypercalls to userspace
In-Reply-To: <20230203135043.409192-30-james.morse@arm.com>
References: <20230203135043.409192-1-james.morse@arm.com>
        <20230203135043.409192-30-james.morse@arm.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/28.2
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: james.morse@arm.com, linux-pm@vger.kernel.org, loongarch@lists.linux.dev, kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, x86@kernel.org, tglx@linutronix.de, lpieralisi@kernel.org, mark.rutland@arm.com, sudeep.holla@arm.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, mingo@redhat.com, will@kernel.org, catalin.marinas@arm.com, chenhuacai@kernel.org, suzuki.poulose@arm.com, oliver.upton@linux.dev, lenb@kernel.org, rafael@kernel.org, kernel@xen0n.name, salil.mehta@huawei.com, linux@armlinux.org.uk, jean-philippe@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 03 Feb 2023 13:50:40 +0000,
James Morse <james.morse@arm.com> wrote:
> 
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> When capability KVM_CAP_ARM_HVC_TO_USER is available, userspace can
> request to handle all hypercalls that aren't handled by KVM. With the
> help of another capability, this will allow userspace to handle PSCI
> calls.
> 
> Suggested-by: James Morse <james.morse@arm.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: James Morse <james.morse@arm.com>
> 
> ---
> 

On top of Oliver's ask not to make this a blanket "steal everything",
but instead to have an actual request for ranges of forwarded
hypercalls:

> Notes on this implementation:
> 
> * A similar mechanism was proposed for SDEI some time ago [1]. This RFC
>   generalizes the idea to all hypercalls, since that was suggested on
>   the list [2, 3].
> 
> * We're reusing kvm_run.hypercall. I copied x0-x5 into
>   kvm_run.hypercall.args[] to help userspace but I'm tempted to remove
>   this, because:
>   - Most user handlers will need to write results back into the
>     registers (x0-x3 for SMCCC), so if we keep this shortcut we should
>     go all the way and read them back on return to kernel.
>   - QEMU doesn't care about this shortcut, it pulls all vcpu regs before
>     handling the call.
>   - SMCCC uses x0-x16 for parameters.
>   x0 does contain the SMCCC function ID and may be useful for fast
>   dispatch, we could keep that plus the immediate number.
> 
> * Add a flag in the kvm_run.hypercall telling whether this is HVC or
>   SMC?  Can be added later in those bottom longmode and pad fields.

We definitely need this. A nested hypervisor can (and does) use SMCs
as the conduit. The question is whether they represent two distinct
namespaces or not. I *think* we can unify them, but someone should
check and maybe get clarification from the owners of the SMCCC spec.

>
> * On top of this we could share with userspace which HVC ranges are
>   available and which ones are handled by KVM. That can actually be added
>   independently, through a vCPU/VM device attribute which doesn't consume
>   a new ioctl:
>   - userspace issues HAS_ATTR ioctl on the vcpu fd to query whether this
>     feature is available.
>   - userspace queries the number N of HVC ranges using one GET_ATTR.
>   - userspace passes an array of N ranges using another GET_ATTR. The
>     array is filled and returned by KVM.

As mentioned above, I think this interface should go both ways.
Userspace should request the forwarding of a certain range of
hypercalls via a similar SET_ATTR interface.

Another question is how we migrate VMs that have these forwarding
requirements. Do we expect the VMM to replay the forwarding as part of
the setting up on the other side? Or do we save/restore this via a
firmware pseudo-register?

> 
> * Enabling this using a vCPU arch feature rather than the whole-VM
>   capability would be fine, but it would be difficult to do the same for
>   the following psci-in-user capability. So let's enable everything at
>   the VM scope.

Absolutely.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
