Return-Path: <linux-acpi+bounces-1591-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC127F02E3
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Nov 2023 21:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB6B21F22525
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Nov 2023 20:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADB11E508
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Nov 2023 20:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="BU2InGWB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318E1F2;
	Sat, 18 Nov 2023 10:50:44 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 062CD9B6;
	Sat, 18 Nov 2023 19:50:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1700333414;
	bh=A+D1nmSanTzQJvrVfPUsKP8uZ0rghh5nMqAvj+bHk6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BU2InGWBhbiKfo4iFmN9UwjW5+yvUUhnPeKZq/izXOdL4WqLYTwFQyPomwDdjRYcy
	 94xyMaLsa7fTt9E59o2NJWAdTHQrD/lvK/hlIJbm3jl695fzokLyt8JLSFiLaErXgz
	 ibjv8/lBhmo8HFdjo6bzGyY4QOGTkfdd8iIe2swc=
Date: Sat, 18 Nov 2023 20:50:49 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
	rafael@kernel.org, jacopo.mondi@ideasonboard.com
Subject: Re: [PATCH v2 3/7] ACPI: Documentation: Document acpi_dev_state_d0()
Message-ID: <20231118185049.GH20846@pendragon.ideasonboard.com>
References: <20231117111433.1561669-1-sakari.ailus@linux.intel.com>
 <20231117111433.1561669-4-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231117111433.1561669-4-sakari.ailus@linux.intel.com>

Hi Sakari,

Thank you for the patch.

On Fri, Nov 17, 2023 at 01:14:29PM +0200, Sakari Ailus wrote:
> Document that acpi_dev_state_d0() can be used to tell if the device was
> powered on for probe.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  Documentation/firmware-guide/acpi/non-d0-probe.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/firmware-guide/acpi/non-d0-probe.rst b/Documentation/firmware-guide/acpi/non-d0-probe.rst
> index 7afd16701a02..815bcc8db69f 100644
> --- a/Documentation/firmware-guide/acpi/non-d0-probe.rst
> +++ b/Documentation/firmware-guide/acpi/non-d0-probe.rst
> @@ -24,6 +24,14 @@ there's a problem with the device, the driver likely probes just fine but the
>  first user will find out the device doesn't work, instead of a failure at probe
>  time. This feature should thus be used sparingly.
>  
> +ACPI framework
> +--------------
> +
> +Use the Linux ACPI framework function :c:func:`acpi_dev_state_d0()` to tell
> +whether the device was powered on for probe. :c:func:`acpi_dev_state_d0()`
> +returns true if the device is powered on, false otherwise. For non-ACPI backed
> +devices it returns true always.
> +

While this is true, I don't want to see drivers having to call
ACPI-specific functions, the same way you dislike OF-specific functions
in drivers. Please find a better way to handle this.

>  I²C
>  ---
>  

-- 
Regards,

Laurent Pinchart

