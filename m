Return-Path: <linux-acpi+bounces-6343-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C52B8905B7D
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 20:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 445F71F24AF4
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 18:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB19253E2B;
	Wed, 12 Jun 2024 18:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgxUUnk/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4D46EB56;
	Wed, 12 Jun 2024 18:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718218270; cv=none; b=C0V4S9K5L2lVzYUgO4JCd3d9ZaF9wVS4HCJx8Z023vL1GMwxUPE+rsFxAFCWy82qhs16HRvlorAt5Cp14PdaZdOMZ5SPpOdXEuAk+sorPV2/2lTDH7qvKqr2Xog73nxmZv0om5u9ypbyBU9S/ZRpHdk4HFeda3Fw5w8q6K/vb+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718218270; c=relaxed/simple;
	bh=4H4DmsdoJKBGJmMdPbGYMAKrPkV8qJghcN/5awkWQkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBXxQcTGOgRbxZ+AQCDqIXcQV0zA9BwyxjzWr0cxd8zmIyU3vm94QRXTBbGoPgl2+ze83xhrDgdrIoYz0pAOkAZHvt1Xo9/u4LmeNw9VXh3H8YmmeWW1hoV/8NzPQuLilfQBsqf6BUng5rR4sXVWgHUao6JQXE/Zb3JhHkODwTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgxUUnk/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47746C4AF52;
	Wed, 12 Jun 2024 18:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718218270;
	bh=4H4DmsdoJKBGJmMdPbGYMAKrPkV8qJghcN/5awkWQkc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PgxUUnk/p1irKyt8Uz/hQX3zl6YFCkl+KlFTdlnhsGlAgn041wwM52QXtpPPbSdfT
	 4V72M3edpKrdNfxpCsapHqMvmOXp5LPF23zskPv4XC7Z2KK6xNZILV91ChNSJjlnCb
	 49h6x5hin4s0nHBqKbFQc/5fhAYrN0ONIPnoAk7rR27ug5D74EJYAw3BVfU8HC1bpn
	 A+AVBOPNB2mNiMyaBeDCMdS51pUqlbxQGpc7TlHA4bCWkbzk19GyrNtUnFkVOimW89
	 lZDKeAuzY1OiGNkzJEsbvj8VbOVJUoOwwPHDFSzuangJr7fOXk3QTHqx/F7nw5KAzG
	 DenLNRw1NnGaA==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-254976d3327so19548fac.1;
        Wed, 12 Jun 2024 11:51:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWD7bBO3c0v1xD9iCOlFHnUvXr+q4DkIeMm5Hm6C05xJtJ1D0okop9eLtcpBNk2Hluzimwej6TIt/H2T7s=@vger.kernel.org, AJvYcCWjJTrIvFjXLDJkbejA1WELkqn47HItg82gqfHHydbZXKuY2K5K5iNrdQXtkXxV/qWsmNe9Gr5zXwuVXaGh@vger.kernel.org, AJvYcCXEAjv9tH1DHeeLDBWs2aQq79Qj7qxinTn8Y0X/o9TmvnOQz1FnM9NiZrSHI4QHt96X5obJgKPAt9Iq@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/yU1yMXu4xjOH5/MjKzCqBDROgqgQJ9NKYmzXZE7ehMrXwmFJ
	vVD/+MZBkF72FaSg8WG5GfVmSgGKYC3LuFFNwXUuZTKr0A8/tsPktMYacz7W5ihG5O5mJPZnyjo
	JBPb4E5Jjm+jvbPxxCmCkDXX9xrc=
X-Google-Smtp-Source: AGHT+IEtq+QLYCLEoPLhjiMSdNXsvIPL66kpfPyfQltBzCkynedzwfytjGdmPZCT4d4KvksfnkCFYYka4Poy9hD5/aA=
X-Received: by 2002:a05:6870:c1cc:b0:24f:e599:9168 with SMTP id
 586e51a60fabf-25514b3b43dmr2877359fac.1.1718218269198; Wed, 12 Jun 2024
 11:51:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e9062095-b312-44df-a9e3-0b09f3ec9eff@redhat.com>
 <4b387b4d-f778-4891-9f07-df5fc0a093cd@redhat.com> <ZmmQLt7wB-yGQBTw@kekkonen.localdomain>
 <CAJZ5v0ii3WFQRPdfHeeW4M9kXSWDVxxxy02zThcf25mjNwqDAw@mail.gmail.com>
 <ZmmT56Cyvb2FCyav@kekkonen.localdomain> <CAJZ5v0hOBggQR_=uA3VuhruQnZihVxHHovpTz4=qfcbiSunsYw@mail.gmail.com>
 <ZmmY3he9vfWVWU3I@kekkonen.localdomain> <CAJZ5v0j7HTfg1wY+B+7vhE6tBKPVHMuu_MsFHjaLK70VS_cNEw@mail.gmail.com>
 <ZmnnFueL-Cgw5Eqp@kekkonen.localdomain> <CAJZ5v0gtK9yusimCOVV2dGkQWDwQ6=r=vfbgC-eE60Cg-5wk_Q@mail.gmail.com>
 <ZmnrtIEla9R24egi@kekkonen.localdomain>
