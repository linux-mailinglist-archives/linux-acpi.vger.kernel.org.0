Return-Path: <linux-acpi+bounces-8677-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF13C997C89
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Oct 2024 07:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4775DB2369D
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Oct 2024 05:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EE819DF9A;
	Thu, 10 Oct 2024 05:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="cZkh0htR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AM3EOCLp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E7119D89B;
	Thu, 10 Oct 2024 05:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728538860; cv=none; b=IO/f3cVY9iOAZ2fAoVnZ5d2PfN98wGsnjCrgffweyWMJGtHp936dusrvD4cPZR4x6gFkAiJfg/kw/PKgZ9+UB48QprK9AyJUf3Yn0X6nF4O0XOrBdQKi5IFPmwXLk2VmBc9+TwBhJzMZVDAQ+GCJQ2BRNOWUQBaTAABIfo407FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728538860; c=relaxed/simple;
	bh=YVwKYlhz4xT7en7AOUus58/Rtpt3YtkNqgNo1EDaBEs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VrZKa3GAad2SuptYpXLzwthD9X3EXwzSuu4g+3rdlcdtH4d8ULstszbYOp93XJSrDWKlr46frfzKoHFvTy7gvJiKGXLiC6aHH3qTDruf6IHWKQxV+y+yLtQwb2Bnj8oMmmhTEtIt/NyFbPo0ebLWZ3t2nWyxdm8UJ5+NdGDgclA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=cZkh0htR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AM3EOCLp; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 27B10114028D;
	Thu, 10 Oct 2024 01:40:56 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 10 Oct 2024 01:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728538856;
	 x=1728625256; bh=Mu8BnObLQOiBpv7WxnsOaiY49X/FV0hRFGNM1f9tNgE=; b=
	cZkh0htROGtG1oB0UDOvaL6j040WHwf9ZPqBhB8Xe+f9y68fpZTurdWehkaumECj
	CZHEZhvkaaHmwX3s2F5qUiBenmAUIk8kw5EAeZSNF0kaf/RD/iyOeep31hMYXoGn
	IGIH9uePBI5kiVeGcWGmGYlqbmaDD978rvQdxIqM0yv575NC7En2X+l86b4+1SwA
	b5gjD3pQMeZ7fogA3hhKoB/OjvraX8tVn9hgXLEOL3tcZgmkMwOlib34d7mkKbD9
	xqtntrFux5y7z42+d2/4dGKejAKZFWHKbHHVtwKO5SSvJVaFMYUkwOP4YElMqd0u
	na1cPhu561mMYJlo8exZ1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728538856; x=
	1728625256; bh=Mu8BnObLQOiBpv7WxnsOaiY49X/FV0hRFGNM1f9tNgE=; b=A
	M3EOCLp0vkswktvFf1IQWpE0uclBLVAWYzFcoLkHwPhOXr2gAE+C8rsELU2mvrr4
	bRhhneuKQLGl9mFr62QvX5z3ZeFmgR1H8wfUF2zTFfBBuTuPbXgeHHmVmaj5Og4y
	64uvsIZpd5S6wQTVX4Np5PKyv617N74eKV1qiOG/g9hEj0sO/LkCIZR4f8v6Ppja
	+IDof2yqqBVdDCgTcdoVUHSSqxaBlzQ1O1zMld3tISo+OiIbtRrZI/kroLE0+apK
	XAY143JUgx8SzcwiGyv4RbeP022ltRCuLDwZNJyes0hIEASmIf2mdSiv4E/wAjk8
	33F0OO1ncPXXnL/fx30Ag==
X-ME-Sender: <xms:5mgHZ99tg_UO8iEtqIi9a20_DUReLA_bsuhu9K7FA-tbI0KrKnGn0A>
    <xme:5mgHZxs-NpE99PneD5fvGDNN-RhY3RRx9-Hwa9zzW2FT52_rXVGJoYKba3GszET6r
    uWKRNTkXHx9IKS2jpo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefgedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvleehvddv
    geejvdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpd
    hrtghpthhtohepjhgrmhgvshdrmhhorhhsvgesrghrmhdrtghomhdprhgtphhtthhopehj
    ohhnrghthhgrnhdrtggrmhgvrhhonheshhhurgifvghirdgtohhmpdhrtghpthhtoheprh
    hosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepthhonhihrdhl
    uhgtkhesihhnthgvlhdrtghomhdprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhgvnhgssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghf
    rggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgthhhnvghllhgvsehlihhnuh
    igrdhisghmrdgtohhm
X-ME-Proxy: <xmx:5mgHZ7ALKTL1DpFvnxO2QYC8Q-WEwKXHk1OVm-vphMkabqCJI0G3dA>
    <xmx:5mgHZxeGHec4xxRcOBhf0c3p24qwsOyduS0n-5unOwpc3h0-ADcNhA>
    <xmx:5mgHZyOGgrnaErX_H-5rJnXD1eGUlaTnQBG0EjMKnelRa_49FxVh6A>
    <xmx:5mgHZzkrQcRe16COoXUPCdIiPrcJrRr0pnV8K9kVoHyxhaCC2N5_gw>
    <xmx:6GgHZ8vfvpbelgoC2cVFMfkH6tjFUpRNOzq0B_RbCj25oq2PHaw3da98>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6359D2220071; Thu, 10 Oct 2024 01:40:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Oct 2024 05:40:33 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: "Arnd Bergmann" <arnd@kernel.org>,
 "Robert Moore" <robert.moore@intel.com>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>, "Len Brown" <lenb@kernel.org>,
 "James Morse" <james.morse@arm.com>, "Tony Luck" <tony.luck@intel.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 "Sunil V L" <sunilvl@ventanamicro.com>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev
