Return-Path: <linux-acpi+bounces-20925-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMJUGOfTi2njbgAAu9opvQ
	(envelope-from <linux-acpi+bounces-20925-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 01:57:11 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA19D12063D
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 01:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F01E2304B5A4
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 00:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68A4238C0F;
	Wed, 11 Feb 2026 00:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vsd+Xx+4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0110221721;
	Wed, 11 Feb 2026 00:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770771426; cv=none; b=fuhgKTIM+4FN1SFhULsrf2oYc+3tEkXFzvNNGVbUGLEQnMe0z0mBFpiLUZX9lL4xNS6atuLVZHKVtP30TUDIbKEmRltOLdXlHga0a95FrfChsaU7UaWWBBKLjIxQCZ55umJ8eq2gQl1uU5lsT34BkGeNDhGg8JHYn9u/Q7YBDcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770771426; c=relaxed/simple;
	bh=yzkylkEQyMlLPX3kedBSzjU8RsbSf5Jk4i2N65fCL30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZTrgI4RfOqPtq55rW+rZhvp+cDTnxagsjGtzirwcaUgcSgGpGfoavKFnSjYUdWjoXzE7bDDmWJXyGa7kyMhXrHerKyt9wsyQ80nCoY5ewyOyaXIFa9vJjazK6vHSJMZLYvxodAhEqeMNh1YOvoykMMFOLc6H/a863KvX1kg374=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vsd+Xx+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92776C116C6;
	Wed, 11 Feb 2026 00:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770771426;
	bh=yzkylkEQyMlLPX3kedBSzjU8RsbSf5Jk4i2N65fCL30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vsd+Xx+447hSpwSmZtlt6wlU5Hsp407El/yFKvfrSUqG3FQLSrDuVoVM2V36u6YDn
	 1mo+o/9mKLtQoy/ggzuyPhHQ90EZlJ5/SJcYf0kxikYec8x+iqQ7dj690JynShMoiw
	 7iWldpWyz+lEAyyK4Gqz4ZtYUJ344F3VnoTZbuU2Q0EbOykBR4n/0+YM03kjkyajTH
	 k49D3J6/m8KCdRCyjHnLyE6jOnu9uAhfn/SnU5gh8XKWyeuwXazTEo2syDUuEgGHC5
	 8ybe5SdKk8diqA5JAdonfw4eNFzGAZ0saK5NJLG3bJ+DQ04fk2I8NCFr8GYJzAM8Wm
	 pnz+0JYn9w8yw==
Date: Tue, 10 Feb 2026 16:57:04 -0800
From: Drew Fustini <fustini@kernel.org>
To: Gong Shuai <gsh517025@gmail.com>
Cc: Dave.Martin@arm.com, acpica-devel@lists.linux.dev, alex@ghiti.fr,
	aou@eecs.berkeley.edu, aricciardi@baylibre.com,
	atish.patra@linux.dev, atishp@rivosinc.com, babu.moger@amd.com,
	ben.horgan@arm.com, conor+dt@kernel.org, cp0613@linux.alibaba.com,
	cuiyunhui@bytedance.com, devicetree@vger.kernel.org,
	fenghua.yu@intel.com, guo.wenjia23@zte.com.cn, james.morse@arm.com,
	krzk+dt@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	liu.qingtao2@zte.com.cn, liwei1518@gmail.com, mindal@semihalf.com,
	npitre@baylibre.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
	peternewman@google.com, pjw@kernel.org, rafael@kernel.org,
	reinette.chatre@intel.com, rkrcmar@ventanamicro.com,
	robert.moore@intel.com, robh@kernel.org, samuel.holland@sifive.com,
	sunilvl@ventanamicro.com, tony.luck@intel.com, vasu@rivosinc.com,
	ved@rivosinc.com, x86@kernel.org, zhiwei_liu@linux.alibaba.com,
	gong.shuai@sanechips.com.cn
Subject: Re: [PATCH RFC v2 08/17] RISC-V: QoS: add resctrl interface for
 CBQRI controllers
Message-ID: <aYvT4I7qWyJGuMDR@gen8>
References: <20260128-ssqosid-cbqri-v2-8-dca586b091b9@kernel.org>
 <20260209141649.330184-1-gong.shuai@sanechips.com.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209141649.330184-1-gong.shuai@sanechips.com.cn>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20925-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fustini@kernel.org,linux-acpi@vger.kernel.org];
	FREEMAIL_CC(0.00)[arm.com,lists.linux.dev,ghiti.fr,eecs.berkeley.edu,baylibre.com,linux.dev,rivosinc.com,amd.com,kernel.org,linux.alibaba.com,bytedance.com,vger.kernel.org,intel.com,zte.com.cn,lists.infradead.org,gmail.com,semihalf.com,dabbelt.com,sifive.com,google.com,ventanamicro.com,sanechips.com.cn];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA19D12063D
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 10:16:49PM +0800, Gong Shuai wrote:
> Hi, Drew
> 
> > Add interface for CBQRI controller drivers to make use of the resctrl
> > filesystem.
> > 
> > Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> >
> > ...
> >
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
> 
> It looks like the parameter order might be incorrect. I believe it
> should be:
> cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT, closid, type);

Thanks, I will fix so that closid and type are the correct order.
> 
> > +		if (err < 0) {
> > +			pr_err("%s(): operation failed: err = %d", __func__, err);
> > +			return resctrl_get_default_ctrl(r);
> > +		}
> > ...
> 
> Sorry for the resend, my company email had some formatting issues,
> so I'm sending this from my personal address.
> 
> Hope it doesn't cause any trouble!

No problem.

Thanks
Drew


