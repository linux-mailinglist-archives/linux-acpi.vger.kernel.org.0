Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8798B41AEE2
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Sep 2021 14:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240516AbhI1MYT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Sep 2021 08:24:19 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:42581 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240496AbhI1MYT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Sep 2021 08:24:19 -0400
Received: by mail-ot1-f42.google.com with SMTP id c26-20020a056830349a00b0054d96d25c1eso2162921otu.9;
        Tue, 28 Sep 2021 05:22:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UI7fQWTc4BWab1f6J+oR5Hi5VMkl6zZ8M3eCk2VMX9c=;
        b=TqwwRfaJoLwQKC078WcwOdDr0TrAKzYO00ykfZ9+6PTCP7YIunS00iB7DzdRdVK3rP
         ArWKcAQkHL1Og4MjoLvLMpgIuke9X0hFsYTRm96fiGZ1h6j8eI+3nEJwbxVCtqNloPWG
         is3zyJQmIsqtJQ10VCVTIuBhq6opHMIUw4l3NPMI7vKB0Nx4SONinDhBIWSHwBCBHntI
         aNB0V0lwmS//nIpadnTPUNozXCZX1v9H+30GR/Q2Xz/EGB97IoY+AoqUHfhF7TlKpk9y
         freSk3SE/3T0CKa7YAWWFILTgWH2eQuRSMuhyEEQ/STwsu7MrXms0VcvyOHoqlkI+IBU
         YmSw==
X-Gm-Message-State: AOAM533MoreKOARY9tL8q2IyTSMZv4S5IrayEkWL/8+QaTYwnyZsy7vZ
        xZNP/y2oDkj4weYYNwrAEHFrSnKwExitdmwIg1qYWsKiOWk=
X-Google-Smtp-Source: ABdhPJxMqWvfKx2pgMKFUTT9WrNOQ4DvkeUOWl/z+/UneT3vZXj9J3ROA3NrGMb3ZSS8RIGjPJ2v0yv0PND7HyxT3pA=
X-Received: by 2002:a05:6830:82b:: with SMTP id t11mr4856948ots.319.1632831758949;
 Tue, 28 Sep 2021 05:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631802162.git.yu.c.chen@intel.com> <90d270c031401430445cb2c4ba1b9b0c265cf9d4.1631802163.git.yu.c.chen@intel.com>
In-Reply-To: <90d270c031401430445cb2c4ba1b9b0c265cf9d4.1631802163.git.yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Sep 2021 14:22:28 +0200
Message-ID: <CAJZ5v0i__g02rjQh5TuBQN2HejEbZUxiy-4=YSWDUEczrTui0Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] drivers/acpi: Introduce Platform Firmware Runtime
 Update device driver
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
        Ard Biesheuvel <ardb@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 16, 2021 at 5:56 PM Chen Yu <yu.c.chen@intel.com> wrote:
