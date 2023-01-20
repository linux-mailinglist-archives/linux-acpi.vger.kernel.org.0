Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE656674C41
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jan 2023 06:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjATF15 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Jan 2023 00:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjATF1f (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jan 2023 00:27:35 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4654AD14;
        Thu, 19 Jan 2023 21:22:10 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o17-20020a05600c511100b003db021ef437so2827248wms.4;
        Thu, 19 Jan 2023 21:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPUNBOEvi+EfT+XJWJvekQT2sNWEjQ5PxX/U+WoCuzc=;
        b=YBIwhB603yUqIdel1BN1aQ2kRRXRXqB2ePnBo3AkabEKkIGyDyo6TflF9PCi7R+hXF
         uM7KoCMnU6bNghykefMWau8xbi8kmQEoq0eKHop8Onk0DBVr0FMBryV2/DhXMkUxVxyW
         +25pM8oejnfFKv2WQMqpFfhuNf+U+R7cRkBTKzRS9Ng0t/RojLDy6qWw6EkKgyf4PkPT
         B2XYSyWpzPB9g9N21dEcnHRVUJwkRPSEsgEo5PUsnNMF1+YfJkhVuxfLSEFilB4J2Mtk
         EohULOeh+ymbakO1zDxwI+oXnMV/seI/uIkLI/7sPHX5TxRBoO190pVfz9VszRXppNYv
         aKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPUNBOEvi+EfT+XJWJvekQT2sNWEjQ5PxX/U+WoCuzc=;
        b=W4rPLuRgliCjsl/eedr1speGyY6sdc3pRPEtQG1xCMrgH9NqgOoh4eZwbMA1DLwAXD
         4MZvD4U35cdlEMsS9pKsOfqnV7V8Vuj9b1LzwsCKU0rMrgV3G227+dt/4BPDdB5rTGYZ
         u/Ei4agiKDQS+mZRIhNLoQ6Dhb1HCbkbKUN1SGEz9os0/idpmp709NsSbwShvrQBSFQV
         zQgLy75/zfKOyyRvLhnnhKVUkWOZnAD+FGalrPRyj7qR9Zh8XF1Xdngg4laS2iA38OL+
         TSbjkDXFN9TGSgtHL1mHG27twMLopbNpSERS0pkwBewh7RelG5wVwvjBDfrRSsrhV+8A
         gE1g==
X-Gm-Message-State: AFqh2krwJfH3DGw3eUWzFo74cZZAxw9GS5/JJJfz7hN2bWxGFDcsCkrD
        H4uO10bk2woGCDXx/cq4g1LMjXC0VN4aAA==
X-Google-Smtp-Source: AMrXdXvzl4+RN1WjgYUz4tRPCvty5ZKlP8ibxlgMTYBueXvwytqo0rr34srYHacHIL0AlSzaowxE1A==
X-Received: by 2002:a05:600c:3b1b:b0:3da:11d7:dba3 with SMTP id m27-20020a05600c3b1b00b003da11d7dba3mr12497450wms.5.1674192129466;
        Thu, 19 Jan 2023 21:22:09 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k16-20020a05600c0b5000b003db0a08694bsm1118757wmr.8.2023.01.19.21.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 21:22:09 -0800 (PST)
Date:   Fri, 20 Jan 2023 08:22:06 +0300
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
Message-ID: <Y8ok/oCxzOhFDEQ+@kadam>
References: <Y8ldQn1v4r5i5WLX@kadam>
 <x49y1py5wcd.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49y1py5wcd.fsf@segfault.boston.devel.redhat.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 19, 2023 at 11:21:22AM -0500, Jeff Moyer wrote:
> Dan Carpenter <error27@gmail.com> writes:
> 
> > The concern here would be that "family" is negative and we pass a
> > negative value to test_bit() resulting in an out of bounds read
> > and potentially a crash.
> 
> I don't see how this can happen.  Do you have a particular scenario in
> mind?
> 

This is from static analysis.  My main thinking was:

1) The static checker says that this comes from the user.
2) Every upper bounds check should have a lower bounds check.
3) family is passed to array_index_nospec() so we must not trust it.

But looking closer today here is what the checker is concerned about:

	func = cmd_to_func(nfit_mem, cmd, call_pkg, &family);

Assume "nfit_mem" is NULL but "call_pkg" is non NULL (user input from
__nd_ioctl() or ars_get_status().  In that case family is unchecked user
input.

But probably, it's not possible for nfit_mem to be NULL in those caller
functions?

regards,
dan carpenter

