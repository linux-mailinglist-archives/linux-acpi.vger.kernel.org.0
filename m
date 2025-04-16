Return-Path: <linux-acpi+bounces-13072-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75277A8AFE5
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Apr 2025 07:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CC544414F7
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Apr 2025 05:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9360A22B5AA;
	Wed, 16 Apr 2025 05:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQ3wkwSE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2F5227E89;
	Wed, 16 Apr 2025 05:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744782919; cv=none; b=d3Z4wJJrZ1dFcI+cf7FgqS8BMTyem3nXV/31fqZ2lw1AJmm86WTo4lFekKSUvv/hr1cFqmZF6MT7WEEIXQgjkFMmc4BuvnYOTU1qWM1Omj/TedPBFMBotl5aRXezTVKX5CiTLwQXOoZQc6ECu6OPv6Bcz2PVZfug7CZjn9+GS4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744782919; c=relaxed/simple;
	bh=leHfCPiWJjR8QJk096GICCgGysb1FJAdLfgctZ3mqU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PNVekE4VPnfmwdIwClyy5FU+qkqiVRQG/qsZzaeKtEgVrVbSqo95ENwXG3UVwb+HHHoeoRd/zCxtHr7hIei1cdDECi3i9wC/yuJ7pqO5/dq+RYeMjDTgcoUO9HMRRbgEZiTXMScTdH0tUMfr1W6FLGQgfntjtq7XpDAezu+XjQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQ3wkwSE; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54acc04516fso6109424e87.0;
        Tue, 15 Apr 2025 22:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744782916; x=1745387716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9m2yRU3f+5sO7kMkcMdb1lUeBTJeJ32rqj0qwQeg/yw=;
        b=HQ3wkwSEgnsdZ8TJ/6yd+ZRj3/wItd10KGFjRV7nIBwGvoseIGXxTSZXkKGa7X/QZq
         E0W0G2TK0xahfIS+72lbpeJ7WM9QnQwoRY7lezwON8obl6Ujk1TGhL60OAvnCwrSvJyE
         J9DEwNIN5Wp7F5f8FY2XnvM0IogQn54Aj+IxPf2QPcloBCQVOMj2p/iP7RCw91x7GWm1
         hT6fd6QFIPKNIo2d1lneBrtg/pr75u5iNf2RheDRqSBqj+gBfLcTwlFNPVE1+tcc2Z6L
         xowuTdtZToTatrpCEXxXc/UGMlypMxyqEdrlG1wrJNkeSyIN+X3NHJjDrxmFEwJJLnVG
         feAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744782916; x=1745387716;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9m2yRU3f+5sO7kMkcMdb1lUeBTJeJ32rqj0qwQeg/yw=;
        b=Uht+VzRMovlifJdVi5LMW4CDQ6GLW7XakOL4E8wXNjO+x/CdzormiK1NLUR5oNjs2F
         pqHEgcWL1s+mmGEha4V8USHygFZCaDWS5G1JvroP2Dh7e+5WX+UmDth5ETBs6ezwno8u
         +80BhSoODHYbPMM4TLOZ6MlbpeB6j2Cm2o1+T/VX/X3kpN0qXFlcMox+YTyslVmFCKyP
         etIMcAC5Df5yxIFnWkjZpmoa8GTA7NqpJk6yk9D0/LRJ4/DOjMAxsWjSPagY1BPf/mRD
         IweYVlmK0uneose2SeNyNFNt3BmS77plr7J2imuEji4tos18ZQZhgQtJek5NAbal1kbm
         1jMg==
X-Forwarded-Encrypted: i=1; AJvYcCUyYUFeUrxBtp9tJN8Yn0UmW77Y2cmM6G+dE0WUoq6LnbUxb90zRLWUHDI2/vyxp9qxRojS3TKObyV8@vger.kernel.org, AJvYcCV9wvmPmbXg8Vv7AJRLNn+VDJ/3Pq/zltQWST7YgrSNUu4hx6fq+SapfZSHCSjizRkcj1ifHDAOZBvhxKWW@vger.kernel.org
X-Gm-Message-State: AOJu0YxBkIuqfw2qUTWAVn2SncjtKiCnM0/rdHUqszMJD+m16njlbEoa
	NB0VxMTWGHMi6bMAM6moaNQXWhEGsTYDrLYK/q5UxZ5UeupHvNXr
