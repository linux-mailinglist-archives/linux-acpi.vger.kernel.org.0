Return-Path: <linux-acpi+bounces-15062-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166C7AFC6DB
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jul 2025 11:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8EAA7AA32E
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jul 2025 09:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2E718A6DB;
	Tue,  8 Jul 2025 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SepvhZMb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34814C2FB
	for <linux-acpi@vger.kernel.org>; Tue,  8 Jul 2025 09:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751966205; cv=none; b=Gu/eVkLJAkdTDB7AQOyXsGDGk08qCbg+0VeC2gEiMtn817h+MJbgNpAo1LDryurizFvhM5Tyr0w16B2n7wjiPbht72Uo8/21KtqsC7jRKaAhD+WywmN/+sur5KdU3sxU9EUHUn8SnNC3uAiI4quHOgpVC3RKQD0u4VYBMfZwBjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751966205; c=relaxed/simple;
	bh=oWA+jyYXTFUVOVpq0A1KhzsVCekTcqZUOlf72Qn1/FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CuiTJxDQBS8wuE4BZiF+R0Zgw5//PGOxwRqckY2um6vdYv6IUWpC+W9GSFVh9mlpB4z09bMBZJKiDGCErAHKe0gjzPdJh4fM1tsdc1UFi6nkS8qQA4+9KqFwTf9TAWeD7fZmaQBCS9CfOzIsWvFIVVV4Ffp66aEnTeulZcBZz6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SepvhZMb; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54b10594812so4998145e87.1
        for <linux-acpi@vger.kernel.org>; Tue, 08 Jul 2025 02:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751966201; x=1752571001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyLgLNqxZVEVrHG4u8oZzb76t/clebyyt0lejdbang0=;
        b=SepvhZMbapen4HO2fUzAObbbQPrHg0NY4eWEOj/O99cf01pQgWCCi12IymBkVWzVle
         /UuO6xk7jZEhq8tPKfzNLLKLd7Fx4qBs12+mOp6KqsLyuSgb22ltg7CaAXwI+JuuSZR4
         K98hIyn4BMs9XSFvruJjNIzuZRboh5KnqHZuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751966201; x=1752571001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyLgLNqxZVEVrHG4u8oZzb76t/clebyyt0lejdbang0=;
        b=ZZZMM82aAOfoSQJ5AIevuPJltg/gSH05wQXtqdSkCZLAl9vUNvPcfKd8G7iUA9V6ey
         F8xSQGy+htjbBNAQRvu0bp7Vxq1aPUSURNEbF5ORS+oe/Es/OcnqVSb6aUkA31CTqFPg
         eH0VSEuL1ujcZ2JiCWqxLzkP01gqFrYoD3nf1+97gSqejUB+YH8Q5+AiA2sXgDYYD1MM
         kGvWxODy/SLUzz45H+G29YUwDAcKrAYzOGtHKL7T9qHptYDj7Nrj7AE5LeZag2tScjZj
         0QLP5yEm0ND8Grp5N2gugdpM+dm6cKhQRRbW50yJRWM3QHujFLvOfLiJEbDUuPKAr6I9
         y5KA==
X-Forwarded-Encrypted: i=1; AJvYcCVSFFcu2rNxBLQaJX0m1vEX0mBhzk/dAQkwt3dpszeOHXHJmNiNwUR9Y1nXgRWNT9zI4QcOjYeKLpHt@vger.kernel.org
X-Gm-Message-State: AOJu0YzdpMvDIBftubb3+X8euEyMGx0WfbMGUrYMPj+94ggsffuoZgfe
	TSF7e7nmEx+X2+YhNYYAQOGZilLTJLftqiPwVTsk9gDahdjHNEPM/90ce7fSaDRQaLjSmvFaWwn
	v/7vvfQ==
