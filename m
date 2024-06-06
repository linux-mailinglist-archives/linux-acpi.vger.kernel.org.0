Return-Path: <linux-acpi+bounces-6210-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9181C8FDB26
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 02:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A7D7B21D10
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 00:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFBC38D;
	Thu,  6 Jun 2024 00:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="wntv7k8S"
X-Original-To: linux-acpi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FE4364;
	Thu,  6 Jun 2024 00:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717632453; cv=none; b=jAmnpkoKqtj0g8tqoA0CLC/7kWH6cqbnYPAFNTzZPgfn/2Ttgmau5HXWAfpRxeLlE7qCIIqRfN8fT2lJl+2zs0YYfXlHY+B/0ByNz9zOfLbye16PI3roQq8IIz6Y2DJal1rzyjM8O5mNCxIR9T2X4sROxyKu+xjYNEuZsPS45IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717632453; c=relaxed/simple;
	bh=HTGnDlVg14busy09uFE1RwMMDVeW7zepOGPbVzb22lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZifajysTKL4DUi4fVbQ4UkAKMlco1yXPhBLu6HV1FWbhxNBAnxPoOum+wj2f5SjVYRQJoA68fZl2xqH9Q70Zv1nmpf1C4Eug8EMoUoNiOh5qQ3RgtUvqEhxO42mm6DYeKeMxJxtPAoXQrrrCnuV2rPFpqcFzSZgvrrbDXCGQD9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=wntv7k8S; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717632449;
	bh=HTGnDlVg14busy09uFE1RwMMDVeW7zepOGPbVzb22lQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wntv7k8SU7Cjvzy7fmO3fbAeEUIIKr/6rzXqwz/SrLoc5JOTBtA26crHqcg0LB/QN
	 PMRT6b4X5fcBLkmneVihaqX0BCY74kSLtluox3LwWgT9kBrfv5lzG8FlZBRgOcfD6e
	 B9u6TblodH4BFsP6jhxwOP3IJZEPt6R7agEuAdOBz3T7bWOS8qOeHfSg0POU9XONkT
	 bpdEH25wLQHeYW2ZMUDdp6fCeXOD3iUuucywa06bB3c+jE16E746XpKePQ9bV80DDZ
	 KNKwYcpQY6UttongPf0ALeMjvt6c9oD8cMVDUm/ztOclDuSiX72PaCABqSAw0zdj+e
	 VX7UtRQ+GKh5g==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1823837821B7;
	Thu,  6 Jun 2024 00:07:29 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 8CECD1060501; Thu, 06 Jun 2024 02:07:28 +0200 (CEST)
Date: Thu, 6 Jun 2024 02:07:28 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Asmaa Mnebhi <asmaa@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 1/1] power: reset: pwr-mlxbf: support graceful shutdown
Message-ID: <j6nkeh6wyonjuwfznhanfx7i6tpxaxr2tlxami3punkukoslnx@l7w73vgebguw>
References: <20240429204519.1618-1-asmaa@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6txz7zmbt2uenzzr"
Content-Disposition: inline
In-Reply-To: <20240429204519.1618-1-asmaa@nvidia.com>


--6txz7zmbt2uenzzr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Apr 29, 2024 at 04:45:19PM -0400, Asmaa Mnebhi wrote:
> Replace the low power mode with a graceful shutdown.

That's a summary of what the code changes, but the commit
description is missing an important information. It's not
obvious why this change is needed. Especially considering
the past of this driver: It started with

reset => emergency reset
low power => poweroff HID event

Then got changed to

reset => reset HID event
low power => poweroff HID event

And now is further changed to

reset => reset HID event
low power => emergency poweroff

I don't think it's sensible to continue this ping pong, so please
properly describe what those IRQs are for and why further changes
are needed.

Greetings,

-- Sebastian

--6txz7zmbt2uenzzr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmZg/bwACgkQ2O7X88g7
+pqa4Q//Ym5unYKwJvokdgmR//dfoEOOeLD5c8aj7Ptvz5ofr8Qw6yk8Cklxu2UV
rngEmHy4hfpNN340sQ9hTvlFkVFU4xRueYWA3suk/NAzPI41m1lbbnP0pfYqJ4gA
XrUwO3kWDFpjLmeaAVIkhWupAtTbjoFmRN6tVWNL5kjZAZrmn3K0TQj/zME3kFRm
/iqNJ5n8pgk6YylsjVKEfIsCxguDbp4NOb9yOQIrrUyHTEF2irbo2Wkn0QWfxbwf
d+Vf3oe/p59BTyyjH2gZ1YxrkxEXIl17G/s95XhSYpgWs5lhFLGEI72FDA9cbP+H
tfFqw3PmVlTNMFN8w0yAvDMEjT380UOXF2eec0DJiqy+H6cS5Wi/k4cQUAY3PaD5
JUTvnwiXsF78S57HYqnqTZnyMzxoCtfOdAsheOi3eQwdCoCESNdf7fIg5bZ9RGtR
fX4H5eODEC0QH/FUEWevYIduM77xKSzC0UQM/yK9Rye90zyl1Um2tXN4mfj5A+gA
pYgrSNEP6fNlWVoggWwg6ck90uX5DKpsXRcjxASg2jAggINQ+VrW0TUWn3CTTqIj
ryb7EjFJ1uSOqZaEVqxU8bgCYNcUZJ5yQwjMHIzY7gCmPITnF2h18V/m8sJMvWsZ
6hZvhXmKYgptmjpep6Cqg6K145/UFWqZRlsDMYB+GroljEK1moM=
=pJhW
-----END PGP SIGNATURE-----

--6txz7zmbt2uenzzr--

