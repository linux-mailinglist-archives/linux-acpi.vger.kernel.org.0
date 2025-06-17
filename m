Return-Path: <linux-acpi+bounces-14417-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022EDADD784
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 18:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CFD27AA256
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 16:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5F62FA634;
	Tue, 17 Jun 2025 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R25Xp4nc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED902FA62D;
	Tue, 17 Jun 2025 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178488; cv=none; b=jd13RzbDVJena9Sjqa6RMkYuELX+KT7quK/3s9N10JONTxeAAG1xVEav79Zcnkp7sZ6+GSzE5xzGo+hzFTsmhc9VXQSYvj/rvSueweOT8Q2aIAkz1bub6ESVT3bLJQ8ysBMLCAq2jkxpY1Lwl6pZpT4rPdgn5wAi4kTqd4Um7Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178488; c=relaxed/simple;
	bh=rdxjPTpTsVt/SnRY7PKjl1A9WOWE6Jp00hg/fNkh9po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHsaKIIObXnXtGiYyUlso/QKn9WsDxPeCohsJFToM3mOcvByIsN726TrSpinY4LI/SUx/5rPrs+SpSdk3CFrw9Ul1gm0C1IxYHiskUeZPscEnvO05vyokSUIEmGQl+1uBhRSVs7X0gM6ONmfARnegWHbKms1C/13lFleLP0EZiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R25Xp4nc; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so10573055e9.1;
        Tue, 17 Jun 2025 09:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750178485; x=1750783285; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=21G7K3oa7nNa6fSkku+S/f2TFwa2VN9LqV0I5kPoxQ0=;
        b=R25Xp4nc0eJKwbv6cmE+W2UZUiAukiMzseD8g1FgBE/WcdUZniks8Twbp8IuPKsvDb
         on6xcUvCwOSfRz8bZJYFYGpXF3i6/kcBZKSaOXjbDFaRQ8mZG9FAoREsIjFDFVrNrkph
         PaVhqr3Ip6UJAbYMy4UL7eQ03lKDWNa1lfh1YcjnNTgi4esl+6Dg2L8v/cHCFJRa4xqr
         V/J9mDkmT1z5IP+IhrqTCgxC2CtPWFZaoP0d3Paaz4lL5A+yo8/aYe8RQUJtKmPctMqJ
         JkmZVI0G7qWuDPk8B7imTwBQZF25y5nFnKP4lopvGEW1tXfm0L1sE6eygRpcO6ZKYmrU
         NgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750178485; x=1750783285;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21G7K3oa7nNa6fSkku+S/f2TFwa2VN9LqV0I5kPoxQ0=;
        b=OVccAgdn5ZGRBPij7tjjACG/+DTfj7g0waaIjWvWqGVIdUiWssXpQYql7WBxyI8iUN
         sqEL6Rd7F/jF9xm3o5T+vqWF40PljE0dRKT4/p2zHRBGnH2QKUdty+eVFOUMJkp7w8sU
         q+fLU41aAK41tBo9uIJfm1U8Jcra6MeBxdyXEayIFAjI0VfD2SmBi/tVdk/huaL6ytMN
         bd9+7Ss+HOew0+fBzvVEj9/UWkbnLbikAUyY6Tgt6Cs74ghSYXxdJNVcaWd7o/6gvJxe
         Jn60TD5Xyr7JXFdDNMEvZGbPA1QP8nhgGnPVaLNt4XhujKXkIsnMJldxQ8KTUVNMXl+o
         YLww==
