Return-Path: <linux-acpi+bounces-14219-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26F8AD1183
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Jun 2025 09:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 744EC16B0C5
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Jun 2025 07:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FEF1FBE8B;
	Sun,  8 Jun 2025 07:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d11+CsZg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A5A1AC88B;
	Sun,  8 Jun 2025 07:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749369532; cv=none; b=jcZDY5wdShO4z1YyUoTpHAgAm7DS9HPg/3yWdgsC2y4B6+kgobZV0PQpPPCclN9pE6pFFL2wIpvSW4/nNQUdZ9GvuKkg/xi2xWhlH4G67Z+2SHtkhQeCgaba1JskEd4UjYzA65vyfs73SZ6U12LlojXIM24Jpx2u4NQlpOr/ijo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749369532; c=relaxed/simple;
	bh=VBjtYErWs6de/6b5SNrswQN/MIEXGEMgrz94Dvuld84=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jpkmfPkIDaiEwgAMQxLYwNMVvZxwDAUAnyr/zHoHOmA22qviV6N4kkYGAJGQufyTsE8/UHc/v5H1EGujkURXkpTePUfr0z0ZIziV7QA0mClMuZ0msbq/L4HhhKNBFjNrLy+q+UfcjSCFtp9ShOo2CiiRtp3qKsuDCC0tsjsuLC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d11+CsZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461A1C4CEEE;
	Sun,  8 Jun 2025 07:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749369532;
	bh=VBjtYErWs6de/6b5SNrswQN/MIEXGEMgrz94Dvuld84=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=d11+CsZgVeuLPpcUL3AIJ1gt4iirZ0e80qqHwHn/n/n0ai1ZGGhxwA8wek1xnPKHl
	 xZc0lFpaVOXjHClfO6SEio/Rh3+KMlSAHyfrcbM2Wbq3Y5n01UTnKYIAe/HgYbYtX/
	 W47IIU+9W1c2PF9uHKpfkhvqBbnDoShSZHlSJxeR/NePOkziGrM0RayC+uwPEG5bC5
	 O99rgD+dDu/i5dRsII0CVJs+A8pFUJqcLRC9QHQC+3HH5aahFwlK0LHdW7uzFK4BDN
	 tqLMOaLVYOOOelMgSNOvFFJ5gxhGcRLSx9HgcpAHhRDNySDXFA8tfCmldvTd7CSGEp
	 5UAThdKyXD5qQ==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 08 Jun 2025 09:58:46 +0200
Message-Id: <DAGZQQ0GQGI7.3QYQ39S6RPC2Z@kernel.org>
Cc: <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <benno.lossin@proton.me>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <dakr@kernel.org>, <lenb@kernel.org>,
 <wedsonaf@gmail.com>, <viresh.kumar@linaro.org>, <alex.hung@amd.com>,
 <dingxiangfei2009@gmail.com>, "Igor Korotin" <igorkor.3vium@gmail.com>
Subject: Re: [PATCH v3 4/4] samples: rust: add ACPI match table example to
 platform driver
From: "Benno Lossin" <lossin@kernel.org>
To: "Igor Korotin" <igor.korotin.linux@gmail.com>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <rafael@kernel.org>, <gregkh@linuxfoundation.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250606170341.3880941-1-igor.korotin.linux@gmail.com>
 <20250606171033.3882079-1-igor.korotin.linux@gmail.com>
In-Reply-To: <20250606171033.3882079-1-igor.korotin.linux@gmail.com>

On Fri Jun 6, 2025 at 7:10 PM CEST, Igor Korotin wrote:
> Extend the Rust sample platform driver to probe using device/driver name
> matching, OF ID table matching, or ACPI ID table matching.
>
> Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
> ---
>  samples/rust/rust_driver_platform.rs | 96 +++++++++++++++++++++++++++-
>  1 file changed, 95 insertions(+), 1 deletion(-)
>
> diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_dri=
ver_platform.rs
> index e3992e7a71e9..be7c311dca07 100644
> --- a/samples/rust/rust_driver_platform.rs
> +++ b/samples/rust/rust_driver_platform.rs
> @@ -17,10 +17,104 @@ struct SampleDriver {
>      [(of::DeviceId::new(c_str!("test,rust-device")), Info(42))]
>  );
> =20
> +// ACPI match table test

This looks great, let's move it to the crate-level documentation. That
way it gets rendered :)

---
Cheers,
Benno

> +//
> +// This demonstrates how to test an ACPI-based Rust platform driver usin=
g QEMU
> +// with a custom SSDT.
> +//
> +// Steps:

