Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8CE45605E
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 17:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbhKRQYb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 11:24:31 -0500
Received: from mga07.intel.com ([134.134.136.100]:38411 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231667AbhKRQYb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 18 Nov 2021 11:24:31 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="297637333"
X-IronPort-AV: E=Sophos;i="5.87,245,1631602800"; 
   d="scan'208";a="297637333"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 08:12:14 -0800
X-IronPort-AV: E=Sophos;i="5.87,245,1631602800"; 
   d="scan'208";a="507497104"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.186])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 08:12:12 -0800
Date:   Fri, 19 Nov 2021 00:11:20 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 1/4] efi: Introduce
 EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER and corresponding structures
Message-ID: <20211118161120.GA884221@chenyu-desktop>
References: <cover.1635953446.git.yu.c.chen@intel.com>
 <68d1c452bbf7f742793cb39ebb66f6b4ba6a3fb3.1635953446.git.yu.c.chen@intel.com>
 <CAJZ5v0gKu3JtCGThZKx87rQJeW+xK=ZkSD47kaP+N8Qr8Pq-Tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gKu3JtCGThZKx87rQJeW+xK=ZkSD47kaP+N8Qr8Pq-Tw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,
On Thu, Nov 18, 2021 at 04:49:35PM +0100, Rafael J. Wysocki wrote:
> On Wed, Nov 3, 2021 at 4:44 PM Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > Platform Firmware Runtime Update image starts with UEFI headers, and the
> > headers are defined in UEFI specification, but some of them have not been
> > defined in the kernel yet.
> >
> > For example, the header layout of a capsule file looks like this:
> >
> > EFI_CAPSULE_HEADER
> > EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER
> > EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER
> > EFI_FIRMWARE_IMAGE_AUTHENTICATION
> >
> > These structures would be used by the Platform Firmware Runtime Update
> > driver to parse the format of capsule file to verify if the corresponding
> > version number is valid.
> 
> Why does the driver need to do that?
> 
> The firmware will reject the update if the version is invalid anyway, won't it?
> 
Yes, the firmware will reject the update if the version does not match. The motivation
of checking it in kernel before the firmware is mainly to deal with a corner case that,
if the user provides an invalid capsule image, the kernel could be used as a guard to
reject it, without switching to the MM update mode(which might be costly).
> > The EFI_CAPSULE_HEADER has been defined in the
> > kernel, however the rest are not, thus introduce corresponding UEFI
> > structures accordingly.
> 
> I would change the above in the following way:
> 
> "EFI_CAPSULE_HEADER has been defined in the kernel, but the other
> structures have not been defined yet, so do that."
>
Ok, will do. 
> > Besides, EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER
> > and EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER are required to be packed
> > in the uefi specification.
> 
> > Ard has pointed out that, the __packed
> > attribute does indicate to the compiler that the entire thing can appear
> > misaligned in memory. So if one follows the other in the capsule header,
> > the __packed attribute may be appropriate to ensure that the second one
> > is not accessed using misaligned loads and stores.
> 
> "For this reason, use the __packed attribute to indicate to the
> compiler that the entire structure can appear misaligned in memory (as
> suggested by Ard) in case one of them follows the other directly in a
> capsule header."
> 
Ok, will do.
> >
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> > v8: Use efi_guid_t instead of guid_t. (Andy Shevchenko)
> > v7: Use __packed instead of pragma pack(1). (Greg Kroah-Hartman, Ard Biesheuve)
> > v6: No change since v5.
> > v5: No change since v4.
> > v4: Revise the commit log to make it more clear. (Rafael J. Wysocki)
> > ---
> >  include/linux/efi.h | 46 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >
> > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > index 6b5d36babfcc..1ec73c5ab6c9 100644
> > --- a/include/linux/efi.h
> > +++ b/include/linux/efi.h
> > @@ -148,6 +148,52 @@ typedef struct {
> >         u32 imagesize;
> >  } efi_capsule_header_t;
> >
> > +/* EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER */
> > +struct efi_manage_capsule_header {
> > +       u32 ver;
> > +       u16 emb_drv_cnt;
> > +       u16 payload_cnt;
> > +       /*
> > +        * Variable array indicated by number of
> > +        * (emb_drv_cnt + payload_cnt)
> 
> * Variable-size array of the size given by the sum of
> * emb_drv_cnt and payload_cnt.
> 
Ok, will change it.
> > +        */
> > +       u64 offset_list[];
> > +} __packed;
> > +
> > +/* EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER */
> > +struct efi_manage_capsule_image_header {
> > +       u32 ver;
> > +       efi_guid_t image_type_id;
> > +       u8 image_index;
> > +       u8 reserved_bytes[3];
> > +       u32 image_size;
> > +       u32 vendor_code_size;
> > +       /* ver = 2. */
> 
> What does this mean?
> 
> > +       u64 hw_ins;
> > +       /* ver = v3. */
> 
> And same here?
> 
The hw_ins was introduced in version 2, and capsule_support
was introduced in version 3 of the capsule image format.
I'll revise the comment in next version.
> > +       u64 capsule_support;
> > +} __packed;
> > +
> > +/* WIN_CERTIFICATE */
> > +struct win_cert {
> > +       u32 len;
> > +       u16 rev;
> > +       u16 cert_type;
> > +};
> > +
> > +/* WIN_CERTIFICATE_UEFI_GUID */
> > +struct win_cert_uefi_guid {
> > +       struct win_cert hdr;
> > +       efi_guid_t cert_type;
> > +       u8 cert_data[];
> > +};
> > +
> > +/* EFI_FIRMWARE_IMAGE_AUTHENTICATIO */
> 
> The "N" character at the end is missing.
> 
Ok, will fix it.

thanks,
Chenyu
