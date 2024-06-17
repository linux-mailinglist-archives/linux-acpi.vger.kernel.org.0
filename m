Return-Path: <linux-acpi+bounces-6466-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1748E90B9F5
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 20:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B410628201C
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 18:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939EE197A62;
	Mon, 17 Jun 2024 18:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qa9djcRu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D634178387;
	Mon, 17 Jun 2024 18:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718649796; cv=none; b=byYxv3bQPlXNH8XZBKWmaY7lTPeEoSaTIZDYFoKCRiVVV9JgzHByAF7upnqjO4dHf/9D3r8Z+XGg20Ub8THfT0NVQ8DF2VtmY5OS7SBSovnY+hV1Nc1yhgGIb2BOGp42t0Wxil92tRqrWiEHKuYpqxbI5tPErQZVfZq9xXhwYHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718649796; c=relaxed/simple;
	bh=V0ku5sxdL8qo384e1iG5kKYdsUFz8tB9PL/67myO7kA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rqt6Z7z9LjxZHOVcj9cuRedwC2Da87sTS1lGzFvPW//vogvh7q8yStW6eJdJS1pi4uX7Xuf2oLcKs5t25q0WtFdqh2vxed8YzE5zX+BIR/T9PGx51y7GrUil0OykJW8UewYbOB0qg9N8rn82TzpTpmfJPFTfHzvZx20nrrT/WYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qa9djcRu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F591C4AF1C;
	Mon, 17 Jun 2024 18:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718649796;
	bh=V0ku5sxdL8qo384e1iG5kKYdsUFz8tB9PL/67myO7kA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qa9djcRueWKcaNGYiIHiwMLF1J0ZV+pF29DnsG0cO16kCT/XPX5FN5kFbiPELQQTx
	 R7N4dT/3XkLdM2LlSIgLRIKLM8HMDvZEwfdz+eJz8jJ9bSgyOM03mAk1Cq8NU5OE2T
	 Ehslhc1mwinSx1YksCRukAuagnMX7Bq3OIQmfGTqtV7x8Il1uNfy8TMZ2qotVm4HZU
	 /f0t/GgBvSAmhxrsZuYxjoMyjCilsEZRr4QMeTZ35WrEEDzSRy42T74iJJgtyFUunc
	 l9FoRJbdy6BKmstdiCipKrAGTJho7i/j0I9yiQdlzV0SdfAg51E4t7hI6WJWPyhtvs
	 vVuadv1fsY3QA==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f98e321a8aso128406a34.3;
        Mon, 17 Jun 2024 11:43:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDFYP1l6pO7aU+SGGynnNYQvkQL/+k9tumIyB0qZR+nQlVXdVHyyL2gQXzPaQ+RIogsiUDxLg+csWkYVNRYqPzd7vli6/BGZW2ttQ6iU+c5LK8cWdmhIwKGpnCBgPdBSZAsjYHiF4UwQ==
X-Gm-Message-State: AOJu0YwEu5a7wlzTipUY5Fhi92hzIiqVYzPtvAh7169C0jHeg7kTauJf
	lJJwSu3dc8Piu+HWc6vav7T9tvhNFbNs+FSAhjaF2IazYbG+pXiLsHrd/CBm/ucL7eKn4bn4yau
	b9mbcvMPGFqNdVcRkXw9Q5vAi19Y=
X-Google-Smtp-Source: AGHT+IHFvMDDR3EP9d6d3cAPgTivz/ja/DXVGoxUkeRpGuN+toQyEFczK7wQaj+Ix05m2DqUkxzOVjcsAWXqTpTv7RE=
X-Received: by 2002:a05:6820:287:b0:5ba:ca8a:6598 with SMTP id
 006d021491bc7-5bdad9f3131mr10530296eaf.0.1718649795206; Mon, 17 Jun 2024
 11:43:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613-acpi-sysfs-groups-v1-0-665e0deb052a@weissschuh.net>
 <20240613-acpi-sysfs-groups-v1-1-665e0deb052a@weissschuh.net> <CAJZ5v0iHB1X7WM6Lg_-vr3Kzwp65yqjvHG9CA_X8vqFBFV_F_A@mail.gmail.com>
In-Reply-To: <CAJZ5v0iHB1X7WM6Lg_-vr3Kzwp65yqjvHG9CA_X8vqFBFV_F_A@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 17 Jun 2024 20:43:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gmHPBS3LE+Eo8yJkvpuavBvip-1AEEEf9nxAp2gi_adQ@mail.gmail.com>
Message-ID: <CAJZ5v0gmHPBS3LE+Eo8yJkvpuavBvip-1AEEEf9nxAp2gi_adQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] ACPI: sysfs: convert utf-16 from _STR to utf-8 only once
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 8:37=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Jun 13, 2024 at 10:15=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@wei=
ssschuh.net> wrote:
> >
> > The ACPI _STR method returns an UTF-16 string that is converted to utf-=
8
> > before printing it in sysfs.
> > Currently this conversion is performed every time the "description"
> > sysfs attribute is read, which is not necessary.
>
> Why is it a problem, though?
>
> How many devices have _STR and how much of the time is it used?
>
> Hint: On the system I'm sitting in front of, the answer is 0 and never.

This was actually factually incorrect, sorry.

The correct answer is 12 out of 247 and very rarely (if at all).
Which doesn't really change the point IMO.

