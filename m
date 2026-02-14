Return-Path: <linux-acpi+bounces-20985-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLWBIsL+j2nMUwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20985-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Feb 2026 05:49:06 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6C613B14B
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Feb 2026 05:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 383C930074E1
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Feb 2026 04:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E77C2FB969;
	Sat, 14 Feb 2026 04:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cm4Dbc+c"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2602D2F83B5;
	Sat, 14 Feb 2026 04:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771044538; cv=none; b=MFkSHHVRbRIvlB5kxAPMQiSPGqwqWP0e7BNkeqc7l26zwSXC08J4mXdA2Tlq07RSSyT1caFKpHy3b+TPjxYvFDcuuEgJnFABxUSr/hEDbOFo2a8RheErRXFoaCCnbioKSE6ISxSNN4zeFV9HEDmCDxTbg2IztUI08L/kJz9qDkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771044538; c=relaxed/simple;
	bh=SWciu1EotfgCtPYvcZhetq4/41qsYpU6LYTorQstCP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgUY64thTGju1pDtrZLTGjekChv67xVx3hGiuckVNCd9KtnO+qeiEAFql0cV2lkgK8ROmU//pGdmgvjWXiyIK0twrRgbNShPpzdJvQFR2uMV8EUGMOoPyK3v14ClZR5+4X1dr1fjOSJAibo5AM2uboaKm9h9GCGhWYRFv/vWYKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cm4Dbc+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16543C19421;
	Sat, 14 Feb 2026 04:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771044537;
	bh=SWciu1EotfgCtPYvcZhetq4/41qsYpU6LYTorQstCP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cm4Dbc+cr3k+spSIzdONPIChT99Efjuv8SV8dvRQb+wDhK4lYNjrfVC7WL6wvScp6
	 CxrdCZRan298qIW56GPrdlelatF6w7A3xe1FRGogqkfh7+AYurnTRGnDVB2mYwJuIK
	 HUSEbujlPyLPV+y17WezDaMMSSpMs+I3kqiecM9vp7HJCvNoa0jUjoW0ilpYbUCPTT
	 RbK6J4+3gLHiLXBVnCv8/XguS3cqs+VHqrT5X55xqpBYShpTyo1oWXeFWVjMN1P5b2
	 h6tt+18A4u0gySiiSTMeUkWUZIQpwlCz4IHkffTnMag+X8WIdi7cgv9XUdgsKgSb0i
	 UJwI8UCOU210w==
Date: Fri, 13 Feb 2026 20:48:55 -0800
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
Subject: Re: [External] [PATCH RFC v2 16/17] acpi: riscv: Parse RISC-V
 Quality of Service Controller (RQSC) table
