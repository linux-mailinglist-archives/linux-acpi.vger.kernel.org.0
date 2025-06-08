Return-Path: <linux-acpi+bounces-14221-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F285CAD11D5
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Jun 2025 12:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB81B168FED
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Jun 2025 10:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D5A1F09A7;
	Sun,  8 Jun 2025 10:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+FzWM05"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BB12F3E;
	Sun,  8 Jun 2025 10:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749379721; cv=none; b=sAciZloOT/8JQAPsgWTSPFeOwb0zKbxRyr2RFu2ifYjWAEPw6lpA5gWBS1uxpIZZUGmEqjtSj/vsRfk/JezFmHVfn9dBs8+OM+DBJEZU2IKfV5JtFJh/ifKeaOYJ6zwkUyT/SSnAOFZ1fi/s83WUtNujPSjRIo9fExim6+Zv1ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749379721; c=relaxed/simple;
	bh=AnI/cidWMnRFA5NIz5etjUog1SNqGjwokm1tz/aotaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1X+G4bYNZllayjs8USFIi07YBoQlPF8QX1omYHP7xNK8psDjIgKKnDmCXN6NSDkA+GIN2mU0cKLpWAP9nvv9SqKHmzG0g1tcSYy2rlwHpFgtZDyjgEi3ZHiA87WdfUTw3alY5c+/odiLnRL+fCQUs6CrbAtWvV/+OSFgK//Vzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+FzWM05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708B4C4CEEE;
	Sun,  8 Jun 2025 10:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749379720;
	bh=AnI/cidWMnRFA5NIz5etjUog1SNqGjwokm1tz/aotaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c+FzWM05XYK4BIU51gGGGgEJAWMslEGiEpppSHl69eCMoo0WO2Zr1Rw+nMb88GQyY
	 bag2Cx7wtbzfNraPq9K4PF4C7x4L4Rr0nS/BgJhRzPizjdEx5RxT5OVeLXPEiU6uk3
	 TmVNVVDVOVHVsaIDmR2BCiPvO1fjdsW1BOK2SCqAmg6JUwKqWrG36SUk+dumsG5NZh
	 ExLjsrUGpNxdjb9+CYx8Pt/9DKGG0fRn3R843CV0B1ZNpF2UzkF7/yWtsjq6diPw6y
	 olNrkOjfYCue1r/p5gq7vxrJkHpOohpnsRPtaFiQpe8KGPUjwLPsoeKG4HcQ4oeOU0
	 uA/JY0ol5VMZg==
Date: Sun, 8 Jun 2025 12:48:33 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <lossin@kernel.org>
Cc: Igor Korotin <igor.korotin.linux@gmail.com>, ojeda@kernel.org,
	alex.gaynor@gmail.com, rafael@kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, lenb@kernel.org, wedsonaf@gmail.com,
	viresh.kumar@linaro.org, alex.hung@amd.com,
	dingxiangfei2009@gmail.com, Igor Korotin <igorkor.3vium@gmail.com>
Subject: Re: [PATCH v3 2/4] rust: driver: Add ACPI id table support to
 Adapter trait
Message-ID: <aEVqgUtflBCzZi1X@pollux>
References: <20250606170341.3880941-1-igor.korotin.linux@gmail.com>
 <20250606170817.3881748-1-igor.korotin.linux@gmail.com>
 <DAGZNG518T0C.1PXOK55IXHZOF@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DAGZNG518T0C.1PXOK55IXHZOF@kernel.org>

On Sun, Jun 08, 2025 at 09:54:30AM +0200, Benno Lossin wrote:
> On Fri Jun 6, 2025 at 7:08 PM CEST, Igor Korotin wrote:
> > @@ -141,6 +141,38 @@ pub trait Adapter {
> >      /// The type holding driver private data about each device id supported by the driver.
> >      type IdInfo: 'static;
> >  
> > +    /// The [`acpi::IdTable`] of the corresponding driver
> > +    fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>>;
> > +
> > +    /// Returns the driver's private data from the matching entry in the [`acpi::IdTable`], if any.
> > +    ///
> > +    /// If this returns `None`, it means there is no match with an entry in the [`acpi::IdTable`].
> > +    #[cfg(CONFIG_ACPI)]
> > +    fn acpi_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
> > +        let table = Self::acpi_id_table()?;
> > +
> > +        // SAFETY:
> > +        // - `table` has static lifetime, hence it's valid for read,
> > +        // - `dev` is guaranteed to be valid while it's alive, and so is `pdev.as_ref().as_raw()`.
> > +        let raw_id = unsafe { bindings::acpi_match_device(table.as_ptr(), dev.as_raw()) };
> > +
> > +        if raw_id.is_null() {
> > +            None
> > +        } else {
> > +            // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapper of `struct of_device_id` and
> > +            // does not add additional invariants, so it's safe to transmute.
> > +            let id = unsafe { &*raw_id.cast::<acpi::DeviceId>() };
> > +
> > +            Some(table.info(<acpi::DeviceId as crate::device_id::RawDeviceId>::index(id)))
> > +        }
> > +    }
> > +
> > +    #[cfg(not(CONFIG_ACPI))]
> > +    #[allow(missing_docs)]
> 
> I think we should change this to one single definition and do
> 
>     if cfg!(not(CONFIG_ACPI)) {
>         return None;
>     }
>     /* body from above */
> 
> In a single function instead.

Generally, that's fine, but in this case I'd rather keep it as it is for
consistency with the rest of the file.

> > +    fn acpi_id_info(_dev: &device::Device) -> Option<&'static Self::IdInfo> {
> > +        None
> > +    }
> > +
> >      /// The [`of::IdTable`] of the corresponding driver.
> >      fn of_id_table() -> Option<of::IdTable<Self::IdInfo>>;
> >  
> > @@ -178,6 +210,11 @@ fn of_id_info(_dev: &device::Device) -> Option<&'static Self::IdInfo> {
> >      /// If this returns `None`, it means that there is no match in any of the ID tables directly
> >      /// associated with a [`device::Device`].
> >      fn id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
> > +        let id = Self::acpi_id_info(dev);
> > +        if id.is_some() {
> > +            return id;
> > +        }
> 
> Is a driver only going to have one id_info? Or is there some kind of
> precedence?

A driver potentially has lots of them, but the device is only matching a single
entry in one of the driver's ID tables and hence a single ID info.

