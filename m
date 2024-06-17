Return-Path: <linux-acpi+bounces-6467-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EBE90BA44
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 20:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31BD41F22ACE
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 18:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E604F198843;
	Mon, 17 Jun 2024 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="s/KNjjMI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192D816A95C;
	Mon, 17 Jun 2024 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718650645; cv=none; b=bAGsdW7qoD3KwLauCz04rDRCpJoxcwzfwRsMP2igYNpmPLk9iUByTpKccPVO1YcyXyM6QHgx7e49QTXWHeIcAn5XRvgQCEQDv8wXgGX3MSwxM4spHAsTK8VVG4ieui87fhybsnF0sl/xtYi5wVwkHnbPNfjIAEyoJ1ZsIzzcMng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718650645; c=relaxed/simple;
	bh=5pv/xUugx1g0LQObPHQuHsZ/wg3alIZMiZM149zEcXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJYYa8BYCg75hk0hNqjoyE6l8SMDBx26OGyoiTZJUbHtBPKpJL4s0bpAX8Kd2FNP4LlK457iqrG+WUN7uuz9h/Fo8n8qdztNdGzij4VZw2vFMdGJ/7YaFR3juB9+5rVB35ynWaa8JqlxU4t4KkAtqqaVRLZkQagURazAsthLHOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=s/KNjjMI; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718650633;
	bh=5pv/xUugx1g0LQObPHQuHsZ/wg3alIZMiZM149zEcXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s/KNjjMIIP1DSQoyCQd+3YxICvkEyX/KeX2ELz/6C2k3XsliHzwVKSGqGtdhss5Fy
	 8npYjzlG27luZ0ttPTeDWxlWrZQpqNAyQVZMpGsU0NSzKtmmxCNxMQnkA3gw1cG6Md
	 ReBNizpNmbdENEoLbCFe+ylf9AJWeXp+nKWmNlSQ=
Date: Mon, 17 Jun 2024 20:57:10 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH 1/5] ACPI: sysfs: convert utf-16 from _STR to utf-8 only
 once
Message-ID: <7c0d3358-eb1f-4c71-8a09-52b5e7668e36@t-8ch.de>
References: <20240613-acpi-sysfs-groups-v1-0-665e0deb052a@weissschuh.net>
 <20240613-acpi-sysfs-groups-v1-1-665e0deb052a@weissschuh.net>
 <CAJZ5v0iHB1X7WM6Lg_-vr3Kzwp65yqjvHG9CA_X8vqFBFV_F_A@mail.gmail.com>
 <CAJZ5v0gmHPBS3LE+Eo8yJkvpuavBvip-1AEEEf9nxAp2gi_adQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gmHPBS3LE+Eo8yJkvpuavBvip-1AEEEf9nxAp2gi_adQ@mail.gmail.com>

On 2024-06-17 20:43:03+0000, Rafael J. Wysocki wrote:
> On Mon, Jun 17, 2024 at 8:37 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Jun 13, 2024 at 10:15 PM Thomas Weißschuh <linux@weissschuh.net> wrote:
> > >
> > > The ACPI _STR method returns an UTF-16 string that is converted to utf-8
> > > before printing it in sysfs.
> > > Currently this conversion is performed every time the "description"
> > > sysfs attribute is read, which is not necessary.
> >
> > Why is it a problem, though?

It's not a real problem, mostly it made the following changes simpler.

> > How many devices have _STR and how much of the time is it used?
> >
> > Hint: On the system I'm sitting in front of, the answer is 0 and never.
> 
> This was actually factually incorrect, sorry.
> 
> The correct answer is 12 out of 247 and very rarely (if at all).
> Which doesn't really change the point IMO.
> 
> > So Is it really worth adding an _STR string pointer to every struct acpi_device?

The string pointer replaces a 'union acpi_object *str_obj', so no new
space is used.
Also in case the device _STR is present the new code uses less memory, as
it doesn't need the full union and stores utf-8 instead of utf-16.
(Plus a few more cycles for the preemptive conversion)

In case no _STR is present both CPU and memory costs are identical.

Anyways, I don't really care about this and can also try to drop this
patch if you prefer.
Or drop the 'union acpi_device *' from the struct completely at your
preference.

