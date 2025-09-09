Return-Path: <linux-acpi+bounces-16524-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C5BB4A839
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 11:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8E8166595
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 09:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C182773CC;
	Tue,  9 Sep 2025 09:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4RZcLOwS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bolmjk5C"
X-Original-To: linux-acpi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928EC1A9FA8;
	Tue,  9 Sep 2025 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757410678; cv=none; b=ed9jbj02Xg7IrbQWNGZ8GTiy7+LpBwCjwrDfkvqrTy3/s8FWbDpZ6mM8NF4Bsit+krAz+/Wng9kv+Zfzira7THg1xXRLJ3pUOTTvVM5YTj1QJjFdn19/DVtShLX2f6wbSByfiKaG28MnkpH+Ou+fFyw06/EzuH5xHsELjUNnjlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757410678; c=relaxed/simple;
	bh=finoHdL4lrkhdPFvo33p8a/mRKGbGiB2KKqwRehKIQU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XB1evqnG+IPq33bL/twIqrAeCPoXbarxrM5hPsv3kKc/8ii2Ko236foMwHYCsXd0ymnuje1AsvE493HGqZ1bBy2Ztf1hb2lp63xytwQkiZTirIlFaDhdlUu2HLXPfElgCmDGbJ0mZid/9CTHJ05rgelM8QJcV9u/6vH5y1EndeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4RZcLOwS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bolmjk5C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757410674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FSTU+fJf1O70Krquo94BQr87mP330EiEN0RcNsxUleY=;
	b=4RZcLOwSb0dmMv7B4YHDkIz+KhtTeqOpwNyLPsmp7bbSbNRkWVJYNJoMRj5EusMidYuTk6
	2Han6ZN0s63gFtEpHK5IyAeeoKpfIXuEenu6Cdi8gsNGnETzKEN5iSRBd+ujNmyMatrLlZ
	z0ofAPcjvu3B/zwbwZBjQRPLBZq0gr7k8IfnV5tOuCYSXDg9uZK+hui0GCmKM3F1gRZX7g
	zXY+kYp0OHaYDucktcGj37sTsWLpi/didas+BztC2AzTLIoXBEGcFxA+yDDOPWcjx2hB0E
	WpUdm4AS/TqIlzOpa0TtjaHzQxiWPKXNQrM1bmc8TVApWcPEymw7SSYFq0f3AA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757410674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FSTU+fJf1O70Krquo94BQr87mP330EiEN0RcNsxUleY=;
	b=Bolmjk5CYkbrGuV/Whi0VUccKJmYKPo5FEZxsosf6RGKHWJnsi852ieh0QCDXtOFmCdIyh
	qXIzDCxFMzPrMYDw==
To: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sven Peter <sven@kernel.org>, Janne Grunau
 <j@jannau.net>, Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark
 <james.clark@linaro.org>
Subject: Re: [PATCH 05/25] irqchip/gic-v3: Add FW info retrieval support
In-Reply-To: <20250908163127.2462948-6-maz@kernel.org>
References: <20250908163127.2462948-1-maz@kernel.org>
 <20250908163127.2462948-6-maz@kernel.org>
Date: Tue, 09 Sep 2025 11:37:53 +0200
Message-ID: <87cy80vudq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 08 2025 at 17:31, Marc Zyngier wrote:
> +static int gic_irq_get_info(struct irq_fwspec_info *info)
> +{
> +	struct irq_fwspec *fwspec = &info->fwspec;
> +	const struct cpumask *mask = NULL;
> +
> +	info->flags = 0;
> +	info->affinity = NULL;

:)

> +	/* ACPI is not capable of describing PPI affinity -- yet */
> +	if (!is_of_node(fwspec->fwnode))
> +		goto out;

'goto out' to return 0? Seriously?

> +	/* If the specifier provides an affinity, use it */
> +	if (fwspec->param_count == 4 && fwspec->param[3]) {
> +		struct fwnode_handle *fw;
> +
> +		switch (fwspec->param[0]) {
> +		case 1:			/* PPI */
> +		case 3:			/* EPPI */
> +			break;
> +		default:
> +			goto out;
> +		}
> +
> +		fw = of_node_to_fwnode(of_find_node_by_phandle(fwspec->param[3]));
> +		if (!fw)
> +			goto out;
> +
> +		for (int i = 0; i < gic_data.nr_parts; i++) {
> +			if (gic_data.parts[i].partition_id == fw) {
> +				mask = &gic_data.parts[i].mask;
> +				break;
> +			}
> +		}
> +
> +		if (!mask)
> +			goto out;
> +	} else {
> +		mask = cpu_possible_mask;
> +	}
> +
> +	info->affinity = mask;
> +	info->flags = (IRQ_FWSPEC_INFO_FWSPEC_VALID |
> +		       IRQ_FWSPEC_INFO_AFFINITY_VALID);

It's not really clear to me what the purpose
ofIRQ_FWSPEC_INFO_FWSPEC_VALID is. That firmware spec was handed in by
the caller, so it should be valid no matter what, no? 

Thanks,

        tglx

