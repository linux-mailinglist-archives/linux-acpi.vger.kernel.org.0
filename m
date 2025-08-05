Return-Path: <linux-acpi+bounces-15532-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA5BB1B879
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Aug 2025 18:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DA5C4E03A7
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Aug 2025 16:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA884291C1F;
	Tue,  5 Aug 2025 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOnhD7gO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE2472630;
	Tue,  5 Aug 2025 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754411269; cv=none; b=jbhSZaF7bWu1gcd9pJYcT4++SezLCNk0/fb3OTuXcdblYbZVZzuefoJTHNJCiLDbquLlKwbTD3ValmQYJG3cQoNdoXNG24b1pXoUEEWqv+2zO3C1lARflvS1EJglVjzxSToGVZEgSgrdTwxt4S8BSwfX8F5c6hDxJGYcrIxCYIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754411269; c=relaxed/simple;
	bh=5BJyQyJpgV+yQh2Ditn8oy8a04n9ISc9q8hHHgTLqBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KxcgI26KbH86DT62jSjVOBRObHDGtj394/UbH4GSrBdGRpopqQEquYZx+lefyHnhCCyBMSfn+ss3segzSXLVTn6hs9UAL7gFuNITnmRwq02viWnLtKLqqEPZl87b/fhtdYbxKkXkVmFbSt4TLGwinB2EZ4hSRohUkAzlRZzmTpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOnhD7gO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23fe2be6061so519865ad.0;
        Tue, 05 Aug 2025 09:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754411267; x=1755016067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+3O50zNUML0rXrgIz2L4u9X6MchbPe/SOppfxHs5UVY=;
        b=UOnhD7gOSdrochvqwP0lOpDYrwADZkM0D8Kv42fL/4UtlgSqMmpf+SzyPlVthB7dRS
         tIKqDyMpsUXMNBW2kNSo+w+2QTomgOsjEaYwWSaWivvJShtCu9SqFmSZ8bGIfV8fIoYN
         QtBQARj9Ghe3PNIP4JLi6Y2fN3q683RkRK+qA5n/tr6L9yNQ7e+fxNwxLQ5mPP5Lmdp1
         q7ChCTzxkt78gPMuh1SsANm7IA07t9e3aFs2ZaLP8d6EVEkaJmHE0krgTzIyyu0gB7cZ
         gBnF6qZ8/dIoIAL55UcLPOy2klHDqPO8mVUaJH0Two9r83J93AEeJxX2rNc/DOPfkLqr
         w9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754411267; x=1755016067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+3O50zNUML0rXrgIz2L4u9X6MchbPe/SOppfxHs5UVY=;
        b=I2khUOIUkS+9bNOY+ff7QHNtddRWkv0i5UhQYMAg/rqSn/AsksA/f41bVc9TI9so/b
         8StR27DT2iN8Yn28jOGM0TIpPbGhgcKc2qFYJzcucmK509x0kjYhYIToVeCFmpe5Juvz
         zrkgWQqNexGVcVS+yMdriQrZCc7rJfEgMqx0msdyIwdgoF+dI+aK37xCbinLnhuU91Pa
         wIhg90eTVQnEALIbSUeIGYqo30ry54xsfq2R0gXBlgvg+UTN8S6xpyeVTndeWnKX8Xu6
         LyoIEt2jmgamuSNdaXXNpQTHBhS6E9QOpVFa7jAwb/2GgqGpFmSfX47L6uFEfwnEepPr
         3WLw==
X-Forwarded-Encrypted: i=1; AJvYcCW4rwAoUqFA/g9/gSj6nzl9/OTQ9l4ZWuaB2MOPgfMd3y1Jh6EfAHcIQ8wt562WIH+QtZqTi6lO/j4F@vger.kernel.org
X-Gm-Message-State: AOJu0YyzviTgf5lPS2bJFcTtPlEy51LQ2dCs+8HBZCruL2ocu79eOYSe
	+WZ4dYJ1rfJDS1idRIfmI7S5e2+hUbarD50dxagDh5TiY7ab33q8Df2gBB0zNMow
X-Gm-Gg: ASbGncsLWZ7WuPAnO722TfhF92ptrZLIt0YsDI1w9VJ0/YnyGMPp15X7NYGVi4WYZEc
	8hrbwXsSNFXw+eRGirqAorVEmc65siiyq/MiVepYQByI+kgAzu52shNxBHwf3fTJeNOmzpxK+NM
	zsX5Apzc42EedqEQEyU8yM+kOZV+9bnYj0vTGatT47QOOAwILYKyjMhHGWSbKl5XT9bAgltzjIo
	rGWnRyfoXNikL35VackYU8NoFNVtDKeZsgy00R5fdtuf7zDONChPr+KtuHSyh+0u5epNND/Es+p
	nVbXZq+dqYPpOgMMD+XwzyCyXaw/NIZBcvybxbJFK22dxCc9vansYB+13m5DnMqd1VHvehY0is0
	vbYAnUWc7V7p3KFcmWEHoilCb1cAFBidPaB7vs2XV9SmWwojLXqSjrbeE595o5XePkC8qq9UIUL
	rt
X-Google-Smtp-Source: AGHT+IHd19vjUFBW1J+x03NMEuyJK581n036vQ9x7nKm3KkZ/4nVoUzKV04IA+ulDj2XieVTIyuOvA==
X-Received: by 2002:a17:902:d508:b0:215:b1e3:c051 with SMTP id d9443c01a7336-24288d2ef67mr49304575ad.11.1754411267413;
        Tue, 05 Aug 2025 09:27:47 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f27:8800:d28b:e1ed:c83b:1281? ([2401:4900:1f27:8800:d28b:e1ed:c83b:1281])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0f7bfsm137074095ad.41.2025.08.05.09.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 09:27:47 -0700 (PDT)
Message-ID: <4dc74bbe-da7b-4f40-a5e4-130ef20dbaa8@gmail.com>
Date: Tue, 5 Aug 2025 21:57:42 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] acpi: remove unnecessary return parentheses and
 conditional braces
To: Markus Elfring <Markus.Elfring@web.de>, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Robert Moore <robert.moore@intel.com>
References: <20250804185826.29723-1-dikshakdevgan@gmail.com>
 <927e03af-6682-44c5-9225-fb269b0a6e1c@web.de>
Content-Language: en-US
From: Diksha Kumari <dikshakdevgan@gmail.com>
In-Reply-To: <927e03af-6682-44c5-9225-fb269b0a6e1c@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 05/08/25 01:54, Markus Elfring wrote:
>> This patch removes …
> See also:
>
> * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.16#n94
>
> * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.16#n658
>
ok, i will do the changes in the next revision.
> …
>
>> These changes address checkpatch.pl warnings and improve code readability.
>>
>> v3:
>> - Updated commit message
> …> ---
>>   drivers/acpi/acpica/dbconvert.c | 43 +++++++++++++++------------------
> …
>
> Please move your patch version descriptions behind the marker line.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.16#n784

ok, will do the changes in the next revision.


Thanks again for the feedback.

Regards,

Diksha

> Regards,
> Markus

