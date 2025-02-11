Return-Path: <linux-acpi+bounces-11016-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12471A30CC9
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 14:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574CD1889088
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 13:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE0422068A;
	Tue, 11 Feb 2025 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ETyLvKzm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41473320F
	for <linux-acpi@vger.kernel.org>; Tue, 11 Feb 2025 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739280467; cv=none; b=B5IORE+NfdS2/Md2CxQHhRjeEgqefqnQtEFGazj8MOzB2M6Dh7QCASWLQcSNGYPIrrS2Hzuu9cItKhG9vgKiZXCmGUrQ2m16dKPlBHrBJtihEhG+3VAKBPrpBZUPVb8+PAzc5v9MW3tXagyhSkJC73KqBJ/zw0c3HavwYhNIvMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739280467; c=relaxed/simple;
	bh=CX7lnilW9sbI3Vky73CNlewLMliV3YoE8FiZmFwXgTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tfjm1mQrwISNI9mz41lldTLLVDyOM2/0i4lB5PESNOXANNpz+YQSFi/TG9lT6ia6KgLjcZeFJdrhm5u8V92GJpk5ltJuzQmlAj+Tu+SxPPMpj0v6A6km6n8w1DUFa6bLfRHmLxE38TK5E9hgQ97CwssZKTHAx+nH2k3g/5+UkHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ETyLvKzm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739280465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+DkuDtOtzjY6Gb6ZkxsAXFxf0AKiS7x2SvB3W65iASI=;
	b=ETyLvKzmg85syqTSu0uxRU9sMpnSCS6tYCiLMgpaTxHVsVz6vGpf33caQuoLqsFbXzzTJz
	X1Pn8d1kS0lqLi82o1enPV1zZ+xtvxNWY1wjhBzCg6LiE4HYN5ciL6C6HmUxIlYyjzIhnx
	fMGHIXFYbOecdbV4ErcNWCIqYJRbhGo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-3l4qF89sMS2ijuG_JC4cLw-1; Tue, 11 Feb 2025 08:27:44 -0500
X-MC-Unique: 3l4qF89sMS2ijuG_JC4cLw-1
X-Mimecast-MFC-AGG-ID: 3l4qF89sMS2ijuG_JC4cLw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4394c747c72so5708305e9.1
        for <linux-acpi@vger.kernel.org>; Tue, 11 Feb 2025 05:27:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739280463; x=1739885263;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+DkuDtOtzjY6Gb6ZkxsAXFxf0AKiS7x2SvB3W65iASI=;
        b=uSjgS2ozMN9QBOaIDmcZ/oc/M9aD/DGrPru9Avq7c2XhC/1IjZXA1XfttyM9BXFx6B
         xBWv7Edjq/FuRtPHHpgb+8NCoYGGh5x+Bz3eUAwc6FtoQ7EcxanlPe3fG2OtgcL408rQ
         0ZM/+nSoxCiRwaOQpILvJKiqqM4VSiuxlGqyvT5kFkUCpV8GjcKG6Dxw5azG5gTx0Qn3
         9yTJqbro2QBpN9S+01BQTUTmotaVs22m/8DXCheLX+SA/UGLiGqX7KGWtcw2xoLhciKM
         US1jcsIgsIavFqiqRt3Gq6SLhPrkYcwfy7nE36/u0vXdWB6iRrX4PIhKfNgG2shpkAVl
         ZI/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDOm7XWeZZLIYxCleMKhaYI1ThdEzEMqVL2/8YX+H9+8wuB2whdaIxJQntPwGWZa8DL/7VaNOyyWv4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/mwwD7dajIvkuFaxi9NeeyphM1ypnsOAZimPS9KK9GCc8onaS
	2j3HS+YMrrR5/x0EA6+zUnbmqwVMnDydmSbil2nuRPBYDtnXTLCc+uuzEdCkoG601ONewfy4+FN
	6w3d12IKaC6XE4dQO+wHLQ0BGqb+UPQEpfe1LV/thydEcsrEV55NnT4YuwJI=
