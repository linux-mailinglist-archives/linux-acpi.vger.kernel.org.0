Return-Path: <linux-acpi+bounces-21009-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPo7DxQ0lmktcAIAu9opvQ
	(envelope-from <linux-acpi+bounces-21009-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Feb 2026 22:50:12 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E88F915A6CC
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Feb 2026 22:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5CBD030186AB
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Feb 2026 21:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CF130BBB6;
	Wed, 18 Feb 2026 21:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUCOmhRe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8273EBF10;
	Wed, 18 Feb 2026 21:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771451383; cv=none; b=KPtAzgT6JONQylpbQFZS7SA0+LhoEvcSshk10DEaE4TA7KbjHXGiYlPDa38I5vTvyzIB4x4v6eKP0H6P+mEdYQffpOrDLygjA2yT6e1ey1ZzOX/RkyKeByVdBl/+bBJzqlsdf49NCp9dJ0daE8LUApggP0vwsVO7R4+Yx+urBug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771451383; c=relaxed/simple;
	bh=5Wow3tGz8vWN2FjI9QWepeH3NjBnFKf7jkpS8AoiwKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ga1wF+giJSGpeaYWToR5iaPdv7fYj9RwIQ+BwaasJd0qo9vSCxLuGTWnHEEGxfqaWMr8PiIrNGNzPB1ZJj8NcGggnwBNiHEiebzfUx70KxgmRDe6k2t7YaLijoCSpgbA46ooUphALAWAalpqE3DMi0JLPkzjrdy8WUM/LoOuCFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUCOmhRe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B780C116D0;
	Wed, 18 Feb 2026 21:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771451382;
	bh=5Wow3tGz8vWN2FjI9QWepeH3NjBnFKf7jkpS8AoiwKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VUCOmhRep5WrbGPxFOM7trI4QpMie6JRRKWIJHL+qtvq1zLBZ1v56Zl7KFZOAdtlz
	 FO5G0Fq9qp56N7EhtCOUTgv2+0xg4Ew4fY3Q2Vf2xJ6oeZJeoRC/DpGFZkAZjPJnxG
	 mJuUFhkhBonzQrPWfeFmG+C7osUXw17LsY3G9hV1/SYQmVT+KEDCatXSBY4VgvEJOx
	 Jov87Rot02ozPSl8/G6fxJgiT//TOwBSjYY/bl6YV+MBHo+6NLPrsbdeYXZGPzDDVe
	 d78/xEVrR7K2zWpzNeMm+aUobNVqCkTdXKYgD1T/EWnh2x89i7vSbhQb+2/RPrW1Y0
	 4ERk7NL+NI0fg==
Date: Wed, 18 Feb 2026 13:49:40 -0800
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
Subject: Re: [PATCH RFC v2 08/17] RISC-V: QoS: add resctrl interface for
 CBQRI controllers
Message-ID: <aZYz9IdnnnsGZJr9@gen8>
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
 <20260128-ssqosid-cbqri-v2-8-dca586b091b9@kernel.org>
 <7e35f79c-df56-4cab-9a8b-1a9ffbca053a@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e35f79c-df56-4cab-9a8b-1a9ffbca053a@intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21009-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,ventanamicro.com,sifive.com,baylibre.com,semihalf.com,linux.dev,rivosinc.com,bytedance.com,linux.alibaba.com,gmail.com,zte.com.cn,intel.com,amd.com,google.com,arm.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fustini@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E88F915A6CC
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 03:30:44PM -0800, Reinette Chatre wrote:
> Hi Drew,
> 
> On 1/28/26 12:27 PM, Drew Fustini wrote:
> > +struct rdt_domain_hdr *resctrl_arch_find_domain(struct list_head *domain_list, int id)
> > +{
> > +	struct rdt_domain_hdr *hdr;
> > +
> > +	lockdep_assert_cpus_held();
> > +
> > +	list_for_each_entry(hdr, domain_list, list) {
> > +		if (hdr->id == id)
> > +			return hdr;
> > +	}
> > +
> > +	return NULL;
> > +}
> 
> This indeed looks like a duplicate of resctrl_find_domain(). From what I can tell it
> is not used in this series nor is it an arch call called by resctrl fs so can be dropped?

Yes, this does not seem to be needed so I've will drop it.

> > +void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *rmid)
> > +{
> > +	*closid = ((u32)~0); /* refer to X86_RESCTRL_BAD_CLOSID */
> 
> The name is actually X86_RESCTRL_EMPTY_CLOSID - and if RISC-V also needs it we could
> make it generally available.A

There is no dependency between closid (RCID for CBQRI) and rmid (MCID
for CBQRI), so resctrl_arch_rmid_idx_decode() is essentially the same
for RISC-V.

What do you think would be the best way to share that between X86 and
RISC-V?

Or is it is simpler to just defiend RISCV_RESCTRL_EMPTY_CLOSID?

> > +	*rmid = idx;
> > +}
> > +
> > +/* RISC-V resctrl interface does not maintain a default srmcfg value for a given CPU */
> 
> This means that when user space uses resctrl fs to assign a CPU to a resource group and
> then run a task belonging to the default resource group on that CPU then the task will not
> obtain the allocations that user assigned to that resource group. Here is what the resctrl
> docs currently contain wrt "Resource allocation rules"
> 
> 	Resource allocation rules                                                       
> 	-------------------------                                                       
>                                                                                 
> 	When a task is running the following rules define which resources are           
> 	available to it:                                                                
>                                                                                 
> 	1) If the task is a member of a non-default group, then the schemata            
> 	   for that group is used.                                                      
>                                                                                 
> 	2) Else if the task belongs to the default group, but is running on a           
> 	   CPU that is assigned to some specific group, then the schemata for the       
> 	   CPU's group is used.                                                         
>                                                                                 
> 	3) Otherwise the schemata for the default group is used.         
> 
> If I understand correctly RISC-V thus does not support CPU assignment but user space cannot
> tell. That is, user may write to the cpus/cpus_list file and resctrl will show that it
> succeeds and actually display the new cpumask but underneath it all the actual allocations will
> not reflect that?

