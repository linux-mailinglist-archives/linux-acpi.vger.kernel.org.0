Return-Path: <linux-acpi+bounces-6347-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845A9905BC1
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 21:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E5172869FC
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 19:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71358286F;
	Wed, 12 Jun 2024 19:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikyuq2oi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D8E1EB2A;
	Wed, 12 Jun 2024 19:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718219592; cv=none; b=EI0vHjpnCjJrBVgb3vBkju/BomSFiHlBPiP/r6Hfmns/VCRP7roMcZ+YHzaxEP4TvIsp3mt8JbkJPQLhX5tzeYkbLuAx6FV1tdAg4Fjj6MOh0s2HG5WPDKVUDk13gLM/Fw/7/5H1AbWpTQCG+41FdFc9k8G4x058nQ+aVCctJxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718219592; c=relaxed/simple;
	bh=D95BUDPDOiXvOzh2dkf+mPT2ETEOxlXOeFeNIfYAtpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TiQzywsN+LG6c966JHnlvz/Ge0m2Og0QdKMh2Ayun9McUw9CWpSBHrzmhJU2XFX3IhbJ7lWuz94yIprHA5rsvHL7OKe8/rDg5KXazr2Nl+3wLLtvtCowgDbAKXVcaHeXIOFHRkxvX0b4QzYR/TBB7j3G2/gt0nP6ofsoTP3nIJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikyuq2oi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B7DC4AF48;
	Wed, 12 Jun 2024 19:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718219592;
	bh=D95BUDPDOiXvOzh2dkf+mPT2ETEOxlXOeFeNIfYAtpI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ikyuq2oirVuje91Fz2ah+jvxTe59EKKA4pVVyhuw6u4CddK/v3cJpofYQH4z0loBu
	 S96o38t04VEqZVur40n8/ZxuloA1O76Fpo1QsjqxBzHvYlmFWhTRod2SitJSr2siFi
	 A6RWisPsQl9Q7w+7//J6DnDA/M/vwpIdkprXl6SE+o0KiDDFemHwb0LfOIClov5hUA
	 UAgh9h6RSzp3xqqprIAn+aG0B9FCJAO6mig1rg5uZOb1TEq8beWhWsWiqEW2NLTEgM
	 wGgYAJVwi4pCCKdHV5ODIh57qRlU528iL/ZDavAa5lnnnaIxiQgZbk8yJ4V19Rbil0
	 /nU4la17QkyiQ==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-254f646b625so27187fac.0;
        Wed, 12 Jun 2024 12:13:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWBc5RE9nfyxc2rNu6fyP+wR60OnOPeW934UhgWNzgz6F/hlUFRcMK2c73OxzFDjQ8bCQrj42EIc+zoWwUk7Lrr5oGxqSNzSC5pecPRbbLCKyqvTJNkboS2r45kdv6IXrzYLaLRkgghsn02Hr5CCP5MtAgpQvqtwYWJ1pbFqhveVCGka3I1
X-Gm-Message-State: AOJu0YzSPd5QTDF0dI97JuVfX/TwUEbFdXCEhrFTmZXVwlOFjEiKD7AJ
	QtIbpPakPj1UZDOfqRF5AqiMqzWQ9v+b9/TSWGCnZNPYmkb6DwRmeZTyLwhRhpimLS5kg4t+zyH
	OV6P8PrtaGgVAIjdwJLU8NFBT/Sk=
