Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0234324E4
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Oct 2021 19:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbhJRRXo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Oct 2021 13:23:44 -0400
Received: from foss.arm.com ([217.140.110.172]:40868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233600AbhJRRXn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Oct 2021 13:23:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD91E2F;
        Mon, 18 Oct 2021 10:21:31 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C10B13F694;
        Mon, 18 Oct 2021 10:21:30 -0700 (PDT)
Subject: Re: [PATCH V2] ACPI / APEI: restore interrupt before panic in sdei
 flow
To:     =?UTF-8?B?5Lmx55+z?= <zhangliguang@linux.alibaba.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        huangming@linux.alibaba.com
References: <20211012142910.9688-1-zhangliguang@linux.alibaba.com>
 <5951ad5b-d755-0150-0f2a-c567eb454dac@arm.com>
 <f8e73ed7-f45f-0f5d-9055-486fb83dcd82@linux.alibaba.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <ddefdfea-a8ca-8735-0f81-8b2748587da5@arm.com>
Date:   Mon, 18 Oct 2021 18:21:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <f8e73ed7-f45f-0f5d-9055-486fb83dcd82@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Liguang,

On 14/10/2021 15:18, 乱石 wrote:
> 在 2021/10/14 1:44, James Morse 写道:
>> On 12/10/2021 15:29, Liguang Zhang wrote:
>>> When hest acpi table configure Hardware Error Notification type as
>>> Software Delegated Exception(0x0B) for RAS event, OS RAS interacts with
>>> ATF by SDEI mechanism. On the firmware first system, OS was notified by
>>> ATF sdei call.

>>> If fatal RAS error occured, panic was called in sdei_asm_handle()
>>> without ehf_deactivate_priority executed, which lead interrupt masked.

>> So far the story is:
>> Firmware generated and SDEI event (a kind of software NMI) because of a firmware
>> interrupt, but it hasn't completely handled the interrupt.
>>
>>
>>> If interrupt masked, system would be halted in kdump flow like this:
>>>
>>> arm-smmu-v3 arm-smmu-v3.3.auto: allocated 65536 entries for cmdq
>>> arm-smmu-v3 arm-smmu-v3.3.auto: allocated 32768 entries for evtq
>>> arm-smmu-v3 arm-smmu-v3.3.auto: allocated 65536 entries for priq
>>> arm-smmu-v3 arm-smmu-v3.3.auto: SMMU currently enabled! Resetting...

>> How and why do firmware interrupts affect the IOMMU?

[...]

>> Could you debug why firmware interrupts being active prevent the SMMU from being reset. As
>> far as I can tell, those should be totally independent.

> If ehf_deactivate_priority() was not executed, pmr_el1 register was not resumed to >0x80,
> which leads
> non-secure interrupts masked. arm_smmu_device_probe() finally called usleep_range() which
> based on
> hrtimer. Because non-secure timer interrupts was masked, usleep_range would not reponse.

Aha! So nothing to do with with the SMMU at all.

Your firmware has 'disabled' the interrupt by moving the CPUs priority mask so that no
interrupts at all can be taken.

I still think this is best fixed in firmware.

Papering over the problem here is not enough as the handler may encounter memory
corruption, take an exception, and panic() from some other part of the kernel. Its RAS -
we know something has gone wrong before we get to this point.

The OS needs to be able to call panic() at any point in time.


Your firmware should not deny the normal-world interrupts like this.
Please either complete the interrupt handling before calling into the normal world,
or disable it if you need the interrupt to not fire again. If the device that triggers the
interrupt doesn't have a disable, there are hardware registers in the GIC to do this.
(I don't know how TFA works here, it may be a bug in the upstream code)



Thanks,

James
