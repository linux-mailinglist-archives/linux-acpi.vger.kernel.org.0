Return-Path: <linux-acpi+bounces-14919-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 660F4AF11B1
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 12:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749B044398B
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 10:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E6A2522A4;
	Wed,  2 Jul 2025 10:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKb9H5tj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EA0226CE1;
	Wed,  2 Jul 2025 10:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751451718; cv=none; b=ErtYBKOIlUx457rlf1kZ7SHebXLbx4KMCf4poPXhKjPmWHvsLrB0OgtBRnjt44SRhgeeDoNJEOOLIMFmH3u8ws5lbMD+5UpoOVnPJEm+9Rx+5Itob5m7644SL8l0m/hUe+h+Va0GgKDg7JpOpEM0DB8I4GH41LMHusMzAeCB8MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751451718; c=relaxed/simple;
	bh=dev3dwMQN1yzY1rh7c/NWkAu3zaem3ULhrEy2Os6A3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HcHYegp5MWqKj7LmAGUjGMKwp5Sp8e9q7Gtx2LMpJUljHMM9H0sDa9EChJ8Q2G13es62Pafw0QSTmQyrxZHH0jbqc/IZ2mJqHhQdxRmI/306ZkJOxV0dw7CG5n0aBHjHQ7fjbqoYNdg+R585gwmvR+9UpDLumXsz0Pj0gfZYnnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKb9H5tj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1151EC4CEF4;
	Wed,  2 Jul 2025 10:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751451718;
	bh=dev3dwMQN1yzY1rh7c/NWkAu3zaem3ULhrEy2Os6A3k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gKb9H5tjCKMpWdrmwlrz4o511Ue55dDLqhHuWDZQwxHTV2jvlbA4Bxo/YrK8TzDQ2
	 GeyXY3dZHvu27WNWPlSyx4VUXfBtWXq0kfulrZewtKrJYEge60w+7ZwYJ2U0iX9Ukm
	 u0rLb6x15YkOmZxjW1GTjqtI/nrdKvSkY04sImgXHd+t5xcT4Mc4Aq79bV5ljFe1vQ
	 j7aC5qkma6xcP7DN8IYGBTKehW8g5unXI7947p0EIo/457fBaZ1cFXoEhbiGvtFLB1
	 UcoBNTD5y0fUfHeLz+gBXnsLRXaV1CEJvZ2e35dzE9JJMd6SA4oQLnVEOVJtE464gW
	 7/i1Z5O/GD9gg==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-40a7322f081so1014040b6e.3;
        Wed, 02 Jul 2025 03:21:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVefSB4rD8MaagsKqjYG0+8y3Y9R6cEUYQwFvsBlttg4o+R852DhN5Glul9wgSrTyjUmOHKczTChhSEVCec@vger.kernel.org, AJvYcCWf/tkyfWCIeW7bXX3Kk1VKy8VuRqmZ8JNkRDU+sUddgxubd09zTLUe/O7Xv241IgdnI7RA8T5dVHyv@vger.kernel.org, AJvYcCWx460XCh5wzO8e8xJRXxRkdcC6jyygxdLSO0vdUBnjbqO35P1XepB3k4c6ohPircW2ibxL4DPOh4OxGg==@vger.kernel.org, AJvYcCXIH/YM1ordZjBOWQGdTa/J4hQnVV6Ejf8rJCXjS3g4al4oJZVvUW/O0ABTz2Qq6avgHtJfV6wWSgUK@vger.kernel.org
X-Gm-Message-State: AOJu0YyEqxuopzDImb3Z5+rdtyoPtjBwjtEWsFOSupVnK5BBphD7Oa2e
	7/ap3nevCpKx3rTFHFK12zp2PXygxfOlE9R+g+nekKr6aEsO3hFG72IH+uFkfv0c20Z52Wb9UUx
	qdqTahqUQrIB15F+VxI8UWcvmzBoczAg=
X-Google-Smtp-Source: AGHT+IE2Kkk8T0ZbVBmpiOQbam/pLa6wG5+XN/RreLIx2X9wnWq0x8o9JpWoqRvdPgQY0h9YV/+fKkFjda3J6bwfL00=
X-Received: by 2002:a05:6808:1b99:b0:3f9:aeb6:6eac with SMTP id
 5614622812f47-40b889192f1mr1729652b6e.30.1751451717345; Wed, 02 Jul 2025
 03:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702051345.1460497-1-apatel@ventanamicro.com> <20250702051345.1460497-17-apatel@ventanamicro.com>
In-Reply-To: <20250702051345.1460497-17-apatel@ventanamicro.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Jul 2025 12:21:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gkCtxMWvgjS+CXOgC2QzCFFQ1bX6XA_D2HCOuGwT67kg@mail.gmail.com>
X-Gm-Features: Ac12FXwD-4N8bNKSBtHuf_106cJhbwii5ybB7cDrqtVYJiIXKxNBIQd1GfJzRU8
Message-ID: <CAJZ5v0gkCtxMWvgjS+CXOgC2QzCFFQ1bX6XA_D2HCOuGwT67kg@mail.gmail.com>
Subject: Re: [PATCH v7 16/24] ACPI: scan: Update honor list for RPMI System MSI
To: Anup Patel <apatel@ventanamicro.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
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
	linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 7:16=E2=80=AFAM Anup Patel <apatel@ventanamicro.com>=
 wrote:
>
> From: Sunil V L <sunilvl@ventanamicro.com>
>
> The RPMI System MSI interrupt controller (just like PLIC and APLIC)
> needs to probed prior to devices like GED which use interrupts provided
> by it. Also, it has dependency on the SBI MPXY mailbox device.
>
> Add HIDs of RPMI System MSI and SBI MPXY mailbox devices to the honor
> list so that those dependencies are handled.
>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>

This is fine by me, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/scan.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index fb1fe9f3b1a3..54181b03b345 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -858,6 +858,8 @@ static const char * const acpi_honor_dep_ids[] =3D {
>         "INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c acce=
ss to camera sensors */
>         "RSCV0001", /* RISC-V PLIC */
>         "RSCV0002", /* RISC-V APLIC */
> +       "RSCV0005", /* RISC-V SBI MPXY MBOX */
> +       "RSCV0006", /* RISC-V RPMI SYSMSI */
>         "PNP0C0F",  /* PCI Link Device */
>         NULL
>  };
> --
> 2.43.0
>

