Return-Path: <linux-acpi+bounces-12486-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2C8A727A1
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 01:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A8E93A9A42
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 00:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A4119A;
	Thu, 27 Mar 2025 00:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vL+NKwqp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74152114;
	Thu, 27 Mar 2025 00:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743033790; cv=none; b=SHE3uGmfsJGcnZ0irax4375NSHtGBAx4QMbvc2GKrvqWvFz29trsfYDQ6zh+L5zS27/55rcOd4wej8jcK/xmLPySCKNk5ScA0rxEKbrJb9y4r2X1CwPhWFQRWlp+cHhLPIhdaXFeEwzRmq1QRYTzqic3W6mwZXdZerRRDrCoUnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743033790; c=relaxed/simple;
	bh=CCjSPDZVo2hoLF4g6LePOKhEhcRY89Xy5MCm450/MOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGjvi71tfcSCvviMv6nessEEMLWpY8bKKnQK38bGpia2t7OFsvxkJnZcfMtvjJMZ5Jp/WNMsSnj4HMUp+ubRfETsVhWqJHxsx6bpN0ohZEUjESERiXnzmoEk85XUGXZKrKkbE1vxqHz8Gb2RFnmzKMpboFzIkAGWVYiCcZ54CII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vL+NKwqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF98C4CEE2;
	Thu, 27 Mar 2025 00:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743033790;
	bh=CCjSPDZVo2hoLF4g6LePOKhEhcRY89Xy5MCm450/MOU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vL+NKwqp8c9HC5c30Q6ri1Y5yuTsi/EpenHjDf9CNMaeXqpxghA8YA6YWhwz1hQ+F
	 VUWA5uSym/8DTgSLWQImCc80GnbJE3NnA1VWdjal24PqvWRmIOA+gf/9OAo9DRVTRW
	 3JpAp9PAt7xs7L0tLjRrrvowhdrURlG2LlCwfG/tg/1NGrjUnDxkvAEGYyM3fu6RLx
	 eIjePamEWaufKTbh1ZSrGZGKhmIlxxiVVLjS89zWUt1kPQy/79qOwHN+ej0psdlae/
	 tzkFnZyhZjYS/msFoHekHQO90cwrJ+u7NsVP8yS0Xu7SCYrhnD/BlOLShy4MmLa0OC
	 A/Ffz0TWBl1XA==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so616917a12.1;
        Wed, 26 Mar 2025 17:03:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2n2u31D6yVidZr7RcImNkQfw0HmVVHa7aiKsQ6HwmexO1b+49n9obxfGrSQ8dBz4N5hOzUZLa3BP4bA==@vger.kernel.org, AJvYcCVcDrf0PJX7ciz8oUIQ1S6BwjMyvmbWYZkV8rj4GQTq7pU1jlwDLziR+7SOK1snnErdgJsRGzHRIR2u0kMF@vger.kernel.org, AJvYcCVkwJdWe+ySZCXd8eloOvyNFIrbCGBgkOD+/ftzjk9mCy9VgWYCVa/tW9ovVkcMqvUqowpVoezGEtJd@vger.kernel.org, AJvYcCWWftW046uoOpveLYzNSAgFTN3Sdt7PItfTjZmHna+HvP1eeLDWtdH8hgJLqaoS1A+mo5K75VPkHaYPU/1Cl3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3U7e55GOL+UndvZdMfZgC12m9LnuqxhgzCgnVjBPNARS6UTdo
	hfM7bB5u+E+u9FZcJs0Zb/2gex9vwcIf+U0rjL3m3SObMhOK28+ZETQ+T2jZAPFLYDEGu+6/fxA
	YfI3Z8MYKZBBanSMwHEPjgAOHFw==
X-Google-Smtp-Source: AGHT+IERzT0kl1LknG2usIHMI1+Lt1VD4s7YUfGbLkTeY7qe+y/QCZpxxzGJSyF5y3Gin8FJCELvt/lRJqwoZFoadfA=
X-Received: by 2002:a17:907:d89:b0:ac6:d9cb:58c0 with SMTP id
 a640c23a62f3a-ac6fb1a73c2mr107112066b.50.1743033788647; Wed, 26 Mar 2025
 17:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326171411.590681-1-remo@buenzli.dev> <20250326171411.590681-11-remo@buenzli.dev>
 <20250326220129.GD2844851-robh@kernel.org> <D8QJSRGJIYHS.K4H9W8N8N0YO@buenzli.dev>
In-Reply-To: <D8QJSRGJIYHS.K4H9W8N8N0YO@buenzli.dev>
From: Rob Herring <robh@kernel.org>
Date: Wed, 26 Mar 2025 19:02:56 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK0SH+HTtquxDNvp8jCLwJgg7YJDNQT8h=kHO=nJChk4Q@mail.gmail.com>
X-Gm-Features: AQ5f1JpETx50vOdiMhHoK95MGuYfdGvgMOPx1IsTpXGdDGU44Po8M857aSNDVHs
Message-ID: <CAL_JsqK0SH+HTtquxDNvp8jCLwJgg7YJDNQT8h=kHO=nJChk4Q@mail.gmail.com>
Subject: Re: [PATCH 10/10] samples: rust: platform: Add property read examples
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

On Wed, Mar 26, 2025 at 5:24=E2=80=AFPM Remo Senekowitsch <remo@buenzli.dev=
> wrote:
>
> On Wed Mar 26, 2025 at 11:01 PM CET, Rob Herring wrote:
> >>
> >> +        let prop =3D dev
> >> +            .property_read::<bool>(c_str!("test,bool-prop"))
> >> +            .required()?;
> >
> > The 'required' is kind of odd for boolean properties. They are never
> > required as not present is the only way to to get false.
>
> Agreed. I can think of a few alternatives:
>
> * Make the trait `Property` more flexible to allow each implementor to sp=
ecify
>   what its output type for the `read` function is, via an associated type=
.
>   I really don't like this idea, because overly generic APIs can mess wit=
h type
>   inference and become less ergonomic because of it.
>
> * Use `propert_present` instead. That doesn't perfectly express the inten=
tion,
>   because it doesn't warn if the property is present but has a type other=
 than
>   bool.

Right. I've been cleaning up the tree to use of_property_read_bool()
on bools and of_property_present() on non-bools, so don't want to go
back to 1 function. The C code now warns on a mismatch.

> * Add an additional inherent method `property_read_bool`, which returns a=
 plain
>   `bool` instead of `PropertyGuard<bool>`. Then there will be three sligh=
tly
>   different ways to read a bool: `property_present`, `property_read_bool`=
 and
>   `property_read::<bool>`. Maybe that's confusing.
>
> * Add `property_read_bool` and remove `impl Property for bool`. That woul=
d avoid
>   confusion between `property_read_bool` and `property_read::<bool>`, onl=
y the
>   former would work.

I think I would go with this option. Easier to add another way later
than remove one.

Rob

