Return-Path: <linux-acpi+bounces-18802-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F29E0C5187B
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 11:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B8474F909C
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 09:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637092FFDE4;
	Wed, 12 Nov 2025 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THXlsGbF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0122FFDE0;
	Wed, 12 Nov 2025 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762941028; cv=none; b=de6/GxKzQt05ObQAOyzQpnGInJw/0hStdkB2NryoJcbRFPZHWtVVxGtcH2HEh+NW6b3VmhPI+PYGJarVWOPUXQJNyrNV8DAmYwrhtv+zqOmdTtkWOFAgW1FRoPKKUXzfjxG4m3mwoY5CtFmYSnvP8kUM9L6muo9IoUCMBYc+bU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762941028; c=relaxed/simple;
	bh=wKkYTwbaHODjzCytHEFDqnL5g4JxssRcsrQb6AjyIG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8XrxaaQ8OQxhXHF+qBUbqo9T7Tk605KnWJqcEYvMizxmxJlDSsrcMQ0Zg0MtmzHafmkH1hBgejFr1+Tc83V2wMXOssWc1ON+aW8fqwgbjuGkRLW1ThhNS/LkTC97gKzUe2B64JOVe85+PQqGyTOsellI/jB+AsU3QaJtlG+Hpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THXlsGbF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0C7C4CEF8;
	Wed, 12 Nov 2025 09:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762941027;
	bh=wKkYTwbaHODjzCytHEFDqnL5g4JxssRcsrQb6AjyIG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=THXlsGbFErwUFo1wXBwnqtZVc6BeYn6L2UE7CtZWfMJ4+KHQIlHtuc0TildUHh9Ob
	 lbTpx2tKz/MJDGXzxMH3yv/POWUQ2aqZzG7HA94ie+/hvHaVTkNs0qr3mkXqf8MUl6
	 3xQrouYjCT1oIZFDzLeMNz2k5X4HgsMojIK8wtRmO6zaaZSfFJSKTvA/atntB+Nvce
	 UTg4ZNmTK0FKQW5hAT0TVEXQQv998uAJgquRdnYwTccyPWKJ4vmwWzDuutaq7NLM3K
	 yO9dpZI9D2EUC6PxhSTPniAIx6r42xtWyAYBzgMBzkGIU3Q09/XJ3yR3XEsaBgw3Vc
	 GTO/aG2ppFgmw==
Date: Wed, 12 Nov 2025 10:50:19 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Charles Mirabile <cmirabil@redhat.com>
Cc: fj1078ii@fujitsu.com, catalin.marinas@arm.com, fj2767dz@fujitsu.com,
	guohanjun@huawei.com, ilkka@os.amperecomputing.com, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, rafael@kernel.org,
	sudeep.holla@arm.com, will@kernel.org, tglx@linutronix.de,
	maz@kernel.org
Subject: Re: [PATCH v4] ACPI: AGDI: Add interrupt signaling mode support
Message-ID: <aRRYW7UK7PWb6cpS@lpieralisi>
References: <OSAPR01MB7669F9B9E145A50B38819E13D5CEA@OSAPR01MB7669.jpnprd01.prod.outlook.com>
 <20251112044239.4049011-1-cmirabil@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251112044239.4049011-1-cmirabil@redhat.com>

[+cc Thomas, Marc]

