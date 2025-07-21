Return-Path: <linux-acpi+bounces-15250-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8926B0BBBD
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Jul 2025 06:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791D218964A0
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Jul 2025 04:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FAF1EC006;
	Mon, 21 Jul 2025 04:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Yf1saEEI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8075E15A848
	for <linux-acpi@vger.kernel.org>; Mon, 21 Jul 2025 04:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753071908; cv=none; b=dRFI+U+u5l+KRGKutZL50YIJ4I/WViDYaj9OyXq3VJeLQoOmlbBC1Emmz1g2e/NqvrpWXJ1J8aNN8y9Al08+sCcPcG+yeqHoceN0+brA4cQGDUKyPvq5c91dEqJfWBYYqBvEX5StY8lvfENUbb/pIG8MPD9tMx1VUtq6Ex36H2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753071908; c=relaxed/simple;
	bh=YHpGq/EVF3hR1Mn16LA+qjwUkfBdGFxSmAKlt0kUjrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgYcknID24MgfocTJvTygWFC8i1+l4Y4JNTwLdwZZCClDYAQ2SngTk/U1SKIZk8USRCOcLpF8BFQAIfEgUIWYAQryzmIMMb5eMTfL3rejqSkaBlZQ/M3zDVhqUvAtYY24S1XEMb+OOdhwozowwGOMwv+Fb1SmUzUtPdtkXHmWDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Yf1saEEI; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32f1df5703aso30566701fa.3
        for <linux-acpi@vger.kernel.org>; Sun, 20 Jul 2025 21:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753071905; x=1753676705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quI4bQg7HruKkSCY0E/bW8y75jmL2fc1qxlCHyjOA4E=;
        b=Yf1saEEIgz8OlGaFDGenCkqdMATtqCV3MtqJ6Fv4290iNM9CDP/vV5p694yN4YLZyF
         xpupBF6Pb3o/10W33nCIU/RvEnDs2hFDVkus0trB3NLmJTpjTEEshgZJc5hcVRK6kzep
         dXEpTvRRfUr+ynFy12Qa5iUIcLThg4xTBgpw453AbTzQvp0Xzwg6mvKxiFy5no5hJRSl
         V7HwfensiDDyDXCkJPyVMeyo0QOLZlSfB2CsJ4pdbNtCItgSOveU8jBikP/VwvLwHGye
         ohzQQRUQmSJ0ZW+M6WzDbxy4yMZ3tjgUzNKF+8iTpXxgsaf8YEOssfFbHUKW+LDps0Rf
         uDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753071905; x=1753676705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quI4bQg7HruKkSCY0E/bW8y75jmL2fc1qxlCHyjOA4E=;
        b=K0YFgY1ouau32oAH6B1keBBPbDyT80cbipE2tirPQeTnPuId7N0SiIqq+OOrzR98D8
         UtV/8y2n9OL4m/ZY0rGn7oP2C9QdtDcI1MKnFv01X3NCe0v0Q68kKVuMxNuyyjrHkgbv
         VwnVHq0EhbU1X4DP1wVXP7DKvZCEB3vUAIyJT12LSNX9rbLuCpPni7jI+m+dbHOnl2Vi
         nuBGaWi40miX8b2/hLPe9iJQa7oOALltKA89uSWpIwmvCPXjjqlbX1mEhQ61fWuVlMyC
         TeTvr9KICQ4J0s3uFvpfPz5a58aMC0KK3KILuIL+cspplisYJkrzgTRSZaZteKbvxhKB
         x7RA==
X-Forwarded-Encrypted: i=1; AJvYcCXfLgZTIDyWHZPdNvvfdaSEc/Hl9S0cHb2L1d9zCX76xKKWz4GgGCd3cnHbV8cBEH/gcwoxDXYTG5Za@vger.kernel.org
X-Gm-Message-State: AOJu0YyoFyDpdn1m+HtiSdLJzhhZAe4/tvPpn0Rq2TBIIVf7CHLuP4HK
	CtorKWt9u/mw9BsylwYVDdz3laYsJmKn1ujzihSRMOkLet27x+GjVcFsSrShVyjX3u7Ip3psHMd
	PWM9IkqX71xOMJsEaGALj8Q3pbsRpICeUmzTJL6ux6g==
X-Gm-Gg: ASbGncvQ35im/keHk1oqsKZFCAF7AVqU7V1ZucIDl6f8wCVfBL+cTuZjKhSiskSRTqN
	8qHHZkAr1CM0PQIC//76ON1Tv7dc97vCYNoY4GOeCC9bSiWex5Y/kTaw0q2vo1p9Shpg9JsHyxv
	d9q28j49u1kbcvGr1TsulU9TQfym/yHnJgBusfcTiEVgnsf+EupoilH/3Li1qtYnyEf0i1tuoRB
	AmNPcsN
