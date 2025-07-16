Return-Path: <linux-acpi+bounces-15201-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0C9B07A02
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 17:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58916581B87
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 15:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB9A28BAAD;
	Wed, 16 Jul 2025 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="cgCwbx7i"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934641428E7
	for <linux-acpi@vger.kernel.org>; Wed, 16 Jul 2025 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680174; cv=none; b=LojkzH/G3BzWZTLeWX+aXt1dFH+euqSfBuFnsxu4QKVJpVdyHKptDaTFFEchN06brfURqbUaF8xGcgcmxwk3f+Cj4ompL71B3QXEs03JnzTlJy7MC5Oz1EeLDAE/5COqqidJBkIJLvSRpzE7ToDIFxJSgMLG6wSqzddxu4lObsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680174; c=relaxed/simple;
	bh=UOlPAAovmKrMRUsNzrf+Fv+Hb6gtp5IG/AXs7W9HC1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ifsXuEwl+JSh0P10QFbnzekiF8EUcJo+ForGQI/AHlhB5/HBPfiDP/PUvzZIioryaoC/6WWxuaEdpjXit+CdMuU55iaq7tRhQHNsWyBq3u8FRlIDTAUQ/d4SXbiHyKwXWbP/sEsixgBPFej8d2J4c9coGfGdhKgnkhdpa3CsdSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=cgCwbx7i; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32e14cf205cso38261fa.1
        for <linux-acpi@vger.kernel.org>; Wed, 16 Jul 2025 08:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1752680171; x=1753284971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d44dYcfHmwqbX+zpmz2euXgeuat7OAXV3SVWxkrjZNE=;
        b=cgCwbx7iHP5+AzQrhzGLjwZZgrxn/VCBKuNGMMx/d1THlgEEv5AIjID/LlTaKHv5as
         QY1UTEcdYt3imHNscU985vhBKe2aig5IxazMMsOV0EPv//OPGsp1sRINLCCiLch65OsL
         KHI3JgfPlSxdhwWhhqi+BDdtFRDOvNngRmM1kuxWzHVKL4jjNAbTwJq8yzMuOlC2YEM4
         gpbCDJN7cCZslZGaFCSbpnjc+v+GGkg3kgEVwheNUxtV06VkudNbCLu2hEoHAmHsy2Bj
         IS8zA41J6J5RFbkVvcKzzfZmsEiSHunEnr7N8cAf6po6maOFNpnetUYN9/RUQcvO1ahm
         qCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752680171; x=1753284971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d44dYcfHmwqbX+zpmz2euXgeuat7OAXV3SVWxkrjZNE=;
        b=hWvoIzIuxQwdzW1tAoyRTVCBC5v5bscq/AdswX5JiRluT2py5C27af/VSIFCPILnzz
         0nOKNkL2N1Yc5k4HasQtj6OfMXH6HjUvAEMYKaB5YMBSluyrd9H4K8clEonb4e4brhqq
         Q44R7qz53E5bOisFG/LsPKO6DhdOjFX1UJ2ANmTQeI8/RzEymZCwqTWYzfmQl5gZpBiJ
         mGjKka3ALrNbVsE3i6GbXp2oTnTLyNeyeeE8HwH6lhHPx1UbLv7N1pkFTa5gr/P3Hwz5
         2HhpdP4gRsjnkn+0MtSci2EyacLozhVYRu55o4O1qX3aaYoYCgjuddm70TIdjsqxzC+H
         PyFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbJqAHj/RbK+Y5aPfoaQRAQkYmuFj87OpjxHvwpH+/Ztc5lJB1hW73mPIe6Dp1Pf38nUL7ng5e2P80@vger.kernel.org
X-Gm-Message-State: AOJu0YzsykuTDFukBb98pB/yX4uAvuNSVGyoez0iiOFbX88smqI980nd
	aAV415TFPmWCmHRIcuBFDbwyJ2Ppu1quDOtKu4JxeOIawA19b3i0ZCR1U+Xty+Q7b2pxMB8bNDR
	vHI8IbYoPJabihTJRHLYFIJlWv149Re/eac8UepxHlA==
