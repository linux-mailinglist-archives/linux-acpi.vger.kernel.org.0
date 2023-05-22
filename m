Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D7D70BDBF
	for <lists+linux-acpi@lfdr.de>; Mon, 22 May 2023 14:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbjEVMXK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 22 May 2023 08:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbjEVMW5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 May 2023 08:22:57 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2851918C
        for <linux-acpi@vger.kernel.org>; Mon, 22 May 2023 05:20:24 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-96f66fbd770so64961766b.1
        for <linux-acpi@vger.kernel.org>; Mon, 22 May 2023 05:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684757911; x=1687349911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6loFUA9mZTaBhksiYSDr//MIYwSKmH+WH5P5CiDYiw=;
        b=DLxGcRWsV87fuN9ZaDhRTNSfxjyc3ltqRkIblDOd7hwSzwB7pAD0FFItd0HKJHK+LR
         4PZXRh9P97khD8C0gB3RsiRa/dnNgIasCKp1VdqwbYjGp59n23zLJCh+ADDTMUPrZrI+
         FY5PSAlNvK9wrfdzr7I53ZLYAvwHU/ZQueaDZ1qPTlabdjb2El6h11laibB1Oi9ofXxP
         eI7fkZU/Ugv3Crn0VsM+0B/tSLPgPj+c8e/l+yB0X11ysFyvBe/E5pEwVbsdU7p2gDyx
         bHV3o1Bcxr6g2fmFEN8xlJ7JICG9jmpdauKZO7QELv8iy8GiVs0GzhLhdjWoLLJtsFrd
         uU+Q==
X-Gm-Message-State: AC+VfDwvaQP3ZJp5ZKVqIshNDy052okaybRCvjlugUVcoK9kRlM/rlWr
        a8jZJbXEUk57AqdKl3RL5EthfJ63eq0waiVfwtM=
X-Google-Smtp-Source: ACHHUZ6M5NMrb+OBmOGW1h/Os0NMQMNGTVGnzskp0Gbc9OhXhbS6nhThOOS730m1iI0OfkjZODVuNeGRoegPixYdLNY=
X-Received: by 2002:a17:906:2218:b0:96f:4c38:4b1a with SMTP id
 s24-20020a170906221800b0096f4c384b1amr9027269ejs.5.1684757911056; Mon, 22 May
 2023 05:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <0-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com> <1-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
In-Reply-To: <1-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 22 May 2023 14:18:19 +0200
Message-ID: <CAJZ5v0hu+=TpAOGnh5gyz685t6DV2LRJwN7Rrq=j3rMdtQHgHw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] iommu: Have __iommu_probe_device() check for
 already probed devices
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 19, 2023 at 8:42 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> This is a step toward making __iommu_probe_device() self contained.
>
> It should, under proper locking, check if the device is already associated
> with an iommu driver and resolve parallel probes. All but one of the
> callers open code this test using two different means, but they all
> rely on dev->iommu_group.
>
> Currently the bus_iommu_probe()/probe_iommu_group() and
> probe_acpi_namespace_devices() rejects already probed devices with an
> unlocked read of dev->iommu_group. The OF and ACPI "replay" functions use
> device_iommu_mapped() which is the same read without the pointless
> refcount.
>
> Move this test into __iommu_probe_device() and put it under the
> iommu_probe_device_lock. The store to dev->iommu_group is in
> iommu_group_add_device() which is also called under this lock for iommu
> driver devices, making it properly locked.
>
> The only path that didn't have this check is the hotplug path triggered by
> BUS_NOTIFY_ADD_DEVICE. The only way to get dev->iommu_group assigned
> outside the probe path is via iommu_group_add_device(). Today the only
> caller is VFIO no-iommu which never associates with an iommu driver. Thus
> adding this additional check is safe.
>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

for the ACPI change in scan.c.

> ---
>  drivers/acpi/scan.c         |  2 +-
>  drivers/iommu/intel/iommu.c |  7 -------
>  drivers/iommu/iommu.c       | 19 +++++++++----------
>  drivers/iommu/of_iommu.c    |  2 +-
>  4 files changed, 11 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 0c6f06abe3f47f..945866f3bd8ebd 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1579,7 +1579,7 @@ static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
>          * If we have reason to believe the IOMMU driver missed the initial
>          * iommu_probe_device() call for dev, replay it to get things in order.
>          */
> -       if (!err && dev->bus && !device_iommu_mapped(dev))
> +       if (!err && dev->bus)
>                 err = iommu_probe_device(dev);
>
>         /* Ignore all other errors apart from EPROBE_DEFER */
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index b871a6afd80321..3c37b50c121c2d 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3763,7 +3763,6 @@ static int __init probe_acpi_namespace_devices(void)
>                 for_each_active_dev_scope(drhd->devices,
>                                           drhd->devices_cnt, i, dev) {
>                         struct acpi_device_physical_node *pn;
> -                       struct iommu_group *group;
>                         struct acpi_device *adev;
>
>                         if (dev->bus != &acpi_bus_type)
> @@ -3773,12 +3772,6 @@ static int __init probe_acpi_namespace_devices(void)
>                         mutex_lock(&adev->physical_node_lock);
>                         list_for_each_entry(pn,
>                                             &adev->physical_node_list, node) {
> -                               group = iommu_group_get(pn->dev);
> -                               if (group) {
> -                                       iommu_group_put(group);
> -                                       continue;
> -                               }
> -
>                                 ret = iommu_probe_device(pn->dev);
>                                 if (ret)
>                                         break;
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 4d7010f2b260a7..6d4d6a4d692893 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -351,9 +351,16 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>          * but for now enforcing a simple global ordering is fine.
>          */
>         mutex_lock(&iommu_probe_device_lock);
> +
> +       /* Device is probed already if in a group */
> +       if (dev->iommu_group) {
> +               ret = 0;
> +               goto out_unlock;
> +       }
> +
>         if (!dev_iommu_get(dev)) {
>                 ret = -ENOMEM;
> -               goto err_unlock;
> +               goto out_unlock;
>         }
>
>         if (!try_module_get(ops->owner)) {
> @@ -399,7 +406,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>  err_free:
>         dev_iommu_free(dev);
>
> -err_unlock:
> +out_unlock:
>         mutex_unlock(&iommu_probe_device_lock);
>
>         return ret;
> @@ -1711,16 +1718,8 @@ struct iommu_domain *iommu_group_default_domain(struct iommu_group *group)
>  static int probe_iommu_group(struct device *dev, void *data)
>  {
>         struct list_head *group_list = data;
> -       struct iommu_group *group;
>         int ret;
>
> -       /* Device is probed already if in a group */
> -       group = iommu_group_get(dev);
> -       if (group) {
> -               iommu_group_put(group);
> -               return 0;
> -       }
> -
>         ret = __iommu_probe_device(dev, group_list);
>         if (ret == -ENODEV)
>                 ret = 0;
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 40f57d293a79d4..157b286e36bf3a 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -159,7 +159,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>          * If we have reason to believe the IOMMU driver missed the initial
>          * probe for dev, replay it to get things in order.
>          */
> -       if (!err && dev->bus && !device_iommu_mapped(dev))
> +       if (!err && dev->bus)
>                 err = iommu_probe_device(dev);
>
>         /* Ignore all other errors apart from EPROBE_DEFER */
> --
> 2.40.1
>
