Return-Path: <linux-acpi+bounces-13570-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29394AADDD7
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 13:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 324203AEB27
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 11:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA5C2580CD;
	Wed,  7 May 2025 11:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="HCe/yMub"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712A9221F13;
	Wed,  7 May 2025 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619015; cv=none; b=RutPVWK1J0jmibInHpA5pohhjVTEDwjS9ru39xSuwRfAGnf+4tlr4TPb8b3Ta/cWL9Wit9HSAsigsOHTyHOv5aPd7ymtXLh+ZTPXQpySyAS6ho23DQ98JJ5Hwd1ev1ry/V99ljEDAEVREP5+VdReCE/454x3NQlSP1URwRTLCRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619015; c=relaxed/simple;
	bh=ZA9Y1wsrZnknMkYvzVK+ptndnHoMfaLcC9neNJrDucc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZTLc7Ic2zoNW24wz+rj1SfnvuylgFSwm4lo7eSf/wN+TGhYJc136W9LUPMdRTmMrnkqDsdblY+WGv8uCxz7ujf8vU3OXBGDY2COqoET78wKaB/IWzVXGPj7mU6rnVtbVqWYyf4oOT/e1tR2KW/PAiQBIGI9e89w9rj5UkMcBs6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=HCe/yMub; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1746619013; x=1778155013;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=7O10eEM9ON4MC+FIalneB31SAD6y2mZuippPzSFTtFg=;
  b=HCe/yMub8ISek11LuSKY7depGrCcNwDiuwd91O5cT7Zx2q58dNHUAIpq
   XH6GQDusG4Oqt2PhWkst1ehGE2FlHMjijnaQFQyHhXa4HahKhJKy5Rtz+
   oIL4QIY9QJGEAXBpSbvJsngcPVLQRWtRZIUf7y4b6DkDHlI5XXhH5rvQ9
   Z+ybciHGUFhT6yLG3UKBRZyRYiLO9MYvCKPFJZeToERXkuNvEY1MpvoOE
   kz8sP1TumBo/ADm+1dWMbeLxkgeW6KPU/nWajYaq7JnRYnJJpXhEv2MmU
   VAHJk6zKzgnMRLjXdO+D4WdB5+MAWnjx2e82pOKHqjth2ERnA8T4ywH44
   w==;
X-IronPort-AV: E=Sophos;i="6.15,269,1739836800"; 
   d="scan'208";a="720515120"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 11:56:50 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:13774]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.25.138:2525] with esmtp (Farcaster)
 id e91dea9c-6454-43c3-b96a-6007bf520f3f; Wed, 7 May 2025 11:56:49 +0000 (UTC)
X-Farcaster-Flow-ID: e91dea9c-6454-43c3-b96a-6007bf520f3f
Received: from EX19D008EUC004.ant.amazon.com (10.252.51.148) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 7 May 2025 11:56:49 +0000
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19D008EUC004.ant.amazon.com (10.252.51.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 7 May 2025 11:56:48 +0000
Received: from EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1]) by
 EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1%3]) with mapi id
 15.02.1544.014; Wed, 7 May 2025 11:56:48 +0000
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
Thread-Index: AQHbv0ccbCDfJtLNeEeomi2x2IfgyQ==
Date: Wed, 7 May 2025 11:56:48 +0000
Message-ID: <20250507-blend-revel-3d94099b@mheyne-amazon>
References: <20250506-draco-taped-15f475cd@mheyne-amazon>
 <20250506-shapeless-merciful-inchworm-7bfdb4@sudeepholla>
 <20250506-dialog-57th-c4e70064@mheyne-amazon>
 <20250507-mysterious-emu-of-fertility-951c69@sudeepholla>
In-Reply-To: <20250507-mysterious-emu-of-fertility-951c69@sudeepholla>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E4B6600F44D354419EF59D2EF5CB70C8@amazon.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, May 07, 2025 at 12:52:18PM +0100, Sudeep Holla wrote:
> On Tue, May 06, 2025 at 08:08:47PM +0000, Heyne, Maximilian wrote:
> > On Tue, May 06, 2025 at 02:43:39PM +0100, Sudeep Holla wrote:
> > > On Tue, May 06, 2025 at 01:13:02PM +0000, Heyne, Maximilian wrote:
> > > > Commit 7ab4f0e37a0f ("ACPI PPTT: Fix coding mistakes in a couple of
> > > > sizeof() calls") corrects the processer entry size but unmasked a l=
onger
> > > > standing bug where the last entry in the structure can get skipped =
due
> > > > to an off-by-one mistake if the last entry ends exactly at the end =
of
> > > > the ACPI subtable.
> > > >
> > > =

> > > Unless the firmware has populated an incorrect value for the header l=
ength, I
> > > don't see how this is possible. The table_end should point to the add=
ress
> > > immediately following the last byte of the table. None of the headers=
 are only
> > > one byte long, so what am I missing that could explain this apparent
> > > off-by-one issue?.
> > > =

> > > -- =

> > > Regards,
> > > Sudeep
> > =

> > Maybe calling it off-by-one is not very exact. You're right table_end
> > points to the address following the last byte *but*
> >   (unsigned long)entry + proc_sz
> > also points to this very byte if it's the last entry. And in this case
> > the while condition is not taken which means we're ignoring the last
> > processor node.
> > =

> > For example, in our specific case the table has a length of 0xCBE and
> > the last processor node entry is at 0xCAA with a length of 0x14 fitting
> > exactly into the table but 0xCAA + 0x14 =3D=3D 0xCBE which turns the
> > condition false.
> > =

> =

> Just to understand, this node is absolutely processor node with no
> private resources ? I find it hard to trust this as most of the CPUs
> do have L1 I&D caches. If they were present the table can't abruptly end
> like this.

Yes looks like it. In our case the ACPI subtable has length 0x14 which is
exactly sizeof(acpi_pptt_processor).



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


