Return-Path: <linux-acpi+bounces-14585-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF12AAE7D7A
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 11:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96647163F71
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 09:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03D52D5C8F;
	Wed, 25 Jun 2025 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHsgY6qT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ADB288CB7;
	Wed, 25 Jun 2025 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843643; cv=none; b=oX25Q68QkrH2vetMPhjmOABA2JRAFtvMoivtx/mR79yUEdb2KIN7o3DXOzWgiHoX9EqMjPJVDnv/8XiHFQD/rS50fbywUoYlTPeYln/2pNzhwD0VoNihKPNu+wHnK79HjBu04U+AlAYKTWfDZQZlYz/+7nzL43FQaYr4jP8bfRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843643; c=relaxed/simple;
	bh=LpJpTA8+a1zc/RJHeusoxiRPSfqQxKO4gM6yc+uiJt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6A4KjGAhkF/Yg1UgcUB2xVksZxRML85RNd/6Rf2NXnCOiT+lp3rNcGh3BDHB0CvGnRBCurWaBvbRGtaTZQ16PCEEkq+bMLAocSyxAs3LAwcY1VzYJ36aYGrUZefcc0jKJEotOrU0LDuntekzpW97PVjDcafaEJTwVTqPyc8jWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHsgY6qT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D6FC4CEEA;
	Wed, 25 Jun 2025 09:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750843643;
	bh=LpJpTA8+a1zc/RJHeusoxiRPSfqQxKO4gM6yc+uiJt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sHsgY6qTVa/7MiXn+Shg9Mg26XDKt2B9ZBkdvu7bfcRDPcml6L5K4SDHqchJDnXC5
	 5+R9npyhTG8xXtte+zb0v1pgFjNYIMRkcPRnLStskdgiGLflPjQogucD2gxLRjuWGD
	 uMUo+jjr14KNLUCVfnxzPbt6zEcE63Eb49AIs6ZGj5HCcxkZwvHP4PuyU/Xb0wkymi
	 FaMbXW67PBlzbS7EKiqe2qLOkTmiuD8x3S6I3vGH98MNv3ILg2q93KAIgLTqHqLTRu
	 j6AzAIK3wRWBxtdufCCUueo3Dpa2H1d7LND6myB/jnNtmEhXTDcBufw2mzjXnmQ3Cw
	 l0Y7slShLruwg==
Date: Wed, 25 Jun 2025 11:27:16 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Igor Korotin <igor.korotin.linux@gmail.com>, ojeda@kernel.org,
	alex.gaynor@gmail.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-acpi@vger.kernel.org, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	lenb@kernel.org, wedsonaf@gmail.com, viresh.kumar@linaro.org,
	alex.hung@amd.com, dingxiangfei2009@gmail.com
Subject: Re: [PATCH v6 6/6] samples: rust: add ACPI match table example to
 platform driver
Message-ID: <aFvA9LVmStikbBF7@cassiopeiae>
References: <20250613133517.1229722-1-igor.korotin.linux@gmail.com>
 <20250613135407.1233005-1-igor.korotin.linux@gmail.com>
 <aFB2FZEFcXUsW8lN@pollux>
 <f29b4eba-bd79-4f74-940c-8cff65495ae0@gmail.com>
 <aFGisAm-n6Mt70Hd@pollux>
 <CAJZ5v0hBG-ccWdhiKtcasAVOph+===AZoOroznf2k5OG0BOnkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hBG-ccWdhiKtcasAVOph+===AZoOroznf2k5OG0BOnkg@mail.gmail.com>

On Wed, Jun 25, 2025 at 11:17:33AM +0200, Rafael J. Wysocki wrote:
> On Tue, Jun 17, 2025 at 7:15 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On Tue, Jun 17, 2025 at 05:39:07PM +0100, Igor Korotin wrote:
> > > I could suggest on of the following:
> > > DRV0001
> > > DRVR0001
> > > PDRV0001
> >
> > This one looks reasonable to me.
> >
> > > TEST0001
> > > TST0001
> 
> Can we please avoid using made up device IDs in the code, even if it
> is just sample code?
> 
> It is way better to use a real one that's been reserved already as
> "never use in real ACPI tables" for some reason.  I think I can find a
> few of these for you if need be.
> 
> Thanks!

Sure! Please let me know which one you think fits best and I'll use it instead
of "TST0001" when I apply the series.

- Danilo

