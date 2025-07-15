Return-Path: <linux-acpi+bounces-15161-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2FEB057D6
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jul 2025 12:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9655F7AE554
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jul 2025 10:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C043B26D4D9;
	Tue, 15 Jul 2025 10:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kfByKl+f"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED8E28F4;
	Tue, 15 Jul 2025 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752575511; cv=none; b=HBpJmDerT9Ea1aEjygD9VEZaOgpFEjwsgsbRVjHf4W3eRFFLYwzPaqA0m+V+Uj6vZzg9b4h/1fsxBeFCLFLpHgTbDlFuyYefsQnkCWnKuzjrZ/r+uNIYr7xlzhgpbe8rsevuDyWcyiP/Q3IT9yCwoyapP+8KQIIxh7rTWPOtk1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752575511; c=relaxed/simple;
	bh=XebkX95wcEKQnKte28NcMhjW/zd225Us26tVO6Iz2YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uY/+coKr/1L0XenEGq6n/xyI0Br7vFNsis2vfeZckgnXGBJzGB/hOYlFmqmt13zJUx+3pbQcaSz33le0cWyCGHfxBWbH3zeL5K73jBq+WD1CnYuG5xqoQuLSzV1UbtcLG69vjI6aqVtmaJBN4d/a4OeEoOlbrCs9QB2gQITtuOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kfByKl+f reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1980C40E0215;
	Tue, 15 Jul 2025 10:31:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id A0infUpuRe_C; Tue, 15 Jul 2025 10:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752575501; bh=ZeK8/hSot3trf3uPAOW7h8n9eMuR+wJSK+K8dpRpwsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kfByKl+fmWuix5Vv24mjwKVc86RjZOUmh9GhJJYI3yPOuMuWniu4tH28ISiX3+4xR
	 MAnrZIHXA4EFe/jWk7QjeMrJWJBPi6idZtBsmzsrkPuO/1YcJ0UfWNMA8pOG9V0i6q
	 U+WRh/oXcM/GMwyvNZsC4pUEiSwX7cfa3pUxdNIXPZD8mgNLbWZSQGFif7Y7fz6YB5
	 2m5D/FtieT2nFvL6ATZtoPtrIUZiHZZ9ZwJCWT19k9EU561sLQXC9g7SIePc8nObpq
	 BHCjAnACm14AoUiGSDoBGfiQta4sLRmWQXNb5ONL+3/oPDuerufjrBUnzAHF0szKQe
	 Kefy79TfX/Oiri7gEkSrrKSJz+ehQf7zEJaWCvtzlZMkuXntYe7X5bK+sulXYXzCS6
	 bK8od/W9eLd9l7E4pRYos8G43WRAqNKd988TJidlT4TCU4PNiOui/MUJUOXhWNdfvT
	 yMQUkx8X6cHSC3VCXlbV2PO7iJHSr7Hz/l9O5TgpTTTuUvJQ56G8YoS5cZHh/FVKsl
	 mAzOTGYmUtrSzsxfCuHiq6EqFo5sgQAlPVNNkFjNYAgqoDPfUEypZCaPY4RcL/8Fpg
	 l8BLOJNZJl/VvP4DruiU+wb+a1Yhlr0KaYt9MW3dz7nt+fIHfkOSQEL+6wTBuLtvAc
	 X4oY9veU7HsV5PsFgopNdph8=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0D28240E015D;
	Tue, 15 Jul 2025 10:31:31 +0000 (UTC)
Date: Tue, 15 Jul 2025 12:31:25 +0200
From: Borislav Petkov <bp@alien8.de>
To: Breno Leitao <leitao@debian.org>
Cc: "Luck, Tony" <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	"Moore, Robert" <robert.moore@intel.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [PATCH] ghes: Track number of recovered hardware errors
Message-ID: <20250715103125.GFaHYt_TnFQW6ti0ST@fat_crate.local>
References: <20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org>
 <20250714171040.GOaHU6EKH2xxSZFnZd@fat_crate.local>
 <SJ1PR11MB6083C38E6DA922E05E1748D6FC54A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250714173556.GQaHU__LL6IUIPCDIW@fat_crate.local>
 <aHWC-J851eaHa_Au@agluck-desk3>
 <20250715082939.GAaHYRc3Yn49jyvYzc@fat_crate.local>
 <kyprjdilgyz3xgw3slnrsemptnpp6h75mipv6a3lgp2dmwqekg@s7azbepy7nu2>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <kyprjdilgyz3xgw3slnrsemptnpp6h75mipv6a3lgp2dmwqekg@s7azbepy7nu2>
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 03:20:35AM -0700, Breno Leitao wrote:
> For instance, If every investigation (as you suggested above) take just
> a couple of minutes, there simply wouldn=E2=80=99t be enough hours in t=
he day,
> even working 24x7, to keep up with the volume.

Well, first of all, it would help considerably if you put the use case in=
 the
commit message.

Then, are you saying that when examining kernel crashes, you don't look a=
t
dmesg in the core file?

I find that hard to believe.

Because if you do look at dmesg and if you would grep it for hw errors - =
we do
log those if desired, AFAIR - you don't need anything new.

I'd say...

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

