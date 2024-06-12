Return-Path: <linux-acpi+bounces-6349-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B1C905BEF
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 21:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E286289819
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 19:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936BF82D8E;
	Wed, 12 Jun 2024 19:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKgei1ur"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D0882C7D;
	Wed, 12 Jun 2024 19:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718220408; cv=none; b=uVn54jd0FoQr8wIwiKYRMBBQ3kDZXs4GR4Ebuc6QCETZP8XrelQKsHrb63aVaiXQfDx4iMpi5HgVvlU5RacQKK0Q1/s6DtyoMUmSCRfm6MqCOmU7jFASsyDz4ky/eQQqP2hxXZjwcvz29EICO9IYPU7ttE+nKWaIXxXpDPYrqy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718220408; c=relaxed/simple;
	bh=8nKEBDIbnc+ryG/BlmNEuNO7h3L3EG6+iD1k3ViaoLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=spGYlwe9655j9fWBYv229kjOwc40LXav7uKbxW8y04C/817CATy5w92xNtQIKwJFta02XyUi75c6uJRncY2Sy0ExqduiYQAC1U3AXFblvQBIj+Vt6CpwXPpGfOcwH+//MgPweOSpnCUYLsr94Ia+fqPnWHeQBvAHBHt6YMaO72s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKgei1ur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEADC32789;
	Wed, 12 Jun 2024 19:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718220408;
	bh=8nKEBDIbnc+ryG/BlmNEuNO7h3L3EG6+iD1k3ViaoLw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tKgei1urqIx9k6147CuicOSYo6xLXXDd8zTJdFxBx9WfCkDyuCX1s4MUF0ZtutK2I
	 TG1YcPo59lCGdNd0L6mkCLNFUcaMtPII/TfxOSAOXe+jNMbTBRpP9ZS3SMhE4EhakB
	 APy6WRWF7da2vBDLyYqFWERXzepersF/b623fy0rMStH1/WwINEYyrubYg7N9kfE4t
	 lwFHrtmEj2rMcljv51wCpKL1Rki3SvF6936N4CusfMMqzhYgyMC5UB+xmNdwFcxOQD
	 tMvy04A+gHh1iY+9jO+Waq0qcDq5ZQeHZklybw+tBgKwEM1vsgzcELd7VaM4M2hfrz
	 kTTiytWsKL+yQ==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5bad7941dcfso17899eaf.3;
        Wed, 12 Jun 2024 12:26:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWM0Eom135JMwFXZLF/I5WkgNLliBxE+XegAim8DuG4lP5MMEp8e6hbuWAi98iDd7Yh95uKoCjbwU35UV7oC+judBMh3Os8+xZZ14yvjsz7ERs482u4Ac3mkNd9+nnLJNBX8OTPQI8l0SHc98E6ej1E3E29Z+YwR0sqdKY6wV3iAdvA2RVm
X-Gm-Message-State: AOJu0YyXritIVHHZfxvHGjURv1YM66voqoCJFtiIyrcAzUdcUky0sPZS
	KPqqOf4hRmRyTpdV5AIHJ7BHikq6ioBykuHOzsi+eiDz9qOhxSMoYqxbliD71BV9tmlu3U0MdOE
	dS6VhQx44YCiNarxCkHUrmuoGViI=
X-Google-Smtp-Source: AGHT+IHbOkHydIK804UjnB3IUxvl9tv2nbC+XcrsXga+PPOO73Jn0KonCqcj83UYBrXGKFfZP3XY2rE7CIasN7oLwB4=
X-Received: by 2002:a05:6820:705:b0:5ba:ef94:7dc3 with SMTP id
 006d021491bc7-5bb3b9de330mr2811895eaf.1.1718220407223; Wed, 12 Jun 2024
 12:26:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZmmQLt7wB-yGQBTw@kekkonen.localdomain> <CAJZ5v0ii3WFQRPdfHeeW4M9kXSWDVxxxy02zThcf25mjNwqDAw@mail.gmail.com>
 <ZmmT56Cyvb2FCyav@kekkonen.localdomain> <CAJZ5v0hOBggQR_=uA3VuhruQnZihVxHHovpTz4=qfcbiSunsYw@mail.gmail.com>
 <ZmmY3he9vfWVWU3I@kekkonen.localdomain> <CAJZ5v0j7HTfg1wY+B+7vhE6tBKPVHMuu_MsFHjaLK70VS_cNEw@mail.gmail.com>
 <ZmnnFueL-Cgw5Eqp@kekkonen.localdomain> <CAJZ5v0gtK9yusimCOVV2dGkQWDwQ6=r=vfbgC-eE60Cg-5wk_Q@mail.gmail.com>
 <ZmnrtIEla9R24egi@kekkonen.localdomain> <CAJZ5v0hXU62QiXxWfkbiovciNNEk0h49kRdScmz5qONTMDA+4A@mail.gmail.com>
 <Zmny2zKoXvKN9TxF@kekkonen.localdomain>
