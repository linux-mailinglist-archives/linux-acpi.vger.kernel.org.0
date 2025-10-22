Return-Path: <linux-acpi+bounces-18070-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B282FBFA26C
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 08:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244E41A010A5
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 06:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0BB2EAB6B;
	Wed, 22 Oct 2025 06:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C9GE4h47"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5DB74C14
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 06:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761112966; cv=none; b=GcnU5wPUHI85finef68BX5Tc7GqDkFMzZEKSPjw8VUi1sJT7zM2yBBOqoBLRWu+ETlzzzOd4JvNYlWDSAyZ9hVi4fwXZQFrpLSRklyRkjGfrD3rFPxDYRy3L3E0CrDGqwypI0VxRCK6uPOnq9RhPht7EC6V0fSvpeuYnlY7KP6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761112966; c=relaxed/simple;
	bh=11qJWsQMMn3TdIr0k15HikUUDbffopUjVoEsdGswtAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZOCwWGhwwHC1ySfAYqZVK5vCrcBz0pPmdhjRLfxSdnu3mIjSVPgYkX2YR95C0OMDKCiVBqEYogEj+5LuD8+s5XyF0dm6OGN1jazxYip4tpNd+k9ew0nDyLrOGCoaEDVhMQz3Piyosfe/l8jxRyhHJLTPa6N8mb7HlWkx3/jmuFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C9GE4h47; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <edef2e95-d270-41cf-9ba5-390688fe2c15@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761112961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F7S0a0ENWg8lddRXks1OBpnlzn8V2G9Xj3LbzbyhYu0=;
	b=C9GE4h47xf8eUq38Ggzjdwwp72ZeaCrXlZTaZiVAkVzJqFp3PncF7sw/X4AEQq5P5r0CVP
	Ez68Z/O9XDhdiTfKJWR/rxGDJgjgfl0+a+OlrfUq2bX9Wzc4I1PM/2AXlSaEaQ3viwZKP1
	XJQlDkCOJ1wXhzB5Ga/egHskbeaWNmk=
Date: Wed, 22 Oct 2025 14:02:19 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] rust: acpi: replace `core::mem::zeroed` with
 `pin_init::zeroed`
To: Siyuan Huang <huangsiyuan@kylinos.cn>, rafael@kernel.org,
 lenb@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, dakr@kernel.org
Cc: linux-acpi@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251020031204.78917-1-huangsiyuan@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <20251020031204.78917-1-huangsiyuan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/20/25 11:12, Siyuan Huang wrote:
> All types in `bindings` implement `Zeroable` if they can, so use
> `pin_init::zeroed` instead of relying on `unsafe` code.
>
> If this ends up not compiling in the future, something in bindgen or on
> the C side changed and is most likely incorrect.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1189
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Siyuan Huang <huangsiyuan@kylinos.cn>
> ---
>   rust/kernel/acpi.rs | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/rust/kernel/acpi.rs b/rust/kernel/acpi.rs
> index 7ae317368b00..f9488be9249c 100644
> --- a/rust/kernel/acpi.rs
> +++ b/rust/kernel/acpi.rs
> @@ -42,9 +42,7 @@ pub const fn new(id: &'static CStr) -> Self {
>               "ID exceeds 16 bytes"
>           );
>           let src = id.as_bytes_with_nul();
> -        // Replace with `bindings::acpi_device_id::default()` once stabilized for `const`.
> -        // SAFETY: FFI type is valid to be zero-initialized.
> -        let mut acpi: bindings::acpi_device_id = unsafe { core::mem::zeroed() };
> +        let mut acpi: bindings::acpi_device_id = pin_init::zeroed();
>           let mut i = 0;
>           while i < src.len() {
>               acpi.id[i] = src[i];


Reviewed-by: Kunwu Chan <chentao@kylinos.cn>

-- 
Thanks,
        Kunwu Chan.


