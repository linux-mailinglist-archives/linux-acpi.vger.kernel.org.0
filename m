Return-Path: <linux-acpi+bounces-15177-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4399FB06E00
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 08:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4619A1893639
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 06:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE8F239E60;
	Wed, 16 Jul 2025 06:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mngyDJzY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2047A10A1E;
	Wed, 16 Jul 2025 06:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752647433; cv=none; b=pQOb9VPF0PjOQNF5b7MaZeNrHuCcOkYNA8o4974ex76DI6taQ4ZUCwCGQF2ptkzfvR/ZZoZX3RdXKJurijXPTJNPqNlAcE87uA07ijBmHaqF5UgC3VzkEhvwCYHceOqyeEFGzLsj0K2/SND8At3CN8dE0gqMfai43biLNh2zlFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752647433; c=relaxed/simple;
	bh=cPXUdocH7BWiamPELQtEXH5v8MfZzzXrf+na9+ySFAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n19xTH/5nVodthwDkSFg0FuwTwkcaynarpMBjjrWi4zk1aEIm9m6obOhPeoRW3BUpiU9KIJDASgjeCCsEhkRrpaz/x89xAp8b2tRgPui9TWgIvFBDFZIoEh5UUXrg9cm1dTT5RfT5S8q7I0Tf9LuBpWwNllIBP+JXgnxFiQeAis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mngyDJzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2166C4CEF0;
	Wed, 16 Jul 2025 06:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752647432;
	bh=cPXUdocH7BWiamPELQtEXH5v8MfZzzXrf+na9+ySFAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mngyDJzYxswRUKAor6BhdCDEeP7/f1/WiEGIIktBpmkL1q/z1WzrIyXvEqGHnI7Kf
	 CErmAEVuxZN3MYZi85Fk9HbQLBelB6pX8ZCDI6WKshBqXohNFkMGBDJXIRTsr35vTh
	 bU+biH50xCXMqTG2Gj3VDYxVU4W+ke5fZ+5we6tIwB5KZ9RLMYLud4ioG2rp7paTTX
	 6tD7SqlhNlrXWrst7wCeVm3RvAZPuXMEwUKqdymbqipTSjRsA/4CH0lw1SsGZDA7A3
	 RIF6UKmz39KCqObBiQkuHBwtf5vg2a29vnRjpicoqjUXmndoDDPBz8CKmFap61O6LT
	 D7tV9HPzzODWA==
Date: Wed, 16 Jul 2025 08:30:26 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>,
 Alexander Graf <graf@amazon.com>, Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>, Peter Gonda <pgonda@google.com>, "Luck, Tony"
 <tony.luck@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
 <lenb@kernel.org>, James Morse <james.morse@arm.com>, "Moore, Robert"
 <robert.moore@intel.com>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "acpica-devel@lists.linux.dev"
 <acpica-devel@lists.linux.dev>, "kernel-team@meta.com"
 <kernel-team@meta.com>
Subject: Re: [PATCH] ghes: Track number of recovered hardware errors
Message-ID: <20250716083026.1737fdb4@foz.lan>
In-Reply-To: <564e0deb-73f0-449f-9d0f-181311d3a348@linux.alibaba.com>
References: <20250714171040.GOaHU6EKH2xxSZFnZd@fat_crate.local>
	<SJ1PR11MB6083C38E6DA922E05E1748D6FC54A@SJ1PR11MB6083.namprd11.prod.outlook.com>
	<20250714173556.GQaHU__LL6IUIPCDIW@fat_crate.local>
	<aHWC-J851eaHa_Au@agluck-desk3>
	<20250715082939.GAaHYRc3Yn49jyvYzc@fat_crate.local>
	<kyprjdilgyz3xgw3slnrsemptnpp6h75mipv6a3lgp2dmwqekg@s7azbepy7nu2>
	<20250715103125.GFaHYt_TnFQW6ti0ST@fat_crate.local>
	<vs5x5qvw2veurxdljmdiumqpseze2myx6quw3rmt7li7d3dbin@duoky4z44zzz>
	<20250715125327.GGaHZPRz9QLNNO-7q8@fat_crate.local>
	<68b6961c-4443-48a8-a7f7-ed94f3352d7d@linux.alibaba.com>
	<20250715150947.GAaHZvOxsvEvALZNDd@fat_crate.local>
	<564e0deb-73f0-449f-9d0f-181311d3a348@linux.alibaba.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Wed, 16 Jul 2025 10:05:27 +0800
Shuai Xue <xueshuai@linux.alibaba.com> escreveu:

> =E5=9C=A8 2025/7/15 23:09, Borislav Petkov =E5=86=99=E9=81=93:
> > On Tue, Jul 15, 2025 at 09:46:03PM +0800, Shuai Xue wrote: =20
> >> For the purpose of counting, how about using the cmdline of rasdaemon?=
 =20
> >=20
> > That would mean you have to run rasdaemon on those machines before they
> > explode and then carve out the rasdaemon db from the coredump (this is
> > post-mortem analysis). =20
>=20
> Rasdaemon is a userspace tool that will collect all hardware error=20
> events reported by the Linux Kernel from several sources (EDAC, MCE,=20
> PCI, ...) into one common framework. And it has been a standard tools
> in Alibaba. As far as I know, twitter also use Rasdaemon in its productio=
n.

There are several others using rasdaemon, afaikt. It was originally
implemented due to a demand from supercomputer customers with thousands
of nodes in US, and have been shipped on major distros for quite a while.

>=20
> >=20
> > I would love for rasdaemon to log over the network and then other tools=
 can
> > query those centralized logs but that has its own challenges...
> >  =20
>=20
> I also prefer collecting rasdaemon data in a centralized data center, as=
=20
> this is more beneficial for using big data analytics to analyze and=20
> predict errors. At the same time, the centralized side also uses=20
> rasdaemon logs as one of the references for machine operations and=20
> maintenance.
>=20
> As for rasdaemon itself, it is just a single-node event collector and=20
> database, although it does also print logs. In practice, we use SLS [1]=20
> to collect rasdaemon text logs from individual nodes and parse them on=20
> the central side.

Well, rasdaemon already uses SQL commands to store on its SQLite database.

It shouldn't be hard to add a patch series to optionally use a centralized
database directly. My only concern is that delivering logs to an external
database on a machine that has hardware errors can be problematic and
eventually end losing events.

Also, supporting different databases can be problematic due to the
libraries they require. Last time I wrote a code to write to an Oracle
DB (a life-long time ago), the number of the libraries that were required
were huge. Also, changing the order with "-l" caused ld to not find the
right objects. It was messy. Ok, supporting MySQL and PostgreSQL is not
that hard.

Perhaps a good compromise would be to add a logic there to open a local
socket or a tcp socket with a logger daemon, sending the events asynchronou=
sly
after storing locally at SQLite. Then, write a Python script using SQLAlche=
my.=20
This way, we gain for free support for several different databases.


Thanks,
Mauro

