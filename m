Return-Path: <linux-acpi+bounces-20990-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PCdCgCkkGmwbwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20990-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Feb 2026 17:34:08 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 863E313C80A
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Feb 2026 17:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F8F9301E96B
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Feb 2026 16:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D571D2BEC30;
	Sat, 14 Feb 2026 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cs9v7tEM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC59F29AAEA;
	Sat, 14 Feb 2026 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771086840; cv=none; b=azarcE0xHJuAdDpdrhD26vvrKfS+5Xex9LLczqUol4h6VaS5+nersUfM9P+KzVY20oZwYpFsGG3DU3bX6o51ztdsnWq/JyR+mxEADUt+Z+Oe/O1gnuyBuRMS8OQmTw9JnJ4UbmG/K+++/CJhRv2QnWqvwcyWRVTjJ7ztK58gf9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771086840; c=relaxed/simple;
	bh=4W58A1qF2KMzD+CNPgn+QF1OmJw16hqgvTE9E1HsVeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcK0NGJK+po1xOWFd3CpVbtAUOE3tOTiHDYnCCQfFFpUJen/dAIQAX+S986//MLLVgZ4VEaufUnkLyf2bmMoQM2UJJ8iqXIUr26uAtTpqEg9A6OBsYcLdcW9fw8WqbpSnYpQbPi4ubF27jT3LMS5q16varjIqe8CBX41nJUDkTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cs9v7tEM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA927C16AAE;
	Sat, 14 Feb 2026 16:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771086840;
	bh=4W58A1qF2KMzD+CNPgn+QF1OmJw16hqgvTE9E1HsVeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cs9v7tEMNej7LNy7z7/h2afCc6HElvd5q9t+qse1Y1zd66p7wDvC2meIBgHJTTHfn
	 RG0micMqePg+kAByNIQfRKLoCBurORHuzEbiQ6FB8qIpytQhBhowe8TG72e12U28ng
	 io0Rb4ItKzI6PJvfj7x6BFlyfaEAK7Z+NAht2HzzxQvzYdmsGIUed6RYuS6wc0iFiu
	 Usi43vf67e7RZwNwTE2ydq2nGkezYIJhXzxgel++t2dMSCc9NnleO1fUEcklxhMFLA
	 UQuyHFuhmvsbmXHNg7RUu0UKO0I8Xc+astLdSmxQEnIH4s+kG9j0Ca2R6e7OejEoDx
	 9vffDt9JGbUIw==
Date: Sat, 14 Feb 2026 08:34:12 -0800
From: Drew Fustini <fustini@kernel.org>
To: Reinette Chatre <reinette.chatre@intel.com>
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
	yunhui cui <cuiyunhui@bytedance.com>,
	Chen Pei <cp0613@linux.alibaba.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Weiwei Li <liwei1518@gmail.com>, guo.wenjia23@zte.com.cn,
	liu.qingtao2@zte.com.cn, Tony Luck <tony.luck@intel.com>,
	Babu Moger <babu.moger@amd.com>,
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
Subject: Re: [PATCH RFC v2 06/17] RISC-V: QoS: define CBQRI resctrl resources
 and domains
Message-ID: <aZCkBOPLof_Wr0t4@gen8>
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
 <20260128-ssqosid-cbqri-v2-6-dca586b091b9@kernel.org>
 <34bb3ae7-b48e-4c29-8762-0d16e0e7838f@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34bb3ae7-b48e-4c29-8762-0d16e0e7838f@intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20990-lists,linux-acpi=lfdr.de];
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
	FREEMAIL_CC(0.00)[kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,ventanamicro.com,sifive.com,baylibre.com,semihalf.com,linux.dev,rivosinc.com,bytedance.com,linux.alibaba.com,gmail.com,zte.com.cn,intel.com,amd.com,google.com,arm.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 863E313C80A
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 03:15:57PM -0800, Reinette Chatre wrote:
> Hi Drew,
> 
> (caveat for all my comments)
> I scanned this series for resctrl interactions and my comments are
> focused around that instead of a thorough review of all the code
> within. 

Thanks for spending the time to review. It has helped me to realize that
there is a lot cruft leftover from when I was developing based on the
mpam snapshot at the time (2023) and never reorganized after rebasing on
upstream.

> 
> On 1/28/26 12:27 PM, Drew Fustini wrote:
> > diff --git a/arch/riscv/kernel/qos/internal.h b/arch/riscv/kernel/qos/internal.h
> > index ff2c7eff50be..c0402dd06cfa 100644
> > --- a/arch/riscv/kernel/qos/internal.h
> > +++ b/arch/riscv/kernel/qos/internal.h
> > @@ -65,6 +65,11 @@
> >  #define CBQRI_BC_ALLOC_CTL_OP_READ_LIMIT   2
> >  #define CBQRI_BC_ALLOC_CTL_STATUS_SUCCESS  1
> >  
> > +int qos_resctrl_setup(void);
> > +void qos_resctrl_exit(void);
> > +int qos_resctrl_online_cpu(unsigned int cpu);
> > +int qos_resctrl_offline_cpu(unsigned int cpu);
> > +
> >  /* Capacity Controller hardware capabilities */
> >  struct riscv_cbqri_capacity_caps {
> >  	u16 ncblks; /* number of capacity blocks */
> > @@ -125,4 +130,26 @@ struct cbqri_controller {
> >  	bool mon_capable;
> >  };
> >  
> > +struct cbqri_resctrl_res {
> > +	struct rdt_resource     resctrl_res;
> > +	struct cbqri_controller controller;
> > +	u32 max_rcid;
> > +	u32 max_mcid;
> > +};
> > +
> > +struct cbqri_resctrl_dom {
> > +	struct rdt_domain_hdr       resctrl_dom_hdr;
> 
> The resctrl_dom_hdr above should not be needed and indeed does
> not seem to be used in this series. The two members below it,
> struct rdt_ctrl_domain and struct rdt_mon_domain (now named
> rdt_l3_mon_domain), have the necessary struct rdt_domain_hdr as
> their first member.

Thank you for the insight. I think added this when trying get the code
working again after rebasing from an old mpam snapshot to upstream last
year. It does seem like I didn't understand the data structures well
enough and should clean up cbqri_resctrl_dom.
> 
> Without any comments or changelog that describes the other members
> I am not able to really consider their inclusion here. From the
> names it seems that most members are intended to support the
> control domain usage so it is not clear to me why the cbqri domain
> contains both a control and monitor domain while they are interacted
> with separately by resctrl. From what I can tell resctrl_mon_dom
> is not used by this implementation.
> 
> As hinted above, when you rebase you will find that struct rdt_mon_domain
> is now named struct rdt_l3_mon_domain (see commit 4bc3ef46ff41
> ("x86,fs/resctrl: Rename struct rdt_mon_domain and rdt_hw_mon_domain")) to
> make it obvious that it is specific to L3 monitoring. Having this
> as a member for all cbqri domains will then become increasingly confusing
> since the cbqri_resctrl_dom is also used for L2 cache allocation as well as the
> memory bandwidth allocation that are not at L3 scope.
> 
> I think it may be simplest to drop the resctrl_mon_dom member until
> monitoring is supported?

Thanks for the suggestion. Monitoring broke when rebasing on upstream
and also the realization that my approach to MBM was too much of a hack.
I think that does make sense for me to remove all the monitoring code
until I have a working implementation based on the current upstream.

Thanks,
Drew

