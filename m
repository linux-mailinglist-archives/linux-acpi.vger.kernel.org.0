Return-Path: <linux-acpi+bounces-14272-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF68AD3E9B
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 18:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B1AF7AB8DA
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 16:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE32823958C;
	Tue, 10 Jun 2025 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7ezQRyy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F46A2116F5;
	Tue, 10 Jun 2025 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749572112; cv=none; b=dCW/yL5NnMEtVZJWhbkQqbCMZrmcsrlQFv7YAn/PfHGcEB5m3psOzhBW+zYrXv35FkjGv3/m6neNsqsOIgcJe/wQrwIKIoa7en/WZlIWp1o4Fno8kmgSD6tA3flT+Nmvu8p4F1lX/xGDFDJHP8ilaKOXNU+mSA7O3iqBfr76gB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749572112; c=relaxed/simple;
	bh=EnE3iCmdmPCrC78MsYphV4x/iTw7Ie5czyJvF6gMHXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6o76vvusAZ3kOsCysC0jhRc652HR+ZKGgYhEGVAD5zLpYew/OnwH/qHXWmhqY9yNGvs5O2HnMgcxCNO5mbbsTxyf7kyk2G0h8fPKgQjVo+a6pp6FvL/IoJoZpLFYjJ0IcldeN42dcBCtqtQkrFURhWprpoKjPimwWRra/fImD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7ezQRyy; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-60ef6bf2336so4224520eaf.0;
        Tue, 10 Jun 2025 09:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749572110; x=1750176910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ta7maDhtSE3i5q5bUhjou/IV8ubkgGzHQ0R4B2/Mhjw=;
        b=R7ezQRyyljMuLNX4La5zJmvGyoYGXZnrQ+kH4k6qDDoPmJWiYvqXBjTBlenuRZdvZ5
         pj8IyB3B1e/hWFp9bYluF2KY/qQAaBXrY+8PrsWvBB9P4r0Y78W/lYTx11USq5qVkTFK
         Mk7BOwpieeODC1BbBC/g904hqfGPBNZ5mZNvG3DVHbF6NzkU5j3yog1RVVWqi+x9Du/x
         xrhff6G5NtISlk27B1ic7UDjZ65X6jYhDhR9WdhZpRhVE0ppGkvvQSA0CotCzV0cluii
         caZ7iNaTjnsuteegnbVKo2tCrHogn+Og7BclP1SyIJdfdPhIuLI36MYN+XuC0cKO1HNG
         FXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749572110; x=1750176910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ta7maDhtSE3i5q5bUhjou/IV8ubkgGzHQ0R4B2/Mhjw=;
        b=OV1FLg7tFCOmQtg4cHAutKFyhEajNDMyBbv1jIj3G0hJ55qNYHLY1l4ZcwOrqNXFNQ
         1F2RsLX+RQNvxiTdtSmeHaTax9al2xRKKotUeUL73VXYaPlkJ6cs/he5yi3eBFPXKUDK
         aUikcLQb9cFGNVhYG3aF1a+PR7MVziKQnRTvDMH0mtFxdaP/GAvpIqak94k5hPH9y1OL
         gphMO7KvtbL9b3p3dKdo8LqY+sAjOuBJfUGEIxItpn6ayHkvZnX/fVRY7Thb/RsU5UA0
         Zpv8BReJN0rFaG1vtq7xI/++Izv7V0+8IXCVQxF/9MHK2viVdbRupSfZkdB0CzKo8BpU
         l9Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVnAxcnu29P0sQvOt0BOGQZAA/eOeYjonol6HxTvwb5DbtWz3sG+M4ew7gyheDnZOzLkd/KEDU42kJEeZwj@vger.kernel.org, AJvYcCWABCWEJhu7b5GF+8v+SMDSn0Ol30ZJ/XjSlLKrsCbvTyj6U+FOpP0xymLb8gOpysfX6KhXoO9uapA1@vger.kernel.org, AJvYcCWjm1Mb3Jnhh057M9yIs2RSdA4Pxi94AnjlWipKG5YCmcLKi5ET7LD24FLRv0HvnPbKxsA7NEMBiFXSTG6+hKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyip+Pqg6ROZQX2IZdUrMg/fYGxvtqnuk7LqpQI03M+9JO4/1wZ
	mMOMuInyHZBC31P8s1amjnbDM81nRUHoYE8D2e3EaPsVsU2PbxGZX7j04JW9BTdIkkYtfPR8jU1
	wvOM/OLCmnKlsdpt4XgZOZQgjMMX2T1E=
X-Gm-Gg: ASbGncsZjzywvF5xBqtABcH2e1PxzGdo9RkQ50sL6OGPAqi9P8G9Q6EG7FXU7as9jGa
	szevpQ77gzO0khn5YZ72nKkG3pZ5+oU0zNZGYnAWyZTaMhtWh/YflSr33QHy56eA2q3HmvyUU+j
	VJf0RcR50aYaOPrW74QfjGQJh1aVavcg+LD1ArcpbE
