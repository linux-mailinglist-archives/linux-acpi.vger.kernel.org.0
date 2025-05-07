Return-Path: <linux-acpi+bounces-13583-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09426AAE34D
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 16:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04D94501D47
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 14:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123BE288CA6;
	Wed,  7 May 2025 14:36:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93180289344
	for <linux-acpi@vger.kernel.org>; Wed,  7 May 2025 14:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746628571; cv=none; b=fcJiVCvDdSG8w/Sd+IUBocBUuvaZ35WRUi+9psHT5Qdpy1g0ns5GnzZppqE68T9bTTlgS/F1uKfkAKf6NKqV4og2+NWpnf4RIg5mMUothVzjP4EPpHTQOOfOqQ0suFiKV98VgaBxqRvcO3jvkalFAoVMlSLXjzkCWUVtDI4NajI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746628571; c=relaxed/simple;
	bh=YjLfkRQOYTscTiKcHzV/iuInQdOTC8JDYKd6TCzPrzU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ab94QOUWDuMSIKdGYLnB9BMA5valHKf4bZ3fRO39PZ491UfToR7WBHczPoI0cjXCdtOwg3aFWpaCJGWgnRrK6E0tozs6jgg/+TPGT/w5jEwMNkTNWbz6xdW2MhdpqQL91TrF9/63b5kJZmdfcNYAkOUDjPjNFkoJpSD4m+sAvMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZsyS16t7Xz6L5ZD;
	Wed,  7 May 2025 22:33:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 456571402F7;
	Wed,  7 May 2025 22:36:05 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 7 May
 2025 16:35:52 +0200
Date: Wed, 7 May 2025 15:35:50 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Yicong Yang
	<yangyicong@huawei.com>, <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<jmeurin@google.com>, <jeremy.linton@arm.com>, <zhanjie9@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <yangyicong@hisilicon.com>,
	<linuxarm@huawei.com>, <alireza.sanaee@huawei.com>
Subject: Re: [PATCH] ACPI: PPTT: Fix table length check when parsing
 processor nodes
Message-ID: <20250507153550.0000340f@huawei.com>
In-Reply-To: <20250507-obedient-knowing-galago-245e7c@sudeepholla>
References: <20250507035124.28071-1-yangyicong@huawei.com>
	<20250507-devout-mysterious-jackal-e50e00@sudeepholla>
	<CAJZ5v0iWJQnwamT0mP=A_wtAbRkguhxcvbMnm+b2chAET7=sGA@mail.gmail.com>
	<20250507-venomous-feathered-skink-77ea16@sudeepholla>
	<CAJZ5v0hyxCE3NWcCgKkut2_pJGO-Pyt27GdhMK0ZUZ-MJ6dudQ@mail.gmail.com>
	<20250507-obedient-knowing-galago-245e7c@sudeepholla>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 7 May 2025 12:55:00 +0100
Sudeep Holla <sudeep.holla@arm.com> wrote:

> On Wed, May 07, 2025 at 01:51:58PM +0200, Rafael J. Wysocki wrote:
> > On Wed, May 7, 2025 at 1:47=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.c=
om> wrote: =20
> > >
> > > On Wed, May 07, 2025 at 01:44:26PM +0200, Rafael J. Wysocki wrote: =20
> > > > On Wed, May 7, 2025 at 1:40=E2=80=AFPM Sudeep Holla <sudeep.holla@a=
rm.com> wrote: =20
> > > > >
> > > > > On Wed, May 07, 2025 at 11:51:24AM +0800, Yicong Yang wrote: =20
> > > > > > From: Yicong Yang <yangyicong@hisilicon.com>
> > > > > >
> > > > > > Below error is met on my board and QEMU VM on SMT or non-SMT ma=
chine:
> > > > > >   ACPI PPTT: PPTT table found, but unable to locate core 31 (31)
> > > > > >
> > > > > > This is because the processor node is found by iterating the PP=
TT
> > > > > > table under condition (for both acpi_find_processor_node() and
> > > > > > acpi_pptt_leaf_node()):
> > > > > >   while (entry + proc_sz < table_end)
> > > > > >     [parse the processor node]
> > > > > >
> > > > > > If the last processor node is happened to be the last node in t=
he
> > > > > > PPTT table, above condition will always be false since
> > > > > > entry + proc_sz =3D=3D table_end. Thus the last CPU is not pars=
ed.
> > > > > > Fix the loop condition to resolve the issue.
> > > > > >
> > > > > > This issue is exposed by [1] but the root cause is explained ab=
ove.
> > > > > > Before [1] entry + proc_sz is always smaller than table_end.
> > > > > > =20
> > > > >
> > > > > Another thread [1]  with similar patch. =20
> > > >
> > > > OK, so is this a correct fix? =20
> > >
> > > While it may fix the issue on the surface, I just want to be sure the=
re
> > > are no other issues with the PPTT table presented from the firmware.
> > > I will asked some questions on that thread before I can agree on the =
solution. =20
> >=20
> > Yeah, it looks like table_end points to the last byte of the table
> > instead of pointing to the first byte after the end of the table. =20
>=20
> Indeed and also we should have private resources like L1 cache described
> after the initial 20 bytes of the node. So I am bit worried if this will
> just hide other problems while it may solve this problem by looks of it.
> This example doesn't look like a proper PPTT matching real systems.
>=20

Assuming I'm understanding the bug correctly...

SMT systems will hit this. There will typically be no private resources
for a thread as the L1I/D shared by multiple threads (which are processor
nodes IIRC).  Note we are trying to improve the cache description in QEMU
at the moment as it would definitely be better to present caches in PPTT,
but that isn't the main issue here.

Jonathan




