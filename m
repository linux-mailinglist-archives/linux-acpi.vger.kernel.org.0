Return-Path: <linux-acpi+bounces-10074-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CDD9EC355
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 04:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77FD188A437
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 03:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D09211268;
	Wed, 11 Dec 2024 03:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="hl4Dsv4m"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19511FCD0B
	for <linux-acpi@vger.kernel.org>; Wed, 11 Dec 2024 03:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733887832; cv=none; b=hfEYBa+jhzDLDDMHRYqtNCeImN/1w8jnd4Az1bnB933EytTwPyh+nS7TIPK4fFLgSosrStTQsEN4MSrtSFJW3YQLk4Bg3NpZtTBlSnopeJqzda4faqDLJbQ4/G3zr8TqluAXcHOup9CVJOWd71IrMdjKoATT0RYCqWABgff1Mqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733887832; c=relaxed/simple;
	bh=zT5MMkeVxdAxKNaqETEGqXnG8bqp0IPR3hmAjjBhxgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPEWFIinGVcc3idUmFrKJ3xVahOgSr9vBPoK7m1tun5IZxlkdckRUfDPBgaj2iKa5TA/BAqlQZspFXZ1whhAzfdQCuJGUoTDDjlhpT8s7q9qVP+0EKkgw7gZYHlmQMXdJwU1IZonvKNUxgIURxYDDt/556ZOlviEzuN5TaACaD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=hl4Dsv4m; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21628b3fe7dso36804875ad.3
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 19:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1733887830; x=1734492630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nmKkjwShwXSsCgYfsWDcGD12PQmjyh1tzh4JMcmOWUQ=;
        b=hl4Dsv4mXI8n1nPx7NWW7NCN1gPwJYyXzPbXkjNvEP5AutQklCC7escdRTVZaI64jK
         4CT2qWF37PL6w7dndTTpYhcAEacOel4bPOAhNqoyQ2mCroO2iHQDNbdXcKfyE/zAaGzj
         +MYqxO+dE8Beapvq4mUHaDZlSE2BtXvR8XBU5ptYyg7HZ9KBA9czbLo1zhchU1l9XQkZ
         p/rl8FmQnX1pqLjnAupkpMnE0UL5kp4IgX+KnJnv4ZLT3mvDjRvSnRD+FdhvDtIJzblK
         T8WR+cCSycEdYQmXxUE1DDZ6sH9ztHLYUcUF5JH+091BdiGKW8jJeD52Me3rfM+ln1wa
         hHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733887830; x=1734492630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmKkjwShwXSsCgYfsWDcGD12PQmjyh1tzh4JMcmOWUQ=;
        b=w/SWJYGJM7RXjsUgRcfaILgoPol4KAg+3I7ZrxxLnnha/wFSqVD3b2xWhSogONH+LX
         vQgwCwGA7BGlXNZcVPznv52w2bjt6zg9vsYKCnKywA6eERogaxIygyY0hm5oHkfsHOGM
         +X1OfQKnqZWkYot058F3yyQvMvQ7W+kpenh2piTo/wI1O6MUo7U42LI/Q1jOE0t9M+fB
         K6npyYjPFsWhoDVOkis82qUD2qDHHZpn+ZnXixmHpVbg9y7u16Bi2M02nyOQoO9x90qr
         TzWQ/xkyUaWxASdKowbUspj6R+kI3upzmgSaKHwlDQnFo1pvUgPiM6T99XlrbsZxRFvz
         9yhw==
X-Forwarded-Encrypted: i=1; AJvYcCVGytN1G/DP47+KchNnTVHR5L+YJx/oSIl+LQ6iYazki32IKTZzXIPiwrScK426QSo5OfT6zg0/v1gQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt8U4DYHDCP6Im7ItCmbk5mYBDDmqmDaaK5pDlFTDQZtb1NmGZ
	ijhMTfXSkyjle+k8uRxrlN4ahmW07QOmevW/VANsV87O006FJ8yOVxmzL231aiHmXCgDJDrTbDf
	EfqwdJA==
X-Gm-Gg: ASbGncvFp2iqPqM81at3VeNcpnJ81oWqbEo8lbGz3hcEoETUqNsanoGMzQDlP7eIk19
	3Ge2k/i40hfg58qrwQtAnNgftXU+oILjCOwZozJ4j4W+/FNbIiTwb4UT12Gsj+m99bBDn05IpyF
	Lmk3mUD8LlCPLLdztbLOwAY59yj/8YL5NwE5Rvxy4K3KX2O9rx9zhnEmMeRLro4p6iauUtkMDrq
	sEYPIEt4uX+cfl5U5rvFOzH3U1UcHE6whdhK6k1fHC+X1rFYl8eTozutXEvHYIKhIQSUPkNqQyo
	Gz6Vay3ZZXP0BMdswpRM0BzpnDUrj8g=
X-Google-Smtp-Source: AGHT+IG8wl4DRVKtbNL6VdgMgG8Re7lvavhEJFz6Tn1rhjJZPMnMOjNeoNM09rqEWPwpaEulSp6xVQ==
X-Received: by 2002:a17:903:1d0:b0:215:b18d:ef with SMTP id d9443c01a7336-21778534b33mr25823235ad.25.1733887829851;
        Tue, 10 Dec 2024 19:30:29 -0800 (PST)
Received: from [192.168.0.78] (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd44fc859asm5126385a12.51.2024.12.10.19.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 19:30:29 -0800 (PST)
Message-ID: <885b6efc-a294-419c-9161-8c5de94e9c18@pf.is.s.u-tokyo.ac.jp>
Date: Wed, 11 Dec 2024 12:30:26 +0900
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: fan: cleanup resources in the error path of
 .probe()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org
References: <20241203033018.1023827-1-joe@pf.is.s.u-tokyo.ac.jp>
 <CAJZ5v0jywmZg3wEdtF5i7s4nDNi5XCh3=toH+dNOjGvt4ozFGg@mail.gmail.com>
Content-Language: en-US
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <CAJZ5v0jywmZg3wEdtF5i7s4nDNi5XCh3=toH+dNOjGvt4ozFGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafael,

Thank you for your review.

On 12/11/24 03:42, Rafael J. Wysocki wrote:
> On Tue, Dec 3, 2024 at 4:30 AM Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp> wrote:
>>
>> Call thermal_cooling_device_unregister() and sysfs_remove_link() in the
>> error path of acpi_fan_probe() to fix possible memory leak.
>>
>> Fixes: 05a83d972293 ("ACPI: register ACPI Fan as generic thermal cooling device")
>> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
>> ---
>>   drivers/acpi/fan_core.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
>> index 3ea9cfcff46e..8e3f62a3745e 100644
>> --- a/drivers/acpi/fan_core.c
>> +++ b/drivers/acpi/fan_core.c
>> @@ -379,11 +379,14 @@ static int acpi_fan_probe(struct platform_device *pdev)
>>                                     "device");
>>          if (result) {
>>                  dev_err(&pdev->dev, "Failed to create sysfs link 'device'\n");
>> -               goto err_end;
>> +               goto err_unregister;
>>          }
>>
>>          return 0;
>>
>> +err_unregister:
>> +       sysfs_remove_link(&pdev->dev.kobj, "thermal_cooling");
>> +       thermal_cooling_device_unregister(cdev);
>>   err_end:
>>          if (fan->acpi4)
>>                  acpi_fan_delete_attributes(device);
>> --
> 
> What if the creation of the "thermal_cooling" symlink fails?

Should have handled that case as well. Fixed in the V2 patch.

Best,
Joe

