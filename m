Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC87D1DAF11
	for <lists+linux-acpi@lfdr.de>; Wed, 20 May 2020 11:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgETJm2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 20 May 2020 05:42:28 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42209 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgETJm1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 May 2020 05:42:27 -0400
Received: by mail-oi1-f195.google.com with SMTP id l6so2359273oic.9;
        Wed, 20 May 2020 02:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nugmEbtCazlXCQDSz2W1N82eZimQB1QpohzBG1gKV4s=;
        b=TqOaj3ugo4+TDUMfzXKNgaABxNI7J5l6M0nfJIbYPrgbZho7vSy4M9V6UZ0GsrrVCG
         TBsUUx0bggR8UzZGrEn0GfRqVnpYhd7iu/kZbo8PA9TOOLz3ionzUFfXhejXjQEv6V24
         r03NF3kc29B6fdkSQi4MYMAy6i1/RVqvhUR4CDB91zpc5lhrk1UUVvs7APrVEwrQydyz
         1LpIkcyP3w3efkEK4NfqsidRnhvX3Lhg/rBeoCFm/KYxd3QUnRSDC5NWsnt874FN77Ja
         0pYfrGqIdcTl04Z51CD1WEM22K4WkeOONGma6aiOOAlOroxCD71Q5nef0OCDSZy43SLK
         163g==
X-Gm-Message-State: AOAM531v3tRAIpNd/vgn+ve0+k70q0nwwJYBFQ4UfCns/ip0QL6pSQM4
        PTHKZsUePoPlm4LApJP2Hu5CG0bWZ3qpAC9kn90=
X-Google-Smtp-Source: ABdhPJzOiYHvtvgDAhZyQHWugtECBMHFvnDNduCyRa11VSymu3LsBForG2fd9+to5VmtbxJiLn8IGvu+XUrw9lafTvM=
X-Received: by 2002:aca:eb56:: with SMTP id j83mr2638352oih.110.1589967746203;
 Wed, 20 May 2020 02:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200519222409.616078-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20200519222409.616078-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 May 2020 11:42:15 +0200
Message-ID: <CAJZ5v0i-jtE5d0dAMiQxbEmSfMBnAK4C3Ek_7+86W2La2_UCNw@mail.gmail.com>
Subject: Re: [PATCH] ACPI / DPTF: Add additional attributes to power
 participant driver
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

 powerOn Wed, May 20, 2020 at 12:24 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Add two additional attributes to the existing power participant driver:
> rest_of_platform_power_mw: (RO) Shows the rest of worst case platform
> power in mW.

It would be good to explain or at least give an example of what the
"rest of worst case platform power" can be.

