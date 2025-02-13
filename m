Return-Path: <linux-acpi+bounces-11142-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AAFA3343F
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2025 01:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46C2167C35
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2025 00:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851B478F4A;
	Thu, 13 Feb 2025 00:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdU4/zmP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ADE69D2B;
	Thu, 13 Feb 2025 00:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739407789; cv=none; b=YBU4uBfcqqktMPcPvqfaXlchXbEzMZEAdDi4SCwEi/hpqZiGIoi0batL6Z0+guURnPnwM0X3GgKpG8C3s/RZirD+unucYbZagUW/lUdh1hB4gfUj8BFfn+FPv3terVBBlZYPse0FVy9rui2fJHgwf7DlWkeGfR+rjqAVa08Tl+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739407789; c=relaxed/simple;
	bh=sYVtl8FZw/KnddYYNyeEnoqcmmSLBcEfZci1/TGTiaY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QfVpqgcX35g/J/2kG49o/JuHF6juD8WwcGc7V6r+meyHtuQZdVJMo0Ravgsdi+7X/Qr5WBhm4nclqgCknD412Wa/0+j3w2dJNyESkX51j07yMXdu0h8y3ffw6d8AfqLbjta61EapC5hGezCT3XURIx9HHmytGe3rHSty+9Tn/wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdU4/zmP; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6f8c58229f1so3164047b3.0;
        Wed, 12 Feb 2025 16:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739407787; x=1740012587; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYZOqw5/OhnRzbkno6N9aN8DbLKnrD7ty1vBxu0VExA=;
        b=cdU4/zmPEyQrAtq4D54RMkV8LJydVAQ5aZTlqaUqzn2IlOuMJbllKM1jxEzg/0Ny5q
         pZ7rE+jzAvse9VRjHyq8XHwVGgFiBUebq4zSDK3lIKEpTpPPbF/n8M+f6eHITZLSENFT
         dnNt8MyrDsCuVKXRJFXq6PTbzs4z8t2QuhhkSbFVzbuPNOVn5s39g3lAIphiRWL9iPrh
         6q41I2VfPrMKlpyPCqAnR2mPSF91gHjk8NdKWKxdpXsZJ+2JCe9uMeEnQaQXAscnp3Rw
         UedfIRRhj3Ib9nfulBM7PlGnyn/2sFjgcBSMiyTS7IfI3vF+VYIiLmjNXND53y1IMHn7
         9FUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739407787; x=1740012587;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eYZOqw5/OhnRzbkno6N9aN8DbLKnrD7ty1vBxu0VExA=;
        b=gd7M/5lwDxMJYXKnPF3dmVpYtX7yrIZp7jipOQTVkpmLZ/IdF0LwkFMqA4dIYuaMkb
         LYptBub6O6hPwOGx/wXsIUB7N94EW3Zww4d/8no8BaBUzl/pLvdH2LptHMyHqu14xCcl
         8Ty1rd6agqk+r9lCSrBs7rf7ixyrDK/1tCTv9tNnqPpQVehTFdcku+25eZobRJFAMwIG
         j8L055g4aa31Ssa9nXywLah5qxBuMMLpdyDIRgIcIk1BuiMPqdHgBYJ+npuvaN2qyDs4
         2Zj/UugQPmaP9tfMkSoOYen7IiH/rM8yygva30/9H9COK6Ud3L6osuqTYdqQ88ZReYSk
         sZTw==
X-Forwarded-Encrypted: i=1; AJvYcCV47MqSUSNMuBAYmqhVljhXDu84R53MnZh+J05rOXU+F+a7xJMVmW0NEpjzeCNNqFXKJSDnemIPQMfP+mOM@vger.kernel.org, AJvYcCWDNICsZyjBZgEm0XX/fjyLt2P3wp5ThdG5b1H4MWrfx2OjBtjDkIlJPXLnBmjh8fdWf+izbVmPNLs1kvVWIwdOrncf+A==@vger.kernel.org, AJvYcCWivPZydsvhDpU6F0UwjtPQo0FAxH8Th1TUPDzAyOt88mWgC0Xz0MpT2pO7IOStk58FznymsJaP9CsM@vger.kernel.org
X-Gm-Message-State: AOJu0YwyLr9HKAOc8IEAkTr9lOjW0ZfExpXcvWU5vP07YcNOqQvIKb/s
	ncHjS+VJkIl59cR+rzc+ThRimzw12xyDMi8Ha8KbgutntTAf63mw
X-Gm-Gg: ASbGncs8MtW28XECl0J/cxJmcKX0M1F5DWv8P72zqmDyihUlmAXufLYEUR9W4CiPGmS
	6sweS0pUB8XqAJDhFO8ELMbkN5CgRHiGF9k6Njv7/HpyyYn5clYsBwQxswUC7uuLXJIG2aX9hd4
	m3nbANnQyGJHr8lg9nG3aMTYNbrr+e+bfw6RB4KttGXdRYy9uZUD8zQQp9hB9Rn6Drr6ftDG8Cg
	3A/8NEEmZCzgDvG8xGkBcMTZKheWoi9VTAO2WWFbovSUsoNifs52elZpp8Bu1TkzVsvSfHsUD9Y
	wD9XeQA=
