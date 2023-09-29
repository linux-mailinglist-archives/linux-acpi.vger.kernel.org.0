Return-Path: <linux-acpi+bounces-283-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A9E7B2DD6
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 10:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 948311C20B0D
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 08:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1411170E
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 08:31:26 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBC2399
	for <linux-acpi@vger.kernel.org>; Fri, 29 Sep 2023 07:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4810AC433C8;
	Fri, 29 Sep 2023 07:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695972830;
	bh=g8FdDsQ1Zwr/ZjQDd8aYwCZmir6Os4Zbdr9LrVxV5eE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=le2Q3iNmRMuu2aDm/1gAb/Nkpjw+t2NGDgUoPMGdqB0TJGttAXFoEfwAnW0klPrEq
	 JZq4Hyu8LmDTkOX4B0BRIYmVUAvnL1hVdgzQEKRjRUEGbqkB1A0vFIlAbN/l6sLRC0
	 9E27r9drR8gvvqf6aT3lwP8KZeio0rmvnFO0F+zqjMYB364xECxc/6mxhRIWTrdJNj
	 8PxUQ94htfAYs5PgSjTxHZ2FvSl3NNC+42Uvlp0ZoScSlplJdYa5mIpuxnmeMRtoY4
	 8NQFPv2S3dXvLUJjfOeSoxSDDS3NjZJuDrw+fA1CLUtwQVkTBi2OtFkcVtWwQ+4LRC
	 WQwAER+pJ851w==
Date: Fri, 29 Sep 2023 09:33:47 +0200
From: Wolfram Sang <wsa@kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v2 2/4] i2c: xgene-slimpro: Migrate to use generic PCC
 shmem related macros
Message-ID: <ZRZ92ybPW7ZDQzjK@ninjato>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Huisong Li <lihuisong@huawei.com>
References: <20230927-pcc_defines-v2-0-0b8ffeaef2e5@arm.com>
 <20230927-pcc_defines-v2-2-0b8ffeaef2e5@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TVdwXygprCc3G6Ue"
Content-Disposition: inline
In-Reply-To: <20230927-pcc_defines-v2-2-0b8ffeaef2e5@arm.com>


--TVdwXygprCc3G6Ue
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 05:26:11PM +0100, Sudeep Holla wrote:
> Use the newly defined common and generic PCC shared memory region
> related macros in this driver to replace the locally defined ones.
>=20
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Wolfram Sang <wsa@kernel.org>


--TVdwXygprCc3G6Ue
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmUWfdsACgkQFA3kzBSg
KbZplQ/+PVjCOoJkwOjw4nUeBPAQv+KSkSaAkd4kTFssbOe4SIrdF7Gp4mT9Rb6Z
SH7kSKG+CtxL6kpFC0cPDTG7NzS1FFkOJCwCkEvPiF0LNBx0D3vqijVeFFk75ObG
cHpbwGjh5J8mOcQ1YMcjdImqMR4bdWC3PlT5eZI9WHbs5Y+/sjUtXFSjNggx7H2u
T9Rh/PdvJPph18Pv0KEahZ3e/VUh2piuRXlSEvuw+lPERWnm2U0as/BlGuZd6oDj
U0OrJABOM2UhJza2UCjHr0VZLO/rudjUJPrhaktyj6mKu6E0Nss1HKuql2j/ZGJZ
7U46GGsxoYIchI3vJ72Z1q1fhXwEKebe4izhvB9Ji3uaTPe6czS45UxJP3lX96lJ
SyYYJv3lV7EIYJFjUpFXXIzLQWwTRKBrkKux+dTzKZvQhzeq34QJZqlh8aeVapbC
KPeh87hs78mwyJas3mJdB6QwiVFu2Uaen05vIwlnJmdAnuJIDH5h7x1qyURybrpF
kkTX+IAa2Xx2+dCNQd7zkO1cDlmugjFK/VIgz6oyo+3ijLLIkOyn/kS4Aa5Q6UaB
ioaCqeHbKACyJ0ETNQRlybAQz1w1gBPatCMwmWCbX0YgbcCl8caHUphg9DJUCf2Z
U9AKXuW2EuDEIXRXsjpqRG93L+8bK4EE3P6o8EjvWegSe+CdH7A=
=z9Hg
-----END PGP SIGNATURE-----

--TVdwXygprCc3G6Ue--

