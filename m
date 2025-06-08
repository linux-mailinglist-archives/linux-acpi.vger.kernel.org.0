Return-Path: <linux-acpi+bounces-14224-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287CBAD11DD
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Jun 2025 13:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334353ABCBC
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Jun 2025 11:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAB21E1A3B;
	Sun,  8 Jun 2025 11:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ttovr1Uz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D2C2F3E;
	Sun,  8 Jun 2025 11:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749380896; cv=none; b=YcUNY4WZIOZA6YLPRGEU+CB3YfKA2bgIBW8fd71FDMKH9FWXxBT7G0yJ0B26pjnOYZpBpNGsPo0e8w2wXSBMYC+4+YixIr3HBezOfdy84CMkqOZaGlfg3HuGaAXeDw2638ddZcKH0MHqvTdxwLHSv0QoGI7YXdxjKOkOEOD+/1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749380896; c=relaxed/simple;
	bh=zQjLaCkqXUXf8VbzcQyBJoOCeg+tyk6Eio9EBcujSWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ce5GBexTZfhl4fcpDpGVtBl+sKARJy5QDkzZb4Bf7if4EjMJf7W/8ICIDDavphqgD9xepfCasOSXGUK3bK6Q19mzav72x0x0BZGHXASoj3uDJirzBZhm/UD07wbUX3rE/wGTwjfvIuA42q2VpaEpndHN7c+oq9OxUdtN9hdpAjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ttovr1Uz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CB5C4CEEE;
	Sun,  8 Jun 2025 11:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749380895;
	bh=zQjLaCkqXUXf8VbzcQyBJoOCeg+tyk6Eio9EBcujSWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ttovr1Uzv1SfKsvXEVDQB067dMRv19fTGTshKUEmo25QMQGgYNdkwOEyS+EGlSeQQ
	 V4LfuSafPK6SeiZXjx/44/aXFBWMppybb0ZBVH0MrD7+UiEKZg6FX+cf1Dfn6EHZf/
	 4tJp9Saxd41tZuMZt+1ONT2MT9rDxz8dBsR+wOovNTybwL5+dQbCodU6BZeuTCZSoj
	 WPazQD4hBgjdnWj/BaitWHJzKzz3omW13HyOrTMB+h7p+Fidl8LY0yn0inDBjdnzjD
	 gK4tuU8rYn0fyH94SkPAth3V020et0S6fPBqkxNhVzVhfEATta+HH+iOkSZPlny9Ui
	 zFAhluVbBmyxg==
Date: Sun, 8 Jun 2025 13:08:09 +0200
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
Subject: Re: [PATCH v3 4/4] samples: rust: add ACPI match table example to
 platform driver
Message-ID: <aEVvGeG5mnIj2gw5@pollux>
References: <20250606170341.3880941-1-igor.korotin.linux@gmail.com>
 <20250606171033.3882079-1-igor.korotin.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606171033.3882079-1-igor.korotin.linux@gmail.com>

On Fri, Jun 06, 2025 at 06:10:33PM +0100, Igor Korotin wrote:
> Extend the Rust sample platform driver to probe using device/driver name
> +/// OF/ACPI match tables for Platform Driver implementation
> +///
> +/// The platform::Driver requires declaration of both OF_ID_TABLE and
> +/// ACPI_ID_TABLE, but if driver is not going to use either of them
> +/// it can implement one of them or both as None.
> +///
> +/// # Example:
> +///
> +/// ```ignore
> +/// impl platform::Driver for SampleDriver {
> +///     type IdInfo = ();
> +///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
> +///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
> +///
> +///     fn probe(
> +///         pdev: &platform::Device<Core>,
> +///         _info: Option<&Self::IdInfo>,
> +///     ) -> Result<Pin<KBox<Self>>> {
> +///         dev_dbg!(pdev.as_ref(), "Probe Rust Platform driver sample.\n");
> +///
> +///         let drvdata = KBox::new(Self { pdev: pdev.into() }, GFP_KERNEL)?;
> +///
> +///         Ok(drvdata.into())
> +///     }
> +/// }
> +/// ```

What I meant with [1] was that I think we should make this code compile and
remove everything that's not needed, i.e.:

	///```
	/// # use kernel::{acpi, device::Core, of, platform};
	///
	/// struct MyDriver;
	///
	/// impl platform::Driver for MyDriver {
	///     type IdInfo = ();
	///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
	///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
	///
	///     fn probe(
	///         _pdev: &platform::Device<Core>,
	///         _id_info: Option<&Self::IdInfo>,
	///     ) -> Result<Pin<KBox<Self>>> {
	///         Err(ENODEV)
	///     }
	/// }
	///```

However, given that we can't run doctests from drivers yet, we should just
remove this doctest I think. It much more belongs into rust/kernel/platform.rs
anyways (where we already have a similar one).

[1] https://lore.kernel.org/lkml/aEL0AGBZqDp1lMFe@pollux/

