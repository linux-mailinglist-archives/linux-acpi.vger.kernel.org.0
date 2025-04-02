Return-Path: <linux-acpi+bounces-12656-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DA0A79340
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 18:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 639433B1974
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 16:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B244B1DED49;
	Wed,  2 Apr 2025 16:28:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E0E1DC9BB;
	Wed,  2 Apr 2025 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743611315; cv=none; b=oraKAseQqkT9yvX7Rt+DGUMv+wlYW3WJwGvZWw0ZRDgGf8NNn/G5SmvA2bM1vh1D+KOMMf0nq58iYGobgzWXByzt5yGbKFawyvpebrMfrlY2iDQTbsBEb2ElW0wjh6dTIE+ZYH9fM1yGrbqXwg35ZWzR4oUdvk54w20qs30eWF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743611315; c=relaxed/simple;
	bh=0KerdkcffqZmlgoEUS22zRUxvbQYQdYxl/T66d4Qje8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=joqjOk3jij/2Bncw9vbDr3EjFu/J6orV/iPGws5x+xj2Azd3YxPcxU22XybGluSk60lV1XtKiZKM6MQbm2i/NL0dDM6IFr9wWFdT6tEzRz1ttjipeCKrXGrkQeoW2mtT8E/DQm39vQ74k7qQijk+439kJfAHYtm8iYt7aUc9Rwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZSVfZ1Wfcz9tyS;
	Wed,  2 Apr 2025 18:28:22 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Apr 2025 18:28:17 +0200
Message-Id: <D8WAMBXFOO2O.1Q3YT6FC05EKO@buenzli.dev>
Cc: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>, "Daniel Scally"
 <djrscally@gmail.com>, "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
 "Sakari Ailus" <sakari.ailus@linux.intel.com>, "Dirk Behme"
 <dirk.behme@de.bosch.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>, "Saravana Kannan"
 <saravanak@google.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 04/10] rust: Add bindings for reading device properties
From: "Remo Senekowitsch" <remo@buenzli.dev>
To: "Rob Herring" <robh@kernel.org>
References: <20250326171411.590681-1-remo@buenzli.dev>
 <20250326171411.590681-5-remo@buenzli.dev>
 <20250326212753.GA2844851-robh@kernel.org>
In-Reply-To: <20250326212753.GA2844851-robh@kernel.org>

On Wed Mar 26, 2025 at 10:27 PM CET, Rob Herring wrote:
> On Wed, Mar 26, 2025 at 06:13:43PM +0100, Remo Senekowitsch wrote:
>> +    pub fn property_read_string(&self, name: &CStr) -> Result<CString> =
{
>> +        let mut str =3D core::ptr::null_mut();
>> +        let pstr: *mut _ =3D &mut str;
>> +
>> +        // SAFETY: `name` is non-null and null-terminated. `self.as_raw=
` is
>> +        // valid because `self` is valid.
>> +        let ret =3D unsafe {
>> +            bindings::fwnode_property_read_string(self.as_raw(), name.a=
s_char_ptr(), pstr as _)
>> +        };
>> +        to_result(ret)?;
>> +
>> +        // SAFETY: `pstr` contains a non-null ptr on success
>> +        let str =3D unsafe { CStr::from_char_ptr(*pstr) };
>> +        Ok(str.try_into()?)
>> +    }
>
> There's a problem with the C version of this function that I'd like to=20
> not repeat in Rust especially since ownership is clear.=20
>
> The issue is that we never know when the returned string is no longer=20
> needed. For DT overlays, we need to be able free the string when/if an=20
> overlay is removed. Though overlays are somewhat orthogonal to this.=20
> It's really just when the property's node refcount goes to 0 that the=20
> property value could be freed.
>
> So this function should probably return a copy of the string that the=20
> caller owns.

I think the function already does that. The variable `str` is of type `&CSt=
r`,
so the expression `str.try_into()?` on the last line calls the implementati=
on
of `impl TryFrom<&CStr> for CString`, which is documented here:
https://rust.docs.kernel.org/kernel/str/struct.CString.html#impl-TryFrom%3C=
%26CStr%3E-for-CString

And looking at the source, it shows that the `CString` is created with a ne=
w
owned memory allocation:
https://rust.docs.kernel.org/src/kernel/str.rs.html#878-890

Remo

