Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597C047E02F
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Dec 2021 09:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbhLWILS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 23 Dec 2021 03:11:18 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:45209 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243034AbhLWILR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 23 Dec 2021 03:11:17 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0V.Wa1Z2_1640247072;
Received: from 30.240.114.155(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0V.Wa1Z2_1640247072)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 Dec 2021 16:11:14 +0800
Message-ID: <8d415145-01bc-ce57-fd00-91ca63090caa@linux.alibaba.com>
Date:   Thu, 23 Dec 2021 16:11:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
From:   Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [RESEND PATCH v4] ACPI: Move sdei_init and ghes_init ahead to
 handle platform errors earlier
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
        lenb@kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
References: <20211221231701.GA1125162@bhelgaas>
Content-Language: en-US
In-Reply-To: <20211221231701.GA1125162@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi, Bjorn,

Thank you for your comments.

在 2021/12/22 AM7:17, Bjorn Helgaas 写道:
> On Thu, Dec 16, 2021 at 09:34:56PM +0800, Shuai Xue wrote:
>> On an ACPI system, ACPI is initialised very early from a subsys_initcall(),
>> while SDEI is not ready until a subsys_initcall_sync().
>>
>> The SDEI driver provides functions (e.g. apei_sdei_register_ghes,
>> apei_sdei_unregister_ghes) to register or unregister event callback for
>> dispatcher in firmware. When the GHES driver probing, it registers the
>> corresponding callback according to the notification type specified by
>> GHES. If the GHES notification type is SDEI, the GHES driver will call
>> apei_sdei_register_ghes to register event call.
>>
>> When the firmware emits an event, it migrates the handling of the event
>> into the kernel at the registered entry-point __sdei_asm_handler. And
>> finally, the kernel will call the registered event callback and return
>> status_code to indicate the status of event handling. SDEI_EV_FAILED
>> indicates that the kernel failed to handle the event.
>>
>> Consequently, when an error occurs during kernel booting, the kernel is
>> unable to handle and report errors until the GHES driver is initialized by
>> device_initcall(), in which the event callback is registered. All errors
>> that occurred before GHES initialization are missed and there is no chance
>> to report and find them again.
>>
>> From commit e147133a42cb ("ACPI / APEI: Make hest.c manage the estatus
>> memory pool") was merged, ghes_init() relies on acpi_hest_init() to manage
>> the estatus memory pool. On the other hand, ghes_init() relies on
>> sdei_init() to detect the SDEI version and the framework for registering
>> and unregistering events.
> 
>> By the way, I don't figure out why acpi_hest_init is called in
>> acpi_pci_root_init, it don't rely on any other thing. May it could
>> be moved further, following acpi_iort_init in acpi_init.
> 
> I think you should drop the "By the way ..." text or move it after the
> "---" at the bottom of your commit log.  It doesn't help understand
> this patch.

I will fix it in next version.

>> sdei_init() relies on ACPI table which is initialized
>> subsys_initcall(): acpi_init(), acpi_bus_init(), acpi_load_tables(),
>> acpi_tb_laod_namespace().  May it should be also moved further,
>> after acpi_load_tables.
> 
> This text also doesn't seem relevant to this patch.

I will delete it in next version.

>> In this patch, move sdei_init and ghes_init as far ahead as
>> possible, right after acpi_hest_init().
> 
> I'm having a hard time figuring out the reason for this patch.
> 
> Apparently the relevant parts are sdei_init() and ghes_init().
> Today they are executed in that order:
> 
>   subsys_initcall_sync(sdei_init);
>   device_initcall(ghes_init);
> 
> After this patch, they would be executed in the same order, but called
> explicitly instead of as initcalls:
> 
>   acpi_pci_root_init()
>   {
>     acpi_hest_init();
>     sdei_init();
>     ghes_init();
>     ...
> 
> Explicit calls are certainly better than initcalls, but that doesn't
> seem to be the reason for this patch.
> 
> Does this patch fix a bug?  If so, what is the bug?

Yes. When the kernel booting, the console logs many times from firmware
before GHES drivers init:

	Trip in MM PCIe RAS handle(Intr:910)
  	Clean PE[1.1.1] ERR_STS:0x4000100 -> 0 INT_STS:F0000000
	Find RP(98:1.0)
	--Walk dev(98:1.0) CE:0 UCE:4000
	...
	ERROR:   sdei_dispatch_event(32a) ret:-1
	--handler(910) end

This is because the callback function has not been registered yet.
Previously reported errors will be overwritten by new ones. Therefore,
all errors that occurred before GHES initialization are missed
and there is no chance to report and find them again.


> You say that currently "errors that occur before GHES initialization
> are missed".  Isn't that still true after this patch?  Does this patch
> merely reduce the time before GHES initialization?  If so, I'm
> dubious, because we have to tolerate an arbitrary amount of time
> there.
After this patch, there are still errors missing. As you mentioned,
we have to tolerate it until the software reporting capability is built.

Yes, this patch merely reduce the time before GHES initialization. The boot
dmesg before this patch:

	[    3.688586] HEST: Table parsing has been initialized.
	...
	[   33.204340] calling  sdei_init+0x0/0x120 @ 1
	[   33.208645] sdei: SDEIv1.0 (0x0) detected in firmware.
	...
	[   36.005390] calling  ghes_init+0x0/0x11c @ 1
	[   36.190021] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.


After this patch, the boot dmesg like bellow:

	[    3.688664] HEST: Table parsing has been initialized.
	[    3.688691] sdei: SDEIv1.0 (0x0) detected in firmware.
	[    3.694557] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.

As we can see, the initialization of GHES is advanced by 33 seconds.
So, in my opinion, this patch is necessary, right?
(It should be noted that the effect of optimization varies with the platform.)

> s/acpi_tb_laod_namespace/acpi_tb_load_namespace/

> You use "()" after function names sometimes, but not always.  Please
> do it consistently.

Thank you for pointing this out. I will fix it in next version.


>> -device_initcall(ghes_init);
> 
>>  void __init acpi_pci_root_init(void)
>>  {
>>  	acpi_hest_init();
>> +	sdei_init();
>> +	ghes_init();
> 
> What's the connection between PCI, SDEI, and GHES?  As far as I can
> tell, SDEI and GHES are not PCI-specific, so it doesn't seem like they
> should be initialized here in acpi_pci_root_init().

The only reason is that acpi_hest_init() is initialized here.

From commit e147133a42cb ("ACPI / APEI: Make hest.c manage the estatus
memory pool") was merged, ghes_init() relies on acpi_hest_init() to manage
the estatus memory pool. On the other hand, ghes_init() relies on
sdei_init() to detect the SDEI version and the framework for registering
and unregistering events. The dependencies are as follows

	ghes_init() => acpi_hest_init()
	ghes_init() => sdei_init()

I don't figure out why acpi_hest_init() is called in
acpi_pci_root_init(), it don't rely on any other thing.
I am wondering that should we moved all of them further? e.g.
following acpi_iort_init() in acpi_init().

Best Regards,
Shuai
