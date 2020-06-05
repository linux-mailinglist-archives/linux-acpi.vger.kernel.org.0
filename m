Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AF31EFCDD
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jun 2020 17:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgFEPoM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jun 2020 11:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgFEPoL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jun 2020 11:44:11 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EEAC08C5C2
        for <linux-acpi@vger.kernel.org>; Fri,  5 Jun 2020 08:44:11 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s88so2888419pjb.5
        for <linux-acpi@vger.kernel.org>; Fri, 05 Jun 2020 08:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1mULMROuThJEJ5mn2BpH3TCtjO6X9vn9NXYKq1SVXCQ=;
        b=NikDzLOKEbkdHl/a+qsn72HQQdgG4lUWew7gJeKOem2r+jk/zX/zfvHnv0NNmhzFm7
         zYt45PiWRzHSua6gEBvhxICbkJ5xlf/RiDfUJZz+Pg7FKaHqMzUC7gOAd2VZzDeTZ/8/
         QO+Gu1UWhZuFTFXNwtbOJqb0F1nglhXU1rzYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1mULMROuThJEJ5mn2BpH3TCtjO6X9vn9NXYKq1SVXCQ=;
        b=DgbubSCAg82oOK6kWC/JCj1flG88+4Pr80PULNRTbUxL+ITkHqaE+K8y9D9P1++P5M
         USurygiIAamwMGkdus4ma8Yy95DYnQKC+toUpwz894g0vs7iMZenm+peijzWWMC8D/kG
         is1vx+Hu0iOMy9KwUsQU3eB8mhXqy9rkUd0sWE27O06CDGpKqf6tEh0jdKDsrbqsW6Bu
         iKZM44o38uzh1SjB2mA1X/sPdxhFV00bgRsoEYqUk3HJ3Bz1IutHvPO5otGPuKXni4Yl
         PyCRKdm7DJZNiZQtw2A5KWcnRGtsDiOSUNDniJMYMKgfIvtIgnFrFfTK2O6+IZiA628e
         KM0A==
X-Gm-Message-State: AOAM533xEqucQ1I6RESpyS6Fe0vXbKLMGwIFBw8FU5TFfur9alxuwOj8
        laEDFSzMuEQvxv0DyHQ+1MH47w==
X-Google-Smtp-Source: ABdhPJxCJZj6genPtMB0lpkEc5DOWzQaxfWZ3R8Dw3uF3dgSiNjDe0nqGoGObx9Tl6gZci9hQn2mJg==
X-Received: by 2002:a17:90a:f694:: with SMTP id cl20mr3815256pjb.141.1591371851304;
        Fri, 05 Jun 2020 08:44:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w190sm39003pfw.35.2020.06.05.08.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 08:44:09 -0700 (PDT)
Date:   Fri, 5 Jun 2020 08:44:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: slub freelist issue / BUG: unable to handle page fault for
 address: 000000003ffe0018
Message-ID: <202006050828.F85A75D13@keescook>
References: <7839183d-1c0b-da02-73a2-bf5e1e8b02b9@suse.cz>
 <94296941-1073-913c-2adb-bf2e41be9f0f@oracle.com>
 <202006041054.874AA564@keescook>
 <cb0cdaaa-7825-0b87-0384-db22329305bb@suse.cz>
 <34455dce-6675-1fc2-8d61-45bf56f3f554@suse.cz>
 <6b2b149e-c2bc-f87a-ea2c-3046c5e39bf9@oracle.com>
 <faea2c18-edbe-f8b4-b171-6be866624856@oracle.com>
 <CAJZ5v0jqmUmf7mv3wjniVM-YqPqhDSjxunU0E4VYCsUQqvrF_Q@mail.gmail.com>
 <ce333dcb-2b2c-3e1f-2a7e-02a7819b1db4@suse.cz>
 <894e8cee-33df-1f63-fb12-72dceb024ea7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <894e8cee-33df-1f63-fb12-72dceb024ea7@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 05, 2020 at 04:44:51PM +0200, Vegard Nossum wrote:
