Return-Path: <linux-acpi+bounces-20766-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHnRBDhme2l2EQIAu9opvQ
	(envelope-from <linux-acpi+bounces-20766-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 14:52:56 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DB5B09E3
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 14:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43151305B295
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 13:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA5D345CD0;
	Thu, 29 Jan 2026 13:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="MqUu8Ubv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A23346799
	for <linux-acpi@vger.kernel.org>; Thu, 29 Jan 2026 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769694597; cv=none; b=h0VyvReDLZVkcjxFo8TaT5YzwE55ykYGE/XdHNjsl3DmeqXkYwYdr1bV4wwBSunVRtP2pofXfNT7TmOMOhGLz1YZqCjz6u5mOXRkquogMCpFZgmHKTAARWQWE7jaKHwuxsQ4fcO9DTNfNV+quUSsvmL7QZsyBJFBTI6jr1LGguM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769694597; c=relaxed/simple;
	bh=Kx1nkocKHg2r0KbodzyE6L4KOQagRhJ/saQ/g0TrF+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HI74daGcZcaRA1R9pHchWhhp3YZvq2sC05YP72xOnd7PIDBybAdJpxvlxitLxDPDa47J6z9EoY/rQTU9NpHNAMo2o2npzL3XaS9NaZgQ5nUjcjl7mwcaHa5rTXfUxXdrCGM1AtvWQE5iRvGaTdtCZRjQXzL0B+Lb38wuoCKZF0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=MqUu8Ubv; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-81f4c0e2b42so527693b3a.1
        for <linux-acpi@vger.kernel.org>; Thu, 29 Jan 2026 05:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1769694595; x=1770299395; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MVJS0XZnQdJSuFRyO9cJopaQzPSIm6FDGJq3O2WzR/w=;
        b=MqUu8UbvxitnXnJTGHY5ruvNJV8KH9cJGi0hvHQc5CJmR8TmY+QDdt3QeIw3DPrMvJ
         t4Ac1K4x1Mncr0YnE4dabFNV5Tfd6P/o2dsY397c00UyyQBESfQw0jjGSharhjhEa4oU
         mIps82+3jo8ZbtGssM/JphJrze1iOruCydgoiECd1xWQJKlyZjRNv56Lek2XBgh2jmrC
         9S+Hhc9FHEBnY7wjFgIPujlErsDg1rjFHEFzt7rVU2FbSow3Me6ZOdr5HMV7eVndN5tP
         Vm9R4zyIqvPbtOTklEZGTDcZgzHLBeL/QeWmvhRIMjVt/F+KfPTfgOdui5nMA9Ea9xYd
         PlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769694595; x=1770299395;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MVJS0XZnQdJSuFRyO9cJopaQzPSIm6FDGJq3O2WzR/w=;
        b=Q3jjOsMEMVqnXsJ0YPfZZJpRsjeN6BKZ6dvdz4SCrd6PnO21K8h/Co2sCae2PlmDe8
         GVGy4y5WzWEfLQSad+BLSQaA11kqskyyJcCkHEfcLuoqZckY1if2MWAQ+Q5BWHNkY602
         ajgwbAYaRZ+ePmktKNPLZy3m0ZnBdPMEAzPYmEthQBYA05GgLvPKEY8KFllycJyVCq2M
         7Ub7qVlgCXPw7Vmq4+mMHy0CnE0aEnvlj+0Q95th4yuwggS6sWLdU5Y9bvFmrfxDM2Vv
         CrGC7QMAJVomS5wVynrDggoVZF+t6kq0v2k2+2YuVseUioik158aJ/jKckZnbNk5mJbE
         M1ww==
X-Forwarded-Encrypted: i=1; AJvYcCUTM45H7Q5ZFaLxRZ/nnOZ3KzpgcvVAt3dSaMJ4n3Oa2Ag9gjtW8Mqvfs50xCb+vs7f7LpEVZ44y3ku@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb+lRFroFqMq6VqHJp5H8/WwDCg8UD0baf9dBu89dSFlAzDi2w
	0DvtGgnEtdfa/hqJ9Zhts11WBnHFrsfmBd2AFvVydVfysHEICrErPshG2cE2aGMXTqI=
X-Gm-Gg: AZuq6aJbo/G923nWhYuG83+IK3aV6CmizDqr5GnbHb5v3WeSBuYi+U0xao5efVe3Z1M
	VjHZ+fprFmPOvTZd1YpErrQIsJ+y8Aam/kJaBm5UOAWFNUtgkfjs8WSQ6yug+oh9aoseQCRuWan
	TFkM9Toec+sVLanny1g2kiDr5NutrSQD2aVmDFKgA5HdPLbfRH/XX7prVnqRJyfSnIfQaWqd7f6
	te4X+BeeD6b3w6sIYgNpW90qEDhAxe0J2WEomJQFF/r7ja4pKlJXcf7ZwEZfjhPY5Lc+2Dbnr9w
	sVZHmm5LI/2WJtp7Zm72woHock6umwWjvoSgRxkk0xoaJ0t/kadjZUlY2FhAClk7rg2xZhwaWDz
	RGIuOjna1D0O23o8kt4PSpoFCUQXy5j39FpFKBsw29XGom1PYy9HO4u43iNpsnT9M1PdY78sTZ1
	AwslueJX22c6WXjfE0Ug==
X-Received: by 2002:a05:6a00:2e2a:b0:800:8fdf:1a54 with SMTP id d2e1a72fcca58-82369275931mr8476106b3a.34.1769694595607;
        Thu, 29 Jan 2026 05:49:55 -0800 (PST)
Received: from sunil-laptop ([106.51.192.152])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfcaadsm6072882b3a.37.2026.01.29.05.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 05:49:54 -0800 (PST)
Date: Thu, 29 Jan 2026 19:19:43 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, huyuye <huyuye812@163.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Robert Moore <robert.moore@intel.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, dai.hualiang@zte.com.cn,
	deng.weixian@zte.com.cn, guo.chang2@zte.com.cn,
	liu.qingtao2@zte.com.cn, wu.jiabao@zte.com.cn,
	lin.yongchun@zte.com.cn, hu.yuye@zte.com.cn,
	zhang.longxiang@zte.com.cn, zuo.jiang@zte.com.cn,
	li.kunpeng@zte.com.cn, Sunil V L <sunilvl@oss.qualcomm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH v2] ACPI: pci_root: Clear the acpi dependencies after PCI
 root bridge initialization on RISC-V
