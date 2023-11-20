Return-Path: <linux-acpi+bounces-1637-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9190D7F1E10
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 21:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18B73B20F7C
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 20:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789C1225B2
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EF2D8;
	Mon, 20 Nov 2023 12:23:05 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3b2ef978011so468762b6e.1;
        Mon, 20 Nov 2023 12:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700511784; x=1701116584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEL8RdOFxFykWvNo3p0KHcsMqBbFzmXNVA5stbCYoiU=;
        b=tQiTYrqftbS0oTK3ZPoF97bBmaeyh+WjBsKRGG5gyHD4gz8h9yJmxgknFag+oL1PPf
         Y0aNtXPw3bGNIDUdqsCrIwT5aXyZlFGfmNTbI2Zq9VtGaqSL11c/+insz4wz41JX+v7w
         5VWAt5IbAfESS81b/b8vVVcVbgddjNvEKGRBTebWrWpo7tgPGUV2Klyq8Pppv2oQuKmO
         EPYHqj5T+YGF0LI9dK53Q8Nt01SwkBARplSRuE0plS6mKh+A7bgnSdV+cw2deE4HT3zK
         exbbJgZrtdXFLNvHV9TioWU7KvUKazSYIAuMOAW96l9xxByAlAzJLk5+S8bkwubiOa5h
         iY7w==
X-Gm-Message-State: AOJu0YwFOoEuCDkVBokkINWt7TmytAXl1G/QzeA8nYF85EydEK0JJgPM
	RA0RSkeOfashQM9qu/x1Dp/WuW3qi5w2Bp9F4ThfDF594Ug=
X-Google-Smtp-Source: AGHT+IGPCESCJbDT//EBDWHop3IhRMxf7cRF2zL3jYjGojA5Qn7WJfzTL0GJPgzMCD2znXMYxViN5gR481kOyVIPc6g=
X-Received: by 2002:a05:6808:341:b0:3b2:e224:73d0 with SMTP id
 j1-20020a056808034100b003b2e22473d0mr7869856oie.5.1700511784279; Mon, 20 Nov
 2023 12:23:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231117111433.1561669-1-sakari.ailus@linux.intel.com>
 <20231117111433.1561669-4-sakari.ailus@linux.intel.com> <20231118185049.GH20846@pendragon.ideasonboard.com>
 <ZVsnYjjWAiNPdHPG@kekkonen.localdomain> <CAJZ5v0h+tP1=PW4C44LCfyJcDXhcUQ4+BHPP9vBM19rtfqukWA@mail.gmail.com>
 <ZVu7iMimov2c5QFM@kekkonen.localdomain>
In-Reply-To: <ZVu7iMimov2c5QFM@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Nov 2023 21:22:53 +0100
Message-ID: <CAJZ5v0iB5cRbDJGxOQeFW_r_jbKv70OgFPpQ-_5c38FJwQGOpw@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] ACPI: Documentation: Document acpi_dev_state_d0()
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	linux-acpi@vger.kernel.org, linux-media@vger.kernel.org, 
	jacopo.mondi@ideasonboard.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sakari,

On Mon, Nov 20, 2023 at 9:03=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Mon, Nov 20, 2023 at 01:52:39PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Nov 20, 2023 at 10:31=E2=80=AFAM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Laurent,
> > >
> > > On Sat, Nov 18, 2023 at 08:50:49PM +0200, Laurent Pinchart wrote:
> > > > Hi Sakari,
> > > >
> > > > Thank you for the patch.
> > > >
> > > > On Fri, Nov 17, 2023 at 01:14:29PM +0200, Sakari Ailus wrote:
> > > > > Document that acpi_dev_state_d0() can be used to tell if the devi=
ce was
> > > > > powered on for probe.
> > > > >
> > > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > > ---
> > > > >  Documentation/firmware-guide/acpi/non-d0-probe.rst | 8 ++++++++
> > > > >  1 file changed, 8 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/firmware-guide/acpi/non-d0-probe.rst b=
/Documentation/firmware-guide/acpi/non-d0-probe.rst
> > > > > index 7afd16701a02..815bcc8db69f 100644
> > > > > --- a/Documentation/firmware-guide/acpi/non-d0-probe.rst
> > > > > +++ b/Documentation/firmware-guide/acpi/non-d0-probe.rst
> > > > > @@ -24,6 +24,14 @@ there's a problem with the device, the driver =
likely probes just fine but the
> > > > >  first user will find out the device doesn't work, instead of a f=
ailure at probe
> > > > >  time. This feature should thus be used sparingly.
> > > > >
> > > > > +ACPI framework
> > > > > +--------------
> > > > > +
> > > > > +Use the Linux ACPI framework function :c:func:`acpi_dev_state_d0=
()` to tell
> > > > > +whether the device was powered on for probe. :c:func:`acpi_dev_s=
tate_d0()`
> > > > > +returns true if the device is powered on, false otherwise. For n=
on-ACPI backed
> > > > > +devices it returns true always.
> > > > > +
> > > >
> > > > While this is true, I don't want to see drivers having to call
> > > > ACPI-specific functions, the same way you dislike OF-specific funct=
ions
> > > > in drivers. Please find a better way to handle this.
> > >
> > > The functionality is only available on ACPI and the function does the=
 right
> > > thing on non-ACPI platforms. I don't see an issue here.
> >
> > The issue would be calling an ACPI-specific function from code that's
> > otherwise firmware-agnostic, AFAICS.
> >
> > It would be good to have a more generic way of checking whether or not
> > a device is operational.
>
> In DT case it's up to the driver to do that, so the device is powered off=
.

Unless the boot loader (or whatever happens to run before the kernel)
turns it on for some reason (whatever that may be).

I guess the original point has been that in the ACPI case the generic
enumeration code may power up the device if not instructed otherwise
by the platform firmware, whereas in the DT case this is entirely up
to the driver, but I'm not sure if this really matters.

I would suggest adding a generic wrapper around acpi_dev_state_d0()
that will just always return true in the DT case, something like
device_is_accessible() or device_is_operational(), that can be invoked
from generic code without any visible ACPI connotations.

