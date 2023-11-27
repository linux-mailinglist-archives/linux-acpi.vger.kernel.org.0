Return-Path: <linux-acpi+bounces-1839-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5837FABB6
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Nov 2023 21:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD16A281B77
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Nov 2023 20:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DA545C0B
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Nov 2023 20:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1626D59;
	Mon, 27 Nov 2023 12:32:02 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1f9f9e62248so528797fac.0;
        Mon, 27 Nov 2023 12:32:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701117122; x=1701721922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdwRWyWKrOa5q+kJX8zg2X2doauF23yJjB05tmOZA/w=;
        b=SEwc6lyh+cECnHW7txhvgxAQpA7/pUOI2+Ve+ZkJPPGgFgJ3K0eSec6fQbppHX4GHQ
         cCdNrX+HOGCeHzCAEGtS0YNXMJTiM6j+TVqn0cinJdhKyMsTVht4uyXPtiY300S2eQKC
         2kTCS7b+n53YDnaeHeIP41Zso6Oz7QfzZ2yDAjGiJzEZ0F/vSdB5S81DIhh7KHSEXwd0
         eDJML8gesazLAAkkbzicWnKSYzIOHFmTcSZYMS9R2WJ3PUs0hlNX/q2uEO13TfeXE7gG
         yq9/BalIJw/TTedIMGMCAK4hOxXnIWPAKOcV9nv/yRXHQ70tiq4ktPaOzwMyWQ/+Jpe6
         FZgQ==
X-Gm-Message-State: AOJu0YzCGODGSxs7ahjpdmpUfB0PJ0Sf933RWcrp3njYA096bzI6+i/s
	NbSaLwSHW1FHUjKkB+2bdlGT4IsLp2kcgA//4Y9orcHM
X-Google-Smtp-Source: AGHT+IFod1sFMJLpgT0eyPYq1PZ1XNGcKxPo1FKiHM6SG/Y23H7XVeB/wtViS1xemYf9phD6cTKaU2ePcBOLKaUL/EA=
X-Received: by 2002:a05:6870:3c8b:b0:1ea:1510:d8df with SMTP id
 gl11-20020a0568703c8b00b001ea1510d8dfmr18371405oab.4.1701117122107; Mon, 27
 Nov 2023 12:32:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127143741.5229-1-hdegoede@redhat.com> <20231127143741.5229-2-hdegoede@redhat.com>
In-Reply-To: <20231127143741.5229-2-hdegoede@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 27 Nov 2023 21:31:51 +0100
Message-ID: <CAJZ5v0iZkxq=5KBd-Y=V8xbTXbQ6qATr56xsJd29Rgtaj2Gg=g@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: video: Use acpi_video_device for cooling-dev
 driver data
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Michal Wilczynski <michal.wilczynski@intel.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, linux-acpi@vger.kernel.org, 
	"6 . 6+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 3:37=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> The acpi_video code was storing the acpi_video_device as driver-data
