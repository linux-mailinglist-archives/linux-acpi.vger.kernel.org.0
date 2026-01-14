Return-Path: <linux-acpi+bounces-20320-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C11D1F576
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 15:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 803A130076A6
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 14:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FDD2D94A5;
	Wed, 14 Jan 2026 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="htk+x4Na"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BD7231829;
	Wed, 14 Jan 2026 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400180; cv=none; b=fh3aja0plzHBvsRzOHb/tH5X5xjqEP473PO3OUJ9LzXjzix9oWWXorcHaTazV4scSAMt1tIvnpKu+63CpKTpnqxyhBICSleC9S1BFjre3HbFIpiB6WfDIaWDkKPPrYDV0BIn1aqDCgS9XMzezQiznRNjD28TmLfU9b3anO48FQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400180; c=relaxed/simple;
	bh=Zk+X0U0nP+GtJI9b23g7B8znsodnQPS5UKylro1oFwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xzvx485fnRh2JGtEFiuptTHurs0GfvWU1eBPIToOL46OYfuPGOEHpW1n53ICgoo7UxJANeLDI7oOvZIyzwqxG8R9RCTQXEI9S4pihgaguxXdkujjdtZgnWvl+5Wn11eI2DW0jLlhJoL4+CKZSRU23tzCUNYzuhCSvZw7NBCvAOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=htk+x4Na reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 628C540E0194;
	Wed, 14 Jan 2026 14:16:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id U9i6nnOD5eUv; Wed, 14 Jan 2026 14:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1768400172; bh=VRoSE/2YTwFhEpBBl9wXpY8ydPU6I1xxtgwmqqKape0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=htk+x4Natx08his9bWPcyT1eRR2E8mDo6r0Ufv6M7oX9I1xf/5nuKcRZPOt5JxFil
	 0DvrlAz0d2fonr1AfsbmuosW50C8y8AmnD9ABkAVcz/irfYQKSMHS3Y9ltalVds6wU
	 DTuRZk1RmrxFdRMrSl+9eeEWHB+qnXrGlJIW18D40BH0Xy6VF5Du6dcAqHL/QItIOG
	 RhFxknDK9aKTwPtwPZsc81Qo0JEgFJCxA1h/UwnEh/jQkCQG/L+NJn8fXYLTBuk/W4
	 1VKxEB5pqHN7dp5Cq1iwvaQ+uh/YYx/6aGXFad82Mh4WYRT2IpNSty94gOwXqUgk88
	 iKFWzxUOws2xTDEzs8v7XzGbqOe+Rd6ucImcyNSW4ZQGj+KdtHAiOrbA+YGgScbR2t
	 QRL7tKqgCCIA+X48lHwrFW3P4rqDumjugBJINl8I0z+W59xVpbdlcDhJ7sg2om9sb/
	 Vg8KkN7bmGqZdrjoBMYFo9BhQESYLdHsRAMR4uvUmD7lK3Qrl/6CiaGP0QSHTxCdwJ
	 ql6xe/rslfuUVQk11RN3dRitXJxteJ/bvPvKYj3QndGFsiI8Z/9qcxMUg+EWW7qpZX
	 VtDCCiOy6v1ID7knmO7TX5qxIvsynDRvzdk0cPpkA4nPPz7chJwTdXHX3AZ2hHoj8I
	 Smbu6S3Z1aBrY+pY/st1NB+g=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 5C64E40E0280;
	Wed, 14 Jan 2026 14:15:58 +0000 (UTC)
Date: Wed, 14 Jan 2026 15:15:51 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ahmed Tiba <ahmed.tiba@arm.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
	tony.luck@intel.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
	linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com,
	Michael.Zhao2@arm.com
Subject: Re: [PATCH 00/12] ras: share firmware-first estatus handling
Message-ID: <20260114141551.GKaWelF-Gsvzr71LUs@fat_crate.local>
References: <20251221013534.GAaUdO5vWqMWAdbWbd@renoirsky.local>
 <20251229115440.2734800-1-ahmed.tiba@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251229115440.2734800-1-ahmed.tiba@arm.com>
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 11:54:36AM +0000, Ahmed Tiba wrote:
> By =E2=80=9Cerror status=E2=80=9D I=E2=80=99m referring to the UEFI CPE=
R Generic Error Status block,
> which is the standard firmware-produced error payload that Linux alread=
y

Standard, schmandard - a bunch of fw crap.

That's UEFI's understanding of a common platform error record, no?

So why is this a generic estatus and not part of CPER-something?

You're calling something "estatus" which sounds like a generic thing but =
it is
simply a subset of functionality you need to make it work on ARM without
ACPI and have packaged whatever you need under the name "estatus".

Why does this thing need to be called an "estatus core"?

I'd expect to see a compilation unit which contains shared functionality,=
 gets
linked to your stuff and that's it. No "fanfares", no CONFIG symbols, no
nothing.

> consumes via GHES on ACPI systems. I=E2=80=99m not introducing a new er=
ror model
> here; the intent is to reuse the existing CPER decoding and handling on=
ce
> that payload exists.

So why aren't you doing only that? Why are you doing all that extra stuff=
?

> The practical use case is firmware-first RAS platforms that emit CPER
> records but do not use ACPI/APEI GHES for discovery or notification. To=
day,
> those platforms either have to duplicate CPER parsing logic or miss out=
 on
> the common Linux RAS handling (standard logging, memory failure flow,
> vendor notification paths). As a result, the full firmware-first RAS
> pipeline effectively only works when CPER arrives through GHES.

Yah, got it.

But see above.

Please do not "over-design" this into a separate thing but simply carve o=
ut
the functionality and share it. And leave it where it belongs
- drivers/firmware/efi/ is not the right place as this isn't really EFI. =
This
is a piece of APEI/GHES crap you need.

Later, when there's need to make it more sophisticated, then we can talk
again.

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

