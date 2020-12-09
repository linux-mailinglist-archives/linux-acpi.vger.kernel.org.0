Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352D92D3832
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Dec 2020 02:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgLIBSU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Dec 2020 20:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgLIBSU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2020 20:18:20 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A3EC0613CF
        for <linux-acpi@vger.kernel.org>; Tue,  8 Dec 2020 17:17:39 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id cw27so245596edb.5
        for <linux-acpi@vger.kernel.org>; Tue, 08 Dec 2020 17:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7fIOzCvpd6aSP3MBc1QUX2SNDA47p2Jnl5uGB646gB4=;
        b=swFJsHPTureZg+ccHNrZKz0Ay6MPRyHrYK561JfYX8lByhLMlQt/+fMH6u8y4qqbEw
         VYmoZB25A6sG0S2neeGtA6Gc407XbR8j8yVhJmpqypbPJYSH1qdo/njjEKYWtjNWxqhu
         Wao+dMIbW/kdfe0UmeYmX6XdyVZotXSdPYuf5io+ZsxETGDvxdkE0hPA0cBd5Jq4f4Ud
         bM9LawcpsCm13fCdas2EBJ3ZQH2lxCPm9DT8sQdYzvuWQgNOmce6A8OGOEc2pyMxBCa0
         wyeHZoCqxkacBcxMGHzxgw2nsknYfYOnmQA/Is/6FqI6b1OV79guRBXGSZPNlumpM+Ha
         AW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7fIOzCvpd6aSP3MBc1QUX2SNDA47p2Jnl5uGB646gB4=;
        b=Tvz8m52DpkBNPn1PbcjLYLwi8hW2fckZDKKJZy3kmKFtARPSTFaf1p4sFZch/jGtR0
         cUNnTxvpbUul0s+oRmaIgFhFxB8MT5Ku2YqhIwUMRMvFIccyxIu2ruHr1CefZcZ5iXjL
         tI90CfOWghR5adeqWYQJTFrGEXFYWe488FB/S7NFDPm58Cq+oQcjIrH+a7DzIv8OFjQV
         zU8xU8lP2Jeud9dJrE2gc3R759nQSSn+4BJuBRKFRC4E4i43k71xDdcyKwkO7xNtWWgY
         IBHd6yHjb/PZecNT08WWdFiE7sdpYCTwSoTB3E7zN3QmXpIepwMKi6L5jRcUfpheD+jf
         +AUA==
X-Gm-Message-State: AOAM530hOr0mtBRuyIq/mDKGyRuDSqfklfGq9ysoCU73Uv3Tx1KKGB5q
        bW610ejDmsVRXwfbLsgSomrnbEL1utpWx38sT/VXzw==
X-Google-Smtp-Source: ABdhPJzxVnQtRyJI4S2IHeWKfYBJCVMTSxNCGUnGWc8AdVYhwvSrNC/IyV+FIez7TrBAryxGqC3ACKxHaNpVNQOeJSU=
X-Received: by 2002:a50:e0ce:: with SMTP id j14mr652719edl.18.1607476658534;
 Tue, 08 Dec 2020 17:17:38 -0800 (PST)