X-Google-Smtp-Source: AGHT+IFfBIZ9tw9xk6izt+Pp1RDKhrneM/4V0xMQ3SQcQyw8bxtVQ+yk7ZX4FkrasMb7cm8JZje8oaxcUAv/6th9jac=
X-Received: by 2002:a2e:80d4:0:b0:32b:755e:6cd7 with SMTP id
 38308e7fff4ca-3308e56e179mr51708341fa.32.1753071904344; Sun, 20 Jul 2025
 21:25:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704070356.1683992-1-apatel@ventanamicro.com> <CABb+yY0mf08KU-GgjCVKMFpSf-jVSSRadtYfk6VHcbcMw6xztA@mail.gmail.com>
In-Reply-To: <CABb+yY0mf08KU-GgjCVKMFpSf-jVSSRadtYfk6VHcbcMw6xztA@mail.gmail.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Mon, 21 Jul 2025 09:54:52 +0530
X-Gm-Features: Ac12FXy5l4nDu-013iesLxkoer-0bUk6pdvS3VWXraud9GJ1aiQP15I-8GohFJE
Message-ID: <CAK9=C2VfZ8PneOnChoUn4-mYZFut+TXoW8iDzKXc4XOW9X2qKw@mail.gmail.com>
Subject: Re: [PATCH v8 00/24] Linux SBI MPXY and RPMI drivers
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>, 
	Rahul Pathak <rpathak@ventanamicro.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>, 
	Atish Patra <atish.patra@linux.dev>, Andrew Jones <ajones@ventanamicro.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Anup Patel <anup@brainfault.org>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 1:09=E2=80=AFAM Jassi Brar <jassisinghbrar@gmail.co=
