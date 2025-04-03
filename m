Return-Path: <linux-acpi+bounces-12700-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF714A7A80F
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 18:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351241884E75
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 16:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC1624E4AF;
	Thu,  3 Apr 2025 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dp5Lf/I8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ADA23F403;
	Thu,  3 Apr 2025 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743698212; cv=none; b=DOztxTyuzCUZ1Wn9i4O3PokES67FtvHUUtniJtIfHdOLyDmOn1DEEbQ5F4PcjYCpLbgh41ykuSp85FSHHZCLwzrm8K2R2mBJxVIe18niKC6R3WQc5AEPQ9ApLDIKZmYwc7JRp1gHjvVOCHnHVjfsauxSJ0MlN2jp40LvfAOFDsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743698212; c=relaxed/simple;
	bh=rHQvrTRD9lw8HQVLfGzOcqqcO/H5rWQHLFBLB0wZyD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FoknYX7C61TNeRoo10i/WqJYU5MO9b2APzp9viCWsZUMeSw66qBpolotMzrXAy6ediY5eYaQeZ6nHJTwYlNfa+l16RxeLmCG4KX2kS7EinyL1WPPFlSI94gXJ3WPXzY4awGz3NXmILZwg7l0DtliPl7pO5LCQ8wnyj6czpaJA24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dp5Lf/I8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24F0C4CEE3;
	Thu,  3 Apr 2025 16:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743698211;
	bh=rHQvrTRD9lw8HQVLfGzOcqqcO/H5rWQHLFBLB0wZyD4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dp5Lf/I8Vwz/fTu+t0VA6NfWBk+w+7i+KnuEgYHWSaCRIpVBxETkf1HyJ0Gww5BaI
	 Ro4nvDrTvMjuAk9L/42vbvWA13shG6KWzcK0aSwPpPlhQhbE+30BUPCyauCqTqll0P
	 CjiGxCSAFse68HUBO53jquvUQBe1Eo71FjPSjH3QYlE+GkOcEiV69OiGoGmAEovnKm
	 unsRq+GDuEJG8jhTUvhNBUjOSf0VfMAnBJBzR8CPYBuO54t7jQHGDWmr6AQLjGnhkc
	 pnzAq6q3f8hxEdtVanG0X86dPOp+ydmpD14TiBotwUHFvXYHnFCTq0AiW5Q07T2WNH
	 UQjwhVu/iqovQ==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5eb92df4fcbso2126941a12.0;
        Thu, 03 Apr 2025 09:36:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUl3aGOV2WxAqD+DRd6XI+rPsw0uuSGfEze4493c8rr9bwNICBE9Da4osgOrFn445GsmLaxdhanYY8t0wlR@vger.kernel.org, AJvYcCW5NrOZcxUoF0tbY+EGQHKmJ6glBsfjn1JJf8Q3agNt63TUUWeIergGVUnt30eTWQZhu4ce4S51dtus9g==@vger.kernel.org, AJvYcCXlB1vRaXmg8sJF1aqQUQDWwONSLiLZIwvvI4QOUy9HKHEAm0ayzbzaGXNjK7fZzSmYCUrir/yo9BlYueUuR2w=@vger.kernel.org, AJvYcCXxi/eFDSqVKEsq2ied1QZzB1T64u2J/TRVWfE0ANDdiKXx7nuqRlUWyJErmHQGBnOezwPZDMt1PTkh@vger.kernel.org
X-Gm-Message-State: AOJu0YzbFyOJe13hoQkcn2PDjG4RS0+0Fop9WY7pw/jcKqoHcZ/ndU0N
	b06GldlL1LkD/LnBflcywHZq9Bp6v4F5yzFcbfq9pKORC7TZ6tBqmXmG2XS4GX5QQmccVsc1Qsf
	3l/k2o3CCUAle9eXHAXl1ERQCdg==
X-Google-Smtp-Source: AGHT+IHon+pzrhvNsXMZduvE26T67ozKBFRk7/vc4tDRAuvWWErTIylHENbrBF1kJZB7zR9IjvY91WWEDmvpGtA682M=
X-Received: by 2002:a17:907:7e8f:b0:ac7:cfe0:3014 with SMTP id
 a640c23a62f3a-ac7d1914808mr23737166b.25.1743698210484; Thu, 03 Apr 2025
 09:36:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326171411.590681-1-remo@buenzli.dev> <20250326171411.590681-4-remo@buenzli.dev>
 <Z-UPJyD41LOMM3o2@smile.fi.intel.com> <CAL_Jsq+tJvGsbw1dGdgmBM8+cL4vN71OMTvX9tkmBLNk=6T9KQ@mail.gmail.com>
 <Z-60LwRrw30cq4YE@smile.fi.intel.com>
In-Reply-To: <Z-60LwRrw30cq4YE@smile.fi.intel.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 3 Apr 2025 11:36:38 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKiYCh7ukDoqc_toyn75=3wOM4WyOTGvogoOfdz9T_7Ow@mail.gmail.com>
X-Gm-Features: ATxdqUHrR9f-M9Rc-icD8gFeAJeiwgk4wmkSQ4eYZoRilCIetdjLrpjtMC9KT6E
Message-ID: <CAL_JsqKiYCh7ukDoqc_toyn75=3wOM4WyOTGvogoOfdz9T_7Ow@mail.gmail.com>
Subject: Re: [PATCH 03/10] device property: Add fwnode_property_read_int_array()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Remo Senekowitsch <remo@buenzli.dev>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Dirk Behme <dirk.behme@de.bosch.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Saravana Kannan <saravanak@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 11:15=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Apr 03, 2025 at 11:04:32AM -0500, Rob Herring wrote:
> > On Thu, Mar 27, 2025 at 3:41=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Wed, Mar 26, 2025 at 06:13:42PM +0100, Remo Senekowitsch wrote:
> > > > The rust bindings for reading device properties has a single
> > > > implementation supporting differing sizes of integers. The fwnode C=
 API
> > > > already has a similar interface, but it is not exposed with the
> > > > fwnode_property_ API. Add the fwnode_property_read_int_array() wrap=
per.
>
> ...
>
> > > > +EXPORT_SYMBOL_GPL(fwnode_property_read_int_array);
> > >
> > > I'm not sure about this. We have a lot of assumptions in the code tha=
t the
> > > arrays beneath are only represented by the selected number of integer=
 types.
> > > This opens a Pandora's box, e.g., reading in u24, which is not suppor=
ted by
> > > the upper layers..
> >
> > We can probably drop the export if it is just that which you object to.
>
> Yes, this is main point, but dropping it does not prevent from still usin=
g in
> the complied-in code. Is it possible to hide it better?

Don't put any declaration in the header and declare it in the rust
code? But lack of declaration generates warnings.

Also, all the backends will reject an arbitrary size. So your worry
about u24 or other odd sizes isn't really valid. But if you want to be
doubly paranoid for when we add a new firmware backend (shoot me now),
you could move this from the swnode implementation to the fwnode
implementation:

        if (!is_power_of_2(elem_size) || elem_size > sizeof(u64))
                return -ENXIO;

Rob

