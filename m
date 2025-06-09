Return-Path: <linux-acpi+bounces-14241-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEDBAD1E7F
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 15:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19D8B168A96
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 13:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83948257427;
	Mon,  9 Jun 2025 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFWhoZ+4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD24BC148;
	Mon,  9 Jun 2025 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749474586; cv=none; b=so6pDhbB+5Vbn35PcHTjBVuGpOr/G8UVHMXmHjOvOgB5NwiTWspWYcrz1CLH+nmyGsYJ3h3EjXsY5NgmIeTjkQktpqJDEGDCdliEZHlgGPhUsSbadhO+8mNCTwtJwCCtYrl5ooIQWpaemcVfWRDsdIrrlhZSgIekbr13n111tu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749474586; c=relaxed/simple;
	bh=3mRMkIYVTSZC714iTPiHLfKYftqKrauXc24RysnTVR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b67rf+5O/1C/ZMcuRsBsF1/nLvzZEYdeSzea4GmJEE5EbLIaXSm7/Cd3ecJRXHy65N5HPLrFCSyWboe2Ago9PrfOlglNwp5MJkZVrZ4mveHT0wculkT0ReficMEhJjJtbsOZMu5UhuDip4ESsLWsBHey2lliaiLWt/uuS/X015k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFWhoZ+4; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2cc82edcf49so1278500fac.1;
        Mon, 09 Jun 2025 06:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749474583; x=1750079383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzGMkDK3n8nVOfYPfCVF/Okket+ksQrM0KYKB81Tg4M=;
        b=TFWhoZ+4XLGTwVTfl9nP5o1g2u1xLrRz44So7yR38y770gbjlExFs34ZEN9W5raOUq
         0Uu9HQcwlT4Af1gHBcWdUsUM8hpqH1CyGQR+uHY0GStgoomDa8cfD1eP0H49bomXWvzi
         ijRqvDJDt5q5eU3Gyyg6pHO6/rjCn0Rzh3HZ9sGbapONtcHbECNTI0gklvzY9MX2ic+k
         NUhU7y/fqYD0X3QlW8UorQkWfr86Ec6u+RJcro4J8X46OF58hTLVPPgxBlicDI4xiVFj
         i2GcYEZ85FjUw36+5wWA/cHymJzpFLTJC+24TmfWlG2u7pQFjF2h2cRhXFMQ9lgGDhqS
         bm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749474583; x=1750079383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzGMkDK3n8nVOfYPfCVF/Okket+ksQrM0KYKB81Tg4M=;
        b=csUdgv65daLlzslSkL/sEhQx3eMkqPLtUDzglEo1voePd/z1AcokcTitrYi8hZDIIw
         N1vAyKawBj/LCQ/4dsisNq1N8dASGjrqoUU8Ev7tn72suLm9q3nzD+/9NxdJ7CYBvW87
         k5XI06rhLgfxq6a57qZGVTv24XjLQkQ4c1Ed0jvqGdNwAl5UIaki2gMB3P0hiVkjwlEw
         TgZ2evLfz3UvwBWAoL9S/Iyb4wvUD/ENj54494SGbzp7oQQVH3SCaWLouWyRM7xGbBKo
         E4X0qSa8nIgxLA2rBFR5y14oOBMZNjMTNuZqjCzWhjLKDXJYQ342bWRJkuoIdfhCzMdy
         VjDA==
X-Forwarded-Encrypted: i=1; AJvYcCUQS4DsBjyx4pfS2/cx2e5SlSE2h653eRaoUgAkvdDLBLDfXObMZiEDA5+Gfu/WLiKFhRSHG5VpDuV5jRMD@vger.kernel.org, AJvYcCUrydWJfWUQ6dt+Gu42f7ABev7TXINRC0xf0VNNDfXLTWH+pAoty57IAqZhwIEea2rdchO2Qs1YVMDJhGqzOgI=@vger.kernel.org, AJvYcCXPs4Oq4HxF1cza0sqJ0MIrUoUREZcyQhoeKdWLjfaXA/tGYw/DsFrULkaw43sYC6/MoEbvrkCytqTs@vger.kernel.org
X-Gm-Message-State: AOJu0YzMFhX+XWFSQP0Z9qMeaziC+1wQRkXDjVKSI0HpjM+zPD/DXOiO
	8++V2/g/UyKsYUAB+py9QpK7f0mKI/l+FSt1h7cSHYRisl2E73cGkJ0fQKjYMQkR+HXigffJVKU
	CdTDMd8MZDPXGovc+oqJwg+nZPQKfis4=
X-Gm-Gg: ASbGncuWSxfi1PJRsgtnsf5eqYXuu+iPTg2IZr0mhvXs5ej0QzK27W4J3ZfHuPlS1nM
	5tEIaGELOip5y6Yb2nmvBjkWiyzWLe2ezK1m4gccb1h3exyHO7Xbohf7cWca9N9xFYPiKfQtysW
	8xjIVFMtV5NUvPye7hPuLHaLcoIiJW39UUNiapC2lr
