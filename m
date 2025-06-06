Return-Path: <linux-acpi+bounces-14194-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9A6AD03AE
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 15:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26EE63A7B07
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 13:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1224A28936C;
	Fri,  6 Jun 2025 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boD0tZeV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D104D1A274;
	Fri,  6 Jun 2025 13:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749218313; cv=none; b=Mhj4gms/BeC6LHl7OSWoP3J+zrkhA4mcz38q/b3Uz2lPrYz7wee/rnjv3CfID2IVuz+PcK//OQ27aJYtyONlpztbGFLLxMjRx8sVLyjPKR59wSswL8PaPsdnQaUrzIHsnUAgxuhOxdLg69+qD9KWrLhiI41J7lWSE5Sr4Lv/qSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749218313; c=relaxed/simple;
	bh=QyO94pd4hlnn9BKqJzgyhfcD8waNKskd+/HKP0CvpQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ww8mU6cV9K1o3AopT1xdtfxLqa/LzXlCfSYy6+BROokUDewQrjyEJcHpFTcxlXJsnUhwD6WcbSfnuh/AdO6NbImBS3VxLTYSeKTLJhZwzB0FFfbtPldyGNh8w5OEENiYXdTR65j4zGXchPV/oMdGRdrPFiE1LdRKMykwBDjaiTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boD0tZeV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC28FC4CEEB;
	Fri,  6 Jun 2025 13:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749218311;
	bh=QyO94pd4hlnn9BKqJzgyhfcD8waNKskd+/HKP0CvpQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=boD0tZeVz5UtG9+im6UihIJ+Z3HQVXLzuovQCa76Atf/9RHJd0Xy0unwT4wwKsQ+U
	 IazlNovBJ4GSG7qM8+lXg86bB8VuD/12OnlxwVm1uCwbqBrW8OttMdBn3MyTyCX/+F
	 KsHnXp2ftgx8rT65KtGmXpExDfPqjsWx6xc3RgjumuBb/LaoUAk/zru1lJg7Qa6BH+
	 haVxJHJCz808MLSPhmGUjOeyNUDeirD4ekFhd9PA8NGB7Q8ySMFMP0l+yE63y4hZ92
	 tw7ECnLbyvsMHl7sAIwFFTQzZXWhDhNbR+/zRiPCYRTyi9x6oOfMNjL1liJCxEvdGs
	 fkfa4ID5MlTLA==
Date: Fri, 6 Jun 2025 15:58:24 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Igor Korotin <igor.korotin.linux@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Hung <alex.hung@amd.com>, Tamir Duberstein <tamird@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Xiangfei Ding <dingxiangfei2009@gmail.com>
Subject: Re: [PATCH v2 5/5] samples: rust: add ACPI match table example to
 platform driver
Message-ID: <aEL0AGBZqDp1lMFe@pollux>
References: <20250605161956.3658374-1-igor.korotin.linux@gmail.com>
 <20250605165231.3663810-1-igor.korotin.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605165231.3663810-1-igor.korotin.linux@gmail.com>

On Thu, Jun 05, 2025 at 05:52:31PM +0100, Igor Korotin wrote:
> Extend the Rust sample platform driver to probe using device/driver name
> matching, OF ID table matching, or ACPI ID table matching.
> 
> Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
> ---
>  samples/rust/rust_driver_platform.rs | 40 +++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
> index e3992e7a71e9..ee0780c1d6ae 100644
> --- a/samples/rust/rust_driver_platform.rs
> +++ b/samples/rust/rust_driver_platform.rs
> @@ -17,10 +17,48 @@ struct SampleDriver {
>      [(of::DeviceId::new(c_str!("test,rust-device")), Info(42))]
>  );
>  
> +kernel::acpi_device_table!(
> +    ACPI_TABLE,
> +    MODULE_ACPI_TABLE,
> +    <SampleDriver as platform::Driver>::IdInfo,
> +    [(acpi::DeviceId::new(c_str!("TEST4321")), Info(0))]

Can you please explain add a comment explaining how to make this probe? In the
cover letter you mention:

"Tested using QEMU with a custom SSDT that creates an ACPI device matching the
sample Rust platform driver."

> +);
> +
> +/// OF/ACPI match tables for Platform Driver implementation
> +///
> +/// The platform::Driver requires declaration of both OF_ID_TABLE and
> +/// ACPI_ID_TABLE, but if driver is not going to use either of them
> +/// it can implement one of them or both as None.
> +///
> +/// # Example:
> +///
> +///```
> +/// impl platform::Driver for SampleDriver {
> +///     type IdInfo = Info;
> +///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
> +///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
> +///
> +///     fn probe(
> +///         pdev: &platform::Device<Core>,
> +///         info: Option<&Self::IdInfo>,
> +///     ) -> Result<Pin<KBox<Self>>> {
> +///         dev_dbg!(pdev.as_ref(), "Probe Rust Platform driver sample.\n");
> +///
> +///         if let Some(info) = info {
> +///             dev_info!(pdev.as_ref(), "Probed with info: '{}'.\n", info.0);
> +///         }
> +///
> +///         let drvdata = KBox::new(Self { pdev: pdev.into() }, GFP_KERNEL)?;
> +///
> +///         Ok(drvdata.into())
> +///     }
> +/// }
> +///```

I assume you want to make clear that both the ACPI and OF table are optional;
not sure of that's required given their type is Option<...>. But I'm fine having
this additional comment and example.

Please make sure that it compiles though and remove everything unnecessary from
probe() please.

> +
>  impl platform::Driver for SampleDriver {
>      type IdInfo = Info;
>      const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
> -    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
> +    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
>  
>      fn probe(
>          pdev: &platform::Device<Core>,
> -- 
> 2.43.0
> 

