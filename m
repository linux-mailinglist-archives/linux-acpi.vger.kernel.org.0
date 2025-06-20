Return-Path: <linux-acpi+bounces-14488-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FFFAE24D9
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Jun 2025 00:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F0153A7FD0
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 22:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747D623B63E;
	Fri, 20 Jun 2025 22:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZPhJTzG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F05221DAC;
	Fri, 20 Jun 2025 22:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750457209; cv=none; b=DVs2cN8C7ZXw+BejlPFCfFq0lgLIIaa9mp5i+3iLLdQaWf7ptWsEdctMZ6AjoZ8rEJHlFDkwiEI4/mJv51hi5DKtdHUgAcXVtFljAG0T6b513/SU0vppuEWd0TQ3qBF+OivJCObgt34XrP9T95u9mskHbuYJyGU0fO0bRBhDBc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750457209; c=relaxed/simple;
	bh=eE3jajaJNedzuZV2q+noRIBA/GEx5wr6lDpsRW4JnuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQ4cMd/JkbVXfIYZVVk6cbvWyJ4ATPIUyzDLF7/M4H1ey+ZK4SDm9PdTqYhfYksEIoFfvq1Z7fuCVdG3l0qYFz61ZU9FHqF+fEaQ1EiF9rQQ1caOATddY4+f1LSW0HZQntlgjmcR86aRe91bW3s9igpF1l1/GPHhBxBGvQt3dEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZPhJTzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08439C4CEE3;
	Fri, 20 Jun 2025 22:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750457208;
	bh=eE3jajaJNedzuZV2q+noRIBA/GEx5wr6lDpsRW4JnuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GZPhJTzG+rjZ/ksx00F7qb+fGO7UMyEYCOBCzqeK0z8fQfLrmtNo2wQRQTF/Tzwou
	 GpWbpmZkxxeDQyh0gxI9+t+Ng1l/er9u483F7D3NL3KoO9w5W5HNQiAdNDgDegybUt
	 l0CY+FUjiCob7yrbWAqTJBf1mMXliS5Wx7aSVLlMy6WFytBfFmnwvajPkEVto3S9Ss
	 4QivkrIa/HRrTudrZoGxyLQqP83dkjASNxw7zZR0YWW45N9UN/WRYQwbIOWS5OW4A/
	 m59pq/ZmbM913crcqhVp4fydUXW4nL2Ii/9UtYVRo/Q1qH68VMK/258vu3XPHJCpBd
	 y2l0AANJ4JSog==
Date: Sat, 21 Jun 2025 00:06:40 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Igor Korotin <igor.korotin.linux@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Alex Hung <alex.hung@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Remo Senekowitsch <remo@buenzli.dev>,
	Tamir Duberstein <tamird@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Xiangfei Ding <dingxiangfei2009@gmail.com>,
	devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Benno Lossin <lossin@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>, Len Brown <lenb@kernel.org>,
	Trevor Gross <tmgross@umich.edu>
Subject: Re: [PATCH v8 4/9] rust: acpi: add `acpi::DeviceId` abstraction
Message-ID: <aFXbcDKP_jw_Sg5k@cassiopeiae>
References: <20250620150914.276272-1-igor.korotin.linux@gmail.com>
 <20250620152425.285683-1-igor.korotin.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620152425.285683-1-igor.korotin.linux@gmail.com>

On Fri, Jun 20, 2025 at 04:24:25PM +0100, Igor Korotin wrote:
> `acpi::DeviceId` is an abstraction around `struct acpi_device_id`.
> 
> This is used by subsequent patches, in particular the i2c driver
> abstractions, to create ACPI device ID tables.

I think this should say something like

	"Enable drivers to build ACPI device ID tables, to be consumed by the
	 corresponding bus abstractions, such as platform or I2C."

instead.

If we agree, I can change it when applying the patch -- no need to resend.

> 
> Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>

@Rafael: Can I get an ACK for this one, such that I can take it together with
all other patches through the driver-core tree?

