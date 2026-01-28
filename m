Return-Path: <linux-acpi+bounces-20746-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aErCF+p3emmE6wEAu9opvQ
	(envelope-from <linux-acpi+bounces-20746-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 21:56:10 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BEEA8DEC
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 21:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DC723089461
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 20:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E66E37107A;
	Wed, 28 Jan 2026 20:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msfm9Jud"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1F8331202
	for <linux-acpi@vger.kernel.org>; Wed, 28 Jan 2026 20:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769633454; cv=none; b=ATqySd6SjNW6IvxdA8CIIteBOjQATD+jRBM6PPAOW4Ii/DgxqZATZWYEoVzHUqZCh5LRw+8NaIHcjSP14uS5UZWE+seLrNr6j7b+cPsa8F+MnxEbHG0UIomIfpavprfeeeiFYGQqpuhM0WVMPcvhLFyKFCV5l5ZLbr1mFvo60I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769633454; c=relaxed/simple;
	bh=ksVa7i053Gqvf5wbPc/HrTEHP7zm0EUFO3JlMtMt06k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JvuGAQJaCvDkV0/EsPKNAEgb3DKkD1YaosjvSxtS5HP4zaciI8zuG1lqSq47I0P/vCdAENQD4m8vOF0O3RSzSdZnuvXALufjv7YtipJGyQDr3KwqCEPOyl4eMy9smHRvKpmssKIiSnjI2NsY/a5yAQMM9JcTCZBMFQSZIqKIyrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msfm9Jud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901E6C2BCB5
	for <linux-acpi@vger.kernel.org>; Wed, 28 Jan 2026 20:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769633453;
	bh=ksVa7i053Gqvf5wbPc/HrTEHP7zm0EUFO3JlMtMt06k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=msfm9JudaB4iljw/Je2k9+mMvyqev+mms7mUQ9Mq/OD4Ti/EobONMorms0WSdJ3mj
	 2thOa60VmGPUkABxlF1ZfpktHn6LniqsC+jXKfQo6gL1tX7bxNmmeWaCS+mrn7O67P
	 7PNG+FYO8Yy8r029/3DXWY0XVaw1BEr/zqk2ckSRpSbPSRcjVHoKcYKP7QudDV7aS7
	 /jwjh9rE9i1KBtutV46RLOnZk7sipUCaHPIEdcAhBVpLAEHRnLzq22izCg7GaCcMSX
	 tiSpxjP+vCWRBnQMLNRuxC2SL6zsc0+k3vKImVA54zmuiLTM7CV5+LjfT+jgG76IQF
	 AYg1k5aBjOVpg==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-3f9ebb269c3so115112fac.3
        for <linux-acpi@vger.kernel.org>; Wed, 28 Jan 2026 12:50:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWzC1Oz+9UiPwCpUUGCf8izgfGXOflhZYx8xHWKaSAn0YWzMSuwvFL6/KNK98O7t2UVeXteQ+fUyJsW@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ8BVXBakFzZuYP9Lmz1nUfZI+Uu+BcbXtgrG/hoNRS27oE4sV
	9cRO2XLzV8G/LZQCDzg7M/KrSCU2Boe9aNkCJMygU6khK4W4tEqIzAgoEyKBpX/Jr0dv0bD5Cip
	m9CmwWIP9dh2DNdXWvqOZGaN2Hp8ZTJk=
X-Received: by 2002:a4a:e7d2:0:b0:662:f764:9050 with SMTP id
 006d021491bc7-662f76491cbmr2156938eaf.41.1769633452515; Wed, 28 Jan 2026
 12:50:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
 <20260128-ssqosid-cbqri-v2-14-dca586b091b9@kernel.org> <CAJZ5v0iSZ6qvhUWHtrWuO5XBviMcLUMfRB_hWn-FxAhe=LoA-Q@mail.gmail.com>
 <aXp1HexsqZst1xXu@x1>
In-Reply-To: <aXp1HexsqZst1xXu@x1>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 28 Jan 2026 21:50:41 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gZaijBJBT24ZZkXPpqggkbXHqVB2u-MOaNJ7X0Ls08pA@mail.gmail.com>
X-Gm-Features: AZwV_Qig52UoHvD8XkTqFmnO9_rJtBsUhA_OiCKW2V4vwWKvPytXGv8uGMe7cv4
Message-ID: <CAJZ5v0gZaijBJBT24ZZkXPpqggkbXHqVB2u-MOaNJ7X0Ls08pA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 14/17] include: acpi: actbl2: Add structs for RQSC table
To: Drew Fustini <fustini@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Adrien Ricciardi <aricciardi@baylibre.com>, 
	Nicolas Pitre <npitre@baylibre.com>, =?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
	Atish Patra <atish.patra@linux.dev>, Atish Kumar Patra <atishp@rivosinc.com>, 
	Vasudevan Srinivasan <vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, 
	yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>, 
	guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
	Reinette Chatre <reinette.chatre@intel.com>, Tony Luck <tony.luck@intel.com>, 
	Babu Moger <babu.moger@amd.com>, Peter Newman <peternewman@google.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, James Morse <james.morse@arm.com>, 
	Ben Horgan <ben.horgan@arm.com>, Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, x86@kernel.org, 
	Rob Herring <robh@kernel.org>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[mail.gmail.com:server fail,sea.lore.kernel.org:server fail];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	TAGGED_FROM(0.00)[bounces-20746-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,ventanamicro.com,sifive.com,baylibre.com,semihalf.com,linux.dev,rivosinc.com,bytedance.com,linux.alibaba.com,gmail.com,zte.com.cn,intel.com,amd.com,google.com,arm.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8BEEA8DEC
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 9:44=E2=80=AFPM Drew Fustini <fustini@kernel.org> w=
rote:
>
> On Wed, Jan 28, 2026 at 09:31:16PM +0100, Rafael J. Wysocki wrote:
> > On Wed, Jan 28, 2026 at 9:28=E2=80=AFPM Drew Fustini <fustini@kernel.or=
g> wrote:
> > >
> > > Add structs for the RQSC table which describes the properties of the
> > > RISC-V QoS controllers (CBQRI) in the system. The table also describe=
s
> > > the topological arrangement of the QoS controllers and resources in t=
he
> > > system. The topology is expressed in terms of the location of the
> > > resources within the system and the relation between the QoS Controll=
er
> > > and the resource it manages.
> > >
> > > Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
> > > Link: https://github.com/riscv-non-isa/riscv-rqsc/blob/main/src/chapt=
er2.adoc
> > > Signed-off-by: Drew Fustini <fustini@kernel.org>
> >
> > Of course, this change needs to go through upstream ACPICA.
>
> Thank you for pointing this out. I've not worked with ACPI prior to
> dealing with the RQSC table.
>
> Is the pull request for RISC-V RIMT a good example of how to do that?
> https://github.com/acpica/acpica/pull/1003

I think so.

You may also have a look at
Documentation/driver-api/acpi/linuxized-acpica.rst (sorry for the
counter-intuitive location).

As a general rule, Linux patches that change the ACPICA code need to
be auto-generated from the corresponding upstream ACPICA commits (and
when you do so, please add a Link: tag pointing to the source ACPICA
commit to the Linux patch).

