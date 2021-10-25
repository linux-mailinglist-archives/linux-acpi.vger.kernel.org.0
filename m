Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81F743973F
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Oct 2021 15:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbhJYNOb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Oct 2021 09:14:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233371AbhJYNOb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Oct 2021 09:14:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 233F9601FA;
        Mon, 25 Oct 2021 13:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635167529;
        bh=/OnURZEJ7wts6w/3Qdts+/dkEpA+4/DrN1zIZXZY8S8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JswxGSFuC+gqwwPbsTgdSA8sAzoI3ajjbzLRbr6B3Ksea6DSD2afYRsLBJi8M5KGo
         fYBSf9ZphnInaEcPhgmYnhbgOPc7Hw6L8V9tVcR+GifxTtUc+eEk4hoONRLaYekxtm
         +3q7jivqhbG8Rzvg5pF4HYDIxQhxHJj2J4phzyU+wkm6tBAIQa2WGf61Ubx9HgtHOB
         87ec06gEr6msZ418TgcRn0UZuzkRsCJ/gqXEwaQEWU1raifxVnS+uKY4VvOkdOWlMq
         1XvZJmk8n6iU31PYHl9emO5UcD+ekkdN1gIecuwEVC0yxu/2+Hb3+R+kXtTxhzXu1U
         J5oE13bhfPL/A==
Received: by mail-ot1-f47.google.com with SMTP id b4-20020a9d7544000000b00552ab826e3aso14885563otl.4;
        Mon, 25 Oct 2021 06:12:09 -0700 (PDT)
X-Gm-Message-State: AOAM530kb1go6foCy5wztZ/+iYXdZo7Kib2y8mfRevP5fTy8RLs8RG3W
        kvYVp+cIuh7KkHI+3N+mjSviDLpIZ7BeKLF5O7o=
X-Google-Smtp-Source: ABdhPJyNyqweANOfqAfuDkrHzy36CK1fQiv7MCaQLpXfd3uAKpbGji9uo1EtLhugmRPoQR+x+eNIGCe52lTKkywkE40=
X-Received: by 2002:a9d:5911:: with SMTP id t17mr13904890oth.30.1635167528453;
 Mon, 25 Oct 2021 06:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1635140590.git.yu.c.chen@intel.com> <1cd3161bf51de99990fd5ee2dc896b4defef4f38.1635140590.git.yu.c.chen@intel.com>
 <YXZSMCaODRPw0Zlj@kroah.com> <20211025114519.GA7559@chenyu5-mobl1>
 <YXac0IYICzIOmeRh@kroah.com> <20211025124705.GA9212@chenyu5-mobl1>
In-Reply-To: <20211025124705.GA9212@chenyu5-mobl1>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 25 Oct 2021 15:11:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG-L5D3WpGRg20xSuCUkqJrXGLJsffOPE4M1OrFcEf2eQ@mail.gmail.com>
Message-ID: <CAMj1kXG-L5D3WpGRg20xSuCUkqJrXGLJsffOPE4M1OrFcEf2eQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] efi: Introduce EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER
 and corresponding structures
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 25 Oct 2021 at 14:47, Chen Yu <yu.c.chen@intel.com> wrote:
>
> On Mon, Oct 25, 2021 at 02:02:24PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Oct 25, 2021 at 07:45:19PM +0800, Chen Yu wrote:
> > > On Mon, Oct 25, 2021 at 08:44:00AM +0200, Greg Kroah-Hartman wrote:
> > > > On Mon, Oct 25, 2021 at 02:25:04PM +0800, Chen Yu wrote:
> > > > > Platform Firmware Runtime Update image starts with UEFI headers, and the
> > > > > headers are defined in UEFI specification, but some of them have not been
> > > > > defined in the kernel yet.
> > > > >
> > > > > For example, the header layout of a capsule file looks like this:
> > > > >
> > > > > EFI_CAPSULE_HEADER
> > > > > EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER
> > > > > EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER
> > > > > EFI_FIRMWARE_IMAGE_AUTHENTICATION
> > > > >
> > > > > These structures would be used by the Platform Firmware Runtime Update
> > > > > driver to parse the format of capsule file to verify if the corresponding
> > > > > version number is valid. The EFI_CAPSULE_HEADER has been defined in the
> > > > > kernel, however the rest are not, thus introduce corresponding UEFI
> > > > > structures accordingly. Besides, EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER
> > > > > and EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER need not be aligned and
> > > > > so the corresponding data types should be packed.
> > > > >
> > > > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > > > ---
> > > > > v6: No change since v5.
> > > > > v5: No change since v4.
> > > > > v4: Revise the commit log to make it more clear. (Rafael J. Wysocki)
> > > > > ---
> > > > >  include/linux/efi.h | 50 +++++++++++++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 50 insertions(+)
> > > > >
> > > > > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > > > > index 6b5d36babfcc..19ff834e1388 100644
> > > > > --- a/include/linux/efi.h
> > > > > +++ b/include/linux/efi.h
> > > > > @@ -148,6 +148,56 @@ typedef struct {
> > > > >         u32 imagesize;
> > > > >  } efi_capsule_header_t;
> > > > >
> > > > > +#pragma pack(1)
> > > >
> > > > Why is this pragma suddenly needed now in this file?
> > > >
> > > > If you really need this for a specific structure, use the "__packed"
> > > > attribute please.
> > > >
> > > These two structures are required to be packed in the uefi spec, I'll change
> > > them to "__packed".
> >
> > And they are the _only_ ones in this .h file that require this?  I would
> > think that they all require this.
> >
> I did a search in the uefi specification, and found 42 pack(1) structures,
> while the other structures do not have pack(1) attribute.
>
> It seems to me that whether the structures are required to be strictly packed
> depends on the use case. Here's my understanding and I might be wrong: In this
> patch, according to the skeleton of capsule file described in
> [Figure 23-6 Firmware Management and Firmware Image Management headers]
> in the uefi spec [1], the two structures are located at the beginning of
> the capsule file, and followed by real payload. If these structure are packed
> then the the adjacent binary payload could start on byte boundary without
> padding, which might save space for capsule file.
>

Packing only affects internal padding, and a struct's size is never
padded to be a multiple of its alignment (which equals the largest
alignment of all its members). This of course assumes that you don't
abuse array indexing as a sizeof() operator.

However, the __packed attribute does indicate to the compiler that the
entire thing can appear misaligned in memory. So if one follows the
other in the capsule header, the __packed attribute may be appropriate
to ensure that the second one is not accessed using misaligned loads
and stores.

And then there is of course the ambiguity in alignment of uint64_t on
x86, which could be either 4 or 8 bytes depending on the context (and
UEFI targets all of them). So __packed may be used to disambiguate
between those if a uint64_t field appears on a boundary whose offset %
8 == 4.

So please use __packed rather than the pragma(), and apply it wherever
it is applied in the spec.



> For those structures that do not have strict pack requirement, the uefi spec
> does not force to pack them.
>
> Link: https://uefi.org/sites/default/files/resources/UEFI_Spec_2_9_2021_03_18.pdf # [1]
>
> thanks,
> Chenyu
>
>
> > thanks,
> >
> > greg k-h
