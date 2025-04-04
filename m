Return-Path: <linux-acpi+bounces-12754-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4975CA7BEC6
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 16:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16CD4179DA2
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 14:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BE81F2B94;
	Fri,  4 Apr 2025 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYTpW7l1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DB61EF0B9;
	Fri,  4 Apr 2025 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743775992; cv=none; b=cEF7/LjYaXgfBaiZubJA+ddrf5TwlsQsnv1iqFfM4Wg5K97+F6IeK5xSJjAUbAx6H+gzhQnHx3GvDRPBBCRBUllQ1iCWvyp/mNf5Q1b1LgsS0Bfu1ZazkGqNggkb5SHcV+1YoKLbz3YE+lYPVeiQkb+Tr3kvRrJgKsG+aw6gbL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743775992; c=relaxed/simple;
	bh=EL7oi2/m85Kv7csUQ8MDtG6477di5KZ8Vv1tGjjgOBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TUvxtV9YCLK91l91aZ+EfWw6kIHXVi2HrdPYBeLoeQL6A2e4r4esrfCHcpdg5GVoolEPwnuKe5kTXhIEvxsD11qFXJSikgkL+k1DqENSxhbpYPLVDYKGRfbgePcA/OMljoark77Avnf4tBh5/KlP1CJTI3D2ht/c8jI7bIFc8Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYTpW7l1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD78C4CEE8;
	Fri,  4 Apr 2025 14:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743775990;
	bh=EL7oi2/m85Kv7csUQ8MDtG6477di5KZ8Vv1tGjjgOBk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dYTpW7l1losml3CYXnM2+/9RTN+kRplk1y1a+MLfSztD2vBz0JGqTjsUHrAm3qTpz
	 A3oxqJtMqrcbJaDjSBG6PYQ6pWPuh5kQVOo8QlCV+OYOKFPNew31NLD+Z2Ra8ojz9u
	 BVq2zY28+eBq3tuFTEYxZu6zAF42xZL7V7GhwF6xotOfLtJ1bsYffVovtgDwg8ybHO
	 KoiSa7GTvIlg/xbf7mUb3Ik7lr4M4iFjRr7RCnZGZP6pTUgYCn8BRDd0CaQjPIu6lb
	 zVEjaunh98vLcoRJhNVcDxx1qWs8yiwZ9rRz5bxx4p73M0NkHQRgQjRuZD5qCtrC5g
	 7mM8WqP0Po0PQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2963dc379so339171566b.2;
        Fri, 04 Apr 2025 07:13:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8VBboLnPzk4EOJmRJV7MeZOK/9SAC3ZnfQKR4q9A3ktIsJkJt52NsD2mKci6wGqX2+aqD20q+dG9DHXjB@vger.kernel.org, AJvYcCULfWe0VpviVdkArRXIfiAhY8X7i6MgcrNbKQ7OmRaV4OxJLZrbyeUBrnbm3P0hVxPCPUvjTrnz4Ggt@vger.kernel.org, AJvYcCV5YtuFaru7WD8omqHAE7ajBL9Pzf+T3MCS7I+6psRH/ok3tF9tEqN10VB+/zyUFupfnsPxFbrFXq/n8A==@vger.kernel.org, AJvYcCX2hCbStwCHBhH+ZEJjVldDFESVlRLQhe5iM0G9WAkrmswJLRFlxRM1rCDL6OXVIXmCZ6SPpmkC5JC+KZyko0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdP1F2ohfZ3kY4FfyJi386Vd9g7xEtWvGLIepYsN3AcFMxjdyt
	ESIsUhl/igkt3APp3Lbs9ZSb0uNIxi96i4uCvgdvaR9nC2H7jEW4s/VteIw7vfrLpLdV5iu2ssh
	6NB4JvFE74F50bwuBqxzxBxrYww==
X-Google-Smtp-Source: AGHT+IH2xZciNnrePOn7PFRsdNZCfWkEZWTMbMOOyl4q4+IVMO9VZ6AF2DruwUbn9tSbS4OBxTe5eyCs5VZiI6Ii+E4=
X-Received: by 2002:a17:907:1b08:b0:abf:a387:7e35 with SMTP id
 a640c23a62f3a-ac7d19f4f50mr368734866b.53.1743775989309; Fri, 04 Apr 2025
 07:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326171411.590681-1-remo@buenzli.dev> <20250326171411.590681-4-remo@buenzli.dev>
 <Z-UPJyD41LOMM3o2@smile.fi.intel.com> <CAL_Jsq+tJvGsbw1dGdgmBM8+cL4vN71OMTvX9tkmBLNk=6T9KQ@mail.gmail.com>
 <Z-60LwRrw30cq4YE@smile.fi.intel.com> <CAL_JsqKiYCh7ukDoqc_toyn75=3wOM4WyOTGvogoOfdz9T_7Ow@mail.gmail.com>
 <Z-7LcXoGw7uNWBUE@smile.fi.intel.com> <CAL_JsqLCa8AjwsUpS-N9FWymG67w7DjmmBZCKW7G7BAfY78vWw@mail.gmail.com>
 <CANiq72=iD5ogB2Qjn=WNbghouuER5ypND9=Y_wFiTDfPC2NgFA@mail.gmail.com> <Z--7vN1h0jwgLUyF@smile.fi.intel.com>
In-Reply-To: <Z--7vN1h0jwgLUyF@smile.fi.intel.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 4 Apr 2025 09:12:57 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+S6=k4+Y4rcOsgtrSHC0AtSPx_8B8TMW-rm0YsrjoaXA@mail.gmail.com>
X-Gm-Features: ATxdqUHdrvIjuE8QyPUip-zFccUDXruULn0BP0ZVUYyWnPCy_seCxXopQlF_ly4
Message-ID: <CAL_Jsq+S6=k4+Y4rcOsgtrSHC0AtSPx_8B8TMW-rm0YsrjoaXA@mail.gmail.com>
Subject: Re: [PATCH 03/10] device property: Add fwnode_property_read_int_array()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Remo Senekowitsch <remo@buenzli.dev>, Daniel Scally <djrscally@gmail.com>, 
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

On Fri, Apr 4, 2025 at 6:00=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Apr 03, 2025 at 10:36:40PM +0200, Miguel Ojeda wrote:
> > On Thu, Apr 3, 2025 at 8:48=E2=80=AFPM Rob Herring <robh@kernel.org> wr=
ote:
> > >
> > > Looks there are RUST_BINDGEN or __BINDGEN__ define which could be use=
d
> > > here. Don't need a header, just wrap the declaration. No idea which
> > > one would be preferred as there's exactly 1 use of each. Miguel?
> >
> > If you mean bcachefs' `RUST_BINDGEN`, then I think that one comes from
> > bcachefs-tools, i.e. we don't define it.
>
> But is there a way to have a function that is not really exported to be u=
sed in
> Rust only code?

#ifdef __BINDGEN__
int fwnode_property_read_int_array(const struct fwnode_handle *fwnode,
const char *propname,
                                unsigned int elem_size, void *val, size_t n=
val);
#endif

Rob

