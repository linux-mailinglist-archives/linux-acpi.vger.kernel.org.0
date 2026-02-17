Return-Path: <linux-acpi+bounces-21003-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKQ1MbmzlGlbGgIAu9opvQ
	(envelope-from <linux-acpi+bounces-21003-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Feb 2026 19:30:17 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2602514F256
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Feb 2026 19:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45D3A3031820
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Feb 2026 18:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F07B372B33;
	Tue, 17 Feb 2026 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nP4xUFSL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D431C69D;
	Tue, 17 Feb 2026 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771352929; cv=none; b=iLy427iTbjvO4utaHBrUyIY+nSR1UNY+tEU12LYBPR/gDNV50uy+fjLNjZ4ccXkTNL/ULfnsauKyEMhgJJlERANGkRnQAUQ4VsmUBLyTW1w7y9KE6QMbIjajBOio/y/4NT09h1O5zply7/Tn9XSyVOeb7UGV+2UzsC6qaDpfkSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771352929; c=relaxed/simple;
	bh=6VEW5d7AQFJxxetsXBI84a7st2FxJT4K5c5ALxF0BlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcVFZCk/GSX02DMHklsgdnWnEm2+486JLZUWTe5Yl1IK9bijTCpGq3D+6y9LBIpTWl0kRo+0DXDTjM/jRW35GmVnZ239YcI5EqvLDe0oBjY2HrXSeMcdPbytNDcL/v/xjkO+rPksbYnIDOov2kaYR+6kzUJIyeXVa5IwD2ZrboI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nP4xUFSL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0EFC4CEF7;
	Tue, 17 Feb 2026 18:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771352928;
	bh=6VEW5d7AQFJxxetsXBI84a7st2FxJT4K5c5ALxF0BlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nP4xUFSLToWnOwwa4nhEUkF5sMvpVR7KgCPHfM5ocvrhmdQ2qdKf3rGu6kGOB3j5n
	 hjWBs0euPbe56pJK4oYINPNhuTSnzogVtM8Ms2p3I1NLofyMLPVSxUhkOvC+jxotKy
	 jxBj/EOajDew9rXSQMNdQJ+4+N2VTKnUeOIXFLxsE85z6wkqRFoV7JOYawVsA++mn4
	 FJi0HSs5vAUP/s9og47Tdw7ofCy5jYe1gVjRnQMOntrLbLxMN4h3GeWXiLOB2q0Nfs
	 2YxcjZTtybCIjgtdTL9nBKBT+JbqrbI2SWBbejs8A+ea3hiBTN3hdMoV+d8SAALbhS
	 cwDRpS+QRNn/A==
Date: Tue, 17 Feb 2026 10:28:52 -0800
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
Subject: Re: [PATCH RFC v2 05/17] RISC-V: QoS: define CBQRI capacity and
 bandwidth capabilities
Message-ID: <aZSzZChSrjXeZmf1@gen8>
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
 <20260128-ssqosid-cbqri-v2-5-dca586b091b9@kernel.org>
 <3f53c823-74ab-46c3-9cf0-c28b062f2c89@intel.com>
 <aZCh3JaS2V0pLWXm@gen8>
 <0ba158fc-0c44-4b83-b733-9fc00c4d7f3a@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ba158fc-0c44-4b83-b733-9fc00c4d7f3a@intel.com>
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
	TAGGED_FROM(0.00)[bounces-21003-lists,linux-acpi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre.com:email]
X-Rspamd-Queue-Id: 2602514F256
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 08:32:41AM -0800, Reinette Chatre wrote:
> Hi Drew,
> 
> On 2/14/26 8:25 AM, Drew Fustini wrote:
> > On Fri, Feb 13, 2026 at 03:13:42PM -0800, Reinette Chatre wrote:
> >> Hi Drew,
> > 
> > Hi! Thanks for your detailed feedback on this series.
> > 
> >> On 1/28/26 12:27 PM, Drew Fustini wrote:
> >>> Define data structures to store the capacity and bandwidth capabilities
> >>> that are discovered for a CBQRI-capable controller.
> >>>
> >>> Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> >>> Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> >>> Signed-off-by: Drew Fustini <fustini@kernel.org>
> >>> ---
> >>>  arch/riscv/kernel/qos/internal.h | 128 +++++++++++++++++++++++++++++++++++++++
> >>>  1 file changed, 128 insertions(+)
> >>>
> >>> diff --git a/arch/riscv/kernel/qos/internal.h b/arch/riscv/kernel/qos/internal.h
> >>> new file mode 100644
> >>> index 000000000000..ff2c7eff50be
> >>> --- /dev/null
> >>> +++ b/arch/riscv/kernel/qos/internal.h
> >>> @@ -0,0 +1,128 @@
> >>> +/* SPDX-License-Identifier: GPL-2.0-only */
> >>> +#ifndef _ASM_RISCV_QOS_INTERNAL_H
> >>> +#define _ASM_RISCV_QOS_INTERNAL_H
> >>> +
> >>> +#include <linux/resctrl.h>
> >>
> >> The include caught my eye but I did not notice any additions in this patch
> >> refer to it.
> >>
> >> Reinette
> >>
> > 
> > I was using this to make resctrl structs available in the code that
> > includdes this header:
> > 
> > arch/riscv/kernel/qos/qos.c
> > arch/riscv/kernel/qos/qos_resctrl.c
> 
> I see. The changelog made me believe that this patch defines new data structures
> used by the patches that follow and the inclusion of resctrl.h created expectation
> that some of these new data structures contain resctrl members that I was interested
> in seeing used. If keeping this style then a snippet in changelog that explains the
> header inclusion/organization would be helpful.
>  
> > Should I rearrange to include resctrl.h directly where it is needed?
> I'll defer to the RISC-V folks since I understand that not all subsystems follow/enforce
> rule #1 of Documentation/process/submit-checklist.rst the same (also called "Include
> What You Use (IWYU)") quoted for convenience:
> 
> 	1) If you use a facility then #include the file that defines/declares           
> 	   that facility.  Don't depend on other header files pulling in ones           
> 	   that you use.
> 
> I have worked with code following different customs and personally I do find code
> following IWYU easier to maintain.

Thank you for the explanation. I agree that IWYU makes more sense so
I'll rearrange how I do includes in the series.

BTW, I'm working through all the comments in patch 8. In short, there
are a lot of shortcomings in my current implementation that need to be
fixed and I will explain in my reply how I plan to address them.

Drew

