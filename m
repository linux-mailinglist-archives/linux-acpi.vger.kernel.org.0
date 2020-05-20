Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0DF1DB87E
	for <lists+linux-acpi@lfdr.de>; Wed, 20 May 2020 17:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgETPky (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 May 2020 11:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgETPkx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 May 2020 11:40:53 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789D5C061A0F
        for <linux-acpi@vger.kernel.org>; Wed, 20 May 2020 08:40:52 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t16so1480190plo.7
        for <linux-acpi@vger.kernel.org>; Wed, 20 May 2020 08:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y1fs4yTARhwr8K0tG6MX4nh3naH0ZmYi8BIM1sTbmmk=;
        b=SnnX5IlL2jOGPBbhnW+zn3VrPPJKbMei2u1IT8e5MY6RbTas9TC1b4PG7IY7TPI+k2
         7/La7lh3gBjKXgJBAri9ts5V1YYXVmIsibUimG5DAxmGATbORH/0vE5AJeLxwF0lW5KC
         MPf3f5TCil0ArCReccwkMXQtx2FL7cVc1zuqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y1fs4yTARhwr8K0tG6MX4nh3naH0ZmYi8BIM1sTbmmk=;
        b=uRxDat1VvUeT8YmC3kVXoiEdbluvgFVwKrvhZ7FRUdA9OScBqYCKCaLpXMLLx+7xng
         JUCQAmJ7HTvRs1xZR0YkPKSyXa5zrSR4z7gUshZvshfDm7U6mzWMyj32B1vLdIRnfZAC
         SYob4DwPjQSXbpi7MGqsn3tZViMXvYkC9H67XpkWnDBSdg8GmQOb8gtUOeGZm1cZ+4FS
         KfebkUOgRvLwnMpghYgWOvGc38TcAqYBdZAfdykLyah6CPMKmG9lNEx8EN8KEHnNp5v4
         4UrUitIVqSdKqMDWjn2P2BeS4rm7xuvmwrjNCUQzpNZ/nUcHk1ORRr0oqafOxi38tbnM
         1SGA==
X-Gm-Message-State: AOAM53277XYf2jbcKkGk9gDVQZBWuV4NhyNPOnTSICuZJfl1GJe5ZSa3
        757NYUlB8iD/VnUpySCvbIz9QA==
X-Google-Smtp-Source: ABdhPJzUqLMoA1/x9EhQmhBk3k0L04+X2IjM0ZTqDWwb1s9RjOQf58DhCfsuP/AQ/DQfC6ncpfnROg==
X-Received: by 2002:a17:90a:e54c:: with SMTP id ei12mr5800259pjb.129.1589989251909;
        Wed, 20 May 2020 08:40:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p30sm2063906pgn.58.2020.05.20.08.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 08:40:50 -0700 (PDT)
Date:   Wed, 20 May 2020 08:40:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] ACPICA: Replace one-element array and use struct_size()
 helper
Message-ID: <202005200831.41DA095B2@keescook>
References: <20200518222722.GA7791@embeddedor>
 <CAJZ5v0goZpvRQ6du214FqvFNQnqZHR9-kz=WhEgRsMJ3Zx0WiQ@mail.gmail.com>
 <20200519225058.GA14138@embeddedor>
 <CAJZ5v0jg9HoE2KEm45hxKNB1g61DzCn-GWH74w1goeHH3AKRaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jg9HoE2KEm45hxKNB1g61DzCn-GWH74w1goeHH3AKRaA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 20, 2020 at 11:15:18AM +0200, Rafael J. Wysocki wrote:
> On Wed, May 20, 2020 at 12:46 AM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
> >
> > On Tue, May 19, 2020 at 12:25:13PM +0200, Rafael J. Wysocki wrote:
> > > On Tue, May 19, 2020 at 12:22 AM Gustavo A. R. Silva
> > > <gustavoars@kernel.org> wrote:
> > > >
> > > > The current codebase makes use of one-element arrays in the following
> > > > form:
> > > >
> > > > struct something {
> > > >     int length;
> > > >     u8 data[1];
> > > > };
> > > >
> > > > struct something *instance;
> > > >
> > > > instance = kmalloc(sizeof(*instance) + size, GFP_KERNEL);
> > > > instance->length = size;
> > > > memcpy(instance->data, source, size);
> > > >
> > > > but the preferred mechanism to declare variable-length types such as
> > > > these ones is a flexible array member[1][2], introduced in C99:
> > > >
> > > > struct foo {
> > > >         int stuff;
> > > >         struct boo array[];
> > > > };
> > > >
> > > > By making use of the mechanism above, we will get a compiler warning
> > > > in case the flexible array does not occur last in the structure, which
> > > > will help us prevent some kind of undefined behavior bugs from being
> > > > inadvertently introduced[3] to the codebase from now on.
> > >
> > > However, the ACPICA code in the kernel comes from an external project
> > > and changes of this type are generally not applicable to it unless
> > > accepted upstream.
> >
> > Hi Rafael,
> >
> > By _accepted upstream_, in this case, you mean the adoption of the
> > flexible-arrays in the whole codebase, first?
> 
> I meant whether or not the patch is accepted by the ACPICA upstream.

Is that here? https://github.com/acpica/acpica/commits/master

> 
> >  If this is the case
> > notice that there are hundreds of these flexible-array conversions
> > in mainline, already:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=grep&q=flexible-array
> >
> > Is this what you mean?
> 
> I'm not actually sure what you mean here.

I think this was just a misunderstanding about what "upstream" meant. :)

I hope ACPICA will take these changes -- it seems like we keep running
into these issues with the kernel's language feature clean-ups and ACPICA
upstream, though each have been resolved so far! :) Flexible array
members are a C99 feature, so it's hardly a new way to express things.
In fact, it looks like ACPICA already builds with -c99 by default:
https://github.com/acpica/acpica/blob/master/generate/unix/Makefile.config#L202
https://github.com/acpica/acpica/blob/master/generate/efi/Makefile.config#L93

MSVC has supported them (called "unsized arrays") since 7.1 in 2003.

Gustavo, can you build a merge request for the ACPICA project directly?

-- 
Kees Cook
