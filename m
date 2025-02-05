Return-Path: <linux-acpi+bounces-10903-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19488A29B82
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Feb 2025 21:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23EDF3A5D8C
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Feb 2025 20:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2575321B1A3;
	Wed,  5 Feb 2025 20:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tl80DqPP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469CB218AB3;
	Wed,  5 Feb 2025 20:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738788892; cv=none; b=d1Q3M3m2Fd0rgKo2fg0NLxYPCkGzXOrnzitDI0MaUpBITnDeKSJ1RUOnyrv0pWmki2o+6tCc3yeSNAlRO8W6U3m6tG3F1UbmlrvJCGlsntfxPR2UA7C6jVrrxU/bI940YvT00ZHH6SRSuWMCGz3rePbOYHExd/MFVSkhBwxLFRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738788892; c=relaxed/simple;
	bh=j2HLWk8/4qGzx0p3awb9Xa8DY1Gdod6WC52lNjRWyIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxxMqYN202sQt1tgMlbQw29WFtJxCDZD+RlGiiu5Ge9dI+oEVJtzHfElWmnWAvwj3DjKY11qPeIOGdoM9i/Td2ilgHRcaON3AndywF3i864WeTCPiRIhmsqPilZJok+aL7HkzbzqDmU9J2FXpAejmM+LePcG1JznGSV8ZqoC7BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tl80DqPP; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54025432becso209086e87.1;
        Wed, 05 Feb 2025 12:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738788888; x=1739393688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnEC+VBLcJLG5Ji1NJMnDo7g4OTcnLl9A1TvXHUfoS4=;
        b=Tl80DqPPTBd2+czjMEjTmWUzvO38IxfA2vLqXf3oGrcxjpavx8D8OJuiqym/w//QFC
         RtF6c+JNim2+zbIm67AwxwaGvuNTiZbYvxxdwx5+dHxTqr3MmtXirFUa2FQ7RM0DuWKn
         RltjOwuEjEHh0Km+Fb8hm54TS5i4yGYtYfsdI2JLcx60TCJ3ggUrX5YjJmAJG5vD1eFB
         dT56kpO7yPasVNbVp14m+agfOYLRi7C5P24oM303D2ibu66AWQJ9XgUPwgf62RYu2TFl
         7+wccbehSnsuwKgqGmbdK0+Emiy5ugfpI66f2Ni0oX0SHUYHOyLCL1vC2TJS+OXnfbBB
         k9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738788888; x=1739393688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MnEC+VBLcJLG5Ji1NJMnDo7g4OTcnLl9A1TvXHUfoS4=;
        b=pWk8Q/et8Bkx3jnCb1Qo3ozqV9j1xFTcftFv96t4VSgROTtUnKQ6J4J+6mstaMtG+q
         IUPa7c3ArGQOePUHKjWx5rk7yjYJoUlYXgS+Iv/sID2kKxhtF9txYOt3zcYu9J6/cK3J
         LT2l1Qq5xywaZnaII6eCNwV9QUX1yjIA/U/ZYYI2zLRKzT2EuLr7C6le1pAcMgkVGOyt
         WVZfOeaysc86ooYcg8o7iBkFk/2KuoUBAxr+F/pDAt4+7Vl+Pb/gpkmQFtXuwcUR60zO
         bHnPJhG52b1251Yi8YCw6Y4hG7J1jm1ai3tl/nK9e2mVMqRvQnAwg1NWN5+mkRVBPX7w
         YImw==
X-Forwarded-Encrypted: i=1; AJvYcCVcTVWjBbkg6rQODXQHM05KVjWoEeUUk1pql+De0aTW8zEeRbQtU7flJqsNW94ul0vyD/i/DduePFv1@vger.kernel.org, AJvYcCXT1siUv/6aQqfso3mwGIjhmd9dBvu3RGgddJidN8xwIOJIm3UO58sriV4xSPxQStVp8xAfl+Up8ZxeuIVJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4eg31oERhdwGMQbvqeNYiSAPb2cQYSCcr5MQ4BJt+/EuXZ0qp
	N5UXnrstQh0hWY0YIw6y8YWn7Iq8+6pEaACsFrmmf5ccukuaBXQHIjyDfijHyfrmC2AvOfSK+GK
	OgSJKSB/rCBw+BvZR1Zqu3vBGMEJNDw==
X-Gm-Gg: ASbGncvmUR0h/iNktgJ7rf2Q+gqTpbTY4Fl6OH65SWpesAM+KRthT3d8KpyZXsjbC9R
	UyN1i6abSuP6e32EQEXKBdk1+/n+9GKjF9H1pv1uaW9xuiEcMJOoLLUKQF7svSOKzH2+vmOme
X-Google-Smtp-Source: AGHT+IGmA44UxWHGW4HN8bUJdnGTHvoxayQdQYcQLBp9bLTN4mzyL8TKZGX5UTBJfHYQxCRSOz3Hc9cR/l11jSoPNL0=
X-Received: by 2002:a05:6512:b90:b0:542:19ef:95c2 with SMTP id
 2adb3069b0e04-54405a225f3mr1491886e87.23.1738788887984; Wed, 05 Feb 2025
 12:54:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127093902.328361-1-gannon.kolding@gmail.com> <CAJZ5v0gvSY+4Hdoedo0Hm6Rap_1kig1z0G0NuYcEKBsLPsMo8Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0gvSY+4Hdoedo0Hm6Rap_1kig1z0G0NuYcEKBsLPsMo8Q@mail.gmail.com>
From: Gannon Kolding <gannon.kolding@gmail.com>
Date: Wed, 5 Feb 2025 13:54:11 -0700
X-Gm-Features: AWEUYZnU-orluMl_8Zqp3TcQrwEKPriWuK5E7AisKI9xUBmuF44DmZoU9KDzVqc
Message-ID: <CAKDWbw4-u7GuTueewnOCrWs7eR7xLPdQWRZbAOpcW_kjrxF_dw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: IRQ override for Eluktronics MECH-17
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Great, thanks Rafael!

Gannon

On Wed, Feb 5, 2025 at 1:14=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Mon, Jan 27, 2025 at 10:39=E2=80=AFAM Gannon Kolding
> <gannon.kolding@gmail.com> wrote:
> >
> > The Eluktronics MECH-17 (GM7RG7N) needs IRQ overriding for the
> > keyboard to work. Adding a DMI_MATCH entry for this laptop model
> > makes the internal keyboard function normally.
> >
> > Signed-off-by: Gannon Kolding <gannon.kolding@gmail.com>
> > ---
> >  drivers/acpi/resource.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> > index 90aaec923889..b4cd14e7fa76 100644
> > --- a/drivers/acpi/resource.c
> > +++ b/drivers/acpi/resource.c
> > @@ -563,6 +563,12 @@ static const struct dmi_system_id irq1_edge_low_fo=
rce_override[] =3D {
> >                         DMI_MATCH(DMI_BOARD_NAME, "RP-15"),
> >                 },
> >         },
> > +       {
> > +               .matches =3D {
> > +                       DMI_MATCH(DMI_SYS_VENDOR, "Eluktronics Inc."),
> > +                       DMI_MATCH(DMI_BOARD_NAME, "MECH-17"),
> > +               },
> > +       },
> >         {
> >                 /* TongFang GM6XGxX/TUXEDO Stellaris 16 Gen5 AMD */
> >                 .matches =3D {
> > --
>
> Applied as 6.14-rc material, thanks!