>
> Introduce the pfru_update driver which can be used for Platform Firmware
> Runtime code injection and driver update. The user is expected to provide
> the update firmware in the form of capsule file, and pass it to the driver
> via ioctl. Then the driver would hand this capsule file to the Platform
> Firmware Runtime Update via the ACPI device _DSM method. At last the low
> level Management Mode would do the firmware update.
>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v3: Use __u32 instead of int and __64 instead of unsigned long
>     in include/uapi/linux/pfru.h (Greg Kroah-Hartman)
>     Rename the structure in uapi to start with a prefix pfru so as
>     to avoid confusing in the global namespace. (Greg Kroah-Hartman)
> v2: Add sanity check for duplicated instance of ACPI device.
>     Update the driver to work with allocated pfru_device objects.
>     (Mike Rapoport)
>     For each switch case pair, get rid of the magic case numbers
>     and add a default clause with the error handling.
>     (Mike Rapoport)
>     Move the obj->type checks outside the switch to reduce redundancy.
>     (Mike Rapoport)
>     Parse the code_inj_id and drv_update_id at driver initialization time
>     to reduce the re-parsing at runtime.(Mike Rapoport)
>     Explain in detail how the size needs to be adjusted when doing
>     version check.(Mike Rapoport)
>     Rename parse_update_result() to dump_update_result()(Mike Rapoport)
>     Remove redundant return.(Mike Rapoport)
>     Do not expose struct capsulate_buf_info to uapi, since it is
>     not needed in userspace.(Mike Rapoport)
> ---
>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>  drivers/acpi/Kconfig                          |   1 +
>  drivers/acpi/Makefile                         |   1 +
>  drivers/acpi/pfru/Kconfig                     |  15 +
>  drivers/acpi/pfru/Makefile                    |   2 +
>  drivers/acpi/pfru/pfru_update.c               | 567 ++++++++++++++++++
>  include/uapi/linux/pfru.h                     | 101 ++++
>  7 files changed, 688 insertions(+)
>  create mode 100644 drivers/acpi/pfru/Kconfig
>  create mode 100644 drivers/acpi/pfru/Makefile
>  create mode 100644 drivers/acpi/pfru/pfru_update.c
>  create mode 100644 include/uapi/linux/pfru.h
>
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 2e8134059c87..6e5a82fff408 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -365,6 +365,7 @@ Code  Seq#    Include File                                           Comments
>                                                                       <mailto:aherrman@de.ibm.com>
>  0xE5  00-3F  linux/fuse.h
>  0xEC  00-01  drivers/platform/chrome/cros_ec_dev.h                   ChromeOS EC driver
> +0xEE  00-1F  uapi/linux/pfru.h                                       Platform Firmware Runtime Update and Telemetry
>  0xF3  00-3F  drivers/usb/misc/sisusbvga/sisusb.h                     sisfb (in development)
>                                                                       <mailto:thomas@winischhofer.net>
>  0xF6  all                                                            LTTng Linux Trace Toolkit Next Generation
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 1da360c51d66..1d8d2e2cefac 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -482,6 +482,7 @@ source "drivers/acpi/nfit/Kconfig"
>  source "drivers/acpi/numa/Kconfig"
>  source "drivers/acpi/apei/Kconfig"
>  source "drivers/acpi/dptf/Kconfig"
> +source "drivers/acpi/pfru/Kconfig"
>
>  config ACPI_WATCHDOG
>         bool
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 3018714e87d9..9c2c5ddff6ec 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -102,6 +102,7 @@ obj-$(CONFIG_ACPI_CPPC_LIB) += cppc_acpi.o
>  obj-$(CONFIG_ACPI_SPCR_TABLE)  += spcr.o
>  obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
>  obj-$(CONFIG_ACPI_PPTT)        += pptt.o
> +obj-$(CONFIG_ACPI_PFRU)                += pfru/
>
>  # processor has its own "processor." module_param namespace
>  processor-y                    := processor_driver.o
> diff --git a/drivers/acpi/pfru/Kconfig b/drivers/acpi/pfru/Kconfig
> new file mode 100644
> index 000000000000..3f31b7d95f3b
> --- /dev/null
> +++ b/drivers/acpi/pfru/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0
> +config ACPI_PFRU
> +       tristate "ACPI Platform Firmware Runtime Update (PFRU)"
> +       depends on 64BIT
> +       help
> +         In order to reduce the system reboot times and update the platform firmware
> +         in time, Platform Firmware Runtime Update is leveraged to patch the system
> +         without reboot. This driver supports Platform Firmware Runtime Update,
> +         which is composed of two parts: code injection and driver update.
> +
> +         For more information, see:
> +         <file:Documentation/x86/pfru_update.rst>
> +
> +         To compile this driver as a module, choose M here:
> +         the module will be called pfru_update.
> diff --git a/drivers/acpi/pfru/Makefile b/drivers/acpi/pfru/Makefile
> new file mode 100644
> index 000000000000..098cbe80cf3d
> --- /dev/null
> +++ b/drivers/acpi/pfru/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_ACPI_PFRU) += pfru_update.o
> diff --git a/drivers/acpi/pfru/pfru_update.c b/drivers/acpi/pfru/pfru_update.c
> new file mode 100644
> index 000000000000..cd2039a195c9
> --- /dev/null
> +++ b/drivers/acpi/pfru/pfru_update.c
> @@ -0,0 +1,567 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ACPI Platform Firmware Runtime Update Device Driver
> + *
> + * Copyright (C) 2021 Intel Corporation
> + * Author: Chen Yu <yu.c.chen@intel.com>
> + */
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/efi.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/string.h>
> +#include <linux/uaccess.h>
> +#include <linux/uio.h>
> +#include <linux/uuid.h>
> +#include <uapi/linux/pfru.h>
> +
> +enum cap_index {
> +       CAP_STATUS_IDX,
> +       CAP_UPDATE_IDX,
> +       CAP_CODE_TYPE_IDX,
> +       CAP_FW_VER_IDX,
> +       CAP_CODE_RT_VER_IDX,
> +       CAP_DRV_TYPE_IDX,
> +       CAP_DRV_RT_VER_IDX,
> +       CAP_DRV_SVN_IDX,
> +       CAP_PLAT_ID_IDX,
> +       CAP_OEM_ID_IDX,
> +       CAP_OEM_INFO_IDX,
> +};
> +
> +enum buf_index {
> +       BUF_STATUS_IDX,
> +       BUF_EXT_STATUS_IDX,
> +       BUF_ADDR_LOW_IDX,
> +       BUF_ADDR_HI_IDX,
> +       BUF_SIZE_IDX,
> +};
> +
> +enum update_index {
> +       UPDATE_STATUS_IDX,
> +       UPDATE_EXT_STATUS_IDX,
> +       UPDATE_AUTH_TIME_LOW_IDX,
> +       UPDATE_AUTH_TIME_HI_IDX,
> +       UPDATE_EXEC_TIME_LOW_IDX,
> +       UPDATE_EXEC_TIME_HI_IDX,
> +};
> +
> +struct pfru_device {
> +       guid_t uuid, code_uuid, drv_uuid;
> +       int rev_id;
> +       struct device *dev;
> +};
> +
> +/*
> + * There would be only one instance of pfru_device.
> + */
> +static struct pfru_device *pfru_dev;
> +
> +static bool valid_cap_type(int idx, union acpi_object *obj)
> +{
> +       acpi_object_type type = obj->type;
> +
> +       if (idx == CAP_STATUS_IDX || idx == CAP_UPDATE_IDX ||
> +           idx == CAP_FW_VER_IDX || idx == CAP_CODE_RT_VER_IDX ||
> +           idx == CAP_DRV_RT_VER_IDX || idx == CAP_DRV_SVN_IDX)
> +               return type == ACPI_TYPE_INTEGER;
> +       else if (idx == CAP_CODE_TYPE_IDX || idx == CAP_DRV_TYPE_IDX ||
> +                idx == CAP_PLAT_ID_IDX || idx == CAP_OEM_ID_IDX ||
> +                idx == CAP_OEM_INFO_IDX)
> +               return type == ACPI_TYPE_BUFFER;
> +       else
> +               return false;
> +}

