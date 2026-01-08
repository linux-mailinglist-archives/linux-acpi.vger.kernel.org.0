Return-Path: <linux-acpi+bounces-20060-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D51D0353C
	for <lists+linux-acpi@lfdr.de>; Thu, 08 Jan 2026 15:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3B2D3238088
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jan 2026 13:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BC5328B60;
	Thu,  8 Jan 2026 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrIX2GMW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B986337FF61
	for <linux-acpi@vger.kernel.org>; Thu,  8 Jan 2026 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767879165; cv=none; b=hselIlGjwEJRwrfwLnCelBHJcUD7D1bOjnOnJeu9qCvSEveAOMBqf31ewkUS4eV/zgLrrqQ3IJ6sweSLsRzf3AoIqQe0/ffYfkpd58K0iekps9D542PQwFhKlKFn8lE9W7N+Sm1GXjZfiyiEeQRRaD3iiFSQJJTNOwLuOTNFv8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767879165; c=relaxed/simple;
	bh=Wvww7vZ0DB21ERIotv5CaS5vro46IN6JUNZOrB2SQIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fB37RFDQ1QsrXLa3p1w3tQhS0OQ0Nst+rtuL299FC3atPp2W6QBQYOY/DtE88qGKFCsHMk/juQ+L2lE/D/7yx3iIarAdfjV/laaUZZ4d2feuxcwO0g6utfYoX1Fqi00YCLxhN3uYu6ahe9GKn56TfwuTEl/xtMTn7Uc2otlrxcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrIX2GMW; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-11f3e3f0cacso3352058c88.0
        for <linux-acpi@vger.kernel.org>; Thu, 08 Jan 2026 05:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767879161; x=1768483961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCNs2kjgIT6kMvkT1/HYipAMuaQ5d8q4dP9luvyKVIQ=;
        b=UrIX2GMWJ4nImm84BgUDhsIkAS844P9W+kVHvwwcHNZE0rDgGv2lGrE59apVXhwoZ3
         ebeGEW4hMGTZaTD19aN4cWPd8wODsn6aVcNysOMVZY5aPHVtXFwCdRs9tP6ut4OdBhmu
         Tq35nGZN7VrCf+Pk/rySwrm77eEUf71OerGzW0Lkay+hB9UMUgCp6uzP0FH2IPSRQV1c
         8V0WLi1O+t9q7e5oPx5KAEEnFqqfrwGeSQBTuhL8Zv3JHOZX5vKzdlzhvajkPj0bjD9Y
         o5ehm3rUR4+3JuewI7ZrRuQCY0omj+GUuMqjWUssgTzwcPi1SiY1SsntZbfUpo0QJhza
         fv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767879161; x=1768483961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZCNs2kjgIT6kMvkT1/HYipAMuaQ5d8q4dP9luvyKVIQ=;
        b=njPU52fihktbGVYFQfeTu9zZywyoiz+A9MGsqNPWw3wxgLehzjU1x5rdVmf/rTED/H
         i6JI+pNphCx3ymHMC4w7nq6qMq7YkO/TFeqShZTwdn5MeRXKB/J3ae4EtK8b9snml61F
         wUHcGoWJUMz3bY9QSEIaHqwUS+D2j0eSPEigAYh1aItRMvVcTAyHCHdxKhDze0MNqIlZ
         DJLGrBqioCXK0cq4jWX7WTomdqaPtK065CYpBiN40lvSbx4lRta7dYyiYiW3EuJpb06Q
         s0MI8ogXMkvZdJN3FH1cc22zrOnznIod5eN6jBvUkOx2HAe0Ice8s8HAi9dg2VMQmT/0
         VgJA==
X-Forwarded-Encrypted: i=1; AJvYcCXeMM74kRboB6GGfleSL7JNW5ZO6oTG8keztNHzDTErMOIubJcHxb4hCyjnt+Kxj7yVcB1U3w6QyCuO@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy1t9us5xJW1otUAaqyQqFziJps9Avds/JdWP5V3uDkxNJnv/F
	LRJIR/WhXPmg4bMhuig0Ob3EGcuUT1729wXDFcUwbY3QvTgqyzrefuajqKM+ML1hstI1t/ogBDK
	zMS9ijoqNIXcsz3CZkyhkTdHIECyyt0g=
X-Gm-Gg: AY/fxX5a1qxepnzqMKghLTV5Z/5fku9Fjg1H6nL93uOyKO01Oarl2rKfTwLc8wg6Ieg
	MzZ2N6MzQM28eEMyG7qmhDpeNLURsfJoUy1fEPSePmM0om/M/fg89zhgdNdNDK9vKyQU7DqopgU
	vh8e+2hVNE8GiIeaSdsqfgtHocJoO/66oXWHotaCaQEG2HWzxDqgv/2InEpv0K2GYoVqkWBcORR
	RP6uJGgsYzAO5iNgmGdvziR8li1yfzQ8SoqcRoXlSMNUGCu9BtYjQr9P/z896Ld0TA1Dpk=
X-Google-Smtp-Source: AGHT+IFU8Az40PCv/tXDG7VuYUAw6o4ext2ubuIiC6Z/4hOYnsYtETEAkakhqVprEZ2GGFm9KBaXsIMNZ5wj3jn0HLg=
X-Received: by 2002:a05:7022:985:b0:11b:99a2:9082 with SMTP id
 a92af1059eb24-121f8adcfe2mr4082719c88.15.1767879159377; Thu, 08 Jan 2026
 05:32:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209103114.3964322-1-islituo@gmail.com> <CAJZ5v0gG9v_S7L7S1yuUBLFSXi2GbHUees4p-VEKhVot+2omDQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gG9v_S7L7S1yuUBLFSXi2GbHUees4p-VEKhVot+2omDQ@mail.gmail.com>
