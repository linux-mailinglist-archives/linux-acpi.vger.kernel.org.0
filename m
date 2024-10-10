Return-Path: <linux-acpi+bounces-8690-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4577B999205
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Oct 2024 21:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE2E1F261C8
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Oct 2024 19:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C6819DFA2;
	Thu, 10 Oct 2024 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QegfFLXu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174B915B0F2;
	Thu, 10 Oct 2024 19:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728587759; cv=none; b=MvdbSgBqVkmEJj0z68cmxY6Do4OjFim9hs2IMu0dAUumI5jEUBd25fsj8mI0aVeE9XddN6Wrk3Gf6NT7XA08n74bTwLgHTT9+6dYjdV7E624/JEGJHIrXs02shUWOAIz71o/eOF+4W3Vr+6P+zkR98dUHTgpfzTAQlTFcXbs/RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728587759; c=relaxed/simple;
	bh=eb3suY3zlniCKZkcu2EtYXos0KCvlIUBpsS0SaS9+ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vBERBozcMaSqi51wD5mqGquZLvI6zG4iqdLQF2RokYdubUgy5Hp/GOcLH9U185gdRp/zWrO1z60saNmAq+JJfUIBdx+biQYtHEIvZMjWWWM49IExkB/D82oKaWVbXi0b7FDhuaye1VF8ns7Mo6ylLsvBTU5fcXxKvZhtDhkq2zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QegfFLXu; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fac9eaeafcso14652611fa.3;
        Thu, 10 Oct 2024 12:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728587756; x=1729192556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DGEt1GNskh8ogSkNTTUTRly98dXsZVKOQebAZzWVN5s=;
        b=QegfFLXu4m6njSSGaJx/nrW2/wOlPn59i9R513JeVrJQ2YD87AUSA2mE/tR/IP7oT7
         lToDkAWMVFbceW0ww+PvVKRine7SRGxBRc6dgsYXC3FQQkWKzIm635AvLW6ofJdhqHQS
         G/MuTToKmoXStsWnqR3ItQ8MqzHIFZHEsLhZEzBinqsUoMmxIAe2GznWrjsX916kL4I9
         Yywv3RVsOMx1rBscXmLPBcxYF/khTjy1lS2FVQHcsBWGITFRKK/PWX24HwhdZ4ZzyLpY
         IKJ7mBY4HNSoQtb2ApcLuQPxKtc5clvcpEjywQB7URmCLel4RGoaAlHYiO9LCRYL2Zmn
         JmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728587756; x=1729192556;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DGEt1GNskh8ogSkNTTUTRly98dXsZVKOQebAZzWVN5s=;
        b=BZDgqsoNVilxnyx1My+cRodf1EOxhQnplWbOOW1nel7E9rXL/kh+0i73Bw/oL6/Mgv
         TRgEoYUyPJQKgmobz2ltSd5nAPbgszjapOoiX25mpHXvkV/EVUWUJ2eiAuftD4DIiBo+
         eQtxyKNLPSib+VTB1YTy+DFbUPq8BfFhzfo7yTH0964YwBDSrzVETPXbqxAX7z6XsZqy
         28pSiPMp0NVl7B539jR0ZG0jNCLVyI+Z4BGTe0QbcjxWwMCKMJ1kqwmbwhFSjxjIl9vI
         4hUUXXw3JcGzYSJv51Ix+FL3aln+fM795cm5x/4vyk+dPhVxFRaX1cU+JgUvOBLPYzyW
         x3+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQNpjU5iuMN3X9hH90OVCDx7rAXq5xHQZlTcJ8wrnPz+osNopBVXX3fDl5Zl1UE0aMVjCeIflw@vger.kernel.org, AJvYcCW9cjegVyx5J+cfqHudTtUiYTULtF1XGZPxEnow3Gax08jQD7taQ8Zw3szofZQ2Rv1ddhpp0KZRqKkO@vger.kernel.org, AJvYcCXP1Yuawb2rR+4r8F09f+Mr9LBSWG6AWJ1rKfYERFXi9fRbnFgeswcLEaOs7DN51rsRI4gTbyo/zjTSenkl@vger.kernel.org
X-Gm-Message-State: AOJu0YxWA6bk8Q+WDGESpmGO7dzC4O3xHdPZmfIWvGmo2lcOMM0flaUH
	fNATc0fTAAloxPgwkbxpJLd4NLi3uQtSQRsjf4Jz3Ws+KO3FPAM8o6DWHtVd
X-Google-Smtp-Source: AGHT+IHVATcBWedVSai3TXL0IMdZ5y6RpCUK6PnRtWh37/7/oOPLAIQQbEomM6IC2zAqXggr9ixQEg==
X-Received: by 2002:a05:651c:1a0b:b0:2fa:f5b0:a8a0 with SMTP id 38308e7fff4ca-2fb187c7900mr46126081fa.41.1728587755832;
        Thu, 10 Oct 2024 12:15:55 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:5f5a:6b7f:166e:ac6d? (2a02-8389-41cf-e200-5f5a-6b7f-166e-ac6d.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:5f5a:6b7f:166e:ac6d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d70b4291sm56011545e9.35.2024.10.10.12.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 12:15:54 -0700 (PDT)
Message-ID: <01ad0d96-cc40-437c-9033-56de465aa5f5@gmail.com>
Date: Thu, 10 Oct 2024 21:15:52 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: dsa: mv88e6xxx: leds: fix leds refcount
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Scally
 <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Linus Walleij <linus.walleij@linaro.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20241008-mv88e6xxx_leds_fwnode_put-v1-0-cfd7758cd176@gmail.com>
 <20241008-mv88e6xxx_leds_fwnode_put-v1-3-cfd7758cd176@gmail.com>
 <ZwflrDCm7qWVH0N3@smile.fi.intel.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <ZwflrDCm7qWVH0N3@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/2024 16:33, Andy Shevchenko wrote:
> On Tue, Oct 08, 2024 at 06:10:29PM +0200, Javier Carrasco wrote:
>> The 'leds' fwnode_handle is initialized by calling
>> fwnode_get_named_child_node(), which requires an explicit call to
>> fwnode_handle_put() when the node is not required anymore.
>>
>> Instead of adding the missing call, and considering that this driver was
>> recently introduced, use the automatic clenaup mechanism to release the
>> node when it goes out of scope.
> 
> ...
> 
>> -	leds = fwnode_get_named_child_node(p->fwnode, "leds");
>> +	struct fwnode_handle *leds __free(fwnode_handle) =
>> +		fwnode_get_named_child_node(p->fwnode, "leds");
> 
> Can it be const?
> 

Hi Andy,

in its current form, it could be const as its only assignment occurs in
its declaration. But if the final decision is moving it to the top and
giving it an initial NULL value, then that will not be possible for
obvious reasons.

I am fine with any of those options for v2.

Best regards,
Javier Carrasco

