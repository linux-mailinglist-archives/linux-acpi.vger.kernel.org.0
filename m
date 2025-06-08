Return-Path: <linux-acpi+bounces-14218-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51782AD1181
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Jun 2025 09:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62A973AB820
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Jun 2025 07:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1721F869E;
	Sun,  8 Jun 2025 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQEjnddC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE1C1EEA40;
	Sun,  8 Jun 2025 07:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749369279; cv=none; b=apIkXBBblYbRgK/o/zA7hc3GudvRfLxawqnTufYPBuL/w9o7VYMaOwDfvg4qxs4hfC/MCdfxuEur87CjOoL+9uHN+K3v+LmtrLRQwzRoaD0L/5lwF50SNuPuKy2GJTheHvZhJsgARif9iH7xJOuUbFggTGkf2fJgfoRaXtumI/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749369279; c=relaxed/simple;
	bh=V0H2ZPx507hWYzVCRMXOfD4KNfaS9reVDfuV2C0ecY0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=HdVyDnyN/NV0QCvuRyxUejPZRKYOyw3YglBu8XWYHNql5XSwgPLOTELuAaRSANERaW0HIvjywvEVsQEtS7Y6WNHi27HmXaH19A2EywbGOe8fxrEWs1VTS+Hydte2GGzalLdS2hxtcwXp+/Dz+lBuveJyW7u78r6we5zxD2EXzZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQEjnddC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A48C4CEEE;
	Sun,  8 Jun 2025 07:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749369275;
	bh=V0H2ZPx507hWYzVCRMXOfD4KNfaS9reVDfuV2C0ecY0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=QQEjnddCUp9jnzHBvf6ZLQCOwfKRP50j1q63B/fwUqN5W7e8dYh2I1s0a0mfM+psZ
	 8RLTd0c/eh/bwG3FjL4kpS67ZVzTXJp2GAYY1vEa3oWS5BZ3L6lkQVxK8bySaoDSI1
	 pqFiL18h+SmpoihcdTrYXUdYt8gOPTdN4FV9xY+q8ZhghVrR2pcKmQ9oM9XPmcqKXJ
	 toP+GR+OoT7sGPEJP4uu1lJlKnqB2UUK+8TqcbJixbZOAt4ivb49ZB34I8e0mTXGHe
	 8m4eKrBy8Wwpy4RtcDMYAaNqqQFJCOx4CuwJe8MEQ1+8sIXetRSfTAtCpSX42Lnmcz
	 e621Gdho52qsQ==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 08 Jun 2025 09:54:30 +0200
Message-Id: <DAGZNG518T0C.1PXOK55IXHZOF@kernel.org>
Subject: Re: [PATCH v3 2/4] rust: driver: Add ACPI id table support to
 Adapter trait
From: "Benno Lossin" <lossin@kernel.org>
To: "Igor Korotin" <igor.korotin.linux@gmail.com>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <rafael@kernel.org>, <gregkh@linuxfoundation.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>
Cc: <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <benno.lossin@proton.me>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <dakr@kernel.org>, <lenb@kernel.org>,
 <wedsonaf@gmail.com>, <viresh.kumar@linaro.org>, <alex.hung@amd.com>,
 <dingxiangfei2009@gmail.com>, "Igor Korotin" <igorkor.3vium@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250606170341.3880941-1-igor.korotin.linux@gmail.com>
 <20250606170817.3881748-1-igor.korotin.linux@gmail.com>
In-Reply-To: <20250606170817.3881748-1-igor.korotin.linux@gmail.com>

On Fri Jun 6, 2025 at 7:08 PM CEST, Igor Korotin wrote:
> @@ -141,6 +141,38 @@ pub trait Adapter {
>      /// The type holding driver private data about each device id suppor=
ted by the driver.
>      type IdInfo: 'static;
> =20
> +    /// The [`acpi::IdTable`] of the corresponding driver
> +    fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>>;
> +
> +    /// Returns the driver's private data from the matching entry in the=
 [`acpi::IdTable`], if any.
> +    ///
> +    /// If this returns `None`, it means there is no match with an entry=
 in the [`acpi::IdTable`].
> +    #[cfg(CONFIG_ACPI)]
> +    fn acpi_id_info(dev: &device::Device) -> Option<&'static Self::IdInf=
o> {
> +        let table =3D Self::acpi_id_table()?;
> +
> +        // SAFETY:
> +        // - `table` has static lifetime, hence it's valid for read,
> +        // - `dev` is guaranteed to be valid while it's alive, and so is=
 `pdev.as_ref().as_raw()`.
> +        let raw_id =3D unsafe { bindings::acpi_match_device(table.as_ptr=
(), dev.as_raw()) };
> +
> +        if raw_id.is_null() {
> +            None
> +        } else {
> +            // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapper of =
`struct of_device_id` and
> +            // does not add additional invariants, so it's safe to trans=
mute.
> +            let id =3D unsafe { &*raw_id.cast::<acpi::DeviceId>() };
> +
> +            Some(table.info(<acpi::DeviceId as crate::device_id::RawDevi=
ceId>::index(id)))
> +        }
> +    }
> +
> +    #[cfg(not(CONFIG_ACPI))]
> +    #[allow(missing_docs)]

I think we should change this to one single definition and do

    if cfg!(not(CONFIG_ACPI)) {
        return None;
    }
    /* body from above */

In a single function instead.

> +    fn acpi_id_info(_dev: &device::Device) -> Option<&'static Self::IdIn=
fo> {
> +        None
> +    }
> +
>      /// The [`of::IdTable`] of the corresponding driver.
>      fn of_id_table() -> Option<of::IdTable<Self::IdInfo>>;
> =20
> @@ -178,6 +210,11 @@ fn of_id_info(_dev: &device::Device) -> Option<&'sta=
tic Self::IdInfo> {
>      /// If this returns `None`, it means that there is no match in any o=
f the ID tables directly
>      /// associated with a [`device::Device`].
>      fn id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
> +        let id =3D Self::acpi_id_info(dev);
> +        if id.is_some() {
> +            return id;
> +        }

Is a driver only going to have one id_info? Or is there some kind of
precedence?

---
Cheers,
Benno