From: Tuo Li <islituo@gmail.com>
Date: Thu, 8 Jan 2026 21:32:28 +0800
X-Gm-Features: AQt7F2p6mz4d8pngXbwH67Rw3f9EqGf3EbqKrg9EyKqK0uUztII8ZhB2FmSBdMY
Message-ID: <CADm8TemG+gjPTscQfV5vXQjYVk0-q5WaoetmZbifJzyOhv4UHg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: Fix a possible null-pointer dereference
 in acpi_processor_errata_piix4() when debug messages are enabled
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 3:46=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Tue, Dec 9, 2025 at 11:31=E2=80=AFAM Tuo Li <islituo@gmail.com> wrote:
> >
> > In acpi_processor_errata_piix4(), the pointer dev is first assigned an =
IDE
> > device and then reassigned an ISA device:
> >
> >   dev =3D pci_get_subsys(..., PCI_DEVICE_ID_INTEL_82371AB, ...);
> >   dev =3D pci_get_subsys(..., PCI_DEVICE_ID_INTEL_82371AB_0, ...);
> >
> > If the first lookup succeeds but the second fails, dev becomes NULL. Th=
is
> > leads to a potential null-pointer dereference when dev_dbg() is called:
> >
> >   if (errata.piix4.bmisx)
> >     dev_dbg(&dev->dev, ...);
> >
> > To prevent this, use two temporary pointers and retrieve each device
> > independently, avoiding overwriting dev with a possible NULL value.
> >
> > Signed-off-by: Tuo Li <islituo@gmail.com>
> > ---
> >  drivers/acpi/acpi_processor.c | 23 ++++++++++++-----------
> >  1 file changed, 12 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processo=
r.c
> > index 7ec1dc04fd11..ddd7081430f7 100644
> > --- a/drivers/acpi/acpi_processor.c
> > +++ b/drivers/acpi/acpi_processor.c
> > @@ -50,6 +50,7 @@ static int acpi_processor_errata_piix4(struct pci_dev=
 *dev)
> >  {
> >         u8 value1 =3D 0;
> >         u8 value2 =3D 0;
> > +       struct pci_dev *ide_dev, *isa_dev;
> >
> >
> >         if (!dev)
> > @@ -107,12 +108,12 @@ static int acpi_processor_errata_piix4(struct pci=
_dev *dev)
> >                  * each IDE controller's DMA status to make sure we cat=
ch all
> >                  * DMA activity.
> >                  */
> > -               dev =3D pci_get_subsys(PCI_VENDOR_ID_INTEL,
> > +               ide_dev =3D pci_get_subsys(PCI_VENDOR_ID_INTEL,
> >                                      PCI_DEVICE_ID_INTEL_82371AB,
> >                                      PCI_ANY_ID, PCI_ANY_ID, NULL);
> > -               if (dev) {
> > -                       errata.piix4.bmisx =3D pci_resource_start(dev, =
4);
> > -                       pci_dev_put(dev);
> > +               if (ide_dev) {
> > +                       errata.piix4.bmisx =3D pci_resource_start(ide_d=
ev, 4);
> > +                       pci_dev_put(ide_dev);
> >                 }
> >
> >                 /*
> > @@ -124,24 +125,24 @@ static int acpi_processor_errata_piix4(struct pci=
_dev *dev)
> >                  * disable C3 support if this is enabled, as some legac=
y
> >                  * devices won't operate well if fast DMA is disabled.
> >                  */
> > -               dev =3D pci_get_subsys(PCI_VENDOR_ID_INTEL,
> > +               isa_dev =3D pci_get_subsys(PCI_VENDOR_ID_INTEL,
> >                                      PCI_DEVICE_ID_INTEL_82371AB_0,
> >                                      PCI_ANY_ID, PCI_ANY_ID, NULL);
> > -               if (dev) {
> > -                       pci_read_config_byte(dev, 0x76, &value1);
> > -                       pci_read_config_byte(dev, 0x77, &value2);
> > +               if (isa_dev) {
> > +                       pci_read_config_byte(isa_dev, 0x76, &value1);
> > +                       pci_read_config_byte(isa_dev, 0x77, &value2);
> >                         if ((value1 & 0x80) || (value2 & 0x80))
> >                                 errata.piix4.fdma =3D 1;
> > -                       pci_dev_put(dev);
> > +                       pci_dev_put(isa_dev);
> >                 }
> >
> >                 break;
> >         }
> >
> >         if (errata.piix4.bmisx)
>
> if (ide_dev)
>
> > -               dev_dbg(&dev->dev, "Bus master activity detection (BM-I=
DE) erratum enabled\n");
> > +               dev_dbg(&ide_dev->dev, "Bus master activity detection (=
BM-IDE) erratum enabled\n");
> >         if (errata.piix4.fdma)
>
> if (isa_dev)
>
> > -               dev_dbg(&dev->dev, "Type-F DMA livelock erratum (C3 dis=
abled)\n");
> > +               dev_dbg(&isa_dev->dev, "Type-F DMA livelock erratum (C3=
 disabled)\n");
> >
> >         return 0;
> >  }
> > --

Thanks for your reply.

I will add the suggested checks for ide_dev and isa_dev before dev_dbg()
and submit a v2 patch shortly.

Best regards,
Tuo

