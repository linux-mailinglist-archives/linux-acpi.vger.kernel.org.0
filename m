Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87672A06BA
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Oct 2020 14:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgJ3Nro (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Oct 2020 09:47:44 -0400
Received: from foss.arm.com ([217.140.110.172]:34938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgJ3Nrn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Oct 2020 09:47:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1D9E30E;
        Fri, 30 Oct 2020 06:47:42 -0700 (PDT)
Received: from [172.16.1.113] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41AF33F68F;
        Fri, 30 Oct 2020 06:47:41 -0700 (PDT)
Subject: Re: [PATCH] Don't do panic for memory Fatal UE in ghes of x86_mce
 platform
To:     yaoaili126@163.com
Cc:     rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        bp@alien8.de, linux-acpi@vger.kernel.org, YANGFENG1@kingsoft.com,
        yaoaili@kingsoft.com
References: <3942f335-b905-4c8f-bf81-7bdff6c025ad () arm ! com>
 <20201029122711.7091-1-yaoaili126@163.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <076b78b6-4d3c-028c-7dc0-467f5afed1a9@arm.com>
Date:   Fri, 30 Oct 2020 13:47:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201029122711.7091-1-yaoaili126@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello,

On 29/10/2020 12:27, yaoaili126@163.com wrote:
> From: Aili Yao <yaoaili@kingsoft.com>
>> -----Original Message-----
>> From: James Morse [mailto:james.morse@arm.com]

>> On 28/10/2020 07:35, yaoaili126@163.com wrote:
>>> From: Aili Yao <yaoaili@kingsoft.com>
>>>
>>> For x86 with mce, when BIOS get its work done for memory UE,it will
>>> raise MCE exception, In MCE, it will do panic or recovery work there.
>>> But When BIOS option WHEA memory log is enabled,
>>
>> This is GHES_ASSIST?
> 
> sorry, I am not sure, What i know is this option for x86 is only to supply
> more error information.

GHES has two modes, one where it gets the only error notification, and must handle the
error, including deciding whether to call panic().
The other where it provides extra information for another error source.

Could you dump the HEST table for your machine to see if the GHES 'related source id'
points to an alternate source that has the GHES_ASSIST flag set?
See table 18.10 and table 18.5 of the ACPI spec v6.3a for what to look for.

If its not set ... something else is going on.


>>> BIOS also prepared one
>>> detailed error table which will be polled by ghes_notify_nmi from NMI
>>> watchdog,
>>
>> heh, because the NMI notification chain has no idea what triggered it...
>>
>>
>>> ghes_notify_nmi will check the severity and do panic too, this panic
>>> action is not necessary and confusing, and may lead to unwanted
>>> results like core dump fail.
>>>
>>> Downgrade CPER_SEV_FATAL to GHES_SEV_RECOVERABLE before panic is
>>> called for x86_mce
>>
>> You can't know whether your platform (will?) also generate an MCE when
>> you build the kernel. Distros set all the Kconfig options, they aren't tuned to
>> the platform.
>>
>> This also makes fatal memory errors recoverable, which isn't true for other
>> platforms.

> I am little confused, if any thing wrong, correct me: I know ACPI and APEI support
> x86 and ARM, is there any other Platform I don't know? if a Platform doesn't support 
> this, this code will never execute even when the config is on. And for a ARM platfrom 
> Distros, I don't think it's right to have CONFIG_X86_MCE on. 

I probably picked the wrong term with platform.

You might buy servers from Dell that have the behaviour you are seeing, but servers from
HP don't. You can't make the decision on which behaviour you are going to see when
compiling the kernel, as you don't know whether that kernel will run on servers from Dell,
or HP.

Determining which behaviour is being seen needs to come from the ACPI table.
From what you describe, this sounds like GHES_ASSIST.


>> Assuming this is GHES_ASSIST, I think the simplest approach is to skip the
>> panic() for CPER records found for those GHES. APEI is only providing
>> assistance in this case, so its unfair for it to take some terminal action. The
>> machine-check handler should have the final say in in this case.

Something like [0] - which I've only build tested.


>> Section 18.7 of ACPI v6.3a says we're supposed to:
>> | consume the additional GHES_ASSIST information in the context of an
>> | error reported by hardware
>> which would be the MCE - so there is no reason for these GHES entries to be
>> poked whenever an unrelated NMI occurs.
>>
>> Fixing this would need a separate list for the machine check handler to poke
>> to dump any data from GHES_ASSIST CPER, so its more work than just
>> skipping the register call.

> This is a great idea！ This way we may collect more error info and avoid the issue mentioned
> before. I do realize a prototype following your method，i will try it and test it. 

>> (I've no idea how x86 prioritises MCE and NMI... does one block the other?)
> 
> From intel sdm, it says MCE has higher priority than NMI.

So GHES doesn't have to worry about interrupting the thing it was supposed to assist,
great! It will need its own fixmap slot as the NMI one may have been in use when you took
the MCE.


> but the latest kernel is changing
> fast, NMI may can preemt the MCE for userspace? I am not sure. 


Thanks,

James


[0] Totally untested:
------------%<------------
diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
index 1d6ef9654725..b268fb6e9ffb 100644
--- a/drivers/acpi/apei/apei-internal.h
+++ b/drivers/acpi/apei/apei-internal.h
@@ -118,6 +118,8 @@ void apei_resources_release(struct apei_resources *resources);
 int apei_exec_collect_resources(struct apei_exec_context *ctx,
                                struct apei_resources *resources);

+bool apei_is_ghes_assist(struct acpi_hest_generic *ghes);
+
 struct dentry;
 struct dentry *apei_get_debugfs_dir(void);

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index fce7ade2aba9..52201304c046 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -814,7 +814,7 @@ static int ghes_proc(struct ghes *ghes)
        if (rc)
                goto out;

-       if (ghes_severity(estatus->error_severity) >= GHES_SEV_PANIC)
+       if (ghes_severity(estatus->error_severity) >= GHES_SEV_PANIC && !ghes->assist)
                __ghes_panic(ghes, estatus, buf_paddr, FIX_APEI_GHES_IRQ);

        if (!ghes_estatus_cached(estatus)) {
@@ -1020,7 +1020,7 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
        }

        sev = ghes_severity(estatus->error_severity);
-       if (sev >= GHES_SEV_PANIC) {
+       if (sev >= GHES_SEV_PANIC && !ghes->assist) {
                ghes_print_queued_estatus();
                __ghes_panic(ghes, estatus, buf_paddr, fixmap_idx);
        }
@@ -1280,6 +1280,8 @@ static int ghes_probe(struct platform_device *ghes_dev)
                goto err;
        }

+       ghes->assist = apei_is_ghes_assist(generic);
+
        switch (generic->notify.type) {
        case ACPI_HEST_NOTIFY_POLLED:
                timer_setup(&ghes->timer, ghes_poll_func, 0);
diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 6e980fe16772..55e3a44fd6e7 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -117,6 +117,42 @@ int apei_hest_parse(apei_hest_func_t func, void *data)
 }
 EXPORT_SYMBOL_GPL(apei_hest_parse);

+static int __is_ghes_assist(struct acpi_hest_header *hest_hdr, void *data)
+{
+       struct acpi_hest_aer_common *cmn_hdr;
+       u16 err_src = *(u16 *)data;
+
+       if (hest_hdr->source_id != err_src)
+               return 0;
+
+       switch (hest_hdr->type) {
+       /* GHES can't help itself */
+       case ACPI_HEST_TYPE_GENERIC_ERROR:
+       case ACPI_HEST_TYPE_GENERIC_ERROR_V2:
+       default:
+               return 0;
+       case ACPI_HEST_TYPE_IA32_CHECK:
+       case ACPI_HEST_TYPE_IA32_CORRECTED_CHECK:
+       /* ACPI_HEST_TYPE_IA32_NMI does not support GHES_ASSIST */
+               cmn_hdr = (struct acpi_hest_aer_common *)hest_hdr;
+
+               if (cmn_hdr->flags & ACPI_HEST_FIRMWARE_FIRST &&
+                   cmn-hdr->flags & ACPI_HEST_GHES_ASSIST)
+                       return 1;
+       }
+
+       return 0;
+}
+
+bool apei_is_ghes_assist(struct acpi_hest_generic *ghes)
+{
+       if (ghes->related_source_id == 0xffff)
+               return false;
+
+       return apei_hest_parse(__is_ghes_assist, &ghes->related_source_id);
+}
+
+
 /*
  * Check if firmware advertises firmware first mode. We need FF bit to be set
  * along with a set of MC banks which work in FF mode.
------------%<------------


