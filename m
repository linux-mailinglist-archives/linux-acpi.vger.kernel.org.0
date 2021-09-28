Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8742741AF27
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Sep 2021 14:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240526AbhI1Mmx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Sep 2021 08:42:53 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:33454 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240488AbhI1Mmt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Sep 2021 08:42:49 -0400
Received: by mail-oi1-f177.google.com with SMTP id 24so29856127oix.0;
        Tue, 28 Sep 2021 05:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iN9a1Aw1zWXTV/h2Icb5TI8nqI1cGIjKtzd1AYVNfvU=;
        b=KR8ZIuW3zcd+lka/GvXgSQ9Cs6NlX+cnYUpD+QbkfqwPPX6IYiv3Vps+0cGTdTOHgv
         cemaVhLM+wxGSH4MGF1chpdZCBQtjz4bbAQzNO7Z7tamWgBNa1ysvH8fG1xWAQp24ZY3
         1Ifx9gCDBJqEogg63ryHcJU7SQGg8gDxgUeBV85CJE4m5Jv5i1/Wzf4wSChW4Na9i8ma
         h7tvkZ/e2RvVfXbr2/JCrTmuJ5R2GYOtmwTBCL8wAGfwQVKvV4lpI6oejZUgvuflFdXR
         Mxsyu5EHRYKmnvgs+5Oesnsi/kbY8ajQ53sV9EXK1GBn5zIac7YFjQkU3uAA8hR3bjag
         xB4w==
X-Gm-Message-State: AOAM533OSFMNgqBFN122kcrHEd8Fa1ahGjJqRRORP/XpaWb9AO2dYB1W
        QEH/gM+DDNd8v//ucnr/tu/hMyroQktPQicKA14=
X-Google-Smtp-Source: ABdhPJwGx5oWHDmR8s8yeqUylWgH2pj9PaMuoJ56t9qOoYRJVtxLwn529xEB1XHGf7+OdB+qxQaNzgHgGVw/sHsUwpk=
X-Received: by 2002:a54:4f15:: with SMTP id e21mr3443756oiy.71.1632832870033;
 Tue, 28 Sep 2021 05:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631802162.git.yu.c.chen@intel.com> <8df66db9e8c30c762d676448e51c8536afe3b886.1631802163.git.yu.c.chen@intel.com>