X-Google-Smtp-Source: AGHT+IGnzkyGtvwG+PkwyrLhW1g6LMDUIy3ysZMstnNvvxnDsNT5JOLjNFrH7oJPuDjxN77q2VErwB50gLBUlN21Uuk=
X-Received: by 2002:a05:6870:44e:b0:2e8:f5d4:607f with SMTP id
 586e51a60fabf-2ea00f35d72mr8148337fac.26.1749474582685; Mon, 09 Jun 2025
 06:09:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606170341.3880941-1-igor.korotin.linux@gmail.com>
 <20250606170817.3881748-1-igor.korotin.linux@gmail.com> <DAGZNG518T0C.1PXOK55IXHZOF@kernel.org>
 <aEVqgUtflBCzZi1X@pollux> <DAH4KX3Y3M3P.3B82LSVWU172Q@kernel.org> <aEV43zxZmWvDgKES@pollux>
In-Reply-To: <aEV43zxZmWvDgKES@pollux>
From: Igor Korotin <igor.korotin.linux@gmail.com>
Date: Mon, 9 Jun 2025 14:09:31 +0100
X-Gm-Features: AX0GCFsQpkVbAKR-ZkgrNy0-Z7eCS0NS5RCA_sLS9MyOdTTnUwHtGQuu6IUDE0g
Message-ID: <CAJxaTdNZEdK21mFPu2kTJPa7aQ+PpnkwFVdEP5MCt6w+bD0wXA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] rust: driver: Add ACPI id table support to Adapter trait
To: Danilo Krummrich <dakr@kernel.org>
Cc: Benno Lossin <lossin@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, 
	rafael@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, lenb@kernel.org, wedsonaf@gmail.com, 
	viresh.kumar@linaro.org, alex.hung@amd.com, dingxiangfei2009@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 12:50=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Sun, Jun 08, 2025 at 01:46:17PM +0200, Benno Lossin wrote:
> > On Sun Jun 8, 2025 at 12:48 PM CEST, Danilo Krummrich wrote:
> > > On Sun, Jun 08, 2025 at 09:54:30AM +0200, Benno Lossin wrote:
> > >> On Fri Jun 6, 2025 at 7:08 PM CEST, Igor Korotin wrote:
> > >> > @@ -141,6 +141,38 @@ pub trait Adapter {
> > >> >      /// The type holding driver private data about each device id=
 supported by the driver.
> > >> >      type IdInfo: 'static;
> > >> >
> > >> > +    /// The [`acpi::IdTable`] of the corresponding driver
> > >> > +    fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>>;
> > >> > +
> > >> > +    /// Returns the driver's private data from the matching entry=
 in the [`acpi::IdTable`], if any.
> > >> > +    ///
> > >> > +    /// If this returns `None`, it means there is no match with a=
n entry in the [`acpi::IdTable`].
> > >> > +    #[cfg(CONFIG_ACPI)]
> > >> > +    fn acpi_id_info(dev: &device::Device) -> Option<&'static Self=
::IdInfo> {
> > >> > +        let table =3D Self::acpi_id_table()?;
> > >> > +
> > >> > +        // SAFETY:
> > >> > +        // - `table` has static lifetime, hence it's valid for re=
ad,
> > >> > +        // - `dev` is guaranteed to be valid while it's alive, an=
d so is `pdev.as_ref().as_raw()`.
> > >> > +        let raw_id =3D unsafe { bindings::acpi_match_device(table=
.as_ptr(), dev.as_raw()) };
> > >> > +
> > >> > +        if raw_id.is_null() {
> > >> > +            None
> > >> > +        } else {
> > >> > +            // SAFETY: `DeviceId` is a `#[repr(transparent)` wrap=
per of `struct of_device_id` and
> > >> > +            // does not add additional invariants, so it's safe t=
o transmute.
> > >> > +            let id =3D unsafe { &*raw_id.cast::<acpi::DeviceId>()=
 };
> > >> > +
> > >> > +            Some(table.info(<acpi::DeviceId as crate::device_id::=
RawDeviceId>::index(id)))
> > >> > +        }
> > >> > +    }
> > >> > +
> > >> > +    #[cfg(not(CONFIG_ACPI))]
> > >> > +    #[allow(missing_docs)]
> > >>
> > >> I think we should change this to one single definition and do
> > >>
> > >>     if cfg!(not(CONFIG_ACPI)) {
> > >>         return None;
> > >>     }
> > >>     /* body from above */
> > >>
> > >> In a single function instead.
> > >
> > > Generally, that's fine, but in this case I'd rather keep it as it is =
for
> > > consistency with the rest of the file.
> >
> > Then let's also change the OF bindings in this file to that style :)
>
> Fine for me.
>
> @Igor: If you do so, please do it in a seaparate patch.

That's definitely not possible with `if cfg!(not(CONFIG_ACPI))`
because it is a runtime condition and it breaks compilation in case
either `CONFIG_OF` or `CONFIG_ACPI` is not set, the Rust compiler
can't find `of_match_device`/`acpi_match_device` because in that case
they are defined as `static inline` and are not parsed by bindgen.

Alternatively the following pattern works:

    fn foo() {
        #[cfg(not(CONFIG_ACPI))] {
            None
        }

        #[cfg(CONFIG_ACPI)] {
             // some logic.
        }
    }

Also the argument `dev` of `both of_id_info` and `acpi_id_info`  must be
renamed into `_dev` to mark it as unused in case CONFIG_ACPI/CONFIG_OF
is off and the argument is not used.

Let me know if this pattern is acceptable. To my opinion it is not much
different from the original 2 functions conditioned by #[cfg] and
requires some nasty changes.

Thanks
Igor

