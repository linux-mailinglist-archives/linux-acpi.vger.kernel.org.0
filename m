Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B32426A592
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Sep 2020 14:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgIOMvM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Sep 2020 08:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgIOMum (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Sep 2020 08:50:42 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1135C06178B
        for <linux-acpi@vger.kernel.org>; Tue, 15 Sep 2020 05:50:13 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0e42005feaf7d7c7b8ac70.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4200:5fea:f7d7:c7b8:ac70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6A9781EC0268;
        Tue, 15 Sep 2020 14:50:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600174212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=apY9uagXcKYIhWCC1PSmk/9uoKShxkutga8Rag01Bac=;
        b=n4aeYGRweyXbQq+5qg/38VrcEXY/bIPJNFZZGoER+rxgxhh4juwlJB5fxi+0TrJegf9JXQ
        yaq7x09dzX26QpTh7+JHp7AQgbd4Ch/M4JkQPiopgxmG3GpvrZzbMVIJkN3LoKFOZ5G1dK
        MopBagtwx+iGMKVB3PxivPpPSkFAMqU=
Date:   Tue, 15 Sep 2020 14:50:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, wangkefeng.wang@huawei.com,
        linux-acpi@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] ACPI, APEI: make apei_resources_all static
Message-ID: <20200915125003.GH14436@zn.tnic>
References: <20200912033851.143311-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200912033851.143311-1-yanaijie@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Sep 12, 2020 at 11:38:51AM +0800, Jason Yan wrote:
> This eliminates the following sparse warning:
> 
> drivers/acpi/apei/apei-base.c:290:23: warning: symbol
> 'apei_resources_all' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/acpi/apei/apei-base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
> index e358d0046494..d3fbac58d91a 100644
> --- a/drivers/acpi/apei/apei-base.c
> +++ b/drivers/acpi/apei/apei-base.c
> @@ -287,7 +287,7 @@ struct apei_res {
>  };
>  
>  /* Collect all resources requested, to avoid conflict */
> -struct apei_resources apei_resources_all = {
> +static struct apei_resources apei_resources_all = {
>  	.iomem = LIST_HEAD_INIT(apei_resources_all.iomem),
>  	.ioport = LIST_HEAD_INIT(apei_resources_all.ioport),
>  };
> -- 

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
