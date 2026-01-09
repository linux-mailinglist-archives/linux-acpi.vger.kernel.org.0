Return-Path: <linux-acpi+bounces-20122-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D7CD0C487
	for <lists+linux-acpi@lfdr.de>; Fri, 09 Jan 2026 22:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 54E7A300D40D
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jan 2026 21:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E7233C519;
	Fri,  9 Jan 2026 21:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ll9aBESq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171D72D94BF
	for <linux-acpi@vger.kernel.org>; Fri,  9 Jan 2026 21:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767993562; cv=none; b=mWaRVGfd7TLuW+/Ifoz6yJIHcoLGWY4vNfVozoa/Q7Cl1P77msp3yyxfK54lGp7hcqto7+jpphM4EBC+ouWIBl7f2X/InuZHOpm9qFLL4TZhMiMgRASkyBGp/Hes2XvZw3TWTqA7P5Pq8MOG0SKOVZAGcm7w3XSIZs46kdhJR+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767993562; c=relaxed/simple;
	bh=/0ULzneR7T9EOzoq4WfrWNnQxFP+dbvVZCBUkkZ2tv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NoQbsbdpIDKUt1+rt9mnU2Q8qYQ4WhsCdjQU+nhkIQQIRpcXRnF+cdNgi0+3aaN+2d21IPpLO3wJb0zdJmak0EI0+2LKWn7v9F2v9Vf3mYWfP5QsuS569z+xKpTqzHw/7ruNkozIg+Du4B4JFqNWj0u99nJPbrGY4stxVxdNuiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ll9aBESq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00CCC19424
	for <linux-acpi@vger.kernel.org>; Fri,  9 Jan 2026 21:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767993562;
	bh=/0ULzneR7T9EOzoq4WfrWNnQxFP+dbvVZCBUkkZ2tv8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ll9aBESqLbk+zm21PDf2V7duFrEwHhv+bwTp1rjVzcR4dx+36j9uOUYsGgCCdCdx9
	 uMjvmz8uNSRjQihrWDFWXJKHBexUg5a+zzIsgEs1JQXwHeVU8RkF2m3uOKuyR8jEft
	 nhO5RxKkqJQUC7joq+WCgGu8L0Ym8lJBSn+GzgGMuXtdqMj0UVeOrAv+Hr6VT0azPC
	 2K9tun33elJeFY9YmHKBWVZcNLO6JQsnhmjRQ1f+/KE/nEwWE4TSO07HjOIkbstAwy
	 FqsM5wRSDifUOHPqZGPge2JXARyyojrewTglEzsYXym2I0kOnjj7qaOUE1bdAuV6dC
	 IVrP9xuHRex2A==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-45a3145faddso1561886b6e.2
        for <linux-acpi@vger.kernel.org>; Fri, 09 Jan 2026 13:19:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXrSFRtiC3xKINK5C0UGUD3LwOKewlq8wC+IXq0gPh8gJY+tjjWTMdaw5ec+vZx2FVVYYolRxLmaLUH@vger.kernel.org
X-Gm-Message-State: AOJu0Yws5hpVvN887ePuYTvHVdDUwzVOkTK7S/TBsGUjEt0SiulbM3h0
	N/Q9pUHu+scfm+PeAsVBb4tl5cbgPO8FlHypHStkAiIXiTIn5zb2KBGfk8QX9fDVaMXoO/P3xrg
	O2bbzj90eJKxLjMFcG6NOLxMnYDNBZAQ=
X-Google-Smtp-Source: AGHT+IFxY+bXNcAjA0AIsRQvKjlqWfd/LT6KhyS0BfJ2Dt1hsrZ0egO0EkOQA666SmU0Xn9Ky6+t682Bgs7v8WGnOxc=
X-Received: by 2002:a05:6808:191d:b0:459:b40c:8a3d with SMTP id
 5614622812f47-45a6be4136bmr5629611b6e.32.1767993561087; Fri, 09 Jan 2026
 13:19:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109033859.187086-1-islituo@gmail.com>
In-Reply-To: <20260109033859.187086-1-islituo@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 Jan 2026 22:19:09 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hEPum5414FzNC-i-oF07YSXOXavQjtUyRs6q21mCzrbQ@mail.gmail.com>
X-Gm-Features: AQt7F2ptzSTNXLaHjR9YdlmhZC6XSD0LnAZU-qZfCUKqEl6OeUYuk4cFyggW7wg
Message-ID: <CAJZ5v0hEPum5414FzNC-i-oF07YSXOXavQjtUyRs6q21mCzrbQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: processor: Fix a possible null-pointer
 dereference in acpi_processor_errata_piix4() when debug messages are enabled
