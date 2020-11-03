Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10102A3CF1
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Nov 2020 07:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgKCGmW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Nov 2020 01:42:22 -0500
Received: from mail-m973.mail.163.com ([123.126.97.3]:59658 "EHLO
        mail-m973.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgKCGmW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Nov 2020 01:42:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=CA3ag
        dP8HMSZ16aXpXcExgN4/kSRHGcenyBnyMdPh9w=; b=a7j+HofAoEY9InrO5rGKd
        oMz9eQyAsBH+hTF5XZltfpBl6BQ/ykSvNrx+4qoHlKydfusPILs9tNb4zcj+RqIa
        fiE+8ugjIRXrVBSCEKfa2UhXc1gZMRrCiq2Nzs044qIZFkWx8CVwmsNC08hwywOz
        SvaAdqkb+ZQPhhlVnhQmhI=
Received: from smtp.163.com (unknown [36.112.24.9])
        by smtp3 (Coremail) with SMTP id G9xpCgC3QWOn+6Bf3WtMKA--.127S2;
        Tue, 03 Nov 2020 14:41:44 +0800 (CST)
From:   yaoaili126@163.com
To:     james.morse@arm.com
Cc:     rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        bp@alien8.de, linux-acpi@vger.kernel.org, YANGFENG1@kingsoft.com,
        CHENGUOMIN@kingsoft.com, yaoaili@kingsoft.com
Subject: Re: [PATCH] Don't do panic for memory Fatal UE in ghes of x86_mce
Date:   Mon,  2 Nov 2020 22:41:10 -0800
Message-Id: <20201103064109.25152-1-yaoaili126@163.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <076b78b6-4d3c-028c-7dc0-467f5afed1a9 () arm ! com>
References: <076b78b6-4d3c-028c-7dc0-467f5afed1a9 () arm ! com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgC3QWOn+6Bf3WtMKA--.127S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3uFW7CFy7uFW3uFykJw15twb_yoWkKw45pF
        WSvanIkr4kGr1rtw40vF4jq3yYv3s7CFy5Jr98XryrA3Z09Fy0yr4xK34j9F9xGrW8W3yS
        vFyqqrnFka4kZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UidbnUUUUU=
X-Originating-IP: [36.112.24.9]
X-CM-SenderInfo: 51drtxdolrjli6rwjhhfrp/1tbifAvRG1r6nPtBdgABsM
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Aili Yao <yaoaili@kingsoft.com>

Hi! Thanks for your comments!

1. I dig a little more into Config system of kernel, I see this:
arch/x86/configs/x86_64_defconfig:45:CONFIG_X86_MCE=y, but for other 
platform not, and I think if CONFIG_X86_MCE if not enough to avoid other 
platform, how about this:
  #if defined(CONFIG_X86) && defined(CONFIG_X86_MCE)
for a different platfrom like ARM64, they can't enable CONFIG_X86.

2. I tested your draft codes, and it doesn't work,
  [    8.311488] ghes_probe,1298 assist:0
  [    8.315177] ghes_probe,1298 assist:0
  [    8.318877] ghes_probe,1298 assist:0
For the server i use, the ghes module will create 3 ghes struct, one is for
poll timer, second is for sci, the third is for NMI. for x86 platform, 
the NMI ghes is not only for memory but also other hw error like PCIE,
I don't know how assist will be set for this senario, Maybe different 
manufactures of hw may have different values. 
I do wondering if we can add one option to each error record the OS 
received from BIOS, if we can, we may unify some of ghes_proc brached
which is seperate by CONFIG_OPTIONS, this will do more clean code.

3. I have some test result from an Fatal UE inject, following:
It seems the NMI has preempt MCE, and MCE's work
isn't finished as NMI has decided to panic. I may refers to Intel for
some help. 
That's not good as we may lose the mcelog in pstore.

Even if there is no kdump fail issue, I think the No panic action for 
Fatal memory is still needed.

[  995.167270] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 4
[  995.167271] {1}[Hardware Error]: event severity: fatal
[  995.167271] {1}[Hardware Error]:  Error 0, type: fatal
[  995.167271] {1}[Hardware Error]:  fru_text: Card03, ChnA, DIMM0
[  995.167272] {1}[Hardware Error]:   section_type: memory error
[  995.167272] {1}[Hardware Error]:   error_status: 0x0000000000000000
[  995.167272] {1}[Hardware Error]:   physical_address: 0x00000046fe735000
[  995.167273] {1}[Hardware Error]:   node: 2 card: 0 module: 0 rank: 0 bank: 1 device: 0 row: 62761 column: 208
[  995.167273] {1}[Hardware Error]:   DIMM location: CPU 1 DIMM 4
[  995.167274] Kernel panic - not syncing: Fatal hardware error!
[  995.167274] CPU: 47 PID: 0 Comm: swapper/47 Kdump: loaded Not tainted 4.18.0+ #20
[  995.167274] Hardware name: Lenovo ThinkSystem SR650 -[7X06CTO1WW]-/-[7X06CTO1WW]-, BIOS -[IVE636Z-2.13]- 07/18/2019
[  995.167275] Call Trace:
[  995.167275]  <NMI>
[  995.167275]  dump_stack+0x5a/0x73
[  995.167275]  panic+0xe8/0x2bc
[  995.167276]  __ghes_panic+0x68/0x6a
[  995.167276]  ghes_notify_nmi+0x23b/0x290
[  995.167276]  nmi_handle+0x69/0x110
[  995.167276]  default_do_nmi+0x3e/0x110
[  995.167277]  do_nmi+0x116/0x190
[  995.167277]  end_repeat_nmi+0x16/0x6a
[  995.167277] RIP: 0010:machine_check+0x0/0x40
[  995.167278] Code: 00 00 48 89 e7 48 8b 74 24 78 48 c7 44 24 78 ff ff ff ff e8 b2 0e 66 ff e9 ed 02 00 00 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 <0f> 01 ca 6a ff f6 44 24 10 03 75 14 e8 2f 00 00 00 48 89 e7 31 f6
[  995.167278] RSP: 0018:fffffe00007effd8 EFLAGS: 00000046
[  995.167279] RAX: ffffffff97eac2c0 RBX: ffff8f8cc0ce5c40 RCX: 7fffff18a792c0bf
[  995.167279] RDX: 0000000000000001 RSI: 000000000000002f RDI: ffff8fa39fd5d600
[  995.167280] RBP: 000000000000002f R08: 0000000000000008 R09: ffffffdb56bbc181
[  995.167280] R10: 000000000000002f R11: 0000000000000000 R12: 0000000000000000
[  995.167280] R13: 0000000000000000 R14: ffff8f8cc0ce5c40 R15: ffff8f8cc0ce5c40
[  995.167280]  ? __sched_text_end+0x4/0x4
[  995.167281]  ? async_page_fault+0x30/0x30
[  995.167281]  ? async_page_fault+0x30/0x30
[  995.167281]  </NMI>
[  995.167281]  <#MC>
[  995.167282] RIP: 0010:native_safe_halt+0xe/0x10
[  995.167282] Code: ff ff eb bc 90 90 90 90 90 90 90 90 e9 07 00 00 00 0f 00 2d 76 c8 55 00 f4 c3 66 90 e9 07 00 00 00 0f 00 2d 66 c8 55 00 fb f4 <c3> 90 0f 1f 44 00 00 41 54 55 53 e8 e2 29 88 ff 65 8b 2d d3 2a 16
[  995.167283] RSP: 0018:ffffa2e4cca47ea0 EFLAGS: 00000246 </#MC>
[  995.167283]  default_idle+0x1a/0x130
[  995.167283]  do_idle+0x1a6/0x290
[  995.167283]  cpu_startup_entry+0x6f/0x80
[  995.167284]  start_secondary+0x1aa/0x200
[  995.167284]  secondary_startup_64+0xb7/0xc0

Thanks
Aili Yao

> -----Original Message-----
> From: James Morse [mailto:james.morse@arm.com]
> Sent: Friday, October 30, 2020 9:47 PM
> To: yaoaili126@163.com
> Cc: rjw@rjwysocki.net; lenb@kernel.org; tony.luck@intel.com; bp@alien8.de;
> linux-acpi@vger.kernel.org; YANGFENG1
> <YANGFENG1@kingsoft.com>; yaoaili<yaoaili@kingsoft.com>
> Subject: Re: [PATCH] Don't do panic for memory Fatal UE in ghes of x86_mce
> platform
> 
> Hello,
> 
> On 29/10/2020 12:27, yaoaili126@163.com wrote:
> > From: Aili Yao <yaoaili@kingsoft.com>
> >> -----Original Message-----
> >> From: James Morse [mailto:james.morse@arm.com]
> 
> >> On 28/10/2020 07:35, yaoaili126@163.com wrote:
> >>> From: Aili Yao <yaoaili@kingsoft.com>
> >>>
> >>> For x86 with mce, when BIOS get its work done for memory UE,it will
> >>> raise MCE exception, In MCE, it will do panic or recovery work there.
> >>> But When BIOS option WHEA memory log is enabled,
> >>
> >> This is GHES_ASSIST?
> >
> > sorry, I am not sure, What i know is this option for x86 is only to
> > supply more error information.
> 
> GHES has two modes, one where it gets the only error notification, and must
> handle the error, including deciding whether to call panic().
> The other where it provides extra information for another error source.
> 
> Could you dump the HEST table for your machine to see if the GHES 'related
> source id'
> points to an alternate source that has the GHES_ASSIST flag set?
> See table 18.10 and table 18.5 of the ACPI spec v6.3a for what to look for.
> 
> If its not set ... something else is going on.
> 
> 
> >>> BIOS also prepared one
> >>> detailed error table which will be polled by ghes_notify_nmi from
> >>> NMI watchdog,
> >>
> >> heh, because the NMI notification chain has no idea what triggered it...
> >>
> >>
> >>> ghes_notify_nmi will check the severity and do panic too, this panic
> >>> action is not necessary and confusing, and may lead to unwanted
> >>> results like core dump fail.
> >>>
> >>> Downgrade CPER_SEV_FATAL to GHES_SEV_RECOVERABLE before panic
> is
> >>> called for x86_mce
> >>
> >> You can't know whether your platform (will?) also generate an MCE
> >> when you build the kernel. Distros set all the Kconfig options, they
> >> aren't tuned to the platform.
> >>
> >> This also makes fatal memory errors recoverable, which isn't true for
> >> other platforms.
> 
> > I am little confused, if any thing wrong, correct me: I know ACPI and
> > APEI support
> > x86 and ARM, is there any other Platform I don't know? if a Platform
> > doesn't support this, this code will never execute even when the
> > config is on. And for a ARM platfrom Distros, I don't think it's right to have
> CONFIG_X86_MCE on.
> 
> I probably picked the wrong term with platform.
> 
> You might buy servers from Dell that have the behaviour you are seeing, but
> servers from HP don't. You can't make the decision on which behaviour you
> are going to see when compiling the kernel, as you don't know whether that
> kernel will run on servers from Dell, or HP.
> 
> Determining which behaviour is being seen needs to come from the ACPI
> table.
> From what you describe, this sounds like GHES_ASSIST.
> 
> 
> >> Assuming this is GHES_ASSIST, I think the simplest approach is to
> >> skip the
> >> panic() for CPER records found for those GHES. APEI is only providing
> >> assistance in this case, so its unfair for it to take some terminal
> >> action. The machine-check handler should have the final say in in this case.
> 
> Something like [0] - which I've only build tested.
> 
> 
> >> Section 18.7 of ACPI v6.3a says we're supposed to:
> >> | consume the additional GHES_ASSIST information in the context of an
> >> | error reported by hardware
> >> which would be the MCE - so there is no reason for these GHES entries
> >> to be poked whenever an unrelated NMI occurs.
> >>
> >> Fixing this would need a separate list for the machine check handler
> >> to poke to dump any data from GHES_ASSIST CPER, so its more work than
> >> just skipping the register call.
> 
> > This is a great idea！ This way we may collect more error info and
> > avoid the issue mentioned before. I do realize a prototype following your
> method，i will try it and test it.
> 
> >> (I've no idea how x86 prioritises MCE and NMI... does one block the
> >> other?)
> >
> > From intel sdm, it says MCE has higher priority than NMI.
> 
> So GHES doesn't have to worry about interrupting the thing it was supposed
> to assist, great! It will need its own fixmap slot as the NMI one may have
> been in use when you took the MCE.
> 
> 
> > but the latest kernel is changing
> > fast, NMI may can preemt the MCE for userspace? I am not sure.
> 
> 
> Thanks,
> 
> James
> 
> 
> [0] Totally untested:
> ------------%<------------
> diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-
> internal.h
> index 1d6ef9654725..b268fb6e9ffb 100644
> --- a/drivers/acpi/apei/apei-internal.h
> +++ b/drivers/acpi/apei/apei-internal.h
> @@ -118,6 +118,8 @@ void apei_resources_release(struct apei_resources
> *resources);  int apei_exec_collect_resources(struct apei_exec_context *ctx,
>                                 struct apei_resources *resources);
> 
> +bool apei_is_ghes_assist(struct acpi_hest_generic *ghes);
> +
>  struct dentry;
>  struct dentry *apei_get_debugfs_dir(void);
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c index
> fce7ade2aba9..52201304c046 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -814,7 +814,7 @@ static int ghes_proc(struct ghes *ghes)
>         if (rc)
>                 goto out;
> 
> -       if (ghes_severity(estatus->error_severity) >= GHES_SEV_PANIC)
> +       if (ghes_severity(estatus->error_severity) >= GHES_SEV_PANIC &&
> + !ghes->assist)
>                 __ghes_panic(ghes, estatus, buf_paddr, FIX_APEI_GHES_IRQ);
> 
>         if (!ghes_estatus_cached(estatus)) { @@ -1020,7 +1020,7 @@ static int
> ghes_in_nmi_queue_one_entry(struct ghes *ghes,
>         }
> 
>         sev = ghes_severity(estatus->error_severity);
> -       if (sev >= GHES_SEV_PANIC) {
> +       if (sev >= GHES_SEV_PANIC && !ghes->assist) {
>                 ghes_print_queued_estatus();
>                 __ghes_panic(ghes, estatus, buf_paddr, fixmap_idx);
>         }
> @@ -1280,6 +1280,8 @@ static int ghes_probe(struct platform_device
> *ghes_dev)
>                 goto err;
>         }
> 
> +       ghes->assist = apei_is_ghes_assist(generic);
> +
>         switch (generic->notify.type) {
>         case ACPI_HEST_NOTIFY_POLLED:
>                 timer_setup(&ghes->timer, ghes_poll_func, 0); diff --git
> a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c index
> 6e980fe16772..55e3a44fd6e7 100644
> --- a/drivers/acpi/apei/hest.c
> +++ b/drivers/acpi/apei/hest.c
> @@ -117,6 +117,42 @@ int apei_hest_parse(apei_hest_func_t func, void
> *data)  }  EXPORT_SYMBOL_GPL(apei_hest_parse);
> 
> +static int __is_ghes_assist(struct acpi_hest_header *hest_hdr, void
> +*data) {
> +       struct acpi_hest_aer_common *cmn_hdr;
> +       u16 err_src = *(u16 *)data;
> +
> +       if (hest_hdr->source_id != err_src)
> +               return 0;
> +
> +       switch (hest_hdr->type) {
> +       /* GHES can't help itself */
> +       case ACPI_HEST_TYPE_GENERIC_ERROR:
> +       case ACPI_HEST_TYPE_GENERIC_ERROR_V2:
> +       default:
> +               return 0;
> +       case ACPI_HEST_TYPE_IA32_CHECK:
> +       case ACPI_HEST_TYPE_IA32_CORRECTED_CHECK:
> +       /* ACPI_HEST_TYPE_IA32_NMI does not support GHES_ASSIST */
> +               cmn_hdr = (struct acpi_hest_aer_common *)hest_hdr;
> +
> +               if (cmn_hdr->flags & ACPI_HEST_FIRMWARE_FIRST &&
> +                   cmn-hdr->flags & ACPI_HEST_GHES_ASSIST)
> +                       return 1;
> +       }
> +
> +       return 0;
> +}
> +
> +bool apei_is_ghes_assist(struct acpi_hest_generic *ghes) {
> +       if (ghes->related_source_id == 0xffff)
> +               return false;
> +
> +       return apei_hest_parse(__is_ghes_assist,
> +&ghes->related_source_id); }
> +
> +
>  /*
>   * Check if firmware advertises firmware first mode. We need FF bit to be set
>   * along with a set of MC banks which work in FF mode.
> ------------%<------------
> 


