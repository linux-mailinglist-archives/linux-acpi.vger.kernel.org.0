Return-Path: <linux-acpi+bounces-14446-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 019DCADEDAD
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 15:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 855F5189B4F4
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 13:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A86C2E8DFC;
	Wed, 18 Jun 2025 13:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJwamnN5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9DD2E6D1E;
	Wed, 18 Jun 2025 13:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750252800; cv=none; b=KZIBD5hblRmlDSI8X1T/oEgBdrOphdtMUa+hVXIMG+hSKxxUUzQpjtZ9Q624P6LPoRuomi4yPsjuRR8qk9HAM0XeW4SaGK4HK9XM2QjOS5YtDJz1/vClc9QHNnb5ckoJsrWlzaqQlxHu3ZMBQjiK4CNKiT8pyi8lHfXx3CQFQ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750252800; c=relaxed/simple;
	bh=6f04xDOpNX05iFRDZ8DlWL53L0pt5D4Vgc+rMTWpBQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPU4TEcvXAHBLN/mtOwv0JhcG7DSUzfjrLtbq5psLe1Ob+X2MHN/jHb4w1jW6Vaw+y6yuOXiHfg0CIoBgL3bAZh9SrPVAhZUOeGLbYyILrjx+E5cGV65LgNVneWynq1drLezUSEsFXwNrCo2dtAR4wyJHg9Rm5bIia16FD+c6Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJwamnN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DE3C4CEE7;
	Wed, 18 Jun 2025 13:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750252799;
	bh=6f04xDOpNX05iFRDZ8DlWL53L0pt5D4Vgc+rMTWpBQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YJwamnN5nsfolQq0lW8x7Qz6jFeRfMqcj7LUP9P7Dl8o6gvr4SXqyK22DG1GPV0Lp
	 cY9HJK0bFDmEAunLTyGp7DBQDVHdQXqge4TiV3NmgK1xuw8n5JkhA7SlQff6hindRF
	 ymIkxFsuqk1udmM+vABAxCTwE/uKhh8mOsKNVOEB9/S0OiACJLL7+NDV4eMEZPlQKO
	 /BNNCYHVE6bWyT9QeznFxALRWzVkniHQdas7IdbnFBmXHFmV6CsWieOxGBOVLZzuqk
	 jv8xmTL0NyQWl3t0djxl+a2quW0TSowB3I4a4GqOE6xigRRpIwLTGysco0ZAj1GUGY
	 zz8uh00v7O7xQ==
Date: Wed, 18 Jun 2025 08:19:58 -0500
From: Rob Herring <robh@kernel.org>
To: Igor Korotin <igor.korotin.linux@gmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, rafael@kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, lenb@kernel.org,
	wedsonaf@gmail.com, viresh.kumar@linaro.org, alex.hung@amd.com,
	dingxiangfei2009@gmail.com
Subject: Re: [PATCH v7 3/9] samples: rust: platform: conditionally call
 Self::properties_parse()
Message-ID: <20250618131958.GA1550757-robh@kernel.org>
References: <20250618100221.3047133-1-igor.korotin.linux@gmail.com>
 <20250618101325.3048187-1-igor.korotin.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618101325.3048187-1-igor.korotin.linux@gmail.com>

On Wed, Jun 18, 2025 at 11:13:25AM +0100, Igor Korotin wrote:
> From: Danilo Krummrich <dakr@kernel.org>
> 
> Only call Self::properties_parse() when the device is compatible with
> "test,rust-device".
> 
> Once we add ACPI support, we don't want the ACPI device to fail probing
> in Self::properties_parse().
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

This needs your S-o-b as well since you sent the patch.

> ---
>  samples/rust/rust_driver_platform.rs | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
> index 000bb915af60..036dd0b899b0 100644
> --- a/samples/rust/rust_driver_platform.rs
> +++ b/samples/rust/rust_driver_platform.rs
> @@ -40,7 +40,12 @@ fn probe(
>              dev_info!(dev, "Probed with info: '{}'.\n", info.0);
>          }
>  
> -        Self::properties_parse(dev)?;
> +        if dev
> +            .fwnode()
> +            .is_some_and(|node| node.is_compatible(c_str!("test,rust-device")))

I think you should be checking just is this ACPI or DT rather than 
compatible. It's kind of an anti-pattern to test compatible in probe. 
The reason is we've already matched to a compatible and have match data 
to use, so we don't need to do it again. It becomes quite messy when 
there are numerous possible compatibles.

In C, we just do 'if (dev->of_node)' to check for DT or not.

It is just a sample, but I'm sure folks will copy it.

Rob