To: Tuo Li <islituo@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 4:39=E2=80=AFAM Tuo Li <islituo@gmail.com> wrote:
>
> In acpi_processor_errata_piix4(), the pointer dev is first assigned an ID=
E
> device and then reassigned an ISA device:
>
>   dev =3D pci_get_subsys(..., PCI_DEVICE_ID_INTEL_82371AB, ...);
>   dev =3D pci_get_subsys(..., PCI_DEVICE_ID_INTEL_82371AB_0, ...);
>
> If the first lookup succeeds but the second fails, dev becomes NULL. This
> leads to a potential null-pointer dereference when dev_dbg() is called:
>
>   if (errata.piix4.bmisx)
>     dev_dbg(&dev->dev, ...);
>
> To prevent this, use two temporary pointers and retrieve each device
> independently, avoiding overwriting dev with a possible NULL value.
>
>
> Signed-off-by: Tuo Li <islituo@gmail.com>
> ---
> v2:
> * Add checks for ide_dev and isa_dev before dev_dbg()
>   Thanks Rafael J. Wysocki for helpful advice.
> ---
>  drivers/acpi/acpi_processor.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index 7ec1dc04fd11..e43978b0d83c 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -50,6 +50,7 @@ static int acpi_processor_errata_piix4(struct pci_dev *=
dev)
>  {
>         u8 value1 =3D 0;
>         u8 value2 =3D 0;
> +       struct pci_dev *ide_dev, *isa_dev;
>
>
>         if (!dev)
> @@ -107,12 +108,12 @@ static int acpi_processor_errata_piix4(struct pci_d=
ev *dev)
>                  * each IDE controller's DMA status to make sure we catch=
 all
>                  * DMA activity.
>                  */
> -               dev =3D pci_get_subsys(PCI_VENDOR_ID_INTEL,
> +               ide_dev =3D pci_get_subsys(PCI_VENDOR_ID_INTEL,
>                                      PCI_DEVICE_ID_INTEL_82371AB,
>                                      PCI_ANY_ID, PCI_ANY_ID, NULL);
> -               if (dev) {
> -                       errata.piix4.bmisx =3D pci_resource_start(dev, 4)=
;
> -                       pci_dev_put(dev);
> +               if (ide_dev) {
> +                       errata.piix4.bmisx =3D pci_resource_start(ide_dev=
, 4);
> +                       pci_dev_put(ide_dev);
>                 }
>
>                 /*
> @@ -124,24 +125,24 @@ static int acpi_processor_errata_piix4(struct pci_d=
ev *dev)
>                  * disable C3 support if this is enabled, as some legacy
>                  * devices won't operate well if fast DMA is disabled.
>                  */
> -               dev =3D pci_get_subsys(PCI_VENDOR_ID_INTEL,
> +               isa_dev =3D pci_get_subsys(PCI_VENDOR_ID_INTEL,
>                                      PCI_DEVICE_ID_INTEL_82371AB_0,
>                                      PCI_ANY_ID, PCI_ANY_ID, NULL);
> -               if (dev) {
> -                       pci_read_config_byte(dev, 0x76, &value1);
> -                       pci_read_config_byte(dev, 0x77, &value2);
> +               if (isa_dev) {
> +                       pci_read_config_byte(isa_dev, 0x76, &value1);
> +                       pci_read_config_byte(isa_dev, 0x77, &value2);
>                         if ((value1 & 0x80) || (value2 & 0x80))
>                                 errata.piix4.fdma =3D 1;
> -                       pci_dev_put(dev);
> +                       pci_dev_put(isa_dev);
>                 }
>
>                 break;
>         }
>
> -       if (errata.piix4.bmisx)
> -               dev_dbg(&dev->dev, "Bus master activity detection (BM-IDE=
) erratum enabled\n");
> -       if (errata.piix4.fdma)
> -               dev_dbg(&dev->dev, "Type-F DMA livelock erratum (C3 disab=
led)\n");
> +       if (errata.piix4.bmisx && ide_dev)

Why does errata.piix4.bmisx need to be checked in addition to ide_dev?
 If the latter is not NULL, the former is set, isn't it?

> +               dev_dbg(&ide_dev->dev, "Bus master activity detection (BM=
-IDE) erratum enabled\n");
> +       if (errata.piix4.fdma && isa_dev)

And analogously here.

> +               dev_dbg(&isa_dev->dev, "Type-F DMA livelock erratum (C3 d=
isabled)\n");
>
>         return 0;
>  }
> --

And you need to change the "break;" statement at the end of the first
"switch ()" block to "return 0;" if you don't want to initialize the
new variables to NULL.

