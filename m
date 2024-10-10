Return-Path: <linux-acpi+bounces-8679-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0447C998311
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Oct 2024 12:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7835B1F21E74
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Oct 2024 10:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E7F1BDA9B;
	Thu, 10 Oct 2024 10:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtFV11m8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2151BBBF7;
	Thu, 10 Oct 2024 10:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728554491; cv=none; b=oo7YI8S3lBvoamYQXU7nIWUDBY3iaKfopSCXi0/Nx7ul5LTYNZ6s/mOY42EChBPqgn+8iRZr070MTCyBpUGo/D+z1p/2vPp1aBgozeQ8AwUHf9m7KHJsRYiPqaHPxgR2+nzdIx5MMBPbPCP+FoSVzOj08Y/81dK1i0vWULjyZGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728554491; c=relaxed/simple;
	bh=n5Zp6gdmhvbmwbmdIrkDEzYVm1om2vT3AoMt9Vajij4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OokEln9R174FooqXNNWoU1JPUrpF3Ct5ofkjKxk/ubcb7QqgFj0cbdF6AoDCzk5vrNOFb3ObFafUVI0Bj6bE0kLGjZNZRgchNOZBBCpyNhTro4P+Gqkcc5/hetViKas96H2Kez0mXehIFkLoqYesIzlbiUeXLN1qSZwnt3e/90c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtFV11m8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209BBC4CED5;
	Thu, 10 Oct 2024 10:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728554491;
	bh=n5Zp6gdmhvbmwbmdIrkDEzYVm1om2vT3AoMt9Vajij4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CtFV11m87dWMe3LVi+JsFuB7ZzOnjlXjt8cUoi82axO6RS/AmojQcVncb98jaCvZi
	 m9XyLRzTFf+EobnMJCBvZmdP8if3+rBMOTZqfWcOyCugCQ54KK+pPTFpht6l5qoYqJ
	 pIFrjpyZku6iDRalEMdZLxnsOAeIUXMg+DfwBpEgl+L9a4lRCJsEN+ae88Y+r6E1Aq
	 PXNqxrap7OMyHcfhzkz/w8EZthXSrioxvAgv4essfNT1B3SYJxJlyGm+1KXxjpPTMH
	 oXOkOHNzfpINdR4fAIlEAw3gqVHyNog7jE9xSNLBjwz17UB4zTqJA8lcY+3GegsKEy
	 37QQFiPN84MMw==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e0719668e8so289496b6e.0;
        Thu, 10 Oct 2024 03:01:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUzQcvbsG6QTLdOE2ll7j8UYX1JRnKMSmhnRkV1r7fQmDLZou8UoH76pn87d3SeM3Ig8sQ65tDxNUl8@vger.kernel.org, AJvYcCWwF2YaSyvwl/7mmDcw4uYljyBCSMcTyz4rQuK/Q648j8m6Y3gRQH9WM63/2H5g6be1hhsAESmNWHfqpCzI@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb5On8fK5aJ/IirDbt6UuaY8TQsmUtOXvz5ddSJ3THI60fw+zS
	h737+4s6Y6Gdp07dmG6ZcG8YMQ+TxM1LFBCE1fedg6KsQXPU4zOXxCr36KYZQ6fSrLudV6cvMn4
	t7AdAVy6A3jVsZCkfLZNH6zkGf9c=
X-Google-Smtp-Source: AGHT+IFxafHo+JyQ1hf/GPawKw1+TkTDTc5Gg6D2CVYitq2SPIK1psVljYw1UzvQW0QSFGLKeUwpCR0Umn5/+C8P+uE=
X-Received: by 2002:a05:6871:686:b0:277:7633:f50b with SMTP id
 586e51a60fabf-288342dd615mr3712561fac.16.1728554490275; Thu, 10 Oct 2024
 03:01:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004204845.970951-1-arnd@kernel.org> <CAJZ5v0immr4obYsu2qNKKY2DKxzLDR1a=6B4xY_YTHfPF5kADg@mail.gmail.com>
 <641307d3-3fe5-401a-ba22-96ad5ef25fed@app.fastmail.com> <CAJZ5v0jBY91TDXPMfmLPeoDLeQCKFD+sHBgkOwPusQAMpZJc6A@mail.gmail.com>
 <a06460f0-2779-40a6-bb1e-5b1a904fcca5@app.fastmail.com>
In-Reply-To: <a06460f0-2779-40a6-bb1e-5b1a904fcca5@app.fastmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 10 Oct 2024 12:01:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iW5d=gx_7aDge0_0sR5mSC1j=7ew+Mj8GDgcxQ3jQgpg@mail.gmail.com>
Message-ID: <CAJZ5v0iW5d=gx_7aDge0_0sR5mSC1j=7ew+Mj8GDgcxQ3jQgpg@mail.gmail.com>
Subject: Re: [PATCH] acpi: allow building without CONFIG_HAS_IOPORT
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Niklas Schnelle <schnelle@linux.ibm.com>, 
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
	Borislav Petkov <bp@alien8.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 7:40=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Wed, Oct 9, 2024, at 19:40, Rafael J. Wysocki wrote:
