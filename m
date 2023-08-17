Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762FB77F239
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Aug 2023 10:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240109AbjHQIct (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Aug 2023 04:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349040AbjHQIc0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Aug 2023 04:32:26 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF36330F5
        for <linux-acpi@vger.kernel.org>; Thu, 17 Aug 2023 01:32:03 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230817083136euoutp01c68d839c3335b2c3ee39ba4516f6081d~8HoBkJ3F82781627816euoutp01S
        for <linux-acpi@vger.kernel.org>; Thu, 17 Aug 2023 08:31:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230817083136euoutp01c68d839c3335b2c3ee39ba4516f6081d~8HoBkJ3F82781627816euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1692261096;
        bh=LWP6HOUT/s0Qm9UKvuvZTZgDiYa8sLT/CKDjn3kJWgM=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=PISQEF7DUIx7CEhZ9FWcIhBIT2GI0QRucANTAsVKnrf2cbxVQNzpBOMOer/zCAGPR
         7SX5hmLvKQGtCOMs4MzjW1GAsurHMIj5D82cQIlt88egiUHBY9HIdMvyzTAMutVhJW
         kabWXWHI3dUbsNgU8kcjoEUT4dGrYPBmPqoghM+0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230817083133eucas1p27af8d0f0896238066dec92d203622cd6~8Hn_pR_ci2199221992eucas1p2j;
        Thu, 17 Aug 2023 08:31:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 72.BC.42423.5EADDD46; Thu, 17
        Aug 2023 09:31:33 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230817083133eucas1p259c8ff768faa7052d94779c3cf3c2da6~8Hn_XocV13025930259eucas1p2C;
        Thu, 17 Aug 2023 08:31:33 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230817083133eusmtrp2cad3626781e3d81bf217ad2c9ceaadbe~8Hn_WwxxO0066900669eusmtrp2h;
        Thu, 17 Aug 2023 08:31:33 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-ab-64dddae5187e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 10.70.10549.5EADDD46; Thu, 17
        Aug 2023 09:31:33 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230817083132eusmtip1446eb92a3c94c7171b321b3fec735912~8Hn9hVT970220002200eusmtip16;
        Thu, 17 Aug 2023 08:31:32 +0000 (GMT)
Message-ID: <d090f196-a5c2-b188-31bf-e42553d8d251@samsung.com>
Date:   Thu, 17 Aug 2023 10:31:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 0/4] Fix device_lock deadlock on two probe() paths
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Chen-Yu Tsai <wenst@chromium.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <0-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRmVeSWpSXmKPExsWy7djPc7pPb91NMZhxV8li88StbBa/vlhY
        XPm3h9Gic/YGdovJp+YyWSx9u5XdYufDt2wWy/f1M1rM/TKV2eLghyesFjPaLrNatNwxdeDx
        eHJwHpPHmnlrGD1mN1xk8Vi85yWTx6ZVnWwe804GerzYPJPRo7f5HZvH5tPVHp83yQVwRXHZ
        pKTmZJalFunbJXBlbP3wmbVgpkbFk4V9jA2MO5W6GDk5JARMJI7vamTvYuTiEBJYwSjx/mMT
        M4TzhVHid/N0JgjnM6PEux2PWWFa2o/cg0osZ5ToPNLLAuF8ZJQ4t3QpM0gVr4CdxPqHZ9hA
        bBYBVYmetiY2iLigxMmZT1hAbFGBVIlnt+awg9jCAp4Se342gsWZBcQlbj2ZD7ZBRKCdSWL2
        5T6wDcwC/YwSJ5a/ApvEJmAo0fW2C8zmFPCQeHViCTNEt7xE89bZYF9ICMzmlLh/9j4LxOEu
        EiuOXWWEsIUlXh3fwg5hy0j83wmxTkKgnVFiwe/7UM4ERomG57egOqwl7pz7BbSOA2iFpsT6
        XfoQYUeJF7uPsIOEJQT4JG68FYQ4gk9i0rbpzBBhXomONiGIajWJWcfXwa09eOES8wRGpVlI
        ATMLKQBmIXlnFsLeBYwsqxjFU0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3MQLT3Ol/xz/tYJz7
        6qPeIUYmDsZDjBIczEoivD28t1KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ82rbnkwWEkhPLEnN
        Tk0tSC2CyTJxcEo1MM37l6Ts+GG38o3aRHGRbzsMvxveSuqRCHjqE5Xvc/lvmiRHQe5uZls+
        7rcC88MXxSi87l2+4baixuemT1/t4yvlWl6nRb6v2XO77lWe4938WZe12GI+1L85cdVHMna3
        4hLRuc/E36SnTdoxIeNfjc0WMZnXBTrnO847HJl+bt7EmZrny2ZJMBx45FMn96TJMkPghp+D
        j3FK6/Hdj7+xejdEGoge+3WXqfGCmCiz+wuHONdr2QsPT4zOeP03YNX0211u6XKnX26J6drW
        NG2ilUAtE3+sh634j4bbslls8iz7Mz/4TJftUTpb8i/2hfsr8XncRzd+fOK9fOdhGfe9DWdZ
        mqt4n85b8531U7NLmRJLcUaioRZzUXEiAJmW6rniAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsVy+t/xu7pPb91NMZi/ncdi88StbBa/vlhY
        XPm3h9Gic/YGdovJp+YyWSx9u5XdYufDt2wWy/f1M1rM/TKV2eLghyesFjPaLrNatNwxdeDx
        eHJwHpPHmnlrGD1mN1xk8Vi85yWTx6ZVnWwe804GerzYPJPRo7f5HZvH5tPVHp83yQVwRenZ
        FOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlbP3wmbVg
        pkbFk4V9jA2MO5W6GDk5JARMJNqP3GPqYuTiEBJYyiixaO9ZNoiEjMTJaQ2sELawxJ9rXWwQ
        Re8ZJaZv280CkuAVsJNY//AMWAOLgKpET1sTG0RcUOLkzCdgNaICqRLfb+0DiwsLeErs+dkI
        FmcWEJe49WQ+2GYRgXYmiZUfvzBDJPoZJd6eL4fYNptR4tLRR+wgCTYBQ4mut11gkzgFPCRe
        nVgC1WAm0bW1ixHClpdo3jqbeQKj0Cwkh8xCsnAWkpZZSFoWMLKsYhRJLS3OTc8tNtQrTswt
        Ls1L10vOz93ECIzqbcd+bt7BOO/VR71DjEwcjIcYJTiYlUR4e3hvpQjxpiRWVqUW5ccXleak
        Fh9iNAWGxkRmKdHkfGBaySuJNzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi
        4JRqYNoVpXE4xm3PWQkf8Zdd/86Eqa/e6WJYpXz3mHxun6+knsmdl2t/GPjOtuLR5jI18uQ4
        LXaD8/6hnIeq3gcF01gmvPCLCDu1+GpoxNvq/UsfJCTM0TPjVoyscLOtelv6qu7HWZHfH/Zw
        SDgezJdhCGaQTk/r0M+osn3bvTuur3waowLT+d2sb3bkB8b5h3ktWZ15el2L9DTGJrZLy8/n
        3J96OsAm5ngmv/XXv8Wfpyo5as/QeBEU4HHqHNvPecV7j/6+2ZvR+075yWNFa6HFzvsKGTv/
        h3Id53mavLL/8LcLXYUhV2dzMsh41Udcufh4vfpp906LE8veLrf3KP56SmHNrEOu7+7zf9Mz
        zDixW4mlOCPRUIu5qDgRAA4/PdRzAwAA
