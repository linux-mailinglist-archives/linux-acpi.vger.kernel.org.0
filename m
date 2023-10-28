Return-Path: <linux-acpi+bounces-1085-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8267DA78B
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Oct 2023 16:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A91A28207B
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Oct 2023 14:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A6C15AE0
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Oct 2023 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0ulZcON"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32B83C1E
	for <linux-acpi@vger.kernel.org>; Sat, 28 Oct 2023 13:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5E0C433C7;
	Sat, 28 Oct 2023 13:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698499867;
	bh=gBP3glv6afepKnA9zNUdSdOeKTh6qfPeOCMMmWtBx4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b0ulZcONzlSEoifyGuvkRsVAv8rLqkTCfQx6MiO31JSaQAHf9UdLfJ1EvfT7yxhx7
	 Ogpm8Q7mK2kaPa0WrGUBKPZm52+0/zWA2vCUQQXX51UNCRsSVP40zQ/iLHtbiEIfAS
	 VrjGmiWamBc+6TfE4je5gqsQ6Q8+03bowKUP9iiFbWNZdoi0DK4Dal/WWKFc0cQu+U
	 KhcIffIzhxeFmvXNbj1X9K0qmBT6+TtDznARqo8PILll7kqkgfeOw5H25wrI8cZBaj
	 Bm6uwnsTlXyPRD2lB9bmbhEEeWc/s4pShnpr7ILFFCXbqq26nk61zmQXsTmgqORs+v
	 8+Aoh3x8ybw9Q==
Date: Sat, 28 Oct 2023 15:31:02 +0200
From: Wolfram Sang <wsa@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Andi Shyti <andi.shyti@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/2] i2c: i801: Use new helper acpi_use_parent_companion
Message-ID: <ZT0NFgr7t+BbrlCn@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	linux-acpi@vger.kernel.org
References: <90bd1071-317e-4dfe-b94b-9bcee15d66c5@gmail.com>
 <6e935761-5b36-411a-ac82-cbc394bba7b6@gmail.com>
 <206f0f25-8a83-4e53-89fd-cbe025e5798d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VDhSQjZ5Lig59x0D"
Content-Disposition: inline
In-Reply-To: <206f0f25-8a83-4e53-89fd-cbe025e5798d@gmail.com>


--VDhSQjZ5Lig59x0D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 15, 2023 at 11:36:17PM +0200, Heiner Kallweit wrote:
> Use new helper acpi_use_parent_companion to simplify the code.
>=20
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied to for-next, thanks!


--VDhSQjZ5Lig59x0D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmU9DRYACgkQFA3kzBSg
KbZtHw//a+IW1Jk1egi/2k9E2jk9Y641xuC31yG3m+7nMwRlVTLmxKKqKNK62r9e
Eu10a9jQ2HAqfskXBvs7/XVBdZL1Ry4BNZH6OXFV0qjrN8yPHr5J2qA3DECfAWST
u1H1mEsjKwIQEmSeUYmbxmmyAkkIC3ZANfzrz2jpmnPnfCK0rmLRXhMRXK+LN9Im
JdXAuaApxEWSDjw1vY7Q8rmUhSjyFvFGcvIQWraxjCQ/sw+gpadeKgo53tpeeYUv
py7hUnD5ascPpm3YY26Kuo3/ii/kRBxSNvM4q7hdLyWD5vrtY7CsevtyYAx5D6jI
XnH49UF65DEq82yIo9W8LzcytoKi1ZX+yPPhpNY5otV1biT+uZjex2l2PybKdJFC
4PI3RqZtZ4jvpX7Pa9Qda5P/sitQPZLDJB4HWzOjkGA51ZlKHrH+e0GTlpoy8Y3/
rA1jUbjxtG6w+WthSke2YwWs4FXoGefBlafQ6FYQ5ppmWdyvk+7RRKsH08RR5ZN6
J58PwGfozPBDgrhVCu77DS0ObEn26qT+nA2XMAAFbEU7lUq6sRucM71fJWKkiY6p
DN9XN1m7EMZYqInXW0diCTtJsq7H3HlfhONDCBhMjEuyiUTd8B3txLtIxhDuDA57
bWYoR6sUdVezypO+4ZGFrKMw83acALM0ouyFQowTawU//FfrItg=
=tqrD
-----END PGP SIGNATURE-----

--VDhSQjZ5Lig59x0D--

