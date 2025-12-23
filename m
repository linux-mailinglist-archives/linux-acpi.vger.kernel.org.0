Return-Path: <linux-acpi+bounces-19832-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 629DDCD9FFB
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 17:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93DB03022A8C
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 16:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2066288C2B;
	Tue, 23 Dec 2025 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="DPsZ/D6e";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="2uPdkJDm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m.foxido.dev (m.foxido.dev [81.177.217.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068332D6E73;
	Tue, 23 Dec 2025 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.177.217.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766508419; cv=none; b=A06ERPali68MWgW77j7MzfTj2kyWq7hs0h1Xv7CTwKVcijULMDIbNUSf9DK0QOvF7wMGwIh001FC9VQjbt/Vueg4eUk+AhxG+n5Nnnih1jBoMMwdED/VpTk/m6yR9c2NU+vG1y8O+yPSbjIKWkPbGFLoZCqGftnCmNCKWr2gg+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766508419; c=relaxed/simple;
	bh=c3oruc5JNPL3tmclWUMJaqookCpPc3ku7t6M4H9XVBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P7crlxJJOztqDxB7EP07X8fK3VYwJFyXtXZRFfWmP0eJT2RfmTVnZhx3vhb+aq/6E6UR4rzHGFR/m+tPYYIEz8iUbc0iBXYfGBtBnHCdBQtErP0+ytWudGYyn9PElOjMUIlKki55eRFqzT0yb1JnvA8RXPHhCj7DHTjtEdKvVrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=foxido.dev; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=DPsZ/D6e; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=2uPdkJDm; arc=none smtp.client-ip=81.177.217.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxido.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1766507796; bh=ZWOnZuUMlVXzgHCTwvw9NNQ
	mfdOfpyNA3gzYuFDdTAM=; b=DPsZ/D6eonS0NWChqhm2efhUulODxaaaQ3iRcbOxJoo+5KV/16
	NW9CB/OhCf3knj49qwGXS7SkDlYCBNqshWPBBX4rhPmKvNm4wgPm2vuvHQQ7fbdnp7ptX9oqx55
	7zBoXCmixWP4rp4Oqzbmvgsqjb4AxybIzUXEjS8ATB2JRxLObcFv1mvlTHSHPADPLfD7jFoUZC1
	m96hsqGjvHJVo9Qalku2abprUax3RlbKo0D82eNqruwem5ftCVpmXdatfbDePD9uSyjc8wRIciY
	5KbWpyTm0E6KjCW/CvYc8zl8J/NfPZZDSclURl4Im3Dwzlsp0OLAz5iIqJjaG0hUX0g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1766507796; bh=ZWOnZuUMlVXzgHCTwvw9NNQ
	mfdOfpyNA3gzYuFDdTAM=; b=2uPdkJDmvR/9Ge6TcjQfAu6c81SN9E3FTLtLEN+GukIZVLTgys
	d0nY/WA/qg9AjtpMB/99fBIRf/w11tpKOJBg==;
Message-ID: <3aa3ef74-ee40-4a57-94c8-bf642e23aee5@foxido.dev>
Date: Tue, 23 Dec 2025 19:36:34 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] rust: implement wrapper for acpi_object
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@gmail.com>,
 Armin Wolf <W_Armin@gmx.de>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <cover.1766331321.git.foxido@foxido.dev>
 <a28e83201e1413091333509628274807e50ec170.1766331321.git.foxido@foxido.dev>
 <CAJZ5v0hQwopbJox0QpT5tmZ0Eobgpfii47cDP8OWEON+iT4Qxg@mail.gmail.com>
Content-Language: en-US
From: Gladyshev Ilya <foxido@foxido.dev>
In-Reply-To: <CAJZ5v0hQwopbJox0QpT5tmZ0Eobgpfii47cDP8OWEON+iT4Qxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/22/25 22:32, Rafael J. Wysocki wrote:
> On Sun, Dec 21, 2025 at 7:24 PM Gladyshev Ilya <foxido@foxido.dev> wrote:
>>
>> ACPI Object is represented via union on C-side. On Rust side, it's
>> zero-cost type wrapper for each ACPI Type, with individual methods for
>> getters and other interactions.
> 
> This is ACPICA stuff though and switching over ACPICA to Rust any time
> soon is rather unlikely.
> 
> Is this really needed on the Rust side?

At least acpi_buffer is needed, and for now, only that will be wrapped 
(I will remove other types).

Note that there are no actual types on the Rust side, only transparent 
wrappers around C acpi structs (for type safety).

