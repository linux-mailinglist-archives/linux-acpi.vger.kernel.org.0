Return-Path: <linux-acpi+bounces-17162-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD9CB8E37B
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Sep 2025 20:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40AF57A5C89
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Sep 2025 18:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C6D26F2B8;
	Sun, 21 Sep 2025 18:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0RTRwAM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD9B20ADD6
	for <linux-acpi@vger.kernel.org>; Sun, 21 Sep 2025 18:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758480365; cv=none; b=N5S4qdFhCMmvWxETSBfQANZ9R7Ax7R9qAjEYzS6qFLbzgZkkXdPg4c22zSHlOdEqGgDl1byMpPAwQjYAwQq9P7KxyXHWlvgFrQNYi97W1oGMnbxygwBRH5xUyl2RXZY2RBxHwYpjHDpTQYnS2lP40GgFcdyq7xE/PbfDRlGoXWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758480365; c=relaxed/simple;
	bh=s2zLXFL3oZyxxRnuK7m4mTTTzjy81wEwkm7YmZJ3hOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DAlQJluj7pza5C2tLbr9z8Bp95Pxv4YwTReIgBBoNRJIz2fNh1afM17xFIDisTXcW8QscS/Xga1k83cayZ+pSm183uw9MTXbfBy0w6Od8XWtHpnFTuZXxibj8CXF6mpSiyeJlOvmC0nCyW0IWDZuU3KdYvRFLfQURYOxQ7gQSrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0RTRwAM; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b04770a25f2so601674866b.2
        for <linux-acpi@vger.kernel.org>; Sun, 21 Sep 2025 11:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758480362; x=1759085162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvrG/fYnobVZfYkaIXOslWuOpvRasf4JDL3N8DCdcQs=;
        b=A0RTRwAMtYjsbE2dh7F6aSybVsW2KDNOhzynNZVg7etLOYUqySgmbrQZVG4eb0xaL5
         /qFhlaMbRr+KGh81qyqjyVqlifaAYUMO8Ouee8z/N3qfSVUtl7swhKLPIWg17jeoRsaD
         8OMAaAdCnVgWF4ktevl7OkCgDgvqGqc2XLFXC+YVdngZniD0V7Rakmtu2g/aMMy5FHko
         4wd7hxgW8FRyPtm4ysC5KJGw2e6BVF2q12lSeNTSTnW0bAaV9yi7/5JkLInKyBV/EFvj
         VDU7qOFgT1FDSxUyDHFSvLSmkEQ32nSH7vtfY/grpDdyT22TBAZqdPNilFNEVgLQtSWR
         gezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758480362; x=1759085162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LvrG/fYnobVZfYkaIXOslWuOpvRasf4JDL3N8DCdcQs=;
        b=PbaoMp8raTodLiLb/HtY2617ZM8aAQWBSNQ+D4lFfxcDBJG6NHlqv9MAUTW9fQ+TaE
         ctEc19z6LLvoyX9+tMpIjuaiQyRvB4b7BpJrGjmyUatJk05gVqpQiP3TEkhcmgQ5aF8S
         BOIucKMBRKdfTakwqqjP0o040eXtA/Q1F++/LWLMyG5kMfkfiaUyhTXYCL2xiL7wTtFP
         opIoJWQBebkyJMzJhTVV+LIhCbBU1VwtRy+aicM+hXlBk5eZe88FxS0/FJiNp0AUAMYO
         Iieffz9bcuhRlwoBmRPVJT3SBorIDe/wcF3oPaeqjNSa2mboY1p6YtFyaNA6P5JUJXEA
         hZTA==
X-Forwarded-Encrypted: i=1; AJvYcCU460KEx4voto8r4G+G2zWuHenAGfKXYJI/rlJBiq4b6uX//ohtfn5zhA05L7QqnzbXw8zklL0QQqcQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxdEgiIh3TpHs/LLTU0+iIUr1/MWRBFuqUCZ0ED62qXWE7x/wF+
	Hj4Lu6os6wiZl2SGSgDf/6DS0zP1pKFiauH7FLh5qyhufbRs7FtY9tWS5lMU3ubKkJ32m3sHd+u
	65sWw7KDLVclBuMr1M+Ww2SZG89WO21M=
X-Gm-Gg: ASbGncsSzwF9B7ufIDROzkPvY2vP5n3g/Rz4gYM779DJRr16mkRsDSrOK7GYIJi+AW4
	5FDgOpkWYwW8aBcOBk750+v9Zyf8jeuX10+OICuHBOTq3dNBU02M4q7o65N5PXLWH6Y07kih/jq
	MtLzJvhJcLuphZsU1T3zPsnq6DeBD3S4lUAvien1WA3+RXad/E+IZEQj968Rv3xUxyTSG1sJTUm
	V4bKbA=
X-Google-Smtp-Source: AGHT+IGGGllbTI7KeHuphlLDGQpJRt14pyAekhjmR1hgEzwbGY/f9vj/49nWttbUlxCKKlMAxXhz85pHtx1Lj09NDyY=
X-Received: by 2002:a17:907:1c8e:b0:b04:39af:bee9 with SMTP id
 a640c23a62f3a-b24e116b821mr976879266b.0.1758480361850; Sun, 21 Sep 2025
 11:46:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920200955.20403-1-hansg@kernel.org> <w7twypwesy4t5qkcupjqyqzcdh2soahqpa35rqeajzh2syhtra@6trjploaie6g>
 <d8e90507-49d1-4afa-a71a-ceacf5f89f82@kernel.org>
In-Reply-To: <d8e90507-49d1-4afa-a71a-ceacf5f89f82@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 21 Sep 2025 21:45:24 +0300
X-Gm-Features: AS18NWBhNqYELqho0RrBHNg2hMISYyhFwTOMutrnHFC2Ze-Ijp3oRQDj_P3ofHU
Message-ID: <CAHp75Vdt6Fpt5JHzKFGLDGjeEV9io+D37FfbWWYMX6B4gc76+A@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: Extend software-node support to support
 secondary software-nodes
To: Hans de Goede <hansg@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 4:00=E2=80=AFPM Hans de Goede <hansg@kernel.org> wr=
ote:
> On 20-Sep-25 11:27 PM, Dmitry Torokhov wrote:
> > On Sat, Sep 20, 2025 at 10:09:55PM +0200, Hans de Goede wrote:

...

> > Bikeshedding for later. Maybe do it like this in case we can have more
> > than 2 nodes at some point?
> >
> >         do {
> >               desc =3D gpiod_find_by_fwnode(fwnode, consumer, con_id, i=
dx, flags, lookupflags);
> >               if (!gpiod_not_found(desc))
> >                       return desc;
> >
> >               fwnode =3D fwnode->secondary;
> >       } while (!IS_ERR_OR_NULL(fwnode));
> >
> >       return ERR_PTR(-ENOENT);
>
> At a minimum this would need to a regular while () {} loop then,
> the initial fwnode may also be NULL and we don't want to deref that.
>
> Andy did mention turning the fwnode-s into a regular linked-list
> in the future, but I think that would be using <linux/list.h> then,
> replacing the secondary pointer with a list head ?

Dropping secondary in the struct fwnode_handle and use struct
list_head somewhere else, e.g., struct device.

> >> +}


--=20
With Best Regards,
Andy Shevchenko

