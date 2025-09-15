Return-Path: <linux-acpi+bounces-16951-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78575B58335
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 19:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EEFF4C0F53
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 17:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57C2298CDE;
	Mon, 15 Sep 2025 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZOY1AjZf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B4B28B4F0
	for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2025 17:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757956492; cv=none; b=ibeA3UOD7VCoa2jVy6Z7PfiCOktpvFcNsBKBz2EJa4SMyoN9q7Upu9LIibTjY4B13xTglokF1BRnBjXTqGS7ne9gPjf7Bit3B8/Bj7EeUEoxETYlz4J3Vp2YnjkASznrxmkGFipylXIFGWYIEhWLUfhOnjGhwldRn88ybTX94/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757956492; c=relaxed/simple;
	bh=57ceu26JUiHiqcScAKJWVpvwcLHU1hQlLrs2e7+VIlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmq67Le1MwgAxLXe9R+0pKjW/I9q8AlZxg22GOBXO/DtWZX46EmAZ7AQqxVEnGKiksnTJ0w9Uv+u2dok+0aWx00B+3VQjvbZuz7staLH9Utbh67xZBMvxOkJ3iaNCo+Jl+b6M7jR3VongqIwmcngejMFWDegdcaeBTFUrfRbIbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZOY1AjZf; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so5347928a12.1
        for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2025 10:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757956489; x=1758561289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiFx6cbWZLqYgj+ebeWVAqgHimLLBo5NU/io3AMrOm4=;
        b=ZOY1AjZfzhMlgWRiiQaeZDMdiVvVp49pq0u9HjdGqMZs4nMax785ZD+NHDcmW8IoRo
         PhuV5FuHUWs56+rwKsO+H39Tk1YZtPp9Ws2JBSyE9bM4ABvXWjcisRoPuyJXjdrz+w3N
         ln2iPsB6ICN8BIy2rk9D3xjiXeDjzUkgrMlFQTh7i9hFuI9fj3xfZWooBfOZqb/hSL4e
         BaWAurdlwLOuYKTGab34UTIUhXYbPaSVlagmtxTQ0CVYcPY7Ytex3g0ZGAZaXkAlAlUm
         ybxVQmf83RzrE8i0xRaIKOvFydm6JCyOcgkXk3CO/bEoYa9OEz5Vci6UIJuSTac/bD54
         uI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757956489; x=1758561289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiFx6cbWZLqYgj+ebeWVAqgHimLLBo5NU/io3AMrOm4=;
        b=Ky31XVEFu7eBa2I78hMnwk8Ekt7IyCUFoVyVv9sdGi1XrrKjKLHJ0YIzx5x/6ejnxs
         R2X0288O1Kv0w0TZiVqz2HkFkw3WNXAojecK2Idr1HeEqxTTzMCY8lAcNHhYqsLnsoUO
         uPPuPYwI8VBwWG7K1sGVzwi1aQ+GGIQ8EsxboPW5L9sNYO19Vo4xDxJqh3YPAoDeu17T
         Db93iDBBlvgXOYEMVZ/QBvXkaggQ0Ua/VUy/Qssit/6qNTIy+c+6ZIh2JQjLHq3O8zGK
         asBnB+LYqDK+s/j7+dllIcXNd/UE3URIvejlDaHoMmlwQf0zI/te2QyirAfjmuO9YA0w
         c/tg==
X-Forwarded-Encrypted: i=1; AJvYcCXlC3+sbq7AfJuh9JwrnDGsRtgvsNEZJj6N2b8YhJL9OuNyFzvlYBj+VAqrGgEMaLyu2nntiWzgzF+G@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4wZNxw8pcj6OWknr0GO/GgCxe+09/KPMhGG47l9VenmLNXqyx
	SvkJ8H/V46T36+y3duyQfrmAlKd6efnnyoqDnyuGr0Ph4PCsGRFF7i4KUI3UyPYyE0EIdiNalor
	ITMMeDGEjdez/jRO2xrgpkNeOprDt1GF6FhQWFjxz
X-Gm-Gg: ASbGncsum8Zu/khNDGTOg3DbCVXXz4dT/kv+LF8feYUdWguM9WDAn6+MdDo2EXQDkNG
	6zr0xz4iCJNL7wjI4OBgdv3zKUS1ECnVh9gT+ISFL60jPVpIklMHipLIfn8jFPGsbQQWmzBA/VA
	qvBjaTdw2Bt5eWgqkrq0m95eFCyEiPF5yTeJuHWcUV0QhG+IWXQACP4LWypHXjAeDCLOvzyr/u7
	821qrP5NHzN64iNnsh+AWJUn3RNocmEFY/xoKyEzKa8
