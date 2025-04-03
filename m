Return-Path: <linux-acpi+bounces-12696-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974E0A7A792
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 18:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB9F3AA3A0
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 16:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28532512C7;
	Thu,  3 Apr 2025 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osdmGpzD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF700250C1F;
	Thu,  3 Apr 2025 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743696501; cv=none; b=hEEZYP5QIZmvRD1Q79MBgsNwoJ8pAP0epa4Sc+Znz+X0ivllqzcXyYqqg+L5wotdlkb9nioJOXI+LZkivTyIpplylWpsYzKkBc+7XlUsto5W/ze9EQJQtMrk/VDkCnj7zaELYnX6E5FbBHXz1i6aQOIN4SvL47G1qUHaXSJL2gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743696501; c=relaxed/simple;
	bh=gEGKYAZEoePzKrXwvNWYI1CtU+E9aEhhPR/kyywS4RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jDvQjQpLJ3Zr35tUE9B7uIcAe5FXXk5ajYo1mbBnJboBRSpfW6HnMfsLomovC8KVo8UcRYooxVHIBiFDh8Bla/RKyL5JMT9VsZBnH9GJyClqVmlZ42gaEbY1oAFqOIUY2tvtkV2+p+uefCIx/ozhOBH0gAbErRZmeJc5ttCLk9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osdmGpzD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226F3C4AF0B;
	Thu,  3 Apr 2025 16:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743696501;
	bh=gEGKYAZEoePzKrXwvNWYI1CtU+E9aEhhPR/kyywS4RU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=osdmGpzDe1g6mqi6TW2PxhV/CgA5CAQdc+2/xgS6y1RM2F1SYaBYALTINCj9i+UrN
	 143BdFO1f4vck2K8KF0B+L+MJ3i3grUMpOfq+MVPy7r/iN8Hj/0pHiTDioNPvkj3C8
	 kUTm7S8qNrh0ExziAYZ7DiyKbar2zglm1eFMJ8ZCV3ASENAtmIIfFMaoDaeprwKVrY
	 ctRSVbxpVeoBoywXyeV+xZp/Y+GSuJyMr2GQ0S3eWO62KKna0+VfbTWdp4saIzAgG1
	 8LlSBA49eazaMXOZryC4gn+VLxuXJBDyR5RZ1xoD0rUy4EkpLJwkrwMDJuTpbLvE6u
	 Ug7X29x9YrhRQ==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9eb12so1718273a12.1;
        Thu, 03 Apr 2025 09:08:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPTSorcw6rbIguhAMJleZCoYUp/NQhisHZH1mF1aDfj8+k9CQVTjHO22n7Y7FWV/rK25rHKJWPT0OBeZDw@vger.kernel.org, AJvYcCVRVL5nhcX+m3BQkv7x/F0sq2Yh9aCSrII/t34bq7XxscfzKEUKF+7beg7zzlzKOPe+9DjdsAlxNUKF@vger.kernel.org, AJvYcCVtEoLjlK1nW4cCtivclIrdDGqs1YozrSGIiyxN9slDwQJ7st+whX8pD4G61Jlgpl9rTgLFKV1R0XzllQ==@vger.kernel.org, AJvYcCW3tZyTJ84V3sdzDJ01e8J/OcR0wS7Nx5q2/ZvdnYlGonMYUo/IVAIEZ0HpyuhLBZkIcT8NdkWXN/7tZWWrRCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNVZsNAMfem90+XZEV5BJhvPgb8DztIbyIUasITxuiw9mDyTqp
	EvujWlEkYKrk6bSxkCTVe8kJ8hsIZ2qWXYAk/V8VZ/LyCOL3y+74pCgYQU3sqSj+aZpAqXPy/JU
	1r0NtUEzZpNYohgUTgd9DZ8nE+w==
X-Google-Smtp-Source: AGHT+IHmscTaGwO7LnNvWu3XRFwSzOKZ3kzeKT1rfjNXx+XA8krxwiN/UAgxO7RqmNAtS46aSBz26E9rNTAuhvD6UyI=
X-Received: by 2002:a05:6402:51cb:b0:5e6:23c:a242 with SMTP id
 4fb4d7f45d1cf-5f0871e7927mr2878204a12.18.1743696499667; Thu, 03 Apr 2025
 09:08:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326171411.590681-1-remo@buenzli.dev> <20250326171411.590681-4-remo@buenzli.dev>
 <Z-UPJyD41LOMM3o2@smile.fi.intel.com> <D8WA3WIHEQRN.3LQS84K8Z46OW@buenzli.dev>
 <Z-6NG7fSfyKH-vW_@smile.fi.intel.com>
In-Reply-To: <Z-6NG7fSfyKH-vW_@smile.fi.intel.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 3 Apr 2025 11:08:07 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLPZc1LB09auMOJp90hbhJin75Yaa09h12ziZZgExSsBg@mail.gmail.com>
X-Gm-Features: ATxdqUHd96TFG2qW7tZ-hBkIo8v6Ux3T1qGlGrFUSrc98Q86mSDii3n0BKpAGgE
Message-ID: <CAL_JsqLPZc1LB09auMOJp90hbhJin75Yaa09h12ziZZgExSsBg@mail.gmail.com>
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

On Thu, Apr 3, 2025 at 8:29=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Apr 02, 2025 at 06:04:13PM +0200, Remo Senekowitsch wrote:
> > On Thu Mar 27, 2025 at 9:41 AM CET, Andy Shevchenko wrote:
> > > On Wed, Mar 26, 2025 at 06:13:42PM +0100, Remo Senekowitsch wrote:
> > >> The rust bindings for reading device properties has a single
> > >> implementation supporting differing sizes of integers. The fwnode C =
API
> > >> already has a similar interface, but it is not exposed with the
> > >> fwnode_property_ API. Add the fwnode_property_read_int_array() wrapp=
er.
>
> ...
>
> > >> +EXPORT_SYMBOL_GPL(fwnode_property_read_int_array);
> > >
> > > I'm not sure about this. We have a lot of assumptions in the code tha=
t the
> > > arrays beneath are only represented by the selected number of integer=
 types.
> > > This opens a Pandora's box, e.g., reading in u24, which is not suppor=
ted by
> > > the upper layers..
> > >
> > >> +int fwnode_property_read_int_array(const struct fwnode_handle *fwno=
de, const char *propname,
> > >> +                             unsigned int elem_size, void *val, siz=
e_t nval);
> >
> > Here's an alternative approach using a macro to map each integer type e=
xplicitly
> > to its corresponding read function. There are some additional changes t=
hat will
> > be necessary to make the rest work, but this is the gist of it.
>
> I don;'t know Rust to tell anything about this, but at least it feels muc=
h
> better approach.

I know a little Rust and it is much worse. It is implementing the same
code 8 times instead of 1 time just to work-around the C API.

Rob

