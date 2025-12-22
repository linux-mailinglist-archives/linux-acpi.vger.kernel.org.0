Return-Path: <linux-acpi+bounces-19790-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B53CD738F
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 22:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7554F300670B
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 21:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F70F30F93A;
	Mon, 22 Dec 2025 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="FvWdYEZd";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="7G2KABJX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m.foxido.dev (m.foxido.dev [81.177.217.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67492299A8F;
	Mon, 22 Dec 2025 21:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.177.217.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766440083; cv=none; b=ccCZmyQNmjUKQ66awNYlqc7vlAp0YO0YTalsr66WwnyFw3idmrvnyt8EoHL/HzgqB+lgtsEH2fKYZYAvEjiua4uuYTxuC1WSruz6yl3ReCwOH6DCNcwyYtNdDsZwWwEnkJAvTty5u5QCIXUu4Tec27kQ0YWh9VxL3JhLbOvvFkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766440083; c=relaxed/simple;
	bh=Snu9Jrt+zidlFK51/gPv0gvUEospFW61l1sK1kIbbwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=avBcvpownrKtrOR2TfJ8+dtGG4CuntAQ5GuwOynJWZtq/UiT3FvJqL4t46lt4WTwJzMOvtIHlPjpjsc3k/QN8Sd2WB288VWE1TZHf5nqafI2RxIV1psJLt4f6xYVjONZvor3u9sOjq1uwgWmoh+KYgNtM1dmmImngqcRStpK/wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=foxido.dev; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=FvWdYEZd; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=7G2KABJX; arc=none smtp.client-ip=81.177.217.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxido.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1766440038; bh=ghgRSdastf1WP2RJZiLrcW9
	qvS9iUDdzm/jPXi5kSh4=; b=FvWdYEZd2HARKBMpILfI3K46EEHofNQw5SThgj9T2DvrPSrzp0
	NJRGc8xGmxkI4mrivaVxl1ooPrk9brhvtZqGpODN5nSN5ESpgu0EUafj3yv+o27flssiYncKYjT
	fgKk6xHPh4AnyJhRLiymflWxnBfijcgHi4urwnCXAiUnYNM/NsTIY+sXT2wfkUFVB2He3w9YzUd
	0ksETBrYUUaeXTTB5cYsbIH4xKvmIr5IhYfkNF1i9jGj8nyMWtNahMiWKv6WdDgNQSFz+ITmBRG
	nouoemuNTURhwDbqkZhCYg2SlElss5Dy37Mp/7m5d1y8vbfdvE767vr0tMLJm2mHWmA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1766440038; bh=ghgRSdastf1WP2RJZiLrcW9
	qvS9iUDdzm/jPXi5kSh4=; b=7G2KABJX6fXKMXHYC4+lczO77UFnjxTFJsHBnLzWo+s+p7krt1
	t50wlnCWhQoMfc+JbWoOgulA+OZLH2XtNOBA==;
Message-ID: <4266e3d2-141e-44bd-a4c1-b140674542e3@foxido.dev>
Date: Tue, 23 Dec 2025 00:47:17 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] rust: implement wrapper for acpi_object
To: Danilo Krummrich <dakr@kernel.org>
Cc: "foxido @ foxido . dev-cc= Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Tamir Duberstein <tamird@gmail.com>, Armin Wolf <W_Armin@gmx.de>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org
References: <cover.1766331321.git.foxido@foxido.dev>
 <a28e83201e1413091333509628274807e50ec170.1766331321.git.foxido@foxido.dev>
 <DF4PPPGQBPNA.13TJNSRSRUW0A@kernel.org>
Content-Language: en-US
From: Gladyshev Ilya <foxido@foxido.dev>
In-Reply-To: <DF4PPPGQBPNA.13TJNSRSRUW0A@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/25 14:35, Danilo Krummrich wrote:
>> +acpi_object_subtype!(AcpiInteger
>> +    <- (ACPI_TYPE_INTEGER, integer, bindings::acpi_object__bindgen_ty_1));
>> +acpi_object_subtype!(AcpiString
>> +    <- (ACPI_TYPE_STRING, string, bindings::acpi_object__bindgen_ty_2));
>> +acpi_object_subtype!(AcpiBuffer
>> +    <- (ACPI_TYPE_BUFFER, buffer, bindings::acpi_object__bindgen_ty_3));
>> +acpi_object_subtype!(AcpiPackage
>> +    <- (ACPI_TYPE_PACKAGE, package, bindings::acpi_object__bindgen_ty_4));
>> +acpi_object_subtype!(AcpiReference
>> +    <- (ACPI_TYPE_LOCAL_REFERENCE, reference, bindings::acpi_object__bindgen_ty_5));
>> +acpi_object_subtype!(AcpiProcessor
>> +    <- (ACPI_TYPE_PROCESSOR, processor, bindings::acpi_object__bindgen_ty_6));
>> +acpi_object_subtype!(AcpiPowerResource
>> +    <- (ACPI_TYPE_POWER, power_resource, bindings::acpi_object__bindgen_ty_7));
>> +
>> +impl AcpiBuffer {
>> +    /// Get Buffer's content
>> +    pub fn payload(&self) -> &[u8] {
>> +        // SAFETY: (pointer, length) indeed represents byte slice
>> +        unsafe { ::core::slice::from_raw_parts(self.0.pointer, self.0.length as usize) }
>> +    }
>> +}
> 
> What about the values of the other types? How are they accessed?

I couldn't really decide between implementing all types or only the one 
needed... Probably, I should provide simple implementations for all the 
others, I will fix that.

> Also, I think it would be better to use a Deref impl rather than a method.

Wouldn't it be confusing to overload Deref on a non "pointer-like" type 
just for an implicit cast?

Overall, thank you for your patience and review. I will fix the other 
comments from both of your emails.

