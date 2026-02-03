Return-Path: <linux-acpi+bounces-20839-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCvrN/NTgmliSQMAu9opvQ
	(envelope-from <linux-acpi+bounces-20839-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Feb 2026 21:00:51 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A449DE541
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Feb 2026 21:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F792306778C
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Feb 2026 20:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CA42DF6F8;
	Tue,  3 Feb 2026 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vgjzg0JC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3CC13AA2D;
	Tue,  3 Feb 2026 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770148844; cv=none; b=VTaTowldsH19nTwlcdGcBHm5tn0GHNnIRHYv8OauIW2p6kjWa6RKXl8MRikISF+5TCVPdt2PCSaERHQHAWb05tENE1RgUGtSBajuoScSvxULA9gBd++wBuECMgPu4YJFdksZyrwefsfg779hZAMMs+L/Kizn76JT8S4t7jjnuuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770148844; c=relaxed/simple;
	bh=eKNCgEBO6pJ63QzdwEPsSvrcDi0qCByDuzz0mMYiFKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOUuNZHcvji/CV3LH3bMZzI3y/fNU0q4Zt0RPdno6CyxX9OJEKa04xqfoo4KnWRht67cgRLe+DqIFeOssyz/S75HEJ4KZjQn+MsPy/sNX8uHVkkHtULMY4ZlfC+tFe9Dn0opcNtwY0oGn1EiPjJACgTL//q9favZ1G7k1NZpdag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vgjzg0JC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C604C116D0;
	Tue,  3 Feb 2026 20:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770148843;
	bh=eKNCgEBO6pJ63QzdwEPsSvrcDi0qCByDuzz0mMYiFKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vgjzg0JCTwi6+FOUDOBQKyIoi3VkM882ESZIcy/MG2dCcCJs9Ai4arJyd0ixH8v7m
	 S7It/2f7BM11O0G7UWgPil4+56euEY5wTzKUXrz/IXiLRouE1vxXoSrSuYg+QRj5Zt
	 9ltn3owIlgdSX0rys2mVxyHescG6B/LRC7Lmaam45gPO9xj3d1bdmLcdCDhiSADNL2
	 777RTr+vSdumMGGFRngZI+TZ2HzwitiZbd3y7h8kX34Snxiisu/uiy5mP4W1V0Brac
	 ComsQ4qzNb+IUiacCvJBGtYNo7CMxAg39nNbwHdAOyUksePbGrCtKaJZG2ODB6B90l
	 i/ejsWPrZKCag==
Date: Tue, 3 Feb 2026 12:00:42 -0800
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
Message-ID: <aYJT6pjtWZIUBc1J@x1>
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
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20839-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8A449DE541
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
[..]
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

Thanks, I will give that a try as the current value 0xFF is not flexible.

Drew

