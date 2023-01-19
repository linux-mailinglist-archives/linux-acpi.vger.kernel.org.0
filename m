Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267F7673E87
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jan 2023 17:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjASQUF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Jan 2023 11:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjASQTb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jan 2023 11:19:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACFC82D60
        for <linux-acpi@vger.kernel.org>; Thu, 19 Jan 2023 08:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674145116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qmHYjUt24sUlF/c+UMA/XCra8CJo51C7Y4xLfqoKvY0=;
        b=ZwxKNIxo5uAccZHyJDO1xBRHHYDTpwJTzWtx0LzXOjhAIX4UJk6XEPp8DNgUaMI02ceUD/
        3zaZZNlSLM1KvzCNU1yykU0uMlruoEPX/feC6UDNaDB57FkK/4lTFj8LM/ljng74bCjUWU
        TwXajCzvowUI1ODzwdpu2IUgb7nuUs8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-G6fLYfogOzG6HcOEitMZ7Q-1; Thu, 19 Jan 2023 11:17:42 -0500
X-MC-Unique: G6fLYfogOzG6HcOEitMZ7Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2560D3814953;
        Thu, 19 Jan 2023 16:17:25 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A802D492B03;
        Thu, 19 Jan 2023 16:17:24 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Dan Carpenter <error27@gmail.com>
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
References: <Y8ldQn1v4r5i5WLX@kadam>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 19 Jan 2023 11:21:22 -0500
In-Reply-To: <Y8ldQn1v4r5i5WLX@kadam> (Dan Carpenter's message of "Thu, 19 Jan
        2023 18:09:54 +0300")
Message-ID: <x49y1py5wcd.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dan Carpenter <error27@gmail.com> writes:

> The concern here would be that "family" is negative and we pass a
> negative value to test_bit() resulting in an out of bounds read
> and potentially a crash.

I don't see how this can happen.  Do you have a particular scenario in
mind?

-Jeff

> This patch is based on static analysis and not on testing.
>
> Fixes: 9a7e3d7f0568 ("ACPI: NFIT: Fix input validation of bus-family")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
> v2: add missing close parens ) in subject
>
>  drivers/acpi/nfit/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index f1cc5ec6a3b6..da0739f04c98 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -446,10 +446,10 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>  	const char *cmd_name, *dimm_name;
>  	unsigned long cmd_mask, dsm_mask;
>  	u32 offset, fw_status = 0;
> +	unsigned int family = 0;
>  	acpi_handle handle;
>  	const guid_t *guid;
>  	int func, rc, i;
> -	int family = 0;
>  
>  	if (cmd_rc)
>  		*cmd_rc = -EINVAL;

