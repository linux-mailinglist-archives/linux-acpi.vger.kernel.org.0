Return-Path: <linux-acpi+bounces-6345-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B33C905BAC
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 21:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6020A1C231D3
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 19:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F421824A4;
	Wed, 12 Jun 2024 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tp+/ReVB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309B22F3B;
	Wed, 12 Jun 2024 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718219242; cv=none; b=is1F+Ymb5Y4dmSirjsY1lMw4LqfwQqR+29srd4rs/9KS0aGJ0aVSNMVyQT+sXXB3LLOCZyJmxaY6jfiUQ8cC7xu/0i6Podrgxa1a8qDf8K7p/BMGzdqMcFmC2OM5dwSsmpBdwK5h6I8ApCsNjjdgoLiMz7+4IRuJfyCm0ZvzzdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718219242; c=relaxed/simple;
	bh=co3JLRVjCdgIMVek7zva2k02tHosLsHbny7zqnwE6UM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VqKVCmeL+xP5tsUpeOGDJybGs7qx4xFx8R4pOVlIXgOgyETwWfpaXss/CO3R28wY82+byJk6dipoMXzvVygxo1pmi+++9D0eB3PztT5YlULcAixTXVPClfBV5wA5zstrfFOW3HRQQ6lg7oaSvU7GoCm0vzA6AGkhYcNvwmkoQVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tp+/ReVB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0698C116B1;
	Wed, 12 Jun 2024 19:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718219241;
	bh=co3JLRVjCdgIMVek7zva2k02tHosLsHbny7zqnwE6UM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Tp+/ReVBLeZqSTlO4XqIY2FqWn5Vsqw50lcbJijpkOcw3OQ+1OtB2Fgm0cZEYnm7m
	 6RqCLfKwW33/W4+sObF8o5Gq/mctFI+sCCdz4gmP6x4ByBL3kVDlOgyJK6T4NwiN5m
	 EjPRWveoElkbL8pwH0NHcbfmg3GjhZiWfU17Pu6K0BrFcpe07LMpqm/omex1/G/dO4
	 J8E3G396HVLF6DlRHwcbbqbgSH3logQ5nFjtuJdtx4n5CaEjAEO67ctVLOX2lyYlMZ
	 l14QBOUjEwpQnBE50CcXlphrtilYYnCW+tXRZHNokZyQfC/i7HfENo/0h2NrEqqtPy
	 1JnJlHnD9HnCg==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-254c411d816so18395fac.1;
        Wed, 12 Jun 2024 12:07:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVO722AeLRgMQl1ZXx1qlc+VfYXIbAQu7Vdei4poO2tFrxH3RzsqdDJUaE776G7AI31UihGbwpqFJYsaDGFj0zJGhWmJE8YgLLRqWGlKaISR6CJ6mVsKI8B/uGMeUkQMvtKhZ9iyVOhdPsUQ8wX+dAPArDFwnkskZ73I92YPd703UoKkyaa
X-Gm-Message-State: AOJu0YwgaYqtwo6CylGVXS6DuDTAzWc8igtAr1ZknvSA4gpoJ+/TWJAw
	vxzjWCYR4uXRCsM5TP3Cl7e5IVpHhPod3orir1z369HL7Q97x4+dwsmkMRZmGmyAXHK/d9VCmBe
	aaw3HG/wcvKZ+bg4N9niz6ZNr01w=
X-Google-Smtp-Source: AGHT+IFItMnUdPUbzCp7/fLhP868kZPpu6NJZIO1tWGUVf5eLGfN/RSjuQs2QGDFWC26hZYDuYNeT2t7pyexWRnXb/E=
X-Received: by 2002:a05:6870:e2cc:b0:255:1fea:340d with SMTP id
 586e51a60fabf-2551fea40d9mr1841541fac.0.1718219241080; Wed, 12 Jun 2024
 12:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a05df025-a0be-49cd-84a9-7d7fb2eeb33e@redhat.com>
 <e9062095-b312-44df-a9e3-0b09f3ec9eff@redhat.com> <4b387b4d-f778-4891-9f07-df5fc0a093cd@redhat.com>
 <ZmmQLt7wB-yGQBTw@kekkonen.localdomain> <CAJZ5v0ii3WFQRPdfHeeW4M9kXSWDVxxxy02zThcf25mjNwqDAw@mail.gmail.com>
 <ZmmT56Cyvb2FCyav@kekkonen.localdomain> <CAJZ5v0hOBggQR_=uA3VuhruQnZihVxHHovpTz4=qfcbiSunsYw@mail.gmail.com>
 <ZmmY3he9vfWVWU3I@kekkonen.localdomain> <CAJZ5v0j7HTfg1wY+B+7vhE6tBKPVHMuu_MsFHjaLK70VS_cNEw@mail.gmail.com>
 <18cb82bb-51c6-4a52-80a4-6b1e3d95f99c@redhat.com> <20240612143956.GN28989@pendragon.ideasonboard.com>
