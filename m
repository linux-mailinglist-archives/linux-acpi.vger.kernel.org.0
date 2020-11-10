Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847B92AD5C8
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Nov 2020 13:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgKJMBQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Nov 2020 07:01:16 -0500
Received: from m12-18.163.com ([220.181.12.18]:52826 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgKJMBP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 10 Nov 2020 07:01:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=CpdDBEmnH4j9uj+y0K
        YDhZA9jQHH4uyATyhYlaSijMc=; b=AgyXgXeEGMOU7rgopWrz1jmwXWbZqcWy89
        cN2mEQhZod284/CyrrA9jN3Nsk1P52Ieuqu+M1Ni/d02e2LoDqROb+2yiSZCVd8G
        eYuQgjKighsIq5lD+aI0JP6IBW+Pg29HCx86SFB1Qg8v98ewNyDj5sfYuDviULXk
        /BAGxd8/c=
Received: from smtp.163.com (unknown [36.112.24.10])
        by smtp14 (Coremail) with SMTP id EsCowABXXgrOgKpf3x+jDA--.28051S2;
        Tue, 10 Nov 2020 20:00:14 +0800 (CST)
From:   yaoaili126@163.com
To:     james.morse@arm.com
Cc:     rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        bp@alien8.de, linux-acpi@vger.kernel.org, YANGFENG1@kingsoft.com,
        yaoaili@kingsoft.com
Subject: Re: [PATCH] ACPI, APEI, Fix incorrect return value of apei_map_generic_address
Date:   Tue, 10 Nov 2020 04:00:02 -0800
Message-Id: <20201110120002.459078-1-yaoaili126@163.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <e0e1cf62-6e49-1524-a370-41532c5b4ac7 () arm ! com>
References: <e0e1cf62-6e49-1524-a370-41532c5b4ac7 () arm ! com>
X-CM-TRANSID: EsCowABXXgrOgKpf3x+jDA--.28051S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF4xZw4rur1kKFW3Aw13Arb_yoW5Xw4rpF
        WI9F4UCrWvqr4xKw48Zr1FvFyUXan3Aay7tF10ywnYyF1YkF93Zryjgws8uas8JFW8Ga1F
        qFsrKaykKayDAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jb4SrUUUUU=
X-Originating-IP: [36.112.24.10]
X-CM-SenderInfo: 51drtxdolrjli6rwjhhfrp/1tbifAnYG1r6nXb9VQABsU
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Aili Yao <yaoaili@kingsoft.com>

Hi!
Thank you for all the suggestions and comments!
I have re-submited the patch following your comments
I really need to read Documentation/process more detailly!

Thanks

Best Regards!

Aili Yao

> -----Original Message-----
> From: James Morse [mailto:james.morse@arm.com]
> Sent: Saturday, November 7, 2020 3:35 AM
> To: yaoaili126@163.com; rjw@rjwysocki.net; lenb@kernel.org
> Cc: tony.luck@intel.com; bp@alien8.de; linux-acpi@vger.kernel.org;
> YANGFENG1<YANGFENG1@kingsoft.com>; yaoaili<yaoaili@kingsoft.com>
> Subject: Re: [PATCH] ACPI, APEI, Fix incorrect return value of
> apei_map_generic_address
> 
> Hello,
> 
> On 02/11/2020 02:47, yaoaili126@163.com wrote:
> > From: Aili Yao <yaoaili@kingsoft.com>
> >
> > From commit 6915564dc5a8 ("ACPI: OSL: Change the type of
> > acpi_os_map_generic_address() return
> > value"),acpi_os_map_generic_address
> > will return logical address or NULL for error, but
> > pre_map_gar_callback and related apei_map_generic_address ,for
> > ACPI_ADR_SPACE_SYSTEM_IO case, it should be also return 0,as it's a
> > normal case, but now it will return -ENXIO. so check it out for such
> > case to avoid einj module initialization fail.
> 
> (Nit: To make the commit message easier to read, please put '()' after
> function names, and spaces after commas.)
> 
> 
> > Tested-by: Tony Luck <tony.luck@intel.com>
> 
> > Signed-off-by: James Morse <james.morse@arm.com>
> 
> You can't add other peoples 'signed off'. This is for tracking the path a patch
> takes, and that each person who touches it 'signs off' their changes for the
> open-source license. See the 'Developer's Certificate of Origin 1.1' in
> Documentation/process/submitting-patches.rst'.
> 
> Please remove this tag.
> 
> 
> > Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
> 
> As this fixes the bug where the einj module can't be loaded, I think its
> appropriate for the stable kernels. The tags to do that are:
> Fixes: 6915564dc5a8 ("ACPI: OSL: Change the type of
> acpi_os_map_generic_address() return
> value")
> Cc: <stable@vger.kernel.org>
> 
> 
> With that, please add my:
> Reviewed-by: James Morse <james.morse@arm.com>
> 
> 
> Thanks!
> 
> James
> 
> 
> 
> > diff --git a/drivers/acpi/apei/apei-base.c
> > b/drivers/acpi/apei/apei-base.c index 552fd9ffaca4..3294cc8dc073
> > 100644
> > --- a/drivers/acpi/apei/apei-base.c
> > +++ b/drivers/acpi/apei/apei-base.c
> > @@ -633,6 +633,10 @@ int apei_map_generic_address(struct
> acpi_generic_address *reg)
> >  	if (rc)
> >  		return rc;
> >
> > +	/* IO space doesn't need mapping */
> > +	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO)
> > +		return 0;
> > +
> >  	if (!acpi_os_map_generic_address(reg))
> >  		return -ENXIO;
> >
> >


