Return-Path: <linux-acpi+bounces-20693-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OkIG24yeWmNvwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20693-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 22:47:26 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F389ACEB
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 22:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E32530060B6
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 21:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CD332BF47;
	Tue, 27 Jan 2026 21:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEARLZZm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F6F32BF43;
	Tue, 27 Jan 2026 21:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769550437; cv=none; b=GJjN3P4lJLfi+O+TrAITFosqrbMDQTx65ah5mezV83aIiXTVPxY5gpWijSMtat7hILl/QlfyomZLSH8TWm+A9KQxG+7x8VaTyqKMJwo9gI1wO9883RLNvGIOXzE2fmvQoaMn9PEffx82xdBiTTpfJGt2rubKropKUcx9U6cv/sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769550437; c=relaxed/simple;
	bh=V9UEkbOrvf5E0u78+1v0R8sZs6y1JexLeJyE/uJ2M3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwdk+UJ0qfJHxPnvpiY9CJ361l2RmgumC2bKFehxrsG9G440wqA3J2pR4rYoquEzLNumqLkrQ1l6JlJaqcwT55onm/NFmlqXrJmvR0TusgDtWaMNBgM29R7tSvyElLP1kFGRFlginBGDYVfcTlfi0ixdB8fL0/7y0ukgE/3yAMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEARLZZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FB6C2BCAF;
	Tue, 27 Jan 2026 21:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769550436;
	bh=V9UEkbOrvf5E0u78+1v0R8sZs6y1JexLeJyE/uJ2M3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vEARLZZmBMOxL+lnrFFcUA6zg+F1phIc9ggqJPS8lag1bfsUMoKu8rmVogFia+JVG
	 9PJCW8z3Gj95pG0vni1MKU9BPwOlDnhX6YVnnS3ppO27JnsuwwCjGxHPXN4HCxV4Wy
	 5eoUNdwCQgFhXCwcfJ/CFHKu3FLRvST/in9W6wBMoZ7LPAODhoHdD/Pf3BO6UjKS5U
	 raJWGXF9xrI6ahr6C1ozFs+1urEszs7uBBVRdJHuhXswuetDgzSVSDPQnsa+M7Cvu3
	 2RLMB6SS6GscWbyn/vSoANwdbjRngIUzM0cmyxA2EvuFR+wAbVSTm1xYqYEexYbIrR
	 wLBydC45wRPtA==
Date: Tue, 27 Jan 2026 14:47:11 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-acpi@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH] ACPI: APEI: GHES: Disable KASAN instrumentation when
 compile testing with clang < 18
Message-ID: <20260127214711.GA3382807@ax162>
References: <20260114-ghes-avoid-wflt-clang-older-than-18-v1-1-9c8248bfe4f4@kernel.org>
 <CAJZ5v0ju+7U10_nuQMijadeFrVxUWQFYJfUyRvga9qEPdK50_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0ju+7U10_nuQMijadeFrVxUWQFYJfUyRvga9qEPdK50_Q@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-20693-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,alien8.de,huawei.com,kernel.org,linux.alibaba.com,gmail.com,google.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi,lkml];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D1F389ACEB
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 03:37:58PM +0100, Rafael J. Wysocki wrote:
> On Thu, Jan 15, 2026 at 12:27 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > After a recent innocuous change to drivers/acpi/apei/ghes.c, building
> > ARCH=arm64 allmodconfig with clang-17 or older (which has both
> > CONFIG_KASAN=y and CONFIG_WERROR=y) fails with:
> >
> >   drivers/acpi/apei/ghes.c:902:13: error: stack frame size (2768) exceeds limit (2048) in 'ghes_do_proc' [-Werror,-Wframe-larger-than]
> >     902 | static void ghes_do_proc(struct ghes *ghes,
> >         |             ^
> >
> > A KASAN pass that removes unneeded stack instrumentation, enabled by
> > default in clang-18 [1], drastically improves stack usage in this case.
> >
> > To avoid the warning in the common allmodconfig case when it can break
> > the build, disable KASAN for ghes.o when compile testing with clang-17
> > and older. Disabling KASAN outright may hide legitimate runtime issues,
> > so live with the warning in that case; the user can either increase the
> > frame warning limit or disable -Werror, which they should probably do
> > when debugging with KASAN anyways.
> >
> > Closes: https://github.com/ClangBuiltLinux/linux/issues/2148
> > Link: https://github.com/llvm/llvm-project/commit/51fbab134560ece663517bf1e8c2a30300d08f1a [1]
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >  drivers/acpi/apei/Makefile | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
> > index 2c474e6477e1..346cdf0a0ef9 100644
> > --- a/drivers/acpi/apei/Makefile
> > +++ b/drivers/acpi/apei/Makefile
> > @@ -1,6 +1,10 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_ACPI_APEI)                += apei.o
> >  obj-$(CONFIG_ACPI_APEI_GHES)   += ghes.o
> > +# clang versions prior to 18 may blow out the stack with KASAN
> > +ifeq ($(CONFIG_COMPILE_TEST)_$(CONFIG_CC_IS_CLANG)_$(call clang-min-version, 180000),y_y_)
> > +KASAN_SANITIZE_ghes.o := n
> > +endif
> >  obj-$(CONFIG_ACPI_APEI_EINJ)   += einj.o
> >  einj-y                         := einj-core.o
> >  einj-$(CONFIG_ACPI_APEI_EINJ_CXL) += einj-cxl.o
> >
> > ---
> 
> I'm inclined to apply this for 6.20/7.0 unless someone has any
> particular heartburn related to it.

I think taking it for next cycle is fine, I can just apply this to our
CI until it makes its way to Linus. Could you stick a

  Cc: stable@vger.kernel.org

on the patch in that case so that it can go back to 6.18 after the
initial flurry of the merge window?

Cheers,
Nathan

