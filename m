Return-Path: <linux-acpi+bounces-14223-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 053CBAD11DB
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Jun 2025 12:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F63F3ABBC8
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Jun 2025 10:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBC32066F7;
	Sun,  8 Jun 2025 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niRpu4gK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC21137932;
	Sun,  8 Jun 2025 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749380316; cv=none; b=dcjyXqsn7QbAkxk6ZsuH3FJ3o3pcafGiaaHqju93zPckS/ZUpnO+Y4V4cw4lw2LnPdvtx03UaAPr+mvcASQQlvPVzP4Z5pS2NHAQgPfOAbx9fSI2hH1S42vQcTiZLd1RBlt/1LzKBx9oM1QSpr/ynxvrjI7rI4BQXF8+UC6ChXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749380316; c=relaxed/simple;
	bh=nCYnEAk6sxs69Gv19dtbUqNiUWnHt4w8STlFDbctEJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=If2JGRcwhu6tqXIWehqBXucCC5vldD7UeliZ3niovMr2zw3zFB8yRL3lSMTWZR6TVfbxu02gPNKaT0btvCZkpK+rCstwGXs8Cgp+nnaW/5HJgVRaBVS54WXyc61707hZcPlr23ECVV1d+5gVLN3clrtyTZDwlxrkgSY7IGuHZJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niRpu4gK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CB9C4CEEE;
	Sun,  8 Jun 2025 10:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749380315;
	bh=nCYnEAk6sxs69Gv19dtbUqNiUWnHt4w8STlFDbctEJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=niRpu4gKVniSkpXvUI7mfQCBYosR05FSGLspzaqTZx7jFmnWvWVbxyxPeDnbrCfcT
	 3R+BYATG5Xq7oWRaj7Ql4n4d/xepVpUuopcA6k7m+cl8IBf0lbvlPY2yTuGoeQuKJp
	 y0jXS0phRjhOpnWS/IHOH7br8ZaslNrSX9eGTF6vFuVCHHNGfFDpqKNt04q75nZvZY
	 6DtvhnGE6dej+uoolTHfv9cKyXCWLP6OGShdPEAFep8pE2MvdgwF/A2KKzLScgAi+a
	 8JVL/HaU1savm1wVbXfRuNCA/PI6/HJzagEOeEIcM74aiTlVDvLAVEeAro2ITIiOre
	 Y/uSY7kQC9bRA==
Date: Sun, 8 Jun 2025 12:58:29 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Igor Korotin <igor.korotin.linux@gmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, rafael@kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, lenb@kernel.org, wedsonaf@gmail.com,
	viresh.kumar@linaro.org, alex.hung@amd.com,
	dingxiangfei2009@gmail.com
Subject: Re: [PATCH v3 3/4] rust: platform: Add ACPI match table support to
 `Driver` trait
Message-ID: <aEVs1Q5eYuOgVBi4@pollux>
References: <20250606170341.3880941-1-igor.korotin.linux@gmail.com>
 <20250606170905.3881900-1-igor.korotin.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606170905.3881900-1-igor.korotin.linux@gmail.com>

On Fri, Jun 06, 2025 at 06:09:05PM +0100, Igor Korotin wrote:
> @@ -144,6 +150,7 @@ macro_rules! module_platform_driver {
>  /// impl platform::Driver for MyDriver {
>  ///     type IdInfo = ();
>  ///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
> +///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);

This breaks the doctest. You need to define ACPI_TABLE above, just like OF_TABLE
is defined above.

If you enable CONFIG_RUST_KERNEL_DOCTESTS=y it will compile the doctests and run
them as kunit test.

