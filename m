Return-Path: <linux-acpi+bounces-7364-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D26C59492E2
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Aug 2024 16:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53C8B1F24F9C
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Aug 2024 14:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C147E18D64C;
	Tue,  6 Aug 2024 14:23:24 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E163B18D624;
	Tue,  6 Aug 2024 14:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954204; cv=none; b=qMpHmYL51W/v4SZwiOVQ6NTR6kkwvkLkP1vE0amMh4020comf7rNTf75JzZOHDCqQm+APHhKbnx+rqUrtBdwOx0DME9N4R2nAemEsiC5uzPMe0i+azvMrxnh8dMTzfMHsv4sK5duHfJEQhtlInW0WN+HJcJvLRqdYy7qDluT0EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954204; c=relaxed/simple;
	bh=U91EeTuop3DyOCAzp3imMwkzZUlrRzys7Mo8oCZ2ESI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzu6GRfvqp14XpLB0ym/Ea59MXpVpaqGCVidcQMXmEAnaq0NlZMNoWWYLqiPtV3oqETi8F7XtmPMaPy8VdNsWZa/rXz43Fhkn+jtYgIyPfzolpEjuunbUbFmOb3QFfPtMxMQ/M+nmsIDtwZQYiA+0q9C7mJnhOuT1mmvqdjpzgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 250AFFEC;
	Tue,  6 Aug 2024 07:23:47 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DEB23F6A8;
	Tue,  6 Aug 2024 07:23:19 -0700 (PDT)
Message-ID: <2d3dc395-58f1-47bc-8d95-c8c65b474988@arm.com>
Date: Tue, 6 Aug 2024 15:23:18 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG REPORT]net: page_pool: kernel crash at
 iommu_get_dma_domain+0xc/0x20
To: Jesper Dangaard Brouer <hawk@kernel.org>,
 Yonglong Liu <liuyonglong@huawei.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, pabeni@redhat.com, ilias.apalodimas@linaro.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexander Duyck <alexander.duyck@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, linyunsheng <linyunsheng@huawei.com>,
 "shenjian (K)" <shenjian15@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, iommu@lists.linux.dev,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-acpi@vger.kernel.org
References: <0e54954b-0880-4ebc-8ef0-13b3ac0a6838@huawei.com>
 <8743264a-9700-4227-a556-5f931c720211@huawei.com>
 <e980d20f-ea8a-43e3-8d3f-179a269b5956@kernel.org>
 <CAOBf=musxZcjYNHjdD+MGp0y6epnNO5ryC6JgeAJbP6YQ+sVUA@mail.gmail.com>
 <d385bdba-65a0-4776-b950-9e62392f5115@huawei.com>
 <f09f7df6-9d5e-410d-8409-006c3b6e995a@huawei.com>
 <8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/08/2024 10:51 am, Jesper Dangaard Brouer wrote:
[...]
>> The iommu_group will release whether the page_pool is using it or not, 
>> so if once page_pool_return_page() was called(why does this occur when 
>> the device is reloaded and packets are transmitted?) , this crash will 
>> happen.
>>
>> I try the follow patch, but doesn't work :(
>>
> 
> The idea of taking a refcnt on IOMMU to avoid dev->iommu_group getting
> freed, make sense to me.
> 
> The question is if API iommu_group_get() and iommu_group_put() is the
> correct API to use in this case?
> 
>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>> index f4444b4e39e6..d03a87407ca8 100644
>> --- a/net/core/page_pool.c
>> +++ b/net/core/page_pool.c
>> @@ -21,6 +21,7 @@
>>   #include <linux/poison.h>
>>   #include <linux/ethtool.h>
>>   #include <linux/netdevice.h>
>> +#include <linux/iommu.h>
>>
> 
> The page_pool already have a system/workqueue that waits for inflight
> "packet" pages, and calls struct device API get_device() and put_device().
> 
> Why didn't the patch add code together with struct device API?
> Like this:

Now do the one where there is no IOMMU, and dma_unmap_page() corrupts 
random unrelated memory because the mapped DMA address was relative to 
dev->dma_range_map which has since become NULL.

In other words, no, hacking one particular IOMMU API symptom does not 
solve the fundamental lifecycle problem that you have here.

Thanks,
Robin.

