Return-Path: <linux-acpi+bounces-14248-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34975AD2139
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 16:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED69D168945
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 14:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB2425229D;
	Mon,  9 Jun 2025 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiBDwxpl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC1625E456;
	Mon,  9 Jun 2025 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749480280; cv=none; b=r4n0VFsOTzEj6p0RSiwcwaMzMaKb7x4mjG6rZFCY/watcWaxGSdYo8ht8Gj+JFNiLcxYiQ0zGu4v/0snattZR3x6+x4pehNI0KTyZCpDNVjAm3Z+sXVFbCtzjDmgyxm//ykUKagXT2icHEo+DEp/gk200fXMmqJcu4MyZZkGR6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749480280; c=relaxed/simple;
	bh=HEwGfrYE+2z+Z0Xje7AAWmPnND3J6qC5RIA57A8gRIY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gTICUXwsmG51pd0KtWSqK5mobH4yVyjyKSATcGz9goNngBVXVhDOOs8s0fg0g7c7znxQeeCs1T8YDa9oPnZo7V+8bwjrwCOEV2IOLktih9Xq9og8y1JV2/JqQ4gjGNGdI15u0ZIDKrR06IPgUnTTOjEY6IUSwH71KBVURxT24oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiBDwxpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA15C4CEEB;
	Mon,  9 Jun 2025 14:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749480279;
	bh=HEwGfrYE+2z+Z0Xje7AAWmPnND3J6qC5RIA57A8gRIY=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=DiBDwxplqBP0kvNlqjxNelsdkgej+76ey6F3qsOhSG+fRJ9j1JaF9aqelNGGYWFsM
	 LqtVLvjJl5dC3EZG/9ezL09/xTGoch0tsYMydCFaoxUdc9WeMzqSM8vvMeuGctz/QZ
	 YDh2Ge6QAsdhk2jlWt0ni1l4QrEw+AcgosXAH2DCw6qQSvsjdsUF+Gm/C9BW3sQwLm
	 35cWar+BY8NsGWCZcTE49scImlFCnBWKiHPgKex+RWXx2P8Hz9Gk/pxRQXkfCr6JoD
	 lNE9gWUk9Yrs/U71tKPlIuzedkyxTmFILBUMw4Eo4iudukuozCAED70h5DF6xJ1tLE
	 W2GNdbCjLqnsQ==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Jun 2025 16:44:33 +0200
Message-Id: <DAI2ZYFSORPD.3LJ9L234S6LZ2@kernel.org>
Cc: <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <rafael@kernel.org>,
 <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <benno.lossin@proton.me>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <lenb@kernel.org>, <wedsonaf@gmail.com>,
 <viresh.kumar@linaro.org>, <alex.hung@amd.com>,
 <dingxiangfei2009@gmail.com>
Subject: Re: [PATCH v3 2/4] rust: driver: Add ACPI id table support to
 Adapter trait
From: "Benno Lossin" <lossin@kernel.org>
To: "Igor Korotin" <igor.korotin.linux@gmail.com>, "Danilo Krummrich"
 <dakr@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250606170341.3880941-1-igor.korotin.linux@gmail.com>
 <20250606170817.3881748-1-igor.korotin.linux@gmail.com>
 <DAGZNG518T0C.1PXOK55IXHZOF@kernel.org> <aEVqgUtflBCzZi1X@pollux>
 <DAH4KX3Y3M3P.3B82LSVWU172Q@kernel.org> <aEV43zxZmWvDgKES@pollux>
 <CAJxaTdNZEdK21mFPu2kTJPa7aQ+PpnkwFVdEP5MCt6w+bD0wXA@mail.gmail.com>
In-Reply-To: <CAJxaTdNZEdK21mFPu2kTJPa7aQ+PpnkwFVdEP5MCt6w+bD0wXA@mail.gmail.com>

