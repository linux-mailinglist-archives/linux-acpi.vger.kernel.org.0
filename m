Return-Path: <linux-acpi+bounces-18445-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76877C2B19A
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 11:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45A03AA628
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 10:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD192FE592;
	Mon,  3 Nov 2025 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="iv5OUXrD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015772FCC04
	for <linux-acpi@vger.kernel.org>; Mon,  3 Nov 2025 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166213; cv=none; b=q1fEtNxJbEx3savV2RSS7ji6FtmePns8iz8EIYFcvXUjSrhNy8JpOzlPS25vX++n6mIWCrbvEjyOnK0829NypaOxueyS6ohMFEKQ6dKSGLStol4BkyPNEzPl5FppOqArNs7opYFAFGrk4XlaqVjphDnPFhD5yV81TWmckSLze24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166213; c=relaxed/simple;
	bh=+MmxogPhCLs9ZpI9QmsWexfExGRNeJu+3ZnjBRPUXe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRaV+SWpGQItbPWjdAJ+pxr42YpgiT51alX0NedXZOIUTRagHpLdJNg++e2CLPif9ai0MWZKSjo+g9b4lbuwrp/NQUIocomXK4IF4w7yToyUhZAaS2wWjrSCRg4xdAAu4KttK/hHApVuKtevAv8bsvBXim+r0s6Rc0nXnnHA9Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=iv5OUXrD; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3717780ea70so46778471fa.1
        for <linux-acpi@vger.kernel.org>; Mon, 03 Nov 2025 02:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762166210; x=1762771010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjLBSonYsqmv8UYBTszg3fkXjFKAEIXlmbkscAA6YbA=;
        b=iv5OUXrDCZogogcKkaAr2xU9qPJ09nejdz8PXi5j3gPIVivtB1RBQgE/F3QQ1nGwJy
         GM9OxBnVhI69OguE+YQ7/B/GI52YjpVurtceaK4SWItb4Ti4zaspM7rSK1pjYPgrf+Mr
         A1gvN1fUAPQGqfCrRl7KInQJhbEXUifSN+iXHGctNMfg1p8gdekdjQKk6gv4Jrsmv634
         YBcUTXIAutvtHOfq+12fr44JLfo+3VEqlNnL6rW457Y8XcOpWL0t/zWO1O6idx/UMzUX
         Dm7X27jtovNir7m0HYSf8kz6CqTWalrqRMx+znF2vcqmeFUXZuqRVoEqVlC/emLTmyhs
         FqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762166210; x=1762771010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjLBSonYsqmv8UYBTszg3fkXjFKAEIXlmbkscAA6YbA=;
        b=aB2VQ6HDF5gr1WYaRo5wwjSIR+zHoURIxjXeK62jXTIB5xoN+wlE1ptCE45R4gogKk
         AdUAngZJ+ayj/nMoarf3GCblpKIhtksXfA8Iwe1RGj/ekVrTVRCOkBzQd+TDee9Pi21u
         J9fWtOPuRf9AiH0DR956/mjSRkrZcmBLbOardzD4G9FVr9jcM82ObTwauryMb8QEdiOb
         crg5B8SGz1ellaQPXBmYWDm99H8MzOvjJwecI8e1ya47/llyG2pqcxpOVsn3C6xeaEeN
         ENsdAbQIfb4B67Dx1Yjm02IO1YJmdynIEwoC8U6AFFpt5e+XqP8E/bXXyXKqk3/bQWKG
         DboQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjaYefTZRgE30EM+Fznw4Nvw4R4eiwgQSZhlEgPJUk+1VzFw1oamBG4Zu/QPJUQ1sT+fGUoyxMKCbi@vger.kernel.org
