Return-Path: <linux-acpi+bounces-20016-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF567CFFE62
	for <lists+linux-acpi@lfdr.de>; Wed, 07 Jan 2026 21:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88A0D31645F1
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jan 2026 19:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433B932D0D0;
	Wed,  7 Jan 2026 19:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9y5dLf3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4206C1F3FEC
	for <linux-acpi@vger.kernel.org>; Wed,  7 Jan 2026 19:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767815161; cv=none; b=lcASBE6LQ35Kvu+Uwrd8ONaSnUQUn2WhZ6sJ3CwO6exwZnSRls6UxAXJhxduXE9I3iQYAL3LaY7F8TkBDFSBtagYS1VrFP3Jwh9PMZT8t5m2m5FuZf61qn0ia3145txCzOC0xZDZYeKYDd9JOXu0LQEtp6QerTa/is0Der/QyD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767815161; c=relaxed/simple;
	bh=WLBRYbWlO+SSdjbkqp6MpyNoUyQRIYhgDiK8Y9YY384=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHzuOqhbEyfjxfxMRWP1D8P8L/QyqVAH5e3e2FNEl/IoNmnR11kkpiULvq9lZCUYjydutbdUtgV283eHSTo5loSyUgAHDoowcgRurSAAU4SS+5LzIdADn0XszbkPxtIZwtfJBqpodQVzC7GR938g95iSMsW1StN+1ehHYBdrEYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9y5dLf3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890F0C19422
	for <linux-acpi@vger.kernel.org>; Wed,  7 Jan 2026 19:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767815160;
	bh=WLBRYbWlO+SSdjbkqp6MpyNoUyQRIYhgDiK8Y9YY384=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d9y5dLf3jpY30pG8Bzvlqz0aeNHPHmg1HWk/8Df+YnhKNgPaiCJVdb9qnxnd855sv
	 Q4N62wz5TAr2XYk/WzNPU7UT++BYZSO6OVtwW9kGY9f5asox1E3qRM+BlNeyY17Vat
	 dGO3SQujEz4QPQ4Dx3OJgTZsAOmE0BbG0Dvb+R6qGIZTr2Hzn1ATllQN14JYjZ6yPl
	 nNsWfc4vNmyl7KUMJ/lowOOppwrzdGWqn1WwH8l2nEmrRyran4yshvSp/6FsrBYPHU
	 Y0cmdqOGTMMBFkUeWfQsxGqYnNnj3aVP/l2oWFN0ObHT8uLHDktlIAXKaRQUKBg7CB
	 E7YJCS/SuWoYw==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-3f13043e2fdso1007275fac.1
        for <linux-acpi@vger.kernel.org>; Wed, 07 Jan 2026 11:46:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUQd3wocgtcQyIKACeOFjTIiMRqXNg5rIHuyP6hwhvv7Mj0YAoimWf7KNmuHbJr2YOqk1PXFIRcSdBq@vger.kernel.org
X-Gm-Message-State: AOJu0YydxwCugC4Ix8VQ0AFDcGlLeIZPScWtM25HgWlvmWVa9VAG3ycq
	gWZQqbubbaQ64AnYAxiSxGGomQ1PlsvCeAiEJ0EDATg2qfEpTf2ofSsL57bHhoC6nxRT9Xo34fp
	/8fV3yCnoaHa1RzeAzRBQtUSuma5IzMI=
X-Google-Smtp-Source: AGHT+IFRRVxUcSFa1tJ+wIdsIYUv4qLqntR2omwbt3n8ayURPfnQutw463XAXKCS0yNH8GYcWqqnUdrmHlTMgpdaEEY=
X-Received: by 2002:a05:6820:2205:b0:657:42c3:42f0 with SMTP id
 006d021491bc7-65f54ef1d20mr1619093eaf.2.1767815159608; Wed, 07 Jan 2026
 11:45:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209103114.3964322-1-islituo@gmail.com>
In-Reply-To: <20251209103114.3964322-1-islituo@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 Jan 2026 20:45:47 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gG9v_S7L7S1yuUBLFSXi2GbHUees4p-VEKhVot+2omDQ@mail.gmail.com>
X-Gm-Features: AQt7F2rVWHuo8jqhnqC_JLPR8VsdmtbmZkpBLdoULhlDAcjgTF6bQ9w56EeVBGM
Message-ID: <CAJZ5v0gG9v_S7L7S1yuUBLFSXi2GbHUees4p-VEKhVot+2omDQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: Fix a possible null-pointer dereference
 in acpi_processor_errata_piix4() when debug messages are enabled
To: Tuo Li <islituo@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 11:31=E2=80=AFAM Tuo Li <islituo@gmail.com> wrote:
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
> Signed-off-by: Tuo Li <islituo@gmail.com>
> ---
>  drivers/acpi/acpi_processor.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index 7ec1dc04fd11..ddd7081430f7 100644
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
>         if (errata.piix4.bmisx)

if (ide_dev)

> -               dev_dbg(&dev->dev, "Bus master activity detection (BM-IDE=
) erratum enabled\n");
> +               dev_dbg(&ide_dev->dev, "Bus master activity detection (BM=
-IDE) erratum enabled\n");
>         if (errata.piix4.fdma)

if (isa_dev)

> -               dev_dbg(&dev->dev, "Type-F DMA livelock erratum (C3 disab=
led)\n");
> +               dev_dbg(&isa_dev->dev, "Type-F DMA livelock erratum (C3 d=
isabled)\n");
>
>         return 0;
>  }
> --

