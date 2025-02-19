Return-Path: <linux-acpi+bounces-11327-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79652A3C9E2
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 21:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425A1189DF12
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 20:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6555F23F262;
	Wed, 19 Feb 2025 20:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jhZQutJ+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1591B393D;
	Wed, 19 Feb 2025 20:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997072; cv=none; b=ZS/AGa+Db/c70LR84tCL0yqO3uwBUZlp6Vh2AXV9OeWzVgym86x+LAEZhyRhd3gxWb2Zi/EEi/71tamTrQsnDftxHkDSLOO7b2xuh7UXbSFJju1RgkK+OUDKU2aS/UjFocJ6UVXy6hXZd1YoPSfoaFH3Gksj5KR/4jCe/wtjJoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997072; c=relaxed/simple;
	bh=W4azDLkDiwBTrihwDksA0pWoXqaTH0WlElItmz2xVmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOlP4gn5Qb6ibhZV8sG3GBcxh7Z+lVGRtLr6BsbIcdSgrNN0VVgP3WTHaf+Ev9SRzsnrzTmkVVoVedtwMq1c1fz4/XuQx2+NJZpfsbQ2JU9uSmUQzEZFZWq9SqsNBwYza9VTQdT91BvWavbQQWdjdoGdXxV3tcxww8ypGxDLHX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jhZQutJ+; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ECF2E40E015D;
	Wed, 19 Feb 2025 20:31:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id unM9zs4ln9tY; Wed, 19 Feb 2025 20:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739997061; bh=kp1oT2W838eKIVFMU4ld+U/sKEoFPsgJksw8L1EP32M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jhZQutJ+C8XpbRvePMuUHuspU/o9D7qmOQ7L59v7dhDXOiAPmeHUDV2VaLhDPqlOG
	 /aN/ZKr7Ne5zN2TS2Ay7ebA+X32+ww82+yw7AAwsh5v9rIxFrWyGmYupxGREDjl4dp
	 ywc3JdIzUHtUpmcFO9G2j9tEJsuAfyu6bn3Pi/Mc2LliZrvVErSFIw+/Rtyh93k1BU
	 7XjoKhgKr57kfib1WKTrvGuFwtELOcxqZuoAa9F9Z+0FGlEPBZHOduHKrPmhvd1sse
	 nFQFHb7SuXbbuM8yNwiGMyfZ+7S147UgBlU19C5xWpxsnXUGhITUacj0rVabBDWyqD
	 n1CcuQjYe5baL7gLyuIfCz9L96Mim1afjkvBh7QOZNzO0iCcOMHnuCU5rFXy/azwP9
	 3vtn2AuNmpEs7GX2VfxyDYDS9XdV9a5fTT/c4Q6b94eimfM190AUFC3TGEqooQaMaT
	 zgG97HynjfC+yC9Myqc+t1ThWmKF1333TTMoMj6qSkL2HmY9c0d0+pwV4X6KmAv2zf
	 LmakqGhTMJ2PKTj37S50hNlL0Y9XLO1Y4g3fN6flDdmCAoB8+Mep9ioVEkvavJKDIP
	 IUEbHUxuppOnnvS3zXuCBW7dW7s6O+C5D9kxS7rfal8bghqqqEZZHb6kDlQKJ1ZAuA
	 NkLRtqoGg8hjMPj/s1M0XGHo=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BF2DB40E015F;
	Wed, 19 Feb 2025 20:30:45 +0000 (UTC)
Date: Wed, 19 Feb 2025 21:30:39 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ruidong Tian <tianruidong@linux.alibaba.com>
Cc: catalin.marinas@arm.com, will@kernel.org, lpieralisi@kernel.org,
	guohanjun@huawei.com, sudeep.holla@arm.com,
	xueshuai@linux.alibaba.com, baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
	lenb@kernel.org, tony.luck@intel.com, yazen.ghannam@amd.com
Subject: Re: [PATCH v3 0/5] ARM Error Source Table V2 Support
Message-ID: <20250219203039.GQZ7Y_b2xE6GZo5pQv@fat_crate.local>
References: <20250115084228.107573-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250115084228.107573-1-tianruidong@linux.alibaba.com>

On Wed, Jan 15, 2025 at 04:42:23PM +0800, Ruidong Tian wrote:
> AEST provides a mechanism for hardware to directly notify Kernel to
> handle RAS errors through interrupts, which is also known as Kernel-first
> mode.

Kernel first? Srsly? No? Oh.

https://www.youtube.com/watch?v=pFjSDM6D500

So what, folks realized finally that firmware-first is simply a stinking pile,
after a decade or so.

> AEST's Advantage
> ========================
> 
> 1. AEST uses EL1 interrupts to report CE/DE, making it more lightweight
>    than GHES (the Firmware First solution on Arm).

ROTFL.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

