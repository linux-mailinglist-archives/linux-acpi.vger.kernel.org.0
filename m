Return-Path: <linux-acpi+bounces-12699-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150D9A7A7B8
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 18:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4C03ABD1C
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 16:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF8F2512C0;
	Thu,  3 Apr 2025 16:16:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71594223708;
	Thu,  3 Apr 2025 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743696970; cv=none; b=OFB6viCPvsLc7+XbYe4b7Siq436HstrBiYrPXOpFLsHZuIhY1UQ7LOUTTw8k7MCCG9aehfIxkzDZaK0aTK78iwpMAeeneTu76qfy5ON7imRx7yuIAbMroMEi3JhHZWrwAJ3ps33Apfru6TZ67z1kNKQkHEA53pjBcLBDZAkV76c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743696970; c=relaxed/simple;
	bh=YQX6hMcqFE5B4/BvIPeiRSY8mEz58DbavCaIoez6WdY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=OWQn+K53ESpLqBgckxVlcr5a+9VDtB4RsmpcMQTgufmHmMrOjyMlfekdztdzEP6dviAHXQzextL92PQBaXSFGF20C1ZtCBpeIf+zVBLDCiYB5VNEUoWNIV0WOifeU8QyLHTrvOknKb78glLjPc3fhzrBOIkF15M6qX8KN1gXCpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZT6Kw2n2fz9sqZ;
	Thu,  3 Apr 2025 18:16:04 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Apr 2025 18:15:57 +0200
Message-Id: <D8X4ZFQUDX4O.2CUNGWJOG6U59@buenzli.dev>
To: "Rob Herring" <robh@kernel.org>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>
Cc: "Daniel Scally" <djrscally@gmail.com>, "Heikki Krogerus"
 <heikki.krogerus@linux.intel.com>, "Sakari Ailus"
 <sakari.ailus@linux.intel.com>, "Dirk Behme" <dirk.behme@de.bosch.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>, "Saravana
 Kannan" <saravanak@google.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 03/10] device property: Add
 fwnode_property_read_int_array()
From: "Remo Senekowitsch" <remo@buenzli.dev>
References: <20250326171411.590681-1-remo@buenzli.dev>
 <20250326171411.590681-4-remo@buenzli.dev>
 <Z-UPJyD41LOMM3o2@smile.fi.intel.com>
 <D8WA3WIHEQRN.3LQS84K8Z46OW@buenzli.dev>
 <Z-6NG7fSfyKH-vW_@smile.fi.intel.com>
 <CAL_JsqLPZc1LB09auMOJp90hbhJin75Yaa09h12ziZZgExSsBg@mail.gmail.com>
In-Reply-To: <CAL_JsqLPZc1LB09auMOJp90hbhJin75Yaa09h12ziZZgExSsBg@mail.gmail.com>

On Thu Apr 3, 2025 at 6:08 PM CEST, Rob Herring wrote:
> On Thu, Apr 3, 2025 at 8:29=E2=80=AFAM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>>
>> On Wed, Apr 02, 2025 at 06:04:13PM +0200, Remo Senekowitsch wrote:
>> > On Thu Mar 27, 2025 at 9:41 AM CET, Andy Shevchenko wrote:
>> > > On Wed, Mar 26, 2025 at 06:13:42PM +0100, Remo Senekowitsch wrote:
>> > >> The rust bindings for reading device properties has a single
>> > >> implementation supporting differing sizes of integers. The fwnode C=
 API
>> > >> already has a similar interface, but it is not exposed with the
>> > >> fwnode_property_ API. Add the fwnode_property_read_int_array() wrap=
per.
>>
>> ...
>>
>> > >> +EXPORT_SYMBOL_GPL(fwnode_property_read_int_array);
>> > >
>> > > I'm not sure about this. We have a lot of assumptions in the code th=
at the
>> > > arrays beneath are only represented by the selected number of intege=
r types.
>> > > This opens a Pandora's box, e.g., reading in u24, which is not suppo=
rted by
>> > > the upper layers..
>> > >
>> > >> +int fwnode_property_read_int_array(const struct fwnode_handle *fwn=
ode, const char *propname,
>> > >> +                             unsigned int elem_size, void *val, si=
ze_t nval);
>> >
>> > Here's an alternative approach using a macro to map each integer type =
explicitly
>> > to its corresponding read function. There are some additional changes =
that will
>> > be necessary to make the rest work, but this is the gist of it.
>>
>> I don;'t know Rust to tell anything about this, but at least it feels mu=
ch
>> better approach.
>
> I know a little Rust and it is much worse. It is implementing the same
> code 8 times instead of 1 time just to work-around the C API.

You mean it's worse because it will generate too much code during compile t=
ime?

Remo

