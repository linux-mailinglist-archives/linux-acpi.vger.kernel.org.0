Return-Path: <linux-acpi+bounces-14225-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E195FAD11F3
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Jun 2025 13:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B063AB1B2
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Jun 2025 11:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35E61E412A;
	Sun,  8 Jun 2025 11:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBGEVAno"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3022A1BA;
	Sun,  8 Jun 2025 11:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749383183; cv=none; b=XHast8gtxSR482zkVYhx3bLgSAF0LPv3SU2yrohO3Ny7SxsQG47L/retbVqrE6ShGlxlBheJikmuAwo7TkjHa4NvU37ssDADXlWQzFvuzxd5m9qtiqUvCtHgygnj9lsbSbbCX8Rn4MiXPqnw1fw59/VDN+QoezQyi0lcj45ONJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749383183; c=relaxed/simple;
	bh=FQhGPKHnjDJWBuphMJJy3evL9nvvs5J8uvzpqEW7mIs=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Y61WuGvXaE+p0PFtO49pYm9qnK20svA+4m/UdVrjOvAjliQZfVuQ+sGTVsKbJAnznACsTGpeIjRXmWTai4UNwdBJvOWeOQBbKYNylIGBPIgYPX6gkC6fWCrxvOjrUKnF7csW4OQPVXaDee2k5rC2yEX9QgjOwOaeYBYhOgsDnMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBGEVAno; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081BAC4CEEE;
	Sun,  8 Jun 2025 11:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749383183;
	bh=FQhGPKHnjDJWBuphMJJy3evL9nvvs5J8uvzpqEW7mIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HBGEVAnoZBtcaOukjsVBCFyOEs0WVrKtZ62+0dngja02fxCQM+NJcz0p+/aOsSYxK
	 btNZ89U9tV1A3ay37XWlLjEjU44vJiR9FpkDj/xejo8LbAS1Hct8GoEl8CnG8pfFeD
	 9J13nd3cn/obwYXhx6Z7ULMAK+rh8KDFCS/f0Y83WORyHxT/zPMeVB1X832GaBIZV/
	 Hk1uoBgr4NTzeB8o24p5KzO0idgvMpJHYvis/vPTfOw5fur6UjaN/0IgQH9FwSGOo2
	 YCw4ZX8nykvO1FwG/xdAh8Rw/634QBZdvUCn8yD7eUa26eZR5o3dx6dYn5ocii2mzQ
	 4yFWFlKwhas+Q==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 08 Jun 2025 13:46:17 +0200
Message-Id: <DAH4KX3Y3M3P.3B82LSVWU172Q@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Igor Korotin" <igor.korotin.linux@gmail.com>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <rafael@kernel.org>, <gregkh@linuxfoundation.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <benno.lossin@proton.me>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <lenb@kernel.org>, <wedsonaf@gmail.com>, <viresh.kumar@linaro.org>,
 <alex.hung@amd.com>, <dingxiangfei2009@gmail.com>, "Igor Korotin"
 <igorkor.3vium@gmail.com>
Subject: Re: [PATCH v3 2/4] rust: driver: Add ACPI id table support to
 Adapter trait
X-Mailer: aerc 0.20.1
References: <20250606170341.3880941-1-igor.korotin.linux@gmail.com>
 <20250606170817.3881748-1-igor.korotin.linux@gmail.com>
 <DAGZNG518T0C.1PXOK55IXHZOF@kernel.org> <aEVqgUtflBCzZi1X@pollux>
In-Reply-To: <aEVqgUtflBCzZi1X@pollux>

On Sun Jun 8, 2025 at 12:48 PM CEST, Danilo Krummrich wrote:
> On Sun, Jun 08, 2025 at 09:54:30AM +0200, Benno Lossin wrote:
>> On Fri Jun 6, 2025 at 7:08 PM CEST, Igor Korotin wrote:
>> > @@ -141,6 +141,38 @@ pub trait Adapter {
>> >      /// The type holding driver private data about each device id sup=
ported by the driver.
>> >      type IdInfo: 'static;
>> > =20
>> > +    /// The [`acpi::IdTable`] of the corresponding driver
>> > +    fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>>;
>> > +
>> > +    /// Returns the driver's private data from the matching entry in =
the [`acpi::IdTable`], if any.
>> > +    ///
>> > +    /// If this returns `None`, it means there is no match with an en=
try in the [`acpi::IdTable`].
>> > +    #[cfg(CONFIG_ACPI)]
>> > +    fn acpi_id_info(dev: &device::Device) -> Option<&'static Self::Id=
Info> {
>> > +        let table =3D Self::acpi_id_table()?;
>> > +
>> > +        // SAFETY:
>> > +        // - `table` has static lifetime, hence it's valid for read,
>> > +        // - `dev` is guaranteed to be valid while it's alive, and so=
 is `pdev.as_ref().as_raw()`.
>> > +        let raw_id =3D unsafe { bindings::acpi_match_device(table.as_=
ptr(), dev.as_raw()) };
>> > +
>> > +        if raw_id.is_null() {
>> > +            None
>> > +        } else {
>> > +            // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapper =
of `struct of_device_id` and
>> > +            // does not add additional invariants, so it's safe to tr=
ansmute.
>> > +            let id =3D unsafe { &*raw_id.cast::<acpi::DeviceId>() };
>> > +
>> > +            Some(table.info(<acpi::DeviceId as crate::device_id::RawD=
eviceId>::index(id)))
>> > +        }
>> > +    }
>> > +
>> > +    #[cfg(not(CONFIG_ACPI))]
>> > +    #[allow(missing_docs)]
>>=20
>> I think we should change this to one single definition and do
>>=20
>>     if cfg!(not(CONFIG_ACPI)) {
>>         return None;
>>     }
>>     /* body from above */
>>=20
>> In a single function instead.
>
> Generally, that's fine, but in this case I'd rather keep it as it is for
> consistency with the rest of the file.

Then let's also change the OF bindings in this file to that style :)

>> > +    fn acpi_id_info(_dev: &device::Device) -> Option<&'static Self::I=
dInfo> {
>> > +        None
>> > +    }
>> > +
>> >      /// The [`of::IdTable`] of the corresponding driver.
>> >      fn of_id_table() -> Option<of::IdTable<Self::IdInfo>>;
>> > =20
>> > @@ -178,6 +210,11 @@ fn of_id_info(_dev: &device::Device) -> Option<&'=
static Self::IdInfo> {
>> >      /// If this returns `None`, it means that there is no match in an=
y of the ID tables directly
>> >      /// associated with a [`device::Device`].
>> >      fn id_info(dev: &device::Device) -> Option<&'static Self::IdInfo>=
 {
>> > +        let id =3D Self::acpi_id_info(dev);
>> > +        if id.is_some() {
>> > +            return id;
>> > +        }
>>=20
>> Is a driver only going to have one id_info? Or is there some kind of
>> precedence?
>
> A driver potentially has lots of them, but the device is only matching a =
single
> entry in one of the driver's ID tables and hence a single ID info.

Ah so if `of_id_info` and `acpi_id_info` return `Some(_)`, then both
values are the same?

---
Cheers,
Benno

