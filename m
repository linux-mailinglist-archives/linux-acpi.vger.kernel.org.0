Return-Path: <linux-acpi+bounces-19852-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B31CDE2E0
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Dec 2025 01:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADFE73009804
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Dec 2025 00:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63F015CD74;
	Fri, 26 Dec 2025 00:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OP10CBCd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E0026AE5
	for <linux-acpi@vger.kernel.org>; Fri, 26 Dec 2025 00:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766708411; cv=none; b=Dy3zwI5pfvi1UTUnwVMmoZ6rqBxO3Lhvqn0KOZ6ZoezTZR1hYfqHC+DMW6foLJ78PnXldu6EfTGINsFqwy6jCfLBG7chWYg3kAFNbsOW8s13KBFeT4Ygd42jELZcEQkdBM9/vjkvM13KXAtdkCq65wCD6hb9znMa3i0RSdh2K5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766708411; c=relaxed/simple;
	bh=nGwM+PQuL1rzxPZ5jagDG0kFkA7NFWyXrk61vQ0HbjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjjdKB1a00Ta0HCw+nzr94dON06FgW6xC28d1Ehkx2c6yv57doA6tXqDBzt/qFCSxBXjJAj/s9I1GSjqrOnayiWq0weFgV8TxYZ58tABo4N4n3U1zPPPFdbM3IW1MeFtsZ+8Xr57wGCY/pOY7ZG+isU0AcQ6E4CAbIgmUsXeGYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OP10CBCd; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0d6f647e2so110520415ad.1
        for <linux-acpi@vger.kernel.org>; Thu, 25 Dec 2025 16:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766708408; x=1767313208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+DhWhE7XYlLnVX4zCn90QgLygN3HeTxBI4v2gs7tTiQ=;
        b=OP10CBCdAUEacACKVvMPn6XHxS9EbUitLw4z1g+kARcZywxhn2wVI1mo1gRBilHtj5
         KyC3El1KDYxst7dTnafKE2sxfO2E8CVRZx9TXJVQwcQPe+2IAoCrWRFF/UnvnYT99Pl0
         CfujeCadZV4ip/wJw0LkKVp7Z0DfOfy9Mo2yHdKghpkVs/wKD5aMeSJyQktGp6IrUBq3
         yerN7Xm6lv+PZE9LcI+97ltp/2PphRKf+hxzc3eyV3YipGj2hAZfDpCGc/2d+2z92sTa
         hz6TfvIbyIXE9JPZrBAcMuTze73FJyNsgT3Jl42uh5VKr5xke6uf9+KdKG9i2dRun5Gt
         W7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766708408; x=1767313208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DhWhE7XYlLnVX4zCn90QgLygN3HeTxBI4v2gs7tTiQ=;
        b=pGPB2/+VzOtob9MD4bVlxiiMar/1t0oWzyJZTJAyDqHNcO2dBOBoP3UOt7HF3RP+Pb
         GDOng6+rTtmdD96dQ2tjumTq9w2IHVzdpGWzd7LeswMVBN1SB4nRiUFYN6myImDrtqgU
         Oj+Y5rTfxHdlHkHtQi8UPNUJ+aBQmej/cfUpe5q7/yqdM4JpP9rpVt9doG+XcSHoxo7w
         p42eB89p+v+6uhFffEUWfb6+S7xU7jPQrgbIXt9E0pOCuzKPnTYhR6aFhz1Y3bLtgUWs
         axKQwnzSHzGg2XHySrPrI2uTDdAc8lbwuOVZpUhDZrI1qBu1GHa6L/sllMQ53Nj5QAnR
         McMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSIHLMfHzzVjRK/5LI+3RLyT81devlpR9b6PWoz3ecqJ78QU4fZMskRdN6B4ne7IkW025abYBMQ/tj@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf5t5RcZyw3xFo+fnbvW3NHuACK4B8uK7duJN9ZGK4xrlVT/jb
	vSzTOtbytn3+xunNifXzTsqtivek6/VZyb/bbuHmEtFeHvejERm3smIY
