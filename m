Return-Path: <linux-acpi+bounces-19370-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B633C97DB1
	for <lists+linux-acpi@lfdr.de>; Mon, 01 Dec 2025 15:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BC064343C96
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Dec 2025 14:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFCE316190;
	Mon,  1 Dec 2025 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBOAdvMn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0AF30DED1
	for <linux-acpi@vger.kernel.org>; Mon,  1 Dec 2025 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764599498; cv=none; b=sVPVZLAY59k04ZdNpWpPSoYkkRXVw+qy0yll+Y/5PA3W9uEMbbEyOGELcMV8fH84DdPPqY59txW51nnRZABNLqjLhfvA7B39AMrmE+eeFWp2ADaASi/gGT5IJCLQSyWF68/r1DUsYeeg/yYhGo5FA94pH5U4qihtcs/ZSYvxM00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764599498; c=relaxed/simple;
	bh=6IOGvsQ7JJkK9NqZyThSzk/We7JxrkgA07y82I7ci3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVWUxr5/HKNVFhj0z4PL8T2mruTbuVTnsX1GAqL1VXrADmEu8HjXLLbuI+s4aV2ms7dTqNGtR8KTRMddq5jh4U3YkmNJTRyV7QRqtXgIxEKT6u5OOqfdcRXxHxM4XDQD5bjYNa0v9XjU1x/1AF6iTffbV7mZQBGcIKpZOj414sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBOAdvMn; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-343ee44d89aso5895950a91.2
        for <linux-acpi@vger.kernel.org>; Mon, 01 Dec 2025 06:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764599496; x=1765204296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0g1S8qHX+DaR+1Bz/ZA/uLjK+Q+YLAA5K0tVpFYArqw=;
        b=gBOAdvMntHzOSQZnbjroaO+tlLK1Xj7I3vcRiREH5iVqDqFxZfb2pId184w4dI4A2O
         HIEe6kdrXHHvRsyctmK1RgaRtTf/RtXbskdUE+0CFfo6L978wNmVaLEmkW1ESyOCziH/
         qfPV1iL7EQ2TREKzTxb1Nfjxkv+z8TtU/D3djN83xkLC+a1GlyKkfdyZYnAhzl/L8zTu
         2/GesfETgSxVjUSJjzqNfPAD1CAPBLtv4Zx1GCa+lzJssANLlTSKpOYCwzzuH+eYfXSb
         OLltL4sjh2B5p09JDhzqVbQ0AdtTrMrk52WmfD38JtpMWkoIMd+f1+xlFnBzHVYd06GR
         TxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764599496; x=1765204296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0g1S8qHX+DaR+1Bz/ZA/uLjK+Q+YLAA5K0tVpFYArqw=;
        b=LdHYtCfiAXt1LeBRpDh4ZY0+ah15c1t1fmFmGt5aB1uZ+NP+C+eaVK0be5gJVgTmFS
         mYRdFjg0rqLkS5npKCVqn41vYT+6X6j2R7NLbhSZnfQSQaT7MvF7LU8cCfRxK5GMA/oH
         RkRP1cxiBopAcYDYUo6pGiGbWXsrc8/SdW1LNAkZVU3v2bJsc26I4SoLplYTANCiP1aJ
         x0p2j/+KeSSUfzR5SPcl2Fsq0mB6SdBGkKwMoUlvQpGjOMw+EiUnYSXntxUF5abDjKZ1
         cciJEukFYyvY0yOCTa1NQ6nxtX7OFXeJLBUeHzNDWfmVr8pqO/+1zsZ/8RGjk7nNeUdY
         AZ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlU1HByRpC3UYw6R4TfZFARg5rb+2/YorCOYVfjiTdgkPrQd1BDpxIMwjQRZkNYA3DxN0rTkU25lwF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Nt976kv4wfnpSuYV9H9M2EBx6jBZ6BS7lwjFMZREG24RRTzA
	NDljuSPoo9U+eMOadY7fB6wJh6G4JxWCcl82jyXnOPwZ6+kw+WvXhmRv
