Return-Path: <linux-acpi+bounces-15195-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8E0B07767
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 15:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A23A16D008
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 13:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ECA1E0E14;
	Wed, 16 Jul 2025 13:53:47 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA55414A09C;
	Wed, 16 Jul 2025 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752674027; cv=none; b=OVPf8VbM1c9zPUU1sSzwPxvMrdLNJLmZsDYQL84pzMIf43mFJS6NSgLLXb1hbVVkgzP7zd7p39pBljtf0dl5+uJlsBv/8WXUHMQB9yrTEc9fU+wyKXB2RlepM3w48+WCpSi7LN7cq9o/NOF1iHCPLC1l7PF9MM9ZSsGZrXNeItQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752674027; c=relaxed/simple;
	bh=sApfRX53GAVbCCpziYIkee5X3th2BDu676Hkvn24NB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iYQGhlo5ShrPaavZV90COvj25jGxbE4Y27zdKKaypWhg4wdkEE3LvfNoUpWdm56MsML8KhQYY8TI6G+Sdon0W2f4Dkii+Np+Hv0n710GtOXvp8yUAbp8zl9/cA8b0QAIEfGtXHsL8TGsee+HgE7DtDmiuWsIm8BwqUZntyh/CII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id CD381585102;
	Wed, 16 Jul 2025 13:22:52 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 164B743D47;
	Wed, 16 Jul 2025 13:22:37 +0000 (UTC)
Message-ID: <74f147f3-c671-41f0-bfe7-a59aadc73f1b@ghiti.fr>
Date: Wed, 16 Jul 2025 15:22:37 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/24] Linux SBI MPXY and RPMI drivers
To: Anup Patel <apatel@ventanamicro.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Len Brown <lenb@kernel.org>,
 Sunil V L <sunilvl@ventanamicro.com>, Rahul Pathak
 <rpathak@ventanamicro.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>,
 Atish Patra <atish.patra@linux.dev>, Andrew Jones <ajones@ventanamicro.com>,
 Samuel Holland <samuel.holland@sifive.com>, Anup Patel
 <anup@brainfault.org>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250704070356.1683992-1-apatel@ventanamicro.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250704070356.1683992-1-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehjeekvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhepueekjeefieeikeevvefhtddtteevgefgtdffheegieegkeffueeujefhjefftdeinecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemleehtdgumehftgegieemjeejlegvmedvfhgvfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemleehtdgumehftgegieemjeejlegvmedvfhgvfedphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemleehtdgumehftgegieemjeejlegvmedvfhgvfegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepvdelpdhrtghpthhtoheprghprghtvghlsehvvghnthgrnhgrmhhitghrohdrtghomhdprhgtphhtthhopehmthhurhhquhgvthhtvgessggrhihlihgsr
 hgvrdgtohhmpdhrtghpthhtohepshgsohihugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrshhsihhsihhnghhhsghrrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggv
X-GND-Sasl: alex@ghiti.fr

Hi Anup,