X-Gm-Gg: ASbGncsulqgQZSGEJePkFEWIKXtY4v4pe9x3yQurX+eS+4vduhvCYa3wXd7qI9yKyYJ
	18HDv7lMf1Zi3BgCdn+Ibt1pXtXowOJpyKubhkbBl6Ax7aWXYNhrNIOPjKHlBkJgOHHZnbsv4Ri
	WKt6CrkRA6CE/G6TuWxNHR+sePjQBGSBKFgY9qRXR8afuqysFYIaahROzCCZKmu7zz6P7fvP3e8
	+8EPpZKxmtISreyQgMA6Ps5+NR90sX+Sl+724JbnOkCK08heE+EH1FrL6jJXzibZ9UhvSNrWEuE
	A38z4wDhX/Xq4eNuf+I07axyjd1sEvvBffQVG56UZx9jDac2VV4BQm7DYcrzT/ikoWz4TDinIAG
	U5sKVXRXkDeCpscWg5pRSWA==
X-Google-Smtp-Source: AGHT+IGWyn3ogmkmaBqKBu1a3wDd6qHnziLYfar+7QtgwPNJpfr1FegmOe/Tec/6oAiaM1iuMK+Rnw==
X-Received: by 2002:a05:6512:118c:b0:54a:cc75:6a9d with SMTP id 2adb3069b0e04-54d64aea25amr173466e87.42.1744782915422;
        Tue, 15 Apr 2025 22:55:15 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d502654sm1593845e87.111.2025.04.15.22.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 22:55:14 -0700 (PDT)
Message-ID: <0d470203-fe9c-4bc0-b487-6d638c006232@gmail.com>
Date: Wed, 16 Apr 2025 08:55:13 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] property: Use tidy for_each_named_* macros
To: Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Z_ew4DN0z71nCX3C@mva-rohm> <Z_yvNl23GcEpOkK1@smile.fi.intel.com>
 <Z_yvkKTgI4XSlGya@smile.fi.intel.com> <20250414201450.43fb8d9c@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250414201450.43fb8d9c@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/04/2025 22:14, Jonathan Cameron wrote:
> On Mon, 14 Apr 2025 09:47:44 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
>> On Mon, Apr 14, 2025 at 09:46:14AM +0300, Andy Shevchenko wrote:
>>> On Thu, Apr 10, 2025 at 02:52:00PM +0300, Matti Vaittinen wrote:
>>>> Implementing if-conditions inside for_each_x() macros requires some
>>>> thinking to avoid side effects in the calling code. Resulting code
>>>> may look somewhat awkward, and there are couple of different ways it is
>>>> usually done.
>>>>
>>>> Standardizing this to one way can help making it more obvious for a code
>>>> reader and writer. The newly added for_each_if() is a way to achieve this.
>>>>
>>>> Use for_each_if() to make these macros look like many others which
>>>> should in the long run help reading the code.
>>>
>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> Thanks for cleaning these up!
>>>    
>>>> ---
>>>> The patch was crafted against the IIO/testing branch, and it depends on
>>>> the 76125d7801e5 ("property: Add functions to iterate named child").
>>>> Hence I'd suggest taking this via IIO tree (if this gets accepted).
>>>
>>> I'm not sure why. The for_each_if() is part of v6.15-rc1.
>>
>> Ah, I see, you are trying to fix newly introduced stuff? I would rather suggest
>> to make this straightforward against the current upstream and ask Jonathan to
>> rebase the testing to fold the fixes into a new APIs.
>>
> 
> Or we just do this next cycle maybe. 

I'm not against either of the approaches. I'm (mostly) staying away from 
the computer for this and the next week, so re-spinning this will in any 
case get delayed. In that regard, the next cycle won't be that far away.

> Definitely not going to take anything
> through IIO that hasn't been on the iio list btw.

Ah. Thanks for pointing this out Jonathan! I just used the 
get_maintainer.pl - and added You. I definitely should have added the 
IIO-list!

Yours,
	-- Matti


