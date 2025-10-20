Return-Path: <linux-acpi+bounces-18001-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCFCBF1759
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 15:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB6653E736A
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 13:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BFD2FB621;
	Mon, 20 Oct 2025 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuBIY3x8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE30286889;
	Mon, 20 Oct 2025 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965825; cv=none; b=hYjqwl+RMOHxSH9+DqwxL+c0FZVl/BLodfx0qF1TPg5qq2fdXG9Quwnf0IWUthnXOQJuUXyVbVprOwH5iaoZocd+43QM1UQGRgUVQ7fK5fX+bM6+4MKlOdX1GqvBgskCZjkqx1r+kTbEp479fD40GGwjI5oqSmO/zOdOvCl1xNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965825; c=relaxed/simple;
	bh=6Pc9UWszhKcAi8/KToVHt002Dk2g1lKSe+WvbjXwVI8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FczyDMraP3/dtJUim75jipBB9T78quDfi0dREBb8zJGlh6zkEW+71bCCuyP5/O/T6sUb17FaVhmg0EJWOPSDq/dQ+/IXzngO43EinRK9XStuwV82AqVAosc495ZsMdFzMe1AsZQ7411UZuDzEnqBN8S/WDn6++dvBOwibsBTPTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuBIY3x8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103DAC4CEF9;
	Mon, 20 Oct 2025 13:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760965825;
	bh=6Pc9UWszhKcAi8/KToVHt002Dk2g1lKSe+WvbjXwVI8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=OuBIY3x8J5qZzQSjGUxQ4eCjq+K6khoqQ7MYbLGsyu7N/HZvEotU3uBcjoQZXBOCs
	 561l/M4LCGkVn9ZE3M/FYGOLvGGAtArq3v2gfdSROclpygdXxcOe/wzY2WNYRwes8w
	 qIh3JVVXN7ccpa2A83St5Um8s+coQ99sIBpPczPl7FuO4CpNrRZI18aiZWiHsNYSMu
	 40N4qNDOH680/460peDWSbWHSwFvWTNEZRmRiuxysTLGl7jNtQGZ5/YRCIYOw1Fp0I
	 PJ8KZ1GDgz6JVaLk6puxiGmzA6QZicoJtTb90Xm2GjZ6KXHeNUwhy5ipgY+txvhHOF
	 IdxDQoxg/q9pA==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Oct 2025 15:10:18 +0200
Message-Id: <DDN6A90KU2TR.31NIJCY3TEDYG@kernel.org>
Cc: <linux-acpi@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: acpi: replace `core::mem::zeroed` with
 `pin_init::zeroed`
From: "Benno Lossin" <lossin@kernel.org>
To: "Siyuan Huang" <huangsiyuan@kylinos.cn>, <rafael@kernel.org>,
 <lenb@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <dakr@kernel.org>
X-Mailer: aerc 0.21.0
References: <20251020031204.78917-1-huangsiyuan@kylinos.cn>
In-Reply-To: <20251020031204.78917-1-huangsiyuan@kylinos.cn>

On Mon Oct 20, 2025 at 5:12 AM CEST, Siyuan Huang wrote:
> All types in `bindings` implement `Zeroable` if they can, so use
> `pin_init::zeroed` instead of relying on `unsafe` code.
>
> If this ends up not compiling in the future, something in bindgen or on
> the C side changed and is most likely incorrect.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1189
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Siyuan Huang <huangsiyuan@kylinos.cn>

Thanks, great to see this.

Reviewed-by: Benno Lossin <lossin@kernel.org>

Cheers,
Benno

> ---
>  rust/kernel/acpi.rs | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

