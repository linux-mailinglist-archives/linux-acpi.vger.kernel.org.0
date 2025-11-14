Return-Path: <linux-acpi+bounces-18910-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B6EC5E384
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Nov 2025 17:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E58A8540D42
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Nov 2025 15:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DF1324B35;
	Fri, 14 Nov 2025 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKZv8SOp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC549176ADE;
	Fri, 14 Nov 2025 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763133808; cv=none; b=mh0DDP162fQ6XaKen818rsKWAAIjvYp++zBPFp8IOeTTUIyfJEhqruGZX9KPvgoW78iRcmtQ0k7GijQiDptS/XqpZ44NSsJOfkPqbmu1qVd2jk5VYcQPYUqpjrj83pTFQRaajvN459dCQPQEnWf5Ou1qPk9t4oi7jo9Ptp3qeJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763133808; c=relaxed/simple;
	bh=HR765DhUvED/IAYt/KalTJoC6rZzlIvAnWmGbhovKJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwqU/5yzg1rJD/Q+vP+O3lJD//BnCSw22fHzbOKcnitQ/GFXI3y9vu84cdB6rZNnW+z/A3wuSHYkV1+SSRU3cIbXQs7DNTOHCSu8m3Xuf2KATEmWomER0U5ymp7z9rt10+W17B40v0IbNAjCmexXpUCxZaIpJ7fK2tz1Kj7Z8xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKZv8SOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6623C4CEF5;
	Fri, 14 Nov 2025 15:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763133808;
	bh=HR765DhUvED/IAYt/KalTJoC6rZzlIvAnWmGbhovKJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dKZv8SOpFhYMv82Bb47ixVSYEdtUwSvyoBkSDMrRmTQ8GK2ndLwlMfMBiLHAbjcbV
	 cmJa43PIae5JaMtaTovUMsc0qCviAYBshBxDfKh8/HhrLi6Zz1whJkL3vSISFhWflT
	 POl4U8ytpyfaGSG6QTkmH/TWGNoDxmBCAxKFbCg59ApZIbJDnlvQ2ucP9L2THsHFa7
	 EUc9tX+pBbG/xXpL/jmzkUjt82d15rZ70vtrChAZtwZQeJ96VOW007zQPX0m5a0b2M
	 iuol1iU51PaxZWzccFf7w0H0ZKHod2V7ZjI297Na45RHTSejjmazzexuuUElxc0eBU
	 3d5vzsa9VOwQQ==
Date: Fri, 14 Nov 2025 15:23:22 +0000
From: Will Deacon <will@kernel.org>
To: Charles Mirabile <cmirabil@redhat.com>
Cc: "Kazuhiro Abe (Fujitsu)" <fj1078ii@fujitsu.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"Koichi Okuno (Fujitsu)" <fj2767dz@fujitsu.com>,
	"guohanjun@huawei.com" <guohanjun@huawei.com>,
	"ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>
Subject: Re: [PATCH v4] ACPI: AGDI: Add interrupt signaling mode support
Message-ID: <aRdJant_3FzZt9w6@willie-the-truck>
References: <OSAPR01MB7669F9B9E145A50B38819E13D5CEA@OSAPR01MB7669.jpnprd01.prod.outlook.com>
 <20251112044239.4049011-1-cmirabil@redhat.com>
 <OSCPR01MB16310F566905156A462CE3727D5CAA@OSCPR01MB16310.jpnprd01.prod.outlook.com>
 <CABe3_aE7EjKX1uJbA_r9W_Em3Eu8F4xzdcKh0vfjjJ4YQe7C4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABe3_aE7EjKX1uJbA_r9W_Em3Eu8F4xzdcKh0vfjjJ4YQe7C4Q@mail.gmail.com>

On Fri, Nov 14, 2025 at 10:20:39AM -0500, Charles Mirabile wrote:
> On Fri, Nov 14, 2025 at 3:21 AM Kazuhiro Abe (Fujitsu)
> <fj1078ii@fujitsu.com> wrote:
> > > On Mon, Nov 10, 2025 at 07:38:17AM +0000, Kazuhiro Abe (Fujitsu) wrote:
> > > > > > On Mon, Oct 20, 2025 at 09:23:05PM +0800, Hanjun Guo wrote:
> > > > > > > On 2025/10/17 15:39, Kazuhiro Abe wrote:
> > > > > > > > AGDI has two types of signaling modes: SDEI and interrupt.
> > > > > > > > Currently, the AGDI driver only supports SDEI.
> > > > > > > > Therefore, add support for interrupt signaling mode The
> > > > > > > > interrupt vector is retrieved from the AGDI table, and call
> > > > > > > > panic function when an interrupt occurs.
> > > > > > > >
> > > > > > > > Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> > > > > > > > Signed-off-by: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>
> > > > > > > > ---
> > > > > > > > Hanjun, I have addressed all your comments.
> > > > > > > > Please review them.
> > > > > > > >
> > > > > > > > v3->v4
> > > > > > > >   - Add a comment to the flags member.
> > > > > > > >   - Fix agdi_interrupt_probe.
> > > > > > > >   - Fix agdi_interrupt_remove.
> > > > > > > >   - Add space in struct initializsation.
> > > > > > > >   - Delete curly braces.
> > > > > > >
> > > > > > > Looks good to me,
> > > > > > >
> > > > > > > Acked-by: Hanjun Guo <guohanjun@huawei.com>
> > > > > >
> > > > > > I wasn't cc'd on the original patch but I couldn't figure out why
> > > > > > it uses IRQF_NO_AUTOEN when requesting the irq given that the
> > > > > > first thing it does is enable it.
> > > > >
> > > > > I misunderstood the usage of request_irq and enable_irq.
> > > > > Since there's no need to separate them, I will remove IRQF_NO_AUTOEN
> > > > > and the enable_irq call, and send v5.
> > > >
> > > > I found out when calling request_nmi, removing IRQF_NO_AUTOEN results in an
> > > error (-EINVAL).
> > > > Therefore, I would like to keep IRQF_NO_AUTOEN specified.
> > > > If you have any comments on this version, please let me know.
> > >
> > > Could it be that this is just a bug in `request_nmi`? I see the following:
> > >
> > > if (!desc || (irq_settings_can_autoenable(desc) &&
> > >     !(irqflags & IRQF_NO_AUTOEN)) ||
> > >     !irq_settings_can_request(desc) ||
> > >     WARN_ON(irq_settings_is_per_cpu_devid(desc)) ||
> > >     !irq_supports_nmi(desc))
> > >         return -EINVAL;
> > >
> > > Perhaps there is just a missing `!` before `irq_settings_can_autoenable`.
> >
> > I tried this change without specifying NO_AUTOEN, but it resulted in an error.
> > __setup_irq succeeded, but irq_nmi_setup failed with -EINVAL.
> > I haven't investigated further beyond that point yet.
> 
> Thank you for trying, from reading the other commentary in the thread,
> I recognize now that that was a naive suggestion.
> 
> I think that this patch should go in as is then unless there are other
> concerns, because it seems like it is not possible and should not be
> possible to autoenable NMIs and that explains why the code does what
> it does to answer Will's original question.

Yes, I wasn't trying to derail this at all. I spotted something that
looked weird, it turns out that's how NMIs are enabled and if the
cleanest thing is to treat normal IRQs the same way then so be it.

Will

