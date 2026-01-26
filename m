Return-Path: <linux-acpi+bounces-20628-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADroMriTd2n0iwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20628-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 17:18:00 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2548A944
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 17:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD2613031821
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 16:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57B62E0901;
	Mon, 26 Jan 2026 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="280F4xTc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7BF2C0F63
	for <linux-acpi@vger.kernel.org>; Mon, 26 Jan 2026 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769444098; cv=pass; b=m57b/VtZ5eaSczcu+TpVVKGcvIaiJS8N2zVftvXaFNpHxHc1r+Hc8piDIoOKUiVg4dBySp5Sjb1qaqoTAqqdxeiuG9LQHcFJN++kdhEoZX5GE3c8FGrZyTDxZEVD0fBQEXvKke2kWmi5yIjHJwF3PgEBQPAn0iQiOrRlCaF+I7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769444098; c=relaxed/simple;
	bh=b3m3/VVdwm1L5JwvxjexOIEy5wN31isjno52EUeePNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eu4jkSbkPBRf0bZIDYCeWCWKHXl0l/p76XZosAX+r6lifB+X3faA6qc80ERgAt4+ghj9B/FI3/UjJ1txBuvGyMg3o2/LEvenHhWRlh8QqniEaGYbw8ssEuAg8tnJDCMdrJPogF+ernG8ydC7mS+0eT1w2PYmw9kRQcCVJiSejQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=280F4xTc; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-432d2c96215so4169468f8f.3
        for <linux-acpi@vger.kernel.org>; Mon, 26 Jan 2026 08:14:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769444095; cv=none;
        d=google.com; s=arc-20240605;
        b=CPob9CMPWu2rwcw2Cu9R7anzjppeMu39BHFD6uSngiPxeeNxugq9GCds30o0yc1Dh0
         EV/r8oMrGfhFXaAbBCUf+A0+Q6voQunK+fHeuQeepib7VaVYB3EyF6mZ+sx5obp6osQ8
         jCL9yoFrUqkXF0ohiGtD2ZsnJ5dgqqT/HxyY2cW2YgKyGgrj0jHCYnLvWnYbeJ9cmY17
         5adYHjTTkZ8ZHjBIygtBQVkRpAePxsWE5nV8E/m4+1nHTEBhwgOkTd8fuF4ZNXbxJWfR
         UZVl6B12BJU5gPjUctKqwI0s6mbAxNP2TgkAZpphtZCh7XaU8o3hZOs9zit9W4sdUjQy
         WgxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b3m3/VVdwm1L5JwvxjexOIEy5wN31isjno52EUeePNw=;
        fh=g5XxLXAiid0V9QhBxrZHqLA9DmbwEP654Xp7lE5QUYo=;
        b=Ac1GUEM6UQZEXfeMiv2QHHJV8MNYilqBvJvzM1BMvjHXIuR+mLopbsC4JDvUT1UoMw
         SRh3TNA4M9N5gyiHrbvrbXQNKQSqWHGDFo07pJNOitFWfsM2kN+wGkt2Bl7eGq/WtOTE
         TU9Gjt0e+vADBKKfkqdFKsbl25JHJQGNdT5dADRvMuMzmmj9rcb9ASEZIqC+zgO2RZzB
         SHfqgO+meVjjhGsA7iEXSVvCJ0+wnVJQhQyR2PDaYPD1eHuwqzzMNEhn23FTJXzg1YFN
         UFuPWXrLd50Fot6/Pd0cSfLE4mgCIk8RC6ELEO+XqfExo+V1C7rfgTe49iLPcTOYksaS
         cbqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769444095; x=1770048895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3m3/VVdwm1L5JwvxjexOIEy5wN31isjno52EUeePNw=;
        b=280F4xTcTA5p7vg5B5/a3tkfZPvH27OboATow6174PXCIko+LqdKpnRfDP8XHBnAUe
         ArRkDkQB1pGbSc8tIMGhDbZWZyUw2bads/RiqeCEpgkQELOYoDdDEYVVlF97swjgQcYM
         iyDfImGYsVwTEsDdDplBx78x2U7PyZ6fmHemHUDjligMpvVATecJRJW0H5G4tuPF/O7r
         4H7mqfbxziXX56rlp1VkMWMGv/cbhiC5GQRZdwdacQFE0GXHx+psu0RRWLwWv3TVbjsJ
         b0GMKSE+mOs9F+xV48ThsTRbQNlZUxif5RrYPdXAjFCEFQ77ovtfJiY8VDZSBqslU2JZ
         D4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769444095; x=1770048895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b3m3/VVdwm1L5JwvxjexOIEy5wN31isjno52EUeePNw=;
        b=lDxQMr5uBP+xOxmKTuOhI618eK0vQ9dj9sxu8j2725dRTP9+MANhkxauA+E2DLDCGR
         4Tnw7jxs9j/7j/PLGZqAPXrcpfe0BvQsjMlmI3vEXERKL1RkhASOf3eBId8kuwA3txrH
         rA0wfMz19eEHYaGeUk+1AmiigLIvCtFaDzv3YDhAO1tX5xClH+/VGHarey2VnYEV/kSP
         v2FzbjOlQHUu2B3iiR8VqDAcRzTAJrlMN0C6S4eeAT2J/7qZyQkq1/yfnP8MmwdpXhgX
         h4+GXSyl5J5wNWnZtxpUgkVDqJ7dXOKA4mmkXnMID9H2DxM8w/G9/6lLntV8RD6mPofZ
         CI+g==
