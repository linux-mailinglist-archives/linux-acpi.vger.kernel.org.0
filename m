Return-Path: <linux-acpi+bounces-12749-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7167CA7BCA8
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 14:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31FB33B4FCB
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 12:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C194F1E1E1B;
	Fri,  4 Apr 2025 12:30:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5091F1EB5DA;
	Fri,  4 Apr 2025 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743769811; cv=none; b=fWXgeWURqcScdDz3YU7J4GTvchGtNTUvwhtFS8eMvMt/D7EoRtpPDJ3m5l+JvrpIrYZe/98NdKojRKZULH4/aKQmBg0zaeuDIaogqU8TJwgozDmXmTBaZXfzqcH3GlfH6gNJhA7vrW17W31MUX33XI0e8wlFJQdomDeyGdv+UJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743769811; c=relaxed/simple;
	bh=JeuacFG/T5IzwJvxG1MoFQp4VLhHpIBovq2dABSnT4Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=i2d6hGBLw65LDTos2czsqJjy1qaZoYghZywtvOMjy+uRRZ67e6tKoSMscQCF0caS5j9IUyWBMbB/UhO+oaKDAGEvXBjAzNOQOXY4/9b1M+TOk7G4w1KJ98SogOLbfOrG9LzynL0aXWJpPFCeYyzP/nx4Gx6vQYBw48zc8tRChCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZTdGh1m1wz9s3R;
	Fri,  4 Apr 2025 14:30:04 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Apr 2025 14:29:56 +0200
Message-Id: <D8XUSXKGAPBL.HFZUETKB6YQ1@buenzli.dev>
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
To: "Rob Herring" <robh@kernel.org>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>
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

Can you please elaborate on this concern?

The previous approach uses generics, which means the function is also
"copy-pasted" for each concrete type it is used with at compile time,
just like with a macro. So using a macro wouldn't be worse than generics
if binary size is the concern.

If the concern is about readability, I have managed to move all logic
outside the macro body, all that remains is the association between type
and `*_read_array` function.

Remo

