Return-Path: <linux-acpi+bounces-12475-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E959A720D9
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 22:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2F5188FC23
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 21:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537C42620C4;
	Wed, 26 Mar 2025 21:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhAVbwjG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE8025FA0E;
	Wed, 26 Mar 2025 21:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743024834; cv=none; b=sMOmlSZGoPXGmtQ7qhp87TjMGhI+x85iwy7GzhPdVKjCxopJA7WlxGyGz24umhCW7blBxtIWoyQREUNUphCYEKq+FMKY7XGlU7nptUy6D/TlsBYJzRgf9/l3MgJIXG6njJ3/AdV27bX/kUURO+iS2Dw0sNbmnyIUG+WpwB25i38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743024834; c=relaxed/simple;
	bh=8xEA2OShHhaqsNPdu0wc3xsXBHIf6cUYnQTL28FkuQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDIsnteM3YASXaKrhYIWbBjuKBr/rBAka0/vnVEcK0r3fxQkTNjC6StLnpLlAKOoJT3J7zxZwddbRpkZyoTQkzKaaWugHiHQDVQ6vttZKqIa2mGsrBCV4Ked7twZFHLXb6Ky4CaP7YSOPmvY0tMNZvgn+qY9S0rOWUhnn8glK9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhAVbwjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9089C4CEE2;
	Wed, 26 Mar 2025 21:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743024834;
	bh=8xEA2OShHhaqsNPdu0wc3xsXBHIf6cUYnQTL28FkuQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dhAVbwjGxcVI4N1P+u2VZxME5ITtTdoATVxDGXuNIGhzYLSXLUupbew6JtLQiy+Oz
	 S0M0jCCdqgGJEa0ty3M+4fRxsacBZovUTb5eRNQ4oQki34V674R8AxRP6ezTiJJYHI
	 0vXrDJHT5OEn7WVz0K14znjoraVTYZGuXcNXwQ8ADex0XMprh2YcS8LhsFDRSWFcyw
	 54oOjbi1A1VAK/4fOLQNvd/N4Cek4qeFUxlAcz7gslyloRb3kvKWDYCXpAwklI8Kc7
	 UmFRdtl74tMdQh0CJYSgS5MTnnPxW9SH/KxiFGycrZCA2TaS1AVA39oxoKLpyj38Il
	 F5XQkCvqyS05g==
Date: Wed, 26 Mar 2025 16:33:52 -0500
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
Subject: Re: [PATCH 05/10] rust: Read properties via single generic method
Message-ID: <20250326213352.GB2844851-robh@kernel.org>
References: <20250326171411.590681-1-remo@buenzli.dev>
 <20250326171411.590681-6-remo@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326171411.590681-6-remo@buenzli.dev>

On Wed, Mar 26, 2025 at 06:13:44PM +0100, Remo Senekowitsch wrote:
> This can probably be squashed into its parent. I haven't done that
> yet in case there is something wrong with the generic approach and the
> previous one is preferred.

Looks good to me other than the returning of strings issue. And yes it 
should be squashed. (Really, it should have been in this series so 
reviewers aren't reviewing code you delete in the next patch).

> 
> Signed-off-by: Remo Senekowitsch <remo@buenzli.dev>
> ---
>  rust/kernel/property.rs | 171 +++++++++++++++++++++++-----------------
>  1 file changed, 99 insertions(+), 72 deletions(-)

