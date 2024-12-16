Return-Path: <linux-acpi+bounces-10156-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA5E9F3B57
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 21:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21FC18841BF
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 20:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87D01DDA17;
	Mon, 16 Dec 2024 20:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S2psUm5a"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254F81DC1AF
	for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2024 20:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381753; cv=none; b=bWzsuOGK+PQ+KdqpTiWp58pmvdJOjXxwzkzEJB4gi2D79I5XsPZKIoq4PewOCj55znSH/gjzhQ2oSjWj3EafsVZ7uwQ1e22lxjK/YFP9iZMVN99xNkx8C+1EyoZNRvRHdzJ+lgE4THaBZga9LraAMPKr4r5mMgnhT3YEO7mtJ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381753; c=relaxed/simple;
	bh=9QjWQ7WcKGFYlJPwxvTynGyVMoiDED/7I9tp5nVgQz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMSbRT7zzw9F/gCTXLC7Ihn4MGXyedbfwJWM2KON3B3dAAFSKTLcKRKrt41liAG9Z58SB0QBnRx0VzbwqM0Mlph+OyFJ/I4jOyjnZJslJDD26qK5aMr+Ed4EGiRJs8VTtfnLqtpbtsj2hexvPfyqXdsuJcOL49DMNSrjuwOKUrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S2psUm5a; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ef6af22ea8so3981151a91.0
        for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2024 12:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734381750; x=1734986550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2NwUtcfc/2jNCrLFAC1JPgfazwYnhzpPLv20A5ylj4=;
        b=S2psUm5aXXqAdbZPuuk/1Xn3/k51NKenPIRkmDZ6tMfC1GfLjQQMtooLCGi8ossZta
         KeTpx2tib12CV7JQWaXywEwfuhUixtL/gxQoQHvnfuFEiWs4ZAD1sAyy+1P3XpxBaC22
         8h0rWFGuS/83oQfQfF42RdVruwDeBMizg5BI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734381750; x=1734986550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2NwUtcfc/2jNCrLFAC1JPgfazwYnhzpPLv20A5ylj4=;
        b=sq7+7plzuNUH4WRYWdQjHJWeP/f/Is5YUAcSbe3vpW/s6LSqHh6Cwymvrv0bo3WqsL
         H0I2TtnxkCH1ZPU5jzwEyCH6TOgmyLm8krRAeMRtm/55tEJ8d2pngPPzjVsZr9IO9ZuJ
         ov88AbMd5xvgql/AWSBzFyvuK//xvhIRB1vr2KARdcuj2rLe22E/dKH6GTyCHjxxEzQX
         YVBO5K/IzrgoKr/tlH3GbqGjkC35SnFyTG/YQiGJqqyVocIPik3Ws655T6Sjth19cqt7
         zf9aDBw+Ry4TiLhO9uJjVQoiR8RDXRAO4Ww8A0WsUCPT6DfvjTZnTxfckCTroOgPhxC6
         mLuA==
X-Forwarded-Encrypted: i=1; AJvYcCXyKOKtA1hJxmeNUfQDfg6lY/ldcnFVFmg1THAxrJd2iYM/ZUAIBId1GPCw86g5IV6Vc6NaYgHeVSuw@vger.kernel.org
X-Gm-Message-State: AOJu0YzdmJnTT4TUy1NzhCZzOiVul6BUsVgZKSsIiSJ2NrcMJ4r9kRLI
	LAszFdD1Ew/zezmnMJkUjm1jkKox7u3yYf+kGYiUV5hpc33V5Q4lyXSyGOTmOANQVvYGDngNSm4
	=
X-Gm-Gg: ASbGnctNkNZZ8ny9DpbSm6eI31fz1CoUf0j4OWZMCy5JRZgGXhamzRd+8Cfmvb202cu
	+EsajY1Yl2DgDsedT6AMlXKhxhzJzt6spyJUtP3AE/50XnJvaeSZh5cUVVM9oH9ty5zcO+0zVP4
	I2ilr2XozhFlxvkXt1+11wojFo5HCrbDg6AFpMlwta9Kw2tpzQMhB3XFeBe/4zfKWrNUO2Ug5Qr
	2r++wy9i+ulfOIUdaNwk7FMBJModmpMxtqHYHskeCGErKs5kMcUlRw5fPBY05e2Sj+GHv1w/8zS
	75s8HnSLSFyswGHwJl2eZRs=
