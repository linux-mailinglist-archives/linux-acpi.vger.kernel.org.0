Return-Path: <linux-acpi+bounces-17304-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B3DB9ED40
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 12:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F2C97AB40C
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 10:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864622F5461;
	Thu, 25 Sep 2025 10:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="g/WnpFmT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A642F9D96
	for <linux-acpi@vger.kernel.org>; Thu, 25 Sep 2025 10:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758797670; cv=none; b=IpLkGwCAzIpEPtaTwPqnAamUFt4IOq8nDjzciM2t9yoPZdp6xvy61iz4lwah5sT7ukra0wFYX2p7hnnSp5fggsb1Rd5JRIMA0k8y+i1fFJHC4JMBOcgLEHV3T6HTO3WSIhf1WfbhYK2lKEP7u+199TuMl0DlGY53qgvWrzh+DOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758797670; c=relaxed/simple;
	bh=ppkpFu7LN0UmEwlbZ2LjmG3X3CuagEiDP1aYMiHSU0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=He9wcVHHVF0bTrpuj6Qwo96KzZiFr/EWIYAVm7TtW6HiPROZ8rsC5wYq4Khw5dpjTUy+W89zrDu1ms+I+sDULmOM8GW+dnft9CycX5VbEUJZBXpuil81U+BMyQcI6m9/jMbPoXolHxV6+N7e9VTGDLAe6Iis+uKueLpAT9XZk7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=g/WnpFmT; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=ppkp
	Fu7LN0UmEwlbZ2LjmG3X3CuagEiDP1aYMiHSU0w=; b=g/WnpFmTS27BXVSZdc9S
	dSmUno7FamUCex+xNe/x+9+XXr1c3kLhTeqVKqfZEW4hxesla1a5ilTFtIEANWkZ
	f5xZnhVUcKH8Zubl3YrZwv2LbEq+FltpGAsmknncZZWCNWhcdlhu+QWxoM0Jth71
	MwTFImDxE1vcV5TOSez+Zai+mTs7Yl0/aqcgtIKF7VwG7RSjmsSBlA8Ewodu+7Rs
	kignesNuPNjojOpCJL/WyLvDPIfOuHoig7gNYvqc1uAHOwuckPoe+My9l416F+Pd
	mOXtWKBAmQj035BzrhfbCqz6ZEjI+mALUzSnY8DqDP1FmV9xpszCh9s2l84JsBTh
	7A==
Received: (qmail 1835891 invoked from network); 25 Sep 2025 12:54:21 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Sep 2025 12:54:21 +0200
X-UD-Smtp-Session: l3s3148p1@hxXX/Z0/UrggAwDPXwQHAL/S9V79e5yL
Date: Thu, 25 Sep 2025 12:54:21 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: =?utf-8?Q?Jean-Fran=C3=A7ois?= Lessard <jefflessard3@gmail.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 0/2] device property: Add scoped fwnode child node
 iterators
Message-ID: <aNUfXftqGmX8skbp@shikoro>
References: <20250902190443.3252-1-jefflessard3@gmail.com>
 <aLgY1z-MvQbDBx2_@smile.fi.intel.com>
 <aLlgpUlHp7t8P4dQ@shikoro>
 <aLljGIcjAjQhC2uS@smile.fi.intel.com>
 <aMF0xW9rBrSK--Cl@shikoro>
 <aMSehiADcCEpfJUa@shikoro>
 <aMexwC-nB2IQEr8C@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WWFfwp8c3QS64Ifd"
Content-Disposition: inline
In-Reply-To: <aMexwC-nB2IQEr8C@smile.fi.intel.com>


--WWFfwp8c3QS64Ifd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Since there are no further comments, I pull this into my branch now? I
was waiting for feedback, but I'll take it as 'no news, good news'


--WWFfwp8c3QS64Ifd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmjVH10ACgkQFA3kzBSg
KbbHFQ/9E1eiGuQcw81QqjiJvd9fXSz6aXssKtBrBYeTD6d8Iteoxon+/Q+OVHyM
iocbvOx8DibmfDtjVKa7Pkv+UIgFWTbbGgrwx6GtSVqcghGSVw8Ykw2CishGlVx8
e8NNX0RSzhVIl9NMubFcNilYuIen0moQ4ffCYsTqKgZgGWk6YqksJfTYQ7Gn79sx
0TxdLWz75HohA5thzOcBfIVH3qwf9jCJHPSmQYW2uYIkdNRhab3Wskc3aEqozpUp
ZAlqFAO1wiSgTkyA7p/LFjWzpLdYPQvOn2M4uy/trMjptgHr6Jbrz1EK+ZQaXm7p
nM0wSIoV+f/3r7Qbd+r3KD2ZJZrQxrT1K6kSIDnk4UL/j1ijJkh7rS23udptFCs2
6/mmBBqQHlpFuvVn1+Dv6XCg3sf0e8RlCYPubf6a4ZgGltx7QqaSnYaW4nRdeHzo
+RNqbzT8oiNtslqr8XgefdIZLaK+BFg+1vxjvRuEHlc8bWsGUAqY/MMkY6Vgdhnn
aJytXDjUZgaHsHno4WCPA/AHlt8xHlnoPio/HhI7+DbISk6h0tmwIuAFaLNN1i2t
YebLRkCH0QDLa3mEDy65EHqiHo12XK/VCRacMjfd+o4cA/dq9KjbClOk1o5q2Llp
KqhzSsdWlimX1Y7wI7gO4Kj/oCkrjyBBYIrLv8vPNQQ0B9U5hIg=
=KSlp
-----END PGP SIGNATURE-----

--WWFfwp8c3QS64Ifd--

