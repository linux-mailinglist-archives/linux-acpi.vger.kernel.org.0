Return-Path: <linux-acpi+bounces-6319-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F554905055
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 12:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EF401C21534
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 10:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF2C16E89A;
	Wed, 12 Jun 2024 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJwAf12h"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C046016E881;
	Wed, 12 Jun 2024 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718187968; cv=none; b=aWI6yjfXHRttAGH/khQhJgn+lDt8Hlrdf9RteFIy9/XWxM+RmJNJzuneVuLnjuLgfFlAVya0H/PCyhMe2XZP/qiMNH63n2Whmz09nry0KovcvAOwe7N15I4+e/sYsYhXMrqoYX4alvlm3a/3ZYoASDBcX9CqV0Zfg6sobEC+T1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718187968; c=relaxed/simple;
	bh=Hy009I4Y0Qv6ns/yhERDJ2MDP1boihPeApgieoNPYl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYVNsWUVrzy6DnJALpiJ3JQEM8dX0hPvJ/QUdWqzDSKzqeVgpbIdzF5TvFmKzo1XsZNA9Ew0ARIU52gO1fE6HkJbLeiFMI71jKSAT4dlRiVIjYEXhdVanMrIAUI+PJ2MeiBYEoyHj7mD5Cnbkp1i0VCClBafRsc6ojN1HSz9mrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJwAf12h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DEDAC4AF4D;
	Wed, 12 Jun 2024 10:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718187968;
	bh=Hy009I4Y0Qv6ns/yhERDJ2MDP1boihPeApgieoNPYl8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jJwAf12hDyb8KkzUlwPaUpF7c/GBZv98SWRj4Lf7Q2TMs+Q7tb62d+3GheBOkS15W
	 xEmMKdXRGR07q4E6e6O74S6NCtdLoEfSXxxwCJUrRvlBux5vAYNphgNW3GI/q1Kr9Q
	 Ro0jgAAEzgD8sv7AFfAA1IoyTJMRM8i9wgI8jST5/pkVHYodWEtyPJ2rOohUXwzqJZ
	 jZtuKEmQNSSV2kG4rl5awH4k4PeoAiPU9AIsyqkxD4epaYkNKR4toQkFf2iyHmgWZQ
	 qOb4nkxbQ231vnHuorFvhl6zvOr7j/bGl6Rm+Hjfb+MtS2CUEdU0ictQb8sLW2hZ7u
	 Ecq1omUKx1+CA==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5bae827df63so242046eaf.3;
        Wed, 12 Jun 2024 03:26:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUR0yjgWHnjgsr51a7bx+JOSW8J2YmHCkFAjZNS8YVgetoin7BeOtl8Wzh3y+0ciY1SYhHv6+faHh2owHnCfKwYOn/uZLcyosVBXTLcegkAJMJUeBoffosQX0iTKS4SNXekCCvnsZJXP6dcfXB04jRxZC/0m3kpd+aiIOFd5+e83Pxg13KP
X-Gm-Message-State: AOJu0YzVylCKlYEkBc49Rzx84kRODoAm6Dm/w25hVxY9AQWczdNfaScx
	OSaM5jBQvafG2DlGLKUHzRPmbfESkrtmzEH6LvSRr+oyHGqijSAZDR1ohA1qX0RKOBSVl+IEDlF
	ZAoNw4pxht54o9/YiHAvk42lcYIg=
X-Google-Smtp-Source: AGHT+IEhytvAjKaqXjVi4XDP6ekYnjP36qmWXpwgUUaoF04z3nVKwdXo5pIyTnVxdO7jVFV/WIeaQcFKeLMLVefzXso=
X-Received: by 2002:a4a:3101:0:b0:5ba:ca8a:6598 with SMTP id
 006d021491bc7-5bb3b7b972bmr1488238eaf.0.1718187967599; Wed, 12 Jun 2024
 03:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <988e48090982c89ce0c906954832fdfb09a1ce34.camel@sapience.com>
 <20240528084413.2624435-1-sakari.ailus@linux.intel.com> <a05df025-a0be-49cd-84a9-7d7fb2eeb33e@redhat.com>
 <e9062095-b312-44df-a9e3-0b09f3ec9eff@redhat.com> <4b387b4d-f778-4891-9f07-df5fc0a093cd@redhat.com>
In-Reply-To: <4b387b4d-f778-4891-9f07-df5fc0a093cd@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Jun 2024 12:25:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0itb45-hWS-JV5Nx8CQ7=CiS-dhJG8xJbrPNkY2=jN4jg@mail.gmail.com>
Message-ID: <CAJZ5v0itb45-hWS-JV5Nx8CQ7=CiS-dhJG8xJbrPNkY2=jN4jg@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: scan: Ignore Dell XPS 9320 camera graph port nodes
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Genes Lists <lists@sapience.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, mchehab@kernel.org, 
	hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com, 
	wentong.wu@intel.com, linux-media@vger.kernel.org, linux-acpi@vger.kernel.org, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 12:08=E2=80=AFPM Hans de Goede <hdegoede@redhat.com=
> wrote:
>
> Hi,
>
> On 6/6/24 8:12 PM, Hans de Goede wrote:
> > Hi,
> >
> > +To: Rafael since this was Cc-ed to linux-acpi but never send
> > to Rafael directly.
> >
> > Rafael this fixes a crash in 6.10-rc1 for some users and is necessary
> > to make the cameras work on the Dell XPS 13 plus 9320 .
> >
> > On 5/28/24 7:09 PM, Hans de Goede wrote:
> >> Hi Sakari,
> >>
> >> On 5/28/24 10:44 AM, Sakari Ailus wrote:
> >>> Ignore camera related graph port nodes on Dell XPS 9320. They data in=
 BIOS
> >>> is buggy, just like it is for Dell XPS 9315. The corresponding softwa=
re
> >>> nodes are created by the ipu-bridge.
> >>>
> >>> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> >>> ---
> >>> Hi,
> >>>
> >>> Could you test this and see whether it fixes the warning?
> >>>
> >>> The camera might work with this change, too.
> >>
> >> Thank you I just received a Dell XPS 13 plus 9320 myself to use
> >> for VSC testing and I can confirm that with this patch 6.10.0-rc1
> >> works, including giving a picture with the libcamera software ISP +
> >> 3 small libcamera patches.
> >
> > I forgot to add:
> >
> > Tested-by: Hans de Goede <hdegoede@redhat.com>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> I just hit the same problem on another Dell laptop. It seems that
> all Dell laptops with IPU6 camera from the Tiger Lake, Alder Lake
> and Raptor Lake generations suffer from this problem.
>
> So instead of playing whack a mole with DMI matches we should
> simply disable ACPI MIPI DISCO support on all Dell laptops
> with those CPUs. I'm preparing a fix for this to replace
> the DMI matching now.
>
> Rafael, please drop this patch, my more generic fix will replace it
> and backporting will be easier without having the intermediate fix
> in the middle.

Dropping, thanks!