In-Reply-To: <Zmny2zKoXvKN9TxF@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Jun 2024 21:26:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iH3QX3TUU0jEuRsPQNSN84R6t_ZJ85-kSZhiedBSds2A@mail.gmail.com>
Message-ID: <CAJZ5v0iH3QX3TUU0jEuRsPQNSN84R6t_ZJ85-kSZhiedBSds2A@mail.gmail.com>
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

On Wed, Jun 12, 2024 at 9:11=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Wed, Jun 12, 2024 at 08:50:57PM +0200, Rafael J. Wysocki wrote:
> > Hi Sakari,
> >
> > On Wed, Jun 12, 2024 at 8:41=E2=80=AFPM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Rafael,
> > >
> > > On Wed, Jun 12, 2024 at 08:29:21PM +0200, Rafael J. Wysocki wrote:
> > > > Hi Sakari,
> > > >
> > > > On Wed, Jun 12, 2024 at 8:21=E2=80=AFPM Sakari Ailus
> > > > <sakari.ailus@linux.intel.com> wrote:
> > > > >
> > > > > Hi Rafael,
> > > > >
> > > > > On Wed, Jun 12, 2024 at 03:06:53PM +0200, Rafael J. Wysocki wrote=
:
> > > > > > Hi Sakari,
> > > > > >
> > > > > > On Wed, Jun 12, 2024 at 2:47=E2=80=AFPM Sakari Ailus
> > > > > > <sakari.ailus@linux.intel.com> wrote:
> > > > > > >
> > > > > > > Hi Rafael,
> > > > > > >
> > > > > > > On Wed, Jun 12, 2024 at 02:32:26PM +0200, Rafael J. Wysocki w=
rote:
> > > > > > > > > > > > I just hit the same problem on another Dell laptop.=
 It seems that
> > > > > > > > > > > > all Dell laptops with IPU6 camera from the Tiger La=
ke, Alder Lake
> > > > > > > > > > > > and Raptor Lake generations suffer from this proble=
m.
> > > > > > > > > > > >
> > > > > > > > > > > > So instead of playing whack a mole with DMI matches=
 we should
> > > > > > > > > > > > simply disable ACPI MIPI DISCO support on all Dell =
laptops
> > > > > > > > > > > > with those CPUs. I'm preparing a fix for this to re=
place
> > > > > > > > > > > > the DMI matching now.
> > > > > > > > > > >
> > > > > > > > > > > DisCo for Imaging support shouldn't be dropped on the=
se systems, and this
> > > > > > > > > > > isn't what your patch does either. Instead the ACPI g=
raph port nodes (as
> > > > > > > > > > > per Linux specific definitions) are simply dropped, i=
.e. this isn't related
> > > > > > > > > > > to DisCo for Imaging at all.
> > > > > > > > > >
> > > > > > > > > > So it looks like the changelog of that patch could be i=
mproved, right?
> > > > > > > > >
> > > > > > > > > Well, yes. The reason the function is in the file is that=
 nearly all camera
