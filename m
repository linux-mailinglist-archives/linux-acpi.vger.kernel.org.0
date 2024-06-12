Return-Path: <linux-acpi+bounces-6350-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E567905C05
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 21:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3956283BA2
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 19:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92403839F1;
	Wed, 12 Jun 2024 19:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjnYjxlf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632A382D89;
	Wed, 12 Jun 2024 19:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718220750; cv=none; b=AthpFkyqwDmQXaRGVIWDzc2NeyhQi38USW5J6TJkws/XZ51iQkfyxWvPe/E8yRHdl9BAfOzWZ+8EHou+O6rUeYEJU198IaSW5xtyY4Zw8TxgL6esvD99spFizWe3XXKiWb/9ao7nrlIDAjiJgN6rzCF3LzZAnYGL11mH3iaFrMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718220750; c=relaxed/simple;
	bh=QR8c5f02TI5g8J8fSmx11sXwM4j5nLkDKdis3kzTp+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UzdtYsLWl2B+rINnZxdKsqLi7Tkq8twgpCCX3Nk1uGA0zYGrBrs9hvHeEy+n5tAmEPRAa6r3ik1fzYUpJufOLXJajLLY+KJv+hos2bRWDDgy3edTj61bd+Uz+CFiDREstm1zCMKBZsXjBPQZehyNq+4LomVJ8PBGqC0N9kp5usY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjnYjxlf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1452AC4AF48;
	Wed, 12 Jun 2024 19:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718220750;
	bh=QR8c5f02TI5g8J8fSmx11sXwM4j5nLkDKdis3kzTp+o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sjnYjxlfVl1xZt47VGNfMxiq1u0HvNksHffve0JJG+nuIFETKBxdqri8er+j1Q07H
	 Q1CDgwoDlF7xMc4VT6uZR8QhKS4aFq4wZ1GcKP/MznqHNQXuPFRk3Hb3bLLqaTD6Xv
	 JdhZ+JtUEVosy8beYKUBtaQHxph9tgTm9nfvnrFGD7aBqMaB+IoXhMuX+s4sDxE4I7
	 5yV7MXiE4n7JkyicOrCgQvqA233+zk6qvpdolXnBTvR5NDsZCwtB4IYWB3fVQrt91m
	 7gXACXJung1HIU6Rvy8wSrUOV7vlemPbtEs/qfiZ7tHRF61VgZHdBsw0SW/aG25HCu
	 jYKIdGy601IoA==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d21a80b8ceso14247b6e.3;
        Wed, 12 Jun 2024 12:32:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWSID+bE/eRuMusT8WCFBNfXJi6zc7CZk9sdh6GPI6SggH5jukYk0fb/Rg0JfGO7TbVREW46W9gxy+OjCakxa2sfUbiY8/B6fOB4ATwMwR8TkR2+i+n0xlTsq877bKDrNl4Eiy500eA07GNoRkR5RTUJcNlGaw3xeHa48jIWVBGd3khjb6A
X-Gm-Message-State: AOJu0YyGM0aqnkbhBVmXmneeTuGRwbMkiYQni9wV36Gy7XGEFk+o462L
	qoQMmzQ8JHbQbFuA+sOH9OmDq2XnZnxBrQCHBtKZXAYrlOScIzOEA7VPcOXqcVGrogKYj+YijZ+
	bBANvc7I5+5phVYpLfp/IUugH1dc=
