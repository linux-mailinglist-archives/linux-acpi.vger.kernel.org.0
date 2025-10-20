Return-Path: <linux-acpi+bounces-18003-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D09BF180A
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 15:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A03644EB68D
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 13:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FC825A655;
	Mon, 20 Oct 2025 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoc0m9d1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EBC1C84C0;
	Mon, 20 Oct 2025 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760966272; cv=none; b=jEZv9eww5kEZEKL7tKlawOHovPCsSOWw5GT1Fd8w3Zx5j782P7Y36i2vZGDeIeiMe5ypKWIzGewH1p2Yy0bxILA25AFjD3LkamLnMZVuqLzZcFvw17Ly+Oja7eQ/MbeBPwfwXLSxAyaXM7DyFExg3lIJKKP5cMDb0iqzb/avBwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760966272; c=relaxed/simple;
	bh=Q6dPfppUAtQSvlACVICBfe5BTPuVHrT+7T4aQpJcxuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fS8+7NQsjE74/PF4hNpOsGAXXquiGSSJklpwvSDSh8Fy1J6IUbpK52h607051UPT2YUCMOCRUfm9d/FEIkSetkVYC4ZqkOgf2QkrwmlNsjrJvzSzNaqQy2qShBq0S8vnPXwnandY4XTEMFeg8WYeZgPKhRiZF6OIH9W/cmcNXLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoc0m9d1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C2FC4CEF9;
	Mon, 20 Oct 2025 13:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760966272;
	bh=Q6dPfppUAtQSvlACVICBfe5BTPuVHrT+7T4aQpJcxuU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hoc0m9d1RygVWbxA9Y0wLLqp+m1sE2SA/CqmeMee8wHNwJmMdACxTiRigwBFG8Zu0
	 claO0kx2MULA3JNoz9beXVExGYd+TeHJ/pd2w7xLXe6cbloPx7tNMUNVs2EAAN/Vpa
	 P2/7Fh8RDeuqd5F+D6ZnOo295eQUuoUBxO7455v+PkaQyTGH8+hrt/HeBBJJlUPEfb
	 7hnlaZA5hqOPIN+zTb1llaaKsBaEwC2y/iJBpOFO7Hw8MdD2in83qdwEBmzvw5t/vQ
	 Djt7zVTNisj6ODTSh1BqSGnqw9DW1xxXjWb6YMb3cImv6XNBFEi6Sjs0TPg/1MyW/k
	 9iNDOcF4awXUQ==
Message-ID: <e86af6ea-5991-4246-a725-ff5bf45b13b8@kernel.org>
Date: Mon, 20 Oct 2025 15:17:47 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: acpi: replace `core::mem::zeroed` with
 `pin_init::zeroed`
To: Siyuan Huang <huangsiyuan@kylinos.cn>
Cc: rafael@kernel.org, lenb@kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, linux-acpi@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251020031204.78917-1-huangsiyuan@kylinos.cn>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251020031204.78917-1-huangsiyuan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 5:12 AM, Siyuan Huang wrote:
> All types in `bindings` implement `Zeroable` if they can, so use
> `pin_init::zeroed` instead of relying on `unsafe` code.
> 
> If this ends up not compiling in the future, something in bindgen or on
> the C side changed and is most likely incorrect.
> 
> Link: https://github.com/Rust-for-Linux/linux/issues/1189
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Siyuan Huang <huangsiyuan@kylinos.cn>

Acked-by: Danilo Krummrich <dakr@kernel.org>

Siyuan, there are more such cases, e.g. in OF, debugfs and a few others in case
you're interested in fixing up those as well. :)

