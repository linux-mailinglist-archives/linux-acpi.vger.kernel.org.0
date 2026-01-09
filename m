Return-Path: <linux-acpi+bounces-20103-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9E7D08908
	for <lists+linux-acpi@lfdr.de>; Fri, 09 Jan 2026 11:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 500263024D4D
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jan 2026 10:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45582D5A19;
	Fri,  9 Jan 2026 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="YKoPAbDq";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="6wtE3GRV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m.foxido.dev (m.foxido.dev [81.177.217.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C981928B4E2;
	Fri,  9 Jan 2026 10:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.177.217.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767954669; cv=none; b=VsB7ME0AVDXkhFOb9xSYCxrp0c2kOh0SOLBx8Gvo4wGBKC7ld9aZKXhlG9G/P8MEPD3w34tRJQuEAv+ZHvgCUrN2sVvsU2/n7mg4YGEKm6PMgA1vgJCO612S+OG3RMpN038alg/Yn8OVdoEmwxPxh0SlBkK0ICzVN9dDnUiocdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767954669; c=relaxed/simple;
	bh=+qHAIPmCbdG+yT7XyoN5T2NgqGoDO4ZSyksu4ezcQpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PreYqogDCAYkSIwkfcUK3s+2DkXShdKOxRUUO7jtItAMoYiQz1T1NxqPYWXEfLaLHnvJZL0QWxhGveWZfUm+a5cAPXVj7OyMwg9+7Vr0s/LVxpD73Ie09C8V9LxuM4k83BKNzftclf8il5yHxUQgE7mNB5IBkMP7Jc8c0NniUfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=foxido.dev; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=YKoPAbDq; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=6wtE3GRV; arc=none smtp.client-ip=81.177.217.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxido.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1767954642; bh=Yn/2Om+B9b6zXo/LWX38uLY
	KiZO7o1iPmAvOdr8TL/4=; b=YKoPAbDqa4G6tRHdD1Pktb8cR44OeD7x/DKZALTwoEyVdzULjN
	+o5JzfPxCcmamUOGiYzV3NPF3ljqULJivDInvMJ31D45DUFJ50cMjKB9zW0QEgxwguJHpxjgnMR
	iDiNJi6LXBspkAo65Gu7BuDjD21k2DYym4ChjmJv4Sk1p3gnNya9l2ipHlVacSy6LZRlyJm3dzd
	Os/V4gA5Zeg0VqAvEL4zWCnsvFxz+3/tQ8o1hLCjo3lU4P31/5nEC9YIcsbmt3rkTgCpcKk3nDa
	UauoqBsChan62xfoA0SLTIiDpReFVI46UykRtsKYIvooSojpjznNCky0b23dYXZoZIQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1767954642; bh=Yn/2Om+B9b6zXo/LWX38uLY
	KiZO7o1iPmAvOdr8TL/4=; b=6wtE3GRVGadUiFqZy45xKa0TIeYQuXzXG9EDAcBOMYw3tIZN0A
	q4flcXdb8AlKwkN8EaKRBe5r4fzdqD75lMCQ==;
Message-ID: <510f51f0-64b5-48b5-b8d6-42629517b6ef@foxido.dev>
Date: Fri, 9 Jan 2026 13:30:35 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rust: implement wrapper for acpi_object
To: Gary Guo <gary@garyguo.net>
Cc: "foxido @ foxido . dev-cc= Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Tamir Duberstein <tamird@gmail.com>, Armin Wolf <W_Armin@gmx.de>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org
References: <cover.1767818037.git.foxido@foxido.dev>
 <05261e88ac8503e2af59d703389d94cc15f4450d.1767818037.git.foxido@foxido.dev>
 <20260108132141.6cce4827.gary@garyguo.net>
 <7b8130de-8096-4fcb-be84-c13209638b25@foxido.dev>
 <DFJH89UGFFHB.318N5A8X42JOB@garyguo.net>
Content-Language: en-US
From: Gladyshev Ilya <foxido@foxido.dev>
In-Reply-To: <DFJH89UGFFHB.318N5A8X42JOB@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/8/26 23:06, Gary Guo wrote:
> On Thu Jan 8, 2026 at 5:11 PM GMT, Gladyshev Ilya wrote:
>> On 1/8/26 16:21, Gary Guo wrote:
>>> On Wed,  7 Jan 2026 23:35:32 +0300
>>> Gladyshev Ilya <foxido@foxido.dev> wrote:
>>>
>>>> ACPI Object is represented via union on C-side. On Rust side, this union
>>>> is transparently wrapped for each ACPI Type, with individual methods and
>>>> Defer implementation to represented type (integer, string, buffer, etc).
>>>>
>>>> Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
>>>
>>>
>>> Hi Gladyshev,
>>>
>>> I've checked the `acpi_object` implementation on the C side and it appears
>>> that the buffer is not owned by the object (however managed externally,
>>> could either be resting in ACPI tables directly or be allocated).
>> Hm, I looked through ACPI_FREE() call sites and acpi_evaluate_object()
>> implementation, and it seems to me that the acpi_object's lifetime is
>> the same as its internal buffer.
> 
> No, it's not the same. acpi_object's lifetime needs to be shorter than
> the internal buffer.

Okay, I agree than) Will fix in next revision

