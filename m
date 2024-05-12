Return-Path: <linux-acpi+bounces-5776-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB6F8C36F1
	for <lists+linux-acpi@lfdr.de>; Sun, 12 May 2024 17:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5465B20CF8
	for <lists+linux-acpi@lfdr.de>; Sun, 12 May 2024 15:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A7F2F873;
	Sun, 12 May 2024 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lo1gSMre"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B773636122;
	Sun, 12 May 2024 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715527207; cv=none; b=YN8bfd9RgjlW8DD3oGLNpOTwCkE3w68LgICT4WXyIim3K2RXS/TQXfUwSo5pWmgE6dc+mcSWpfWzcQYIQTY+xBSPdoZ2TAwvYgL6xeDJGLY1TN/UKi5QJCOlBfSoaTtNLBPu+tbOPRpA0oDScvyyqTxPYQReaL9BARi+2+4FRNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715527207; c=relaxed/simple;
	bh=sKz/vCxOFcJztSXUN0nrES3JoaGgin/w+NBH5KDpWD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CvvrumdOWBs/NHqDA27P0/hm+iRy3MOxnjzBP9kUmxHYtsWZVEVUzFGD0L9SlpisToDJk66bUuieYpmcnRcsNtxXqyiFDe03cR3WV5CCuvOCvUM//t5Egp66QuIAqs+1j/aN2BwkyjZoRLNiG0t5pelfQAJCvRCs5Zcop1pH7Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lo1gSMre; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ec41d82b8bso33926895ad.2;
        Sun, 12 May 2024 08:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715527205; x=1716132005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=cIa1eL5zjqrgZiK7tQDMfCMELbeJgMi/BExOPYfa0vc=;
        b=lo1gSMrekMPvH+qtj+VTKtABKBgKoCLCr5dli9amyx0+RDpClOdFUtzBp3qfqYn5dH
         59CdvfMGnR2Vpn0t51NEYietGST0t5CpiiAiiHAcLvy1n3LQGakYkc7Mo8nxE7erJa/4
         shOx014HcxmJDX8y5/57JGqB+KiesnAIptP9C7Rx/jq03OA45hdjaWZOFC7pWiBRFUHr
         LuCi0pW0MyB/hYNoSXspWEzYobZJLu5cN8ZcXg6fvLykXy6O4lP881tR+rW9JjRMrQxJ
         67ffFmrTl8jjnOr3P8m0wXivWn/xqzG5XK/qm1+Xo8TjRz2EZG1WHI7KOaDab8YkHAM+
         hGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715527205; x=1716132005;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIa1eL5zjqrgZiK7tQDMfCMELbeJgMi/BExOPYfa0vc=;
        b=RrsxjG+iXKIY/O8nViS20sS8nOQRSuuomTkwM5tKxw483/sU2YIJ+8eAmDcF5Jxjbt
         K9s4oGqWAk57b1UWrx/QLpGVRJUVSNVbZSnKVggPlYZqYpIuN8JDBPQkTSoP7tpN4M/R
         WIW516+qHwUELVCjLMCW6m7FvHjm5V87GIWVcuNhyesdGHbXTf9r8m0fdYKnB+sBEjq+
         k3VpTYosPlJqmqOLX4mFq11dQlccARX13jA9SKCsie1xGKfZK4fIAxdIxavKF8uwxKC9
         0q1V4M6PVpPZHAAj2wuwtJ2MvDtfGLEFKW/fgwK6XXDNOr3SIJK40jYSUL4FqDL8jvyw
         Nr+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbUhUaWmSSjrWDOToisqOGbggL9IdPYCfwbDQJ2D9xPko5HbaPuUQJjvwVSC/NSNxbVBIILhqV6XyxaGcm/YEOxqeFR3BH0eVkgAaOQHi+0Le+zf7L/F+qYy3UfWR7A8REB59r7Iqc3YGzecgccfxu5DIl1nk+ZdNrkKGo13at4THv0g83ifjSZ3rqoPCxoFhmfMYoALDLsTgWuWGPDnZIExadKjCPe48N3g==
X-Gm-Message-State: AOJu0YxebhZs6a8KL7JGQCf7MsDAIRBg1keowEGMA/T5F7ozzNO5qgF2
	iZc1LAdH8Wz5J7ndRQoZxHutmONE66Fzc/CzbR9eRCA4hDsLNQL2
X-Google-Smtp-Source: AGHT+IEq84hbL5SBxGGFkfTufGVxF7SnIK9nZyyyCSYzCCnVKLiyiavy7v5hrdblFYWv4sdZtmoiDQ==
X-Received: by 2002:a17:902:ed89:b0:1de:e47e:116c with SMTP id d9443c01a7336-1ef43e26e66mr72697085ad.39.1715527204849;
        Sun, 12 May 2024 08:20:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d166esm63128815ad.36.2024.05.12.08.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 May 2024 08:20:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9f6ed1f0-3615-43ce-8d0a-23d1f6a23669@roeck-us.net>
Date: Sun, 12 May 2024 08:20:01 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] ACPI: fan: Add hwmon support
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Armin Wolf <W_Armin@gmx.de>
Cc: mlj@danelec.com, rafael.j.wysocki@intel.com, lenb@kernel.org,
 jdelvare@suse.com, linux@weissschuh.net, ilpo.jarvinen@linux.intel.com,
 linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20240509221947.3118-1-W_Armin@gmx.de>
 <CAHp75Vd9JZxuDGYm2drSYun+h2CAU+Lb4BEFq3LnQYBKpOfyMA@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAHp75Vd9JZxuDGYm2drSYun+h2CAU+Lb4BEFq3LnQYBKpOfyMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/10/24 06:30, Andy Shevchenko wrote:
> On Fri, May 10, 2024 at 1:19 AM Armin Wolf <W_Armin@gmx.de> wrote:
>>
>> Currently, the driver does only support a custom sysfs
>> interface to allow userspace to read the fan speed.
>> Add support for the standard hwmon interface so users
>> can read the fan speed with standard tools like "sensors".
> 
>> Tested with a custom ACPI SSDT.
> 
> This most likely fits the comment/changelog area and not the commit
> message. Also would be good to put there the link to this custom SSDT
> (like one of zillion of pastebin sites, or GitHub, or ...).
> 
> I was under the impression that Guenter gave a tag, which is missing,
> but no, he just said it's okay to go. Guenter, maybe a formal
> Acked-by?
> 

I said

It all seems odd, and I returning -ENODATA doesn't seem right,
but then I don't understand the specification or the logic behind it, and
I don't have the time to read and understand it. No objection from my side
against moving forward.

This isn't sufficient for anything formal. Just go ahead.

Thanks,
Guenter


