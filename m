Return-Path: <linux-acpi+bounces-7932-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ED1962DF1
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 18:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C191C21869
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 16:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA921A4F09;
	Wed, 28 Aug 2024 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PedrDLI9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763591A4B84;
	Wed, 28 Aug 2024 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724864242; cv=none; b=HvU5X7Ei1/nEP6HNRnyqLN2f/STEBsSOysZutwG12KvHzd5LponWcpuAjjpub9DHIpBrMC3lKaY6nwwgyxi9mt0rhucY5BAWcYsnBAEZxYimt7Uu3kJR2Js8PUwjw7RzREyaYeYVc0yAdHb5zJ+ttvrFekw6B7/gvR+dyejZq4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724864242; c=relaxed/simple;
	bh=U1TLFQZt+dZF4bzcYiLl5fLCz7z4c7CpxWEGSxiBo/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XoCPV10WTWCpfqp7Lg4BkmebWDm1sN5+eEg1to5RtBr+CgEQKyZZelF/pl8Ohh/Bru4GpMF4YuDRKm1jxk3PTaudG3b8M+FhrYQZXvB+yMJfeTS2us4YPqHYKQCdRXDr3zGW8foq1spOCkrWKpiotuO8oimgCi4/AIOYi2i6Ijk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PedrDLI9; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a80eab3945eso720736766b.1;
        Wed, 28 Aug 2024 09:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724864239; x=1725469039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZd4+X6vP9oPWuhaKm7zNB7TUyUBJnLZr/iH8MefkcA=;
        b=PedrDLI9rFCDLvvGlu51084wkQ3PYz1ESNvamzeQyFqHSAWSPDwpxOS9eTsh6YfGUC
         4aXAs/fEBHhcjywSF9tgt65jexY9URIT7hv0kAedfuud6n+BjOKEOZNY2bu+scy27INq
         KhxDOfGnFcU07CCIbNWzZp8c8jFUhGkL2MzNNzVRZ3zx3VSzUb9kjvRaRDB6hr5lZJ5J
         YWEWZ3XpAwz+KRMFTrHpB1rJM1kM9wX+SH12PuCUmIP0N+Xy+hoLeG3PMjbNbTSrFr5r
         sc6zh8dU8ljb2wM5MDst3KOvzbSCrgcQaUipVicjbNdVUDaJVMEbMf279c+T1DvgmD68
         KYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724864239; x=1725469039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZd4+X6vP9oPWuhaKm7zNB7TUyUBJnLZr/iH8MefkcA=;
        b=P2IZfe5x36pbTolxzxWcMhYxt+1KoNNF4u24nXrYA2VE0D7QBwOMvTI1Nm7fFKG2X/
         BM0CYQUmQvF6AS3v4mZ45tFKtOLiRcm5FkFP3hPuRPcJrBgnOCUd5ZS+qCSRp4MbNvF2
         UiLzMfE2rlRpWBQndF4Ia8m9UEtX9wBl8DsbJ7yG4vvF7JW/f3XWab6wSOvQbRkLbB55
         UebSOcaHGTYixgnjoQCvv80RblLMobunJyd/X1Qs/0ioFuEwwEkaSLNAx1S/VrQfHklg
         63TT53rdEN8pQfFiBbm063I0ZMRldqayfAXP7IKF7rxfif1Nq5dpabAYbznwBJLXh8v3
         EcuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPImXmn3ktyZdhgDvpu7WhqCPoquDxnq+HGxZKWKKp46FQ+A/f+c1f29C1c0TuvsycG3n9XDaLGtcG@vger.kernel.org, AJvYcCWOF06MwIvGneRuKVZvhDmMA2DzhWN2NnmaErQl3WEYaHpQG+VxJ2UNQQ8uNTZHix3C+FugUqYsffQdbg==@vger.kernel.org, AJvYcCWl3Mb+rFCYtTPof9Xhp7lAmpze0hhdVnZBTeuWyD9qfCbW3Ve9jDQzE0LpcPaJcDNvolQln9fHbM013jKw+zc3d126gQ==@vger.kernel.org, AJvYcCXtZvrMl+fIxgccRL7vaPNZg+w1kjM/Vb+jC+3/PIFo8lJe/gHtoUBnkXpKBh6f+iHGyLD6/9e3dLZ6UooI@vger.kernel.org, AJvYcCXwqeigUMdZfJVRRDBtePLtEZpOgSMewWtz3UcQJDpp3KsN1Klepnj7cML38V1s76OvnX2RAQ0L1Q+O/fD7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7e3EEhYtCiAzIUQoOZ/zIpfeYWlAQI3gzvNJZMeCFhND1AuPI
	teTVc2STS4fM9EOlx+MhC+NAosNpvqtGR+x9coX927b3dmOZVHXNJubM0fU8HlEPgtOMR9j5D1y
	BSRmdU9x+m28HzfopKm4QbRp8oUE=
