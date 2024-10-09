Return-Path: <linux-acpi+bounces-8674-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 642519975C1
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Oct 2024 21:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36031F22FFE
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Oct 2024 19:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202F91D356C;
	Wed,  9 Oct 2024 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbBynD0y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99B240849;
	Wed,  9 Oct 2024 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728502823; cv=none; b=Ig+9On+T3eY4sZHNWtdCj6w09heRnwMy9vLZ7uuzLtcZRUvIaNnYKrPIZZioOpXZtKT2LOetqqVKqzdokvUJoe1C5GOvFbyn3D5HbfK2cbiebSjkw5wOULZ72g9YaKVM1DaJzvY8UYNuvOApKOg3KfqTjbtfhDcbMfb6LT0KtyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728502823; c=relaxed/simple;
	bh=aKfGHvxtx2jHudoi3yqdcvhArPGA54mqJWauC72y1rU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=buaY4EYMxZHrXdRr53VUCQeP5zFItQJGFQcMKFrJNAIVRGpIlQSVyYn/OSf/LgHcp1CyU/uqZa1RVfAUKhKB9TiZLutnYVVE7UXuF9Yp7q/VngLY2W8MFQR5SyGgdR3JdFN+A9Wcc2enYEc54lX/iDEz21/qTDkcR2Jj9ToSmvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbBynD0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B985C4CED2;
	Wed,  9 Oct 2024 19:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728502822;
	bh=aKfGHvxtx2jHudoi3yqdcvhArPGA54mqJWauC72y1rU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tbBynD0yvF3GFOeBgNpWPasatK5W43BJWif/HOnpJ+1qpJqtLEd0Wq8YXGrGIW+13
	 3dfGbXiioVBCDWZ7vZems22ea8zq0LuFqlBcGIgSAUMs4UYPVZ+dp302IybmQtJ9Ct
	 DzEg6EP2bOn4rHOb3vLYGhuUZCJtgeygOvAx3JhJAfu6bmK6zPOjvVnh0aL+1fb32K
	 1sjUUvKN2C3tTwgTojfA3MZBKobI6wICf1xgnkv1z7+MJQwTIz1aFMs1unmUUsrD8b
	 QdFzadkzsqBPYAujBqM8lA2J0P98EOtpGxsUX9RclJEiX7CAbJUCSZs7qUjbw/Wg2r
	 eh/HoTSyymLdg==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e3e7b0ee6eso110972b6e.2;
        Wed, 09 Oct 2024 12:40:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU762qXQXv/5XRMWJ2noQwpc4F1HE29fMfxwR3Fj/S8Jb1G6oyxc03esxVJCEakrHHh47xPQFzhGS/b5BXw@vger.kernel.org, AJvYcCXDMnK2a6BgCtN6NaViQDjgvntw4dpVihH0w3xwGH4B+DOtoJHoz2xh5zs/4KXvqEUqPmOwFzeOSsBA@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu0Dc2HjN9cWrLj9jdBMJwzj57orNIVbvov6ov/NAN8r0eoBPr
	EhsEz3ueFGQIMsRN0hAhyYfY+HVptRDL/dSSSazWosun1Dm/bBZWRlwFugJ6yoM40cFsCgdJoaE
	4VbTnn7iqOqtuDBIwQ2sDvsIIpic=
X-Google-Smtp-Source: AGHT+IFJ609ZL8gemgxVGu+HNY0V1JQcHHfVROXRen2YkNvjEyWFyWpjthck5EejbuzdeTIak0KNM89ZoagfkoVy1Xo=
X-Received: by 2002:a05:6808:2218:b0:3e2:7e10:5fd2 with SMTP id
 5614622812f47-3e3e66b3afemr2926913b6e.11.1728502821740; Wed, 09 Oct 2024
 12:40:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004204845.970951-1-arnd@kernel.org> <CAJZ5v0immr4obYsu2qNKKY2DKxzLDR1a=6B4xY_YTHfPF5kADg@mail.gmail.com>
 <641307d3-3fe5-401a-ba22-96ad5ef25fed@app.fastmail.com>
In-Reply-To: <641307d3-3fe5-401a-ba22-96ad5ef25fed@app.fastmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Oct 2024 21:40:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jBY91TDXPMfmLPeoDLeQCKFD+sHBgkOwPusQAMpZJc6A@mail.gmail.com>
Message-ID: <CAJZ5v0jBY91TDXPMfmLPeoDLeQCKFD+sHBgkOwPusQAMpZJc6A@mail.gmail.com>
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

