Return-Path: <linux-acpi+bounces-16577-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744F2B517DD
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 15:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11ACA17D45C
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 13:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110D728751A;
	Wed, 10 Sep 2025 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ApCtoVsc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB66A268C40
	for <linux-acpi@vger.kernel.org>; Wed, 10 Sep 2025 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757510831; cv=none; b=lz9srGmQU0ZwUdQKwobOnpM7UkgNSeyk7XWJ1qRjfSgaPPvHcLpEm4ehWASIAE0jQXotuyuV2gRIliIqXThvhGeFTRUuhGEgqYa3PHuAZ6NwbRXbbw19ByH9wfhqJv30knhbH4pMqiTzBhax19JpfBPfuH78y8i4QZ8yLKSKsP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757510831; c=relaxed/simple;
	bh=ogVm8trucvDSm3Kwtl2iXjtv1SvKNGL9WqRdEd8fHcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pad4H1SUrhYYXLLEqO0bjXwgGz9FfPDMxTbD30kdGWaj4jS8xVTu5scRMCHKtj+tT7QUbeNMs3C2/OdJKOZZtHoh1Y0bgEEmO0V+c58HLlCadfbArqNT9Bs2dZkeKc9u0yM928dwwpKnTBq78eATwADpcHvsuIYwTSEkvgvIEg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ApCtoVsc; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b9814efbcso4513745e9.0
        for <linux-acpi@vger.kernel.org>; Wed, 10 Sep 2025 06:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757510827; x=1758115627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u0KH36ZKXhdeAdnK3QlMzkwzGwV1sdl29nhq++hRLN4=;
        b=ApCtoVscftwGEYSefc9P7/f3xhc4SW366qqjReRdGJKxKGHRaLaPhKYuus9jA8pxFn
         X1aFIsxPzgDg7fGZLwMOLuH3tRbs29bRhfURH2eeUoq/MBW73UHEFq+7fZ3ZJ/Otj9G5
         tnPtwqCA33t6TfpOD3V7yYpvK/IR6sBk5hpR4SKpRfu+H65vd3zRAMvYzae137M/Dxlc
         8X+ehXU4zPB4cXRmB6MiXqPYqNdbtLXGtn8yklOQcXEFlp9NfVjqoy8SpveMK3Ez2fPC
         IWDUge1nt1I6IEKW79hYFPypLkLihjT3L3ilnYw30KgPAsgM+Ye8wQIc2hVk42j2zXQ1
         kbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757510827; x=1758115627;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u0KH36ZKXhdeAdnK3QlMzkwzGwV1sdl29nhq++hRLN4=;
        b=ZoQwntot7cNTlEPxFuVgo3BTIOkxhpcpHilhiKeuhQgFoV6B5W+BzjwoUnXAY8vf+6
         QmM/4Z0BgshQd+OQvO8UPJLTNAs5f+DUS88Nyf953JKH80t+q9jm4oWeLhaoybW3rMNA
         h/xN+lWQvKBM7WNsON3k4Fa6O2EQEnQo7bWD9VdCF9DmE4nx09gpoMqkagnGdUhUA+9v
         xOPK9W1AilJzAlNJ63j4L/ldRY/G9hZzlTakxxSuYQEIgH+JpWldY6KQ7qcO/6M1JlM+
         9PR5g692pE0slkGv9Q/ytIDW4Y7vbJVEsVSEbsnFbRSCprIpc7McFYSlXXGGL2kuNBN/
         iFow==
X-Forwarded-Encrypted: i=1; AJvYcCW8VNsOuMM85TM+VK3KWsZ54bv/i13k7HJH2YAwm6kP1D+ZTxGXGu1ODIj/GntKR9J6iUySQSqN3v8y@vger.kernel.org
X-Gm-Message-State: AOJu0Yy70qE9d82gdyt/61xGEj3X/wbl33Ej7Tf+/OlxAPWMuKZKST01
	n7bL/EBN2uIiFkk6rlFfq9SDi2aH4wsgepLOUTYTnEP9Kx8yEy4enTUVOZVT9uxH/1k=
X-Gm-Gg: ASbGncsYB6ZqJnqrWVAFoefzzc/DUSUyr9WILuIwd0ReMIo+pt/fLPSawfRZetIiyNu
	+iTOZSHC+tb0eS/ag1MFcGieF+fHLc8Q5fT7G0+a7LB3hAf1dbkRKOxJYADjf7NgULa4Htq4snf
	jEMHKefvS7+Gc/Pa2Q1d75E4m1TTjGSUhntQfPia8dcLIcR6g6zAAMOO4YHj+TAWTSGqeKWLx7k
	X0knR883eUBXdk7SnMSOpyxKs2na3LpQwPNcdQNljxF3684m+9djAp3wZZ6tB4SWPR2UBXP+aep
	EvYecv3xmH8Od1vbOt8+TBzO3+8rj2c9O1I3eyIogv+3+OhdOHgB38BcZqaThS2TOUnmL06rwic
	iZloEuqJDOIyDVZ/dO/txTV5W5lOLnkrD6KxwXsH7SncV+g==
X-Google-Smtp-Source: AGHT+IETw7dFN/bGOQqvrqcqGTQ0XCg0cHB9VY99Nl5WYPWvawcJVIy7xgIbI3+xfTA4oikqjgmGYw==
X-Received: by 2002:a05:600c:840f:b0:45d:dc10:a5ee with SMTP id 5b1f17b1804b1-45dde20ee09mr143413245e9.15.1757510827160;
        Wed, 10 Sep 2025 06:27:07 -0700 (PDT)
Received: from [10.20.0.214] (ivokam.ddns.nbis.net. [109.121.139.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df820d686sm27843075e9.10.2025.09.10.06.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 06:27:06 -0700 (PDT)
Message-ID: <ed56eac5-2484-4ac8-947a-5ccec80fa298@suse.com>
Date: Wed, 10 Sep 2025 16:27:00 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/15] x86/mce: Do 'UNKNOWN' vendor check early
To: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
 Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 linux-acpi@vger.kernel.org
References: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
 <20250908-wip-mca-updates-v6-4-eef5d6c74b9c@amd.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20250908-wip-mca-updates-v6-4-eef5d6c74b9c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8.09.25 г. 18:40 ч., Yazen Ghannam wrote:
> The 'UNKNOWN' vendor check is handled as a quirk that is run on each
> online CPU. However, all CPUs are expected to have the same vendor.
> 
> Move the 'UNKNOWN' vendor check to the BSP-only init so it is done early
> and once. Remove the unnecessary return value from the quirks check.
> 
> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Tested-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>


Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

