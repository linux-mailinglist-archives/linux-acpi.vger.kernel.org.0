Return-Path: <linux-acpi+bounces-14220-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2142AD11D1
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Jun 2025 12:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885CE168E01
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Jun 2025 10:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D7520E6F7;
	Sun,  8 Jun 2025 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cURS+zMN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D88213AA2F;
	Sun,  8 Jun 2025 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749379383; cv=none; b=B1iHIx3xKwQrdA9BM66x7V5UVp6/6U1aNUIcJIYF9hDKVw4Y/0y5lVFyJJMl5rMAkJzGt/yCwNUOT83oQvuigfqJYSLO2e70UzZph+/cOPHoWDe2tvAG6tHp4xVcdXkW+1XeqpJV7b1O/8eRgsYNPrwNyRUWlv2/qeVT8HQhuzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749379383; c=relaxed/simple;
	bh=IZis6emlWrEmjsjf57puJXxO84axvdnHEGFmX6HRIy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaP0X5eE2x++AFd/Bry6B1zYJtec/8JKdYeXCebcisa/92MkoMF011clMolGHrYNdVY6e3NI/ScVBtaHTq0z3aZJUhKlJHti5SgXoaNc41R4eCZdfxMyNDxwpaQ5uyJ+zuGsafECoyhJ+rgEouRqe9BSsBTziZAdmKlx0lEAKM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cURS+zMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5928FC4CEEE;
	Sun,  8 Jun 2025 10:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749379382;
	bh=IZis6emlWrEmjsjf57puJXxO84axvdnHEGFmX6HRIy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cURS+zMNjLbct3bzWrK4N2GY+KlYJXKu70Z6+PI8xwq05QpGS12Br/cmg4qcdi6m7
	 CISBBLfHo2T/Gy44OjZpALLQ1T5AZUjxUcH14w+BIfhl4mUkFy6dAuBy8i8LQR1vHF
	 SqqSpNXdn7Nd7MEXA0O0GFZSIJLd6v/Df3R18IMZXKCJZGdExg+VEaBuRo4U0ADVLQ
	 /kb6tgtS6FvRNFfqrLto5TEvLqe9mihF5Hi+dI4XdbuHYfHtPG1lg55RrIGWnqH8/f
	 XDbKZsxFAiLpV1Jq2NTDNrA7Vo03e/NCWsBvck8t9lpy//LGays3hYaDdRs8nFTtp4
	 FQxhNZrJs7E9g==
Date: Sun, 8 Jun 2025 12:42:55 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <lossin@kernel.org>
Cc: Igor Korotin <igor.korotin.linux@gmail.com>, ojeda@kernel.org,
	alex.gaynor@gmail.com, rafael@kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, lenb@kernel.org, wedsonaf@gmail.com,
	viresh.kumar@linaro.org, alex.hung@amd.com,
	dingxiangfei2009@gmail.com
Subject: Re: [PATCH v3 1/4] rust: acpi: add `acpi::DeviceId` abstraction
Message-ID: <aEVpL8wIfGDZRyUN@pollux>
References: <20250606170341.3880941-1-igor.korotin.linux@gmail.com>
 <20250606170641.3881401-1-igor.korotin.linux@gmail.com>
 <DAGZIHBVBI6Z.32401TQB5MNTL@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DAGZIHBVBI6Z.32401TQB5MNTL@kernel.org>

On Sun, Jun 08, 2025 at 09:48:00AM +0200, Benno Lossin wrote:
> On Fri Jun 6, 2025 at 7:06 PM CEST, Igor Korotin wrote:
> > +impl DeviceId {
> > +    const ACPI_ID_LEN: usize = 16;
> > +
> > +    /// Create a new device id from an ACPI 'id' string.
> > +    pub const fn new(id: &'static CStr) -> Self {
> > +        assert!(id.len() <= Self::ACPI_ID_LEN, "ID exceeds 16 bytes");
> > +        let src = id.as_bytes_with_nul();
> > +        // Replace with `bindings::acpi_device_id::default()` once stabilized for `const`.
> > +        // SAFETY: FFI type is valid to be zero-initialized.
> > +        let mut acpi: bindings::acpi_device_id = unsafe { core::mem::zeroed() };
> 
> This can be made safe using this series:
> 
>     https://lore.kernel.org/all/20250523145125.523275-1-lossin@kernel.org

Indeed, I did not mention this though since I think this series should not
depend on the one above. They'll land through different trees and the
improvement can still be made later on.

