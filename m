Return-Path: <linux-acpi+bounces-14891-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1751AF05A4
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jul 2025 23:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A3C4482E4
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jul 2025 21:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FB3266576;
	Tue,  1 Jul 2025 21:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="Tqr4Y0So"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fabulous-taliesin.relay-egress.a.mail.umich.edu (relay-egress-host.us-east-2.a.mail.umich.edu [13.59.128.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC502222A6;
	Tue,  1 Jul 2025 21:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.59.128.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751405964; cv=none; b=HgXGra6Z9Jw2wJF82LWAuNSHkUNgYX7oRepJ0dZlcr6YpJOWstbfDVG/F3CceUtCZ6iK/gpMuL3qxQw0+u5qTG0K306QTRlE5IFTxz7EyM7N31sbUCo7fG4OFkVCcN5+6MIv/Y1d0SIXeVEX02Gl1IRWiIhOU9RQuR/Lon93pKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751405964; c=relaxed/simple;
	bh=FfRpsdCetCvTN4MvBRq2kYjiqRtFaR1ruWoUx1S7KfE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=uX11jmFvGigILdVwOR/Ih98yBxWHMhSIA9R2jqXGOsc4Wfk15x8cj/5LB+wvJ3ipnEykyeg1z1GG4vuzd+21Bc95TokZJQ6Z/if3acKXjPTSxmdWn8ix95A1YGGqzbyivWsqTZnkhr49SGMV1b62ECyKaMM3QqzGzd0VqYj3gSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=Tqr4Y0So; arc=none smtp.client-ip=13.59.128.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: from enriching-yacaruna.authn-relay.a.mail.umich.edu (ip-10-0-73-67.us-east-2.compute.internal [10.0.73.67])
	by fabulous-taliesin.relay-egress.a.mail.umich.edu with ESMTPS
	id 68645573.2994DE00.13D81883.132849;
	Tue, 01 Jul 2025 17:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umich.edu;
	s=relay-1; t=1751405937;
	bh=EoCFQ7P8Tnk+dsaPLBjGlDsJb2PcEiJqEGBMjg3BNJA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To;
	b=Tqr4Y0SoTUl3hjVtISApUUlSvtP0x0o8Q7gTb9EPBigNjeSAYteDfqIdKlbKDDnWC
	 hVm+wsmrlcn1Us/3D6z/iRMyZnzYslcRxSfRvXlln/hkKbBhxYhmbLKCtn5g473ZSR
	 HEuJmQxcMTTCpNO0ktclae25mAPJ8ui8HIcibKoyapT/iGkVjjuOo9J56Lv70kVlHz
	 +a2XCXpn7LEUcUk+2DzyblYtNAJxIEnFKbnMMoG/Y1XyKZYuf+zcPf67Oe32YCdZ/2
	 cBbMyHkcsMANYRqq+RHR2KiO48ISBDdK6yaZSkzfA1pI7GiKCTV0K4vuN/vnQUTbMI
	 jWvnRKklE2G/g==
Authentication-Results: enriching-yacaruna.authn-relay.a.mail.umich.edu; 
	iprev=fail policy.iprev=73.110.187.65 (Mismatch);
	auth=pass smtp.auth=tmgross
Received: from localhost (Mismatch [73.110.187.65])
	by enriching-yacaruna.authn-relay.a.mail.umich.edu with ESMTPSA
	id 68645571.4F66061.263F03BF.1065300;
	Tue, 01 Jul 2025 17:38:57 -0400
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Jul 2025 16:38:56 -0500
Message-Id: <DB11L7KWH27S.8L9WLRAR1B0P@umich.edu>
Cc: "Len Brown" <lenb@kernel.org>, <linux-acpi@vger.kernel.org>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH] rust: acpi: remove unneeded cast to clean future Clippy
 warning
From: "Trevor Gross" <tmgross@umich.edu>
To: "Miguel Ojeda" <ojeda@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Danilo Krummrich" <dakr@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250701174656.62205-1-ojeda@kernel.org>
In-Reply-To: <20250701174656.62205-1-ojeda@kernel.org>

On Tue Jul 1, 2025 at 12:46 PM CDT, Miguel Ojeda wrote:
> A future Clippy warning, `clippy::as_underscore`, is getting enabled in
> parallel in the rust-next tree:
>
>     error: using `as _` conversion
>       --> rust/kernel/acpi.rs:25:9
>        |
>     25 |         self.0.driver_data as _
>        |         ^^^^^^^^^^^^^^^^^^^^^^-
>        |                               |
>        |                               help: consider giving the type exp=
licitly: `usize`
>
> The type is already `ulong`, which nowadays is always `usize`, so the
> cast is unneeded. Thus remove it, which in turn will avoid the warning
> in the future.
>
> Other abstractions of device tables do not use a cast here either.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

