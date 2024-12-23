Return-Path: <linux-acpi+bounces-10282-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6114E9FB4B3
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2024 20:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D8E165B23
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2024 19:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369481C5F10;
	Mon, 23 Dec 2024 19:33:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F051C3BEE;
	Mon, 23 Dec 2024 19:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734982391; cv=none; b=PRSobR1AnG00l+/kNDUV0w66Hj7O3UGlfxFgXP5XucE1ZyIw6eER1OoQRoif/F76TvhCRjH2hdAp4vKgDpDzn1xlGKKlqRVJQjCN+MlXBKzK1rS9XKxac8uzLPJUqavhemYqL7q7DP9zUEnO2JW+g4CKecFu9/jmp8LY6jL8r9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734982391; c=relaxed/simple;
	bh=mAeUuoTSqMoiDt/5kTDDGSdhmGP1Drr5E9wbWwrpM40=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJkgjeCAMwEoIBOQ3svKLYF4Vyy0AW4yHeczdTxtsX4lVUgqwV9Z0Sd+ST06G/H4s/K6QHX1ceS6sPKTqPRAn9UiS6nwUz+783omEHkxHbfI6Th6lW027qLojSx7MEFcgb30HDAFo4mW8J0S6CQDk5cvHoC9QKIDpc8MRj70uIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YH7PN57FSz6K61Z;
	Tue, 24 Dec 2024 03:29:12 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A7C0140B3C;
	Tue, 24 Dec 2024 03:33:03 +0800 (CST)
Received: from localhost (10.47.75.118) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Dec
 2024 20:33:02 +0100
Date: Mon, 23 Dec 2024 19:33:00 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Xiaofei Tan <tanxiaofei@huawei.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<M.Chehab@huawei.com>, <roberto.sassu@huawei.com>, <shiju.jose@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
	<mchehab+huawei@kernel.org>
Subject: Re: [PATCH] acpi: Fix hed module initialization order when it is
 built-in
Message-ID: <20241223193300.00000b32@huawei.com>
In-Reply-To: <dfa67fab-e9c1-baec-dd86-6c6ba79eabeb@huawei.com>
References: <20241115035014.1339256-1-tanxiaofei@huawei.com>
	<CAJZ5v0h4-cSFs+ED3ymJKHKkEAproXCtB2t3cP1wcyd6eq=Sgg@mail.gmail.com>
	<dfa67fab-e9c1-baec-dd86-6c6ba79eabeb@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 23 Dec 2024 17:31:08 +0800
Xiaofei Tan <tanxiaofei@huawei.com> wrote:

> Hi Rafael,
>=20
> =E5=9C=A8 2024/12/11 1:59, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > On Fri, Nov 15, 2024 at 4:56=E2=80=AFAM Xiaofei Tan <tanxiaofei@huawei.=
com> wrote: =20
> >> When the module hed is built-in, the init order is determined by
> >> Makefile order. =20
> > Are you sure? =20
>=20
> yes

We had a similar fix in CXL recently (which is why I suggested this approach
internally when tanxiaofei mentioned the problem).

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/d=
rivers/cxl?id=3D6575b268157f37929948a8d1f3bafb3d7c055bc1

The related discussion for the CXL patch was the first time I'd come across=
 solution
to load order for built in cases.


>=20
> >> That order violates expectations. Because the module
> >> hed init is behind evged. RAS records can't be handled in the
> >> special time window that evged has initialized while hed not.
> >> If the number of such RAS records is more than the APEI HEST error
> >> source number, the HEST resources could be occupied all, and then
> >> could affect subsequent RAS error reporting. =20
> > Well, the problem is real, but does the change really prevent it from
> > happening or does it just increase the likelihood of success? =20
>=20
> It can be completely solved if the driver used as built-in way. If build =
HED as a
> module, it not solved.

Can we enforce that condition not happening with appropriate Kconfig?
It's annoying to restrict build options, but if needed to make it work
then better than not working!

Jonathan


>=20
> >
> > In the latter case, and generally speaking too, it would be better to
> > add explicit synchronization between evged and hed.
> > =20
> >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> >> ---
> >>   drivers/acpi/Makefile | 8 +++++++-
> >>   1 file changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> >> index 61ca4afe83dc..54f60b7922ad 100644
> >> --- a/drivers/acpi/Makefile
> >> +++ b/drivers/acpi/Makefile
> >> @@ -15,6 +15,13 @@ endif
> >>
> >>   obj-$(CONFIG_ACPI)             +=3D tables.o
> >>
> >> +#
> >> +# The hed.o needs to be in front of evged.o to avoid the problem that
> >> +# RAS errors cannot be handled in the special time window of startup
> >> +# phase that evged has initialized while hed not.
> >> +#
> >> +obj-$(CONFIG_ACPI_HED)         +=3D hed.o
> >> +
> >>   #
> >>   # ACPI Core Subsystem (Interpreter)
> >>   #
> >> @@ -95,7 +102,6 @@ obj-$(CONFIG_ACPI_HOTPLUG_IOAPIC) +=3D ioapic.o
> >>   obj-$(CONFIG_ACPI_BATTERY)     +=3D battery.o
> >>   obj-$(CONFIG_ACPI_SBS)         +=3D sbshc.o
> >>   obj-$(CONFIG_ACPI_SBS)         +=3D sbs.o
> >> -obj-$(CONFIG_ACPI_HED)         +=3D hed.o
> >>   obj-$(CONFIG_ACPI_EC_DEBUGFS)  +=3D ec_sys.o
> >>   obj-$(CONFIG_ACPI_BGRT)                +=3D bgrt.o
> >>   obj-$(CONFIG_ACPI_CPPC_LIB)    +=3D cppc_acpi.o
> >> --
> >> 2.33.0
> >> =20
> > . =20


