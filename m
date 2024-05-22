Return-Path: <linux-acpi+bounces-5948-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1F18CC771
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 21:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 961A4B209ED
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 19:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408201419BA;
	Wed, 22 May 2024 19:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="az6VapnM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97420A929;
	Wed, 22 May 2024 19:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716407189; cv=none; b=Llh94VUPU9dFWDZEv14bNVDZfhrr8CSqJs5/UH08MMXuXHKAMuXaojwb9UZ0fA/fczWI0Q5JwqjJAapjlbIj3R5Ft9Zhdgqd2/zGV6QNILTvtJbQM3YqTVSUljkmvvA++dkuBF3tt+taW6bpYxp51LjOL95PAvsWdiRBCI4lgCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716407189; c=relaxed/simple;
	bh=2CLGln2zgzW+HisWTsBgru7f8PYezcmku6NM5WBH6NI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TF8x2fdgR8K79OLZu1bXc6nOBZ5vQW76pY8xC05NJvE5c3ER0OPYcTc6jSPA9i2HCzg2X0lHBSkqunyyZWgKB/AUa7ZdG81JKio2z4bF9jB+YqUZ4PmuulK7nThkPstukmEApKvkssjCMc08ENdMVdl7GKTUcOw0+NWTUSY/v+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=az6VapnM; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a5a4bc9578cso1013161666b.2;
        Wed, 22 May 2024 12:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716407186; x=1717011986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cNRKSkhfeBfdl1/YLhNkI/YGV4nmuFQs+U3x5z3R5T8=;
        b=az6VapnMtgY4m/yx8R7ek18CEKYyZ/UxONMvXH34oze5y8kVBGn67ab4NR33M6Bm07
         guHchQC9ZDliR3XxnouskYuHXE0fpj1aEsAfk3rixtI6K1eUzQplbaOob/IlU+XWe3a6
         aHv9wubMWlTlraWOlurYNAaH8j7TV8dNNx/+Iqk/7AV89Nvnbt018Hv9A6JD+oZgvI0W
         8FZOqQaGh0hBVt7JCeeyQ+VSrlUOU2xbhZNej8+dbLcCEYbYlhJxjG9ithvspAfuB1We
         +0OSFhozSv4j0H5wne1LwWwXJUW9UUiTeIxLBCakDIfHbUkR5uRHyYooUgB7apMowqOY
         9jQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716407186; x=1717011986;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cNRKSkhfeBfdl1/YLhNkI/YGV4nmuFQs+U3x5z3R5T8=;
        b=kjO+ewl/4K2XgleuX50y/pd0HDfSjVNNkLjOHEMGKXowxytxyGGfDT8sIJ6Qx2iiuW
         +sbrgz180Mu7ZKuC/IPg7jIcHr7XmQVwjKinQpti9GsAbWEKh3HTdugXrVVxDWl67Jpw
         BXb6qJzAsw2My091OQT36HUwouuQfO/5LXqU2civTLX/Mlz4Fwr3DYgJP8B0lbHZ3xtB
         LMV+7JMbMIFBNC5E5+1nlmxPabTVpCqyLHQ/hvON6n6Gv36x3d08wtHGOIA/5yMVB9Gp
         LX3WZXfriX0T0CdlGhS90MjOWVkgiorJgn1UhrJxkScIIRDuB/y+V36dd63X46fB5LuU
         H4Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUJsqBZFnFq45lLTqEm9/plROPFhM6cJ0mNQPDM4NAEMRWyee2k8LWgMbiy6lBGObThBF2CXpw/M7HSRWuN6/+uTzulBLmOdGZRHspaC0qkPzly96oPgYBPhi7liDJuKsyTw0lMdoPBzbg=
X-Gm-Message-State: AOJu0YzSRdO+9Ne9OZRk8B05+JJfOa07bRLkPk1wlcnmnJ+jmr/lnbeT
	qWlfIvri+l1Xr/ASvQKdhcrIfO+KelZ644kxKRXIb1HStUXiNdaN
X-Google-Smtp-Source: AGHT+IEM0LbYjeqrk1h+RNEsBFNp+7qjFe8R1PmbfLpgAKY9VpGnbi+gJvPkd3oMLBdEe2q4KmAOCw==
X-Received: by 2002:a17:906:3857:b0:a5c:e43a:2bd5 with SMTP id a640c23a62f3a-a62281e18e6mr269701066b.59.1716407185764;
        Wed, 22 May 2024 12:46:25 -0700 (PDT)
Received: from [192.168.0.31] (84-115-212-250.cable.dynamic.surfer.at. [84.115.212.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17a06sm1800861566b.219.2024.05.22.12.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 12:46:25 -0700 (PDT)
Message-ID: <97567de0-895d-4a23-907f-506551e86362@gmail.com>
Date: Wed, 22 May 2024 21:46:22 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hwmon: (ltc2992) use
 fwnode_for_each_available_child_node_scoped()
To: Guenter Roeck <linux@roeck-us.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Jean Delvare
 <jdelvare@suse.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20240522-fwnode_for_each_available_child_node_scoped-v1-0-1188b0da12dc@gmail.com>
 <20240522-fwnode_for_each_available_child_node_scoped-v1-2-1188b0da12dc@gmail.com>
 <57645247-fb14-4180-bef0-1638e9f522fe@roeck-us.net>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <57645247-fb14-4180-bef0-1638e9f522fe@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/05/2024 21:08, Guenter Roeck wrote:
> On 5/22/24 02:18, Javier Carrasco wrote:
>> The error path from a zero value of the "shunt-resistor-micro-ohms"
>> property does not decrement the refcount of the child node.
>>
>> Instead of adding the missing fwnode_handle_put(), a safer fix for
>> future modifications is using the _scoped version of the macro,
>> which removes the need for fwnode_handle_put() in all error paths.
>>
>> The macro defines the child node internally, which removes the need for
>> the current child node declaration as well.
>>
>> Fixes: 10b029020487 ("hwmon: (ltc2992) Avoid division by zero")
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 
> I really don't like fixes which depend on an API change.
> 
> Guenter
> 

We could split the fix into two steps as suggested by Andy, where the
fix would simply add the missing fwnode_handle_put(), adding the
corresponding tag to include it in the stable kernels (the bug was
introduced with v6.7). By doing that, the new macro would not need to be
backported, which is probably a safer approach.

The patch with the new macro would be left as it is, and another patch
would convert the the loop to use the new macro to avoid that a similar
bug arises again. That would be this 2/2 + dropping the additional
fwnode_handle_put().

Best regards,
Javier Carrasco


