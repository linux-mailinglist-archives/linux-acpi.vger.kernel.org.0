Return-Path: <linux-acpi+bounces-20625-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKD7GfWRd2m9hgEAu9opvQ
	(envelope-from <linux-acpi+bounces-20625-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 17:10:29 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAF78A822
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 17:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0A40305B298
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 16:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734A52D7392;
	Mon, 26 Jan 2026 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qShnXFrg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DED92C21F4;
	Mon, 26 Jan 2026 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769443694; cv=none; b=lRgzqXL3op2eqMnBgduoee1kHv7omUFEGM3g0l4sbR+I+66vmlMgCqrirv1UypnGvzT3ub7TvkTxqXZC2RAHYFUZv02EyZualIFFBpP+tjEbAhxHojk1AIqfT39YRY9h1/39SsAPiI6Zc1L9akcfQiBSffl7pleFXP19F59rfqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769443694; c=relaxed/simple;
	bh=DJPEHkUN6UgUB1r4BLgEiTLjiWYowHcGQLkor332iqI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fkj3HyBlGh2LJHJL5cwsd4eoPhqa8KtdcOg6jWuckQ0OBN1FZvqSD+XcW9VZQx3pIqxgoIacZYuybdsgo9OgWj2lNo6BSkYhdXcm9tSjqi7yGwZcnmc5HZeD4+cHXsWFIehFZqFwUvjvohCcs6R7iPdCLHbovUJQAJNUoQ3B8MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qShnXFrg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669E2C116C6;
	Mon, 26 Jan 2026 16:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769443693;
	bh=DJPEHkUN6UgUB1r4BLgEiTLjiWYowHcGQLkor332iqI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=qShnXFrg0TvPEZt7un8gQqCSQCItLO3XgcKUUHzXvKevSDUZL8+SwVAZ9HwVcin7w
	 G126G/ynNtH/szewZkIap0sI9yD8qiq69GU9LG14ZWjJmRBPcE/BBK8N8Vt2WKtqMe
	 AK2hJpfpt2OzqYN7cgidiGaPi02Bckj2s2EUKXjRbp8vxtKqlVvE9AQAiZ2cAtF2gk
	 3gOGEhW3iAvb/+YIHUwrs3XbOw3Kb+znLwrEuI2y8jdcMAXkLkgad3x1wHUBLe1Imc
	 st7yegbE0LBcyo5yPODkHBfMn0TXgRdBb5bsj3bC7GwGM6ebmaj8tdXCi80iRazZjJ
	 j3YguAf6jHlXg==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Jan 2026 17:08:08 +0100
Message-Id: <DFYNFSOP2UVY.27KHATUQMCXHQ@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Igor
 Korotin" <igor.korotin.linux@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Len Brown" <lenb@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 0/4] Re-export Zeroable and zeroed() from ffi module
From: "Benno Lossin" <lossin@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260126-zeroable-ffi-v1-0-0ef101d1ed85@google.com>
 <DFYJRWUHCOMQ.3L6ZVLOJTNDNO@garyguo.net> <aXdrUsrKVmzpBVd8@google.com>
In-Reply-To: <aXdrUsrKVmzpBVd8@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20625-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,protonmail.com,umich.edu,linaro.org,collabora.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lossin@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0FAF78A822
X-Rspamd-Action: no action

On Mon Jan 26, 2026 at 2:25 PM CET, Alice Ryhl wrote:
> On Mon, Jan 26, 2026 at 01:15:53PM +0000, Gary Guo wrote:
>> On Mon Jan 26, 2026 at 1:05 PM GMT, Alice Ryhl wrote:
>> > Currently, the Zeroable trait is defined by pin-init because pin-init
>> > happens to use the trait. However, zeroed types are useful for many
>> > purposes other than pin-init. Also, we wish to implement Zeroable for
>> > types generated by bindgen. For both of these reasons, re-export
>> > Zeroable from the ffi crate, which is a already dependency of the crat=
es
>> > with bindgen output.
>>=20
>> I don't see a benefit of re-exporting these from the `ffi` crate? Especi=
ally
>> that we re-export `ffi` crate from kernel crate anyway, and `Zeroable` i=
s
>> already in the kernel prelude.
>>=20
>> We already derive `Zeroable` for bindgen via `MaybeZeroable` derive in
>> rust/bindgen_parameters.
>
> I can't find the convo now, but this change is on my list from when we
> discussed also implementing FromBytes / IntoBytes for the bindings
> types. To do that, we need to move our FromBytes / IntoBytes traits
> somewhere that bindings/uapi can access, and we agreed that the ffi
> crate was a good place for it.
>
> And then for consistency, also reexport Zeroable from the same location.

I think you also mentioned at some point that using `pin_init` from
`bindings` seemed strange and also using the `pin_init::zeroed()`
function also doesn't fit, since it doesn't have to do with pinned
initialization.

Cheers,
Benno

