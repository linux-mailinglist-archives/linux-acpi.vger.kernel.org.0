Return-Path: <linux-acpi+bounces-15245-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1DBB0B805
	for <lists+linux-acpi@lfdr.de>; Sun, 20 Jul 2025 21:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B19537AB917
	for <lists+linux-acpi@lfdr.de>; Sun, 20 Jul 2025 19:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3543C2236FA;
	Sun, 20 Jul 2025 19:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGBDcFtY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4368818EFD1;
	Sun, 20 Jul 2025 19:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753040380; cv=none; b=mCvPPtmlIuhdUi4BujG2HIW5ugYAYQ/ohOXBBm15GFRYuyvG0EMgEQ3cVxNuYsXHeFJHzpW80ApYOTNPUNTnYUaXnL9iDXhOAMmruyXhFlJOPfHH3+b5/aNajgKi1g1GzgvGDwT5a6PTZXzwayUUPr3KBN9OzIykCfC6rInXIR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753040380; c=relaxed/simple;
	bh=hwBvO6Ulva8/j0xHYM7U2YSGUnaQQC/5UxEHSk6tpF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPy4llI7xsxtDPAG/G8OL1xyRYiQvjscK4stSXIUC+2kMhO3qBzI9Tlcpbh5+jOFLdASp0rl5O44kCi0MQZBw6uxh4CztObLavCFCXF5PBeIKjukF3dgaqPKp6rnN67PnXmgpXy9UoQ2ypXMU+vJgR/tLOuRqJzaZRYiFYCAv9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGBDcFtY; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-615bb20b741so1301723eaf.1;
        Sun, 20 Jul 2025 12:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753040376; x=1753645176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8pDrPYAjI9tKigWN4u3/A9ISQOquja4L6UQzT6Ikok=;
        b=UGBDcFtYckFT21q1Duy0QznFvYmbg2+4LKfb8AHMJIShAqXFpczYBdq+m4F52WIJrE
         7722R7rqv965L5XLr483fncjMzR878gCIuptqIs4VL4LGffaylu3vseZOXOV+X7HnVdn
         YBPWjP+zDcEYetA2dmcXUiGGeZBsql5lm0H0Zxfh/xI+dO5bJn5E17erkag2YLjK92dW
         9xMotJDEi4jVC5palJ5nFMcsQcjg6ItxUGLxwrAnWx7UNiDzGDLLQlhIX+r3RbRaFpel
         ZxEyZp5XtSdUjzxvStHxUorG7seuVmcSPiecUU/fprVddAyOLsiUeq746l5RtkuRRLPX
         ypUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753040376; x=1753645176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8pDrPYAjI9tKigWN4u3/A9ISQOquja4L6UQzT6Ikok=;
        b=NAN96p6YPUwnt6IICzURI4cB/mgw3QWu3zlBWpVPHK6Ml8vMrrcyt66WAtjEec10xD
         uNs4mct9memHkJkqMSizPkYn6+VJ7czzL7O2lu/tS0/SqfgudEe5+c52iFQBOpF4/p8T
         YuE+6ocgWr2Q47+Fgx2cyQ8Xr7mUvAKfeTqu7e4Y/uWf5ShfQ1ksjDxwk7jF5C69JCOH
         fwkbQj0Aldug18/sl04/LGY9vWFlUTP5RDKVnvfrr4qVOa5k7wlOzl0kW+LtWoHu5Egx
         EP+L2wt08UJrs8P3FiwaLkbynhBaDqpbUSAceFj4G8Twtn1yzSqLdznVL0R/GV/VaLmb
         Z2hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKI8NSSbQDeykzRP2uWd42DDjwGgZhApwooos7Tf3Sc0MaEceSoNBCo3ZrM1l7KvMeTp+/Jv39qPML@vger.kernel.org, AJvYcCVRggf4GHhYCybHN6tIqwmaPj4CsVRWIOJd8FAsmareeeFEAxlGvZhZnMYAos7PH3g/LBMCZlva5koXng==@vger.kernel.org, AJvYcCVTq2hA6AgijyCoLOeD7ELGhAReeXYXtTUjeHuScM5NudHjJErR9KTc86warzx8DlEWMBKP5GkgkwzaiBcg@vger.kernel.org, AJvYcCWcna/7f4b4lOTZfneeCUytJKnXlLh4UIal0D1BK78e6IuGrbOTMgYuCvoWz6h4ZlQ/PGeV+uaD9Syn@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7KbVyNTayUTxt0Q/FdJA9RQ9oS+k5hcki72UPo50JG6hY943N
	AkMeKcXC14FzuPyhJxGcAHVo1dpzhf/8SYYFVp2H/HMi9352KfmumiKSS0F8SsBC8PPJ48fQj3x
	G3wej0fwH9LkYjYSOsZ4q3lHVR9EpT4g=
