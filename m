Return-Path: <linux-acpi+bounces-10812-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 405B7A1B7B7
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jan 2025 15:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292F6188FA95
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jan 2025 14:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB3412EBDB;
	Fri, 24 Jan 2025 14:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="haXuFAz4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from ksmg02.maxima.ru (ksmg02.maxima.ru [81.200.124.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D0B86320;
	Fri, 24 Jan 2025 14:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737728288; cv=none; b=NHKaHVipf1lZLJDKYiKJOTQMIuicUtrW7vDN65zWw0xkFnMPTXxbDukurm98w2zaNeaEgUhjL2i+5yqULq3eRMSly68OIABhjR1wNocfn4Qn1/TAFO390a7J7mXy/27iNz5kNA4SaNHXbiZ4sdPBHaSqNhVznnD7X4iocrXBFWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737728288; c=relaxed/simple;
	bh=vMcNKfUrr6kvw1KTDIL8NbPVXX6x6jNASGpvfFsjVhM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UA9uHUKMoM0ZXHfBXRxaFxLE0SIwtABrA50QLXMmULH2aS/ZcPnsXGF8Cq8v2cEr7Np7ENdOVpAKtmB0F4rfdbEPfsIOUZya4YA8PaVcTH46Bfur5Bh5EBv/peOfSMmVdcAVF4/wZGn7qrcG+Zq6qQtJUoSWzV8Qeg7nVudu2Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=haXuFAz4; arc=none smtp.client-ip=81.200.124.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg02.maxima.ru (localhost [127.0.0.1])
	by ksmg02.maxima.ru (Postfix) with ESMTP id 942041E0007;
	Fri, 24 Jan 2025 17:17:53 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg02.maxima.ru 942041E0007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1737728273; bh=mhAYYhkyZeToCP7bA5KTLaEmT6/0G2AimppcOQ85rPY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
	b=haXuFAz48hQSn0XvM23sNjt2my/syiGnceq51w4AeIb3ZHknXMh2eXSV63dHQuZnw
	 NEnCCBSRtwu7N8sbMVvPxbv3tLnOiZi1M0pebBtO9e2khnm895tqEMcWplUtMCaXbh
	 dWgQPmqQkuze8tkH/RY0qxdikJMoR9Mae8D3lEggMeXpHilRBD4adYP3Xakjutxdvo
	 Aofw7+XlVHQzXMVZAG4/SSMR9PirBLDOd6OfCGTWM6CSlb02klUuGy4NZ7k2UoEGCB
	 qqkVhhRUiz6Q8+w+H/OZI7Yw7JwkRm+GYEC1V/di79W5Y480SDtJ/SOoL5DLhsZXPl
	 0ffjli/MRzLgQ==
