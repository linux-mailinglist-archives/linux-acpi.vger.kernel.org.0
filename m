Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D82E36168C
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Apr 2021 01:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbhDOXun (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Apr 2021 19:50:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:10840 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236043AbhDOXun (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Apr 2021 19:50:43 -0400
IronPort-SDR: D8z+XwkxkhlDlb5jcrlykp4Smywy7yRyknSi+iU1gsvZv5tYzTI0JkSw/O5WoPtbPbJhScat7o
 PBK3hb+OGg9Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="174458446"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="174458446"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:50:19 -0700
IronPort-SDR: eGJ9FTYJ9NtptFWp74pgwnK1jWYxF4rMRmU/9xj8a25/QYZD0h6F+CCyk+ewartnpMa+ft28v2
 i9a1UjJtGBbw==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="418926874"
Received: from oamoninu-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.130.91])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:50:18 -0700
Date:   Thu, 15 Apr 2021 16:50:16 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/7] cxl: Add HDM decoder capbilities
Message-ID: <20210415235016.uobdn4m6bq35f4ob@intel.com>
References: <20210407222625.320177-1-ben.widawsky@intel.com>
 <20210407222625.320177-8-ben.widawsky@intel.com>
 <CAPcyv4hSvN_O7UUaD=AR=F3bOesDnJFsEeHZ4=fLQySiGxVekw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hSvN_O7UUaD=AR=F3bOesDnJFsEeHZ4=fLQySiGxVekw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thanks for looking. Mostly trivial agreements or disagreements which I don't
care much about, but I'd really like you to focus on the last point, please.

On 21-04-15 16:27:14, Dan Williams wrote:
> On Wed, Apr 7, 2021 at 3:26 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > An HDM decoder is defined in the CXL 2.0 specification as a mechanism
> > that allow devices and upstream ports to claim memory address ranges and
> > participate in interleave sets. HDM decoder registers are within the
> > component register block defined in CXL 2.0 8.2.3 CXL 2.0 Component
> > Registers as part of the CXL.cache and CXL.mem subregion.
> >
> > The Component Register Block is found via the Register Locator DVSEC
> > in a similar fashion to how the CXL Device Register Block is found. The
> > primary difference is the capability id size of the Component Register
> > Block is a single DWORD instead of 4 DWORDS.
> >
> > It's now possible to configure a CXL type 3 device's HDM decoder.
> 
> It's always been possible and this patch just prepares for programming
> them, but does not actually touch them yet. So let's drop this as I'm
> not sure what it is saying.
> 
> > Such
> > programming is expected for CXL devices with persistent memory, and hot
> > plugged CXL devices that participate in CXL.mem with volatile memory.
> 
> Let's drop this as well because the state of what the OS is expected
> to program is platform and topology specific. The OS needs to be
> prepared for the HDMs to be unprogrammed, validly programmed in a
> state the OS will leave untouched, and/or validly programmed in a way
> the OS wants to redo.
> 

Okay to both.

> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >  drivers/cxl/core.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxl.h  | 48 ++++++++++++++++++++++++++++++
> >  drivers/cxl/mem.c  | 37 ++++++++++++++++++++---
> >  drivers/cxl/pci.h  |  1 +
> >  4 files changed, 155 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
> > index 65cd704581bc..db6a83eed0a2 100644
> > --- a/drivers/cxl/core.c
> > +++ b/drivers/cxl/core.c
> > @@ -479,6 +479,79 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
> >  }
> >  EXPORT_SYMBOL_GPL(devm_cxl_add_port);
> >
> > +void cxl_setup_component_regs(struct device *dev, void __iomem *base,
> > +                             struct cxl_component_regs *regs)
> > +{
> > +       int cap, cap_count;
> > +       u64 cap_array;
> > +
> > +       *regs = (struct cxl_component_regs) { 0 };
> > +
> > +       /*
> > +        * CXL.cache and CXL.mem registers are at offset 0x1000 as defined in
> > +        * CXL 2.0 8.2.4 Table 141.
> > +        *
> > +        * TODO: Map other registers as needed.
> 
> That TODO goes without saying.
> 

I don't agree with this. The device register implementation is complete as is,
and this one is not.

> > +        */
> > +       base += CXL_CM_OFFSET;
> > +
> > +       cap_array = readq(base + CXL_CM_CAP_HDR_OFFSET);
> > +
> > +       if (FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, cap_array) != CM_CAP_HDR_CAP_ID) {
> > +               dev_err(dev,
> > +                       "Couldn't locate the CXL.cache and CXL.mem capability array header./n");
> > +               return;
> > +       }
> > +
> > +       /* It's assumed that future versions will be backward compatible */
> 
> If future versions are backwards compatible then why check? If someone
> wants a driver that supports new capabilities then update the driver,
> but validating that the version is non-zero seems to be a pedantic
> check for no good reason to me.
> 

