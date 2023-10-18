Return-Path: <linux-acpi+bounces-726-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABADD7CDBEC
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 14:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32876B20F18
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 12:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC3C3588D
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98071F5E6
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 11:31:32 +0000 (UTC)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01A5111;
	Wed, 18 Oct 2023 04:31:31 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6c6591642f2so1577870a34.1;
        Wed, 18 Oct 2023 04:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697628691; x=1698233491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHentBHE/DrtRzr1LJu3KtjR8Xr3ccerMFpUqr2z4BQ=;
        b=AcWR8OW0qTzDBZze3vH7HoLMm+nd4zo8Rk1QFBqAI1J8oy3NVUCs9ce/rzjP/oA/gk
         y6XOQWIGDdH7nQbUQMcpE/37kDm50/lbGi7W6U52G7heS2JcqGqYEIZG1zJqQr+YLd6x
         TDrVlU9MAWuY4BkcBCbb1M2nwB40ND5yguHHwO5Vrp5bLSlR5PrEIH6EOIF+h21IIhbX
         IT7y4aD+KK6vo4Tb7SbubW8tsJs93o/bdYqrxRi8BTLOTUWCkgNTv7HKyEn+/RPa4qPc
         S7Or6Qh/iYS7hamQ7ov9oFBCZ1xCttooj3g/s3TwGVbx8gsjwLshqm4SrpqostvYoHft
         BPqg==
X-Gm-Message-State: AOJu0Yy4aDDdr+GrufSx0ey9epvrU3kczaJRLLPFzOTOprSEJvw4RUXn
	xw2tUmrCWTjDwFtsmlG5YgBcFvTPZbOPgaLcSa8=
X-Google-Smtp-Source: AGHT+IEWNgwxgiAwoitCnD04CiK/3JY1UQabRaWJAqFubO1cNSbJEIp0jD/RkyiUovK6zf16xE5r54Jykv/SNqjTMbU=
X-Received: by 2002:a4a:b304:0:b0:581:d5df:9cd2 with SMTP id
 m4-20020a4ab304000000b00581d5df9cd2mr4509936ooo.0.1697628691098; Wed, 18 Oct
 2023 04:31:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016170939.1192260-1-sunilvl@ventanamicro.com> <CAJZ5v0hCaXxYSmjWorbM2AEoCJrJk06xCY5Fq-geM945vOE86w@mail.gmail.com>
In-Reply-To: <CAJZ5v0hCaXxYSmjWorbM2AEoCJrJk06xCY5Fq-geM945vOE86w@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Oct 2023 13:31:20 +0200
Message-ID: <CAJZ5v0g29Gh4JmKkheqkF5MrnbHefq=KVm=ccxHT4+A99LpVfg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: irq: Fix the incorrect return value in acpi_register_gsi()
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Marc Zyngier <maz@kernel.org>, Anup Patel <apatel@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 1:13=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Mon, Oct 16, 2023 at 7:09=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.c=
om> wrote:
> >
> > acpi_register_gsi() should return negative value in case of failure.
> > Currently, it returns the return value from irq_create_fwspec_mapping()=
.
> > However, irq_create_fwspec_mapping() returns 0 for failure. Fix the iss=
ue
> > by returning -EINVAL if irq_create_fwspec_mapping() returns zero.
> >
> > Fixes: d44fa3d46079 ("ACPI: Add support for ResourceSource/IRQ domain m=
apping")
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  drivers/acpi/irq.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
> > index c2c786eb95ab..403f33df66af 100644
> > --- a/drivers/acpi/irq.c
> > +++ b/drivers/acpi/irq.c
> > @@ -57,6 +57,7 @@ int acpi_register_gsi(struct device *dev, u32 gsi, in=
t trigger,
> >                       int polarity)
> >  {
> >         struct irq_fwspec fwspec;
> > +       unsigned int rc;
> >
> >         fwspec.fwnode =3D acpi_get_gsi_domain_id(gsi);
> >         if (WARN_ON(!fwspec.fwnode)) {
> > @@ -68,7 +69,11 @@ int acpi_register_gsi(struct device *dev, u32 gsi, i=
nt trigger,
> >         fwspec.param[1] =3D acpi_dev_get_irq_type(trigger, polarity);
> >         fwspec.param_count =3D 2;
> >
> > -       return irq_create_fwspec_mapping(&fwspec);
> > +       rc =3D irq_create_fwspec_mapping(&fwspec);
> > +       if (!rc)
> > +               return -EINVAL;
> > +
> > +       return rc;
> >  }
> >  EXPORT_SYMBOL_GPL(acpi_register_gsi);
> >
> > --
>
> Good catch!
>
> Applied as 6.7 material, but I renamed the new rc local variable to irq.
>
> Thanks!

Actually, I'm going to push this for -rc7.