X-Gm-Gg: ASbGncujEPTRQLodfKLTvyGPFfqr/3PDIUsZT6L3yE4u/tt6UWLXl+h1YOw1eV5qMwx
	/DvLBFvPyLDGoXVSB7sL0Odah6l2MYn21O1ffk5Pv+WBdyztHSbWUqrpKAa8lGLP9oeAzdBMIR/
	8lLwPTBMaZgszXc+YLWLDwRkFgaoN7iOZpZBV7VWpiOVpdgNA/M7K1PglMJH99b8gIKgIV4eA85
	4oFt8XE+1qXOChF5beeCxIe2Bdq0HuA7lxuVyB7X6fCe1fZkksidd8bqFX8UqFAo7l17ivHM+Bz
	++kdTfsz6WieGSDm6B2UV87KNLrxvLMtomLpHI+62o7mN9YiNhcbAYsbe4iuRNgvVV955XLgblP
	3ou8+BNIUpD1vMHw8ApmfroifcG/AznItM7pmZa028wV8sQDPGqzw2nF75yEvK5Jh7NJavkVaia
	Jd8t3ZKPYBJdfzl7GK9SHQu/QQtLBCd5DNATKpULMrIuXH+gm0MRuFr7Ahh0BDkWl1HzPicYgj
X-Google-Smtp-Source: AGHT+IGvbF/byQknZb6N80Q9Lh4kdld+1bFxsz4P0/QJgof/Fo/fWclFfoLJXhcr6zXEd2KDjmKnkw==
X-Received: by 2002:a17:90b:2587:b0:32d:db5b:7636 with SMTP id 98e67ed59e1d1-34733f34e52mr40043250a91.27.1764599496039;
        Mon, 01 Dec 2025 06:31:36 -0800 (PST)
Received: from atharv-HP-Pavilion-x360-2-in-1-Laptop-14-ek1xxx ([103.216.213.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3476a560090sm17186239a91.7.2025.12.01.06.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 06:31:35 -0800 (PST)
Date: Mon, 1 Dec 2025 20:01:27 +0530
From: Atharv Dubey <atharvd440@gmail.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: rafael@kernel.org, lenb@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
	linux-acpi@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: acpi: replace manual zero-initialization with
 `pin_init::zeroed()`
Message-ID: <aS2mv2jEsTT4vK_W@atharv-HP-Pavilion-x360-2-in-1-Laptop-14-ek1xxx>
References: <20251129122753.23022-1-atharvd440@gmail.com>
 <DEMKDP6SAN8X.2W77GYK34BQX0@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DEMKDP6SAN8X.2W77GYK34BQX0@nvidia.com>

On Mon, Dec 01, 2025 at 12:36:22PM +0900, Alexandre Courbot wrote:
> On Sat Nov 29, 2025 at 9:27 PM JST, Atharv Dubey wrote:
> > Use `pin_init::zeroed()` instead of `core::mem::zeroed()` for initializing
> > `acpi_device_id`. This removes an explicit unsafe block and aligns ACPI
> > initialization with the pin-init conversion used across the Rust tree.
> >
> > Link: https://github.com/Rust-for-Linux/linux/issues/1189
> > Signed-off-by: Atharv Dubey <atharvd440@gmail.com>
> > ---
> >  rust/kernel/acpi.rs | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/rust/kernel/acpi.rs b/rust/kernel/acpi.rs
> > index 37e1161c1298..9b8efa623130 100644
> > --- a/rust/kernel/acpi.rs
> > +++ b/rust/kernel/acpi.rs
> > @@ -39,9 +39,7 @@ impl DeviceId {
> >      pub const fn new(id: &'static CStr) -> Self {
> >          let src = id.to_bytes_with_nul();
> >          build_assert!(src.len() <= Self::ACPI_ID_LEN, "ID exceeds 16 bytes");
> > -        // Replace with `bindings::acpi_device_id::default()` once stabilized for `const`.
> 
> Let's keep this comment as well.
> > Sure, will add the comment in V2 of the patch  
> > -Atharv