X-Gm-Gg: ASbGncvTF69SXEUgKB+QvBKAL604J+oZJIsl3rmzuJpJuc7iUc5GKaa511bEjd6a703
	7wNk/h+hhBUBowvwAZ4LeqTn2HxlkdKr3QWObZnayDgkkLd31LA41ekB2CjxPAn733PhtKaRvZY
	0GBzsVx0GE+4DDAC6gdaFat7vPaYzURSuoO0GahnhC402oWvyy1S+ArqhTNtfoyr90amvMD3w+O
	PbCqUYw0iS+T+/+G0xWnoNRx+q6/lN2Fy6TQLljke4X/G8NNoU7pkWlHVbTkEbtX1PU1Z3k3XnC
	mk80vxw37swDZLjbr9D+DEYCpEVD5klUHhRL1IztehcsWqbwva9YmXkwuw8LBSCGgclNwCcu4Yq
	uciqksX5u3FUQZ0zNpEI9jDMz
X-Google-Smtp-Source: AGHT+IH7dD1vH7qfYz+K1pGB+2PC6LsYKxTnlSxsoipEZVU2zByGJvpwLAaGyVYE30JItrQdpDP/VA==
X-Received: by 2002:a05:6512:3dab:b0:553:2812:cf01 with SMTP id 2adb3069b0e04-557ab2fe800mr4874330e87.54.1751966201104;
        Tue, 08 Jul 2025 02:16:41 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5570b439191sm1520141e87.72.2025.07.08.02.16.40
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 02:16:40 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-553c31542b1so4115235e87.2
        for <linux-acpi@vger.kernel.org>; Tue, 08 Jul 2025 02:16:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVEkRKDIoWnAK5IsHHxVicAoeKoLqTe4LUtTigkWE/0jwaSJ8V0qanVPEqdfZu8MZAEowNIrnafbUQh@vger.kernel.org
X-Received: by 2002:a05:6512:2386:b0:553:3407:eee0 with SMTP id
 2adb3069b0e04-557a132beb0mr6054641e87.4.1751966199327; Tue, 08 Jul 2025
 02:16:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-5-5710f9d030aa@chromium.org> <aGw_1T_Edm8--gXW@kekkonen.localdomain>
In-Reply-To: <aGw_1T_Edm8--gXW@kekkonen.localdomain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 8 Jul 2025 11:16:25 +0200
X-Gmail-Original-Message-ID: <CANiDSCup2iRx+0RcaijSmbn04nBY4Ui9=esCPFsQzOKe=up9Gg@mail.gmail.com>
X-Gm-Features: Ac12FXyzhfInZK890Wq_-YMIwMPEqs5CfSkqVHt4PZPUUwV21icplYQB7hfeIEM
Message-ID: <CANiDSCup2iRx+0RcaijSmbn04nBY4Ui9=esCPFsQzOKe=up9Gg@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] media: ipu-bridge: Use v4l2_fwnode for unknown rotations
To: Sakari Ailus <sakari.ailus@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sakari

Thanks for your review

On Mon, 7 Jul 2025 at 23:45, Sakari Ailus <sakari.ailus@linux.intel.com> wr=
ote:
>
> Hi Ricardo,
>
> On Thu, Jun 05, 2025 at 05:52:58PM +0000, Ricardo Ribalda wrote:
> > The v4l2_fwnode_device_properties contains information about the
> > rotation. Use it if the ssdb data is inconclusive.
>
> As SSDB and _PLD provide the same information, are they always aligned? D=
o
> you have any experience on how is this actually in firmware?

Not really, in ChromeOS we are pretty lucky to control the firmware.

@HdG Do you have some experience/opinion here?

>
> _PLD is standardised so it would seem reasonable to stick to that -- if i=
t
> exists. Another approach could be to pick the one that doesn't translate =
to
> a sane default (0=C2=B0).

I'd rather stick to the current prioritization unless there is a
strong argument against it. Otherwise there is a chance that we will
have regressions (outside CrOS)


