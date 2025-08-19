Return-Path: <linux-acpi+bounces-15830-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F1FB2BD11
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 11:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5CE18871BF
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 09:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677BD31CA53;
	Tue, 19 Aug 2025 09:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfMchSV7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12BF31AF17
	for <linux-acpi@vger.kernel.org>; Tue, 19 Aug 2025 09:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595119; cv=none; b=fRDNcc0GZ6gkweJ2PA7rjnOQiTbDGCRQ+uomGSFbanXe/DDcGmATH61disXtcVq28/diYaSzx4a/KhF1xAMA4/FN2Ymt6P3S6CbglseAcq1DMoJMccupQbHT/uliBFICO6IZ44MJeEz74Lx2yePshdpcnH8RoL/L/wPefibKsXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595119; c=relaxed/simple;
	bh=k9u/zkUOxHsMWxFUfXyf/12KxWsh8vlLwOU5SPjsuCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X7rCrlIJ6dMfoV6CWGCILb5tAoL/Jm7nYwB54Sj10YtZYtW7mSAUTDH7h8u6aAw1y5L3Ku4sW4lJz1dlC4oQttuehooJP7ixkSG54jzzd1kF88YUbeYoUqiuW7KxXW5BmvuDEkxJ6w+yPckfkGeAQg3ztsBxm9ctrT3WHAsE9i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KfMchSV7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755595114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9bXM2P/MhqSpumKlbQzkTNlQ0naxdYHG4yQEwZLp1fE=;
	b=KfMchSV7FJueVhGUD16TUbRWr1gWNa6vBEG0cKJNUxE7E+IZXSrlNnHke38CEum70C74Oe
	rdMnIVJwA0VYsBeLsOujqvFSIjWvu/Rk0/Q9pkMBIfcn9XGDVNYmWGSuolTInDuyXKgmJJ
	XnbGRpcqWE2UwwwECgISDT0OaUT5Ljw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-_NehvVjrNH2pB_t86uWYSg-1; Tue, 19 Aug 2025 05:18:32 -0400
X-MC-Unique: _NehvVjrNH2pB_t86uWYSg-1
X-Mimecast-MFC-AGG-ID: _NehvVjrNH2pB_t86uWYSg_1755595111
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b9e4146902so2952325f8f.2
        for <linux-acpi@vger.kernel.org>; Tue, 19 Aug 2025 02:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755595111; x=1756199911;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bXM2P/MhqSpumKlbQzkTNlQ0naxdYHG4yQEwZLp1fE=;
        b=D3iEEQ/e2Y5ZVLsH5+6HPZZWdrJFhjx/+0dJfCTH4ZrUayzKA7lqdEpyXTs5jXxs81
         Zu7kNx3C1mGm9qJE4gwbzKjE6f5JmIovcs13dV7v7x/2erKi1abcol5D93xkdHHac0fh
         m+1/3QVPw/TbBcVXoGPX5icEV7Hk72jfD93iRhSQf91C3FCBGimjGBH0WzdQipBH7I7O
         Rq3aWnW0KYtzdZe3z3qAGX2tAa9DU6zj5aqwnKyvYiFB41dCulKUUZ+8flbl5nuV0i26
         Yq9WLOvm50nay0Zk04RAm01poVX58aI//DjxFWB0kcTeN3SyHbB49nSJwmGuvaSkVI7O
         9bhA==
X-Forwarded-Encrypted: i=1; AJvYcCXxj2peUx+Z+B70ehk2v7Se6qm9T0AFNpo7ip/PKCajM1OSKsOtiUrKVIyhbrwuAQYnJypSwywjNV8M@vger.kernel.org
X-Gm-Message-State: AOJu0YyqxxKLs34HUqv4hOlYb+pCwG/iYir+leJG/ygp+rrP2SaLbyna
	Nymm6JIFZVeSFvpQ/3ajA+oxFyuHXy1yHsFpa3hlM6xXpmUwfb04WRdA02Ie1GpB7t3OoMbBIWN
	lsiL8luceO9Fu5kNR0RExB7d+p0dCaRe+ii879RucMTt+Y2vhg29bkInwb1gJ008=
X-Gm-Gg: ASbGncvIKeqsMQ+d9oxrP8RJvfrtcLdtYGtx0WN9Hi3rxMAdwCg2pWkjYN+HhSb5kHt
	khPVWt4z5K/xcZ60KdzKJ+ZVcpZxVvcNJGBkWjK064oW2rVdFcaLcgfZdjQs9r94q1x/Kt1GTxC
	W4JlOESWFLUeyAFy3WIItPDB7HelHGkVd8yqfnkPLiixyXKrtaHuJyswcFOwwmYjKPDs8qsz3Mi
	KHNDRIaamTfzlpRqjkmp9q0r7cijQuGbvpfHJt3mfS9ytoVH6dgjyCP6O0zj9T8ZiiqaBHXTkux
	UHOn1QevXeClUu3lE2kO0sd3IUU/e7w0Ak2bFs/k3EBvxN9qWFk2EABy539LtlhS4Y/A1MFS66y
	FOuJgTwUuMS89EmzEYTyH4ef1JVyjsLDfpDvKObeK6Ll4pDEOYi8w5TaK8D25bjqDUGU=