Message-Id: <a06460f0-2779-40a6-bb1e-5b1a904fcca5@app.fastmail.com>
In-Reply-To: 
 <CAJZ5v0jBY91TDXPMfmLPeoDLeQCKFD+sHBgkOwPusQAMpZJc6A@mail.gmail.com>
References: <20241004204845.970951-1-arnd@kernel.org>
 <CAJZ5v0immr4obYsu2qNKKY2DKxzLDR1a=6B4xY_YTHfPF5kADg@mail.gmail.com>
 <641307d3-3fe5-401a-ba22-96ad5ef25fed@app.fastmail.com>
 <CAJZ5v0jBY91TDXPMfmLPeoDLeQCKFD+sHBgkOwPusQAMpZJc6A@mail.gmail.com>
Subject: Re: [PATCH] acpi: allow building without CONFIG_HAS_IOPORT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024, at 19:40, Rafael J. Wysocki wrote:
> On Mon, Oct 7, 2024 at 9:23=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> index 61ca4afe83dc..132357815324 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -41,7 +41,7 @@ acpi-y                                +=3D resource=
.o
>>  acpi-y                         +=3D acpi_processor.o
>>  acpi-y                         +=3D processor_core.o
>>  acpi-$(CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC) +=3D processor_pdc.o
>> -acpi-y                         +=3D ec.o
>> +acpi-$(CONFIG_HAS_IOPORT)      +=3D ec.o
>>  acpi-$(CONFIG_ACPI_DOCK)       +=3D dock.o
>>  acpi-$(CONFIG_PCI)             +=3D pci_root.o pci_link.o pci_irq.o
>>  obj-$(CONFIG_ACPI_MCFG)                +=3D pci_mcfg.o
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index 16917dc3ad60..535d6a72ce1b 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -1356,7 +1356,8 @@ static int __init acpi_bus_init(void)
>>          * Do that before calling acpi_initialize_objects() which may=
 trigger EC
>>          * address space accesses.
>>          */
>> -       acpi_ec_ecdt_probe();
>> +       if (IS_ENABLED(CONFIG_HAS_IOPORT))
>> +               acpi_ec_ecdt_probe();
>>
>>         status =3D acpi_enable_subsystem(ACPI_NO_ACPI_ENABLE);
>>         if (ACPI_FAILURE(status)) {
>> @@ -1391,7 +1392,8 @@ static int __init acpi_bus_init(void)
>>          * Maybe EC region is required at bus_scan/acpi_get_devices. =
So it
>>          * is necessary to enable it as early as possible.
>>          */
>> -       acpi_ec_dsdt_probe();
>> +       if (IS_ENABLED(CONFIG_HAS_IOPORT))
>> +               acpi_ec_dsdt_probe();
>
> The above two changes mean that it is not necessary to compile either
> acpi_ec_ecdt_probe() or acpi_ec_dsdt_probe() at all if
> CONFIG_HAS_IOPORT is not enabled.

Correct, this is a result of removing ec.o from the list of objects.

>>         pr_info("Interpreter enabled\n");
>>
>> @@ -1464,7 +1466,8 @@ static int __init acpi_init(void)
>>         acpi_arm_init();
>>         acpi_riscv_init();
>>         acpi_scan_init();
>> -       acpi_ec_init();
>> +       if (IS_ENABLED(CONFIG_HAS_IOPORT))
>> +               acpi_ec_init();
>
> And this means that the whole EC driver is not going to work at all th=
en.

Correct. The way I read ec.c it makes no sense if acpi_ec_write_cmd()
and acpi_ec_write_data() don't actually access the registers. Is
there anything in ec.c that still makes sense without port I/O?

>> diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processo=
r_perflib.c
>> index 4265814c74f8..8be453d89ef8 100644
>> --- a/drivers/acpi/processor_perflib.c
>> +++ b/drivers/acpi/processor_perflib.c
>> @@ -455,7 +455,8 @@ int acpi_processor_pstate_control(void)
>>  {
>>         acpi_status status;
>>
>> -       if (!acpi_gbl_FADT.smi_command || !acpi_gbl_FADT.pstate_contr=
ol)
>> +       if (!IS_ENABLED(CONFIG_HAS_IOPORT) ||
>> +           !acpi_gbl_FADT.smi_command || !acpi_gbl_FADT.pstate_contr=
ol)
>>                 return 0;
>
> All of the existing callers of acpi_processor_pstate_control() are x86
> which has CONFIG_HAS_IOPORT AFAICS.
>
> And if you care about the code size, acpi_processor_notify_smm() can
> go away for !CONFIG_HAS_IOPORT too.
>
>>         pr_debug("Writing pstate_control [0x%x] to smi_command [0x%x]=
\n",
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index 7ecc401fb97f..9d5e6dd542bf 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -2293,7 +2293,8 @@ static int acpi_bus_attach(struct acpi_device *=
device, void *first_pass)
>>         if (device->handler)
>>                 goto ok;
>>
>> -       acpi_ec_register_opregions(device);
>> +       if (IS_ENABLED(CONFIG_HAS_IOPORT))
>> +               acpi_ec_register_opregions(device);
>
> I'd rather have an empty stub of acpi_ec_register_opregions() for
> !CONFIG_HAS_IOPORT instead.

Fair enough. Should I add stubs for all the global EC functions then?
I also wonder if there should be a separate CONFIG_ACPI_EC symbol
that allows the EC logic to be turned off on non-x86 architectures
even when HAS_IOPORT is otherwise enabled.=20

      Arnd