X-Google-Smtp-Source: AGHT+IHpzoYhWuy+mbmNAGjX99iKMPyZ0Pjnitc+0cWgikQBOzGoC1C+1zBXvte4GTlWj91lAeyRLwOih4QT2iXr7A4=
X-Received: by 2002:a05:6402:46c6:b0:62c:9c9c:fec2 with SMTP id
 4fb4d7f45d1cf-62ed82407d5mr12151057a12.6.1757956488775; Mon, 15 Sep 2025
 10:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830053404.763995-1-srosek@google.com> <20250830053404.763995-12-srosek@google.com>
 <c6f2b153-b783-4087-b7e4-30ca207b7572@kernel.org>
In-Reply-To: <c6f2b153-b783-4087-b7e4-30ca207b7572@kernel.org>
From: =?UTF-8?Q?S=C5=82awomir_Rosek?= <srosek@google.com>
Date: Mon, 15 Sep 2025 19:14:37 +0200
X-Gm-Features: AS18NWDmZyMWNu_bpVwetpBiBtZSa6wW1YIdsTUIKiqgEZ7PmsQe16tDVSuggPY
Message-ID: <CAF3aWvGt69Lo1xKLBb8_DVu-+RYe9Lq4BnAm4T68VZ-5GsAorw@mail.gmail.com>
Subject: Re: [PATCH v1 11/12] ACPI: platform: Add macro for acpi platform driver
To: Hans de Goede <hansg@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Alex Hung <alexhung@gmail.com>, 
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, AceLan Kao <acelan.kao@canonical.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hans,

First of all I would like to apologize for the late reply and thank
you for your comments.