Message-ID: <aXtld38sQ9qFoNKk@sunil-laptop>
References: <CAJZ5v0iZukqD0atbdfBnmZAxUzNB6sTcJ1YUeAo5a8NRn-emEg@mail.gmail.com>
 <20260127194648.GA368841@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260127194648.GA368841@bhelgaas>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[ventanamicro.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20766-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ventanamicro.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,163.com,google.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,intel.com,vger.kernel.org,lists.infradead.org,zte.com.cn,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ventanamicro.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunilvl@ventanamicro.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ventanamicro.com:dkim]
X-Rspamd-Queue-Id: 63DB5B09E3
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 01:46:48PM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 27, 2026 at 06:50:24PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Jan 27, 2026 at 6:26 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Tue, Jan 27, 2026 at 04:00:49PM +0100, Rafael J. Wysocki wrote:
> > > > On Mon, Jan 12, 2026 at 3:17 PM huyuye <huyuye812@163.com> wrote:
> > > > >
[...]

> > Not really.
> > 
> > acpi_dev_clear_dependencies() is related to the way Linux uses _DEP
> > which is to defer the enumeration of dependent devices until the
> > devices they depend on are ready.
> > 
> > So by calling acpi_dev_clear_dependencies() the driver basically
> > allows other drivers to bind to devices.
> 
> I assumed the dependency expressed by _DEP would be satisfied by the
> execution of some other ACPI method.  E.g., the dependency might be
> satisfied when a _REG method makes an opregion available (although the
> spec seems to suggest that's only one of the possible dependencies).
> 
> But in this case it sounds like RISC-V is using _DEP not because of
> any ACPI-related ordering requirement, but simply to enforce the OS
> enumeration order (and therefore naming).  I guess this refers to PCI
> device naming, so I suppose that dependency is on
> pci_acpi_scan_root().
> 
Right. Devices that use wired interrupts (or GSIs) depend on the APLIC
interrupt controller being probed first. ACPI uses the _DEP mechanism to
enforce this probe order. However, when multiple dependent PCI bridges
are present in the system, there is no guarantee that they will be
probed in the same order on every reboot. This patch addresses the issue
by adding _DEP relationships between the PCI bridge nodes in the
platform, ensuring that they are always probed in a deterministic
order.

> I thought udev was supposed to be the real solution for consistent
> naming.  Is this sort of a workaround to accomplish the same end?
>
Yes, Marc had suggested this as well, but it looks like it’s not easy to
use in this environment [1].

> In any case, your IS_ENABLED(CONFIG_RISCV) proposal seems fine to me.
> I think it's nice if we can avoid adding another __weak function.
> 
I agree. But I am not sure if ARM also can get into this situation with
GICv5. Adding Lorenzo.

[1] - https://lore.kernel.org/linux-riscv/20251126161540.6460-1-ni_liqiang@126.com/

Thanks,
Sunil

