Return-Path: <linux-acpi+bounces-13575-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 975D4AADF6A
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 14:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949F63B2041
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 12:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B98280029;
	Wed,  7 May 2025 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="Ythp8r9N"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60545258CD7;
	Wed,  7 May 2025 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746621742; cv=none; b=s9XHXZkHml4tCeWqBalCe9ZeAQwTwSj2YwKHhuC0sqI5yRXz9TdxxHbuSuOqR36viimkPp4l34XnHqWIJnO4YH6nWYS0xTVjbMqj9OkP/yi88I7lLSo/itkzp2auropgSRhuPswAOYUmQxEmSQLjpRxc0pExEwMQQXM6EqIB8Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746621742; c=relaxed/simple;
	bh=xcl+DVUCBVGwS4tk7tt7JhUeBoLQFsx0goUXJ9bECFw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b/5dDw9zcO02PBWRgDPJEc1fMzxaBY6UhFkr4OZpEooOD7Q6jvDizyhsuQvGbSpmXWn28BAyVfiPbMsecATRVZaDqLsRJaFvESDVSLEa6wAzbnDR/cJidMcVQS+zABzgiOgQG1ANOvlXM+XEu+8Hv98glTsg9DsPQAdv/yRowQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=Ythp8r9N; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1746621741; x=1778157741;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=xcl+DVUCBVGwS4tk7tt7JhUeBoLQFsx0goUXJ9bECFw=;
  b=Ythp8r9NFNWU0HswYy6+5MjFhorzIDW3THx9mlfCKmqShQGVU1JMUuXI
   U3V8+Smp2tU9Aeks1RF/IvtPlurMkHa27jrVUbegNdjAqZ6anaQdUvR/K
   fJR0of2Ohto2EIC6E7Dpwt6Lf7irLizN8Qfdkz5k8MLUieghue9DtKkdS
   AtHRqFsDcE/glkJvShhgf9+xInByPRdJsqb+Fj1X3aM8il8sR/EyHigaJ
   BgxcasdS0ZGJMUGKwCByKLZwuEdfI48/vo98GEhQZ6BuD0aps5DN3xLx/
   iHjb5p664rWxtzR8xNkeC0S3vcUs0pWgWSOAv/X38Pdw7RzqQbSQx0tUc
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,269,1739836800"; 
   d="scan'208";a="295395097"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 12:42:18 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.10.100:1686]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.12.172:2525] with esmtp (Farcaster)
 id f6c7f54a-6d1b-4037-8a4a-1376fe21f347; Wed, 7 May 2025 12:42:15 +0000 (UTC)
X-Farcaster-Flow-ID: f6c7f54a-6d1b-4037-8a4a-1376fe21f347
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 7 May 2025 12:42:15 +0000
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19D008EUC001.ant.amazon.com (10.252.51.165) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 7 May 2025 12:42:15 +0000
Received: from EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1]) by
 EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1%3]) with mapi id
 15.02.1544.014; Wed, 7 May 2025 12:42:14 +0000
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
Thread-Index: AQHbv0114M7qx/B8dkqeDaMIhaZebQ==
Date: Wed, 7 May 2025 12:42:14 +0000
Message-ID: <20250507-autumn-phrase-4a1eddef@mheyne-amazon>
References: <20250506-draco-taped-15f475cd@mheyne-amazon>
 <20250506-shapeless-merciful-inchworm-7bfdb4@sudeepholla>
 <20250506-dialog-57th-c4e70064@mheyne-amazon>
 <20250507-mysterious-emu-of-fertility-951c69@sudeepholla>
 <20250507-blend-revel-3d94099b@mheyne-amazon>
 <20250507-quantum-solid-ibex-218f1b@sudeepholla>
In-Reply-To: <20250507-quantum-solid-ibex-218f1b@sudeepholla>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <75972120DDD3DE4084D8C4FBFE95DF15@amazon.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, May 07, 2025 at 01:30:53PM +0100, Sudeep Holla wrote:
> On Wed, May 07, 2025 at 11:56:48AM +0000, Heyne, Maximilian wrote:
> > On Wed, May 07, 2025 at 12:52:18PM +0100, Sudeep Holla wrote:
> > > =

> > > Just to understand, this node is absolutely processor node with no
> > > private resources ? I find it hard to trust this as most of the CPUs
> > > do have L1 I&D caches. If they were present the table can't abruptly =
end
> > > like this.
> > =

> > Yes looks like it. In our case the ACPI subtable has length 0x14 which =
is
> > exactly sizeof(acpi_pptt_processor).
> > =

> =

> OK, this seem like it is emulated platform with no private resources as
> it is specified in the other similar patch clearly(QEMU/VM). So this
> doesn't match real platforms. Your PPTT is wrong if it is real hardware
> platform as you must have private resources.
> =

> Anyways if we allow emulation to present CPUs without private resources
> we may have to consider allowing this as the computed pointer will match
> the table end.

Is there a need by the ACPI specification that the Cache information
must come after the processor information? Because on our platform there
is Cache and it's described but at a different location seemingly. It
looks like caches are described first and then the CPUs.

I can try to drill even deeper here if you insist. As said I'm no
subject matter expert here. But is there something obviously wrong with
my patch or would it be ok to just take it?



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


