Return-Path: <linux-acpi+bounces-6356-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 501E6905CD5
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 22:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE1C1F24279
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 20:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18F284A57;
	Wed, 12 Jun 2024 20:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eX4ALd3Y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804642F50;
	Wed, 12 Jun 2024 20:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718224279; cv=none; b=PEPKJS3x25I2EQggV7kVJGeom2+p2tcNTYcEEdyC91OWcnIM5yJgQ5gkoWdc9JAj6hGkZ9BKrKMWfgu+EajD3jVsHHr8zTavhnEXsvbP9+z9N26ERySq1zA4wh+dQpRO5v83f/rJK10qZacKYrrq+48Nhc17T6yS98pOu69LRi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718224279; c=relaxed/simple;
	bh=HY2qgzNeWbkLILb0hdsOFXDNhMJvoo73ZepbbNjLKSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+lGK4K6nZbIMLNb0Qh16FzjVuea39rJ1eDtTYUcbgXJ7vnAPRXQLlGU4hbxCs+DMMmUPA4+fCanAg1pioFevgCjv1CPRAesEa50rGvQuqtqVqtrm93drWHFZWmTJr+aLTTIYYAlC0upawWfmVghm4qgT8rAIXiFnb69e8mzjjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eX4ALd3Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191AFC4AF55;
	Wed, 12 Jun 2024 20:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718224279;
	bh=HY2qgzNeWbkLILb0hdsOFXDNhMJvoo73ZepbbNjLKSQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eX4ALd3Y8T7LAZznqDfmCsFZyXnFjfrIxBHz5zjL8yXZv2ypLnQIGPNztZTjKsFvQ
	 2qPT6lnjJNTRHTZiKXvrCeCM/Hl1XX80J3/kOW/TWRt/eQYj9fqJHnTzO+EWZgR+8P
	 f+/dSh1xrXuKF6zeXe5D2S/rNcjjst2S5ywK1naINfdfEksVBsy7HtV5TRkV1Y9Gef
	 Vr6OrBUc17lzbd7/cGspYNB3LiM92W1tnQsrBZYY93paf1OLB3+G6tIzYR5JZsoY2i
	 IEtolFsFgiXiKsklU+3Hyys8pIJaJovO4GEjMwnNVv7RFmTkUXYzGLdY3ZJMzU2HfO
	 Ds3P0ANwVsXTw==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-254ceab70e3so31140fac.2;
        Wed, 12 Jun 2024 13:31:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUb9jGRewniRZc5CSyuTj3FjlxrMKsWCuc5TpeW6L1Iwz/7/0i/KQPlEdWNcJN0M612bN03ld8t9W8ZOnuAZx+TpfqKgEbAxrjQ5xcqoJxWWuZVwx9T7cTCRzTzNK3BrwIh+uCPyfrIl3UWJbWBzSQ0iKQb4KvjJc/VNYDnCm5dGdn0KIzj
X-Gm-Message-State: AOJu0Yxf4JOKodwlss3Tqx822jrcgNrQnSDfMN28vLy5g31BQFNXka9t
	TQbQPRAboNeB4Qi1SC9TzhmxSop7uTQHlgXBQuY3HQgbZ6h1isdsudq/arL5HiJBCO/fm7iaHPV
	IVGxcPZbRmLdcwW79e4GPc7osCEY=
X-Google-Smtp-Source: AGHT+IE6zLDp0Xr9uEZW3NcTgA28SMy5R0lGm6I9ZmdfoYb6zvenzjQgpu06Q4ox7ABFxNDHbnIu5Ak4Fc+s2DYR/Ww=
X-Received: by 2002:a05:6870:e2cc:b0:255:1fea:340d with SMTP id
 586e51a60fabf-2551fea40d9mr2036264fac.0.1718224278027; Wed, 12 Jun 2024
 13:31:18 -0700 (PDT)
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
 <20240612200012.GP28989@pendragon.ideasonboard.com>
In-Reply-To: <20240612200012.GP28989@pendragon.ideasonboard.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Jun 2024 22:31:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hF+6_RCyP-Rr+ajNNEKe0YenFR8x6wX3dG1Pq+vguTwg@mail.gmail.com>
Message-ID: <CAJZ5v0hF+6_RCyP-Rr+ajNNEKe0YenFR8x6wX3dG1Pq+vguTwg@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: scan: Ignore Dell XPS 9320 camera graph port nodes
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Hans de Goede <hdegoede@redhat.com>, Genes Lists <lists@sapience.com>, linux-kernel@vger.kernel.org, 
	mchehab@kernel.org, hverkuil-cisco@xs4all.nl, wentong.wu@intel.com, 
	linux-media@vger.kernel.org, linux-acpi@vger.kernel.org, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 10:00=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Wed, Jun 12, 2024 at 08:50:57PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jun 12, 2024 at 8:41=E2=80=AFPM Sakari Ailus wrote:
> > > On Wed, Jun 12, 2024 at 08:29:21PM +0200, Rafael J. Wysocki wrote:
> > > > On Wed, Jun 12, 2024 at 8:21=E2=80=AFPM Sakari Ailus wrote:
> > > > > On Wed, Jun 12, 2024 at 03:06:53PM +0200, Rafael J. Wysocki wrote=
:
> > > > > > On Wed, Jun 12, 2024 at 2:47=E2=80=AFPM Sakari Ailus wrote:
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
>
> We have to be careful here. Part of the job of the ACPI methods for
> camera objects is to control the camera sensor PMIC and set up the right
> voltages (many PMICs have programmable output levels). In many cases
> we've seen with the IPU3, broken ACPI support means the methods will try
> to do something completely bogus, like accessing a PMIC at an incorrect
> I2C address. That's mostly fine, it will result in the camera not being
> detected. We could however have broken ACPI implementation that would
> program the PMIC to output voltages that would damage the sensor. Users
> won't be happy.

My point is basically that if that data were also used by Windows,
then chances are that breakage of this sort would be caught during
Windows validation before shipping the machines and so it wouldn't
affect Linux as well.

However, if OEMs have no vehicle to validate their systems against,
bad things can happen indeed.

Also, if an OEM has no incentive to carry out the requisite checks,
the result is likely to be invalid data in the platform firmware.