X-Google-Smtp-Source: AGHT+IFuGyn0gfOYtvlCb/88UiDCNDsdNgqbD+iqDzd+pTHdHpZmtW9bbN5yuBoGvspfvNjBajNSalJ5Ph8RTYmWi/U=
X-Received: by 2002:a05:6871:5813:b0:254:d417:34ff with SMTP id
 586e51a60fabf-255151dd450mr3086794fac.4.1718219591278; Wed, 12 Jun 2024
 12:13:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZmmQLt7wB-yGQBTw@kekkonen.localdomain> <CAJZ5v0ii3WFQRPdfHeeW4M9kXSWDVxxxy02zThcf25mjNwqDAw@mail.gmail.com>
 <ZmmT56Cyvb2FCyav@kekkonen.localdomain> <CAJZ5v0hOBggQR_=uA3VuhruQnZihVxHHovpTz4=qfcbiSunsYw@mail.gmail.com>
 <ZmmY3he9vfWVWU3I@kekkonen.localdomain> <CAJZ5v0j7HTfg1wY+B+7vhE6tBKPVHMuu_MsFHjaLK70VS_cNEw@mail.gmail.com>
 <18cb82bb-51c6-4a52-80a4-6b1e3d95f99c@redhat.com> <CAJZ5v0je=Z+2LWv41OVwunujfTD7U2L9QDrNa7MoNBL+Chstnw@mail.gmail.com>
 <Zmnp8JbFj7ZoN5Vy@kekkonen.localdomain> <CAJZ5v0ie+OzJ5xd2g-j+pT=D20Ps__dA149XRnX8i9r4KKJ=ww@mail.gmail.com>
 <Zmnxy_8vxaNIJu_v@kekkonen.localdomain>
In-Reply-To: <Zmnxy_8vxaNIJu_v@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Jun 2024 21:12:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h4oF+QVk8VPb+roEjgTS1q0rG6g3STSDn9OgYz=4O6Ww@mail.gmail.com>
Message-ID: <CAJZ5v0h4oF+QVk8VPb+roEjgTS1q0rG6g3STSDn9OgYz=4O6Ww@mail.gmail.com>
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

On Wed, Jun 12, 2024 at 9:07=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Wed, Jun 12, 2024 at 08:41:43PM +0200, Rafael J. Wysocki wrote:
> > Hi Sakari,
> >
> > On Wed, Jun 12, 2024 at 8:33=E2=80=AFPM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Rafael,
> > >
> > > On Wed, Jun 12, 2024 at 05:26:46PM +0200, Rafael J. Wysocki wrote:
> > > > Hi,
> > > >
> > > > On Wed, Jun 12, 2024 at 4:30=E2=80=AFPM Hans de Goede <hdegoede@red=
hat.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On 6/12/24 3:06 PM, Rafael J. Wysocki wrote:
> > > > > > Hi Sakari,
> > > > > >
> > > > > > On Wed, Jun 12, 2024 at 2:47=E2=80=AFPM Sakari Ailus
> > > > > > <sakari.ailus@linux.intel.com> wrote:
> > > > > >>
> > > > > >> Hi Rafael,
> > > > > >>
> > > > > >> On Wed, Jun 12, 2024 at 02:32:26PM +0200, Rafael J. Wysocki wr=
ote:
> > > > > >>>>>>> I just hit the same problem on another Dell laptop. It se=
ems that
> > > > > >>>>>>> all Dell laptops with IPU6 camera from the Tiger Lake, Al=
der Lake
> > > > > >>>>>>> and Raptor Lake generations suffer from this problem.
> > > > > >>>>>>>
> > > > > >>>>>>> So instead of playing whack a mole with DMI matches we sh=
ould
> > > > > >>>>>>> simply disable ACPI MIPI DISCO support on all Dell laptop=
s
> > > > > >>>>>>> with those CPUs. I'm preparing a fix for this to replace
> > > > > >>>>>>> the DMI matching now.
> > > > > >>>>>>
> > > > > >>>>>> DisCo for Imaging support shouldn't be dropped on these sy=
stems, and this
> > > > > >>>>>> isn't what your patch does either. Instead the ACPI graph =
port nodes (as
> > > > > >>>>>> per Linux specific definitions) are simply dropped, i.e. t=
his isn't related
> > > > > >>>>>> to DisCo for Imaging at all.
> > > > > >>>>>
> > > > > >>>>> So it looks like the changelog of that patch could be impro=
ved, right?
> > > > > >>>>
> > > > > >>>> Well, yes. The reason the function is in the file is that ne=
arly all camera
> > > > > >>>> related parsing is located there, not that it would be relat=
ed to DisCo for
> > > > > >>>> Imaging as such.
> > > > > >>>
> > > > > >>> So IIUC the camera graph port nodes are created by default wi=
th the
> > > > > >>> help of the firmware-supplied information, but if that is def=
ective a
> > > > > >>> quirk can be added to skip the creation of those ports in whi=
ch case
> > > > > >>> they will be created elsewhere.
> > > > > >>>
> > > > > >>> Is this correct?
> > > > > >>
> > > > > >> Yes.
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
> > > > > That is a good question. The ACPI MIPI DISCO specification is an
> > > > > attempt standardize how MIPI cameras and their sensors are descri=
bed
> > > > > in ACPI.
> > > > >
> > > > > But this is not actually being used by any Windows drivers atm. T=
he windows
> > > > > drivers rely on their own custom ACPI data which gets translated =
into
> > > > > standard Linux device-properties by: drivers/media/pci/intel/ipu-=
bridge.c
> > > > >
> > > > > and so far AFAIK there are 0 laptops where there actually is 100%=
 functional
