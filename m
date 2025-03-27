Return-Path: <linux-acpi+bounces-12495-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B9DA72DBF
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 11:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DB287A37D7
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 10:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6292820E6E7;
	Thu, 27 Mar 2025 10:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMH8PRfU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA4D20E03B;
	Thu, 27 Mar 2025 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743071347; cv=none; b=oua51eIdpvOFD2PkUmowoF7M+fUeScNmdDSG+numlifuVXQtA/QukezR4O4G4v1BQEK1z9UcH9VngNYhnH1bVWS+5KaqSIHpafyF78ezM8NhiKnFOJrajIkweQ97mn0VVDLJGj/+V8Teg8qjh0zubHF22Gt/QrgAl/Qbb0TNWs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743071347; c=relaxed/simple;
	bh=NAF2vsNFyg0cvCLYEPLLXD2j50hqtM/yWmWAgBOxym0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoszEA713zDWpjOwrKRk/wG8WCMYyI/V9swAZs3mhfXb5BPgZxPxsF064qYHn1Ev04i+jX2+PQ6QKSgvTNtJFU5q9nf1v0mS1ibgB258IugqkrdDAQRf2wNoYiJTS/JQbTetHQp6lTY+bVvaX7LBJ3rC+n/YFTRX7O/GYywjzGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMH8PRfU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67623C4CEDD;
	Thu, 27 Mar 2025 10:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743071345;
	bh=NAF2vsNFyg0cvCLYEPLLXD2j50hqtM/yWmWAgBOxym0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DMH8PRfUym9SXob0XTs+3UqyBUmb0wdk3kel4QTR1FHOK/CSFqJglYwccJntcR2I0
	 a8ZkatnvRf1aomVo7KCFGEIPlPnjiWu1k1oer4JodtZRoxO//tats2uIVg81q+iWyM
	 w7LL52JmPiekFfB97DzbWAFxC4NZbPli/WwPHWhkEcVNaJN+yuQbWwunJSdR+n99mm
	 XGUojGl81prawFjwcCDlR05ATFqWxWfB3/kx3nSEZwrNRCRs70uvPAcgQFiXBgBtRF
	 qY+7ABnK/K8l068sLRNEV+osz/oc23mjop58pHbC8WCTTmqfYW0y2ANdr1+3uVHCMr
	 V1XeTrKuxKRow==
Date: Thu, 27 Mar 2025 11:28:58 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Remo Senekowitsch <remo@buenzli.dev>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Rob Herring <robh@kernel.org>, Dirk Behme <dirk.behme@de.bosch.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 10/10] samples: rust: platform: Add property read examples
Message-ID: <Z-UoapC4zkKFOD9-@pollux>
References: <20250326171411.590681-1-remo@buenzli.dev>
 <20250326171411.590681-11-remo@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326171411.590681-11-remo@buenzli.dev>

On Wed, Mar 26, 2025 at 06:13:49PM +0100, Remo Senekowitsch wrote:
> --- a/samples/rust/rust_driver_platform.rs
> +++ b/samples/rust/rust_driver_platform.rs
> @@ -2,7 +2,7 @@
>  
>  //! Rust Platform driver sample.
>  
> -use kernel::{c_str, of, platform, prelude::*};
> +use kernel::{c_str, of, platform, prelude::*, str::CString};
>  
>  struct SampleDriver {
>      pdev: platform::Device,
> @@ -28,6 +28,60 @@ fn probe(pdev: &mut platform::Device, info: Option<&Self::IdInfo>) -> Result<Pin
>              dev_info!(pdev.as_ref(), "Probed with info: '{}'.\n", info.0);
>          }
>  
> +        let dev = pdev.as_ref();
> +        if let Ok(idx) = dev.property_match_string(c_str!("compatible"), c_str!("test,rust-device"))
> +        {
> +            dev_info!(pdev.as_ref(), "matched compatible string idx = {}\n", idx);
> +        }
> +
> +        if let Ok(str) = dev
> +            .property_read::<CString>(c_str!("compatible"))
> +            .required()
> +        {
> +            dev_info!(pdev.as_ref(), "compatible string = {:?}\n", str);
> +        }
> +
> +        let prop = dev
> +            .property_read::<bool>(c_str!("test,bool-prop"))
> +            .required()?;
> +        dev_info!(dev, "bool prop is {}\n", prop);
> +
> +        if dev.property_present(c_str!("test,u32-prop")) {
> +            dev_info!(dev, "'test,u32-prop' is present\n");
> +        }
> +
> +        let prop = dev
> +            .property_read::<u32>(c_str!("test,u32-optional-prop"))
> +            .or(0x12);
> +        dev_info!(
> +            dev,
> +            "'test,u32-optional-prop' is {:#x} (default = {:#x})\n",
> +            prop,
> +            0x12
> +        );

Printing the default value looks more like a test, rather than a sample.

> +
> +        // Missing property without a default will print an error
> +        let _ = dev
> +            .property_read::<u32>(c_str!("test,u32-required-prop"))
> +            .required()?;
> +
> +        let prop: u32 = dev.property_read(c_str!("test,u32-prop")).required()?;
> +        dev_info!(dev, "'test,u32-prop' is {:#x}\n", prop);
> +
> +        let prop: [i16; 4] = dev.property_read(c_str!("test,i16-array")).required()?;
> +        dev_info!(dev, "'test,i16-array' is {:?}\n", prop);
> +        dev_info!(
> +            dev,
> +            "'test,i16-array' length is {}\n",
> +            dev.property_count_elem::<u16>(c_str!("test,i16-array"))
> +                .unwrap()

Please no unwrap() in the kernel, it may panic.

> +        );
> +
> +        let prop: KVec<i16> = dev
> +            .property_read_array_vec(c_str!("test,i16-array"), 4)?
> +            .required()?;
> +        dev_info!(dev, "'test,i16-array' is KVec {:?}\n", prop);
> +

Please move this code to a new function, e.g.

	impl SampleDriver {
	   fn properties_parse(dev: &device::Device)) -> Result;
	}

in order to keep probe() as clean as possible. If we put too much stuff in
there, it might become too confusing to serve as a simple example showing how to
implement a platform driver in Rust.

Besides that, are we sure we really want to print everything?