In-Reply-To: <8df66db9e8c30c762d676448e51c8536afe3b886.1631802163.git.yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Sep 2021 14:40:58 +0200
Message-ID: <CAJZ5v0j+kZKRN=OymSm+TTB8NMUM3YagMFrygaRFHtQOnCNDEg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] drivers/acpi: Introduce Platform Firmware Runtime
 Update Telemetry
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 16, 2021 at 5:58 PM Chen Yu <yu.c.chen@intel.com> wrote:
>
> Platform Firmware Runtime Update(PFRU) Telemetry Service is part of RoT
> (Root of Trust), which allows PFRU handler and other PFRU drivers to
> produce telemetry data to upper layer OS consumer at runtime.
>
> The linux provides interfaces for the user to query the parameters of
> telemetry data, and the user could read out the telemetry data
> accordingly.
>
> Typical log looks like:
>
> [SmmRuntimeUpdateHandler.ProcessSmmRuntimeUpdate]
> ProcessSmmRuntimeUpdate = START, Action = 2
> [SmmRuntimeUpdateHandler.ProcessSmmRuntimeUpdate]
> FwVersion = 0, CodeInjectionVersion = 1
> [ShadowSmmRuntimeUpdateImage]
> Image = 0x74D9B000, ImageSize = 0x1172
> [ProcessSmmRuntimeUpdate]
> ShadowSmmRuntimeUpdateImage.Status = Success
> [ValidateSmmRuntimeUpdateImage]
> CapsuleHeader.CapsuleGuid = 6DCBD5ED-E82D-4C44-BDA1-7194199AD92A
> [ValidateSmmRuntimeUpdateImage]
> FmpCapHeader.Version = 1
> [ValidateSmmRuntimeUpdateImage]
> FmpCapImageHeader.UpdateImageTypeId = B2F84B79-7B6E-4E45-885F-3FB9BB185402
> [ValidateSmmRuntimeUpdateImage]
> SmmRuntimeUpdateVerifyImageWithDenylist.Status = Success
> [ValidateSmmRuntimeUpdateImage]
> SmmRuntimeUpdateVerifyImageWithAllowlist.Status = Success
> [SmmCodeInjectionVerifyPayloadHeader]
> PayloadHeader.Signature = 0x31494353
> [SmmCodeInjectionVerifyPayloadHeader]
> PayloadHeader.PlatformId = 63462139-A8B1-AA4E-9024-F2BB53EA4723
> [SmmCodeInjectionVerifyPayloadHeader]
> PayloadHeader.SupportedSmmFirmwareVersion = 0,
> PayloadHeader.SmmCodeInjectionRuntimeVersion = 1
> [ProcessSmmRuntimeUpdate]
> ValidateSmmRuntimeUpdateImage.Status = Success
> CPU CSR[0B102D28] Before = 7FBF830E
> CPU CSR[0B102D28] After = 7FBF8310
> [ProcessSmmRuntimeUpdate] ProcessSmmCodeInjection.Status = Success
> [SmmRuntimeUpdateHandler.ProcessSmmRuntimeUpdate]
> ProcessSmmRuntimeUpdate = End, Status = Success
>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v3: Use __u32 instead of int and __64 instead of unsigned long
>     in include/uapi/linux/pfru.h (Greg Kroah-Hartman)
>     Rename the structure in uapi to start with a prefix pfru so as
>     to avoid confusing in the global namespace. (Greg Kroah-Hartman)
> v2: Do similar clean up as pfru_update driver:
>     Add sanity check for duplicated instance of ACPI device.
>     Update the driver to work with allocated telem_device objects.
>     (Mike Rapoport)
>     For each switch case pair, get rid of the magic case numbers
>     and add a default clause with the error handling.
>     (Mike Rapoport)
> ---
>  drivers/acpi/pfru/Kconfig          |  14 +
>  drivers/acpi/pfru/Makefile         |   1 +
>  drivers/acpi/pfru/pfru_telemetry.c | 412 +++++++++++++++++++++++++++++
>  include/uapi/linux/pfru.h          |  43 +++
>  4 files changed, 470 insertions(+)
>  create mode 100644 drivers/acpi/pfru/pfru_telemetry.c
>
> diff --git a/drivers/acpi/pfru/Kconfig b/drivers/acpi/pfru/Kconfig
> index 3f31b7d95f3b..e2934058884e 100644
> --- a/drivers/acpi/pfru/Kconfig
> +++ b/drivers/acpi/pfru/Kconfig
> @@ -13,3 +13,17 @@ config ACPI_PFRU
>
>           To compile this driver as a module, choose M here:
>           the module will be called pfru_update.
> +
> +config ACPI_PFRU_TELEMETRY

Why does this need a separate Kconfig option?

> +       tristate "ACPI Platform Firmware Runtime Update Telemetry Service"
> +       depends on ACPI_PFRU
> +       help
> +         PFRU(Platform Firmware Runtime Update) Telemetry Service is part of
> +         RoT(Root of Trust), which allows Platform Firmware Runtime Update handler
> +         and other PFRU drivers to produce telemetry data to upper layer OS consumer
> +         at runtime.
> +
> +         For more information, see:
> +         <file:Documentation/x86/pfru_update.rst>
> +
> +         If unsure, please say N.
> diff --git a/drivers/acpi/pfru/Makefile b/drivers/acpi/pfru/Makefile
> index 098cbe80cf3d..30060ba320ea 100644
> --- a/drivers/acpi/pfru/Makefile
> +++ b/drivers/acpi/pfru/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_ACPI_PFRU) += pfru_update.o
> +obj-$(CONFIG_ACPI_PFRU_TELEMETRY) += pfru_telemetry.o

I'm not sure about this ...

