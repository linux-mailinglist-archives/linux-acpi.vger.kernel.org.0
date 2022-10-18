Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0EB602C49
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Oct 2022 15:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiJRNA5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 Oct 2022 09:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiJRNAz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Oct 2022 09:00:55 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EED0C4D8F;
        Tue, 18 Oct 2022 06:00:53 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.32])
        by gateway (Coremail) with SMTP id _____8Dx_7eDo05jHm0AAA--.605S3;
        Tue, 18 Oct 2022 21:00:51 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxXuCDo05jTrMAAA--.2859S3;
        Tue, 18 Oct 2022 21:00:51 +0800 (CST)
Subject: Re: [PATCH V5 1/2] ACPI / scan: Support multiple dma windows with
 different offsets
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Yicong Yang <yangyicong@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>, yangyicong@hisilicon.com,
        lpieralisi@kernel.org, chenhuacai@loongson.cn,
        guohanjun@huawei.com, sudeep.holla@arm.com, lenb@kernel.org,
        robert.moore@intel.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, loongarch@lists.linux.dev,
        liulongfang <liulongfang@huawei.com>
References: <20220911090635.5559-1-lvjianmin@loongson.cn>
 <20220911090635.5559-2-lvjianmin@loongson.cn>
 <8e9df8ea-06f0-3989-2563-d5dc6b09a062@huawei.com>
 <CAJZ5v0gBBdTxRkE08PO8W+yi1eTkWqzpGLAyMNuzZmqx02EzFA@mail.gmail.com>
 <c7ae3a66-1d24-1014-b63a-8d4af3de42c8@arm.com>
 <7904cd2e-caf5-0073-9889-306ab524d802@huawei.com>
 <ded07a34-0cf4-3f76-a538-fb6a9abd6673@loongson.cn>
 <CAJZ5v0i5jo-+B6sq5Aftj_TR=dj4gt-4aiXhbu2BW-=KETQgFw@mail.gmail.com>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <81b8f3db-73b4-b3a4-d3e9-5d1779b13947@loongson.cn>
Date:   Tue, 18 Oct 2022 21:00:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0i5jo-+B6sq5Aftj_TR=dj4gt-4aiXhbu2BW-=KETQgFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxXuCDo05jTrMAAA--.2859S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3Jw1kZF4kCFyUZr43JrWDArb_yoW7Zr1xpr
        y5GF42kr48Jr1UJr1Utw4jqryUtw1UZFyUXrWxG34DCF1qvr1UJrWUtr1rKryUAryYkr1x
        Ja90q3ZayrWUJw7anT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2
        jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
        AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCa
        FVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280
        aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8XTm3UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2022/10/18 下午8:56, Rafael J. Wysocki wrote:
