Return-Path: <linux-acpi+bounces-14085-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 934FDACC7AD
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Jun 2025 15:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD67D1886EFA
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Jun 2025 13:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB62C230BF8;
	Tue,  3 Jun 2025 13:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBhZ0Siv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D17522F754;
	Tue,  3 Jun 2025 13:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748957025; cv=none; b=kIU9JfchYEp7/zmv8A9QR7OxfnV44Txiz528JIUGIMd/A+M1MIC8dJQaDRTc4KckXhkIKZUkUuw8CXcQ+Xub8F8lbibc600lPs0qhQzbkMcdI1375uM0iN32tpYW8uNhBQTmyBi9pL4d27Ff1KhgNlKf+UBnGJ5KekF/z6AVvc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748957025; c=relaxed/simple;
	bh=HGwYyw4Mesm+h+CsA+i4y5waGWiE+tpQES3zA7dABzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAEtCMmdRX5eMOSggVUdq4dpc2ebhRdXW7Lfny5SojoFbUBDwMrdAfRSrT2lnLg/m069lBsjKuhRVSM9o05FH2Zr0EXuc8IjL7OlxVQnEW8DfnWqZ9PhESjVgKYuQi7ecBCv6eA6LCkP0i3DU3aYYkiekAejpiow/JbRWh4LrDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBhZ0Siv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03A6C4CEED;
	Tue,  3 Jun 2025 13:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748957024;
	bh=HGwYyw4Mesm+h+CsA+i4y5waGWiE+tpQES3zA7dABzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mBhZ0SivRzLRx0FhwwRERCHY+BJgxei4rW8cYIMx60QxPxl7jfCv9LGvUfEi+cMwG
	 GmAhD62LXJvgYmPTzkUoRfmX4pUkTqwAtmL39e1bP0GFgn87Vmu7Oe0OfCX8TD2gSi
	 BrCnGMs/ReCuUb7n/BCc1pV1srk3Msu2VpsZs9JmelknTCKr1zd/J2lU23PmrmPvDa
	 r+MBT32WfZyVuQFP5e5+lsW5jvd+huiDmbffwFQ2dUKKxpz4ZBO5gDFyjK42V1Tvgb
	 OHCfr+08WMPqb1/tSFG9qNpDvyvb9BFVQ+FlyDmRs9wD+xOlgPmTU1YPg8J6mw6x8l
	 8NR//4MX1JXJw==
Date: Tue, 3 Jun 2025 15:23:38 +0200
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
Message-ID: <aD73Won8t4jlYYs_@cassiopeiae>
References: <20250530123815.1766726-1-igor.korotin.linux@gmail.com>
 <aDnD_Bb3l6GiI_8K@cassiopeiae>
 <CAG7QV92rtk7NUKzUoApkopv1LF2WVjqyNA9hPt=yCuEvdJjoCA@mail.gmail.com>
 <2025053111-anteater-balsamic-8d01@gregkh>
 <aDrWCBAxPnu7VY0P@pollux>
 <CAG7QV936MPp7RLH_D6+K8mRcgPdpNsGFWF_D10b1C8op7YRtqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG7QV936MPp7RLH_D6+K8mRcgPdpNsGFWF_D10b1C8op7YRtqA@mail.gmail.com>

On Tue, Jun 03, 2025 at 01:55:47PM +0100, Igor Korotin wrote:
> > Alternatively, if you want to upstream this dependency already you can send the
> > following patches:
> >
> >   - this acpi::DeviceId abstraction
> >   - the glue code for the generic adapter trait in rust/kernel/driver.rs
> >   - use this glue code in the platform abstraction
> >   - add acpi support to the platform sample driver
> >
> > This way we can already validate that the code works correctly. All this is
> > required anyways if the I2C device you write a driver for is on the platform
> > bus.
> 
> A few questions if I may:
> 1. I committed to 4 different files: `acpi.rs`, `driver.rs`,
> `platform.rs`, platform rust sample driver.
> Should I commit all of this as one commit or split each part to a
> separate commit and send it as a patch sequence?

Every entry of my list above should be a separate commit. It might happen that
writing the glue code for the generic adapter trait in rust/kernel/driver.rs
breaks the build in the platform abstraction, then you have to fix it up in the
same commit, i.e. we never break the build. Please also see [1].

> 2. From author's point of view, as Danilo noticed, `acpi table`
> abstraction code is in general just copy-paste from `of table`
> abstraction code. How should I explicitly mark that fact?

You don't need to do anything specific here. You authored the commit, even
though it's based on existing code.

If you want you can add a note in the commit message that your case is based on
the OF table abstraction. But AFAIC, you don't have to.

[1] https://docs.kernel.org/process/submitting-patches.html#separate-your-changes

