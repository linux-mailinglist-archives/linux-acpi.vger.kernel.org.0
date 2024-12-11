Return-Path: <linux-acpi+bounces-10084-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00A19EC711
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 09:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD9716A0F0
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 08:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FEF1DC9AF;
	Wed, 11 Dec 2024 08:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fZ+Dd2pm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7791D88D5
	for <linux-acpi@vger.kernel.org>; Wed, 11 Dec 2024 08:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905549; cv=none; b=XhezmFjBKx3SeWdSsi546UAVhs0k2AdO93sw9zg5nH9MXNaJLOtaiiAnHP4Zsi4ynhLTArkY+GH5sF8/BlgLC3zSql/B+ViFJu9/EfAiB0rQiblDHNJGDdhSRLYP2cN98B/DwoZ5YFV7Ga64YORyUpE7g5/jsKMEd7FRkGFiFuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905549; c=relaxed/simple;
	bh=pbxla0yTksNMB/yfJqiplYk5I6ztCJkCMOXdq941Wsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r1XPyhg9nfi7/ns7MDlQlEFgbmf4K2Ih68DYz6O9Qm5FgIXP6wDxIWjQm2Km/fs6SBF0Ql/kxgM1kIDVctrtrYoWIMSC9bAkm/oR94JYIEU03/iQfiZo5ZpnzqgMwQPcUCdAoWtMSLhjhQeyZWor2I4znGK7x4E5NqvtYBeAE5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fZ+Dd2pm; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21680814d42so10034215ad.2
        for <linux-acpi@vger.kernel.org>; Wed, 11 Dec 2024 00:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733905547; x=1734510347; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aMeiDMRxTxRMOSHecISft1Z76qFjuaNBQ/+kSc1K3bY=;
        b=fZ+Dd2pmmUpiTBk0/eIcQVQ9i1Q1A5CplgX7CnVSSVU1Hrt8A2AYxb8pM3Q4N4h33/
         8EzRcKS6wYGmoGQm+5Gm47ElHWEMHSaewkm4lufOuM2xqQ/QMU42xGzIceb/jxQj6KJu
         U8NRVr6BImViAjPmYkd/gRcuQpq8XcWzOPDMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733905547; x=1734510347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMeiDMRxTxRMOSHecISft1Z76qFjuaNBQ/+kSc1K3bY=;
        b=OJF2mW7yL5KD3jrxhodvcumP7njnKGG7oPo9ZrgQwyrxvjh10SMf6cIyqbnDGvJkO9
         qWz3vjup4ZrFxlo4IV2UJuXNSVlef+Aog3WmXt4jQHsxCC1RwO804EdoSDtzDwiZLN2I
         ePOA6+ytiaNss4fCieNOwRmPMo1tmwvBDOAKKIBqTtXhYk+fzURmk/A7VU6jpixYnnZk
         zk/pK/ZNdBEvo6LDWj6rJEYbFvjDc5tT4XREEQiOq3sevDpKMi+fSVYGPe4MoKDkfp9P
         7F/czW6TNzv1YQvfn3fsfntJQq2KT2chy3MhhZqhFWAIIc42ZB8Lw3B2xYUZgvJ5BnxD
         w4RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXcZYMWRTB10OKk2rPieXerJef4GK0oa1TbBXaBzpM2bAUOjTMZ+00iq2X+Q4n4vMbsAZ9Wt5gw+72@vger.kernel.org
X-Gm-Message-State: AOJu0YzOO/6ZL0kQ+MrUdUsUE7M0z9SfHwx8DvmuM9LgX534JV066VkO
	M24W4CeSFjEOoePiEpkmoWlccCa4djYFbJ7K7ExsnxZfmadZQmyKTOxHn4iAMkqckqBk5Y39zDA
	=
