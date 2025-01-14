Return-Path: <linux-acpi+bounces-10631-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FD5A10D42
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 18:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF0E163689
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 17:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926A81FA14A;
	Tue, 14 Jan 2025 17:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCcTuAr8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FDD1D5154;
	Tue, 14 Jan 2025 17:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736874841; cv=none; b=GDoDaDJP6jzJ4DOWpIvvK1O644QrUsMQpMQtkeF0VxgopEbmj8Q+EbzwPPW5M+5mHjFVO8tO7q83ZRL3DTBs85PCdUb8GeUaSrQCwBxRvcrI1Uln+CAsTPlCORMYYT9TsZUDE0qwit5eipn2afUqXZ7JxRvoR5FKeYIoaCsHYlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736874841; c=relaxed/simple;
	bh=6xElT7U2OxBKAh95+jSWPMTILfpv5e1HIARlEGGndd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q3U36YqpLK7fpkM+lhg2yxO7jFe4YDXeE8lhg7r0oqXzBm+32XuaiPm1v/6n94WJQX1CK8j5ZKELFF55IRBHAA2jR0OSKc5sc27RIOZaChhGFK/fEfXiUGPBjJ0CxrZimRBcbi4zVYrWibBYtTRiISazwLLie2mlEX+1EA2FUB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCcTuAr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38CBC4CEE3;
	Tue, 14 Jan 2025 17:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736874840;
	bh=6xElT7U2OxBKAh95+jSWPMTILfpv5e1HIARlEGGndd0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vCcTuAr8mYL27YHh8RwCnact85gtObi1JRYhaE0AgI6rp0zdZmofghvWvN7yf+qwo
	 CFONX3q4niYhPYt7UlQqvRIv2qLJyr8GacrvffcZfL/ljvpBIUq2Ie2jUJK5Y4kN9y
	 OZEY6ccUDhMTUlsMb6WMjRk7z1yXCoysI2E3Rh5Sxng77DAh/4zKdVJYNYhO7u1XaS
	 rmQNsp9fgqc9FxLsxSuDqYaNh1GCoO8QdXDrVuTUK9ste+0oaKnoLQDcfJrlHdyhC/
	 s+OklTs2cEcQxz6EaW0X7qTsVOMP/nt0fh4pwbxvfsO7ldwHJuSoKSP0Wg7iN0TPD+
	 lLslL/RyH1HTQ==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3eba7784112so3089934b6e.2;
        Tue, 14 Jan 2025 09:14:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXFVLqL1TcIG1PBpGGA7HqLIA03sA/th0XI1TBB4LLm3jeGhBm42fNSuv6RDxmchME8o1z8rY37LZmWBCPQ24NA09ysOg==@vger.kernel.org, AJvYcCXI6I3weo2HEqW4OuBXM6+0SpNMA+1OOFx3V/EpsASzfBQ9husipg4Oktf5i6u+NPaV+aXunWfCP4aORGb7@vger.kernel.org, AJvYcCXj2xJIbsKaKUAMrSLzrPwPX/6vONbrHKEdCBsgU9DR6DnoI2SVdCs0PNLDmZPbrYFvBi62hK2E4w24@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1fezQzdSsM28CV0KFSNxBriC1hggF8qO1RbL5k556OhW7dDG2
	WoTFxVpkyYGew4+0ONvY8mSSWz1jZBi2gWo0tvuJh45JN2XhceCBbefvIql3RuO6cEen5uhOEr6
	nrLjPCE/F7LVM5tvEB5AmcBnSGJk=
X-Google-Smtp-Source: AGHT+IEt3nGfMxwItJjhYapytL6AT8hJDw8/2MgLlURGGNP/SPCUu6W4hR86aukYTLfeIKl3SjrBI84mzzoUcdNL/kg=
X-Received: by 2002:a05:6808:2797:b0:3ec:df52:a3c8 with SMTP id
 5614622812f47-3ef2ed70cdcmr13797668b6e.34.1736874840144; Tue, 14 Jan 2025
 09:14:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114153726.11802-1-kuurtb@gmail.com> <20250114153726.11802-16-kuurtb@gmail.com>
 <b271023f-8a84-a48d-2d59-f0815014687b@linux.intel.com>