> 
> $ git diff
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 2abe6e919224..686ff1d31aff 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -265,8 +265,10 @@ static int page_pool_init(struct page_pool *pool,
>          /* Driver calling page_pool_create() also call 
> page_pool_destroy() */
>          refcount_set(&pool->user_cnt, 1);
> 
> -       if (pool->dma_map)
> +       if (pool->dma_map) {
> +               iommu_group_get(pool->p.dev);
>                  get_device(pool->p.dev);
> +       }
> 
>          return 0;
>   }
> @@ -275,8 +277,10 @@ static void page_pool_uninit(struct page_pool *pool)
>   {
>          ptr_ring_cleanup(&pool->ring, NULL);
> 
> -       if (pool->dma_map)
> +       if (pool->dma_map) {
> +               iommu_group_put(pool->p.dev->iommu_group);
>                  put_device(pool->p.dev);
> +       }
> 
> 
> --Jesper
> 
>>   #include <trace/events/page_pool.h>
>>  > @@ -306,6 +307,9 @@ page_pool_create_percpu(const struct
>> page_pool_params *params, int cpuid)
>>          if (err)
>>                  goto err_uninit;
>>
>> +       if (pool->dma_map)
>> +               iommu_group_get(pool->p.dev);
>> +
>>          return pool;
>>
>>   err_uninit:
>> @@ -974,8 +978,11 @@ static int page_pool_release(struct page_pool *pool)
>>
>>          page_pool_scrub(pool);
>>          inflight = page_pool_inflight(pool, true);
>> -       if (!inflight)
>> +       if (!inflight) {
>>                  __page_pool_destroy(pool);
>> +               if (pool->dma_map)
>> + iommu_group_put(pool->p.dev->iommu_group);
>> +       }
>>
>>          return inflight;
>>   }
>>
>>
>>>>> The page_pool bumps refcnt via get_device() + put_device() on the DMA
>>>>> 'struct device', to avoid it going away, but I guess there is also 
>>>>> some
>>>>> IOMMU code that we need to make sure doesn't go away (until all 
>>>>> inflight
>>>>> pages are returned) ???
>>>>>
>>>>>
>>>>>> [ 4407.212119] process_one_work+0x164/0x3e0
>>>>>> [ 4407.216116]  worker_thread+0x310/0x420
>>>>>> [ 4407.219851]  kthread+0x120/0x130
>>>>>> [ 4407.223066]  ret_from_fork+0x10/0x20
>>>>>> [ 4407.226630] Code: ffffc318 aa1e03e9 d503201f f9416c00 (f9405400)
>>>>>> [ 4407.232697] ---[ end trace 0000000000000000 ]---
>>>>>>
>>>>>>
>>>>>> The hns3 driver use page pool like this, just call once when the 
>>>>>> driver
>>>>>> initialize:
>>>>>>
>>>>>> static void hns3_alloc_page_pool(struct hns3_enet_ring *ring)
>>>>>> {
>>>>>>       struct page_pool_params pp_params = {
>>>>>>           .flags = PP_FLAG_DMA_MAP | PP_FLAG_PAGE_FRAG |
>>>>>>                   PP_FLAG_DMA_SYNC_DEV,
>>>>>>           .order = hns3_page_order(ring),
>>>>>>           .pool_size = ring->desc_num * hns3_buf_size(ring) /
>>>>>>                   (PAGE_SIZE << hns3_page_order(ring)),
>>>>>>           .nid = dev_to_node(ring_to_dev(ring)),
>>>>>>           .dev = ring_to_dev(ring),
>>>>>>           .dma_dir = DMA_FROM_DEVICE,
>>>>>>           .offset = 0,
>>>>>>           .max_len = PAGE_SIZE << hns3_page_order(ring),
>>>>>>       };
>>>>>>
>>>>>>       ring->page_pool = page_pool_create(&pp_params);
>>>>>>       if (IS_ERR(ring->page_pool)) {
>>>>>>           dev_warn(ring_to_dev(ring), "page pool creation failed: 
>>>>>> %ld\n",
>>>>>>                PTR_ERR(ring->page_pool));
>>>>>>           ring->page_pool = NULL;
>>>>>>       }
>>>>>> }
>>>>>>
>>>>>> And call page_pool_destroy(ring->page_pool)  when the driver 
>>>>>> uninitialized.
>>>>>>
>>>>>>
>>>>>> We use two devices, the net port connect directory, and the step 
>>>>>> of the
>>>>>> test case like below:
>>>>>>
>>>>>> 1. enable a vf of '7d:00.0':  echo 1 >
>>>>>> /sys/class/net/eno1/device/sriov_numvfs
>>>>>>
>>>>>> 2. use iperf to produce some flows(the problem happens to the side 
>>>>>> which
>>>>>> runs 'iperf -s')
>>>>>>
>>>>>> 3. use ifconfig down/up to the vf
>>>>>>
>>>>>> 4. kill iperf
>>>>>>
>>>>>> 5. disable the vf: echo 0 > /sys/class/net/eno1/device/sriov_numvfs
>>>>>>
>>>>>> 6. run 1~5 with another port bd:00.0
>>>>>>
>>>>>> 7. repeat 1~6
>>>>>>
>>>>>>
>>>>>> And when running this test case, we can found another related 
>>>>>> message (I
>>>>>> replaced pr_warn() to dev_warn()):
>>>>>>
>>>>>> pci 0000:7d:01.0: page_pool_release_retry() stalled pool shutdown: id
>>>>>> 949, 98 inflight 1449 sec
>>>>>>
>>>>>>
>>>>>> Even when stop the traffic, stop the test case, disable the vf, this
>>>>>> message is still being printed.
>>>>>>
>>>>>> We must run the test case for about two hours to reproduce the 
>>>>>> problem.
>>>>>> Is there some advise to solve or debug the problem?
>>>>>>
>>>
> 