X-Forwarded-Encrypted: i=1; AJvYcCVVlS3nUbA9tKNRfQ299GptYLw5eY0FN4dvinAZCFSSeCFmfKHctBFI+x5MGrxhiehElrbStsEG/rR2UGMesYs=@vger.kernel.org, AJvYcCWF/s+AAJmmK327BUj1vchVuZXTz3lywfPp2xxD5k3ktrKrYpj6xQMKFmMpZ7fb6hdZnyVgy3INqfia28Gg@vger.kernel.org, AJvYcCXUr+1mkJQGzRgkr6Wbh1BpeFYlpH05DI8+nBWZp4lcnfjpnRzRKgZc4wpjKMuQRJrkh5pX4P5V2ylp@vger.kernel.org
X-Gm-Message-State: AOJu0YxEeV/xzHwmjMQ5s18CzTniW3B1iXl/bQE4KVATH4W6fE+/DvTF
	cNm7Krtsjuv3oO7xgq1IQUn/Q6GX11elqILxnpRrHGjMyLT5aa7bzaBu
X-Gm-Gg: ASbGncucLcL9Z04X7J+syVnrkqCLPAaIAuWy7BSeIDoZUTJkDvkbviHyVxm6YSluAQQ
	6222mzim6ksHTeFnLFIfXY7bVrOd2NipRfLnxcP8t9nFyMCdJTdKpu9bHFP2zH/g3G4KsMZ+Pcm
	7ENoeVtTawJw0AJGsohDPA/9gAP93bg0D6dldg24pWvwqiV1XgW7xkGNJLNxdEkQcd2VpxHvK07
	IJ6DRSyo7VIbw5aDyUnq+t6eXMZx+HTsggDS6tkjIcUhM59KWa3x0i75E1RRCnFSZiLnrhJA4Gs
	SZLYJ4YHRQDM6CzJN1FvyVEweARHsJjc3Y7ZzHYxxIYxhUbH09UVOzeOtfratUjEjffV
X-Google-Smtp-Source: AGHT+IFmZhow4l5H2yFI4b5oAR++LPmg9+bxohsFEM/5hvW+POf0Ml4orx9ZxlbbJYmos+qnKOd3xw==
X-Received: by 2002:a05:600c:828d:b0:450:cabc:a6c6 with SMTP id 5b1f17b1804b1-4533c971330mr140024935e9.15.1750178484289;
        Tue, 17 Jun 2025 09:41:24 -0700 (PDT)
Received: from [10.38.1.85] ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e195768sm182014045e9.0.2025.06.17.09.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 09:41:23 -0700 (PDT)
Message-ID: <f29b4eba-bd79-4f74-940c-8cff65495ae0@gmail.com>
Date: Tue, 17 Jun 2025 17:39:07 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] samples: rust: add ACPI match table example to
 platform driver
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, rafael@kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, lenb@kernel.org, wedsonaf@gmail.com,
 viresh.kumar@linaro.org, alex.hung@amd.com, dingxiangfei2009@gmail.com
References: <20250613133517.1229722-1-igor.korotin.linux@gmail.com>
 <20250613135407.1233005-1-igor.korotin.linux@gmail.com>
 <aFB2FZEFcXUsW8lN@pollux>
Content-Language: en-US
From: Igor Korotin <igor.korotin.linux@gmail.com>
In-Reply-To: <aFB2FZEFcXUsW8lN@pollux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/16/25 20:52, Danilo Krummrich wrote:
>> +kernel::acpi_device_table!(
>> +    ACPI_TABLE,
>> +    MODULE_ACPI_TABLE,
>> +    <SampleDriver as platform::Driver>::IdInfo,
>> +    [(acpi::DeviceId::new(c_str!("TEST4321")), Info(0))]
> 
> Let's use something like "SAMPLE_DRV0" instead.

Nope, that's prohibited by ACPI HID naming rules. A brief description
can be found here:
https://uefi.org/specs/ACPI/6.5/06_Device_Configuration.html.
According to section 6.1.5, ACPI IDs must be 7 or 8 characters long and
follow the format "AAA####" or "AAAA####", where A is an uppercase
letter [A–Z] and # is an uppercase letter or digit [A–Z, 0–9]. No
underscores or special characters are allowed.

The `iasl` utility throws an error if an invalid HID string is used in a
dsl file.

I could suggest on of the following:
DRV0001
DRVR0001
PDRV0001
TEST0001
TST0001

Let me know which one you'd prefer for the code and documentation.

Best Regards
Igor