X-Gm-Gg: ASbGncsl9LzluO3SB2p/svYFoN3Cu2jQzm5nXJvf//gHVghXE33nhrq9R32wHuCCbi2
	8uXvXwJa+9+5dPdHtda+a+s4mlshwCW0d8EBANlNnRbZwenN+q0CiigDI8xgKk5HW9T5XbG61FN
	A0YjqT1NhUXUwy1AhVuXHSCoDVynXVFVeUt98HNaYKpZ00BekL2hCPYG7JdP9ijJPF0IjCdnZgE
	kFqgUA=
X-Google-Smtp-Source: AGHT+IHU9G+jOG1JR6TA+0PMNpzeORjZBKpBQWTiu105me1EpFHWyXS44ekens1krtL2zYDhYV41TvUtVC15iDhIVIg=
X-Received: by 2002:a05:651c:88c:b0:310:81a0:64f7 with SMTP id
 38308e7fff4ca-3308f5df10emr7433971fa.24.1752680170539; Wed, 16 Jul 2025
 08:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704070356.1683992-1-apatel@ventanamicro.com> <74f147f3-c671-41f0-bfe7-a59aadc73f1b@ghiti.fr>
In-Reply-To: <74f147f3-c671-41f0-bfe7-a59aadc73f1b@ghiti.fr>
From: Anup Patel <apatel@ventanamicro.com>
Date: Wed, 16 Jul 2025 21:05:58 +0530
X-Gm-Features: Ac12FXzbe5BOnCFn1O4nVsR27ZwfI4fS2L19PcJ1MRU0GdaiTAjWgXHKlujTpVk
Message-ID: <CAK9=C2Vf2gqj73CJbCepQVecwjKNDu1TMUShnvXcMUwEztHPtA@mail.gmail.com>
Subject: Re: [PATCH v8 00/24] Linux SBI MPXY and RPMI drivers
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Len Brown <lenb@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>, 
	Rahul Pathak <rpathak@ventanamicro.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>, 
	Atish Patra <atish.patra@linux.dev>, Andrew Jones <ajones@ventanamicro.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Anup Patel <anup@brainfault.org>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 6:52=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> Hi Anup,
