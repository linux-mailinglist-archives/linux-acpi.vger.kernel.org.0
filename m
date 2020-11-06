Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930562A9E19
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Nov 2020 20:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgKFTe0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Nov 2020 14:34:26 -0500
Received: from foss.arm.com ([217.140.110.172]:44014 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728224AbgKFTe0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 6 Nov 2020 14:34:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1532B1474;
        Fri,  6 Nov 2020 11:34:25 -0800 (PST)
Received: from [172.16.1.113] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA3CA3F718;
        Fri,  6 Nov 2020 11:34:23 -0800 (PST)
Subject: Re: [PATCH] Don't do panic for memory Fatal UE in ghes of x86_mce
To:     yaoaili126@163.com
Cc:     rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        bp@alien8.de, linux-acpi@vger.kernel.org, YANGFENG1@kingsoft.com,
        CHENGUOMIN@kingsoft.com, yaoaili@kingsoft.com
References: <076b78b6-4d3c-028c-7dc0-467f5afed1a9 () arm ! com>
 <20201103064109.25152-1-yaoaili126@163.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <72ca543a-5022-bd12-14b5-4d7b125cd0fe@arm.com>
Date:   Fri, 6 Nov 2020 19:34:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201103064109.25152-1-yaoaili126@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello,

On 03/11/2020 06:41, yaoaili126@163.com wrote:
> From: Aili Yao <yaoaili@kingsoft.com>
> 
> Hi! Thanks for your comments!
> 
> 1. I dig a little more into Config system of kernel, I see this:
> arch/x86/configs/x86_64_defconfig:45:CONFIG_X86_MCE=y, but for other 
> platform not, and I think if CONFIG_X86_MCE if not enough to avoid other 
> platform, how about this:
>   #if defined(CONFIG_X86) && defined(CONFIG_X86_MCE)
> for a different platfrom like ARM64, they can't enable CONFIG_X86.

Its not arm platforms I'm worried about! Its x86 systems that do everything
firmware-first, or everything kernel-first. You seem to have something doing a bit of
both, anything added needs to not break the other systems.

You can't know at compile time if the system will be doing a bit of both.
You must detect it from the entries in the HEST.


> 2. I tested your draft codes, and it doesn't work,
>   [    8.311488] ghes_probe,1298 assist:0
>   [    8.315177] ghes_probe,1298 assist:0
>   [    8.318877] ghes_probe,1298 assist:0

Its probably buggy - I don't have a HEST to test this with.
But - maybe this isn't GHES-ASSIST!

Could you dump the HEST and check the flags. Something like:
| cp /sys/firmware/acpi/tables/HEST  .
| iasl HEST

Look for the GHES entries having an 'alternate source id' that in turn has the GHES_ASSIST
flag set.


> For the server i use, the ghes module will create 3 ghes struct, one is for
> poll timer, second is for sci, the third is for NMI. for x86 platform, 
> the NMI ghes is not only for memory but also other hw error like PCIE,
> I don't know how assist will be set for this senario, Maybe different 
> manufactures of hw may have different values. 

GHES-ASSIST has been my assumption as you were finding firmware-first records during
machine-check. (which suggests its not really a firmware-first system)

If the GHES-ASSIST flag isn't set, then something else is going on.


> I do wondering if we can add one option to each error record the OS 
> received from BIOS, if we can, we may unify some of ghes_proc brached
> which is seperate by CONFIG_OPTIONS, this will do more clean code.

I'm not sure what you are suggesting here.


> 3. I have some test result from an Fatal UE inject, following:
> It seems the NMI has preempt MCE, and MCE's work
> isn't finished as NMI has decided to panic. I may refers to Intel for
> some help. 
> That's not good as we may lose the mcelog in pstore.

> Even if there is no kdump fail issue, I think the No panic action for 
> Fatal memory is still needed.

Injecting fatal errors is expected to be fatal.


It may be your firmware is over reacting and reporting recoverable errors as fatal. But:
there are cases that fatal really means fatal.

CPUs can get themselves in a terrible mess when they try to do something quickly, then it
turns out a read/write in the past suffered from a RAS error. Its not always possible for
the hardware to put the world back in order, so it gives up.
In the arm world, these are called an 'imprecise external abort'. Imprecise because the
CPU can't tell you where the error was. From greping arch/x86, it looks like the x86
equivalent is INEXACT.
When this happens, the running thread has been wrecked, it cannot be restarted. It may
have corrupted memory, we don't know where.

Ignoring these means not all the instructions in the program got executed. Such a system
is not reliable.

For this reason, firmware's 'fatal' has to mean fatal.
If its reported non-fatal errors as fatal, please take that up with the firmware vendor.


> [  995.167270] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 4
> [  995.167271] {1}[Hardware Error]: event severity: fatal
> [  995.167271] {1}[Hardware Error]:  Error 0, type: fatal
> [  995.167271] {1}[Hardware Error]:  fru_text: Card03, ChnA, DIMM0
> [  995.167272] {1}[Hardware Error]:   section_type: memory error
> [  995.167272] {1}[Hardware Error]:   error_status: 0x0000000000000000
> [  995.167272] {1}[Hardware Error]:   physical_address: 0x00000046fe735000
> [  995.167273] {1}[Hardware Error]:   node: 2 card: 0 module: 0 rank: 0 bank: 1 device: 0 row: 62761 column: 208
> [  995.167273] {1}[Hardware Error]:   DIMM location: CPU 1 DIMM 4
> [  995.167274] Kernel panic - not syncing: Fatal hardware error!
> [  995.167274] CPU: 47 PID: 0 Comm: swapper/47 Kdump: loaded Not tainted 4.18.0+ #20
> [  995.167274] Hardware name: Lenovo ThinkSystem SR650 -[7X06CTO1WW]-/-[7X06CTO1WW]-, BIOS -[IVE636Z-2.13]- 07/18/2019
> [  995.167275] Call Trace:
> [  995.167275]  <NMI>
> [  995.167275]  dump_stack+0x5a/0x73
> [  995.167275]  panic+0xe8/0x2bc
> [  995.167276]  __ghes_panic+0x68/0x6a
> [  995.167276]  ghes_notify_nmi+0x23b/0x290
> [  995.167276]  nmi_handle+0x69/0x110
> [  995.167276]  default_do_nmi+0x3e/0x110
> [  995.167277]  do_nmi+0x116/0x190
> [  995.167277]  end_repeat_nmi+0x16/0x6a
> [  995.167277] RIP: 0010:machine_check+0x0/0x40
> [  995.167278] Code: 00 00 48 89 e7 48 8b 74 24 78 48 c7 44 24 78 ff ff ff ff e8 b2 0e 66 ff e9 ed 02 00 00 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 <0f> 01 ca 6a ff f6 44 24 10 03 75 14 e8 2f 00 00 00 48 89 e7 31 f6
> [  995.167278] RSP: 0018:fffffe00007effd8 EFLAGS: 00000046
> [  995.167279] RAX: ffffffff97eac2c0 RBX: ffff8f8cc0ce5c40 RCX: 7fffff18a792c0bf
> [  995.167279] RDX: 0000000000000001 RSI: 000000000000002f RDI: ffff8fa39fd5d600
> [  995.167280] RBP: 000000000000002f R08: 0000000000000008 R09: ffffffdb56bbc181
> [  995.167280] R10: 000000000000002f R11: 0000000000000000 R12: 0000000000000000
> [  995.167280] R13: 0000000000000000 R14: ffff8f8cc0ce5c40 R15: ffff8f8cc0ce5c40
> [  995.167280]  ? __sched_text_end+0x4/0x4
> [  995.167281]  ? async_page_fault+0x30/0x30
> [  995.167281]  ? async_page_fault+0x30/0x30
> [  995.167281]  </NMI>
> [  995.167281]  <#MC>
> [  995.167282] RIP: 0010:native_safe_halt+0xe/0x10
> [  995.167282] Code: ff ff eb bc 90 90 90 90 90 90 90 90 e9 07 00 00 00 0f 00 2d 76 c8 55 00 f4 c3 66 90 e9 07 00 00 00 0f 00 2d 66 c8 55 00 fb f4 <c3> 90 0f 1f 44 00 00 41 54 55 53 e8 e2 29 88 ff 65 8b 2d d3 2a 16
> [  995.167283] RSP: 0018:ffffa2e4cca47ea0 EFLAGS: 00000246 </#MC>
> [  995.167283]  default_idle+0x1a/0x130
> [  995.167283]  do_idle+0x1a6/0x290
> [  995.167283]  cpu_startup_entry+0x6f/0x80
> [  995.167284]  start_secondary+0x1aa/0x200
> [  995.167284]  secondary_startup_64+0xb7/0xc0

Hmm. Firmware manages to trigger an NMI during machine-check.... I would have thought you
only get one, or the other. If you do get both, its because of GHES-ASSIST.

You are triggering this with some error injection... its possible this would never
actually happen in real life as the kernel takes the errors via machine-check, firmware
never finds out.
Is it possible to check with your BIOS vendor whether this is the case?


Thanks,

James
