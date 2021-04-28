Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263F436D6A9
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Apr 2021 13:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhD1Llu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Apr 2021 07:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhD1Llu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Apr 2021 07:41:50 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12CBC061574;
        Wed, 28 Apr 2021 04:41:05 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id lr7so14498444pjb.2;
        Wed, 28 Apr 2021 04:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sgmbb716pp70upIvBedbMM7RAEsX29bxos2MIUhmNtw=;
        b=jbAvMHwyFlcIykq9SSrAP5NHON36AO08GicovVqRZ3Bj4/wVPos5hWfUreVQK/gs2p
         nAiy+LjfpFM56z5KAPbfhaK/lnFr01VngEVz5yNSpg2+/H5lRLl1cc7Tyz6RAXGQo4SE
         1MM0cAqix3Tn1gG9yq1bpO4/Y1bLsLEPUl3SqJk0cpw3YVg6Wt/OBajbeO8WpdtJedRm
         w2ivUIx/Vbez+OKrcBKQ1rWY9h2+sRFtEFxTSbFphhtqofzyCXPCZn+gcXiCIGGFoBLO
         L4AXoIxeP63cClj7+8+a61cS872a+ITM72MhH6WFLvvYpwsA673kLjs7/HdyIT6vFyM5
         7T9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sgmbb716pp70upIvBedbMM7RAEsX29bxos2MIUhmNtw=;
        b=Sqcc5Eyrru3irnVDrW98xJz+2sNbgtlRWTgVwOrZ2UIk7YLVunbacvEKDfCiDdVbUB
         PIWBdplq5UgWTi3+H/AcCcfKrItQ84Mm6PlaWFx68gl/0AWzNf8H+aD8yDOzjbBUfGs8
         8gfwW55SGdPHfdyRZYrIO2+oQc9eOToSxfyPvdVpyBhDdAiPnM41ZGEZ41/PAZNVsKzj
         WgrFr5OeYDBYMIYQIRZksIeOqY+l1RVzTw6YYfCEYhKTH8MvpSeZ8vQHZTIY81efcvgL
         xbuxpDoW7UKp4KYDHHqolosKxnz7Ylo6XPZ13EtFnrPzfpm9x0jzul54tSwYsPzpg15C
         KzZA==
X-Gm-Message-State: AOAM530ACaQhmI7Kk0gF7X9Ps0tkOsma3tnPlia1Z4QFRowNjYokU1jm
        SWt892jQKpaEBsOWojm2c7s=
X-Google-Smtp-Source: ABdhPJyms1Ccv3HYvRR/ohsK7akYTsCGSFwGhtNiB4M+j7HfuOjxNNjunRKnnf5uAszVCwefrb45nQ==
X-Received: by 2002:a17:90a:d18b:: with SMTP id fu11mr1884901pjb.129.1619610065049;
        Wed, 28 Apr 2021 04:41:05 -0700 (PDT)
Received: from localhost ([122.172.37.94])
        by smtp.gmail.com with ESMTPSA id i14sm4948257pfa.156.2021.04.28.04.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 04:41:04 -0700 (PDT)
Date:   Wed, 28 Apr 2021 17:10:57 +0530
From:   Anupama K Patil <anupamakpatil123@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jaroslav Kysela <perex@perex.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Leon Romanovsky <leon@kernel.org>,
        B K Karthik <bkkarthik@pesu.pes.edu>,
        kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH] MAINTAINERS: mark isapnp as obsolete
Message-ID: <20210428114057.tlc53ie7crvkqqhj@ubuntu>
References: <20210428110536.edy74gsobkgtd6al@ubuntu>
 <YIlCzOl/rkYeOWVW@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIlCzOl/rkYeOWVW@kroah.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 21/04/28 01:11PM, Greg KH wrote:
> On Wed, Apr 28, 2021 at 04:35:36PM +0530, Anupama K Patil wrote:
> > isapnp code is very old and according to this link
> > https://en.wikipedia.org/wiki/Legacy_Plug_and_Play#Specifications
> > from Wikipedia, even Windows Vista disabled ISA PnP by default.
> > 
> > This change is in follow up to
> > https://lore.kernel.org/lkml/20210422180322.7wlyg63kv3n2k6id@ubuntu/T/#u
> > and https://lore.kernel.org/lkml/20210424194301.jmsqpycvsm7izbk3@ubuntu/T/#u
> > 
> > Suggested-by: B K Karthik <bkkarthik@pesu.pes.edu>
> > Signed-off-by: Anupama K Patil <anupamakpatil123@gmail.com>
> 
> Has the maintainer said this is unsupported?
> 
> That's who you should take suggestions from :)
> 
> thanks,
> 
> greg k-h

Leon said he thinks it is unsupported (I've also cc'd him). So, I've sent this patch
to get the feedback from the maintainer.

Thanks,
Anupama
