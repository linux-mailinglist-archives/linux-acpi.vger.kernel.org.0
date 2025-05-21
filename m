Return-Path: <linux-acpi+bounces-13841-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8222ABFA22
	for <lists+linux-acpi@lfdr.de>; Wed, 21 May 2025 17:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64068A24FA3
	for <lists+linux-acpi@lfdr.de>; Wed, 21 May 2025 15:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C14021ADA0;
	Wed, 21 May 2025 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYhJeEYd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545C81EDA06
	for <linux-acpi@vger.kernel.org>; Wed, 21 May 2025 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842014; cv=none; b=NDAyfVvvUfh6X5Sdp78Hx2yFl04jENWrg35loMBPMha+llQnQhDiamP9xbvrQg9teRTOcKKHmW/n2hL2rFnImMCq5LkKBm4Xv+BmCH24mH8SsNvxSuBwsrx1Fun36o3uf+8qqOhkBC+0C23kZQw0oxhKqjnuF69n+KBGE9TeqIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842014; c=relaxed/simple;
	bh=NLygiekAtL55TjDUjcKb6xYYaF14hruzqgMH5XEWRRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=orvIHFI4KjwTb8x9gJSH5vXgcHifXe2F7s9km1RQMAK7Y4+8kurMFKeB+MRPNrBQuoCL+aZFYAs3ROaZY4uoIJOAPpGElw4bKSSX4hpCfBzX/3r/dPWdnNx45a0mMzZsPdycQZ2ttBS/17DWLx7xFRGD9crO4tY5Y50PfkKHi9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aYhJeEYd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747842012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xsLGMafl9TLli4x/0rHFhu7b0Rej2k1hBcUbVvG/iQ8=;
	b=aYhJeEYdZCzdBOebNlOt4NHD+fqu/HCogHPMUI1zKhButRGljfFskGdQEWx1hy3OVuHRKo
	fF1tYfuBQ34KqHbtMSIMQH8bXoFjkvfxq4bbB9n4c0ZPWlKKmrvfGGwjtmvNQZpkMhU3c3
	2EagaBeiOjTqwjO78QyE53QHpWiLqbw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-kKZbblW7MdGzvPfRR0NB5g-1; Wed, 21 May 2025 11:40:10 -0400
X-MC-Unique: kKZbblW7MdGzvPfRR0NB5g-1
X-Mimecast-MFC-AGG-ID: kKZbblW7MdGzvPfRR0NB5g_1747842010
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d209dc2d3so43493235e9.3
        for <linux-acpi@vger.kernel.org>; Wed, 21 May 2025 08:40:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747842009; x=1748446809;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xsLGMafl9TLli4x/0rHFhu7b0Rej2k1hBcUbVvG/iQ8=;
        b=aobkC609LBYzrXnSyEnMcFOozbXc7m30hxmiYP4q1ZqrbztL1ATOgh9yiW7bo/DXra
         O1V/WQWqhxbnz1rk2Ik/6qCTE+/ws1D4S2nbUWoQPgkfI7w6hnToB6z6TQ4qShU1qHup
         um2vKJVWaNyBVQ/JNXgA4afDzj/zzmXRQjfyNa0mbvnNiK2jt8tGwaGBcLKMiKCYMpDo
         kqu+ujui0rnZkfcBH6ZZskQkTuSAZGzKePvTSZrW6TaTg+EbR+XTvIiTy/7kHPzLwX7S
         ZMcvkPdsldigDSBsRyRo7ooekLylJIOp38wRS14iH958k5pT3R68N4X1Iet4os3YYzhp
         YEpA==
X-Forwarded-Encrypted: i=1; AJvYcCUspbkNhxZyYWkFt/vr3utHe3gCqBjxa2NkKGQ/5dfTPlEc6+5XqLf28I9noOFYx76TAPZM7MES7Zm7@vger.kernel.org
X-Gm-Message-State: AOJu0YxgTD4caPC+V5rR+lDsxTEgNFIyWRc028Er40WTOqzSUNRfGdu+
	MnuF8fZxgheBU33pdRKy0LFJB1BUhRzZ81/8PqeQXGP4iUOJTT7Ov3KMbEDXVro8JSw3IkP40zw
	sQUO4ppIe06K+QaYeHf7m352UEBS2SB7fpvwcwd38odmXyPj3TK9Q1DhTP4wNBZc=
