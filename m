Return-Path: <linux-acpi+bounces-14034-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6204FAC9974
	for <lists+linux-acpi@lfdr.de>; Sat, 31 May 2025 07:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307C24E2739
	for <lists+linux-acpi@lfdr.de>; Sat, 31 May 2025 05:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D6F28CF59;
	Sat, 31 May 2025 05:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0CctRSZB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0142904;
	Sat, 31 May 2025 05:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748670590; cv=none; b=YoHzGebxMORwJF+V1il/7lDfi39OxW5lcywerg4wF4/cssNP6CPwfnmNgh4vKUhqAIgMAC+//0JcJPost4ML1ejqWUb13LGhaOmxSSpWYxIPCodhsn/OAOj241We/XGDFwM6taQI6VyrvrhxJBb0tRpYWn/+uiSm1nUVI/WHalY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748670590; c=relaxed/simple;
	bh=3rztAwoj/CLKv7pyv7i7aukmruToEE0/FZ2bxxCzmxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZ9suoUQYFmcCERD9urgiopEh14unKFNdMDhphxJdhDQ3ASW2kJeJ7KbLibQlLQbnVIdbm1jS+tqgDFwnkQ3jZBASIOUI9lTrwR8ipcveUuz4bNdui5UMNSteTAIj+exg6O+81K1vODuji//oL0aJ9jPAe/10dnEaNKSAI+eEcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0CctRSZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D5AC4CEE3;
	Sat, 31 May 2025 05:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748670589;
	bh=3rztAwoj/CLKv7pyv7i7aukmruToEE0/FZ2bxxCzmxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0CctRSZBzVq5upNYar9hc5fdQL8nvDgDWnSOyL1X08oXi0XwwRaCBpORb0c2y5wv9
	 iGJenbHnFR6gCzQJ2FckQORDSqiyQKGOAlIYhmn0379UZM22QS2bYnpoaG5XEHNJIq
	 KpJof6NBRpvxT4wBPVoEKkyO5cvqiRRLxM+fw3Nw=
Date: Sat, 31 May 2025 07:49:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Igor Korotin <igor.korotin.linux@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
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
Message-ID: <2025053111-anteater-balsamic-8d01@gregkh>
References: <20250530123815.1766726-1-igor.korotin.linux@gmail.com>
 <aDnD_Bb3l6GiI_8K@cassiopeiae>
 <CAG7QV92rtk7NUKzUoApkopv1LF2WVjqyNA9hPt=yCuEvdJjoCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG7QV92rtk7NUKzUoApkopv1LF2WVjqyNA9hPt=yCuEvdJjoCA@mail.gmail.com>

On Fri, May 30, 2025 at 05:11:29PM +0100, Igor Korotin wrote:
> On Fri, May 30, 2025 at 3:43 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On Fri, May 30, 2025 at 01:38:06PM +0100, Igor Korotin wrote:
> > > `acpi::DeviceId` is an abstraction around `struct acpi_device_id`.
> > >
> > > This is used by subsequent patches, in particular the i2c driver
> > > abstractions, to create ACPI device ID tables.
> > >
> > > Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
> >
> > As Greg mentioned it would be nice to see the subsequent patches.
> 
> Ok. There's a little misunderstanding from my side. I'm in the
> progress of implementation
> of I2C driver abstractions. I2C drivers can use either "of" or "acpi".
> The idea was to push this
> change first, because:
>  - It's quite standalone one.
>  - I'm not sure how much time it will take me to finalize I2C drivers
> abstractions.

If you don't need it now, then there's no rush to get it merged now :)

> If it is not appropriate way of commits, I'll then keep it until all is done.

We would like to see it be used first, to ensure that the code is
actually correct.

thanks,

greg k-h

