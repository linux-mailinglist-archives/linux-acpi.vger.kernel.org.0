Return-Path: <linux-acpi+bounces-14698-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0442EAEA279
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 17:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE79169789
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 15:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662F72EB5CC;
	Thu, 26 Jun 2025 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L325dsHB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E8935975;
	Thu, 26 Jun 2025 15:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750951537; cv=none; b=IAzqnk7gXi9RSiKhaKrT+QzV0tZSM0Q8GE/SXwjUEgRx2iTt7JwEOFimwxkVEoKZrEVihOG1u/w184FEaoyrc5JAORUJcP9Se2xxpyDaxcEi3m2iR8dentvA8GHrarHfEHsFVPjI9CnpQzUFkIF9rYZ9PBW+VRzNy6uGSpORmkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750951537; c=relaxed/simple;
	bh=bUyuSpIXa48k5y8qyPnFT3SJWO3XGosa1vIwLaD8jjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wcsa2/kXiT1748nxcoLGe466vkSdrRBOjSuKwtoaM8wHY5dXJ40wKzssSbzVQEb2VAm3YnpN4zx1rK+QlDZoSuVdsC1QhXi9FwJ2bYQb+JQZOYxKUZE51/ucYwcZKHSCc1aWZm4veYSlhVy5PfctlizzC+VjZGUQmNmzcXo4VwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L325dsHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DCEC4CEEE;
	Thu, 26 Jun 2025 15:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750951536;
	bh=bUyuSpIXa48k5y8qyPnFT3SJWO3XGosa1vIwLaD8jjk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L325dsHBl28/R3isb72xBnqJpcXq8jgW8dClg2huIIWwG81xeCDbYPIP88TMG0Uq6
	 o8+dvKbi8wFkVE/xZhd7Mv3+mq2lH2UST0Iyf66/STB2IOLUO/0AbU/ZQAEDbAhr7y
	 hSbSbR6BLKKSdycRWriQ2pYsyKNOZHH6WWdZnvAm/zPn9gEZzJ+DdMZSPtPdgHo+yk
	 b4N73VtPPaMyDqPiBSZaqsITE24nj6YCITllkxnOfZn55DJv/bxkd5ypgdbmGlOjkB
	 A2/6tJvpGP5jgcRxW1AH9Y3tv+aNWsotMKuBoERZ2pnM7k/7GwzwnE5theEK7oSKN8
	 pXQo9aW7EmRjg==
Message-ID: <c5d750fd-ffcf-4d07-bfff-ebe206faa41a@kernel.org>
Date: Thu, 26 Jun 2025 17:25:29 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/9] rust: acpi: add `acpi::DeviceId` abstraction
To: Igor Korotin <igor.korotin.linux@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>, Alex Hung <alex.hung@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jakub Kicinski <kuba@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Remo Senekowitsch <remo@buenzli.dev>, Tamir Duberstein <tamird@gmail.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Xiangfei Ding <dingxiangfei2009@gmail.com>, devicetree@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Benno Lossin <lossin@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Len Brown <lenb@kernel.org>, Trevor Gross <tmgross@umich.edu>
References: <20250620150914.276272-1-igor.korotin.linux@gmail.com>
 <20250620152425.285683-1-igor.korotin.linux@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250620152425.285683-1-igor.korotin.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/20/25 5:24 PM, Igor Korotin wrote:
> +impl DeviceId {
> +    const ACPI_ID_LEN: usize = 16;
> +
> +    /// Create a new device id from an ACPI 'id' string.
> +    pub const fn new<const N: usize>(id: &[u8; N]) -> Self {

Didn't notice before, but why was this silently changed from &CStr to &[u8; N]
from v6 to v7?

> +        build_assert!(N <= Self::ACPI_ID_LEN, "ID exceeds 16 bytes");
> +        // Replace with `bindings::acpi_device_id::default()` once stabilized for `const`.
> +        // SAFETY: FFI type is valid to be zero-initialized.
> +        let mut acpi: bindings::acpi_device_id = unsafe { core::mem::zeroed() };
> +        let mut i = 0;
> +        while i < N {
> +            acpi.id[i] = id[i];
> +            i += 1;
> +        }
> +
> +        Self(acpi)
> +    }
> +}

