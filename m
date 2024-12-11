Return-Path: <linux-acpi+bounces-10092-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 614479EC7AE
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 09:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628681888AB7
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 08:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215841E9B10;
	Wed, 11 Dec 2024 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7a5u8sd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A071C5F12;
	Wed, 11 Dec 2024 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733907031; cv=none; b=h1j3HX85XSa51VSU41gMXxRFS6P8BZi4FVNpbSDYMLivTcLO0/fm0ch6D1VXwriNHZT9/eQ/begWI1d6g9jnKeEInPl+M7vS7SvW27a96ukMIv9PrZUMVNdR67iP3Juyv/H/xZhGuOjE3L+mASLsTcH6BquN5foGsZCuyjLG1C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733907031; c=relaxed/simple;
	bh=ai8YESzxty1CKO1ZiELcR0rZG9JCE+LruFb2+gcI//s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U2Zhjvtob3Bv4fjK2MFmyGnSeB+7M4UiHp5mjpGupgQo93E/7WjHAn6TJCqFCswOjIBahLy7csINzdgU6Q9dwo2H6lVCt/7XEswEEJH1gQLnbF5LM9Nq7m7vpFab6GJrVMVVRTQ8Rbhjkoh3fZK5X9yAm2G97Dd1yASYwOkcmYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7a5u8sd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5EF6C4CED2;
	Wed, 11 Dec 2024 08:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733907030;
	bh=ai8YESzxty1CKO1ZiELcR0rZG9JCE+LruFb2+gcI//s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S7a5u8sdt53aLg1ztDUhcO4F3nZIO9VYs8BIhiWMuY+mfJ+zG7aLouYtETFX5TvQN
	 I4lZ9y8CKj4cVp/4noQ326Za7Kvqe4rVebZ56lrIg1YO1uUfKzK3CnsIrkXoZKlafb
	 G+V7edTFAt2tpuV4HofB3a+9cpO4+qktpjQQYdXfknA6Klhskq13/4fMFeAu99tcnb
	 6LuYid6mG2kkxwg9vwl1Iu4+aXBneNxwhwloDDAGCsokM2VRLdjRmJSuS9KqNxHILc
	 n30f6ZJkQajbjDQczUU97YybPm0CNAf55NjTo4vEkrkUvVYkAm3P8fYEyI6wKhWhoQ
	 k34a8xHqoTt/A==
Date: Wed, 11 Dec 2024 09:50:24 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Robert Moore
 <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev
Subject: Re: [PATCH v3 7/7] media: ipu-bridge: Remove unneeded conditional
 compilations
Message-ID: <20241211095024.66f8759a@foz.lan>
In-Reply-To: <CANiDSCsHk+QbF3BtrFU8G3UOgZZjTbQf4RhwkYCr+BeFiTYrEg@mail.gmail.com>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
	<20241210-fix-ipu-v3-7-00e409c84a6c@chromium.org>
	<20241211091954.42a5c778@foz.lan>
	<CANiDSCsHk+QbF3BtrFU8G3UOgZZjTbQf4RhwkYCr+BeFiTYrEg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 11 Dec 2024 09:25:33 +0100
Ricardo Ribalda <ribalda@chromium.org> escreveu:

> [only Mauro]
> 
> On Wed, 11 Dec 2024 at 09:20, Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > Em Tue, 10 Dec 2024 19:56:04 +0000
> > Ricardo Ribalda <ribalda@chromium.org> escreveu:
> >  
> > > The ACPI headers have introduced implementations for some of their
> > > functions when the kernel is not configured with ACPI.
> > >
> > > Let's use them instead of our conditional compilation. It is easier to
> > > maintain and less prone to errors.
> > >
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > >  drivers/media/pci/intel/ipu-bridge.c | 28 +++++-----------------------
> > >  1 file changed, 5 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
> > > index be82bc3e27d0..1db994338fdf 100644
> > > --- a/drivers/media/pci/intel/ipu-bridge.c
> > > +++ b/drivers/media/pci/intel/ipu-bridge.c
> > > @@ -2,6 +2,7 @@
> > >  /* Author: Dan Scally <djrscally@gmail.com> */
> > >
> > >  #include <linux/acpi.h>
> > > +#include <acpi/acpi_bus.h>
> > >  #include <linux/cleanup.h>
> > >  #include <linux/device.h>
> > >  #include <linux/i2c.h>
> > > @@ -107,7 +108,6 @@ static const char * const ipu_vcm_types[] = {
> > >       "lc898212axb",
> > >  };
> > >
> > > -#if IS_ENABLED(CONFIG_ACPI)
> > >  /*
> > >   * Used to figure out IVSC acpi device by ipu_bridge_get_ivsc_acpi_dev()
> > >   * instead of device and driver match to probe IVSC device.
> > > @@ -127,11 +127,11 @@ static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev
> > >               const struct acpi_device_id *acpi_id = &ivsc_acpi_ids[i];
> > >               struct acpi_device *consumer, *ivsc_adev;
> > >
> > > -             acpi_handle handle = acpi_device_handle(adev);
> > > +             acpi_handle handle = acpi_device_handle(ACPI_PTR(adev));
> > >               for_each_acpi_dev_match(ivsc_adev, acpi_id->id, NULL, -1)
> > >                       /* camera sensor depends on IVSC in DSDT if exist */
> > >                       for_each_acpi_consumer_dev(ivsc_adev, consumer)
> > > -                             if (consumer->handle == handle) {
> > > +                             if (ACPI_PTR(consumer->handle) == handle) {
> > >                                       acpi_dev_put(consumer);
> > >                                       return ivsc_adev;
> > >                               }
> > > @@ -139,12 +139,6 @@ static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev
> > >
> > >       return NULL;
> > >  }
> > > -#else
> > > -static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev)
> > > -{
> > > -     return NULL;
> > > -}
> > > -#endif
> > >
> > >  static int ipu_bridge_match_ivsc_dev(struct device *dev, const void *adev)
> > >  {
> > > @@ -261,9 +255,8 @@ static enum v4l2_fwnode_orientation ipu_bridge_parse_orientation(struct acpi_dev
> > >       struct acpi_pld_info *pld = NULL;
> > >       acpi_status status = AE_ERROR;
> > >
> > > -#if IS_ENABLED(CONFIG_ACPI)
> > > -     status = acpi_get_physical_device_location(adev->handle, &pld);
> > > -#endif
> > > +     status = acpi_get_physical_device_location(ACPI_PTR(adev->handle),
> > > +                                                &pld);
> > >       if (ACPI_FAILURE(status)) {
> > >               dev_warn(ADEV_DEV(adev), "_PLD call failed, using default orientation\n");
> > >               return V4L2_FWNODE_ORIENTATION_EXTERNAL;
> > > @@ -498,9 +491,7 @@ static void ipu_bridge_create_connection_swnodes(struct ipu_bridge *bridge,
> > >       if (sensor->csi_dev) {
> > >               const char *device_hid = "";
> > >
> > > -#if IS_ENABLED(CONFIG_ACPI)
> > >               device_hid = acpi_device_hid(sensor->ivsc_adev);
> > > -#endif
> > >
> > >               snprintf(sensor->ivsc_name, sizeof(sensor->ivsc_name), "%s-%u",
> > >                        device_hid, sensor->link);
> > > @@ -671,11 +662,7 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
> > >       struct acpi_device *adev = NULL;
> > >       int ret;
> > >
> > > -#if IS_ENABLED(CONFIG_ACPI)
> > >       for_each_acpi_dev_match(adev, cfg->hid, NULL, -1) {
> > > -#else
> > > -     while (true) {
> > > -#endif
> > >               if (!ACPI_PTR(adev->status.enabled))
> > >                       continue;  
> >
> > Heh, that's what I pointed on patch 1: you don't need it there, as this
> > will be handled on patch 2.
> >  
> > >
> > > @@ -768,15 +755,10 @@ static int ipu_bridge_ivsc_is_ready(void)
> > >       unsigned int i;
> > >
> > >       for (i = 0; i < ARRAY_SIZE(ipu_supported_sensors); i++) {
> > > -#if IS_ENABLED(CONFIG_ACPI)
> > >               const struct ipu_sensor_config *cfg =
> > >                       &ipu_supported_sensors[i];
> > >
> > >               for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) {
> > > -#else
> > > -             while (false) {
> > > -                     sensor_adev = NULL;
> > > -#endif
> > >                       if (!ACPI_PTR(sensor_adev->status.enabled))
> > >                               continue;
> > >
> > >  
> >
> > Considering that you drop patch 1, and keep the ACPI dependencies
> > at the header, as proposed by patches 2-6:
> >
> > Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kerenel.org>  
> I will fix the typo in your email


Heh, slow start... I didn't take any caffeine today yet :-)

Thanks for noticing it!


Thanks,
Mauro

