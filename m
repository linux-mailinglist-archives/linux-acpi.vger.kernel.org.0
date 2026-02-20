Return-Path: <linux-acpi+bounces-21035-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPR+Gxm8mGl+LgMAu9opvQ
	(envelope-from <linux-acpi+bounces-21035-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 20:55:05 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A05A316A829
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 20:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 561CD3006014
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 19:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339CB2F6591;
	Fri, 20 Feb 2026 19:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbWQ4DZr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB9B1F7541;
	Fri, 20 Feb 2026 19:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771617299; cv=none; b=nwTM/sVSXgJUE5jmHMAkj9AVo/qqfEKTjOYhIytxd2PonziHAYuoRAN4u2S9Oj+E76lplAldka7hAEO+xaehN89tG3Vu6YwLktBNf52UO51haOamkXmMRuhpOaAT9RAo476uznnz7zyXGels+t387+d4ybMdCPu/ZISc+M2Sb3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771617299; c=relaxed/simple;
	bh=G8bBEO/g8w7OleXjDK76ZPJ7XfuuZF81p9PP5s2xJGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBBWuq4x+ni7HlvlNOkMEmZ3Vl/NaAAqrg/n3DzEz39clBXSxlRjhl4zwnA0DDu2SHSLD15mIZPeMpaT3T6uqGdcMmgdgd/gUvgl0JFBMYhjfnZYe2ynFmYu3iKxCntIgFxcMyvdU84V4OrWKaAwYO1wTckGcHWtSiu53jfN2rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbWQ4DZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4341C116C6;
	Fri, 20 Feb 2026 19:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771617298;
	bh=G8bBEO/g8w7OleXjDK76ZPJ7XfuuZF81p9PP5s2xJGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EbWQ4DZrULRIpfj3CJM7KKV//fsDC8CLhHmiPL0HturNAqFKrFk527trkEU6xhW2f
	 w3SwTGScz1OkFw/9wovoXiC5e/95USuL7WrS9naQxcnv9wrrTqtb/IlHaGMsSezJhm
	 br/QmCkRWyndpOzfSqun5kQUylX2CtCuiuK7FT2+5dCG3hjC1sJ8nNnSFugHlLq2Ht
	 TZ9igfItIvo0leyV6QSa6cea+Ij6FrmhLbopseM+g86V9TQ0DtTZ+E5I37+aJQhFf2
	 JxupJktMKVQw45FKa3v1BaBYGIxB1QcTI+GrKklrwf6jKjr3cLj4fTR2h2gbQPwZ4D
	 COnH7NWf35U8g==
Date: Fri, 20 Feb 2026 11:54:56 -0800
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
Subject: Re: [External] [PATCH RFC v2 08/17] RISC-V: QoS: add resctrl
 interface for CBQRI controllers
Message-ID: <aZi8ED8pzmSZEuUX@x1>
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
 <20260128-ssqosid-cbqri-v2-8-dca586b091b9@kernel.org>
 <CAEEQ3wn1zQfn3wD-D6tz5OQjk+7ZucwyKrPHD9wP=kDDj+3XGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wn1zQfn3wD-D6tz5OQjk+7ZucwyKrPHD9wP=kDDj+3XGg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21035-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,baylibre.com:email]
X-Rspamd-Queue-Id: A05A316A829
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 12:12:28PM +0800, yunhui cui wrote:
> Hi Drew,

Hi, thanks for your review, sorry I had this reply in draft for awhile
and failed to actually send it. All good points from you and I've been
working on fixing up the code.

> On Thu, Jan 29, 2026 at 4:28 AM Drew Fustini <fustini@kernel.org> wrote:
> >
> > Add interface for CBQRI controller drivers to make use of the resctrl
> > filesystem.
> >
> > Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > ---
> >  arch/riscv/kernel/qos/qos_resctrl.c | 1192 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 1192 insertions(+)
> >
> > diff --git a/arch/riscv/kernel/qos/qos_resctrl.c b/arch/riscv/kernel/qos/qos_resctrl.c
> > new file mode 100644
> > index 000000000000..d500098599d2
> > --- /dev/null
> > +++ b/arch/riscv/kernel/qos/qos_resctrl.c
> > @@ -0,0 +1,1192 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#define pr_fmt(fmt) "qos: resctrl: " fmt
> > +
> > +#include <linux/slab.h>
> > +#include <linux/err.h>
> > +#include <linux/riscv_qos.h>
> > +#include <linux/resctrl.h>
> > +#include <linux/types.h>
> > +#include <asm/csr.h>
> > +#include <asm/qos.h>
> > +#include "internal.h"
> > +
> > +#define MAX_CONTROLLERS 6
> > +static struct cbqri_controller controllers[MAX_CONTROLLERS];
> 
> Switch to dynamic allocation? Remove MAX_CONTROLLERS.

