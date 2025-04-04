Return-Path: <linux-acpi+bounces-12750-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 657E1A7BCE9
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 14:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB0D7177C3A
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 12:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A681DB363;
	Fri,  4 Apr 2025 12:49:09 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891FC2E62B6;
	Fri,  4 Apr 2025 12:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743770949; cv=none; b=jpDgVUXsD6QzzOtrmdcXDPmvXq2GEYMU64Un73AF7u/vgReRw9PxuuMpg9UyXPhhmgyemrh3BhShqvtyOioRbeVyp2o7g8JSaqlSJs3pN//IqOzZAB29vY+25dA3UX1lq+TQVg9PkV/rEbrWf1xSXsfnAJW4ALBrAUhjcHtsXSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743770949; c=relaxed/simple;
	bh=CEYtds7W6FcLLrM6Q6AVfowOXuAzfO5skyhiJ0Y81MA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=H93CJfG7+F1IxsNXrgx+Jm47SktureHJSVHocCv83bsKK/7wNvHY+tDrYAoYWImDfJNYOjxjeQ0XKexj0PbCjxRwySsIYuOk0q/oHU5NF5fjobmnizV4wRm95P8dRqeOrKTq1KvhCEkumQ7XCWe/QmBcFbmXSyEOKoGWvv6YQpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp102.mailbox.org (unknown [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZTdhT5NWYz9tkP;
	Fri,  4 Apr 2025 14:48:57 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Apr 2025 14:48:53 +0200
Message-Id: <D8XV7FTGG0EC.K6P4J4IMUJAO@buenzli.dev>
To: "Rob Herring" <robh@kernel.org>
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
Subject: Re: [PATCH 01/10] rust: Move property_present to property.rs
From: "Remo Senekowitsch" <remo@buenzli.dev>
References: <20250326171411.590681-1-remo@buenzli.dev>
 <20250326171411.590681-2-remo@buenzli.dev>
 <20250326205106.GB2787672-robh@kernel.org>
In-Reply-To: <20250326205106.GB2787672-robh@kernel.org>

On Wed Mar 26, 2025 at 9:51 PM CET, Rob Herring wrote:
> On Wed, Mar 26, 2025 at 06:13:40PM +0100, Remo Senekowitsch wrote:
>>
>> +impl Device {
>> +    /// Obtain the fwnode corresponding to the device.
>> +    fn fwnode(&self) -> &FwNode {
>> +        // SAFETY: `self` is valid.
>> +        let fwnode_handle =3D unsafe { bindings::dev_fwnode(self.as_raw=
()) };
>> +        if fwnode_handle.is_null() {
>> +            panic!("fwnode_handle cannot be null");
>
> It's usually not a good idea to panic the kernel especially with=20
> something a driver calls as that's probably recoverable.
>
> Users/drivers testing fwnode_handle/of_node for NULL is pretty common.=20
> Though often that's a legacy code path, so maybe not allowing NULL is=20
> fine for now.

Just to be clear on this, should I keep this as is, or return a result?
In the latter case, all the duplicated methods on `Device` that just
call `self.fwnode().same_method()` would have a result in their function
signatur as well. That includes `property_present`, `read_property`
and `children`.

>> +        }
>> +        // SAFETY: `fwnode_handle` is valid. Its lifetime is tied to `&=
self`. We
>> +        // return a reference instead of an `ARef<FwNode>` because `dev=
_fwnode()`
>> +        // doesn't increment the refcount.
>> +        unsafe { &*fwnode_handle.cast() }
>> +    }
>> +
>> +    /// Checks if property is present or not.
>> +    pub fn property_present(&self, name: &CStr) -> bool {
>> +        self.fwnode().property_present(name)
>> +    }
>> +}
>
> The C developer in me wants to put this after the FwNode stuff since=20
> this uses it.

Is that just a comment or a call to action? :-)

Remo