This was specifically meant as a way to prevent the driver being used for 1.1
without explicit support being added (and then dropping this check). You're
right though , it should be !=, it should have been <. It's sounding like you'd
rather I remove it entirely rather than fix it though. Is that correct?

> > +#define CAPID_VERSION_CHECK(data, mask, expected, capability_msg)              \
> > +       do {                                                                   \
> > +               if (FIELD_GET(mask, data) < expected) {                        \
> > +                       dev_err(dev,                                           \
> > +                               capability_msg                                 \
> > +                               " version %ld is below expected %d",           \
> > +                               FIELD_GET(mask, data), expected);              \
> > +                       return;                                                \
> 
> Ugh, "return" in a macro, please no.
> 

Okay. If you're okay with the macro, I'll rewrite it to bool and then return
based on that.

> > +               }                                                              \
> > +       } while (0)
> > +
> > +       CAPID_VERSION_CHECK(cap_array, CXL_CM_CAP_HDR_VERSION_MASK,
> > +                           CM_CAP_HDR_CAP_VERSION, "Capability array header");
> > +       CAPID_VERSION_CHECK(cap_array, CXL_CM_CAP_HDR_CACHE_MEM_VERSION_MASK,
> > +                           CM_CAP_HDR_CACHE_MEM_VERSION,
> > +                           "Capability array header CXL.cache CXL.mem");
> > +
> > +       cap_count = FIELD_GET(CXL_CM_CAP_HDR_ARRAY_SIZE_MASK, cap_array);
> > +
> > +       for (cap = 1; cap <= cap_count; cap++) {
> > +               void __iomem *register_block;
> > +               u32 hdr;
> > +               u16 cap_id, offset;
> > +
> > +               hdr = readl(base + cap * 0x4);
> > +
> > +               cap_id = FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, hdr);
> > +               offset = FIELD_GET(CXL_CM_CAP_PTR_MASK, hdr);
> > +               register_block = base + offset;
> > +
> > +               switch (cap_id) {
> > +               case CXL_CM_CAP_CAP_ID_HDM:
> > +                       CAPID_VERSION_CHECK(hdr, CXL_CM_CAP_HDR_VERSION_MASK,
> > +                                           CXL_CM_CAP_CAP_HDM_VERSION,
> > +                                           "HDM decoder capability");
> > +                       dev_dbg(dev, "found HDM decoder capability (0x%x)\n",
> > +                               offset);
> > +                       regs->hdm_decoder = register_block;
> > +                       break;
> > +               default:
> > +                       dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
> 
> Hex cap id? Perhaps rather than "Unknown" this can just say "Skipping"
> because some of these are technically it's just the kernel does not
> care.
> 

I just sent some patches for devices that I'd like to include for 5.12 to this
effect. I'll fix this here too.

> > +                               offset);
> > +                       break;
> > +               }
> > +       }
> > +}
> > +EXPORT_SYMBOL_GPL(cxl_setup_component_regs);
> > +
> >  /*
> >   * cxl_setup_device_regs() - Detect CXL Device register blocks
> >   * @dev: Host device of the @base mapping
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 0211f44c95a2..a4ad1176dc5a 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -8,6 +8,31 @@
> >  #include <linux/bitops.h>
> >  #include <linux/io.h>
> >
> > +/* CXL 2.0 8.2.5 CXL.cache and CXL.mem Registers*/
> > +#define CXL_CM_OFFSET 0x1000
> > +#define CXL_CM_CAP_HDR_OFFSET 0x0
> > +#define   CXL_CM_CAP_HDR_ID_MASK GENMASK(15, 0)
> > +#define     CM_CAP_HDR_CAP_ID 1
> > +#define   CXL_CM_CAP_HDR_VERSION_MASK GENMASK(19, 16)
> > +#define     CM_CAP_HDR_CAP_VERSION 1
> > +#define   CXL_CM_CAP_HDR_CACHE_MEM_VERSION_MASK GENMASK(23, 20)
> > +#define     CM_CAP_HDR_CACHE_MEM_VERSION 1
> > +#define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
> > +#define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
> > +
> > +#define   CXL_CM_CAP_CAP_ID_HDM 0x5
> > +#define   CXL_CM_CAP_CAP_HDM_VERSION 1
> > +
> > +/* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
> > +#define CXL_HDM_DECODER_CAP_OFFSET 0x0
> > +#define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
> > +#define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
> > +#define CXL_HDM_DECODER0_BASE_LOW_OFFSET 0x10
> > +#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET 0x14
> > +#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET 0x18
> > +#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET 0x1c
> > +#define CXL_HDM_DECODER0_CTRL_OFFSET 0x20
> > +
> >  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
> >  #define CXLDEV_CAP_ARRAY_OFFSET 0x0
> >  #define   CXLDEV_CAP_ARRAY_CAP_ID 0
> > @@ -35,11 +60,26 @@
> >  #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
> >
> >  /* See note for 'struct cxl_regs' for the rationale of this organization */
> > +#define CXL_COMPONENT_REGS() \
> > +       void __iomem *hdm_decoder
> > +
> >  #define CXL_DEVICE_REGS() \
> >         void __iomem *status; \
> >         void __iomem *mbox; \
> >         void __iomem *memdev
> >
> > +/**
> > + * struct cxl_component_regs - Common container of CXL component register block
> > + *                            base pointers.
> > + *
> > + * The only component registers that we care about are the CXL.cache and CXL.mem
> > + * registers which are at offset 0x1000 from the component register base (CXL
> > + * 2.0 8.2.4)
> > + */
> 
> I don't think kernel-doc will be happy about this, so probably follow
> the same fixup I did when Jonathan pointed this out for the cxl_port
> patches.
> 