IMO, this is way overdesigned.  It is not necessary to do all of these
checks for every element of the package in query_capability().

> +
> +static int query_capability(struct pfru_update_cap_info *cap)
> +{
> +       union acpi_object *out_obj;
> +       acpi_handle handle;
> +       int i, ret = -EINVAL;
> +
> +       handle = ACPI_HANDLE(pfru_dev->dev);
> +       out_obj = acpi_evaluate_dsm_typed(handle, &pfru_dev->uuid,
> +                                         pfru_dev->rev_id, FUNC_QUERY_UPDATE_CAP,
> +                                         NULL, ACPI_TYPE_PACKAGE);
> +       if (!out_obj)
> +               return -EINVAL;
> +
> +       for (i = 0; i < out_obj->package.count; i++) {

It is not very useful to do a loop if there is a switch () on the
control variable in every step.

> +               union acpi_object *obj = &out_obj->package.elements[i];
> +
> +               if (!valid_cap_type(i, obj))
> +                       goto free_acpi_buffer;
> +
> +               switch (i) {
> +               case CAP_STATUS_IDX:
> +                       cap->status = obj->integer.value;
> +                       break;

The above can be written as

if (out_obj->package.elements[CAP_STATUS_IDX].type != ACPI_TYPE_INTEGER)
        goto free_acpi_buffer;

cap->status = out_obj->package.elements[CAP_STATUS_IDX].integer.value;

and analogously for all of the other index values.

But check the number of elements upfront.

> +               case CAP_UPDATE_IDX:
> +                       cap->update_cap = obj->integer.value;
> +                       break;
> +               case CAP_CODE_TYPE_IDX:
> +                       memcpy(&cap->code_type, obj->buffer.pointer,
> +                              obj->buffer.length);
> +                       break;
> +               case CAP_FW_VER_IDX:
> +                       cap->fw_version = obj->integer.value;
> +                       break;
> +               case CAP_CODE_RT_VER_IDX:
> +                       cap->code_rt_version = obj->integer.value;
> +                       break;
> +               case CAP_DRV_TYPE_IDX:
> +                       memcpy(&cap->drv_type, obj->buffer.pointer,
> +                              obj->buffer.length);
> +                       break;
> +               case CAP_DRV_RT_VER_IDX:
> +                       cap->drv_rt_version = obj->integer.value;
> +                       break;
> +               case CAP_DRV_SVN_IDX:
> +                       cap->drv_svn = obj->integer.value;
> +                       break;
> +               case CAP_PLAT_ID_IDX:
> +                       memcpy(&cap->platform_id, obj->buffer.pointer,
> +                              obj->buffer.length);
> +                       break;
> +               case CAP_OEM_ID_IDX:
> +                       memcpy(&cap->oem_id, obj->buffer.pointer,
> +                              obj->buffer.length);
> +                       break;
> +               case CAP_OEM_INFO_IDX:
> +                       /*vendor specific data*/
> +                       break;
> +               default:
> +                       pr_err("Incorrect format of Update Capability.\n");

Why pr_err() and not dev_dbg()?

Besides, it looks like you're going to fail if the package has more
elements than expected, but is this really a big deal?

Moreover, what if the number of package elements is too small?

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
> +static int query_buffer(struct pfru_com_buf_info *info)
> +{
> +       union acpi_object *out_obj;
> +       acpi_handle handle;
> +       int i, ret = -EINVAL;
> +
> +       handle = ACPI_HANDLE(pfru_dev->dev);
> +       out_obj = acpi_evaluate_dsm_typed(handle, &pfru_dev->uuid,
> +                                         pfru_dev->rev_id, FUNC_QUERY_BUF,
> +                                         NULL, ACPI_TYPE_PACKAGE);
> +       if (!out_obj)
> +               return -EINVAL;
> +
> +       for (i = 0; i < out_obj->package.count; i++) {

Again, what is the benefit from doing this loop?

> +               union acpi_object *obj = &out_obj->package.elements[i];
> +
> +               if (obj->type != ACPI_TYPE_INTEGER)
> +                       goto free_acpi_buffer;
> +
> +               switch (i) {
> +               case BUF_STATUS_IDX:
> +                       info->status = obj->integer.value;
> +                       break;
> +               case BUF_EXT_STATUS_IDX:
> +                       info->ext_status = obj->integer.value;
> +                       break;
> +               case BUF_ADDR_LOW_IDX:
> +                       info->addr_lo = obj->integer.value;
> +                       break;
> +               case BUF_ADDR_HI_IDX:
> +                       info->addr_hi = obj->integer.value;
> +                       break;
> +               case BUF_SIZE_IDX:
> +                       info->buf_size = obj->integer.value;
> +                       break;
> +               default:
> +                       pr_err("Incorrect format of Communication Buffer.\n");
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
> +static int get_image_type(efi_manage_capsule_image_header_t *img_hdr,
> +                         int *type)
> +{
> +       guid_t *image_type_id;
> +
> +       /* check whether this is a code injection or driver update */
> +       image_type_id = &img_hdr->image_type_id;

Anything wrong with doing this assignment as initialization?

> +       if (guid_equal(image_type_id, &pfru_dev->code_uuid))
> +               *type = CODE_INJECT_TYPE;
> +       else if (guid_equal(image_type_id, &pfru_dev->drv_uuid))
> +               *type = DRIVER_UPDATE_TYPE;

And what would be wrong with returning the type or a negative error code?

> +       else
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +/*
> + * The (u64 hw_ins) was introduced in UEFI spec version 2,
> + * and (u64 capsule_support) was introduced in version 3.
> + * The size needs to be adjusted accordingly. That is to
> + * say, version 1 should subtract the size of hw_ins+capsule_support,
> + * and version 2 should sbstract the size of capsule_support.

Either turn this into a kerneldoc comment or put it inside the function.

> + */
> +static int adjust_efi_size(efi_manage_capsule_image_header_t *img_hdr,
> +                          int *size)
> +{
> +       int tmp_size = *size;
> +
> +       tmp_size += sizeof(efi_manage_capsule_image_header_t);
> +       switch (img_hdr->ver) {
> +       case 1:
> +               tmp_size -= 2 * sizeof(u64);
> +               break;
> +       case 2:
> +               tmp_size -= sizeof(u64);
> +               break;
> +       default:
> +               /* only support version 1 and 2 */
> +               return -EINVAL;
> +       }
> +       *size = tmp_size;

Why not simply return the size or a negative error code?

> +
> +       return 0;
> +}
> +
> +/*
> + * Sanity check if the capsule image has a newer version than current one.
> + * Return: true if it is valid, false otherwise.

Would it hurt if this was a proper kerneldoc comment?

> + */
> +static bool valid_version(const void *data, struct pfru_update_cap_info *cap)
> +{
> +       struct pfru_payload_hdr *payload_hdr;
> +       efi_capsule_header_t *cap_hdr;
> +       efi_manage_capsule_header_t *m_hdr;
> +       efi_manage_capsule_image_header_t *m_img_hdr;
> +       efi_image_auth_t *auth;
> +       int type, size, ret;
> +
> +       cap_hdr = (efi_capsule_header_t *)data;
> +       size = cap_hdr->headersize;
> +       m_hdr = (efi_manage_capsule_header_t *)(data + size);
> +       /*
> +        * Current data structure size plus variable array indicated
> +        * by number of (emb_drv_cnt + payload_cnt)
> +        */
> +       size += sizeof(efi_manage_capsule_header_t) +
> +                     (m_hdr->emb_drv_cnt + m_hdr->payload_cnt) * sizeof(u64);
> +       m_img_hdr = (efi_manage_capsule_image_header_t *)(data + size);
> +
> +       ret = get_image_type(m_img_hdr, &type);
> +       if (ret)
> +               return false;
> +
> +       ret = adjust_efi_size(m_img_hdr, &size);
> +       if (ret)
> +               return false;
> +
> +       auth = (efi_image_auth_t *)(data + size);
> +       size += sizeof(u64) + auth->auth_info.hdr.len;
> +       payload_hdr = (struct pfru_payload_hdr *)(data + size);
> +
> +       /* Finally, compare the version. */
> +       if (type == CODE_INJECT_TYPE)
> +               return payload_hdr->rt_ver >= cap->code_rt_version;
> +       else
> +               return payload_hdr->rt_ver >= cap->drv_rt_version;
> +}
> +
> +static void dump_update_result(struct pfru_updated_result *result)
> +{
> +       pr_debug("Update result:\n");
> +       pr_debug("Status:%d\n", result->status);
> +       pr_debug("Extended Status:%d\n", result->ext_status);
> +       pr_debug("Authentication Time Low:%lld\n", result->low_auth_time);
> +       pr_debug("Authentication Time High:%lld\n", result->high_auth_time);
> +       pr_debug("Execution Time Low:%lld\n", result->low_exec_time);
> +       pr_debug("Execution Time High:%lld\n", result->high_exec_time);

All of these could be dev_dbg() I suppose?

> +}
> +
> +static int start_acpi_update(int action)
> +{
> +       union acpi_object *out_obj, in_obj, in_buf;
> +       struct pfru_updated_result update_result;
> +       acpi_handle handle;
> +       int i, ret = -EINVAL;
> +
> +       memset(&in_obj, 0, sizeof(in_obj));
> +       memset(&in_buf, 0, sizeof(in_buf));
> +       in_obj.type = ACPI_TYPE_PACKAGE;
> +       in_obj.package.count = 1;
> +       in_obj.package.elements = &in_buf;
> +       in_buf.type = ACPI_TYPE_INTEGER;
> +       in_buf.integer.value = action;
> +
> +       handle = ACPI_HANDLE(pfru_dev->dev);
> +       out_obj = acpi_evaluate_dsm_typed(handle, &pfru_dev->uuid,
> +                                         pfru_dev->rev_id, FUNC_START,
> +                                         &in_obj, ACPI_TYPE_PACKAGE);
> +       if (!out_obj)
> +               return -EINVAL;
> +
> +       for (i = 0; i < out_obj->package.count; i++) {

Same comment regarding the benefit of doing a loop: why is it needed?

> +               union acpi_object *obj = &out_obj->package.elements[i];
> +
> +               if (obj->type != ACPI_TYPE_INTEGER)
> +                       goto free_acpi_buffer;
> +               switch (i) {
> +               case UPDATE_STATUS_IDX:
> +                       update_result.status = obj->integer.value;
> +                       break;
> +               case UPDATE_EXT_STATUS_IDX:
> +                       update_result.ext_status = obj->integer.value;
> +                       break;
> +               case UPDATE_AUTH_TIME_LOW_IDX:
> +                       update_result.low_auth_time = obj->integer.value;
> +                       break;
> +               case UPDATE_AUTH_TIME_HI_IDX:
> +                       update_result.high_auth_time = obj->integer.value;
> +                       break;
> +               case UPDATE_EXEC_TIME_LOW_IDX:
> +                       update_result.low_exec_time = obj->integer.value;
> +                       break;
> +               case UPDATE_EXEC_TIME_HI_IDX:
> +                       update_result.high_exec_time = obj->integer.value;
> +                       break;
> +               default:
> +                       pr_err("Incorrect format of Runtime Update result.\n");
> +                       goto free_acpi_buffer;
> +               }
> +       }
> +       dump_update_result(&update_result);
> +       ret = 0;
> +
> +free_acpi_buffer:
> +       ACPI_FREE(out_obj);
> +
> +       return ret;
> +}
> +
> +static long pfru_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +       void __user *p;
> +       int ret = 0, rev;
> +
> +       p = (void __user *)arg;
> +
> +       switch (cmd) {
> +       case PFRU_IOC_SET_REV:
> +               if (copy_from_user(&rev, p, sizeof(unsigned int)))
> +                       return -EFAULT;
> +               if (!pfru_valid_revid(rev))
> +                       return -EFAULT;

Why is this the right error code to return here?

> +               pfru_dev->rev_id = rev;
> +               break;
> +       case PFRU_IOC_STAGE:
> +               ret = start_acpi_update(START_STAGE);
> +               break;
> +       case PFRU_IOC_ACTIVATE:
> +               ret = start_acpi_update(START_ACTIVATE);
> +               break;
> +       case PFRU_IOC_STAGE_ACTIVATE:
> +               ret = start_acpi_update(START_STAGE_ACTIVATE);
> +               break;
> +       default:
> +               ret = -ENOIOCTLCMD;
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +#ifdef CONFIG_COMPAT
> +static long compat_pfru_ioctl(struct file *filep, unsigned int cmd,
> +                             unsigned long arg)
> +{
> +       return pfru_ioctl(filep, cmd, arg);
> +}
> +#endif
> +
> +static int pfru_open(struct inode *inode, struct file *file)
> +{
> +       return capable(CAP_SYS_RAWIO) ? stream_open(inode, file) : -EPERM;
> +}
> +
> +static ssize_t pfru_write(struct file *file, const char __user *buf,
> +                         size_t len, loff_t *ppos)
> +{
> +       struct pfru_update_cap_info cap;
> +       struct pfru_com_buf_info info;
> +       phys_addr_t phy_addr;
> +       struct iov_iter iter;
> +       struct iovec iov;
> +       char *buf_ptr;
> +       int ret;
> +
> +       ret = query_buffer(&info);
> +       if (ret)
> +               return ret;
> +
> +       if (len > info.buf_size)
> +               return -EINVAL;
> +
> +       iov.iov_base = (void __user *)buf;
> +       iov.iov_len = len;
> +       iov_iter_init(&iter, WRITE, &iov, 1, len);
> +
> +       /* map the communication buffer */
> +       phy_addr = (phys_addr_t)(info.addr_lo | (info.addr_hi << 32));
> +       buf_ptr = memremap(phy_addr, info.buf_size, MEMREMAP_WB);
> +       if (IS_ERR(buf_ptr))
> +               return PTR_ERR(buf_ptr);

Empty line here, please.

> +       if (!copy_from_iter_full(buf_ptr, len, &iter)) {
> +               pr_err("error! could not read capsule file\n");

dev_dbg()?

> +               ret = -EINVAL;
> +               goto unmap;
> +       }
> +
> +       /* Check if the capsule header has a valid version number. */
> +       ret = query_capability(&cap);
> +       if (ret)
> +               goto unmap;

ret is guaranteed to be 0 here, so you can do

if (cap.status != DSM_SUCCEED)
        ret = -EBUSY;
else if (!valid_version(buf_ptr, &cap))
        ret = -EINVAL;

and the gotos and the "ret = 0" statement below won't be necessary.

> +
> +       if (cap.status != DSM_SUCCEED) {
> +               ret = -EBUSY;
> +               goto unmap;
> +       }
> +       if (!valid_version(buf_ptr, &cap)) {
> +               ret = -EINVAL;
> +               goto unmap;
> +       }
> +       ret = 0;
> +unmap:
> +       memunmap(buf_ptr);
> +
> +       return ret ?: len;
> +}
> +
> +static ssize_t pfru_read(struct file *filp, char __user *ubuf,
> +                        size_t size, loff_t *off)
> +{
> +       struct pfru_update_cap_info cap;
> +       int ret;
> +
> +       ret = query_capability(&cap);
> +       if (ret)
> +               return ret;
> +
> +       size = min_t(size_t, size, sizeof(cap));
> +
> +       if (copy_to_user(ubuf, &cap, size))
> +               return -EFAULT;

Well, if the read() is only needed for this, maybe consider
implementing it as an ioctl() command and using read() for the
telemetry retrieval?  Then, you won't need the other special device
file, the write() will be the code injection/update, the read() will
be telemetry retrieval and all of the rest can be ioctl()s under one
special device file.

> +
> +       return size;
> +}
> +
> +static const struct file_operations acpi_pfru_fops = {
> +       .owner          = THIS_MODULE,
> +       .write          = pfru_write,
> +       .read           = pfru_read,
> +       .open           = pfru_open,
> +       .unlocked_ioctl = pfru_ioctl,
> +#ifdef CONFIG_COMPAT
> +       .compat_ioctl   = compat_pfru_ioctl,
> +#endif
> +       .llseek         = noop_llseek,
> +};
> +
> +static struct miscdevice pfru_misc_dev = {
> +       .minor = MISC_DYNAMIC_MINOR,
> +       .name = "pfru_update",
> +       .nodename = "pfru/update",
> +       .fops = &acpi_pfru_fops,
> +};
> +
> +static int acpi_pfru_remove(struct platform_device *pdev)
> +{
> +       misc_deregister(&pfru_misc_dev);
> +       kfree(pfru_dev);
> +       pfru_dev = NULL;
> +
> +       return 0;
> +}
> +
> +static int acpi_pfru_probe(struct platform_device *pdev)
> +{
> +       acpi_handle handle;
> +       int ret;
> +
> +       if (pfru_dev) {
> +               pr_err("Duplicated PFRU INTC1080 detected, skip...\n");
> +               return 0;
> +       }
> +
> +       pfru_dev = kzalloc(sizeof(*pfru_dev), GFP_KERNEL);
> +       if (!pfru_dev)
> +               return -ENOMEM;
> +
> +       ret = guid_parse(PFRU_UUID, &pfru_dev->uuid);
> +       if (ret)
> +               goto out;
> +       ret = guid_parse(PFRU_CODE_INJ_UUID, &pfru_dev->code_uuid);
> +       if (ret)
> +               goto out;
> +       ret = guid_parse(PFRU_DRV_UPDATE_UUID, &pfru_dev->drv_uuid);
> +       if (ret)
> +               goto out;
> +
> +       /* default rev id is 1 */
> +       pfru_dev->rev_id = 1;
> +       pfru_dev->dev = &pdev->dev;
> +       handle = ACPI_HANDLE(pfru_dev->dev);
> +       if (!acpi_has_method(handle, "_DSM")) {
> +               pr_err("Missing _DSM\n");
> +               ret = -ENODEV;
> +               goto out;
> +       }
> +
> +       ret = misc_register(&pfru_misc_dev);
> +       if (ret)
> +               goto out;
> +
> +       return 0;
> +out:
> +       kfree(pfru_dev);
> +       pfru_dev = NULL;
> +
> +       return ret;
> +}
> +
> +static const struct acpi_device_id acpi_pfru_ids[] = {
> +       {"INTC1080", 0},
> +       {}
> +};
> +MODULE_DEVICE_TABLE(acpi, acpi_pfru_ids);
> +
> +static struct platform_driver acpi_pfru_driver = {
> +       .driver = {
> +               .name = "pfru_update",
> +               .acpi_match_table = acpi_pfru_ids,
> +       },
> +       .probe = acpi_pfru_probe,
> +       .remove = acpi_pfru_remove,
> +};
> +module_platform_driver(acpi_pfru_driver);
> +
> +MODULE_DESCRIPTION("Platform Firmware Runtime Update device driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/uapi/linux/pfru.h b/include/uapi/linux/pfru.h
> new file mode 100644
> index 000000000000..ca0b7433f79f
> --- /dev/null
> +++ b/include/uapi/linux/pfru.h
> @@ -0,0 +1,101 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Platform Firmware Runtime Update header
> + *
> + * Copyright(c) 2021 Intel Corporation. All rights reserved.
> + */
> +#ifndef __PFRU_H__
> +#define __PFRU_H__
> +
> +#include <linux/ioctl.h>
> +#include <linux/uuid.h>
> +
> +#define PFRU_UUID              "ECF9533B-4A3C-4E89-939E-C77112601C6D"
> +#define PFRU_CODE_INJ_UUID             "B2F84B79-7B6E-4E45-885F-3FB9BB185402"
> +#define PFRU_DRV_UPDATE_UUID           "4569DD8C-75F1-429A-A3D6-24DE8097A0DF"
> +
> +#define FUNC_STANDARD_QUERY    0
> +#define FUNC_QUERY_UPDATE_CAP  1
> +#define FUNC_QUERY_BUF         2
> +#define FUNC_START             3
> +
> +#define CODE_INJECT_TYPE       1
> +#define DRIVER_UPDATE_TYPE     2
> +
> +#define REVID_1                1
> +#define REVID_2                2
> +
> +#define PFRU_MAGIC 0xEE
> +
> +#define PFRU_IOC_SET_REV _IOW(PFRU_MAGIC, 0x01, unsigned int)
> +#define PFRU_IOC_STAGE _IOW(PFRU_MAGIC, 0x02, unsigned int)
> +#define PFRU_IOC_ACTIVATE _IOW(PFRU_MAGIC, 0x03, unsigned int)
> +#define PFRU_IOC_STAGE_ACTIVATE _IOW(PFRU_MAGIC, 0x04, unsigned int)
> +
> +static inline int pfru_valid_revid(int id)
> +{
> +       return (id == REVID_1) || (id == REVID_2);
> +}
> +
> +/* Capsule file payload header */
> +struct pfru_payload_hdr {
> +       __u32   sig;
> +       __u32   hdr_version;
> +       __u32   hdr_size;
> +       __u32   hw_ver;
> +       __u32   rt_ver;
> +       uuid_t  platform_id;
> +};
> +
> +enum pfru_start_action {
> +       START_STAGE,
> +       START_ACTIVATE,
> +       START_STAGE_ACTIVATE,
> +};
> +
> +enum pfru_dsm_status {
> +       DSM_SUCCEED,
> +       DSM_FUNC_NOT_SUPPORT,
> +       DSM_INVAL_INPUT,
> +       DSM_HARDWARE_ERR,
> +       DSM_RETRY_SUGGESTED,
> +       DSM_UNKNOWN,
> +       DSM_FUNC_SPEC_ERR,
> +};
> +
> +struct pfru_update_cap_info {
> +       enum pfru_dsm_status status;
> +       __u32 update_cap;
> +
> +       uuid_t code_type;
> +       __u32 fw_version;
> +       __u32 code_rt_version;
> +
> +       uuid_t drv_type;
> +       __u32 drv_rt_version;
> +       __u32 drv_svn;
> +
> +       uuid_t platform_id;
> +       uuid_t oem_id;
> +
> +       char oem_info[];
> +};
> +
> +struct pfru_com_buf_info {
> +       enum pfru_dsm_status status;
> +       enum pfru_dsm_status ext_status;
> +       __u64 addr_lo;
> +       __u64 addr_hi;
> +       __u32 buf_size;
> +};
> +
> +struct pfru_updated_result {
> +       enum pfru_dsm_status status;
> +       enum pfru_dsm_status ext_status;
> +       __u64 low_auth_time;
> +       __u64 high_auth_time;
> +       __u64 low_exec_time;
> +       __u64 high_exec_time;
> +};
> +
> +#endif /* __PFRU_H__ */
> --
