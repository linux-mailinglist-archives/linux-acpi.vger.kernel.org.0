Return-Path: <linux-acpi+bounces-21394-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGclGkU0qWk73AAAu9opvQ
	(envelope-from <linux-acpi+bounces-21394-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 08:44:05 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E3920CD3F
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 08:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D3C3301F394
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 07:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED613264DF;
	Thu,  5 Mar 2026 07:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="AWFB08gI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FC231B824
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 07:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772696642; cv=none; b=X1avUtfzHIF3+UiKto7WXL2+obQPmcu03muHY4zWHpcejGntwfUOG0s3YNT7Wygamj4WnLxlkFjaEwFtlVHMM+sVlm5St8Fh+sjT0G09eQKnXnJnRcwK8bbcbxVzo1Ms6HFWETqFqUtjCEVJyuC4MlnJdrNQT/upTdC0RVGl62Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772696642; c=relaxed/simple;
	bh=HFhQGScd5orZZTQDNzxl2IwQKAoGG4UpAXqgoxIXrwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZYI4OlTzfuBHmcSSU/vmOA8n0DgjxLE3zglnIVhcVNKM7+fK4I13FfuMp8mBcS5h7QRgMBA90SI197OSP/K2vSpC5EDt20RVoC1Nxa83YoD1u+okKQL3WW3/7lJqnZbr+9G95GiXJeng2A5v5S1BTQGw87vRP+GPywcF7/5VSC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=AWFB08gI; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-829756f3ee9so1350375b3a.2
        for <linux-acpi@vger.kernel.org>; Wed, 04 Mar 2026 23:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1772696641; x=1773301441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGV5tSt+Pn/qUjEUL1W1gWV5V7UmQEiKPJnjCM1uOgk=;
        b=AWFB08gIfQHFD01398SGmCH3CzEFasxne52A1do5Pdw7CGgVTPfRl3YFfvsC1sHMkr
         RoJl1th+KvOMt4wzT00KIR956nm5m5izbt/yySY035pxRUpaWvwZr4WAO8kT7fZgR4E3
         CpyJ7kGjPbA0xq+DF0bPltOLbArHZ7aNqMqRSCC+ua2mRr9NPrRrAB4ju7YD65h5xEuv
         YLsqSH5b6Gh0LYGyq8kpPczuZKMFDyMTYkAxf7xqys9/Z9QAzh8L3b8aaQWeUTDWF5zv
         +MSPAYZmfbElVnZlb0DbZ7MoorU5iiKhZUlEdZ8BhsUoiYvbylsXWX4WZZgNt0i0MZ7k
         s8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772696641; x=1773301441;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YGV5tSt+Pn/qUjEUL1W1gWV5V7UmQEiKPJnjCM1uOgk=;
        b=adup92ROY3sfikW1pFRhE0J6qLgyBkNQJd93mu5SAWws9GvAiBvfYZj33r65GrmnFS
         0hkDTz0Usucjafd1nzW8I0GZm6jRX5k1WHgxL4a8WD0z/IdrbMii3Zp+a47NLK1jFU1v
         sI+J4Fr6RVC1aTCmSkZZ6nOP2N27Zizcr8qxl0br5Q9rgH4us/Jy3TV8D8AV88tE3uX4
         Sp4HK1vcgi58t3r0GBSBl6G4FKBeJQxd9RbS4aKe/tB19KGWIgfNd5/G2njjHQrn8vzi
         l/+Ez56Gzwj+gP6vzq7jBxajECeNKqYr2jM6wqHGRrHoB9D51APh0QsI/gpSNco1ta27
         jFwg==
X-Forwarded-Encrypted: i=1; AJvYcCW/K30YY/e76jg+cCtGxzhBYJe9j7sxtESoPKU8cW3ByHPQGCUJKcTvH2PMkdBQB3t2nKDYQS7u/vfo@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt7t0TK13SW//vYvm9rnB2PAWaJLtWRylMsUR16LUJ89/dfJEG
	FFaPWdwDeGJdk11Oe64zuM09e7V9Zo5QrYBl8vk+VNw6rYQEWN+jcu4MOztIKRLs0zs=
X-Gm-Gg: ATEYQzw7aq+Gik6hQQPkFH54ttjxAZbom5TAuOSn6my/vlfDxdWn+yOZbYOM9F6T4XC
	mD1bXM3WTFgZFtF6nXWl0V0UeFNLP2V43Byr+Rdj28nPDllP6zI1H6U7Kn4Hl9+RDenDuwsH7/2
	MNxRVeGUYlInD5HQPZGWyaVPogs0+NXO9joz/+90y3j61y2we+0cC7KIs2NSd9y+rcW3jvuSml5
	iqWFauzG1H1sY0bB5RWaXnTJZAh0Ek5iw6kEbMJ2w5VSYOvuzM7awCscv25QA/fHGrkKvniS7jq
	R+CqrQYgGUcB+LFnJp3w1OCak1mEtSre/Ca5IpVmRBo6ZVlcWS6OmtQfOwEumg2sxcr7roYZwIm
	liAycY0jw+9R4HWZERZ6Y/NZ0Z5lfyjJtgw7QFgGzt3SvG2DMFyyGu1nVGhf2+9GnyZYBIVCEHe
	67fSGBm6VZca15edhPIQXKYVedxp13T5lJ/zCu
X-Received: by 2002:a05:6a00:cca:b0:827:46b2:50f6 with SMTP id d2e1a72fcca58-82972cd401cmr4596619b3a.49.1772696640701;
        Wed, 04 Mar 2026 23:44:00 -0800 (PST)
Received: from [10.54.26.107] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8297a05d155sm2593862b3a.25.2026.03.04.23.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 23:44:00 -0800 (PST)
Message-ID: <a549b1d3-547b-49a5-b92d-864bb825945c@shopee.com>
Date: Thu, 5 Mar 2026 15:43:54 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: add a boot parameter to disable parsing CFMWS
 during NUMA init
To: Gregory Price <gourry@gourry.net>
Cc: rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
 jonathan.cameron@huawei.com, dave@stgolabs.net, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260304080647.169434-1-haifeng.xu@shopee.com>
 <aaho0IyQ0WAjcRMM@gourry-fedora-PF4VCD3F>
 <8ad398f6-995a-489b-8ca2-f21afdce47e4@shopee.com>
 <aaki7DZ78o_vr0kb@gourry-fedora-PF4VCD3F>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <aaki7DZ78o_vr0kb@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 07E3920CD3F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[shopee.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[shopee.com:s=shopee.com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-21394-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[shopee.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haifeng.xu@shopee.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:dkim,shopee.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 2026/3/5 14:30, Gregory Price wrote:
> On Thu, Mar 05, 2026 at 12:18:05PM +0800, Haifeng Xu wrote:
>> On 2026/3/5 01:16, Gregory Price wrote:
>>> On Wed, Mar 04, 2026 at 04:06:47PM +0800, Haifeng Xu wrote:
>>
>> Every memcg records shrinker info for each possible node. If we use online node
>> instead of possible node，then during memory hotplug, we must tarverse all memcgs
>> and shrinkers to check whether corresponding node has allocated the shrinker_info.
>> This way introduces more complexity.
>>
> 
> Right, but some systems might actually WANT this many nodes, and this
> does not scale well at all as-is.  I also don't think it's as complex as
> you think, most of the infrastructure is already there.
> 
>>> If you're not actually using CXL, can't you just disable CXL in the
>>> BIOS?  Then you shouldn't even emit CFMWS at all.
>>
>> I have asked our Intel Support Engineer, he saied that cxl can't be disabled
>> in BIOS.
>>
> 
> Huh, this is surprising.
> 
> If this is the case then see Dan's patch here:
> https://lore.kernel.org/linux-cxl/1f5074979a58803ec875dd10c9234c7b1a17192d.camel@intel.com/T/#m0d64b723a63ca7faf44311c52c1ebd5f280ae626
> 
> That should deal with your issue more cleanly.
> 
> Otherwise, the problem you're describing here really should really be
> fixed with either better lock scoping or lazy-allocation.
> 
> (Already poking at the issue a bit)

Yes，the patch you paste above worke well for us.

Thanks！

> 
> ~Gregory


