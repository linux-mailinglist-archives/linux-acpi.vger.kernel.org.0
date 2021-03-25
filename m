Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2C434931B
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Mar 2021 14:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhCYNc2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Mar 2021 09:32:28 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:22983 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhCYNcC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Mar 2021 09:32:02 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210325133200euoutp01e762f5df54193da531377b93ef0fcc6a~vmRhGmn_S2994429944euoutp01y
        for <linux-acpi@vger.kernel.org>; Thu, 25 Mar 2021 13:32:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210325133200euoutp01e762f5df54193da531377b93ef0fcc6a~vmRhGmn_S2994429944euoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616679120;
        bh=Z/DNfCxQzs0IDWoaY5k0ggzsNxFtNfsppQC7SUo3Oxc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=PMtE0N/GN5n23FKdJXoe8fmfFE0n4PTHJd3YgoYKQPYCm535bMH5dylBD/7xAPS6A
         q4+0hT/utbRMOzRFTSeYrVtJswhqbLyjqTM7c8/0pfbxpLlEFTUpA/GJHzeLLuskvt
         JfW95ozqwAKxC+A8pj2zaJLFcCbZ+vpPvtNEovU0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210325133200eucas1p220f7c0abe8506fb7c14ee5a19048e6d5~vmRgcvosb0792407924eucas1p2T;
        Thu, 25 Mar 2021 13:32:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 5F.25.09452.FC09C506; Thu, 25
        Mar 2021 13:31:59 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210325133159eucas1p297b769beb681743fb32d362a86cc6e3e~vmRfxkYzT0793607936eucas1p2M;
        Thu, 25 Mar 2021 13:31:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210325133159eusmtrp2092b54a21cf01982167e7e9aebd38641~vmRfwEGGD3060130601eusmtrp2q;
        Thu, 25 Mar 2021 13:31:59 +0000 (GMT)
X-AuditID: cbfec7f2-a9fff700000024ec-a5-605c90cf87a7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id FA.32.08705.FC09C506; Thu, 25
        Mar 2021 13:31:59 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210325133157eusmtip1093d76ecea4c2fb8cbe03e117ac26715~vmReav6BN2222222222eusmtip1s;
        Thu, 25 Mar 2021 13:31:57 +0000 (GMT)
Subject: Re: [PATCH] clk: Mark fwnodes when their clock provider is added
To:     Tudor Ambarus <tudor.ambarus@microchip.com>, corbet@lwn.net,
        gregkh@linuxfoundation.org, rafael@kernel.org, khilman@kernel.org,
        ulf.hansson@linaro.org, len.brown@intel.com, lenb@kernel.org,
        pavel@ucw.cz, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, frowand.list@gmail.com, maz@kernel.org,
        tglx@linutronix.de, saravanak@google.com
