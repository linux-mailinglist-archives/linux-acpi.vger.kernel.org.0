Return-Path: <linux-acpi+bounces-19286-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2082C8A993
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Nov 2025 16:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 642A74E1836
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Nov 2025 15:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2579330B38;
	Wed, 26 Nov 2025 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="OnoMT1yy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375A9331239
	for <linux-acpi@vger.kernel.org>; Wed, 26 Nov 2025 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764170435; cv=none; b=G1gG3WnCdIovRmHxfZnFvNEDa9PiGDIeEAHSBqib/jWQvLtlRBuOulIymOEjLjERzMleWgktgsev0ATfeib7rvIV207tEvE28H/DTkftyoXBtum9vDu38QJ6SkDMoi/r7V7fSTzPkXj55PKYvdAxHURkQGhtOBhSrUSPnQUAzl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764170435; c=relaxed/simple;
	bh=nq+18yCbIjN68mfxCtnLnhRS2b0sgj7XPpMYAquaKsg=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JMNtecrHgLUNPv/51mUI2Jp9xbw8/JcDiXSoOk6xZrcnhStqfFf4+CA2tr8FPtWxL2hJxLA6hl3zNWzqz3mvrhRT2PgEYKrkAl2o0mvC+P4+Pk50LIvYz3tlN6yMfILRuFaTUlgU9LEmNbuthH4fmcuN6abSwg1tq+uZVFR9de0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=OnoMT1yy; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
	In-Reply-To:From:Subject:Cc:To:Message-Id:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=tNFEZumKHSYYIjyqtWd/gI3UClhLQ2SvutzdiZGuepw=; b=OnoMT1yyaMT9HykZkgkntvVSxT
	ClVwXJg3xXB+pdGyvp0fpSwF84msahykYup0omuKcsOIEW+J2pqT/9n5yGs9PpFIeNZsQl4xTwM/g
	hILyrhSDEthgAmCk+KOYc2kW72Xo9wIluxn8cYX8Y50nd3OQE6f22kwiRryQYSpTT6TBsPNN7olST
	m/NPiJBgeg8QDR4YFVH2s9JlC66lYaGHf+whp17jBbFD+4kAlrKfFT0PKFrlHVPHBb8W1KtZj1wag
	z/YXNoAox0y0pEWImOY4CBwFKBJdM7pZJlkkhyPbTJrT5lqv0qFtk4NTu/YqTH9mA35j6np9Y6qcK
	EK1BghCQ==;
Date: Wed, 26 Nov 2025 16:20:38 +0100 (CET)
Message-Id: <20251126.162038.2015308014407369467.rene@exactco.de>
To: rafael@kernel.org
Cc: linux-acpi@vger.kernel.org, ray.huang@amd.com, bp@alien8.de,
 x86@kernel.org, tglx@linutronix.de, superm1@kernel.org
Subject: Re: [PATCH] ACPI: processor_core: fix map_x2apic_id for amd-pstate
From: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
In-Reply-To: <CAJZ5v0jiZCxHJCXMXjBtQuPZzDzJyjYwBXTkq5Girj05CwxoNA@mail.gmail.com>
References: <20251125.182654.1292605389516841541.rene@exactco.de>
	<CAJZ5v0jiZCxHJCXMXjBtQuPZzDzJyjYwBXTkq5Girj05CwxoNA@mail.gmail.com>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi,

On Wed, 26 Nov 2025 13:19:30 +0100, "Rafael J. Wysocki" <rafael@kernel.org> wrote:

> In the first place, this is an x86 patch, so it would be good to CC
> the x86 list (CCed now).

Sorry I missed the list.

> > Fix amd-pstate w/ x2apic on am4 by removing the device_declaration
> > check in map_x2apic_id(), likewise.
> 
> It looks like on your system Processor statements have been used for
> declaring the CPUs in the ACPI namespace instead of processor device
> objects (which should have been used).  CPU declarations via Processor
> statements were deprecated in ACPI 6.0 that was released 10 years ago.
> They should not be used any more in any contemporary platform
> firmware.

Yes, I know. I tried to contact Asus multiple times, but never
received a reply nor did any BIOS update ever change this.

I only wanted to finally sent upstream what we shipped for years.

> This change goes a bit too far because some acpi_id values are only
> valid when the CPU is declared as a processor device.
> 
> Does the attached patch also fix the issue?

Yes, thanks. The only point of this -I guess- is to enforce vendors to
use the right declaration for big server boards? We better use <= 255
just in case? Will sent v2.

Thanks!
     René

-- 
René Rebe, ExactCODE GmbH, Berlin, Germany
https://exactco.de • https://t2linux.com • https://patreon.com/renerebe

