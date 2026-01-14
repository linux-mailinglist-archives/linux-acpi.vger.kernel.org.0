Return-Path: <linux-acpi+bounces-20336-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8436D2039C
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 17:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B65DB3065782
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 16:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA523A0E9F;
	Wed, 14 Jan 2026 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvCxIe+m"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E4037F8D5
	for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768408373; cv=none; b=TB0RU2E9asIep0OcVLGnnARpetssAVniXcrjVahdXq83MsWD3ShuVHLFeWn/gyPbxD0XSoBl82nGgU5JKTsefSmTKcNYdYmUp07sWQRwvQWlKAxTC8RBYQ8DDQL5sU54dJWf+Y5sZA+EBuDKT+WLqrHFrrMN7ziL7h8eEUWl2KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768408373; c=relaxed/simple;
	bh=yxFbzugBi+XL4Q2zZ3vWzhT8h7XOQYwQ1Ls091Hf2KY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KaOcPQzT/8VGhzuvQgwTEQ3dRecQpHuhuiflT99cFdFCHLIKJA3FJLQLd8IU3flJytzombU50XujyerR5x0zTCZsjVse43YUU9b22+2s1wKiZAOPUfiEeDdW+SiX5JW43+e7Ey6a3vyPF7WjBHuJW4QkcOPv3G3ZTpNRoXzj5+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvCxIe+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B5AC19422
	for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 16:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768408373;
	bh=yxFbzugBi+XL4Q2zZ3vWzhT8h7XOQYwQ1Ls091Hf2KY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uvCxIe+msDbs0Cnn76p9rza4o6WRHlumXsvvenV4WjtabwouC3kofZxrLYHedTLi0
	 AOdN2gTvPqaPEDr9CZg2PnpPQ7jFQrGcC0SyaQiw8LRCZQ8tXw6GkAtfPWpeAqJBQH
	 Li/cCR84fGFT8WWrbLTXfrK9dwlPpX652jpHoS95HA18YzKBfydnSgCrcS6/UfkfqE
	 hKytybQbhMH4XVq9BAlh/kTRXrCaeNOP2n+L5obLpYmmcdgU9W3O5Ogbx04Fr54hpa
	 2Yl96qo/3/vN5NsWe7D2zPuIfFGMh6VMLObo3oAbGgPKhXNdlaE5fRiE4rNLfsBw3G
	 +hKsZxDzAq42g==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6610b05b37dso321304eaf.2
        for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 08:32:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXsRBY/qPLUODvYFbAnhf2M/zzL/a4yN2tEhlcvHXeudge67gRDtboCrZZ6GMYdcDbrBeGc7kvfuvuX@vger.kernel.org
X-Gm-Message-State: AOJu0YzScPveIvW1MLBFkEQ86JSasJaZYWRrVJ5Oq6mHB4Zk2u+EZ2cp
	y7Qtdwq6ZD+JvmYt/LY0qZrb76OuVUQAPFhG8UTM/LJB+OrpdoEn5yV9dbHKoO3kbXDYVoiNmjo
	4WXQiLglhYExOEXgVygvCo+K75wrGwZQ=
X-Received: by 2002:a05:6820:4d52:10b0:659:9a49:8f5e with SMTP id
 006d021491bc7-661006689b3mr1782734eaf.35.1768408372780; Wed, 14 Jan 2026
 08:32:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111163214.202262-1-islituo@gmail.com>
In-Reply-To: <20260111163214.202262-1-islituo@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 14 Jan 2026 17:32:41 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g_5WTa151v2NfFuh+U8=y=6P7OFvZ7m5RpCaLe_Tggsg@mail.gmail.com>
X-Gm-Features: AZwV_QjtUxfW2Slv9IXslVN5IR1a0us7ARasuIDRLWGjA0m-pz0Pnn-hZBQ27q8
Message-ID: <CAJZ5v0g_5WTa151v2NfFuh+U8=y=6P7OFvZ7m5RpCaLe_Tggsg@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: processor: Fix a possible null-pointer
 dereference in acpi_processor_errata_piix4() when debug messages are enabled
To: Tuo Li <islituo@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2026 at 5:32=E2=80=AFPM Tuo Li <islituo@gmail.com> wrote:
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
> v3:
> * Initialize the new variables to NULL and drop redundant checks.
>   Thanks Rafael J. Wysocki for helpful advice.
> v2:
> * Add checks for ide_dev and isa_dev before dev_dbg()
>   Thanks Rafael J. Wysocki for helpful advice.
> ---
>  drivers/acpi/acpi_processor.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index 7ec1dc04fd11..de256e3adeed 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -50,6 +50,7 @@ static int acpi_processor_errata_piix4(struct pci_dev *=
dev)
>  {
>         u8 value1 =3D 0;
>         u8 value2 =3D 0;
> +       struct pci_dev *ide_dev =3D NULL, *isa_dev =3D NULL;
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
> +       if (ide_dev)
> +               dev_dbg(&ide_dev->dev, "Bus master activity detection (BM=
-IDE) erratum enabled\n");
> +       if (isa_dev)
> +               dev_dbg(&isa_dev->dev, "Type-F DMA livelock erratum (C3 d=
isabled)\n");
>
>         return 0;
>  }
> --

Applied as 6.20 material, thanks!