Yes, I am reworking the implementation to dynamically allocate the
cbqri_controller array based on the number of controllers actually in
the system.

> > +int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
> > +                          u32 closid, u32 rmid, enum resctrl_event_id eventid,
> > +                          u64 *val, void *arch_mon_ctx)
> > +{
> > +       /*
> > +        * The current Qemu implementation of CBQRI capacity and bandwidth
> > +        * controllers do not emulate the utilization of resources over
> > +        * time. Therefore, Qemu currently sets the invalid bit in
> > +        * cc_mon_ctr_val and bc_mon_ctr_val, and there is no meaningful
> > +        * value other than 0 to return for reading an RMID (e.g. MCID in
> > +        * CBQRI terminology)
> > +        */
> > +
> > +       return 0;
> 
> Implement per the spec's description directly, not as this comment states?

Good point that this should actually perform the operation to read the
value, even if Qemu is just setting the invalid bit as there is no real
value implemented in Qemu.

> > +/*
> > + * Note: for the purposes of the CBQRI proof-of-concept, debug logging
> > + * has been left in this function that detects the properties of CBQRI
> > + * capable controllers in the system. pr_info calls would be removed
> > + * before submitting non-RFC patches.
> > + */
> > +static int cbqri_probe_controller(struct cbqri_controller_info *ctrl_info,
> > +                                 struct cbqri_controller *ctrl)
> > +{
> > +       int err = 0, status;
> > +       u64 reg;
> > +
> > +       pr_info("controller info: type=%d addr=0x%lx size=%lu max-rcid=%u max-mcid=%u",
> > +               ctrl_info->type, ctrl_info->addr, ctrl_info->size,
> > +               ctrl_info->rcid_count, ctrl_info->mcid_count);
> > +
> > +       /* max_rmid is used by resctrl_arch_system_num_rmid_idx() */
> > +       max_rmid = ctrl_info->mcid_count;
> 
> Get the min of all controllers?

Yes, I will change the logic to do that.

> > +static int qos_init_domain_ctrlval(struct rdt_resource *r, struct rdt_ctrl_domain *d)
> > +{
> > +       struct cbqri_resctrl_res *hw_res;
> > +       struct cbqri_resctrl_dom *hw_dom;
> > +       u64 *dc;
> > +       int err = 0;
> > +       int i;
> > +
> > +       hw_res = container_of(r, struct cbqri_resctrl_res, resctrl_res);
> > +       if (!hw_res)
> > +               return -ENOMEM;
> > +
> > +       hw_dom = container_of(d, struct cbqri_resctrl_dom, resctrl_ctrl_dom);
> > +       if (!hw_dom)
> > +               return -ENOMEM;
> > +
> > +       dc = kmalloc_array(hw_res->max_rcid, sizeof(*hw_dom->ctrl_val),
> > +                          GFP_KERNEL);
> > +       if (!dc)
> > +               return -ENOMEM;
> > +
> > +       hw_dom->ctrl_val = dc;
> > +
> > +       for (i = 0; i < hw_res->max_rcid; i++, dc++) {
> > +               err = resctrl_arch_update_one(r, d, i, 0, resctrl_get_default_ctrl(r));
> > +               if (err)
> > +                       return 0;
> 
> return 0 ?

Ah, yes, I will update to return error instead of silencing it.

> > +static int qos_resctrl_add_controller_domain(struct cbqri_controller *ctrl, int *id)
> > +{
> > +       struct rdt_ctrl_domain *domain = NULL;
> > +       struct cbqri_resctrl_res *cbqri_res = NULL;
> > +       struct rdt_resource *res = NULL;
> > +       int internal_id = *id;
> > +       int err = 0;
> > +
> > +       domain = qos_new_domain(ctrl);
> > +       if (!domain)
> > +               return -ENOSPC;
> > +       if (ctrl->ctrl_info->type == CBQRI_CONTROLLER_TYPE_CAPACITY) {
> > +               cpumask_copy(&domain->hdr.cpu_mask, &ctrl->ctrl_info->cache.cpu_mask);
> > +               if (ctrl->ctrl_info->cache.cache_level == 2) {
> > +                       cbqri_res = &cbqri_resctrl_resources[RDT_RESOURCE_L2];
> > +                       cbqri_res->max_rcid = ctrl->ctrl_info->rcid_count;
> > +                       cbqri_res->max_mcid = ctrl->ctrl_info->mcid_count;
> > +                       res = &cbqri_res->resctrl_res;
> > +                       res->mon.num_rmid = ctrl->ctrl_info->mcid_count;
> > +                       res->rid = RDT_RESOURCE_L2;
> > +                       res->name = "L2";
> > +                       res->alloc_capable = ctrl->alloc_capable;
> > +                       res->mon_capable = ctrl->mon_capable;
> > +                       res->schema_fmt = RESCTRL_SCHEMA_BITMAP;
> > +                       res->ctrl_scope = RESCTRL_L2_CACHE;
> > +                       res->cache.arch_has_sparse_bitmasks = false;
> > +                       res->cache.arch_has_per_cpu_cfg = false;
> > +                       res->cache.cbm_len = ctrl->cc.ncblks;
> > +                       res->cache.shareable_bits = resctrl_get_default_ctrl(res);
> > +                       res->cache.min_cbm_bits = 1;
> > +               } else if (ctrl->ctrl_info->cache.cache_level == 3) {
> > +                       cbqri_res = &cbqri_resctrl_resources[RDT_RESOURCE_L3];
> > +                       cbqri_res->max_rcid = ctrl->ctrl_info->rcid_count;
> > +                       cbqri_res->max_mcid = ctrl->ctrl_info->mcid_count;
> > +                       res = &cbqri_res->resctrl_res;
> > +                       res->mon.num_rmid = ctrl->ctrl_info->mcid_count;
> > +                       res->rid = RDT_RESOURCE_L3;
> > +                       res->name = "L3";
> > +                       res->schema_fmt = RESCTRL_SCHEMA_BITMAP;
> > +                       res->ctrl_scope = RESCTRL_L3_CACHE;
> > +                       res->alloc_capable = ctrl->alloc_capable;
> > +                       res->mon_capable = ctrl->mon_capable;
> > +                       res->cache.arch_has_sparse_bitmasks = false;
> > +                       res->cache.arch_has_per_cpu_cfg = false;
> > +                       res->cache.cbm_len = ctrl->cc.ncblks;
> > +                       res->cache.shareable_bits = resctrl_get_default_ctrl(res);
> > +                       res->cache.min_cbm_bits = 1;
> > +               } else {
> > +                       pr_warn("%s(): unknown cache level %d", __func__,
> > +                               ctrl->ctrl_info->cache.cache_level);
> > +                       err = -ENODEV;
> > +                       goto err_free_domain;
> > +               }
> > +       } else if (ctrl->ctrl_info->type == CBQRI_CONTROLLER_TYPE_BANDWIDTH) {
> > +               if (ctrl->alloc_capable) {
> > +                       cbqri_res = &cbqri_resctrl_resources[RDT_RESOURCE_MBA];
> > +                       cbqri_res->max_rcid = ctrl->ctrl_info->rcid_count;
> > +                       cbqri_res->max_mcid = ctrl->ctrl_info->mcid_count;
> > +                       res = &cbqri_res->resctrl_res;
> > +                       res->mon.num_rmid = ctrl->ctrl_info->mcid_count;
> > +                       res->rid = RDT_RESOURCE_MBA;
> > +                       res->name = "MB";
> > +                       res->schema_fmt = RESCTRL_SCHEMA_RANGE;
> > +                       res->ctrl_scope = RESCTRL_L3_CACHE;
> > +                       res->alloc_capable = ctrl->alloc_capable;
> > +                       res->mon_capable = false;
> > +                       res->membw.delay_linear = true;
> > +                       res->membw.arch_needs_linear = true;
> > +                       res->membw.throttle_mode = THREAD_THROTTLE_UNDEFINED;
> > +                       // The minimum percentage allowed by the CBQRI spec
> > +                       res->membw.min_bw = 1;
> > +                       // The maximum percentage allowed by the CBQRI spec
> > +                       res->membw.max_bw = 80;
> > +                       res->membw.bw_gran = 1;
> > +               }
> 
> Wrap a function.

I am guessing you mean to break up this long function into a couple of
smaller functions? I will give that a try for the next rev.

> > +       } else {
> > +               pr_warn("%s(): unknown resource %d", __func__, ctrl->ctrl_info->type);
> > +               err = -ENODEV;
> > +               goto err_free_domain;
> > +       }
> > +
> > +       domain->hdr.id = internal_id;
> > +       err = qos_init_domain_ctrlval(res, domain);
> > +       if (err)
> > +               goto err_free_domain;
> > +
> > +       if (cbqri_res) {
> > +               list_add_tail(&domain->hdr.list, &cbqri_res->resctrl_res.ctrl_domains);
> > +               *id = internal_id;
> > +               err = resctrl_online_ctrl_domain(res, domain);
> > +               if (err) {
> > +                       pr_warn("%s(): failed to online cbqri_res domain", __func__);
> > +                       goto err_free_domain;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +
> > +err_free_domain:
> > +       pr_warn("%s(): err_free_domain", __func__);
> > +       kfree(container_of(domain, struct cbqri_resctrl_dom, resctrl_ctrl_dom));
> 
> free hw_dom->ctrl_val ？

I'll take a closer look at the error cleanup path and fix in the next
rev.

Thanks,
Drew