X-Google-Smtp-Source: AGHT+IEtjdaW5DWFBXlDhShavyc8gZ15mfMvcHQHIznkc3CYe2fZiBZfliG97AisJA+Yr8HSPZgaFdqF8yZmKxV3xpc=
X-Received: by 2002:a05:6871:741e:b0:254:d163:c3a9 with SMTP id
 586e51a60fabf-255147735a4mr3142253fac.0.1718220749332; Wed, 12 Jun 2024
 12:32:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZmmT56Cyvb2FCyav@kekkonen.localdomain> <CAJZ5v0hOBggQR_=uA3VuhruQnZihVxHHovpTz4=qfcbiSunsYw@mail.gmail.com>
 <ZmmY3he9vfWVWU3I@kekkonen.localdomain> <CAJZ5v0j7HTfg1wY+B+7vhE6tBKPVHMuu_MsFHjaLK70VS_cNEw@mail.gmail.com>
 <18cb82bb-51c6-4a52-80a4-6b1e3d95f99c@redhat.com> <CAJZ5v0je=Z+2LWv41OVwunujfTD7U2L9QDrNa7MoNBL+Chstnw@mail.gmail.com>
 <Zmnp8JbFj7ZoN5Vy@kekkonen.localdomain> <CAJZ5v0ie+OzJ5xd2g-j+pT=D20Ps__dA149XRnX8i9r4KKJ=ww@mail.gmail.com>
 <Zmnxy_8vxaNIJu_v@kekkonen.localdomain> <CAJZ5v0h4oF+QVk8VPb+roEjgTS1q0rG6g3STSDn9OgYz=4O6Ww@mail.gmail.com>
 <Zmn0UZ7A3gX_uMVf@kekkonen.localdomain>
In-Reply-To: <Zmn0UZ7A3gX_uMVf@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Jun 2024 21:32:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jtGSoqH1Syy4dDpPCWQ5ghT3K=ZWFxmXo6A+kpYEPxOQ@mail.gmail.com>
Message-ID: <CAJZ5v0jtGSoqH1Syy4dDpPCWQ5ghT3K=ZWFxmXo6A+kpYEPxOQ@mail.gmail.com>
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

On Wed, Jun 12, 2024 at 9:17=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Wed, Jun 12, 2024 at 09:12:59PM +0200, Rafael J. Wysocki wrote:
> > Hi Sakari,
> >
> > On Wed, Jun 12, 2024 at 9:07=E2=80=AFPM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Rafael,
> > >
> > > On Wed, Jun 12, 2024 at 08:41:43PM +0200, Rafael J. Wysocki wrote:
> > > > Hi Sakari,
> > > >
> > > > On Wed, Jun 12, 2024 at 8:33=E2=80=AFPM Sakari Ailus
> > > > <sakari.ailus@linux.intel.com> wrote:
> > > > >
> > > > > Hi Rafael,
> > > > >
> > > > > On Wed, Jun 12, 2024 at 05:26:46PM +0200, Rafael J. Wysocki wrote=
:
> > > > > > Hi,
> > > > > >
> > > > > > On Wed, Jun 12, 2024 at 4:30=E2=80=AFPM Hans de Goede <hdegoede=
@redhat.com> wrote:
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > On 6/12/24 3:06 PM, Rafael J. Wysocki wrote:
> > > > > > > > Hi Sakari,
> > > > > > > >
> > > > > > > > On Wed, Jun 12, 2024 at 2:47=E2=80=AFPM Sakari Ailus
> > > > > > > > <sakari.ailus@linux.intel.com> wrote:
> > > > > > > >>
> > > > > > > >> Hi Rafael,
> > > > > > > >>
> > > > > > > >> On Wed, Jun 12, 2024 at 02:32:26PM +0200, Rafael J. Wysock=
i wrote:
> > > > > > > >>>>>>> I just hit the same problem on another Dell laptop. I=
t seems that
> > > > > > > >>>>>>> all Dell laptops with IPU6 camera from the Tiger Lake=
, Alder Lake
> > > > > > > >>>>>>> and Raptor Lake generations suffer from this problem.
> > > > > > > >>>>>>>
> > > > > > > >>>>>>> So instead of playing whack a mole with DMI matches w=
e should
> > > > > > > >>>>>>> simply disable ACPI MIPI DISCO support on all Dell la=
ptops
> > > > > > > >>>>>>> with those CPUs. I'm preparing a fix for this to repl=
ace
> > > > > > > >>>>>>> the DMI matching now.
> > > > > > > >>>>>>
> > > > > > > >>>>>> DisCo for Imaging support shouldn't be dropped on thes=
e systems, and this
> > > > > > > >>>>>> isn't what your patch does either. Instead the ACPI gr=
aph port nodes (as
> > > > > > > >>>>>> per Linux specific definitions) are simply dropped, i.=
e. this isn't related
> > > > > > > >>>>>> to DisCo for Imaging at all.
> > > > > > > >>>>>
> > > > > > > >>>>> So it looks like the changelog of that patch could be i=
mproved, right?
> > > > > > > >>>>
> > > > > > > >>>> Well, yes. The reason the function is in the file is tha=
t nearly all camera
> > > > > > > >>>> related parsing is located there, not that it would be r=
elated to DisCo for
> > > > > > > >>>> Imaging as such.
> > > > > > > >>>
> > > > > > > >>> So IIUC the camera graph port nodes are created by defaul=
t with the
> > > > > > > >>> help of the firmware-supplied information, but if that is=
 defective a