Received: from ksmg02.maxima.ru (mail.maxima.ru [81.200.124.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg02.maxima.ru (Postfix) with ESMTPS;
	Fri, 24 Jan 2025 17:17:53 +0300 (MSK)
Received: from mmail-p-exch02.mt.ru (81.200.124.62) by mmail-p-exch02.mt.ru
 (81.200.124.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 24 Jan
 2025 17:17:51 +0300
Received: from mmail-p-exch02.mt.ru ([fe80::5fe7:9066:a884:475c]) by
 mmail-p-exch02.mt.ru ([fe80::5fe7:9066:a884:475c%9]) with mapi id
 15.02.1544.004; Fri, 24 Jan 2025 17:17:51 +0300
From: "Murad Masimov " <m.masimov@mt-integration.ru>
To: Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"syzbot+c80d8dc0d9fa81a3cd8c@syzkaller.appspotmail.com"
	<syzbot+c80d8dc0d9fa81a3cd8c@syzkaller.appspotmail.com>
Subject: Re: [PATCH] acpi: nfit: fix narrowing conversion in acpi_nfit_ctl
Thread-Topic: [PATCH] acpi: nfit: fix narrowing conversion in acpi_nfit_ctl
Thread-Index: AQHbbbW+YWbRIqLg90Kdd63unsRF6rMk03WAgADVgoY=
Date: Fri, 24 Jan 2025 14:17:51 +0000
Message-ID: <741f409ae5be4f1f9b62d9223f026e26@mt-integration.ru>
References: <20250123163945.251-1-m.masimov@mt-integration.ru>,<649ed1bb-0686-42f0-802f-9f1909aeed8c@intel.com>
In-Reply-To: <649ed1bb-0686-42f0-802f-9f1909aeed8c@intel.com>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSMG-AntiPhishing: NotDetected, bases: 2025/01/24 12:55:00
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: m.masimov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 50 0.3.50 df4aeb250ed63fd3baa80a493fa6caee5dd9e10f, {rep_avail}, {Tracking_one_url, url3}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;mt-integration.ru:7.1.1;syzkaller.appspot.com:7.1.1,5.0.1;81.200.124.62:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;ksmg02.maxima.ru:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.62
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 190558 [Jan 24 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/01/24 11:37:00 #27111174
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/01/24 12:55:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7


________________________________________
=EF=D4: Dave Jiang <dave.jiang@intel.com>
=EF=D4=D0=D2=C1=D7=CC=C5=CE=CF: 24 =D1=CE=D7=C1=D2=D1 2025 =C7. 2:43
=EB=CF=CD=D5: Masimov Murad; Dan Williams
=EB=CF=D0=C9=D1: Vishal Verma; Ira Weiny; Rafael J. Wysocki; Len Brown; nvd=
imm@lists.linux.dev; linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.o=
rg; lvc-project@linuxtesting.org; stable@vger.kernel.org; syzbot+c80d8dc0d9=
fa81a3cd8c@syzkaller.appspotmail.com
=F4=C5=CD=C1: Re: [PATCH] acpi: nfit: fix narrowing conversion in acpi_nfit=
_ctl

> On 1/23/25 9:39 AM, Murad Masimov wrote:
> > Syzkaller has reported a warning in to_nfit_bus_uuid(): "only secondary
> > bus families can be translated". This warning is emited if the argument
> > is equal to NVDIMM_BUS_FAMILY_NFIT =3D=3D 0. Function acpi_nfit_ctl() f=
irst
> > verifies that a user-provided value call_pkg->nd_family of type u64 is
> > not equal to 0. Then the value is converted to int, and only after that
> > is compared to NVDIMM_BUS_FAMILY_MAX. This can lead to passing an inval=
id
> > argument to acpi_nfit_ctl(), if call_pkg->nd_family is non-zero, while
> > the lower 32 bits are zero.
> >
> > All checks of the input value should be applied to the original variabl=
e
> > call_pkg->nd_family.
> >
> > Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> >
> > Fixes: 6450ddbd5d8e ("ACPI: NFIT: Define runtime firmware activation co=
mmands")
> > Cc: stable@vger.kernel.org
> > Reported-by: syzbot+c80d8dc0d9fa81a3cd8c@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dc80d8dc0d9fa81a3cd8c
> > Signed-off-by: Murad Masimov <m.masimov@mt-integration.ru>
>=20
> While the change logically makes sense, the likelihood of nd_family > int=
_size is not ever likely. Given that NVDIMM_BUS_FAMILY_MAX is defined as 1,=
 I don't think we care about values greater than that regardless of what is=
 set in the upper 32bit of the u64. I'm leaning towards the fix is unnecess=
ary.

Thank you for the review! But I believe there is a misunderstanding. The po=
int is that the code fragment affected by this patch is intended to make su=
re, that family is in range between 1 and NVDIMM_BUS_FAMILY_MAX. This is ne=
cessary because call_pkg contains user-provided data. However the implement=
ation of these validity checks is erroneous and leads to passing an invalid=
 value. The syzkaller report proves, that this bug can be triggered by a us=
er. Here is an example to demonstrate, what exactly happens:

1. Let's say call_pkg->nd_family is equal to (1ull << 32).
2. Expression (cmd =3D=3D ND_CMD_CALL && call_pkg->nd_family) evaluates to =
true.
3. Since family is of type int, and call_pkg->nd_family is u64, assigning c=
all_pkg->nd_family to family will lead to a narrowing conversion.
4. As a result, family equals to 0, which will be passed in to_nfit_bus_uui=
d() triggering the warning.

Moreover, family may also be a negative integer (e.g. call_pkg->nd_family =
=3D=3D ~(0ull)). This can lead to an undefined behaviour in test_bit() and =
potentially out-of-bounds in to_nfit_uuid(). Thus, even if triggering a WAR=
N is not concerning, the bug still should be fixed.

> > ---
> >  drivers/acpi/nfit/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> > index a5d47819b3a4..ae035b93da08 100644
> > --- a/drivers/acpi/nfit/core.c
> > +++ b/drivers/acpi/nfit/core.c
> > @@ -485,7 +485,7 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_=
desc, struct nvdimm *nvdimm,
> >               cmd_mask =3D nd_desc->cmd_mask;
> >               if (cmd =3D=3D ND_CMD_CALL && call_pkg->nd_family) {
> >                       family =3D call_pkg->nd_family;
> > -                     if (family > NVDIMM_BUS_FAMILY_MAX ||
> > +                     if (call_pkg->nd_family > NVDIMM_BUS_FAMILY_MAX |=
|
> >                           !test_bit(family, &nd_desc->bus_family_mask))
> >                               return -EINVAL;
> >                       family =3D array_index_nospec(family,
> > --
> > 2.39.2
> >


