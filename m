Return-Path: <linux-acpi+bounces-20443-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4H94CcdqcGkVXwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20443-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 06:57:27 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9562051C9F
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 06:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F409960B4E7
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 11:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7B141C301;
	Tue, 20 Jan 2026 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QJw+RVEC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601F0421892;
	Tue, 20 Jan 2026 11:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768907742; cv=none; b=V6rGomeKsHwLgcje6hLDvc4jby6gWHeovSXWfMhEPoRoLi+/qOjuiKF/UikMKJVBcuW+HU+J6rTm6T9k9qAUDSGxeLBvZyexBo8+DQdRm4vl6CXcTfrqPcnF8fgpLgZ8RORsfxoVskMtIxTINT30MGevZjoSji4Kj+UYQgKcq9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768907742; c=relaxed/simple;
	bh=JwisfVkKO4Z3FpwUNlvf3Cbw1xDvv2iEO5bqk5bBeCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYh+koa9sgyevdgzL21Plfrg6zD1QbJjqazpvhUkc8YtFcdqHLLxg62cEq8D0LUpW4JV4/o9/+60KjbeMtbmngD8xU9YT1ZTTo6po5A83U9jXjDzTgcpin014smNyT2XvgcUKAOznH8AcR8uOTSO2fdXEwmM5L8bmj5qkK6gefc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QJw+RVEC; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7199C40E0281;
	Tue, 20 Jan 2026 11:15:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fFjED6RZL-lM; Tue, 20 Jan 2026 11:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1768907730; bh=mBvyFQuCshmJ3cwSs+iBUFdLtp7nh3PV7P2ugBf4G88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QJw+RVECP6474Z9cwnRQGBFv8sIk9xEMcHs4PCqMOUshWVcXgh1mGxVFayiYt2fJU
	 eNYOSPBgcBeAgyReMkkDtu7lDihOkorQe4FUa98gHynKy9tGbToHOIuBPLZukB/tj6
	 6r4oJjQu9sOeLiMlXfHXGewjHRLvyjwiGzhNLSkFPmN7sUhHhxjtQPM0yrXCwXhHVd
	 iWGuqYVtK78Y0cRmoyDJG9Cv01CGcoMSMDOrFw4dADlnjMF7oCVgXyRpMAbhzOG/hq
	 Esq04zqEy2Zu5YrvmxwlO+KcaREy6Kpmut1oGRtHKNDtEccmH8bkcfTisf8MClvz4c
	 6NCHWGEXr9OtuynPNfZv8JhNxDWqUh85cEq0NJn2K1ARIjqpid8uhO8MT7IYIjnG8T
	 jAIwJ+Ru7XsdwVk9vptU2Pxd9Y46JEoMKtTaW07A4H2ylEwEdZqD9lu+m0WbSvGEup
	 +MNT+Inm5j4hQO1nWyPfA9VLthy2QBEnoUQ0uX5fb5Wh8tVcLJY3v54M5R+UMCQJva
	 7UDxdiMItyeuNLCKzULsjsXkUJmSR2QnQxy1THgfaj8fGQgShD+yVrqbMfdGr4SJjB
	 VbxKe5F5k/aZqkahc3I2g64Wk0FkxDYScDW00cxNsy99hbgVLLOz21UDlpl+4ZI6zm
	 2k5tV0YS9O70NRnieMr4FyfA=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id DB45E40E0268;
	Tue, 20 Jan 2026 11:15:15 +0000 (UTC)
Date: Tue, 20 Jan 2026 12:15:09 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ahmed Tiba <ahmed.tiba@arm.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
	tony.luck@intel.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
	linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com,
	Michael.Zhao2@arm.com
Subject: Re: [PATCH 00/12] ras: share firmware-first estatus handling
Message-ID: <20260120111509.GAaW9jvTirZhL_pHTT@fat_crate.local>
References: <20251221013534.GAaUdO5vWqMWAdbWbd@renoirsky.local>
 <20251229115440.2734800-1-ahmed.tiba@arm.com>
 <20260114141551.GKaWelF-Gsvzr71LUs@fat_crate.local>
 <dc2f3dd7-b9db-4a2d-b431-f70738cefcfd@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dc2f3dd7-b9db-4a2d-b431-f70738cefcfd@arm.com>
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20443-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[alien8.de,none];
	DKIM_TRACE(0.00)[alien8.de:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,alien8.de:dkim,fat_crate.local:mid]
X-Rspamd-Queue-Id: 9562051C9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Jan 15, 2026 at 12:17:17PM +0000, Ahmed Tiba wrote:
> In drivers/acpi/apei/ghes.c, this subset of CPER handling
> is already implemented using a number of helpers mostly named
> estatus_* rather than cper_*.

Which helpers are those?

$ git grep -Ei "\Westatus_" drivers/acpi/apei/ghes.c

doesn't give me a single one. Maybe I can't grep.

> The naming therefore originates from the existing GHES implementation, not
> from a new abstraction.

And even if, calling it a "estatus core" and making it a separate thing is
just confusing and unnecessary.

> What I did was lift that existing estatus_* logic so it can be reused by a
> non-ACPI provider, rather than duplicating the CPER handling
> in a parallel DT path.

Nothing wrong with that as long as you simply export common helpers and we
agree on how they're going to be shared. We do stuff like that all the time.

> Because the DT-based path still needs a clean way to call into the shared
> logic without dragging in ACPI plumbing.

Yes, carve them out in a separate compilation unit and select it in your DT
glue and that's it. No need for a Kconfig item and calling it a "core" bla.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