> > > > > > > >>> quirk can be added to skip the creation of those ports in=
 which case
> > > > > > > >>> they will be created elsewhere.
> > > > > > > >>>
> > > > > > > >>> Is this correct?
> > > > > > > >>
> > > > > > > >> Yes.
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
> > > > > > > That is a good question. The ACPI MIPI DISCO specification is=
 an
> > > > > > > attempt standardize how MIPI cameras and their sensors are de=
scribed
> > > > > > > in ACPI.
> > > > > > >
> > > > > > > But this is not actually being used by any Windows drivers at=
m. The windows
> > > > > > > drivers rely on their own custom ACPI data which gets transla=
ted into
> > > > > > > standard Linux device-properties by: drivers/media/pci/intel/=
ipu-bridge.c
> > > > > > >
> > > > > > > and so far AFAIK there are 0 laptops where there actually is =
100% functional
> > > > > > > ACPI MIPI information. I believe that some work is in place t=
o get correct
> > > > > > > usable ACPI MIPI information in place in the ACPI tables of s=
ome Meteor Lake
> > > > > > > laptops. But I believe that there too it does not work yet wi=
th the BIOS
> > > > > > > version with which current Windows models are shipping. It is=
 being fixed
> > > > > > > for systems which have Linux support from the vendor but I su=
spect that
> > > > > > > on other models if ACPI MIPI DISCO information is there it wi=
ll not
> > > > > > > necessarily be reliable because AFAICT Windows does not actua=
lly use it.
> > > > > > >
> > > > > > > And TBH this has me worried about camera support for Meteor L=
ake devices
> > > > > > > going forward. We really need to have 1 reliable source of tr=
uth here and
> > > > > > > using information which is ignored by Windows does not seem l=
ike the best
> > > > > > > source to use.
> > > > > > >
> > > > > > > Sakari I know you have been pushing for MIPI camera descripti=
ons under
> > > > > > > ACPI to move to a standardized format and I can see how that =
is a good
> > > > > > > thing, but atm it seems to mainly cause things to break and b=
efore
> > > > > > > the ACPI MIPI DISCO support landed in 6.8 we did not have the=
se issues,
> > > > > > > since the information used by the ipu-bridge code does seem t=
o be correct.
> > > > > >
> > > > > > Well, if Windows doesn't use this information, it is almost gua=
ranteed
> > > > > > to be garbage.
> > > > >
> > > > > No ACPI DSDT in production systems uses DisCo for Imaging as of n=
ow at
> > > > > least to my knowledge.
> > > > >
> > > > > >
> > > > > > So maybe it would be better to make acpi_graph_ignore_port() re=
turn
> > > > > > true by default and false only when the information is known to=
 be
> > > > > > valid.  IOW, whitelist things instead of adding blacklist entri=
es in
> > > > > > perpetuum.
> > > > >
> > > > > What could be gained from this?
> > > >
> > > > Generally speaking, fewer headaches for people trying to support Li=
nux
> > > > on Intel client platforms.
> > >
> > > I don't think that is the case here.
> > >
> > > I'd like to reiterate that none of the issues there have been so far
> > > (including with Dell laptops) have been related to DisCo for Imaging.
> >
> > Well, they were (or are) related to firmware issues that cause systems
> > to fail to boot if triggered until they get blacklisted in
> > acpi_graph_ignore_port().
>
> This is the first time I hear about a boot failure due to incorrect camer=
a
> description (on production systems). Could you point me to where this has
> happened?

https://lore.kernel.org/lkml/8afe9391b96ff3e1c60e624c1b8a3b2bd5039560.camel=
@sapience.com/

or is it not a boot failure?  If so, apologies for misunderstanding.

Looks serious enough to me though.

