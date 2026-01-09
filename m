Return-Path: <linux-acpi+bounces-20108-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE27D08D73
	for <lists+linux-acpi@lfdr.de>; Fri, 09 Jan 2026 12:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14102301E588
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jan 2026 11:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A91133AD85;
	Fri,  9 Jan 2026 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="RxoCJkty";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="i38XKqfr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m.foxido.dev (m.foxido.dev [81.177.217.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1B2212FB9;
	Fri,  9 Jan 2026 11:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.177.217.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767957166; cv=none; b=RbtPPj04/+NOpbR/BJUOroDAe7/+lRIjqxQCoLNBw5vP34V68oziUCETAJu53fxF+C4a5Ymkl3LvA8CyIgLoV4OugOuRkDopG3K10pKPheUK6jRC5Hg1VFMaGdTwPrarhEhg0z5rRrPUx0FJMto/SLjno0ENhgsf4Mj0S9ezwwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767957166; c=relaxed/simple;
	bh=Dkau82hsJ+DmW1Y6VMA9TTxIuOJDmZMwqjFKfCCruAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jYMnMl5cT/QDBddB/VSuo5QZ/oXFbJaxf/lfnsFyt1Kv2PILK2wdd82uG++MjCLd2+NIYYRsAe+Jv+Qmysb2XKL+2FiBNTzvR33gQiS8UqQog0AFvJmVU02qm4VT3AzJWpIMGbAU4f0ojagKzsFMzbO2x/m04GvAKsfi/fjIEfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=foxido.dev; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=RxoCJkty; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=i38XKqfr; arc=none smtp.client-ip=81.177.217.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxido.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1767957134; bh=D3VjQJrX7fEC9KlHLozvNVJ
	PpBrGVqH1peCc0TRpagE=; b=RxoCJktyixPsXBwzaqgz1AvP0qkvr+5swubyEBU/G8P7dRNqik
	iKZpQrYri5Qk9Vp0/7WHbXpxfzbVH8b/xtT9V8DeFoASijjcA6+kjiMn73hp8qTCAF85fcNmngk
	5MDwF2nhtiHR4qn4CVebnMZw6roS2luOO3QjhZHP4WDipsDu7C3C06dtjvxMyJj9fT0j/6POF/v
	g6rbsle3zY1xprg1k9+7ND66L4x9z7EgpisyTGxD/stM3ok2aEaa5TeUTAj4Hn+Qm0sp9AwmAC8
	XOpoguKoW/wLzHxTYuOg1+1IJFujDRIPRuvyodqAGLWnj5vH+9TZlXkv+U3BGPQwfXg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1767957134; bh=D3VjQJrX7fEC9KlHLozvNVJ
	PpBrGVqH1peCc0TRpagE=; b=i38XKqfrIU/EnpOhVYovj1diulR8mYtFOVwg8prQxNE/cnsTtd
	TdUNM6ig5WMmTNkayZEeN9730CCPvVg7+UDw==;
Message-ID: <622213c0-1793-4b1f-ba9a-aa99f73047f6@foxido.dev>
Date: Fri, 9 Jan 2026 14:12:10 +0300
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
 <CAKBF=psGUwgr7e+EM1d2OAv8H1A6zKfhQaSPS56vVcnc=Ez_KA@mail.gmail.com>
Content-Language: en-US
From: Gladyshev Ilya <foxido@foxido.dev>
In-Reply-To: <CAKBF=psGUwgr7e+EM1d2OAv8H1A6zKfhQaSPS56vVcnc=Ez_KA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/8/26 22:48, Kari Argillander wrote:
> On Wed, 7 Jan 2026 at 22:56, Gladyshev Ilya <foxido@foxido.dev> wrote:
[snip]
>> +    /// WMI device notify.
>> +    ///
>> +    /// Called when new WMI event received from bounded device.
>> +    fn notify(self: Pin<&Self>, _dev: &Device<device::Core>, _event: Option<&AcpiObject>) {
> 
> This should be device::Bound
> 
> Also probably _ marks are not needed. I think compiler does give
> unused build warnings.
> 
> I do not know reason but usually other drivers use this over self. And
> device first so this
> would be:
> 
>      fn notify(dev: &Device<device::Bound>, this: Pin<&Self>, event:
> Option<&AcpiObject>) {
> 
> Same also in unbind. But like I said I'm not completely sure about this.

I thought the reason for using this instead of self was because of the 
limited set of possible self types in previous versions of Rust...

IMO using Rust's self is more readable

>> +        build_error!(VTABLE_DEFAULT_ERROR);
>> +    }
>> +
>> +    /// WMI driver remove.
>> +    fn unbind(self: Pin<&Self>, _dev: &Device<device::Core>) {
>> +        build_error!(VTABLE_DEFAULT_ERROR);
>> +    }
> 
> unbind should not be mandatory so here just do
It's not mandatory, that why there is default implementation. See 
https://rust.docs.kernel.org/macros/attr.vtable.html


For other comments: Ack, thanks!

