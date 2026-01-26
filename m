Return-Path: <linux-acpi+bounces-20621-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJkGI69rd2nCfQEAu9opvQ
	(envelope-from <linux-acpi+bounces-20621-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 14:27:11 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3390F88D01
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 14:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D2393014C19
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 13:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95133385B3;
	Mon, 26 Jan 2026 13:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RMivWN4u"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADFF3385A1
	for <linux-acpi@vger.kernel.org>; Mon, 26 Jan 2026 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769433942; cv=none; b=cej8vTpXZj7SF6Zk+iqtVK0T4JyAqPba9Ok6ai4wvQ4LJGKcmWLOk4qlHolChvoqjf6HYpTmppp9ZYBpYEn85oUFdYx6Njc7MLD5od/LJ63A9cXAwykR8SZvfa2Cs6Tgfk47NKOy+4h0vp0FE6cFCOhWehUIoA0uX5V09cYue1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769433942; c=relaxed/simple;
	bh=DdCD88aF50DYmnQ9IOnsuZ7DFtissFn0ullB3REUWGo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JgC5aShsqNhMBshFr2r8WzIW4yU56kHIOCqyVr91OwsC2YbVnla7QiM9mPZcWoZph3qJI079v6opUS7Zi/HUVH4c1UDtb91tgoNS9DXL2ys5/RMQs2ldVqSBVUmxTeUbBUBhpG3vTO74JROYVaUF7GELpnTkxYEW/m4/m34gydk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RMivWN4u; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47d5c7a2f54so54982515e9.1
        for <linux-acpi@vger.kernel.org>; Mon, 26 Jan 2026 05:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769433939; x=1770038739; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PjqOOfPtPNNn9huhvOjZdrj5YH3GjxWGXVwA30fCwBk=;
        b=RMivWN4uN4XKja5WJ/AFgl6L1Z7Y9gSR7DjGBMGpNPGKIYXGvx9la1/Za7uWj4zFFl
         CSo2L1upGvhqzHKz2iXBLS0EdVj+NA/JBwKMoa3aUzwZgffyfIMrg8BWsN9394GGe54J
         SP17myoKzfio8jfUVuR7V/g/4mg3zBIKVKbzE8EeK75GsC6ip5i8fV2id4duGTPpvBuD
         5wS9kBHYwHJ6lfgU7ajOGJvAUhD4znS6t2nAHc5WUwc9dP96G2Qkc8IfwAlPw/z6uwO1
         DZjyBuJl4iLd1yeuT7SuPp2eyB4geskC7qEbzseCFQjmQbwXxjmUdJb7F5qD8Rf7yrMd
         TNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769433939; x=1770038739;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PjqOOfPtPNNn9huhvOjZdrj5YH3GjxWGXVwA30fCwBk=;
        b=MuzyeZQFhnGej22XJ/HMokVgtfM5oEoFvF3vvqkFrcMZAuS7ai3lDwNJip/UHfqdxr
         6wVbavyW8ap6hK4qM5gFEXZlyYgOrfCsvMOcjVrxzvbr+E64HlTrAJHLP2joqqEP0IfJ
         cq5SH21nFNG2MjVQvFXbiXw6GnKfL6uQv7avwfZ2SibFfwTfR4sN/VhZXTLwXi3E8zgz
         7b/cT3k4P7vEaCOOptC+877csfGWlbPsG5tz6XcmqqAzbmjqEPVffNclZSTV0/ZKEVYP
         oK0yEa65VmbXgqRWPwGIMnWaBswG+MV1L+vrw9i23kMulCERToetEpukPjHAq4zop9nc
         jizQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0bW4AuwuV/pxuOHvUVcPiFxIBA9U7jl91QgDwcyWTp6xqT3uZl2R+w8840IYChtugmzSX5Bkx/YSt@vger.kernel.org
X-Gm-Message-State: AOJu0YzmGjHpOsVO5T/0uy/jUGzHOuSmoTVlKkRsXUNgb9vBb10Ora47
	8iLk8NBlF7nF/kxuOOIplo4CETSaSUyy8y4O64KIyx+7rp2rEW8i/sKXxqsqD2h282aCLNK6OGn
	rHyqLxve5s35wsG/jlA==
X-Received: from wmej18.prod.google.com ([2002:a05:600c:42d2:b0:477:a43b:b532])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e0d:b0:475:d9de:952e with SMTP id 5b1f17b1804b1-4805ce52302mr70480645e9.1.1769433939572;
 Mon, 26 Jan 2026 05:25:39 -0800 (PST)
Date: Mon, 26 Jan 2026 13:25:38 +0000
In-Reply-To: <DFYJRWUHCOMQ.3L6ZVLOJTNDNO@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126-zeroable-ffi-v1-0-0ef101d1ed85@google.com> <DFYJRWUHCOMQ.3L6ZVLOJTNDNO@garyguo.net>
Message-ID: <aXdrUsrKVmzpBVd8@google.com>
Subject: Re: [PATCH 0/4] Re-export Zeroable and zeroed() from ffi module
From: Alice Ryhl <aliceryhl@google.com>
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Igor Korotin <igor.korotin.linux@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Len Brown <lenb@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20621-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,protonmail.com,umich.edu,linaro.org,collabora.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3390F88D01
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 01:15:53PM +0000, Gary Guo wrote:
> On Mon Jan 26, 2026 at 1:05 PM GMT, Alice Ryhl wrote:
> > Currently, the Zeroable trait is defined by pin-init because pin-init
> > happens to use the trait. However, zeroed types are useful for many
> > purposes other than pin-init. Also, we wish to implement Zeroable for
> > types generated by bindgen. For both of these reasons, re-export
> > Zeroable from the ffi crate, which is a already dependency of the crates
> > with bindgen output.
> 
> I don't see a benefit of re-exporting these from the `ffi` crate? Especially
> that we re-export `ffi` crate from kernel crate anyway, and `Zeroable` is
> already in the kernel prelude.
> 
> We already derive `Zeroable` for bindgen via `MaybeZeroable` derive in
> rust/bindgen_parameters.

I can't find the convo now, but this change is on my list from when we
discussed also implementing FromBytes / IntoBytes for the bindings
types. To do that, we need to move our FromBytes / IntoBytes traits
somewhere that bindings/uapi can access, and we agreed that the ffi
crate was a good place for it.

And then for consistency, also reexport Zeroable from the same location.

Alice

