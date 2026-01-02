Return-Path: <linux-acpi+bounces-19937-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DBFCEF709
	for <lists+linux-acpi@lfdr.de>; Fri, 02 Jan 2026 23:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E205300EE79
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jan 2026 22:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6723B2D837E;
	Fri,  2 Jan 2026 22:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="Gop3DCjz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524FE22F772;
	Fri,  2 Jan 2026 22:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767393663; cv=none; b=YdLXPpchaTsSNjefefFxWiLLDNI7AZTqu/en601jWo1MR4xcXOPG/tQlQxSOAt+s0Ni7gWuo9qFUeFaWuQdLh9TFLeIjqWXvYZg3YaS1iJK7iWA9We61GMrhhRU+ChbrdxpMrT5ch+OJ2nLBpG/Z71Yt/lyxrV3gBfz4WWH8YAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767393663; c=relaxed/simple;
	bh=SZ2FJKEbdJsCIL6jv9aNHAhPwnmQcsP0c2Q9qhVbvwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNXtAmNZyfbSRY5LA59eyuQdu5MvlDCSuVWSCPos0xzkkhUv7Mr0STT4CYom0mgLa+oT7HnRMko0otdR2dp4bPXDYK9Cc2W0FU1HiHoPSbOqbqZkKMO4GZzI+qILyAUcw+8Xz0G7/hIj1lK3LFsqQmA7nWXs2sAsBskaPNSH7Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=Gop3DCjz; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E5D101C01B5; Fri,  2 Jan 2026 23:40:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1767393656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=74FoWfHJsSpgcmzt7S2Iv6lmGbI+FLkCUy2agBMwDpU=;
	b=Gop3DCjzMwq4H0VyNRTxo5wCxfyklRYzVezvTQEn0zayHaeWFjxK6VkmEUOjq/HekOvBYt
	vMkth1CHmDpaepscmdpj2HoT/eB4Lbm7Omh1HB0XmeymjW6LhAKzv8bV3GLrXq8dTfQXWK
	U4XilMX2dKNMadKrif1Wqh9TWx9Q43Q=
Date: Fri, 2 Jan 2026 23:40:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-input@vger.kernel.org, kernel@collabora.com,
	superm1@kernel.org
Subject: Re: [PATCH 0/4] PM: Hibernate: Add hibernation cancellation support
Message-ID: <aVhJeJ93EbF8BEp+@duo.ucw.cz>
References: <20251107184438.1328717-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DFRgtCiQLehrnEn0"
Content-Disposition: inline
In-Reply-To: <20251107184438.1328717-1-usama.anjum@collabora.com>


--DFRgtCiQLehrnEn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On a normal laptop/PC, the hibernation takes 15-20 seconds which is
> considerable time. Once hibernation is triggered from command line or by
> some GUI option, the hibernation cannot be cancelled until completed.
> Its not a blocker, but poor user experience.

In-kernel hibernation is basic and simple. It is not great, and not
designed to be great.

You can do fancy progress bars, cancellations and probably better
encryption in userspace.

Documentation/power/swsusp.rst

Best regards,
								Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, Netanyahu and Musk!

--DFRgtCiQLehrnEn0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaVhJeAAKCRAw5/Bqldv6
8mqPAJ9RBaNB2vPr1ude6eyzLoxzx57bAgCfS6UiXMgA/bfJ7dnLgTY25VvAikQ=
=V1KT
-----END PGP SIGNATURE-----

--DFRgtCiQLehrnEn0--

