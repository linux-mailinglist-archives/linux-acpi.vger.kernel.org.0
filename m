Return-Path: <linux-acpi+bounces-20908-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFbmKGTsiWlpEQAAu9opvQ
	(envelope-from <linux-acpi+bounces-20908-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Feb 2026 15:17:08 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE22110244
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Feb 2026 15:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EADA53019811
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Feb 2026 14:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2556E366064;
	Mon,  9 Feb 2026 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXuaLcyb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86C828312D
	for <linux-acpi@vger.kernel.org>; Mon,  9 Feb 2026 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770646624; cv=none; b=qR0lVqK5Yffuaj43N1s4caXk6Xi4weMr2e+ZbTkQFANMWS5KFzIVn4W1NaHQEzo+dnyhIYGza1M7kpXFEm562DjZpsrRla8QwSovdZHoj57OMHibFirJyUXTmORIrqg+yZsHqdQHvfHS5eUUSS9RPiVdThhGZs5yJLkfAr3yu4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770646624; c=relaxed/simple;
	bh=gfTEdIsMmUOuJYpGHiGGK9+1z6kQlfXxsYz33NHV2IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ng84eB261rAg9U43Wy8J/hMemLMOY08pI5x6/TqtravoLDZ2LewIX4g1QnjLbW+1MMruW/tyHTbAjI3xxCGZlp+ZwYgiVTKa7vaM1zs/TlL7n1/4vXLRb8CTG3kmYzn84N6ihnsD3bPS5BKqFPsn+dMl+Weg3UsGldWoFY8kpag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXuaLcyb; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-35305538592so2684930a91.0
        for <linux-acpi@vger.kernel.org>; Mon, 09 Feb 2026 06:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770646623; x=1771251423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+vhAUWptZLQYZPG8ROuiqprar1JCQQK4npIFBepuBs=;
        b=NXuaLcybPND+YIJKqPMSsPeiW37EzhCfaQj15wY8pfGeaGvszvtcq71+oppya71E9d
         ri0RdB4PkvT1LGDizv+jwr+hTD2Y5cEeu2IJ0faCAIx5WOAPTIXuDxwA55jGmn3lCswx
         XK3Yv/ujCgDzGDdXCj8TQ4O4gFy03eENmJ8jM84lCWR8k4dZeNE8QjAQX3KKPbDpbNXv
         tsxhTNXY7drgHdDBHwowCOgDfZIC87d4y1orPdEWhyEaxdAPKa5ii7FlHpxp5XCOOdwM
         NGZ0mtBYO7LCR/7CeBUWkt6GK5yFngUiYAe/olwZek9WAgSbIUUBwWJE96jQ1y8Izg7A
         Qnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770646623; x=1771251423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J+vhAUWptZLQYZPG8ROuiqprar1JCQQK4npIFBepuBs=;
        b=cInDCvzt1CSRW7If00pSE6qNjYltX3EYZ+Nc47te3UzmyVbeAgBdnqs7/5/KLbvrgP
         k5G/egp241eaRoiB2cBf8RDlc5crGPzrZydCQIxA9jp7YEFmyQ14UlfZjOvxPvz1ETUQ
         9gTxGJwH+Wh0NASsmraSDwEEcbhU37gG62tV9aJsePtuXrWykiICCPRyMXD2bXf5vn+G
         WNy/ld7QoRKzCQjiNg5kprMcFGKNgUKU5hvU3++sJ79sCIWAu6VRmln80qqW0AirtavW
         CPDJHJBPCXduHul2O7g6VDBL7zUBMoqPVVbZtFzINqQPVbCRqal3fNIKybA1GWEJKe/x
         qmuw==
X-Forwarded-Encrypted: i=1; AJvYcCWO0bqJ3e8L0Vt3ktCDwxC5+n6e1+BJL33XDj4b0kWU5Hps/gm3ibrwhc1Aifk0z4P/coxzfPA8Mzyn@vger.kernel.org
X-Gm-Message-State: AOJu0YyfjgNafa2SWaX5vc6soWcm5AWqEV7MmNd82KIROK0sxuUB8hXP
	2e+f6sHw6LHN9wowBd5JFN9r0qS9v8Ir6hKVm4YgDQ0rizHBfzme9riW
X-Gm-Gg: AZuq6aLkqPUzh4TEFvAIxN3XDEzeXJn9luGATon97mpoVtrdU7V+276JZ0lMl/+ogiT
	w57jtIibXKz2nQ2CZucN04MoRb9EhLQg/kFQ/BoIIZksTJIxEff3g540uY/eNr45qfN5FUElph2
	7G3tfGrWaY9aB2cG6bQb42H1Wnr6cqDapsowHoFpslKFq9V+9REC/CMnUZHOO5X5Idrzziwjn1D
	oY8ROB+AwmPaNS7SaIpogeWXb2h1YsdwEshiYXN7LE921S4aG91ATPtlnNoCGJVPMWdvsvJ9bfK
	CXfOleNaQHBnohIOK2tZB//tqf2XKsASR04gxVbw69zHAQljXZWOeIJUm0GtXd3BdouLI9pMED2
	a+JCrSsqQrB50W0KHFM0+ksjOPGtM3oMMmfKtp9siphBJHU0u/SGltqLvgXDYbI2MOFOLEATRhG
	Ns1JCSRCuKHMe+lYtp11gnIE/7STstX7S48A==
X-Received: by 2002:a17:90a:d010:b0:356:2eac:b650 with SMTP id 98e67ed59e1d1-3562eacbbccmr4038749a91.3.1770646623298;
        Mon, 09 Feb 2026 06:17:03 -0800 (PST)
Received: from localhost.localdomain ([106.38.154.106])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3549c5955a7sm14852844a91.17.2026.02.09.06.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 06:17:02 -0800 (PST)
From: Gong Shuai <gsh517025@gmail.com>
X-Google-Original-From: Gong Shuai <gong.shuai@sanechips.com.cn>
To: fustini@kernel.org
Cc: Dave.Martin@arm.com,
	acpica-devel@lists.linux.dev,
	alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	aricciardi@baylibre.com,
	atish.patra@linux.dev,
	atishp@rivosinc.com,
	babu.moger@amd.com,
	ben.horgan@arm.com,
	conor+dt@kernel.org,
	cp0613@linux.alibaba.com,
	cuiyunhui@bytedance.com,
	devicetree@vger.kernel.org,
	fenghua.yu@intel.com,
	guo.wenjia23@zte.com.cn,
	james.morse@arm.com,
	krzk+dt@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	liu.qingtao2@zte.com.cn,
	liwei1518@gmail.com,
	mindal@semihalf.com,
	npitre@baylibre.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	peternewman@google.com,
	pjw@kernel.org,
	rafael@kernel.org,
	reinette.chatre@intel.com,
	rkrcmar@ventanamicro.com,
	robert.moore@intel.com,
	robh@kernel.org,
	samuel.holland@sifive.com,
	sunilvl@ventanamicro.com,
	tony.luck@intel.com,
	vasu@rivosinc.com,
	ved@rivosinc.com,
	x86@kernel.org,
	zhiwei_liu@linux.alibaba.com,
	gong.shuai@sanechips.com.cn
Subject: Re: [PATCH RFC v2 08/17] RISC-V: QoS: add resctrl interface for CBQRI controllers
Date: Mon,  9 Feb 2026 22:16:49 +0800
Message-ID: <20260209141649.330184-1-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128-ssqosid-cbqri-v2-8-dca586b091b9@kernel.org>
References: <20260128-ssqosid-cbqri-v2-8-dca586b091b9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[43];
	FREEMAIL_CC(0.00)[arm.com,lists.linux.dev,ghiti.fr,eecs.berkeley.edu,baylibre.com,linux.dev,rivosinc.com,amd.com,kernel.org,linux.alibaba.com,bytedance.com,vger.kernel.org,intel.com,zte.com.cn,lists.infradead.org,gmail.com,semihalf.com,dabbelt.com,sifive.com,google.com,ventanamicro.com,sanechips.com.cn];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20908-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gsh517025@gmail.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,baylibre.com:email]