X-Gm-Gg: ASbGncs3xHR+B4FP+M2JjJci+bzWfJB9k/PKehO/bn3SDpGYIPvdPZv8sIPtQG/Tz17
	72KeJa1RJTKyIomeO0WRArmYGbDjtTfKo0/3xHEvh2bZ9yGLEIgTYx7A53a6uog84KfKiK7QNIV
	C7QKdVIGGQ9ZW6LRWgny/xrViJSNcLhn0rvAwSPIzpCrQRdZj/aWyhiGqzAbB00SM+pi1NzrhAA
	dhFwUO0cDzE5eIHhA+aTR0sL6pYhWhrjdudFdb2BhN8DFHLUftVn3AxLr5I4bmL7L4SPCyfUwSK
	DAsnUpVxgfoMzucYlR4LMkQZmMmkDuPzQ6P6o3s=
X-Received: by 2002:a05:6000:178a:b0:38d:c771:1a21 with SMTP id ffacd0b85a97d-38de41c54cbmr3306671f8f.50.1739280462788;
        Tue, 11 Feb 2025 05:27:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IES8BmD5KVnJ7AOsEX1VJGJXGv3OpI33bF4yN3HJaiNguyrQtCmoYvDdbWdljJ4VKqKgxqbLg==
X-Received: by 2002:a05:6000:178a:b0:38d:c771:1a21 with SMTP id ffacd0b85a97d-38de41c54cbmr3306647f8f.50.1739280462362;
        Tue, 11 Feb 2025 05:27:42 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dcd8213f2sm11803708f8f.67.2025.02.11.05.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 05:27:41 -0800 (PST)
Message-ID: <d19e60d7-8abb-4e46-8935-bc989b1d5d68@redhat.com>
Date: Tue, 11 Feb 2025 14:27:39 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ACPI/MRRM: Add "node" symlink to
 /sys/devices/system/memory/rangeX
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tony Luck <tony.luck@intel.com>
Cc: Robert Moore <robert.moore@intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown
 <lenb@kernel.org>, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Oscar Salvador <osalvador@suse.de>, Danilo Krummrich <dakr@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
References: <20250210211223.6139-1-tony.luck@intel.com>
 <20250210211223.6139-4-tony.luck@intel.com>
 <2025021111-deepen-landing-4252@gregkh>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2025021111-deepen-landing-4252@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.02.25 07:51, Greg Kroah-Hartman wrote:
> On Mon, Feb 10, 2025 at 01:12:22PM -0800, Tony Luck wrote:
>> Users will likely want to know which node owns each memory range
>> and which CPUs are local to the range.
>>
>> Add a symlink to the node directory to provide both pieces of information.
>>
>> Signed-off-by: Tony Luck <tony.luck@intel.com>
>> ---
>>   drivers/acpi/acpi_mrrm.c | 29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/drivers/acpi/acpi_mrrm.c b/drivers/acpi/acpi_mrrm.c
>> index 51ed9064e025..28b484943bbd 100644
>> --- a/drivers/acpi/acpi_mrrm.c
>> +++ b/drivers/acpi/acpi_mrrm.c
>> @@ -119,6 +119,31 @@ static struct attribute *memory_range_attrs[] = {
>>   
>>   ATTRIBUTE_GROUPS(memory_range);
>>   
>> +static __init int add_node_link(struct mrrm_mem_range_entry *entry)
>> +{
>> +	struct node *node = NULL;
>> +	int ret = 0;
>> +	int nid;
>> +
>> +	for_each_online_node(nid) {
>> +		for (int z = 0; z < MAX_NR_ZONES; z++) {
>> +			struct zone *zone = NODE_DATA(nid)->node_zones + z;
>> +
>> +			if (!populated_zone(zone))
>> +				continue;
>> +			if (zone_intersects(zone, PHYS_PFN(entry->base), PHYS_PFN(entry->length))) {
>> +				node = node_devices[zone->node];
>> +				goto found;
>> +			}
>> +		}
>> +	}
>> +found:
>> +	if (node)
>> +		ret = sysfs_create_link(&entry->dev.kobj, &node->dev.kobj, "node");
> 
> What is going to remove this symlink if the memory goes away?  Or do
> these never get removed?
> 
> symlinks in sysfs created like this always worry me.  What is going to
> use it?

On top of that, we seem to be building a separate hierarchy here.

/sys/devices/system/memory/ operates in memory block granularity.

/sys/devices/system/node/nodeX/ links to memory blocks that belong to it.

Why is the memory-block granularity insufficient, and why do we have to 
squeeze in another range API here?

-- 
Cheers,

David / dhildenb


