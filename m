Return-Path: <linux-acpi+bounces-7337-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E3E948C6A
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Aug 2024 11:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28E71C22381
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Aug 2024 09:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45FE1BDA9A;
	Tue,  6 Aug 2024 09:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uo+oBi2B"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7030CF4FA;
	Tue,  6 Aug 2024 09:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722937896; cv=none; b=SyD4YZqoTWAVnEFAiZWmk9jLtmBMovSIbslihoMLGhhrxpD5O4u+2dcNg2IJIMIvKu//j5/d/KY5vX/aGVTZrX9VvpPaViQp0UJw7T4mePu0v88StoiiBfZ9TKvJMEgwW876lOHE0qx9Qo6kxNUQB08wzz6ZGPxGoJV44CDBu5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722937896; c=relaxed/simple;
	bh=rFZ5BVoG5sE3sYKVXHYIEXX+iy+2/CjVVn9kYPvqLpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZyX781MmyEk8T/g+itTEhiElKd4DQWNJDe7KEOyjYDgZPoij072XsqOFU4zzcH9rVNnWZlTFHyhx7rlWIaJu+NyiXNC3Xe5hXLZdFC+GgK1KkxvsPLUWpI+p1jVVGhk6Acueq4grEnLfwiZp++pRIiHD2o3Qg374aGNEt6yFVi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uo+oBi2B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE46C32786;
	Tue,  6 Aug 2024 09:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722937895;
	bh=rFZ5BVoG5sE3sYKVXHYIEXX+iy+2/CjVVn9kYPvqLpQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uo+oBi2ByVjwsslyGoaeNZ69Bj0FQW5pKn2mtJ8oXR5mCbnkTbWM8t62w1psHAkEa
	 dk7hIz6dH8e+Tm8sNLCZyleUU8F3M+JYvqWfr5Fui1mwPceCW7CVJ1RukWVX0/jZbQ
	 FC9kxAPI3EtTfSD9pxvLxWLmNO9qoDsVWsTml9JIj4YLcRSqrvebScSbytb313kj86
	 OZWF+CPTCKxAFp9ncKgA5gHIwf9j03dLMMPidydLqEoJwB6GLbqINj8UorY9YPiexg
	 ZRDx5EF5l7ycEjNU49vwuFvc4kykO7EJ8JWdsaPRn+oaZGX/Z8DO0A21bDcOfqTaWs
	 nmfGPTsf+ykAw==
Message-ID: <8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org>
Date: Tue, 6 Aug 2024 11:51:31 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG REPORT]net: page_pool: kernel crash at
 iommu_get_dma_domain+0xc/0x20
To: Yonglong Liu <liuyonglong@huawei.com>,
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
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <f09f7df6-9d5e-410d-8409-006c3b6e995a@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Cc. IOMMU list+maintainers, question below...


