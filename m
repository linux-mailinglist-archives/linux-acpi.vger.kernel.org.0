Return-Path: <linux-acpi+bounces-12870-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500F0A81365
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 19:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29ED84A07F9
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 17:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F4C2356D6;
	Tue,  8 Apr 2025 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCZc2oYq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F5F14AD2D;
	Tue,  8 Apr 2025 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744132791; cv=none; b=lPV25oZjoDwLVv7JSO67rRw5ZsrRwNluoBXF5BTzuAr+M7IYIVGVSFIf8jO9oy9ERtlesVfhkSLh/viBSShchChrLKoPHBaF3Z+kXOGu6lhxOzxZaMg0YYIC++iT232SvWHSiDe+ZgNx9T8qiMgZzM9F7MUXvBJzb0ziXOOzffc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744132791; c=relaxed/simple;
	bh=U669dnRQH7czDNzWqUFUuMlBcJP3S6KYnqImh3r2v0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DBIBd3t+ULQj4enqQPt4KLtbOOrDkwTrUmT+kx7sylP3npnwgTgbXNehnOU221eOQtPBzGfYS9zQH3YRUW35yTJxKuin/QKcGzXhv4W74zn/B3ifvfuU45eGkx1osJI8bexhxw8e1ija18PEcvP9AUuIfuiS4QTB1VJXrnpJ1Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCZc2oYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6CDC4CEED;
	Tue,  8 Apr 2025 17:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744132790;
	bh=U669dnRQH7czDNzWqUFUuMlBcJP3S6KYnqImh3r2v0g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZCZc2oYqjrpZjQFSRgKZfWFz45yphLgC/LSluEpThaHwlfiGRb58xGYvdO3hYJcQ4
	 PvQwrDkosLvcScbvV45yJkTqaD3zkslnTF2xmERGbqIe8Kz4lEEu/hzp4wa1+rX535
	 wxThVTsccNPERYXAdv7239tZy1RYeYSFTTPaV7rO4+wlvpaIyFhT6tDRGSK3rcTM2P
	 1OvlCGWpH126kfYyakDJCErmcyYBpo94G66+xhsh57BcKWFO8zVzj8EdFpVGuvWgzE
	 WohDiePHf3m3hgy2eNF42NgpMHKLhkUVLTyBFhz4+PhxaT8XkM1GpsqUad3rl2a9F2
	 pxEs98JoQlOsg==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5cd420781so10477085a12.2;
        Tue, 08 Apr 2025 10:19:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlfQ9DkkgyNPd1NrghqZcDSnRq3HlIoyVLSTgWznmmdEDKO2/NwoMNkjmazV2sLTSp2p3/Ue92OpWf@vger.kernel.org, AJvYcCWXcPtOgaHnIqJV68vlKCUNoSVlOBSqdQMApmobazuqtRM/doc0VdQS10iWr0rjfu3e6aAtzKHmLwppdD3t@vger.kernel.org, AJvYcCXRYQDgGPH6yrQaRQE6MEcnyQ4sUs4TI4kQpWR+qzBsw94bMvpyUMWlNVuk6Vd5h8hQIyC0BDKNGeW5hg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKZSILVG4q8XB4IIEfhIZwyUd1bG3xXlraqlJymz+WPPkgAvPH
	lyPKO9rliZdGRse/47euDrvX3ZWkJKQJYQsdYucIOLr1JPG0Oyt/JVJdkDG0ZMhL+bD6E+KDQ8q
	9F39KUNFLbB/E5QRLuKV5EQzZFg==
X-Google-Smtp-Source: AGHT+IGZRWBkVFARy4u9eBhNgtJLapB3TFqzZKxTqTUFfra1UJfhPaSVR0H3Ymc4n8tBpwFrpmYLa2yoknPDb57Ejf8=
X-Received: by 2002:a05:6402:50c7:b0:5eb:4e69:2578 with SMTP id
 4fb4d7f45d1cf-5f0db81be66mr11324732a12.13.1744132789461; Tue, 08 Apr 2025
 10:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407223714.2287202-1-sean.anderson@linux.dev>
 <20250407223714.2287202-3-sean.anderson@linux.dev> <CAL_JsqLQvyBvOXJJhRcnVAVx81MUf9YwtyZ5VC-whwY=uoeDXw@mail.gmail.com>
 <52d79db7-f1fa-4695-aeb6-d07d6c2f90dc@linux.dev> <CAL_JsqJ_EqsxrY67OPm+t6tU5ikFA-TZ-fFqHPYQMuy16c_kLg@mail.gmail.com>
 <2d674a0e-9a54-4315-bd81-0cb3a2fb1602@linux.dev>