In-Reply-To: <20240612143956.GN28989@pendragon.ideasonboard.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Jun 2024 21:07:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hFYSQic3N2KWGzyrX-K4KX9Okt20NtXmqRuutc140HUw@mail.gmail.com>
Message-ID: <CAJZ5v0hFYSQic3N2KWGzyrX-K4KX9Okt20NtXmqRuutc140HUw@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: scan: Ignore Dell XPS 9320 camera graph port nodes
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Genes Lists <lists@sapience.com>, 
	linux-kernel@vger.kernel.org, mchehab@kernel.org, hverkuil-cisco@xs4all.nl, 
	wentong.wu@intel.com, linux-media@vger.kernel.org, linux-acpi@vger.kernel.org, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

On Wed, Jun 12, 2024 at 4:40=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Wed, Jun 12, 2024 at 04:30:30PM +0200, Hans de Goede wrote:
> > On 6/12/24 3:06 PM, Rafael J. Wysocki wrote:
> > > On Wed, Jun 12, 2024 at 2:47=E2=80=AFPM Sakari Ailus wrote:
> > >> On Wed, Jun 12, 2024 at 02:32:26PM +0200, Rafael J. Wysocki wrote:
> > >>>>>>> I just hit the same problem on another Dell laptop. It seems th=
at
> > >>>>>>> all Dell laptops with IPU6 camera from the Tiger Lake, Alder La=
ke
> > >>>>>>> and Raptor Lake generations suffer from this problem.
> > >>>>>>>
> > >>>>>>> So instead of playing whack a mole with DMI matches we should
> > >>>>>>> simply disable ACPI MIPI DISCO support on all Dell laptops
> > >>>>>>> with those CPUs. I'm preparing a fix for this to replace
> > >>>>>>> the DMI matching now.
> > >>>>>>
> > >>>>>> DisCo for Imaging support shouldn't be dropped on these systems,=
 and this
> > >>>>>> isn't what your patch does either. Instead the ACPI graph port n=
odes (as
> > >>>>>> per Linux specific definitions) are simply dropped, i.e. this is=
n't related
> > >>>>>> to DisCo for Imaging at all.
> > >>>>>
> > >>>>> So it looks like the changelog of that patch could be improved, r=
ight?
> > >>>>
> > >>>> Well, yes. The reason the function is in the file is that nearly a=
ll camera
> > >>>> related parsing is located there, not that it would be related to =
DisCo for
> > >>>> Imaging as such.
> > >>>
> > >>> So IIUC the camera graph port nodes are created by default with the
> > >>> help of the firmware-supplied information, but if that is defective=
 a
> > >>> quirk can be added to skip the creation of those ports in which cas=
e
> > >>> they will be created elsewhere.
> > >>>
> > >>> Is this correct?
> > >>
> > >> Yes.
> > >
> > > So it would be good to add a comment to this effect to
> > > acpi_nondev_subnode_extract() where acpi_graph_ignore_port() is
> > > called.
> > >
> > > And there is a somewhat tangential question that occurred to me: If
> > > the nodes are created elsewhere when acpi_graph_ignore_port() is true=
,
> > > why is it necessary to consult the platform firmware for the
> > > information on them at all?  Wouldn't it be better to simply always
> > > create them elsewhere?
> >
> > That is a good question. The ACPI MIPI DISCO specification is an
> > attempt standardize how MIPI cameras and their sensors are described
> > in ACPI.
> >
> > But this is not actually being used by any Windows drivers atm. The win=
dows
> > drivers rely on their own custom ACPI data which gets translated into
> > standard Linux device-properties by: drivers/media/pci/intel/ipu-bridge=
.c
> >
> > and so far AFAIK there are 0 laptops where there actually is 100% funct=
ional
> > ACPI MIPI information. I believe that some work is in place to get corr=
ect
> > usable ACPI MIPI information in place in the ACPI tables of some Meteor=
 Lake
> > laptops. But I believe that there too it does not work yet with the BIO=
S
> > version with which current Windows models are shipping. It is being fix=
ed
> > for systems which have Linux support from the vendor but I suspect that
>
> I think it's shipped in Chrome Books. Sakari can confirm.
>
> > on other models if ACPI MIPI DISCO information is there it will not
> > necessarily be reliable because AFAICT Windows does not actually use it=
.
> >
> > And TBH this has me worried about camera support for Meteor Lake device=
s
> > going forward. We really need to have 1 reliable source of truth here a=
nd
> > using information which is ignored by Windows does not seem like the be=
st
> > source to use.
>
> As long as the Windows drivers don't use the ACPI data that Linux uses,
> you can be 100% sure it will be wrong. That will never be fixed if Intel
> doesn't address the issue on their side, and effort we would put in
> standardizing that data for machines shipped by Windows OEMs is a waste
> of time in my opinion. Our only option, given Intel's failure, is to
> keep reverse-engineering camera support per machine for the time being
> (sometimes with the help of OEMs).

So while I kind of agree with you on the technical side (as you can
see from my messages in this thread), there is one thing in the above
paragraph that I need to react to.

Namely, both I and Sakari are Intel employees.  Do you think or are
you suggesting that we are somehow responsible for this failure?
Because I personally don't think like I have anything to do with it.

What do you mean, specifically, by saying "if Intel doesn't address
the issue on their side"?  And who at Intel do I need to talk to about
this?

