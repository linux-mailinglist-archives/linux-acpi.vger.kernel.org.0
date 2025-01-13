Return-Path: <linux-acpi+bounces-10579-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22282A0C47F
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 23:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFAB43A3D13
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 22:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F7F1FA27C;
	Mon, 13 Jan 2025 22:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="lPmgb6EL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1635C1F9421;
	Mon, 13 Jan 2025 22:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736806657; cv=none; b=phbW14Qsge9nyAM0j8hQ4CW0fu1qE5ZuEMaaGcLuSVbo7krGIj87EeFMUVQCnjWPVsTmPvdLtubrNgmF0r3HN8wU8aj/Ynu6J2s9/OlUz9qySgfyZRnMMpygho2ks2zjFH+KfDcjUFuJPvq7rCL8CPRydwMG3NnsAMGKTHBNzfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736806657; c=relaxed/simple;
	bh=Ley5R3jaIIBE3Gs5cys2Z18hBudkOLdGEnS8/2LsEV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsxZPVWSlqOaI4NIFCPcuA55WYwWJtgHbVyfhNLNdqRkhjoTxpu0tSmWLNgaInsV5szM4GNLUxbl6SG9M3U1jUtPx6tubeYHaSE8eCUXSTGJT1hWcvz9eilsXmUXJEbrSf369Sz1bEHGEMrY+fXhc06EVXPhSvsriJtjKciv3qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=lPmgb6EL; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2B3811C00A0; Mon, 13 Jan 2025 23:17:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1736806646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=40e4dl5AT4Mj7ttnAivyVKP9TPNoDuXexUMhilR/FrU=;
	b=lPmgb6ELPQWGSAGqjWEg994HeiQrl9xr4KyHTDiWKjWzdItTktyJVhBxuHGYl7Pwg9NpQd
	nQtkvoAstB/Ph9QYFy4OjhknOZ2HzJwkTj5dDDvZo8B8Bd7e+N0L1MiqdRlIYHRVowfwkn
	/nKt9JvTeYUCtvZj+ghEFAB9jARAWKo=
Date: Mon, 13 Jan 2025 23:17:25 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>, rui.zhang@intel.com,
	Hans de Goede <hdegoede@redhat.com>, Armin Wolf <W_Armin@gmx.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	platform-driver-x86@vger.kernel.org
Subject: Re: Thermal driver with safeguards
Message-ID: <Z4WQ9XasbW6VuU1A@duo.ucw.cz>
References: <41483e2b-361b-4b84-88a7-24fc1eaae745@tuxedocomputers.com>
 <2d24e844-242b-4c1e-9e43-f0bec1a98ed5@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dkseR5wI3M9+p6zb"
Content-Disposition: inline
In-Reply-To: <2d24e844-242b-4c1e-9e43-f0bec1a98ed5@tuxedocomputers.com>


--dkseR5wI3M9+p6zb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > given a pair of a temperature sensor and a fan, I want to implement a
> > driver. that allows userspace to directly control the fan if it wants
> > to. But have a minimum fan speed when certain high temperatures are
> > reached to avoid crashes or hardware damage.
> >=20
> > e.g.
> >=20
> > - temperature of target die is 80=B0C -> fan speed must be at least 30%
> >=20
> > - temperature of target die is 90=B0C -> fan speed must be at least 40%
> >=20
> > - temperature of target die is 105=B0C -> fan speed must be 100%
> >=20
> > - temperature of target die is 110=B0C -> device shuts off to protect t=
he hardware
> >=20
> > Would the thermal subsystem be the right place for this to implement
> > this protection in driver?

Best place to implement this would be hardware... It should
self-protect.

Next best place is embedded controller.

Yes, kernel can probably do that, too, but then you risk running "hot"
when kernel panics, when someone boots 2.16 kernel, or DOS or ...

Best regards,

								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--dkseR5wI3M9+p6zb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ4WQ9QAKCRAw5/Bqldv6
8s6zAJ0dAUkg89a/BA6zOWIW+ir7oTxOsACfcQRVvy5vpGKrfdu6oz+FgJJBLTs=
=zG6l
-----END PGP SIGNATURE-----

--dkseR5wI3M9+p6zb--

