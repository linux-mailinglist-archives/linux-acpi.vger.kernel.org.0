Return-Path: <linux-acpi+bounces-14834-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3806AECF41
	for <lists+linux-acpi@lfdr.de>; Sun, 29 Jun 2025 19:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB45F3B28E8
	for <lists+linux-acpi@lfdr.de>; Sun, 29 Jun 2025 17:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3CA22CBE6;
	Sun, 29 Jun 2025 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="RTlHbRL/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1AA1C36;
	Sun, 29 Jun 2025 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751218825; cv=none; b=TxoI7CzYvQ1+Sogw9rjaL0mZoJ44vdjlrLwBb3dt4ux5olf2xS5I60jCA3NzHtk1rwbuwCCSvj9yLwjp05eXqHkVgkEMIy8veXCvERLV/9TTdwQj3XD2xQKNq+TwwCPGbyY2ztfskdlfiNTY4sFOE/GL008sLc81WP6cenrQ++M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751218825; c=relaxed/simple;
	bh=kNTnA/HEHbrY20Y20zsb2ywwOhUAzW+t5QxcQgfHaLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyL3sSOKO2kJiDapBF58K5yHXIGTuV84vmwSdfdbyrloiT1F7O3gIkQcve3kiBwxrzpLoHrQTp/0EMCKUyKsPK6uXeqEvQaWMIUvHcPjURZaRs0XEZHqCHpbxwNTsRDpZkW/MKnreB1DLemhHyDrp3jxIycSXmKk+DtQm+wuS9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=RTlHbRL/; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id CB96E16D7;
	Sun, 29 Jun 2025 19:40:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1751218801;
	bh=kNTnA/HEHbrY20Y20zsb2ywwOhUAzW+t5QxcQgfHaLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RTlHbRL/r/r1gaRrFFI0Pgsd6sC5iZnTaGjpvzCh8yDmQqqJ36UICUp5SPUJBsuDD
	 lZupLJwM96TKcMkxICNw74LmgHCLEZVmqe83P4sC7/4cE6SKjVlIJ8yuY96uTjnV/T
	 y1JjJHo8g7Kwt1wTgFXX8fSGsp17BL0Ujaa6rc8k=
Date: Sun, 29 Jun 2025 20:39:58 +0300
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
Subject: Re: [PATCH v2 01/12] media: uvcvideo: Always set default_value
Message-ID: <20250629173958.GA6260@pendragon.ideasonboard.com>
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-1-5710f9d030aa@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250605-uvc-orientation-v2-1-5710f9d030aa@chromium.org>

Hi Ricardo,

Thank you for the patch.

On Thu, Jun 05, 2025 at 05:52:54PM +0000, Ricardo Ribalda wrote:
> If the control does not support GET_DEF, the field default_value will be
> left uninitialized during queryctrl.
> 
> Fixes: c0efd232929c ("V4L/DVB (8145a): USB Video Class driver")

Media CI rules require a Cc: stable.

> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 44b6513c526421943bb9841fb53dc5f8e9f93f02..47e8ccc39234d1769384b55539a21df07f3d57c7 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1497,6 +1497,8 @@ static int __uvc_queryctrl_boundaries(struct uvc_video_chain *chain,
>  	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_DEF) {
>  		v4l2_ctrl->default_value = uvc_mapping_get_s32(mapping,
>  				UVC_GET_DEF, uvc_ctrl_data(ctrl, UVC_CTRL_DATA_DEF));
> +	} else {
> +		v4l2_ctrl->default_value = 0;
>  	}

While at it we can drop the curly braces.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  
>  	switch (mapping->v4l2_type) {

-- 
Regards,

Laurent Pinchart