m> wrote:
>
> On Fri, Jul 4, 2025 at 2:04=E2=80=AFAM Anup Patel <apatel@ventanamicro.co=
m> wrote:
> >
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
> >  - Addressed comments on PATCH3, PATCH7, PATCH10, PATCH14, and PATCH21
> >
> > Changes since v6:
> >  - Rebased the series on Linux-6.16-rc4
> >  - Added Stephen's Reviewed-by in appropriate patches
> >  - Addressed Andy's comments on PATCH5, PATCH6, PATCH9, and PATCH14
> >  - New PATCH6 in this series which is factored-out from PATCH7
> >
> > Changes since v5:
> >  - Rebased the series on Linux-6.16-rc2
> >  - Added Conor's Reviewed-by in all DT binding patches
> >  - Addressed Andy's comments on PATCH5
> >  - Addressed Tglx's comments on PATCH12 and PATCH21
> >
> > Changes since v4:
> >  - Rebased the series on Linux-6.16-rc1
> >  - Dropped PATCH1 since a similar change is already merged
> >    https://lore.kernel.org/linux-riscv/20250523101932.1594077-4-cleger@=
rivosinc.com/
> >  - Addressed Andy's comments on PATCH4, PATCH5, PATCH6, PATCH7,
> >    PATCH13, and PATCH17
> >  - Addressed Atish's comments on PATCH11 and PATCH12
> >  - Addressed Conor's comments on PATCH9
> >
> > Changes since v3:
> >  - Rebased the series on Linux-6.15-rc7
> >  - Updated PATCH2 DT bindings as-per Rob's suggestion
> >  - Improved request_threaded_irq() usage in PATCH7
> >  - Updated PATCH10 clk-rpmi driver as-per commments from Andy
> >  - Updated PATCH13 irq-riscv-rpmi-sysmsi driver as-per comments
> >    from Andy and Tglx
> >  - Addressed ACPI related comments in PATCH14, PATCH15, PATCH18,
> >    PATCH20 and PATCH21
> >
> > Changes since v2:
> >  - Dropped the "RFC" tag from series since the SBI v3.0 and
> >    RPMI v1.0 specifications are now frozen
> >  - Rebased the series on Linux-6.15-rc5
> >  - Split PATCH8 of v2 into two patches adding separate DT
> >    bindings for "riscv,rpmi-mpxy-clock" and "riscv,rpmi-clock"
> >  - Split PATCH10 of v2 into two patches adding separate DT
> >    bindings for "riscv,rpmi-mpxy-system-msi" and
> >    "riscv,rpmi-system-msi"
> >  - Addressed comments from TGLX on PATCH11 of v2 adding irqchip
> >    driver for RPMI system MSI
> >  - Addressed ACPI related comments in PATCH15 and PATCH16 of v2
> >  - New PATCH17 and PATCH18 in this series
> >
> > Changes since v1:
> >  - Addressed DT bindings related comments in PATCH2, PATCH3, and
> >    PATCH7 of v1 series
> >  - Addressed comments in PATCH6 and PATCH8 of v1 series
> >  - New PATCH6 in v2 series to allow fwnode based mailbox channel
> >    request
> >  - New PATCH10 and PATCH11 to add RPMI system MSI based interrupt
> >    controller driver
> >  - New PATCH12 to PATCH16 which adds ACPI support in SBI MPXY
> >    mailbox driver and RPMI system MSI driver
> >  - New PATCH17 to enable required kconfig option to allow graceful
> >    shutdown on QEMU virt machine
> >
> > Anup Patel (14):
> >   dt-bindings: mailbox: Add bindings for RPMI shared memory transport
> >   dt-bindings: mailbox: Add bindings for RISC-V SBI MPXY extension
> >   RISC-V: Add defines for the SBI message proxy extension
> >   mailbox: Add common header for RPMI messages sent via mailbox
> >   mailbox: Allow controller specific mapping using fwnode
> >   byteorder: Add memcpy_to_le32() and memcpy_from_le32()
> >   mailbox: Add RISC-V SBI message proxy (MPXY) based mailbox driver
> >   dt-bindings: clock: Add RPMI clock service message proxy bindings
> >   dt-bindings: clock: Add RPMI clock service controller bindings
> >   dt-bindings: Add RPMI system MSI message proxy bindings
> >   dt-bindings: Add RPMI system MSI interrupt controller bindings
> >   irqchip: Add driver for the RPMI system MSI service group
> >   RISC-V: Enable GPIO keyboard and event device in RV64 defconfig
> >   MAINTAINERS: Add entry for RISC-V RPMI and MPXY drivers
> >
> > Rahul Pathak (1):
> >   clk: Add clock driver for the RISC-V RPMI clock service group
> >
> > Sunil V L (9):
> >   ACPI: property: Refactor acpi_fwnode_get_reference_args() to support
> >     nargs_prop
> >   ACPI: Add support for nargs_prop in acpi_fwnode_get_reference_args()
> >   ACPI: scan: Update honor list for RPMI System MSI
> >   ACPI: RISC-V: Create interrupt controller list in sorted order
> >   ACPI: RISC-V: Add support to update gsi range
> >   ACPI: RISC-V: Add RPMI System MSI to GSI mapping
> >   irqchip/irq-riscv-imsic-early: Export imsic_acpi_get_fwnode()
> >   mailbox/riscv-sbi-mpxy: Add ACPI support
> >   irqchip/riscv-rpmi-sysmsi: Add ACPI support
> >
> >  .../bindings/clock/riscv,rpmi-clock.yaml      |   64 ++
> >  .../bindings/clock/riscv,rpmi-mpxy-clock.yaml |   64 ++
> >  .../riscv,rpmi-mpxy-system-msi.yaml           |   67 ++
> >  .../riscv,rpmi-system-msi.yaml                |   74 ++
> >  .../mailbox/riscv,rpmi-shmem-mbox.yaml        |  124 ++
> >  .../bindings/mailbox/riscv,sbi-mpxy-mbox.yaml |   51 +
> >  MAINTAINERS                                   |   15 +
> >  arch/riscv/configs/defconfig                  |    2 +
> >  arch/riscv/include/asm/irq.h                  |    6 +
> >  arch/riscv/include/asm/sbi.h                  |   63 +
> >  drivers/acpi/property.c                       |  128 ++-
> >  drivers/acpi/riscv/irq.c                      |   75 +-
> >  drivers/acpi/scan.c                           |    2 +
> >  drivers/base/property.c                       |    2 +-
> >  drivers/clk/Kconfig                           |    8 +
> >  drivers/clk/Makefile                          |    1 +
> >  drivers/clk/clk-rpmi.c                        |  616 ++++++++++
> >  drivers/irqchip/Kconfig                       |    7 +
> >  drivers/irqchip/Makefile                      |    1 +
> >  drivers/irqchip/irq-riscv-imsic-early.c       |    2 +
> >  drivers/irqchip/irq-riscv-rpmi-sysmsi.c       |  328 ++++++
> >  drivers/mailbox/Kconfig                       |   11 +
> >  drivers/mailbox/Makefile                      |    2 +
> >  drivers/mailbox/mailbox.c                     |   65 +-
> >  drivers/mailbox/riscv-sbi-mpxy-mbox.c         | 1017 +++++++++++++++++
> >  include/linux/byteorder/generic.h             |   16 +
> >  include/linux/mailbox/riscv-rpmi-message.h    |  243 ++++
> >  include/linux/mailbox_controller.h            |    3 +
> >  include/linux/wordpart.h                      |   16 +
> >  29 files changed, 2990 insertions(+), 83 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/clock/riscv,rpmi-=
clock.yaml
> >  create mode 100644 Documentation/devicetree/bindings/clock/riscv,rpmi-=
mpxy-clock.yaml
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-control=
ler/riscv,rpmi-mpxy-system-msi.yaml
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-control=
ler/riscv,rpmi-system-msi.yaml
> >  create mode 100644 Documentation/devicetree/bindings/mailbox/riscv,rpm=
i-shmem-mbox.yaml
> >  create mode 100644 Documentation/devicetree/bindings/mailbox/riscv,sbi=
-mpxy-mbox.yaml
> >  create mode 100644 drivers/clk/clk-rpmi.c
> >  create mode 100644 drivers/irqchip/irq-riscv-rpmi-sysmsi.c
> >  create mode 100644 drivers/mailbox/riscv-sbi-mpxy-mbox.c
> >  create mode 100644 include/linux/mailbox/riscv-rpmi-message.h
> >
> For the mailbox changes ...
> Acked-by: Jassi Brar <jassisinghbrar@gmail.com>

Thanks Jassi !

--Anup

