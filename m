Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA07322B667
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Jul 2020 21:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgGWTHd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 23 Jul 2020 15:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgGWTHd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Jul 2020 15:07:33 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81BAC0619E4
        for <linux-acpi@vger.kernel.org>; Thu, 23 Jul 2020 12:07:32 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x9so3004868plr.2
        for <linux-acpi@vger.kernel.org>; Thu, 23 Jul 2020 12:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fmy4tO1tW/yB2p+/DBGuPfpuvcNIPQV/6jKnfwUymaM=;
        b=uJ/LXXd4WW3t/V9uP1pvh2+w7xCfmHmmU2q2MX994uvmdMhyUpnBd6wtTkFWVeSiVn
         fni2Skynmv78aJ9rstIyOgTssb4uBzBQL6YPmxb5SzQaGZtm2sB0Ln7Qk9r6vt5a/SEE
         gYzQRW0K8FC5lX9W9+bz+gbIOgybElEHRuMxxBvv7T+TJKJnGfXHkIe/b2UFhfrjNnt8
         hmvs/pCT8mt2wp6eGsvntxKg2m7zjG9IalAT3RXT7FCW3qu0zRZl84tHISI7JSF/JPwL
         M06pYkfoNbZamtdmUh5GU20hgxfU9YBtWQ50on6QDjz/h882N3ikL5uKYSp6UNdyl0GU
         5IDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fmy4tO1tW/yB2p+/DBGuPfpuvcNIPQV/6jKnfwUymaM=;
        b=ndJue7Tot/jdLJIir3AqDE3exinHJQ2IOQYeBAriPUieyF/n/RW0Wc2rerUawqtjja
         bgRvlms7fUAr9OmE/623G+8ce8h0Qf7W++0skZMWqkrt7hzwNJCg3fWM32KXlginBJ53
         q38IHpkl7+FsgbHB80O9peEQIQ18BZsfPKe2UW30lxuzZjRZDCLtgZ3pWYR1wATvzysF
         Jh79aQGO+pyBHOuCb+TZg8keW4kt7neWxQ/2ycqWV4fHLpUa5aa7LdmSntflYeEIHCRN
         Dei6oOyOt/OeKd2cmWqNAbEZ/fxKbUp1Ohm5xzG0uhMZ2px5yQhdJN3uV0CMNtaKXMKD
         vv0A==
X-Gm-Message-State: AOAM5329dZhNeeHjE8l4SyGAgNkHP7PoT4tUXhVJFbD7hR1qA5WluvAO
        SAYb6RJjdESGBL8pP5SvtqHZNQ==
X-Google-Smtp-Source: ABdhPJyFY8SK2yrpGMIJYPZOm/XbUPFW09vVIwr7j2Oue2l2cEXybEXOCRDyJvKCGSvI32jjRGApEQ==
X-Received: by 2002:a17:902:22:: with SMTP id 31mr4590106pla.120.1595531251889;
        Thu, 23 Jul 2020 12:07:31 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
        by smtp.gmail.com with ESMTPSA id h6sm3716298pfo.123.2020.07.23.12.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 12:07:31 -0700 (PDT)
Date:   Thu, 23 Jul 2020 12:07:24 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Subject: Re: [PATCH v2] cpuidle: change enter_s2idle() prototype
Message-ID: <20200723190724.GA1339461@google.com>
References: <1594005196-16327-1-git-send-email-neal.liu@mediatek.com>
 <1594005196-16327-2-git-send-email-neal.liu@mediatek.com>
 <CAJZ5v0ihB5AJwSRpjaOnXAmciregzxARL5xfudu1h+=_LXaE_w@mail.gmail.com>
 <1594350535.4670.13.camel@mtkswgap22>
 <1595233294.8055.0.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595233294.8055.0.camel@mtkswgap22>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 20, 2020 at 04:21:34PM +0800, Neal Liu wrote:
> Gentle ping on this patch.
> 
> 
> On Fri, 2020-07-10 at 11:08 +0800, Neal Liu wrote:
> > On Thu, 2020-07-09 at 14:18 +0200, Rafael J. Wysocki wrote:
> > > On Mon, Jul 6, 2020 at 5:13 AM Neal Liu <neal.liu@mediatek.com> wrote:
> > > >
> > > > Control Flow Integrity(CFI) is a security mechanism that disallows
> > > > changes to the original control flow graph of a compiled binary,
> > > > making it significantly harder to perform such attacks.
> > > >
> > > > init_state_node() assign same function callback to different
> > > > function pointer declarations.
> > > >
> > > > static int init_state_node(struct cpuidle_state *idle_state,
> > > >                            const struct of_device_id *matches,
> > > >                            struct device_node *state_node) { ...
> > > >         idle_state->enter = match_id->data; ...
> > > >         idle_state->enter_s2idle = match_id->data; }
> > > >
> > > > Function declarations:
> > > >
> > > > struct cpuidle_state { ...
> > > >         int (*enter) (struct cpuidle_device *dev,
> > > >                       struct cpuidle_driver *drv,
> > > >                       int index);
> > > >
> > > >         void (*enter_s2idle) (struct cpuidle_device *dev,
> > > >                               struct cpuidle_driver *drv,
> > > >                               int index); };
> > > >
> > > > In this case, either enter() or enter_s2idle() would cause CFI check
> > > > failed since they use same callee.
> > > 
> > > Can you please explain this in a bit more detail?
> > > 
> > > As it stands, I don't understand the problem statement enough to apply
> > > the patch.
> > > 
> > 
> > Okay, Let's me try to explain more details.
> > Control Flow Integrity(CFI) is a security mechanism that disallows
> > changes to the original control flow graph of a compiled binary, making
> > it significantly harder to perform such attacks.
> > 
> > There are multiple control flow instructions that could be manipulated
> > by the attacker and subvert control flow. The target instructions that
> > use data to determine the actual destination.
> > - indirect jump
> > - indirect call
> > - return
> > 
> > In this case, function prototype between caller and callee are mismatch.
> > Caller: (type A)funcA
> > Callee: (type A)funcB
> > Callee: (type C)funcC
> > 
> > funcA calls funcB -> no problem
> > funcA calls funcC -> CFI check failed
> > 
> > That's why we try to align function prototype.
> > Please feel free to feedback if you have any questions.

I think you should include a better explanation in the commit message.
Perhaps something like this?

  init_state_node assigns the same callback function to both enter and
  enter_s2idle despite mismatching function types, which trips indirect
  call checking with Control-Flow Integrity (CFI).

> > > > Align function prototype of enter() since it needs return value for
> > > > some use cases. The return value of enter_s2idle() is no
> > > > need currently.
> > > 
> > > So last time I requested you to document why ->enter_s2idle needs to
> > > return an int in the code, which has not been done.  Please do that.

Rafael, are you happy with the commit message documenting the reason,
or would you prefer to also add a comment before enter_s2idle?

Sami