In-Reply-To: <2d674a0e-9a54-4315-bd81-0cb3a2fb1602@linux.dev>
From: Rob Herring <robh@kernel.org>
Date: Tue, 8 Apr 2025 12:19:38 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLWAHD81zsWHL-wZqu4Ao8qntSDSwgU7wJ7HuyuSxQXGA@mail.gmail.com>
X-Gm-Features: ATxdqUHMcL5qfIIZT8rw4kE9fnQMI0i354qvFstiOUw41LgdZIAWdhmhfWysIF8
Message-ID: <CAL_JsqLWAHD81zsWHL-wZqu4Ao8qntSDSwgU7wJ7HuyuSxQXGA@mail.gmail.com>
Subject: Re: [PATCH 2/2] device property: Add fwnode_property_get_reference_optional_args
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 10:28=E2=80=AFAM Sean Anderson <sean.anderson@linux.=
dev> wrote:
>
> On 4/8/25 11:19, Rob Herring wrote:
> > On Tue, Apr 8, 2025 at 10:12=E2=80=AFAM Sean Anderson <sean.anderson@li=
nux.dev> wrote:
> >>
> >> On 4/8/25 09:00, Rob Herring wrote:
> >> > On Mon, Apr 7, 2025 at 5:37=E2=80=AFPM Sean Anderson <sean.anderson@=
linux.dev> wrote:
> >> >>
> >> >> Add a fwnode variant of of_parse_phandle_with_optional_args to allo=
w
> >> >> nargs_prop to be absent from the referenced node. This improves
> >> >> compatibility for references where the devicetree might not always =
have
> >> >> nargs_prop.
> >> >
> >> > Can't we just make fwnode_property_get_reference_args() handle this
> >> > case? Or why is it not just a 1 line wrapper function?
> >>
> >> fwnode_property_get_reference_args ignores nargs when nargs_prop is
> >> non-NULL. So all the existing callers just pass 0 to nargs. Rather tha=
n
> >> convert them, I chose to add another function with different defaults.
> >> There are only four callers that pass nargs_prop, so I could just as
> >> easily change the callers instead.
> >
> > Why do you have to change the callers? nargs value won't matter
> > because they obviously have nargs_prop present or they would not have
> > worked in the first place. If behavior changes because there's an
> > error in their DT, who cares. That's their problem for not validating
> > the DT.
>
> Because the change would be to make nargs matter even when nargs_prop is
> present. For the sake of example, consider something like
>
>   foo: foo {
>     #my-cells =3D <1>;
>   };
>
>   bar: bar {
>   };
>
>   baz {
>     my-prop =3D <&bar>, <&foo 5>, ;
>     my-prop-names =3D "bar", "foo";
>   };
>
> Before we would have
>
> fwnode_property_get_reference_args(baz, "my-prop", NULL, 0, "bar", args) =
<bar>
> fwnode_property_get_reference_args(baz, "my-prop", NULL, 0, "foo", args) =
<foo>
> fwnode_property_get_reference_args(baz, "my-prop", "#my-cells", -1, "bar"=
, args) ERROR
> fwnode_property_get_reference_args(baz, "my-prop", "#my-cells", -1, "foo"=
, args) ERROR
> fwnode_property_get_reference_args(baz, "my-prop", "#my-cells", 0, "bar",=
 args) ERROR
> fwnode_property_get_reference_args(baz, "my-prop", "#my-cells", 0, "foo",=
 args) ERROR
>
> and after we would have
>
> fwnode_property_get_reference_args(baz, "my-prop", NULL, 0, "bar", args) =
<bar>
> fwnode_property_get_reference_args(baz, "my-prop", NULL, 0, "foo", args) =
<foo>
> fwnode_property_get_reference_args(baz, "my-prop", "#my-cells", -1, "bar"=
, args) ERROR
> fwnode_property_get_reference_args(baz, "my-prop", "#my-cells", -1, "foo"=
, args) ERROR
> fwnode_property_get_reference_args(baz, "my-prop", "#my-cells", 0, "bar",=
 args) <bar>
> fwnode_property_get_reference_args(baz, "my-prop", "#my-cells", 0, "foo",=
 args) <foo 5>
>
> The problem is that all existing callers pass nargs=3D0 when
> nargs_prop=3D"#my-cells" so they will get the new behavior even when they
> shouldn't. So if we change the behavior we have to change the callers
> too. If we make a new function with new behavior the callers stay the
> same.

It does not matter! It is not the kernel's job to validate the DT. If
it was: it does a terrible job at it and we wouldn't have needed
dtschema. In your example, the change actually makes things work
despite the error! Why would you not want that? No one is relying on
the last 2 cases returning an error other than to debug their DT.

That being said, looking at the DT side, we have
of_parse_phandle_with_args(), of_parse_phandle_with_fixed_args(), and
of_parse_phandle_with_optional_args(). We should mirror that API here
as you have done. So to rephrase, make
fwnode_property_get_reference_args() contents a static function and
then both fwnode_property_get_reference_args() and
fwnode_property_get_reference_optional_args() call that static
function. IOW, similar to the DT API implementation using
__of_parse_phandle_with_args().

Rob