On Mon, Oct 7, 2024 at 9:23=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Oct 7, 2024, at 16:04, Rafael J. Wysocki wrote:
> > On Fri, Oct 4, 2024 at 10:48=E2=80=AFPM Arnd Bergmann <arnd@kernel.org>=
 wrote:
> >>
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> CONFIG_HAS_IOPORT will soon become optional and cause a build time
> >> failure when it is disabled but a driver calls inb()/outb(). At the
> >> moment, all architectures that can support ACPI have port I/O, but
> >> this is not necessarily the case in the future.
> >
> > Can addressing this be deferred to that point?
>
> Yes. I would like to have all of arm64 and riscv be able to turn
> off HAS_IOPORT eventually, but nothing depends on doing this
> when ACPI is enabled.
>
> >> Since the embedded controller can only exist when port I/O is
> >> active, it makes sense to disable that code on targets that don't
> >> have it. The same is true for anything using acpi_os_read_port()
> >> and similar functions.
> >>
> >> Add compile-time conditionals around all of those and their callers.
> >>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >> Should this be split up into smaller patches?
> >
> > No need, but the ACPICA part is kind of nasty.
>
> Right, I see.
>
> >> --- a/drivers/acpi/acpica/evhandler.c
> >> +++ b/drivers/acpi/acpica/evhandler.c
> >> @@ -358,12 +358,13 @@ acpi_ev_install_space_handler(struct acpi_namesp=
ace_node *node,
> >>                         handler =3D acpi_ex_system_memory_space_handle=
r;
> >>                         setup =3D acpi_ev_system_memory_region_setup;
> >>                         break;
> >> -
> >> +#ifdef CONFIG_HAS_IOPORT
> >>                 case ACPI_ADR_SPACE_SYSTEM_IO:
> >>
> >>                         handler =3D acpi_ex_system_io_space_handler;
> >>                         setup =3D acpi_ev_io_space_region_setup;
> >>                         break;
> >> +#endif
> >
> > All changes like the above in the ACPICA code potentially increase the
> > number of times when upstream ACPICA patches will have to be ported to
> > Linux manually, which in turn increases the number of potential
> > mistakes in the process.
> >
> > I'd rather avoid making them, if possible.
>
> Understood. Does that mean that on the flip-side we can change
> the drivers/acpi/osl.c portion to turn acpi_os_read_port()
> and acpi_os_write_port() into a runtime error for configurations
> without port I/O, without causing the same maintenance overhead?

Yes, that can be done.

> The version below builds fine and doesn't touch acpica but
> it's a bit harder to predict what would happen at runtime.

Sure.

> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index b8924077163b..5ec58c4e0332 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -134,6 +134,7 @@ config ACPI_REV_OVERRIDE_POSSIBLE
>
>  config ACPI_EC_DEBUGFS
>         tristate "EC read/write access through /sys/kernel/debug/ec"
> +       depends on HAS_IOPORT
>         help
>           Say N to disable Embedded Controller /sys/kernel/debug interfac=
e
>
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 61ca4afe83dc..132357815324 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -41,7 +41,7 @@ acpi-y                                +=3D resource.o
>  acpi-y                         +=3D acpi_processor.o
>  acpi-y                         +=3D processor_core.o
>  acpi-$(CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC) +=3D processor_pdc.o
> -acpi-y                         +=3D ec.o
> +acpi-$(CONFIG_HAS_IOPORT)      +=3D ec.o
>  acpi-$(CONFIG_ACPI_DOCK)       +=3D dock.o
>  acpi-$(CONFIG_PCI)             +=3D pci_root.o pci_link.o pci_irq.o
>  obj-$(CONFIG_ACPI_MCFG)                +=3D pci_mcfg.o
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 16917dc3ad60..535d6a72ce1b 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -1356,7 +1356,8 @@ static int __init acpi_bus_init(void)
>          * Do that before calling acpi_initialize_objects() which may tri=
gger EC
>          * address space accesses.
>          */
> -       acpi_ec_ecdt_probe();
> +       if (IS_ENABLED(CONFIG_HAS_IOPORT))
> +               acpi_ec_ecdt_probe();
>
>         status =3D acpi_enable_subsystem(ACPI_NO_ACPI_ENABLE);
>         if (ACPI_FAILURE(status)) {
> @@ -1391,7 +1392,8 @@ static int __init acpi_bus_init(void)
>          * Maybe EC region is required at bus_scan/acpi_get_devices. So i=
t
>          * is necessary to enable it as early as possible.
>          */
> -       acpi_ec_dsdt_probe();
> +       if (IS_ENABLED(CONFIG_HAS_IOPORT))
> +               acpi_ec_dsdt_probe();

The above two changes mean that it is not necessary to compile either
acpi_ec_ecdt_probe() or acpi_ec_dsdt_probe() at all if
CONFIG_HAS_IOPORT is not enabled.

>
>         pr_info("Interpreter enabled\n");
>
> @@ -1464,7 +1466,8 @@ static int __init acpi_init(void)
>         acpi_arm_init();
>         acpi_riscv_init();
>         acpi_scan_init();
> -       acpi_ec_init();
> +       if (IS_ENABLED(CONFIG_HAS_IOPORT))
> +               acpi_ec_init();

And this means that the whole EC driver is not going to work at all then.

>         acpi_debugfs_init();
>         acpi_sleep_proc_init();
>         acpi_wakeup_device_init();
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index b73b3aa92f3f..326b73ae77a9 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1017,7 +1017,8 @@ static int cpc_read(int cpu, struct cpc_register_re=
source *reg_res, u64 *val)
>         *val =3D 0;
>         size =3D GET_BIT_WIDTH(reg);
>
> -       if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_IO) {
> +       if (IS_ENABLED(CONFIG_HAS_IOPORT) &&
> +           reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_IO) {
>                 u32 val_u32;
>                 acpi_status status;
>
> @@ -1090,7 +1091,8 @@ static int cpc_write(int cpu, struct cpc_register_r=
esource *reg_res, u64 val)
>
>         size =3D GET_BIT_WIDTH(reg);
>
> -       if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_IO) {
> +       if (IS_ENABLED(CONFIG_HAS_IOPORT) &&
> +           reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_IO) {
>                 acpi_status status;
>
>                 status =3D acpi_os_write_port((acpi_io_address)reg->addre=
ss,
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 78a81969d90e..04d3864073ba 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -642,6 +642,11 @@ acpi_status acpi_os_read_port(acpi_io_address port, =
u32 *value, u32 width)
>  {
>         u32 dummy;
>
> +       if (!IS_ENABLED(CONFIG_HAS_IOPORT)) {
> +               *value =3D BIT_MASK(width);
> +               return AE_NOT_IMPLEMENTED;
> +       }
> +
>         if (value)
>                 *value =3D 0;
>         else
> @@ -665,6 +670,9 @@ EXPORT_SYMBOL(acpi_os_read_port);
>
>  acpi_status acpi_os_write_port(acpi_io_address port, u32 value, u32 widt=
h)
>  {
> +       if (!IS_ENABLED(CONFIG_HAS_IOPORT))
> +               return AE_NOT_IMPLEMENTED;
> +
>         if (width <=3D 8) {
>                 outb(value, port);
>         } else if (width <=3D 16) {

The above two changes look reasonable to me.

> diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_pe=
rflib.c
> index 4265814c74f8..8be453d89ef8 100644
> --- a/drivers/acpi/processor_perflib.c
> +++ b/drivers/acpi/processor_perflib.c
> @@ -455,7 +455,8 @@ int acpi_processor_pstate_control(void)
>  {
>         acpi_status status;
>
> -       if (!acpi_gbl_FADT.smi_command || !acpi_gbl_FADT.pstate_control)
> +       if (!IS_ENABLED(CONFIG_HAS_IOPORT) ||
> +           !acpi_gbl_FADT.smi_command || !acpi_gbl_FADT.pstate_control)
>                 return 0;

All of the existing callers of acpi_processor_pstate_control() are x86
which has CONFIG_HAS_IOPORT AFAICS.

And if you care about the code size, acpi_processor_notify_smm() can
go away for !CONFIG_HAS_IOPORT too.

>         pr_debug("Writing pstate_control [0x%x] to smi_command [0x%x]\n",
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 7ecc401fb97f..9d5e6dd542bf 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2293,7 +2293,8 @@ static int acpi_bus_attach(struct acpi_device *devi=
ce, void *first_pass)
>         if (device->handler)
>                 goto ok;
>
> -       acpi_ec_register_opregions(device);
> +       if (IS_ENABLED(CONFIG_HAS_IOPORT))
> +               acpi_ec_register_opregions(device);

I'd rather have an empty stub of acpi_ec_register_opregions() for
!CONFIG_HAS_IOPORT instead.

>
>         if (!device->flags.initialized) {
>                 device->flags.power_manageable =3D

