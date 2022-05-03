Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1853C517C4B
	for <lists+linux-acpi@lfdr.de>; Tue,  3 May 2022 05:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiECDqr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 May 2022 23:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiECDqq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 May 2022 23:46:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BABA03CA50
        for <linux-acpi@vger.kernel.org>; Mon,  2 May 2022 20:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651549394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IAD018WElU9xghuzkSMUkUxt4Nb5z2Ox0B3F5e4aA7E=;
        b=eQcztj6uJtT6oq/MLmC+PIDiElNqQ09zS2CCt/vBP/SMFmG7udG1y7lKDY1uNeS0cc1bUY
        txMaoZNBbGzxiuki1YZOOEwOuYrGyMRQjd8O3fTLAe2kJDj1UbFOisB5/H9qyo9w4wOc9P
        HYlK7Xcu5fMKISn6I+02EnM9+Fb9uLU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-s-WaF6ekN36Uy0s98R70xQ-1; Mon, 02 May 2022 23:43:11 -0400
X-MC-Unique: s-WaF6ekN36Uy0s98R70xQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 048C885A5BE;
        Tue,  3 May 2022 03:43:11 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.36.110.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B6D51534B29;
        Tue,  3 May 2022 03:43:08 +0000 (UTC)
Date:   Tue, 3 May 2022 05:43:06 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     nvdimm@lists.linux.dev, robert.hu@linux.intel.com,
        vishal.l.verma@intel.com, hch@lst.de, linux-acpi@vger.kernel.org,
        ldv@strace.io
Subject: Re: [PATCH 6/6] nvdimm/region: Delete nd_blk_region infrastructure
Message-ID: <20220503034306.GA30980@asgard.redhat.com>
References: <164688415599.2879318.17035042246954533659.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164688418803.2879318.1302315202397235855.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164688418803.2879318.1302315202397235855.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 09, 2022 at 07:49:48PM -0800, Dan Williams wrote:
> Now that the nd_namespace_blk infrastructure is removed, delete all the
> region machinery to coordinate provisioning aliased capacity between
> PMEM and BLK.

> --- a/include/uapi/linux/ndctl.h
> +++ b/include/uapi/linux/ndctl.h
> @@ -189,7 +189,6 @@ static inline const char *nvdimm_cmd_name(unsigned cmd)
>  #define ND_DEVICE_REGION_BLK 3      /* nd_region: (parent of BLK namespaces) */
>  #define ND_DEVICE_NAMESPACE_IO 4    /* legacy persistent memory */
>  #define ND_DEVICE_NAMESPACE_PMEM 5  /* PMEM namespace (may alias with BLK) */
> -#define ND_DEVICE_NAMESPACE_BLK 6   /* BLK namespace (may alias with PMEM) */

As [1] suggests, this would break compilation of at least one Debian
package, as well as unknown number of any other potential users of this part
of UAPI.

>  #define ND_DEVICE_DAX_PMEM 7        /* Device DAX interface to pmem */
>  
>  enum nd_driver_flags {
> @@ -198,7 +197,6 @@ enum nd_driver_flags {
>  	ND_DRIVER_REGION_BLK      = 1 << ND_DEVICE_REGION_BLK,
>  	ND_DRIVER_NAMESPACE_IO    = 1 << ND_DEVICE_NAMESPACE_IO,
>  	ND_DRIVER_NAMESPACE_PMEM  = 1 << ND_DEVICE_NAMESPACE_PMEM,
> -	ND_DRIVER_NAMESPACE_BLK   = 1 << ND_DEVICE_NAMESPACE_BLK,

The same probably applies here.

[1] https://sources.debian.org/src/ipmctl/03.00.00.0429-1/src/os/linux/lnx_system.c/?hl=334#L334

