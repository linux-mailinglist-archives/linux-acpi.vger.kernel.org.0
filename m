Return-Path: <linux-acpi+bounces-6373-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2C690717C
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 14:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 981431C24142
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 12:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE7714374F;
	Thu, 13 Jun 2024 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TT64gkUy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD41020ED;
	Thu, 13 Jun 2024 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282241; cv=none; b=Ikl9kuIZ+SnlzbgtuafMLlrgHooc6/FdEQcP4h6yzKda5/Dv0QD4C1F5en4RhX1sTQBhrdrODeFNAcvmsvyZguFCZqILaHWVLmA/dxYkSRMrobNzvH4J0lPF55v4ugVSfUDTs5gHiXRB+kRyEnoJPpsnoq7k+lZCFmWtfXDcI4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282241; c=relaxed/simple;
	bh=VDJefMT8xEQw6dtn2VOdumNzxAyhkyOn6nPBaW3ZJiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjfk6G0Jb4fzxKY5NPHBXzkRGLd6KWqplgc0S4RevfveQlZBZwIUXRAlfJylry0/eiEiEDfUIiBsVuBG57f56irAif0W5mcD+r4PVxoWfvEF5mTGcLLU4PpMQ2nquoo+mi2ALEwbxCfXKqVGIqItzm+O5u6MMHm45bjKXks5ryA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TT64gkUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D807C4AF53;
	Thu, 13 Jun 2024 12:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718282241;
	bh=VDJefMT8xEQw6dtn2VOdumNzxAyhkyOn6nPBaW3ZJiI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TT64gkUypWGpN57uf31YfLVd6Oqds94a3mJKRp0vfTVwexIHa2PHxnUkuIolWZg5Q
	 zVI5g/L1svui4NPbN8DWXstFNwDSpy6G7ik0uXNbyE2WyloZt3tFMSJ4aHJz/qJyN5
	 icnSJVk83GVjDCHJ8NsvbNcX8uUbi2cXzeo2fn/FHf4VmphJpN+ec5/hbI1mDCAXXA
	 5mEI89vMLBYjxmHMHtbIduJQqnjjQZN0Zctylwv4P+qf3Pp59Y0kJwosGLdC65EPAe
	 t7bK+FyJOxueWeJd22ryfPioTdnFg4CmFga9wgsl/UQekLcdwZ1mkJW6qit5znbWcy
	 NZ3O8G/4+Dodg==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5bad7941dcfso37758eaf.3;
        Thu, 13 Jun 2024 05:37:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUy+8V/HgYUKkNrKs+M52VcDniDcbjXbBsC9x0BxHLpI933OpFO9AW4MZmUL1qxGxFldm6aP/f3Nd+9nU/L65jGetUWGmYYtxwOsnzWf0q/QwaXt59qX4GgO/7jt9hPQDRbJ3Ysx6+GpumMJDtsLoC+Cn9I8hUoohegC6nOxN7dcu3Akawc
X-Gm-Message-State: AOJu0Yx+8Q/sHUNxDhYyeCTZL04xHT1Is73lc5fiz20o+9ehu1WWAbzA
	Kl0+jg2VTRKEG+NkFovnvra6qOq9nj5N2Czbrj9FIjdaZkwsPgum3vVg9jyHvjBf15Q/Js2xm1K
	7h+JTUh4HC/89Lbuoy5ufR5E3gEc=
X-Google-Smtp-Source: AGHT+IF3D9bX2FCgBxRWF3J91JRycIDlipicsuGKj32M8JQW0MoP4JJyINqoxlncsVsvD3FsRtlEpauxLEFmyLYNnDU=
X-Received: by 2002:a4a:e9f6:0:b0:5bd:87a0:66d with SMTP id
 006d021491bc7-5bdabe6f5a3mr189994eaf.1.1718282240455; Thu, 13 Jun 2024
 05:37:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZmmT56Cyvb2FCyav@kekkonen.localdomain> <CAJZ5v0hOBggQR_=uA3VuhruQnZihVxHHovpTz4=qfcbiSunsYw@mail.gmail.com>
 <ZmmY3he9vfWVWU3I@kekkonen.localdomain> <CAJZ5v0j7HTfg1wY+B+7vhE6tBKPVHMuu_MsFHjaLK70VS_cNEw@mail.gmail.com>
 <ZmnnFueL-Cgw5Eqp@kekkonen.localdomain> <CAJZ5v0gtK9yusimCOVV2dGkQWDwQ6=r=vfbgC-eE60Cg-5wk_Q@mail.gmail.com>
 <ZmnrtIEla9R24egi@kekkonen.localdomain> <CAJZ5v0hXU62QiXxWfkbiovciNNEk0h49kRdScmz5qONTMDA+4A@mail.gmail.com>
 <20240612200012.GP28989@pendragon.ideasonboard.com> <CAJZ5v0hF+6_RCyP-Rr+ajNNEKe0YenFR8x6wX3dG1Pq+vguTwg@mail.gmail.com>
 <20240612204114.GV28989@pendragon.ideasonboard.com>
