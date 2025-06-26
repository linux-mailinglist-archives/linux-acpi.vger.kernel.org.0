Return-Path: <linux-acpi+bounces-14722-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0417EAEA564
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 20:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0D84A30FA
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 18:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAD52EE980;
	Thu, 26 Jun 2025 18:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8QqsWw7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B79267F53;
	Thu, 26 Jun 2025 18:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750962494; cv=none; b=eaRruSciuZN3wZqtwixBwUIdsQjgUHMXw4ofkfd+30WXb1l65igWR0rNo0ks//sBQnvMCqP1Gd0FuLsdA6VnuewolRcr0ud5rX+gAKxFZ8C9i4Z1gpVVl5fUC2T56MjvStOVDaftyRIy6eKaZbZ/zFsrzWkuooCF8hAYieEdBvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750962494; c=relaxed/simple;
	bh=nEf1l43KaouDikpuorZWPUKVVUh+pNAxFKrEO2DfOrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hs76pU/dMZbAggdH2OggNgMIldIN/ZbOvl1WTR0wBgolbrxv9wBKicJ2cgvqfvhXOCFCMNOkCv66l1SIGXcuaUdkwfKyQg+eNrDdLvSy5/04SWMxPVf164rZjLAdHMyl7mlIEgDfksl3DNczGoqBcD3Qtu18KFqM9vCJmXcz/c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8QqsWw7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2163C4CEEF;
	Thu, 26 Jun 2025 18:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750962494;
	bh=nEf1l43KaouDikpuorZWPUKVVUh+pNAxFKrEO2DfOrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j8QqsWw7SxYPuWEQUdlpamK5i1Am6fGyFs6uVZ6EnbAK1d82ueqY47YTELqwHV5ca
	 uSue5FB2tg7Fut+ebftqQe1aIvA4mftQdfupMWJ1lpDdrFV+iBGPYMoWcYr6e+0zyp
	 UBwwlm0Lc6k1BL7Y/+q2nkn/V6EV6yzdfstl02JunYllygysVlxui/9XFY55RWIKyb
	 owr+sq1MFkso/nQh9I4dqq4GBrW23p1+RpXECksn88ZyLY/Udmhde8TTdNcyF2ibnY
	 PATTqcr3ow4+2kQcddVzsHlwyLAjj3h288g3KtXfxFOp/WUFYETF39mjY2OxbJfVdE
	 5JAu1evmwaxmA==
Date: Thu, 26 Jun 2025 20:28:05 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Igor Korotin <igor.korotin.linux@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Alex Hung <alex.hung@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Remo Senekowitsch <remo@buenzli.dev>,
	Tamir Duberstein <tamird@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Xiangfei Ding <dingxiangfei2009@gmail.com>,
	devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Benno Lossin <lossin@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>, Len Brown <lenb@kernel.org>,
	Trevor Gross <tmgross@umich.edu>
Subject: Re: [PATCH v8 4/9] rust: acpi: add `acpi::DeviceId` abstraction
Message-ID: <aF2RNVJVIHyKuead@cassiopeiae>
References: <20250620150914.276272-1-igor.korotin.linux@gmail.com>
 <20250620152425.285683-1-igor.korotin.linux@gmail.com>
 <c5d750fd-ffcf-4d07-bfff-ebe206faa41a@kernel.org>
 <31804bbf-1a0b-4312-8db6-532a008528a2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31804bbf-1a0b-4312-8db6-532a008528a2@gmail.com>

On Thu, Jun 26, 2025 at 06:40:06PM +0100, Igor Korotin wrote:
> 
> 
> On 6/26/25 16:25, Danilo Krummrich wrote:
> > On 6/20/25 5:24 PM, Igor Korotin wrote:
> >> +impl DeviceId {
> >> +    const ACPI_ID_LEN: usize = 16;
> >> +
> >> +    /// Create a new device id from an ACPI 'id' string.
> >> +    pub const fn new<const N: usize>(id: &[u8; N]) -> Self {
> > 
> > Didn't notice before, but why was this silently changed from &CStr to
> > &[u8; N]
> > from v6 to v7?
> > 
> >> +        build_assert!(N <= Self::ACPI_ID_LEN, "ID exceeds 16 bytes");
> >> +        // Replace with `bindings::acpi_device_id::default()` once
> >> stabilized for `const`.
> >> +        // SAFETY: FFI type is valid to be zero-initialized.
> >> +        let mut acpi: bindings::acpi_device_id = unsafe
> >> { core::mem::zeroed() };
> >> +        let mut i = 0;
> >> +        while i < N {
> >> +            acpi.id[i] = id[i];
> >> +            i += 1;
> >> +        }
> >> +
> >> +        Self(acpi)
> >> +    }
> >> +}
> 
> In v6 I was asked to change assert! (runtime) to build_assert! (build time)
> It was as follows:
> 
> > +    pub const fn new(id: &'static CStr) -> Self {
> > +        assert!(id.len() <= Self::ACPI_ID_LEN, "ID exceeds 16 bytes");
> 
> but id.len() breaks const context and so build_assert! triggers
> assertion.

It does indeed, but I'm not sure why it does...

> If I needed to explicitly describe change from CStr to
> [u8;20], then it's my bad.

Yes, that's usually better. Otherwise reviewers might skip the changed part. In
this case I think it actually introduced a bug:

Checking for N <= Self::ACPI_ID_LEN it can happen that acpi_device_id::id is not
NULL terminated anymore, whereas before this was ensured by
CStr::as_bytes_with_nul(). See also [1].

I think we can easily fix this by just checking N < Self::ACPI_ID_LEN.

However, I'd still like to check why build_assert!() does not work with
CStr::len() in this case first.

[1] https://elixir.bootlin.com/linux/v6.15.3/source/drivers/acpi/bus.c#L899

