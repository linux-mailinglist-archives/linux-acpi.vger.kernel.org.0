Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356A443969D
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Oct 2021 14:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbhJYMth (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Oct 2021 08:49:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:2075 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232474AbhJYMth (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Oct 2021 08:49:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="229500905"
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="229500905"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 05:47:15 -0700
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="485661923"
Received: from yifanyao-mobl.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.249.171.31])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 05:47:11 -0700
Date:   Mon, 25 Oct 2021 20:47:05 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/4] efi: Introduce
 EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER and corresponding structures
Message-ID: <20211025124705.GA9212@chenyu5-mobl1>
References: <cover.1635140590.git.yu.c.chen@intel.com>
 <1cd3161bf51de99990fd5ee2dc896b4defef4f38.1635140590.git.yu.c.chen@intel.com>
 <YXZSMCaODRPw0Zlj@kroah.com>
 <20211025114519.GA7559@chenyu5-mobl1>
 <YXac0IYICzIOmeRh@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXac0IYICzIOmeRh@kroah.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 25, 2021 at 02:02:24PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Oct 25, 2021 at 07:45:19PM +0800, Chen Yu wrote:
> > On Mon, Oct 25, 2021 at 08:44:00AM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Oct 25, 2021 at 02:25:04PM +0800, Chen Yu wrote:
> > > > Platform Firmware Runtime Update image starts with UEFI headers, and the
> > > > headers are defined in UEFI specification, but some of them have not been
> > > > defined in the kernel yet.
> > > > 
> > > > For example, the header layout of a capsule file looks like this:
> > > > 
> > > > EFI_CAPSULE_HEADER
> > > > EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER
> > > > EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER
> > > > EFI_FIRMWARE_IMAGE_AUTHENTICATION
> > > > 
> > > > These structures would be used by the Platform Firmware Runtime Update
> > > > driver to parse the format of capsule file to verify if the corresponding
> > > > version number is valid. The EFI_CAPSULE_HEADER has been defined in the
> > > > kernel, however the rest are not, thus introduce corresponding UEFI
> > > > structures accordingly. Besides, EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER
> > > > and EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER need not be aligned and
> > > > so the corresponding data types should be packed.
> > > > 
> > > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > > ---
> > > > v6: No change since v5.
> > > > v5: No change since v4.
> > > > v4: Revise the commit log to make it more clear. (Rafael J. Wysocki) 
> > > > ---
> > > >  include/linux/efi.h | 50 +++++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 50 insertions(+)
> > > > 
> > > > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > > > index 6b5d36babfcc..19ff834e1388 100644
> > > > --- a/include/linux/efi.h
> > > > +++ b/include/linux/efi.h
> > > > @@ -148,6 +148,56 @@ typedef struct {
> > > >  	u32 imagesize;
> > > >  } efi_capsule_header_t;
> > > >  
> > > > +#pragma pack(1)
> > > 
> > > Why is this pragma suddenly needed now in this file?
> > > 
> > > If you really need this for a specific structure, use the "__packed"
> > > attribute please.
> > >
> > These two structures are required to be packed in the uefi spec, I'll change
> > them to "__packed".
> 
> And they are the _only_ ones in this .h file that require this?  I would
> think that they all require this.
>
I did a search in the uefi specification, and found 42 pack(1) structures,
while the other structures do not have pack(1) attribute.

It seems to me that whether the structures are required to be strictly packed
depends on the use case. Here's my understanding and I might be wrong: In this
patch, according to the skeleton of capsule file described in
[Figure 23-6 Firmware Management and Firmware Image Management headers]
in the uefi spec [1], the two structures are located at the beginning of
the capsule file, and followed by real payload. If these structure are packed
then the the adjacent binary payload could start on byte boundary without
padding, which might save space for capsule file.

For those structures that do not have strict pack requirement, the uefi spec
does not force to pack them.

Link: https://uefi.org/sites/default/files/resources/UEFI_Spec_2_9_2021_03_18.pdf # [1]

thanks,
Chenyu

 
> thanks,
> 
> greg k-h
