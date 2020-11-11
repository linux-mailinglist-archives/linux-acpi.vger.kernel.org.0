Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9982AF7BF
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Nov 2020 19:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgKKSLi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Nov 2020 13:11:38 -0500
Received: from foss.arm.com ([217.140.110.172]:59430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbgKKSLh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 11 Nov 2020 13:11:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC867139F;
        Wed, 11 Nov 2020 10:11:36 -0800 (PST)
Received: from [172.16.1.113] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABF433F718;
        Wed, 11 Nov 2020 10:11:35 -0800 (PST)
Subject: Re: [PATCH] Don't do panic for memory Fatal UE in ghes of x86_mce
To:     yaoaili126@163.com, tony.luck@intel.com, bp@alien8.de
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        YANGFENG1@kingsoft.com, yaoaili@kingsoft.com
References: <72ca543a-5022-bd12-14b5-4d7b125cd0fe () arm ! com>
 <20201109060757.406689-1-yaoaili126@163.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <c292438a-eeb0-abca-6e0c-92339ae3d998@arm.com>
Date:   Wed, 11 Nov 2020 18:11:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201109060757.406689-1-yaoaili126@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello,

(Boris, Tony, question below: have you seen a machine taking both MCE and at least
populating FF records for the same error?)

On 09/11/2020 06:07, yaoaili126@163.com wrote:
> James Morse wrote:
>> Its not arm platforms I'm worried about! Its x86 systems that do everything
>> firmware-first, or everything kernel-first. You seem to have something doing
>> a bit of both, anything added needs to not break the other systems.
>>
>> You can't know at compile time if the system will be doing a bit of both.
>> You must detect it from the entries in the HEST.


> Oh, This time I know your concern, I have assumed that x86 will never trigger NMI
> for memory UE errors, I need to dig more about this.

Systems broadly fall into one of three buckets:

1. kernel-first: The OS takes a machine check when an error occurs.
2. firmware-first: Firmware takes over when an error occurs, and provides a standard
description of the error via these GHES things, and notifies the OS by some means.
3. neither of the above.

Linux supports all of these, and works out which kind of system you have at boot.

You appear to have a machine that is doing 1 and 2 at the same time...


>> But - maybe this isn't GHES-ASSIST!
>>
>> Could you dump the HEST and check the flags. Something like:
>> | cp /sys/firmware/acpi/tables/HEST  .
>> | iasl HEST
>>
>> Look for the GHES entries having an 'alternate source id' that in turn has the
>> GHES_ASSIST flag set.
>>
>> GHES-ASSIST has been my assumption as you were finding firmware-first
>> records during machine-check. (which suggests its not really a firmware-first
>> system)
>>
>> If the GHES-ASSIST flag isn't set, then something else is going on.

> I have provided the HEST table to you, And I think your concern is right,
> before further action, we must clarify the GHES-ASSIST topic, I will also look
> into it. Thanks!

Thanks for sending those. None of them support GHES-ASSIST.
A cut down version of your lenovo example:

[028h 0040   2]                Subtable Type : 0001 [IA-32 Corrected Machine Check]
[02Ah 0042   2]                    Source Id : 0001
[02Ch 0044   2]                    Reserved1 : 0000
[02Eh 0046   1]        Flags (decoded below) : 01
                              Firmware First : 1
[02Fh 0047   1]                      Enabled : 01

...

[288h 0648   2]                Subtable Type : 0009 [Generic Hardware Error Source]
[28Ah 0650   2]                    Source Id : 0002
[28Ch 0652   2]            Related Source Id : 0001

This tells us that IA-32 Corrected Machine Check errors can be taken via firmware-first,
and if they are - errors are reported via GHES.2 (which is polled).

The flags field has a 'GHES-ASSIST' flag which means 'both', it is not set in any of the
files you sent. I'm afraid this was a bad suggestion from me.

On  this machine, you should see arch_apei_enable_cmcff() print:
| HEST: Enabling Firmware First mode for corrected errors.
on this machine. It spots the firmware-first flag, ignores enabled, and calls
mce_disable_bank() for the listed banks as firmware says it is handling these.


But, you've been seeing uncorrected errors, and none of these tables describe a 'type 0 -
IA-32 Architecture Machine Check Exception Structure'... so presumably linux has
discovered the hardware itself, and firmware has failed to describe that it is taking
these errors...

Boris, Tony, have you seen anything like this before?
(is there a well-known firmware bug down here?)


Have you seen this happen without triggering the error via einj? Is is possible its just
the error injection code in firmware that is doing the wrong thing?


>>> I do wondering if we can add one option to each error record the OS
>>> received from BIOS, if we can, we may unify some of ghes_proc brached
>>> which is seperate by CONFIG_OPTIONS, this will do more clean code.
>>
>> I'm not sure what you are suggesting here.

> I am suggesting the GHES-ASSIST flag per error record. not GHES-ASSIST flag per
> error source.

I'm afraid the ACPI specification dictates how this works.


>>> 3. I have some test result from an Fatal UE inject, following:
>>> It seems the NMI has preempt MCE, and MCE's work isn't finished as NMI
>>> has decided to panic. I may refers to Intel for some help.
>>> That's not good as we may lose the mcelog in pstore.
>>
>>> Even if there is no kdump fail issue, I think the No panic action for
>>> Fatal memory is still needed.
>>
>> Injecting fatal errors is expected to be fatal.

[...]

>> You are triggering this with some error injection... its possible this would
>> never actually happen in real life as the kernel takes the errors via machine-
>> check, firmware never finds out.
>> Is it possible to check with your BIOS vendor whether this is the case?
>>
> 
> I think we have different opinions on this:
> I think the NMI process in this case is un-expected, it's from NMI watchdog.
> you think This NMI is from BIOS's Firmware Frst Mode invocation. Am I right?

Yes, we're not quite agreed on this, because:

> I prefer my opinion. Because in my tests and real production cases, this is
> not the Only case I met, mostly I will get mce_panic log or both mce and 
> ghes log when panic.

Where do the GHES CPER records come from?

The memory areas are paired up with the notifications. Linux only reads the regions that
go with an NMI when it takes an NMI. If firmware wrote to the regions that go with the
NMI, its because firmware believes its doing firmware-first for errors reported via NMI.

In which case, why are you also taking a machine-check?


In the case you get both MCE and CPER records - do they describe the same error?


> I do ask for help from a vendor, He confirmed my opinion but i can't 
> guarantee he is right as i know little about BIOS.

That the watchdog generates NMI? Sure.

I think the question is whether firmware handles your 'Fatal UE inject' firmware-first, or
not.

If not - why is it writing CPER records to the GHES regions that go with NMI?
(even if the NMI comes from somewhere else - this is what makes linux think its
firmware-first doing this)

If firmware-first, how come you also see a machine-check?


I'm afraid beyond this we'd need someone who knows more about x86 to comment.
I suspect there is something missing from the firmware tables.


If you don't want the firmware-first behaviour, and its causing problems, you can disable
it with 'ghes_disable' on the kernel cmdline. If firmware never triggers the NMI for
firmware-first, this should hide the problem of it spuriously writing records.


Thanks,

James
