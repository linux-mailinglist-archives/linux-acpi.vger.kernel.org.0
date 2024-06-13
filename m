Return-Path: <linux-acpi+bounces-6370-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B9590694B
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 11:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62CF1C22A10
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 09:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F5B140E58;
	Thu, 13 Jun 2024 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVUcNJAN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F54140E2B;
	Thu, 13 Jun 2024 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718272261; cv=none; b=KFd8ZG9C0GyebgyVBzOakx56+exqa1er6wcgYHFlPOzPFl11k6NMeADAseC5U6ytaYPgT/Oj2pOFBI+Y0JUuEYhQ+mgwRVDxHuz0KqUGF3Q5KZACPTAncygbYRpxHasmVWlZ1ch5zBGys7wwFaJ4+W+f5w63h+tqcy+RIvIE3kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718272261; c=relaxed/simple;
	bh=SNV35KtlQC31smqSFcPsdJtAGTjRT6XfQVyUb02BMzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dxq9czCkXUNoQVEaeBDzEae8DcrK6ppZFngxlwLa1dwPTm2aSx01GWqXXdJV7Dy6FLONXhdH4ajy+I2HjZLsho1SAoPYogsFUdnsuOccBM3DlTX0LkiaSjxprNqDKQEA61PShk27veKXjS+cu5boQJ7oAc30XfJDiJS97RO4sUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVUcNJAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37EFC4AF1C;
	Thu, 13 Jun 2024 09:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718272261;
	bh=SNV35KtlQC31smqSFcPsdJtAGTjRT6XfQVyUb02BMzU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RVUcNJANurLX6qKW3W2xf6Fl4wZYNeNxn7+iw/2c4zp+OVda5WkTyj/41ummI67UZ
	 Ud8ChBUTEDR0WQBxQeWf9uDUv9tplmGh/y+r2RFJT6XmSYbXho2hxiAg7JA49uj8l1
	 evis/bFksYao+zUPUJYcW1HBigOmKlFfm5k+gucc4Xfp0hPvZAXEQFg/O0lvQRiNA1
	 po1Dfo9GJvDuLjzVLmeuYruiATe2PEs+mbrAYE24sCqvMeaC53qLgtoAI2jnn0lnoW
	 2hdmxd1NVeO9UR+32gNQwc8uLACi8So5g5+gE9gGcNho89lZg8xzuws/IfvItRNZ0X
	 tocH7TK9zapvA==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b335681e82so51737eaf.2;
        Thu, 13 Jun 2024 02:51:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUV40vPanHZTd1Gv3LPHCq0WprjPo9sUG/D8Mbb5DlTLm9T03NqKxXzONBzcuENZAxEsZa0SBOSuhxk3xPtcEwLkn1O07m1Vlq76xdsmtlWDnnEXmoUcXAnL6qUcglIqtUYdTdQ8sKF2mnuF/Ts9T3jDQBOuN/WE6ze5VGhRTAwmMEwYdCH
X-Gm-Message-State: AOJu0Yz2gAzJINkj1SGpYCs01TWDMcTPWTHhCpvbPnP5jsxI81pG6hfj
	V8NOk5sSt6ZFUjCpF4xtqBjdc37rK8dGz8Tk0sNCTaZn3o7roKzlwxUacD++uI9U3xN4HzqT8ld
	SOklCr3t+WXOdrzHZErF2w560xNk=
X-Google-Smtp-Source: AGHT+IEcaBEAG1NmWL/I9RS0vHUxgrV83BuKZJ+zxf4O57zYlHmYtUHwc4Z7TBN+zb6NrRmrRDwkdL+RKuRXm9EHD20=
X-Received: by 2002:a05:6820:2c86:b0:5aa:3e4f:f01e with SMTP id
 006d021491bc7-5bb3b9c614cmr4555004eaf.1.1718272260335; Thu, 13 Jun 2024
 02:51:00 -0700 (PDT)
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
 <18cb82bb-51c6-4a52-80a4-6b1e3d95f99c@redhat.com> <ZmoCUZxlSHy_PclO@kekkonen.localdomain>
In-Reply-To: <ZmoCUZxlSHy_PclO@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Jun 2024 11:50:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jN3CXM9vWQniu1Q2t1NvG9n5KoG0VGHnMgdPU2iHpBvw@mail.gmail.com>
Message-ID: <CAJZ5v0jN3CXM9vWQniu1Q2t1NvG9n5KoG0VGHnMgdPU2iHpBvw@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: scan: Ignore Dell XPS 9320 camera graph port nodes
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Genes Lists <lists@sapience.com>, linux-kernel@vger.kernel.org, mchehab@kernel.org, 
	hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com, 
	wentong.wu@intel.com, linux-media@vger.kernel.org, linux-acpi@vger.kernel.org, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sakari,

On Wed, Jun 12, 2024 at 10:17=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Hans,
>
> On Wed, Jun 12, 2024 at 04:30:30PM +0200, Hans de Goede wrote:
> > Sakari I know you have been pushing for MIPI camera descriptions under
> > ACPI to move to a standardized format and I can see how that is a good
> > thing, but atm it seems to mainly cause things to break and before
> > the ACPI MIPI DISCO support landed in 6.8 we did not have these issues,
> > since the information used by the ipu-bridge code does seem to be corre=
ct.
>
> Support for capturing from cameras on IPU6 systems (IPU6 ISYS driver and
> IPU bridge changes) was upstreamed for 6.10, with some drivers such as IV=
SC
> (four of them) and IVSC related IPU bridge changes merged for 6.8 already=
.
>
> We can't guarantee the continued functioning of downstream drivers in cas=
es
> where new upstream drivers for the same devices get merged to the kernel,
> often with different APIs. You know that as well as I do.
>
> In other words, there was no regression with respect to the upstream
> kernel.

Users' opinions on this may differ I suppose.

If a user sees a new kernel warning on boot, they will easily count it
as a regression, and with panic_on_warn this becomes a full-fledged
kernel crash.

This is bad, even though it may be coming from a new driver strictly speaki=
ng.

