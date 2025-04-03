Return-Path: <linux-acpi+bounces-12702-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C936EA7A886
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 19:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C55A7A5CF3
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 17:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE862512FA;
	Thu,  3 Apr 2025 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0TodopX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E33133DB;
	Thu,  3 Apr 2025 17:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743700992; cv=none; b=Ls42wscHQLZ/4Jve439L0rj+wOzwacmkYIVmr9wTHsDg2m9oD3oBioXVdAYfemPSQ3AclqmkdgdmY5qlY+myNWHfrvB6TrPDJasauUqcoUeYMow6y8kEDeyzSJDCj/qPmHqgQgwaUJT6oOgf71Wox7D5Qv99sUGOf7Alje2jCzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743700992; c=relaxed/simple;
	bh=ONT5hyP9dAVamP+G+ulFE46eRCan0impzfRCpp3f67I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KXJ+ke0sa0qAF+aDYaFW5L4Hb9oFFHQ7NVnni0s2EpCFvmkP5YAZDJRgrZWoq+RA7fOMZDUpTPBAp01JwOLAjxjGw+XqCPgbCOHIDi+hKXmwZ28F3JkDtfI9jYhXzQJcpPge2G4RTNC0JITu4F0wwPY3pfKyqRTx72oY5dFEsyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0TodopX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2D1C4AF09;
	Thu,  3 Apr 2025 17:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743700991;
	bh=ONT5hyP9dAVamP+G+ulFE46eRCan0impzfRCpp3f67I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f0TodopXamtJcPuXFkIFGmXEMFVjCtZ26awby3r6CbOcoRrVUdsKFM7fGkEDmUdEX
	 BG/AKQulIqCH6NiNwsUCMTEvgBPaqHY8FT1+jXx2DZioFyQO+/BH3K+sHO/iUwiycq
	 adqhmahQixU30j9r4Bry9W8s0+qYsOiBn/Q5iUrYiScw3FqZImVh5qCvddkzDtit/z
	 ao98GbtNaNCEFYUisU9DLc8wgkNAm+Tgxx0FBGYfVIrPzsl38QsSAw43CGqR5UEgNc
	 04Dxrb/7C5Mruv4jfLrlx3PiNSebwWV7bom1HzOil+g3XiO4r066zp6m5WbwlpnLcD
	 roFnHogRGW7CQ==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abec8b750ebso187781766b.0;
        Thu, 03 Apr 2025 10:23:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3PTxuEG5oSPvpCrlcb4Cbr0iETijQT9M64ymnquQ/4Ow90eTyhzBamP4fySLPvt0OJi29zs/7bTxk9V6xU2A=@vger.kernel.org, AJvYcCVV7+V5mhRfhfXsfPMLL56/NPQCZO7ydzonQhBve3mMwIVmxHhtyyRJSWZzJ9U+CCIitXvc+Or1kuER@vger.kernel.org, AJvYcCVZz5psvvP3rwOKfoOh8xHe4zbTOzzZ+Tt5oJCaMCMH3//EvV06XU3HEmLfgF4oXxnaun/I0+Tgs3MIEQ==@vger.kernel.org, AJvYcCWnvFjgFMTE4TlXRJ70n2FqcU1vEVkBM6fzbkiLAgVXCoSix8Gn6Y945yxo/jtTsGmqIOsGYO+0D+aH7nHX@vger.kernel.org
X-Gm-Message-State: AOJu0YxCPUOoJv5jxWEU9Up+rSYySuYmOWfeDRvfpK8buswn4C1h6chY
	BMAw9L1rjp6VcOcGh+rVdxSsEi3H+Weo15T89bIA6WjzhtYzvlYjQErxIwU9LsHrhxu+HeGpj0E
	sfuD3X8udP308kqO40FXzSBxxPQ==