Cc:     nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        geert@linux-m68k.org, kernel-team@android.com,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <d24bebc5-0f78-021f-293f-e58defa32531@samsung.com>
Date:   Thu, 25 Mar 2021 14:31:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210210114435.122242-2-tudor.ambarus@microchip.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUxTVxzdfa99rxDrHgXTO2aYNJM5l/FhMN6NxjDF7S1EQzYXF4KjFd/A
        FSq2sM0tGQhUoSoUi1FrCZiiMD4E21GtCKylriBLy4ZjjCGufJTJhqbW+S2O55ON/8459/zO
        73eSK8BFViJcsEuZx6iU8mwJEcyz/vDA86ZHlyaLNfqkyNP1mEST3x8AqMbp5qMTfz8lkG+k
        E0PFplYCXTgfhqYsExgyVM1LNu8sgeq7KgDyHxrjo1P763ho8KKRQIHDToAqf28jkc3Yx0c/
        XdmEzltO4chqqCfQtSuXCVR95yiONJ1OEmkdTwg0N3SOhyzmec1fl4hcLdsSl9PWDiufvjWs
        IWmb4RpJ15rzadOlGxhtbiwj6NGhSwR90+0maUdPKaC7q5tJ2lJXQJvK9Xx69P5pQFv6v6Yb
        mu6RdMAckUKlBkt3Mtm7PmdUMetlwVnlk5O83PGILzXXrUQhKAnXgiABpOJhwPYLoQXBAhHV
        AKDe1P+c3AFwYrYFZ10iKgBgYb1kYaLn0a3npnoAL3fcAxzxA+g3dWBaIBCEUu9DszGL1cOo
        GxjU+1p5LMGpUhz2/OHlsVEEFQe1s1qCxUJqPTzS58RYzKNWwqkBL58NWkbtgG2O7ZwlBPad
        mHw2GkRtgP0VTc/sOPUKLG4/iXNYDEcmazB2F6TswVBnbAZsDqSS4F9VG7kGoXDG9R3J4eXw
        qW3BXwyg191CcuQQgINFxwHnSoCj7ocEG4RTr8PWizGc/A4sDdzmc/lL4fBsCHfDUnjEegzn
        ZCEs3S/i3FHQ4Dr731r7wM+4DkgMi5oZFrUxLGpj+H9vLeA1AjGTr87JZNRxSuaLaLU8R52v
        zIzO2J1jBvNfu3/OdfsCqJ7xRzsAJgAOAAW4JEy4Y3OaTCTcKd/7FaPana7Kz2bUDvCygCcR
        CxtPNqeLqEx5HqNgmFxGtfCKCYLCCzGj8u25pMGOo70vvXo38rcl/Kzjvc6QtYel7mPnIh+t
        Ufu2JXVRSQV2YpOqL8Ja9GdKXfnVkUp7e9QKRTf2ickzkLCltnt8YxSpV0wcgOsG8E5F6bS1
        KUCLtQW/vmUs8qTBD8+KKl6bmrbpM16sHz4T8vjT7pLte+7aNQZP+B51WmjDhoS8j6XK96qS
        /Vs0kaHJg5qxis3XpaMfpH8kU6DuJLtuXEp4qCWf+eIPrvJthS0Pl4l/FL/xZPXVWBQpWrPu
        4Kqw9sq9qSUZutah1JmBM15Jb3LN/fgU3YPeqH2935QpX2jwrV3R5oopc347nfhu/D9BUxL9
        ygTZvrFYUe7NZAlPnSWPW42r1PJ/AU4O5fpJBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsVy+t/xu7rnJ8QkGHxey29xft8fdosnB9oZ
        LeYfOcdqMfPNfzaLZ7f2Mlk0L17PZrFju4jF082PmSxmTQEK7Xz4ls1i+b5+RouPPfdYLRa2
        LWGxuLxrDpvF594jjBYTb29gt9g55ySrxcVTrhbbNy9kttg2azmbxd1TR9ks5n6ZymzRuvcI
        u0XXob9sFv+ubWSx2LwJKPZxiYPF8bXhDjIe23ZvY/V4f6OV3WPnrLvsHgs2lXos3vOSyWPT
        qk42jzvX9rB5vDt3jt3j0OEORo/9c9ewe2xeUu+xuG8yq8edH0sZPTafrvZYsfo7u8fnTXIB
        AlF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GX1P
        nrAUPJKraL2/ja2BsUWqi5GTQ0LAROLw7/dsXYxcHEICSxklXi58ygyRkJE4Oa2BFcIWlvhz
        rQuq6D2jxNfLk1i6GDk4hAU8JTbNyQCJiwi8ZJJ4tWkfK4jDLNDBLHHpeDc7RMdqRolr//4y
        gYxiEzCU6HoLMoqTg1fATmLSySNgcRYBVYmnFx6CrRMVSJK4vGQiK0SNoMTJmU9YQGxOASeJ
        0/2rweqZBcwk5m1+yAxhy0s0b50NZYtL3Hoyn2kCo9AsJO2zkLTMQtIyC0nLAkaWVYwiqaXF
        uem5xYZ6xYm5xaV56XrJ+bmbGIGpatuxn5t3MM579VHvECMTB+MhRgkOZiUR3iTfmAQh3pTE
        yqrUovz4otKc1OJDjKZA/0xklhJNzgcmy7ySeEMzA1NDEzNLA1NLM2Mlcd6tc9fECwmkJ5ak
        ZqemFqQWwfQxcXBKNTAd2sJbqSZ3ZsaPzGfXT7892/3YTKtiQ9tn8Uotpq/7Vv/eOMFRykax
        f9X+bd3fMqdxfRQOq8644Xc84WpJhHE/l5e34oIXxnuWx20si5L5cfMpf4Xw7UvfJ/VwPhDp
        vCLSv+JQwxyZy3Fs5oZTPvSd5FS1P7OizyJ5wqU+jdStk1N7BZpe7bjLEW2uz+kq/WY189uc
        iD/7X9Tty5ygu6FvX/cS+wWdN7h1dvzw4nI+s2xVvZRG6HJJdsei0s2PeBhV8rM+W77YcOaW
        3OHwtypHjH52xRW/zlP8cmjp/LKXbQb9hs99v2hc8/RLCE35pZ3Rxq8R9lOSkeGU8+xXyZOt
        zl9h95nyPz8mQIOnh0+JpTgj0VCLuag4EQC4OsQT3gMAAA==
