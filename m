Return-Path: <linux-acpi+bounces-6326-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F07D90524E
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 14:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B5C7B216FB
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 12:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8F716F85A;
	Wed, 12 Jun 2024 12:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIuPn1wQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D419816F821;
	Wed, 12 Jun 2024 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718194923; cv=none; b=jzTpNRKfdhJ8o8zG7cLb8ZjPYOoFjCf0XO4I9dKZSOXm4E1LI4Dz1aOdXlIOrYy6FNd/HcnoMnF0BuMiwU8QLMYCNJoauvrcbtfeTnSUvHVuU0Tz9ZsliLnKq2qpwDkrRdySNzURzjrhLr0SjziyIPEh5W31dmACzOM1KF1jK6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718194923; c=relaxed/simple;
	bh=ehkqEWvAkeJfmZ4FyFkMj8Vh0L124tfLTeLX6PfTy54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZuFv2i+3562vikd/Ay8J3RScN6lO65V2E+atp35Ng7i564/HbAHwtRx8MUNZaapgMGasK6zQ0Xq2AnYlnp820D1jmp0vrsy7Uhg+bM8Tud2yiXU9oGvd625DKJNyGTTnTLFbebJjXt21yLeEjkrwnJN1cFkSxlmhwb170pApT3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIuPn1wQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5040EC4AF1A;
	Wed, 12 Jun 2024 12:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718194923;
	bh=ehkqEWvAkeJfmZ4FyFkMj8Vh0L124tfLTeLX6PfTy54=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IIuPn1wQecGDJEZos5zhc5U/CUN/f10tGrvJdYvfromI8GipoXof4yJkzQnvlm4V4
	 2wVWWR7wO7wIU2YoONeUPqmMB5CWFOSO69zcverOx6wWiBBsSY78+vEgtBq+xKX1bH
	 IpeOFKyZEy3pGyqFOyLpTK7oQ5sJGZEBAt8QtD04ujut0Im5CTcOAFyyQNnC0AxfhA
	 DUYtYjCx51ALgnDGkq1FwXI6W97899x9ocBqQ+ZnOBYnRoKcSD70sec0qMDv9TMxBj
	 UQira4ohkX4drf37hdhZenUlj5qC8Pomey2oFWHFzCq59kkNByY4dpb1azSqBF3160
	 4EXxYbP2AkzLA==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-250aa23752dso156467fac.3;
        Wed, 12 Jun 2024 05:22:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURawYyLGJbcuhW3BBVWnjJHx67RcTGJ69go5I1B+79VwQUxs7EqlGz+DO22YEjNKItI458VxhWezH4DWNi@vger.kernel.org, AJvYcCV41aZH0Vgrwy9sKB4N22gjSmM3rt9cMiuqoi/B6H+lHLwQ0omO+inIYP4iArqdMx659BcYUK4dlsyP@vger.kernel.org, AJvYcCVp+mwegA9vHDjimIArLj8U/XWuAGrLYQyhDSyDKJRZLiBe89b0L42QU0UkAoADWG8hXDqzWSqcG1dbIKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YykExmaYEoGJx7GLsPBdDsgNGpzTcfgH9dR/ysQw/5aSAFasWKk
	hGAHpjkElzuMbF1ltgVWG+RTXeL89YISGq42ijaZmVWO0b5Nc5t82Rdaffxeq7HUJWQQbKQ9xqY
	+2nxZZE16Q8SXNTJ9l6CYa0pMfu4=
X-Google-Smtp-Source: AGHT+IHtRvOSNUNNtGcHZ7XGYRODDzrIhjFAMbzw/b4fUlFJog7eYZaN5tqqQUQafgkRRyodYtIxWh71Rb8Cz4ZcVfA=
X-Received: by 2002:a05:6870:b489:b0:24f:bd2f:28d0 with SMTP id
 586e51a60fabf-25514779302mr1839574fac.0.1718194922609; Wed, 12 Jun 2024
 05:22:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <988e48090982c89ce0c906954832fdfb09a1ce34.camel@sapience.com>
 <20240528084413.2624435-1-sakari.ailus@linux.intel.com> <a05df025-a0be-49cd-84a9-7d7fb2eeb33e@redhat.com>
 <e9062095-b312-44df-a9e3-0b09f3ec9eff@redhat.com> <4b387b4d-f778-4891-9f07-df5fc0a093cd@redhat.com>
 <ZmmQLt7wB-yGQBTw@kekkonen.localdomain>
In-Reply-To: <ZmmQLt7wB-yGQBTw@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Jun 2024 14:21:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ii3WFQRPdfHeeW4M9kXSWDVxxxy02zThcf25mjNwqDAw@mail.gmail.com>
Message-ID: <CAJZ5v0ii3WFQRPdfHeeW4M9kXSWDVxxxy02zThcf25mjNwqDAw@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: scan: Ignore Dell XPS 9320 camera graph port nodes
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Genes Lists <lists@sapience.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, mchehab@kernel.org, 
	hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com, 
	wentong.wu@intel.com, linux-media@vger.kernel.org, linux-acpi@vger.kernel.org, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 2:10=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Hans,
>
> Just read this discussion, too...
>
> On Wed, Jun 12, 2024 at 12:08:49PM +0200, Hans de Goede wrote:
> > Hi,
> >
> > On 6/6/24 8:12 PM, Hans de Goede wrote:
> > > Hi,
> > >
> > > +To: Rafael since this was Cc-ed to linux-acpi but never send
> > > to Rafael directly.
> > >
> > > Rafael this fixes a crash in 6.10-rc1 for some users and is necessary
> > > to make the cameras work on the Dell XPS 13 plus 9320 .
> > >
> > > On 5/28/24 7:09 PM, Hans de Goede wrote:
> > >> Hi Sakari,
> > >>
> > >> On 5/28/24 10:44 AM, Sakari Ailus wrote:
> > >>> Ignore camera related graph port nodes on Dell XPS 9320. They data =
in BIOS
> > >>> is buggy, just like it is for Dell XPS 9315. The corresponding soft=
ware
> > >>> nodes are created by the ipu-bridge.
> > >>>
> > >>> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > >>> ---
> > >>> Hi,
> > >>>
> > >>> Could you test this and see whether it fixes the warning?
> > >>>
> > >>> The camera might work with this change, too.
> > >>
> > >> Thank you I just received a Dell XPS 13 plus 9320 myself to use
> > >> for VSC testing and I can confirm that with this patch 6.10.0-rc1
> > >> works, including giving a picture with the libcamera software ISP +
> > >> 3 small libcamera patches.
> > >
> > > I forgot to add:
> > >
> > > Tested-by: Hans de Goede <hdegoede@redhat.com>
> > > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> >
> > I just hit the same problem on another Dell laptop. It seems that
> > all Dell laptops with IPU6 camera from the Tiger Lake, Alder Lake
> > and Raptor Lake generations suffer from this problem.
> >
> > So instead of playing whack a mole with DMI matches we should
> > simply disable ACPI MIPI DISCO support on all Dell laptops
> > with those CPUs. I'm preparing a fix for this to replace
> > the DMI matching now.
>
> DisCo for Imaging support shouldn't be dropped on these systems, and this
> isn't what your patch does either. Instead the ACPI graph port nodes (as
> per Linux specific definitions) are simply dropped, i.e. this isn't relat=
ed
> to DisCo for Imaging at all.

So it looks like the changelog of that patch could be improved, right?

