Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A947536D710
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Apr 2021 14:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbhD1MO3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Apr 2021 08:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhD1MO3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Apr 2021 08:14:29 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591D2C061574;
        Wed, 28 Apr 2021 05:13:43 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id i14so64062pgk.5;
        Wed, 28 Apr 2021 05:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m/t105WtwDDOLhmhL5s6Z3Yp7TxO2rZsqoLK7mthyoY=;
        b=GtCNQZ9eYrdYKapifMY+XhOpeYAoy6nhCd+pkIprTdP2PwPi48ChX85cCpUX1nLCnE
         jrm2ypKsh9NgTa6WQmuvwS+X7k5BwrCexL982FZVvEQ29hWb9FbFRuoK8E+m7KItvyuE
         K7rGTZQ0JTAOd8wqgM1ngYPEHffmv0xpbDHgaszGxHV0X7nOFLStkFjtNgUmHgpzGN4v
         7KUjV/3N6BQiNq5NvORtDnZGsZ4u8n1B0k0sLbEZJ4h+/566ZDcYJ4F8RoAJDL4SjDie
         DOZIyi04Goq3xR8o9W/7qa799DIrAcjYkBUgKQCJqapnvLgeq/eHh/xOPw5aqhucScfA
         so3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m/t105WtwDDOLhmhL5s6Z3Yp7TxO2rZsqoLK7mthyoY=;
        b=bFI/iEaxEsY+sMiMrHjkDhzzEJA758CwQHQ/Qx1Oy2RP55GHFxIp9E0g71WvSGrkrQ
         tMIlVMpFv4i28DhgOQvnjy/WoxgeF+3tMCIP4UH0nzJIx3u9JeigLfXGuftt+meo4hUM
         8frdJQYxcR5RmB9vt5euhvRdw3bgzMmF2nxlK+v0DvPiNNt0T+2IzYJ5JXuumzqff77J
         vPmNcwEikoCDgvEgWAsEOFf9woV/bCsfNwoSr7joVbiQ0iKWfuWqNzD0aoTQHnVwUTXP
         vQ9Gb0tw3j7LtG9k/TqodZ7e79LuZYV0fQP8pUeXajfzl0Hsy1r6EG/pm+SMXHgSVOAV
         4NdQ==
X-Gm-Message-State: AOAM530LN4A1SQsH4tSZSuL1QlnDBz/7q0yELfaALJRU5ulVU2A0J7lp
        HCe3kX9WtQRNB8O/uJPV5Tc=
X-Google-Smtp-Source: ABdhPJxkasbYaZ+a3xYQTQtl3b614xZu5AU+TRrkjjMthcIa76eKDQRlfjo34JwWMPAuYr+jNHVSsw==
X-Received: by 2002:a63:ce07:: with SMTP id y7mr13472683pgf.293.1619612022764;
        Wed, 28 Apr 2021 05:13:42 -0700 (PDT)
Received: from localhost ([122.172.37.94])
        by smtp.gmail.com with ESMTPSA id f3sm4567201pjo.3.2021.04.28.05.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 05:13:42 -0700 (PDT)
Date:   Wed, 28 Apr 2021 17:43:29 +0530
From:   Anupama K Patil <anupamakpatil123@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, B K Karthik <bkkarthik@pesu.pes.edu>,
        kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH] MAINTAINERS: mark isapnp as obsolete
Message-ID: <20210428121329.o4jlx76klmzlzl5n@ubuntu>
References: <20210428110536.edy74gsobkgtd6al@ubuntu>
 <YIlCzOl/rkYeOWVW@kroah.com>
 <20210428114057.tlc53ie7crvkqqhj@ubuntu>
 <YIlLk00Wzd6Lf660@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIlLk00Wzd6Lf660@unreal>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 21/04/28 02:48PM, Leon Romanovsky wrote:
> On Wed, Apr 28, 2021 at 05:10:57PM +0530, Anupama K Patil wrote:
> > On 21/04/28 01:11PM, Greg KH wrote:
> > > On Wed, Apr 28, 2021 at 04:35:36PM +0530, Anupama K Patil wrote:
> > > > isapnp code is very old and according to this link
> > > > https://en.wikipedia.org/wiki/Legacy_Plug_and_Play#Specifications
> > > > from Wikipedia, even Windows Vista disabled ISA PnP by default.
> > > > 
> > > > This change is in follow up to
> > > > https://lore.kernel.org/lkml/20210422180322.7wlyg63kv3n2k6id@ubuntu/T/#u
> > > > and https://lore.kernel.org/lkml/20210424194301.jmsqpycvsm7izbk3@ubuntu/T/#u
> > > > 
> > > > Suggested-by: B K Karthik <bkkarthik@pesu.pes.edu>
> > > > Signed-off-by: Anupama K Patil <anupamakpatil123@gmail.com>
> > > 
> > > Has the maintainer said this is unsupported?
> > > 
> > > That's who you should take suggestions from :)
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > Leon said he thinks it is unsupported (I've also cc'd him). So, I've sent this patch
> > to get the feedback from the maintainer.
> 
> Leon said something different.
> https://lore.kernel.org/lkml/20210422180322.7wlyg63kv3n2k6id@ubuntu/T/#m6c837180c8d6496d5bcbb8526e274c4239844be0
> ------
> > If changes to ISA code aren't welcomed, should these be marked obsolete in the MAINTIANERS file?
> 
> I think so, but think that "Odd Fixes" better describes that Rafael wrote.
> ------
Sorry about that! but does checkpatch tell people not to send patches if it's 'Odd fixes'?
Should I wait for the maintainer's reply before doing anything else?
> 
> > 
> > Thanks,
> > Anupama
