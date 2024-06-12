Return-Path: <linux-acpi+bounces-6341-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3B7905B41
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 20:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87FF1F23C3D
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 18:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622C359B71;
	Wed, 12 Jun 2024 18:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlGmqilp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAD651C45;
	Wed, 12 Jun 2024 18:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718217716; cv=none; b=PLabNLJ/AcQAFwjrQdmKflH+4++U85kvfW38/WJRQx/bgFJOKg+SKQfpza+xcO9rIIsWWvdmMPWCP2eoPtqWjsX+wwGlWUMK67OH6Le+u/6uByw5Xu4GZAx+mWYY0r0zzU4cXz4SJqDhYx7dv0/kpNAp2Ufdwjd+jxJCMRqHiAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718217716; c=relaxed/simple;
	bh=bsiocjMdSbNWXRE26AKfuTdlJAeRjkYzp/UJN99xvY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hIQIPqFmN3L6HSbXt4A4ReFEiZLZ0OFcFIoGjBWpLq3qCcjl9CM5/TtR/DnIyJsj+k/N9wrM0OF54a62HbUg4UxpRxXm7vZjPJ3W/XiMBK5FgEYpCzTI5fmc117g7pHohdykhhfVhRuiVaPuZiLeMGjo+MIPR3F3I8CUZUykq7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlGmqilp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30D6C4AF50;
	Wed, 12 Jun 2024 18:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718217715;
	bh=bsiocjMdSbNWXRE26AKfuTdlJAeRjkYzp/UJN99xvY8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WlGmqilpadNsVXr+hlHuIg0rvLfsWMs2ZK2hW1pCX8laDRVuGBO0ZKaDCnKIC45OG
	 SXcY+a0AkHfOBudvi/cNs7OFiIDuDyjv4RQC5aZrkjAXkTcs9IxOMIpmxsKtOxVjxO
	 QcuU6MOQUjOShyo0iYJQARG5kRKTLIdCe52FI7kk0+q6hc7An/KjVxFw1G6ValEuXE
	 pMTjgbpAYH3/ZdGIQyTjfdn1oTXw7c8N/+OLBqsMxqs5dbMghEeWNsJaN8nZw4UBN2
	 QoDsXAphguFCD8Q7BSREyw3luycABlrE7WwdUujpIsL4+UgG+ufHHHuninKHpYAgNF
	 q8D+DLcZd6iGg==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5bad97708efso17658eaf.1;
        Wed, 12 Jun 2024 11:41:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0aBX4pW//2OiWbzaq8yzW1Y1KZwLHYcRqSyxsPrbcePSr2QXFS73ZEGMMIw59aecdmiurRUQN8ZagR7wimv26t5aq48GoXZsXQPNGwIiaLjlNYhLepKZCBsokQfZAHiKQR4GsuRiscwPE4Vb18M5TdSDdiAyh8kSEqZpnmqe1rnxXEJan
X-Gm-Message-State: AOJu0Yx9FPcS8si6V89XPmlX0JZq1aUe+WlQhOgr0G+caAErDQ2f58np
	Ky8XkdXh1DIgTHV23upkqCF9HPKUO6ZradOEj0xF5WJozOat3BLtBunbO6ZfSxvSf8Fb8pQ/jY8
	Lm2ksnRIPgsbhOCWDlMIPx9vfaHM=
X-Google-Smtp-Source: AGHT+IFnK5h44LsdeYX+xRSwdvSgqIYjg8Vd+aOcIXNMFJrSOGxTPhNHMiiucq46k6atD9R3fAhOisT5pW1/jzJzuUo=
X-Received: by 2002:a4a:3101:0:b0:5ba:ca8a:6598 with SMTP id
 006d021491bc7-5bb3b7b972bmr2887893eaf.0.1718217715001; Wed, 12 Jun 2024
 11:41:55 -0700 (PDT)
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
 <18cb82bb-51c6-4a52-80a4-6b1e3d95f99c@redhat.com> <CAJZ5v0je=Z+2LWv41OVwunujfTD7U2L9QDrNa7MoNBL+Chstnw@mail.gmail.com>
 <Zmnp8JbFj7ZoN5Vy@kekkonen.localdomain>
In-Reply-To: <Zmnp8JbFj7ZoN5Vy@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Jun 2024 20:41:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ie+OzJ5xd2g-j+pT=D20Ps__dA149XRnX8i9r4KKJ=ww@mail.gmail.com>
Message-ID: <CAJZ5v0ie+OzJ5xd2g-j+pT=D20Ps__dA149XRnX8i9r4KKJ=ww@mail.gmail.com>
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

