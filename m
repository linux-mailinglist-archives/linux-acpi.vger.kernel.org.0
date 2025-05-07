Return-Path: <linux-acpi+bounces-13568-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CC3AADDC9
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 13:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEA991B63376
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 11:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49673257AF9;
	Wed,  7 May 2025 11:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="NCo5Qiel"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6FA1F17E8;
	Wed,  7 May 2025 11:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746618828; cv=none; b=h2XHUZjNq3tO0cCwxqLE40tthYAUDkkjZtJMyCnXVNmtMSvwNa0qQjaYT6GEwRxKY8bZVraoIFUDLcyVs3tYHo94Og8lez5jCAR6qHoyjwLTC2ERywf/uLU9Z8qlIGVcdvGOlM64dhbyuhSCOrsheT7S87dPJm7t2BGFt7FdwhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746618828; c=relaxed/simple;
	bh=3Mvx4gS4UCJGhJqVQabDRGH7Ae1Hmq8fMWFbmn3ZEAQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aEKbP7pScDTkRpyRIPNb+bupRfA4ei7shHVrF8OOyb3sNg5N0TsOZYl3VsuzCOoQoo/7V1vo73ZIdkZweXvhLR6VpluhqzeFqz0F0BXyup5imMAKehYfYohYFyD14o9p6JlOHE7JYlAjvQbhRYPr/K3qwFa+Vfi4vfMgTae5P/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=NCo5Qiel; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1746618826; x=1778154826;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=9H6IB1t05Wk4CPRCOrMkbFz+/zLlqKfD3q7NfPAHCKA=;
  b=NCo5QielITX6YnRlIoQEB6PUn5uQF0oTTb/rMJeP4gAIke1pgsHqoOQ4
   a/dFkGJSFZ9q+rQtLkWv7KPPbOr8OtRu+f+bSQ7XZ+3SKq3KiuN1FcMJT
   1T4nkHDMeqYHpMhfdjhQXfYIvpBeyZl6WuQn+dXL2IWyg5wL2g74UPPhP
   2iIva7Q9FXZGNb07vnGOtvY1DjQa8AQyKx4Tfg2ILLZ1LL/BT71LwekX4
   gbeNR8tbXhUjt+twBbEwyaGlBCvsxfirZO/aofkrvr+9t6KFNrR+0eDcu
   ZumB698AkGcYb5Ief/GiwvL4rPfXetAzwtVICuSCbU1W1MaDFMzX7nGPb
   A==;
X-IronPort-AV: E=Sophos;i="6.15,269,1739836800"; 
   d="scan'208";a="17398127"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 11:53:39 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:35612]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.24.249:2525] with esmtp (Farcaster)
 id 77eb41e8-f9ab-4c1f-a112-3990db12ac9a; Wed, 7 May 2025 11:53:38 +0000 (UTC)
X-Farcaster-Flow-ID: 77eb41e8-f9ab-4c1f-a112-3990db12ac9a
Received: from EX19D008EUC003.ant.amazon.com (10.252.51.205) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 7 May 2025 11:53:38 +0000
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19D008EUC003.ant.amazon.com (10.252.51.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 7 May 2025 11:53:38 +0000
Received: from EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1]) by
 EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1%3]) with mapi id
 15.02.1544.014; Wed, 7 May 2025 11:53:38 +0000
From: "Heyne, Maximilian" <mheyne@amazon.de>
To: Jeremy Linton <jeremy.linton@arm.com>
CC: Sudeep Holla <sudeep.holla@arm.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI/PPTT: fix off-by-one error
Thread-Topic: [PATCH] ACPI/PPTT: fix off-by-one error
Thread-Index: AQHbv0arMRX/gskFdkix2YX2FUmtIw==
Date: Wed, 7 May 2025 11:53:38 +0000
Message-ID: <20250507-argue-rant-9f48ba38@mheyne-amazon>
References: <20250506-draco-taped-15f475cd@mheyne-amazon>
 <20250506-shapeless-merciful-inchworm-7bfdb4@sudeepholla>
 <35895e57-bbe2-4ff9-b1d4-4b70e28ed8a1@arm.com>
In-Reply-To: <35895e57-bbe2-4ff9-b1d4-4b70e28ed8a1@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2476D48D943DCC429522F5546EF3921F@amazon.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, May 06, 2025 at 03:11:20PM -0500, Jeremy Linton wrote:
> Hi,
> =

> On 5/6/25 8:43 AM, Sudeep Holla wrote:
> > On Tue, May 06, 2025 at 01:13:02PM +0000, Heyne, Maximilian wrote:
> > > Commit 7ab4f0e37a0f ("ACPI PPTT: Fix coding mistakes in a couple of
> > > sizeof() calls") corrects the processer entry size but unmasked a lon=
ger
> > > standing bug where the last entry in the structure can get skipped due
> > > to an off-by-one mistake if the last entry ends exactly at the end of
> > > the ACPI subtable.
> > > =

> > =

> > Unless the firmware has populated an incorrect value for the header len=
gth, I
> > don't see how this is possible. The table_end should point to the addre=
ss
> > immediately following the last byte of the table. None of the headers a=
re only
> > one byte long, so what am I missing that could explain this apparent
> > off-by-one issue?.
> =

> More likely its because the sizeof() fix was merged without proper review
> and is wrong because the type isn't actually known on the object until the
> header is checked.

I agree that the type might not be known at this point but the condition

  	proc_sz =3D sizeof(struct acpi_pptt_processor);
	  while((unsigned long)entry + proc_sz <=3D table_end)

would make sure that there could potentially be a node of type
acpi_pptt_processor because there is at least space for it. If the entry
can't be of that size because it would go over table_end then it can't
be an acpi_pptt_processor.

Therefore, I don't think the sizeof() fix is that wrong but we just need
to adjust the while condition.

Alternatively, we could at least make sure that we can safely access
(without crossing table_end) the acpi_subtable_header to check the type.
But the current approach seems cleaner to me.



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