>
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/pci/intel/ipu-bridge.c | 30 +++++++++++++++++++---------=
--
> >  1 file changed, 19 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/i=
ntel/ipu-bridge.c
> > index 020aa52f590d66b6d333adc56ebfb9ab0561db51..6f436a8b4d23373af8a6668=
530333a827eca467a 100644
> > --- a/drivers/media/pci/intel/ipu-bridge.c
> > +++ b/drivers/media/pci/intel/ipu-bridge.c
> > @@ -236,37 +236,41 @@ static int ipu_bridge_read_acpi_buffer(struct acp=
i_device *adev, char *id,
> >  }
> >
> >  static u32 ipu_bridge_parse_rotation(struct acpi_device *adev,
> > -                                  struct ipu_sensor_ssdb *ssdb)
> > +                                  struct ipu_sensor_ssdb *ssdb,
> > +                                  struct v4l2_fwnode_device_properties=
 *props)
> >  {
> >       switch (ssdb->degree) {
> >       case IPU_SENSOR_ROTATION_NORMAL:
> >               return 0;
> >       case IPU_SENSOR_ROTATION_INVERTED:
> >               return 180;
> > -     default:
> > +     }
> > +
> > +     if (props->rotation =3D=3D V4L2_FWNODE_PROPERTY_UNSET) {
> >               dev_warn(ADEV_DEV(adev),
> >                        "Unknown rotation %d. Assume 0 degree rotation\n=
",
> >                        ssdb->degree);
> >               return 0;
> >       }
> > +
> > +     return props->rotation;
> >  }
> >
> > -static enum v4l2_fwnode_orientation ipu_bridge_parse_orientation(struc=
t acpi_device *adev)
> > +static enum v4l2_fwnode_orientation
> > +ipu_bridge_parse_orientation(struct acpi_device *adev,
> > +                          struct v4l2_fwnode_device_properties *props)
> >  {
> > -     struct v4l2_fwnode_device_properties props;
> > -     int ret;
> > -
> > -     ret =3D v4l2_fwnode_device_parse(ADEV_DEV(adev), &props);
> > -     if (!ret || props.rotation =3D=3D V4L2_FWNODE_PROPERTY_UNSET) {
> > +     if (props->orientation =3D=3D V4L2_FWNODE_PROPERTY_UNSET) {
> >               dev_warn(ADEV_DEV(adev), "Using default orientation\n");
> >               return V4L2_FWNODE_ORIENTATION_EXTERNAL;
> >       }
> >
> > -     return props.orientation;
> > +     return props->orientation;
> >  }
> >
> >  int ipu_bridge_parse_ssdb(struct acpi_device *adev, struct ipu_sensor =
*sensor)
> >  {
> > +     struct v4l2_fwnode_device_properties props;
> >       struct ipu_sensor_ssdb ssdb =3D {};
> >       int ret;
> >
> > @@ -274,6 +278,10 @@ int ipu_bridge_parse_ssdb(struct acpi_device *adev=
, struct ipu_sensor *sensor)
> >       if (ret)
> >               return ret;
> >
> > +     ret =3D v4l2_fwnode_device_parse(ADEV_DEV(adev), &props);
> > +     if (ret)
> > +             return ret;
> > +
> >       if (ssdb.vcmtype > ARRAY_SIZE(ipu_vcm_types)) {
> >               dev_warn(ADEV_DEV(adev), "Unknown VCM type %d\n", ssdb.vc=
mtype);
> >               ssdb.vcmtype =3D 0;
> > @@ -287,8 +295,8 @@ int ipu_bridge_parse_ssdb(struct acpi_device *adev,=
 struct ipu_sensor *sensor)
> >       sensor->link =3D ssdb.link;
> >       sensor->lanes =3D ssdb.lanes;
> >       sensor->mclkspeed =3D ssdb.mclkspeed;
> > -     sensor->rotation =3D ipu_bridge_parse_rotation(adev, &ssdb);
> > -     sensor->orientation =3D ipu_bridge_parse_orientation(adev);
> > +     sensor->rotation =3D ipu_bridge_parse_rotation(adev, &ssdb, &prop=
s);
> > +     sensor->orientation =3D ipu_bridge_parse_orientation(adev, &props=
);
> >
> >       if (ssdb.vcmtype)
> >               sensor->vcm_type =3D ipu_vcm_types[ssdb.vcmtype - 1];
> >
>
> --
> Regards,
>
> Sakari Ailus



--
Ricardo Ribalda

