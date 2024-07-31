Return-Path: <linux-acpi+bounces-7172-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC5C943761
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2024 22:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 672E0B22269
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2024 20:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821F21607B7;
	Wed, 31 Jul 2024 20:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDzA9xKa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B9921340;
	Wed, 31 Jul 2024 20:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722459012; cv=none; b=AFldtQdC8BxvfebN+HU8C8A0LRj1GZezQiMEf0KlFpu3XdGCzAcFm8sMlUU3R1r9j0f97p8iG9Jc1F/XO8C57VyjEv264xgvL2Ovxx9CKfLbWQfP59CFbDA0pswLyqoGxl3nL7aw7Dm+6IODdYK/VxNP/PxHiRLqQRPBSk6qevI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722459012; c=relaxed/simple;
	bh=A60R/L5OK72VG8q53MaGclWUVNvU47wZcDunE9S64FM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEDR+eswDH9icR0YScgTwfm8Xys6vUu5VEy1gAi+XGciEImd38L3n8C+uGr4rEReMvT6IAW+Qs2JOOjuKAGVQQStBxh8/edne2rVllqWI+3puZuRmuTAOKvFhBk7T+3oENU9pDVpxyzty+7eVtWsjtqaKdPV0VClsKHexFovigQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDzA9xKa; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3684e8220f9so767806f8f.1;
        Wed, 31 Jul 2024 13:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722459008; x=1723063808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NypEUFyZR9rTYuNsPATzI2y5L7UdAiiDN2+0R35u6WA=;
        b=VDzA9xKa7YMdbSM+hWj6UsBKRDETx5j/fRjHZb49JWv0ize/In7ephUDRdXKU5HZ9F
         +SvpQh7doxDGorlE/eMy59JKO2YsI0IIHkWMb+NTRzsjyBuOknE98WAeBgR8Zc+pc0sL
         Hx0isHMEN2u3Dml8F+xj7dz+wLltMO/eRbnhgj5XCpj3dvaZMp8OIn+zh5d/hPqqHTYD
         j44ukcxp1QjXAp62ofvUUadR7QDJHCnH102ykqVg1KJi0+6KSKqgobQQHyxmMhzy7+79
         tr9oqcVSWJuHP4u7D6TCH5YHIGzhQopK7m7lWiQOfF1LtCFD7MfGhZ2W9fMhbYmpNTcg
         P1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722459008; x=1723063808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NypEUFyZR9rTYuNsPATzI2y5L7UdAiiDN2+0R35u6WA=;
        b=PU64SOymhbsX4nfw6N9M90bjGfPscuEDDLXYDqXX50PXazudmbdss7Wol2NaMKjmal
         9JsQAMtxFPhvOr55X2bfpzPtkmL0HMm3oCvveXbD46DL/CiN9b7mkWxD5bmqQP19k4w3
         9nhQwQ47spUkxsDB/bm5aqsKnWxGrcjJpyQfu64bpUKWcLlF2u2gaxCS3kNTnXlI/X5N
         IgLFPHToURaFlFqT4EA5JBQ6PS5AcwSMgJaj4baVGN4fL4M/a2tZWAJ3/b9I1fNbrB+P
         TJWRLIY/Sm0xtGy5c+sIFDitzFT3iay66M6KL81kMPzZuqqGi6A9Pj5Hf2nI9KGBspOm
         omkg==
X-Forwarded-Encrypted: i=1; AJvYcCUGGimbIKYzfbn6wIsCEHfupjPDMz5TnECYa+qOoNmvIRmNL6IVNhqvLG7v57MBxJNeFWOLOLKHWmrzozDH+9MpY40KMENyXMAWXl/xlBy3+Yh934EDJcXFzadJt2TcPlCuR3Kfl67fNmLEKJMviNycLus9ahazAxB2riNeV3tA5DuJ1Qn0zn5yVA==
X-Gm-Message-State: AOJu0YyzOaSycTMCBXSHgv9htpTtDGAff5CKGbXkf2Pci1zAkn9xiL4d
	dLumqn9M8E4lnR00oq7vDdJhaIKQ03H68Uvw8UPRy3/gfNOR/+NWz56iKNCkYDk=
X-Google-Smtp-Source: AGHT+IHnZLI1g3Kk58XYevbjUdD5hcGNWGOSODxQ5AOPDZjpHHUhf1E3Ymw5hhoYDmBYwHfL7h/IBQ==
X-Received: by 2002:adf:e6c4:0:b0:36b:aa27:3f79 with SMTP id ffacd0b85a97d-36baa277c37mr441992f8f.4.1722459007730;
        Wed, 31 Jul 2024 13:50:07 -0700 (PDT)
Received: from [192.168.1.27] (ip-109-090-180-058.um36.pools.vodafone-ip.de. [109.90.180.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367fd071sm17912969f8f.62.2024.07.31.13.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 13:50:07 -0700 (PDT)
Message-ID: <a0c639d1-4f21-47f1-bb66-92f185e828a9@gmail.com>
Date: Wed, 31 Jul 2024 22:50:06 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 12/17] platform/x86: acerhdf: Use the .should_bind()
 thermal zone callback
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba
 <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Peter Kaestle <peter@piie.net>, platform-driver-x86@vger.kernel.org
References: <1922131.tdWV9SEqCh@rjwysocki.net>
 <2242500.C4sosBPzcN@rjwysocki.net>
Content-Language: en-US
From: =?UTF-8?Q?Peter_K=C3=A4stle?= <xypiie@gmail.com>
In-Reply-To: <2242500.C4sosBPzcN@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

On 30.07.24 20:33, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make the acerhdf driver use the .should_bind() thermal zone
> callback to provide the thermal core with the information on whether or
> not to bind the given cooling device to the given trip point in the
> given thermal zone.  If it returns 'true', the thermal core will bind
> the cooling device to the trip and the corresponding unbinding will be
> taken care of automatically by the core on the removal of the involved
> thermal zone or cooling device.
> 
> The previously existing acerhdf_bind() function bound cooling devices
> to thermal trip point 0 only, so the new callback needs to return 'true'
> for trip point 0.  However, it is straightforward to observe that trip
> point 0 is an active trip point and the only other trip point in the
> driver's thermal zone is a critical one, so it is sufficient to return
> 'true' from that callback if the type of the given trip point is
> THERMAL_TRIP_ACTIVE.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks for including me on the review.
I'm working on it, but unfortunately the refactoring of the thermal layer
around gov_bang_bang.c earlier this year broke acerhdf.
This needs some debugging and refactoring.  I think I can finish it on
upcoming weekend.

-- 
--peter;