In-Reply-To: <20240612204114.GV28989@pendragon.ideasonboard.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Jun 2024 14:37:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0geGXHM-yHR-CWN8JremnbnSNFkWJEB+8ZZ=jPbUNy6kA@mail.gmail.com>
Message-ID: <CAJZ5v0geGXHM-yHR-CWN8JremnbnSNFkWJEB+8ZZ=jPbUNy6kA@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: scan: Ignore Dell XPS 9320 camera graph port nodes
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Hans de Goede <hdegoede@redhat.com>, Genes Lists <lists@sapience.com>, linux-kernel@vger.kernel.org, 
	mchehab@kernel.org, hverkuil-cisco@xs4all.nl, wentong.wu@intel.com, 
	linux-media@vger.kernel.org, linux-acpi@vger.kernel.org, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 10:41=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Wed, Jun 12, 2024 at 10:31:06PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jun 12, 2024 at 10:00=E2=80=AFPM Laurent Pinchart
> > <laurent.pinchart@ideasonboard.com> wrote:
> > >
> > > On Wed, Jun 12, 2024 at 08:50:57PM +0200, Rafael J. Wysocki wrote:
> > > > On Wed, Jun 12, 2024 at 8:41=E2=80=AFPM Sakari Ailus wrote:
> > > > > On Wed, Jun 12, 2024 at 08:29:21PM +0200, Rafael J. Wysocki wrote=
:
> > > > > > On Wed, Jun 12, 2024 at 8:21=E2=80=AFPM Sakari Ailus wrote:
> > > > > > > On Wed, Jun 12, 2024 at 03:06:53PM +0200, Rafael J. Wysocki w=
rote:
> > > > > > > > On Wed, Jun 12, 2024 at 2:47=E2=80=AFPM Sakari Ailus wrote:
> > > > > > > > > On Wed, Jun 12, 2024 at 02:32:26PM +0200, Rafael J. Wysoc=
ki wrote:
> > > > > > > > > > > > > > I just hit the same problem on another Dell lap=
top. It seems that
> > > > > > > > > > > > > > all Dell laptops with IPU6 camera from the Tige=
r Lake, Alder Lake
> > > > > > > > > > > > > > and Raptor Lake generations suffer from this pr=
oblem.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > So instead of playing whack a mole with DMI mat=
ches we should
> > > > > > > > > > > > > > simply disable ACPI MIPI DISCO support on all D=
ell laptops
> > > > > > > > > > > > > > with those CPUs. I'm preparing a fix for this t=
o replace
> > > > > > > > > > > > > > the DMI matching now.
> > > > > > > > > > > > >
> > > > > > > > > > > > > DisCo for Imaging support shouldn't be dropped on=
 these systems, and this
