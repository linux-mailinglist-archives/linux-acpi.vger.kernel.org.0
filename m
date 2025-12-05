Return-Path: <linux-acpi+bounces-19441-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0DFCA7C6E
	for <lists+linux-acpi@lfdr.de>; Fri, 05 Dec 2025 14:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBC6E300ACE0
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Dec 2025 13:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AF232D7D9;
	Fri,  5 Dec 2025 13:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="ZCahyJqW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFF32192F5;
	Fri,  5 Dec 2025 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764941697; cv=none; b=q0SUTjNQnxgZPLN8VA2zLKt3nz0oMSxRDi2koOhclSFAKIm7+hoSKnV6B/Vs2Y6PqR8NndBFKvK2n3xTl746aKHKDeZoskdtAUHr/5lR2wItC9qLNplGIy4Ff0UPKLKBzgCRM7sWw1VJqMho1enNzfIHnhkmiHQ245x9L/p2vBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764941697; c=relaxed/simple;
	bh=m3hfaKQK1uO2lNMHM+UqMtvAMFIUX5Xw/Jt6ld1qzjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGcvRLgKI24ipioJy8gEbdgFlJaNnVp4RL7QNwuODJDmYxjnAPVxRDDeejvqE+ojmdGrWb3MkiRGrq8JDo7BPSzzgWpL1mUxeCgPFG1YAgjGeBflICX79T7WESUOc/6L5eIwrZMMC1BavAz62C8QLxU6RJrSeK1H7Lq8fy2QZ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=ZCahyJqW; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E6B3E1C008F; Fri,  5 Dec 2025 14:34:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1764941683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RIPfVUnMaYa0Y7gDoNdysIjTwTAo3rqn7Aaj+hkwZF0=;
	b=ZCahyJqWFSjMQJA53FHieEk54PvrmyXe53jQMmtZ5ztVdPwx5jFA5seEdcrq06RkBmvDRh
	43PmDj6P32ewWKyy41yRvGAjsXXGxzChlsskPZ8m40Hb6R6Zg2TCy0eaL9uqNGt8AcqZxo
	YjRaVShSXycnaZjUJH3roPbkw5381Gw=
Date: Fri, 5 Dec 2025 14:34:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Mario Limonciello <superm1@kernel.org>,
	Robert Beckett <bob.beckett@collabora.com>,
	linux-acpi@vger.kernel.org, kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Xaver Hugl <xaver.hugl@gmail.com>,
	Richard Hughes <richard@hughsie.com>,
	William Jon McCann <mccann@jhu.edu>,
	"Jaap A . Haitsma" <jaap@haitsma.org>,
	Benjamin Canou <bookeldor@gmail.com>,
	Bastien Nocera <hadess@hadess.net>,
	systemd-devel@lists.freedesktop.org,
	Lennart Poettering <lennart@poettering.net>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: Re: [RFC PATCH v1 0/1] ACPI: s2idle: Add /sys/power/lps0_screen_off
Message-ID: <aTLfc+NT/OVUR/vZ@duo.ucw.cz>
References: <20251202043416.2310677-1-dmitry.osipenko@collabora.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YsO1h4ynmPO1LIsy"
Content-Disposition: inline
In-Reply-To: <20251202043416.2310677-1-dmitry.osipenko@collabora.com>


--YsO1h4ynmPO1LIsy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Introduce the `/sys/power/lps0_screen_off` sysfs interface, enabling
> userspace control over ACPI LPS0 Display Off/On notifications [1].
>=20
> These notifications are a part of a Modern Standby [2]. The Display Off
> notification signals the firmware when all displays (physical and remote)
> are off, allowing it to enter lower power states that makes device pretend
> it has been suspended while the system remains operational.

What is "remote" display? Remote desktop? ssh connection?

This needs better name. If it enables powersaving in exchange for
100msec latency, for example, it should say that. I'm pretty sure it
will be useful elsewhere, and all the world is not ACPI.

BR,
								Pavel

--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, Netanyahu and Musk!

--YsO1h4ynmPO1LIsy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaTLfcwAKCRAw5/Bqldv6
8nScAJ9SIQK2U6Xnz9Cqp/YUM+oGP9NKlACfaF2dwcHce973GrS41NYV40jKocA=
=7/YZ
-----END PGP SIGNATURE-----

--YsO1h4ynmPO1LIsy--

