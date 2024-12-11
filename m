Return-Path: <linux-acpi+bounces-10095-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127399ECB48
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 12:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8CF42818E5
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 11:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A7F1C5CCB;
	Wed, 11 Dec 2024 11:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTG3CUBL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96140238E27;
	Wed, 11 Dec 2024 11:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733916800; cv=none; b=MFVuWhsdV+euuhSkpuOFkhSMq9mSVXkf/L6W5UJoa6W5xDQ/INlWiv/GEW+OJbEC8i8XhCdk0hi5qkovq6SKiOoRTkqmscL1CzhTkTrDaJ4l+3RTa5wlYZPvHqByFpWwXZTttslGMaCHtNEqhFHb0gGbh0PMhLFYchhZ+N1K1hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733916800; c=relaxed/simple;
	bh=+VM/hzp5wXMCauHL67cEqJBthSxft/0uu55Nkx/Kt28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9zaxIn7z81eFoIYthOwZRDcfv7vnM8VWsGLos5+J5+g5rGZ9kYVKRnwniQ1i/0G1j7nFtDqfZRfLlWmdJL+EP9HxWovnbojfFUac4W4sQm0mi2hm5/VI/V1b+NDY8dYIQtJMGQhN12/b1i2OPiSyLRWK8J434u3cyYRJ+QB3k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTG3CUBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352EFC4CEDE;
	Wed, 11 Dec 2024 11:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733916800;
	bh=+VM/hzp5wXMCauHL67cEqJBthSxft/0uu55Nkx/Kt28=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jTG3CUBLBIF6ciX5X1bClXkR6kkwgk77lVDsE8iv4oev2ldWepUcNlyLuEm1bKB9o
	 X0Nyg1foxuBU4Dzvf9SpCC4KuC/gOMETimXzfa18Z8ITBmwTjXRovsn+64ysx1ZJxE
	 sUus0INmX5lxEE8POr9gvv9hebgEK/2iSNO0IME3PcMhSsI6VO5fJzoLra4v+5IPrm
	 HmltwLoD6HP+RjcfRho0LLQU/7lmju/5/nF4Q+ioUy0ZxwFtCv4McfpFMNEz6qVDqF
	 Da64RYE2UlcbUE+hs1SV7YA1SIksPxJOzxBmASa9C48m/suGI7fpHKP1KURCBEu7/s
	 kr/tp7oC5HPUw==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5f2bdbca73cso795336eaf.2;
        Wed, 11 Dec 2024 03:33:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUgnpgYC6WVlcRQnDYbnDprThkfznSyOylsAaBowLDa4fpEdpBePmZasN6JjwmcwMkAO8e5rtHyYUsqVcY=@vger.kernel.org, AJvYcCUkpBbKKAWNICsNC30HnjA5DXqf7tTbhTQLcCPCtNATUgMd6L0jiSwmBpIELHikaIPTwQyoYIxssE8jk4be@vger.kernel.org, AJvYcCXECvrgMT4Jqgq8PsNogwPX1oRPWp/ZC8blZmjx25X/ElQMJWniy9+BhjzVL6+zSLz3kpTv4HUqHylW@vger.kernel.org
X-Gm-Message-State: AOJu0YztyTSjL3l1tmBf8/0zFA5UDfTLoLaDm+Hgd6lz7Gt79/UGFfk1
	ygowkwwf/NwmUpwqoYzGfBEoTUT+ZuzAw/ALif8rcYMMI5LRz54Gpw4Issl0JD0ZCye/64X44MF
	t7nCfpUH/HVjwgD+Q2uCeSlPI61s=
X-Google-Smtp-Source: AGHT+IE2JX9wLDw7XGZFWMFEl/QZANF0fFOFWPSJjHSw+Ny8mSpK6DqmcMPXInglCCsZP3zGngbPGlDk8Cq5dyK7cl8=
X-Received: by 2002:a4a:e70b:0:b0:5f2:df9a:83d4 with SMTP id
 006d021491bc7-5f2df9a8a96mr398155eaf.1.1733916799520; Wed, 11 Dec 2024
 03:33:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-4-00e409c84a6c@chromium.org> <Z1irAT0KVwqhBSSZ@kekkonen.localdomain>
 <CANiDSCsLOODLhGrpPwOQ1j+coSb9yHYi=wjGpZ+F7VbA7AM0og@mail.gmail.com> <Z1lGPWHYTdfcxFPL@kekkonen.localdomain>
In-Reply-To: <Z1lGPWHYTdfcxFPL@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 11 Dec 2024 12:33:08 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gjwmd81zKYYcsyMmRWpK_R9UsV_H6HfQU+xP7MpWRD5g@mail.gmail.com>
Message-ID: <CAJZ5v0gjwmd81zKYYcsyMmRWpK_R9UsV_H6HfQU+xP7MpWRD5g@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] ACPI: header: implement acpi_device_handle when !ACPI
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Ricardo Ribalda <ribalda@chromium.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 8:59=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> On Tue, Dec 10, 2024 at 11:31:57PM +0100, Ricardo Ribalda wrote:
> > On Tue, 10 Dec 2024 at 21:56, Sakari Ailus <sakari.ailus@linux.intel.co=
m> wrote:
> > >
> > > Hi Ricardo,
> > >
> > > On Tue, Dec 10, 2024 at 07:56:01PM +0000, Ricardo Ribalda wrote:
> > > > Provide an implementation of acpi_device_handle that can be used wh=
en
> > > > CONFIG_ACPI is not set.
> > > >
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > >  include/linux/acpi.h | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > > > index 05f39fbfa485..59a5d110ff54 100644
> > > > --- a/include/linux/acpi.h
> > > > +++ b/include/linux/acpi.h
> > > > @@ -787,6 +787,12 @@ const char *acpi_get_subsystem_id(acpi_handle =
handle);
> > > >  #define acpi_dev_hid_uid_match(adev, hid2, uid2)     (adev && fals=
e)
> > > >
> > > >  struct fwnode_handle;
> > > > +struct acpi_device;
> > > > +
> > > > +static inline acpi_handle acpi_device_handle(struct acpi_device *a=
dev)
> > > > +{
> > > > +     return NULL;
> > > > +}
> > > >
> > > >  static inline bool acpi_dev_found(const char *hid)
> > > >  {
> > > >
> > >
> > > Please remove the extra forward declaration of struct acpi_device a f=
ew
> > > lines below this.
> >
> > Instead I have moved the function under the forward declaration. Let
> > me know if you disagree.
>
> The same order in which the functions are found in the actual
> implementation would be my suggestion. Rafael could also have an opinion.

It is nice, but it is not a requirement.

