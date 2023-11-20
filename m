Return-Path: <linux-acpi+bounces-1619-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DF17F15DB
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 15:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA06281F5D
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 14:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D746FAE
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F060CC4;
	Mon, 20 Nov 2023 04:52:50 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6d64d8ce2c3so671043a34.0;
        Mon, 20 Nov 2023 04:52:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700484770; x=1701089570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HoRlunjQDW1HaYq2fn2UmPJYBNEsQabm2JAfQKAH8Bc=;
        b=w742G6luZl3RqCBpPr/wj1VFw6drbpuyCvmJhKa1kGQZm4tMdtRy9guStWlczXbxFH
         /KchlljqeINzcXptjdN/BhkieC7WcXnYxLyh5I7lDsu95gTzs98TTVgoG+UqVzCXUAkZ
         XCxhXA0yQ08XqM2+bxUWloV8lUtiN+ntJI5uLvMAQzIp/8Plb6O6J7LxveLFqsjBWLu4
         OF8bd9luAKwmpegTFxLJipj9BUgGUVFbkEwdn+nTY/tbs5UqOYycNZPMVKDeh/viV9pK
         0ILEEAJOcclBbUNXgut9XD5phApZKLAWv34CJT/N20TAHQUxcDz9RzxTJOQsxqu0pDHX
         KA3g==
X-Gm-Message-State: AOJu0YwU8hpuB+gwtGSAQp4iNJm8BMzHdOYcLXtlu0UZS6XLG9HIvkaN
	MZkB5koC66NGnS5QLL5vs4LTdCaL6b1pUaHi4JyFck+o
X-Google-Smtp-Source: AGHT+IEEkTqrIIVE0w2gmfejJ/N0PXHlj2deOG662ZwVJEj+dP9SM00fE42X0Td0Nygh4Pe+18jtAZI6KPG1R/0hsgI=
X-Received: by 2002:a05:6820:290e:b0:58a:7cff:2406 with SMTP id
 dp14-20020a056820290e00b0058a7cff2406mr9437734oob.0.1700484770278; Mon, 20
 Nov 2023 04:52:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231117111433.1561669-1-sakari.ailus@linux.intel.com>
 <20231117111433.1561669-4-sakari.ailus@linux.intel.com> <20231118185049.GH20846@pendragon.ideasonboard.com>
 <ZVsnYjjWAiNPdHPG@kekkonen.localdomain>
In-Reply-To: <ZVsnYjjWAiNPdHPG@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Nov 2023 13:52:39 +0100
Message-ID: <CAJZ5v0h+tP1=PW4C44LCfyJcDXhcUQ4+BHPP9vBM19rtfqukWA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] ACPI: Documentation: Document acpi_dev_state_d0()
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-acpi@vger.kernel.org, 
	linux-media@vger.kernel.org, rafael@kernel.org, jacopo.mondi@ideasonboard.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 10:31=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Laurent,
>
> On Sat, Nov 18, 2023 at 08:50:49PM +0200, Laurent Pinchart wrote:
> > Hi Sakari,
> >
> > Thank you for the patch.
> >
> > On Fri, Nov 17, 2023 at 01:14:29PM +0200, Sakari Ailus wrote:
> > > Document that acpi_dev_state_d0() can be used to tell if the device w=
as
> > > powered on for probe.
> > >
> > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > ---
> > >  Documentation/firmware-guide/acpi/non-d0-probe.rst | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/Documentation/firmware-guide/acpi/non-d0-probe.rst b/Doc=
umentation/firmware-guide/acpi/non-d0-probe.rst
> > > index 7afd16701a02..815bcc8db69f 100644
> > > --- a/Documentation/firmware-guide/acpi/non-d0-probe.rst
> > > +++ b/Documentation/firmware-guide/acpi/non-d0-probe.rst
> > > @@ -24,6 +24,14 @@ there's a problem with the device, the driver like=
ly probes just fine but the
> > >  first user will find out the device doesn't work, instead of a failu=
re at probe
> > >  time. This feature should thus be used sparingly.
> > >
> > > +ACPI framework
> > > +--------------
> > > +
> > > +Use the Linux ACPI framework function :c:func:`acpi_dev_state_d0()` =
to tell
> > > +whether the device was powered on for probe. :c:func:`acpi_dev_state=
_d0()`
> > > +returns true if the device is powered on, false otherwise. For non-A=
CPI backed
> > > +devices it returns true always.
> > > +
> >
> > While this is true, I don't want to see drivers having to call
> > ACPI-specific functions, the same way you dislike OF-specific functions
> > in drivers. Please find a better way to handle this.
>
> The functionality is only available on ACPI and the function does the rig=
ht
> thing on non-ACPI platforms. I don't see an issue here.

The issue would be calling an ACPI-specific function from code that's
otherwise firmware-agnostic, AFAICS.

It would be good to have a more generic way of checking whether or not
a device is operational.

> Feel free to post DT binding patches on suggested device power state duri=
ng
> probe. :-) I think DT would benefit from this as well: the at24 driver is
> widely used and suddenly making probe() not talk to the chip (or even pow=
er
> it up) at all would probably be seen as a regression.

In the DT case it is more complicated, though, at least in general,
because there may be multiple clocks and regulators the device depends
on and you may need to toggle a GPIO line too.

