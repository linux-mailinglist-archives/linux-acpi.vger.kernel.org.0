Return-Path: <linux-acpi+bounces-14401-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382F4ADBA58
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Jun 2025 21:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CC193A7D31
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Jun 2025 19:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AA31F429C;
	Mon, 16 Jun 2025 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1c1xR/d"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F8F249F9;
	Mon, 16 Jun 2025 19:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750103580; cv=none; b=lxKVLxPQ30VFTT2OoB+x25g6GSOAVzfX6uFCOnRkeS/VBThz8LynWZMdGDayk7unNkbpaIvfUQ+D4pVhs7cWDHZAbMnKoVpyKZ0z2WdrFpSZEggkYt2ukKP33Bi1sCFcQgS0Vqwe5skTiH5MKhfwsH/rWqoHVmrH4MLcBlG6rnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750103580; c=relaxed/simple;
	bh=4TsZfMRJ0KYt9kFx3GdlaieAGxVQz4lRsWZyWYs6e1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAjRkRtJMvz7dcV3jeP3NC6QCRgdV/DyLyHnKolUzwjVJpQnM7kbqWe4Scx6kMj7uhHWHVemkjBq+iT7KOYCA+lERF0I6I9BLpFKuluFG3vcNF42NSfVPfdWIachMHEJVZtCaxuRatJ0vakxpaPttYDNd3EedCP0HWQZxhx0aBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1c1xR/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456C9C4CEEA;
	Mon, 16 Jun 2025 19:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750103580;
	bh=4TsZfMRJ0KYt9kFx3GdlaieAGxVQz4lRsWZyWYs6e1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B1c1xR/dp3Hn0TuK0dyVw2OBNiXhrB8BNXJCYqY4/tOHzj2GN6lsI6gzuzNQJi8sV
	 6j3hwUaAnUl2lP3dCTtEv+6jAlDV18GeoIYpjzsn0UIOeK4nFxK6SQmdIRoqNjpZcS
	 VPAxgFUwoiDFubetz5CfM7e7Ah+3D34jsGS2lWx/FMYW4d1VfPxBRsNtvEQz0gZOqn
	 4b5NeDyNJTUlBG0657k86AVSdrnL2tGnzcjwkPbE5W56NGs4Xjr8C1kmCCp7fHPP2g
	 wGgcNtjcB3Va0E8NQQaYiAbSXIf8TT3FAUM/edjECnkt+U+xPzAHZ3eUzKXUXBAOhD
	 HDEyiHD51B3wQ==
Date: Mon, 16 Jun 2025 21:52:53 +0200
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
Subject: Re: [PATCH v6 6/6] samples: rust: add ACPI match table example to
 platform driver
Message-ID: <aFB2FZEFcXUsW8lN@pollux>
References: <20250613133517.1229722-1-igor.korotin.linux@gmail.com>
 <20250613135407.1233005-1-igor.korotin.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613135407.1233005-1-igor.korotin.linux@gmail.com>

On Fri, Jun 13, 2025 at 02:54:07PM +0100, Igor Korotin wrote:
> Extend the Rust sample platform driver to probe using device/driver name
> matching, OF ID table matching, or ACPI ID table matching.

Can you please rebase onto driver-core-next? You may also want to add the three
patches I sent as a reply to this one to your series.

> Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
> ---
>  samples/rust/rust_driver_platform.rs | 71 +++++++++++++++++++++++++++-
>  1 file changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
> index 8b42b3cfb363..35d5067aa023 100644
> --- a/samples/rust/rust_driver_platform.rs
> +++ b/samples/rust/rust_driver_platform.rs
> @@ -2,7 +2,7 @@
>  
>  //! Rust Platform driver sample.
>  
> -use kernel::{c_str, device::Core, of, platform, prelude::*, types::ARef};
> +use kernel::{acpi, c_str, device::Core, of, platform, prelude::*, types::ARef};
>  
>  struct SampleDriver {
>      pdev: ARef<platform::Device>,
> @@ -17,9 +17,78 @@ struct SampleDriver {
>      [(of::DeviceId::new(c_str!("test,rust-device")), Info(42))]
>  );
>  
> +// ACPI match table test
> +//
> +// This demonstrates how to test an ACPI-based Rust platform driver using QEMU
> +// with a custom SSDT.
> +//
> +// Steps:
> +//
> +// 1. **Create an SSDT source file** (`ssdt.dsl`) with the following content:
> +//
> +//     ```asl
> +//     DefinitionBlock ("", "SSDT", 2, "TEST", "VIRTACPI", 0x00000001)
> +//     {
> +//         Scope (\_SB)
> +//         {
> +//             Device (T432)
> +//             {
> +//                 Name (_HID, "TEST4321")  // ACPI hardware ID to match
> +//                 Name (_UID, 1)
> +//                 Name (_STA, 0x0F)        // Device present, enabled
> +//                 Name (_CRS, ResourceTemplate ()
> +//                 {
> +//                     Memory32Fixed (ReadWrite, 0xFED00000, 0x1000)
> +//                 })
> +//             }
> +//         }
> +//     }
> +//     ```
> +//
> +// 2. **Compile the table**:
> +//
> +//     ```sh
> +//     iasl -tc ssdt.dsl
> +//     ```
> +//
> +//     This generates `ssdt.aml`
> +//
> +// 3. **Run QEMU** with the compiled AML file:
> +//
> +//     ```sh
> +//     qemu-system-x86_64 -m 512M \
> +//         -enable-kvm \
> +//         -kernel path/to/bzImage \
> +//         -append "root=/dev/sda console=ttyS0" \
> +//         -hda rootfs.img \
> +//         -serial stdio \
> +//         -acpitable file=ssdt.aml
> +//     ```
> +//
> +//     Requirements:
> +//     - The `rust_driver_platform` must be present either:
> +//         - built directly into the kernel (`bzImage`), or
> +//         - available as a `.ko` file and loadable from `rootfs.img`
> +//
> +// 4. **Verify it worked** by checking `dmesg`:
> +//
> +//     ```
> +//     rust_driver_platform TEST4321:00: Probed with info: '0'.
> +//     ```
> +//
> +// This demonstrates ACPI table matching using a custom ID in QEMU with a minimal SSDT

Can you please move this up into the module-level documentation?

> +kernel::acpi_device_table!(
> +    ACPI_TABLE,
> +    MODULE_ACPI_TABLE,
> +    <SampleDriver as platform::Driver>::IdInfo,
> +    [(acpi::DeviceId::new(c_str!("TEST4321")), Info(0))]

Let's use something like "SAMPLE_DRV0" instead.

> +);
> +
>  impl platform::Driver for SampleDriver {
>      type IdInfo = Info;
>      const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
> +    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
>  
>      fn probe(
>          pdev: &platform::Device<Core>,
> -- 
> 2.43.0
> 