X-Gm-Message-State: AOJu0YxDFbB/xnqjN5wuPzzgCXOkTYBqmjWZcHdXyNlgtXy66ew06Iu+
	LZVg/8uy/KDgf9CJWPYeYx597EczRv7blx6cLPdFNQiwLy3pbdqymHuoFTTJKPYzJiL/uzDCTwI
	kbXrSON6g/h92Jg1Py+lU1PPdcxXcHHWCrHL+H4BbZg==
X-Gm-Gg: ASbGncvSeJ5CC4mCJ7J15mutyhBz/DRG/094wUCXRzsHNMYGCeR31+zpErqsGWy+x8Y
	44/v52DiGzsV/PEvvthxWRue5j8/KaYUc68UMZYOOTu7+v3cMBIRXSOcaFbWBOSSLBcUg6yB70J
	E7Sq9Z5AtnxtGWEaj4zBZeKYOXftUHnniiIR6uvYWsGm60JBh63jVQSCeb5PgAFIh8K4lSq7f+b
	/OhIX9hQKLtWZrhZENOZhZq7bdaQESqX7Q52CECDAZ56b1qRm6LAdr+VD4VCH7bWwIKWJr9Oy0n
	Xrli0RJfDEYkGowL4ly5+ApbExE=
X-Google-Smtp-Source: AGHT+IE87NQ2wrN4nbBrNGJFPIv5zQc1LIytN9zHMv4eWDwdCr6Is7aAXMrMg0as6kgGpZ9GoAeO7eWblG8JuiJzHas=
X-Received: by 2002:a2e:be27:0:b0:37a:2b3d:12cc with SMTP id
 38308e7fff4ca-37a2b3d178fmr22342871fa.44.1762166210020; Mon, 03 Nov 2025
 02:36:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
 <20251103-reset-gpios-swnodes-v4-3-6461800b6775@linaro.org> <aQh6n2XuI0oayg2g@smile.fi.intel.com>
In-Reply-To: <aQh6n2XuI0oayg2g@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 3 Nov 2025 11:36:36 +0100
X-Gm-Features: AWmQ_bkxzE88tRObcETZ4rhIp4MxY1YrBBIl6dy0Tsm5UlD4jZWeoUiNmbbz8tk
Message-ID: <CAMRc=Md=r7GaO3A_7de+EqzboyA2cqNSTZx7+64VSMvRBb9gpw@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] software node: allow referencing firmware nodes
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 10:49=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Nov 03, 2025 at 10:35:23AM +0100, Bartosz Golaszewski wrote:
> >
> > At the moment software nodes can only reference other software nodes.
> > This is a limitation for devices created, for instance, on the auxiliar=
y
> > bus with a dynamic software node attached which cannot reference device=
s
> > the firmware node of which is "real" (as an OF node or otherwise).
> >
> > Make it possible for a software node to reference all firmware nodes in
> > addition to static software nodes. To that end: add a second pointer to
> > struct software_node_ref_args of type struct fwnode_handle. The core
> > swnode code will first check the swnode pointer and if it's NULL, it
> > will assume the fwnode pointer should be set. Rework the helper macros
> > and deprecate the existing ones whose names don't indicate the referenc=
e
> > type.
> >
> > Software node graphs remain the same, as in: the remote endpoints still
> > have to be software nodes.
>
> ...
>
> > +     /*
> > +      * A software node can reference other software nodes or firmware
> > +      * nodes (which are the abstraction layer sitting on top of them)=
.
> > +      * This is done to ensure we can create references to static soft=
ware
> > +      * nodes before they're registered with the firmware node framewo=
rk.
> > +      * At the time the reference is being resolved, we expect the swn=
odes
> > +      * in question to already have been registered and to be backed b=
y
> > +      * a firmware node. This is why we use the fwnode API below to re=
ad the
>
> A nit-pick (since anyway it requires a new version): move 'the' to the ne=
xt
> line to make them more equal in the length.
>
> > +      * relevant properties and bump the reference count.
> > +      */
>
> ...
>
> > -#define SOFTWARE_NODE_REFERENCE(_ref_, ...)                  \
> > +#define __SOFTWARE_NODE_REF(_ref, ...)                               \
>
> No, NAK. The renaming of the parameters is not related to this change _at=
 all_.
