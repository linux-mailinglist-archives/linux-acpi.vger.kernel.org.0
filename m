Return-Path: <linux-acpi+bounces-1032-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023FD7D8862
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 20:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B3C7B21130
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 18:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42EC3AC11
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 18:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afLXuJoS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9CD1BDC7
	for <linux-acpi@vger.kernel.org>; Thu, 26 Oct 2023 17:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C034C433C8;
	Thu, 26 Oct 2023 17:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698341175;
	bh=V/ulC58a5LfJVX5wavisSwumWcJwtbXrRUJsg5+bfNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=afLXuJoSGhBj7fHwWoalKeo/DjEUbaQrbtz5NrFt9haLw9eKZ1VH8bie1taFLGoud
	 Zznmvx9IWRrc0EedjfQiZvk9dHqtKZhNp81arczbQxG3vCv2L76TjnRUEOoofp5ET3
	 i/VHE5b/pi4X0P/LnWFqzUV35Zu5vW9VAMfiM8jECXPC/XaTDee6KnAowYPvO7kS3T
	 OByO1x2f88e5mzWSkgwAquBV+cxKGzL9zeWzEJ95mJhnC5nKzgMPYWT7GU6T+1w3R7
	 nGw4RM+XIp689pSqFFaZcUv11/+rMERXE8dmvtX99bluXMOLpzrA2BHdGCt+3aS4AC
	 s1Babz4GYp4KQ==
Date: Thu, 26 Oct 2023 19:26:12 +0200
From: Wolfram Sang <wsa@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/2] ACPI: Add helper acpi_use_parent_companion
Message-ID: <ZTqhNCNCtUk+mz1n@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	linux-acpi@vger.kernel.org
References: <90bd1071-317e-4dfe-b94b-9bcee15d66c5@gmail.com>
 <6e935761-5b36-411a-ac82-cbc394bba7b6@gmail.com>
 <20231024173338.haei2py7izlqxjmw@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t+ij7JVM6oQTTOMi"
Content-Disposition: inline
In-Reply-To: <20231024173338.haei2py7izlqxjmw@zenone.zhora.eu>


--t+ij7JVM6oQTTOMi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Wolfram, can we take this in i2c? Otherwise this will take two
> release rounds to get in.

In general, I can, no problem. But there is still on-going discussion
regarding patch 2. So, I will wait for a conclusion there. I am not
familiar enough with ACPI to have an own opinion about that topic.


--t+ij7JVM6oQTTOMi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmU6oTQACgkQFA3kzBSg
Kbal+w//REmKZnyzryb0YPyt3Xa/LtVjSLhm/i28zSYJpqmn7ZmMLvQd+FdincA/
JeqBruTNQ5Gs7WoIJDyALMn//dv8G7YCHJ5aSmj5PpAZvJFezLAC2pqMoC8iD6Yi
j2OtMS6Zc+V0mlImPojTWNV+6RBOEcKhy42MN2pYFCvjWvTrjX5Ds8yvdQ6MBXmP
aiYJD7ppj5/EZefvNjFGhYAA+YPqN/1Xsd2FmkrJK03HLIk43XlFtnBvSnZUeD6c
/h0lcr8khDDO7VFFL/2/QcS8MvP0Rwnq1JzA85sxF25zP2Kevlp+zL6OsmjHP+3s
LVjFhQGQLL619NpPJdOszEin2hilEs6mD0cnK6mCbbUEyg87PyZSNeCz3zbVNIXg
8Ka+0jA0w2wuNquHopJ10DD62b3JbxqLSXeEnmWXdLTzn7OMvapcBaAWOzc0Hgar
5ryM74qVYUDZSugyNw6hk3tGbuh0kAGp68UPOpn7W9whBg/ojkFVbZk81sSmhjr4
MLEvnhjr66TiyDDZch5kE7NJ7zPzKGaW68zGgRsmWO2j98XPBK5qgCpDJPztb3jP
KybD7F3Al9hNaGrolD1R9TIXZ2tQM0x3GmNu7FFtskvAUbKmGe599ch21b/+GP9X
rw8gX1QfoGA41JSAd0dEQWHOezOMhZk/IUEj4cJUnuB5tCVGyd8=
=8d1G
-----END PGP SIGNATURE-----

--t+ij7JVM6oQTTOMi--

