Return-Path: <linux-acpi+bounces-15136-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00CDB041AA
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 16:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6AF3AFF1C
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 14:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA26257422;
	Mon, 14 Jul 2025 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="nIiB3A07"
X-Original-To: linux-acpi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1961EC014;
	Mon, 14 Jul 2025 14:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503401; cv=none; b=l3/2Y84oUPvsIl65KeJ/5/IiJNHKiN9Og8SCtq6h+yO5LGDV/FEp7tuAN5ngL2Dum6mzDvMNoHwz4cWG+pgh1kO+YwAxaq8KnfYng8q244MyWAL0PDDRx1AGfhZHSqWwjHZUDEjlDPKqS1kU3H4CCHPHyN1Sn7bZtejcEDygSmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503401; c=relaxed/simple;
	bh=wPDtCI6xegXtln2Eh4yv/iYqoEEGtGwFMY5S/0Xr5MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hhrt9Xl6QmP3tmG31zwcahaV2aYuqoeeuhIYqysRTP/7QyINtnL8LIrQuf3WEslbDSUSnRH9s7kdbp6vM1tGjc73/vY8nVnfmZjv9Y27d7JmSgmH4aMzw70AmcOazdJ8QdBaH6xF6bcUYbePrYTi+oE/kykRKyFMdbq0O5fpvl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=nIiB3A07; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id D543A166D;
	Mon, 14 Jul 2025 16:29:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1752503366;
	bh=wPDtCI6xegXtln2Eh4yv/iYqoEEGtGwFMY5S/0Xr5MM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nIiB3A07vGOX/XzlIRB05tOOWCHIoNND22IwaFcC02uI7jX/Rrwc7EV2po2oUct7o
	 ILtKbEMHt546i3+1qM3uSLi/E4QaWapauf4TCJhW4Vlgyg8AIZrCQEQyLfkK7EVy7n
	 FWgcpxo0LLwJZJlRdSVV4et+UjxnefeC4cTiddwg=
Date: Mon, 14 Jul 2025 17:29:26 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
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
Subject: Re: [PATCH v2 10/12] media: uvcvideo: Add get_* functions to
 uvc_entity
Message-ID: <20250714142926.GI8243@pendragon.ideasonboard.com>
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-10-5710f9d030aa@chromium.org>
 <20250629181246.GE6260@pendragon.ideasonboard.com>
 <CANiDSCsu0RT4dcGyBJRutP=9HTe+niUoohxTZE=qJ8O_9ez=+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiDSCsu0RT4dcGyBJRutP=9HTe+niUoohxTZE=qJ8O_9ez=+A@mail.gmail.com>

On Tue, Jul 01, 2025 at 01:13:10PM +0200, Ricardo Ribalda wrote:
> On Sun, 29 Jun 2025 at 20:13, Laurent Pinchart wrote:
> > On Thu, Jun 05, 2025 at 05:53:03PM +0000, Ricardo Ribalda wrote:
> > > Virtual entities need to provide more values than get_cur and get_cur
> >
> > I think you meant "get_info and get_cur".
> >
> > > for their controls. Add support for get_def, get_min, get_max and
> > > get_res.
> >
> > Do they ? The UVC specification defines controls that don't list
> > GET_DEF, GET_MIN, GET_MAX and GET_RES as mandatory requests. Can't we do
> > the same for the software controls ? This patch is meant to support the
> > UVC_SWENTITY_ORIENTATION and UVC_SWENTITY_ROTATION control in the next
> > patch, and those are read-only controls. Aren't GET_INFO and GET_CUR
> > enough ?
> 
> V4L2_CID_CAMERA_ROTATION has the type UVC_CTRL_DATA_TYPE_UNSIGNED,
> that time requires get_min and get_max.

Where does that requirement come from ? Is it because how the
corresponding V4L2 type (V4L2_CTRL_TYPE_INTEGER) is handled in
uvc_ctrl_clamp() ? uvc_ctrl_clamp() is only called when setting a
control, from uvc_ctrl_set(), and V4L2_CID_CAMERA_ROTATION should be
read-only.

> We can create a new type UVC_CTRL_DATA_TYPE_UNSIGNED_READ_ONLY that
> fakes min, max and res, but I think that it is cleaner this approach.
> 
> > > This is a preparation patch.
> > >
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > >  drivers/media/usb/uvc/uvc_ctrl.c | 12 ++++++++++++
> > >  drivers/media/usb/uvc/uvcvideo.h |  8 ++++++++
> > >  2 files changed, 20 insertions(+)
> > >
> > > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > > index 21ec7b978bc7aca21db7cb8fd5d135d876f3330c..59be62ae24a4219fa9d7aacf2ae7382c95362178 100644
> > > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > > @@ -596,6 +596,18 @@ static int uvc_ctrl_query_entity(struct uvc_device *dev,
> > >       if (query == UVC_GET_CUR && ctrl->entity->get_cur)
> > >               return ctrl->entity->get_cur(dev, ctrl->entity,
> > >                                            ctrl->info.selector, data, len);
> > > +     if (query == UVC_GET_DEF && ctrl->entity->get_def)
> > > +             return ctrl->entity->get_def(dev, ctrl->entity,
> > > +                                          ctrl->info.selector, data, len);
> > > +     if (query == UVC_GET_MIN && ctrl->entity->get_min)
> > > +             return ctrl->entity->get_min(dev, ctrl->entity,
> > > +                                          ctrl->info.selector, data, len);
> > > +     if (query == UVC_GET_MAX && ctrl->entity->get_max)
> > > +             return ctrl->entity->get_max(dev, ctrl->entity,
> > > +                                          ctrl->info.selector, data, len);
> > > +     if (query == UVC_GET_RES && ctrl->entity->get_res)
> > > +             return ctrl->entity->get_res(dev, ctrl->entity,
> > > +                                          ctrl->info.selector, data, len);
> > >       if (query == UVC_GET_INFO && ctrl->entity->get_info)
> > >               return ctrl->entity->get_info(dev, ctrl->entity,
> > >                                             ctrl->info.selector, data);
> > > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > > index a931750bdea25b9062dcc7644bf5f2ed89c1cb4c..d6da8ed3ad4cf3377df49923e051fe04d83d2e38 100644
> > > --- a/drivers/media/usb/uvc/uvcvideo.h
> > > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > > @@ -261,6 +261,14 @@ struct uvc_entity {
> > >                       u8 cs, u8 *caps);
> > >       int (*get_cur)(struct uvc_device *dev, struct uvc_entity *entity,
> > >                      u8 cs, void *data, u16 size);
> > > +     int (*get_def)(struct uvc_device *dev, struct uvc_entity *entity,
> > > +                    u8 cs, void *data, u16 size);
> > > +     int (*get_min)(struct uvc_device *dev, struct uvc_entity *entity,
> > > +                    u8 cs, void *data, u16 size);
> > > +     int (*get_max)(struct uvc_device *dev, struct uvc_entity *entity,
> > > +                    u8 cs, void *data, u16 size);
> > > +     int (*get_res)(struct uvc_device *dev, struct uvc_entity *entity,
> > > +                    u8 cs, void *data, u16 size);
> > >
> > >       unsigned int ncontrols;
> > >       struct uvc_control *controls;

-- 
Regards,

Laurent Pinchart

