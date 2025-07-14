Return-Path: <linux-acpi+bounces-15144-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC33AB04578
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 18:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3223BC700
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 16:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92415260578;
	Mon, 14 Jul 2025 16:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UqK26IC3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2C57262A;
	Mon, 14 Jul 2025 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752510636; cv=none; b=EY/cPgJ3KjUS86hq1eqxIf5swPt0XVpL1PWTosjDwVWQQ3F25Gy5/sWll3KaMFCTGyV0f4AINwvsmherIAyFE/rAsOWG0w7Z4Az1ZTkhLHZocVOwfkzD6Kml1Ilu/OzeG5Uq9kzz6OWkoCUe3QMU7+hGQnYhHcw99mPsPdpwo4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752510636; c=relaxed/simple;
	bh=lpG4IZ6Ioq/EzhqQaI7oezuh5rcGhQxbRRwnUfAZ4QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/0GrvvP7tF4q8u2naAoTVIR85CsfWLoZHVdyOZh//LTMfv2Mdq2hLyXYu3RTmkWauQKiSaKej3rLIS4gBY87izOYOlV6vtNt4e5lSBrq5dqxMCm4NLTKww4Rd4K/ZxnLbJkds/2QLWlFG7kTYfLI2JKTylsALeIcGH3D1r5SpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=UqK26IC3; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id C7AC11127;
	Mon, 14 Jul 2025 18:30:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1752510601;
	bh=lpG4IZ6Ioq/EzhqQaI7oezuh5rcGhQxbRRwnUfAZ4QU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UqK26IC3nrteCaDdSqP4/6c5LRJvIFIKHrPP5hoaIEntyWXbglU0Ud7wrmyYOE09Q
	 b52LWzlDeplUKoLkikXQ7jdTUw2wUxSueHsUV8heHEKyg0qqzuOpkW5m5S3yZnR3vs
	 htRQ7bNTqyiHfISZ57ALngPRq/z9fJTNvQSmqMFs=
Date: Mon, 14 Jul 2025 19:30:01 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Hans de Goede <hdegoede@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 12/12] media: uvcvideo: Do not create MC entities for
 virtual entities
Message-ID: <20250714163001.GB20231@pendragon.ideasonboard.com>
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-12-5710f9d030aa@chromium.org>
 <20250629180534.GN24912@pendragon.ideasonboard.com>
 <CANiDSCvcQ9MA+WBMQTpUzSxDLNiKpvaHsb-pDHTuiUQekgXvQA@mail.gmail.com>
 <CANiDSCtq0cr1LgFCgvdBtWcE3z1MWZEjc0e1wTH_BYPETC+s4Q@mail.gmail.com>
 <20250714143617.GK8243@pendragon.ideasonboard.com>
 <CANiDSCud66tcaODuVA1TreEQ3k8u4k-6ghzRQedTPFcT3j+9VQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiDSCud66tcaODuVA1TreEQ3k8u4k-6ghzRQedTPFcT3j+9VQ@mail.gmail.com>

On Mon, Jul 14, 2025 at 06:04:50PM +0200, Ricardo Ribalda wrote:
> On Mon, 14 Jul 2025 at 16:36, Laurent Pinchart wrote:
> > On Tue, Jul 08, 2025 at 08:28:21AM +0200, Ricardo Ribalda wrote:
> > > On Tue, 1 Jul 2025 at 13:20, Ricardo Ribalda wrote:
> > > > On Sun, 29 Jun 2025 at 20:06, Laurent Pinchart wrote:
> > > > > Hi Ricardo,
> > > > >
> > > > > Thank you for the patch.
> > > > >
> > > > > I would use "software entities" and not "virtual entities" in the
> > > > > subject line and everywhere else, as those entities are not virtual.
> > > > >
> > > > > On Thu, Jun 05, 2025 at 05:53:05PM +0000, Ricardo Ribalda wrote:
> > > > > > Neither the GPIO nor the SWENTITY entities form part of the device
> > > > > > pipeline. We just create them to hold emulated uvc controls.
> > > > > >
> > > > > > When the device initializes, a warning is thrown by the v4l2 core:
> > > > > > uvcvideo 1-1:1.0: Entity type for entity SWENTITY was not initialized!
> > > > > >
> > > > > > There are no entity function that matches what we are doing here, and
> > > > > > it does not make to much sense to create a function for entities that
> > > > > > do not really exist.
> > > > >
> > > > > I don't agree with this. The purpose of reporting entities to userspace
> > > > > through the MC API is to let application enumerate what entities a
> > > > > device contains. Being able to enumerate software entities seems as
> > > > > useful as being able to enumerate hardware entities.
> > > >
> > > > What function shall we use in this case? Nothing here seems to match a
> > > > software entity
> > > > https://www.kernel.org/doc/html/latest/userspace-api/media/mediactl/media-types.html
> > > >
> > > > Any suggestion for name?
> > > > Shall we just live with the warning in dmesg?
> > >
> > >  I just realised that if/when we move to the control framework, the
> > > software entity will be gone.... So to avoid introducing a uAPI change
> > > that will be reverted later I think that we should keep this patch.
> >
> > You know my opinion about moving to the control framework, so that's not
> > a very compelling argument :-)
> 
> Correct me if I am wrong, your opinion is that it will take too much
> work, not that it can't be done or that it is a bad idea.

My opinion is that it's not worth the time needed to write patches, nor
the time needed to review them. It would be a big change, with risks of
regressions, for minimal gain, if any. I don't know if it can be done,
but I think it's a bad idea. Don't fix something that isn't broken, the
patches backlog is big enough, let's focus on useful changes.

> Will send a patch using MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER, but
> when/if we use the control framework, please let me drop the swentity.
> 
> Thanks!
> 
> > We could use MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER, as that's the
> > function already used by XUs, and the SWENTITY fulfills the same role as
> > XUs in some devices.
> >
> > > > > > Do not create MC entities for them and pretend nothing happened here.
> > > > > >
> > > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > > ---
> > > > > >  drivers/media/usb/uvc/uvc_entity.c | 10 ++++++++++
> > > > > >  1 file changed, 10 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/media/usb/uvc/uvc_entity.c b/drivers/media/usb/uvc/uvc_entity.c
> > > > > > index d1a652ef35ec34801bd39a5124b834edf838a79e..2dbeb4ab0c4c8cc763ff2dcd2d836a50f3c6a040 100644
> > > > > > --- a/drivers/media/usb/uvc/uvc_entity.c
> > > > > > +++ b/drivers/media/usb/uvc/uvc_entity.c
> > > > > > @@ -72,6 +72,16 @@ static int uvc_mc_init_entity(struct uvc_video_chain *chain,
> > > > > >  {
> > > > > >       int ret;
> > > > > >
> > > > > > +     /*
> > > > > > +      * Do not initialize virtual entities, they do not really exist
> > > > > > +      * and are not connected to any other entities.
> > > > > > +      */
> > > > > > +     switch (UVC_ENTITY_TYPE(entity)) {
> > > > > > +     case UVC_EXT_GPIO_UNIT:
> > > > > > +     case UVC_SWENTITY_UNIT:
> > > > > > +             return 0;
> > > > > > +     }
> > > > > > +
> > > > > >       if (UVC_ENTITY_TYPE(entity) != UVC_TT_STREAMING) {
> > > > > >               u32 function;
> > > > > >

-- 
Regards,

Laurent Pinchart

