Return-Path: <linux-acpi+bounces-6335-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2727B9056D5
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 17:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EAF0B22805
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 15:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E71F17F503;
	Wed, 12 Jun 2024 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AP3e0CNc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2037F17C7C8;
	Wed, 12 Jun 2024 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718206019; cv=none; b=PfFyu5TxTvkOaN/KRk2rEn7q0hLA2Ra4ysFkox/jY4XU/tzNYWKCIgXbniQOxEZ6KjyVJ27OEpEws3F3sIFwPjx6VVfJwcd+y8e/qkqIgkrB1lS5CB17+vXWx/FHxvD8WKsgf0V31s6hpTKaiHNA0FxalCW23vVGbYm5JyyOoCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718206019; c=relaxed/simple;
	bh=i0tIWVrxpXVNiH8UaLFBap5+2XPdFzrsjMX6/kJT1ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5gOdah5SD+NUAQj/9gLE0Rp8r/tI4cw/Y6nwfHiZg+dhndEk8OQB9ZL4IBGX6Yl0wm0vY+np40z9VmwFtqyKH+dUWMdsdHWO9XIc9YtSct682owyCIcEYQsStK3kuxdtl8Lv5awYXQYpeMFjtEugyriry2TYB8Jjfxi9T1niXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AP3e0CNc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01692C4AF50;
	Wed, 12 Jun 2024 15:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718206019;
	bh=i0tIWVrxpXVNiH8UaLFBap5+2XPdFzrsjMX6/kJT1ns=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AP3e0CNcf3s2NZtQ+jo2N0jCN7wOgdw/6YBMtvS38euYp3lQqnkUM+6aXRzIvA5NW
	 60vT8OcHim2lBiPy8S8Yswa9Ckrc452Ovq658cI9B3rmBvoZEIJ8h8f/Qvmc2noaAu
	 ebigdw2mmdtI9HEgq0dOoAqlbVbQQ+NeKT/laGQmrtzVzkJw1dEyEANXFJRaryXPIl
	 ht3qBcW/PnAJbNy4pJ9y4MBHTWwT7qcutAqAdZ7vYq/BQzbV5DiGxN4wr6qhuY3fdU
	 7kXHcHosxAPbt16JBuoVPvWSsW7kKeuDP1ppKSXshX3iVly72/248Akc3AMH78JiZ+
	 zByKcmBXZ8/5w==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-254c411d816so111889fac.1;
        Wed, 12 Jun 2024 08:26:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVWEqmWwxIFYuDnDDt1uEIJohipS+eCLJN18zILUm8uj/VcaHkHoq/OnocNlMsUkr8sVEQ6SBEoMCY7wLDGd6sfxUSuA3+lXyYJlQSDI53745Gd7zSyfGZFkxHsrSKSxYGRjGVOGWc0E33IAO6BJWscAW+XsOKyDkerE6PGPQuKnFccYv0n
X-Gm-Message-State: AOJu0YyEwh2UlI83TPXEej60Uihbu/4kbSwQwo8+PVJQclg3xB9IXVAH
	rv0LllpuHI8qzUkEvTIwQSWyma4XRj8qKfWTGNslvX7SLr4Hn8bUk0jjQzGHcZyuq2mmsC1x35O
	8osLrxRbVY3GZ5CZKh/otw866drw=
X-Google-Smtp-Source: AGHT+IEmGKsa7zPe9kt73Q8m7u/t5Z55oHv8QPOlgNJhzyXFN2PzZ1dBxzIRNYGfQ9TOgOaE06d3xxBR9OIkbG+g9tg=
X-Received: by 2002:a05:6871:5813:b0:254:d417:34ff with SMTP id
 586e51a60fabf-255151dd450mr2398277fac.4.1718206018125; Wed, 12 Jun 2024
 08:26:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <988e48090982c89ce0c906954832fdfb09a1ce34.camel@sapience.com>
 <20240528084413.2624435-1-sakari.ailus@linux.intel.com> <a05df025-a0be-49cd-84a9-7d7fb2eeb33e@redhat.com>
 <e9062095-b312-44df-a9e3-0b09f3ec9eff@redhat.com> <4b387b4d-f778-4891-9f07-df5fc0a093cd@redhat.com>
 <ZmmQLt7wB-yGQBTw@kekkonen.localdomain> <CAJZ5v0ii3WFQRPdfHeeW4M9kXSWDVxxxy02zThcf25mjNwqDAw@mail.gmail.com>
 <ZmmT56Cyvb2FCyav@kekkonen.localdomain> <CAJZ5v0hOBggQR_=uA3VuhruQnZihVxHHovpTz4=qfcbiSunsYw@mail.gmail.com>
 <ZmmY3he9vfWVWU3I@kekkonen.localdomain> <CAJZ5v0j7HTfg1wY+B+7vhE6tBKPVHMuu_MsFHjaLK70VS_cNEw@mail.gmail.com>
 <18cb82bb-51c6-4a52-80a4-6b1e3d95f99c@redhat.com>
