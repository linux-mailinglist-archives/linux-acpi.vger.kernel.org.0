Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEE129EA89
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 12:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgJ2La0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 07:30:26 -0400
Received: from m12-13.163.com ([220.181.12.13]:60832 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgJ2LaW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Oct 2020 07:30:22 -0400
X-Greylist: delayed 5505 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Oct 2020 07:30:20 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=AaNZ+
        UTrfFvTmfBqxcF0huHAYMs+6mQfOeQlH2xbxjA=; b=Hd+VDlowan/+N+GuLVN8Q
        fHY93IR+pPUi4Bac+g5KqagFOdidHXnEJbm+BngZarHENalmPqyms1oOo4i8vR/N
        pR7HfJslaMHv5AItrxMFMIUYRlajR8sfANLh/rNMM1GdyRrr2SUycw0jsCI+VQ/V
        UBoAljVllRXNG2vQ2oVghw=
Received: from smtp.163.com (unknown [36.112.24.9])
        by smtp9 (Coremail) with SMTP id DcCowAAnJoIekppfNTowNw--.42547S2;
        Thu, 29 Oct 2020 17:57:51 +0800 (CST)
From:   yaoaili126@163.com
To:     james.morse@arm.com
Cc:     rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        bp@alien8.de, linux-acpi@vger.kernel.org, YANGFENG1@kingsoft.com,
        CHENGUOMIN@kingsoft.com, yaoaili@kingsoft.com
Subject: Subject: Re:Re: [PATCH] Don't do panic for memory Fatal UE in ghes of x86_mce platform
Date:   Thu, 29 Oct 2020 02:57:37 -0700
Message-Id: <20201029095737.5165-1-yaoaili126@163.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <3942f335-b905-4c8f-bf81-7bdff6c025ad () arm ! com>
References: <3942f335-b905-4c8f-bf81-7bdff6c025ad () arm ! com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAAnJoIekppfNTowNw--.42547S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw13WrWrAw1fWr1ruFy7Awb_yoWrWFWDpF
        WaqFyIkry8KFy2yF1Iqr48uFWYvan3C345G3sxt34rCas8u3W0vr42gr1aga4DGryqqry8
        tr4vgr9rKa9YvaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2ZXrUUUUU=
X-Originating-IP: [36.112.24.9]
X-CM-SenderInfo: 51drtxdolrjli6rwjhhfrp/1tbifAjMG1r6nJVPCQABsN
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi, Thanks for your comments!

> -----Original Message-----
> From: James Morse [mailto:james.morse@arm.com]
> Sent: Thursday, October 29, 2020 3:20 AM
> To: yaoaili126@163.com
> Cc: rjw@rjwysocki.net; lenb@kernel.org; tony.luck@intel.com; bp@alien8.de;
> linux-acpi@vger.kernel.org; YANGFENG1 [杨峰]
> <YANGFENG1@kingsoft.com>; CHENGUOMIN [陈国民]
> <CHENGUOMIN@kingsoft.com>; yaoaili [么爱利] <yaoaili@kingsoft.com>
> Subject: Re: [PATCH] Don't do panic for memory Fatal UE in ghes of x86_mce
> platform
> 
> Hi!
> 
> On 28/10/2020 07:35, yaoaili126@163.com wrote:
> > From: Aili Yao <yaoaili@kingsoft.com>
> >
> > For x86 with mce, when BIOS get its work done for memory UE,it will
> > raise MCE exception, In MCE, it will do panic or recovery work there.
> > But When BIOS option WHEA memory log is enabled,
> 
> This is GHES_ASSIST?

sorry, I am not sure, What i know is this option for x86 is only to supply
more error information.

> 
> > BIOS also prepared one
> > detailed error table which will be polled by ghes_notify_nmi from NMI
> > watchdog,
> 
> heh, because the NMI notification chain has no idea what triggered it...
> 
> 
> > ghes_notify_nmi will check the severity and do panic too, this panic
> > action is not necessary and confusing, and may lead to unwanted
> > results like core dump fail.
> >
> > Downgrade CPER_SEV_FATAL to GHES_SEV_RECOVERABLE before panic is
> > called for x86_mce
> 
> You can't know whether your platform (will?) also generate an MCE when
> you build the kernel. Distros set all the Kconfig options, they aren't tuned to
> the platform.
> 
> This also makes fatal memory errors recoverable, which isn't true for other
> platforms.
> 

I am little confused, if any thing wrong, correct me: I know ACPI and APEI support
x86 and ARM, is there any other Platform I don't know? if a Platform doesn't support 
this, this code will never execute even when the config is on. And for a ARM platfrom 
Distros, I don't think it's right to have CONFIG_X86_MCE on. 

> 
> Assuming this is GHES_ASSIST, I think the simplest approach is to skip the
> panic() for CPER records found for those GHES. APEI is only providing
> assistance in this case, so its unfair for it to take some terminal action. The
> machine-check handler should have the final say in in this case.
> 
> 
> Section 18.7 of ACPI v6.3a says we're supposed to:
> | consume the additional GHES_ASSIST information in the context of an
> | error reported by hardware
> which would be the MCE - so there is no reason for these GHES entries to be
> poked whenever an unrelated NMI occurs.
> 
> Fixing this would need a separate list for the machine check handler to poke
> to dump any data from GHES_ASSIST CPER, so its more work than just
> skipping the register call.
> 

This is a great idea！ This way we may collect more error info and avoid the issue mentioned
before. I do realize a prototype following your method，i will try it and test it. 

> (I've no idea how x86 prioritises MCE and NMI... does one block the other?)

From intel sdm, it says MCE has higher priority than NMI. but the latest kernel is changing
fast, NMI may can preemt the MCE for userspace? I am not sure. 

> 
> 
> Thanks,
> 
> James
> 
> 
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c index
> > 81bf71b10d44..e5e8a53beb5a 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -272,7 +272,27 @@ static inline int ghes_severity(int severity)
> >  	case CPER_SEV_RECOVERABLE:
> >  		return GHES_SEV_RECOVERABLE;
> >  	case CPER_SEV_FATAL:
> > +	{
> > +#ifdef CONFIG_X86_MCE
> > +		int sev, sec_sev;
> > +		struct acpi_hest_generic_data *gdata;
> > +		guid_t *sec_type;
> > +
> > +		if (estatus == NULL)
> > +			return GHES_SEV_PANIC;
> > +
> > +		apei_estatus_for_each_section(estatus, gdata) {
> > +			sec_type = (guid_t *)gdata->section_type;
> > +			sec_sev = gdata->error_severity;
> > +			if (sec_sev == CPER_SEV_FATAL &&
> > +			 !guid_equal(sec_type,
> &CPER_SEC_PLATFORM_MEM))
> > +				return GHES_SEV_PANIC;
> > +		}
> > +		return GHES_SEV_RECOVERABLE;
> > +#else
> >  		return GHES_SEV_PANIC;
> > +#endif
> > +	}

Thanks
Aili Yao