In-Reply-To: <b271023f-8a84-a48d-2d59-f0815014687b@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 14 Jan 2025 18:13:48 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i8HNj5ztnt2K=QqL6eCUCEFbcDgAt2AWWhG4UwHL_EuQ@mail.gmail.com>
X-Gm-Features: AbW1kva6vQScZRlnDpQXOEObMQad5T55fCAdtzyYdgfxK0lrwuD5SajX6BkxvEs
Message-ID: <CAJZ5v0i8HNj5ztnt2K=QqL6eCUCEFbcDgAt2AWWhG4UwHL_EuQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/18] ACPI: platform_profile: Remove
 platform_profile_handler from exported symbols
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <W_Armin@gmx.de>, 
	Joshua Grisham <josh@joshuagrisham.com>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Hans de Goede <hdegoede@redhat.com>, Maximilian Luz <luzmaximilian@gmail.com>, 
	"Lee, Chun-Yi" <jlee@suse.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>, 
	Lyndon Sanche <lsanche@lyndeno.ca>, Ike Panhc <ike.pan@canonical.com>, 
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	Alexis Belmonte <alexbelm48@gmail.com>, Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>, 
	Dell.Client.Kernel@dell.com, ibm-acpi-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 5:55=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Tue, 14 Jan 2025, Kurt Borja wrote:
>
> > In order to protect the platform_profile_handler from API consumers,
> > allocate it in platform_profile_register() and modify it's signature
> > accordingly.
> >
> > Remove the platform_profile_handler from all consumer drivers and
> > replace them with a pointer to the class device, which is
> > now returned from platform_profile_register().
> >
> > Replace *pprof with a pointer to the class device in the rest of
> > exported symbols.
> >
> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > ---
> >  drivers/acpi/platform_profile.c               | 87 ++++++++++++-------
> >  .../surface/surface_platform_profile.c        | 11 ++-
> >  drivers/platform/x86/acer-wmi.c               | 18 ++--
> >  drivers/platform/x86/amd/pmf/pmf.h            |  2 +-
> >  drivers/platform/x86/amd/pmf/sps.c            | 17 ++--
> >  drivers/platform/x86/asus-wmi.c               | 20 ++---
> >  drivers/platform/x86/dell/alienware-wmi.c     |  9 +-
> >  drivers/platform/x86/dell/dell-pc.c           | 22 ++---
> >  drivers/platform/x86/hp/hp-wmi.c              | 19 ++--
> >  drivers/platform/x86/ideapad-laptop.c         | 14 +--
> >  .../platform/x86/inspur_platform_profile.c    |  9 +-
> >  drivers/platform/x86/thinkpad_acpi.c          | 14 ++-
> >  include/linux/platform_profile.h              | 12 ++-
> >  13 files changed, 125 insertions(+), 129 deletions(-)
> >
> > diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pr=
ofile.c
> > index 34e22b006ccc..2fae5e2fc962 100644
> > --- a/drivers/acpi/platform_profile.c
> > +++ b/drivers/acpi/platform_profile.c
> > @@ -4,6 +4,7 @@
> >
> >  #include <linux/acpi.h>
> >  #include <linux/bits.h>
> > +#include <linux/cleanup.h>
> >  #include <linux/init.h>
> >  #include <linux/kdev_t.h>
> >  #include <linux/mutex.h>
> > @@ -213,9 +214,17 @@ static struct attribute *profile_attrs[] =3D {
> >  };
> >  ATTRIBUTE_GROUPS(profile);
> >
> > +static void pprof_device_release(struct device *dev)
> > +{
> > +     struct platform_profile_handler *pprof =3D to_pprof_handler(dev);
> > +
> > +     kfree(pprof);
> > +}
> > +
> >  static const struct class platform_profile_class =3D {
> >       .name =3D "platform-profile",
> >       .dev_groups =3D profile_groups,
> > +     .dev_release =3D pprof_device_release,
> >  };
> >
> >  /**
> > @@ -409,10 +418,10 @@ static const struct attribute_group platform_prof=
ile_group =3D {
> >       .is_visible =3D profile_class_is_visible,
> >  };
> >
> > -void platform_profile_notify(struct platform_profile_handler *pprof)
> > +void platform_profile_notify(struct device *dev)
> >  {
> >       scoped_cond_guard(mutex_intr, return, &profile_lock) {
> > -             _notify_class_profile(&pprof->class_dev, NULL);
> > +             _notify_class_profile(dev, NULL);
> >       }
> >       sysfs_notify(acpi_kobj, NULL, "platform_profile");
> >  }
> > @@ -461,40 +470,51 @@ int platform_profile_cycle(void)
> >  }
> >  EXPORT_SYMBOL_GPL(platform_profile_cycle);
> >
> > -int platform_profile_register(struct platform_profile_handler *pprof, =
void *drvdata)
> > +struct device *platform_profile_register(struct device *dev, const cha=
r *name,
> > +                                      void *drvdata,
> > +                                      const struct platform_profile_op=
s *ops)
> >  {
> > +     int minor;
> >       int err;
> >
> > -     /* Sanity check the profile handler */
> > -     if (!pprof || !pprof->ops->profile_set || !pprof->ops->profile_ge=
t ||
> > -         !pprof->ops->probe) {
> > +     /* Sanity check */
> > +     if (!dev || !name || !ops || !ops->profile_get ||
> > +         !ops->profile_set || !ops->probe) {
> >               pr_err("platform_profile: handler is invalid\n");
> > -             return -EINVAL;
> > +             return ERR_PTR(-EINVAL);
> >       }
> >
> > -     err =3D pprof->ops->probe(drvdata, pprof->choices);
> > +     struct platform_profile_handler *pprof __free(kfree) =3D kzalloc(
> > +             sizeof(*pprof), GFP_KERNEL);
> > +     if (!pprof)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     err =3D ops->probe(drvdata, pprof->choices);
> >       if (err < 0)
> > -             return err;
> > +             return ERR_PTR(err);
> >
> >       if (bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST)) {
> >               pr_err("platform_profile: no available profiles\n");
> > -             return -EINVAL;
> > +             return ERR_PTR(-EINVAL);
> >       }
> >
> >       guard(mutex)(&profile_lock);
> >
> >       /* create class interface for individual handler */
> > -     pprof->minor =3D ida_alloc(&platform_profile_ida, GFP_KERNEL);
> > -     if (pprof->minor < 0)
> > -             return pprof->minor;
> > +     minor =3D ida_alloc(&platform_profile_ida, GFP_KERNEL);
> > +     if (minor < 0)
> > +             return ERR_PTR(minor);
> >
> > +     pprof->name =3D name;
> > +     pprof->ops =3D ops;
> > +     pprof->minor =3D minor;
> >       pprof->class_dev.class =3D &platform_profile_class;
> > -     pprof->class_dev.parent =3D pprof->dev;
> > +     pprof->class_dev.parent =3D dev;
> >       dev_set_drvdata(&pprof->class_dev, drvdata);
> >       dev_set_name(&pprof->class_dev, "platform-profile-%d", pprof->min=
or);
> >       err =3D device_register(&pprof->class_dev);
> >       if (err) {
> > -             put_device(&pprof->class_dev);
> > +             put_device(&no_free_ptr(pprof)->class_dev);
> >               goto cleanup_ida;
> >       }
> >
> > @@ -504,20 +524,21 @@ int platform_profile_register(struct platform_pro=
file_handler *pprof, void *drvd
> >       if (err)
> >               goto cleanup_cur;
> >
> > -     return 0;
> > +     return &no_free_ptr(pprof)->class_dev;
> >
> >  cleanup_cur:
> > -     device_unregister(&pprof->class_dev);
> > +     device_unregister(&no_free_ptr(pprof)->class_dev);
>
> I don't like how this is architected.
>
> IMO, no_free_ptr() should not appear on error/rollback paths. The pointer
> is going to be freed despite the code just told it's not going to be
> freed, which sends conflicting signals. Obviously, it is because this
> function has relinquished its ownership of the pointer but as is it seems
> a dangerous/confusing pattern.

I agree.

