Return-Path: <linux-acpi+bounces-14470-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCDFAE0C32
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jun 2025 19:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B8DD7A4E57
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jun 2025 17:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A22A28CF71;
	Thu, 19 Jun 2025 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4JQ0XEw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3195519D8BE;
	Thu, 19 Jun 2025 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750355969; cv=none; b=hQMmZ4UK+ePj6Ng4d0foxPL3wFPuwG3h4/c85otiXrLXAb104dAaLB2WK1AgIGV1vlxbraq5dCeophPEVXllfFwVw10QoRtjdHv7v3NSTK/Qu4JuPbj2ht6zv1VHpKT1MrTK/i8GBAkXvTpeNOHPYhBrBU4WKNIMcRhbucFQ7J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750355969; c=relaxed/simple;
	bh=d58puvBfc5wuZvpZedp1Wh9cQYVuL5NmGhl8ie1qK+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcndU8VlRnFK5Y2X3D1sXZYPb20szZbFixIYxSRyel8hyosE7HpV8xDQvNckroiLzpBB/IySboFmy3JA142iyauU4a6BtgbGT4J3wqKY81Q0OFihH+sgCpA0dRLQtL6SUfH3J8YGqhOJbV63hbuhC6qXVqrFQEVyHIldodEb5yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4JQ0XEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D627C4CEEA;
	Thu, 19 Jun 2025 17:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750355968;
	bh=d58puvBfc5wuZvpZedp1Wh9cQYVuL5NmGhl8ie1qK+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i4JQ0XEwdQ0RQTKhT67jP1Lb/RKD1KrfDMR2taXEOlHxCjr0qGbkC2E0twFaVtPqd
	 PfPSntVaxXlkxwK4gDfxNjkfvREpWXG59UoAaOPFmf89kkn0QVJWCJm3Wchwks1IxC
	 49izVI9Exx+Zs9q7eF8Lkeq/0Ku5NJpuUq8Tm+f8Q4VMqWZ3gXVggebJTSiFk2mChg
	 9kG51CuHuO2GvnTV6xoDe+24AaA1ri1O+RBBYbKiFR1v7TyP63A1Sse8VSgjC9uunY
	 dLSk52vqZyWY62V98Kl7S5oJvA1C8fBcsCqljAPnMTzPDL2iHXI18Krgi7tWf9i5oB
	 AxB3G+cUJtOJA==
Date: Thu, 19 Jun 2025 19:59:22 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Igor Korotin <igor.korotin.linux@gmail.com>
Cc: ojeda@kernel.org, Rob Herring <robh@kernel.org>, alex.gaynor@gmail.com,
	rafael@kernel.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-acpi@vger.kernel.org, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	lenb@kernel.org, wedsonaf@gmail.com, viresh.kumar@linaro.org,
	alex.hung@amd.com, dingxiangfei2009@gmail.com
Subject: Re: [PATCH v7 3/9] samples: rust: platform: conditionally call
 Self::properties_parse()
Message-ID: <aFRP-vGMoZNmQZ2E@pollux>
References: <20250618100221.3047133-1-igor.korotin.linux@gmail.com>
 <20250618101325.3048187-1-igor.korotin.linux@gmail.com>
 <20250618131958.GA1550757-robh@kernel.org>
 <aFLJJkeFfHR9GB-0@pollux>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFLJJkeFfHR9GB-0@pollux>

On Wed, Jun 18, 2025 at 04:11:57PM +0200, Danilo Krummrich wrote:
> On Wed, Jun 18, 2025 at 08:19:58AM -0500, Rob Herring wrote:
> > On Wed, Jun 18, 2025 at 11:13:25AM +0100, Igor Korotin wrote:
> > > From: Danilo Krummrich <dakr@kernel.org>
> > > 
> > > Only call Self::properties_parse() when the device is compatible with
> > > "test,rust-device".
> > > 
> > > Once we add ACPI support, we don't want the ACPI device to fail probing
> > > in Self::properties_parse().
> > > 
> > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > 
> > This needs your S-o-b as well since you sent the patch.
> > 
> > > ---
> > >  samples/rust/rust_driver_platform.rs | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
> > > index 000bb915af60..036dd0b899b0 100644
> > > --- a/samples/rust/rust_driver_platform.rs
> > > +++ b/samples/rust/rust_driver_platform.rs
> > > @@ -40,7 +40,12 @@ fn probe(
> > >              dev_info!(dev, "Probed with info: '{}'.\n", info.0);
> > >          }
> > >  
> > > -        Self::properties_parse(dev)?;
> > > +        if dev
> > > +            .fwnode()
> > > +            .is_some_and(|node| node.is_compatible(c_str!("test,rust-device")))
> > 
> > I think you should be checking just is this ACPI or DT rather than 
> > compatible. It's kind of an anti-pattern to test compatible in probe. 
> > The reason is we've already matched to a compatible and have match data 
> > to use, so we don't need to do it again. It becomes quite messy when 
> > there are numerous possible compatibles.
> 
> Yeah, that was my first approach; here's the patch from a few days ago [1].
> 
> The reason why I decided against this, was that all the properties we check in
> Self::properties_parse() in a fallible way *only* apply to the device with this
> compatible string.
> 
> But I don't mind if we replace it with [1] either.

As mentioned, I don't mind either, so let's change it up.

@Igor, can you please pick up the patch in [1] and at the same time drop the
patch introducing FwNode::is_compatible() and replace node.is_compatible() with
node.is_of_node() in this one?

Please also remember to add your SoB to the patches not authored by yourself.

Thanks,
Danilo

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/commit/?h=rust/is_of_node

