Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5467342DB5A
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Oct 2021 16:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhJNOWw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Oct 2021 10:22:52 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:35621 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230213AbhJNOWv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Oct 2021 10:22:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Urs.kf._1634221243;
Received: from 30.13.156.201(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0Urs.kf._1634221243)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 14 Oct 2021 22:20:44 +0800
Subject: Re: [PATCH V2] ACPI / APEI: restore interrupt before panic in sdei
 flow
To:     James Morse <james.morse@arm.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        huangming@linux.alibaba.com
References: <20211012142910.9688-1-zhangliguang@linux.alibaba.com>
 <5951ad5b-d755-0150-0f2a-c567eb454dac@arm.com>
From:   =?UTF-8?B?5Lmx55+z?= <zhangliguang@linux.alibaba.com>
Message-ID: <f8e73ed7-f45f-0f5d-9055-486fb83dcd82@linux.alibaba.com>
Date:   Thu, 14 Oct 2021 22:18:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <5951ad5b-d755-0150-0f2a-c567eb454dac@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

在 2021/10/14 1:44, James Morse 写道:
> Hello!
>
> On 12/10/2021 15:29, Liguang Zhang wrote:
>> When hest acpi table configure Hardware Error Notification type as
>> Software Delegated Exception(0x0B) for RAS event, OS RAS interacts with
>> ATF by SDEI mechanism. On the firmware first system, OS was notified by
>> ATF sdei call.
>>
>> The calling flow like as below when fatal RAS error happens:
>>
>> ATF notify OS flow:
>>    sdei_dispatch_event()
>>      ehf_activate_priority()
>>        call sdei callback  // callback registered by OS
>>      ehf_deactivate_priority()
>>
>> OS sdei callback:
>>    sdei_asm_handler()
>>      __sdei_handler()
>>        _sdei_handler()
>>          sdei_event_handler()
>>            ghes_sdei_critical_callback()
>>              ghes_in_nmi_queue_one_entry()
>>                /* if RAS error is fatal */
>>                __ghes_panic()
>>                  panic()
>>
>> If fatal RAS error occured, panic was called in sdei_asm_handle()
>> without ehf_deactivate_priority executed, which lead interrupt masked.
> So far the story is:
> Firmware generated and SDEI event (a kind of software NMI) because of a firmware
> interrupt, but it hasn't completely handled the interrupt.
>
>
>> If interrupt masked, system would be halted in kdump flow like this:
>>
>> arm-smmu-v3 arm-smmu-v3.3.auto: allocated 65536 entries for cmdq
>> arm-smmu-v3 arm-smmu-v3.3.auto: allocated 32768 entries for evtq
>> arm-smmu-v3 arm-smmu-v3.3.auto: allocated 65536 entries for priq
>> arm-smmu-v3 arm-smmu-v3.3.auto: SMMU currently enabled! Resetting...
> How and why do firmware interrupts affect the IOMMU?
>
> It sounds like you are sharing something with firmware that you shouldn't.
>
>
>> After debug, we found accurate halted position is:
>> arm_smmu_device_probe()
>>    arm_smmu_device_reset()
>>      arm_smmu_device_disable()
>>        arm_smmu_write_reg_sync()
>>          readl_relaxed_poll_timeout()
>>            readx_poll_timeout()
>>              read_poll_timeout()
>>                usleep_range() // hrtimer is never waked.
>>
>> So interrupt should be restored before panic otherwise kdump will trigger
>> error.
> Why can't firmware finish with the interrupt before injecting the SDEI event?
> If you need it to not happen a second time while the handler runs, you can always disable it.
>
> The text in the spec about the interaction of complete and physical interrupts is for
> bound interrupts. Linux doesn't support these. It isn't possible for linux to know whether
> firmware tied any other kind of event to a physical interrupt or not.
>
>
>> In the process of sdei, a SDEI_EVENT_COMPLETE_AND_RESUME call
>> should be called before panic for a completed run of ehf_deactivate_priority().
> SDEI_EVENT_COMPLETE_AND_RESUME is a complete, it tells firmware to restore the execution
> state from before the event. You get almost get away with x17-x30 being corrupted as
> panic() won't return - but the stack trace produced will be corrupt. If the original
> exception was from user-space, SP_EL0 will have been restored to be the user value. The
> kernel uses this for 'current'.
>
>
> The way this is supposed to work is the die-ing kernel calls SDEI_PE_MASK while it does
> the kdump reboot. Once the kdump kernel has started, the SDEI_PRIVATE_RESET and
> SDEI_SHARED_RESET calls should fix anything left over in firmware.
>
>
> Could you debug why firmware interrupts being active prevent the SMMU from being reset. As
> far as I can tell, those should be totally independent.

If ehf_deactivate_priority() was not executed, pmr_el1 register was not 
resumed to >0x80, which leads

non-secure interrupts masked. arm_smmu_device_probe() finally called 
usleep_range() which based on

hrtimer. Because non-secure timer interrupts was masked, usleep_range 
would not reponse.

Thanks.

Liguang

>
>
> Thanks,
>
> James
