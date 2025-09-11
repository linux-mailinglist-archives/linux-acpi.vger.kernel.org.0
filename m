Return-Path: <linux-acpi+bounces-16686-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3243B53827
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 17:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D961173E8A
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 15:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598E934F46C;
	Thu, 11 Sep 2025 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gv/J/Im1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8EyvGHyL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A974E322A3B;
	Thu, 11 Sep 2025 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757605786; cv=none; b=tUOM0LsfjYV8FoC5EIZA6EuUUnzcymZ9Twh/3wTE21g4TxPu33S7atMvp9Nr55K2Dqobp95iLaz3Yq1fQRs4M4+izO751cCO0jftdpPB2QlGzYsQtkroXAGxAVzgp3+CpcrR9kZ+8alN2tbLwDjHj8CijxdiVzPTrqZZd7MVU2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757605786; c=relaxed/simple;
	bh=dWoVgwSzzjiPdlwDeA7V1SLJtm8SzcHG/efD+5uBOG8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WUG2Tg1bSytefhegj2AVPhOzV6dHCblfj7Zh1JZk5n3R4MnNiYQq/MNtlrcIwOqhW5IqSTEZcJgmw/h5zuK3fOIXPlDP8SeZeSne5eEsGeHoPQQ8D5BctdDSNKzyCn3Z9jRVBW6TZrOwaUAKr/45nvL6/h+nsWs0aPdTe/FFO1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gv/J/Im1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8EyvGHyL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757605777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UuMEMPuykm7rNGqGRgSYCtjd+uJaJUQH41mpXqr8O2w=;
	b=Gv/J/Im1CRWyw9bIl8PD4nIFLIoBpCCDS8ViJW4a1/U8I1LoLfawuDNMYSQQJlnOXxL6xn
	OuskPZs1HqkU7fAUh+M5SxMFwGSCzu+glLIkiXNQ9BTxWi41a/3yDUGqqQzW6hvqvGbvxG
	qqnkM3cXBzd2JtesOHC+5f38VhyJIX0E+XXO/TZJ+Y019OxsWqkvmMq1sTaT+J+emzLMSu
	lXyTfsY2TjF8eVgy9PTZjs1z/FVVLvPTwNZve1qcbXRjwIhL7QuK85235FlipsXxtccsCT
	0UahOuRi7w9ZhLffoDRzXhra4do0Uac7YnvaUZnecJLnUSplJHaJ7KH8hv2DMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757605777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UuMEMPuykm7rNGqGRgSYCtjd+uJaJUQH41mpXqr8O2w=;
	b=8EyvGHyLQfWvch9vyXZ0F+oYN8ZCmX7LrZq8smIyrF3OFyBr/PeUHLTanMneSn8D2Sylym
	y8TAWPkIKCXiKnDQ==
To: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Will
 Deacon <will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob
 Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Sven Peter <sven@kernel.org>,
 Janne Grunau <j@jannau.net>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 James Clark <james.clark@linaro.org>
Subject: Re: [PATCH 01/25] irqdomain: Add firmware info reporting interface
In-Reply-To: <86a531cc1q.wl-maz@kernel.org>
References: <20250908163127.2462948-1-maz@kernel.org>
 <20250908163127.2462948-2-maz@kernel.org> <87ikhsvvau.ffs@tglx>
 <86a531cc1q.wl-maz@kernel.org>
Date: Thu, 11 Sep 2025 17:49:36 +0200
Message-ID: <877by5rnu7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 11 2025 at 15:13, Marc Zyngier wrote:

> On Tue, 09 Sep 2025 10:18:01 +0100,
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> 
>> On Mon, Sep 08 2025 at 17:31, Marc Zyngier wrote:
>
> [...]
>
>> > @@ -69,6 +90,8 @@ void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
>> >   * @translate:	Given @fwspec, decode the hardware irq number (@out_hwirq) and
>> >   *		linux irq type value (@out_type). This is a generalised @xlate
>> >   *		(over struct irq_fwspec) and is preferred if provided.
>> > + * @get_info: Given @info, report additional firmware-provided information.
>> > + *            Optional.
>> 
>> get_info() is pretty generic. Can we have some more descriptive name for
>> that? Also please keep the tabular formatting of the doc intact.
>
> Would get_fwspec_info() be descriptive enough?

I think so