X-Google-Smtp-Source: AGHT+IGBcTXIQpTZHaJO2gzh+xeqhW5vsmM/rL+gIC9Bk/L2lfLs2jI8YNuoDA0HhaIYMlttzKS2dmFDu5RSdENUZSU=
X-Received: by 2002:a17:907:d25:b0:ac3:b115:21b8 with SMTP id
 a640c23a62f3a-ac7d1b16d1bmr34388366b.47.1743700990242; Thu, 03 Apr 2025
 10:23:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326171411.590681-1-remo@buenzli.dev> <20250326171411.590681-4-remo@buenzli.dev>
 <Z-UPJyD41LOMM3o2@smile.fi.intel.com> <D8WA3WIHEQRN.3LQS84K8Z46OW@buenzli.dev>
 <Z-6NG7fSfyKH-vW_@smile.fi.intel.com> <CAL_JsqLPZc1LB09auMOJp90hbhJin75Yaa09h12ziZZgExSsBg@mail.gmail.com>
 <D8X60PODTV0B.2ENFYEXH7EZP0@buenzli.dev>
In-Reply-To: <D8X60PODTV0B.2ENFYEXH7EZP0@buenzli.dev>
From: Rob Herring <robh@kernel.org>
Date: Thu, 3 Apr 2025 12:22:59 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLtRuzpQH=LnV45FFN=Gr_U403H2qfoPQskrCOknnwoyA@mail.gmail.com>
X-Gm-Features: ATxdqUFBJeZLouUdX7Kpe6dUgmjxFi1XjK6oFW_um6EtcJfr1DDYj3hJqn8yqqU
Message-ID: <CAL_JsqLtRuzpQH=LnV45FFN=Gr_U403H2qfoPQskrCOknnwoyA@mail.gmail.com>
Subject: Re: [PATCH 03/10] device property: Add fwnode_property_read_int_array()
To: Remo Senekowitsch <remo@buenzli.dev>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
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

On Thu, Apr 3, 2025 at 12:04=E2=80=AFPM Remo Senekowitsch <remo@buenzli.dev=
> wrote:
>
> On Thu Apr 3, 2025 at 6:08 PM CEST, Rob Herring wrote:
> > On Thu, Apr 3, 2025 at 8:29=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> >>
> >> On Wed, Apr 02, 2025 at 06:04:13PM +0200, Remo Senekowitsch wrote:
> >> > On Thu Mar 27, 2025 at 9:41 AM CET, Andy Shevchenko wrote:
> >> > > On Wed, Mar 26, 2025 at 06:13:42PM +0100, Remo Senekowitsch wrote:
> >> > >> The rust bindings for reading device properties has a single
> >> > >> implementation supporting differing sizes of integers. The fwnode=
 C API
> >> > >> already has a similar interface, but it is not exposed with the
> >> > >> fwnode_property_ API. Add the fwnode_property_read_int_array() wr=
apper.
> >>
> >> ...
> >>
> >> > >> +EXPORT_SYMBOL_GPL(fwnode_property_read_int_array);
> >> > >
> >> > > I'm not sure about this. We have a lot of assumptions in the code =
that the
> >> > > arrays beneath are only represented by the selected number of inte=
ger types.
> >> > > This opens a Pandora's box, e.g., reading in u24, which is not sup=
ported by
> >> > > the upper layers..
> >> > >
> >> > >> +int fwnode_property_read_int_array(const struct fwnode_handle *f=
wnode, const char *propname,
> >> > >> +                             unsigned int elem_size, void *val, =
size_t nval);
> >> >
> >> > Here's an alternative approach using a macro to map each integer typ=
e explicitly
> >> > to its corresponding read function. There are some additional change=
s that will
> >> > be necessary to make the rest work, but this is the gist of it.
> >>
> >> I don;'t know Rust to tell anything about this, but at least it feels =
much
> >> better approach.
> >
> > I know a little Rust and it is much worse. It is implementing the same
> > code 8 times instead of 1 time just to work-around the C API.
>
> I prepared a functioning version of the macro-based approach. I'll post
> the patch for reference and discussion. We don't have to go with it.

Please wait for the discussion to finish.

Rob

