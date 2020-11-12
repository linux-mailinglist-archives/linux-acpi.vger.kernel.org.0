Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2CB2B01D9
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Nov 2020 10:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgKLJPz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 04:15:55 -0500
Received: from mail.kingsoft.com ([114.255.44.145]:44104 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgKLJPy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2020 04:15:54 -0500
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Nov 2020 04:15:51 EST
X-AuditID: 0a580155-613ff7000003c60c-59-5facf5eff491
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id 55.04.50700.FE5FCAF5; Thu, 12 Nov 2020 16:44:31 +0800 (HKT)
Received: from aili-OptiPlex-7020 (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 12 Nov
 2020 17:00:39 +0800
Date:   Thu, 12 Nov 2020 17:00:39 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     James Morse <james.morse@arm.com>, <tony.luck@intel.com>,
        <bp@alien8.de>
CC:     <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <YANGFENG1@kingsoft.com>,
        <CHENGUOMIN@kingsoft.com>, <yaoaili@kingsoft.com>
Subject: Re: [PATCH] Don't do panic for memory Fatal UE in ghes of x86_mce
Message-ID: <20201112170039.7ba08c14.yaoaili@kingsoft.com>
In-Reply-To: <c292438a-eeb0-abca-6e0c-92339ae3d998@arm.com>
References: <72ca543a-5022-bd12-14b5-4d7b125cd0fe () arm ! com>
        <20201109060757.406689-1-yaoaili126@163.com>
        <c292438a-eeb0-abca-6e0c-92339ae3d998@arm.com>
Organization: Kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsXCFcGooPv+65p4g+e/jSw+b/jHZnF/33Im
        i50P37JZLN/Xz2hx5vQlVos3F+6xOLB5fG/tY/FYM28No8fiPS+ZPDat6mTz2HK1ncXj8ya5
        ALYoLpuU1JzMstQifbsErow9y/awFUxwqpj84D9rA+MGoy5GTg4JAROJ+QePsXUxcnEICUxn
        kvjzqY8FwnnBKDFv9gM2kCoWAVWJbQf/sYDYbED2rnuzWEFsEQEfibdHDjCCNDALTGeU2N82
        gRkkISzgJXF7dhcjiM0rYCXR/6wNrIFTwFriSctLJogN8xklfh7+ClTEwcEvICbxqsEY4iR7
        ied/zzJD9ApKnJz5BGwxs4COxIlVx5ghbHmJ7W/ngNlCAooSh5f8YofoVZI40j2DDcKOlVg2
        7xXrBEbhWUhGzUIyahaSUQsYmVcxshTnphttYoTEQ+gOxhlNH/UOMTJxMB5ilOBgVhLhVXZY
        Ey/Em5JYWZValB9fVJqTWnyIUZqDRUmct/YsUEogPbEkNTs1tSC1CCbLxMEp1cAkueoCf7MY
        IzfDVs+FccJFNuyHyn9d2+/seb9x7qrpKTPXTxbbkHDXiUWUL27C5l2rLZzcVwmJTw+ur7yf
        wGB09UJnRElXsq+E9yN3lhLZZnHTVVc/nclPUcqQePl9dUNL8m2n9/2PHsZ9OFRhotHQuGJf
        5eHZGjNSm0rybbpn9vl/2fPU7qSH2dc+p30KJ3dNnVo6wzM0XXme382aqbdC9n3NFPPfnmly
        Z5V2mt+twLLonnXXn9xT7Fwz/9M0l9AVuy322TrO5VDyvne25G3AjePf7/xJZg5L5JaOjHn9
        cqHrj+Tkwg1KrtIC65boWcTo6rMnzwlmcBa8s+NLZoHzea/Xp/Yq7fCc1ny4wUqJpTgj0VCL
        uag4EQDiJkIw9gIAAA==
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi!
Thanks for your comments!

//I have changed my email client, hope this client will not start a new thread automatically :) 
//I am not sure

On Wed, 11 Nov 2020 18:11:22 +0000
James Morse <james.morse@arm.com> wrote:

> Hello,
> 
> (Boris, Tony, question below: have you seen a machine taking both MCE and at least
> populating FF records for the same error?)
> 
> On 09/11/2020 06:07, yaoaili126@163.com wrote:
> > James Morse wrote:  
> >> Its not arm platforms I'm worried about! Its x86 systems that do everything
> >> firmware-first, or everything kernel-first. You seem to have something doing
> >> a bit of both, anything added needs to not break the other systems.
> >>
> >> You can't know at compile time if the system will be doing a bit of both.
> >> You must detect it from the entries in the HEST.  
> 
> 
> > Oh, This time I know your concern, I have assumed that x86 will never trigger NMI
> > for memory UE errors, I need to dig more about this.  
> 
> Systems broadly fall into one of three buckets:
> 
> 1. kernel-first: The OS takes a machine check when an error occurs.
> 2. firmware-first: Firmware takes over when an error occurs, and provides a standard
> description of the error via these GHES things, and notifies the OS by some means.
> 3. neither of the above.
> 
> Linux supports all of these, and works out which kind of system you have at boot.
> 
> You appear to have a machine that is doing 1 and 2 at the same time...
> 

Intel document does say this: when EMCA enabled, Memory UE will trigger one SMI to get into
Bios code, as so called Firmware First Mode, and when BIOS get the work done, It should raise
one MCE exception.

> 
> >> But - maybe this isn't GHES-ASSIST!
> >>
> >> Could you dump the HEST and check the flags. Something like:
> >> | cp /sys/firmware/acpi/tables/HEST  .
> >> | iasl HEST
> >>
> >> Look for the GHES entries having an 'alternate source id' that in turn has the
> >> GHES_ASSIST flag set.
> >>
> >> GHES-ASSIST has been my assumption as you were finding firmware-first
> >> records during machine-check. (which suggests its not really a firmware-first
> >> system)
> >>
> >> If the GHES-ASSIST flag isn't set, then something else is going on.  
> 
> > I have provided the HEST table to you, And I think your concern is right,
> > before further action, we must clarify the GHES-ASSIST topic, I will also look
> > into it. Thanks!  
> 
> Thanks for sending those. None of them support GHES-ASSIST.
> A cut down version of your lenovo example:
> 
> [028h 0040   2]                Subtable Type : 0001 [IA-32 Corrected Machine Check]
> [02Ah 0042   2]                    Source Id : 0001
> [02Ch 0044   2]                    Reserved1 : 0000
> [02Eh 0046   1]        Flags (decoded below) : 01
>                               Firmware First : 1
> [02Fh 0047   1]                      Enabled : 01
> 
> ...
> 
> [288h 0648   2]                Subtable Type : 0009 [Generic Hardware Error Source]
> [28Ah 0650   2]                    Source Id : 0002
> [28Ch 0652   2]            Related Source Id : 0001
> 
> This tells us that IA-32 Corrected Machine Check errors can be taken via firmware-first,
> and if they are - errors are reported via GHES.2 (which is polled).
> 
> The flags field has a 'GHES-ASSIST' flag which means 'both', it is not set in any of the
> files you sent. I'm afraid this was a bad suggestion from me.

I still think your suggestion is good. I think if x86 server do raise NMI for memory UE errors
BIOS may should prepare one hest table with type ACPI_HEST_TYPE_IA32_NMI from ACPI_Spec_6_3:

18.3.2.3 IA-32 Architecture Non-Maskable Interrupt
Uncorrected platform errors are typically reported using the Non-Maskable Interrupt (NMI) vector (for example, INT
2). This table allows platform firmware to communicate parameters regarding the configuration and handling of NMI
error conditions.
Only one entry of this type is permitted in the HEST.

we can search for this table when boot, if not found, we can assume UE of the x86 platform will not trigger NMI and we can take action of no panic.
But i need to conform this, and need some time and this may be not right. May others and intel experts will help on this.

> 
> On  this machine, you should see arch_apei_enable_cmcff() print:
> | HEST: Enabling Firmware First mode for corrected errors.
> on this machine. It spots the firmware-first flag, ignores enabled, and calls
> mce_disable_bank() for the listed banks as firmware says it is handling these.
> 
> 
> But, you've been seeing uncorrected errors, and none of these tables describe a 'type 0 -
> IA-32 Architecture Machine Check Exception Structure'... so presumably linux has
> discovered the hardware itself, and firmware has failed to describe that it is taking
> these errors...
> 
> Boris, Tony, have you seen anything like this before?
> (is there a well-known firmware bug down here?)
> 
> 
> Have you seen this happen without triggering the error via einj? Is is possible its just
> the error injection code in firmware that is doing the wrong thing?
> 
> 
> >>> I do wondering if we can add one option to each error record the OS
> >>> received from BIOS, if we can, we may unify some of ghes_proc brached
> >>> which is seperate by CONFIG_OPTIONS, this will do more clean code.  
> >>
> >> I'm not sure what you are suggesting here.  
> 
> > I am suggesting the GHES-ASSIST flag per error record. not GHES-ASSIST flag per
> > error source.  
> 
> I'm afraid the ACPI specification dictates how this works.
> 
> 
> >>> 3. I have some test result from an Fatal UE inject, following:
> >>> It seems the NMI has preempt MCE, and MCE's work isn't finished as NMI
> >>> has decided to panic. I may refers to Intel for some help.
> >>> That's not good as we may lose the mcelog in pstore.  
> >>  
> >>> Even if there is no kdump fail issue, I think the No panic action for
> >>> Fatal memory is still needed.  
> >>
> >> Injecting fatal errors is expected to be fatal.  
> 
> [...]
> 
> >> You are triggering this with some error injection... its possible this would
> >> never actually happen in real life as the kernel takes the errors via machine-
> >> check, firmware never finds out.
> >> Is it possible to check with your BIOS vendor whether this is the case?
> >>  
> > 
> > I think we have different opinions on this:
> > I think the NMI process in this case is un-expected, it's from NMI watchdog.
> > you think This NMI is from BIOS's Firmware Frst Mode invocation. Am I right?  
> 
> Yes, we're not quite agreed on this, because:
> 
> > I prefer my opinion. Because in my tests and real production cases, this is
> > not the Only case I met, mostly I will get mce_panic log or both mce and 
> > ghes log when panic.  
> 
> Where do the GHES CPER records come from?
> 
> The memory areas are paired up with the notifications. Linux only reads the regions that
> go with an NMI when it takes an NMI. If firmware wrote to the regions that go with the
> NMI, its because firmware believes its doing firmware-first for errors reported via NMI.
> 
> In which case, why are you also taking a machine-check?
> 
> 
> In the case you get both MCE and CPER records - do they describe the same error?
> 
> 
> > I do ask for help from a vendor, He confirmed my opinion but i can't 
> > guarantee he is right as i know little about BIOS.  
> 
> That the watchdog generates NMI? Sure.
> 

he confirmed No NMI will be triggered for memory UE.

> I think the question is whether firmware handles your 'Fatal UE inject' firmware-first, or
> not.
> 
> If not - why is it writing CPER records to the GHES regions that go with NMI?
> (even if the NMI comes from somewhere else - this is what makes linux think its
> firmware-first doing this)
> 
> If firmware-first, how come you also see a machine-check?
> 
> 
> I'm afraid beyond this we'd need someone who knows more about x86 to comment.
> I suspect there is something missing from the firmware tables.
> 
> 
> If you don't want the firmware-first behaviour, and its causing problems, you can disable
> it with 'ghes_disable' on the kernel cmdline. If firmware never triggers the NMI for
> firmware-first, this should hide the problem of it spuriously writing records.
> 
> 
> Thanks,
> 
> James

Thanks
Aili Yao