On 02/08/2024 04.06, Yonglong Liu wrote:
> 
> On 2024/7/31 19:32, Yonglong Liu wrote:
>>
>> On 2024/7/31 16:42, Somnath Kotur wrote:
>>> On Tue, Jul 30, 2024 at 10:51 PM Jesper Dangaard Brouer 
>>> <hawk@kernel.org> wrote:
>>>>
>>>>
>>>> On 30/07/2024 15.08, Yonglong Liu wrote:
>>>>> I found a bug when running hns3 driver with page pool enabled, the log
>>>>> as below:
>>>>>
>>>>> [ 4406.956606] Unable to handle kernel NULL pointer dereference at
>>>>> virtual address 00000000000000a8
>>>> struct iommu_domain *iommu_get_dma_domain(struct device *dev)
>>>> {
>>>>          return dev->iommu_group->default_domain;
>>>> }
>>>>
>>>> $ pahole -C iommu_group --hex | grep default_domain
>>>>          struct iommu_domain *      default_domain;   /* 0xa8   0x8 */
>>>>
>>>> Looks like iommu_group is a NULL pointer (that when deref member
>>>> 'default_domain' cause this fault).
>>>>
>>>>
>>>>> [ 4406.965379] Mem abort info:
>>>>> [ 4406.968160]   ESR = 0x0000000096000004
>>>>> [ 4406.971906]   EC = 0x25: DABT (current EL), IL = 32 bits
>>>>> [ 4406.977218]   SET = 0, FnV = 0
>>>>> [ 4406.980258]   EA = 0, S1PTW = 0
>>>>> [ 4406.983404]   FSC = 0x04: level 0 translation fault
>>>>> [ 4406.988273] Data abort info:
>>>>> [ 4406.991154]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>>>>> [ 4406.996632]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>>>>> [ 4407.001681]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>>>>> [ 4407.006985] user pgtable: 4k pages, 48-bit VAs, 
>>>>> pgdp=0000202828326000
>>>>> [ 4407.013430] [00000000000000a8] pgd=0000000000000000,
>>>>> p4d=0000000000000000
>>>>> [ 4407.020212] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
>>>>> [ 4407.026454] Modules linked in: hclgevf xt_CHECKSUM ipt_REJECT
>>>>> nf_reject_ipv4 ip6table_mangle ip6table_nat iptable_mangle
>>>>> ip6table_filter ip6_tables hns_roce_hw_v2 hns3 hclge hnae3 xt_addrtype
>>>>> iptable_filter xt_conntrack overlay arm_spe_pmu arm_smmuv3_pmu
>>>>> hisi_uncore_hha_pmu hisi_uncore_ddrc_pmu hisi_uncore_l3c_pmu
>>>>> hisi_uncore_pmu fuse rpcrdma ib_isert iscsi_target_mod ib_iser 
>>>>> libiscsi
>>>>> scsi_transport_iscsi crct10dif_ce hisi_sec2 hisi_hpre hisi_zip
>>>>> hisi_sas_v3_hw xhci_pci sbsa_gwdt hisi_qm hisi_sas_main hisi_dma
>>>>> xhci_pci_renesas uacce libsas [last unloaded: hnae3]
>>>>> [ 4407.076027] CPU: 48 PID: 610 Comm: kworker/48:1
>>>>> [ 4407.093343] Workqueue: events page_pool_release_retry
>>>>> [ 4407.098384] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS
>>>>> BTYPE=--)
>>>>> [ 4407.105316] pc : iommu_get_dma_domain+0xc/0x20
>>>>> [ 4407.109744] lr : iommu_dma_unmap_page+0x38/0xe8
>>>>> [ 4407.114255] sp : ffff80008bacbc80
>>>>> [ 4407.117554] x29: ffff80008bacbc80 x28: 0000000000000000 x27:
>>>>> ffffc31806be7000
>>>>> [ 4407.124659] x26: ffff2020002b6ac0 x25: 0000000000000000 x24:
>>>>> 0000000000000002
>>>>> [ 4407.131762] x23: 0000000000000022 x22: 0000000000001000 x21:
>>>>> 00000000fcd7c000
>>>>> [ 4407.138865] x20: ffff0020c9882800 x19: ffff0020856f60c8 x18:
>>>>> ffff8000d3503c58
>>>>> [ 4407.145968] x17: 0000000000000000 x16: 1fffe00419521061 x15:
>>>>> 0000000000000001
>>>>> [ 4407.153073] x14: 0000000000000003 x13: 00000401850ae012 x12:
>>>>> 000006b10004e7fb
>>>>> [ 4407.160177] x11: 0000000000000067 x10: 0000000000000c70 x9 :
>>>>> ffffc3180405cd20
>>>>> [ 4407.167280] x8 : fefefefefefefeff x7 : 0000000000000001 x6 :
>>>>> 0000000000000010
>>>>> [ 4407.174382] x5 : ffffc3180405cce8 x4 : 0000000000000022 x3 :
>>>>> 0000000000000002
>>>>> [ 4407.181485] x2 : 0000000000001000 x1 : 00000000fcd7c000 x0 :
>>>>> 0000000000000000
>>>>> [ 4407.188589] Call trace:
>>>>> [ 4407.191027]  iommu_get_dma_domain+0xc/0x20
>>>>> [ 4407.195105]  dma_unmap_page_attrs+0x38/0x1d0
>>>>> [ 4407.199361]  page_pool_return_page+0x48/0x180
>>>>> [ 4407.203699]  page_pool_release+0xd4/0x1f0
>>>>> [ 4407.207692]  page_pool_release_retry+0x28/0xe8
>>>> I suspect that the DMA IOMMU part was deallocated and freed by the
>>>> driver even-though page_pool still have inflight packets.
>>> When you say driver, which 'driver' do you mean?
>>> I suspect this could be because of the VF instance going away with
>>> this cmd - disable the vf: echo 0 >
>>> /sys/class/net/eno1/device/sriov_numvfs, what do you think?
>>
>> I found that this happen when the vf enabled and running some packets, 
>> below is more infomation:
>>
>>
>> [ 4391.596558] pci 0000:7d:01.0: page_pool_release_retry() stalled 
>> pool shutdown: id 1145, 33 inflight 906 sec
>> [ 4397.111484] hns3 0000:bd:00.0: SRIOV setting: 0
>> [ 4397.118155] hns3 0000:bd:01.0 enp189s0f0v0: link down
>> [ 4397.416623] hns3 0000:bd:01.0: finished uninitializing hclgevf driver
>> [ 4397.480572] pci 0000:7d:01.0: page_pool_release_retry() stalled 
>> pool shutdown: id 1279, 98 inflight 362 sec
>> [ 4400.948362] hns3 0000:7d:00.0: SRIOV setting: 1
>> [ 4401.060569] pci 0000:7d:01.0: [19e5:a22f] type 00 class 0x020000 
>> PCIe Endpoint
>> [ 4401.067795] pci 0000:7d:01.0: enabling Extended Tags
>> [ 4401.073090] hns3 0000:7d:01.0: Adding to iommu group 48
>> [ 4401.078494] hns3 0000:7d:01.0: enabling device (0000 -> 0002)
>> [ 4401.084348] hns3 0000:7d:01.0: The firmware version is 1.20.0.17
>> [ 4401.102911] hns3 0000:7d:01.0: finished initializing hclgevf driver
>> [ 4401.111212] hns3 0000:7d:01.0: using random MAC address 
>> da:**:**:**:a3:47
>> [ 4401.138375] hns3 0000:7d:01.0 eno1v0: renamed from eth0
>> [ 4403.939449] hns3 0000:7d:01.0 eno1v0: link up
>> [ 4403.940237] 8021q: adding VLAN 0 to HW filter on device eno1v0
>> [ 4406.956606] Unable to handle kernel NULL pointer dereference at 
>> virtual address 00000000000000a8
>>
>>
>> another log:
>>
>> [11550.197002] hns3 0000:bd:01.0 enp189s0f0v0: link up
>> [11550.197034] hns3 0000:bd:01.0 enp189s0f0v0: net open
>> [11550.206910] 8021q: adding VLAN 0 to HW filter on device enp189s0f0v0
>> [11564.872929] page_pool_release_retry() stalled pool shutdown: id 
>> 2330, 99 inflight 60 sec
>> [11568.353723] hns3 0000:bd:01.0 enp189s0f0v0: net stop
>> [11568.360723] hns3 0000:bd:01.0 enp189s0f0v0: link down
>> [11568.519899] hns3 0000:bd:01.0 enp189s0f0v0: link up
>> [11568.519935] hns3 0000:bd:01.0 enp189s0f0v0: net open
>> [11568.529840] 8021q: adding VLAN 0 to HW filter on device enp189s0f0v0
>> [11589.640930] page_pool_release_retry() stalled pool shutdown: id 
>> 1996, 50 inflight 2054 sec
>> [11592.554875] hns3 0000:bd:01.0 enp189s0f0v0: net stop
>> [11592.560930] hns3 0000:bd:01.0 enp189s0f0v0: link down
>> [11596.684935] pci 0000:7d:01.0: [19e5:a22f] type 00 class 0x020000 
>> PCIe Endpoint
>> [11596.692140] pci 0000:7d:01.0: enabling Extended Tags
>> [11596.697324] hns3 0000:7d:01.0: Adding to iommu group 48
>> [11596.702988] hns3 0000:7d:01.0: enabling device (0000 -> 0002)
>> [11596.708808] hns3 0000:7d:01.0: The firmware version is 1.20.0.17
>> [11596.727263] hns3 0000:7d:01.0: finished initializing hclgevf driver
>> [11596.735561] hns3 0000:7d:01.0: using random MAC address 
>> 72:**:**:**:55:d7
>> [11596.760621] hns3 0000:7d:01.0 eno1v0: renamed from eth0
>> [11599.545341] hns3 0000:7d:01.0 eno1v0: link up
>> [11599.545409] hns3 0000:7d:01.0 eno1v0: net open
>> [11599.554858] 8021q: adding VLAN 0 to HW filter on device eno1v0
>> [11608.908922] Unable to handle kernel NULL pointer dereference at 
>> virtual address 00000000000000a8
>>
> I adds more debug info, and found that:
> 
> [ 4573.356891] pci 0000:7d:01.0: page_pool_release_retry() stalled pool 
> shutdown: id 1046, 82 inflight 60 sec, iommu_group=0x0
> 
> The iommu_group will release whether the page_pool is using it or not, 
> so if once page_pool_return_page() was called(why does this occur when 
> the device is reloaded and packets are transmitted?) , this crash will 
> happen.
> 
> I try the follow patch, but doesn't work :(
> 