X-Rspamd-Queue-Id: 1DE22110244
X-Rspamd-Action: no action

Hi, Drew

> Add interface for CBQRI controller drivers to make use of the resctrl
> filesystem.
> 
> Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Drew Fustini <fustini@kernel.org>
>
> ...
>
> +u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
> +			    u32 closid, enum resctrl_conf_type type)
> +{
> +	struct cbqri_resctrl_dom *hw_dom;
> +	struct cbqri_controller *ctrl;
> +	int reg_offset;
> +	u32 percent;
> +	u32 rbwb;
> +	u64 reg;
> +	int err;
> +
> +	hw_dom = container_of(d, struct cbqri_resctrl_dom, resctrl_ctrl_dom);
> +
> +	ctrl = hw_dom->hw_ctrl;
> +
> +	if (!r->alloc_capable)
> +		return resctrl_get_default_ctrl(r);
> +
> +	switch (r->rid) {
> +	case RDT_RESOURCE_L2:
> +	case RDT_RESOURCE_L3:
> +		/* Clear cc_block_mask before read limit operation */
> +		cbqri_set_cbm(ctrl, 0);
> +
> +		/* Capacity read limit operation for RCID (closid) */
> +		err = cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT, type, closid);

It looks like the parameter order might be incorrect. I believe it
should be:
cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT, closid, type);

> +		if (err < 0) {
> +			pr_err("%s(): operation failed: err = %d", __func__, err);
> +			return resctrl_get_default_ctrl(r);
> +		}
> ...

Sorry for the resend, my company email had some formatting issues,
so I'm sending this from my personal address.

Hope it doesn't cause any trouble!

Thanks,
Shuai

