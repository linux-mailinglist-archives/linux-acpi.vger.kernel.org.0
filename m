Return-Path: <linux-acpi+bounces-20648-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEYhD3OSeGmxrAEAu9opvQ
	(envelope-from <linux-acpi+bounces-20648-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 11:24:51 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B25E292BF5
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 11:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6545301CDA6
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 10:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AF133CEB9;
	Tue, 27 Jan 2026 10:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NO+b5c1u"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C99533CEA1;
	Tue, 27 Jan 2026 10:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769509316; cv=none; b=KoNrCg+Qt6Xtdg/DX7aYbZPKm4ANg+LRsJMahO+sUreo4AH/FIqvWNwF6+gwBX6Oa0Lgz48H6R5N7XbM4YNa205L3tJNOhqJJrYsyx3bv4tTsPd0WE5Jd9qh3Hyn6514nkMQz3SirOCUs9sIXk/bwOSpNuuY6fmLsXNMmbdDAU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769509316; c=relaxed/simple;
	bh=oeQyUukbQzjzfnGPsxMRYzzayN1/I685ZVpXUPWFnzE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=o2u+2+aMNm715Hx7or7aUIPDhaFw5x5CF3m0OPk8dc/W7WfQptoov+7REFCtQio2kCJqr3dgRoVMMgASUS9jE2e2GAboAP6wVJ819wEaFV5eql0DFx+PqRdV9ZZtCO3gJKMvGGf+xAprIGeGrB/ld4A2JajBBBWy+t9pjGts7eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NO+b5c1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85EBBC16AAE;
	Tue, 27 Jan 2026 10:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769509315;
	bh=oeQyUukbQzjzfnGPsxMRYzzayN1/I685ZVpXUPWFnzE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=NO+b5c1u8EKIdtzw+z36S75jauAQvOx3BGcOSwxiFDfQL6oUo86G3RJ/0BzStX+kv
	 NXC13wNnxKc+bqx8L4ptm4v8p3y6oOyibq9HETx8c05t3vVidd43dzpGp9kTzMTFWZ
	 Vuu0DQEOG0K74s+T+g1lUEXWh0B4dGNwSEALvgsWVFgGnZTHR+BfC/0IfjcazJMwax
	 sCvP4Ydz4lIvLSrYgKiwRLbogcAfomxkaqxMg/zlUUv0Q0pSE/5PldgZK+hQGNgc9Q
	 2qBtslN2gFttqpeQS7QvN5F1kq7Q+kFvjE/IpZHtRBkgXc+3Y/Lmxn7ori66HlMKxI
	 Au2kE15OPcEHg==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Jan 2026 11:21:50 +0100
Message-Id: <DFZAP6YM5JHD.3JB06NHLVZF9H@kernel.org>
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
 <DFYNFSOP2UVY.27KHATUQMCXHQ@kernel.org>
 <DFYNILJPAYJE.3CFM49W80ED4O@garyguo.net>
 <CAH5fLggAfRkjSmYuYAZioXn3OP31Fwr=VGd2znnaHQvPL3tKHg@mail.gmail.com>
In-Reply-To: <CAH5fLggAfRkjSmYuYAZioXn3OP31Fwr=VGd2znnaHQvPL3tKHg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20648-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,protonmail.com,umich.edu,linaro.org,collabora.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lossin@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B25E292BF5
X-Rspamd-Action: no action

On Mon Jan 26, 2026 at 5:14 PM CET, Alice Ryhl wrote:
> On Mon, Jan 26, 2026 at 5:11=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote=
:
>>
>> On Mon Jan 26, 2026 at 4:08 PM GMT, Benno Lossin wrote:
>> > On Mon Jan 26, 2026 at 2:25 PM CET, Alice Ryhl wrote:
>> >> On Mon, Jan 26, 2026 at 01:15:53PM +0000, Gary Guo wrote:
>> >>> On Mon Jan 26, 2026 at 1:05 PM GMT, Alice Ryhl wrote:
>> >>> > Currently, the Zeroable trait is defined by pin-init because pin-i=
nit
>> >>> > happens to use the trait. However, zeroed types are useful for man=
y
>> >>> > purposes other than pin-init. Also, we wish to implement Zeroable =
for
>> >>> > types generated by bindgen. For both of these reasons, re-export
>> >>> > Zeroable from the ffi crate, which is a already dependency of the =
crates
>> >>> > with bindgen output.
>> >>>
>> >>> I don't see a benefit of re-exporting these from the `ffi` crate? Es=
pecially
>> >>> that we re-export `ffi` crate from kernel crate anyway, and `Zeroabl=
e` is
>> >>> already in the kernel prelude.
>> >>>
>> >>> We already derive `Zeroable` for bindgen via `MaybeZeroable` derive =
in
>> >>> rust/bindgen_parameters.
>> >>
>> >> I can't find the convo now, but this change is on my list from when w=
e
>> >> discussed also implementing FromBytes / IntoBytes for the bindings
>> >> types. To do that, we need to move our FromBytes / IntoBytes traits
>> >> somewhere that bindings/uapi can access, and we agreed that the ffi
>> >> crate was a good place for it.
>> >>
>> >> And then for consistency, also reexport Zeroable from the same locati=
on.
>> >
>> > I think you also mentioned at some point that using `pin_init` from
>> > `bindings` seemed strange and also using the `pin_init::zeroed()`
>> > function also doesn't fit, since it doesn't have to do with pinned
>> > initialization.
>>
>> Shouldn't it be that a crate that implements Zeroable / FromBytes / Into=
Bytes
>> and then pin_init becoming an user of that crate, then?

I think that's a little bit too much effort just for "nice naming".

> The Zeroable trait has to be in pin-init because it's also outside the
> kernel. You *could* add yet another crate just for this and let
> pin-init depend on it, but just putting it in the existing ffi seems
> reasonable to me, and ffi is not a bad name for the owner of those
> traits anyway.
>
> Though I guess if we add zerocopy, that concern goes away.

Indeed, I would just move pin-init to that.

Cheers,
Benno

