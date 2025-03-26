Return-Path: <linux-acpi+bounces-12479-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A142A7214C
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 23:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D70179658
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 22:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8463189B91;
	Wed, 26 Mar 2025 22:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyB6q4Z1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7980B2E3364;
	Wed, 26 Mar 2025 22:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743026491; cv=none; b=YxmKfOZVnUYYiuAqHiS5eSN45mDGginUEcDM47vIZGk11dXeDVpIT/opKWVA2WVWFN4ewbM1LDWZHuO/DEdxisKOvs1XaGIOO0XpX1knlLayr+lLkRSXng2/lEobCLeSi/LU7DArrKu7RnPZ2yQgtGYVnK57F6vimTfTwrrbdsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743026491; c=relaxed/simple;
	bh=5ajdgCMl4Ci8EWMzlvIr8d5WidkzjnJEtRxeoQYgF1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmiytMWWufmcMtNid14PlS3+7FeDrftwzx+nWr4z4U2GB34YZe4obdKffIL7/f1mAcURz6OoR1B7oONeZA7WnNzBsO3d6ueEMttLffFuNMVFAsfFE8P4qVscg+tO2uaLW/5UiR56gNS0aMmbMirnOrS7eI7praTwd0XHWiUDFzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyB6q4Z1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B2CC4CEE2;
	Wed, 26 Mar 2025 22:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743026490;
	bh=5ajdgCMl4Ci8EWMzlvIr8d5WidkzjnJEtRxeoQYgF1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OyB6q4Z10bcmrv1/VonDP3KA1Jof0mOmYxDERrkyaJdyssuZRairW8yTKjOYjZFMp
	 3RMCC/ULdoJeHSAt2GfZ36ywk7VPJGB8TpTzGWbMCFQCH0MHTgwypfRSoT9Il3QlVT
	 mPLl1GsCN68AQotEozgNroAXui2MASgIwfNd7+37X2J93Goj2EcSBV2jA0cq6Ris+K
	 eLHYGtx2SW0hLTFkYxk/KYYXC4ozyhAeyevNEPPkcw7gO7FboVkBq2jHs4VbTDRNqE
	 ok4zCl9pNrRrudkQoGgHbrPKf7Yie/+zmK72bWRVWtEUOiCGyV2Rje2kTB60LgCsKj
	 SRfy0qM0WOX5g==
Date: Wed, 26 Mar 2025 17:01:29 -0500
From: Rob Herring <robh@kernel.org>
To: Remo Senekowitsch <remo@buenzli.dev>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
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
Message-ID: <20250326220129.GD2844851-robh@kernel.org>
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
> Add some example usage of the device property read methods for
> DT/ACPI/swnode properties.
> 
> Co-developed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Remo Senekowitsch <remo@buenzli.dev>
> ---
>  drivers/of/unittest-data/tests-platform.dtsi |  3 ++
>  samples/rust/rust_driver_platform.rs         | 56 +++++++++++++++++++-
>  2 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/unittest-data/tests-platform.dtsi b/drivers/of/unittest-data/tests-platform.dtsi
> index 4171f43cf..50a51f38a 100644
> --- a/drivers/of/unittest-data/tests-platform.dtsi
> +++ b/drivers/of/unittest-data/tests-platform.dtsi
> @@ -37,6 +37,9 @@ dev@100 {
>  			test-device@2 {
>  				compatible = "test,rust-device";
>  				reg = <0x2>;
> +
> +				test,u32-prop = <0xdeadbeef>;
> +				test,i16-array = /bits/ 16 <1 2 (-3) (-4)>;
>  			};
>  		};
>  
> diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
> index 8120609e2..ed25a3781 100644
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

We should move this to the top and replace all the 'pdev.as_ref()' with 
'dev'.

> +        if let Ok(idx) = dev.property_match_string(c_str!("compatible"), c_str!("test,rust-device"))
> +        {
> +            dev_info!(pdev.as_ref(), "matched compatible string idx = {}\n", idx);

Like here. (Looks like this is my fault.)

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

The 'required' is kind of odd for boolean properties. They are never 
required as not present is the only way to to get false.

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
> +        );
> +
> +        let prop: KVec<i16> = dev
> +            .property_read_array_vec(c_str!("test,i16-array"), 4)?
> +            .required()?;
> +        dev_info!(dev, "'test,i16-array' is KVec {:?}\n", prop);
> +
>          let drvdata = KBox::new(Self { pdev: pdev.clone() }, GFP_KERNEL)?;
>  
>          Ok(drvdata.into())
> -- 
> 2.49.0
> 