In-Reply-To: <ZmnrtIEla9R24egi@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Jun 2024 20:50:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hXU62QiXxWfkbiovciNNEk0h49kRdScmz5qONTMDA+4A@mail.gmail.com>
Message-ID: <CAJZ5v0hXU62QiXxWfkbiovciNNEk0h49kRdScmz5qONTMDA+4A@mail.gmail.com>
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

On Wed, Jun 12, 2024 at 8:41=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Wed, Jun 12, 2024 at 08:29:21PM +0200, Rafael J. Wysocki wrote:
> > Hi Sakari,
> >
> > On Wed, Jun 12, 2024 at 8:21=E2=80=AFPM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Rafael,
> > >
> > > On Wed, Jun 12, 2024 at 03:06:53PM +0200, Rafael J. Wysocki wrote:
> > > > Hi Sakari,
> > > >
> > > > On Wed, Jun 12, 2024 at 2:47=E2=80=AFPM Sakari Ailus
> > > > <sakari.ailus@linux.intel.com> wrote:
> > > > >
> > > > > Hi Rafael,
> > > > >
> > > > > On Wed, Jun 12, 2024 at 02:32:26PM +0200, Rafael J. Wysocki wrote=
:
> > > > > > > > > > I just hit the same problem on another Dell laptop. It =
seems that
> > > > > > > > > > all Dell laptops with IPU6 camera from the Tiger Lake, =
Alder Lake
> > > > > > > > > > and Raptor Lake generations suffer from this problem.
> > > > > > > > > >
> > > > > > > > > > So instead of playing whack a mole with DMI matches we =
should
> > > > > > > > > > simply disable ACPI MIPI DISCO support on all Dell lapt=
ops
> > > > > > > > > > with those CPUs. I'm preparing a fix for this to replac=
e
> > > > > > > > > > the DMI matching now.
> > > > > > > > >
> > > > > > > > > DisCo for Imaging support shouldn't be dropped on these s=
ystems, and this
> > > > > > > > > isn't what your patch does either. Instead the ACPI graph=
 port nodes (as
> > > > > > > > > per Linux specific definitions) are simply dropped, i.e. =
this isn't related
> > > > > > > > > to DisCo for Imaging at all.
> > > > > > > >
> > > > > > > > So it looks like the changelog of that patch could be impro=
ved, right?
> > > > > > >
> > > > > > > Well, yes. The reason the function is in the file is that nea=
rly all camera
> > > > > > > related parsing is located there, not that it would be relate=
d to DisCo for
> > > > > > > Imaging as such.
> > > > > >
> > > > > > So IIUC the camera graph port nodes are created by default with=
 the
> > > > > > help of the firmware-supplied information, but if that is defec=
tive a
> > > > > > quirk can be added to skip the creation of those ports in which=
 case
> > > > > > they will be created elsewhere.
> > > > > >
> > > > > > Is this correct?
> > > > >
> > > > > Yes.
> > > >
> > > > So it would be good to add a comment to this effect to
> > > > acpi_nondev_subnode_extract() where acpi_graph_ignore_port() is
> > > > called.
> > > >
> > > > And there is a somewhat tangential question that occurred to me: If
> > > > the nodes are created elsewhere when acpi_graph_ignore_port() is tr=
ue,
> > > > why is it necessary to consult the platform firmware for the
> > > > information on them at all?  Wouldn't it be better to simply always
> > > > create them elsewhere?
> > >
> > > Simple answer: for the same reason why in general system specific
> > > information comes from ACPI and not from platform data compiled into =
the
> > > kernel.
> > >
> > > Of course this is technically possible but it does not scale.
> >
> > While I agree in general, in this particular case the platform data
> > compiled into the kernel needs to be present anyway, at least
> > apparently, in case the data coming from the platform firmware is
> > invalid.
> >
> > So we need to do 3 things: compile in the platform data into the
> > kernel and expect the platform firmware to provide the necessary
> > information, and add quirks for the systems where it is known invalid.
> >
> > Isn't this a bit too much?
>
> Isn't this pretty much how ACPI works currently?

No, we don't need to put platform data into the kernel for every bit
of information that can be retrieved from the platform firmware via
ACPI.

The vast majority of information in the ACPI tables is actually
correct and if quirks are needed, they usually are limited in scope.

Where it breaks is when the ACPI tables are not sufficiently validated
by OEMs which mostly happens when the data in question are not needed
to pass some sort of certification or admission tests.

Which unfortunately is related to whether or not Windows uses those data.

> We can support systems that contain correct DSDT description of cameras
> without platform data. I was, until recently, only aware of Dell XPS 9315
> that has incorrect camera description and that based on recent findings
> seems to extend to other Dell systems with IPU6 (Hans's patches have the
> details).
>
> Still this is not a reason to break systems that have correct camera
> description and expect the users to report them so they can be listed as
> such.

Well, what do you mean by "break".  I thought that platform data
needed to support them were built into the kernel, weren't they?

> >
> > > On laptops shipped with Windows some additional information is also a=
vailable
> > > from ACPI via custom objects but a lot of information is just hard co=
ded into
> > > the IPU bridge as well as the INT3472 driver.
> >
> > Well, that's how it goes.
>
> Yes, but is it desirable?

No, it is not desirable, but the way to address it is to convince the
Windows people to stop doing this and use standard-defined data from
the ACPI tables instead.  It cannot be addressed by Linux unilaterally
trying to do the right thing, because there are OEMs who don't care
about Linux.

