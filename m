Return-Path: <linux-acpi+bounces-20838-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGvyBBFQgmmBSAMAu9opvQ
	(envelope-from <linux-acpi+bounces-20838-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Feb 2026 20:44:17 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FCBDE3C7
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Feb 2026 20:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6558430CCA36
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Feb 2026 19:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA4F366546;
	Tue,  3 Feb 2026 19:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BerMWa4r"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6516E35F8AE;
	Tue,  3 Feb 2026 19:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770147841; cv=none; b=PcZ1zSgHTRTsPnaPka7gMDGmwRvvTzic8VEofyJdHpAj2+tkj1CorKPn1MOrPGJSTCg6ZskhuvXjaPKcESWBFVEv+6S11X65pcDZ4nhe4KGVojSg3IBqCQTqRc5lCrI6k7jxuJEDpJAeP2UPhXth/VUyssP5aAU7mwLeV8ICxoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770147841; c=relaxed/simple;
	bh=fDZMISdTU9j2DjE9ZWL42YJjivPjTuFE4AcisYh4X0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mklCcFZLDr7GWIh3cavlW22ARR0D0ZauivvvKv2srJaQAZt1+wnJe9PRpSg4OLTOMrmsJqbIZaVbJqpD6eA5mEVhwNeUIq9kEb9Ljv/p8afUaOIs5RVz/bvrafFG3cCqqlmTMQA/NtiKOPD/A8zL48z58takDJc8/GMm0gRgv/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BerMWa4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA57C19421;
	Tue,  3 Feb 2026 19:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770147841;
	bh=fDZMISdTU9j2DjE9ZWL42YJjivPjTuFE4AcisYh4X0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BerMWa4rXH0mZdU3u5pcACtA7edWYNUPYbTLnuEBlzts4s0hwAGCKrOI9p0KLNoD8
	 dQAlBZTTKitbG+x11kL6c9AK9qD+1kz3BNmal9R/BXedW3pF3p0FbQcjAdjEQ5X6p/
	 IpGwXj+d3/bKA8LWitWUNb20WdyTKDq8S/FsRFrw6dKbHe/K21GEvp/HbOZs3THzxY
	 wIhGduTEFZpac/6pRBeP9dRT0tIrldsPtTBg8NnIh4PSEW+Xhy2xEA50y/PkWHnFa8
	 TKglfYSWECel6OF6EEbkDdyTn8FMxnVloGYsb7/FlXdvGMAFw/YhPfTXXjeRsOnVt0
	 iYyc0aqbOfoPQ==
Date: Tue, 3 Feb 2026 11:43:58 -0800
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
Subject: Re: [PATCH RFC v2 03/17] RISC-V: Add support for srmcfg CSR from
 Ssqosid ext
Message-ID: <aYJP/tXv7UeSAJqy@x1>
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
 <20260128-ssqosid-cbqri-v2-3-dca586b091b9@kernel.org>
 <CAEEQ3wmK_4y-woedO0htdh3tnO=4SEGwRUrDsGLYRWwsPF105w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wmK_4y-woedO0htdh3tnO=4SEGwRUrDsGLYRWwsPF105w@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-20838-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[41];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,ventanamicro.com,sifive.com,baylibre.com,semihalf.com,linux.dev,rivosinc.com,linux.alibaba.com,gmail.com,zte.com.cn,intel.com,amd.com,google.com,arm.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fustini@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[semihalf.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4FCBDE3C7
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 12:27:59PM +0800, yunhui cui wrote:
> Hi Drew，
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
> > ---
> >  MAINTAINERS                        |  7 +++++++
> >  arch/riscv/Kconfig                 | 17 ++++++++++++++++
> >  arch/riscv/include/asm/csr.h       |  8 ++++++++
> >  arch/riscv/include/asm/processor.h |  3 +++
> >  arch/riscv/include/asm/qos.h       | 41 ++++++++++++++++++++++++++++++++++++++
> >  arch/riscv/include/asm/switch_to.h |  3 +++
> >  arch/riscv/kernel/Makefile         |  2 ++
> >  arch/riscv/kernel/qos/Makefile     |  2 ++
> >  arch/riscv/kernel/qos/qos.c        |  5 +++++
> >  9 files changed, 88 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 765ad2daa218..e98d553bd0ca 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -22505,6 +22505,13 @@ F:     drivers/perf/riscv_pmu.c
> >  F:     drivers/perf/riscv_pmu_legacy.c
> >  F:     drivers/perf/riscv_pmu_sbi.c
> >
> > +RISC-V QOS RESCTRL SUPPORT
> > +M:     Drew Fustini <fustini@kernel.org>
> 
> If you don’t mind, to help support RISC-V QoS resctrl development and
> ensure interface stability, could you please add an 'R:' entry with my
> email address?

Sure, I will add in next revision.

Thanks,
Drew

