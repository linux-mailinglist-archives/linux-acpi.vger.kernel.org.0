Return-Path: <linux-acpi+bounces-13582-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20358AAE305
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 16:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 474C31B66703
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 14:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946722147F8;
	Wed,  7 May 2025 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="R0BKhuGi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804F378F4F;
	Wed,  7 May 2025 14:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746628167; cv=none; b=DUwo91UmmwOCqUvzwSewsTQwwkRKaBt0VOUBvgrkURoYrzPd9UUsT0diyZPebn7ypqN8aIVo9UERnIRSgDBbv3p5xP03wBrBzRZSvKxMbUcbvy3SmrUSpSiV2KZsUs4gKunpr8obKjqDXbbgW4Cjjui8EWUbflGB+SpiWoTkVhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746628167; c=relaxed/simple;
	bh=0BSGCf5rfHlc987os0Fu9XcUHWkIO5jMgVdMg6PXn1Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hk1A8aylYx5uMIv5ROo8KO03awZegMWxYo2rcS3NsZjPeq5+4TMqesCPbXaQsf4nb2pT4qZshcfPnmkyPe5FWpO8ImyqiT7u9apBVoEJS+ODnaHUsG0Bux2mzT6Gr6Gh8fPNqYK5vjl5MDoeMB5Nl+n4hpnPeC2uFxM7exBARwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=R0BKhuGi; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1746628166; x=1778164166;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=yWJ0HMmQPYJc2RhZj02CtJOJz39SjvXrMxOXkap3Ofo=;
  b=R0BKhuGi8SUsHDx/e+840CU02N8udeMtQlv1ItpeMhmRe0xts8tzg3Rd
   NI1EKA7rndNG7HPkvJ9Nrn7A98Snfcbwlhk9UP5FExjBeMWlgivzzYci7
   6/2LsSXOkYn5+Tv/aqIz22DxGrdzeLYYsL32LuroHPAN86J+cdb0nsHMf
   uiFkb8zs8x+etDhxXVBAaRGtTAok7i1+Z2t6JPLQUd0O4du4pf9riHPh3
   hMeKoTXu1r6hBgGBZ2msQzLEuLdPu17ppTh/nABb4Aon2/TFICFBvYaF4
   gIiG+uUh834SSUr7jr25mQ/4APycTQvPdZDi82eJrfQqyRiLYy4JOpcfy
   w==;
X-IronPort-AV: E=Sophos;i="6.15,269,1739836800"; 
   d="scan'208";a="17449249"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 14:29:20 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:54720]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.32.61:2525] with esmtp (Farcaster)
 id b8372dc8-17c1-4412-9dac-5ff4f0e25d03; Wed, 7 May 2025 14:29:18 +0000 (UTC)
X-Farcaster-Flow-ID: b8372dc8-17c1-4412-9dac-5ff4f0e25d03
Received: from EX19D008EUC003.ant.amazon.com (10.252.51.205) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 7 May 2025 14:29:18 +0000
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19D008EUC003.ant.amazon.com (10.252.51.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 7 May 2025 14:29:17 +0000
Received: from EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1]) by
 EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1%3]) with mapi id
 15.02.1544.014; Wed, 7 May 2025 14:29:17 +0000
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
Thread-Index: AQHbv1xqHHdPuyThMkGwcKsDIcT/2Q==
Date: Wed, 7 May 2025 14:29:17 +0000
Message-ID: <20250507-petit-capri-debaa30d@mheyne-amazon>
References: <20250506-draco-taped-15f475cd@mheyne-amazon>
 <20250506-shapeless-merciful-inchworm-7bfdb4@sudeepholla>
 <20250506-dialog-57th-c4e70064@mheyne-amazon>
 <20250507-mysterious-emu-of-fertility-951c69@sudeepholla>
 <20250507-blend-revel-3d94099b@mheyne-amazon>
 <20250507-quantum-solid-ibex-218f1b@sudeepholla>
 <20250507-autumn-phrase-4a1eddef@mheyne-amazon>
 <20250507-divergent-lori-from-pluto-71daee@sudeepholla>
