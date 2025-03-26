Return-Path: <linux-acpi+bounces-12477-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A34DA720F4
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 22:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B40C77A3FB4
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 21:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701F6217730;
	Wed, 26 Mar 2025 21:45:59 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8942AD02;
	Wed, 26 Mar 2025 21:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743025559; cv=none; b=EQO84UcRHUOt8ihS15lGHPy4dRzl5t8nMXawXARZtxPbX8LT+X6QLKOhfhIYJ6b/8s2FRm0QU3JsVNG73gyMM0nTI6nj/rr88jPe3IADwX1sQf8wi/0ShBaiiQ5YjQoj4SKuh6QeQllKyPFPto4XKjfwBD4Tkz3cup9JZd1eYX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743025559; c=relaxed/simple;
	bh=j25v/qjjP3KBffQSnhKDwsAfPrQGIRAAQTXdb3BOQQE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ffrnSpPNhCFnyjy43uOdCcgb3ilwFnz26vHVezkl4jIipn5dOf7piTMpdruBUtUy2c9zO59qEVVENTmkVzWG/+GKf9ae67XziMY2e4dtgmoYmWPy2q2sblDR3ObQ+L6jufUlmK/5Tkpz2qF5+D9R/lVvL11pBPIg7Nj0dBf2Ieo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ZNL2925bGz9t8B;
	Wed, 26 Mar 2025 22:45:53 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Mar 2025 22:45:48 +0100
Message-Id: <D8QIZMNSUBM7.1TEVU3UW4C305@buenzli.dev>
Cc: <a.hindborg@kernel.org>, <alex.gaynor@gmail.com>,
 <aliceryhl@google.com>, <andriy.shevchenko@linux.intel.com>,
 <benno.lossin@proton.me>, <bjorn3_gh@protonmail.com>,
 <boqun.feng@gmail.com>, <dakr@kernel.org>, <devicetree@vger.kernel.org>,
 <dirk.behme@de.bosch.com>, <djrscally@gmail.com>, <gary@garyguo.net>,
 <gregkh@linuxfoundation.org>, <heikki.krogerus@linux.intel.com>,
 <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <ojeda@kernel.org>, <rafael@kernel.org>, <robh@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <sakari.ailus@linux.intel.com>,
 <saravanak@google.com>, <tmgross@umich.edu>
Subject: Re: [PATCH 08/10] rust: property: Add property_get_reference_args
From: "Remo Senekowitsch" <remo@buenzli.dev>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Andrew Ballance"
 <andrewjballance@gmail.com>
References: <20250326171411.590681-9-remo@buenzli.dev>
 <20250326210735.696416-1-andrewjballance@gmail.com>
 <CANiq72nP3EEYH6cdZRj2S9XZUYyi=RyyQARypGCFj3ULEB=+fQ@mail.gmail.com>
In-Reply-To: <CANiq72nP3EEYH6cdZRj2S9XZUYyi=RyyQARypGCFj3ULEB=+fQ@mail.gmail.com>
X-Rspamd-Queue-Id: 4ZNL2925bGz9t8B

On Wed Mar 26, 2025 at 10:25 PM CET, Miguel Ojeda wrote:
>
> Remo: did you build with `CLIPPY=3D1`?

I didn't! Usually I have rust-analyzer configured with clippy, but that doe=
sn't seem to work here.
I added it to my build scripts and can see the warnings now, future patches=
 should be free of clippy warnings.

Thanks for the tip!

Remo

