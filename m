Return-Path: <linux-acpi+bounces-20895-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIfmJXbnh2mRewQAu9opvQ
	(envelope-from <linux-acpi+bounces-20895-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sun, 08 Feb 2026 02:31:34 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 370F71078F6
	for <lists+linux-acpi@lfdr.de>; Sun, 08 Feb 2026 02:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49C35300D966
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Feb 2026 01:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445902FFFA6;
	Sun,  8 Feb 2026 01:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNvowwG9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206DB156F20;
	Sun,  8 Feb 2026 01:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770514288; cv=none; b=RJFhBxr4l3aiu//pa2EBt+I2JmaVhnwttbTHU1zVKYsIMFu99PmaHU1TQraxw7rx1DqTHX9w0I3WuOmW+J0MOwLJO1+Saw7u+UUrhg0ZfqFhnzEHqK4BChUZ4JKy48xXHhHFtalzn4/k+qzbpLQZ5rSTq2FZZ+ZCGUcCYau9PiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770514288; c=relaxed/simple;
	bh=RylA3pGv8inVH/Bl08iuiJfbF8raWZhZT1pwh10HYkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVUvDMrdkeNx7wZyRn6iFdFSTgXLdrghlK+4m/fM+LzKnT8PeGMDScWUxG2z2doDq8NsfylVL15sQgBnoohnCNP9TvVWB4eSZslKZVknKJaeOTJDvsQfwYc5/o9V/m0r/p4c1rxxOfI+/H2HO0paU2rnMifns5oWuW0WNlkrqyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNvowwG9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5FFC116D0;
	Sun,  8 Feb 2026 01:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770514287;
	bh=RylA3pGv8inVH/Bl08iuiJfbF8raWZhZT1pwh10HYkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aNvowwG9YhSNrhXyOQ+sw+jn8QnzzIuXXbwoddP8uOcEJnnXbhDuQ2v8RNLRaZM3o
	 HkZQT/djWZF28qNC54+FfsiCIBhB2zcB//AQYlYlkyNCZty5Salk2DWOmE2wlZW2Vd
	 PM+619Tz/CvRd/b5iF5vADCAK1d46BcT3YlQ0+rdT4tdIYwXp+GVqzu7vtDPWnk+fQ
	 vrFjjyv5S7hqoVP3X6XW6OVb3sJPH5/ZbJAIzSzO9FBAr+1hPvBW01FqPojUKtIRPH
	 lABidUNG72UKryO3wyJtcTGSuQNgZ87p8/unIgVWBVcjy+YkzAFzo3oMW1J/Mik+Ca
	 8Tb0c6GwA87dQ==
Date: Sat, 7 Feb 2026 17:31:25 -0800
From: Drew Fustini <fustini@kernel.org>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Adrien Ricciardi <aricciardi@baylibre.com>,
	Nicolas Pitre <npitre@baylibre.com>,
	Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
	Atish Patra <atish.patra@linux.dev>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Vasudevan Srinivasan <vasu@rivosinc.com>,
	Ved Shanbhogue <ved@rivosinc.com>,
	Chen Pei <cp0613@linux.alibaba.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Weiwei Li <liwei1518@gmail.com>, guo.wenjia23@zte.com.cn,
	liu.qingtao2@zte.com.cn,
	Reinette Chatre <reinette.chatre@intel.com>,
	Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>,
	Peter Newman <peternewman@google.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
	Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, x86@kernel.org,
	Rob Herring <robh@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [External] [PATCH RFC v2 03/17] RISC-V: Add support for srmcfg
 CSR from Ssqosid ext
Message-ID: <aYfnbc3T81RRxz5r@gen8>
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
 <20260128-ssqosid-cbqri-v2-3-dca586b091b9@kernel.org>
 <CAEEQ3wkqC4jFf1LGgh2c6dgGwT=tuvpFV+D4fiw40P3LZ7_8hg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wkqC4jFf1LGgh2c6dgGwT=tuvpFV+D4fiw40P3LZ7_8hg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20895-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[41];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,ventanamicro.com,sifive.com,baylibre.com,semihalf.com,linux.dev,rivosinc.com,linux.alibaba.com,gmail.com,zte.com.cn,intel.com,amd.com,google.com,arm.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fustini@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:url,semihalf.com:email]
X-Rspamd-Queue-Id: 370F71078F6
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 11:17:52AM +0800, yunhui cui wrote:
> Hi Drew,
> 
> On Thu, Jan 29, 2026 at 4:28 AM Drew Fustini <fustini@kernel.org> wrote:
> >
> > Add support for the srmcfg CSR defined in the Ssqosid ISA extension
> > (Supervisor-mode Quality of Service ID). The CSR contains two fields:
> >
> >   - Resource Control ID (RCID) used determine resource allocation
> >   - Monitoring Counter ID (MCID) used to track resource usage
> >
> > Requests from a hart to shared resources like cache will be tagged with
> > these IDs. This allows the usage of shared resources to be associated
> > with the task currently running on the hart.
> >
> > A srmcfg field is added to thread_struct and has the same format as the
> > srmcfg CSR. This allows the scheduler to set the hart's srmcfg CSR to
> > contain the RCID and MCID for the task that is being scheduled in. The
> > srmcfg CSR is only written to if the thread_struct.srmcfg is different
> > than the current value of the CSR.
> >
> > A per-cpu variable cpu_srmcfg is used to mirror that state of the CSR.
> > This is because access to L1D hot memory should be several times faster
> > than a CSR read. Also, in the case of virtualization, accesses to this
> > CSR are trapped in the hypervisor.
> >
> > Link: https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
> > Co-developed-by: Kornel Dulęba <mindal@semihalf.com>
> > Signed-off-by: Kornel Dulęba <mindal@semihalf.com>
> > [fustini: rename csr, refactor switch_to, rebase on upstream]
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
[..]
> > diff --git a/arch/riscv/include/asm/qos.h b/arch/riscv/include/asm/qos.h
> > new file mode 100644
> > index 000000000000..84830d7c6dc4
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/qos.h
> > @@ -0,0 +1,41 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_RISCV_QOS_H
> > +#define _ASM_RISCV_QOS_H
> > +
> > +#ifdef CONFIG_RISCV_ISA_SSQOSID
> > +
> > +#include <linux/sched.h>
> > +#include <linux/jump_label.h>
> > +
> > +#include <asm/barrier.h>
> > +#include <asm/csr.h>
> > +#include <asm/hwcap.h>
> > +
> > +/* cached value of srmcfg csr for each cpu */
> > +DECLARE_PER_CPU(u32, cpu_srmcfg);
> > +
> > +static inline void __switch_to_srmcfg(struct task_struct *next)
> > +{
> > +       u32 *cpu_srmcfg_ptr = this_cpu_ptr(&cpu_srmcfg);
> > +       u32 thread_srmcfg;
> > +
> > +       thread_srmcfg = READ_ONCE(next->thread.srmcfg);
> 
> 
> First set the cpu_list, and then the condition thread_srmcfg !=
> *cpu_srmcfg_ptr will not be satisfied. Is a default value required
> here? Both code paths for cpu_list and tasks are compared against the
> default value; you may refer to the implementation of mpam.

I'm having trouble finding cpu_list but I think that it does make sense
to set the initial value.

Were you thinking I should look at mpam_set_cpu_defaults() in
the mpam_resctrl_glue_v4 [1] branch?

Thanks,
Drew

[1] https://gitlab.arm.com/linux-arm/linux-bh.git

