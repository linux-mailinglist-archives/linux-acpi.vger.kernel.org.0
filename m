Return-Path: <linux-acpi+bounces-14473-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B5EAE1A09
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 13:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF6943B4CCA
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 11:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6A4286432;
	Fri, 20 Jun 2025 11:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXb0b8MZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5397F266B52;
	Fri, 20 Jun 2025 11:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750419176; cv=none; b=ib625Z2ekylunBDHA/yK6l8/b7K8pB+vmX9d1Er2C5yoC492p49cmWPWmeGxJEXapOVmsadWuUTfEfB00wbRnThg5/w9Bdz/zKnVhGXR9RGslaUCi1GbXEIN8cG39b+ZvJ3fIOzu8buacjxiBm5ditWDjP5qcYToBAOGmdoty9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750419176; c=relaxed/simple;
	bh=aVUis3tmwjEVO7sLfUIv5dGMKiNhugLFOOb2Uv9ONlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gnQiZHO+namdmyNzbmY76TPYevW1cowEPmaM7AGCsVdKPv07JFU+XBN1SmRCXMpNYe+3SB5s8/gczhfDuwdnxj3D00ncuj/bESIfERMHmoxFegQmmZyYQlrrV5cSbhx6lFWpUVc+8/cCt2U3HhRZZr6F94HikxUdc9yxW6V0Wcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXb0b8MZ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a54690d369so1552870f8f.3;
        Fri, 20 Jun 2025 04:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750419174; x=1751023974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q6mEJj3phw5TW6gbm0SfLzIIYERO6R6gcqINxCdoWyU=;
        b=NXb0b8MZ5uiVVOST+ylTE9Mov2arH5IHHlYJ4KIHMXvHEyELW0mcF5Leq+0J8S5+76
         5r1uRZYj763RwOAfZ6B8KHQTJBtOZgLLNYZtMpRc9Chhjf9tOrU6BMx6MQ/VG173JYUp
         60Mijk717h3EcEmYRCvyXJ/nk0JZUhkf3AUs6kWsaQuJM/rb0jqJrd1GMZaXocW4Imar
         qdQVbKIAk9aUBuNm1J7RAreX4qxWesqWi5/4lxO26Ep6lBNOtcVWuGLqYTshah40ahe2
         91dTnNts3N3W6dmWte1Rmp/xTKqn8cNldWGOnSq9c1DXTc/Dc9XWHn2qsAj5SipPFhyg
         WQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750419174; x=1751023974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q6mEJj3phw5TW6gbm0SfLzIIYERO6R6gcqINxCdoWyU=;
        b=u9EghzRN/1N4D1oPUGYJIVcY2TnHsCiHD1pmnL10qRMiZ4FrytY51Xxh7gzfHmDxEW
         2qK/XAuDy+LW66/pHm3WFOMWT9ceChibNBCdvTQIawzK7kuTYZv3rN1Cj83kBYNazGI9
         NqgAoGsEcKbVm2OnwER+sBl/gik7qfC7qAtNU9jpxP+Tw6RMJ+S3/fTR+GObMSAisql8
         cL/XhrJ4ytW3h62YY5VodCOyMqW14T2LmHYwutEymm+GYltl5DTAUOd7yH3mVnBMO1It
         zTCH/9smUGvzdaaaCeRV2aLmvmtdEuigAj7U+HcltIHvWu71XCvocJ81m98S8hZeNu58
         vQjg==
X-Forwarded-Encrypted: i=1; AJvYcCU0FEK5WVp+l55szDCa5CSrpK9eNrWJZZWijuQ1nuHRjLPWZrkItmPYPQtrWGmSUdZiyYVsY3YK2EAhVIgkEdc=@vger.kernel.org, AJvYcCXAJ7PakyrMo1bM18/kfewrECgdcDBgli45Ya56wUz6KtJL+uQP/x38ROh+AkrIqNDuU9/gpX0uAqgc@vger.kernel.org, AJvYcCXLAlxDi7hrIf6gj30XzOsNcdJ0R+iFqKeuqazFV25RNu5c88tijLR6pzNQ4RgMFmkF42QmXkz7TcdCaIj1@vger.kernel.org
X-Gm-Message-State: AOJu0YwWmJG1NihH9d8x2XE/MncpaaF97S5H18IqfqwNnwCI6jDkW39O
	9C//jNA0pRWJmycrSULn7+n0h82Mqb/CyVelGzODNssZNPw9YBJ7gI/W
X-Gm-Gg: ASbGncsi+A7ma/IXXPaiq3q4IHpZQI55tg/1AcYfxUpqt12S8WTKPMhAy+qxETkDdyn
	j39rxXCRKK4YSsqJ95FXnHSXR1FYwXz80N+bnUBrUBfkQYN5FnS4A9AXw45camOI7m5D580CDuh
	BeTLfLhS/eFV8n9YIQSX0ze+IhtVcD0PlCQefco8Amh61f9aim2kCv/RBf7kC/Pp9nRNdck/VFi
	NsONX5xRXAw0UzAydWF7YHLkVsIulhsOM9wlg/fQc3XxumkEKxGPQX8HnWXMJGjdDe9vtHhAjzw
	NF+CTr38CaHqsAOWf7ydv5EazOWHPnapk4lohNIL1mz2bhLYQhq5fSfPChaFJ4pYtog9
