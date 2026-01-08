Return-Path: <linux-acpi+bounces-20067-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F28D0343D
	for <lists+linux-acpi@lfdr.de>; Thu, 08 Jan 2026 15:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD7533059AB6
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jan 2026 14:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625BE4D4F9E;
	Thu,  8 Jan 2026 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eznq3CaH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347C94D4F99;
	Thu,  8 Jan 2026 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767880898; cv=none; b=TyngCLNgO+spFMh8FZiMx3+xHBPNnRvIOXdLYJYAA0mEHFci1Pj082BDIqNvwx/v25vtuaiNEbuTI0km05XDehBjtBl9NYcjLjN2p+AbTgg5ZSxj6TC6jsOEAauB27oS4Ps3llTkZB7jGUYetMukWh2F0CNaiRddm8zHn4qQYW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767880898; c=relaxed/simple;
	bh=y0Hy0NxNVX+fY/q63DAVPV47enA8J/C97cniqCF6ZI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tI6dXoBr4go4nuRRYCVseTjI0Y/4R7PZLEjSbxv5dzemdvm/nwROgRMJ6abErm4tx9zmQitQK+Mw5tZ9SWcUJJEFF4R6980CujoOHxtUf6vmWFNDJ6OnObAit6C6N7ad1V04uuq0OnLr4ukRRdqY6KAG1TkeFQHaIFmJbEpDurg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eznq3CaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004E4C116C6;
	Thu,  8 Jan 2026 14:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767880897;
	bh=y0Hy0NxNVX+fY/q63DAVPV47enA8J/C97cniqCF6ZI4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eznq3CaHzYDG5jpotRGliKw6ghBxyc3cFLnLH4KhvIrDTY4bH5No0sJ/MfiEbNCd/
	 DIlxdARCtqbk3Ww7zeoxZV0Kqci3UaifZzx6pjUF4KRIGF5ZS+r8ti04N4zkXDYuqP
	 KdPlwD5uqUvi7HzVnv5h8ns+cuC8r0FHxRaC+9vymRXMIS4VV738MQk5bfSPDTSv+6
	 999gU/XfzH+xfyeGSMeVf980x9oc8k0IyE4qKHYcO8Q9X/35DH9dF8u+jtmY2pg0lT
	 LQpzbk6+2SnAiEHxrORmUaCjJRIjjFfz8Blum0eCfd8EaqZAaxIkIQbH1Q/G0UGxMh
	 vPfZ742eiXn3Q==
Message-ID: <bd3b7165-27ed-4f7d-abb5-4a60063260d8@kernel.org>
Date: Thu, 8 Jan 2026 15:01:32 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: acpi: replace manual zero-initialization with
 `pin_init::zeroed()`
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Atharv Dubey <atharvd440@gmail.com>, Len Brown <lenb@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 linux-acpi@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251201155210.22710-1-atharvd440@gmail.com>
 <CAJZ5v0hvD9T1y2uGq1MtFafQTRUJf2oeKEj11hAZ8gv5J5OM1w@mail.gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <CAJZ5v0hvD9T1y2uGq1MtFafQTRUJf2oeKEj11hAZ8gv5J5OM1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/8/26 3:00 PM, Rafael J. Wysocki wrote:
> On Mon, Dec 1, 2025 at 4:52 PM Atharv Dubey <atharvd440@gmail.com> wrote:
>>
>> Use `pin_init::zeroed()` instead of `core::mem::zeroed()` for initializing
>> `acpi_device_id`. This removes an explicit unsafe block and aligns ACPI
>> initialization with the pin-init conversion used across the Rust tree.
>>
>> Link: https://github.com/Rust-for-Linux/linux/issues/1189
>> Signed-off-by: Atharv Dubey <atharvd440@gmail.com>
> 
> A Rust-side ACK or equivalent would be welcome.

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

