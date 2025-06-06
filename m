Return-Path: <linux-acpi+bounces-14199-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7C3AD0529
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 17:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA668173B76
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 15:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6D12857D2;
	Fri,  6 Jun 2025 15:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="guReOcGA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DECF76026;
	Fri,  6 Jun 2025 15:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749223756; cv=none; b=kV7CwdrYui4L32ILgJsNq7iiQhbfPOgQYVk2vmU+MDuKCR0VwSifCmsVM6u5sq7FdFgi7mFUdHcnETASTbX2LWGSpaaodfyX7TrC/PBi9947MlOYLZDvim07X8F2XXyBOI2AxyIPvwUcMR+TD+f6Ya8/9+Mj76oXQr7n49mSAu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749223756; c=relaxed/simple;
	bh=YIkEnsYYTAgzRDQisXl/WSdMTrphUkF1HTvZcQOQYq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSjKn7uBC3oUquFROpB+OowDe9M+iG/yxn/rfhnlW9qp0skYKJUcEWV37VkkC11rcabmz8aWQ+N5qvl7x+pO3KibkHWn548ywagd6u5DPxJ50474zEpfJUj4v6mGlTUtXQGDuGytEN2PaHda8f7gBPndAZ91klIjHTOFreSUXGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=guReOcGA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48AEEC4CEEB;
	Fri,  6 Jun 2025 15:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749223755;
	bh=YIkEnsYYTAgzRDQisXl/WSdMTrphUkF1HTvZcQOQYq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=guReOcGAKKw4HD4jeerRrIFyOHMiXU0z9TIQs8uPkmlcV6Mgut3B7/Q3kNTr+TF4S
	 kOcLJaOeKevDftVnYiOhpJA3fk2Z/auvyc6219Qh9gVutrYzGPT1u4pInE8cHnQgW1
	 dt8yb3ZKfD9dpROfIMuPoH5MrCjn85IMM9DMcnt8=
Date: Fri, 6 Jun 2025 17:29:13 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Igor Korotin <igor.korotin.linux@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Igor Korotin <igor.korotin@yahoo.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Hung <alex.hung@amd.com>, Tamir Duberstein <tamird@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Xiangfei Ding <dingxiangfei2009@gmail.com>
Subject: Re: [PATCH v2 3/5] rust: driver: Add ACPI id table support to
 Adapter trait
Message-ID: <2025060635-unleveled-drowsily-a192@gregkh>
References: <20250605161956.3658374-1-igor.korotin.linux@gmail.com>
 <20250605162726.3659792-1-igor.korotin@yahoo.com>
 <aELyEqg0GrkC8oZY@pollux>
 <CAG7QV91AWpOk7VUcE-B1MLkEQPDB0Y=zsBOBf6MhHVYh1aEGQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG7QV91AWpOk7VUcE-B1MLkEQPDB0Y=zsBOBf6MhHVYh1aEGQA@mail.gmail.com>

On Fri, Jun 06, 2025 at 03:26:13PM +0100, Igor Korotin wrote:
> On Fri, Jun 6, 2025 at 2:50 PM Danilo Krummrich <dakr@kernel.org> wrote:
> > However, I don't understand why we need this and the subsequent
> > is_acpi_device_node() and is_of_node() checks.
> 
> The idea is to avoid unnecessary table lookups when both OF and ACPI
> match tables are present. If we already know the fwnode type, these
> simple pointer comparisons (is_acpi_device_node() / is_of_node()) let
> us skip the irrelevant match function.
> 
> Those checks are cheap (just pointer comparisons), while
> acpi_match_device() and of_match_device() iterate over tables.
> 
> So yeah, it’s a bit ugly, but it can save some CPU cycles during enumeration.

You have loads of CPU cycles during enumeration, keep things simple
first, only attempt to optimize things later on if it is actually
measureable.

thanks,

greg k-h

