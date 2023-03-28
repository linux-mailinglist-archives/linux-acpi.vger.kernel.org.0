Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FED6CC3A2
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Mar 2023 16:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjC1Oz7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Mar 2023 10:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbjC1Oz6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2023 10:55:58 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A771DDBDB;
        Tue, 28 Mar 2023 07:55:56 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e18so12527911wra.9;
        Tue, 28 Mar 2023 07:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680015355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VUCiRdt4G6e+AfKReFCxGYN4w7zp8icsBzsXAHuEF9Y=;
        b=AnEidLE4LsraW87Q5tXYHYA5Ys+pGCCc9NsTQXztWYS7KfP0rtHSBjPdDzCPcul1og
         XELjf9zZ/Ms/zQ0pafho6jHMsg1nH3aMdm7wdpgxuRZ6kbGRw4au/66oE8Lb/fKm0j7J
         +zc7MS3DN/xKThJhGNbLGMcqzNza8rFIp+TBqxXD2bWnvWqrAYAb9BUXE3K805LX2HFJ
         EONzt2P/PjRZ4gQeprxZGQWQUMXRx6PzH7jyU8+2Mm12q0/F5ZeIomd5uAj9PKq6iYwq
         iCDZ8ZqZXdEFRZWeYVX1ZSWCYKcPOKi3oQ9AdLnWXmDXXrUTrFDbEblNK5uU0jMwCIh7
         Zevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680015355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUCiRdt4G6e+AfKReFCxGYN4w7zp8icsBzsXAHuEF9Y=;
        b=AZ+rhQZhVtab+ThQ3v2dj5V6frD8sILNd/VlPSbjnu0eqPuBdcOMOOpaaRrLAau1WG
         Pkwf6ZqkhjdfTxwhA3bFWOEjd1Uuj2804y06fvlWvr+gwXOxJ1Kz4ktDItiNbifYTrf5
         S6rOCYIXonqwpwN9f/rO1s6wHF6pZhvtvuht7Ii7AD+IY4vWqEDNdM5/QOWFE3n15IYN
         h34HiIFc0Yy7RMazcs3rk8GrJ19VoCFXCvc0yADGq8pw8YW9k+j5l/sWXaOTKqVkfPLK
         ycCFT6aqQ15/In3+BtJzaMs1oIWPYj3woOXSTMDDMZnca53JAyIMVcYZjjWWEPMFJPRJ
         n4Cw==
X-Gm-Message-State: AAQBX9ezBkXi/uSDjuddMVdAlKE4Fm3YjDbJpLeRts3x1dB3Q97r40Hm
        QqewvKLvxvnGtll09KiiWLZ07UkFeJwCoQ==
X-Google-Smtp-Source: AKy350bMs0DBch9jE/m8/eX8EMBCWAe6OoNpwHgERBBzX5jfQ21HXjQ39PxugNSyKZ6Geg4jFjE/8Q==
X-Received: by 2002:a5d:40cd:0:b0:2ce:da65:1e1d with SMTP id b13-20020a5d40cd000000b002ceda651e1dmr15466308wrq.24.1680015354964;
        Tue, 28 Mar 2023 07:55:54 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a6-20020a056000100600b002c8ed82c56csm27836188wrx.116.2023.03.28.07.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 07:55:54 -0700 (PDT)
Date:   Tue, 28 Mar 2023 17:55:40 +0300
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
Message-ID: <8a425108-3480-4a58-ba4f-727146a0cef7@kili.mountain>
References: <Y8ldQn1v4r5i5WLX@kadam>
 <x49y1py5wcd.fsf@segfault.boston.devel.redhat.com>
 <Y8ok/oCxzOhFDEQ+@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8ok/oCxzOhFDEQ+@kadam>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 20, 2023 at 08:22:06AM +0300, Dan Carpenter wrote:
> On Thu, Jan 19, 2023 at 11:21:22AM -0500, Jeff Moyer wrote:
> > Dan Carpenter <error27@gmail.com> writes:
> > 
> > > The concern here would be that "family" is negative and we pass a
> > > negative value to test_bit() resulting in an out of bounds read
> > > and potentially a crash.
> > 
> > I don't see how this can happen.  Do you have a particular scenario in
> > mind?
> > 
> 
> This is from static analysis.  My main thinking was:
> 
> 1) The static checker says that this comes from the user.
> 2) Every upper bounds check should have a lower bounds check.
> 3) family is passed to array_index_nospec() so we must not trust it.
> 
> But looking closer today here is what the checker is concerned about:
> 
> 	func = cmd_to_func(nfit_mem, cmd, call_pkg, &family);
> 
> Assume "nfit_mem" is NULL but "call_pkg" is non NULL (user input from
> __nd_ioctl() or ars_get_status().  In that case family is unchecked user
> input.
> 
> But probably, it's not possible for nfit_mem to be NULL in those caller
> functions?

Did we ever figure out if it's possible for nfit_mem to be NULL?

regards,
dan carpenter

