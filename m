Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB34F42C7DE
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Oct 2021 19:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhJMRq4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Oct 2021 13:46:56 -0400
Received: from foss.arm.com ([217.140.110.172]:43090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229714AbhJMRqz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 13 Oct 2021 13:46:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E85541063;
        Wed, 13 Oct 2021 10:44:51 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E710E3F694;
        Wed, 13 Oct 2021 10:44:50 -0700 (PDT)
Subject: Re: [PATCH V2] ACPI / APEI: restore interrupt before panic in sdei
 flow
To:     Liguang Zhang <zhangliguang@linux.alibaba.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20211012142910.9688-1-zhangliguang@linux.alibaba.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <5951ad5b-d755-0150-0f2a-c567eb454dac@arm.com>
Date:   Wed, 13 Oct 2021 18:44:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211012142910.9688-1-zhangliguang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello!

On 12/10/2021 15:29, Liguang Zhang wrote:
> When hest acpi table configure Hardware Error Notification type as
> Software Delegated Exception(0x0B) for RAS event, OS RAS interacts with
> ATF by SDEI mechanism. On the firmware first system, OS was notified by
> ATF sdei call.
> 
> The calling flow like as below when fatal RAS error happens:
> 
> ATF notify OS flow:
>   sdei_dispatch_event()
>     ehf_activate_priority()
>       call sdei callback  // callback registered by OS
>     ehf_deactivate_priority()
> 
> OS sdei callback:
>   sdei_asm_handler()
>     __sdei_handler()
>       _sdei_handler()
>         sdei_event_handler()
>           ghes_sdei_critical_callback()
>             ghes_in_nmi_queue_one_entry()
>               /* if RAS error is fatal */
>               __ghes_panic()
>                 panic()
> 
> If fatal RAS error occured, panic was called in sdei_asm_handle()
> without ehf_deactivate_priority executed, which lead interrupt masked.

So far the story is:
Firmware generated and SDEI event (a kind of software NMI) because of a firmware
interrupt, but it hasn't completely handled the interrupt.


> If interrupt masked, system would be halted in kdump flow like this:
> 
> arm-smmu-v3 arm-smmu-v3.3.auto: allocated 65536 entries for cmdq
> arm-smmu-v3 arm-smmu-v3.3.auto: allocated 32768 entries for evtq
> arm-smmu-v3 arm-smmu-v3.3.auto: allocated 65536 entries for priq
> arm-smmu-v3 arm-smmu-v3.3.auto: SMMU currently enabled! Resetting...

How and why do firmware interrupts affect the IOMMU?

It sounds like you are sharing something with firmware that you shouldn't.


> After debug, we found accurate halted position is:
> arm_smmu_device_probe()
>   arm_smmu_device_reset()
>     arm_smmu_device_disable()
>       arm_smmu_write_reg_sync()
>         readl_relaxed_poll_timeout()
>           readx_poll_timeout()
>             read_poll_timeout()
>               usleep_range() // hrtimer is never waked.
> 
> So interrupt should be restored before panic otherwise kdump will trigger
> error.

Why can't firmware finish with the interrupt before injecting the SDEI event?
If you need it to not happen a second time while the handler runs, you can always disable it.

The text in the spec about the interaction of complete and physical interrupts is for
bound interrupts. Linux doesn't support these. It isn't possible for linux to know whether
firmware tied any other kind of event to a physical interrupt or not.


> In the process of sdei, a SDEI_EVENT_COMPLETE_AND_RESUME call
> should be called before panic for a completed run of ehf_deactivate_priority().

SDEI_EVENT_COMPLETE_AND_RESUME is a complete, it tells firmware to restore the execution
state from before the event. You get almost get away with x17-x30 being corrupted as
panic() won't return - but the stack trace produced will be corrupt. If the original
exception was from user-space, SP_EL0 will have been restored to be the user value. The
kernel uses this for 'current'.


The way this is supposed to work is the die-ing kernel calls SDEI_PE_MASK while it does
the kdump reboot. Once the kdump kernel has started, the SDEI_PRIVATE_RESET and
SDEI_SHARED_RESET calls should fix anything left over in firmware.


Could you debug why firmware interrupts being active prevent the SMMU from being reset. As
far as I can tell, those should be totally independent.


Thanks,

James
