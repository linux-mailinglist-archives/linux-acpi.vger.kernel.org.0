Return-Path: <linux-acpi+bounces-14222-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68238AD11D7
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Jun 2025 12:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D877168FE4
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Jun 2025 10:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981C31F4C85;
	Sun,  8 Jun 2025 10:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLKpF6hS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1A4635;
	Sun,  8 Jun 2025 10:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749379849; cv=none; b=Z6FZLevFvhNe/PxpsUFkinGlgSaUwSYnSsakrhAER+746vyMw/6w3c7pIpy+vBF3PnHHBkoTUGaECNoagfxSF98s9R2OYONssplDbqeeupOc9y2tkvFRjEz26qB66GVAAB7EZJHchWp62Me0yoQ7wBSFhehbkMuC+WzsG9eKI+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749379849; c=relaxed/simple;
	bh=X8Hl5II9ZiCSSu+OL1+Zy+Cta6JqhNiIp/UzoM+f4VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wg2HlLT5/WKOBiE4FA81hqyJFWkAPwzB1FrtS0JQyFnaLWry/uC+sVvYTzxDziQsXCLHl7Yk4yRcvaogFjkRzMdGcsOWT22aG5dlYBFB/m8KrwRy22puUbbH47vPaU3S0nQRmInwp6Z1WbTSBB6DFL1QqedzhKj6A1KenyluPPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLKpF6hS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CB6C4CEEE;
	Sun,  8 Jun 2025 10:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749379848;
	bh=X8Hl5II9ZiCSSu+OL1+Zy+Cta6JqhNiIp/UzoM+f4VQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KLKpF6hSNBAWBev6cUlX2duIcgneothRzRAT8z4jKRTFBfGcPIl5sxzsPhSZUiSVr
	 5pPipFqrqFAysYtYXFR7iNUsBDBJDRDWji+xVVQ0h//x7PdOPWpEYJVstrN1CUaJq/
	 IPkSVJJ/qNJIuBfMh9Ix4mXj7rEKXuaZMSBoVd8PxeZIDBfoeYaRfudG302fXZOCuI
	 k4HNWxntJ+EJtSdzaAOZ20SmkTz0x85TycqBXvs+jv6odwBTyKHiHFKerJdNe8yB9W
	 fsc4OnFMQwibsOdh1ypZr24/adW0tHl2EZWCErK1uvrQU3cbQFFm5LxTUoJgdWLHFF
	 lvLnldKTRc0ew==
Date: Sun, 8 Jun 2025 12:50:42 +0200
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
Subject: Re: [PATCH v3 4/4] samples: rust: add ACPI match table example to
 platform driver
Message-ID: <aEVrAl94jxjQjT5L@pollux>
References: <20250606170341.3880941-1-igor.korotin.linux@gmail.com>
 <20250606171033.3882079-1-igor.korotin.linux@gmail.com>
 <DAGZQQ0GQGI7.3QYQ39S6RPC2Z@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DAGZQQ0GQGI7.3QYQ39S6RPC2Z@kernel.org>

On Sun, Jun 08, 2025 at 09:58:46AM +0200, Benno Lossin wrote:
> On Fri Jun 6, 2025 at 7:10 PM CEST, Igor Korotin wrote:
> > Extend the Rust sample platform driver to probe using device/driver name
> > matching, OF ID table matching, or ACPI ID table matching.
> >
> > Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
> > ---
> >  samples/rust/rust_driver_platform.rs | 96 +++++++++++++++++++++++++++-
> >  1 file changed, 95 insertions(+), 1 deletion(-)
> >
> > diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
> > index e3992e7a71e9..be7c311dca07 100644
> > --- a/samples/rust/rust_driver_platform.rs
> > +++ b/samples/rust/rust_driver_platform.rs
> > @@ -17,10 +17,104 @@ struct SampleDriver {
> >      [(of::DeviceId::new(c_str!("test,rust-device")), Info(42))]
> >  );
> >  
> > +// ACPI match table test
> 
> This looks great, let's move it to the crate-level documentation.

+1

> That way it gets rendered :)

Just to be precise, I think the build system does not yet render driver
documentation, but it should be in the future.