Message-ID: <aY_-t9F1eCKw8lGv@gen8>
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
 <20260128-ssqosid-cbqri-v2-16-dca586b091b9@kernel.org>
 <CAEEQ3wnAqSFUhezyUmJQut8eXThGJ1zxtdNTbFtJusyDstgVUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wnAqSFUhezyUmJQut8eXThGJ1zxtdNTbFtJusyDstgVUg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20985-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[41];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fustini@kernel.org,linux-acpi@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,ventanamicro.com,sifive.com,baylibre.com,semihalf.com,linux.dev,rivosinc.com,linux.alibaba.com,gmail.com,zte.com.cn,intel.com,amd.com,google.com,arm.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA6C613B14B
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 07:08:48PM +0800, yunhui cui wrote:
> Hi Drew,
> 
> On Thu, Jan 29, 2026 at 4:28 AM Drew Fustini <fustini@kernel.org> wrote:
> >
> > Add driver to parse the ACPI RISC-V Quality of Service Controller (RQSC)
> > table which describes the capacity and bandwidth QoS controllers in a
> > system. The QoS controllers implement the RISC-V Capacity and Bandwidth
> > Controller QoS Register Interface (CBQRI) specification.
> >
> > Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
> > Link: https://github.com/riscv-non-isa/riscv-rqsc/blob/main/src/
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > ---
> >  MAINTAINERS                   |   1 +
> >  arch/riscv/include/asm/acpi.h |  10 ++++
> >  drivers/acpi/riscv/Makefile   |   2 +-
> >  drivers/acpi/riscv/rqsc.c     | 112 ++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 124 insertions(+), 1 deletion(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 96ead357a634..e96a83dc9a02 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -22512,6 +22512,7 @@ S:      Supported
> >  F:     arch/riscv/include/asm/qos.h
> >  F:     arch/riscv/include/asm/resctrl.h
> >  F:     arch/riscv/kernel/qos/
> > +F:     drivers/acpi/riscv/rqsc.c
> >  F:     include/linux/riscv_qos.h
> >
> >  RISC-V RPMI AND MPXY DRIVERS
> > diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> > index 6e13695120bc..16c6e25eed1e 100644
> > --- a/arch/riscv/include/asm/acpi.h
> > +++ b/arch/riscv/include/asm/acpi.h
> > @@ -71,6 +71,16 @@ int acpi_get_riscv_isa(struct acpi_table_header *table,
> >
> >  void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbom_size,
> >                              u32 *cboz_size, u32 *cbop_size);
> > +
> > +#ifdef CONFIG_RISCV_ISA_SSQOSID
> > +int acpi_parse_rqsc(struct acpi_table_header *table);
> > +#else
> > +static inline int acpi_parse_rqsc(struct acpi_table_header *table)
> > +{
> > +       return -EINVAL;
> > +}
> > +#endif /* CONFIG_RISCV_ISA_SSQOSID */
> > +
> >  #else
> >  static inline void acpi_init_rintc_map(void) { }
> >  static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
> > diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
> > index 1284a076fa88..cf0f38c93a9f 100644
> > --- a/drivers/acpi/riscv/Makefile
> > +++ b/drivers/acpi/riscv/Makefile
> > @@ -1,5 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > -obj-y                                  += rhct.o init.o irq.o
> > +obj-y                                  += rhct.o rqsc.o init.o irq.o
> >  obj-$(CONFIG_ACPI_PROCESSOR_IDLE)      += cpuidle.o
> >  obj-$(CONFIG_ACPI_CPPC_LIB)            += cppc.o
> >  obj-$(CONFIG_ACPI_RIMT)                        += rimt.o
> > diff --git a/drivers/acpi/riscv/rqsc.c b/drivers/acpi/riscv/rqsc.c
> > new file mode 100644
> > index 000000000000..a86ddb39fae4
> > --- /dev/null
> > +++ b/drivers/acpi/riscv/rqsc.c
> > @@ -0,0 +1,112 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2025 Tenstorrent
> > + *     Author: Drew Fustini <fustini@kernel.org>
> > + *
> > + */
> > +
> > +#define pr_fmt(fmt) "ACPI: RQSC: " fmt
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/bits.h>
> > +#include <linux/riscv_qos.h>
> > +
> > +#ifdef CONFIG_RISCV_ISA_SSQOSID
> > +
> > +#define CBQRI_CTRL_SIZE 0x1000
> > +
> > +static struct acpi_table_rqsc *acpi_get_rqsc(void)
> > +{
> > +       static struct acpi_table_header *rqsc;
> > +       acpi_status status;
> > +
> > +       /*
> > +        * RQSC will be used at runtime on every CPU, so we
> > +        * don't need to call acpi_put_table() to release the table mapping.
> > +        */
> > +       if (!rqsc) {
> > +               status = acpi_get_table(ACPI_SIG_RQSC, 0, &rqsc);
> > +               if (ACPI_FAILURE(status)) {
> > +                       pr_warn_once("No RQSC table found\n");
> > +                       return NULL;
> > +               }
> > +       }
> > +
> > +       return (struct acpi_table_rqsc *)rqsc;
> > +}
> > +
> > +int acpi_parse_rqsc(struct acpi_table_header *table)
> > +{
> > +       struct acpi_table_rqsc *rqsc;
> > +       int err;
> > +
> > +       BUG_ON(acpi_disabled);
> > +       if (!table) {
> > +               rqsc = acpi_get_rqsc();
> > +               if (!rqsc)
> > +                       return -ENOENT;
> > +       } else {
> > +               rqsc = (struct acpi_table_rqsc *)table;
> > +       }
> > +
> > +       for (int i = 0; i < rqsc->num; i++) {
> > +               struct cbqri_controller_info *ctrl_info;
> > +
> > +               ctrl_info = kzalloc(sizeof(*ctrl_info), GFP_KERNEL);
> > +               if (!ctrl_info)
> > +                       return -ENOMEM;
> > +
> > +               ctrl_info->type = rqsc->f[i].type;
> > +               ctrl_info->addr = rqsc->f[i].reg[1];
> > +               ctrl_info->size = CBQRI_CTRL_SIZE;
> > +               ctrl_info->rcid_count = rqsc->f[i].rcid;
> > +               ctrl_info->mcid_count = rqsc->f[i].mcid;
> > +
> > +               pr_info("Found controller with type %u addr 0x%lx size  %lu rcid  %u mcid  %u",
> > +                       ctrl_info->type, ctrl_info->addr, ctrl_info->size,
> > +                       ctrl_info->rcid_count, ctrl_info->mcid_count);
> > +
> > +               if (ctrl_info->type == CBQRI_CONTROLLER_TYPE_CAPACITY) {
> > +                       ctrl_info->cache.cache_id = rqsc->f[i].res.id1;
> > +                       ctrl_info->cache.cache_level =
> > +                               find_acpi_cache_level_from_id(ctrl_info->cache.cache_id);
> > +
> > +                       struct acpi_pptt_cache *cache;
> > +
> > +                       cache = find_acpi_cache_from_id(ctrl_info->cache.cache_id);
> > +                       if (cache) {
> > +                               ctrl_info->cache.cache_size = cache->size;
> > +                       } else {
> > +                               pr_warn("%s(): failed to determine size for cache id 0x%x",
> > +                                       __func__, ctrl_info->cache.cache_id);
> > +                               ctrl_info->cache.cache_size = 0;
> > +                       }
> > +
> > +                       pr_info("Cache controller has ID 0x%x level %u size %u ",
> > +                               ctrl_info->cache.cache_id, ctrl_info->cache.cache_level,
> > +                               ctrl_info->cache.cache_size);
> > +
> > +                       /*
> > +                        * For CBQRI, any cpu (technically a hart in RISC-V terms)
> > +                        * can access the memory-mapped registers of any CBQRI
> > +                        * controller in the system.
> > +                        */
> > +                       err = cpumask_parse("FF", &ctrl_info->cache.cpu_mask);
> 
> Hardcode? acpi_pptt_get_cpumask_from_cache_id(ctrl_info->cache.cache_id,
> &ctrl_info->cache.cpu_mask); ?

Thank you, I'll switch to using that.

Drew