X-CMS-MailID: 20210325133159eucas1p297b769beb681743fb32d362a86cc6e3e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210325133159eucas1p297b769beb681743fb32d362a86cc6e3e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210325133159eucas1p297b769beb681743fb32d362a86cc6e3e
References: <20210205222644.2357303-9-saravanak@google.com>
        <20210210114435.122242-1-tudor.ambarus@microchip.com>
        <20210210114435.122242-2-tudor.ambarus@microchip.com>
        <CGME20210325133159eucas1p297b769beb681743fb32d362a86cc6e3e@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi

On 10.02.2021 12:44, Tudor Ambarus wrote:
> This is a follow-up for:
> commit 3c9ea42802a1 ("clk: Mark fwnodes when their clock provider is added/removed")
>
> The above commit updated the deprecated of_clk_add_provider(),
> but missed to update the preferred of_clk_add_hw_provider().
> Update it now.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

This patch, which landed in linux-next as commit 6579c8d97ad7 ("clk: 
Mark fwnodes when their clock provider is added") causes the following 
NULL pointer dereference on Raspberry Pi 3b+ boards:

--->8---

raspberrypi-firmware soc:firmware: Attached to firmware from 
2020-01-06T13:05:25
Unable to handle kernel NULL pointer dereference at virtual address 
0000000000000050
Mem abort info:
   ESR = 0x96000004
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
Data abort info:
   ISV = 0, ISS = 0x00000004
   CM = 0, WnR = 0
[0000000000000050] user address but active_mm is swapper
Internal error: Oops: 96000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 10 Comm: kworker/0:1 Not tainted 5.12.0-rc4+ #2764
Hardware name: Raspberry Pi 3 Model B (DT)
Workqueue: events deferred_probe_work_func
pstate: 00000005 (nzcv daif -PAN -UAO -TCO BTYPE=--)
pc : of_clk_add_hw_provider+0xac/0xe8
lr : of_clk_add_hw_provider+0x94/0xe8
sp : ffff8000130936b0
x29: ffff8000130936b0 x28: ffff800012494e04
x27: ffff00003b18cb05 x26: ffff00003aa5c010
x25: 0000000000000000 x24: 0000000000000000
x23: ffff00003aa1e380 x22: ffff8000106830d0
x21: ffff80001233f180 x20: 0000000000000018
x19: 0000000000000000 x18: ffff8000124d38b0
x17: 0000000000000013 x16: 0000000000000014
x15: ffff8000125758b0 x14: 00000000000184e0
x13: 000000000000292e x12: ffff80001258dd98
x11: 0000000000000001 x10: 0101010101010101
x9 : ffff80001233f288 x8 : 7f7f7f7f7f7f7f7f
x7 : fefefefeff6c626f x6 : 5d636d8080808080
x5 : 00000000006d635d x4 : 0000000000000000
x3 : 0000000000000000 x2 : 540eb5edae191600
x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
  of_clk_add_hw_provider+0xac/0xe8
  devm_of_clk_add_hw_provider+0x5c/0xb8
  raspberrypi_clk_probe+0x110/0x210
  platform_probe+0x90/0xd8
  really_probe+0x108/0x3c0
  driver_probe_device+0x60/0xc0
  __device_attach_driver+0x9c/0xd0
  bus_for_each_drv+0x70/0xc8
  __device_attach+0xec/0x150
  device_initial_probe+0x10/0x18
  bus_probe_device+0x94/0xa0
  device_add+0x47c/0x780
  platform_device_add+0x110/0x248
  platform_device_register_full+0x120/0x150
  rpi_firmware_probe+0x158/0x1f8
  platform_probe+0x90/0xd8
  really_probe+0x108/0x3c0
  driver_probe_device+0x60/0xc0
  __device_attach_driver+0x9c/0xd0
  bus_for_each_drv+0x70/0xc8
  __device_attach+0xec/0x150
  device_initial_probe+0x10/0x18
  bus_probe_device+0x94/0xa0
  deferred_probe_work_func+0x70/0xa8
  process_one_work+0x2a8/0x718
  worker_thread+0x48/0x460
  kthread+0x134/0x160
  ret_from_fork+0x10/0x18
Code: b1006294 540000c0 b140069f 54000088 (3940e280)
---[ end trace 7ead5ec2f0c51cfe ]---

This patch mainly revealed that clk/bcm/clk-raspberrypi.c driver calls 
devm_of_clk_add_hw_provider(), with a device pointer, which has a NULL 
dev->of_node. I'm not sure if adding a check for a NULL np in 
of_clk_add_hw_provider() is a right fix, though.

> ---
>   drivers/clk/clk.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 27ff90eacb1f..9370e4dfecae 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -4594,6 +4594,8 @@ int of_clk_add_hw_provider(struct device_node *np,
>   	if (ret < 0)
>   		of_clk_del_provider(np);
>   
> +	fwnode_dev_initialized(&np->fwnode, true);
> +
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(of_clk_add_hw_provider);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