> > > > > > > > > > > > > isn't what your patch does either. Instead the AC=
PI graph port nodes (as
> > > > > > > > > > > > > per Linux specific definitions) are simply droppe=
d, i.e. this isn't related
> > > > > > > > > > > > > to DisCo for Imaging at all.
> > > > > > > > > > > >
> > > > > > > > > > > > So it looks like the changelog of that patch could =
be improved, right?
> > > > > > > > > > >
> > > > > > > > > > > Well, yes. The reason the function is in the file is =
that nearly all camera
> > > > > > > > > > > related parsing is located there, not that it would b=
e related to DisCo for
> > > > > > > > > > > Imaging as such.
> > > > > > > > > >
> > > > > > > > > > So IIUC the camera graph port nodes are created by defa=
ult with the
> > > > > > > > > > help of the firmware-supplied information, but if that =
is defective a
> > > > > > > > > > quirk can be added to skip the creation of those ports =
in which case
> > > > > > > > > > they will be created elsewhere.
> > > > > > > > > >
> > > > > > > > > > Is this correct?
> > > > > > > > >
> > > > > > > > > Yes.
> > > > > > > >
> > > > > > > > So it would be good to add a comment to this effect to
> > > > > > > > acpi_nondev_subnode_extract() where acpi_graph_ignore_port(=
) is
> > > > > > > > called.
> > > > > > > >
> > > > > > > > And there is a somewhat tangential question that occurred t=
o me: If
> > > > > > > > the nodes are created elsewhere when acpi_graph_ignore_port=
() is true,
> > > > > > > > why is it necessary to consult the platform firmware for th=
e
> > > > > > > > information on them at all?  Wouldn't it be better to simpl=
y always
> > > > > > > > create them elsewhere?
> > > > > > >
> > > > > > > Simple answer: for the same reason why in general system spec=
ific
> > > > > > > information comes from ACPI and not from platform data compil=
ed into the
> > > > > > > kernel.
> > > > > > >
> > > > > > > Of course this is technically possible but it does not scale.
> > > > > >
> > > > > > While I agree in general, in this particular case the platform =
data
> > > > > > compiled into the kernel needs to be present anyway, at least
> > > > > > apparently, in case the data coming from the platform firmware =
is
> > > > > > invalid.
> > > > > >
> > > > > > So we need to do 3 things: compile in the platform data into th=
e
> > > > > > kernel and expect the platform firmware to provide the necessar=
y
> > > > > > information, and add quirks for the systems where it is known i=
nvalid.
> > > > > >
> > > > > > Isn't this a bit too much?
> > > > >
> > > > > Isn't this pretty much how ACPI works currently?
> > > >
> > > > No, we don't need to put platform data into the kernel for every bi=
t
> > > > of information that can be retrieved from the platform firmware via
> > > > ACPI.
> > > >
> > > > The vast majority of information in the ACPI tables is actually
> > > > correct and if quirks are needed, they usually are limited in scope=
.
> > > >
> > > > Where it breaks is when the ACPI tables are not sufficiently valida=
ted
> > > > by OEMs which mostly happens when the data in question are not need=
ed
> > > > to pass some sort of certification or admission tests.
> > >
> > > We have to be careful here. Part of the job of the ACPI methods for
> > > camera objects is to control the camera sensor PMIC and set up the ri=
ght
> > > voltages (many PMICs have programmable output levels). In many cases
> > > we've seen with the IPU3, broken ACPI support means the methods will =
try
> > > to do something completely bogus, like accessing a PMIC at an incorre=
ct
> > > I2C address. That's mostly fine, it will result in the camera not bei=
ng
> > > detected. We could however have broken ACPI implementation that would
> > > program the PMIC to output voltages that would damage the sensor. Use=
rs
> > > won't be happy.
> >
> > My point is basically that if that data were also used by Windows,
> > then chances are that breakage of this sort would be caught during
> > Windows validation before shipping the machines and so it wouldn't
> > affect Linux as well.
> >
> > However, if OEMs have no vehicle to validate their systems against,
> > bad things can happen indeed.
> >
> > Also, if an OEM has no incentive to carry out the requisite checks,
> > the result is likely to be invalid data in the platform firmware.
>
> We're exactly on the same page. The only solution [*] I can see for this
> problem is to get the Windows drivers to use the same ACPI data as the
> Linux drivers.

That is long-term, however, and in the meantime something needs to be
done about it too.

Sakari is telling me that the warning on boot triggered by firmware
issues was in a new driver and it has been addressed in 6.10-rc3
already.

This is good, as we don't need to worry about people reporting a
regression because of it any more.

Still, IIUC, the driver simply fails to probe if it doesn't get
correct information from the platform firmware and a quirk needs to be
added to the ACPI enumeration code for the driver to use a different
source of information.

I'm wondering if the driver could be modified to switch over to the
different source of information automatically if the firmware-provided
data don't make any sense to it, after logging an FW_BUG message.  It
could even use the other source of information to sanity-check the
firmware-provided data in principle.  It's all software, so it should
be doable.

> * Another solution would be for OEMs to stop caring about Windows and
> testing their machines with Linux only, essentially reversing the
> current situation. Chances of this happening however seem even tinier
> :-)

Seriously though, we could create a Linux-based utility that would
retrieve all of the relevant information from the firmware using the
existing kernel code and they say "this is what I would do to the
hardware based on this information".  That could help people to do
basic checks if they cared.