X-Gm-Gg: ASbGnctURU2oNFQNpf4NzEak+8DanHJLpKOsgBPkR4tnDSdo7YoRfAcJnp8uC89x2w5
	9aTpAZyTySJYx9Aq2qbcWwwl9e9d/oEB84mgffL9P+UKUZSgDKW/LlKFJTR5m2njAdbkGXJa/kF
	IzEijfVudUxZCIPPuF0ASAmF8m+OzEgkZrPSaebEvINRhND2czULFKSkzBjYw+Xk4Zj3dZJ0nMj
	YNpQ0HeZZ1m476a1Y+yEtHxFJY3TaB1B0l/A66D1Snh/EpiL41ruSotM6iyHPMMhNpGiODLqSEn
	XiRg18d0QLHTgERd
X-Google-Smtp-Source: AGHT+IFpjKKXapJUmuQ+92DavsU0IT7GbCHpvMCdI8nq0FpkhXif4t84vCOR5Y/HH5xD+uTTmT/Tag==
X-Received: by 2002:a17:902:e74e:b0:215:9d29:9724 with SMTP id d9443c01a7336-21778590f41mr33997865ad.38.1733905547086;
        Wed, 11 Dec 2024 00:25:47 -0800 (PST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com. [209.85.216.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2162a47a0d7sm70332415ad.114.2024.12.11.00.25.46
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 00:25:46 -0800 (PST)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso3134173a91.1
        for <linux-acpi@vger.kernel.org>; Wed, 11 Dec 2024 00:25:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUCVrF0oknBSC+VibgS4uL/Zs0WLjbdWlfxqRtzllbo7bFtTfS1mKBg5n7aFCIUM2YZSveYJIRPn8IA@vger.kernel.org
X-Received: by 2002:a17:90b:1650:b0:2ee:a4f2:b311 with SMTP id
 98e67ed59e1d1-2f127f55cacmr3203942a91.8.1733905545661; Wed, 11 Dec 2024
 00:25:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-7-00e409c84a6c@chromium.org> <20241211091954.42a5c778@foz.lan>
In-Reply-To: <20241211091954.42a5c778@foz.lan>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 11 Dec 2024 09:25:33 +0100
X-Gmail-Original-Message-ID: <CANiDSCsHk+QbF3BtrFU8G3UOgZZjTbQf4RhwkYCr+BeFiTYrEg@mail.gmail.com>
X-Gm-Features: AZHOrDlU23tnNgp0likxdl9TeO5EWHsYT3mOqJQICrAuiOLJ0FM89Lhe827RLJA
Message-ID: <CANiDSCsHk+QbF3BtrFU8G3UOgZZjTbQf4RhwkYCr+BeFiTYrEg@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] media: ipu-bridge: Remove unneeded conditional compilations
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

[only Mauro]

On Wed, 11 Dec 2024 at 09:20, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Tue, 10 Dec 2024 19:56:04 +0000
> Ricardo Ribalda <ribalda@chromium.org> escreveu:
>
> > The ACPI headers have introduced implementations for some of their
> > functions when the kernel is not configured with ACPI.
> >
> > Let's use them instead of our conditional compilation. It is easier to
> > maintain and less prone to errors.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/pci/intel/ipu-bridge.c | 28 +++++-----------------------
> >  1 file changed, 5 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
> > index be82bc3e27d0..1db994338fdf 100644
> > --- a/drivers/media/pci/intel/ipu-bridge.c
> > +++ b/drivers/media/pci/intel/ipu-bridge.c
> > @@ -2,6 +2,7 @@
> >  /* Author: Dan Scally <djrscally@gmail.com> */
> >
> >  #include <linux/acpi.h>
> > +#include <acpi/acpi_bus.h>
> >  #include <linux/cleanup.h>
> >  #include <linux/device.h>
> >  #include <linux/i2c.h>
> > @@ -107,7 +108,6 @@ static const char * const ipu_vcm_types[] = {
> >       "lc898212axb",
> >  };
> >
> > -#if IS_ENABLED(CONFIG_ACPI)
> >  /*
> >   * Used to figure out IVSC acpi device by ipu_bridge_get_ivsc_acpi_dev()
> >   * instead of device and driver match to probe IVSC device.
> > @@ -127,11 +127,11 @@ static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev
> >               const struct acpi_device_id *acpi_id = &ivsc_acpi_ids[i];
> >               struct acpi_device *consumer, *ivsc_adev;
> >
> > -             acpi_handle handle = acpi_device_handle(adev);
> > +             acpi_handle handle = acpi_device_handle(ACPI_PTR(adev));
> >               for_each_acpi_dev_match(ivsc_adev, acpi_id->id, NULL, -1)
> >                       /* camera sensor depends on IVSC in DSDT if exist */
> >                       for_each_acpi_consumer_dev(ivsc_adev, consumer)
> > -                             if (consumer->handle == handle) {
> > +                             if (ACPI_PTR(consumer->handle) == handle) {
> >                                       acpi_dev_put(consumer);
> >                                       return ivsc_adev;
> >                               }
> > @@ -139,12 +139,6 @@ static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev
> >
> >       return NULL;
> >  }
> > -#else
> > -static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev)
> > -{
> > -     return NULL;
> > -}
> > -#endif
> >
> >  static int ipu_bridge_match_ivsc_dev(struct device *dev, const void *adev)
> >  {
> > @@ -261,9 +255,8 @@ static enum v4l2_fwnode_orientation ipu_bridge_parse_orientation(struct acpi_dev
> >       struct acpi_pld_info *pld = NULL;
> >       acpi_status status = AE_ERROR;
> >
> > -#if IS_ENABLED(CONFIG_ACPI)
> > -     status = acpi_get_physical_device_location(adev->handle, &pld);
> > -#endif
> > +     status = acpi_get_physical_device_location(ACPI_PTR(adev->handle),
> > +                                                &pld);
> >       if (ACPI_FAILURE(status)) {
> >               dev_warn(ADEV_DEV(adev), "_PLD call failed, using default orientation\n");
> >               return V4L2_FWNODE_ORIENTATION_EXTERNAL;
> > @@ -498,9 +491,7 @@ static void ipu_bridge_create_connection_swnodes(struct ipu_bridge *bridge,
> >       if (sensor->csi_dev) {
> >               const char *device_hid = "";
> >
> > -#if IS_ENABLED(CONFIG_ACPI)
> >               device_hid = acpi_device_hid(sensor->ivsc_adev);
> > -#endif
> >
> >               snprintf(sensor->ivsc_name, sizeof(sensor->ivsc_name), "%s-%u",
> >                        device_hid, sensor->link);
> > @@ -671,11 +662,7 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
> >       struct acpi_device *adev = NULL;
> >       int ret;
> >
> > -#if IS_ENABLED(CONFIG_ACPI)
> >       for_each_acpi_dev_match(adev, cfg->hid, NULL, -1) {
> > -#else
> > -     while (true) {
> > -#endif
> >               if (!ACPI_PTR(adev->status.enabled))
> >                       continue;
>
> Heh, that's what I pointed on patch 1: you don't need it there, as this
> will be handled on patch 2.
>
> >
> > @@ -768,15 +755,10 @@ static int ipu_bridge_ivsc_is_ready(void)
> >       unsigned int i;
> >
> >       for (i = 0; i < ARRAY_SIZE(ipu_supported_sensors); i++) {
> > -#if IS_ENABLED(CONFIG_ACPI)
> >               const struct ipu_sensor_config *cfg =
> >                       &ipu_supported_sensors[i];
> >
> >               for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) {
> > -#else
> > -             while (false) {
> > -                     sensor_adev = NULL;
> > -#endif
> >                       if (!ACPI_PTR(sensor_adev->status.enabled))
> >                               continue;
> >
> >
>
> Considering that you drop patch 1, and keep the ACPI dependencies
> at the header, as proposed by patches 2-6:
>
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kerenel.org>
I will fix the typo in your email


>
> Thanks,
> Mauro



-- 
Ricardo Ribalda

