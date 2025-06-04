Return-Path: <linux-acpi+bounces-14137-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F072BACE62E
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 23:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF0E17877F
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 21:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECDA202997;
	Wed,  4 Jun 2025 21:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZI+eMDP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB88CB660;
	Wed,  4 Jun 2025 21:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749072868; cv=none; b=lxRgSrS7jZ5hLtaqBiMUkFCRyZnrsvIudwarAB/WDdbpnJl94zAMUMi/xqwhPCRmQ2aiYJb+G5f+jFaNKGuMAKBIkCKid1eNRef60liB/TdyN4vBbgAsCCDoiBrMfevPDMHouzkXvuC89TTD7xvARFMQLKya21MJdErJjrStnC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749072868; c=relaxed/simple;
	bh=J1MC5P61dAPFObZN1QHadd/eBuhCxQ28FFl+J7Yc4w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8A76PN8n3cPvhq2r+hqNH4cE7Ia/d7pyXXGGbTA7Io/umuO2iwjgcoyDM6B6HgZK/jTigbTsEfCxwsP9SW1ZGzxRahaCu58tK3yCV20CvQAfbTo0HtRZ6XSv0lsFet3SoWddZYgkvAJTF1ru9dYjQrvlDrvBC2zoQwkt502dR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZI+eMDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C107C4CEE4;
	Wed,  4 Jun 2025 21:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749072868;
	bh=J1MC5P61dAPFObZN1QHadd/eBuhCxQ28FFl+J7Yc4w4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iZI+eMDPedko2rTVnosHnEK0ubYPnXqX5hAD5gZyzzN+rKSDS//uPPs9Z6bmPHGmW
	 KwnDBCJHG7X3jee19SUJShs3kxZYRo/MmdHzgorsS7sF34yaDE159uZ+j9zNjb+2cy
	 GbGMfTJRKV9ejP9xc0JLWVVKp4Q61FIwmZi6kRjwbKIgIL3fan9d7gRILxkT3FQnkX
	 ZCIJ4cjd9OukFp+54KV6Q/b4O1hsPPygMcN+mnu8FeT73EwtfMS2wOjThLL61eMJwy
	 5fUgcviQNlu+ZszTI4IckrfpwzPa8zBjm3V9YynzyYQ/LCRTFlekG0FuQN51+VVj9d
	 yRpQmqAFKcsPA==
Date: Wed, 4 Jun 2025 23:34:20 +0200
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
Subject: Re: [PATCH v1 0/5] rust: Add ACPI match table support for Rust
 drivers
Message-ID: <aEC73CHD0fvByrJs@cassiopeiae>
References: <20250604122945.3445776-1-igor.korotin.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604122945.3445776-1-igor.korotin.linux@gmail.com>

On Wed, Jun 04, 2025 at 01:29:39PM +0100, Igor Korotin wrote:
> This patch series introduces support for ACPI match tables in Rust 
> drivers.
> 
> Currently, Rust abstractions support only Open Firmware (OF) device 
> matching. This series extends the driver model to support ACPI-based 
> matching, enabling Rust drivers to bind to ACPI-described devices.
> 
> Changes include:
>   - A new `acpi::DeviceId` abstraction for working with 
>    `struct acpi_device_id`.
>   - A helper function `is_of_node()` for determining fwnode types.
>   - Updates to the core `Adapter` trait and `platform::Driver` to support
>     optional ACPI ID tables.
>   - A sample implementation in the Rust platform driver, demonstrating 
>     multi-bus matching.
> 
> This is especially useful for writing drivers that work across platforms 
> using both OF and ACPI.
> 
> Tested using QEMU with a custom SSDT that creates an ACPI device matching
> the sample Rust platform driver.

Thanks this is great!

Unfortunately, it seems that something went wrong sending this patch series.
Patches 3 and 5 are missing on my end (and on the corresponding lists as well).
Can you please resend?

Also, technically this series is a v2; patch 1 differs from the one you sent
originally -- please include a changelog.

