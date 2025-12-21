Return-Path: <linux-acpi+bounces-19737-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E331CD399E
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Dec 2025 02:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 441E7300DC9F
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Dec 2025 01:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703FA1E1A17;
	Sun, 21 Dec 2025 01:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XDMU0oYJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840F31925BC;
	Sun, 21 Dec 2025 01:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766280980; cv=none; b=E9cvhcX9uWB4GCXe+PcEqd64btBR3XGh3utEJHVPapLbWb9oLQMagYzIG8x1logIZDYHIhN/L47Cj41THr81vQgZqy8b9JH78Oe7jPwuKw8s45j806GHVje4bNF2hL6UEcN3tV6I+tHsSMxAd0gLxTvif3PAvkFkDGxWDjQdpJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766280980; c=relaxed/simple;
	bh=cTDDwgLD4HNSLH1/6xskLOhEMN3ylhPn/oZKOEJNegc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhdfeFg62YAKC5D1n8yRPV0TD5FsSOj4sKanj5qlz9DleLnEHo+QGkpi9Pg9eTxTcvcI0X9k5dswL9E1hGI3B0cA1AxK6JLLbOuJs2OVLze1BFhNgyAd7Z+Sxbk+ZdR3cQdXMmLOu/ODPpvTIv0Cj7b5aXvlpWPeK9dKVOEJLmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XDMU0oYJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 707F540E015A;
	Sun, 21 Dec 2025 01:36:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id s9plmLMQekvx; Sun, 21 Dec 2025 01:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1766280960; bh=u3fK9PcG+cgEjukRqBJXMkL2CRTOlA5j9EObKIvbhrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XDMU0oYJVL787+ElQKmC+FBYUENoOXT7WeKGnB5oHGThYKBdTQ3AWqFIpVeSlGb78
	 xABcw2DZyhYbf0DNMDX8LBOBBf0kUobVThFiz0BU7eY5ymF5hdIUGUhKprVH/GhZaI
	 fBn5sdN/L5HMHYyfMb8ZjxuR403+kdLyLyEeJlHR7aRkxLncNS8o+fbtSAizQ4jnvp
	 2NGF9Ri/iJi6JSN5v0yz4jQyOCg2F715zXcB/cGnMONRs1dfS5805agDsVOETNbl6M
	 tEDH45KyuHHjp5xy9YeQIZVcxpOldEWRBh6IheN9QXpKdVrelSM3k+AkEN3+UkzrJp
	 RFTpwhqlYYsVM6nAfsBgUGEdeX9ozBkIk+S3Tf15S/s787d8mkP7JyQNCgiQVYjIfG
	 PN5yurEZQKN87fmViypq1c4kXEfE/wp9wddBIElgG5C+jMGvQNqIx2xllazc4Aa8LR
	 rrgyvbZAfyekehmwY0pFUeLNREbwWPq+ZxqocshUnODjC1PXOzcI9Ias7cnImY994j
	 f86pHV80AOSexaDPR82Fe2NYzMAZMDCXtfHh45c/Vv0hRfm+HebHSjmN9yh77Bko9x
	 mVnvX2XW+6JQd1F7RetdYPxXXf6Cx97NYU22+l2rUV3lwWj1rcofWBuT4BhShnu1RP
	 c8N+BImz9MTUY6Pj1h72mk5Q=
Received: from rn.tnic (unknown [160.86.253.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 4886740E0163;
	Sun, 21 Dec 2025 01:35:44 +0000 (UTC)
Date: Sun, 21 Dec 2025 02:35:34 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ahmed Tiba <ahmed.tiba@arm.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
	tony.luck@intel.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
	linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com,
	Michael.Zhao2@arm.com
Subject: Re: [PATCH 00/12] ras: share firmware-first estatus handling
Message-ID: <20251221013534.GAaUdO5vWqMWAdbWbd@renoirsky.local>
References: <20251217112845.1814119-1-ahmed.tiba@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251217112845.1814119-1-ahmed.tiba@arm.com>

On Wed, Dec 17, 2025 at 11:28:33AM +0000, Ahmed Tiba wrote:
> Platforms that rely on firmware-first RAS today only get the full Linux
> handling pipeline when the records arrive through ACPI/APEI GHES. This
> series lifts the generic parts of GHES into a reusable estatus core, wires

Why is this thing called "error status"?

Why is error status so significant so that you need to call it a thing,
much less a "core"?

It looks like you basically want to dump error records from a system
which doesn't support GHES into the common path so they get decoded?

I mean, I'm only guessing because I don't get any wiser from this text.

So how about you give the high-level, practical use spiel first? What's
the use case?

Then we can talk implementation details.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

