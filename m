Return-Path: <linux-acpi+bounces-13506-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91203AACEAB
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 22:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18AC97A6C47
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 20:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EF914B086;
	Tue,  6 May 2025 20:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="ke1j2KIO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E1E4B1E58;
	Tue,  6 May 2025 20:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746562132; cv=none; b=QY4TmEzv+HdeRObr+72fJDcq/GibF480UUdC+Cpj360qiHnycS+ubDSelpeF6lnikD9SlsZqWZ+/maCr8jcV3K0dXlHhYsbTjTfQF4KzIqZdYU5dqkhAH8XoN3CroC+b4Ht9xn71YN25GmnAG2JIcpfc2lZG+PxUOd4fkMPUFDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746562132; c=relaxed/simple;
	bh=eGtaT8YHa2NeK+bQ1S1q6NtQdzVxZEmIZRqdE0nnG8I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XS1RNBB4j8FENHROmZPStBATdjifxfJ8uuYeXR6gp+4Y1MYWmSANRhfi/vS4z5rEDyCUyH2tPazwB56wJBOFxy86rxGQkXzvoQYQvwf6dydg2xqgXw62sS5oAzRKWHiju/fZ4U0sjQTKK1Y7LK3vNkcmDxnSh001iyDEpIZ0Ae4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=ke1j2KIO; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1746562132; x=1778098132;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=XgZWLsQQ1oA86ivWixQClpY8pfBKjEwnYDV1vhlMomQ=;
  b=ke1j2KIOkgdUb+fUf0v+zKdHOhse7zAL5Hz4ZOVFScHfOTtyM7KiJsQk
   PatqTdscxSf5Uhvucnxo9njDkZ0qENuj4VDjxLtf0uaO27vbhsZyxU4eK
   Z/zfn1xPg1jafJveJk7Klx2eojamMhMe58JuGASbznoruqMBh0ibIly8h
   M=;
X-IronPort-AV: E=Sophos;i="6.15,267,1739836800"; 
   d="scan'208";a="402665285"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 20:08:50 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:59930]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.45.202:2525] with esmtp (Farcaster)
 id 32e0986e-25b2-4c4a-923a-248d30395490; Tue, 6 May 2025 20:08:48 +0000 (UTC)
X-Farcaster-Flow-ID: 32e0986e-25b2-4c4a-923a-248d30395490
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 6 May 2025 20:08:47 +0000
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19D008EUC001.ant.amazon.com (10.252.51.165) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 6 May 2025 20:08:47 +0000
Received: from EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1]) by
 EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1%3]) with mapi id
 15.02.1544.014; Tue, 6 May 2025 20:08:47 +0000
From: "Heyne, Maximilian" <mheyne@amazon.de>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Ard Biesheuvel
	<ardb@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI/PPTT: fix off-by-one error
Thread-Topic: [PATCH] ACPI/PPTT: fix off-by-one error
Thread-Index: AQHbvsKtPvPHOudq9EiKfnbEmFnf/w==
Date: Tue, 6 May 2025 20:08:47 +0000
Message-ID: <20250506-dialog-57th-c4e70064@mheyne-amazon>
References: <20250506-draco-taped-15f475cd@mheyne-amazon>
 <20250506-shapeless-merciful-inchworm-7bfdb4@sudeepholla>
In-Reply-To: <20250506-shapeless-merciful-inchworm-7bfdb4@sudeepholla>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1F9E7353BFA2664393D7E4C8429FA22B@amazon.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, May 06, 2025 at 02:43:39PM +0100, Sudeep Holla wrote:
> On Tue, May 06, 2025 at 01:13:02PM +0000, Heyne, Maximilian wrote:
> > Commit 7ab4f0e37a0f ("ACPI PPTT: Fix coding mistakes in a couple of
> > sizeof() calls") corrects the processer entry size but unmasked a longer
> > standing bug where the last entry in the structure can get skipped due
> > to an off-by-one mistake if the last entry ends exactly at the end of
> > the ACPI subtable.
> >
> =

> Unless the firmware has populated an incorrect value for the header lengt=
h, I
> don't see how this is possible. The table_end should point to the address
> immediately following the last byte of the table. None of the headers are=
 only
> one byte long, so what am I missing that could explain this apparent
> off-by-one issue?.
> =

> -- =

> Regards,
> Sudeep

Maybe calling it off-by-one is not very exact. You're right table_end
points to the address following the last byte *but*
  (unsigned long)entry + proc_sz
also points to this very byte if it's the last entry. And in this case
the while condition is not taken which means we're ignoring the last
processor node.

For example, in our specific case the table has a length of 0xCBE and
the last processor node entry is at 0xCAA with a length of 0x14 fitting
exactly into the table but 0xCAA + 0x14 =3D=3D 0xCBE which turns the
condition false.

Disclaimer: I'm not an expert in this topic but stumbled upon this bug
when looking at the latest kernels.



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


