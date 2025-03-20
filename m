Return-Path: <linux-acpi+bounces-12360-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F58A69FB2
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Mar 2025 07:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8DB3AEE76
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Mar 2025 06:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E931E2611;
	Thu, 20 Mar 2025 06:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0mKsVU2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DEA1DE4FB;
	Thu, 20 Mar 2025 06:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742451139; cv=none; b=GCL95R8sWpHKhoxOQHm55uNpPMYr0OBvczhQAj+vhrEGFJrEikwXHTNMdI5b+Q5LqnAIVLgnnHGndABhM4PBXMLZqhZxOLHbrBcf2sAkhcXxD+vfY64HdjUe/jsufBHOS3eHtTbQVZ8fdAtM6T/Cj0rqCjk3N7u84a+b55dHS98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742451139; c=relaxed/simple;
	bh=ekyfNE8XF3fbwOOcpu5cTnVs0PJm+Kc/EisZGJGDLY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xt9BkPQqB+dPzCg7Cawb5WCTsP99IL16gpQpFuUwb+Z+C0iMYVZNNnULib4FeOhlcOsEbr56Y/P5UuQyP+sio9o9yqfEq0h/+e549wuPKyipnfUxLyU0VMURcmrj/sjzUTxkUBncGZHo55AZu21GtexDcdnoXnujsdrWaXKqU7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0mKsVU2; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5499c5d9691so509541e87.2;
        Wed, 19 Mar 2025 23:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742451135; x=1743055935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KXM+SKhFx3PH5HkadS8EZV3VuIrDkgN6Jyx0u7h3tSc=;
        b=R0mKsVU2fmm0LL1aq67+Esv2zuupb9HAg3el2fI24oAp/aBaJVOdxYns0GinIK/zpx
         OkcMSQWNJj+65gVRpRlPd2j9gW+V90n9ZhFKqaYZAw2uL1TB8kUiLURyxsWbHYgl9we8
         fzikL/msmLElL+nsVdS9ufrv/rZ64HV/I/BGHVXmr89NFM0HDsEhsNzEgX+J7SZeFyU1
         44H9hpOEQ5uXHKM4s7Zjjki2K44wJBtT9DfCC6yrEYW7ajNhlYKsIMj3rGcgApjk8gUg
         GeJuQ3aMUj7/4niVtKcWgcXC2ZD/Yb6hOdsQymWe1DSh19L0AxAr5e2XgPazXhfhNF7V
         UXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742451135; x=1743055935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KXM+SKhFx3PH5HkadS8EZV3VuIrDkgN6Jyx0u7h3tSc=;
        b=HNesOc9WpVChX/+VnGiZrQjx/JaSmmwRd3uVi2wOvxpvhvePGBVoPLcD5+hv+qsIU8
         6bnU2VoVONLAni0ra/G8YoIJlK0oVm18eqkImZz/BQ3V098BDsCqAalp8wt1t2wyhUi7
         DB67bM94CIhdyXkv1MHiuXlu8vsSwezF5YdHVXImdw/T/NkCk37SqBAIu8PhjQCeM9mS
         4wGT2Ot/y7ExCjPaaFxqf73zLhACDmX1gQmPEZm9Y0Yol92o8UzKf4IPjdulJRSW1udP
         d6akIsyx3zAohGAX6FMxCWOPg0iAC1TIMj4BXU8zgrfo03BSGFhAqzUX61Hs+CCmOIVd
         Ix2A==
X-Forwarded-Encrypted: i=1; AJvYcCUAxovc2wPBqaIOWZDgIV1kCG40vF/kMO4mBybr+WpYDu6A0ak5IaXaBbp7WfuJ0jC5Yrh1y9zh0J5a5iRj@vger.kernel.org, AJvYcCWCd5Gcd81PCcVuAGY6FYSbYk4KeUzdbtTlahAdCC0JLkGNbvq5exS8wXZ3I6oZPCWqRegUGthK@vger.kernel.org, AJvYcCWemT7kJUkj+YhLWJU8CHYPYijHr8P1mgpc8oUR9PByqlEirdjD2h0nTh7pmCaqk1w/UYJzWKvNo9Oz@vger.kernel.org
X-Gm-Message-State: AOJu0YzOhITkReOwG40WphaJuR1iBlYxhf5AxStucRGvErsp7lJyIMmB
	sKU6Sn6QuFa3sfRygIu9yTBkMWGBIxLjz6ExPHLY6BmbQ+HfWH/X
X-Gm-Gg: ASbGncurPj18WCFEZJ/FSSZk70zy1vF1+lRFIIxkGpTdIYq9dSDXBvHgvR4O2/Gkopy
	TcF8JQSdf8p82f0Ezc8JsX7oslySj5jUVOJLVoaqgau7MX1ZLudLCxD8jRQfJWwExIKjaAKB/44
	WcyjJ1RypdS7IpLi9+dkiQAdLou7MJo920LkBhQj4NhCWHhUmEd/MODnGFs68VzeI/Xp/3NtJn9
	ZvOfiP7A9JsOhyATqtK1pbquK1Ey93ElzndzkHiLILwAm79ibsQHidh0eokTnHK0ph9YMcLuJEk
	I0jGnHfARWJbYsKTmoZTOQRVeDeq6R78P3QVqjXfB/zHUV/JVn0U91CZtYA1PBM0F9CFxkEl7KZ
	CpC4PTst4elaS9+bqF7CULhlmEPm4gAEZK8/X
X-Google-Smtp-Source: AGHT+IHwWUCuVpiSTBAaF6l8ATGtYzDKSb53suqCMwQ/T/P21vrjqisBqZ8u1W+OxPUoq8TMGqtyig==
X-Received: by 2002:a05:6512:4029:b0:549:8f21:bc0e with SMTP id 2adb3069b0e04-54acb2061c2mr2277976e87.32.1742451135066;
        Wed, 19 Mar 2025 23:12:15 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba888069sm2101085e87.193.2025.03.19.23.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 23:12:13 -0700 (PDT)
Message-ID: <fd023be2-a265-4641-b5b4-d26f25cc85b8@gmail.com>
Date: Thu, 20 Mar 2025 08:12:12 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 09/10] net: gianfar: Use
 device_get_child_node_count_named()
To: Simon Horman <horms@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <cover.1742225817.git.mazziesaccount@gmail.com>
 <95b6015cd5f6fcce535982118543d47504ed609f.1742225817.git.mazziesaccount@gmail.com>
 <20250319160728.GA776230@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250319160728.GA776230@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/03/2025 18:07, Simon Horman wrote:
> On Mon, Mar 17, 2025 at 05:52:25PM +0200, Matti Vaittinen wrote:
>> We can avoid open-coding the loop construct which counts firmware child
>> nodes with a specific name by using the newly added
>> device_get_child_node_count_named().
>>
>> The gianfar driver has such open-coded loop. Replace it with the
>> device_get_child_node_count_named().
>>
>> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> This patch looks good to me.
> But I think it would be best to resubmit it,
> as a standalone patch for net-next, once
> it's dependencies are present in net-next.

Thanks Simon. I think you're right.