X-Google-Smtp-Source: AGHT+IG/QArrAZVDgpeDjqm2F/8OGnFom+dDc3g4zYBO1Pm7dMXBAlMGEmqv5hCiQV6E8eEUKTe02AIlrhmGEnPJ/cU=
X-Received: by 2002:a17:907:8694:b0:a86:7adb:b32c with SMTP id
 a640c23a62f3a-a897fad73a7mr4318166b.68.1724864238423; Wed, 28 Aug 2024
 09:57:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814-topic-sam-v3-0-a84588aad233@quicinc.com>
 <20240814-topic-sam-v3-3-a84588aad233@quicinc.com> <ZszrjQChQ2aS5YjV@surfacebook.localdomain>
 <d08d41ad-edcb-48ad-a848-53edc45ab8eb@gmail.com>
In-Reply-To: <d08d41ad-edcb-48ad-a848-53edc45ab8eb@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Aug 2024 19:56:42 +0300
Message-ID: <CAHp75VcbjR8HQqPASLFEGiyYLfTFQDa6Ri+jFy+7Q1xz7gY39Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] platform/surface: Add OF support
To: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <quic_kdybcio@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 12:10=E2=80=AFPM Maximilian Luz <luzmaximilian@gmai=
l.com> wrote:

> I thought I should provide some context:

Thank you, my reply below.

> Am 26/08/2024 um 22:54 schrieb Andy Shevchenko:
> > Wed, Aug 14, 2024 at 12:27:27PM +0200, Konrad Dybcio kirjoitti:
> >> From: Konrad Dybcio <quic_kdybcio@quicinc.com>

[...]

> >>      nodes =3D (const struct software_node **)acpi_device_get_match_da=
ta(&pdev->dev);
> >
> > Hmm... Why this doesn't use simple device_get_match_data()?
> >
> >> -    if (!nodes)
> >> -            return -ENODEV;
> >> +    if (!nodes) {
> >> +            fdt_root =3D of_find_node_by_path("/");
> >> +            if (!fdt_root)
> >> +                    return -ENODEV;
> >> +
> >> +            match =3D of_match_node(ssam_platform_hub_of_match, fdt_r=
oot);
> >> +            of_node_put(fdt_root);
> >> +            if (!match)
> >> +                    return -ENODEV;
> >> +
> >> +            nodes =3D (const struct software_node **)match->data;
> >
> > This is quite strange! Where are they being defined?
>
> Essentially, this whole module is a giant workaround because there
> doesn't seem to be a way to auto-discover which functions or subdevices
> the EC actually supports. So this module builds a registry of software
> nodes and matches against a Surface-model-specific ACPI ID (in ACPI
> mode). Based on that ID, we retrieve the tree of software nodes that
> define the EC subdevices and register them using a (virtual) platform
> hub device.
>
> The snippet way above registers the platform hub device for DT,
> because there we don't have an equivalent ACPI device that we can
> use. The code here retrieves the respective nodes.

Yes, and software nodes for DT are quite strange things! Why can't you
simply fix the DT to begin with?

> >> +            if (!nodes)
> >> +                    return -ENODEV;
> >> +    }

...

> >> +MODULE_ALIAS("platform:surface_aggregator_platform_hub");
> >
> > Can it be platfrom device ID table instead? But do you really need it?
> >
>
> I think the explanation above already kind of answers this, but the
> module is named differently than the driver (so that they reflect the
> specific nature of each, registry vs hub device). And the platform hub
> device added in the snippet I left above is named after the driver. So
> for the registry module to load when the platform hub driver is
> requested, it is needed.

So, I believe it warrants a platform device ID table to make it explicit.

--=20
With Best Regards,
Andy Shevchenko

