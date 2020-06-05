Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3479A1EFF66
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jun 2020 19:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgFERvk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jun 2020 13:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgFERvk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jun 2020 13:51:40 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348FCC08C5C2
        for <linux-acpi@vger.kernel.org>; Fri,  5 Jun 2020 10:51:40 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i12so2978292pju.3
        for <linux-acpi@vger.kernel.org>; Fri, 05 Jun 2020 10:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Elb/K3NbcNegpVMuNaXJOed2nsIqtHUVF+aE4EBGdX4=;
        b=cyE96yzwPDHVFbSsT4aZw5PP7inmvIcaqp2nz+vxN1Qk4NtEz/SigXV/63qONuIY4J
         vbG+klLGqhYzbnI6YcOgD/ScTrjUIdkFdbB72EHxjJX1ygWoZiSZxU/iFVEfzZe1QQhB
         GLHY0xkN5sCyhZ6FaFsduEBmeQRy5nqRSfZj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Elb/K3NbcNegpVMuNaXJOed2nsIqtHUVF+aE4EBGdX4=;
        b=Lq6qDwYFYCbNLiFo831mVMxBAu95p9yVCKmrhapAEKs76dixD71oF7oLGltCbdatLH
         bUr7Vlcb3prdua+7/Q8Cn+uwCca+D13ojSsTlVrgg03aOcmM8/TNngNb5XnYkhwQoFN1
         +01oSH/nvE8vL9dLU3BUTg+0AS7parMmfH+N4pc8iRm/QsLL4spr75zgfO/vTA13kzda
         S+SZMeNk3sRV0/6OjkE9PfUSCeSNX+gb963TaNqaG2Y3qaYSx832yxe4awUmlms7o+Bm
         QBaR/CrFoZn1ZqzLWHiTEUk/Uo6dIMM2Z+XAWeHraVH1VwWEIPkXNJUTLVGybpi9fjiO
         42dw==
X-Gm-Message-State: AOAM5320nK2R5x2Z6SxbqHSNNuqS+YlqCNt8mMbieJAJI5lxAAOKyLjh
        oGEbHH6ed1cHMVBNZk88DLyNzA==
X-Google-Smtp-Source: ABdhPJzrtx43z/k6ys23I9kfo7v5ymkHJ9HRqI32HkBP+x5vnnwzrH20sVJt1WPzaLfHhsYAR2KY9g==
X-Received: by 2002:a17:902:ac97:: with SMTP id h23mr11213337plr.64.1591379499793;
        Fri, 05 Jun 2020 10:51:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 205sm205444pfc.206.2020.06.05.10.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 10:51:38 -0700 (PDT)
Date:   Fri, 5 Jun 2020 10:51:37 -0700
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
Message-ID: <202006051051.CC0F12EA@keescook>
References: <202006041054.874AA564@keescook>
 <cb0cdaaa-7825-0b87-0384-db22329305bb@suse.cz>
 <34455dce-6675-1fc2-8d61-45bf56f3f554@suse.cz>
 <6b2b149e-c2bc-f87a-ea2c-3046c5e39bf9@oracle.com>
 <faea2c18-edbe-f8b4-b171-6be866624856@oracle.com>
 <CAJZ5v0jqmUmf7mv3wjniVM-YqPqhDSjxunU0E4VYCsUQqvrF_Q@mail.gmail.com>
 <ce333dcb-2b2c-3e1f-2a7e-02a7819b1db4@suse.cz>
 <894e8cee-33df-1f63-fb12-72dceb024ea7@oracle.com>
 <202006050828.F85A75D13@keescook>
 <2055681b-35cf-1ca6-00d1-c47868bbf28d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2055681b-35cf-1ca6-00d1-c47868bbf28d@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 05, 2020 at 06:37:55PM +0200, Vegard Nossum wrote:
> On 2020-06-05 17:44, Kees Cook wrote:
> > On Fri, Jun 05, 2020 at 04:44:51PM +0200, Vegard Nossum wrote:
> > > That's it :-) This fixes it for me:
> > > 
> > > diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
> > > index 2566e2d4c7803..b76bbab917941 100644
> > > --- a/drivers/acpi/acpica/nsaccess.c
> > > +++ b/drivers/acpi/acpica/nsaccess.c
> > > @@ -98,14 +98,12 @@ acpi_status acpi_ns_root_initialize(void)
> > >                   * predefined names are at the root level. It is much easier
> > > to
> > >                   * just create and link the new node(s) here.
> > >                   */
> > > -               new_node =
> > > -                   ACPI_ALLOCATE_ZEROED(sizeof(struct
> > > acpi_namespace_node));
> > > +               new_node = acpi_ns_create_node(*ACPI_CAST_PTR (u32,
> > > init_val->name));
> > >                  if (!new_node) {
> > >                          status = AE_NO_MEMORY;
> > >                          goto unlock_and_exit;
> > >                  }
> > > 
> > > -               ACPI_COPY_NAMESEG(new_node->name.ascii, init_val->name);
> > >                  new_node->descriptor_type = ACPI_DESC_TYPE_NAMED;
> > >                  new_node->type = init_val->type;
> > 
> > I'm a bit confused by the internals of acpi_ns_create_note(). It can still
> > end up calling ACPI_ALLOCATE_ZEROED() via acpi_os_acquire_object(). Is
> > this fix correct?
> > 
> 
> include/acpi/platform/aclinuxex.h:static inline void
> *acpi_os_acquire_object(acpi_cache_t * cache)
> include/acpi/platform/aclinuxex.h-{
> include/acpi/platform/aclinuxex.h-      return kmem_cache_zalloc(cache,
> include/acpi/platform/aclinuxex.h- irqs_disabled()? GFP_ATOMIC :
> GFP_KERNEL);
> include/acpi/platform/aclinuxex.h-}
> 
> No comment.

ah! Thanks. I was looking at drivers/acpi/acpica/utcache.c

-- 
Kees Cook
