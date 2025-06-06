Return-Path: <linux-acpi+bounces-14192-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8A6AD032A
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 15:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A598F17B166
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 13:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5C5288C37;
	Fri,  6 Jun 2025 13:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7l7ogoD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB74288C21;
	Fri,  6 Jun 2025 13:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749216388; cv=none; b=QDv1jAg1bRFyVH8k/ULnXMsDKETH4KXUpeDE1cO71E0+v1tyPzoGpZGt5sVr4/1W2p3i4bAczKemaQk+t+nDuefdg3fuRL48NaWrVFfuCez4aMySRAJe8FeAlPxhZyElyohpT3pE84e+TQ639Cp87WdNEzUNpfUHeBYHx9VGzeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749216388; c=relaxed/simple;
	bh=Z/dWd9rA9GTOYSgrU43nybvWakOOsjsLc4UhtvDk3G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LR+Vj8krisYLIiv6tgqzW7L6Jwe5w/AGOQ6Jr/VjHnQacpxWVaUGfVqp2/qra7W6+6uTAM0HD5oK4DvNGWcES6IxpuA+K0WsyZiUZioADq/ZobojO+UrzGTy4XrY0XJan4H0oU871kgBUavSNc6oIgXmsvnIeqPsM6OEex9NZ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7l7ogoD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B120C4CEED;
	Fri,  6 Jun 2025 13:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749216387;
	bh=Z/dWd9rA9GTOYSgrU43nybvWakOOsjsLc4UhtvDk3G8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D7l7ogoDU3evrTZJxuGtWePx8NtwxE4u+ULL6FopavgRWdOFDHnSxl9AGRi/Vq0SZ
	 Il0hxQqFwy1xdiQCDvHLqTJX5LhEBuQfhrBJqMI4EYVPg52cuF/ZBDojf4V7iPJtSK
	 uyIHZy3Ny/IGm9hZmMH9O8UuQaBja87IIpRXO4monGycYYL7ef/pn0cTTuNt50iNJu
	 GXOy+egMZrDv0XVeJfsr3EEpHl4Xo+yOfwxsYvYXSEuxDollnDn5Ms8E9Zuz6eN4hJ
	 Ij33SGWp+3wCgelPLEaK7dYQmCLKrjc+VcbSdTn2T1M77p5KNsKvgZRv7hCiyepiQa
	 J6AMpF/XfEqZQ==
Date: Fri, 6 Jun 2025 15:26:19 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Igor Korotin <igor.korotin.linux@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH v2 0/5] rust: Add ACPI match table support for Rust
 drivers
Message-ID: <aELsexA6yvW8ai9-@pollux>
References: <20250605161956.3658374-1-igor.korotin.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605161956.3658374-1-igor.korotin.linux@gmail.com>

On Thu, Jun 05, 2025 at 05:19:56PM +0100, Igor Korotin wrote:
> This patch series introduces support for ACPI match tables in Rust 
> drivers.

Which commit does this patch series apply to?

In general, I recommend to use '--base' on 'git format-patch'.