On Wed, Jun 12, 2024 at 8:33=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Wed, Jun 12, 2024 at 05:26:46PM +0200, Rafael J. Wysocki wrote:
> > Hi,
> >
> > On Wed, Jun 12, 2024 at 4:30=E2=80=AFPM Hans de Goede <hdegoede@redhat.=
com> wrote:
> > >
> > > Hi,
> > >
> > > On 6/12/24 3:06 PM, Rafael J. Wysocki wrote:
> > > > Hi Sakari,
> > > >
> > > > On Wed, Jun 12, 2024 at 2:47=E2=80=AFPM Sakari Ailus
> > > > <sakari.ailus@linux.intel.com> wrote:
> > > >>
> > > >> Hi Rafael,
> > > >>
> > > >> On Wed, Jun 12, 2024 at 02:32:26PM +0200, Rafael J. Wysocki wrote:
> > > >>>>>>> I just hit the same problem on another Dell laptop. It seems =
that
> > > >>>>>>> all Dell laptops with IPU6 camera from the Tiger Lake, Alder =
Lake
> > > >>>>>>> and Raptor Lake generations suffer from this problem.
> > > >>>>>>>
> > > >>>>>>> So instead of playing whack a mole with DMI matches we should
> > > >>>>>>> simply disable ACPI MIPI DISCO support on all Dell laptops
> > > >>>>>>> with those CPUs. I'm preparing a fix for this to replace
> > > >>>>>>> the DMI matching now.
> > > >>>>>>
> > > >>>>>> DisCo for Imaging support shouldn't be dropped on these system=
s, and this
> > > >>>>>> isn't what your patch does either. Instead the ACPI graph port=
 nodes (as
> > > >>>>>> per Linux specific definitions) are simply dropped, i.e. this =
isn't related
> > > >>>>>> to DisCo for Imaging at all.
> > > >>>>>
> > > >>>>> So it looks like the changelog of that patch could be improved,=
 right?
> > > >>>>
> > > >>>> Well, yes. The reason the function is in the file is that nearly=
 all camera
> > > >>>> related parsing is located there, not that it would be related t=
o DisCo for
> > > >>>> Imaging as such.
> > > >>>
> > > >>> So IIUC the camera graph port nodes are created by default with t=
he
> > > >>> help of the firmware-supplied information, but if that is defecti=
ve a
> > > >>> quirk can be added to skip the creation of those ports in which c=
ase
> > > >>> they will be created elsewhere.
> > > >>>
> > > >>> Is this correct?
> > > >>
> > > >> Yes.
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
> > > That is a good question. The ACPI MIPI DISCO specification is an
> > > attempt standardize how MIPI cameras and their sensors are described
> > > in ACPI.
> > >
> > > But this is not actually being used by any Windows drivers atm. The w=
indows
> > > drivers rely on their own custom ACPI data which gets translated into
> > > standard Linux device-properties by: drivers/media/pci/intel/ipu-brid=
ge.c
> > >
> > > and so far AFAIK there are 0 laptops where there actually is 100% fun=
ctional
> > > ACPI MIPI information. I believe that some work is in place to get co=
rrect
> > > usable ACPI MIPI information in place in the ACPI tables of some Mete=
or Lake
> > > laptops. But I believe that there too it does not work yet with the B=
IOS
> > > version with which current Windows models are shipping. It is being f=
ixed
> > > for systems which have Linux support from the vendor but I suspect th=
at
> > > on other models if ACPI MIPI DISCO information is there it will not
> > > necessarily be reliable because AFAICT Windows does not actually use =
it.
> > >
> > > And TBH this has me worried about camera support for Meteor Lake devi=
ces
> > > going forward. We really need to have 1 reliable source of truth here=
 and
> > > using information which is ignored by Windows does not seem like the =
best
> > > source to use.
> > >
> > > Sakari I know you have been pushing for MIPI camera descriptions unde=
r
> > > ACPI to move to a standardized format and I can see how that is a goo=
d
> > > thing, but atm it seems to mainly cause things to break and before
> > > the ACPI MIPI DISCO support landed in 6.8 we did not have these issue=
s,
> > > since the information used by the ipu-bridge code does seem to be cor=
rect.
> >
> > Well, if Windows doesn't use this information, it is almost guaranteed
> > to be garbage.
>
> No ACPI DSDT in production systems uses DisCo for Imaging as of now at
> least to my knowledge.
>
> >
> > So maybe it would be better to make acpi_graph_ignore_port() return
> > true by default and false only when the information is known to be
> > valid.  IOW, whitelist things instead of adding blacklist entries in
> > perpetuum.
>
> What could be gained from this?

Generally speaking, fewer headaches for people trying to support Linux
on Intel client platforms.

Every system that needs to be put into dmi_ignore_port_nodes[] means a
boot problem for someone that needs to be addressed.

And after the Hans' patch at

https://patchwork.kernel.org/project/linux-acpi/patch/20240612104220.22219-=
1-hdegoede@redhat.com/

we would effectively get very close to that point anyway.

Are the ACPI tables on MTL and beyond going to be fixed?  If not,
we'll probably need to add MTL to the list of platform IDs and so on.
In what way is this better?