X-Gm-Gg: ASbGncvopt2DvyCOSbKjGaWKTkCg3ku/79ZxCMCJdQGirIxrw3XxvuQzvns1wpkYcUX
	y5l46y4ub8kFGEFinJsnd9HWTpU+wyz0XkAixCusj+aZ5AIzz5XY1LFPto5NeQqtbkv7aabKkix
	PGd+DlVHc/Nn5OcU0GIPJ0aECQ33gyZdBlj0+Ndwd+gAupFQnjleYMXaBurol/uoqesWLREknav
	kzuulTL
X-Google-Smtp-Source: AGHT+IFrbPeYsGbhohTWlYFOI9bvOuc2errQJxomgpxyy28WJwJ2mNh9GgBPR9tNqIY7CT/xgD/SC4+XPYmkg5FDtLc=
X-Received: by 2002:a05:6808:320c:b0:40b:4230:387d with SMTP id
 5614622812f47-41d031f1e9emr11575639b6e.3.1753040376186; Sun, 20 Jul 2025
 12:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704070356.1683992-1-apatel@ventanamicro.com>
In-Reply-To: <20250704070356.1683992-1-apatel@ventanamicro.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sun, 20 Jul 2025 14:39:25 -0500
X-Gm-Features: Ac12FXzyAbRCNqQQkJj6k6J7eITPUeJ8FWB1TPamCilBeHAAIHqMEESr0Hgcz4g
Message-ID: <CABb+yY0mf08KU-GgjCVKMFpSf-jVSSRadtYfk6VHcbcMw6xztA@mail.gmail.com>
Subject: Re: [PATCH v8 00/24] Linux SBI MPXY and RPMI drivers
To: Anup Patel <apatel@ventanamicro.com>
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

On Fri, Jul 4, 2025 at 2:04=E2=80=AFAM Anup Patel <apatel@ventanamicro.com>=
 wrote:
>
> The SBI v3.0 (MPXY extension) [1] and RPMI v1.0 [2] specifications
> are frozen and finished public review at the RISC-V International.
>
> Currently, most of the RPMI and MPXY drivers are in OpenSBI whereas
> Linux only has SBI MPXY mailbox controller driver, RPMI clock driver
> and RPMI system MSI driver This series also includes ACPI support
> for SBI MPXY mailbox controller and RPMI system MSI drivers.
>
> These patches can be found in the riscv_sbi_mpxy_mailbox_v8 branch
> at: https://github.com/avpatel/linux.git
>
> To test these patches, boot Linux on "virt,rpmi=3Don,aia=3Daplic-imsic"
> machine with OpenSBI and QEMU from the dev-upstream branch at:
> https://github.com/ventanamicro/opensbi.git
> https://github.com/ventanamicro/qemu.git
>
> [1] https://github.com/riscv-non-isa/riscv-sbi-doc/releases
> [2] https://github.com/riscv-non-isa/riscv-rpmi/releases
>
> Changes since v7:
>  - Addressed comments on PATCH3, PATCH7, PATCH10, PATCH14, and PATCH21
>
> Changes since v6:
>  - Rebased the series on Linux-6.16-rc4
>  - Added Stephen's Reviewed-by in appropriate patches
>  - Addressed Andy's comments on PATCH5, PATCH6, PATCH9, and PATCH14
>  - New PATCH6 in this series which is factored-out from PATCH7
>
> Changes since v5:
>  - Rebased the series on Linux-6.16-rc2
>  - Added Conor's Reviewed-by in all DT binding patches
>  - Addressed Andy's comments on PATCH5
>  - Addressed Tglx's comments on PATCH12 and PATCH21
>
> Changes since v4:
>  - Rebased the series on Linux-6.16-rc1
>  - Dropped PATCH1 since a similar change is already merged
>    https://lore.kernel.org/linux-riscv/20250523101932.1594077-4-cleger@ri=
vosinc.com/
>  - Addressed Andy's comments on PATCH4, PATCH5, PATCH6, PATCH7,
>    PATCH13, and PATCH17
>  - Addressed Atish's comments on PATCH11 and PATCH12
>  - Addressed Conor's comments on PATCH9
>
> Changes since v3:
>  - Rebased the series on Linux-6.15-rc7
>  - Updated PATCH2 DT bindings as-per Rob's suggestion
>  - Improved request_threaded_irq() usage in PATCH7
>  - Updated PATCH10 clk-rpmi driver as-per commments from Andy
>  - Updated PATCH13 irq-riscv-rpmi-sysmsi driver as-per comments
>    from Andy and Tglx
>  - Addressed ACPI related comments in PATCH14, PATCH15, PATCH18,
>    PATCH20 and PATCH21
>
> Changes since v2:
>  - Dropped the "RFC" tag from series since the SBI v3.0 and
>    RPMI v1.0 specifications are now frozen
>  - Rebased the series on Linux-6.15-rc5
>  - Split PATCH8 of v2 into two patches adding separate DT
>    bindings for "riscv,rpmi-mpxy-clock" and "riscv,rpmi-clock"
>  - Split PATCH10 of v2 into two patches adding separate DT
>    bindings for "riscv,rpmi-mpxy-system-msi" and
>    "riscv,rpmi-system-msi"
>  - Addressed comments from TGLX on PATCH11 of v2 adding irqchip
>    driver for RPMI system MSI
>  - Addressed ACPI related comments in PATCH15 and PATCH16 of v2
>  - New PATCH17 and PATCH18 in this series
>
> Changes since v1:
>  - Addressed DT bindings related comments in PATCH2, PATCH3, and
>    PATCH7 of v1 series
>  - Addressed comments in PATCH6 and PATCH8 of v1 series
>  - New PATCH6 in v2 series to allow fwnode based mailbox channel
>    request
>  - New PATCH10 and PATCH11 to add RPMI system MSI based interrupt
>    controller driver
>  - New PATCH12 to PATCH16 which adds ACPI support in SBI MPXY
>    mailbox driver and RPMI system MSI driver
>  - New PATCH17 to enable required kconfig option to allow graceful
>    shutdown on QEMU virt machine
>
> Anup Patel (14):
>   dt-bindings: mailbox: Add bindings for RPMI shared memory transport
>   dt-bindings: mailbox: Add bindings for RISC-V SBI MPXY extension
>   RISC-V: Add defines for the SBI message proxy extension
>   mailbox: Add common header for RPMI messages sent via mailbox
>   mailbox: Allow controller specific mapping using fwnode
>   byteorder: Add memcpy_to_le32() and memcpy_from_le32()
>   mailbox: Add RISC-V SBI message proxy (MPXY) based mailbox driver
>   dt-bindings: clock: Add RPMI clock service message proxy bindings
>   dt-bindings: clock: Add RPMI clock service controller bindings
>   dt-bindings: Add RPMI system MSI message proxy bindings
>   dt-bindings: Add RPMI system MSI interrupt controller bindings
>   irqchip: Add driver for the RPMI system MSI service group
>   RISC-V: Enable GPIO keyboard and event device in RV64 defconfig
>   MAINTAINERS: Add entry for RISC-V RPMI and MPXY drivers
>
> Rahul Pathak (1):
>   clk: Add clock driver for the RISC-V RPMI clock service group
>
> Sunil V L (9):
>   ACPI: property: Refactor acpi_fwnode_get_reference_args() to support
>     nargs_prop
>   ACPI: Add support for nargs_prop in acpi_fwnode_get_reference_args()
>   ACPI: scan: Update honor list for RPMI System MSI
>   ACPI: RISC-V: Create interrupt controller list in sorted order
>   ACPI: RISC-V: Add support to update gsi range
>   ACPI: RISC-V: Add RPMI System MSI to GSI mapping
>   irqchip/irq-riscv-imsic-early: Export imsic_acpi_get_fwnode()
>   mailbox/riscv-sbi-mpxy: Add ACPI support
>   irqchip/riscv-rpmi-sysmsi: Add ACPI support
>
>  .../bindings/clock/riscv,rpmi-clock.yaml      |   64 ++
>  .../bindings/clock/riscv,rpmi-mpxy-clock.yaml |   64 ++
>  .../riscv,rpmi-mpxy-system-msi.yaml           |   67 ++
>  .../riscv,rpmi-system-msi.yaml                |   74 ++
>  .../mailbox/riscv,rpmi-shmem-mbox.yaml        |  124 ++
>  .../bindings/mailbox/riscv,sbi-mpxy-mbox.yaml |   51 +
>  MAINTAINERS                                   |   15 +
>  arch/riscv/configs/defconfig                  |    2 +
>  arch/riscv/include/asm/irq.h                  |    6 +
>  arch/riscv/include/asm/sbi.h                  |   63 +
>  drivers/acpi/property.c                       |  128 ++-
>  drivers/acpi/riscv/irq.c                      |   75 +-
>  drivers/acpi/scan.c                           |    2 +
>  drivers/base/property.c                       |    2 +-
>  drivers/clk/Kconfig                           |    8 +
>  drivers/clk/Makefile                          |    1 +
>  drivers/clk/clk-rpmi.c                        |  616 ++++++++++
>  drivers/irqchip/Kconfig                       |    7 +
>  drivers/irqchip/Makefile                      |    1 +
>  drivers/irqchip/irq-riscv-imsic-early.c       |    2 +
>  drivers/irqchip/irq-riscv-rpmi-sysmsi.c       |  328 ++++++
>  drivers/mailbox/Kconfig                       |   11 +
>  drivers/mailbox/Makefile                      |    2 +
>  drivers/mailbox/mailbox.c                     |   65 +-
>  drivers/mailbox/riscv-sbi-mpxy-mbox.c         | 1017 +++++++++++++++++
>  include/linux/byteorder/generic.h             |   16 +
>  include/linux/mailbox/riscv-rpmi-message.h    |  243 ++++
>  include/linux/mailbox_controller.h            |    3 +
>  include/linux/wordpart.h                      |   16 +
>  29 files changed, 2990 insertions(+), 83 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/riscv,rpmi-cl=
ock.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/riscv,rpmi-mp=
xy-clock.yaml
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controlle=
r/riscv,rpmi-mpxy-system-msi.yaml
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controlle=
r/riscv,rpmi-system-msi.yaml
>  create mode 100644 Documentation/devicetree/bindings/mailbox/riscv,rpmi-=
shmem-mbox.yaml
>  create mode 100644 Documentation/devicetree/bindings/mailbox/riscv,sbi-m=
pxy-mbox.yaml
>  create mode 100644 drivers/clk/clk-rpmi.c
>  create mode 100644 drivers/irqchip/irq-riscv-rpmi-sysmsi.c
>  create mode 100644 drivers/mailbox/riscv-sbi-mpxy-mbox.c
>  create mode 100644 include/linux/mailbox/riscv-rpmi-message.h
>
For the mailbox changes ...
Acked-by: Jassi Brar <jassisinghbrar@gmail.com>