RISC-V should be able to support this but my implementation is too
simplistic. I will work on adding this capability.

> > +void resctrl_arch_set_cpu_default_closid_rmid(int cpu, u32 closid, u32 rmid) { }
> > +
> > +void resctrl_arch_sched_in(struct task_struct *tsk)
> > +{
> > +	__switch_to_srmcfg(tsk);
> > +}
> > +
> > +void resctrl_arch_set_closid_rmid(struct task_struct *tsk, u32 closid, u32 rmid)
> > +{
> > +	u32 srmcfg;
> > +
> > +	WARN_ON_ONCE((closid & SRMCFG_RCID_MASK) != closid);
> > +	WARN_ON_ONCE((rmid & SRMCFG_MCID_MASK) != rmid);
> > +
> > +	srmcfg = rmid << SRMCFG_MCID_SHIFT;
> > +	srmcfg |= closid;
> > +	WRITE_ONCE(tsk->thread.srmcfg, srmcfg);
> > +}
> > +
> > +void resctrl_arch_sync_cpu_closid_rmid(void *info)
> > +{
> > +	struct resctrl_cpu_defaults *r = info;
> > +
> > +	lockdep_assert_preemption_disabled();
> > +
> > +	if (r) {
> > +		resctrl_arch_set_cpu_default_closid_rmid(smp_processor_id(),
> > +							 r->closid, r->rmid);
> 
> This just calls the empty function above?

I'll improve the implementation to add real logic to
resctrl_arch_set_cpu_default_closid_rmid().

> > +/* Set capacity block mask (cc_block_mask) */
> > +static void cbqri_set_cbm(struct cbqri_controller *ctrl, u64 cbm)
> > +{
> > +	int reg_offset;
> > +	u64 reg;
> > +
> > +	reg_offset = CBQRI_CC_BLOCK_MASK_OFF;
> > +	reg = ioread64(ctrl->base + reg_offset);
> > +
> > +	reg = cbm;
> > +	iowrite64(reg, ctrl->base + reg_offset);
> 
> This just writes the new 64bit value without any modifications. Is it necessary to
> read it first?

No, I believe it was left over from when I was printing the value in
debug logging. I will cleanup the function.

> > +static int cbqri_apply_cache_config(struct cbqri_resctrl_dom *hw_dom, u32 closid,
> > +				    enum resctrl_conf_type type, struct cbqri_config *cfg)
> > +{
> > +	struct cbqri_controller *ctrl = hw_dom->hw_ctrl;
> > +	int reg_offset;
> > +	int err = 0;
> > +	u64 reg;
> > +
> > +	if (cfg->cbm != hw_dom->ctrl_val[closid]) {
> > +		/* Store the new cbm in the ctrl_val array for this closid in this domain */
> > +		hw_dom->ctrl_val[closid] = cfg->cbm;
> 
> How this hw_dom->ctrl_val[] is used is not clear ... it almost seems unnecessary? It seems to
> resemble the x86 rdt_hw_ctrl_domain::ctrl_val that essentially contains a copy of the values
> set on hardware but its use during config read and write does not reflect that.
> 
> In cbqri_apply_cache_config() hw_dom->ctrl_val[closid] is set before any attempt is made to
> write it to hardware and below it is clear that code doing the writing may fail. Does this mean
> that the driver may think that it set the control value correctly (because it will not retry
> based on the  cfg->cbm != hw_dom->ctrl_val[closid] check) but that is actually not the case?

This is a flaw in my implementation.

> Jumping ahead to the partner code in resctrl_arch_get_config() that reads the current
> configuration value it is unexpected that the implementation refers to the hardware and
> not hw_dom->ctrl_val[closid] ... but actually sets hw_dom->ctrl_val[closid] there also
> to reflect the hardware when the configuration is *read*?
> 
> As I understand there can be two possibilities, either cache the hardware value or don't:
> One possibility could thus be to move hw_dom->ctrl_val[closid] assignment in this function to
> be after hardware is configured so that it reflects accurate state and then resctrl_arch_get_config()
> could just get the value from it instead of hardware.
> Another possibility may be to drop hw_dom->ctrl_val[] entirely and just read from/write to
> hardware every time, something that is much cheaper to do with this design that does not require IPIs.
> 
> This implementation seems to be a bit of both?

Thanks for pointing out these flaws as now I realize that this
implementation does not make sense. I had been looking at the x86 code
alot when working on proof of concept and never reconsidered whether it
was necessary to cache values in ctrl_val.

CBQRI controllers are accessible by all harts (e.g. cpus) through mmio
registers so access should not burden other harts. I think I will modify
the implementation to just directly read/write the mmio registers when
necessary rather than caching them in ctrl_val.

> > +static int cbqri_apply_bw_config(struct cbqri_resctrl_dom *hw_dom, u32 closid,
> > +				 enum resctrl_conf_type type, struct cbqri_config *cfg)
> > +{
> > +	struct cbqri_controller *ctrl = hw_dom->hw_ctrl;
> > +	int ret = 0;
> > +	u64 reg;
> > +
> > +	if (cfg->rbwb != hw_dom->ctrl_val[closid]) {
> > +		/* Store the new rbwb in the ctrl_val array for this closid in this domain */
> > +		hw_dom->ctrl_val[closid] = cfg->rbwb;
> 
> (similar comment as above about ctrl_val[])

I'll drop ctrl_val[] and read/write directly to the CBQRI registers.

> > +u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
> > +			    u32 closid, enum resctrl_conf_type type)
> > +{
> > +	struct cbqri_resctrl_dom *hw_dom;
> > +	struct cbqri_controller *ctrl;
> > +	int reg_offset;
> > +	u32 percent;
> > +	u32 rbwb;
> > +	u64 reg;
> > +	int err;
> > +
> > +	hw_dom = container_of(d, struct cbqri_resctrl_dom, resctrl_ctrl_dom);
> > +
> > +	ctrl = hw_dom->hw_ctrl;
> > +
> > +	if (!r->alloc_capable)
> > +		return resctrl_get_default_ctrl(r);
> > +
> > +	switch (r->rid) {
> > +	case RDT_RESOURCE_L2:
> > +	case RDT_RESOURCE_L3:
> > +		/* Clear cc_block_mask before read limit operation */
> > +		cbqri_set_cbm(ctrl, 0);
> > +
> > +		/* Capacity read limit operation for RCID (closid) */
> > +		err = cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT, type, closid);
> > +		if (err < 0) {
> > +			pr_err("%s(): operation failed: err = %d", __func__, err);
> > +			return resctrl_get_default_ctrl(r);
> > +		}
> > +
> > +		/* Read capacity block mask for RCID (closid) */
> > +		reg_offset = CBQRI_CC_BLOCK_MASK_OFF;
> > +		reg = ioread64(ctrl->base + reg_offset);
> > +
> > +		/* Update the config value for the closid in this domain */
> > +		hw_dom->ctrl_val[closid] = reg;
> 
> This is what I refer to above, why is it necessary to read from hardware here and not
> just return hw_dom->ctrl_val[closid] directly?

I will drop ctrl_val[] and just do direct read/write as needed.

> > +static int cbqri_probe_controller(struct cbqri_controller_info *ctrl_info,
> > +				  struct cbqri_controller *ctrl)
> > +{
> > +	int err = 0, status;
> > +	u64 reg;
> > +
> > +	pr_info("controller info: type=%d addr=0x%lx size=%lu max-rcid=%u max-mcid=%u",
> > +		ctrl_info->type, ctrl_info->addr, ctrl_info->size,
> > +		ctrl_info->rcid_count, ctrl_info->mcid_count);
> > +
> > +	/* max_rmid is used by resctrl_arch_system_num_rmid_idx() */
> > +	max_rmid = ctrl_info->mcid_count;
> 
> It looks like the max is just the MCID count of the last probed controller as opposed to
> the maximum among all controllers.

Good point, I will modify the logic to take the max among all
controllers.

> > +static int qos_resctrl_add_controller_domain(struct cbqri_controller *ctrl, int *id)
> > +{
> > +	struct rdt_ctrl_domain *domain = NULL;
> > +	struct cbqri_resctrl_res *cbqri_res = NULL;
> > +	struct rdt_resource *res = NULL;
> > +	int internal_id = *id;
> > +	int err = 0;
> > +
> > +	domain = qos_new_domain(ctrl);
> > +	if (!domain)
> > +		return -ENOSPC;
> > +
[..]
> > +	domain->hdr.id = internal_id;
> 
> I am missing something here. For the cache resources I expected the ID to be initialized
> to ctrl->ctrl_info->cache_id instead (which is only introduced later in patch 15 though). 
> When interacting with the L2 and L3 resources the domain ID should be the cache ID since that
> is the ID printed to user space where the cache ID is expected. 
> 
> How is this "internal id" used?
> 
> Also please note there are a couple of other fields in the header that needs initializing.

You are right that hdr.id should be ctrl->ctrl_info->cache.cache_id for
a cache. I need to figure out how to order this patch with the rqsc
driver which populates the cache_id field in acpi_parse_rqsc

> > +	err = qos_init_domain_ctrlval(res, domain);
> > +	if (err)
> > +		goto err_free_domain;
> > +
> > +	if (cbqri_res) {
> > +		list_add_tail(&domain->hdr.list, &cbqri_res->resctrl_res.ctrl_domains);
> 
> There is an expectation that the domain list be sorted. For reference, resctrl_find_domain().

Thank you for letting me know. I'll work on sorting the domains before
adding to the list.

-Drew
 

