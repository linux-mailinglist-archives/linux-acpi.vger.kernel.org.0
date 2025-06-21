Return-Path: <linux-acpi+bounces-14490-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC3BAE273A
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Jun 2025 05:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B36F5A3D46
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Jun 2025 03:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD26D14901B;
	Sat, 21 Jun 2025 03:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFTG9WSj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14763EC2;
	Sat, 21 Jun 2025 03:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750476504; cv=none; b=mnx6rLbk2UGsjDW/VUt+icaOw9nLDb1sJd6rOVN99EaNz7JdeG/DZaz/ufBsy0ULhC0hZqgmWg+GL5bWVyYIvA2pRPiDjbIfsTzUunNEFfHKLqOIR+wETvRPhz8xfCMu44sOg1dtCKgUUmA1mCaAsk4AN4lStx9vY9r3GukVDQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750476504; c=relaxed/simple;
	bh=XOIyHyU8R1w9H+z6+fu5PhmSwMuz8DC82MGSiGDequQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMQ3lYVApuFsTPxOsX3A5yD5/AgFOLyJ89bkFZq3t7GC/itOIfzDtmBVSn7Osg/iz3mNWdW7XLfsPvrGQ7gZF720RKEodjo52u1BntT/t7Qiq8s4fkofPM0BGNXAU7FrEuz+48gKJv8WZj/lt35o6a7pCg4MI6WBUXNkUeyXzkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFTG9WSj; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a4fea34e07so1227016f8f.1;
        Fri, 20 Jun 2025 20:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750476501; x=1751081301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6RYVzsvFt1KjYQ7dHOGgkQLn8r4WbWR3+fey0qRKwFE=;
        b=WFTG9WSjfBQly/wxF3TQ5GMVCLOTrOWtTjlFeSt9nw7D1kug7bnEu9WVbCvHAtsQx6
         8Y+j4G+wPPrNkssYbkrKgbFU0ErctjGP13SdbdZNidLA06lu2n5Vn3zO79MYRsm/lwW9
         YRcSrwhpbpAA0qUdGS70RdBTd2UidtaaMLLw5NIvWtRhAKTa2/ey++2sGDnOUryiETBI
         CMxH7h8Mp+eDjyl0kA3M4RcvxUmwhj9mB+d1LLWXJXUJV3UItmYkwxl2qhy1gsYzUYhZ
         Z3jt4S9zjisCYjy55ENn62B05aFMFTcd3MqEPOdna05CL0gjODgNV/vlYz9E7m4sfRBW
         BpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750476501; x=1751081301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6RYVzsvFt1KjYQ7dHOGgkQLn8r4WbWR3+fey0qRKwFE=;
        b=QoDrFkb2nR9QxQzLEEi2ajlyAoVNz3iw4spA2JuiYObU5/v5xa+cTL+/7IEw44/xjs
         uBkZ7THInT6bJCzdLiW1n/KLa/C4JScMlGWcIhPu4oz2KyB0Rw8pLLKWFI0vdIF7/N7U
         8Xmo9GYkj5ghG+vl/2I/yQ+uO8UMiwFs8wGAEBGaPrM9K9DzgaPtdPD6oimJbFiEqhWT
         kaqr5Z/SwgUFNxTOiAV8shqfH2G8L8iHmUsj7p/POpVoGuWKX9wGoI6dcxaP3E5zIkYV
         4Zl3+Ne3YM+nQ+FNFBpAge3kh6sqELGuYM+I8x4XrxaQl2QEenRL1585bTSntzFTp8jP
         edqw==
X-Forwarded-Encrypted: i=1; AJvYcCUMZotVTI6MYWuO7CENQRbXCi9RKBV7cU1TKhLJI3R9W5rYe3fLm1U9BQ6wk9M+QRfJ7aG6KSsacQoeSxGMQWU=@vger.kernel.org, AJvYcCUq6TZSdC29JdKvNEflwKY+RU8BcsNQfP+OG+8IVLKnTrUzO9ml99ICgOE/OwrAEN//T+ezQJbzaJG71Q==@vger.kernel.org, AJvYcCWlI+p72VCA2pkQjwJKYkN0cIqnbTUG4nhku04svBLe9IUaZLXpC6ukDalTqZhg1lCCUhIUG+N18QIuZPhX@vger.kernel.org, AJvYcCWqzmoTfcit0IJPEYgoY8OMFDzP+kW9JaDd7bHEXC0MEU1bWO1gQ3BqXa/wJI44kEgKyfYopCXaNQ4k@vger.kernel.org
X-Gm-Message-State: AOJu0YybOjJS8Kxkk3aNWqDreFwr12Zy23m7rdK9CKgELC9ytOOWEWcl
	+/I3E28KUR3XfiRpzNohz7bHUrlyZrA0FRDQUUv+qHe4IDmUbD5iRhso