X-Google-Smtp-Source: AGHT+IEOSthR0EbNak5G9TavGEk3affJNL6c5D3MkqGwwG0EgoahxIttjypkNXmARDLkwGDSSJ3aZg==
X-Received: by 2002:a5d:64e4:0:b0:3a4:ebc4:45a9 with SMTP id ffacd0b85a97d-3a6d12a422fmr1841526f8f.19.1750419173444;
        Fri, 20 Jun 2025 04:32:53 -0700 (PDT)
Received: from [10.38.1.85] ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d118b910sm1773851f8f.84.2025.06.20.04.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 04:32:53 -0700 (PDT)
Message-ID: <ddcdc5ac-9c6f-4aca-ad66-37e1e66ef740@gmail.com>
Date: Fri, 20 Jun 2025 12:30:37 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/9] samples: rust: platform: conditionally call
 Self::properties_parse()
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, Rob Herring <robh@kernel.org>, alex.gaynor@gmail.com,
 rafael@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, lenb@kernel.org, wedsonaf@gmail.com,
 viresh.kumar@linaro.org, alex.hung@amd.com, dingxiangfei2009@gmail.com
References: <20250618100221.3047133-1-igor.korotin.linux@gmail.com>
 <20250618101325.3048187-1-igor.korotin.linux@gmail.com>
 <20250618131958.GA1550757-robh@kernel.org> <aFLJJkeFfHR9GB-0@pollux>
 <aFRP-vGMoZNmQZ2E@pollux>
Content-Language: en-US
From: Igor Korotin <igor.korotin.linux@gmail.com>
In-Reply-To: <aFRP-vGMoZNmQZ2E@pollux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/25 18:59, Danilo Krummrich wrote:
> On Wed, Jun 18, 2025 at 04:11:57PM +0200, Danilo Krummrich wrote:
>> On Wed, Jun 18, 2025 at 08:19:58AM -0500, Rob Herring wrote:
>>> On Wed, Jun 18, 2025 at 11:13:25AM +0100, Igor Korotin wrote:
>>>> From: Danilo Krummrich <dakr@kernel.org>
>>>>
>>>> Only call Self::properties_parse() when the device is compatible with
>>>> "test,rust-device".
>>>>
>>>> Once we add ACPI support, we don't want the ACPI device to fail probing
>>>> in Self::properties_parse().
>>>>
>>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>>
>>> This needs your S-o-b as well since you sent the patch.
>>>
>>>> ---
>>>>  samples/rust/rust_driver_platform.rs | 7 ++++++-
>>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
>>>> index 000bb915af60..036dd0b899b0 100644
>>>> --- a/samples/rust/rust_driver_platform.rs
>>>> +++ b/samples/rust/rust_driver_platform.rs
>>>> @@ -40,7 +40,12 @@ fn probe(
>>>>              dev_info!(dev, "Probed with info: '{}'.\n", info.0);
>>>>          }
>>>>  
>>>> -        Self::properties_parse(dev)?;
>>>> +        if dev
>>>> +            .fwnode()
>>>> +            .is_some_and(|node| node.is_compatible(c_str!("test,rust-device")))
>>>
>>> I think you should be checking just is this ACPI or DT rather than 
>>> compatible. It's kind of an anti-pattern to test compatible in probe. 
>>> The reason is we've already matched to a compatible and have match data 
>>> to use, so we don't need to do it again. It becomes quite messy when 
>>> there are numerous possible compatibles.
>>
>> Yeah, that was my first approach; here's the patch from a few days ago [1].
>>
>> The reason why I decided against this, was that all the properties we check in
>> Self::properties_parse() in a fallible way *only* apply to the device with this
>> compatible string.
>>
>> But I don't mind if we replace it with [1] either.
> 
> As mentioned, I don't mind either, so let's change it up.
> 
> @Igor, can you please pick up the patch in [1] and at the same time drop the
> patch introducing FwNode::is_compatible() and replace node.is_compatible() with
> node.is_of_node() in this one?

Just to make sure that we're on the same page, I replace this:

    if dev.fwnode().is_some_and(|node|
node.is_compatible(c_str!("test,rust-device")))

with:

    if dev.fwnode().is_some_and(|node| node.is_of_node())

And reworded the comment as follows:

    samples: rust: platform: conditionally call Self::properties_parse()

    Only call Self::properties_parse() when the device is OF node

    Once we add ACPI support, we don't want the ACPI device to fail probing
    in Self::properties_parse().


Thanks
Igor