> On Tue, Oct 18, 2022 at 2:50 PM Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>>
>>
>> On 2022/10/18 下午8:32, Yicong Yang wrote:
>>> On 2022/10/18 20:00, Robin Murphy wrote:
>>>> On 2022-10-18 11:08, Rafael J. Wysocki wrote:
>>>>> On Tue, Oct 18, 2022 at 11:33 AM Yicong Yang <yangyicong@huawei.com> wrote:
>>>>>>
>>>>>> On 2022/9/11 17:06, Jianmin Lv wrote:
>>>>>>> In DT systems configurations, of_dma_get_range() returns struct
>>>>>>> bus_dma_region DMA regions; they are used to set-up devices
>>>>>>> DMA windows with different offset available for translation between DMA
>>>>>>> address and CPU address.
>>>>>>>
>>>>>>> In ACPI systems configuration, acpi_dma_get_range() does not return
>>>>>>> DMA regions yet and that precludes setting up the dev->dma_range_map
>>>>>>> pointer and therefore DMA regions with multiple offsets.
>>>>>>>
>>>>>>> Update acpi_dma_get_range() to return struct bus_dma_region
>>>>>>> DMA regions like of_dma_get_range() does.
>>>>>>>
>>>>>>> After updating acpi_dma_get_range(), acpi_arch_dma_setup() is changed for
>>>>>>> ARM64, where the original dma_addr and size are removed as these
>>>>>>> arguments are now redundant, and pass 0 and U64_MAX for dma_base
>>>>>>> and size of arch_setup_dma_ops; this is a simplification consistent
>>>>>>> with what other ACPI architectures also pass to iommu_setup_dma_ops().
>>>>>>>
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> With this patch we met problem as well. The DMA coherent mask is not set correctly
>>>>>> for a ehci usb controller and lead to the below calltrace:
>>>>>>
>>>>>> [   16.699259] ------------[ cut here ]------------
>>>>>> [   16.703855] WARNING: CPU: 0 PID: 853 at kernel/dma/mapping.c:499 dma_alloc_attrs+0xc0/0xf0
>>>>>> [   16.712082] Modules linked in:
>>>>>> [   16.715124] CPU: 0 PID: 853 Comm: kworker/0:3 Not tainted 6.1.0-rc1-pipe-deadlock+ #5
>>>>>> [   16.722916] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 2280-V2 CS V5.B211.01 11/10/2021
>>>>>> [   16.731745] Workqueue: events work_for_cpu_fn
>>>>>> [   16.736083] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>>>> [   16.743013] pc : dma_alloc_attrs+0xc0/0xf0
>>>>>> [   16.747091] lr : dma_pool_alloc+0x11c/0x200
>>>>>> [   16.751255] sp : ffff80001e46bb50
>>>>>> [   16.754554] x29: ffff80001e46bb50 x28: 0000000000000000 x27: 0000000000000000
>>>>>> [   16.761657] x26: ffff80000b33ce18 x25: ffff800009cc6c48 x24: 0000000000000000
>>>>>> [   16.768759] x23: ffff00208c830918 x22: 0000000000001000 x21: 0000000000000cc0
>>>>>> [   16.775861] x20: ffff00208ae82080 x19: ffff0020865c40d0 x18: 0000000000000030
>>>>>> [   16.782964] x17: 626d756e20737562 x16: 2064656e67697373 x15: ffff00208ae82640
>>>>>> [   16.790066] x14: 0000000000000000 x13: 646e756f72616b72 x12: 6f77204348207379
>>>>>> [   16.797167] x11: 73706f6e79532067 x10: ffff205f43980000 x9 : ffff80000830b3ac
>>>>>> [   16.804269] x8 : ffff0020861b1b00 x7 : 0000000000000000 x6 : 0000000000000000
>>>>>> [   16.811371] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000cc0
>>>>>> [   16.818472] x2 : ffff00208c830918 x1 : 0000000000001000 x0 : 0000000000000000
>>>>>> [   16.825574] Call trace:
>>>>>> [   16.828009]  dma_alloc_attrs+0xc0/0xf0
>>>>>> [   16.831741]  dma_pool_alloc+0x11c/0x200
>>>>>> [   16.835559]  ehci_qh_alloc+0x60/0x12c
>>>>>> [   16.839207]  ehci_setup+0x18c/0x40c
>>>>>> [   16.842680]  ehci_pci_setup+0xb8/0x680
>>>>>> [   16.846412]  usb_add_hcd+0x310/0x5c0
>>>>>> [   16.849973]  usb_hcd_pci_probe+0x254/0x36c
>>>>>> [   16.854051]  ehci_pci_probe+0x40/0x60
>>>>>> [   16.857698]  local_pci_probe+0x48/0xb4
>>>>>> [   16.861431]  work_for_cpu_fn+0x24/0x40
>>>>>> [   16.865163]  process_one_work+0x1e0/0x450
>>>>>> [   16.869155]  worker_thread+0x2cc/0x44c
>>>>>> [   16.872886]  kthread+0x114/0x120
>>>>>> [   16.876099]  ret_from_fork+0x10/0x20
>>>>>> [   16.879657] ---[ end trace 0000000000000000 ]---
>>>>>>
>>>>>> After reverting this patch the problem resolved. Tested on the latest 6.1-rc1.
>>>>>
>>>>> OK, I'll queue up a revert of this and one more commit depending on it.
>>>>
>>>> FWIW it looks like the fix should be as simple as below.
>>>>
>>>
>>> Looks like it's the case. The change works on my platform, now the ehci probed successfully again
>>> with no calltrace:
>>>
>>> Tested-by: Yicong Yang <yangyicong@hisilicon.com>
>>>
>>>> Robin.
>>>>
>>>> ----->8-----
>>>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>>>> index 558664d169fc..b6962bff1eae 100644
>>>> --- a/drivers/acpi/scan.c
>>>> +++ b/drivers/acpi/scan.c
>>>> @@ -1509,6 +1509,7 @@ int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
>>>>                goto out;
>>>>            }
>>>>
>>>> +        *map = r;
>>>>            list_for_each_entry(rentry, &list, node) {
>>>>                if (rentry->res->start >= rentry->res->end) {
>>>>                    kfree(r);
>>>> @@ -1523,8 +1524,6 @@ int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
>>>>                r->offset = rentry->offset;
>>>>                r++;
>>>>            }
>>>> -
>>>> -        *map = r;
>>>>        }
>>>>     out:
>>>>        acpi_dev_free_resource_list(&list);
>>>>
>>
>> Ohh, yes, map got a wrong value of r because it has been changed.
> 
> Well, please send me a working patch by EOD tomorrow.
> 

Ok!


>> Maybe wo can fix it like this:
>>
>> truct bus_dma_region *r, *orig_r;
>> ...
>> orig_r = r = kcalloc(ret + 1, sizeof(*r), GFP_KERNEL);
>> ...
>> *map = orig_r;
>>
>>>> .

