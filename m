Return-Path: <linux-acpi+bounces-20106-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C14D7D08C8C
	for <lists+linux-acpi@lfdr.de>; Fri, 09 Jan 2026 12:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B3BC6300053E
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jan 2026 11:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E0C33B97D;
	Fri,  9 Jan 2026 11:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="pOwUdcUs";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="z0zefi5V"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m.foxido.dev (m.foxido.dev [81.177.217.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4B533B6FE;
	Fri,  9 Jan 2026 11:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.177.217.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767956507; cv=none; b=IIBV0+9U2yfU1lp5nj8bzYFEoykzoYlDL5LE3hdbTHLvcGazOks8sHYlyV7Me0WUp6u8ntAQbAD1cKb+yBcpWIj6yuJIjglKdSU3vboPSr7MBMe24u/bAA6Al8Kqfx3x2QaLCTR2ehOUuGxO9M9UPGywQVD09b8pvQBdHt1p5UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767956507; c=relaxed/simple;
	bh=MgdDRhOX289Jvru5sc60n2UQcHf+WqOnCsD6DPlUQfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pylGT8/GJtFLj3qiIGjXg/5D/Q7kIvvKcU7VRjGgz12L8ue7ZQ7mqWaM77BQTesw63x590dw2w5DeF//hTq9oeu7aOZtoEKrDavo+0D2NUy1eeBX8HX4c0Og62BEKIfXfI3ol+Mr9nq7/7og1GpB2XUekG0+akpg4x4OuFuxd2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=foxido.dev; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=pOwUdcUs; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=z0zefi5V; arc=none smtp.client-ip=81.177.217.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxido.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1767956480; bh=gI6MZQ7/iz2bg3zwj8e+wkv
	2PcH8IyIJieSl0rYYyFQ=; b=pOwUdcUs6C68jl4kbnH827ZBTPO4EK9IBCcBxcDi5XHh6ZAcau
	6RTNgNPNjxLrgpzJvu1JuOX53kYPEO/8TLPhQVUyU3BMBe35tOxKzglVENPg8uhE0ELDHOP++V3
	YgDbre9kr8duMrkVdc+czxipK/W4/Loz4EPklX+BK35tl7Gd4aSFfCq51kgOxtOLTP58AxQlxWh
	iXlHItsuUs9OR5SF+Hl6qtArD0CW/N92FjfyXPd4+9bL/mBpQbr9dUpTpdL1bhMJAw3lJMfv9RR
	/CPUVSUtaiYjl8m2WcB4EuwwwBXWXfXqxlkpj0titm6xVVCV8juToDbHerr59r9Lb4w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1767956480; bh=gI6MZQ7/iz2bg3zwj8e+wkv
	2PcH8IyIJieSl0rYYyFQ=; b=z0zefi5V/vZmm5UV/oZOBZYDs09wdumVf7FPBpV1oi4SDgQJU9
	tAklbcqp3sWqho1v9bNZE9iJx7kpBl22VDBA==;
Message-ID: <670cab36-3d32-4769-8a3c-a5d3e1bdd74a@foxido.dev>
Date: Fri, 9 Jan 2026 14:01:16 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] rust: add WMI abstractions
To: Kari Argillander <kari.argillander@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Tamir Duberstein <tamird@gmail.com>, Armin Wolf <W_Armin@gmx.de>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org, foxido@foxido.dev
References: <cover.1767818037.git.foxido@foxido.dev>
 <a119094f2e248587c541daf7c5b65bf4398b281b.1767818037.git.foxido@foxido.dev>
 <CAKBF=psOiiakGigJj0Kee3Z5rym41eksSZTgzsO3H1gzUP6DjA@mail.gmail.com>
Content-Language: en-US
From: Gladyshev Ilya <foxido@foxido.dev>
In-Reply-To: <CAKBF=psOiiakGigJj0Kee3Z5rym41eksSZTgzsO3H1gzUP6DjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/8/26 23:48, Kari Argillander wrote:
> On Wed, 7 Jan 2026 at 22:56, Gladyshev Ilya <foxido@foxido.dev> wrote:
> <snip>
> 
>> +impl DeviceId {
>> +    /// Constructs new DeviceId from GUID string.
>> +    pub const fn new(guid: &[u8; bindings::UUID_STRING_LEN as usize]) -> Self {
>> +        // SAFETY: FFI type is valid to be zero-initialized.
>> +        let mut inner: bindings::wmi_device_id = unsafe { MaybeUninit::zeroed().assume_init() };
>> +
>> +        build_assert!(inner.guid_string.len() == bindings::UUID_STRING_LEN as usize + 1);
>> +
>> +        // SAFETY: It's safe to copy UUID_STRING_LEN, because we validated lengths.
>> +        // Also we leave last byte zeroed, so guid_string is valid C string.
>> +        unsafe {
>> +            ::core::ptr::copy_nonoverlapping(
>> +                guid.as_ptr(),
>> +                &raw mut inner.guid_string[0],
>> +                bindings::UUID_STRING_LEN as usize,
>> +            );
>> +        }
> 
> Just use while here so no unsafe is needed at all. Then probably patch
> 1/3 is not needed.

Overall this operation is still unsafe because we are constructing C 
string in FFI object. So for me avoiding `unsafe` via less readable 
(imo) loop will just mask unsafe operation without any real benefits.

Ideally this function should receive c string and just validate it's 
length, but IIRC I had troubles with build-time validation of C string 
length

>> +
>> +        Self(inner)
>> +    }
>> +}


