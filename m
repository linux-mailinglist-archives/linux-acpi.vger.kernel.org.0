Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0341D8FFA
	for <lists+linux-acpi@lfdr.de>; Tue, 19 May 2020 08:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgESGZN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 May 2020 02:25:13 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44983 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgESGZM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 May 2020 02:25:12 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200519062511euoutp012f01509cd9fc8c47d20b036f55663d30~QWeWXGUCL3126131261euoutp01I
        for <linux-acpi@vger.kernel.org>; Tue, 19 May 2020 06:25:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200519062511euoutp012f01509cd9fc8c47d20b036f55663d30~QWeWXGUCL3126131261euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1589869511;
        bh=0mW8JOdJHsUIuudHdYQY2xk3EpXB94vPBsb+CkQ0YLM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=IX/urPLJunFGzHZ1iVPk2oI7Kx2ZKm5vTo63BWHGWiVzfjxS0jT8MTfM13gDlUriI
         AcykNnFXg0hJBdbPIdF+0yn+r0zW83cUr3NpLelttrBhxe6ckpf0TMTDTrqVHDLD6q
         PO4nEXgsOlhrBOCcQUGqGvpf0jkfv9Y62S3gmnbk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200519062510eucas1p193d04a2ebe1b0ba231cc4cd1f5611e39~QWeWFaLvj2639226392eucas1p10;
        Tue, 19 May 2020 06:25:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B3.07.60679.6CB73CE5; Tue, 19
        May 2020 07:25:10 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200519062510eucas1p27bc59da66e1b77534855103a27f87452~QWeVp_qk70674606746eucas1p27;
        Tue, 19 May 2020 06:25:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200519062510eusmtrp25052833a9b71e6ec5b0b3efe1d020f32~QWeVpNDDJ2870828708eusmtrp2o;
        Tue, 19 May 2020 06:25:10 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-99-5ec37bc60e22
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7F.89.08375.6CB73CE5; Tue, 19
        May 2020 07:25:10 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200519062509eusmtip2ae416adb5fb901ac1d88051c545cd8c9~QWeU_A1_a1418614186eusmtip2S;
        Tue, 19 May 2020 06:25:09 +0000 (GMT)
Subject: Re: [PATCH v1 4/4] of: platform: Batch fwnode parsing when adding
 all top level devices
To:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        Ji Luo <ji.luo@nxp.com>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <e0f9211d-9cf6-a12d-eb63-df06910920ed@samsung.com>
Date:   Tue, 19 May 2020 08:25:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200515053500.215929-5-saravanak@google.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7djPc7rHqg/HGXw9rWsx/8g5VouZb/6z
        WTQvXs9mMePOEXaLHdtFLHY+fMtmsXxfP6PF5V1zgOLn9zFZzP0yldmidS9QRdehv2wOPB7b
        dm9j9dg56y67x4JNpR6bVnWyeeyfu4bdY+O7HUwenzfJBbBHcdmkpOZklqUW6dslcGWsWPKF
        teCiWMX3DRsZGxifCHUxcnJICJhIPFzzm62LkYtDSGAFo0Tb6RnMEM4XRomlz2YwQjifGSUe
        ft7DCtMy+ctzqKrljBJbl51lh3DeM0ps71gKVMXBISyQJPF9Ch9IXETgA6PE49k3WEAcZoHj
        jBIPps9iBBnFJmAo0fW2iw3E5hWwk7hw/CYziM0ioCqxaNVJsBpRgViJ04s3M0LUCEqcnPmE
        BcTmFLCWeDhhD1gvs4C8RPPW2cwQtrjErSfzmUCWSQi8ZJd4++YZO8TdLhJHXzdA/SAs8er4
        Fqi4jMT/nTANzUCPnlvLDuH0MEpcbprBCFFlLXHn3C82kN+YBTQl1u/Shwg7SmxunMwCEpYQ
        4JO48VYQ4gg+iUnbpjNDhHklOtqgoa0mMev4Ori1By9cYp7AqDQLyWuzkLwzC8k7sxD2LmBk
        WcUonlpanJueWmyUl1quV5yYW1yal66XnJ+7iRGYyk7/O/5lB+OuP0mHGAU4GJV4eBPyD8UJ
        sSaWFVfmHmKU4GBWEuGd8AIoxJuSWFmVWpQfX1Sak1p8iFGag0VJnNd40ctYIYH0xJLU7NTU
        gtQimCwTB6dUA2NUlEX3wxeLF50tq8n6c8ywa7YU39/5bpMdGf+f/zmhb/Etd+8zv3O/Pn3d
        dGr3y5X26m3Nj0T0FJK7+jTs+JcUzLlbVVK+c3vL32jJkq7HHx+Hfg2cdNnkuv/hjBtp+TUG
        HAsTZ0Sp+l153LG5gtFK+ditl2dSxKJVt+zn9o5J8K1dsk1DXU+JpTgj0VCLuag4EQCl9sCW
        YQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsVy+t/xe7rHqg/HGfxp5rWYf+Qcq8XMN//Z
        LJoXr2ezmHHnCLvFju0iFjsfvmWzWL6vn9Hi8q45QPHz+5gs5n6ZymzRuheoouvQXzYHHo9t
        u7exeuycdZfdY8GmUo9NqzrZPPbPXcPusfHdDiaPz5vkAtij9GyK8ktLUhUy8otLbJWiDS2M
        9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJWLPnCWnBRrOL7ho2MDYxPhLoYOTkk
        BEwkJn95ztzFyMUhJLCUUeLxpNWMEAkZiZPTGlghbGGJP9e62CCK3jJK7Jr3h6WLkYNDWCBJ
        4sE8S5C4iMAHRokP0+6wgjjMAicZJVadb2QEKRISyJbYedAAZBCbgKFE11uQQZwcvAJ2EheO
        32QGsVkEVCUWrToJtlhUIFZi9bVWRogaQYmTM5+wgNicAtYSDyfsAetlFjCTmLf5ITOELS/R
        vHU2lC0ucevJfKYJjEKzkLTPQtIyC0nLLCQtCxhZVjGKpJYW56bnFhvqFSfmFpfmpesl5+du
        YgTG7bZjPzfvYLy0MfgQowAHoxIPb0L+oTgh1sSy4srcQ4wSHMxKIrwTXgCFeFMSK6tSi/Lj
        i0pzUosPMZoCPTeRWUo0OR+YUvJK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQW
        wfQxcXBKNTDWfnmwS3Wto3iR40bFYw/+1uzfcSd/5rXX1+98+8b5JMSpQ6nUyOmc40mt+x9S
        tbSs7vifVU7I+K5e+1U0ZdV9g29xq7aLTZjGts2L+19rXarUzdW6831ZxG9s3FVmNW9N7+ag
        s2eUrpulh2gJOx5dUFJhoW6c0avt6TJjuc2h/OuO9xYd8/BUYinOSDTUYi4qTgQAHOWNNvEC
        AAA=