The idea of taking a refcnt on IOMMU to avoid dev->iommu_group getting
freed, make sense to me.

The question is if API iommu_group_get() and iommu_group_put() is the
correct API to use in this case?

> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index f4444b4e39e6..d03a87407ca8 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -21,6 +21,7 @@
>   #include <linux/poison.h>
>   #include <linux/ethtool.h>
>   #include <linux/netdevice.h>
> +#include <linux/iommu.h>
> 

The page_pool already have a system/workqueue that waits for inflight
"packet" pages, and calls struct device API get_device() and put_device().

Why didn't the patch add code together with struct device API?
Like this:

$ git diff
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 2abe6e919224..686ff1d31aff 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -265,8 +265,10 @@ static int page_pool_init(struct page_pool *pool,
         /* Driver calling page_pool_create() also call 
page_pool_destroy() */
         refcount_set(&pool->user_cnt, 1);

-       if (pool->dma_map)
+       if (pool->dma_map) {
+               iommu_group_get(pool->p.dev);
                 get_device(pool->p.dev);
+       }

         return 0;
  }
@@ -275,8 +277,10 @@ static void page_pool_uninit(struct page_pool *pool)
  {
         ptr_ring_cleanup(&pool->ring, NULL);

-       if (pool->dma_map)
+       if (pool->dma_map) {
+               iommu_group_put(pool->p.dev->iommu_group);
                 put_device(pool->p.dev);
+       }


--Jesper

>   #include <trace/events/page_pool.h>
>  > @@ -306,6 +307,9 @@ page_pool_create_percpu(const struct
> page_pool_params *params, int cpuid)
>          if (err)
>                  goto err_uninit;
> 
> +       if (pool->dma_map)
> +               iommu_group_get(pool->p.dev);
> +
>          return pool;
> 
>   err_uninit:
> @@ -974,8 +978,11 @@ static int page_pool_release(struct page_pool *pool)
> 
>          page_pool_scrub(pool);
>          inflight = page_pool_inflight(pool, true);
> -       if (!inflight)
> +       if (!inflight) {
>                  __page_pool_destroy(pool);
> +               if (pool->dma_map)
> + iommu_group_put(pool->p.dev->iommu_group);
> +       }
> 
>          return inflight;
>   }
> 
> 
>>>> The page_pool bumps refcnt via get_device() + put_device() on the DMA
>>>> 'struct device', to avoid it going away, but I guess there is also some
>>>> IOMMU code that we need to make sure doesn't go away (until all 
>>>> inflight
>>>> pages are returned) ???
>>>>
>>>>
>>>>> [ 4407.212119] process_one_work+0x164/0x3e0
>>>>> [ 4407.216116]  worker_thread+0x310/0x420
>>>>> [ 4407.219851]  kthread+0x120/0x130
>>>>> [ 4407.223066]  ret_from_fork+0x10/0x20
>>>>> [ 4407.226630] Code: ffffc318 aa1e03e9 d503201f f9416c00 (f9405400)
>>>>> [ 4407.232697] ---[ end trace 0000000000000000 ]---
>>>>>
>>>>>
>>>>> The hns3 driver use page pool like this, just call once when the 
>>>>> driver
>>>>> initialize:
>>>>>
>>>>> static void hns3_alloc_page_pool(struct hns3_enet_ring *ring)
>>>>> {
>>>>>       struct page_pool_params pp_params = {
>>>>>           .flags = PP_FLAG_DMA_MAP | PP_FLAG_PAGE_FRAG |
>>>>>                   PP_FLAG_DMA_SYNC_DEV,
>>>>>           .order = hns3_page_order(ring),
>>>>>           .pool_size = ring->desc_num * hns3_buf_size(ring) /
>>>>>                   (PAGE_SIZE << hns3_page_order(ring)),
>>>>>           .nid = dev_to_node(ring_to_dev(ring)),
>>>>>           .dev = ring_to_dev(ring),
>>>>>           .dma_dir = DMA_FROM_DEVICE,
>>>>>           .offset = 0,
>>>>>           .max_len = PAGE_SIZE << hns3_page_order(ring),
>>>>>       };
>>>>>
>>>>>       ring->page_pool = page_pool_create(&pp_params);
>>>>>       if (IS_ERR(ring->page_pool)) {
>>>>>           dev_warn(ring_to_dev(ring), "page pool creation failed: 
>>>>> %ld\n",
>>>>>                PTR_ERR(ring->page_pool));
>>>>>           ring->page_pool = NULL;
>>>>>       }
>>>>> }
>>>>>
>>>>> And call page_pool_destroy(ring->page_pool)  when the driver 
>>>>> uninitialized.
>>>>>
>>>>>
>>>>> We use two devices, the net port connect directory, and the step of 
>>>>> the
>>>>> test case like below:
>>>>>
>>>>> 1. enable a vf of '7d:00.0':  echo 1 >
>>>>> /sys/class/net/eno1/device/sriov_numvfs
>>>>>
>>>>> 2. use iperf to produce some flows(the problem happens to the side 
>>>>> which
>>>>> runs 'iperf -s')
>>>>>
>>>>> 3. use ifconfig down/up to the vf
>>>>>
>>>>> 4. kill iperf
>>>>>
>>>>> 5. disable the vf: echo 0 > /sys/class/net/eno1/device/sriov_numvfs
>>>>>
>>>>> 6. run 1~5 with another port bd:00.0
>>>>>
>>>>> 7. repeat 1~6
>>>>>
>>>>>
>>>>> And when running this test case, we can found another related 
>>>>> message (I
>>>>> replaced pr_warn() to dev_warn()):
>>>>>
>>>>> pci 0000:7d:01.0: page_pool_release_retry() stalled pool shutdown: id
>>>>> 949, 98 inflight 1449 sec
>>>>>
>>>>>
>>>>> Even when stop the traffic, stop the test case, disable the vf, this
>>>>> message is still being printed.
>>>>>
>>>>> We must run the test case for about two hours to reproduce the 
>>>>> problem.
>>>>> Is there some advise to solve or debug the problem?
>>>>>
>>

