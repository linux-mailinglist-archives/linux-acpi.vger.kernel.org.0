Return-Path: <linux-acpi+bounces-12499-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D2AA733A1
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 14:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138103A9E22
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 13:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4E821579F;
	Thu, 27 Mar 2025 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EV/KxfQb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C16B8BEC;
	Thu, 27 Mar 2025 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743083756; cv=none; b=ljPm6gWvwuqslo+mYjnRNipGqMokEuXk2ZDSMHT+Sg2yNdfl2jaD4DHodrIf0oVdRCQOSlJhNblG6qA3K2kMY79gcHShvwndrOu3QR2V6ths45vZ9S/ZIcFFbdk8YzfgOPJjLjAZ2hDttkagrggX3s7wWRd6ITNoEKY8Wvyx6ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743083756; c=relaxed/simple;
	bh=1ahn52S0KUDmtK33z7svEfP2CGjDVfmB/atebDqTFKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ETgi2RUyMnrkCiCNYKL5ea7+XBws3sMUZknC+Y34v0n4lVfcGU8Lx+2YyVBri+W7UTX0HfF360c/jF294LD6jJY4iGvnarpAFnl592+dSw062veor/yruVidkiFKK/8O8GQ9QkvP2LrIaJ243+JASezVRlHjpwcVJBqxJlw2JKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EV/KxfQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D0DC4CEF4;
	Thu, 27 Mar 2025 13:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743083755;
	bh=1ahn52S0KUDmtK33z7svEfP2CGjDVfmB/atebDqTFKQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EV/KxfQbKVQE/Xhh32pls3VHowTGMWwBqvlK5i+uCtF7tMlVRZ8TkWIBLp9tCMxgy
	 0p5001fqREESfEQLGaJhAcLrm44OHWW33HEmVz3G4H0XHD1HEXOsISIC9aDEYY3Svs
	 e5URMla/v2QstTdDob5RnwvcTzGMvtdrIT5AOcB62bN4v3AgYaz0zan3dViDHBZ5ER
	 LSX+nFaVX0bK2De+dWKX3ybxLogcAVskmEg1mxaPYiemdEf9AHKljSpRnkcuVyXIzc
	 MEkz0Lth5m3VK+5xYxZrXqJFOinJ6JqT6/jG+E6sAjKaWtVYjR4hVRLuG9GW5sxjSn
	 jdgBZ++XNtnqQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2af2f15d1so132364066b.1;
        Thu, 27 Mar 2025 06:55:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+WIWp3JRR/hhcv7wugUAW7FBuH4OHCTKGLPL0jtQEsJ6sLWXtw9OuDJllAb7IBO1sQVoC4ozqziAP@vger.kernel.org, AJvYcCVcESlG2cNg/0qCMavJQlIM3JyEHx2ja8n3S1+LGB9ZltnLhFy3cNy+erH+mwpn8HY0OV+T/y/u2VJx2w==@vger.kernel.org, AJvYcCWXPpuUXbqYd1nzJPcHscCs+Gv32xk0PAuEWDe46G3+bx6NRObaG8ES/xl3VJ+ckXS1McIrSStZQZzG0TdZoXo=@vger.kernel.org, AJvYcCWZ5rUILW81xvBYMzA9D3Ua7TSiHOrpl+HW1t8RIYHSi3b0s1qSUl++T8gdji9G//EALONq6D9rdi/MJm8J@vger.kernel.org
X-Gm-Message-State: AOJu0YyBhk9dpq+742DUSwFwTYxKg//zM9lXZuXE9z/56yzSuYahKr3y
	meK41Fb19bM5m3Qy+nPnp8nDjrWr180oZtX+KwqorMfD9K5i8tPihHuNR+EkWpRElIXmiaFzjFM
	cPUK1BJsDfpbj0CCndhEDNq8JiA==
X-Google-Smtp-Source: AGHT+IEfUnAlbEn5c8C7zrv5VilBfYXTQwORXTJobYHDkpxBenmsrtDu6IozbVwFugPY8mIaVUJRwg4U2RpBt2Ktt8w=
X-Received: by 2002:a17:906:dc8a:b0:abf:7a26:c486 with SMTP id
 a640c23a62f3a-ac6fb10c9ebmr335651766b.40.1743083753985; Thu, 27 Mar 2025
 06:55:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326171411.590681-1-remo@buenzli.dev> <20250326171411.590681-2-remo@buenzli.dev>
 <Z-UOUKq8GKZM1wuo@smile.fi.intel.com>
In-Reply-To: <Z-UOUKq8GKZM1wuo@smile.fi.intel.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 27 Mar 2025 08:55:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKY17zfLo5rUd9zvO46M1_dR0-V1X-d-NmsO+exDbGY5A@mail.gmail.com>
X-Gm-Features: AQ5f1JpHBP9OYrAt6ksLNzcvIfJhXRJNf4iMM1GxH64Mmcu5lH6rMLCYPLqF7Fs
Message-ID: <CAL_JsqKY17zfLo5rUd9zvO46M1_dR0-V1X-d-NmsO+exDbGY5A@mail.gmail.com>
Subject: Re: [PATCH 01/10] rust: Move property_present to property.rs
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

On Thu, Mar 27, 2025 at 3:37=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Mar 26, 2025 at 06:13:40PM +0100, Remo Senekowitsch wrote:
> > Not all property-related APIs can be exposed directly on a device.
> > For example, iterating over child nodes of a device will yield
> > fwnode_handle. Thus, in order to access properties on these child nodes=
,
> > the APIs has to be duplicated on a fwnode as they are in C.
> >
> > A related discussion can be found on the R4L Zulip[1].
> >
> > [1] https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General=
/topic/DS90UB954.20driver.20done.2C.20ready.20to.20upstream.3F/near/5054156=
97
>
> You can make the above to be a Link tag like
>
> Link: ... [1]
>
> > Signed-off-by: Remo Senekowitsch <remo@buenzli.dev>
>
> ...
>
> > +struct fwnode_handle *rust_helper_dev_fwnode(struct device *dev)
> > +{
> > +     return dev_fwnode(dev);
> > +}
>
> Why not const? For most of the property retrieval APIs the parameter is c=
onst.

Because you might need to modify the refcount.

Though the rust code should probably use __dev_fwnode() and/or
__dev_fwnode_const() directly and avoid the need for the helper here.

Rob