X-CMS-MailID: 20230817083133eucas1p259c8ff768faa7052d94779c3cf3c2da6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230809144403eucas1p1345aec6ec34440f1794594426e0402ab
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230809144403eucas1p1345aec6ec34440f1794594426e0402ab
References: <CGME20230809144403eucas1p1345aec6ec34440f1794594426e0402ab@eucas1p1.samsung.com>
        <0-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jason,

On 09.08.2023 16:43, Jason Gunthorpe wrote:
> I missed two paths where __iommu_probe_device() can be called while
> already holding the device_lock() for the device that is to be probed.
>
> This causes a deadlock because __iommu_probe_device() will attempt to
> re-acquire the lock.
>
> Organize things so that these two paths can re-use the existing already
> held device_lock by marking the call chains based on if the lock is held
> or not.
>
> Also the order of iommu_init_device() was not correct for
> generic_single_device_group()

I've just noticed that there is still one more issue left to fix after 
applying this patchset. On Qualcomm's RB5 board I get the following 
warning (captured on vanilla next-20230817):

------------[ cut here ]------------
WARNING: CPU: 6 PID: 274 at include/linux/device.h:1012 
iommu_probe_device_locked+0xd4/0xe4
Modules linked in: apr pdr_interface venus_dec venus_enc 
videobuf2_dma_contig rpmsg_ctrl fastrpc qrtr_smd rpmsg_char 
lontium_lt9611uxc msm mcp251xfd qcom_camss can_dev videobuf2_dma_sg 
ocmem imx412 gpu_sched venus_core snd_soc_sm8250 phy_qcom_qmp_combo 
videobuf2_memops v4l2_fwnode leds_qcom_lpg v4l2_mem2mem drm_dp_aux_bus 
v4l2_async snd_soc_qcom_sdw videobuf2_v4l2 ax88179_178a onboard_usb_hub 
videodev rtc_pm8xxx qcom_spmi_adc5 qcom_pon qcom_spmi_adc_tm5 
led_class_multicolor qcom_spmi_temp_alarm qcom_vadc_common crct10dif_ce 
i2c_qcom_geni snd_soc_qcom_common qrtr drm_display_helper 
videobuf2_common camcc_sm8250 mc typec i2c_qcom_cci spi_geni_qcom 
qcom_stats llcc_qcom phy_qcom_qmp_usb qcom_rng icc_bwmon qcom_q6v5_pas 
qcrypto phy_qcom_snps_femto_v2 qcom_pil_info sha256_generic 
soundwire_qcom coresight_stm coresight_tmc stm_core coresight_funnel 
coresight_replicator libsha256 qcom_q6v5 pinctrl_sm8250_lpass_lpi 
soundwire_bus snd_soc_lpass_va_macro snd_soc_lpass_macro_common 
pinctrl_lpass_lpi coresight authenc
  lpass_gfm_sm8250 qcom_sysmon slimbus snd_soc_lpass_wsa_macro libdes 
