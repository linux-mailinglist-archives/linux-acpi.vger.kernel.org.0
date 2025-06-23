Return-Path: <linux-acpi+bounces-14499-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32661AE396D
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jun 2025 11:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F19691895A58
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jun 2025 09:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8EF231A30;
	Mon, 23 Jun 2025 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJx862tP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EB622F74E;
	Mon, 23 Jun 2025 09:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669578; cv=none; b=gA64UtALuF9vKZqRJ0eTBn1i2JHqXPfUUUH9qP9QlObomNXzKP9ArNVak8oKOU1qQS/cuLkaLqFZ8wPMYxJjg9fa9kgxQVR/LD0r8ukXwE+MIW1jty2iO4Hkk3tDm3fpZk7UZXDlA3Yy9sS/K96XaliIZIxD+9/MtF6qQP4Wofk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669578; c=relaxed/simple;
	bh=5pF4vDNlHIa6c6oA7h5CZ5pMihTZP50eXtCrfdW6rRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/CPtJWnRcviTxaxueEnSCiTFWUxwu9jxFlREsFSwPUeZuW5c9cqs8qfUoIaaNvpmP4eWzeD/JkIsVGK/yTGDmmxjOK2W4SOcOrF0Aqu20d/9oz6qWyehOvGbTDUEu1+mr7H8PzKjB770E1mBsD2pxgUeRf+5Ns4+Vfng5wMzpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJx862tP; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a5257748e1so2470472f8f.2;
        Mon, 23 Jun 2025 02:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750669575; x=1751274375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kEGfnWR9y2R5Hb4sOmq+4EG1fJXcUTguVBT64eS7amA=;
        b=HJx862tPfX00iWvHCHVN+dqyfXYxWW+In29gof2cpqdPrRGDfvwx6mdb1F8S2QAHd7
         RIiO81+qjedALFu/qyeGr1Ut0xsjKry3BaHUSWhIBPMnhAmFvLBCko58c5TvVYdgS8xg
         DzGMqHxl5J9zf5EoL8+RklYaGK926s0ueqGmfLqAn6akkpXym6ZxFqh4xr99D5NNHD8A
         /E2SmNy0NQXXctcaGD2ZmHgWcc/EfFdq7UekWrr96BKqjyalrSo8l52wuieHEj8av27b
         k1TrkDQvD57cvwFd5M9vJ5NKx7E1rEyTdRFJQSEhm1yUfNw0Ijkm1UqpfU8MXmkAALMh
         Wx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750669575; x=1751274375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kEGfnWR9y2R5Hb4sOmq+4EG1fJXcUTguVBT64eS7amA=;
        b=vspygmw1PQtMTPNHSqXU7KoHKZ1DgOV+R/N5sFLqaB8PBQxOM9M/zwWTF7dZwAJp7B
         aefYjxP76Rcit/aDWFKsoMIMqDUsnPxsMsEk8II6j4uV4NKQVMND0m1GrM+PnZfn+y/u
         /EjNo3kDbi999coch2g+HnYlJwdHKnDLpc5nR3pkykIjg0JuHzmLR3EHGLWptFmFR6Yg
         62oWwM3bE4BaQXZMq+dMmNx1O94Ezt786Zt4xhbv4QDtUk+G81rTSIt1+iwBkZXIMnGm
         IdltKVCN3j5KhzlwO/GLvZV073P52a4MaCoL1Cq+fdgPo52zjPFjAXNxUTK1BUVn30cP
         txaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiSEUgAu7O0wjoEX/fcVtp+0QGkbXeUpcONg1OR/VEkUvwxuuVZQHGpT4Wh8RvP0LPCt0M3/wGaJ8zGL12hjY=@vger.kernel.org, AJvYcCVcdtyv+E8qXxR3UCDoKA9vNWreTFY600tpzbA1FKE5lc9Hqo2uWEqGFaBOUUwk+WK6RKFTS1TtFF7z4vFL@vger.kernel.org, AJvYcCVwL85wppBzYeAn/gNtw/YiHQX6JCgAIz+HzrvKlUQqj3D/tsEvqmyJEohuYgwb4zlFkbq0k7j38/Uy@vger.kernel.org, AJvYcCWdc+8ZMbvUlZPhdEPd/nONio+rQkmt8GZc53iO0kkfQ3kCs7saiTiJCVEtCk56Q4vbvEPlHGrK3I4PPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5caVEzW7IDySNN+50urpgEls4UMhrQZpVxHqxkMiJiieETZC5
	DO7lSxxc0vWofUuAjBKLGzSVsBscpRYkfhcZIDte0/RVYejG/9tfEwJB
X-Gm-Gg: ASbGncv09JJ0tCdS94QkFiag18RfM31V1c/NrqSGiWUpwKe3NJ4yUm7z8ZGTE5bq7ej
	sUJ45BT1bkZRY/r1bHsvw+V9wrGZjccSGGiHLcaE1Mcvp2Y9bPQnZb3RGXmbjmFP4OA++IqllzB
	ynuM1mut/40YE/+Se12eczmtlZRVNmL72g9oHIfgyRNrZfvISKSHhGoHwr0Abxs4Fz9Rlk5XzMQ
	F3YaL3O31VCVPywvWmAW+WtZJFRjaU/vdqQ0ZTee4D5/LECXDO0uvXkHynpK418xvdYEQWK+Why
	ZHaKGhrn7djIg2tM9wkcUFqRZ+kjbIwWX/sAXaD5HjkirmiDdaQ8rjtZBdLrJWyOXvGm
X-Google-Smtp-Source: AGHT+IE0jNES0f1isvf0t0jssclUaz/qe8sm8GaviZjXBxkREDmbJO8rKf8In2RJvpDsEDCES9npdA==
X-Received: by 2002:a05:6000:491a:b0:3a5:39e9:928d with SMTP id ffacd0b85a97d-3a6d1166d39mr11221330f8f.0.1750669574903;
        Mon, 23 Jun 2025 02:06:14 -0700 (PDT)
Received: from [10.38.1.85] ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45364705748sm101407075e9.28.2025.06.23.02.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 02:06:14 -0700 (PDT)
Message-ID: <4655e2ee-6a5e-4ab5-8adc-4f91acd3d325@gmail.com>
Date: Mon, 23 Jun 2025 10:03:57 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/9] rust: acpi: add `acpi::DeviceId` abstraction
To: Danilo Krummrich <dakr@kernel.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>,
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
 <aFXbcDKP_jw_Sg5k@cassiopeiae>
Content-Language: en-US
From: Igor Korotin <igor.korotin.linux@gmail.com>
In-Reply-To: <aFXbcDKP_jw_Sg5k@cassiopeiae>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/20/25 23:06, Danilo Krummrich wrote:
> On Fri, Jun 20, 2025 at 04:24:25PM +0100, Igor Korotin wrote:
>> `acpi::DeviceId` is an abstraction around `struct acpi_device_id`.
>>
>> This is used by subsequent patches, in particular the i2c driver
>> abstractions, to create ACPI device ID tables.
> 
> I think this should say something like
> 
> 	"Enable drivers to build ACPI device ID tables, to be consumed by the
> 	 corresponding bus abstractions, such as platform or I2C."
> 
> instead.
> 
> If we agree, I can change it when applying the patch -- no need to resend.
> 

No objections.

Thanks
Igor

