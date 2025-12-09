Return-Path: <linux-acpi+bounces-19501-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F1BCAFAAC
	for <lists+linux-acpi@lfdr.de>; Tue, 09 Dec 2025 11:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B543B301118D
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Dec 2025 10:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C502FD1D3;
	Tue,  9 Dec 2025 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipearl.com header.i=@sipearl.com header.b="poR5QuP+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpout.sipearl.com (smtpout.sipearl.com [178.170.11.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA0C1FE46D;
	Tue,  9 Dec 2025 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.170.11.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765276833; cv=none; b=FXtdwreEJqKiPWD+8fSI5be6k6uJOkH3QJnEojSxfC+QjpP1scHJKhaoIj35FOBq87o/KvytrJuPW2I2LJjWJEM8Y3hokXW1fvwWxFYG07ORdCxWJW+DCoqWm3bkkQZhMM2NqKwCe+OeSzw/XW+Vd/6uoj9fmx5sen4JnY6f7lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765276833; c=relaxed/simple;
	bh=lKaZnZiXITQBApRICQg3cVECIDLxPqcs9B66Vs1z+IQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S3GU+kxEpR/hVxKjXLMWiibYnz2l5fTN4ProxkogbwS8ln9CNe8fHhYl2+ZkWtSUDwTAJIkPhMqrk0KyEOtE9T9Cu6fXVp6uidcin9sowWHPmp4kWR70NjohYXJNhyefcG03y9PMEkNhrsm57VFq1BpJn6/Bch9TaTztLDhynsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipearl.com; spf=pass smtp.mailfrom=sipearl.com; dkim=pass (2048-bit key) header.d=sipearl.com header.i=@sipearl.com header.b=poR5QuP+; arc=none smtp.client-ip=178.170.11.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipearl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipearl.com
Received: from smtpout.sipearl.com ([172.31.29.2])
	by smtpin.sipearl.com  with ESMTPS id 5B9Adsv4011057-5B9Adsv6011057
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Dec 2025 11:39:54 +0100
Received: from dc2pvwexcz001.sipearl.corp (172.31.29.1) by
 dc2pvwexcz002.sipearl.corp (172.31.29.2) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Tue, 9 Dec 2025 11:39:54 +0100
Received: from dc2pvwexcz001.sipearl.corp ([172.16.21.27]) by
 dc2pvwexcz001.sipearl.corp ([172.16.21.27]) with mapi id 15.02.1748.036; Tue,
 9 Dec 2025 11:39:54 +0100
From: Andrea Tomassetti <andrea.tomassetti@sipearl.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>, "lenb@kernel.org"
	<lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lkp@intel.com" <lkp@intel.com>, "oe-kbuild-all@lists.linux.dev"
	<oe-kbuild-all@lists.linux.dev>, Olivier Dautricourt
	<Olivier.Dautricourt@sipearl.com>, "olivierdautricourt@gmail.com"
	<olivierdautricourt@gmail.com>, "rafael@kernel.org" <rafael@kernel.org>,
	Thibault Cantori <thibault.cantori@sipearl.com>
Subject: Re: Re: Re: [PATCH v3 1/2] mailbox: pcc: support polling mode when
 there is no platform IRQ
Thread-Topic: Re: Re: [PATCH v3 1/2] mailbox: pcc: support polling mode when
 there is no platform IRQ
Thread-Index: AQHcaPgnB2hPlGTceUuN1VHdEiqJ/g==
Date: Tue, 9 Dec 2025 10:39:53 +0000
Message-ID: <aTf8bzYaOPe9naLN@dc2pvlnosz001.pub.int.sipearl.com>
References: <20251203-persimmon-condor-of-essence-9fc43d@sudeepholla>
 <20251204125938.3025022-1-andrea.tomassetti@sipearl.com>
 <20251204-mauve-bear-of-wholeness-e13a4b@sudeepholla>
