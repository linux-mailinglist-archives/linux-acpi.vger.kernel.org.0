Return-Path: <linux-acpi+bounces-6330-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F145905345
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 15:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A216A1C24313
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 13:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD81178398;
	Wed, 12 Jun 2024 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9q3FErm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7AC178371;
	Wed, 12 Jun 2024 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718197626; cv=none; b=eaVSYOsjFMmX3T0HdqJAQOmiauDOTaPmT65LhrRViMePmJKGlFvFw1dNaat+mPMChm7fanx8ylQjm39Ymf9x4bx1dEu1jokJrM17pXJFa+CHg2LqeowwsGvhhnSSmyBzqegv3NCR9ak/4LrJVFxAiDjyR5m0sUR0TaCAzf/hAKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718197626; c=relaxed/simple;
	bh=lrnihvvSZGrimK51z8Vm3UHgRlphb++nLv3/ylgKNfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opzg1kzwOEf/nrxe4tBtXQi2TfQJM8fFHOTOulE33JP7rae6efZG05bHFTU3jKy2iz8BBXumZ1zd9Kb5FWjGYSBLKl4LYZlarCazmvYydrHvfLvD1wHU4Y13qr5QBLsyjhmw2VZWiRyLLqOZjY6WNMYf+KDjoDib/LfucovYYR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9q3FErm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B589CC3277B;
	Wed, 12 Jun 2024 13:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718197625;
	bh=lrnihvvSZGrimK51z8Vm3UHgRlphb++nLv3/ylgKNfc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k9q3FErmOKe1Ln+6Cp+StYEfhRBxizkoiwwI2eP3R3E4vXx3zre20LdsqyrtR4uHx
	 fBqP1BpWc0hKVR7rv1ue8V8l82FMYJalpca8MxpBIqvUlGWxK/kilQtf27jrpYH7Vc
	 EaJRFzBBoGirVZTJRClKLVtYy7BRmNSN+wM8WHVDFclvdAQ1swmYgVUkD+hf0u92Ay
	 +oYRNKnj92loSJIoCxUlDIWVgqPnl6TEoxAn6DbR9Sn9kPcvhv03joZzT+DXwujbr6
	 emMSdJ5dU8sQpdEvjl/A7hidCDITN6mHE1DsCgBgCB/QU6SRViEtTRs2KBkudTwb/I
	 szBvkQbiuz3Fg==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-250aa23752dso161029fac.3;
        Wed, 12 Jun 2024 06:07:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXNVLP6dRr1U13qSvuq9BiudSIN5Z+EvdLZobDU+skx6j3Hoee35ZWxVZaBON713CDgYodE2OKDB665uhfOLjh6iLNKgTWdGaRqVtVaIXffHrw4GhGMpPxE8/pf1Os3nbnnzaBs3ibAbFYEc+DGoeQGpBTyP6g8MQQO2zBVyQXvLtrsuL7k
X-Gm-Message-State: AOJu0YzG256pg6zgChOMG9M+QJH2wgdo1eKkzNuDEDocT49MjkME1sK3
	AZYVnnrrzHfokKO9e02w4kXFLIAi91AXtlIpLNQi/6dXQDafoDusYwcBRBuXLPst/NwEeS/Lwxf
	s//Z1MQnCLlPk3hPvGd+FTB5c5fo=
X-Google-Smtp-Source: AGHT+IF431IDCkOjmZOkN3CBMg6hR6xYBKiQoefnw+Svnx7rCZVovTxZqpP09929qkpZmQGbMmtJ/5AlDGikX6/r2nI=
X-Received: by 2002:a05:6871:4e91:b0:24f:ddd5:a21d with SMTP id
 586e51a60fabf-255151f70fcmr1871165fac.5.1718197625087; Wed, 12 Jun 2024
 06:07:05 -0700 (PDT)
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
 <ZmmY3he9vfWVWU3I@kekkonen.localdomain>
In-Reply-To: <ZmmY3he9vfWVWU3I@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Jun 2024 15:06:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j7HTfg1wY+B+7vhE6tBKPVHMuu_MsFHjaLK70VS_cNEw@mail.gmail.com>
Message-ID: <CAJZ5v0j7HTfg1wY+B+7vhE6tBKPVHMuu_MsFHjaLK70VS_cNEw@mail.gmail.com>
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

On Wed, Jun 12, 2024 at 2:47=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Wed, Jun 12, 2024 at 02:32:26PM +0200, Rafael J. Wysocki wrote:
> > > > > > I just hit the same problem on another Dell laptop. It seems th=
at
> > > > > > all Dell laptops with IPU6 camera from the Tiger Lake, Alder La=
ke
> > > > > > and Raptor Lake generations suffer from this problem.
> > > > > >
> > > > > > So instead of playing whack a mole with DMI matches we should
> > > > > > simply disable ACPI MIPI DISCO support on all Dell laptops
> > > > > > with those CPUs. I'm preparing a fix for this to replace
> > > > > > the DMI matching now.
> > > > >
> > > > > DisCo for Imaging support shouldn't be dropped on these systems, =
and this
> > > > > isn't what your patch does either. Instead the ACPI graph port no=
des (as
> > > > > per Linux specific definitions) are simply dropped, i.e. this isn=
't related
> > > > > to DisCo for Imaging at all.
> > > >
> > > > So it looks like the changelog of that patch could be improved, rig=
ht?
> > >
> > > Well, yes. The reason the function is in the file is that nearly all =
camera
> > > related parsing is located there, not that it would be related to Dis=
Co for
> > > Imaging as such.
> >
> > So IIUC the camera graph port nodes are created by default with the
> > help of the firmware-supplied information, but if that is defective a
> > quirk can be added to skip the creation of those ports in which case
> > they will be created elsewhere.
> >
> > Is this correct?
>
> Yes.

So it would be good to add a comment to this effect to
acpi_nondev_subnode_extract() where acpi_graph_ignore_port() is
called.

And there is a somewhat tangential question that occurred to me: If
the nodes are created elsewhere when acpi_graph_ignore_port() is true,
why is it necessary to consult the platform firmware for the
information on them at all?  Wouldn't it be better to simply always
create them elsewhere?