> > On Mon, Oct 7, 2024 at 9:23=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wr=
ote:
> >> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> >> index 61ca4afe83dc..132357815324 100644
> >> --- a/drivers/acpi/Makefile
> >> +++ b/drivers/acpi/Makefile
> >> @@ -41,7 +41,7 @@ acpi-y                                +=3D resource.=
o
> >>  acpi-y                         +=3D acpi_processor.o
> >>  acpi-y                         +=3D processor_core.o
> >>  acpi-$(CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC) +=3D processor_pdc.o
> >> -acpi-y                         +=3D ec.o
> >> +acpi-$(CONFIG_HAS_IOPORT)      +=3D ec.o
> >>  acpi-$(CONFIG_ACPI_DOCK)       +=3D dock.o
> >>  acpi-$(CONFIG_PCI)             +=3D pci_root.o pci_link.o pci_irq.o
> >>  obj-$(CONFIG_ACPI_MCFG)                +=3D pci_mcfg.o
> >> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> >> index 16917dc3ad60..535d6a72ce1b 100644
> >> --- a/drivers/acpi/bus.c
> >> +++ b/drivers/acpi/bus.c
> >> @@ -1356,7 +1356,8 @@ static int __init acpi_bus_init(void)
> >>          * Do that before calling acpi_initialize_objects() which may =
trigger EC
> >>          * address space accesses.
> >>          */
> >> -       acpi_ec_ecdt_probe();
> >> +       if (IS_ENABLED(CONFIG_HAS_IOPORT))
> >> +               acpi_ec_ecdt_probe();
> >>
> >>         status =3D acpi_enable_subsystem(ACPI_NO_ACPI_ENABLE);
> >>         if (ACPI_FAILURE(status)) {
> >> @@ -1391,7 +1392,8 @@ static int __init acpi_bus_init(void)
> >>          * Maybe EC region is required at bus_scan/acpi_get_devices. S=
o it
> >>          * is necessary to enable it as early as possible.
> >>          */
> >> -       acpi_ec_dsdt_probe();
> >> +       if (IS_ENABLED(CONFIG_HAS_IOPORT))
> >> +               acpi_ec_dsdt_probe();
> >
> > The above two changes mean that it is not necessary to compile either
> > acpi_ec_ecdt_probe() or acpi_ec_dsdt_probe() at all if
> > CONFIG_HAS_IOPORT is not enabled.
>
> Correct, this is a result of removing ec.o from the list of objects.
>
> >>         pr_info("Interpreter enabled\n");
> >>
> >> @@ -1464,7 +1466,8 @@ static int __init acpi_init(void)
> >>         acpi_arm_init();
> >>         acpi_riscv_init();
> >>         acpi_scan_init();
> >> -       acpi_ec_init();
> >> +       if (IS_ENABLED(CONFIG_HAS_IOPORT))
> >> +               acpi_ec_init();
> >
> > And this means that the whole EC driver is not going to work at all the=
n.
>
> Correct. The way I read ec.c it makes no sense if acpi_ec_write_cmd()
> and acpi_ec_write_data() don't actually access the registers. Is
> there anything in ec.c that still makes sense without port I/O?
>
> >> diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor=
_perflib.c
> >> index 4265814c74f8..8be453d89ef8 100644
> >> --- a/drivers/acpi/processor_perflib.c
> >> +++ b/drivers/acpi/processor_perflib.c
> >> @@ -455,7 +455,8 @@ int acpi_processor_pstate_control(void)
> >>  {
> >>         acpi_status status;
> >>
> >> -       if (!acpi_gbl_FADT.smi_command || !acpi_gbl_FADT.pstate_contro=
l)
> >> +       if (!IS_ENABLED(CONFIG_HAS_IOPORT) ||
> >> +           !acpi_gbl_FADT.smi_command || !acpi_gbl_FADT.pstate_contro=
l)
> >>                 return 0;
> >
> > All of the existing callers of acpi_processor_pstate_control() are x86
> > which has CONFIG_HAS_IOPORT AFAICS.
> >
> > And if you care about the code size, acpi_processor_notify_smm() can
> > go away for !CONFIG_HAS_IOPORT too.
> >
> >>         pr_debug("Writing pstate_control [0x%x] to smi_command [0x%x]\=
n",
> >> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> >> index 7ecc401fb97f..9d5e6dd542bf 100644
> >> --- a/drivers/acpi/scan.c
> >> +++ b/drivers/acpi/scan.c
> >> @@ -2293,7 +2293,8 @@ static int acpi_bus_attach(struct acpi_device *d=
evice, void *first_pass)
> >>         if (device->handler)
> >>                 goto ok;
> >>
> >> -       acpi_ec_register_opregions(device);
> >> +       if (IS_ENABLED(CONFIG_HAS_IOPORT))
> >> +               acpi_ec_register_opregions(device);
> >
> > I'd rather have an empty stub of acpi_ec_register_opregions() for
> > !CONFIG_HAS_IOPORT instead.
>
> Fair enough. Should I add stubs for all the global EC functions then?

Yes, please.

> I also wonder if there should be a separate CONFIG_ACPI_EC symbol
> that allows the EC logic to be turned off on non-x86 architectures
> even when HAS_IOPORT is otherwise enabled.

Yes, CONFIG_ACPI_EC would make sense IMV.

Thanks!

