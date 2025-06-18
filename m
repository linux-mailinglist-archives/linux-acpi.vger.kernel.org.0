Return-Path: <linux-acpi+bounces-14447-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE738ADEEE7
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 16:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4B018919B3
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 14:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92312EAB87;
	Wed, 18 Jun 2025 14:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyitIBCx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999182EAB84;
	Wed, 18 Jun 2025 14:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750255917; cv=none; b=GJxPuZM9ggwunofMhRMkZaJtysjZeP/YW1n7wRcUGRmhjSoUNOhcPqCdhSpxFyVLT4rDbSEMOqI4S5acxBDPBGji4c/wJF6pX2+cDdy8JGh4N/SepZO8aYaj3LmSUKDUchGkosXZsTEPc6sn3+jkuMo/nagp4qb9ryhTyO89Bz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750255917; c=relaxed/simple;
	bh=Bet6JRUn7z4rozAlKAD0Ygp9Q/P5w1yOSt6l95tbCAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFZNznjny8JFgt9xKMuwI+RIx/9VU0OO+Pql1sfQExup6a4PUrW2k16A12ApG/k8r3YxPtNhjZzv+oMRiWN8bGDFxMTnm6Y3RBeKCeX/KlTXauhCQxivndjCBUcJI7K5jwk2+xd/LjoY/E2ICTKdvpfmVNYB6h7pkY0PrwGGoFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyitIBCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F91C4CEEE;
	Wed, 18 Jun 2025 14:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750255917;
	bh=Bet6JRUn7z4rozAlKAD0Ygp9Q/P5w1yOSt6l95tbCAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pyitIBCxFo0vRN21UH8bgt2jcjbMYocd7XDoxI0lXptJCYawUeVGY7iB2IinHTj7k
	 t2RSunhqSmf5MEUGCpAqMhsRaHjsoa43be2OA/yCQZeg3G7u8U9lFdzXc08eBYMWXW
	 lvxuW+6H/oDfmnIUlEo5hffNF0tJtN1w0IiYfMsheA1Ht2b2tuYpuK/3g2o714g4ZT
	 rZb7An3UIAlgIdFGV2Tb0TfKqr3mla57tei5fSQ/9TaToo5vI0rSiS7Q58SjYarE9b
	 hgeoDlFn0XpAeqB9qaXP98k0D1MrZMT/5F0SC5B1DvJ/XddfbxZfdQybsY5KiYqrG9
	 53elCJLgGFQ0g==
Date: Wed, 18 Jun 2025 16:11:50 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Igor Korotin <igor.korotin.linux@gmail.com>, ojeda@kernel.org,
	alex.gaynor@gmail.com, rafael@kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, lenb@kernel.org, wedsonaf@gmail.com,
	viresh.kumar@linaro.org, alex.hung@amd.com,
	dingxiangfei2009@gmail.com
Subject: Re: [PATCH v7 3/9] samples: rust: platform: conditionally call
 Self::properties_parse()
Message-ID: <aFLJJkeFfHR9GB-0@pollux>
References: <20250618100221.3047133-1-igor.korotin.linux@gmail.com>
 <20250618101325.3048187-1-igor.korotin.linux@gmail.com>
 <20250618131958.GA1550757-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618131958.GA1550757-robh@kernel.org>

On Wed, Jun 18, 2025 at 08:19:58AM -0500, Rob Herring wrote:
> On Wed, Jun 18, 2025 at 11:13:25AM +0100, Igor Korotin wrote:
> > From: Danilo Krummrich <dakr@kernel.org>
> > 
> > Only call Self::properties_parse() when the device is compatible with
> > "test,rust-device".
> > 
> > Once we add ACPI support, we don't want the ACPI device to fail probing
> > in Self::properties_parse().
> > 
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> 
> This needs your S-o-b as well since you sent the patch.
> 
> > ---
> >  samples/rust/rust_driver_platform.rs | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
> > index 000bb915af60..036dd0b899b0 100644
> > --- a/samples/rust/rust_driver_platform.rs
> > +++ b/samples/rust/rust_driver_platform.rs
> > @@ -40,7 +40,12 @@ fn probe(
> >              dev_info!(dev, "Probed with info: '{}'.\n", info.0);
> >          }
> >  
> > -        Self::properties_parse(dev)?;
> > +        if dev
> > +            .fwnode()
> > +            .is_some_and(|node| node.is_compatible(c_str!("test,rust-device")))
> 
> I think you should be checking just is this ACPI or DT rather than 
> compatible. It's kind of an anti-pattern to test compatible in probe. 
> The reason is we've already matched to a compatible and have match data 
> to use, so we don't need to do it again. It becomes quite messy when 
> there are numerous possible compatibles.

Yeah, that was my first approach; here's the patch from a few days ago [1].

The reason why I decided against this, was that all the properties we check in
Self::properties_parse() in a fallible way *only* apply to the device with this
compatible string.

But I don't mind if we replace it with [1] either.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/commit/?h=rust/is_of_node

