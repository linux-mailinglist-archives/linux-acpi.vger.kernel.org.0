Return-Path: <linux-acpi+bounces-15476-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2ECB19453
	for <lists+linux-acpi@lfdr.de>; Sun,  3 Aug 2025 17:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3AE33B5745
	for <lists+linux-acpi@lfdr.de>; Sun,  3 Aug 2025 15:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF94686323;
	Sun,  3 Aug 2025 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhF1ktgw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511A545C0B;
	Sun,  3 Aug 2025 15:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754234343; cv=none; b=eSbaQk4DAFU+Os1cJeKn7MMGD/a9syRRL+WKTuZZtonTkk3f1vSlPqReDNsmJkjShN4gNKPMqxcCo8+XusMoBi4qIi8woRMTXo5AHeoyqXaXsP2gynO5lR4PxPpLt1INyAvKwwitxAWU6cZRzZHqj60ED6DiIk9y9poAjPbSdHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754234343; c=relaxed/simple;
	bh=d3H2Jph/g4WDb6GqjR/EPGGTLoQy6mxK0lPyvJAmrM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=appkktG7oyC+31+BYpvnWNOqziAybBNPo0rld9eEU0hjAGoEGpvFsr4hKiiqKzN+4rocckA6fpoYXeV5/v0/p42kBpnE5dfGjlrfyV8rUg8Tw8A+UQwod7sdmK2ELqDOjhaZoATic+sXozt15PCPo10J+PNliq1JF1qZ7I8HoVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhF1ktgw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24022261323so50108005ad.1;
        Sun, 03 Aug 2025 08:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754234341; x=1754839141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=06WlQZvc95e6tu1m31wg2n9UbhWFSIaIxMCBHlx+fTI=;
        b=ZhF1ktgwECRnZ2+r6qheZnJrgG7SOFbn91Q9pSu5eNCKcTazG8033+i2Ts3uT6v656
         Ifdx1F75eOf0HJLBo4w/WP1LtawJoqOGKV/ZZF+wpk+4G+GB1HG00XIHd5oXnoBmnYts
         NFpyof1I+3SsJm0nxeApLAYa7LU0rhFEFfGidImSUOYLozLhC04y3GOtotPCG+U+YwtI
         IKw3l0Snz3g84FNwDwFuXgaGdcTajbHGaydIACx6f2mdh8eHq3v/uDPdQf9fxCuhJb5y
         XqU61YWPbceHP7wMqYZ9bpKHFCMncfs7N701aESzJpudQscL6E4eQAKHLI5knPW8IwP0
         b4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754234341; x=1754839141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06WlQZvc95e6tu1m31wg2n9UbhWFSIaIxMCBHlx+fTI=;
        b=nFAPJEnv8Qc7L7Q3xmUxG8uA++pV50FLxScMIr29vmIMhA5iiZXwlDCahlzAKH1y+l
         EIOwA5kV6D5zxJ5CcMW4yQlN6/NMB6KPzP1kd7vO1fcolHy7t84JPPgs7kSnCaFjbtD7
         RvUmh5t+M81XNKb3VKRZOXDrp+GDLrQHEqDb5AOEncliDDG+DL6PjdFuuGt5LPe/CIjv
         NVUxl1VM4rcHWNAUoUIbM2LxHw82dpZGH4ULS8gytetQu+TlWck8IA/9qOg4WLwHahFB
         k61U5SE9IyTTi8aD38ibrn1H1eW69NLuqrg64MCYvxx96RMQqMYdLbb5uYjJGIVOFhXz
         k0CQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0sBSq7vJL4ZotWkTs/KHDB3Ksi7IsCfRAkSQJqOL/InyKxkgNnMiEQS/W2n247/dTcraaxG4JKqlK@vger.kernel.org
X-Gm-Message-State: AOJu0YxE2V4+0x57TOLXoRvrRKB/wwYio1S8hkwymWKLA8KQUuoRAPjk
	bc8t0NKau8tT8BdBQ8BX4QudHd8D/KUWv7Q6N4ZU3Pjdaxd8rRx0BAIv8AhsHwo0jPU=
X-Gm-Gg: ASbGncsPqtd1fvI8goA9hPIK01PXpgBp5/KtamPQiZ+sKv0DgMDgu/zy9O0Xe6m5N5+
	P90gJAJxyObjp+ajv1IHZOu/XdAMnmQYK9sGF5oqUVf1Esw8/MUcwnF3CyoPoEJzbKB3J/e+rGK
	ztq34LmerBVALP2wAM18sf5JDKeXYiFcH0NH5Qj+vOJv9uEqTE5U71NpGBjxfsbw1cJXegQcmYm
	tJIxB6gHktTAhbzKMXllRk8aAlcDYmwuPEicaQrFtny0rHRawcEw84JLkF+s+K/c1lZMukq9Jp8
	Mi9ndn8/Ega22dVkhV5pBC4mMq6JdxMFIJt0EM5hUwH4uHnnAOZoltApbe+1nURlHK81oiuQOef
	/Qy5e5QtCbjrLFwaCZo3HpoG/LQ==
X-Google-Smtp-Source: AGHT+IH8z5C4cgFVB46EZ6EcLxXVP2IuAJ73Mv0m6YfE7gDH8wiOl+kj7/uI2bRLax+fa2YqBaV36w==
X-Received: by 2002:a17:903:2f88:b0:23f:c760:fe02 with SMTP id d9443c01a7336-24200a610bcmr182344905ad.9.1754234341352;
        Sun, 03 Aug 2025 08:19:01 -0700 (PDT)
Received: from [192.168.79.25] ([49.207.53.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89771e2sm89000425ad.88.2025.08.03.08.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Aug 2025 08:19:01 -0700 (PDT)
Message-ID: <9b3fe152-2798-4c3c-8fc5-29cbdc7c336b@gmail.com>
Date: Sun, 3 Aug 2025 20:48:55 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] acpi: remove unnecessary paranthesis from return
To: Markus Elfring <Markus.Elfring@web.de>,
 Diksha Kumari <dkdevgan@outlook.com>, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Robert Moore <robert.moore@intel.com>
References: <20250803113820.16578-1-dikshakdevgan@gmail.com>
 <50cafc07-563e-41a7-9286-54db8a7ac731@web.de>
Content-Language: en-US
From: Diksha Kumari <dikshakdevgan@gmail.com>
In-Reply-To: <50cafc07-563e-41a7-9286-54db8a7ac731@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 03/08/25 20:06, Markus Elfring wrote:
>> checkpatch.pl is generating a warning when return value is
>> enclosed in paranthesis. Remove the paranthesis to improve
> …
>
>                parenthesis?
will fix this in next revision.
>
> You may occasionally put more than 58 characters into text lines
> of such a change description.
Noted.
> Please avoid a typo also in the summary phrase.
>
>
> …
>> +++ b/drivers/acpi/acpica/dbconvert.c
>> @@ -32,7 +32,7 @@ acpi_status acpi_db_hex_char_to_value(int hex_char, u8 *return_value)
>>   	/* Digit must be ascii [0-9a-fA-F] */
>>   
>>   	if (!isxdigit(hex_char)) {
>> -		return (AE_BAD_HEX_CONSTANT);
>> +		return AE_BAD_HEX_CONSTANT;
>>   	}

will fix this in next revision.

Regards,

Diksha

> …
>
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v6.16#n197
>
> Regards,
> Markus