In-Reply-To: <20250507-divergent-lori-from-pluto-71daee@sudeepholla>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4F4607C6B6FDBE46A5D43E61104AA72E@amazon.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, May 07, 2025 at 01:56:53PM +0100, Sudeep Holla wrote:
> On Wed, May 07, 2025 at 12:42:14PM +0000, Heyne, Maximilian wrote:
> > On Wed, May 07, 2025 at 01:30:53PM +0100, Sudeep Holla wrote:
> > > On Wed, May 07, 2025 at 11:56:48AM +0000, Heyne, Maximilian wrote:
> > > > On Wed, May 07, 2025 at 12:52:18PM +0100, Sudeep Holla wrote:
> > > > > =

> > > > > Just to understand, this node is absolutely processor node with no
> > > > > private resources ? I find it hard to trust this as most of the C=
PUs
> > > > > do have L1 I&D caches. If they were present the table can't abrup=
tly end
> > > > > like this.
> > > > =

> > > > Yes looks like it. In our case the ACPI subtable has length 0x14 wh=
ich is
> > > > exactly sizeof(acpi_pptt_processor).
> > > > =

> > > =

> > > OK, this seem like it is emulated platform with no private resources =
as
> > > it is specified in the other similar patch clearly(QEMU/VM). So this
> > > doesn't match real platforms. Your PPTT is wrong if it is real hardwa=
re
> > > platform as you must have private resources.
> > > =

> > > Anyways if we allow emulation to present CPUs without private resourc=
es
> > > we may have to consider allowing this as the computed pointer will ma=
tch
> > > the table end.
> > =

> > Is there a need by the ACPI specification that the Cache information
> > must come after the processor information? Because on our platform there
> > is Cache and it's described but at a different location seemingly. It
> > looks like caches are described first and then the CPUs.
> >
> =

> That is fine but you must have reference to those caches in the processor
> node and the length of the node won't be 0x14 in that case and you should=
n't
> hit this issue. So if this is real platform, then yes I am must say you
> PPTT is wrong especially if there are caches in the table as you say just
> that processor nodes are not pointing to them correctly then ?

The ACPI tables in our case describe a core first which references the
cache as private resource and then a thread whose parent is the core but
this doesn't have a private resource. This is how it looks like:

[C8Eh 3214   1]                Subtable Type : 00 [Processor Hierarchy Node]
[C8Fh 3215   1]                       Length : 1C
[C90h 3216   2]                     Reserved : 0000
[C92h 3218   4]        Flags (decoded below) : 00000002
                            Physical package : 0
                     ACPI Processor ID valid : 1
                       Processor is a thread : 0
                              Node is a leaf : 0
                    Identical Implementation : 0
[C96h 3222   4]                       Parent : 000000A2
[C9Ah 3226   4]            ACPI Processor ID : 0000003F
[C9Eh 3230   4]      Private Resource Number : 00000002
[CA2h 3234   4]             Private Resource : 00000072
[CA6h 3238   4]             Private Resource : 0000008A

[CAAh 3242   1]                Subtable Type : 00 [Processor Hierarchy Node]
[CABh 3243   1]                       Length : 14
[CACh 3244   2]                     Reserved : 0000
[CAEh 3246   4]        Flags (decoded below) : 0000000E
                            Physical package : 0
                     ACPI Processor ID valid : 1
                       Processor is a thread : 1
                              Node is a leaf : 1
                    Identical Implementation : 0
[CB2h 3250   4]                       Parent : 00000C8E
[CB6h 3254   4]            ACPI Processor ID : 0000003F
[CBAh 3258   4]      Private Resource Number : 00000000

> =

> > I can try to drill even deeper here if you insist. As said I'm no
> > subject matter expert here. But is there something obviously wrong with
> > my patch or would it be ok to just take it?
> >
> =

> Yes you much check your PPTT if it is real hardware platform. I am OK
> with the change in terms of QEMU or VM. You may need to reword commit
> message a bit. I will respond separately.
> =

> -- =

> Regards,
> Sudeep



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


