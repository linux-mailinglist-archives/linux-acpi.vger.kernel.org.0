Return-Path: <linux-acpi+bounces-7221-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133A7945905
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Aug 2024 09:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A302865A1
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Aug 2024 07:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E481BE86E;
	Fri,  2 Aug 2024 07:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8pNbQAP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A64E45020;
	Fri,  2 Aug 2024 07:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722584275; cv=none; b=s5dpsZu8k4gAOMX3dQIKIauC2JouxnoAVSmpWRbEqhpysBXefnOG0lQBPP6NjlDPAh7+xeo04LYLTei4phlrdseMudxh/GJKJhSfhxDOFRfksbBfYwNid+lYaeT7e+2VvDS5Yu2KXGKbJ6/TNac7eVS4vJpxUbbTfamFVJGcKls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722584275; c=relaxed/simple;
	bh=442BEwgQZkNvyntWB/mlPJnY/PPnoqx1uEiiossTppU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uP2VJSMlEepnkrg+K9rwj8kpn/Dzo/5zVzVvy7CJ/l8D7/skxYGM+4JovN7ctYIYi7k9PQkfvIf+ASZvDWZ00cd/LinzARHGNRcqfJIX5eiL6bQYai8jp3edR1AICxSRNkAbfLiXba1UpRickH+xKeaBVrS+Leqt6D2JYFVW2iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8pNbQAP; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52f01b8738dso8089125e87.1;
        Fri, 02 Aug 2024 00:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722584271; x=1723189071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VEul01c7Y76/vYgRcbl6yWvRBJXnnoj1/y3jzSU/8/8=;
        b=i8pNbQAPDnn8RzniPSV4nRDgHa3MTkwnKDwB4Ts4KWgJNKmN/mTiOSFBM7x7Jf2/Sg
         5FJkEOyvtCPDQzy1l3+CXTWLUCh/gnN4OBTEEXkJcXw/UaYSO/QBHUChyG1IhCp9t50E
         RjMJ/FdSzAwex8GKGKnQMpnxX/PZPhGLi/sd4HW5bGkNv1dd7FR+UlV75WoFnYQotgrT
         iAQLTIvld+1/Y5Mhn4e6IvAU0CQvSiRGSfdB7lROmoX3dpyYaiCALXl/sDq5s8QpN9gb
         ztfnaPNxZK8yTBI9OMi6u4w1IefkKlXkhSLSyjkzqDjQ2SoxOF9yPULnDkz0EIGXwchO
         qzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722584271; x=1723189071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VEul01c7Y76/vYgRcbl6yWvRBJXnnoj1/y3jzSU/8/8=;
        b=TXrMBbJK8EKHMwiA6RHjrUpbgzCaylfiUhGG2+CB7W4yOIs04iZwX5S58QXVk0xSK1
         du+83NjSb1IjsVQEQ9DOjmnp8KNGVGSsgAKkoENWlNTT9vv3ZCQEYEKWfs0elbkc8Ehq
         j3DFww3NTuh62p7tcw1a0rUJhG5povrdkmUncomDu7Cw6GSMQYBRLGWI7YTf5hebauv0
         NRYRtBKdQAC3dQ0pDkQo8I/JegokO4FVTPkiEbE8VoeHb802Qsu2WQ9hD/zOXPXE5bYW
         m+pZX9rtOT3y51/+lKfsy6ccFImQQxvh0CSMu76uPzF5Pzy9GucEQdS5ZeO9qunwbpT/
         Xkcg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ6uMFjmkNQ8YLT9bnwb3hx16+FhPWOEXM7eqqtX6d4jQQTcJQYqo4URFnIjGN6h/pEuDR+SDeuIxJAYlutExT0/kNIrfWC8cUwguBFOzoBF8Jpf2M3zuqnQuXao+eudLU3Dr18JFyJh2zDkrp3kD6vL3orCdDDHZ+vLFBUEn7Jxd800iSJOad1tBpxf78+IlisNkIV3u/SXATMWZnr9QAjR55kPd7yincrKJhJtS4beTN4UmtHR/bnQ==
X-Gm-Message-State: AOJu0YzRnkQ18SbQqMOu5LPZH83VObSqufhBVsgO6D2lIduTGKk37z1v
	9w9qfigc7gMn6djLxSUP1Z2YF7Zn4yNWpVWB1nXjSABu515HvFWK
X-Google-Smtp-Source: AGHT+IEHnlmTy7PUXPtQ9CQBEllQgwVpgIZH7F4dD5CQheEpZWQkcMNTvJS4jYPpRUf+JDphV9EeJw==
X-Received: by 2002:a05:6512:b1a:b0:52e:9c69:b25b with SMTP id 2adb3069b0e04-530bb37c2a5mr1274908e87.28.1722584271076;
        Fri, 02 Aug 2024 00:37:51 -0700 (PDT)
Received: from [192.168.0.31] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd06df9esm1247001f8f.100.2024.08.02.00.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 00:37:50 -0700 (PDT)
Message-ID: <9083938c-c2df-4429-904d-700e5021331c@gmail.com>
Date: Fri, 2 Aug 2024 09:37:48 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v2 0/6] use device_for_each_child_node() to
 access device child nodes
To: Lee Jones <lee@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Jean Delvare
 <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Pavel Machek <pavel@ucw.cz>, Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andreas Kemnade <andreas@kemnade.info>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-leds@vger.kernel.org, netdev@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20240721-device_for_each_child_node-available-v2-0-f33748fd8b2d@gmail.com>
 <172192488125.1053789.17350723750885690064.b4-ty@kernel.org>
 <094c7d7f-749f-4d8f-9254-f661090e4350@gmail.com>
 <20240801123901.GC6756@google.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240801123901.GC6756@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/08/2024 14:39, Lee Jones wrote:
> On Mon, 29 Jul 2024, Javier Carrasco wrote:
> 
>> On 25/07/2024 18:28, Lee Jones wrote:
>>> On Sun, 21 Jul 2024 17:19:00 +0200, Javier Carrasco wrote:
>>>> This series aims to clarify the use cases of:
>>>>
>>>> - device_for_each_child_node[_scoped]()
>>>> - fwnode_for_each_available_child_node[_scoped]()
>>>>
>>>> to access firmware nodes.
>>>>
>>>> [...]
>>>
>>> Applied, thanks!
>>>
>>> [3/6] leds: bd2606mvv: fix device child node usage in bd2606mvv_probe()
>>>       commit: 75d2a77327c4917bb66163eea0374bb749428e9c
>>> [4/6] leds: is31fl319x: use device_for_each_child_node_scoped() to access child nodes
>>>       commit: 0f5a3feb60aba5d74f0b655cdff9c35aca03e81b
>>> [5/6] leds: pca995x: use device_for_each_child_node() to access device child nodes
>>>       (no commit info)
>>>
>>> --
>>> Lee Jones [李琼斯]
>>>
>>
>> Hi Lee,
>>
>> could you please tell me where you applied them? I rebased onto
>> linux-next to prepare for v3, and these patches are still added on top
>> of it. Can I find them in some leds/ branch? Thank you.
> 
> Sorry, I was side-tracked before pushing.
> 
> Pushed now.  They should be in -next tomorrow.
> 

Thanks, I see

[3/6] leds: bd2606mvv: fix device child node usage in bd2606mvv_probe()

[4/6] leds: is31fl319x: use device_for_each_child_node_scoped() to
access child nodes

applied to -next, but

[5/6] leds: pca995x: use device_for_each_child_node() to access device
child nodes

has not been applied yet.

