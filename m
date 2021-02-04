Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEE630B136
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Feb 2021 21:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbhBAUCM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Feb 2021 15:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbhBAUBD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2021 15:01:03 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1103C0613ED
        for <linux-acpi@vger.kernel.org>; Mon,  1 Feb 2021 12:00:22 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id w1so26268145ejf.11
        for <linux-acpi@vger.kernel.org>; Mon, 01 Feb 2021 12:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=461YGUpeMwuirfSPdv36fT4hA/Nfndl8hImXvd+kglU=;
        b=Fy0CnF6qJQE/SIb2lSkDnbYkezpH15gQ6p/LXcDkhpabDypI4jB/x7kK41krPNFgXr
         i3WULbXipQ6rdY7LlcDX94sVSLoeRLZtfLBAmo0h6Utu/oWDo7C55t1arvOIcXUh4WXB
         +i6mhIjKHvQJEJTz8/+kwBX0Skfv1jDt3NjaxeAzzywjF4SyHlkSssEIbwDhfwN4Ky49
         lmgyY0dcBY5SVYOMe6CN2AB08ICK2F2ThwNqKO3pADvN9fcw9EkuxFIKg9EzvqKrkIDt
         bmmJ2qWW21QArEDTrZrh3Ev5H81G38s7v0gU0SEevYAleoBXbkS2wYLlzGVDIAr3Zgwu
         3EXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=461YGUpeMwuirfSPdv36fT4hA/Nfndl8hImXvd+kglU=;
        b=b04aIoyT+Xl0pHV4G8Y7wngczcsf+M9bnD0KdvCmYqCKj/M22zHqLoWItSojIWi4C3
         DiYnP74ubSHzuhq66ewcqilQcdpJRtq+H4IcoCjI0kmOV0fmoryFtzOwfQIBlaXEIe/O
         URASjjdN9Tt+7uErvmdCdTXMcX12jXn/8o2YCZKanOrqb+BgqrJeKpb2myVRe78T4AzP
         gIFzNMIcAPSicTZtWHaQmfwB7qIzqLtTy8lo+lHaVjeondMMjdpWobkerQMd99g93vS0
         dV8V5jNekcMC0mNumSom41G34h0RcSybT7qYLZtGNV6HLEfg6M/t3P7z/rKGzIbScwHY
         anBw==
X-Gm-Message-State: AOAM531qIwN6/aIEDLJfGFG/y2Ed2m64i2JGU45qeso9VSnzFTpLQ7Ws
        aORC+GiXXPHQbk34Ji+8uHg4uUpM0v0rpApQ9dqe0g==
X-Google-Smtp-Source: ABdhPJz9uFWkuLDdrzvffjOIXGKy+Hssz4LaB90QiLrBPnysw4tcYuXlQkzlx7XyI13fiOAYKVJMKVpjmbozh/Nwrkg=
X-Received: by 2002:a17:906:d8a1:: with SMTP id qc1mr12489360ejb.523.1612209621231;
 Mon, 01 Feb 2021 12:00:21 -0800 (PST)
MIME-Version: 1.0
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-5-ben.widawsky@intel.com> <5986abe5-1248-30b2-5f53-fa7013baafad@google.com>
In-Reply-To: <5986abe5-1248-30b2-5f53-fa7013baafad@google.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 1 Feb 2021 12:00:18 -0800
Message-ID: <CAPcyv4g_yUpwoBJsLeVwCZAkZGGrfSgrCk2+GXVXBcouktZNSQ@mail.gmail.com>
Subject: Re: [PATCH 04/14] cxl/mem: Implement polled mode mailbox
To:     David Rientjes <rientjes@google.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Jan 30, 2021 at 3:52 PM David Rientjes <rientjes@google.com> wrote:
>
> On Fri, 29 Jan 2021, Ben Widawsky wrote:
>
> > Provide enough functionality to utilize the mailbox of a memory device.
> > The mailbox is used to interact with the firmware running on the memory
> > device.
> >
> > The CXL specification defines separate capabilities for the mailbox and
> > the memory device. The mailbox interface has a doorbell to indicate
> > ready to accept commands and the memory device has a capability register
> > that indicates the mailbox interface is ready. The expectation is that
> > the doorbell-ready is always later than the memory-device-indication
> > that the mailbox is ready.
> >
> > Create a function to handle sending a command, optionally with a
> > payload, to the memory device, polling on a result, and then optionally
> > copying out the payload. The algorithm for doing this comes straight out
> > of the CXL 2.0 specification.
> >
> > Primary mailboxes are capable of generating an interrupt when submitting
> > a command in the background. That implementation is saved for a later
> > time.
> >
> > Secondary mailboxes aren't implemented at this time.
> >
> > The flow is proven with one implemented command, "identify". Because the
> > class code has already told the driver this is a memory device and the
> > identify command is mandatory.
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >  drivers/cxl/Kconfig |  14 ++
> >  drivers/cxl/cxl.h   |  39 +++++
> >  drivers/cxl/mem.c   | 342 +++++++++++++++++++++++++++++++++++++++++++-
> >  3 files changed, 394 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > index 3b66b46af8a0..fe591f74af96 100644
> > --- a/drivers/cxl/Kconfig
> > +++ b/drivers/cxl/Kconfig
> > @@ -32,4 +32,18 @@ config CXL_MEM
> >         Chapter 2.3 Type 3 CXL Device in the CXL 2.0 specification.
> >
> >         If unsure say 'm'.
> > +
> > +config CXL_MEM_INSECURE_DEBUG
> > +     bool "CXL.mem debugging"
> > +     depends on CXL_MEM
> > +     help
> > +       Enable debug of all CXL command payloads.
> > +
> > +       Some CXL devices and controllers support encryption and other
> > +       security features. The payloads for the commands that enable
> > +       those features may contain sensitive clear-text security
> > +       material. Disable debug of those command payloads by default.
> > +       If you are a kernel developer actively working on CXL
> > +       security enabling say Y, otherwise say N.
>
> Not specific to this patch, but the reference to encryption made me
> curious about integrity: are all CXL.mem devices compatible with DIMP?
> Some?  None?