X-Google-Smtp-Source: AGHT+IEEwO/CqHeyMnyHTRpRJ6eXvogyj930sk2AOCK0KsWI7FFDXTdN6K0KvTPsQKc1QtzQIycM5KZpcdjaiGrOfyU=
X-Received: by 2002:a05:6820:2718:b0:60f:2051:6fbd with SMTP id
 006d021491bc7-60f3ce433abmr12106756eaf.1.1749572110129; Tue, 10 Jun 2025
 09:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610145234.235005-1-igor.korotin.linux@gmail.com>
 <20250610150538.238007-1-igor.korotin.linux@gmail.com> <aEhMCVJG3c7zVbyU@cassiopeiae>
In-Reply-To: <aEhMCVJG3c7zVbyU@cassiopeiae>
From: Igor Korotin <igor.korotin.linux@gmail.com>
Date: Tue, 10 Jun 2025 17:14:59 +0100
X-Gm-Features: AX0GCFtzpeo4A1lsjhJ7ZirXjU5U1qi_K1xwVCUmWKn3ASiV_UHgwOkDUJrXQdc
Message-ID: <CAJxaTdN15vSGgserH+hnzxmhj_RkZ4gZwrg-DQwdeaoe=ttW6A@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] rust: driver: Consolidate `Adapter` methods using `#[cfg]`
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, rafael@kernel.org, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, lenb@kernel.org, wedsonaf@gmail.com, 
	viresh.kumar@linaro.org, alex.hung@amd.com, dingxiangfei2009@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 4:15=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Tue, Jun 10, 2025 at 04:05:38PM +0100, Igor Korotin wrote:
> > Refactor the `acpi_id_info` and `of_id_info` methods in the `Adapter` t=
rait
> > to reduce duplication. Previously, each method had two versions selecte=
d
> > via `#[cfg(...)]` and `#[cfg(not(...))]`. This change merges them into =
a
> > single method per case by using `#[cfg]` blocks within the method bodie=
s.
> >
> > Suggested-by: Benno Lossin <lossin@kernel.org>
> > Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
> > ---
> >  rust/kernel/driver.rs | 76 +++++++++++++++++++++----------------------
> >  1 file changed, 38 insertions(+), 38 deletions(-)
> >
> > diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
> > index 638f1d270af8..805f61bd4a50 100644
> > --- a/rust/kernel/driver.rs
> > +++ b/rust/kernel/driver.rs
> > @@ -147,30 +147,30 @@ pub trait Adapter {
> >      /// Returns the driver's private data from the matching entry in t=
he [`acpi::IdTable`], if any.
> >      ///
> >      /// If this returns `None`, it means there is no match with an ent=
ry in the [`acpi::IdTable`].
> > -    #[cfg(CONFIG_ACPI)]
> >      fn acpi_id_info(dev: &device::Device) -> Option<&'static Self::IdI=
nfo> {
> > -        let table =3D Self::acpi_id_table()?;
> > +        #[cfg(not(CONFIG_ACPI))] {
> > +            let _ =3D dev;
> > +            return None;
> > +        }
> >
> > -        // SAFETY:
> > -        // - `table` has static lifetime, hence it's valid for read,
> > -        // - `dev` is guaranteed to be valid while it's alive, and so =
is `pdev.as_ref().as_raw()`.
> > -        let raw_id =3D unsafe { bindings::acpi_match_device(table.as_p=
tr(), dev.as_raw()) };
> > +        #[cfg(CONFIG_ACPI)] {
> > +            let table =3D Self::acpi_id_table()?;
> >
> > -        if raw_id.is_null() {
> > -            None
> > -        } else {
> > -            // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapper o=
f `struct of_device_id` and
> > -            // does not add additional invariants, so it's safe to tra=
nsmute.
> > -            let id =3D unsafe { &*raw_id.cast::<acpi::DeviceId>() };
> > +            // SAFETY:
> > +            // - `table` has static lifetime, hence it's valid for rea=
d,
> > +            // - `dev` is guaranteed to be valid while it's alive, and=
 so is `pdev.as_ref().as_raw()`.
> > +            let raw_id =3D unsafe { bindings::acpi_match_device(table.=
as_ptr(), dev.as_raw()) };
> >
> > -            Some(table.info(<acpi::DeviceId as crate::device_id::RawDe=
viceId>::index(id)))
> > -        }
> > -    }
> > +            if raw_id.is_null() {
> > +                None
> > +            } else {
> > +                // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapp=
er of `struct of_device_id` and
> > +                // does not add additional invariants, so it's safe to=
 transmute.
> > +                let id =3D unsafe { &*raw_id.cast::<acpi::DeviceId>() =
};
> >
> > -    #[cfg(not(CONFIG_ACPI))]
> > -    #[allow(missing_docs)]
> > -    fn acpi_id_info(_dev: &device::Device) -> Option<&'static Self::Id=
Info> {
> > -        None
> > +                Some(table.info(<acpi::DeviceId as crate::device_id::R=
awDeviceId>::index(id)))
> > +            }
> > +        }
> >      }
>
> It seems there has been a misunderstanding, the idea was to refactor
> Adapter::of_id_info() in one patch and introduce Adapter::acpi_id_info() =
in a
> subsequent patch already being the suggested implementation by Benno.
>
> We try to avoid introducing code, just to change it again in a subsequent=
 patch.

That does make perfect sense. My bad. I'll reorder changes in the v5.

Sorry for the mess. Thanks for the review.

Best Regards
Igor

