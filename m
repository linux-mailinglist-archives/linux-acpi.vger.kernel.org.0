Return-Path: <linux-acpi+bounces-14705-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B27AEA493
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 19:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 679B07B3323
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 17:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3478B2ECE8D;
	Thu, 26 Jun 2025 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIBBs1PB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D195202C50;
	Thu, 26 Jun 2025 17:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750959747; cv=none; b=nv6yDgWgjORShhWRF0nayMc6uQrc9pCJqUCP0gMNQ+6jbkkHEYXRFe+yHdOp/o191cnPSqX29bVhIbTnRisUKt25DdqwgkWENHh38K58SHPTawa59K/ZXm5lMb2UQVTJWGyjaMWYqzCW1YEz3cduyxJUr2x6y3M+J4cCNMWLPJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750959747; c=relaxed/simple;
	bh=d/uFaFpLqxiJWZje950XRpP9HEjDy0svn2RVhXaZP6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WQGjZ/0Dd4WJ3OO0HaurlrTPdpanp1qwQGjJmi284VlNLX6UHuuaOwZNHENcFB2SqBYRg7WuWem1g0e7KitRAPPqJ3pyUmxyqXoUHIAbUmoePXtyCdZuYUm+E951DzXdAc7S+I+y0VwCwFmWCgrlhI8G2+jf354kfYAVaYfQCQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIBBs1PB; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso765258f8f.2;
        Thu, 26 Jun 2025 10:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750959744; x=1751564544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9it6V+UE5SX4dDhUGK283b/ucph+OC15b+uAeGnEJBc=;
        b=ZIBBs1PBblxWhuOkkVY84zVzw+nDZXUNniuDYQJrzSs87JGWyf38MmJKRMJi+4ibMg
         lJ97AGpaiwQtd6A41uD7hS2Y7KOtTHc/266lRKvEiOaHhw+Ttm0aJhA99t2r0Ydv5/5T
         gK+/lo4ILYWIZYDWxSYYc3J87Se1jSD7dmnihwMiBy7SFLmxO/EQtJ1q/+fnqCmGEnCv
         SD5FbiGEy9T5SlkJkTtUMEJrGqtjfPds8zz9ftCfHP4gFwad00KTPTSHspm5GdgrpLYk
         eKe7RYvOa1DYR3qdPLfuwwl1azOlsWHtZ80tPmCZhiBzQa35ksU6o4oo8MW71LxTzFqB
         1HnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750959744; x=1751564544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9it6V+UE5SX4dDhUGK283b/ucph+OC15b+uAeGnEJBc=;
        b=uNAesVnoZuko4vb/M73twto/y090a/c8TDn2/l2a8LYAV8rQHMv7lFzBVui3WGzcnw
         At4tneR7Xv8BuR+JENHtyII98/8BvoIxrz89na1xKqSoNlI54/bKDTR2b7pkDURxSjBE
         ktqdA53ExHzcjS/1QApuOWSvV35i5i+xgx7xxQRW56iAXM6DDFzGlstTkFc4iceMvFv9
         l+j7TePq6h3sowqcr8AQyWz41XDtjVyoN/al0e5fpAX8E40PG8avC5cWZCBfj/P/L84e
         JYtpXeK5GOJrXJe8inmr0eZ2Cj5f8Nqjv54AHRWlWaGQx2mIqS/R7ibW9ng/v1mUJKdx
         YR1w==
X-Forwarded-Encrypted: i=1; AJvYcCUPWTQUVFe8x8U+x4iVpwa0LMugiqFDU/ln52bYoPct5/V0ZkX/p35WFibUG9AQyfyfo0BNahSH5c1P@vger.kernel.org, AJvYcCVejSgnGeESX6WBOJ4qUEHK8aVcBr95/tr0Z29mXVc99Cyl0eBN7Za395DUmdoFoNWy/0uY+CM9/TIvh7X5@vger.kernel.org, AJvYcCWWvErnrz0tBlDz+BVeqkIucAUA8SlfhgbIsXzDVYxULGSr6ta6fY2VhROlu4mroOLF77mVje4Ic/BrRA==@vger.kernel.org, AJvYcCXKcC/CwnU4JsIzSybjBRnusWdO7F2P7FMy6DxG2IG3QL3LRpdy5pE8ygiVBVP9pM1ZpglG0A0fFUM24qTjnwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQbjJ0dKqWWY3B6jAy3iyuAiIDhgrtWzzt0KnGDaX0Dz6xRSOi
	sJ60ZbdpQEFGPI91zBMXtp47JvGhNF2AF01W/1OusebBuWBXjr0DjMkP
