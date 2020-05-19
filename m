Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF111DA4E9
	for <lists+linux-acpi@lfdr.de>; Wed, 20 May 2020 00:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgESWqM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 May 2020 18:46:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgESWqM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 May 2020 18:46:12 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85816205CB;
        Tue, 19 May 2020 22:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589928371;
        bh=a9pqT8KJ66g+xF2tnOt7wMSRGCEp8vB8fOPKZwpRaVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EPG/ZSzfIp2yIfDN90ZfsHWqbGYNwNiCwwVJwXmKzd8ZLcklpx5SQX/YHT08t3zl9
         ZZrv1TACOd92zdHPKrFhl4qr4WQF0qLV7HMuqr1rFqORmBSwdaMVCF6taJMwujkUTX
         q+rSss0/3OaOda+I9cIcvTWl2DDFBpJmXupbzlqM=
Date:   Tue, 19 May 2020 17:50:58 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] ACPICA: Replace one-element array and use struct_size()
 helper
Message-ID: <20200519225058.GA14138@embeddedor>
References: <20200518222722.GA7791@embeddedor>
 <CAJZ5v0goZpvRQ6du214FqvFNQnqZHR9-kz=WhEgRsMJ3Zx0WiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0goZpvRQ6du214FqvFNQnqZHR9-kz=WhEgRsMJ3Zx0WiQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 19, 2020 at 12:25:13PM +0200, Rafael J. Wysocki wrote:
> On Tue, May 19, 2020 at 12:22 AM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
> >
> > The current codebase makes use of one-element arrays in the following
> > form:
> >
> > struct something {
> >     int length;
> >     u8 data[1];
> > };
> >
> > struct something *instance;
> >
> > instance = kmalloc(sizeof(*instance) + size, GFP_KERNEL);
> > instance->length = size;
> > memcpy(instance->data, source, size);
> >
> > but the preferred mechanism to declare variable-length types such as
> > these ones is a flexible array member[1][2], introduced in C99:
> >
> > struct foo {
> >         int stuff;
> >         struct boo array[];
> > };
> >
> > By making use of the mechanism above, we will get a compiler warning
> > in case the flexible array does not occur last in the structure, which
> > will help us prevent some kind of undefined behavior bugs from being
> > inadvertently introduced[3] to the codebase from now on.
> 
> However, the ACPICA code in the kernel comes from an external project
> and changes of this type are generally not applicable to it unless
> accepted upstream.

Hi Rafael,

By _accepted upstream_, in this case, you mean the adoption of the
flexible-arrays in the whole codebase, first?  If this is the case
notice that there are hundreds of these flexible-array conversions
in mainline, already:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=grep&q=flexible-array

Is this what you mean?

Thanks
--
Gustavo

> 
> I'll let Erik and Bob take over.
> 
> > Also, make use of the new struct_size() helper to properly calculate the
> > size of struct acpi_pnp_device_id_list.
> >
> > This issue was found with the help of Coccinellea and, audited and
> > fixed _manually_.
> >
> > [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> > [2] https://github.com/KSPP/linux/issues/21
> > [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  drivers/acpi/acpica/utids.c | 4 +---
> >  include/acpi/actypes.h      | 2 +-
> >  2 files changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/acpi/acpica/utids.c b/drivers/acpi/acpica/utids.c
> > index 3bb06935a2ad3..c2f819a39424a 100644
> > --- a/drivers/acpi/acpica/utids.c
> > +++ b/drivers/acpi/acpica/utids.c
> > @@ -262,9 +262,7 @@ acpi_ut_execute_CID(struct acpi_namespace_node *device_node,
> >          * 2) Size of the CID PNP_DEVICE_ID array +
> >          * 3) Size of the actual CID strings
> >          */
> > -       cid_list_size = sizeof(struct acpi_pnp_device_id_list) +
> > -           ((count - 1) * sizeof(struct acpi_pnp_device_id)) +
> > -           string_area_size;
> > +       cid_list_size = struct_size(cid_list, ids, count) + string_area_size;
> >
> >         cid_list = ACPI_ALLOCATE_ZEROED(cid_list_size);
> >         if (!cid_list) {
> > diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
> > index 4defed58ea338..c7bcda0ad366a 100644
> > --- a/include/acpi/actypes.h
> > +++ b/include/acpi/actypes.h
> > @@ -1145,7 +1145,7 @@ struct acpi_pnp_device_id {
> >  struct acpi_pnp_device_id_list {
> >         u32 count;              /* Number of IDs in Ids array */
> >         u32 list_size;          /* Size of list, including ID strings */
> > -       struct acpi_pnp_device_id ids[1];       /* ID array */
> > +       struct acpi_pnp_device_id ids[];        /* ID array */
> >  };
> >
> >  /*
> > --
> > 2.26.2
> >