MIME-Version: 1.0
References: <20201209002418.1976362-1-ben.widawsky@intel.com> <20201209002418.1976362-13-ben.widawsky@intel.com>
In-Reply-To: <20201209002418.1976362-13-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Dec 2020 17:17:36 -0800
Message-ID: <CAPcyv4gW8H1wNVDFhSt1SFbU=mcNZFKBve4xG24rGJaJg1wQZA@mail.gmail.com>
Subject: Re: [RFC PATCH 12/14] cxl: Add basic debugging
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Dec 8, 2020 at 4:24 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Provide a standard debug function for use throughout the driver.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/cxl.h |  3 +++
>  drivers/cxl/mem.c | 26 +++++++++++++++++++++++++-
>  2 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 77c2dee6843c..e5afb89dab0b 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -9,6 +9,9 @@
>  #include <linux/bitops.h>
>  #include <linux/io.h>
>
> +#define cxl_debug(fmt, ...)                                                    \
> +       pr_debug("CXL DEBUG: %s: " fmt, __func__, ##__VA_ARGS__)
> +

This should be dev_dbg(), then you don't need the CXL DEBUG prefix. In
fact you don't need a cxl_debug() macro at all in that case. cxl_mem
might need a ->dev attribute for this purpose.

>  #define CXL_SET_FIELD(value, field)                                            \
>         ({                                                                     \
>                 WARN_ON(!FIELD_FIT(field##_MASK, value));                      \
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index a2cea7ac7cc6..6b2f8d3776b5 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -122,9 +122,12 @@ static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
>  {
>         const int timeout = msecs_to_jiffies(2000);
>         const unsigned long start = jiffies;
> +       unsigned long end = start;
>
>         while (cxl_doorbell_busy(cxlm)) {
> -               if (time_after(jiffies, start + timeout)) {
> +               end = jiffies;
> +
> +               if (time_after(end, start + timeout)) {
>                         /* Check again in case preempted before timeout test */
>                         if (!cxl_doorbell_busy(cxlm))
>                                 break;
> @@ -133,6 +136,8 @@ static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
>                 cpu_relax();
>         }
>
> +       cxl_debug("Doorbell wait took %dms",
> +                 jiffies_to_msecs(end) - jiffies_to_msecs(start));
>         return 0;
>  }
>
> @@ -180,6 +185,8 @@ static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
>         }
>
>         /* #4 */
> +       cxl_debug("Sending command to %s\n",
> +                 dev_driver_string(&cxlm->pdev->dev));

dev_dbg() already includes dev_driver_string().

>         cxl_write_mbox_reg32(cxlm, CXLDEV_MB_CTRL_OFFSET,
>                              CXLDEV_MB_CTRL_DOORBELL);
>
> @@ -308,6 +315,8 @@ static int cxl_mem_open(struct inode *inode, struct file *file)
>         if (!cxlmd)
>                 return -ENXIO;
>
> +       cxl_debug("Opened %pD\n", file);
> +
>         file->private_data = cxlmd;
>
>         return 0;
> @@ -383,6 +392,10 @@ static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
>                 .size_in = cmd->info.size_in,
>                 .size_out = size_out,
>         };
> +       cxl_debug("Submitting command for user\n"
> +                 "\topcode: %x\n"
> +                 "\tsize: %zub/%zub\n",
> +                 mbox_cmd.opcode, mbox_cmd.size_in, mbox_cmd.size_out);
>         rc = cxl_mem_mbox_send_cmd(cxlmd->cxlm, &mbox_cmd);
>         cxl_mem_mbox_put(cxlmd->cxlm);
>         if (rc)
> @@ -479,6 +492,8 @@ static long cxl_mem_ioctl(struct file *file, unsigned int cmd, unsigned long arg
>                 u32 n_commands;
>                 int i, j;
>
> +               cxl_debug("Query IOCTL\n");
> +
>                 if (get_user(n_commands, (u32 __user *)arg))
>                         return -EFAULT;
>
> @@ -511,6 +526,8 @@ static long cxl_mem_ioctl(struct file *file, unsigned int cmd, unsigned long arg
>                 struct cxl_mem_command c;
>                 int rc;
>
> +               cxl_debug("Send IOCTL\n");
> +
>                 rc = cxl_validate_cmd_from_user(u, &c);
>                 if (rc)
>                         return rc;
> @@ -843,6 +860,13 @@ static int cxl_mem_identify(struct cxl_mem *cxlm)
>
>         id = (struct cxl_mbox_identify *)mbox_cmd.payload;
>
> +       cxl_debug("Driver identify command\n"
> +                 "\tFirmware Version: %s\n"
> +                 "\tTotal Capacity: %llu (%llu persistent)\n"
> +                 "\tLSA size: %u\n",
> +                 id->fw_revision, id->total_capacity, id->persistent_capacity,
> +                 id->lsa_size);
> +

Seems not necessary for details that are published in sysfs?
