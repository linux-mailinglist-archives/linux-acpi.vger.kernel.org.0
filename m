Return-Path: <linux-acpi+bounces-6338-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A94F905AE3
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 20:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174D128345B
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 18:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B80641A84;
	Wed, 12 Jun 2024 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uygpFqX6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B16C3FE2A;
	Wed, 12 Jun 2024 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718216974; cv=none; b=inFGmxtf0sOSBzhty+kkk484pbecsrJpJEjO+YclojsakmGx/jFtbwZbyCc93Q77SNkPgDf3KNJt5jYeGcusFXzQyXqqNMPYubtlwNrSDCHCvwCkElcftINPnzo7lN/wIxy9cH1niHO37H//dHJkgZrU/wFGiaVVn21719GFxCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718216974; c=relaxed/simple;
	bh=OmrPRsVW/SqHsQ62oU68f2r5XqKqs5zc1yIXlgibcIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ssOLY+K348ine7Cf3lArNJl4I6X6ynKbRj2RCvvzB6ByK0JW/LrsUwhg4NHXhy5duO1/GrjLw68QTYse9LnKs6b7zMVSmSPQ1GTX7c9bg7brgPsd6Z5FiHdPTO0XOGN9sZKU8XSY+t88JqlCj4gIksS/2RLtogqTTkUdPJfY1Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uygpFqX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB57C4AF1C;
	Wed, 12 Jun 2024 18:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718216973;
	bh=OmrPRsVW/SqHsQ62oU68f2r5XqKqs5zc1yIXlgibcIs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uygpFqX6aS5aZZu5MqHl50UapjHNeRaTdABTq3yex0HOvX/S228MsxfCQxhAqTPg8
	 OThcV8SbqJQ3irPlV7/MhDK5lQQUOu/OR3rCoU3y1jWlwobuY1IrCb3QgInydpqrhx
	 zAAbjbCZpRB7Ubr+uvXE9c1WpczfN1NllupVLm4AlJpxWL/W5ap0oxBaIa8YtYj35Z
	 d01NNSY5yFo3R/m8ZPj1XcRHqFRH4+i7nQLjGOwzkU7VJskKExdqFXUPxTJWnrBIRF
	 5FN1SNIbkj+6RT/X5bzct1zm+DMnVdbupFj7Ua/DvKXUDxZAMavt1eDKStXRNHrE8W
	 rXDleSxKni+Qg==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5bad4e45863so12805eaf.3;
        Wed, 12 Jun 2024 11:29:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6dwSmVx4cnP2taCKriJiBys0XhBGAvTGliOhNmhYTkseZduYt0fC85rGYN+L+TDl1xdexWu3LLb7EP54=@vger.kernel.org, AJvYcCUT0rEHomCncIVJ6Sn0lOMgcq/pCO+IJ12uZNriZF4zUZSBiwBBIHJJOwewUR7LvL/7IyJaupC4c5Cz@vger.kernel.org, AJvYcCVRuUp19QCMOH1T4P1aomM4z22FTnsn+5iBCo1rBhRHp1strAJqF187xinDuXfsqt1pkVuPCVGcRdki287A@vger.kernel.org
X-Gm-Message-State: AOJu0YwaTfLo8oNWZbYWkL4GIx/J2jYr8Tt5poMoMOxJ0zqm87OcNLY8
	KlsjiH6Mb+TkXBKfp9oOjxk9UWqj955mrO/DDMlqK+Sm8EUnCayacGx6svNE/YFliYJ9KfoqteM
	Ki0gaawVG8WoY3d3SA9r1UCBajbc=
X-Google-Smtp-Source: AGHT+IFylrCsWLsKLPqjnXt++1LHB3b3Atfwm0DR77ZFQrwea2y+55nezG7Xq+Di2smKAkN62xbjg85zPihLMpPy22E=
X-Received: by 2002:a05:6871:4e91:b0:24f:ddd5:a21d with SMTP id
 586e51a60fabf-255151f70fcmr2841268fac.5.1718216973099; Wed, 12 Jun 2024
 11:29:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528084413.2624435-1-sakari.ailus@linux.intel.com>
 <a05df025-a0be-49cd-84a9-7d7fb2eeb33e@redhat.com> <e9062095-b312-44df-a9e3-0b09f3ec9eff@redhat.com>
 <4b387b4d-f778-4891-9f07-df5fc0a093cd@redhat.com> <ZmmQLt7wB-yGQBTw@kekkonen.localdomain>
 <CAJZ5v0ii3WFQRPdfHeeW4M9kXSWDVxxxy02zThcf25mjNwqDAw@mail.gmail.com>
 <ZmmT56Cyvb2FCyav@kekkonen.localdomain> <CAJZ5v0hOBggQR_=uA3VuhruQnZihVxHHovpTz4=qfcbiSunsYw@mail.gmail.com>
 <ZmmY3he9vfWVWU3I@kekkonen.localdomain> <CAJZ5v0j7HTfg1wY+B+7vhE6tBKPVHMuu_MsFHjaLK70VS_cNEw@mail.gmail.com>
 <ZmnnFueL-Cgw5Eqp@kekkonen.localdomain>