I must have missed something on this. I thought the issue with yours was the way
in which you were calling out the structure members. I skipped this completely
in mine. Is the ask here to add "@hdm" to the documentation? I don't see any
other issue here.

> > +struct cxl_component_regs {
> > +       CXL_COMPONENT_REGS();
> > +};
> > +
> >  /**
> >   * struct cxl_device_regs - Common container of CXL Device register
> >   *                         block base pointers
> > @@ -59,6 +99,12 @@ struct cxl_device_regs {
> >   * The specificity reads naturally from left-to-right.
> >   */
> >  struct cxl_regs {
> > +       union {
> > +               struct {
> > +                       CXL_COMPONENT_REGS();
> > +               };
> > +               struct cxl_component_regs component;
> > +       };
> >         union {
> >                 struct {
> >                         CXL_DEVICE_REGS();
> > @@ -67,6 +113,8 @@ struct cxl_regs {
> >         };
> >  };
> >
> > +void cxl_setup_component_regs(struct device *dev, void __iomem *base,
> > +                             struct cxl_component_regs *regs);
> >  void cxl_setup_device_regs(struct device *dev, void __iomem *base,
> >                            struct cxl_device_regs *regs);
> >
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index b7342aaf38c4..e915e3743b76 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -974,6 +974,21 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
> >         return 0;
> >  }
> >
> > +static int __cxl_setup_component_regs(struct cxl_mem *cxlm, void __iomem *base)
> > +{
> > +       struct cxl_regs *regs = &cxlm->regs;
> > +       struct pci_dev *pdev = cxlm->pdev;
> > +       struct device *dev = &pdev->dev;
> > +
> > +       cxl_setup_component_regs(dev, base, &regs->component);
> > +       if (!regs->hdm_decoder) {
> > +               dev_err(dev, "HDM decoder registers not found\n");
> > +               return -ENXIO;
> 
> I was hoping this patch would show the justification of the
> organization proposed in patch-6, but it doesn't and I think we're
> better off open coding the error check in cxl_mem_setup_regs().

Open coding is functionally equivalent and I think much less tidy, in particular
if you consider adding more register block types in the future (and
specifically, more component register types in the blocks, in the future). I
would predict that this kind of cleanup will happen at some point, however if
you'd prefer to kick the can down the road, we can do that.

If the heartburn is over the naming specifically, it would be my preference to
fix that rather than open-coding.

Addressing the feedback from patch 6 here, since they're tied together, "__"
prefix is, I want to call the core function but I have certain expectations
about the results of that function, and thus the wrapper (sounds like you got
that). TBF, the naming is backward as I'd prefer the core function be
__cxl_setup.., and this one be something like cxl_mem_setup_component_regs(). I
just didn't want to touch the thing you'd previously named. Perhaps that naming
more appropriately construes what I'm trying to do?

> 
> All the other patches in this series I did not comment on look good to me.

