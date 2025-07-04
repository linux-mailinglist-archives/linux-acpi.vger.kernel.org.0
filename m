Return-Path: <linux-acpi+bounces-15020-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA00AF8F9E
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 12:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60915873B9
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 10:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1772EE96F;
	Fri,  4 Jul 2025 10:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="NlfZj2fr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE52D2F272D
	for <linux-acpi@vger.kernel.org>; Fri,  4 Jul 2025 10:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751623887; cv=none; b=QiRFHjGXD0sFkaPAUGlc9O09WgDiGmIZ834gQSBMWgkxB57Ca1Aekc7VMPCJK8s3hTIrb41+rBxDoy9PqdK9c3R0GZDkEnrmqneStPj/eyUsHcNlT21jo+r8dhJ3NrSqoqhCkaDdOFwGw4qd8bJQazh8vm3rCo+Juwgg17skNCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751623887; c=relaxed/simple;
	bh=ZJfiMH6yrhrW4z13OYY/q+7njP7HRfoaeaZaIxvoLsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AHkt76M+tUXlX4gtOEXmNIuJnKC71AlcF4C8wn6+sKFEgiP1KIR1sRvrmEICWXEwRRdOrzElZx0Url/gcTkZBrGAFD9ltzvo6BgdEMrS0S/RIU1tvvcP3CbBjcCQEzoIjDIOvRx6u7LUN2iIdw3Q/K4bpzpNX8es6BhBMt6hTJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=NlfZj2fr; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-553b6a349ccso1023929e87.0
        for <linux-acpi@vger.kernel.org>; Fri, 04 Jul 2025 03:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751623884; x=1752228684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThnYue16skpDKY73i8RkpzoMae/+gmhFicLx/ccew8c=;
        b=NlfZj2frJ0MoI/3h7QveKv3Y0EgzXgLQw8j2Ge+Wo0BaXCzdjZufQmSA/ijuVDP9gi
         gJz4g/4zLumrGQqytWbXxeWHMEK0gbxZzTnKz0n7dciwIIWnDBRKLTHvXypSBwF4d9i1
         nzIqaSMslKbZh3agm9XKrIDh4JTKzk2qwzddiGAXIXGtyp7+cqPObMq3H+2oSMRCLEJG
         JeqMmMdhVRY0YOqnhqCkiV5Ho1k8WTQduCIqx5tuK/tX66Mi0GDGRrjdo0KTeBKK6VPa
         6dJSqsdmSoDN5QvRnopc0iXMyN3DGNdd08Za0D5A0OiMXr1MFTIDRjxVmRZAXd/GPNJZ
         N2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751623884; x=1752228684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThnYue16skpDKY73i8RkpzoMae/+gmhFicLx/ccew8c=;
        b=cgH8q+Jx4n2NysDU7b2zg+I1HbeFMQKwMcQsX5hCorLkIUgnKI/DtF4dkH6qkdqlYP
         1G9ng+sFCwmOTkXBhZ+LYer8WPelPMgPnoWI1muHwXg5Onk8Kg+IYSWl8gCtigXy/lLX
         VcGRU3RDYWKIChjyQ81VMgl0F0CoskbLPIxnG16BNSmFyAtdL2DJgzVMHbz8dUkpLFcs
         Cz+usJ5lKWtK8DnGEviMJWh+05pnpju+dVD1Sm1lym1rOspIdlFW0Ie4ocf+jgzVR/oD
         qqI99ljGl3aR3CoeBAQ6ZlEbyuk2exOhvdQLjTPtWdQYtgqyQ9QgVhPQ/0s1UHjhWy1w
         lwNg==
X-Forwarded-Encrypted: i=1; AJvYcCXs8UXdLDUMShMIPjuekjuinqgDYpuvr6nsx0JmFUs0R9LFTYKYy3b2UpOb49IfHiM7EDIlucgDf9Av@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ/e4XKrBj2uwuzp+AcoWaKyoI8TtwsNoqF2zHu2FFAFDnGm1w
	ByVPM0n7lI/7zrlzTHK/dlptJHqTcwmSAmLvqrPzupcSK09i+7ndtT7JtYnv/Kel81+Dojqm3Nv
	Ng5RMwaK6peMQYcOjdLbvOW0Pvq+pd40zEV9SHXTcFw==
