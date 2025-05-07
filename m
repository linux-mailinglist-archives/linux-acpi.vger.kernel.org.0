Return-Path: <linux-acpi+bounces-13572-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E07F6AADECD
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 14:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24352188C5A9
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 12:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4817325D91E;
	Wed,  7 May 2025 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="imvaQUSu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11931EE7B9;
	Wed,  7 May 2025 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746620252; cv=none; b=OEPGrlXKu6tgiZ1UYc/0i3YVndkZ+s8xzytX2X3n5mxk7KrNFedeodB/kwIXY8BVraa9X3KwhsHL2lq9h8StknsUmI1Nz50CNMGUihqTD27JEJf0s5qHQSVlPLfhQvQbeAGK1r5WVx9iIDjmzUB3KjPb5yrE3ohPOyRR5KZ6upU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746620252; c=relaxed/simple;
	bh=0WVuc/bIsAlAczB+iA0KhssxfdnHwoMHZCTR0ENK7Bo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EAVqdomVwNUqla0h/drHfwJai+mFcdM/ckBF6WeclJLA51Ll0NGUEulZtIVVmFBAAibP1q8hkjSrH79egfKFi3IankOTKFEtJHmdETZ1j7V+XqTYICna8RUCdFC/FcT5Xuv5A6pvjxukScDERoPQ9Ubn3Z8lnTRqXzgxVv2SmUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=imvaQUSu; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1746620250; x=1778156250;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=UfyImMnMFjKQVq6DhjDkJEAaGyvs/fA8oMIw3bn/0mI=;
  b=imvaQUSuk3Mg9x5DaPpvW3teXKeKGS/00g4grGQ4af6MwE3B6Ej8eFTo
   p6F1jFZvBBjHDhuB6e6aXOoakIGm1l/55ggDp/+C/GFCI8U9ljPRoKw24
   KIgA8HbSrF0Z/GyWwEolle07st3dP2pfXjNzBtIV6vMnGz6t8C9F1jy34
   WLKB8Quw0+lzuODqF2ROd0orcmCeIyCf0paVP/mWqB+4qjus5ZUSz4ptQ
   bOOgxCS/3MisactHosURihSXyu92vbwe/c8KZmsXYI4w4m/DseLJ0TF4P
   bLEi4dYcmSh81h3O2GNmDuIgy6f1CXIKBVdj0Z2ZzLsoJqodtnBq6sEzl
   A==;
X-IronPort-AV: E=Sophos;i="6.15,269,1739836800"; 
   d="scan'208";a="487565859"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 12:17:24 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.10.100:15948]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.24.17:2525] with esmtp (Farcaster)
 id dc0efbea-8ae5-4ee4-925f-a59bad1bdfcc; Wed, 7 May 2025 12:17:22 +0000 (UTC)
X-Farcaster-Flow-ID: dc0efbea-8ae5-4ee4-925f-a59bad1bdfcc
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 7 May 2025 12:17:22 +0000
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19D008EUC001.ant.amazon.com (10.252.51.165) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 7 May 2025 12:17:22 +0000
Received: from EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1]) by
 EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1%3]) with mapi id
 15.02.1544.014; Wed, 7 May 2025 12:17:22 +0000
From: "Heyne, Maximilian" <mheyne@amazon.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Jeremy Linton <jeremy.linton@arm.com>, Sudeep Holla
	<sudeep.holla@arm.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Len Brown <lenb@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI/PPTT: fix off-by-one error
Thread-Topic: [PATCH] ACPI/PPTT: fix off-by-one error
Thread-Index: AQHbv0n8fZxPDOFC/UiP9w75yZUSNw==
Date: Wed, 7 May 2025 12:17:22 +0000
Message-ID: <20250507-bruin-gavel-d3a9c0c0@mheyne-amazon>
References: <20250506-draco-taped-15f475cd@mheyne-amazon>
 <20250506-shapeless-merciful-inchworm-7bfdb4@sudeepholla>
 <35895e57-bbe2-4ff9-b1d4-4b70e28ed8a1@arm.com>
 <20250507-argue-rant-9f48ba38@mheyne-amazon>
 <CAJZ5v0gTRcivKKVOx8YhrPyfXJBwL0x+zay9wXrWeod4Lf_Kwg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gTRcivKKVOx8YhrPyfXJBwL0x+zay9wXrWeod4Lf_Kwg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F5C51FEF26083A4B9BAEF0A47B47B1F8@amazon.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, May 07, 2025 at 01:59:12PM +0200, Rafael J. Wysocki wrote:
> On Wed, May 7, 2025 at 1:53???PM Heyne, Maximilian <mheyne@amazon.de> wro=
te:
> >
> > On Tue, May 06, 2025 at 03:11:20PM -0500, Jeremy Linton wrote:
> > > Hi,
> > >
> > > On 5/6/25 8:43 AM, Sudeep Holla wrote:
> > > > On Tue, May 06, 2025 at 01:13:02PM +0000, Heyne, Maximilian wrote:
> > > > > Commit 7ab4f0e37a0f ("ACPI PPTT: Fix coding mistakes in a couple =
of
> > > > > sizeof() calls") corrects the processer entry size but unmasked a=
 longer
> > > > > standing bug where the last entry in the structure can get skippe=
d due
> > > > > to an off-by-one mistake if the last entry ends exactly at the en=
d of
> > > > > the ACPI subtable.
> > > > >
> > > >
> > > > Unless the firmware has populated an incorrect value for the header=
 length, I
> > > > don't see how this is possible. The table_end should point to the a=
ddress
> > > > immediately following the last byte of the table. None of the heade=
rs are only
> > > > one byte long, so what am I missing that could explain this apparent
> > > > off-by-one issue?.
> > >
> > > More likely its because the sizeof() fix was merged without proper re=
view
> > > and is wrong because the type isn't actually known on the object unti=
l the
> > > header is checked.
> >
> > I agree that the type might not be known at this point but the condition
> >
> >         proc_sz =3D sizeof(struct acpi_pptt_processor);
> >           while((unsigned long)entry + proc_sz <=3D table_end)
> >
> > would make sure that there could potentially be a node of type
> > acpi_pptt_processor because there is at least space for it. If the entry
> > can't be of that size because it would go over table_end then it can't
> > be an acpi_pptt_processor.
> =

> I don't follow.
> =

> If it is an acpi_pptt_processor entry, the original condition would be
> sufficient (assuming the correctness of the table header), wouldn't
> it?

On our hardware we have the following situation:
For CPU 63, the acpi_pptt_processor starts at 0xCAA and it has a length
of 0x14. The PPTT table has length 0xCBE. This is exactly the case I'm
describing. You're traversing the entries in the table and arrive at the
last entry but currently you exit the loop because 0xCAA + 0x14 =3D=3D
0xCBE (it's not < 0xCBE which is table_end). So you skip over the last
CPU node.

> =

> > Therefore, I don't think the sizeof() fix is that wrong but we just need
> > to adjust the while condition.
> =

> The sizeof() fix is correct, it makes the code work as designed.
> =

> > Alternatively, we could at least make sure that we can safely access
> > (without crossing table_end) the acpi_subtable_header to check the type.
> =

> Yes.
> =

> > But the current approach seems cleaner to me.
> =

> Why do you think so?

Because the first line in the loop casts straight to
acpi_pptt_processor. That's why I think it makes sense to check the
entry at which you arrived can actually be a acpi_pptt_processor
space-wise.



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


