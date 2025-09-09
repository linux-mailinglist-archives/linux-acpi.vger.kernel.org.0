Return-Path: <linux-acpi+bounces-16526-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D6DB4A8CB
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 11:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA04F1BC5F7A
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 09:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB34331283E;
	Tue,  9 Sep 2025 09:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ncEC6C4M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0yAilcN6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6700330FC08;
	Tue,  9 Sep 2025 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411140; cv=none; b=jhSKICIpNpVzqSJM2gcoA1itPDg6C0UybdKSK7ct9WN0+4iFhUPOK2VLFIpSEW94hd4+ispe7XJIXKjca45ZeWRSHKVrEYAS+bgcLFBkQL9lAYlWAfPgQdFhEE70LQLlxoqf4WLovzHBb6XNsnvfi9DwayIGGWgoGY7/HQ69+QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411140; c=relaxed/simple;
	bh=AJ6bobPKNuxc2pD/YZQNi4iuDg8twlzwv/v9QN7VAQg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n4IiQn3VLZwM1kBB2AYzCyk2jJnA5bfTsYxZi2WfAATobpesQuIA+SxcRoyyZVNGxNKxoMWcz4NPtWp5HYzNt3rOgTW9puL+++sJIoe9PIecisxuOu5tiLyHMz9f5tphPXQa0HJlnRUmML1O8WZXgtUcUabPkLJG1vuYkocC8SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ncEC6C4M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0yAilcN6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757411137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T9rMoXP/QSewckjQCrhDlmtmRGislqHzoJn2eC5EdZQ=;
	b=ncEC6C4M7MYGcs0VyDvSLd33omVS67MIT3m5ZkKIo+MO101yrk6yRna3TBb4mCzLhjLCWm
	2oKicf0VKU5XHVm0LHC8a7XRLBnNIX9yWeWf5PiPiY794tW+ScUevbOL9MJzf+9r8bIvSP
	AgKHe2lNIZU5tHY9/4LZnefGCpKVw3OsyKZSJEixnOFfKFhQ/u8xWN02fA+lZDC7DyfqWi
	PDRVfbP0sEsWqBPzG8FcaTsoC1dwJBH7PZKh5Ozer5E3R/ijX5uCwR8B4TNIuABPVKafyf
	AwdAb/pf17NRiUhDFsg3h0LpAo2/ldpSeM6fciDHlrFEs80i1wKu2l+VF26JDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757411137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T9rMoXP/QSewckjQCrhDlmtmRGislqHzoJn2eC5EdZQ=;
	b=0yAilcN6MbUxoWFzSDsuXfOFuwbjv7OcDJek+tCR08gD6uzz3zYNDYYGl5rZOfbXFmVr/Y
	LSHj9f2fNlkvNvCw==
To: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sven Peter <sven@kernel.org>, Janne Grunau
 <j@jannau.net>, Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark
 <james.clark@linaro.org>
Subject: Re: [PATCH 14/25] genirq: Update request_percpu_nmi() to take an
 affinity
In-Reply-To: <20250908163127.2462948-15-maz@kernel.org>
References: <20250908163127.2462948-1-maz@kernel.org>
 <20250908163127.2462948-15-maz@kernel.org>
Date: Tue, 09 Sep 2025 11:45:36 +0200
Message-ID: <877by8vu0v.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 08 2025 at 17:31, Marc Zyngier wrote:
> @@ -2564,13 +2566,14 @@ int request_percpu_nmi(unsigned int irq, irq_handler_t handler,
>  	    !irq_supports_nmi(desc))
>  		return -EINVAL;
>  
> -	/* The line cannot already be NMI */
> -	if (irq_is_nmi(desc))
> +	/* The line cannot be NMI already if the new request covers all CPUs */
> +	if (irq_is_nmi(desc) &&
> +	    (!affinity || cpumask_equal(affinity, cpu_possible_mask)))
>  		return -EINVAL;

This check looks odd. What makes sure that the affinities do not
overlap?

Thanks,

        tglx