> > > Only perform the conversion once and cache the result.
> > >
> > > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > > ---
> > >  drivers/acpi/device_sysfs.c | 63 ++++++++++++++++++++++++++++-----------------
> > >  include/acpi/acpi_bus.h     |  2 +-
> > >  2 files changed, 40 insertions(+), 25 deletions(-)
> >
> > And it's more lines of code even.
> >
> > >
> > > diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> > > index 23373faa35ec..4bedbe8f57ed 100644
> > > --- a/drivers/acpi/device_sysfs.c
> > > +++ b/drivers/acpi/device_sysfs.c
> > > @@ -439,24 +439,11 @@ static ssize_t description_show(struct device *dev,
> > >                                 char *buf)
> > >  {
> > >         struct acpi_device *acpi_dev = to_acpi_device(dev);
> > > -       int result;
> > >
> > > -       if (acpi_dev->pnp.str_obj == NULL)
> > > +       if (acpi_dev->pnp.str == NULL)
> > >                 return 0;
> > >
> > > -       /*
> > > -        * The _STR object contains a Unicode identifier for a device.
> > > -        * We need to convert to utf-8 so it can be displayed.
> > > -        */
> > > -       result = utf16s_to_utf8s(
> > > -               (wchar_t *)acpi_dev->pnp.str_obj->buffer.pointer,
> > > -               acpi_dev->pnp.str_obj->buffer.length,
> > > -               UTF16_LITTLE_ENDIAN, buf,
> > > -               PAGE_SIZE - 1);
> > > -
> > > -       buf[result++] = '\n';
> > > -
> > > -       return result;
> > > +       return sysfs_emit("%s\n", acpi_dev->pnp.str);
> > >  }
> > >  static DEVICE_ATTR_RO(description);
> > >
> > > @@ -507,14 +494,46 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
> > >  }
> > >  static DEVICE_ATTR_RO(status);
> > >
> > > +static const char *acpi_device_str(struct acpi_device *dev)
> > > +{
> > > +       struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> > > +       union acpi_object *str_obj;
> > > +       acpi_status status;
> > > +       const char *ret;
> > > +       char buf[512];
> > > +       int result;
> > > +
> > > +       if (!acpi_has_method(dev->handle, "_STR"))
> > > +               return NULL;
> > > +
> > > +       status = acpi_evaluate_object(dev->handle, "_STR",
> > > +                                     NULL, &buffer);
> > > +       if (ACPI_FAILURE(status))
> > > +               return NULL;
> > > +
> > > +       str_obj = buffer.pointer;
> > > +       /*
> > > +        * The _STR object contains a Unicode identifier for a device.
> > > +        * We need to convert to utf-8 so it can be displayed.
> > > +        */
> > > +       result = utf16s_to_utf8s((wchar_t *)str_obj->buffer.pointer,
> > > +                                str_obj->buffer.length,
> > > +                                UTF16_LITTLE_ENDIAN,
> > > +                                buf, sizeof(buf) - 1);
> > > +       buf[result++] = '\0';
> > > +
> > > +       ret = kstrdup(buf, GFP_KERNEL);
> > > +       kfree(buffer.pointer);
> > > +
> > > +       return ret;
> > > +}
> > > +
> > >  /**
> > >   * acpi_device_setup_files - Create sysfs attributes of an ACPI device.
> > >   * @dev: ACPI device object.
> > >   */
> > >  int acpi_device_setup_files(struct acpi_device *dev)
> > >  {
> > > -       struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> > > -       acpi_status status;
> > >         int result = 0;
> > >
> > >         /*
> > > @@ -539,12 +558,8 @@ int acpi_device_setup_files(struct acpi_device *dev)
> > >         /*
> > >          * If device has _STR, 'description' file is created
> > >          */
> > > -       if (acpi_has_method(dev->handle, "_STR")) {
> > > -               status = acpi_evaluate_object(dev->handle, "_STR",
> > > -                                       NULL, &buffer);
> > > -               if (ACPI_FAILURE(status))
> > > -                       buffer.pointer = NULL;
> > > -               dev->pnp.str_obj = buffer.pointer;
> > > +       dev->pnp.str = acpi_device_str(dev);
> > > +       if (dev->pnp.str) {
> > >                 result = device_create_file(&dev->dev, &dev_attr_description);
> > >                 if (result)
> > >                         goto end;
> > > @@ -618,7 +633,7 @@ void acpi_device_remove_files(struct acpi_device *dev)
> > >          * If device has _STR, remove 'description' file
> > >          */
> > >         if (acpi_has_method(dev->handle, "_STR")) {
> > > -               kfree(dev->pnp.str_obj);
> > > +               kfree(dev->pnp.str);
> > >                 device_remove_file(&dev->dev, &dev_attr_description);
> > >         }
> > >         /*
> > > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > > index 1a4dfd7a1c4a..32e3105c9ece 100644
> > > --- a/include/acpi/acpi_bus.h
> > > +++ b/include/acpi/acpi_bus.h
> > > @@ -254,7 +254,7 @@ struct acpi_device_pnp {
> > >         struct list_head ids;           /* _HID and _CIDs */
> > >         acpi_device_name device_name;   /* Driver-determined */
> > >         acpi_device_class device_class; /*        "          */
> > > -       union acpi_object *str_obj;     /* unicode string for _STR method */
> > > +       const char *str;                /* _STR */
> > >  };
> > >
> > >  #define acpi_device_bid(d)     ((d)->pnp.bus_id)
> > >
> > > --
> > > 2.45.2
> > >
> > >

