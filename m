Return-Path: <linux-acpi+bounces-1590-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB8D7F02E2
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Nov 2023 21:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDBDD280C60
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Nov 2023 20:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980DB1DFED
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Nov 2023 20:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TyuiHMwL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AEEB7;
	Sat, 18 Nov 2023 10:49:08 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id EA6AC9B6;
	Sat, 18 Nov 2023 19:48:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1700333318;
	bh=Ty/rSOHosocLARDo84/B859X8cHqUg9YUPFxBCL9q7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TyuiHMwLr9sikeyn1H5a6kIcq3L91Jkr9zjschhZFlXCw1XoyvoUW7P6AqSLxYicT
	 aC6y+3GtRBD//miS6pEnaBDstVFqjhy6Ne2V4M3aQyW6sQY2m1VxPWPgk3ngtmnBdf
	 ASMdamVTjcq9e8UHlJWP4YsCaB4Rt/lTTlFIx34c=
Date: Sat, 18 Nov 2023 20:49:12 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
	rafael@kernel.org, jacopo.mondi@ideasonboard.com
Subject: Re: [PATCH v2 4/7] media: Documentation: Improve camera sensor
 runtime PM documentation
Message-ID: <20231118184912.GG20846@pendragon.ideasonboard.com>
References: <20231117111433.1561669-1-sakari.ailus@linux.intel.com>
 <20231117111433.1561669-5-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231117111433.1561669-5-sakari.ailus@linux.intel.com>

Hi Sakari,

Thank you for the patch.

On Fri, Nov 17, 2023 at 01:14:30PM +0200, Sakari Ailus wrote:
> Endorse the use of pm_runtime_get_sync() in order to resume the device and

Drivers should use pm_runtime_resume_and_get(), not
pm_runtime_get_sync().

> pm_runtime_get_if_active() to increment its usage_count if the device is
> in RPM_ACTIVE state.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  .../driver-api/media/camera-sensor.rst        | 76 +++++++++++++------
>  .../firmware-guide/acpi/non-d0-probe.rst      |  2 +
>  2 files changed, 53 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/driver-api/media/camera-sensor.rst b/Documentation/driver-api/media/camera-sensor.rst
> index 6456145f96ed..c1bb0de40189 100644
> --- a/Documentation/driver-api/media/camera-sensor.rst
> +++ b/Documentation/driver-api/media/camera-sensor.rst
> @@ -58,35 +58,55 @@ pipeline. They must obey the rules listed herein to ensure coherent power
>  management over the pipeline.
>  
>  Camera sensor drivers are responsible for controlling the power state of the
> -device they otherwise control as well. They shall use runtime PM to manage
> -power states. Runtime PM shall be enabled at probe time and disabled at remove
> -time. Drivers should enable runtime PM autosuspend.
> +device they otherwise control as well. They shall use runtime PM to manage power
> +states. Runtime PM shall be enabled at probe time using
> +:c:func:`pm_runtime_enable()` and disabled using :c:func:`pm_runtime_disable()`
> +at remove time. Before enabling Runtime PM, the device's Runtime PM status is
> +set to ``RPM_ACTIVE`` using :c:func:`pm_runtime_set_active()` and after
> +disabling set to ``RPM_SUSPENDED`` using :c:func:`pm_runtime_set_suspended()`.

That's correct only if the driver powers the device up manually, which
isn't documented here. I recommend adding code examples, and explaining
why this particular initialization sequence is preferred.

> +Drivers should enable runtime PM autosuspend.

A rationale would also be useful.

>  
>  The runtime PM handlers shall handle clocks, regulators, GPIOs, and other
>  system resources required to power the sensor up and down. For drivers that
>  don't use any of those resources (such as drivers that support ACPI systems
>  only), the runtime PM handlers may be left unimplemented.

Unrelated to this patch, but given how many times I've been told to make
drivers developed for OF-based systems ready for ACPI in case anyone
would ever need that, I think we should require DT support for new
sensor drivers even if they're developed on ACPI systems. It's just
unfair otherwise.