>
> On 7/4/25 09:03, Anup Patel wrote:
> > The SBI v3.0 (MPXY extension) [1] and RPMI v1.0 [2] specifications
> > are frozen and finished public review at the RISC-V International.
> >
> > Currently, most of the RPMI and MPXY drivers are in OpenSBI whereas
> > Linux only has SBI MPXY mailbox controller driver, RPMI clock driver
> > and RPMI system MSI driver This series also includes ACPI support
> > for SBI MPXY mailbox controller and RPMI system MSI drivers.
> >
> > These patches can be found in the riscv_sbi_mpxy_mailbox_v8 branch
> > at: https://github.com/avpatel/linux.git
> >
> > To test these patches, boot Linux on "virt,rpmi=3Don,aia=3Daplic-imsic"
> > machine with OpenSBI and QEMU from the dev-upstream branch at:
> > https://github.com/ventanamicro/opensbi.git
> > https://github.com/ventanamicro/qemu.git
> >
> > [1] https://github.com/riscv-non-isa/riscv-sbi-doc/releases
> > [2] https://github.com/riscv-non-isa/riscv-rpmi/releases
> >
> > Changes since v7:
> >   - Addressed comments on PATCH3, PATCH7, PATCH10, PATCH14, and PATCH21
> >
> > Changes since v6:
> >   - Rebased the series on Linux-6.16-rc4
> >   - Added Stephen's Reviewed-by in appropriate patches
> >   - Addressed Andy's comments on PATCH5, PATCH6, PATCH9, and PATCH14
> >   - New PATCH6 in this series which is factored-out from PATCH7
> >
> > Changes since v5:
> >   - Rebased the series on Linux-6.16-rc2
> >   - Added Conor's Reviewed-by in all DT binding patches
> >   - Addressed Andy's comments on PATCH5
> >   - Addressed Tglx's comments on PATCH12 and PATCH21
> >
> > Changes since v4:
> >   - Rebased the series on Linux-6.16-rc1
> >   - Dropped PATCH1 since a similar change is already merged
> >     https://lore.kernel.org/linux-riscv/20250523101932.1594077-4-cleger=
@rivosinc.com/
> >   - Addressed Andy's comments on PATCH4, PATCH5, PATCH6, PATCH7,
> >     PATCH13, and PATCH17
> >   - Addressed Atish's comments on PATCH11 and PATCH12
> >   - Addressed Conor's comments on PATCH9
> >
> > Changes since v3:
> >   - Rebased the series on Linux-6.15-rc7
> >   - Updated PATCH2 DT bindings as-per Rob's suggestion
> >   - Improved request_threaded_irq() usage in PATCH7
> >   - Updated PATCH10 clk-rpmi driver as-per commments from Andy
> >   - Updated PATCH13 irq-riscv-rpmi-sysmsi driver as-per comments
> >     from Andy and Tglx
> >   - Addressed ACPI related comments in PATCH14, PATCH15, PATCH18,
> >     PATCH20 and PATCH21
> >
> > Changes since v2:
> >   - Dropped the "RFC" tag from series since the SBI v3.0 and
> >     RPMI v1.0 specifications are now frozen
> >   - Rebased the series on Linux-6.15-rc5
> >   - Split PATCH8 of v2 into two patches adding separate DT
> >     bindings for "riscv,rpmi-mpxy-clock" and "riscv,rpmi-clock"
> >   - Split PATCH10 of v2 into two patches adding separate DT
> >     bindings for "riscv,rpmi-mpxy-system-msi" and
> >     "riscv,rpmi-system-msi"
> >   - Addressed comments from TGLX on PATCH11 of v2 adding irqchip
> >     driver for RPMI system MSI
> >   - Addressed ACPI related comments in PATCH15 and PATCH16 of v2
> >   - New PATCH17 and PATCH18 in this series
> >
> > Changes since v1:
> >   - Addressed DT bindings related comments in PATCH2, PATCH3, and
> >     PATCH7 of v1 series
> >   - Addressed comments in PATCH6 and PATCH8 of v1 series
> >   - New PATCH6 in v2 series to allow fwnode based mailbox channel
> >     request
> >   - New PATCH10 and PATCH11 to add RPMI system MSI based interrupt
> >     controller driver
> >   - New PATCH12 to PATCH16 which adds ACPI support in SBI MPXY
> >     mailbox driver and RPMI system MSI driver
> >   - New PATCH17 to enable required kconfig option to allow graceful
> >     shutdown on QEMU virt machine
> >
> > Anup Patel (14):
> >    dt-bindings: mailbox: Add bindings for RPMI shared memory transport
> >    dt-bindings: mailbox: Add bindings for RISC-V SBI MPXY extension
> >    RISC-V: Add defines for the SBI message proxy extension
> >    mailbox: Add common header for RPMI messages sent via mailbox
> >    mailbox: Allow controller specific mapping using fwnode
> >    byteorder: Add memcpy_to_le32() and memcpy_from_le32()
> >    mailbox: Add RISC-V SBI message proxy (MPXY) based mailbox driver
> >    dt-bindings: clock: Add RPMI clock service message proxy bindings
> >    dt-bindings: clock: Add RPMI clock service controller bindings
> >    dt-bindings: Add RPMI system MSI message proxy bindings
> >    dt-bindings: Add RPMI system MSI interrupt controller bindings
> >    irqchip: Add driver for the RPMI system MSI service group
> >    RISC-V: Enable GPIO keyboard and event device in RV64 defconfig
> >    MAINTAINERS: Add entry for RISC-V RPMI and MPXY drivers
> >
> > Rahul Pathak (1):
> >    clk: Add clock driver for the RISC-V RPMI clock service group
> >
> > Sunil V L (9):
> >    ACPI: property: Refactor acpi_fwnode_get_reference_args() to support
> >      nargs_prop
> >    ACPI: Add support for nargs_prop in acpi_fwnode_get_reference_args()
> >    ACPI: scan: Update honor list for RPMI System MSI
> >    ACPI: RISC-V: Create interrupt controller list in sorted order
> >    ACPI: RISC-V: Add support to update gsi range
> >    ACPI: RISC-V: Add RPMI System MSI to GSI mapping
> >    irqchip/irq-riscv-imsic-early: Export imsic_acpi_get_fwnode()
> >    mailbox/riscv-sbi-mpxy: Add ACPI support
> >    irqchip/riscv-rpmi-sysmsi: Add ACPI support
> >
> >   .../bindings/clock/riscv,rpmi-clock.yaml      |   64 ++
> >   .../bindings/clock/riscv,rpmi-mpxy-clock.yaml |   64 ++
> >   .../riscv,rpmi-mpxy-system-msi.yaml           |   67 ++
> >   .../riscv,rpmi-system-msi.yaml                |   74 ++
> >   .../mailbox/riscv,rpmi-shmem-mbox.yaml        |  124 ++
> >   .../bindings/mailbox/riscv,sbi-mpxy-mbox.yaml |   51 +
> >   MAINTAINERS                                   |   15 +
> >   arch/riscv/configs/defconfig                  |    2 +
> >   arch/riscv/include/asm/irq.h                  |    6 +
> >   arch/riscv/include/asm/sbi.h                  |   63 +
> >   drivers/acpi/property.c                       |  128 ++-
> >   drivers/acpi/riscv/irq.c                      |   75 +-
> >   drivers/acpi/scan.c                           |    2 +
> >   drivers/base/property.c                       |    2 +-
> >   drivers/clk/Kconfig                           |    8 +
> >   drivers/clk/Makefile                          |    1 +
> >   drivers/clk/clk-rpmi.c                        |  616 ++++++++++
> >   drivers/irqchip/Kconfig                       |    7 +
> >   drivers/irqchip/Makefile                      |    1 +
> >   drivers/irqchip/irq-riscv-imsic-early.c       |    2 +
> >   drivers/irqchip/irq-riscv-rpmi-sysmsi.c       |  328 ++++++
> >   drivers/mailbox/Kconfig                       |   11 +
> >   drivers/mailbox/Makefile                      |    2 +
> >   drivers/mailbox/mailbox.c                     |   65 +-
> >   drivers/mailbox/riscv-sbi-mpxy-mbox.c         | 1017 ++++++++++++++++=
+
> >   include/linux/byteorder/generic.h             |   16 +
> >   include/linux/mailbox/riscv-rpmi-message.h    |  243 ++++
> >   include/linux/mailbox_controller.h            |    3 +
> >   include/linux/wordpart.h                      |   16 +
> >   29 files changed, 2990 insertions(+), 83 deletions(-)
> >   create mode 100644 Documentation/devicetree/bindings/clock/riscv,rpmi=
-clock.yaml
> >   create mode 100644 Documentation/devicetree/bindings/clock/riscv,rpmi=
-mpxy-clock.yaml
> >   create mode 100644 Documentation/devicetree/bindings/interrupt-contro=
ller/riscv,rpmi-mpxy-system-msi.yaml
> >   create mode 100644 Documentation/devicetree/bindings/interrupt-contro=
ller/riscv,rpmi-system-msi.yaml
> >   create mode 100644 Documentation/devicetree/bindings/mailbox/riscv,rp=
mi-shmem-mbox.yaml
> >   create mode 100644 Documentation/devicetree/bindings/mailbox/riscv,sb=
i-mpxy-mbox.yaml
> >   create mode 100644 drivers/clk/clk-rpmi.c
> >   create mode 100644 drivers/irqchip/irq-riscv-rpmi-sysmsi.c
> >   create mode 100644 drivers/mailbox/riscv-sbi-mpxy-mbox.c
> >   create mode 100644 include/linux/mailbox/riscv-rpmi-message.h
> >
>
> Most of the patches have been AB/RB by their respective maintainers, so
> how do you expect the patchset to be merged? Should it go through the
> riscv tree?
>
> Let me know how you want to proceed, I'd be happy to merge it if that's
> easier for everyone.
>

We discussed this series in today's patchwork meeting and
Palmer has agreed to take this through the RISC-V tree. He
will also provide a shared tag for the benefit of other maintainers.

Please sync-up with Palmer whenever you can.

Thanks,
Anup

