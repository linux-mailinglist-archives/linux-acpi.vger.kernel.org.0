Return-Path: <linux-acpi+bounces-16583-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDBBB51AB6
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 17:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42D7564D55
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 14:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29999341AA1;
	Wed, 10 Sep 2025 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BTscDZbO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gLeMKV+z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370A323F294;
	Wed, 10 Sep 2025 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515632; cv=none; b=iC4c0g0JFuTCA60V/qqE5E3hrRkygAPx7V/J4wZKvhd2marIW8h0x4ox4yU+UrWXNMKjkrKumCRKQxvdZMnr3Mp7ubV7rxBopSSXbIOLXFSqfm4/gSY7vqQ4xkQCylaVSqPNNa8bLRWUQQUfuLkhVWN9AfVgqdiqrkbe0+99P9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515632; c=relaxed/simple;
	bh=cx/cLzMdFwxZEfUZV5dGxlW5/VM8KOo9COoO8ANF8ms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N+0ALR/Dn7v/s7ISu+mqng8JCTt31HP5vdGl6sDUuPrj+i3gBKGJNSYnbOxZNDu78NZN1Slqm+/jK8LhWS1FlwuCyIuEaXIVgc6Lvecd9xp9AQQzcrrYtw53fSc9OjFdLp2F+zM0wPVVMYR2z+JvQO84DQESCbT+3kwiNtbvSVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BTscDZbO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gLeMKV+z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757515622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cx/cLzMdFwxZEfUZV5dGxlW5/VM8KOo9COoO8ANF8ms=;
	b=BTscDZbOpxt/U2TKqJdaOr1GCip/McoA8ZI8h8ly6noV7+Dd2N4nXQGhCwb+4YddUR0xLk
	WpzaV1D3GQYd84DvI+PvWHyomaCOhP3vxBTKqnkW34MnWocKFq4/V6sRzTfD0h/HcuaTc0
	1aHxiQ1dY776Y8FLU4rEv1sJV/OELPo1U1ws7aEaxXrAm8BTX7RXCX1M3PlX3WHGPhJm6t
	GxqvcxGqUn27vgi02Ezw8K+SQBJwg9NKFHL/yEiGPiwpZzJbqFvGflO5pgcIIMZvOLZBqg
	IeOvgQqeUOYzQXuKoYThKPZjBFD2UFY3gu5D0Za9rD0KSwdjcOsRTQ0/iFSHwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757515622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cx/cLzMdFwxZEfUZV5dGxlW5/VM8KOo9COoO8ANF8ms=;
	b=gLeMKV+z5z7Eu3gocJslS196gaSHl3jMqoNzqO7evhJrjr8gHcw6/xN7fF/Y5RfwJHuWMZ
	k8IiifZXielclmDg==
To: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sven Peter <sven@kernel.org>, Janne Grunau
 <j@jannau.net>, Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark
 <james.clark@linaro.org>
Subject: Re: [PATCH 15/25] genirq: Allow per-cpu interrupt sharing for
 non-overlapping affinities
In-Reply-To: <86ecsed84s.wl-maz@kernel.org>
References: <20250908163127.2462948-1-maz@kernel.org>
 <20250908163127.2462948-16-maz@kernel.org> <86ecsed84s.wl-maz@kernel.org>
Date: Wed, 10 Sep 2025 16:47:01 +0200
Message-ID: <87h5xatlei.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 10 2025 at 09:28, Marc Zyngier wrote:
> On Mon, 08 Sep 2025 17:31:17 +0100,
> As Will points out off the list, the above lacks the a similar
> handling for percpu_devid NMIs, leading to NMIs that are only handled
> on the first affinity group.
>
> It's easy enough to move the above to common code and share it with
> handle_percpu_devid_fasteoi_nmi(), but at this point there is hardly
> any difference with handle_percpu_devid_irq().
>
> Any objection to simply killing the NMI version?

Removing code is always appreciated :)

