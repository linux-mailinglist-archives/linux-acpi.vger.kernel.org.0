Return-Path: <linux-acpi+bounces-20148-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BA735D0D69F
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Jan 2026 14:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA0603008D4D
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Jan 2026 13:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E711DFD8B;
	Sat, 10 Jan 2026 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZUJ9+17"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4151B4F1F
	for <linux-acpi@vger.kernel.org>; Sat, 10 Jan 2026 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768052806; cv=none; b=c8HCvSxG2w0MsfK+T1IDGbv4pGyvl9o0ThGdsqddpxN0dYSlPMEBPF9qcCrgXr13B9zFbRPnpflxrX187QwJiQu3UfRpsgzFicn1iEPVSM2G4O+a/Usx63x90XPBxUzkNKmowJy1p0Kym19yRsPWxi10+vXL1/Qjm/ZhaeCbn6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768052806; c=relaxed/simple;
	bh=q8mT9StIiIn4yIgBQfTjUeq3j3eVjuquWYvPqKNl3x0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HBp9foJsgEZaLys9cvBiHDFJJjyAKdH6g2xtbdh2YwdcEjoVYvDcJY5ZK3lRqegzuL/Qh6lP34kDPbGVkzmeTkNf42kF4ALIuJmRAfiofVP/7ak3Gre1+ebhQLJiHhegGxHgGvJZvipsRuzdLgd8CUNY32MtTz3bEaB0m51bKyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZUJ9+17; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-11df4458a85so4487835c88.1
        for <linux-acpi@vger.kernel.org>; Sat, 10 Jan 2026 05:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768052804; x=1768657604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPm1mH2E9PkjFiRRoRqFuaVOVWmSs32ti0r4GJyt90g=;
        b=JZUJ9+173Y1QFP4K7AVtmrSPP99Yri9X6W5Ra0BzSu0CDJU/3XAn0ZffhqbtVU7y0p
         xRG/LMx5f4Repx8UfaHh56JSE5aPNTdArRvrc6oDvtiLR+dUwgu1hokEDWCSciiLAFBd
         mRIxHvl5PonzeUw5nD+C1ut3pilqon+NOXDVZ6VyEdDtZNhmYgst6+l5+Mu2KuzmXO/Z
         NVFT+NXJzSV2OGO2XW9fBskrv1XLFseOA/FWwSWH0oTLu64U9B50EmoQrj6cwfhlUkfB
         +mpVq+iiIXlNdNN0QIIbgxsQY+HPJkhrcfGvjonpj5U1rcBAIcEs2Cr6gp70fFa6YOyI
         7YXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768052804; x=1768657604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FPm1mH2E9PkjFiRRoRqFuaVOVWmSs32ti0r4GJyt90g=;
        b=NNK90EcAbJtp2CxKGK07FcqVr/ZA/X0SWGU4U8oTJInwriU86elDlSxVeO9clU4YYM
         zF3ALO7mIY2pUq+skAxC9CVVlv0xGbyATK9qcPW9uCg2Z6050lWM89hRQ4wPQwLZsjiF
         PYk3VypwFv+FsCIPtSjDCFvNKhkXlgNjjjcowmmyqreHAp8INxytrJY0eSHXLi5JDIj2
         mXCD18riMjYgtzOBo+Pcc+Dcyi4sitAXEt38SkqZ/8P0QJHIZNkcdsEHn4qTF7AjZ8MO
         JrLnD6mtIasZF44bKoWkAHKyPaCjnscmhWhumi+fugAtErg+VIHBgtLNrLevJ9IK+3Zj
         n+MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkGCaPMIW2fErkVTRgTI5zsbOzrNodI/OFoEpEZjmkwBp1V4boIFsQNo1AqvagE7/X685OMN/GF6a5@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjv4JeDMO/P3sAajQMu5WwlhUCeRtchnkRsFbaeOJtx7uwAjy7
	ZPHbxO3X2upgNghT0KAeLIKiPAvCQg4A7D84PY2JuqtpKxCmyP2g/HOJFubp0UhhLNUgnXdF4gt
	pyCjzry6Rf5cWhiyVKA38SqynrZIjAuA=