> > > > > > > > > related parsing is located there, not that it would be re=
lated to DisCo for
> > > > > > > > > Imaging as such.
> > > > > > > >
> > > > > > > > So IIUC the camera graph port nodes are created by default =
with the
> > > > > > > > help of the firmware-supplied information, but if that is d=
efective a
> > > > > > > > quirk can be added to skip the creation of those ports in w=
hich case
> > > > > > > > they will be created elsewhere.
> > > > > > > >
> > > > > > > > Is this correct?
> > > > > > >
> > > > > > > Yes.
> > > > > >
> > > > > > So it would be good to add a comment to this effect to
> > > > > > acpi_nondev_subnode_extract() where acpi_graph_ignore_port() is
> > > > > > called.
> > > > > >
> > > > > > And there is a somewhat tangential question that occurred to me=
: If
> > > > > > the nodes are created elsewhere when acpi_graph_ignore_port() i=
s true,
> > > > > > why is it necessary to consult the platform firmware for the
> > > > > > information on them at all?  Wouldn't it be better to simply al=
ways
> > > > > > create them elsewhere?
> > > > >
> > > > > Simple answer: for the same reason why in general system specific
> > > > > information comes from ACPI and not from platform data compiled i=
nto the
> > > > > kernel.
> > > > >
> > > > > Of course this is technically possible but it does not scale.
> > > >
> > > > While I agree in general, in this particular case the platform data
> > > > compiled into the kernel needs to be present anyway, at least
> > > > apparently, in case the data coming from the platform firmware is
> > > > invalid.
> > > >
> > > > So we need to do 3 things: compile in the platform data into the
> > > > kernel and expect the platform firmware to provide the necessary
> > > > information, and add quirks for the systems where it is known inval=
id.
> > > >
> > > > Isn't this a bit too much?
> > >
> > > Isn't this pretty much how ACPI works currently?
> >
> > No, we don't need to put platform data into the kernel for every bit
> > of information that can be retrieved from the platform firmware via
> > ACPI.
> >
> > The vast majority of information in the ACPI tables is actually
> > correct and if quirks are needed, they usually are limited in scope.
> >
> > Where it breaks is when the ACPI tables are not sufficiently validated
> > by OEMs which mostly happens when the data in question are not needed
> > to pass some sort of certification or admission tests.
> >
> > Which unfortunately is related to whether or not Windows uses those dat=
a.
> >
> > > We can support systems that contain correct DSDT description of camer=
as
> > > without platform data. I was, until recently, only aware of Dell XPS =
9315
> > > that has incorrect camera description and that based on recent findin=
gs
> > > seems to extend to other Dell systems with IPU6 (Hans's patches have =
the
> > > details).
> > >
> > > Still this is not a reason to break systems that have correct camera
> > > description and expect the users to report them so they can be listed=
 as
> > > such.
> >
> > Well, what do you mean by "break".  I thought that platform data
> > needed to support them were built into the kernel, weren't they?
>
> If you add a whitelist for systems where the port aren't just dropped, th=
at
> is bound to break camera on a lot of current systems that depend on the
> said port nodes.

I'm not sure I understand the above.

If a blacklist entry is added to acpi_graph_ignore_port(),
acpi_nondev_subnode_extract() will bail out for all of the ports on
the given system regardless of their role etc.  Still, it is expected
that requisite nodes will be added somewhere else and the camera will
be handled because some platform data has been compiled into the
kernel for this purpose.  Or is my understanding incorrect?

If it is correct, the blacklisting mechanism might be replaced with a
whitelisting one where acpi_nondev_subnode_extract() will not bail out
on systems that are known to be good.

> >
> > > >
> > > > > On laptops shipped with Windows some additional information is al=
so available
> > > > > from ACPI via custom objects but a lot of information is just har=
d coded into
> > > > > the IPU bridge as well as the INT3472 driver.
> > > >
> > > > Well, that's how it goes.
> > >
> > > Yes, but is it desirable?
> >
> > No, it is not desirable, but the way to address it is to convince the
> > Windows people to stop doing this and use standard-defined data from
> > the ACPI tables instead.  It cannot be addressed by Linux unilaterally
> > trying to do the right thing, because there are OEMs who don't care
> > about Linux.
>
> I don't disagree with that as such but it's not really the matter here, i=
s
> it?
>
> Historically, some systems were amended with special "Linux support" whic=
h
> I believe is what these Dell systems have. That was done because the IPU
> bridge driver did not exist yet. I frankly don't think it was ever tested
> on Linux either.

OK, so this is a result of the vendor trying to support Linux in a
home-grown way which now is blowing up IIUC.

Or do you mean something else?