> diff --git a/drivers/acpi/pfru/pfru_telemetry.c b/drivers/acpi/pfru/pfru_telemetry.c
> new file mode 100644
> index 000000000000..96dc9e69edc0
> --- /dev/null
> +++ b/drivers/acpi/pfru/pfru_telemetry.c
> @@ -0,0 +1,412 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ACPI Platform Firmware Runtime Update
> + * Telemetry Service Device Driver
> + *
> + * Copyright (C) 2021 Intel Corporation
> + * Author: Chen Yu <yu.c.chen@intel.com>
> + */
> +#include <linux/acpi.h>
> +#include <linux/errno.h>
> +#include <linux/fs.h>
> +#include <linux/file.h>
> +#include <linux/minmax.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/mm.h>
> +#include <linux/platform_device.h>
> +#include <linux/uuid.h>
> +#include <linux/uaccess.h>
> +#include <uapi/linux/pfru.h>
> +
> +enum update_index {
> +       LOG_STATUS_IDX,
> +       LOG_EXT_STATUS_IDX,
> +       LOG_MAX_SZ_IDX,
> +       LOG_CHUNK1_LO_IDX,
> +       LOG_CHUNK1_HI_IDX,
> +       LOG_CHUNK1_SZ_IDX,
> +       LOG_CHUNK2_LO_IDX,
> +       LOG_CHUNK2_HI_IDX,
> +       LOG_CHUNK2_SZ_IDX,
> +       LOG_ROLLOVER_CNT_IDX,
> +       LOG_RESET_CNT_IDX,
> +};
> +
> +struct pfru_telem_device {
> +       struct device *dev;
> +       guid_t uuid;
> +       struct pfru_telem_info info;
> +};
> +
> +/*
> + * There would be only one instance of pfru_telem_device.
> + */
> +static struct pfru_telem_device *telem_dev;
> +
> +static int get_pfru_data_info(struct pfru_telem_data_info *data_info,
> +                             int log_type)
> +{
> +       union acpi_object *out_obj, in_obj, in_buf;
> +       acpi_handle handle;
> +       int i, ret = -EINVAL;
> +
> +       handle = ACPI_HANDLE(telem_dev->dev);
> +
> +       memset(&in_obj, 0, sizeof(in_obj));
> +       memset(&in_buf, 0, sizeof(in_buf));
> +       in_obj.type = ACPI_TYPE_PACKAGE;
> +       in_obj.package.count = 1;
> +       in_obj.package.elements = &in_buf;
> +       in_buf.type = ACPI_TYPE_INTEGER;
> +       in_buf.integer.value = log_type;
> +
> +       out_obj = acpi_evaluate_dsm_typed(handle, &telem_dev->uuid,
> +                                         telem_dev->info.log_revid, FUNC_GET_DATA,
> +                                         &in_obj, ACPI_TYPE_PACKAGE);
> +       if (!out_obj) {
> +               pr_err("Failed to invoke _DSM\n");
> +               return -EINVAL;
> +       }
> +
> +       for (i = 0; i < out_obj->package.count; i++) {

Is the loop really necessary?

> +               union acpi_object *obj = &out_obj->package.elements[i];
> +
> +               if (obj->type != ACPI_TYPE_INTEGER)
> +                       goto free_acpi_buffer;
> +
> +               switch (i) {
> +               case LOG_STATUS_IDX:
> +                       data_info->status = obj->integer.value;
> +                       break;
> +               case LOG_EXT_STATUS_IDX:
> +                       data_info->ext_status = obj->integer.value;
> +                       break;
> +               case LOG_MAX_SZ_IDX:
> +                       data_info->max_data_size = obj->integer.value;
> +                       break;
> +               case LOG_CHUNK1_LO_IDX:
> +                       data_info->chunk1_addr_lo = obj->integer.value;
> +                       break;
> +               case LOG_CHUNK1_HI_IDX:
> +                       data_info->chunk1_addr_hi = obj->integer.value;
> +                       break;
> +               case LOG_CHUNK1_SZ_IDX:
> +                       data_info->chunk1_size = obj->integer.value;
> +                       break;
> +               case LOG_CHUNK2_LO_IDX:
> +                       data_info->chunk2_addr_lo = obj->integer.value;
> +                       break;
> +               case LOG_CHUNK2_HI_IDX:
> +                       data_info->chunk2_addr_hi = obj->integer.value;
> +                       break;
> +               case LOG_CHUNK2_SZ_IDX:
> +                       data_info->chunk2_size = obj->integer.value;
> +                       break;
> +               case LOG_ROLLOVER_CNT_IDX:
> +                       data_info->rollover_cnt = obj->integer.value;
> +                       break;
> +               case LOG_RESET_CNT_IDX:
> +                       data_info->reset_cnt = obj->integer.value;
> +                       break;
> +               default:
> +                       pr_err("Incorrect format of Telemetry info.\n");

dev_dbg()?  And likewise below.

> +                       goto free_acpi_buffer;
> +               }
> +       }
> +       ret = 0;
> +
> +free_acpi_buffer:
> +       ACPI_FREE(out_obj);
> +
> +       return ret;
> +}
> +
> +static int set_pfru_log_level(int level)
> +{
> +       union acpi_object *out_obj, *obj, in_obj, in_buf;
> +       enum pfru_dsm_status status;
> +       acpi_handle handle;
> +       int ret = -EINVAL;
> +
> +       handle = ACPI_HANDLE(telem_dev->dev);
> +
> +       memset(&in_obj, 0, sizeof(in_obj));
> +       memset(&in_buf, 0, sizeof(in_buf));
> +       in_obj.type = ACPI_TYPE_PACKAGE;
> +       in_obj.package.count = 1;
> +       in_obj.package.elements = &in_buf;
> +       in_buf.type = ACPI_TYPE_INTEGER;
> +       in_buf.integer.value = level;
> +
> +       out_obj = acpi_evaluate_dsm_typed(handle, &telem_dev->uuid,
> +                                         telem_dev->info.log_revid, FUNC_SET_LEV,
> +                                         &in_obj, ACPI_TYPE_PACKAGE);
> +       if (!out_obj)
> +               return -EINVAL;
> +
> +       obj = &out_obj->package.elements[0];
> +       status = obj->integer.value;
> +       if (status) {
> +               pr_err("get MM telemetry level error status %d\n",
> +                      status);
> +               goto free_acpi_buffer;
> +       }
> +
> +       obj = &out_obj->package.elements[1];
> +       status = obj->integer.value;
> +       if (status) {
> +               pr_err("get MM telemetry level error extend status %d\n",
> +                      status);
> +               goto free_acpi_buffer;
> +       }
> +       ret = 0;
> +
> +free_acpi_buffer:
> +       ACPI_FREE(out_obj);
> +
> +       return ret;
> +}
> +
> +static int get_pfru_log_level(int *level)
> +{
> +       union acpi_object *out_obj, *obj;
> +       enum pfru_dsm_status status;
> +       acpi_handle handle;
> +       int ret = -EINVAL;
> +
> +       handle = ACPI_HANDLE(telem_dev->dev);
> +       out_obj = acpi_evaluate_dsm_typed(handle, &telem_dev->uuid,
> +                                         telem_dev->info.log_revid, FUNC_GET_LEV,
> +                                         NULL, ACPI_TYPE_PACKAGE);
> +       if (!out_obj)
> +               return -EINVAL;
> +
> +       obj = &out_obj->package.elements[0];
> +       if (obj->type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +       status = obj->integer.value;
> +       if (status) {
> +               pr_err("get MM telemetry level error status %d\n",
> +                      status);
> +               goto free_acpi_buffer;
> +       }
> +
> +       obj = &out_obj->package.elements[1];
> +       if (obj->type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +       status = obj->integer.value;
> +       if (status) {
> +               pr_err("get MM telemetry level error status %d\n",
> +                      status);
> +               goto free_acpi_buffer;
> +       }
> +
> +       obj = &out_obj->package.elements[2];
> +       if (obj->type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +       *level = obj->integer.value;
> +
> +       ret = 0;
> +
> +free_acpi_buffer:
> +       ACPI_FREE(out_obj);
> +
> +       return ret;
> +}
> +
> +static int valid_log_level(int level)
> +{
> +       return (level == LOG_ERR) || (level == LOG_WARN) ||
> +               (level == LOG_INFO) || (level == LOG_VERB);

The parens are redundant AFAICS.

> +}
> +
> +static int valid_log_type(int type)
> +{
> +       return (type == LOG_EXEC_IDX) || (type == LOG_HISTORY_IDX);

And here too.

> +}
> +
> +static long pfru_telemetry_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +
> +{
> +       struct pfru_telem_data_info data_info;
> +       struct pfru_telem_info info;
> +       void __user *p;
> +       int ret = 0;
> +
> +       p = (void __user *)arg;
> +
> +       switch (cmd) {
> +       case PFRU_LOG_IOC_SET_INFO:
> +               if (copy_from_user(&info, p, sizeof(info)))
> +                       return -EFAULT;

Empty line, please.

> +               if (pfru_valid_revid(info.log_revid))
> +                       telem_dev->info.log_revid = info.log_revid;
> +
> +               if (valid_log_level(info.log_level)) {
> +                       ret = set_pfru_log_level(info.log_level);
> +                       if (ret)
> +                               return ret;

And here.

> +                       telem_dev->info.log_level = info.log_level;
> +               }
> +               if (valid_log_type(info.log_type))
> +                       telem_dev->info.log_type = info.log_type;

And here.  And analogously below.

Generally speaking, I tend to prefer putting empty code lines after an
if () statement that is not followed by a block.

> +               break;
> +       case PFRU_LOG_IOC_GET_INFO:
> +               ret = get_pfru_log_level(&info.log_level);
> +               if (ret)
> +                       return ret;
> +               info.log_type = telem_dev->info.log_type;
> +               info.log_revid = telem_dev->info.log_revid;
> +               if (copy_to_user(p, &info, sizeof(info)))
> +                       ret = -EFAULT;
> +               break;
> +       case PFRU_LOG_IOC_GET_DATA_INFO:
> +               ret = get_pfru_data_info(&data_info, telem_dev->info.log_type);
> +               if (ret)
> +                       return ret;
> +               if (copy_to_user(p, &data_info, sizeof(struct pfru_telem_data_info)))
> +                       ret = -EFAULT;
> +               break;
> +       default:
> +               ret = -ENOIOCTLCMD;
> +               break;
> +       }
> +       return ret;
> +}
> +
> +static ssize_t pfru_telemetry_read(struct file *filp, char __user *ubuf,
> +                                  size_t size, loff_t *off)
> +{
> +       struct pfru_telem_data_info info;
> +       phys_addr_t base_addr;
> +       int buf_size, ret;
> +       char *buf_ptr;
> +
> +       if (*off < 0)
> +               return -EINVAL;
> +
> +       ret = get_pfru_data_info(&info, telem_dev->info.log_type);
> +       if (ret) {
> +               pr_err("Could not get telemetry data info %d\n", ret);
> +               return ret;
> +       }
> +
> +       base_addr = (phys_addr_t)(info.chunk2_addr_lo |
> +                       (info.chunk2_addr_hi << 32));

This line doesn't need to be broken as far as I'm concerned.

> +       if (!base_addr) {
> +               pr_err("Telemetry data not ready\n");
> +               return -EBUSY;
> +       }
> +
> +       buf_size = info.max_data_size;
> +       if (*off >= buf_size)
> +               return 0;
> +
> +       buf_ptr = memremap(base_addr, buf_size, MEMREMAP_WB);
> +       if (IS_ERR(buf_ptr))
> +               return PTR_ERR(buf_ptr);
> +
> +       size = min_t(size_t, size, buf_size - *off);
> +
> +       ret = -EFAULT;
> +       if (copy_to_user(ubuf, buf_ptr + *off, size))
> +               goto out;
> +       ret = 0;

So this would be far more readable in the following form IMO:

size = min_t(size_t, size, buf_size - *off);
if (copy_to_user(ubuf, buf_ptr + *off, size))
        ret = -EFAULT;
else
        ret = 0;

And it looks like you won't need the "out" label any more then.

> +out:
> +       memunmap(buf_ptr);
> +
> +       return ret ? ret : size;
> +}
> +
> +#ifdef CONFIG_COMPAT
> +static long compat_pfru_telemetry_ioctl(struct file *filep, unsigned int cmd,
> +                                       unsigned long arg)
> +{
> +       return pfru_telemetry_ioctl(filep, cmd, arg);
> +}
> +#endif
> +
> +static const struct file_operations acpi_pfru_telemetry_fops = {
> +       .owner          = THIS_MODULE,
> +       .read           = pfru_telemetry_read,
> +       .unlocked_ioctl = pfru_telemetry_ioctl,
> +#ifdef CONFIG_COMPAT
> +       .compat_ioctl   = compat_pfru_telemetry_ioctl,
> +#endif
> +       .llseek         = noop_llseek,
> +};

And I would consider combining this with the update interface so that
the write() updates the firmware code and the read() gets telemetry
data from it.

> +
> +static struct miscdevice pfru_telemetry_misc_dev = {
> +       .minor = MISC_DYNAMIC_MINOR,
> +       .name = "pfru_telemetry",
> +       .nodename = "pfru/telemetry",
> +       .fops = &acpi_pfru_telemetry_fops,
> +};
> +
> +static int acpi_pfru_telemetry_remove(struct platform_device *pdev)
> +{
> +       misc_deregister(&pfru_telemetry_misc_dev);
> +       kfree(telem_dev);
> +       telem_dev = NULL;
> +
> +       return 0;
> +}
> +
> +static int acpi_pfru_telemetry_probe(struct platform_device *pdev)
> +{
> +       acpi_handle handle;
> +       int ret;
> +
> +       if (telem_dev) {
> +               pr_err("Duplicated PFRU Telemetry INTC1081 detected, skip...\n");
> +               return 0;
> +       }
> +
> +       telem_dev = kzalloc(sizeof(*telem_dev), GFP_KERNEL);
> +       if (!telem_dev)
> +               return -ENOMEM;
> +
> +       ret = guid_parse(PFRU_TELEMETRY_UUID, &telem_dev->uuid);
> +       if (ret)
> +               goto out;
> +
> +       telem_dev->info.log_revid = 1;
> +       telem_dev->dev = &pdev->dev;
> +       handle = ACPI_HANDLE(telem_dev->dev);
> +       if (!acpi_has_method(handle, "_DSM")) {
> +               pr_err("Missing _DSM\n");
> +               ret = -ENODEV;
> +               goto out;
> +       }
> +
> +       ret = misc_register(&pfru_telemetry_misc_dev);
> +       if (ret)
> +               goto out;
> +
> +       return 0;
> +out:
> +       kfree(telem_dev);
> +       telem_dev = NULL;
> +
> +       return ret;
> +}
> +
> +static const struct acpi_device_id acpi_pfru_telemetry_ids[] = {
> +       {"INTC1081", 0},
> +       {}
> +};
> +MODULE_DEVICE_TABLE(acpi, acpi_pfru_telemetry_ids);
> +
> +static struct platform_driver acpi_pfru_telemetry_driver = {
> +       .driver = {
> +               .name = "pfru_telemetry",
> +               .acpi_match_table = acpi_pfru_telemetry_ids,
> +       },
> +       .probe = acpi_pfru_telemetry_probe,
> +       .remove = acpi_pfru_telemetry_remove,
> +};
> +module_platform_driver(acpi_pfru_telemetry_driver);
> +
> +MODULE_DESCRIPTION("Platform Firmware Runtime Update Telemetry Service device driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/uapi/linux/pfru.h b/include/uapi/linux/pfru.h
> index ca0b7433f79f..b04852602133 100644
> --- a/include/uapi/linux/pfru.h
> +++ b/include/uapi/linux/pfru.h
> @@ -98,4 +98,47 @@ struct pfru_updated_result {
>         __u64 high_exec_time;
>  };
>
> +#define PFRU_TELEMETRY_UUID    "75191659-8178-4D9D-B88F-AC5E5E93E8BF"
> +
> +/* Telemetry structures. */
> +struct pfru_telem_data_info {
> +       enum pfru_dsm_status status;
> +       enum pfru_dsm_status ext_status;
> +       __u64 chunk1_addr_lo;
> +       __u64 chunk1_addr_hi;
> +       __u64 chunk2_addr_lo;
> +       __u64 chunk2_addr_hi;
> +       __u32 max_data_size;
> +       __u32 chunk1_size;
> +       __u32 chunk2_size;
> +       __u32 rollover_cnt;
> +       __u32 reset_cnt;
> +};
> +
> +struct pfru_telem_info {
> +       __u32 log_level;
> +       __u32 log_type;
> +       __u32 log_revid;
> +};
> +
> +/* Two logs: history and execution log */
> +#define LOG_EXEC_IDX   0
> +#define LOG_HISTORY_IDX        1
> +#define NR_LOG_TYPE    2
> +
> +#define LOG_ERR                0
> +#define LOG_WARN       1
> +#define LOG_INFO       2
> +#define LOG_VERB       4
> +
> +#define FUNC_SET_LEV           1
> +#define FUNC_GET_LEV           2
> +#define FUNC_GET_DATA          3
> +
> +#define LOG_NAME_SIZE          10
> +
> +#define PFRU_LOG_IOC_SET_INFO _IOW(PFRU_MAGIC, 0x05, struct pfru_telem_info)
> +#define PFRU_LOG_IOC_GET_INFO _IOR(PFRU_MAGIC, 0x06, struct pfru_telem_info)
> +#define PFRU_LOG_IOC_GET_DATA_INFO _IOR(PFRU_MAGIC, 0x07, struct pfru_telem_data_info)
> +
>  #endif /* __PFRU_H__ */
> --
