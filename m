Return-Path: <linux-acpi+bounces-13741-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67638AB954E
	for <lists+linux-acpi@lfdr.de>; Fri, 16 May 2025 06:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C453502A76
	for <lists+linux-acpi@lfdr.de>; Fri, 16 May 2025 04:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408E22367D7;
	Fri, 16 May 2025 04:37:48 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0625C635;
	Fri, 16 May 2025 04:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747370268; cv=none; b=iCM1JYW63EDdDFHhoXZWfo/KVW3wKC/nYKj+TJ4qLXgDozjM8IpscI110nwOXnee2PNVNsLLZVALnQFFcHeVOu8xyvRyNvhqb5LzQtLUsqZhPXKlEQhd4CBAu5HianfvRHrfafcNpLDKBg+9OZirN9Nzkz/3LSBF3vzRsRkpNLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747370268; c=relaxed/simple;
	bh=oUR/Vyyy5jkz6oI8KlHpxl1LYLVxP+UCkAjxtCLMq84=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AlzbzkUECL0sQTXW3Q655gHVLG7WSG/nQ5E+EBjFfKFNozHGNBK0OUxZpNxqlgU3CkSanlbyQ5AJOeIIrlN1V8lm84st04+3j5PaV6C5o1jIpKPLU6cs2f6PdLv0fkky7UNdoVdF3ACdSh02FRBSqXZ8MGbEsqeDGc5eIzK2f5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-ed-6826c1131c3e
Message-ID: <7cf5da27-4542-49f9-90e2-88ba0eaba682@sk.com>
Date: Fri, 16 May 2025 13:37:39 +0900
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, Andrew Morton <akpm@linux-foundation.org>,
 "Huang, Ying" <ying.huang@linux.alibaba.com>, gourry@gourry.net,
 yunjeong.mun@sk.com, gregkh@linuxfoundation.org, rafael@kernel.org,
 lenb@kernel.org, dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
 dave.jiang@intel.com, horen.chuang@linux.dev, hannes@cmpxchg.org,
 osalvador@suse.de, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v8] mm/mempolicy: Weighted Interleave Auto-tuning
To: Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20250512141412.3792050-1-joshua.hahnjy@gmail.com>
Content-Language: ko
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <20250512141412.3792050-1-joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsXC9ZZnoa7wQbUMg/OfjC3mrF/DZjF96gVG
	ixM3G9ksft49zm7RvHg9m8XqTb4Wt/vPsVqsWniNzeL41nnsFvsuAtXufPiWzWL5vn5Gi8u7
	5rBZ3Fvzn9XizLQii7lfpjJbrF6T4SDocfjNe2aPnbPusnt0t11m92g58pbVY/Gel0wem1Z1
	snls+jSJ3ePEjN8sHjsfWnosbJjK7LF/7hp2j3MXKzw2n672+LxJLoAvissmJTUnsyy1SN8u
	gSujYfl79oI3bBWHlrSzNTCeZe1iZOeQEDCReFTUxcgJYf14zQxi8wpYSqw43AVmswioSvyc
	2s8IEReUODnzCQuILSogL3H/1gz2LkYuDmaBG8wSHfvmgiWEBVwlbq87BtYgIqApcaJ1Etgg
	IQE7ibbpG1hBbGYBEYnZnW1gcTYBNYkrLycxgdicAvYSt1f8YIOoMZPo2trFCGHLS2x/O4cZ
	ZJmEwCl2iRXLlzNDXC0pcXDFDZYJjIKzkBw4C8mOWUhmzUIyawEjyypGocy8stzEzBwTvYzK
	vMwKveT83E2MwPhdVvsnegfjpwvBhxgFOBiVeHgdrqtmCLEmlhVX5h5ilOBgVhLhvZ6lnCHE
	m5JYWZValB9fVJqTWnyIUZqDRUmc1+hbeYqQQHpiSWp2ampBahFMlomDU6qBUern3pRaHcWD
	NeXixfyfAtUPC8kJGazblJ+23Hjz8Ree23if/7z10vJzdOLtZb6zjlvlLJ9yJ7BX2rNm6p0n
	G5bFd9dLz3OsfjHNZof/pr98glKXti52Y560f7XjtyWK9ouubTpntkJwz5fL7IHhF87/fs0w
	g9t0l239zbgWV975vnIldRvW/1FiKc5INNRiLipOBAAUxezm2wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsXCNUNLT1f4oFqGwfTVqhZz1q9hs5g+9QKj
	xYmbjWwWP+8eZ7doXryezWL1Jl+L2/3nWC1WLbzGZnF86zx2i30XgWoPzz3JarHz4Vs2i+X7
	+hktLu+aw2Zxb81/Vosz04os5n6Zymyxek2Gxe9tK9gchD0Ov3nP7LFz1l12j+62y+weLUfe
	snos3vOSyWPTqk42j02fJrF7nJjxm8Vj50NLj4UNU5k99s9dw+5x7mKFx7fbHh6LX3xg8th8
	utrj8ya5AIEoLpuU1JzMstQifbsEroyG5e/ZC96wVRxa0s7WwHiWtYuRk0NCwETi0Y/XzCA2
	r4ClxIrDXWA2i4CqxM+p/YwQcUGJkzOfsIDYogLyEvdvzWDvYuTiYBa4wSzRsW8uWEJYwFXi
	9rpjYA0iApoSJ1ongQ0SErCTaJu+AWwZs4CIxOzONrA4m4CaxJWXk5hAbE4Be4nbK36wQdSY
	SXRt7WKEsOUltr+dwzyBkW8WkjtmIRk1C0nLLCQtCxhZVjGKZOaV5SZm5pjqFWdnVOZlVugl
	5+duYgTG6LLaPxN3MH657H6IUYCDUYmH1+G6aoYQa2JZcWXuIUYJDmYlEd7rWcoZQrwpiZVV
	qUX58UWlOanFhxilOViUxHm9wlMThATSE0tSs1NTC1KLYLJMHJxSDYxbJijHyn10iRepad7l
	P+vjL5Hkvecjvzac3tyTZRyw5c7rPZJnbp57uPBbteGO1HY77YfTvP8wLnHPEd6fvOzUmZLX
	a1mF3B0Dn/k+Dg2cJFHD5pa+Zgu7uPJX0wlhytN2NP+6oVw/xaBqr/bbhexRJ5t2TjjPLCV7
	/aiHYwZ35tx1PwKaj5QpsRRnJBpqMRcVJwIASyQiE80CAAA=
X-CFilter-Loop: Reflected

Hi Joshua,

On 5/12/2025 11:14 PM, Joshua Hahn wrote:
> Hi Honggyu, thank you for reviewing & testing my patch (again)!

[...snip...]

>> Hi Andrew,
>>
>> I'm not sure if Joshua is better to post v9, but if you want to fold and update,
>> then could you please add my tags as follows when you fold this change?
>>
>>     Reviewed-by: Honggyu Kim <honggyu.kim@sk.com>
>>     Tested-by: Honggyu Kim <honggyu.kim@sk.com>
>>
>> I added the same tags in v7 but not included in v8 somehow.
>> https://lore.kernel.org/linux-mm/5fdd7db9-96fb-49ea-9803-977158cb0132@sk.com
> 
> I must have missed including these tags. Sorry about the confusion --
> hopefully we can incorporate them into v8!

I found it wasn't again :)
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-new&id=c021f31a3b73d8e5ae2abdd658d837c44929cad7

Thanks,
Honggyu