X-Gm-Gg: AY/fxX5xpzNMYUAs0nqCGsb7SeIzrcW88o85ODtrYDZO7SGDa330nmsg1M7ICQiHPxf
	peqwX5TLCfi8tUZAoaCfoXeeg+hhlzyP+IuGA3JBvxWkQosPR2zCnZrE3y6zh6xkl1RkI7v1x7f
	5T/zidGNdamfGLpNfLW3vlxpWl4PUv0g/q/Mzy0MyhFRYVmaPG71UqcjsVe8BgfZkWpOhPZM5NF
	Ydi3heyZESaQ/IR9gEXBNPqXLoe0ArvTDs7QtnGKu12InfzljTmRDOM5byY19TEFpLlOf4=
X-Google-Smtp-Source: AGHT+IGl1dm4CpeMJKL96mAAKQUjvoDZs+VmtRoozMRbubWDV+LgRSlm6BAbFcguSRVV0kQfbsnSeFrUnno7hBPip2U=
X-Received: by 2002:a05:7022:23a8:b0:119:e569:fb96 with SMTP id
 a92af1059eb24-121f8ab693cmr14307648c88.5.1768052804144; Sat, 10 Jan 2026
 05:46:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109033859.187086-1-islituo@gmail.com> <CAJZ5v0hEPum5414FzNC-i-oF07YSXOXavQjtUyRs6q21mCzrbQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hEPum5414FzNC-i-oF07YSXOXavQjtUyRs6q21mCzrbQ@mail.gmail.com>
From: Tuo Li <islituo@gmail.com>
Date: Sat, 10 Jan 2026 21:46:35 +0800
X-Gm-Features: AQt7F2raG0n2DYQZw4jfmVEZhXvuZAeTjF0Q5rASgpAawTwzc0R6fZys3qpbjqM
Message-ID: <CADm8TeniUDHajFA0sb10R=m4xK-ocyFmajkf_4BzPeea72Mrow@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: processor: Fix a possible null-pointer
 dereference in acpi_processor_errata_piix4() when debug messages are enabled
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

Thank you for the careful review.

On Sat, Jan 10, 2026 at 5:19=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Fri, Jan 9, 2026 at 4:39=E2=80=AFAM Tuo Li <islituo@gmail.com> wrote:
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
> >
> > Signed-off-by: Tuo Li <islituo@gmail.com>
> > ---
> > v2:
> > * Add checks for ide_dev and isa_dev before dev_dbg()
> >   Thanks Rafael J. Wysocki for helpful advice.
> > ---
> >  drivers/acpi/acpi_processor.c | 27 ++++++++++++++-------------
> >  1 file changed, 14 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processo=
r.c
> > index 7ec1dc04fd11..e43978b0d83c 100644
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
> > -       if (errata.piix4.bmisx)
> > -               dev_dbg(&dev->dev, "Bus master activity detection (BM-I=
DE) erratum enabled\n");
> > -       if (errata.piix4.fdma)
> > -               dev_dbg(&dev->dev, "Type-F DMA livelock erratum (C3 dis=
abled)\n");
> > +       if (errata.piix4.bmisx && ide_dev)
>
> Why does errata.piix4.bmisx need to be checked in addition to ide_dev?
>  If the latter is not NULL, the former is set, isn't it?
>
> > +               dev_dbg(&ide_dev->dev, "Bus master activity detection (=
BM-IDE) erratum enabled\n");
> > +       if (errata.piix4.fdma && isa_dev)
>
> And analogously here.

Checking errata.piix4.bmisx (or fdma) in addition to ide_dev / isa_dev is
indeed redundant, and I will simplify the conditions accordingly.
>
> > +               dev_dbg(&isa_dev->dev, "Type-F DMA livelock erratum (C3=
 disabled)\n");
> >
> >         return 0;
> >  }
> > --
>
> And you need to change the "break;" statement at the end of the first
> "switch ()" block to "return 0;" if you don't want to initialize the
> new variables to NULL.

Good catch! To avoid any risk of using uninitialized pointers, I think it
is better to initialize ide_dev and isa_dev to NULL at declaration.

I will address both points in v3.

Thanks again for the helpful feedback.

Best regards,
Tuo

