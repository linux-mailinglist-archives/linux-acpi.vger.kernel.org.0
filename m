Return-Path: <linux-acpi+bounces-1143-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 036817DE5FE
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 19:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D661C2040D
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 18:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D5E18E22
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEA923BE
	for <linux-acpi@vger.kernel.org>; Wed,  1 Nov 2023 18:00:43 +0000 (UTC)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5771111;
	Wed,  1 Nov 2023 11:00:40 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5874cc7bb1aso2129eaf.1;
        Wed, 01 Nov 2023 11:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698861640; x=1699466440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NW33Kt1OtgbnrnXkci8faSY06MnlY8Fj/1N16IJDk2g=;
        b=QXgNS86J5KK9NEbAosku60KERjdpSH0i2vW7hsrptt4dccq3DNes7zsZrQBHmu2O51
         +6Xr+XmanUFpgs0HJDcqHXrRFwVcULfv6H0iaBZOk+5+ha2Z7KaaWPzsT+NZOqttHrRd
         kuTHCZo2OOmS7EAwqVxAwQTat1/3sp9qwIKFQDOXvI0ZNmqDL+DfxMYlvQaPM3JnGHXy
         e4q1oJI98jVZESY5mdByugT/1xtvwQzSQppdSvbTKIFZggqUqjYL5YdK/YCTUiGKYx24
         y+hZNADFEomZuxYDy9iKNCBbBlYoP/F3eKAITR27ucoFN563DSYTZ76RR8CSoNYuFu4r
         CweQ==
X-Gm-Message-State: AOJu0YyyV010AKPdoBlyJMeoVulBF7pYTSbGWvrl50S5oY3hQaa4oIVj
	8e1N0kamcsi2yLg7384uv92ivExRfxRlNHASE8shWPPT
X-Google-Smtp-Source: AGHT+IHtkZh5JWIy8kp5OuPsF+vKlzqzWzYT3t7LKTaJypHcebDwZa9eUyMPSw6STz8ba5vZU4uHkETtpArgtRpBb5k=
X-Received: by 2002:a4a:c991:0:b0:586:7095:126d with SMTP id
 u17-20020a4ac991000000b005867095126dmr16081339ooq.0.1698861639903; Wed, 01
 Nov 2023 11:00:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231101111507.1156910-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20231101111507.1156910-1-sakari.ailus@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 1 Nov 2023 19:00:28 +0100
Message-ID: <CAJZ5v0hv6byMP2ZZpr+1oRdjPN1etxcF2jatLLirEmwYfwdvDw@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: property: Replicate DT-aligned u32 properties
 from DisCo for Imaging
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 1:32=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> MIPI DisCo for Imaging defines properties for camera sensors that
> functionally align with DT equivalents. Replicate the values of these
> properties so no-one else needs to know about these property names.
>
> Properties replicated are:
>
>         "mipi-img-clock-frequency" -> "clock-frequency"
>         "mipi-img-led-max-current" -> "led-max-microamp"
>         "mipi-img-flash-max-current" -> "flash-max-microamp"
>         "mipi-img-flash-max-timeout" -> "flash-max-timeout-us"
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> Hi Rafael,
>
> Could you include this patch in the set? Then I think it's fairly
> complete on ACPI framework side.

I'll do it, thanks!

>  drivers/acpi/mipi-di.c  | 21 +++++++++++++++++++++
>  include/acpi/acpi_bus.h |  4 ++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/drivers/acpi/mipi-di.c b/drivers/acpi/mipi-di.c
> index 13ed09216c37..de8988657e96 100644
> --- a/drivers/acpi/mipi-di.c
> +++ b/drivers/acpi/mipi-di.c
> @@ -591,6 +591,7 @@ static void init_crs_csi2_swnodes(struct crs_csi2 *cs=
i2)
>         struct acpi_device *adev;
>         acpi_status status;
>         unsigned int i;
> +       u32 val;
>         int ret;
>
>         /*
> @@ -622,6 +623,26 @@ static void init_crs_csi2_swnodes(struct crs_csi2 *c=
si2)
>                 }
>         }
>
> +       if (!fwnode_property_read_u32(adev_fwnode, "mipi-img-clock-freque=
ncy", &val)) {
> +               swnodes->dev_props[NEXT_PROPERTY(prop_index, DEV_CLOCK_FR=
EQUENCY)] =3D
> +                       PROPERTY_ENTRY_U32("clock-frequency", val);
> +       }
> +
> +       if (!fwnode_property_read_u32(adev_fwnode, "mipi-img-led-max-curr=
ent", &val)) {
> +               swnodes->dev_props[NEXT_PROPERTY(prop_index, DEV_LED_MAX_=
MICROAMP)] =3D
> +                       PROPERTY_ENTRY_U32("led-max-microamp", val);
> +       }
> +
> +       if (!fwnode_property_read_u32(adev_fwnode, "mipi-img-flash-max-cu=
rrent", &val)) {
> +               swnodes->dev_props[NEXT_PROPERTY(prop_index, DEV_FLASH_MA=
X_MICROAMP)] =3D
> +                       PROPERTY_ENTRY_U32("flash-max-microamp", val);
> +       }
> +
> +       if (!fwnode_property_read_u32(adev_fwnode, "mipi-img-flash-max-ti=
meout-us", &val)) {
> +               swnodes->dev_props[NEXT_PROPERTY(prop_index, DEV_FLASH_MA=
X_TIMEOUT_US)] =3D
> +                       PROPERTY_ENTRY_U32("flash-max-timeout-us", val);
> +       }
> +
>         status =3D acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
>         if (ACPI_FAILURE(status)) {
>                 acpi_handle_info(handle, "Unable to get the path name\n")=
;
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index d92799889512..85a27081cced 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -371,6 +371,10 @@ struct acpi_gpio_mapping;
>
>  enum acpi_device_swnode_dev_props {
>         ACPI_DEVICE_SWNODE_DEV_ROTATION,
> +       ACPI_DEVICE_SWNODE_DEV_CLOCK_FREQUENCY,
> +       ACPI_DEVICE_SWNODE_DEV_LED_MAX_MICROAMP,
> +       ACPI_DEVICE_SWNODE_DEV_FLASH_MAX_MICROAMP,
> +       ACPI_DEVICE_SWNODE_DEV_FLASH_MAX_TIMEOUT_US,
>         ACPI_DEVICE_SWNODE_DEV_NUM_OF,
>         ACPI_DEVICE_SWNODE_DEV_NUM_ENTRIES
>  };
> --
> 2.39.2
>
>

