Return-Path: <linux-acpi+bounces-1114-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD287DD1AE
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Oct 2023 17:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D4B2810FC
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Oct 2023 16:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0137A20312
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Oct 2023 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B401119BD7
	for <linux-acpi@vger.kernel.org>; Tue, 31 Oct 2023 15:21:46 +0000 (UTC)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A4619B4;
	Tue, 31 Oct 2023 08:19:32 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5845b7ee438so529064eaf.1;
        Tue, 31 Oct 2023 08:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698765571; x=1699370371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5I+wv0AwpA/9AOWmahw4PTxgF8CLhlJBYtL+4HP13M=;
        b=q5lcjTaUfNRTDUUChtGFLJj0bfnqlHepZan3oHV8kVyyF73fQg1qAEo9HxcLzEMhJQ
         baYMTR463G3TiUQUavYDQmjaxBJADW128PxDvVb2vjhk/xe1jMk8MPxcGNBoHXtqfNxW
         IW50sdVMRh5IEVx7T73g1Jg6eSK6m2MnQRagBBcs9URFRrfCOqVZoGEKNcQBrERC5lmq
         Nj+IxsbG5CSnqeHFlQk7UtDSwjOPigKFUEcLhEWBXIhe2Ftt9D99VhnYoM0dWh3X5oEZ
         fKaaAIE+/HFrDA2O+UTUGNXwN0e+ZqWof6dUbSSRiWLc0/uT+lnMgUCO1WRmewaY2du2
         mIvA==
X-Gm-Message-State: AOJu0Yy2A8csQX0kRyGVZoXdsWhOEQjzCbjxJvkPjnKWiZQNR/F6QdWb
	xJOnF22yr9sFQfA+eb7rrOnPb1w1Ix3Y1bQwMUDrpq+r
X-Google-Smtp-Source: AGHT+IE6LyUsaOXfzrieA+BC3Hq2CDu5XgoUWpofSBhMa9N78AWkzjZij/4PCAITia/6mIl0Zp9EYN0mFRk83sGF5Mo=
X-Received: by 2002:a4a:d8d1:0:b0:586:abc4:2c18 with SMTP id
 c17-20020a4ad8d1000000b00586abc42c18mr13046062oov.0.1698765569924; Tue, 31
 Oct 2023 08:19:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2187487.irdbgypaU6@kreacher> <7609686.EvYhyI6sBW@kreacher>
 <ZUDBnEJ41tc7nnka@kekkonen.localdomain> <CAJZ5v0j_Uv=qVo6eFdz-Q7Ne7W7aTf9ThN128Ust+YEQQ9Gy+Q@mail.gmail.com>
 <ZUEIb81Bbzgvf2Uf@kekkonen.localdomain>
In-Reply-To: <ZUEIb81Bbzgvf2Uf@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 31 Oct 2023 16:19:18 +0100
Message-ID: <CAJZ5v0ioy7n3ts9L6FQZcjngEU8qazXCdNKVXShpNL7+7hRtJg@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] ACPI: scan: Extract MIPI DiSco for Imaging data
 into swnodes
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sakari,

On Tue, Oct 31, 2023 at 3:00=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Tue, Oct 31, 2023 at 02:46:51PM +0100, Rafael J. Wysocki wrote:
> > Hi Sakari,
> >
> > On Tue, Oct 31, 2023 at 11:33=E2=80=AFAM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Rafael,
> > >
> > > On subject:
> > >
> > > s/DiSco/DisCo/
> >
> > Huh
> >
> > Thanks for catching this!
> >
> > > On Fri, Oct 20, 2023 at 04:39:27PM +0200, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > Add information extracted from the MIPI DiSco for Imaging device
> > >
> > > Ditto.
> > >
> > > > properties to software nodes created during the CSI-2 connection gr=
aph
> > > > discovery.
> > > >
> > > > Link: https://www.mipi.org/specifications/mipi-di
> > >
> > > This URL is broken. The correct URL is:
> > >
> > >         https://www.mipi.org/specifications/mipi-disco-imaging
> >
> > OK
> >
> > > > Co-developed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  drivers/acpi/internal.h |    1
> > > >  drivers/acpi/mipi-di.c  |  240 +++++++++++++++++++++++++++++++++++=
++++++++++++-
> > >
> > > How about mipi-disco.c? I wouldn't mind having mipi-disco-imaging.c e=
ither.
> >
> > Well, mipi-disco-imaging is a bit too long and the meaning of
> > mipi-disco would not be clear IMO.
> >
> > What about mipi-disco-img?
>
> Seems fine to me.
>
> >
> > [cut]
> >
> > > > +     ret =3D fwnode_property_count_u8(port_fwnode, "mipi-img-lane-=
polarities");
> > > > +     if (ret > 0) {
> > > > +             unsigned long mask;
> > > > +             unsigned int i;
> > > > +
> > > > +             /*
> > > > +              * Total number of lanes here is clock lane + data la=
nes.
> > > > +              * Require that number to be low enough so they all c=
an be
> > > > +              * covered by the bits in one byte.
> > > > +              */
> > > > +             BUILD_BUG_ON(BITS_PER_TYPE(u8) <=3D ARRAY_SIZE(port->=
data_lanes));
> > > > +
> > > > +             fwnode_property_read_u8_array(port_fwnode,
> > > > +                                           "mipi-img-lane-polariti=
es",
> > > > +                                           val, 1);
> > > > +
> > > > +             for (mask =3D val[0], i =3D 0; i < num_lanes + 1; i++=
)
> > > > +                     port->lane_polarities[i] =3D test_bit(i, &mas=
k);
> > >
> > > This works only up to seven lanes.
> >
> > True, but then ACPI_DEVICE_CSI2_DATA_LANES is defined as 4.
>
> The spec has no limit and in practice 4 is relatively common while 8 exis=
ts
> (but is somewhat rare). I actually think it'd be a good idea to bump this
> to 8 already.

OK