> prochot_confirm: (WO) Confirm EC about a prochot notification.
>
> Also userspace is notified via sysfs_notify(), whenever power source or
> rest of the platform power is changed. So user space can use poll()
> system call on those attributes.
>
> The ACPI methods used in this patch are as follows:
>
> PROP
> This object evaluates to the rest of worst case platform power in mW.
> Bits:
> 23:0 Worst case rest of platform power in mW.
>
> PBOK
> PBOK is a method designed to provide a mechanism for OSPM to change power
> setting before EC can de-assert a PROCHOT from a device. The EC may
> receive several PROCHOTs, so it has a sequence number attached to PSRC
> (read via existing attribute "platform_power_source"). Once OSPM takes
> action for a PSRC change notification, it can call PBOK method to confirm
> with the sequence number.
> Bits:
> 3:0 Power Delivery State Change Sequence number
> 30  Reserved
> 31  0 – Not OK to de-assert PROCHOT
>     1 – OK to de-assert PROCHOT
>
> PSRC (Platform Power Source): Not new in this patch but for
> documentation for new bits
> This object evaluates to an integer that represents the system power
> source as well as the power delivery state change sequence number.
> Bits:
> 3:0 The current power source as an integer for AC, DC, USB, Wireless.
> 0 = DC, 1 = AC, 2 = USB, 3 = Wireless Charging
> 7:4 Power Delivery State Change Sequence Number. Default value is 0
>
> Notifications:
> 0x81: (Power State Change) Used to notify when the power source has
> changed.
> 0x84: (PROP change) Used to notify when the platform rest of power has
> changed.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  Documentation/ABI/testing/sysfs-platform-dptf | 24 +++++--
>  drivers/acpi/dptf/dptf_power.c                | 69 ++++++++++++++++++-
>  2 files changed, 88 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-platform-dptf b/Documentation/ABI/testing/sysfs-platform-dptf
> index 325dc0667dbb..cf4eb5d676de 100644
> --- a/Documentation/ABI/testing/sysfs-platform-dptf
> +++ b/Documentation/ABI/testing/sysfs-platform-dptf
> @@ -27,10 +27,12 @@ KernelVersion:      v4.10
>  Contact:       linux-acpi@vger.kernel.org
>  Description:
>                 (RO) Display the platform power source
> -               0x00 = DC
> -               0x01 = AC
> -               0x02 = USB
> -               0x03 = Wireless Charger
> +               bits[3:0] Current power source
> +                       0x00 = DC
> +                       0x01 = AC
> +                       0x02 = USB
> +                       0x03 = Wireless Charger
> +               bits[7:4] Power source sequence number
>
>  What:          /sys/bus/platform/devices/INT3407:00/dptf_power/battery_steady_power
>  Date:          Jul, 2016
> @@ -38,3 +40,17 @@ KernelVersion:       v4.10
>  Contact:       linux-acpi@vger.kernel.org
>  Description:
>                 (RO) The maximum sustained power for battery in milliwatts.
> +
> +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/rest_of_platform_power_mw
> +Date:          June, 2020
> +KernelVersion: v5.8
> +Contact:       linux-acpi@vger.kernel.org
> +Description:
> +               (RO) Shows the rest of worst case platform power in mW.
> +
> +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/prochot_confirm
> +Date:          June, 2020
> +KernelVersion: v5.8
> +Contact:       linux-acpi@vger.kernel.org
> +Description:
> +               (WO) Confirm embedded controller about a prochot notification.
> diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
> index e4e8b75d39f0..abe99039af74 100644
> --- a/drivers/acpi/dptf/dptf_power.c
> +++ b/drivers/acpi/dptf/dptf_power.c
> @@ -16,6 +16,7 @@
>   * ARTG : Adapter rating
>   * CTYP : Charger type
>   * PBSS : Battery steady power
> + * PROP : Rest of worst case platform Power
>   */
>  #define DPTF_POWER_SHOW(name, object) \
>  static ssize_t name##_show(struct device *dev,\
> @@ -39,12 +40,34 @@ DPTF_POWER_SHOW(platform_power_source, PSRC)
>  DPTF_POWER_SHOW(adapter_rating_mw, ARTG)
>  DPTF_POWER_SHOW(battery_steady_power_mw, PBSS)
>  DPTF_POWER_SHOW(charger_type, CTYP)
> +DPTF_POWER_SHOW(rest_of_platform_power_mw, PROP)
>
>  static DEVICE_ATTR_RO(max_platform_power_mw);
>  static DEVICE_ATTR_RO(platform_power_source);
>  static DEVICE_ATTR_RO(adapter_rating_mw);
>  static DEVICE_ATTR_RO(battery_steady_power_mw);
>  static DEVICE_ATTR_RO(charger_type);
> +static DEVICE_ATTR_RO(rest_of_platform_power_mw);
> +
> +static ssize_t prochot_confirm_store(struct device *dev,
> +                                    struct device_attribute *attr,
> +                                    const char *buf, size_t count)
> +{
> +       struct acpi_device *acpi_dev = dev_get_drvdata(dev);
> +       acpi_status status;
> +       int seq_no;
> +
> +       if (kstrtouint(buf, 0, &seq_no) < 0)
> +               return -EINVAL;
> +
> +       status = acpi_execute_simple_method(acpi_dev->handle, "PBOK", seq_no);
> +       if (ACPI_SUCCESS(status))
> +               return count;
> +
> +       return -EINVAL;
> +}
> +
> +static DEVICE_ATTR_WO(prochot_confirm);
>
>  static struct attribute *dptf_power_attrs[] = {
>         &dev_attr_max_platform_power_mw.attr,
> @@ -52,6 +75,8 @@ static struct attribute *dptf_power_attrs[] = {
>         &dev_attr_adapter_rating_mw.attr,
>         &dev_attr_battery_steady_power_mw.attr,
>         &dev_attr_charger_type.attr,
> +       &dev_attr_rest_of_platform_power_mw.attr,
> +       &dev_attr_prochot_confirm.attr,
>         NULL
>  };
>
> @@ -60,6 +85,33 @@ static const struct attribute_group dptf_power_attribute_group = {
>         .name = "dptf_power"
>  };
>
> +#define POWER_STATE_CHANGED            0x81
> +#define POWER_PROP_CHANGE_EVENT        0x84
> +
> +static void dptf_power_notify(acpi_handle handle, u32 event, void *data)
> +{
> +       struct platform_device *pdev = data;
> +       char *attr;
> +
> +       switch (event) {
> +       case POWER_STATE_CHANGED:
> +               attr = "platform_power_source";
> +               break;
> +       case POWER_PROP_CHANGE_EVENT:
> +               attr = "rest_of_platform_power_mw";
> +               break;
> +       default:
> +               dev_err(&pdev->dev, "Unsupported event [0x%x]\n", event);
> +               return;
> +       }
> +
> +       /*
> +        * Notify that an attribute is changed, so that user space can read
> +        * again.
> +        */
> +       sysfs_notify(&pdev->dev.kobj, "dptf_power", attr);
> +}
> +
>  static int dptf_power_add(struct platform_device *pdev)
>  {
>         struct acpi_device *acpi_dev;
> @@ -78,10 +130,21 @@ static int dptf_power_add(struct platform_device *pdev)
>         if (ptype != 0x11)
>                 return -ENODEV;
>
> +       result = acpi_install_notify_handler(acpi_dev->handle,
> +                                            ACPI_DEVICE_NOTIFY,
> +                                            dptf_power_notify,
> +                                            (void *)pdev);
> +       if (result)
> +               return result;
> +
>         result = sysfs_create_group(&pdev->dev.kobj,
>                                     &dptf_power_attribute_group);
> -       if (result)
> +       if (result) {
> +               acpi_remove_notify_handler(acpi_dev->handle,
> +                                          ACPI_DEVICE_NOTIFY,
> +                                          dptf_power_notify);
>                 return result;
> +       }
>
>         platform_set_drvdata(pdev, acpi_dev);
>
> @@ -90,7 +153,11 @@ static int dptf_power_add(struct platform_device *pdev)
>
>  static int dptf_power_remove(struct platform_device *pdev)
>  {
> +       struct acpi_device *acpi_dev = platform_get_drvdata(pdev);
>
> +       acpi_remove_notify_handler(acpi_dev->handle,
> +                                  ACPI_DEVICE_NOTIFY,
> +                                  dptf_power_notify);
>         sysfs_remove_group(&pdev->dev.kobj, &dptf_power_attribute_group);
>
>         return 0;
> --
> 2.25.4
>