In-Reply-To: <ZmnnFueL-Cgw5Eqp@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Jun 2024 20:29:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gtK9yusimCOVV2dGkQWDwQ6=r=vfbgC-eE60Cg-5wk_Q@mail.gmail.com>
Message-ID: <CAJZ5v0gtK9yusimCOVV2dGkQWDwQ6=r=vfbgC-eE60Cg-5wk_Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: scan: Ignore Dell XPS 9320 camera graph port nodes
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	Genes Lists <lists@sapience.com>, linux-kernel@vger.kernel.org, mchehab@kernel.org, 
	hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com, 
	wentong.wu@intel.com, linux-media@vger.kernel.org, linux-acpi@vger.kernel.org, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sakari,

On Wed, Jun 12, 2024 at 8:21=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Wed, Jun 12, 2024 at 03:06:53PM +0200, Rafael J. Wysocki wrote:
> > Hi Sakari,
> >
> > On Wed, Jun 12, 2024 at 2:47=E2=80=AFPM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Rafael,
> > >
> > > On Wed, Jun 12, 2024 at 02:32:26PM +0200, Rafael J. Wysocki wrote:
> > > > > > > > I just hit the same problem on another Dell laptop. It seem=
s that
> > > > > > > > all Dell laptops with IPU6 camera from the Tiger Lake, Alde=
r Lake
> > > > > > > > and Raptor Lake generations suffer from this problem.
> > > > > > > >
> > > > > > > > So instead of playing whack a mole with DMI matches we shou=
ld
> > > > > > > > simply disable ACPI MIPI DISCO support on all Dell laptops
> > > > > > > > with those CPUs. I'm preparing a fix for this to replace
> > > > > > > > the DMI matching now.
> > > > > > >
> > > > > > > DisCo for Imaging support shouldn't be dropped on these syste=
ms, and this
> > > > > > > isn't what your patch does either. Instead the ACPI graph por=
t nodes (as
> > > > > > > per Linux specific definitions) are simply dropped, i.e. this=
 isn't related
> > > > > > > to DisCo for Imaging at all.
> > > > > >
> > > > > > So it looks like the changelog of that patch could be improved,=
 right?
> > > > >
> > > > > Well, yes. The reason the function is in the file is that nearly =
all camera
> > > > > related parsing is located there, not that it would be related to=
 DisCo for
> > > > > Imaging as such.
> > > >
> > > > So IIUC the camera graph port nodes are created by default with the
> > > > help of the firmware-supplied information, but if that is defective=
 a
> > > > quirk can be added to skip the creation of those ports in which cas=
e
> > > > they will be created elsewhere.
> > > >
> > > > Is this correct?
> > >
> > > Yes.
> >
> > So it would be good to add a comment to this effect to
> > acpi_nondev_subnode_extract() where acpi_graph_ignore_port() is
> > called.
> >
> > And there is a somewhat tangential question that occurred to me: If
> > the nodes are created elsewhere when acpi_graph_ignore_port() is true,
> > why is it necessary to consult the platform firmware for the
> > information on them at all?  Wouldn't it be better to simply always
> > create them elsewhere?
>
> Simple answer: for the same reason why in general system specific
> information comes from ACPI and not from platform data compiled into the
> kernel.
>
> Of course this is technically possible but it does not scale.

While I agree in general, in this particular case the platform data
compiled into the kernel needs to be present anyway, at least
apparently, in case the data coming from the platform firmware is
invalid.

So we need to do 3 things: compile in the platform data into the
kernel and expect the platform firmware to provide the necessary
information, and add quirks for the systems where it is known invalid.

Isn't this a bit too much?

> On laptops shipped with Windows some additional information is also avail=
able
> from ACPI via custom objects but a lot of information is just hard coded =
into
> the IPU bridge as well as the INT3472 driver.

Well, that's how it goes.