> Why do you change established style here? Did I miss your answer to my qu=
estion
> in the previous rounds?
>

Ah, my brain just filtered out the trailing '_'.

> >  (const struct software_node_ref_args) {                              \
> > -     .node =3D _ref_,                                          \
> > +     .swnode =3D _Generic(_ref,                                \
> > +                        const struct software_node *: _ref,  \
> > +                        default: NULL),                      \
> > +     .fwnode =3D _Generic(_ref,                                \
> > +                        struct fwnode_handle *: _ref,        \
> > +                        default: NULL),                      \
> >       .nargs =3D COUNT_ARGS(__VA_ARGS__),                       \
> >       .args =3D { __VA_ARGS__ },                                \
> >  }
>
> ...
>
> > +#define SOFTWARE_NODE_REF_SWNODE(_ref, ...)                  \
> > +     __SOFTWARE_NODE_REF(_ref, __VA_ARGS__)
> > +
> > +#define SOFTWARE_NODE_REF_FWNODE(_ref, ...)                  \
> > +     __SOFTWARE_NODE_REF(_ref, __VA_ARGS__)
> > +
> > +/* DEPRECATED, use SOFTWARE_NODE_REF_SWNODE() instead. */
> > +#define SOFTWARE_NODE_REFERENCE(_ref, ...)                   \
> > +     SOFTWARE_NODE_REF_SWNODE(_ref, __VA_ARGS__)
>
> Now, useless.
>

No, why? With these changes, SOFTWARE_NODE_REFERENCE()'s name is a bit
misleading or incomplete, so I'm proposing to start replacing it with
SOFTWARE_NODE_REF_SWNODE() which is compatible with the former but has
a better name.

> ...
>
>
> > -#define PROPERTY_ENTRY_REF(_name_, _ref_, ...)                        =
       \
> > +#define __PROPERTY_ENTRY_REF(_type, _name, _ref, ...)                 =
       \
> >  (struct property_entry) {                                            \
> > -     .name =3D _name_,                                                =
 \
> > +     .name =3D _name,                                                 =
 \
> >       .length =3D sizeof(struct software_node_ref_args),               =
 \
> >       .type =3D DEV_PROP_REF,                                          =
 \
> > -     { .pointer =3D &SOFTWARE_NODE_REFERENCE(_ref_, ##__VA_ARGS__), },=
 \
> > +     { .pointer =3D &_type(_ref, ##__VA_ARGS__), },                   =
 \
> >  }
>
> Do we need this now? I assume that _Generic() takes case of this.
>

Ah, right, it should be done here as well.

> ...
>
> > +#define PROPERTY_ENTRY_REF_SWNODE(_name, _ref, ...)                  \
> > +     __PROPERTY_ENTRY_REF(SOFTWARE_NODE_REF_SWNODE,                  \
> > +                          _name, _ref, __VA_ARGS__)
> > +
> > +#define PROPERTY_ENTRY_REF_FWNODE(_name, _ref, ...)                  \
> > +     __PROPERTY_ENTRY_REF(SOFTWARE_NODE_REF_FWNODE,                  \
> > +                         _name, _ref, __VA_ARGS__)
> > +
> > +/* DEPRECATED, use PROPERTY_ENTRY_REF_SWNODE() instead. */
> > +#define PROPERTY_ENTRY_REF(_name, _ref, ...)                         \
> > +     PROPERTY_ENTRY_REF_SWNODE(_name, _ref, __VA_ARGS__)
>
> Seems like useless churn.
>

This is the same argument as with SOFTWARE_NODE_REF_SWNODE(). It's not
clear from the name what PROPERTY_ENTRY_REF() is really referencing.

Bart