X-Gm-Gg: ASbGncvCFXrDhBmQaQSd+w4nP1tqwS2TPR/sCuhhMWzs21fa2IlACRu7u002CP7IiB9
	WnEADzW1xTVjwQ9Q5Ihd0rSe4PaGcJNm8dHhdUobgFiyIr+jYUEPyJQJudWVw7LfjKwjDfFBhbn
	AJO8kEg1d77H0pemRNYQY3cD2EzqZ8J0qbIzu9I9R73JgYdsa1ngSMvFuYXzau/kcdFIBJNzH6t
	fGeCCl3lpT3BSW4iZ5z9CtHGLOgyU9F1NgfYkxD3lDOb0xNI/WzpePj1Luhel51J+Z64NSWl7Fz
	DoQJAcp/+UUE9l2WoVNDjxC9dVQE/hFUwfsglO2Qjv5013C9GL/ihoxjwjCjQoLxnTRyaxxhPbU
	qqMkA5cogT2r57QIPIk8iIYlw4ZBRYMtHCIbw3hx64Fl/i7XQC96JM4DeFwFQqqO4CV1WakN5U0
	kZyvGAY9I0yTUM5djyeA==
X-Google-Smtp-Source: AGHT+IEl4sD+EqdTjk1No1Nw/dIxZYZRlU5oJbGK/RYeduxiitvzSariJLNdF8/SAulQCuHsATTNEQ==
X-Received: by 2002:a05:6000:40cb:b0:3a5:8a68:b815 with SMTP id ffacd0b85a97d-3a6d12e68ccmr4150435f8f.46.1750476501064;
        Fri, 20 Jun 2025 20:28:21 -0700 (PDT)
Received: from ?IPV6:2003:df:bf0b:9b00:2ddc:8808:df65:e64d? (p200300dfbf0b9b002ddc8808df65e64d.dip0.t-ipconnect.de. [2003:df:bf0b:9b00:2ddc:8808:df65:e64d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d11909f4sm3527452f8f.88.2025.06.20.20.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 20:28:20 -0700 (PDT)
Message-ID: <9765df90-df3a-48ed-88d8-b5de5b1d0540@gmail.com>
Date: Sat, 21 Jun 2025 05:28:18 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/9] samples: rust: platform: don't call as_ref()
 repeatedly
To: Igor Korotin <igor.korotin.linux@gmail.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>
Cc: Alex Hung <alex.hung@amd.com>, Andrew Morton <akpm@linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>,
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
 Boqun Feng <boqun.feng@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
 Gary Guo <gary@garyguo.net>, Len Brown <lenb@kernel.org>,
 Trevor Gross <tmgross@umich.edu>
References: <20250620150914.276272-1-igor.korotin.linux@gmail.com>
 <20250620151849.281238-1-igor.korotin.linux@gmail.com>
Content-Language: de-AT-frami
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <20250620151849.281238-1-igor.korotin.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20.06.25 17:18, Igor Korotin wrote:
> From: Danilo Krummrich <dakr@kernel.org>
> 
> In SampleDriver::probe() don't call pdev.as_ref() repeatedly, instead
> introduce a dedicated &Device.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>


Reviewed-by: Dirk Behme <dirk.behme@de.bosch.com>

Thanks!

Dirk

> ---
>  samples/rust/rust_driver_platform.rs | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
> index c0abf78d0683..000bb915af60 100644
> --- a/samples/rust/rust_driver_platform.rs
> +++ b/samples/rust/rust_driver_platform.rs
> @@ -32,13 +32,15 @@ fn probe(
>          pdev: &platform::Device<Core>,
>          info: Option<&Self::IdInfo>,
>      ) -> Result<Pin<KBox<Self>>> {
> -        dev_dbg!(pdev.as_ref(), "Probe Rust Platform driver sample.\n");
> +        let dev = pdev.as_ref();
> +
> +        dev_dbg!(dev, "Probe Rust Platform driver sample.\n");
>  
>          if let Some(info) = info {
> -            dev_info!(pdev.as_ref(), "Probed with info: '{}'.\n", info.0);
> +            dev_info!(dev, "Probed with info: '{}'.\n", info.0);
>          }
>  
> -        Self::properties_parse(pdev.as_ref())?;
> +        Self::properties_parse(dev)?;
>  
>          let drvdata = KBox::new(Self { pdev: pdev.into() }, GFP_KERNEL)?;
>  