>  
> -In general, the device shall be powered on at least when its registers are
> -being accessed and when it is streaming. Drivers should use
> -``pm_runtime_resume_and_get()`` when starting streaming and
> -``pm_runtime_put()`` or ``pm_runtime_put_autosuspend()`` when stopping
> -streaming. They may power the device up at probe time (for example to read
> +In general, the device shall be powered on at least when its registers are being
> +accessed and when it is streaming. Drivers using autosuspend should use
> +:c:func:`pm_runtime_get_sync()` to ensure the device is powered on.

This is applicable to all drivers, not just drivers using autosuspend,
and the correct function is pm_runtime_resume_and_get().

> The
> +function increments Runtime PM ``usage_count`` which the driver is responsible
> +for decrementing using e.g. :c:func:`pm_runtime_put_mark_busy_autosusp()`, which
> +starts autosuspend timer to power off the device later on when its
> +``usage_count`` is 0, or :c:func:`pm_runtime_put()` which proceeds to power off
> +the device without a delay when its ``usage_count`` is 0.
> +
> +Note that runtime PM ``usage_count`` of the device must be put even if
> +:c:func:`pm_runtime_get_sync()` fails.

Let's not go back there. If pm_runtime_resume_and_get() doesn't provide
the right return value, fix it. I do not want to see a call to any RPM
put function in case the get function fails. That was too error prone,
and that hasn't changed. Fix the RPM API instead. I know it's hard given
the number of users, but that's not an excuse. If it requires the help
of coccinelle, and touching hundreds of drivers in a large tree-wide
patch, so be it. I'm getting tired of the pain inflicted on hundreds, of
not thousands, of driver developers because the RPM API has been badly
designed. This is a hard blocker for me.

> :c:func:`pm_runtime_get_sync()` returns 1
> +if the device was already powered on, which may be used as a signal for the
> +driver that initialisation related registers need to be written to the
> +sensor.
> +
> +Drivers that support Devicetree shall also power on the device explicitly in
> +driver's probe() function and power the device off in driver's remove() function
> +without relying on Runtime PM.

This belongs to the probe/remove section above, with a clearer
explanation.

> +
> +Drivers may power the device up at probe time (for example to read
>  identification registers), but should not keep it powered unconditionally after
> -probe.
> +probe. On ACPI systems I²C devices are normally powered on for probe but
> +:ref:`this can be avoided if needed <firmware_acpi_non_d0_probe>`.

From a driver point of view, I think you should say that some firmware
implementations request the device not to be powered up at probe time,
and explain what the driver needs to do to handle that properly.

>  
>  At system suspend time, the whole camera pipeline must stop streaming, and
>  restart when the system is resumed. This requires coordination between the
>  camera sensor and the rest of the camera pipeline. Bridge drivers are
>  responsible for this coordination, and instruct camera sensors to stop and
> -restart streaming by calling the appropriate subdev operations
> -(``.s_stream()``, ``.enable_streams()`` or ``.disable_streams()``). Camera
> -sensor drivers shall therefore **not** keep track of the streaming state to
> -stop streaming in the PM suspend handler and restart it in the resume handler.
> -Drivers should in general not implement the system PM handlers.
> +restart streaming by calling the appropriate subdev operations (``.s_stream()``,
> +``.enable_streams()`` or ``.disable_streams()``). Camera sensor drivers shall
> +therefore **not** keep track of the streaming state to stop streaming in the PM
> +suspend handler and restart it in the resume handler. Drivers should in general
> +not implement the system PM handlers.

Reflowing text without making any other change makes review more
difficult, you may want to split that to another patch (or drop it).

>  
>  Camera sensor drivers shall **not** implement the subdev ``.s_power()``
> -operation, as it is deprecated. While this operation is implemented in some
> +operation as it is deprecated. While this operation is implemented in some

I don't think this change is needed.

>  existing drivers as they predate the deprecation, new drivers shall use runtime
>  PM instead. If you feel you need to begin calling ``.s_power()`` from an ISP or
>  a bridge driver, instead add runtime PM support to the sensor driver you are
> @@ -94,20 +114,26 @@ using and drop its ``.s_power()`` handler.
>  
>  Please also see :ref:`examples <media-camera-sensor-examples>`.
>  
> +.. _media_writing_camera_sensor_drives_control_framework:
> +
>  Control framework
>  ~~~~~~~~~~~~~~~~~
>  
>  ``v4l2_ctrl_handler_setup()`` function may not be used in the device's runtime
> -PM ``runtime_resume`` callback, as it has no way to figure out the power state
> -of the device. This is because the power state of the device is only changed
> -after the power state transition has taken place. The ``s_ctrl`` callback can be
> -used to obtain device's power state after the power state transition:
> -
> -.. c:function:: int pm_runtime_get_if_in_use(struct device *dev);
> -
> -The function returns a non-zero value if it succeeded getting the power count or
> -runtime PM was disabled, in either of which cases the driver may proceed to
> -access the device.
> +PM ``runtime_resume`` callback as it has no way to figure out the power state of
> +the device. This is because the Runtime PM status of the device is only changed
> +after the Runtime PM status transition has taken place. The ``s_ctrl`` callback
> +can be used to obtain device's Runtime PM status once the transition has taken

s/device/the device/

> +place:
> +
> +.. c:function:: int pm_runtime_get_if_active(struct device *dev);
> +
> +The function returns a non-zero value if the device is powered on (in which case
> +it increments the device's ``usage_count``) or runtime PM was disabled, in
> +either of which cases the driver may proceed to access the device. Note that the
> +device's ``usage_count`` is not incremented if the function returns an error, in
> +which case the ``usage_count`` also must not be put using
> +:c:func:`pm_runtime_put()` or its variants.

As commented separately in another patch that makes a corresponding
change in a sensor driver, I don't like this. Less complexity in drivers
please, not more.

>  
>  Rotation, orientation and flipping
>  ----------------------------------
> diff --git a/Documentation/firmware-guide/acpi/non-d0-probe.rst b/Documentation/firmware-guide/acpi/non-d0-probe.rst
> index 815bcc8db69f..f0669059101f 100644
> --- a/Documentation/firmware-guide/acpi/non-d0-probe.rst
> +++ b/Documentation/firmware-guide/acpi/non-d0-probe.rst
> @@ -1,5 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
> +.. _firmware_acpi_non_d0_probe:
> +
>  ========================================
>  Probing devices in other D states than 0
>  ========================================

-- 
Regards,

Laurent Pinchart