X-Google-Smtp-Source: AGHT+IHv4dJ+ce1rV2ItV2E9/NEW/s+mQQ61GUtwAaMYKp3VkUMXcazPVIahMXP6uon74SS8NREaMQ==
X-Received: by 2002:a17:90b:4a50:b0:2ee:bc7b:924a with SMTP id 98e67ed59e1d1-2f2901a266bmr17302861a91.28.1734381749996;
        Mon, 16 Dec 2024 12:42:29 -0800 (PST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com. [209.85.215.181])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2a1e9f6aesm5122219a91.21.2024.12.16.12.42.28
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 12:42:28 -0800 (PST)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso3795403a12.2
        for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2024 12:42:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV5WFacQNTnzYWOrPkBO3NBQif9g60oEPlvzp4HqoxOuL8JZUjW02nRR9gm2ZaWm0p3lBYob3EejtnL@vger.kernel.org
X-Received: by 2002:a17:90b:4a50:b0:2ee:bc7b:924a with SMTP id
 98e67ed59e1d1-2f2901a266bmr17302745a91.28.1734381747835; Mon, 16 Dec 2024
 12:42:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211-fix-ipu-v4-0-4102e97aceb6@chromium.org>
 <20241211-fix-ipu-v4-2-4102e97aceb6@chromium.org> <CAJZ5v0gmN6+y2DveaBjSqWpTRWqm9zo2t0uDdvGwnVXcdQ777A@mail.gmail.com>
In-Reply-To: <CAJZ5v0gmN6+y2DveaBjSqWpTRWqm9zo2t0uDdvGwnVXcdQ777A@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 16 Dec 2024 21:42:16 +0100
X-Gmail-Original-Message-ID: <CANiDSCtF6XoAK6t0XNcT1KjGKHJMMFw8oKr1OSS0jkLuwgL8Og@mail.gmail.com>
X-Gm-Features: AbW1kvaPH50jQcGdHOPoZpEMapRhVX_TvQ-lMubFrgv6_CrphG6dWrwQxfPN8to
Message-ID: <CANiDSCtF6XoAK6t0XNcT1KjGKHJMMFw8oKr1OSS0jkLuwgL8Og@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] ACPI: bus: implement acpi_get_physical_device_location
 when !ACPI
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rafael

On Mon, 16 Dec 2024 at 21:17, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Dec 11, 2024 at 5:07=E2=80=AFPM Ricardo Ribalda <ribalda@chromium=
.org> wrote:
> >
> > Provide an implementation of acpi_get_physical_device_location that can
> > be used when CONFIG_ACPI is not set.
> >
> > Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  include/acpi/acpi_bus.h | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index 2b09e513ecf3..b312a72f48ad 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -43,9 +43,6 @@ acpi_status
> >  acpi_evaluate_ost(acpi_handle handle, u32 source_event, u32 status_cod=
e,
> >                   struct acpi_buffer *status_buf);
> >
> > -acpi_status
> > -acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_=
info **pld);
> > -
> >  bool acpi_has_method(acpi_handle handle, char *name);
> >  acpi_status acpi_execute_simple_method(acpi_handle handle, char *metho=
d,
> >                                        u64 arg);
> > @@ -60,6 +57,9 @@ bool acpi_check_dsm(acpi_handle handle, const guid_t =
*guid, u64 rev, u64 funcs);
> >  union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const guid_t =
*guid,
> >                         u64 rev, u64 func, union acpi_object *argv4);
> >  #ifdef CONFIG_ACPI
> > +acpi_status
> > +acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_=
info **pld);
> > +
> >  static inline union acpi_object *
> >  acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 re=
v,
> >                         u64 func, union acpi_object *argv4,
> > @@ -1003,6 +1003,12 @@ static inline int unregister_acpi_bus_type(void =
*bus) { return 0; }
> >
> >  static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
> >
> > +static inline acpi_status
> > +acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_=
info **pld)
> > +{
> > +       return AE_ERROR;
> > +}
>
> I overlooked this before, sorry.
>
> It generally is not OK to use acpi_status and/or AE_ error codes
> without CONFIG_ACPI and they really only should be used in
> drivers/acpi/ (and not everywhere in there for that matter).
>
> So acpi_get_physical_device_location() needs to be redefined to return
> something different from acpi_status (preferably bool) in order to be
> used in !CONFIG_ACPI code.

Shall I redefine it to
bool acpi_get_physical_device_location(acpi_handle handle, struct
acpi_pld_info **pld)/

For both the ACPI and !ACPI cases? or just for the !ACPI?

Regards!

>
> > +
> >  #define for_each_acpi_dev_match(adev, hid, uid, hrv)                  =
 \
> >         for (adev =3D NULL; false && (hid) && (uid) && (hrv); )
> >
> >
> > --



--=20
Ricardo Ribalda