X-CMS-MailID: 20200519062510eucas1p27bc59da66e1b77534855103a27f87452
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200519062510eucas1p27bc59da66e1b77534855103a27f87452
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200519062510eucas1p27bc59da66e1b77534855103a27f87452
References: <20200515053500.215929-1-saravanak@google.com>
        <20200515053500.215929-5-saravanak@google.com>
        <CGME20200519062510eucas1p27bc59da66e1b77534855103a27f87452@eucas1p2.samsung.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Saravana,

On 15.05.2020 07:35, Saravana Kannan wrote:
> The fw_devlink_pause() and fw_devlink_resume() APIs allow batching the
> parsing of the device tree nodes when a lot of devices are added. This
> will significantly cut down parsing time (as much a 1 second on some
> systems). So, use them when adding devices for all the top level device
> tree nodes in a system.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

This patch recently landed in linux-next 20200518. Sadly, it causes 
regression on Samsung Exynos5433-based TM2e board:

s3c64xx-spi 14d30000.spi: Failed to get RX DMA channel
s3c64xx-spi 14d50000.spi: Failed to get RX DMA channel
s3c64xx-spi 14d30000.spi: Failed to get RX DMA channel
s3c64xx-spi 14d50000.spi: Failed to get RX DMA channel
s3c64xx-spi 14d30000.spi: Failed to get RX DMA channel

Internal error: synchronous external abort: 96000210 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 50 Comm: kworker/0:1 Not tainted 5.7.0-rc5+ #701
Hardware name: Samsung TM2E board (DT)
Workqueue: events deferred_probe_work_func
pstate: 60000005 (nZCv daif -PAN -UAO)
pc : samsung_i2s_probe+0x768/0x8f0
lr : samsung_i2s_probe+0x688/0x8f0
...
Call trace:
  samsung_i2s_probe+0x768/0x8f0
  platform_drv_probe+0x50/0xa8
  really_probe+0x108/0x370
  driver_probe_device+0x54/0xb8
  __device_attach_driver+0x90/0xc0
  bus_for_each_drv+0x70/0xc8
  __device_attach+0xdc/0x140
  device_initial_probe+0x10/0x18
  bus_probe_device+0x94/0xa0
  deferred_probe_work_func+0x70/0xa8
  process_one_work+0x2a8/0x718
  worker_thread+0x48/0x470
  kthread+0x134/0x160
  ret_from_fork+0x10/0x1c
Code: 17ffffaf d503201f f94086c0 91003000 (88dffc00)
---[ end trace ccf721c9400ddbd6 ]---
Kernel panic - not syncing: Fatal exception
SMP: stopping secondary CPUs
Kernel Offset: disabled
CPU features: 0x090002,24006087
Memory Limit: none

---[ end Kernel panic - not syncing: Fatal exception ]---

Both issues, the lack of DMA for SPI device and Synchronous abort in I2S 
probe are new after applying this patch. I'm trying to investigate which 
resources are missing and why. The latter issue means typically that the 
registers for the given device has been accessed without enabling the 
needed clocks or power domains.

> ---
>   drivers/of/platform.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 3371e4a06248..55d719347810 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -538,7 +538,9 @@ static int __init of_platform_default_populate_init(void)
>   	}
>   
>   	/* Populate everything else. */
> +	fw_devlink_pause();
>   	of_platform_default_populate(NULL, NULL, NULL);
> +	fw_devlink_resume();
>   
>   	return 0;
>   }

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

