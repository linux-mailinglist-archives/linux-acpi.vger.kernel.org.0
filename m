Return-Path: <linux-acpi+bounces-16525-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A12B4A8AE
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 11:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4521B2215E
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 09:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C75C2D24A0;
	Tue,  9 Sep 2025 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qvIrj3JI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/FYUewtT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8392D2498;
	Tue,  9 Sep 2025 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757410909; cv=none; b=P8aQlFeGG+nNI1Gax8+W72Q3ZkIiMg/cNnYlqrU0DGRkfLE++sfzEMj8HCBxLZvNTP8tHDOK7Hq1peMWtktUR8SM38oyCuv2FRKXtzjlZLUg7s82N/ijNvpsrd2HyLWUDVdvAnoKcPixuRkwRuX9tRMvxAHbp3cMxgZQQJHryAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757410909; c=relaxed/simple;
	bh=DgRLN925Gj+0vB9V4E+9yVd+JBTDFjjqanWtQbb6VX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dmY2SY1mqxGH13lzLayDINRsrNyB2KtTL45bBOKi3X28pKgCqP8IIMMbQWRQkSvfPhKV31U2E+0Bg90OIcx7widgSTSmIkqmZBKXexkP7irZ9H+voEtxnURjtgD2v4d6td4cM/KI/d8ePjOhcms1hUejZ1Qh4tVQwyPxcdpaLsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qvIrj3JI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/FYUewtT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757410905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vQIVnV0YzVXO6tmmGMhC+lDkzjuD/leVXqK9pC6E4D0=;
	b=qvIrj3JI/3eqkUwq6c7mN250yjGhwbss1V4PWDI42NO5zsdvHD2Px1NRtkqPlEIjgBwMFb
	vQev/Q2LW8Qp2bNeRphhOfJHoH3h2un+pdCt9RxfC+4Ed6YB7wpH48XJDndcdnMntJ1yFj
	kilGhrrnBQmjtEerSJEmoAb06/56VDdHbIq5U16yEErKkLWh1kOau7gNJHVyrMffSOMlxJ
	WGafxpsB9DqdLwmJjizjhCqZ5BFt+6jN+yuaYCqRiNdyiXo1cCR5h0OHb07YgzGLpv571d
	/1azegSeCqeBr2R63/2dfI+0DDySVTggpIid98nHwcsFgPqCgXrBcyv7ZO5qwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757410905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vQIVnV0YzVXO6tmmGMhC+lDkzjuD/leVXqK9pC6E4D0=;
	b=/FYUewtTPcwOHupZnyoV+0oOE5Qc5NLcJmsTOEecyy0ww+II071SyAt6Jz4zdM0VnyZsu2
	4eCRUK+q4d41yLAQ==
To: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sven Peter <sven@kernel.org>, Janne Grunau
 <j@jannau.net>, Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark
 <james.clark@linaro.org>
Subject: Re: [PATCH 12/25] genirq: Factor-in percpu irqaction creation
In-Reply-To: <20250908163127.2462948-13-maz@kernel.org>
References: <20250908163127.2462948-1-maz@kernel.org>
 <20250908163127.2462948-13-maz@kernel.org>
Date: Tue, 09 Sep 2025 11:41:44 +0200
Message-ID: <87a534vu7b.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 08 2025 at 17:31, Marc Zyngier wrote:
>  
> +static
> +struct irqaction *create_percpu_irqaction(irq_handler_t handler,
> +					  unsigned long flags,
> +					  const char *devname,
> +					  void __percpu *dev_id)

static struct irqaction *create_percpu_irqaction(irq_handler_t handler, unsigned long flags,
						 const char *devname, void __percpu *dev_id)
{

No?


> +{
> +	struct irqaction *action;
> +
> +	action = kzalloc(sizeof(struct irqaction), GFP_KERNEL);

	struct irqaction *action = kzalloc(sizeof(*action),.....;
> -	action = kzalloc(sizeof(struct irqaction), GFP_KERNEL);
> +	action = create_percpu_irqaction(handler,
> +					 IRQF_NO_THREAD | IRQF_NOBALANCING,
> +					 name, dev_id);

Please get rid of these artifical line breaks. You have 100 characters.

Thanks,

        tglx

