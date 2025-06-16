Return-Path: <linux-acpi+bounces-14402-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA29EADBA80
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Jun 2025 22:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0013AE260
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Jun 2025 20:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46671E102D;
	Mon, 16 Jun 2025 20:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJtVAMvs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B806D19DF7A;
	Mon, 16 Jun 2025 20:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750104230; cv=none; b=TuhFo1wAIWDlpZVYOKBGqeiahzTb9DltAppDtV5PRNpluL9+OT4kG4sm4j/CP1VkvrOBcmmbTHahcKOppM8S7hUnE3moS9mdbxCUNqKfBKU+9gN6D6b3PuchMTwa4ZDvoM+Hhvkkakgf0J05dprTRndwI+1XtU3wxmFTnbOPAoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750104230; c=relaxed/simple;
	bh=JGrS1c9ZdMeBoubO6dQIr+rlJWSwYE9f3Ait9kKN8dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNsmx7bl5krOHSbRRdfDXVpz8pNC9eJB2GmceZOfPbQVXitAKA2cf8mXlEjj4L0/te4A5L2VCU+PRnL48kMjR9E18IIGTqmskxAz+pNobOTUFcBR01PRAGqLGEjtY92Rkagky8bA3AwXS3n1zpaIlyE9UwynRuGXiPbcku2TWbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJtVAMvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D5FC4CEEA;
	Mon, 16 Jun 2025 20:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750104230;
	bh=JGrS1c9ZdMeBoubO6dQIr+rlJWSwYE9f3Ait9kKN8dE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bJtVAMvsJUl0P4ra2MFaqGVdnZ9utODvPyoEd9oF1U4KupAs+4q1FaM+ZbI7BgBwq
	 AQ75D0hO7PUMk3GqWagTlVNsGhUdENwZl3Wve7tcHz1g8Dc/RWAGC7W8LPLAhgb7aT
	 WwYHCa7r6/C+KZGCO7To73OrmBTxCyyvSpN2er+wxuY7uskytRJ16iULtAo2g0YNot
	 Mklcb8sjcIgz5RHoDEJm4Ro6KFpT9b42UvPNG0leqbg3klSqxSyDeASy+6d1H8KJBa
	 jj0Jf2yYxovMZDMNxJ472UNnGWs2qJvPlIAAbTpeXiHIWS/0+Z0tQ7STGRD3N0OfY9
	 iujzIqjMeTg9Q==
Date: Mon, 16 Jun 2025 22:03:43 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Igor Korotin <igor.korotin.linux@gmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, rafael@kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, lenb@kernel.org, wedsonaf@gmail.com,
	viresh.kumar@linaro.org, alex.hung@amd.com,
	dingxiangfei2009@gmail.com
Subject: Re: [PATCH v6 1/6] rust: acpi: add `acpi::DeviceId` abstraction
Message-ID: <aFB4n-0_gTc3CAf4@pollux>
References: <20250613133517.1229722-1-igor.korotin.linux@gmail.com>
 <20250613133842.1230254-1-igor.korotin.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613133842.1230254-1-igor.korotin.linux@gmail.com>

On Fri, Jun 13, 2025 at 02:38:42PM +0100, Igor Korotin wrote:
> +impl DeviceId {
> +    const ACPI_ID_LEN: usize = 16;
> +
> +    /// Create a new device id from an ACPI 'id' string.
> +    pub const fn new(id: &'static CStr) -> Self {
> +        assert!(id.len() <= Self::ACPI_ID_LEN, "ID exceeds 16 bytes");

Please use build_assert!() for this check.

> +        let src = id.as_bytes_with_nul();
> +        // Replace with `bindings::acpi_device_id::default()` once stabilized for `const`.
> +        // SAFETY: FFI type is valid to be zero-initialized.
> +        let mut acpi: bindings::acpi_device_id = unsafe { core::mem::zeroed() };
> +        let mut i = 0;
> +        while i < src.len() {
> +            acpi.id[i] = src[i];
> +            i += 1;
> +        }
> +
> +        Self(acpi)
> +    }
> +}

