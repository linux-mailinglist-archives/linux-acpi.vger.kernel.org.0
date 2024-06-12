Return-Path: <linux-acpi+bounces-6328-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2B6905281
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 14:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C9B31C20F75
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 12:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A8916F904;
	Wed, 12 Jun 2024 12:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnheAkDO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF3316E881;
	Wed, 12 Jun 2024 12:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195559; cv=none; b=aTbiah3fLlu5Vqorg3IBRurwn4DGoCAO0ariOquizCFjfXHmnbWLHAUTLciTSqzw19/9/YPT9DIZi8wr61ZPemacx+PIbv7weghr3nayXJ3C6+ilAmRO6UR+V0jTmaLEYHY2q/0gb6rDMH2Pu/wqBqtM59TrlE+vdJMVBWQoGe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195559; c=relaxed/simple;
	bh=aWxvhXYl7WmnMjLN+jrZVKd1UIrUjxzDb4m7CnLQOOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CoFl1fbBNuawuBrcHzZpgsCE0kYlabkZcomqMICe1Nz1y80dZ1vi8fre4+ZCa1uvWpMKiMVpe4bUQ9qvRFWZmaB0adx0uyVpORkEcRYh+83LohMa6O782I3+2hyIZUHwNeYiHknlzQC04RY3CGElYoq0s3vbCYBp6ELZImXsEcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnheAkDO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E124C4AF50;
	Wed, 12 Jun 2024 12:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718195559;
	bh=aWxvhXYl7WmnMjLN+jrZVKd1UIrUjxzDb4m7CnLQOOU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TnheAkDOGi/SsNTCy3x3FKkyGg08XeOq97xfAQaJLgZL2epochTQojtfStMQcrALo
	 rS+lk3oP4+qUsLwzOJk5EjvsAKTO+F3l24UOkHUssFOFm5BuqWd76rsqUwwBAvAHIv
	 QUpo0dpL7r+TSjWKxJKIf05x6kzKmhAQnCEdoyVqB0RvdIhTRH2hljaEzRsrlsZC2T
	 b0q0MSKLCnwI2D6szNnbhmIIz9LedOP1YGZDgXIDSLxD83oWSnBkltAexdeoIbjDyy
	 60IcGqaoLNB2ID1Nz5rsNY2BnA+p5WU0OjYEC2hvMvTecwq32B5JwjsMQ5fObhSNq7
	 hi6R9KKrwui/A==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-24c5ec50da1so345417fac.3;
        Wed, 12 Jun 2024 05:32:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVEKAeCqspMuFThPbSnXHoIeNTnvjQXcrhCOCMQQd6I/p+UoJOKWIawCE41vTD2Rp5HbDPVqsh3JJba@vger.kernel.org, AJvYcCVOlZyFjb0D9+xMUF/kJmYmoPNB45ct/R04Lilj9PQZQflDkcjHg9vi9AyysEpQmZEtizggYGvZPPOuV3o=@vger.kernel.org, AJvYcCXwCjz9z02kcSu09eHHdoiR83mjyl/rG0YuexD1P3j5ifA1ppE9I6HiA6XSACj0OQZL74TjlnshgkH9bFbU@vger.kernel.org
X-Gm-Message-State: AOJu0YwTkJc3Yl/WLmn1ezMIXZ+qPTYk9I0gWQOPr3bz20BpkXYOJA4Z
	jtOdtpDWUeLUezzLo+ekAGo+n4g9iXK4CA4UqhO/SMgD80xxJiuoyC0aN0kMO4QK6925+4/jJd1
	gsLW+6N2jzIEy3rmQ51REeBqgHnM=
