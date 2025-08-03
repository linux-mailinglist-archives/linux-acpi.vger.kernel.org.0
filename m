Return-Path: <linux-acpi+bounces-15479-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E99AB19489
	for <lists+linux-acpi@lfdr.de>; Sun,  3 Aug 2025 18:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDCD43B4FA4
	for <lists+linux-acpi@lfdr.de>; Sun,  3 Aug 2025 16:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE851D9A54;
	Sun,  3 Aug 2025 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9gmRP7Q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C0E1D63DF;
	Sun,  3 Aug 2025 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754240082; cv=none; b=U5UiBLgnfMma7zdn6YnifPKtOclXfzGg8p/JosTssV2AThu22V6deg8YPRjAIM36XapZBQAMNOQ1TcgFahoduEDKG8RP9A425U9DTryjeuGjqTbPxD6bLDLVs3kuKVZPZFrojdjNpH6c27u8Z1HLDmyjUIMB3oLoWv8xJCkUZ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754240082; c=relaxed/simple;
	bh=013LWtY1z9ycHf9/jlJK5Gk4unBMj8NZDKNYsGQFV9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h6RJtmumOh0tchoMB7av84LAGbkeMDNFzkUrVuV2GybQNdJUiaZYB77mt1JgpHIX/a6fttJpU0ShvgU5vAlzvqmR/LvICZDT3nplH1c5S1vhcbguPhdPqE+g1BCq/+F5v4fCYo878wwcHEoa7ScRIudNh15FB4T83EsnHH6NyK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9gmRP7Q; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76bd041c431so2929116b3a.2;
        Sun, 03 Aug 2025 09:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754240080; x=1754844880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pV9w0CQoRcUYhHYMt23UhoOkZT5o/JoD/yUyCBLIk2k=;
        b=N9gmRP7QGIgX2lrvrHz01ovDZjAts5z4PIoSzB5pk/qtCv8270K9GWRPfl2Pe/HU23
         E/F3wKYKPOeMNLHkL0u84t44L2wWxENbwpj8HWD5xOOw0iMmRUekgwrDrMOsf71S4EuU
         2WGH3za0XbJwF+rwFHkpVsKHqP7c5E+T69GHt8Xq+fgNv6fs9aP3Als0fKFJemlYbafK
         +5AYwtOYABAYeJ1P7kDRY7e8OZ6woVpU0nOPwNZSOopyxMiovkOoZBualNHQulXcURC6
         7bqL3P9eJR8awAXGrfB2ZlRiXKvP+9GKEFmm67IioAQcxDDTopTaN35T4PtAq5oJv/3m
         amrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754240080; x=1754844880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pV9w0CQoRcUYhHYMt23UhoOkZT5o/JoD/yUyCBLIk2k=;
        b=Czjrsvt9eUoAN+nqV5WhDZbfU8dpj+oe1l/cMYayp5SDfDaY6/jDChnisR0/uaJNvu
         5VXlrveQ+InPowmx5DNU/66MiMBPQyfGG/hJa6/CtNB54nYLpV3TDEGJO9ShC6OFC253
         Q3i4gkYHoVdY5HQnuylzMQUbhaDPXnoRGvebtgIAReCBCwkQwpYwtW6uo+HvGGym6NY7
         jFjOu/PM3KQUHYEvJhftmG61tdiQVnGoEGVy8tCp0vuQipvo9XDbUXwjUdtBEBIejCel
         gP/kEMbdk3fuDyhQVqteV1G/MpJjtOFvH9j0wQYHDTW5+j5Sn3jch0xXg013FKRPGVdn
         yPig==
X-Forwarded-Encrypted: i=1; AJvYcCV5xt3fg1H6kFxnhIqauLvBz8u8bNKzfaUetoKW1CM5ku6jBfG8OPQgKZahFu2v3ggBZPISNtP2tKTS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx78g7iQdhp5gxeCTzoZyMIoObD81xqfmxwuNBk0ihYBHnGbOHL
	Qmo/B1tQiJ3Q5np+tWCDBLjIuWZ1RG9/IuZPQBAIqmSsvwi5jGH9HErz
X-Gm-Gg: ASbGncsPuPs8oJCTlCNGyjvcaIzwKlRVLudd0bC5T8TS9idYZOcdCeKLHlpPddkH15C
	Vi8XHMt+eCjiowCf+acGbHG4GtS7Xb3q93aMItuFX8iCVm6IvcxzjjRSYVdBt2rKS0JvzYkdYRj
	+Jl3ctGYCQ9hKSAVnbqDTNudP/07vp4ByzFN61HjcL2qq1z+/RfHrT5C8nooHEb4feDiRzJP0Bb
	Y6ILkeP1sAJXeBiXNRFjwnoudvP/fc9ovYRmTwZmXxXlVcLaCKaLnc21mTCCDRz38VytSeRCi2r
	FVjf4P5Lm+ltZHsmcl+Yw2lEk90YxpFVaTrc3T3JRsWLeVMm0LHzkEJghReZ+wWah3AEJioyM4Y
	N+w2nIytvgP5dbh0=
X-Google-Smtp-Source: AGHT+IEo1gq33O5aUys0+8ALaihfteRTIBvMO85xRSUFfSJcipaf9qogGiVbnN9HwPKG58PZb99ALw==
X-Received: by 2002:a05:6a20:734e:b0:238:3f54:78f2 with SMTP id adf61e73a8af0-23df91932cfmr10086332637.44.1754240080330;
        Sun, 03 Aug 2025 09:54:40 -0700 (PDT)
Received: from [192.168.79.25] ([49.207.53.32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7841besm7475766a12.3.2025.08.03.09.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Aug 2025 09:54:40 -0700 (PDT)
Message-ID: <b30ef694-56c2-4023-8d6e-de8f7b8e10e6@gmail.com>
Date: Sun, 3 Aug 2025 22:24:34 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] acpi: remove unnecessary parenthesis from return
 statement
To: Markus Elfring <Markus.Elfring@web.de>,
 Diksha Kumari <dkdevgan@outlook.com>, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Robert Moore <robert.moore@intel.com>
References: <20250803153829.6545-1-dikshakdevgan@gmail.com>
 <a62ff710-4216-4c4a-9ca1-b376a3703531@web.de>
Content-Language: en-US
From: Diksha Kumari <dikshakdevgan@gmail.com>
In-Reply-To: <a62ff710-4216-4c4a-9ca1-b376a3703531@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 03/08/25 21:38, Markus Elfring wrote:
>> checkpatch.pl is generating a warning when return value is enclosed
>> in parenthesis. Remove the parenthesis to improve code readability.
>                               parentheses?
This is my first patch, so i am not sure what you mean by this.
>
> You propose to omit also some curly brackets, don't you?
ok, i will include this in the next version.
>
> …> ---
>>   drivers/acpi/acpica/dbconvert.c | 43 +++++++++++++++------------------
> …
>
> Did you overlook the addition of patch version descriptions?
> https://lore.kernel.org/all/?q=%22This+looks+like+a+new+version+of+a+previously+submitted+patch%22
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.16#n310

yes, went through the document, thanks for the information. I will add 
the change log in next version.


Thanks for reviewing the patch and feedback.

Regards,

Diksha

> Regards,
> Markus