X-Received: by 2002:a05:6000:290e:b0:3b6:c88:7b74 with SMTP id ffacd0b85a97d-3c0ed1f3189mr1465602f8f.59.1755595111490;
        Tue, 19 Aug 2025 02:18:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+e52xc90Bvrvbc2U770mGOtK5WPpRon5NOHeKyrTke8cTDgsW6CbDrMjBRN9/VTMir3rqZA==
X-Received: by 2002:a05:6000:290e:b0:3b6:c88:7b74 with SMTP id ffacd0b85a97d-3c0ed1f3189mr1465574f8f.59.1755595111066;
        Tue, 19 Aug 2025 02:18:31 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f07:8700:71be:5385:87b8:5a98? (p200300d82f07870071be538587b85a98.dip0.t-ipconnect.de. [2003:d8:2f07:8700:71be:5385:87b8:5a98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c16eesm3019775f8f.37.2025.08.19.02.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 02:18:30 -0700 (PDT)
Message-ID: <83a930e5-660e-49ed-8c34-66c4edf93665@redhat.com>
Date: Tue, 19 Aug 2025 11:18:29 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm/memory_hotplug: Update comment for hotplug memory
 callback priorities
To: Marc Herbert <marc.herbert@linux.intel.com>,
 Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 akpm@linux-foundation.org
References: <20250814171650.3002930-1-dave.jiang@intel.com>
 <20250814171650.3002930-2-dave.jiang@intel.com>
 <c3e30bf7-403a-4105-8e04-a73b80039ea5@redhat.com>
 <cd3d3e33-7b2e-45f1-977f-2d634ff1ef81@intel.com>
 <3e48429a-b52d-43a1-b48a-06fb46f0a37c@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <3e48429a-b52d-43a1-b48a-06fb46f0a37c@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.08.25 05:14, Marc Herbert wrote:
> 
> 
> On 2025-08-18 07:08, Dave Jiang wrote:
>>
>>
>> On 8/16/25 12:29 AM, David Hildenbrand wrote:
>>> On 14.08.25 19:16, Dave Jiang wrote:
>>>> Add clarification to comment for memory hotplug callback ordering as the
>>>> current comment does not provide clear language on which callback happens
>>>> first.
>>>>
>>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>> ---
>>>>    include/linux/memory.h | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/linux/memory.h b/include/linux/memory.h
>>>> index 40eb70ccb09d..02314723e5bd 100644
>>>> --- a/include/linux/memory.h
>>>> +++ b/include/linux/memory.h
>>>> @@ -116,7 +116,7 @@ struct mem_section;
>>>>      /*
>>>>     * Priorities for the hotplug memory callback routines (stored in decreasing
>>>> - * order in the callback chain)
>>>> + * order in the callback chain). The callback ordering happens from high to low.
>>>>     */
>>>>    #define DEFAULT_CALLBACK_PRI    0
>>>>    #define SLAB_CALLBACK_PRI    1
>>>
>>> "stored in decreasing order in the callback chain"
>>>
>>> is pretty clear? It's a chain after all that gets called.
>>
>> I can drop the patch. For some reason when I read it I'm thinking the opposite, and when Marc was also confused I started questioning things.
>>
> 
> I think we both found the current comment confusing (even together!)
> because:
> 
> - It very briefly alludes to an implementation detail (the chain)
>    without really getting into detail. A "chain" could be bi-directional;
>    why not? This one is... "most likely" not. Doubt.
> 

Please note that the memory notifier is really just using the generic 
*notifier chain* mechanism as documented in include/linux/notifier.h.

Here is a good summary of that mechanism. I don't quite agree with the 
"implementation detail" part, but that information might indeed not be 
required here.

https://0xax.gitbooks.io/linux-insides/content/Concepts/linux-cpu-4.html

> - Higher priorities can have lower numbers, example: "P1 bugs". Not the
>    case here, but this "double standards" situation makes _all_
>    priorities suspicious and confusing.
> 

Yes, "priorities" are handled differently in different context.

> - Constants that come first in the file are called last.

Yes, but that part makes perfect sense to me.
  > I would go further than Dave and also drop the "chain" implementation
> detail because it makes the reader to think too much.  Not needed and
> distracting at this particular point in the file.

  > /*
>   * Priorities for the hotplug memory callback routines.
>   * Invoked from high to low.
>   */
> 
>    => Hopefully zero cognitive load.

Still confusion about how a high priority translates to a number, maybe?

/*
  * Priorities for the hotplug memory callback routines. Invoked from
  * high to low. Higher priorities corresponds to higher numbers.
  */

-- 
Cheers

David / dhildenb


