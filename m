Return-Path: <linux-acpi+bounces-12706-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F006BA7A9B1
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 20:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB07F175A74
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 18:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAE21A3176;
	Thu,  3 Apr 2025 18:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUNOYoG1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED15C8E0;
	Thu,  3 Apr 2025 18:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743706115; cv=none; b=FEBQmcYBnhODkfAxrnJWYwKmTlPVQec6JOGPeR5O3BNpmioS5bDA0x1mo/X+goJs3eABrrLxhKGZ8UHRMUhI2h5syE1MXVNFS1lCvn0DH3t4r6R6Fwcl8VbiJc7OFxTEpfPOa43VZQbUeUpdOhbWVNCYmMp6mZ0PJTI9RkbksHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743706115; c=relaxed/simple;
	bh=G44VUuTUzqb06IaItXqVoqS3bWxbLoRLOeLD7CzOGNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ar+PyBfJhUvaDUNEpreJDW/ru2OI+qkZHbSqvBcjCjJifTcGxp6cKQxzHYPYimFSfld+q1OApmmPrAcD0uotZIxsZrwRRUqoKM6SfhZJWfy8X17GZHQsqLfcPMs038fFYiNcwPmOxiH56MPB2XpZVSEtciuOh3RS4mLy4m8dIug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUNOYoG1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431F8C4AF09;
	Thu,  3 Apr 2025 18:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743706114;
	bh=G44VUuTUzqb06IaItXqVoqS3bWxbLoRLOeLD7CzOGNs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lUNOYoG1s3T6OPcj1N8KKeVwZiFQFOKb5A3o9Q1V4uD9cgqTmBYCIVuV+xAPkj51Y
	 wrUAi2DLYs45bBWexwhQPRuGn/XD2SA9nLTp3E1ptvDUcIouCOyLPyXGev5cCDLKNW
	 h6VbutjJpIPBV5HF+t/TgqTEg9SQpPHjKv+EdeYd1VlCAnoeF3tGJMu69H6cq9XgOs
	 lFYR1Zb+d2wbNInETEwDt5NaHvU0/kC8hg4nw2NxghuenoUuCNcqcau1MYeiFvAtBe
	 x3nCiO/iTVRnv7diK3y9hPes+/58Rcg2p0LX3K+s2mucxoK0dzxnl64NtfRv8NthFC
	 jQMh4+eXc4USQ==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so2259703a12.0;
        Thu, 03 Apr 2025 11:48:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUMBknAtU1vWSj1ES8+qrsjMSheWnKe/srVOYzTVU/x1MAVm+Bokj7CyAMNLc8RmClc/NgdRNnNt2I3TxsZ@vger.kernel.org, AJvYcCWFxEc36ReRQNnVwoXn0IDNdR5A+9R6FxVTEbjuot3b/qJvpY8jhtn/Fy4wNXw5MN3A3O2ZRLlf/idFtfB+wrU=@vger.kernel.org, AJvYcCXdrEUWrz+9JeCh7+98u8nC7PyGp7L0myUbpPQ5S6EUuhv/tdFKtyBqxDVaaWMJ9zO9+9xrP1T2hWNS@vger.kernel.org, AJvYcCXn/HygmfMfjXjgya8NXMpjsEJrGVc1StzGwzWLWQqab6MablQM3PmK8cdd/KjxIcIsG/gFzLxRdscQ5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHtYWAQPWOmjNCSf72Df3EaI5LqJP5SU7Q5f9e5Ed9lQDrQzui
	dMm7sqfz9el5uyt6nGGp7M4ax7uE62A8V2sURLWdT5z9JJg2djdgqC65nOO/1qPJg3DRuD9Dyhf
	NCSrYORW/ApS2iKDOhuVDmYbkOg==