In-Reply-To: <20251204-mauve-bear-of-wholeness-e13a4b@sudeepholla>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BEEE6929B9300A4796EB554CB3C29F30@sipearl.corp>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.29.2
X-FE-Policy-ID: 2:2:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=sipearl.com; s=sipearl2024; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:content-type:mime-version;
 bh=lKaZnZiXITQBApRICQg3cVECIDLxPqcs9B66Vs1z+IQ=;
 b=poR5QuP+KeRPL6SCMo9KFDyWAt7y3eqcOjAnA5ecMa7VkDVJcXt2BT6f7PIVzqL1XYj8DXZ3ecJL
	DVj5bBFXwjFsR2N6F0zhK4/rDCLFjc22uMDKoQK87mg8yNKua85HBxF4abIQ080dF+KG2vKz7Qfn
	W5OriCksghRw2UTXyoVGoqr4bt/eoguBB7MxfJCTit7nOXJ7Bq39UJBQ6W2X32SKIUbIJUjItTZs
	uSf99P/11pD84sypfqD/rtCzqQKxrJR/bVjVNWWRkTWeJBp9LYv0VK7X6SkEUwSFg304jB8TA9je
	vFcMV5WaTUNmmfCrw9gk/K7WJ3EE27eIqaf2nA==

On 25/12/04 01:14PM, Sudeep Holla wrote:
> On Thu, Dec 04, 2025 at 01:59:38PM +0100, Andrea Tomassetti wrote:
> > On 25/12/03 10:28AM, Sudeep Holla wrote:
> > > On Tue, Dec 02, 2025 at 11:12:14AM +0100, Andrea Tomassetti wrote:
> > > > The goal is to allow clients to submit a message in both irq and po=
lling
> > > > mode of the pcc mailbox. The ACPI specification does not require a
> > > > platform irq for pcc channels. Let's implement the case where it is=
 not
> > > > available.
> > > >
> > >=20
> > > Just curious if you have a real use case for this polling mode on you=
r
> > > platforms or ...
> > >=20
> > > > Tested-by: Thibault Cantori <thibault.cantori@sipearl.com>
> > > > Co-developed-by: Olivier Dautricourt <olivier.dautricourt@sipearl.c=
om>
> > > > Signed-off-by: Olivier Dautricourt <olivier.dautricourt@sipearl.com=
>
> > > > Signed-off-by: Andrea Tomassetti <andrea.tomassetti@sipearl.com>
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Closes: https://lore.kernel.org/oe-kbuild-all/202511120243.soxAFpqQ=
-lkp@intel.com/
> > > > Closes: https://lore.kernel.org/oe-kbuild-all/202511120558.Cln7LF6M=
-lkp@intel.com/
> > > > Closes: https://lore.kernel.org/oe-kbuild-all/202511120729.R3XQNSnx=
-lkp@intel.com/
> > >=20
> > > You are just trying to fix these warnings. If it is latter, we don't =
have to
> > > add support for polling mode especially if it can't be tested on real
> > > platforms.
> > >
> > In our target product, we're still investigating if PCC-based SCMI comm=
unication will
> > rely on interrupts or polling. When we started looking into it we reali=
zed that polling
> > wasn't supported and that's why we decided to work on and send this pat=
ch. We thought it
> > could have been beneficial to other members of the community and it bri=
ngs the driver a
> > bit closer to the ACPI specifications.
> >=20
> > We're using ARM Fast Models for prototyping and that's how we validated=
 and tested this patch.
> >=20
>=20
> I wouldn't consider that as real platform especially if it is not std. AE=
M
> models that are well maintained. Many Fast models are short lived and nev=
er
> maintained long term, so I don't want to push any feature based on that a=
lone
> unless you have a real platform with missing or broken interrupt that nee=
ds
> this polling feature.
>=20
> It is burden for long term maintenance if there is no regular way to test=
 this
> polling mode feature.
>=20
Fair, I totally get your point. Thank you very much for your time.

Regards,
Andrea
> --=20
> Regards,
> Sudeep=