X-Google-Smtp-Source: AGHT+IFR8h0kytuWOp+ktZ19InJGNg+BPq/zkCFx41afNMr9L2B+GaQBgE3iUq8bHh3fiOtf9oFxvOGgoDjfdriaCOY=
X-Received: by 2002:a05:6870:658d:b0:24f:cabc:4fa3 with SMTP id
 586e51a60fabf-255147c7724mr1817288fac.0.1718195558086; Wed, 12 Jun 2024
 05:32:38 -0700 (PDT)
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
 <ZmmT56Cyvb2FCyav@kekkonen.localdomain>
In-Reply-To: <ZmmT56Cyvb2FCyav@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Jun 2024 14:32:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hOBggQR_=uA3VuhruQnZihVxHHovpTz4=qfcbiSunsYw@mail.gmail.com>
Message-ID: <CAJZ5v0hOBggQR_=uA3VuhruQnZihVxHHovpTz4=qfcbiSunsYw@mail.gmail.com>
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

On Wed, Jun 12, 2024 at 2:26=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Wed, Jun 12, 2024 at 02:21:51PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jun 12, 2024 at 2:10=E2=80=AFPM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Hans,
> > >
> > > Just read this discussion, too...
> > >
> > > On Wed, Jun 12, 2024 at 12:08:49PM +0200, Hans de Goede wrote:
> > > > Hi,
> > > >
> > > > On 6/6/24 8:12 PM, Hans de Goede wrote:
> > > > > Hi,
> > > > >
> > > > > +To: Rafael since this was Cc-ed to linux-acpi but never send
> > > > > to Rafael directly.
> > > > >
> > > > > Rafael this fixes a crash in 6.10-rc1 for some users and is neces=
sary
> > > > > to make the cameras work on the Dell XPS 13 plus 9320 .
> > > > >
> > > > > On 5/28/24 7:09 PM, Hans de Goede wrote:
> > > > >> Hi Sakari,
> > > > >>
> > > > >> On 5/28/24 10:44 AM, Sakari Ailus wrote:
> > > > >>> Ignore camera related graph port nodes on Dell XPS 9320. They d=
ata in BIOS
> > > > >>> is buggy, just like it is for Dell XPS 9315. The corresponding =
software
> > > > >>> nodes are created by the ipu-bridge.
> > > > >>>
> > > > >>> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > >>> ---
> > > > >>> Hi,
> > > > >>>
> > > > >>> Could you test this and see whether it fixes the warning?
> > > > >>>
> > > > >>> The camera might work with this change, too.
> > > > >>
> > > > >> Thank you I just received a Dell XPS 13 plus 9320 myself to use
> > > > >> for VSC testing and I can confirm that with this patch 6.10.0-rc=
1
> > > > >> works, including giving a picture with the libcamera software IS=
P +
> > > > >> 3 small libcamera patches.
> > > > >
> > > > > I forgot to add:
> > > > >
> > > > > Tested-by: Hans de Goede <hdegoede@redhat.com>
> > > > > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > > >
> > > > I just hit the same problem on another Dell laptop. It seems that
> > > > all Dell laptops with IPU6 camera from the Tiger Lake, Alder Lake
> > > > and Raptor Lake generations suffer from this problem.
> > > >
> > > > So instead of playing whack a mole with DMI matches we should
> > > > simply disable ACPI MIPI DISCO support on all Dell laptops
> > > > with those CPUs. I'm preparing a fix for this to replace
> > > > the DMI matching now.
> > >
> > > DisCo for Imaging support shouldn't be dropped on these systems, and =
this
> > > isn't what your patch does either. Instead the ACPI graph port nodes =
(as
> > > per Linux specific definitions) are simply dropped, i.e. this isn't r=
elated
> > > to DisCo for Imaging at all.
> >
> > So it looks like the changelog of that patch could be improved, right?
>
> Well, yes. The reason the function is in the file is that nearly all came=
ra
> related parsing is located there, not that it would be related to DisCo f=
or
> Imaging as such.

So IIUC the camera graph port nodes are created by default with the
help of the firmware-supplied information, but if that is defective a
quirk can be added to skip the creation of those ports in which case
they will be created elsewhere.

Is this correct?

