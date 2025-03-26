Return-Path: <linux-acpi+bounces-12480-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08014A723DF
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 23:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 342247A61BB
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 22:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE463262801;
	Wed, 26 Mar 2025 22:24:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9572F2459DA;
	Wed, 26 Mar 2025 22:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743027841; cv=none; b=NYw5Hk4qjgFaojN8cUw81UhK4ukCd1mgDilojPtMGJ2R1g0nJTbIyRnuiXynLEQziu1tXh2FE2IEj28mjjQHjgsGZ1fYBpOVpzQUZVC/B2YJttRPhfXv1Ml156927KU7Q+MD+nsANQuRdBwsY7heYNRdVlOaXrCdDMZyqwDyp94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743027841; c=relaxed/simple;
	bh=qJpfcudIfTEKPy/BP/NKCYWCXuoKxYIj/l9xDbJEGqk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MfvDf9ss28+nWIIiig/9/+ofhiylny/0BzDXwQPF//JqPsfEd37zSp7ZA+XL6fCeZwVHcJ/p7fKZUVkISRBb7jhnYMtT5cKk/JPx22PMcv2XOah+z8EDvvxoWYuGUAZZsp+9Mb6ZA8tbqoGoUXVVCTmTo85hbV9aYUEUpepD7bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZNLt35MjQz9tj2;
	Wed, 26 Mar 2025 23:23:55 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Mar 2025 23:23:51 +0100
Message-Id: <D8QJSRGJIYHS.K4H9W8N8N0YO@buenzli.dev>
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
Subject: Re: [PATCH 10/10] samples: rust: platform: Add property read
 examples
From: "Remo Senekowitsch" <remo@buenzli.dev>
To: "Rob Herring" <robh@kernel.org>
References: <20250326171411.590681-1-remo@buenzli.dev>
 <20250326171411.590681-11-remo@buenzli.dev>
 <20250326220129.GD2844851-robh@kernel.org>
In-Reply-To: <20250326220129.GD2844851-robh@kernel.org>
X-Rspamd-Queue-Id: 4ZNLt35MjQz9tj2

On Wed Mar 26, 2025 at 11:01 PM CET, Rob Herring wrote:
>>
>> +        let prop =3D dev
>> +            .property_read::<bool>(c_str!("test,bool-prop"))
>> +            .required()?;
>
> The 'required' is kind of odd for boolean properties. They are never=20
> required as not present is the only way to to get false.

Agreed. I can think of a few alternatives:

* Make the trait `Property` more flexible to allow each implementor to spec=
ify
  what its output type for the `read` function is, via an associated type.
  I really don't like this idea, because overly generic APIs can mess with =
type
  inference and become less ergonomic because of it.

* Use `propert_present` instead. That doesn't perfectly express the intenti=
on,
  because it doesn't warn if the property is present but has a type other t=
han
  bool.

* Add an additional inherent method `property_read_bool`, which returns a p=
lain
  `bool` instead of `PropertyGuard<bool>`. Then there will be three slightl=
y
  different ways to read a bool: `property_present`, `property_read_bool` a=
nd
  `property_read::<bool>`. Maybe that's confusing.

* Add `property_read_bool` and remove `impl Property for bool`. That would =
avoid
  confusion between `property_read_bool` and `property_read::<bool>`, only =
the
  former would work.