X-Google-Smtp-Source: AGHT+IHgm8pbYdOS0F5PQ7kYibUeJKz/5qpM9TqFT6ZWudl3bYWCBJzuo/+oLo6fusub0DHm1l8JfiMG1rG1XEMl3xU=
X-Received: by 2002:a05:6402:26c7:b0:5e5:dbcd:185e with SMTP id
 4fb4d7f45d1cf-5f0b3b8a5f1mr168010a12.13.1743706112738; Thu, 03 Apr 2025
 11:48:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326171411.590681-1-remo@buenzli.dev> <20250326171411.590681-4-remo@buenzli.dev>
 <Z-UPJyD41LOMM3o2@smile.fi.intel.com> <CAL_Jsq+tJvGsbw1dGdgmBM8+cL4vN71OMTvX9tkmBLNk=6T9KQ@mail.gmail.com>
 <Z-60LwRrw30cq4YE@smile.fi.intel.com> <CAL_JsqKiYCh7ukDoqc_toyn75=3wOM4WyOTGvogoOfdz9T_7Ow@mail.gmail.com>
 <Z-7LcXoGw7uNWBUE@smile.fi.intel.com>
In-Reply-To: <Z-7LcXoGw7uNWBUE@smile.fi.intel.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 3 Apr 2025 13:48:19 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLCa8AjwsUpS-N9FWymG67w7DjmmBZCKW7G7BAfY78vWw@mail.gmail.com>
X-Gm-Features: ATxdqUHA5DvtfxZYWFohpa6BUX3SjkGJ9QCPri0mQnJJCjTfhmdWcw0nmXvsWnQ
Message-ID: <CAL_JsqLCa8AjwsUpS-N9FWymG67w7DjmmBZCKW7G7BAfY78vWw@mail.gmail.com>
Subject: Re: [PATCH 03/10] device property: Add fwnode_property_read_int_array()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Miguel Ojeda <ojeda@kernel.org>
Cc: Remo Senekowitsch <remo@buenzli.dev>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Dirk Behme <dirk.behme@de.bosch.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 12:55=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Apr 03, 2025 at 11:36:38AM -0500, Rob Herring wrote:
> > On Thu, Apr 3, 2025 at 11:15=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Apr 03, 2025 at 11:04:32AM -0500, Rob Herring wrote:
> > > > On Thu, Mar 27, 2025 at 3:41=E2=80=AFAM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Wed, Mar 26, 2025 at 06:13:42PM +0100, Remo Senekowitsch wrote=
:
> > > > > > The rust bindings for reading device properties has a single
> > > > > > implementation supporting differing sizes of integers. The fwno=
de C API
> > > > > > already has a similar interface, but it is not exposed with the
> > > > > > fwnode_property_ API. Add the fwnode_property_read_int_array() =
wrapper.
>
> ...
>
> > > > > > +EXPORT_SYMBOL_GPL(fwnode_property_read_int_array);
> > > > >
> > > > > I'm not sure about this. We have a lot of assumptions in the code=
 that the
> > > > > arrays beneath are only represented by the selected number of int=
eger types.
> > > > > This opens a Pandora's box, e.g., reading in u24, which is not su=
pported by
> > > > > the upper layers..
> > > >
> > > > We can probably drop the export if it is just that which you object=
 to.
> > >
> > > Yes, this is main point, but dropping it does not prevent from still =
using in
> > > the complied-in code. Is it possible to hide it better?
> >
> > Don't put any declaration in the header and declare it in the rust
> > code? But lack of declaration generates warnings.
>
> Exactly. And I believe we have the typed versions of int_array for a reas=
on.
> Otherwise what's the point in having them to begin with?
> (The first what comes to my mind is a compile time type checking, so we d=
on't
>  try to load u8 with u32 data or any other dirty tricks.)
>
> Maybe it deserves a header that can be included explicitly in the rust st=
uff
> and being checked at compile time to avoid people using that? Can we achi=
eve
> something like C preprocessor
>
> #ifndef FOO
> #error This header must not be included directly
> #endif

Looks there are RUST_BINDGEN or __BINDGEN__ define which could be used
here. Don't need a header, just wrap the declaration. No idea which
one would be preferred as there's exactly 1 use of each. Miguel?

Rob

