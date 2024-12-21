Return-Path: <linux-acpi+bounces-10254-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8A79FA1BC
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Dec 2024 18:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA59F167CE5
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Dec 2024 17:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9B015FD13;
	Sat, 21 Dec 2024 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvwyCAtd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F96E13541B;
	Sat, 21 Dec 2024 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734802072; cv=none; b=g6Kmm0ECHHNiewQzVd5wOIVMff+FwML6JVAR7+LlzOdcj1bXxER/PgyrKe8TXuEql2GIrqFdaymFPKe0dmXYx46/EABbAwyF3QfznHRlUtBuNfWKsz3s0s6BEZ5MK0aHx/2v5YWyoOjVUJfcW2UOBTfg1Bv3LtiqW8WZL1r1UF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734802072; c=relaxed/simple;
	bh=rFLdyA/GOjbE6nESnRW88V+E/E4ubmnsnUdy4Cshh6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g3/JVcC7tixc+Lsrf8NxLndc9t8doCXJfVEYnhaXBA0kgdOtDCTIz/fHEcfk/8I1Xp1AIoQYhW5//esag5bc5McwnoRgc0BNZk4RGRfr6ifGr6E7Mnmvr+ftZB1mLvoW5zwWnAwVjRSQwfbbP+LsinbYDWPyC0l3cj92w7IRtLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvwyCAtd; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-218c80a97caso25520645ad.0;
        Sat, 21 Dec 2024 09:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734802070; x=1735406870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0wZIbw8DQUJgofqHZdyFwS6NpDifTEgbiVWDtrNO6dw=;
        b=EvwyCAtduYtvMQOgmqLVY9HjED4bgjUhucBLsf2TwfYwl3jv0xQM0dODW6zGhkDxEM
         YD+u2iUdgQYa+bWfWPUjdTkJCa8VDr71EmY/DuVJzW/6tlLFo7K5QKaKCX9k/JB1pFQ+
         P1xi3lkhUDf4I3rJp8XpBOftrPFxdqa+QY9YiztCm4JR9GooThwY1tsY1Sly3fenAvt0
         HLOKSYuw2y8l1XdnanXYAY1eNzAoplAnv1A8nrDmdSeYNuHfXVu91vCcj/7Naof85aEC
         PqsckOoWEYqgrkm+hsEBlnrIw1GutiObbW2jo2qyoR71IZqjO8fcsb3uxn3SWvKUhAQy
         eyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734802070; x=1735406870;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wZIbw8DQUJgofqHZdyFwS6NpDifTEgbiVWDtrNO6dw=;
        b=cUSBIKR75WK/yG/qbktxcoY+UW2wQSPZ+C59iMb6w/D7fZnXqknoPIQtqy5hN8SlN/
         w99TYOTEr0kvTlTTHOsdr1hCm+FnJKKoSbHSGyiwN/IClBoOWiSZBt9pC03argUo2oAZ
         0B/Y38OfpFokGTnSxdS3TvbR9SQPKoKviD6lA0ByAC0wgbgZxRs2zY0WFZBgbLMukl+9
         FfZ6BNye2PGt4FwjEEKqToYpymguLH+//h2hvnEQsJCHEEIDNTsai3dD2ZeFJziXkmYu
         Q8jBTWC2Uw2jZPqeRyR4BJAXNTwLgrsYmCG/SkG6b+C+MgBkj3lB41fa/wEyFdcGknyM
         ps2w==
X-Forwarded-Encrypted: i=1; AJvYcCUr2aFIWOyw69z/88g6a88fQDayrjt2Kx6+ISvnEaJL2WkLZEjTem1DTw7jV9Ankag4AuVY5i234Bx3MSS7@vger.kernel.org, AJvYcCV1zfPFPyJtT/0lIfskJP57SsLRwiF7nByqz8taWcR2RGwcSZkFlPrcnL+t1QLfWhXJo4pZFcw+O6Hg4oA=@vger.kernel.org, AJvYcCVSPLG8Wnsq+agfKQykUENf0fsSl8PtMlwFg0YS49oyqqcUfFEr30BxiTehM4demZ+OutmjSWJiWbE=@vger.kernel.org, AJvYcCVUhJsJ2pOKSp3GAHFLxgoQelwZI/1MR9vjTOe9SY3vDA7K/albxdtgVxbexHCsy2gP1aLFVrLTw9hhJWUvHPzHaA==@vger.kernel.org, AJvYcCWuDYhETKDq9tAAuKWN1YJuhE2gP4YdRjFG0vf88GQOzPatHX/Bh72Zdy3rqf0A6iZ+CLXHO153OuCy@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2SLnF1iPaC0dSO0/C6pGKqKjpmmmT6bfMeWRFf1rrNPwj168D
	nJgRUVG6MdJNzkNeKR6hDwmB6HSm7/NI4Yqq36gIJWnWsApDa/Ce
X-Gm-Gg: ASbGncu67ZcV38Dx0qbLJoKBvAqX7pTO4uXAtU6uZ156Qm5G1KJVz+9WAGYoAT034f7
	gRv9AuRJz9eEsqm1Su51IgbzyH/jcEp0deLoBNhfWlkmUt6+szOxWahj/+sUJr6Vx+Wc1lgl6+f
	Aac/1Q7xm/ZksRg1f2GsLCrwSFTr54wTnYIFhePNYHH8Pywh1/k4NcB0cAAIcqSO7Mj22xRbkSa
	mbhX0xSbvjTyOMsyR9GJvHuazj03XeqQsGVomcf4oLXY5pQdOJgkf1oQTQEKCMiyg4oYPNTmOCB
	6Fpw54cKPKLdZ13ah4G75XGb8VD+cw==
X-Google-Smtp-Source: AGHT+IGPmDpTWJ8Te3ChVKErxWyPnJNpgHf9psC8wOhm23v6t2tySUgVkbX+UIHh9R7X1L7NmxpKgw==
X-Received: by 2002:a17:902:ea03:b0:216:5e6e:68ae with SMTP id d9443c01a7336-219e6ebaf33mr102894905ad.31.1734802070519;
        Sat, 21 Dec 2024 09:27:50 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc97432dsm46389995ad.110.2024.12.21.09.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Dec 2024 09:27:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cdece644-385d-408c-bb8c-c8fbb17c1372@roeck-us.net>
Date: Sat, 21 Dec 2024 09:27:47 -0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/15] hwmon: Fix Intel family checks to include
 extended family numbers
To: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare <jdelvare@suse.com>,
 Zhang Rui <rui.zhang@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20241220213711.1892696-1-sohil.mehta@intel.com>
 <20241220213711.1892696-6-sohil.mehta@intel.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241220213711.1892696-6-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/20/24 13:37, Sohil Mehta wrote:
> The current Intel family-model checks in the coretemp driver seem to
> implicitly assume family 6. Extend the checks to include the extended
> family numbers beyond 15 as well.
> 
> Also, add explicit checks for family 6 in places where it is assumed
> implicitly.
> 
> x86_model checks seem inconsistent and scattered throughout the driver.
> Consolidating and converting them to VFM ones would be a useful addition
> in future.
> 

That seems to be irrelevant for the patch description.

> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

The patch is independent, but since it is submitted as part of a series
and there is no comment suggesting otherwise, I assume that it is expected
to be pushed together with that series, and I won't take it into the hwmon
branch.

Guenter


