Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F7B4DCA2F
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Mar 2022 16:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbiCQPmC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Mar 2022 11:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbiCQPmB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Mar 2022 11:42:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD1720D8AC;
        Thu, 17 Mar 2022 08:40:43 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KKBBY4YN8z67kgH;
        Thu, 17 Mar 2022 23:38:45 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 17 Mar 2022 16:40:41 +0100
Received: from localhost (10.47.67.100) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 15:40:40 +0000
Date:   Thu, 17 Mar 2022 15:40:36 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC PATCH 1/2] PCI/ACPI: Use CXL _OSC instead of PCIe _OSC
Message-ID: <20220317154036.00000686@Huawei.com>
In-Reply-To: <CAPcyv4h581oXv59Praskpyk6ywPBm1ksxT4YPvZiv80F6ugZnw@mail.gmail.com>
References: <20220317002704.1835870-1-vishal.l.verma@intel.com>
        <20220317002704.1835870-2-vishal.l.verma@intel.com>
        <CAPcyv4h581oXv59Praskpyk6ywPBm1ksxT4YPvZiv80F6ugZnw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.67.100]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 16 Mar 2022 18:47:11 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Wed, Mar 16, 2022 at 5:27 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
> >
> > From: Dan Williams <dan.j.williams@intel.com>
> >
> > In preparation for negotiating OS control of CXL _OSC features, do the
> > minimal enabling to use CXL _OSC to handle the base PCIe feature
> > negotiation. Recall that CXL _OSC is a super-set of PCIe _OSC and the
> > CXL 2.0 specification mandates: "If a CXL Host Bridge device exposes CXL
> > _OSC, CXL aware OSPM shall evaluate CXL _OSC and not evaluate PCIe
> > _OSC."
> >
> > A new ->cxl_osc_disable attribute is added for cases where platform
> > firmware publishes ACPI0016, but does not also publish CXL _OSC.  
> 
> It's been a couple weeks since I wrote this... looking at it now I
> would rewrite this to:
> 
> Rather than pass a boolean flag alongside @root to all the helper
> functions that need to consider PCIe specifics, add is_pcie() and
> is_cxl() helper functions to check the flavor of @root. This also
> allows for dynamic fallback to PCIe _OSC in cases where an attempt to
> use CXL _OXC fails. This can happen on CXL 1.1 platforms that publish
> ACPI0016 devices to indicate CXL host bridges, but do not publish the
> optional CXL _OSC method. CXL _OSC is mandatory for CXL 2.0 hosts.
> 
> >
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Robert Moore <robert.moore@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> 
> Always include your own sign-off when forwarding a patch.
> 
Subject to Dan's rewording above, this looks good to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> > ---
> >  include/acpi/acpi_bus.h |  1 +
> >  drivers/acpi/pci_root.c | 62 +++++++++++++++++++++++++++++++----------
> >  2 files changed, 48 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index ca88c4706f2b..768ef1584055 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -585,6 +585,7 @@ struct acpi_pci_root {
> >         struct acpi_device * device;
> >         struct pci_bus *bus;
> >         u16 segment;
> > +       bool cxl_osc_disable;
> >         struct resource secondary;      /* downstream bus range */
> >
> >         u32 osc_support_set;    /* _OSC state of support bits */
> > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > index b76db99cced3..2d834504096b 100644
> > --- a/drivers/acpi/pci_root.c
> > +++ b/drivers/acpi/pci_root.c
> > @@ -170,20 +170,47 @@ static void decode_osc_control(struct acpi_pci_root *root, char *msg, u32 word)
> >                         ARRAY_SIZE(pci_osc_control_bit));
> >  }
> >
> > -static u8 pci_osc_uuid_str[] = "33DB4D5B-1FF7-401C-9657-7441C03DD766";
> > +static bool is_pcie(struct acpi_pci_root *root)
> > +{
> > +       return strcmp(acpi_device_hid(root->device), "PNP0A08") == 0;
> > +}
> >
> > -static acpi_status acpi_pci_run_osc(acpi_handle handle,
> > +static bool is_cxl(struct acpi_pci_root *root)
> > +{
> > +       if (root->cxl_osc_disable)
> > +               return false;
> > +       return strcmp(acpi_device_hid(root->device), "ACPI0016") == 0;
> > +}
> > +
> > +static u8 pci_osc_uuid_str[] = "33DB4D5B-1FF7-401C-9657-7441C03DD766";
> > +static u8 cxl_osc_uuid_str[] = "68F2D50B-C469-4d8A-BD3D-941A103FD3FC";
> > +
> > +static char *to_uuid(struct acpi_pci_root *root)
> > +{
> > +       if (is_cxl(root))
> > +               return cxl_osc_uuid_str;
> > +       return pci_osc_uuid_str;
> > +}
> > +
> > +static int cap_length(struct acpi_pci_root *root)
> > +{
> > +       if (is_cxl(root))
> > +               return sizeof(u32) * 6;
> > +       return sizeof(u32) * 3;
> > +}
> > +
> > +static acpi_status acpi_pci_run_osc(struct acpi_pci_root *root,
> >                                     const u32 *capbuf, u32 *retval)
> >  {
> >         struct acpi_osc_context context = {
> > -               .uuid_str = pci_osc_uuid_str,
> > +               .uuid_str = to_uuid(root),
> >                 .rev = 1,
> > -               .cap.length = 12,
> > +               .cap.length = cap_length(root),
> >                 .cap.pointer = (void *)capbuf,
> >         };
> >         acpi_status status;
> >
> > -       status = acpi_run_osc(handle, &context);
> > +       status = acpi_run_osc(root->device->handle, &context);
> >         if (ACPI_SUCCESS(status)) {
> >                 *retval = *((u32 *)(context.ret.pointer + 8));
> >                 kfree(context.ret.pointer);
> > @@ -196,7 +223,7 @@ static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
> >                                         u32 *control)
> >  {
> >         acpi_status status;
> > -       u32 result, capbuf[3];
> > +       u32 result, capbuf[6];
> >
> >         support |= root->osc_support_set;
> >
> > @@ -204,10 +231,18 @@ static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
> >         capbuf[OSC_SUPPORT_DWORD] = support;
> >         capbuf[OSC_CONTROL_DWORD] = *control | root->osc_control_set;
> >
> > -       status = acpi_pci_run_osc(root->device->handle, capbuf, &result);
> > +retry:
> > +       status = acpi_pci_run_osc(root, capbuf, &result);
> >         if (ACPI_SUCCESS(status)) {
> >                 root->osc_support_set = support;
> >                 *control = result;
> > +       } else if (is_cxl(root)) {
> > +               /*
> > +                * CXL _OSC is optional on CXL 1.1 hosts. Fall back to PCIe _OSC
> > +                * upon any failure using CXL _OSC.
> > +                */
> > +               root->cxl_osc_disable = true;
> > +               goto retry;
> >         }
> >         return status;
> >  }
> > @@ -338,7 +373,7 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 s
> >         u32 req = OSC_PCI_EXPRESS_CAPABILITY_CONTROL;
> >         struct acpi_pci_root *root;
> >         acpi_status status;
> > -       u32 ctrl, capbuf[3];
> > +       u32 ctrl, capbuf[6];
> >
> >         if (!mask)
> >                 return AE_BAD_PARAMETER;
> > @@ -375,7 +410,7 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 s
> >         capbuf[OSC_QUERY_DWORD] = 0;
> >         capbuf[OSC_SUPPORT_DWORD] = root->osc_support_set;
> >         capbuf[OSC_CONTROL_DWORD] = ctrl;
> > -       status = acpi_pci_run_osc(handle, capbuf, mask);
> > +       status = acpi_pci_run_osc(root, capbuf, mask);
> >         if (ACPI_FAILURE(status))
> >                 return status;
> >
> > @@ -454,8 +489,7 @@ static bool os_control_query_checks(struct acpi_pci_root *root, u32 support)
> >         return true;
> >  }
> >
> > -static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
> > -                                bool is_pcie)
> > +static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
> >  {
> >         u32 support, control = 0, requested = 0;
> >         acpi_status status;
> > @@ -506,7 +540,7 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
> >                 *no_aspm = 1;
> >
> >                 /* _OSC is optional for PCI host bridges */
> > -               if ((status == AE_NOT_FOUND) && !is_pcie)
> > +               if ((status == AE_NOT_FOUND) && !is_pcie(root))
> >                         return;
> >
> >                 if (control) {
> > @@ -529,7 +563,6 @@ static int acpi_pci_root_add(struct acpi_device *device,
> >         acpi_handle handle = device->handle;
> >         int no_aspm = 0;
> >         bool hotadd = system_state == SYSTEM_RUNNING;
> > -       bool is_pcie;
> >
> >         root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
> >         if (!root)
> > @@ -587,8 +620,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
> >
> >         root->mcfg_addr = acpi_pci_root_get_mcfg_addr(handle);
> >
> > -       is_pcie = strcmp(acpi_device_hid(device), "PNP0A08") == 0;
> > -       negotiate_os_control(root, &no_aspm, is_pcie);
> > +       negotiate_os_control(root, &no_aspm);
> >
> >         /*
> >          * TBD: Need PCI interface for enumeration/configuration of roots.
> > --
> > 2.35.1
> >  