The encryption here is "device passphrase" similar to the NVDIMM
Security Management described here:

https://pmem.io/documents/IntelOptanePMem_DSM_Interface-V2.0.pdf

The LIBNVDIMM enabling wrapped this support with the Linux keys
interface which among other things enforces wrapping the clear text
passphrase with a Linux "trusted/encrypted" key.

Additionally, the CXL.io interface optionally supports PCI IDE:

https://www.intel.com/content/dam/www/public/us/en/documents/reference-guides/pcie-device-security-enhancements.pdf

I'm otherwise not familiar with the DIMP acronym?

> > +
> >  endif
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index a3da7f8050c4..df3d97154b63 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -31,9 +31,36 @@
> >  #define CXLDEV_MB_CAPS_OFFSET 0x00
> >  #define   CXLDEV_MB_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
> >  #define CXLDEV_MB_CTRL_OFFSET 0x04
> > +#define   CXLDEV_MB_CTRL_DOORBELL BIT(0)
> >  #define CXLDEV_MB_CMD_OFFSET 0x08
> > +#define   CXLDEV_MB_CMD_COMMAND_OPCODE_MASK GENMASK(15, 0)
> > +#define   CXLDEV_MB_CMD_PAYLOAD_LENGTH_MASK GENMASK(36, 16)
> >  #define CXLDEV_MB_STATUS_OFFSET 0x10
> > +#define   CXLDEV_MB_STATUS_RET_CODE_MASK GENMASK(47, 32)
> >  #define CXLDEV_MB_BG_CMD_STATUS_OFFSET 0x18
> > +#define CXLDEV_MB_PAYLOAD_OFFSET 0x20
> > +
> > +/* Memory Device (CXL 2.0 - 8.2.8.5.1.1) */
> > +#define CXLMDEV_STATUS_OFFSET 0x0
> > +#define   CXLMDEV_DEV_FATAL BIT(0)
> > +#define   CXLMDEV_FW_HALT BIT(1)
> > +#define   CXLMDEV_STATUS_MEDIA_STATUS_MASK GENMASK(3, 2)
> > +#define     CXLMDEV_MS_NOT_READY 0
> > +#define     CXLMDEV_MS_READY 1
> > +#define     CXLMDEV_MS_ERROR 2
> > +#define     CXLMDEV_MS_DISABLED 3
> > +#define   CXLMDEV_READY(status) \
> > +             (CXL_GET_FIELD(status, CXLMDEV_STATUS_MEDIA_STATUS) == CXLMDEV_MS_READY)
> > +#define   CXLMDEV_MBOX_IF_READY BIT(4)
> > +#define   CXLMDEV_RESET_NEEDED_SHIFT 5
> > +#define   CXLMDEV_RESET_NEEDED_MASK GENMASK(7, 5)
> > +#define     CXLMDEV_RESET_NEEDED_NOT 0
> > +#define     CXLMDEV_RESET_NEEDED_COLD 1
> > +#define     CXLMDEV_RESET_NEEDED_WARM 2
> > +#define     CXLMDEV_RESET_NEEDED_HOT 3
> > +#define     CXLMDEV_RESET_NEEDED_CXL 4
> > +#define   CXLMDEV_RESET_NEEDED(status) \
> > +             (CXL_GET_FIELD(status, CXLMDEV_RESET_NEEDED) != CXLMDEV_RESET_NEEDED_NOT)
> >
> >  /**
> >   * struct cxl_mem - A CXL memory device
> > @@ -44,6 +71,16 @@ struct cxl_mem {
> >       struct pci_dev *pdev;
> >       void __iomem *regs;
> >
> > +     struct {
> > +             struct range range;
> > +     } pmem;
> > +
> > +     struct {
> > +             struct range range;
> > +     } ram;
> > +
> > +     char firmware_version[0x10];
> > +
> >       /* Cap 0001h - CXL_CAP_CAP_ID_DEVICE_STATUS */
> >       struct {
> >               void __iomem *regs;
> > @@ -51,6 +88,7 @@ struct cxl_mem {
> >
> >       /* Cap 0002h - CXL_CAP_CAP_ID_PRIMARY_MAILBOX */
> >       struct {
> > +             struct mutex mutex; /* Protects device mailbox and firmware */
> >               void __iomem *regs;
> >               size_t payload_size;
> >       } mbox;
> > @@ -89,5 +127,6 @@ struct cxl_mem {
> >
> >  cxl_reg(status);
> >  cxl_reg(mbox);
> > +cxl_reg(mem);
> >
> >  #endif /* __CXL_H__ */
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index fa14d51243ee..69ed15bfa5d4 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -6,6 +6,270 @@
> >  #include "pci.h"
> >  #include "cxl.h"
> >
> > +#define cxl_doorbell_busy(cxlm)                                                \
> > +     (cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CTRL_OFFSET) &                    \
> > +      CXLDEV_MB_CTRL_DOORBELL)
> > +
> > +#define CXL_MAILBOX_TIMEOUT_US 2000
>
> This should be _MS?
>
> > +
> > +enum opcode {
> > +     CXL_MBOX_OP_IDENTIFY            = 0x4000,
> > +     CXL_MBOX_OP_MAX                 = 0x10000
> > +};
> > +
> > +/**
> > + * struct mbox_cmd - A command to be submitted to hardware.
> > + * @opcode: (input) The command set and command submitted to hardware.
> > + * @payload_in: (input) Pointer to the input payload.
> > + * @payload_out: (output) Pointer to the output payload. Must be allocated by
> > + *            the caller.
> > + * @size_in: (input) Number of bytes to load from @payload.
> > + * @size_out: (output) Number of bytes loaded into @payload.
> > + * @return_code: (output) Error code returned from hardware.
> > + *
> > + * This is the primary mechanism used to send commands to the hardware.
> > + * All the fields except @payload_* correspond exactly to the fields described in
> > + * Command Register section of the CXL 2.0 spec (8.2.8.4.5). @payload_in and
> > + * @payload_out are written to, and read from the Command Payload Registers
> > + * defined in (8.2.8.4.8).
> > + */
> > +struct mbox_cmd {
> > +     u16 opcode;
> > +     void *payload_in;
> > +     void *payload_out;
> > +     size_t size_in;
> > +     size_t size_out;
> > +     u16 return_code;
> > +#define CXL_MBOX_SUCCESS 0
> > +};
> > +
> > +static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
> > +{
> > +     const int timeout = msecs_to_jiffies(CXL_MAILBOX_TIMEOUT_US);
> > +     const unsigned long start = jiffies;
> > +     unsigned long end = start;
> > +
> > +     while (cxl_doorbell_busy(cxlm)) {
> > +             end = jiffies;
> > +
> > +             if (time_after(end, start + timeout)) {
> > +                     /* Check again in case preempted before timeout test */
> > +                     if (!cxl_doorbell_busy(cxlm))
> > +                             break;
> > +                     return -ETIMEDOUT;
> > +             }
> > +             cpu_relax();
> > +     }
> > +
> > +     dev_dbg(&cxlm->pdev->dev, "Doorbell wait took %dms",
> > +             jiffies_to_msecs(end) - jiffies_to_msecs(start));
> > +     return 0;
> > +}
> > +
> > +static void cxl_mem_mbox_timeout(struct cxl_mem *cxlm,
> > +                              struct mbox_cmd *mbox_cmd)
> > +{
> > +     dev_warn(&cxlm->pdev->dev, "Mailbox command timed out\n");
> > +     dev_info(&cxlm->pdev->dev,
> > +              "\topcode: 0x%04x\n"
> > +              "\tpayload size: %zub\n",
> > +              mbox_cmd->opcode, mbox_cmd->size_in);
> > +
> > +     if (IS_ENABLED(CONFIG_CXL_MEM_INSECURE_DEBUG)) {
> > +             print_hex_dump_debug("Payload ", DUMP_PREFIX_OFFSET, 16, 1,
> > +                                  mbox_cmd->payload_in, mbox_cmd->size_in,
> > +                                  true);
> > +     }
> > +
> > +     /* Here's a good place to figure out if a device reset is needed */
>
> What are the implications if we don't do a reset, as this implementation
> does not?  IOW, does a timeout require a device to be recovered through a
> reset before it can receive additional commands, or is it safe to simply
> drop the command that timed out on the floor and proceed?

Not a satisfying answer, but "it depends". It's also complicated by
the fact that a reset may need to be coordinated with other devices in
the interleave-set as the HDM decoders may bounce.

For comparison, to date there have been no problems with the "drop on
the floor" policy of LIBNVDIMM command timeouts. At the same time
there simply was not a software visible reset mechanism for those
devices so this problem never came out. This mailbox isn't a fast
path, so the device is likely completely dead if this timeout is ever
violated, and the firmware reporting a timeout might as well assume
that the OS gives up on the device.

I'll let Ben chime in on the rest...