> in the acpi_device children of the acpi_video_bus acpi_device.
>
> But the acpi_video driver only binds to the bus acpi_device.
> It uses, but does not bind to, the children. Since it is not
> the driver it should not be using the driver_data of the children's
> acpi_device-s.
>
> Since commit 0d16710146a1 ("ACPI: bus: Set driver_data to NULL every
> time .add() fails") the childen's driver_data ends up getting set
> to NULL after a driver fails to bind to the children leading to a NULL
> pointer deref in video_get_max_state when registering the cooling-dev:
>
> [    3.148958] BUG: kernel NULL pointer dereference, address: 00000000000=
00090
> <snip>
> [    3.149015] Hardware name: Sony Corporation VPCSB2X9R/VAIO, BIOS R2087=
H4 06/15/2012
> [    3.149021] RIP: 0010:video_get_max_state+0x17/0x30 [video]
> <snip>
> [    3.149105] Call Trace:
> [    3.149110]  <TASK>
> [    3.149114]  ? __die+0x23/0x70
> [    3.149126]  ? page_fault_oops+0x171/0x4e0
> [    3.149137]  ? exc_page_fault+0x7f/0x180
> [    3.149147]  ? asm_exc_page_fault+0x26/0x30
> [    3.149158]  ? video_get_max_state+0x17/0x30 [video 9b6f3f0d19d7b4a0e2=
df17a2d8b43bc19c2ed71f]
> [    3.149176]  ? __pfx_video_get_max_state+0x10/0x10 [video 9b6f3f0d19d7=
b4a0e2df17a2d8b43bc19c2ed71f]
> [    3.149192]  __thermal_cooling_device_register.part.0+0xf2/0x2f0
> [    3.149205]  acpi_video_bus_register_backlight.part.0.isra.0+0x414/0x5=
70 [video 9b6f3f0d19d7b4a0e2df17a2d8b43bc19c2ed71f]
> [    3.149227]  acpi_video_register_backlight+0x57/0x80 [video 9b6f3f0d19=
d7b4a0e2df17a2d8b43bc19c2ed71f]
> [    3.149245]  intel_acpi_video_register+0x68/0x90 [i915 1f3a758130b32ef=
13d301d4f8f78c7d766d57f2a]
> [    3.149669]  intel_display_driver_register+0x28/0x50 [i915 1f3a758130b=
32ef13d301d4f8f78c7d766d57f2a]
> [    3.150064]  i915_driver_probe+0x790/0xb90 [i915 1f3a758130b32ef13d301=
d4f8f78c7d766d57f2a]
> [    3.150402]  local_pci_probe+0x45/0xa0
> [    3.150412]  pci_device_probe+0xc1/0x260
> <snip>
>
> Fix this by directly using the acpi_video_device as devdata for
> the cooling-device, which avoids the need to set driver-data on
> the children at all.
>
> Fixes: 0d16710146a1 ("ACPI: bus: Set driver_data to NULL every time .add(=
) fails")
> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/9718
> Cc: Michal Wilczynski <michal.wilczynski@intel.com>
> Cc: 6.6+ <stable@vger.kernel.org> # 6.6+
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/acpi_video.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 5eded14f8853..7cd91e85c62a 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -253,8 +253,7 @@ static const struct backlight_ops acpi_backlight_ops =
=3D {
>  static int video_get_max_state(struct thermal_cooling_device *cooling_de=
v,
>                                unsigned long *state)
>  {
> -       struct acpi_device *device =3D cooling_dev->devdata;
> -       struct acpi_video_device *video =3D acpi_driver_data(device);
> +       struct acpi_video_device *video =3D cooling_dev->devdata;
>
>         *state =3D video->brightness->count - ACPI_VIDEO_FIRST_LEVEL - 1;
>         return 0;
> @@ -263,8 +262,7 @@ static int video_get_max_state(struct thermal_cooling=
_device *cooling_dev,
>  static int video_get_cur_state(struct thermal_cooling_device *cooling_de=
v,
>                                unsigned long *state)
>  {
> -       struct acpi_device *device =3D cooling_dev->devdata;
> -       struct acpi_video_device *video =3D acpi_driver_data(device);
> +       struct acpi_video_device *video =3D cooling_dev->devdata;
>         unsigned long long level;
>         int offset;
>
> @@ -283,8 +281,7 @@ static int video_get_cur_state(struct thermal_cooling=
_device *cooling_dev,
>  static int
>  video_set_cur_state(struct thermal_cooling_device *cooling_dev, unsigned=
 long state)
>  {
> -       struct acpi_device *device =3D cooling_dev->devdata;
> -       struct acpi_video_device *video =3D acpi_driver_data(device);
> +       struct acpi_video_device *video =3D cooling_dev->devdata;
>         int level;
>
>         if (state >=3D video->brightness->count - ACPI_VIDEO_FIRST_LEVEL)
> @@ -1125,7 +1122,6 @@ static int acpi_video_bus_get_one_device(struct acp=
i_device *device, void *arg)
>
>         strcpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME);
>         strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
> -       device->driver_data =3D data;
>
>         data->device_id =3D device_id;
>         data->video =3D video;
> @@ -1747,8 +1743,8 @@ static void acpi_video_dev_register_backlight(struc=
t acpi_video_device *device)
>         device->backlight->props.brightness =3D
>                         acpi_video_get_brightness(device->backlight);
>
> -       device->cooling_dev =3D thermal_cooling_device_register("LCD",
> -                               device->dev, &video_cooling_ops);
> +       device->cooling_dev =3D thermal_cooling_device_register("LCD", de=
vice,
> +                                                             &video_cool=
ing_ops);
>         if (IS_ERR(device->cooling_dev)) {
>                 /*
>                  * Set cooling_dev to NULL so we don't crash trying to fr=
ee it.
> --

Applied, thanks!