> > > > > ACPI MIPI information. I believe that some work is in place to ge=
t correct
> > > > > usable ACPI MIPI information in place in the ACPI tables of some =
Meteor Lake
> > > > > laptops. But I believe that there too it does not work yet with t=
he BIOS
> > > > > version with which current Windows models are shipping. It is bei=
ng fixed
> > > > > for systems which have Linux support from the vendor but I suspec=
t that
> > > > > on other models if ACPI MIPI DISCO information is there it will n=
ot
> > > > > necessarily be reliable because AFAICT Windows does not actually =
use it.
> > > > >
> > > > > And TBH this has me worried about camera support for Meteor Lake =
devices
> > > > > going forward. We really need to have 1 reliable source of truth =
here and
> > > > > using information which is ignored by Windows does not seem like =
the best
> > > > > source to use.
> > > > >
> > > > > Sakari I know you have been pushing for MIPI camera descriptions =
under
> > > > > ACPI to move to a standardized format and I can see how that is a=
 good
> > > > > thing, but atm it seems to mainly cause things to break and befor=
e
> > > > > the ACPI MIPI DISCO support landed in 6.8 we did not have these i=
ssues,
> > > > > since the information used by the ipu-bridge code does seem to be=
 correct.
> > > >
> > > > Well, if Windows doesn't use this information, it is almost guarant=
eed
> > > > to be garbage.
> > >
> > > No ACPI DSDT in production systems uses DisCo for Imaging as of now a=
t
> > > least to my knowledge.
> > >
> > > >
> > > > So maybe it would be better to make acpi_graph_ignore_port() return
> > > > true by default and false only when the information is known to be
> > > > valid.  IOW, whitelist things instead of adding blacklist entries i=
n
> > > > perpetuum.
> > >
> > > What could be gained from this?
> >
> > Generally speaking, fewer headaches for people trying to support Linux
> > on Intel client platforms.
>
> I don't think that is the case here.
>
> I'd like to reiterate that none of the issues there have been so far
> (including with Dell laptops) have been related to DisCo for Imaging.

Well, they were (or are) related to firmware issues that cause systems
to fail to boot if triggered until they get blacklisted in
acpi_graph_ignore_port().

It doesn't matter too much whether this is specifically DisCo for
Imaging or something else.

> >
> > Every system that needs to be put into dmi_ignore_port_nodes[] means a
> > boot problem for someone that needs to be addressed.
> >
> > And after the Hans' patch at
> >
> > https://patchwork.kernel.org/project/linux-acpi/patch/20240612104220.22=
219-1-hdegoede@redhat.com/
> >
> > we would effectively get very close to that point anyway.
>
> Dell systems only, and of a limited range.
>
> >
> > Are the ACPI tables on MTL and beyond going to be fixed?  If not,
> > we'll probably need to add MTL to the list of platform IDs and so on.
> > In what way is this better?
>
> This will very probably take place post-MTL.

So why don't we put MTL into the list in the Hans' patch?  Or are we
going to wait for someone to report a boot failure on MTL because of
this?