In-Reply-To: <18cb82bb-51c6-4a52-80a4-6b1e3d95f99c@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Jun 2024 17:26:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0je=Z+2LWv41OVwunujfTD7U2L9QDrNa7MoNBL+Chstnw@mail.gmail.com>
Message-ID: <CAJZ5v0je=Z+2LWv41OVwunujfTD7U2L9QDrNa7MoNBL+Chstnw@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: scan: Ignore Dell XPS 9320 camera graph port nodes
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Genes Lists <lists@sapience.com>, linux-kernel@vger.kernel.org, mchehab@kernel.org, 
	hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com, 
	wentong.wu@intel.com, linux-media@vger.kernel.org, linux-acpi@vger.kernel.org, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 12, 2024 at 4:30=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi,
>
> On 6/12/24 3:06 PM, Rafael J. Wysocki wrote:
> > Hi Sakari,
> >
> > On Wed, Jun 12, 2024 at 2:47=E2=80=AFPM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> >>
> >> Hi Rafael,
> >>
> >> On Wed, Jun 12, 2024 at 02:32:26PM +0200, Rafael J. Wysocki wrote:
> >>>>>>> I just hit the same problem on another Dell laptop. It seems that
> >>>>>>> all Dell laptops with IPU6 camera from the Tiger Lake, Alder Lake
> >>>>>>> and Raptor Lake generations suffer from this problem.
> >>>>>>>
> >>>>>>> So instead of playing whack a mole with DMI matches we should
> >>>>>>> simply disable ACPI MIPI DISCO support on all Dell laptops
> >>>>>>> with those CPUs. I'm preparing a fix for this to replace
> >>>>>>> the DMI matching now.
> >>>>>>
> >>>>>> DisCo for Imaging support shouldn't be dropped on these systems, a=
nd this
> >>>>>> isn't what your patch does either. Instead the ACPI graph port nod=
es (as
> >>>>>> per Linux specific definitions) are simply dropped, i.e. this isn'=
t related
> >>>>>> to DisCo for Imaging at all.
> >>>>>
> >>>>> So it looks like the changelog of that patch could be improved, rig=
ht?
> >>>>
> >>>> Well, yes. The reason the function is in the file is that nearly all=
 camera
> >>>> related parsing is located there, not that it would be related to Di=
sCo for
> >>>> Imaging as such.
> >>>
> >>> So IIUC the camera graph port nodes are created by default with the
> >>> help of the firmware-supplied information, but if that is defective a
> >>> quirk can be added to skip the creation of those ports in which case
> >>> they will be created elsewhere.
> >>>
> >>> Is this correct?
> >>
> >> Yes.
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
> That is a good question. The ACPI MIPI DISCO specification is an
> attempt standardize how MIPI cameras and their sensors are described
> in ACPI.
>
> But this is not actually being used by any Windows drivers atm. The windo=
ws
> drivers rely on their own custom ACPI data which gets translated into
> standard Linux device-properties by: drivers/media/pci/intel/ipu-bridge.c
>
> and so far AFAIK there are 0 laptops where there actually is 100% functio=
nal
> ACPI MIPI information. I believe that some work is in place to get correc=
t
> usable ACPI MIPI information in place in the ACPI tables of some Meteor L=
ake
> laptops. But I believe that there too it does not work yet with the BIOS
> version with which current Windows models are shipping. It is being fixed
> for systems which have Linux support from the vendor but I suspect that
> on other models if ACPI MIPI DISCO information is there it will not
> necessarily be reliable because AFAICT Windows does not actually use it.
>
> And TBH this has me worried about camera support for Meteor Lake devices
> going forward. We really need to have 1 reliable source of truth here and
> using information which is ignored by Windows does not seem like the best
> source to use.
>
> Sakari I know you have been pushing for MIPI camera descriptions under
> ACPI to move to a standardized format and I can see how that is a good
> thing, but atm it seems to mainly cause things to break and before
> the ACPI MIPI DISCO support landed in 6.8 we did not have these issues,
> since the information used by the ipu-bridge code does seem to be correct=
.

Well, if Windows doesn't use this information, it is almost guaranteed
to be garbage.

So maybe it would be better to make acpi_graph_ignore_port() return
true by default and false only when the information is known to be
valid.  IOW, whitelist things instead of adding blacklist entries in
perpetuum.

And hopefully we'll eventually get to the point at which we are able
to say "whitelist everything from now on".

