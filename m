Return-Path: <linux-acpi+bounces-14036-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE77AC9A6B
	for <lists+linux-acpi@lfdr.de>; Sat, 31 May 2025 12:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A81E4A292A
	for <lists+linux-acpi@lfdr.de>; Sat, 31 May 2025 10:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871662376F7;
	Sat, 31 May 2025 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rt4BfImM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5924320A5E5;
	Sat, 31 May 2025 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748686351; cv=none; b=sUTVfOzYSYe8KcFeS9kurZ5SiXov3XR6HaW57BjnxccrKHTCHqOODGjmS3Wrhazsdd/ic72aQcPWNk+OKGGLpzgIXPSoi35wdZY4gytu74NbfRat7/EBohsewnrh9s080DnC3TbVs9P7XH1/xKHkFMl/ImeonpFBCNQ1HtkUZGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748686351; c=relaxed/simple;
	bh=mJ5Rl0qcXcb/5doOfmKI8NZWnM2jDWsTV88Tpvy+T6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhaPc27K/6T1dsgbbtHcfF4/SWE3OKx3/yrm/RHY3Ll30FvDJRuLaHBz9Y2tuWO92u4gaqCwjGYOSjQ/0Zmo6a+nluGw2/jldNdx4KWM5YIHvMrcuvq6wvjU48N7U/mgvF/mrZpdzpuhfAKLJQ97wxmZKmkPChMJgCirhGhNX5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rt4BfImM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A432FC4CEE3;
	Sat, 31 May 2025 10:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748686350;
	bh=mJ5Rl0qcXcb/5doOfmKI8NZWnM2jDWsTV88Tpvy+T6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rt4BfImM1YnVSBaYAS8IPRSbIwVj91TOQs/cl8Z1bnYBr/N6Fv7DHQ0QXrIju/zH2
	 3KIR7O72VXDYNvAiGdgSk6uFDG0eDFqvc+71AGa9oNbt3zCDnn9yLmKFl6zr/3mwcT
	 +L4JlOPWEI+RnNOrxiAabvouK7Fqy8ILsp/WDxJgbd9MFkVaeHyjMxPde71iBI6bSi
	 Ra3H/Yct21uXvydBCuMsp+CSs0BrPmIY1Q3fiQta4UY3qoTec85Ehmo6hZEwGet1Gv
	 V9Y8M93PnQtD7LG60jPc73TJyN1W0YcJncvHea25CsX/TA9WtsUGbw5ViKac/sJSAy
	 tCt1TzdGST2aQ==
Date: Sat, 31 May 2025 12:12:24 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Igor Korotin <igor.korotin.linux@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-acpi@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: acpi: add `acpi::DeviceId` abstraction
Message-ID: <aDrWCBAxPnu7VY0P@pollux>
References: <20250530123815.1766726-1-igor.korotin.linux@gmail.com>
 <aDnD_Bb3l6GiI_8K@cassiopeiae>
 <CAG7QV92rtk7NUKzUoApkopv1LF2WVjqyNA9hPt=yCuEvdJjoCA@mail.gmail.com>
 <2025053111-anteater-balsamic-8d01@gregkh>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025053111-anteater-balsamic-8d01@gregkh>

On Sat, May 31, 2025 at 07:49:46AM +0200, Greg KH wrote:
> On Fri, May 30, 2025 at 05:11:29PM +0100, Igor Korotin wrote:
> > On Fri, May 30, 2025 at 3:43 PM Danilo Krummrich <dakr@kernel.org> wrote:
> > >
> > > On Fri, May 30, 2025 at 01:38:06PM +0100, Igor Korotin wrote:
> > > > `acpi::DeviceId` is an abstraction around `struct acpi_device_id`.
> > > >
> > > > This is used by subsequent patches, in particular the i2c driver
> > > > abstractions, to create ACPI device ID tables.
> > > >
> > > > Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
> > >
> > > As Greg mentioned it would be nice to see the subsequent patches.
> > 
> > Ok. There's a little misunderstanding from my side. I'm in the
> > progress of implementation
> > of I2C driver abstractions. I2C drivers can use either "of" or "acpi".
> > The idea was to push this
> > change first, because:
> >  - It's quite standalone one.
> >  - I'm not sure how much time it will take me to finalize I2C drivers
> > abstractions.
> 
> If you don't need it now, then there's no rush to get it merged now :)
> 
> > If it is not appropriate way of commits, I'll then keep it until all is done.
> 
> We would like to see it be used first, to ensure that the code is
> actually correct.

Alternatively, if you want to upstream this dependency already you can send the
following patches:

  - this acpi::DeviceId abstraction
  - the glue code for the generic adapter trait in rust/kernel/driver.rs
  - use this glue code in the platform abstraction
  - add acpi support to the platform sample driver

This way we can already validate that the code works correctly. All this is
required anyways if the I2C device you write a driver for is on the platform
bus.