X-Gm-Gg: ASbGncs2VTMqLbhLVxWs5xE9QU92vub5t8FZIvyAmwnoLTrRaMDs8FkGxMz3o8zuGTh
	yyGNNoICDb/UztkzEUI4uXb1CCsM53PfZnCxRz/zlzLcMuXjMP8wCgUPHPXha3JCQXv+CjbfxvT
	g0v3SFKshhaYlN/tPtNCsxzhjGNZKO31LwRX62H6qBzP91d6AlsfiUlYvT7CZo1xi4PMMTxn1a9
	A0RxyBsO1YidlmV9eeKuA9eYWeu1bGZw/kxzGHpjxegkwX0bveOBV0f7rQEtFgta84rGwZ/d3Ml
	56hHnrk4O0Nsi5Q6dfdma1rn5EzSHZhWXVt5v6OHK2iGMe/trCBHfoMBf6sqEsgeg2KkOLU=
X-Google-Smtp-Source: AGHT+IGr2M9MxH/JfMsZ07lpE1ikbaPFCtQUD7frnfdUMbPRMyzGWfcYKWrr5HHz3Nw1g/Fqcy5Sag==
X-Received: by 2002:a05:6000:2082:b0:3a3:7ba5:93a5 with SMTP id ffacd0b85a97d-3a8feb85191mr466394f8f.26.1750959743398;
        Thu, 26 Jun 2025 10:42:23 -0700 (PDT)
Received: from [10.38.1.85] ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823b6c21sm56282555e9.29.2025.06.26.10.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 10:42:23 -0700 (PDT)
Message-ID: <31804bbf-1a0b-4312-8db6-532a008528a2@gmail.com>
Date: Thu, 26 Jun 2025 18:40:06 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/9] rust: acpi: add `acpi::DeviceId` abstraction
To: Danilo Krummrich <dakr@kernel.org>
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
 <c5d750fd-ffcf-4d07-bfff-ebe206faa41a@kernel.org>
Content-Language: en-US
From: Igor Korotin <igor.korotin.linux@gmail.com>
In-Reply-To: <c5d750fd-ffcf-4d07-bfff-ebe206faa41a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/26/25 16:25, Danilo Krummrich wrote:
> On 6/20/25 5:24 PM, Igor Korotin wrote:
>> +impl DeviceId {
>> +    const ACPI_ID_LEN: usize = 16;
>> +
>> +    /// Create a new device id from an ACPI 'id' string.
>> +    pub const fn new<const N: usize>(id: &[u8; N]) -> Self {
> 
> Didn't notice before, but why was this silently changed from &CStr to
> &[u8; N]
> from v6 to v7?
> 
>> +        build_assert!(N <= Self::ACPI_ID_LEN, "ID exceeds 16 bytes");
>> +        // Replace with `bindings::acpi_device_id::default()` once
>> stabilized for `const`.
>> +        // SAFETY: FFI type is valid to be zero-initialized.
>> +        let mut acpi: bindings::acpi_device_id = unsafe
>> { core::mem::zeroed() };
>> +        let mut i = 0;
>> +        while i < N {
>> +            acpi.id[i] = id[i];
>> +            i += 1;
>> +        }
>> +
>> +        Self(acpi)
>> +    }
>> +}

In v6 I was asked to change assert! (runtime) to build_assert! (build time)
It was as follows:

> +    pub const fn new(id: &'static CStr) -> Self {
> +        assert!(id.len() <= Self::ACPI_ID_LEN, "ID exceeds 16 bytes");

but id.len() breaks const context and so build_assert! triggers
assertion. If I needed to explicitly describe change from CStr to
[u8;20], then it's my bad.

Thanks,
Igor