qcom_common qcom_glink_smem socinfo mdt_loader qmi_helpers 
phy_qcom_qmp_pcie icc_osm_l3 qcom_wdt display_connector ip_tables 
x_tables ipv6
CPU: 6 PID: 274 Comm: kworker/u16:8 Not tainted 6.5.0-rc6-next-20230817 
#13867
Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
Workqueue: events_unbound deferred_probe_work_func
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : iommu_probe_device_locked+0xd4/0xe4
lr : iommu_probe_device_locked+0x78/0xe4
...
Call trace:
  iommu_probe_device_locked+0xd4/0xe4
  of_iommu_configure+0x10c/0x200
  of_dma_configure_id+0x104/0x3b8
  a6xx_gmu_init+0x4c/0xccc [msm]
  a6xx_gpu_init+0x3ac/0x770 [msm]
  adreno_bind+0x174/0x2ac [msm]
  component_bind_all+0x118/0x24c
  msm_drm_bind+0x1e8/0x6c4 [msm]
  try_to_bring_up_aggregate_device+0x168/0x1d4
  __component_add+0xa8/0x170
  component_add+0x14/0x20
  dsi_dev_attach+0x20/0x2c [msm]
  dsi_host_attach+0x9c/0x144 [msm]
  devm_mipi_dsi_attach+0x34/0xb4
  lt9611uxc_attach_dsi.isra.0+0x84/0xfc [lontium_lt9611uxc]
  lt9611uxc_probe+0x5c8/0x68c [lontium_lt9611uxc]
  i2c_device_probe+0x14c/0x290
  really_probe+0x148/0x2b4
  __driver_probe_device+0x78/0x12c
  driver_probe_device+0x3c/0x160
  __device_attach_driver+0xb8/0x138
  bus_for_each_drv+0x84/0xe0
  __device_attach+0xa8/0x1b0
  device_initial_probe+0x14/0x20
  bus_probe_device+0xb0/0xb4
  deferred_probe_work_func+0x8c/0xc8
  process_one_work+0x1ec/0x53c
  worker_thread+0x298/0x408
  kthread+0x124/0x128
  ret_from_fork+0x10/0x20
irq event stamp: 207712
hardirqs last  enabled at (207711): [<ffffcfe16b46b160>] 
_raw_spin_unlock_irqrestore+0x74/0x78
hardirqs last disabled at (207712): [<ffffcfe16b458630>] el1_dbg+0x24/0x8c
softirqs last  enabled at (206480): [<ffffcfe16a290a10>] 
__do_softirq+0x438/0x4ec
softirqs last disabled at (206473): [<ffffcfe16a296980>] 
____do_softirq+0x10/0x1c
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------

Let me know if you need more information or some tests on the hardware.


>
> v2:
>   - New patch to correct the order of setting iommu_dev during
>     iommu_init_device()
>   - Spelling fixes
>   - Simply block probing the iommu device itself instead of trying to do it
> v1: https://lore.kernel.org/r/0-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com
>
> Jason Gunthorpe (4):
>    iommu: Provide iommu_probe_device_locked()
>    iommu: Pass in the iommu_device to probe for in bus_iommu_probe()
>    iommu: Do not attempt to re-lock the iommu device when probing
>    iommu: dev->iommu->iommu_dev must be set before ops->device_group()
>
>   drivers/acpi/scan.c        |  5 +--
>   drivers/iommu/iommu.c      | 65 +++++++++++++++++++++++++++-----------
>   drivers/iommu/of_iommu.c   |  2 +-
>   drivers/iommu/omap-iommu.c | 12 +++++--
>   include/linux/iommu.h      |  6 +++-
>   5 files changed, 65 insertions(+), 25 deletions(-)
>
>
> base-commit: 8d3740021d5d461e1ec4c17fc5625b9b4237c2f8

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

