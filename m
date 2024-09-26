Return-Path: <linux-acpi+bounces-8447-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E18A9879F0
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 22:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5CC1C2332D
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 20:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C663515CD6E;
	Thu, 26 Sep 2024 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="IApVQb+v"
X-Original-To: linux-acpi@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEE3156F20;
	Thu, 26 Sep 2024 20:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727380867; cv=none; b=k/v8sqOrbyXknPYtMD+hr8OhDT1NZcT/0eu+tm34I8qzvrCAQSLg3waJWlOOH4PKCjEuajxeybxOVuNgWIYDUpF2ni+M9rxLMeIkC4HoNl8CXhdsmfhKEd/MFDNF4alzi8tkO6rWOmnymhBv/KW5Svv77rH1SzO3yhOmTozwYJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727380867; c=relaxed/simple;
	bh=UGCf3yxjAt8AuDOcgMoy9Vbqp9X/xI1Tg+E2drlH4nk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O4nJu6N/brtbP9YW0/VjYtTd6+beuEcesiH72Y5DSOKqF0F3j+vmXOic3GtibcqKOX1a17IkRIt90r8hUM8vtjXjmJcSgK98CEIaZhnUUUEn+15YFMsBDBaNRv2T8H4gkW5WGi1JVUxyuqYJJb+UH0468/xD5i6mSJtxtbr+clk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=IApVQb+v; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id CCEE21C00AD; Thu, 26 Sep 2024 22:01:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1727380860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=D4UbUO0tej9AOK7eZBZSNSMI5jgpZCCCKDGtS2cPF40=;
	b=IApVQb+vM6H02sv7yFxL0VUlLkE6/ElpsOOQ15ErVh0JwvZRJvdoyeKcR6A5Ug1kPIJzPA
	y2pYC+Ewmj7tJxMZ/ax7+cCAdML6PVcJS/QEfd+Nj4w4bnLfA7+IHT2zFqnaDWJBrCZED+
	xcX5tHrS/VyRM61aUcXi01Cvz/ep0tQ=
Date: Thu, 26 Sep 2024 22:00:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rafael@kernel.org>, linux@leemhuis.info
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Bricked Thinkpad x220 with 6.12-rc0
Message-ID: <ZvW9e8qBiAT5e0Ke@amd.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+0sdFMlwSRUPcF/U"
Content-Disposition: inline


--+0sdFMlwSRUPcF/U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

So I thought I'd help testing 6.12-rc0, and now my machine seems to be
a brick (help! :-) ).

I had one -rc0 booted. It hung after few days of use, so I rebooted
into newer -rc0. I believe I let it suspend.

When I returned, it failed to wake on USB keypress, and power button
was black. I hit power button, and it started pulsating. I believe I
tried 4 second powerdown, but no.

Ok, that should be easy, right? Battery was already removed, so I
removed power, reconnected power... but no.

When I press power button, it starts producing some noise (hdd
spinning up), but power light goes pulsating, not on, and I stare at
black screen.

I removed everything, let it sit for a while, but behaviour was the
same. I'm now letting machine "cool" with everything removed,
but... It seems EC is very confused.

Should I try removing CMOS battery?

Is there some magic combination I can hold during boot?

Any other ideas?

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--+0sdFMlwSRUPcF/U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZvW9ewAKCRAw5/Bqldv6
8pVfAJ4uWkoYOW9cSsqUuUw6/sYbfa8mrgCfZUkhVxbXR0Sq8SJarwlT1hEAu2U=
=X/9I
-----END PGP SIGNATURE-----

--+0sdFMlwSRUPcF/U--