On Sat, Aug 30, 2025 at 5:13=E2=80=AFPM Hans de Goede <hansg@kernel.org> wr=
ote:
>
> Hi Slawomir,
>
> On 30-Aug-25 7:34 AM, Slawomir Rosek wrote:
> > Introduce module_acpi_platform_driver() macro to simplify dynamic
> > enumeration of ACPI device objects on the platform bus by loadable
> > modules. Move common code from the intel-hid and intel-vbtn drivers
> > to the ACPI platform core.
> >
> > Signed-off-by: Slawomir Rosek <srosek@google.com>
>
> Thank you for your interesting patch.
>
> > ---
> >  drivers/acpi/acpi_platform.c      | 27 ++++++++++++++++++++
> >  drivers/platform/x86/intel/hid.c  | 41 +------------------------------
> >  drivers/platform/x86/intel/vbtn.c | 30 +---------------------
> >  include/linux/platform_device.h   | 17 +++++++++++++
> >  4 files changed, 46 insertions(+), 69 deletions(-)
> >
> > diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.=
c
> > index 48d15dd785f6..adf32ffa6be6 100644
> > --- a/drivers/acpi/acpi_platform.c
> > +++ b/drivers/acpi/acpi_platform.c
> > @@ -190,6 +190,33 @@ struct platform_device *acpi_create_platform_devic=
e(struct acpi_device *adev,
> >  }
> >  EXPORT_SYMBOL_GPL(acpi_create_platform_device);
> >
> > +static acpi_status
> > +__acpi_platform_driver_register_cb(acpi_handle handle, u32 lvl,
> > +                             void *context, void **rv)
> > +{
> > +     const struct acpi_device_id *ids =3D context;
> > +     struct acpi_device *dev =3D acpi_fetch_acpi_dev(handle);
> > +
> > +     if (dev && acpi_match_device_ids(dev, ids) =3D=3D 0)
> > +             if (!IS_ERR_OR_NULL(acpi_create_platform_device(dev, NULL=
))) {
> > +                     dev_info(&dev->dev,
> > +                              "created platform device\n");
> > +             }
> > +
> > +     return AE_OK;
> > +}
> > +
> > +int __acpi_platform_driver_register(struct platform_driver *drv,
> > +                             struct module *owner)
> > +{
> > +     acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT, ACPI_UINT=
32_MAX,
> > +                         __acpi_platform_driver_register_cb, NULL,
> > +                         (void *)drv->driver.acpi_match_table, NULL);
> > +
> > +     return __platform_driver_register(drv, owner);
> > +}
> > +EXPORT_SYMBOL_GPL(__acpi_platform_driver_register);
> > +
> >  void __init acpi_platform_init(void)
> >  {
> >       acpi_reconfig_notifier_register(&acpi_platform_notifier);
> > diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/in=
tel/hid.c
> > index f25a427cccda..e2e0fc95e177 100644
> > --- a/drivers/platform/x86/intel/hid.c
> > +++ b/drivers/platform/x86/intel/hid.c
> > @@ -766,43 +766,4 @@ static struct platform_driver intel_hid_pl_driver =
=3D {
> >       .remove =3D intel_hid_remove,
> >  };
> >
> > -/*
> > - * Unfortunately, some laptops provide a _HID=3D"INT33D5" device with
> > - * _CID=3D"PNP0C02".  This causes the pnpacpi scan driver to claim the
> > - * ACPI node, so no platform device will be created.  The pnpacpi
> > - * driver rejects this device in subsequent processing, so no physical
> > - * node is created at all.
> > - *
> > - * As a workaround until the ACPI core figures out how to handle
> > - * this corner case, manually ask the ACPI platform device code to
> > - * claim the ACPI node.
> > - */
>
> This comment contains useful info, please preserve the comment changing
> the last paragraph to:
>
>  * As a workaround until the ACPI core figures out how to handle
>  * this corner case, manually ask the ACPI platform device code to
>  * claim the ACPI node by using module_acpi_platform_driver()
>  * instead of the regular module_platform_driver().
>

Good point. I shouldn't have deleted the original comment. I will restore a=
nd
rephrase it according to your suggestions.

> > -static acpi_status __init
> > -check_acpi_dev(acpi_handle handle, u32 lvl, void *context, void **rv)
> > -{
> > -     const struct acpi_device_id *ids =3D context;
> > -     struct acpi_device *dev =3D acpi_fetch_acpi_dev(handle);
> > -
> > -     if (dev && acpi_match_device_ids(dev, ids) =3D=3D 0)
> > -             if (!IS_ERR_OR_NULL(acpi_create_platform_device(dev, NULL=
)))
> > -                     dev_info(&dev->dev,
> > -                              "intel-hid: created platform device\n");
> > -
> > -     return AE_OK;
> > -}
> > -
> > -static int __init intel_hid_init(void)
> > -{
> > -     acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
> > -                         ACPI_UINT32_MAX, check_acpi_dev, NULL,
> > -                         (void *)intel_hid_ids, NULL);
> > -
> > -     return platform_driver_register(&intel_hid_pl_driver);
> > -}
> > -module_init(intel_hid_init);
> > -
> > -static void __exit intel_hid_exit(void)
> > -{
> > -     platform_driver_unregister(&intel_hid_pl_driver);
> > -}
> > -module_exit(intel_hid_exit);
> > +module_acpi_platform_driver(intel_hid_pl_driver);
> > diff --git a/drivers/platform/x86/intel/vbtn.c b/drivers/platform/x86/i=
ntel/vbtn.c
> > index 232cd12e3c9f..42932479de35 100644
> > --- a/drivers/platform/x86/intel/vbtn.c
> > +++ b/drivers/platform/x86/intel/vbtn.c
>
> ...
>
> > -static int __init intel_vbtn_init(void)
> > -{
> > -     acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
> > -                         ACPI_UINT32_MAX, check_acpi_dev, NULL,
> > -                         (void *)intel_vbtn_ids, NULL);
>
> Too bad there is no comment here. I wonder if this is necessary
> at all, or if this was just copy & pasted from the intel/hid.c
> driver.
>
> git blame is not really helpful here, the acpi_walk_namespace()
> was added in 332e081225fc2 ("intel-vbtn: new driver for Intel Virtual
> Button").
>
> So it looks like this is just copy paste and maybe a regular
> module_platform_driver() will be sufficient here. But changing
> behavior like that is out of scope for this patch-set, so please
> keep using module_acpi_platform_driver()
>

Changing vbtn driver behaviour is definitely out of the scope for this
patch-set but you may be right about copy-paste. Should I update
the commit message and mention about it?

> Otherwise this looks good to me.
>
> Regards,
>
> Hans
>
>

Thanks, Regards,
Slawek

