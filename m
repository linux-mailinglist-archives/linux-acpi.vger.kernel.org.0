Return-Path: <linux-acpi+bounces-1769-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616EE7F5373
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 23:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C56D2815B1
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 22:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8261CABA
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 22:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4C11A4
	for <linux-acpi@vger.kernel.org>; Wed, 22 Nov 2023 13:15:46 -0800 (PST)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-58787a6583aso11474eaf.1
        for <linux-acpi@vger.kernel.org>; Wed, 22 Nov 2023 13:15:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700687746; x=1701292546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIViwE8ngJeWAb0j3Ms81yXwzjL0kaPTkMVaFWZjjIw=;
        b=qe01TRrleugcy29UvVMy0YR0p7leIo8PIR6iS3oKtA7CQeNimdcxOz30C1f74Llckt
         O5UmhdNZPIoWctarLuJu16GvCfwNIiNQpvNGQgRPuDPGtNxv8p8cRq2MpzdUepxoI+QU
         3e+Xb1GYblZFOte5RLug/28CeeAul5A4/BaPpjnUpyyk12dnLVn9rUgirWGsijJdjEAr
         c8vQ2KaDog0PlmWv3JS4fWNKS1g3Jn8v+V8PMobNX5ZGMTakiARPBoqpMS9NTgMzS+Hd
         C1ZPKlHZO7l6S7uCkSD8tI1+egbMW0aQJekkbVhVrElzjAI7d46cjDzpt8/CV13Q2eRu
         NfvQ==
X-Gm-Message-State: AOJu0YwH2pFIbsMpsjTTBXU9qPHeVEjUnS1B0EogmT8oTsEil8EUkSJU
	zS2bAfOgEoFIHjUO06Zr8t/C5aEARD9MPoydVmSqdBvf
X-Google-Smtp-Source: AGHT+IF1HUmXiVCJ6fPYme01keG8iuqJbnlzImD3Kr/4Lgx8CaFbQZGjTZMyuOh+i6z0yqDloBzvLCStEYUcoB4tGfc=
X-Received: by 2002:a4a:d087:0:b0:584:17d0:de3d with SMTP id
 i7-20020a4ad087000000b0058417d0de3dmr4134275oor.1.1700687745915; Wed, 22 Nov
 2023 13:15:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103083625.1229008-1-sakari.ailus@linux.intel.com>
 <20231103083625.1229008-2-sakari.ailus@linux.intel.com> <CAJZ5v0hB=6mLp3ZKOoF=_+wJ-crraXtMaZ7ZNhZ_Gfg2SU08Ww@mail.gmail.com>
 <ZV0h7rfvyTX4tG3t@kekkonen.localdomain>
In-Reply-To: <ZV0h7rfvyTX4tG3t@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 22 Nov 2023 22:15:34 +0100
Message-ID: <CAJZ5v0it5QeNZqJGzYQz-sa52DwjNTaaftLkzGHQZVwXCjJ+Yg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] acpi: property: Let args be NULL in __acpi_node_get_property_reference
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	andriy.shevchenko@linux.intel.com, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 10:32=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> On Tue, Nov 21, 2023 at 08:36:08PM +0100, Rafael J. Wysocki wrote:
> > On Fri, Nov 3, 2023 at 9:36=E2=80=AFAM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > fwnode_get_property_reference_args() may not be called with args argu=
ment
> > > NULL on ACPI, OF already supports this. Add the missing NULL checks a=
nd
> > > document this.
> > >
> > > The purpose is to be able to count the references.
> > >
> > > Fixes: 977d5ad39f3e ("ACPI: Convert ACPI reference args to generic fw=
node reference args")
> > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > ---
> > >  drivers/acpi/property.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > > index 413e4fcadcaf..93608714b652 100644
> > > --- a/drivers/acpi/property.c
> > > +++ b/drivers/acpi/property.c
> > > @@ -851,6 +851,7 @@ static int acpi_get_ref_args(struct fwnode_refere=
nce_args *args,
> > >   * @index: Index of the reference to return
> > >   * @num_args: Maximum number of arguments after each reference
> > >   * @args: Location to store the returned reference with optional arg=
uments
> > > + *       (may be NULL)
> > >   *
> > >   * Find property with @name, verifify that it is a package containin=
g at least
> > >   * one object reference and if so, store the ACPI device object poin=
ter to the
> > > @@ -907,6 +908,9 @@ int __acpi_node_get_property_reference(const stru=
ct fwnode_handle *fwnode,
> > >                 if (!device)
> > >                         return -EINVAL;
> > >
> > > +               if (!args)
> > > +                       return 0;
> > > +
> > >                 args->fwnode =3D acpi_fwnode_handle(device);
> > >                 args->nargs =3D 0;
> > >                 return 0;
> > > --
> >
> > Is this series waiting for me to pick it up or am I confused?
>
> Yes, please!

OK, applied as 6.8 material, thanks!

