Return-Path: <linux-acpi+bounces-21410-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFgBN29oqWlN6wAAu9opvQ
	(envelope-from <linux-acpi+bounces-21410-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 12:26:39 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1CA2108F1
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 12:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C57EC3027317
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 11:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5937C374745;
	Thu,  5 Mar 2026 11:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="N3zqnHq7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C5537B022
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772709987; cv=none; b=S639ehEdl2jHfJCMpXSl8jbUm77O/5VAvGGx6LfvlDgj/xGhgTTBp9hKVdcNYXv0OOOcflRU3iSV3DXYgMtr1HBNEdzczT2cMZitnPz5Sg/WE9DRhPO9SV5DIHexgBu4t/XpBVJt91pV7DfIXhn9B5y2zfvVyusfeWBgjyXR6fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772709987; c=relaxed/simple;
	bh=1e5FmJqr0d5Nr1ikMsAxK6bIvG+kQKpIeszylR7qdmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AfdUxL1jRH5kT0RSHBci9KV/b4njeUzAWcF6lenXI76HSlnGyVADLXg8sO5Y58taV9yo5ot4X9NYcHvYJIz+UMg7/REBSKzE3qZWf5jzzlP5HeGXFLELWdjuRp6uSdy4J9qmRikKzv+kYkKbLLtaZHZyo8j2s8NiICy4M6xChYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=N3zqnHq7; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8298fad2063so136232b3a.3
        for <linux-acpi@vger.kernel.org>; Thu, 05 Mar 2026 03:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1772709985; x=1773314785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysqjtnihLzlMKmZvTnyQ/HF3OaRcuwAeEcdn2G2RcKg=;
        b=N3zqnHq7jAgUcauG/TKePtAtMHzaV2BTqTTPlVORTHCRmY9tP9kpc6bxuU1X5mXF69
         9UWFtTD2t1Ekaa0O0Qp2JCAw4hZbjjClKwR2T0harDLeOAz3VDPhnh+AzlGBbm+zqW/q
         cux0lPNYLLKTbtCJu9hiMzvNrQHlWXpwEugITs38h57ykdKkqeR5HnUuxKAAn05CoI+N
         MH12kP+oDlGiIUH7kYLFelTqfILyltVcZQRJHFpK7eY1Q1mNht3uU6kU6kEmwaKVpljC
         ulDa/dwV0A81v8bsZfk99RBss8Y6UbUoU3jLHTay0+ZCdaAuJW1o/qVFbpcvzZmu9CdE
         zE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772709985; x=1773314785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ysqjtnihLzlMKmZvTnyQ/HF3OaRcuwAeEcdn2G2RcKg=;
        b=DElI18P9QLnP6rELO92JSmv79MMoN1JkUCoQfftmFr2P/HoFecd7EftwAq0iUCzkuF
         4CcBkK6Z3qascwNd6kfsPyLJqFUpue98zLLhRa3jVRXfnU/AaDTN7Q11OC+AfOYL169+
         dLOvfbxGBi0wEyCE2n6IEgJtIG3jTSYS3nV6LKIGf5NaGCiFuGX56MQftb356EbxGXNV
         vb0oHnu+U5Ev6vr3rx3esLMFTPtfiKVXxeIdWMmjqTHIdanEAJnx8c/Rj1vOtqQpKDqM
         lPiQxTlgXqzUZrvxA+fLm1sgV/N8OClA1qbY9gncTL2PfP2ThV2KPkTEw9gE1n49oANg
         iazw==
X-Forwarded-Encrypted: i=1; AJvYcCUYZxTS2iDmA5NYw1k4cg3BHFMsmq97dNYgiFK70yHisH3Q+6ks3NHERsGZgm/5TVlgiKaQphV//TD0@vger.kernel.org
X-Gm-Message-State: AOJu0YxfbWAWgs4dGAHAW9BD8Ct/OYxbM+PPnZDKiy1lWAl8MfqQs3Zw
	QK11LelwiXbnWK9YgYeizIjOcggcnhjZ20Uos/jqKTDvDuylQeWza0vBLHoMCi2eH3Y=
X-Gm-Gg: ATEYQzy4MNq57tPHKgRUoiG97ooCH4zl7j7s8Tm72NJRiOPmJ+dZ6IpxL3hJM/lwvyJ
	sQgsVfKeA0SuS6EQ7mMRI7mEDv/SvmA3FhSK0K4/XTL0onC0Qqas+f48ohaz1C9ukBjcmTMaVCL
	IcKwcBS/q4NEQVGniMsSCtnzjQZMJzBuO5ph2mlyA0qqQDg500Q9XYrIO+aT7j0bBKwVTYR/zB1
	QLFasKZo38CdH9wDBXFlyO2KDzA1QxAnt8TR7BciRwXOwPr/917bvRriFIFDMPx0Lyy5oollNd0
	8sqJkoaXqc6Zr/WHUtGLc0Apc6GH7UfwVph6j1ug+qXuYHfLqlqxALYhg/PWXR5H9j3IrdK5N+5
	piV1W1oTes308cpj3HDqf1g/xxVIWe0iez8SV1Kyo9CDhrqKhEEoGkvcX/3oXX+C13g8ezsSjq+
	6WGTpZXDjd6kcj9E2MBr5gm03anbBw0X2+OoYOU4MPvrmXLmXQ/wOC8fe285jEKIqVSzCOOxawX
	90Lu4aBBKU=
X-Received: by 2002:a05:6a00:1488:b0:81f:23b5:dc33 with SMTP id d2e1a72fcca58-82972c9eeccmr5183569b3a.30.1772709985579;
        Thu, 05 Mar 2026 03:26:25 -0800 (PST)
Received: from [10.54.26.107] (static-ip-148-99-134-202.rev.dyxnet.com. [202.134.99.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d4e10csm21738076b3a.1.2026.03.05.03.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 03:26:25 -0800 (PST)
Message-ID: <e705cd6f-5946-4a8b-8870-0c49f8239d4f@shopee.com>
Date: Thu, 5 Mar 2026 19:26:18 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
To: "Huang, Kai" <kai.huang@intel.com>,
 "Schofield, Alison" <alison.schofield@intel.com>,
 "gourry@gourry.net" <gourry@gourry.net>
Cc: "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
 "lenb@kernel.org" <lenb@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "thorsten.blum@linux.dev" <thorsten.blum@linux.dev>,
 "wangyuquan1236@phytium.com.cn" <wangyuquan1236@phytium.com.cn>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Williams, Dan J" <dan.j.williams@intel.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20260304213342.5776-1-kai.huang@intel.com>
 <aaizNh-0LEvRQMCy@gourry-fedora-PF4VCD3F>
 <aai-K2tEdIp5B4XP@aschofie-mobl2.lan>
 <aajGuOC-G_dFYpwa@gourry-fedora-PF4VCD3F>
 <4809035f61dcd6ace773532efe46b0f1928be313.camel@intel.com>
 <8355402a-e4f0-42b5-854a-ee42f9505612@shopee.com>
 <aee45ef3bc5e62814b09db5f605270b3b376fc64.camel@intel.com>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <aee45ef3bc5e62814b09db5f605270b3b376fc64.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5E1CA2108F1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[shopee.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[shopee.com:s=shopee.com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[shopee.com:+];
	TAGGED_FROM(0.00)[bounces-21410-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haifeng.xu@shopee.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,shopee.com:dkim,shopee.com:mid]
X-Rspamd-Action: no action



On 2026/3/5 18:25, Huang, Kai wrote:
> 
>>
>> By the way, If insert real cxl memory but disable CXL_ACPI, how the kernel
>> initilaizes the cxl memory and assigns the numa node? can you provide the
>> related kernel souce code?
> 
> Sorry I am a bit confused what you want to do.
> 

" It only avoids detecting CFMWS, which doesn't provide any NUMA info actually -- that's why
kernel assigns a 'faked' NUMA node for each of them."

Sorry I misunderstand what you said above. I originally thought that the inserted cxl memory
was assigned to a 'faked' NUMA node if disable CXL_ACPI. 


> If you have actual CXL memory installed, that means you want to use that?
> 
> But if you want to use CXL memory, you cannot disable CXL_ACPI IIUC.
> 
> If you don't want to use CXL memory in your deployment then you can either
> disable CXL memory in your BIOS or, with this patch, disable CXL_ACPI in
> your kernel.
> 

I see.

Thanks!