On Mon Jun 9, 2025 at 3:09 PM CEST, Igor Korotin wrote:
> On Sun, Jun 8, 2025 at 12:50=E2=80=AFPM Danilo Krummrich <dakr@kernel.org=
> wrote:
>> On Sun, Jun 08, 2025 at 01:46:17PM +0200, Benno Lossin wrote:
>> > On Sun Jun 8, 2025 at 12:48 PM CEST, Danilo Krummrich wrote:
>> > > On Sun, Jun 08, 2025 at 09:54:30AM +0200, Benno Lossin wrote:
>> > >> On Fri Jun 6, 2025 at 7:08 PM CEST, Igor Korotin wrote:
>> > >> > @@ -141,6 +141,38 @@ pub trait Adapter {
>> > >> >      /// The type holding driver private data about each device i=
d supported by the driver.
>> > >> >      type IdInfo: 'static;
>> > >> >
>> > >> > +    /// The [`acpi::IdTable`] of the corresponding driver
>> > >> > +    fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>>;
>> > >> > +
>> > >> > +    /// Returns the driver's private data from the matching entr=
y in the [`acpi::IdTable`], if any.
>> > >> > +    ///
>> > >> > +    /// If this returns `None`, it means there is no match with =
an entry in the [`acpi::IdTable`].
>> > >> > +    #[cfg(CONFIG_ACPI)]
>> > >> > +    fn acpi_id_info(dev: &device::Device) -> Option<&'static Sel=
f::IdInfo> {
>> > >> > +        let table =3D Self::acpi_id_table()?;
>> > >> > +
>> > >> > +        // SAFETY:
>> > >> > +        // - `table` has static lifetime, hence it's valid for r=
ead,
>> > >> > +        // - `dev` is guaranteed to be valid while it's alive, a=
nd so is `pdev.as_ref().as_raw()`.
>> > >> > +        let raw_id =3D unsafe { bindings::acpi_match_device(tabl=
e.as_ptr(), dev.as_raw()) };
>> > >> > +
>> > >> > +        if raw_id.is_null() {
>> > >> > +            None
>> > >> > +        } else {
>> > >> > +            // SAFETY: `DeviceId` is a `#[repr(transparent)` wra=
pper of `struct of_device_id` and
>> > >> > +            // does not add additional invariants, so it's safe =
to transmute.
>> > >> > +            let id =3D unsafe { &*raw_id.cast::<acpi::DeviceId>(=
) };
>> > >> > +
>> > >> > +            Some(table.info(<acpi::DeviceId as crate::device_id:=
:RawDeviceId>::index(id)))
>> > >> > +        }
>> > >> > +    }
>> > >> > +
>> > >> > +    #[cfg(not(CONFIG_ACPI))]
>> > >> > +    #[allow(missing_docs)]
>> > >>
>> > >> I think we should change this to one single definition and do
>> > >>
>> > >>     if cfg!(not(CONFIG_ACPI)) {
>> > >>         return None;
>> > >>     }
>> > >>     /* body from above */
>> > >>
>> > >> In a single function instead.
>> > >
>> > > Generally, that's fine, but in this case I'd rather keep it as it is=
 for
>> > > consistency with the rest of the file.
>> >
>> > Then let's also change the OF bindings in this file to that style :)
>>
>> Fine for me.
>>
>> @Igor: If you do so, please do it in a seaparate patch.
>
> That's definitely not possible with `if cfg!(not(CONFIG_ACPI))`
> because it is a runtime condition and it breaks compilation in case
> either `CONFIG_OF` or `CONFIG_ACPI` is not set, the Rust compiler
> can't find `of_match_device`/`acpi_match_device` because in that case
> they are defined as `static inline` and are not parsed by bindgen.
>
> Alternatively the following pattern works:
>
>     fn foo() {
>         #[cfg(not(CONFIG_ACPI))] {
>             None
>         }
>
>         #[cfg(CONFIG_ACPI)] {
>              // some logic.
>         }
>     }

We might want to add a `cfg_if!` macro that expands to this.

> Also the argument `dev` of `both of_id_info` and `acpi_id_info`  must be
> renamed into `_dev` to mark it as unused in case CONFIG_ACPI/CONFIG_OF
> is off and the argument is not used.

You can add a `let _ =3D dev;` in the `not` "branch".

---
Cheers,
Benno