X-Gm-Gg: ASbGncuGB8SEDnKfqjmsDOPqCt1347lpcyZ8WqK2tY9cQvvQNrlMhNDq0Hb6oU56Xxe
	hBl6rJcKRPr3bIDZLQMmGV6vRnmGhVZ5GmAE2WUn5CMqXeVDdKU6A5aUxYhM6AeXawo6he4R4RQ
	o58civs5pO7Vo4Sg0QMx/gyzqK3/6ip8ovTif4ZBYDuxqr87em/Ik8CYPwzLWggB/kBtwFr4TYi
	H9jQTOiPD1PIhvN3HCRVQKvlC03BdGZqeMgChMyy+0hE3Gmpzdpkme3ZfX4QAY4T6SqNJgaFXAk
	3TBrrYNwg5saF+BJk/Is+6D7rTHoCIoh6V6e7XJ/ju6Jak2sCatXyGhoyQcgAhyyq9zH0ru8nJH
	xfecpnSmx4BZFbyw6PC9cvSAktzLriwgrqvhzulc=
X-Received: by 2002:a05:600c:c8c:b0:43c:e467:d6ce with SMTP id 5b1f17b1804b1-442fd60cec5mr219804355e9.4.1747842009428;
        Wed, 21 May 2025 08:40:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjNCF1eahpfitaO56mKWVDM5rQSqaa00w9A/gPv7i6POEGrYQiFRmtGHL69TaRQ3/tEaQ2Xw==
X-Received: by 2002:a05:600c:c8c:b0:43c:e467:d6ce with SMTP id 5b1f17b1804b1-442fd60cec5mr219803925e9.4.1747842008993;
        Wed, 21 May 2025 08:40:08 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:9c00:e2c7:6eb5:8a51:1c60? (p200300d82f259c00e2c76eb58a511c60.dip0.t-ipconnect.de. [2003:d8:2f25:9c00:e2c7:6eb5:8a51:1c60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6f05581sm73492495e9.13.2025.05.21.08.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 08:40:08 -0700 (PDT)
Message-ID: <6ce8f663-2bcc-43a0-bbd8-71fc36005e86@redhat.com>
Date: Wed, 21 May 2025 17:40:07 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] mm/mempolicy: Weighted Interleave Auto-tuning
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: gourry@gourry.net, akpm@linux-foundation.org, harry.yoo@oracle.com,
 ying.huang@linux.alibaba.com, honggyu.kim@sk.com, yunjeong.mun@sk.com,
 gregkh@linuxfoundation.org, rakie.kim@sk.com, rafael@kernel.org,
 lenb@kernel.org, dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
 dave.jiang@intel.com, horen.chuang@linux.dev, hannes@cmpxchg.org,
 osalvador@suse.de, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-mm@kvack.org, kernel-team@meta.com
References: <20250521153730.2196701-1-joshua.hahnjy@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250521153730.2196701-1-joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.05.25 17:37, Joshua Hahn wrote:
> On Wed, 21 May 2025 15:04:00 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>> On 20.05.25 16:12, Joshua Hahn wrote:
> 
> [...snip...]
>   
>> [...]
>>
>>> -static void iw_table_free(void)
>>> +static void wi_state_free(void)
>>>    {
>>> -	u8 *old;
>>> +	struct weighted_interleave_state *old_wi_state;
>>>    
>>> -	mutex_lock(&iw_table_lock);
>>> -	old = rcu_dereference_protected(iw_table,
>>> -					lockdep_is_held(&iw_table_lock));
>>> -	rcu_assign_pointer(iw_table, NULL);
>>> -	mutex_unlock(&iw_table_lock);
>>> +	mutex_lock(&wi_state_lock);
>>> +
>>> +	old_wi_state = rcu_dereference_protected(wi_state,
>>> +			lockdep_is_held(&wi_state_lock));
>>> +	if (!old_wi_state) {
>>> +		mutex_unlock(&wi_state_lock);
>>> +		goto out;
>>> +	}
>>>    
>>> +	rcu_assign_pointer(wi_state, NULL);
>>> +	mutex_unlock(&wi_state_lock);
>>
>> Just one nit: if written as:
>>
>> ...
>> rcu_assign_pointer(wi_state, NULL);
>> mutex_unlock(&wi_state_lock);
>>
>> old_wi_state = ...
>> if (old_wi_state) {
>> 	synchronize_rcu();
>> 	kfree(old_wi_state);
>> }
>> kfree(&wi_group->wi_kobj);
>>
>> You can easily avoid the goto.
> 
> Ah I see, thank you for the suggestion!
> I think we would have to move the "old_wi_state = ..." to be inside
> the lock and before the rcu_assign_pointer since wi_state will be
> NULL at that point if we do not, but other than that, I think this
> is a great optimization over the version I have : -)
> 
> I will send in a fix patch for this later as a cleanup patch, if
> that sounds good with you!

Sure, you can do a cleanup on top.

-- 
Cheers,

David / dhildenb