X-Gm-Gg: ASbGncuG7SvSxEVO4dgwrCX3k+6FQVMGg/4CQ4ZbZYvBfmRT0V9TRmaPCEj87YG/sLI
	j8qb+vasrHWyAguNhUmn+cBGwWg1frEJnwjgoRhDOHMgqw6nqAbE8scNMLDJ2SAcxZXHg5zd3ud
	zp+1yV4my0oAJd2cLPrrlGBXxaLj3GnO0sNRLA4O92KU+lu3BtO8yA/Ew=
X-Google-Smtp-Source: AGHT+IFYm/wR4jTRlbIDDwF6FIxEmPbVXFWiC29PN2h5l87b4kSraGLAGzH7R/iggEXemYKU5MQvLCtTcORv1zFuOus=
X-Received: by 2002:a05:6512:3c94:b0:553:291f:92d with SMTP id
 2adb3069b0e04-556e617c939mr532276e87.57.1751623883637; Fri, 04 Jul 2025
 03:11:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704070356.1683992-1-apatel@ventanamicro.com> <20250704-attractive-sawfly-of-artistry-1c86a3@krzk-bin>
In-Reply-To: <20250704-attractive-sawfly-of-artistry-1c86a3@krzk-bin>
From: Anup Patel <apatel@ventanamicro.com>
Date: Fri, 4 Jul 2025 15:41:11 +0530
X-Gm-Features: Ac12FXzuBcUQShERIhU7sx8yxPVr9NpYbWLk5Qb0GVfeL-KIfhtDK6Kn6d-Jp8I
Message-ID: <CAK9=C2Xt5r0Vjw916U7hV7jR1iRwfaLpvhLYTLmWec_p_1pziw@mail.gmail.com>
Subject: Re: [PATCH v8 00/24] Linux SBI MPXY and RPMI drivers
To: Krzysztof Kozlowski <krzk@kernel.org>
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
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 1:15=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On Fri, Jul 04, 2025 at 12:33:32PM +0530, Anup Patel wrote:
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
>
> Which comments? What exactly did you change? Provide in-patch changelogs
> explaining this, because what you wrote is way too vague.
>

Apologies for being a bit lazy here. Most changes are pretty straight forwa=
rd
except the improvements in PATCH14. More detailed change log is below ...

Changes since v7:
 - Addressed enum related nits in PATCH3
   (Refer, https://lore.kernel.org/all/CAK9=3DC2VxhC6soxHtmacedbeCU=3DrFi84=
Br1RvN2uPcBKoLhRaJw@mail.gmail.com/)
 - Addressed comments in PATCH7 as follows:
   - Added minmax.h to includes
   - Removed "rc" variable from mpxy_mbox_send_rpmi_data()
   - Removed alignment and other checks from mpxy_mbox_peek_rpmi_data()
   - Created separate function to restrict scope of channel_ids used
in mpxy_mbox_probe()
   (Refer, https://lore.kernel.org/all/CAK9=3DC2Ume2CmBYHYob7HSJHu=3DZdfdWM=
+4JYPgFJ9Hir5Oi8cOg@mail.gmail.com/)
 - Improved comments for struct rpmi_clk_rates in PATCH10
   (Refer, https://lore.kernel.org/all/CAK9=3DC2VfvsbFTjecQm0OSsssXbff7wC4f=
qWf3CTmnpWSiaLcBw@mail.gmail.com/)
 - Improved refactoring of acpi_fwnode_get_reference_args() in PATCH14
   (Refer, https://lore.kernel.org/all/20250702051345.1460497-15-apatel@ven=
tanamicro.com/)
 - Improve nargs_count parsing in acpi_fwnode_get_reference_args() for PATC=
H15
   (Refer, https://lore.kernel.org/all/20250702051345.1460497-16-apatel@ven=
tanamicro.com/)
 - Added more comments describing why need to explicitly set device
MSI domain in PATCH21
   (Refer, https://lore.kernel.org/all/aGaUmpw1pVWNAmpb@smile.fi.intel.com/=
)

Regards,
Anup