> On 2020-06-05 16:08, Vlastimil Babka wrote:
> > On 6/5/20 3:12 PM, Rafael J. Wysocki wrote:
> > > On Fri, Jun 5, 2020 at 2:48 PM Vegard Nossum <vegard.nossum@oracle.com> wrote:
> > > > 
> > > > On 2020-06-05 11:36, Vegard Nossum wrote:
> > > > > 
> > > > > On 2020-06-05 11:11, Vlastimil Babka wrote:
> > > > > > So, with Kees' patch reverted, booting with slub_debug=F (or even more
> > > > > > specific slub_debug=F,ftrace_event_field) also hits this bug below. I
> > > > > > wanted to bisect it, but v5.7 was also bad, and also v5.6. Didn't try
> > > > > > further in history. So it's not new at all, and likely very specific to
> > > > > > your config+QEMU? (and related to the ACPI error messages that precede
> > > > > > it?).
> > [...]
> > [    0.140408] ------------[ cut here ]------------
> > [    0.140837] cache_from_obj: Wrong slab cache. Acpi-Namespace but object is from kmalloc-64
> > [    0.141406] WARNING: CPU: 0 PID: 1 at mm/slab.h:524 kmem_cache_free+0x1d3/0x250

Ah yes! Good. I had improved this check recently too, and I was worried
the freelist pointer patch was somehow blocking it, but I see now that
the failing config didn't have CONFIG_SLAB_FREELIST_HARDENED=y. Once
SLAB_CONSISTENCY_CHECKS was enabled ("slub_debug=F"), it started
tripping. Whew.

I wonder if that entire test block should just be removed from
cache_from_obj():

        if (!memcg_kmem_enabled() &&
            !IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
            !unlikely(s->flags & SLAB_CONSISTENCY_CHECKS))
                return s;

and make this test unconditional? It's mostly only called during free(),
and shouldn't be too expensive to be made unconditional. Hmm.

> > And it seems ACPI is allocating an object via kmalloc() and then freeing it
> > via kmem_cache_free(<"Acpi-Namespace" kmem_cache>) which is wrong.
> > 
> > > ./scripts/faddr2line vmlinux 'acpi_ns_root_initialize+0xb6'
> > acpi_ns_root_initialize+0xb6/0x2d1:
> > kmalloc at include/linux/slab.h:555
> > (inlined by) kzalloc at include/linux/slab.h:669
> > (inlined by) acpi_os_allocate_zeroed at include/acpi/platform/aclinuxex.h:57
> > (inlined by) acpi_ns_root_initialize at drivers/acpi/acpica/nsaccess.c:102
> > 
> 
> That's it :-) This fixes it for me:
> 
> diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
> index 2566e2d4c7803..b76bbab917941 100644
> --- a/drivers/acpi/acpica/nsaccess.c
> +++ b/drivers/acpi/acpica/nsaccess.c
> @@ -98,14 +98,12 @@ acpi_status acpi_ns_root_initialize(void)
>                  * predefined names are at the root level. It is much easier
> to
>                  * just create and link the new node(s) here.
>                  */
> -               new_node =
> -                   ACPI_ALLOCATE_ZEROED(sizeof(struct
> acpi_namespace_node));
> +               new_node = acpi_ns_create_node(*ACPI_CAST_PTR (u32,
> init_val->name));
>                 if (!new_node) {
>                         status = AE_NO_MEMORY;
>                         goto unlock_and_exit;
>                 }
> 
> -               ACPI_COPY_NAMESEG(new_node->name.ascii, init_val->name);
>                 new_node->descriptor_type = ACPI_DESC_TYPE_NAMED;
>                 new_node->type = init_val->type;

I'm a bit confused by the internals of acpi_ns_create_note(). It can still
end up calling ACPI_ALLOCATE_ZEROED() via acpi_os_acquire_object(). Is
this fix correct?

-- 
Kees Cook