X-Google-Smtp-Source: AGHT+IHLQf2z+d7k2tHxcynkcyeR2Zh1KSOpqfISMKxTQt2wUce1hspeacEBfZxyhIVm5uXy4pJVvQ==
X-Received: by 2002:a05:690c:6007:b0:6f9:4b81:3dc7 with SMTP id 00721157ae682-6fb33e86b72mr10587897b3.1.1739407786682;
        Wed, 12 Feb 2025 16:49:46 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:4207:a956:ebad:2a64])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb3605dab4sm572227b3.37.2025.02.12.16.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 16:49:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Feb 2025 19:49:43 -0500
Message-Id: <D7QWLKBQ69RZ.1BIAN6FNN7V9B@gmail.com>
Cc: "Len Brown" <lenb@kernel.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Limonciello, Mario" <mario.limonciello@amd.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v2] ACPI: platform_profile: Improve
 platform_profile_unregister
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Mark Pearson" <mpearson-lenovo@squebb.ca>, "Rafael J. Wysocki"
 <rafael@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250212190308.21209-1-kuurtb@gmail.com>
 <bc0a60ef-bdf7-4f48-8215-891cb1efbdf5@app.fastmail.com>
In-Reply-To: <bc0a60ef-bdf7-4f48-8215-891cb1efbdf5@app.fastmail.com>

Hi Mark,

On Wed Feb 12, 2025 at 3:41 PM -05, Mark Pearson wrote:
> Hi Kurt
>
> On Wed, Feb 12, 2025, at 2:03 PM, Kurt Borja wrote:
>> Drivers usually call this method on error/exit paths and do not check
>> for it's return value, which is always 0 anyway, so make it void. This
>> is safe to do as currently all drivers use
>> devm_platform_profile_register().
>>
> I was worried I had mucked that up with the revert done in thinkpad_acpi?=
 But it's not checking the return there so I think it's fine

Don't worry. I was aware of that :)

>
>> While at it improve the style and make the function safer by checking
>> for IS_ERR_OR_NULL before dereferencing the device pointer.
>>
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>> Hi all,
>>
>> I made a little modification that I forgot in the last version.
>>
>> Rafael, please tell me if you prefer different commits for this. Also
>> should we WARN_ON(IS_ERR_OR_NULL)?
>>
>> Based on the acpi branch of the linux-pm tree.
>>
>> ~ Kurt
>>
>> Changes in v2:
>>   - Get reference to pprof after checking for IS_ERR_OR_NULL(dev)
>>   - CC Mark Pearson (sorry!)
>>
>>  drivers/acpi/platform_profile.c  | 19 +++++++++----------
>>  include/linux/platform_profile.h |  2 +-
>>  2 files changed, 10 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
>> index fc92e43d0fe9..ed9c0cc9ea9c 100644
>> --- a/drivers/acpi/platform_profile.c
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -569,24 +569,23 @@ EXPORT_SYMBOL_GPL(platform_profile_register);
>>  /**
>>   * platform_profile_remove - Unregisters a platform profile class devic=
e
>>   * @dev: Class device
>> - *
>> - * Return: 0
>>   */
>> -int platform_profile_remove(struct device *dev)
>> +void platform_profile_remove(struct device *dev)
>>  {
>> -	struct platform_profile_handler *pprof =3D to_pprof_handler(dev);
>> -	int id;
>> +	struct platform_profile_handler *pprof;
>> +
>> +	if (IS_ERR_OR_NULL(dev))
>> +		return;
>> +
>> +	pprof =3D to_pprof_handler(dev);
>> +
>>  	guard(mutex)(&profile_lock);
>>=20
>> -	id =3D pprof->minor;
>> +	ida_free(&platform_profile_ida, pprof->minor);
>>  	device_unregister(&pprof->dev);
>> -	ida_free(&platform_profile_ida, id);
>>=20
>>  	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>> -
>>  	sysfs_update_group(acpi_kobj, &platform_profile_group);
>> -
>> -	return 0;
>>  }
>>  EXPORT_SYMBOL_GPL(platform_profile_remove);
>>=20
>> diff --git a/include/linux/platform_profile.h=20
>> b/include/linux/platform_profile.h
>> index 8ab5b0e8eb2c..d5499eca9e1d 100644
>> --- a/include/linux/platform_profile.h
>> +++ b/include/linux/platform_profile.h
>> @@ -47,7 +47,7 @@ struct platform_profile_ops {
>>  struct device *platform_profile_register(struct device *dev, const=20
>> char *name,
>>  					 void *drvdata,
>>  					 const struct platform_profile_ops *ops);
>> -int platform_profile_remove(struct device *dev);
>> +void platform_profile_remove(struct device *dev);
>>  struct device *devm_platform_profile_register(struct device *dev,=20
>> const char *name,
>>  					      void *drvdata,
>>  					      const struct platform_profile_ops *ops);
>>
>> base-commit: 3e3e377dd1f300bbdd230533686ce9c9f4f8a90d
>> --=20
>> 2.48.1
> Looks good to me
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Thank you very much!

--=20
 ~ Kurt

>
> Mark