X-Gm-Gg: AY/fxX4jpvpS0FI3HMU7awlspadGm7k+CwA0qRwc8Qu0O//jmZtDjE2jNDDk0GJub8N
	xIHy6dhmaW3/DZdTvoyuQexDvQj9s9UXezn5BHv1WU1VP6QDojoDQoSeZDGPwAeZDzGoEQSoZGv
	Gww1HHoMmeNpvtx6uQHeUd/icIYUq+XyJ5liTHThFJ1yTGr8m4WYmTYUKKTBDeBNMrQfV3WJyV1
	cF9C0NwazZ1UOLpx798HyZsQL/KXvsVVJe9zDnzkLOaIPTDyS5/QYDSHWXcj/DAbBK3y/WTZOvV
	FVGNp8tl2xTnLcfFKgtzhYQQH1d/7q4zPVqUA6OW6YKBtHSgT4GriDJlB5dG22eMG6OyYGnS/UX
	fp+3N8Tuu6IhubMhDG4t25M43MKiNCzhY16xPlEiTNxnUL52fzW1nCZGwZ5S1EU0HNcRHts45L2
	9Vus89y4uqvlo=
X-Google-Smtp-Source: AGHT+IGLMBqAzBAWo4yb7tpIYsnetp2fYl5pljocfiHOuE5aX2wPJYCLp8EgyaUT6wEF75bnJiiidQ==
X-Received: by 2002:a17:903:ac4:b0:298:2afa:796d with SMTP id d9443c01a7336-2a2f2a56707mr203430055ad.61.1766708408379;
        Thu, 25 Dec 2025 16:20:08 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d5d1b8sm191462195ad.68.2025.12.25.16.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 16:20:07 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 1E93540A3327; Fri, 26 Dec 2025 07:20:03 +0700 (WIB)
Date: Fri, 26 Dec 2025 07:20:03 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
	viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
	corbet@lwn.net, pierre.gondois@arm.com, zhenglifeng1@huawei.com,
	rdunlap@infradead.org, ray.huang@amd.com, gautham.shenoy@amd.com,
	mario.limonciello@amd.com, perry.yuan@amd.com,
	ionela.voinescu@arm.com, zhanjie9@hisilicon.com,
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
	vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
	nhartman@nvidia.com, bbasu@nvidia.com
Subject: Re: [PATCH v5 07/11] cpufreq: CPPC: Add sysfs for min/max_perf and
 perf_limited
Message-ID: <aU3Us1NzlpVQcyii@archie.me>
References: <20251223121307.711773-1-sumitg@nvidia.com>
 <20251223121307.711773-8-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t+JMDWcZpMsJclIY"
Content-Disposition: inline
In-Reply-To: <20251223121307.711773-8-sumitg@nvidia.com>


--t+JMDWcZpMsJclIY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 05:43:03PM +0530, Sumit Gupta wrote:
> +		Write the bitmask of bits to clear:
> +		  1 =3D clear bit 0 (desired performance excursion)
> +		  2 =3D clear bit 1 (minimum performance excursion)
> +		  3 =3D clear both bits
> +		The platform sets these bits; OSPM can only clear them.

Sphinx reports htmldocs warning:

Documentation/ABI/testing/sysfs-devices-system-cpu:356: WARNING: Definition=
 list ends without a blank line; unexpected unindent. [docutils]

I have to fix up the bitmask list:

---- >8 ----
diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documenta=
tion/ABI/testing/sysfs-devices-system-cpu
index b022cbf46adcfe..8cda698019922b 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -363,9 +363,11 @@ Description:	Performance Limited
 		requested level. A non-zero value indicates throttling occurred.
=20
 		Write the bitmask of bits to clear:
-		  1 =3D clear bit 0 (desired performance excursion)
-		  2 =3D clear bit 1 (minimum performance excursion)
-		  3 =3D clear both bits
+
+		- 1 =3D clear bit 0 (desired performance excursion)
+		- 2 =3D clear bit 1 (minimum performance excursion)
+		- 3 =3D clear both bits
+
 		The platform sets these bits; OSPM can only clear them.
=20
 		This file is only present if the cppc-cpufreq driver is in use.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--t+JMDWcZpMsJclIY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaU3UrwAKCRD2uYlJVVFO
o4kvAQDTEVNeFeX7ckTchAsnDcqX6/lgn/RtWuqlH3bGU25fFwD/ZEKQGJS37yff
aP5cML3xRpih8KZ3CuP+1ul/2sh1TAI=
=OMhn
-----END PGP SIGNATURE-----

--t+JMDWcZpMsJclIY--