> So Is it really worth adding an _STR string pointer to every struct acpi_=
device?
>
> > Only perform the conversion once and cache the result.
> >
> > Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> > ---
> >  drivers/acpi/device_sysfs.c | 63 ++++++++++++++++++++++++++++---------=
--------
> >  include/acpi/acpi_bus.h     |  2 +-
> >  2 files changed, 40 insertions(+), 25 deletions(-)
>
> And it's more lines of code even.
>
> >
> > diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> > index 23373faa35ec..4bedbe8f57ed 100644
> > --- a/drivers/acpi/device_sysfs.c
> > +++ b/drivers/acpi/device_sysfs.c
> > @@ -439,24 +439,11 @@ static ssize_t description_show(struct device *de=
v,
> >                                 char *buf)
> >  {
> >         struct acpi_device *acpi_dev =3D to_acpi_device(dev);
> > -       int result;
> >
> > -       if (acpi_dev->pnp.str_obj =3D=3D NULL)
> > +       if (acpi_dev->pnp.str =3D=3D NULL)
> >                 return 0;
> >
> > -       /*
> > -        * The _STR object contains a Unicode identifier for a device.
> > -        * We need to convert to utf-8 so it can be displayed.
> > -        */
> > -       result =3D utf16s_to_utf8s(
> > -               (wchar_t *)acpi_dev->pnp.str_obj->buffer.pointer,
> > -               acpi_dev->pnp.str_obj->buffer.length,
> > -               UTF16_LITTLE_ENDIAN, buf,
> > -               PAGE_SIZE - 1);
> > -
> > -       buf[result++] =3D '\n';
> > -
> > -       return result;
> > +       return sysfs_emit("%s\n", acpi_dev->pnp.str);
> >  }
> >  static DEVICE_ATTR_RO(description);
> >
> > @@ -507,14 +494,46 @@ static ssize_t status_show(struct device *dev, st=
ruct device_attribute *attr,
> >  }
> >  static DEVICE_ATTR_RO(status);
> >
> > +static const char *acpi_device_str(struct acpi_device *dev)
> > +{
> > +       struct acpi_buffer buffer =3D {ACPI_ALLOCATE_BUFFER, NULL};
> > +       union acpi_object *str_obj;
> > +       acpi_status status;
> > +       const char *ret;
> > +       char buf[512];
> > +       int result;
> > +
> > +       if (!acpi_has_method(dev->handle, "_STR"))
> > +               return NULL;
> > +
> > +       status =3D acpi_evaluate_object(dev->handle, "_STR",
> > +                                     NULL, &buffer);
> > +       if (ACPI_FAILURE(status))
> > +               return NULL;
> > +
> > +       str_obj =3D buffer.pointer;
> > +       /*
> > +        * The _STR object contains a Unicode identifier for a device.
> > +        * We need to convert to utf-8 so it can be displayed.
> > +        */
> > +       result =3D utf16s_to_utf8s((wchar_t *)str_obj->buffer.pointer,
> > +                                str_obj->buffer.length,
> > +                                UTF16_LITTLE_ENDIAN,
> > +                                buf, sizeof(buf) - 1);
> > +       buf[result++] =3D '\0';
> > +
> > +       ret =3D kstrdup(buf, GFP_KERNEL);
> > +       kfree(buffer.pointer);
> > +
> > +       return ret;
> > +}
> > +
> >  /**
> >   * acpi_device_setup_files - Create sysfs attributes of an ACPI device=
.
> >   * @dev: ACPI device object.
> >   */
> >  int acpi_device_setup_files(struct acpi_device *dev)
> >  {
> > -       struct acpi_buffer buffer =3D {ACPI_ALLOCATE_BUFFER, NULL};
> > -       acpi_status status;
> >         int result =3D 0;
> >
> >         /*
> > @@ -539,12 +558,8 @@ int acpi_device_setup_files(struct acpi_device *de=
v)
> >         /*
> >          * If device has _STR, 'description' file is created
> >          */
> > -       if (acpi_has_method(dev->handle, "_STR")) {
> > -               status =3D acpi_evaluate_object(dev->handle, "_STR",
> > -                                       NULL, &buffer);
> > -               if (ACPI_FAILURE(status))
> > -                       buffer.pointer =3D NULL;
> > -               dev->pnp.str_obj =3D buffer.pointer;
> > +       dev->pnp.str =3D acpi_device_str(dev);
> > +       if (dev->pnp.str) {
> >                 result =3D device_create_file(&dev->dev, &dev_attr_desc=
ription);
> >                 if (result)
> >                         goto end;
> > @@ -618,7 +633,7 @@ void acpi_device_remove_files(struct acpi_device *d=
ev)
> >          * If device has _STR, remove 'description' file
> >          */
> >         if (acpi_has_method(dev->handle, "_STR")) {
> > -               kfree(dev->pnp.str_obj);
> > +               kfree(dev->pnp.str);
> >                 device_remove_file(&dev->dev, &dev_attr_description);
> >         }
> >         /*
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index 1a4dfd7a1c4a..32e3105c9ece 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -254,7 +254,7 @@ struct acpi_device_pnp {
> >         struct list_head ids;           /* _HID and _CIDs */
> >         acpi_device_name device_name;   /* Driver-determined */
> >         acpi_device_class device_class; /*        "          */
> > -       union acpi_object *str_obj;     /* unicode string for _STR meth=
od */
> > +       const char *str;                /* _STR */
> >  };
> >
> >  #define acpi_device_bid(d)     ((d)->pnp.bus_id)
> >
> > --
> > 2.45.2
> >
> >

