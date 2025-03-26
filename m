Return-Path: <linux-acpi+bounces-12482-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE8FA7259D
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 23:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22D6E188E58E
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 22:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6048E263F20;
	Wed, 26 Mar 2025 22:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvHzBxHm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBBD1F55FB;
	Wed, 26 Mar 2025 22:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743028894; cv=none; b=JFs2lfS/2aKrLn6DzykUFuzXRz84vXsayqjLxmqddbnl6dwtDe6mqveSxyqPmjU2vhS/38dkLQ8UKD53/UskLMFTjEr40c0m4bINIezVfePDJ1EpNGJRbZN3q9yQ3gDntTeK+MV41QD3/P9K7XEojenzk4Cfk62+oYowrTcujTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743028894; c=relaxed/simple;
	bh=lqViN5Eu7Ch/V4e0CAlSLoRL5PM7JT6zJCd7tWfuf80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkGreby/UYhZZq6Ahm4MEEVB6ugeNwEjZ6OQu5MUeJDRF3gU2c+HqRGBcugeGCM8VMxNMR/krXOmISM/kf1UBvCeVBcmoKyL3rkWrCCKiG29laaYm/ElB0ncz0UM47zIsY60URE+vVz2T3ndsqQIsyOf1OiG2tMWNRzJ+Jp6/zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvHzBxHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AF2C4CEE2;
	Wed, 26 Mar 2025 22:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743028893;
	bh=lqViN5Eu7Ch/V4e0CAlSLoRL5PM7JT6zJCd7tWfuf80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cvHzBxHmPy+Ul3xEP3SsXt4oVcY/0S4iEmX1MGmr50C+EAefcC7FOo8Og7euEjkuI
	 YaqXLva51MPq3l0kn8mFBkKsDeFNKBO8D0QYhyhnCQu02bAVcMgi5h0pp2LnX72WeG
	 caLUbA3pTrvBQUMCughZnEV0ndl+PpICOKScEMTBCYEEpCrHVFVCohLKWql6ri18O7
	 668wEV8hvp23gOBzlljdqQV2DR5LpXgrshg6N+eFybKyagiqdfhbTjg5zK3gap1OZJ
	 JT9/kYySWOg7HGgYM0k3xX5DFdPbxUnuzaVzz7BurWd7vdsVp4KPOaV6xPAFY/+uKK
	 lggK61WcaNcUQ==
Date: Wed, 26 Mar 2025 17:41:32 -0500
From: Rob Herring <robh@kernel.org>
To: Remo Senekowitsch <remo@buenzli.dev>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 01/10] rust: Move property_present to property.rs
Message-ID: <20250326224132.GA2958946-robh@kernel.org>
References: <20250326171411.590681-1-remo@buenzli.dev>
 <20250326171411.590681-2-remo@buenzli.dev>
 <20250326205106.GB2787672-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326205106.GB2787672-robh@kernel.org>

On Wed, Mar 26, 2025 at 03:51:06PM -0500, Rob Herring wrote:
> On Wed, Mar 26, 2025 at 06:13:40PM +0100, Remo Senekowitsch wrote:
> > Not all property-related APIs can be exposed directly on a device.
> > For example, iterating over child nodes of a device will yield
> > fwnode_handle. Thus, in order to access properties on these child nodes,
> > the APIs has to be duplicated on a fwnode as they are in C.
> 
> s/has/have/
> 
> > 
> > A related discussion can be found on the R4L Zulip[1].
> > 
> > [1] https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/DS90UB954.20driver.20done.2C.20ready.20to.20upstream.3F/near/505415697
> 
> Useful below the '---', but I don't think we want to keep this link 
> forever. And who knows how long it will be valid? The commit msg needs 
> to stand on its own, and I think it does.
> 
> > 
> > Signed-off-by: Remo Senekowitsch <remo@buenzli.dev>
> > ---
> >  rust/helpers/helpers.c  |  1 +
> >  rust/helpers/property.c | 13 ++++++++
> >  rust/kernel/device.rs   |  7 ----
> >  rust/kernel/lib.rs      |  1 +
> >  rust/kernel/property.rs | 73 +++++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 88 insertions(+), 7 deletions(-)
> >  create mode 100644 rust/helpers/property.c
> >  create mode 100644 rust/kernel/property.rs

Also, property.rs needs to be added to MAINTAINERS. I guess it goes 
under driver core with Greg.

Rob