X-Forwarded-Encrypted: i=1; AJvYcCUN458nbwdvAPXeIiu6DwTH/VE/DnMJRbkng0i8z3kQplSzpJopD9Lfs+RY6O2KywSN0vTXXD/B1yT+@vger.kernel.org
X-Gm-Message-State: AOJu0YzeaRTEBtGZpYZN+hZxB/7TuI4aR6UCGg3jFIeYHaRWEfIJpVGS
	tjmsDOcbBmWy0BGJCL4Oc9IVAtmkDTB/vSlBkgdolxGH2shJrA091buSJJpnTE358uvcT5/7Ct7
	ExMWRSEF+z+D9sqa0N7wCjKKAP4zgEgeWu4/yUx+d
X-Gm-Gg: AZuq6aIf1k909YYG21+SalpUmOHldnwW9fekN5DCQk1qNkvATBDM2k2rgKvJerm18G4
	Mj7FcKzTudtys0Cxcs6rkoAz3fm+CMShkYmHPUK6W0UknG/bM9OeE0f69izwouvlJ4Sn28wO/fy
	wazDivfK6YmZEIlZoqQbrC9q+TcpBcMfYrkKFZub/Ys7dBnaTEBYezOmkA1AYd8w6X39PwrWjGH
	gyn8eU80kBFD7LbJGcsS63X80H5Nku/BYbrVkdp9YkBELSBvBopTynQfS5tgrDlheAvodnzMcut
	xCCVf3V32ziXSi9goq+INO2yUw==
X-Received: by 2002:a5d:5d0a:0:b0:42f:b690:6788 with SMTP id
 ffacd0b85a97d-435ca0e2909mr7711789f8f.10.1769444095193; Mon, 26 Jan 2026
 08:14:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126-zeroable-ffi-v1-0-0ef101d1ed85@google.com>
 <DFYJRWUHCOMQ.3L6ZVLOJTNDNO@garyguo.net> <aXdrUsrKVmzpBVd8@google.com>
 <DFYNFSOP2UVY.27KHATUQMCXHQ@kernel.org> <DFYNILJPAYJE.3CFM49W80ED4O@garyguo.net>
In-Reply-To: <DFYNILJPAYJE.3CFM49W80ED4O@garyguo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 26 Jan 2026 17:14:43 +0100
X-Gm-Features: AZwV_Qhm51ZvNtcAl24ity6Z1oGdEZsigYZ9qHzy-oChasQeMJ3ey0HJ1RLeuNE
Message-ID: <CAH5fLggAfRkjSmYuYAZioXn3OP31Fwr=VGd2znnaHQvPL3tKHg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Re-export Zeroable and zeroed() from ffi module
To: Gary Guo <gary@garyguo.net>
Cc: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Igor Korotin <igor.korotin.linux@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Len Brown <lenb@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20628-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,protonmail.com,umich.edu,linaro.org,collabora.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6F2548A944
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 5:11=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> On Mon Jan 26, 2026 at 4:08 PM GMT, Benno Lossin wrote:
> > On Mon Jan 26, 2026 at 2:25 PM CET, Alice Ryhl wrote:
> >> On Mon, Jan 26, 2026 at 01:15:53PM +0000, Gary Guo wrote:
> >>> On Mon Jan 26, 2026 at 1:05 PM GMT, Alice Ryhl wrote:
> >>> > Currently, the Zeroable trait is defined by pin-init because pin-in=
it
> >>> > happens to use the trait. However, zeroed types are useful for many
> >>> > purposes other than pin-init. Also, we wish to implement Zeroable f=
or
> >>> > types generated by bindgen. For both of these reasons, re-export
> >>> > Zeroable from the ffi crate, which is a already dependency of the c=
rates
> >>> > with bindgen output.
> >>>
> >>> I don't see a benefit of re-exporting these from the `ffi` crate? Esp=
ecially
> >>> that we re-export `ffi` crate from kernel crate anyway, and `Zeroable=
` is
> >>> already in the kernel prelude.
> >>>
> >>> We already derive `Zeroable` for bindgen via `MaybeZeroable` derive i=
n
> >>> rust/bindgen_parameters.
> >>
> >> I can't find the convo now, but this change is on my list from when we
> >> discussed also implementing FromBytes / IntoBytes for the bindings
> >> types. To do that, we need to move our FromBytes / IntoBytes traits
> >> somewhere that bindings/uapi can access, and we agreed that the ffi
> >> crate was a good place for it.
> >>
> >> And then for consistency, also reexport Zeroable from the same locatio=
n.
> >
> > I think you also mentioned at some point that using `pin_init` from
> > `bindings` seemed strange and also using the `pin_init::zeroed()`
> > function also doesn't fit, since it doesn't have to do with pinned
> > initialization.
>
> Shouldn't it be that a crate that implements Zeroable / FromBytes / IntoB=
ytes
> and then pin_init becoming an user of that crate, then?

The Zeroable trait has to be in pin-init because it's also outside the
kernel. You *could* add yet another crate just for this and let
pin-init depend on it, but just putting it in the existing ffi seems
reasonable to me, and ffi is not a bad name for the owner of those
traits anyway.

Though I guess if we add zerocopy, that concern goes away.

Alice

