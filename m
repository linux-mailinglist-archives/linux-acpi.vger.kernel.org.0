Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B816CC3DF
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Mar 2023 16:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbjC1O6C (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Mar 2023 10:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbjC1O6B (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2023 10:58:01 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3213592;
        Tue, 28 Mar 2023 07:57:59 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so9293973wmq.2;
        Tue, 28 Mar 2023 07:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680015478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DE5xgbwhRQpkJgfP8sEL5gZw3SNhWz8a/RrIbBfg2gk=;
        b=ogWMrlr7I27p4FwSejAr7Q2c1/kXf0NR8Ec5k4be40g439cNGZ3OUCBDTwj2+EJLBS
         +CVfoC11xm9nD86Y42TyBgqgb+BStWr/kyeLZir9gjK/HlHbgRrEkflNOaz65ZHPxbmi
         BtgH1xfl3hZvUenIpKCRqNlBc8BQ8gLlNyiclLGWqIKb6rooabZlKaaDAncJ6Tgy5Eh4
         0tz2uj+3IDTc6XqK5A0tMkM/SXWUDK687xJtClyW9GENsIrdj63nsd8OtjFVHRRcuOuB
         64pbM0vG8buKzrZ3TeB+Ax78GJoerauv979g8hang2NObPVtppPe4vv+cfBz9CvdK8dT
         ISuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680015478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DE5xgbwhRQpkJgfP8sEL5gZw3SNhWz8a/RrIbBfg2gk=;
        b=Q0ZOVIXWHN+V9uwfNNPPmjtdriHSHvKjCD9aXU1LeqeG7zzWEpyIjcGTJvxDQIPsQG
         hfIGciZsKAb97wLOK7ZaZfkmfrzKH6JX9n4AeCk6yb8sQ3bzI4ZD4bucxMQ7a9inNiyd
         bcofC8fc4vkB3bHwf0gZSN+JzJpOoBfclx+Df5P/LL+Q780X4/A9ELdc0wRMPVbUeHTX
         dHUpVvBMDsC5P+DkratmbQtMr9MWvdbMVHw2BVoJvXMdj+JXjAoXT5jqvCAq5Tky/ZUj
         sK/9/RXOVrosO7xi46g2MGh9iRvON4FOuF7cRsENUs9U/oKk579F+tUJGxhDwvMEAscK
         1XyA==
X-Gm-Message-State: AO0yUKW0Hr/hqCZNCrOW7Iw88m7lv75n0scABAOK9AKiMqCrv0Q/+cSv
        /6d+YTpGr++WR3bs/1o2YOg=
X-Google-Smtp-Source: AK7set/I8CH/86E0q7PQNOZAnX2C+ynZld6z0EVam7znB2FfZDfuDS4nv55P+mN8t5DQ9YTt9sfnew==
X-Received: by 2002:a05:600c:21da:b0:3ed:346d:452f with SMTP id x26-20020a05600c21da00b003ed346d452fmr13068122wmj.26.1680015477838;
        Tue, 28 Mar 2023 07:57:57 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m15-20020a05600c3b0f00b003ee91eda67bsm12949511wms.12.2023.03.28.07.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 07:57:57 -0700 (PDT)
Date:   Tue, 28 Mar 2023 17:57:54 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, nvdimm@lists.linux.dev,
        linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        cip-dev <cip-dev@lists.cip-project.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH v2] ACPI: NFIT: prevent underflow in acpi_nfit_ctl()
Message-ID: <ad63258f-cc13-4f6c-a2a7-aea783f60931@kili.mountain>
References: <Y8ldQn1v4r5i5WLX@kadam>
 <x49y1py5wcd.fsf@segfault.boston.devel.redhat.com>
 <Y8ok/oCxzOhFDEQ+@kadam>
 <8a425108-3480-4a58-ba4f-727146a0cef7@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a425108-3480-4a58-ba4f-727146a0cef7@kili.mountain>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 28, 2023 at 05:55:40PM +0300, Dan Carpenter wrote:
> On Fri, Jan 20, 2023 at 08:22:06AM +0300, Dan Carpenter wrote:
> > On Thu, Jan 19, 2023 at 11:21:22AM -0500, Jeff Moyer wrote:
> > > Dan Carpenter <error27@gmail.com> writes:
> > > 
> > > > The concern here would be that "family" is negative and we pass a
> > > > negative value to test_bit() resulting in an out of bounds read
> > > > and potentially a crash.
> > > 
> > > I don't see how this can happen.  Do you have a particular scenario in
> > > mind?
> > > 
> > 
> > This is from static analysis.  My main thinking was:
> > 
> > 1) The static checker says that this comes from the user.
> > 2) Every upper bounds check should have a lower bounds check.
> > 3) family is passed to array_index_nospec() so we must not trust it.
> > 
> > But looking closer today here is what the checker is concerned about:
> > 
> > 	func = cmd_to_func(nfit_mem, cmd, call_pkg, &family);
> > 
> > Assume "nfit_mem" is NULL but "call_pkg" is non NULL (user input from
> > __nd_ioctl() or ars_get_status().  In that case family is unchecked user
> > input.
> > 
> > But probably, it's not possible for nfit_mem to be NULL in those caller
> > functions?
> 
> Did we ever figure out if it's possible for nfit_mem to be NULL?

Another idea is I could send this patch as a static checker fix instead
of a security vulnerability.  That way we would be safe going forward
regardless.

regards,
dan carpenter

