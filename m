Return-Path: <linux-acpi+bounces-18002-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3F8BF1799
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 15:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F2674F629D
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 13:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5BA31DD8A;
	Mon, 20 Oct 2025 13:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfT1qpqt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8B7320380;
	Mon, 20 Oct 2025 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965907; cv=none; b=X7EiXeSi72RR9QocX9kjcBrpM1Abqci+Bnln/JT1It3JVXATWQPtrKJXXi5LnonUCJpGnBROjOzMi2Uhu4itVkbnp2MmUcM0zOgLICDI7OPsPtEYmIypllq60mwvBKimk/Z8tstmDqdYVS0DCSxpdWoc7O4XRsl+wUI1uzh8iNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965907; c=relaxed/simple;
	bh=fUrlHPDefya4ZgIR4w8n8xOGcGITTCU/I54LqE8Kxj0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GqEvYOsZlApDeRdczbm50w9+jC6JRrJ6sP8r7cFhiUuHA1P2CNf4tkOXF1J5Lns9Jq1NlUJZFWwHA7UOb0AvvU16yveXJRWrB1lVLoI2vV/aR6gjVAp82dSMJU3wnBQ7f8JcWZa5w+wfRV2jd5v/1fRwflPNJjORsehZ3gazfvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfT1qpqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A806C116B1;
	Mon, 20 Oct 2025 13:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760965906;
	bh=fUrlHPDefya4ZgIR4w8n8xOGcGITTCU/I54LqE8Kxj0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=HfT1qpqtoVB8LDASViN+nkWRJDfwbDCIzDhmMl84j2k/X23zDQEV1EAr4JmKYEW8M
	 5DINVK0AqWx4IsdrLa8C+irbXmdkRGVx/kXzOTV1oCU8P//Wv10O/4iNrdvMeK8g3x
	 1akXcYdpF0+fszq+6g/7wKIs0x23z2InoSIgSR+V6bbj9TNPn9WGEZeNEW15dSQBBN
	 ncb6DnvwrnLGwLbUhNMf+pFKcir9LnkKX57s35dAGhiAJpMLnX2J07WWCPa0cQcyN/
	 1kUjReNIOVxKWBzo695zTeCwqJuaCSmXMNmQ6OZcrwm4dgRtO6jTVMyvsGHPlBbyC8
	 Kf1+EvehwqJoQ==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Oct 2025 15:11:38 +0200
Message-Id: <DDN6B9VKK6O6.2SHDUYDMJCOG7@kernel.org>
Cc: <rafael@kernel.org>, <lenb@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <dakr@kernel.org>, <linux-acpi@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: acpi: replace `core::mem::zeroed` with
 `pin_init::zeroed`
From: "Benno Lossin" <lossin@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>, "Siyuan Huang"
 <huangsiyuan@kylinos.cn>
X-Mailer: aerc 0.21.0
References: <20251020031204.78917-1-huangsiyuan@kylinos.cn>
 <aPXwaDI8RUjMzMKI@google.com>
In-Reply-To: <aPXwaDI8RUjMzMKI@google.com>

On Mon Oct 20, 2025 at 10:18 AM CEST, Alice Ryhl wrote:
> On Mon, Oct 20, 2025 at 11:12:04AM +0800, Siyuan Huang wrote:
>> All types in `bindings` implement `Zeroable` if they can, so use
>> `pin_init::zeroed` instead of relying on `unsafe` code.
>>=20
>> If this ends up not compiling in the future, something in bindgen or on
>> the C side changed and is most likely incorrect.
>>=20
>> Link: https://github.com/Rust-for-Linux/linux/issues/1189
>> Suggested-by: Benno Lossin <lossin@kernel.org>
>> Signed-off-by: Siyuan Huang <huangsiyuan@kylinos.cn>
>
> We should make this method accessible under kernel::ffi:: since that's
> IMO a better path for it for cases like this. It doesn't really have
> anything to do with pin_init in this use-case.

Yeah, we should do that. I don't have time to do it, so if anyone wants
to go ahead, please do :)

Cheers,
Benno