On Tue, Nov 11, 2025 at 11:42:37PM -0500, Charles Mirabile wrote:
> Hi All—
> 
> On Mon, Nov 10, 2025 at 07:38:17AM +0000, Kazuhiro Abe (Fujitsu) wrote:
> > Hi Will,
> > 
> > > Hi Will,
> > > 
> > > > [You don't often get email from will@kernel.org. Learn why this is
> > > > important at https://aka.ms/LearnAboutSenderIdentification ]
> > > >
> > > > On Mon, Oct 20, 2025 at 09:23:05PM +0800, Hanjun Guo wrote:
> > > > > On 2025/10/17 15:39, Kazuhiro Abe wrote:
> > > > > > AGDI has two types of signaling modes: SDEI and interrupt.
> > > > > > Currently, the AGDI driver only supports SDEI.
> > > > > > Therefore, add support for interrupt signaling mode The interrupt
> > > > > > vector is retrieved from the AGDI table, and call panic function
> > > > > > when an interrupt occurs.
> > > > > >
> > > > > > Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> > > > > > Signed-off-by: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>
> > > > > > ---
> > > > > > Hanjun, I have addressed all your comments.
> > > > > > Please review them.
> > > > > >
> > > > > > v3->v4
> > > > > >   - Add a comment to the flags member.
> > > > > >   - Fix agdi_interrupt_probe.
> > > > > >   - Fix agdi_interrupt_remove.
> > > > > >   - Add space in struct initializsation.
> > > > > >   - Delete curly braces.
> > > > >
> > > > > Looks good to me,
> > > > >
> > > > > Acked-by: Hanjun Guo <guohanjun@huawei.com>
> > > >
> > > > I wasn't cc'd on the original patch but I couldn't figure out why it
> > > > uses IRQF_NO_AUTOEN when requesting the irq given that the first thing
> > > > it does is enable it.
> > > 
> > > I misunderstood the usage of request_irq and enable_irq.
> > > Since there's no need to separate them, I will remove IRQF_NO_AUTOEN and the
> > > enable_irq call, and send v5.
> > 
> > I found out when calling request_nmi, removing IRQF_NO_AUTOEN results in an error (-EINVAL).
> > Therefore, I would like to keep IRQF_NO_AUTOEN specified.
> > If you have any comments on this version, please let me know.
> 
> Could it be that this is just a bug in `request_nmi`? I see the following:
> 
> if (!desc || (irq_settings_can_autoenable(desc) &&
>     !(irqflags & IRQF_NO_AUTOEN)) ||
>     !irq_settings_can_request(desc) ||
>     WARN_ON(irq_settings_is_per_cpu_devid(desc)) ||
>     !irq_supports_nmi(desc))
> 	return -EINVAL;
> 
> Perhaps there is just a missing `!` before `irq_settings_can_autoenable`.
> 
> As far as I can tell it has always been wrong - git blame points me to the
> original commit where that code was introduced:
> 
> b525903c254da ("genirq: Provide basic NMI management for interrupt lines")

I don't think that's the right rationale (and I can't claim to understand
it fully either - that's why I added Thomas/Marc in CC).

As per b525903c254da - IIUC NMI must not be autoenable-capable -
enable/disable must be done using enable_nmi/disable_nmi_nosync explicitly.

cbe16f35bee6 ("genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()")
added the logic checking the IRQF_NO_AUTOEN flag to request_nmi().

Now, AFAICS irq_settings_can_autoenable(desc) returns true in this
specific case - the IRQ is a GICv3 SPI.

First question is - before commit cbe16f35bee6, how request_nmi() could
have possibly succeeded - irq_settings_can_autoenable() would return
true and request_nmi() would have failed.

Come cbe16f35bee6:

if (!desc || (irq_settings_can_autoenable(desc) && !(irqflags & IRQF_NO_AUTOEN)) ||
	!irq_settings_can_request(desc) ||
	WARN_ON(irq_settings_is_per_cpu_devid(desc)) ||
	!irq_supports_nmi(desc))
		return -EINVAL;

Now the check passes _if_ you pass in irqflags IRQF_NO_AUTOEN.

I agree with Will that's a bit counterintuitive - maybe we can force
the irqdesc to be NOAUTOEN in request_nmi() directly ?

Thomas and Marc know better so that's where I stop.

Thanks,
Lorenzo

> I looked and the only two callers are using `IRQF_NO_AUTOEN` so I guess it
> just hasn't been noticed yet.
> 
> Happy to send a patch to fix it.
> 
> > 
> > Best Regards,
> > Kazuhiro Abe
> > 
> > > 
> > > Best Regards,
> > > Kazuhiro Abe
> > > 
> > > >
> > > > Will
> 
> Best—Charlie
> 