On 7/4/25 09:03, Anup Patel wrote:
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
> To test these patches, boot Linux on "virt,rpmi=on,aia=aplic-imsic"
> machine with OpenSBI and QEMU from the dev-upstream branch at:
> https://github.com/ventanamicro/opensbi.git
> https://github.com/ventanamicro/qemu.git
>
> [1] https://github.com/riscv-non-isa/riscv-sbi-doc/releases
> [2] https://github.com/riscv-non-isa/riscv-rpmi/releases
>
> Changes since v7:
>   - Addressed comments on PATCH3, PATCH7, PATCH10, PATCH14, and PATCH21
>
> Changes since v6:
>   - Rebased the series on Linux-6.16-rc4
>   - Added Stephen's Reviewed-by in appropriate patches
>   - Addressed Andy's comments on PATCH5, PATCH6, PATCH9, and PATCH14
>   - New PATCH6 in this series which is factored-out from PATCH7
>
> Changes since v5:
>   - Rebased the series on Linux-6.16-rc2
>   - Added Conor's Reviewed-by in all DT binding patches
>   - Addressed Andy's comments on PATCH5
>   - Addressed Tglx's comments on PATCH12 and PATCH21
>
> Changes since v4:
>   - Rebased the series on Linux-6.16-rc1
>   - Dropped PATCH1 since a similar change is already merged
>     https://lore.kernel.org/linux-riscv/20250523101932.1594077-4-cleger@rivosinc.com/
>   - Addressed Andy's comments on PATCH4, PATCH5, PATCH6, PATCH7,
>     PATCH13, and PATCH17
>   - Addressed Atish's comments on PATCH11 and PATCH12
>   - Addressed Conor's comments on PATCH9
>
> Changes since v3:
>   - Rebased the series on Linux-6.15-rc7
>   - Updated PATCH2 DT bindings as-per Rob's suggestion
>   - Improved request_threaded_irq() usage in PATCH7
>   - Updated PATCH10 clk-rpmi driver as-per commments from Andy
>   - Updated PATCH13 irq-riscv-rpmi-sysmsi driver as-per comments
>     from Andy and Tglx
>   - Addressed ACPI related comments in PATCH14, PATCH15, PATCH18,
>     PATCH20 and PATCH21
>
> Changes since v2:
>   - Dropped the "RFC" tag from series since the SBI v3.0 and
>     RPMI v1.0 specifications are now frozen
>   - Rebased the series on Linux-6.15-rc5
>   - Split PATCH8 of v2 into two patches adding separate DT
>     bindings for "riscv,rpmi-mpxy-clock" and "riscv,rpmi-clock"
>   - Split PATCH10 of v2 into two patches adding separate DT
>     bindings for "riscv,rpmi-mpxy-system-msi" and
>     "riscv,rpmi-system-msi"
>   - Addressed comments from TGLX on PATCH11 of v2 adding irqchip
>     driver for RPMI system MSI
>   - Addressed ACPI related comments in PATCH15 and PATCH16 of v2
>   - New PATCH17 and PATCH18 in this series
>
> Changes since v1:
>   - Addressed DT bindings related comments in PATCH2, PATCH3, and
>     PATCH7 of v1 series
>   - Addressed comments in PATCH6 and PATCH8 of v1 series
>   - New PATCH6 in v2 series to allow fwnode based mailbox channel
>     request
>   - New PATCH10 and PATCH11 to add RPMI system MSI based interrupt
>     controller driver
>   - New PATCH12 to PATCH16 which adds ACPI support in SBI MPXY
>     mailbox driver and RPMI system MSI driver
>   - New PATCH17 to enable required kconfig option to allow graceful
>     shutdown on QEMU virt machine
>
> Anup Patel (14):
>    dt-bindings: mailbox: Add bindings for RPMI shared memory transport
>    dt-bindings: mailbox: Add bindings for RISC-V SBI MPXY extension
>    RISC-V: Add defines for the SBI message proxy extension
>    mailbox: Add common header for RPMI messages sent via mailbox
>    mailbox: Allow controller specific mapping using fwnode
>    byteorder: Add memcpy_to_le32() and memcpy_from_le32()
>    mailbox: Add RISC-V SBI message proxy (MPXY) based mailbox driver
>    dt-bindings: clock: Add RPMI clock service message proxy bindings
>    dt-bindings: clock: Add RPMI clock service controller bindings
>    dt-bindings: Add RPMI system MSI message proxy bindings
>    dt-bindings: Add RPMI system MSI interrupt controller bindings
>    irqchip: Add driver for the RPMI system MSI service group
>    RISC-V: Enable GPIO keyboard and event device in RV64 defconfig
>    MAINTAINERS: Add entry for RISC-V RPMI and MPXY drivers
>
> Rahul Pathak (1):
>    clk: Add clock driver for the RISC-V RPMI clock service group
>
> Sunil V L (9):
>    ACPI: property: Refactor acpi_fwnode_get_reference_args() to support
>      nargs_prop
>    ACPI: Add support for nargs_prop in acpi_fwnode_get_reference_args()
>    ACPI: scan: Update honor list for RPMI System MSI
>    ACPI: RISC-V: Create interrupt controller list in sorted order
>    ACPI: RISC-V: Add support to update gsi range
>    ACPI: RISC-V: Add RPMI System MSI to GSI mapping
>    irqchip/irq-riscv-imsic-early: Export imsic_acpi_get_fwnode()
>    mailbox/riscv-sbi-mpxy: Add ACPI support
>    irqchip/riscv-rpmi-sysmsi: Add ACPI support
>
>   .../bindings/clock/riscv,rpmi-clock.yaml      |   64 ++
>   .../bindings/clock/riscv,rpmi-mpxy-clock.yaml |   64 ++
>   .../riscv,rpmi-mpxy-system-msi.yaml           |   67 ++
>   .../riscv,rpmi-system-msi.yaml                |   74 ++
>   .../mailbox/riscv,rpmi-shmem-mbox.yaml        |  124 ++
>   .../bindings/mailbox/riscv,sbi-mpxy-mbox.yaml |   51 +
>   MAINTAINERS                                   |   15 +
>   arch/riscv/configs/defconfig                  |    2 +
>   arch/riscv/include/asm/irq.h                  |    6 +
>   arch/riscv/include/asm/sbi.h                  |   63 +
>   drivers/acpi/property.c                       |  128 ++-
>   drivers/acpi/riscv/irq.c                      |   75 +-
>   drivers/acpi/scan.c                           |    2 +
>   drivers/base/property.c                       |    2 +-
>   drivers/clk/Kconfig                           |    8 +
>   drivers/clk/Makefile                          |    1 +
>   drivers/clk/clk-rpmi.c                        |  616 ++++++++++
>   drivers/irqchip/Kconfig                       |    7 +
>   drivers/irqchip/Makefile                      |    1 +
>   drivers/irqchip/irq-riscv-imsic-early.c       |    2 +
>   drivers/irqchip/irq-riscv-rpmi-sysmsi.c       |  328 ++++++
>   drivers/mailbox/Kconfig                       |   11 +
>   drivers/mailbox/Makefile                      |    2 +
>   drivers/mailbox/mailbox.c                     |   65 +-
>   drivers/mailbox/riscv-sbi-mpxy-mbox.c         | 1017 +++++++++++++++++
>   include/linux/byteorder/generic.h             |   16 +
>   include/linux/mailbox/riscv-rpmi-message.h    |  243 ++++
>   include/linux/mailbox_controller.h            |    3 +
>   include/linux/wordpart.h                      |   16 +
>   29 files changed, 2990 insertions(+), 83 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/clock/riscv,rpmi-clock.yaml
>   create mode 100644 Documentation/devicetree/bindings/clock/riscv,rpmi-mpxy-clock.yaml
>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,rpmi-mpxy-system-msi.yaml
>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,rpmi-system-msi.yaml
>   create mode 100644 Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.yaml
>   create mode 100644 Documentation/devicetree/bindings/mailbox/riscv,sbi-mpxy-mbox.yaml
>   create mode 100644 drivers/clk/clk-rpmi.c
>   create mode 100644 drivers/irqchip/irq-riscv-rpmi-sysmsi.c
>   create mode 100644 drivers/mailbox/riscv-sbi-mpxy-mbox.c
>   create mode 100644 include/linux/mailbox/riscv-rpmi-message.h
>

Most of the patches have been AB/RB by their respective maintainers, so 
how do you expect the patchset to be merged? Should it go through the 
riscv tree?

Let me know how you want to proceed, I'd be happy to merge it if that's 
easier for everyone.

Thanks,

Alex


