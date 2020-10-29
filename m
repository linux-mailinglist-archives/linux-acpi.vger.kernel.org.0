Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50EA29EA8F
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 12:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgJ2LbK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 07:31:10 -0400
Received: from m12-15.163.com ([220.181.12.15]:55623 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgJ2LbK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Oct 2020 07:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=BrT/V
        DrUtJNFzx+oBTZWWNNYOVKlR1dGHe4EMKul+Xs=; b=cZ5xfMk2e0fnx3n1fduXG
        3ReeenaWzyEwnvuNsYqq+uEMtpZrkSom0rfE8Mfh/xE3PwOLvWglt9zIXxLz30Mx
        xftTPByl/6Dxb5Go+tDOPJndkz5lDAOYD6XamLPcVCuP+LA7q66LJO6+aWE5LS70
        FDeiKY73+7NyNjNXB1eAmg=
Received: from smtp.163.com (unknown [36.112.24.9])
        by smtp11 (Coremail) with SMTP id D8CowADXTvPZp5pfgTvjFQ--.9414S2;
        Thu, 29 Oct 2020 19:30:34 +0800 (CST)
From:   yaoaili126@163.com
To:     james.morse@arm.com
Cc:     rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        bp@alien8.de, linux-acpi@vger.kernel.org, YANGFENG1@kingsoft.com,
        yaoaili@kingsoft.com
Subject: Re:Re: [PATCH] Fix incorrect return value of pre_map_gar_callback
Date:   Thu, 29 Oct 2020 04:30:23 -0700
Message-Id: <20201029113023.6292-1-yaoaili126@163.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <6b71b5b3-b423-6768-15f4-44f7aa7dc12d () arm ! com>
References: <6b71b5b3-b423-6768-15f4-44f7aa7dc12d () arm ! com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowADXTvPZp5pfgTvjFQ--.9414S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw1fJr4DXr4rtr48XF1DZFb_yoW5Ar1fpF
        ZavF47Cr40qw40yr4Iv345ZF1UWws3JF47tw40kwn09F1Y9F42yFyUu3Z8ta4rta10k3yF
        vanrtayrWayDtFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UPOz3UUUUU=
X-Originating-IP: [36.112.24.9]
X-CM-SenderInfo: 51drtxdolrjli6rwjhhfrp/1tbifAjMG1r6nJVPCQACsO
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Aili Yao <yaoaili@kingsoft.com>

Hi, Thanks for your comments!

> -----Original Message-----
> From: James Morse [mailto:james.morse@arm.com]
> Sent: Thursday, October 29, 2020 3:19 AM
> To: yaoaili126@163.com
> Cc: rjw@rjwysocki.net; lenb@kernel.org; tony.luck@intel.com; bp@alien8.de;
> linux-acpi@vger.kernel.org; YANGFENG1 [杨峰]
> <YANGFENG1@kingsoft.com>; yaoaili [么爱利] <yaoaili@kingsoft.com>
> Subject: Re: [PATCH] Fix incorrect return value of pre_map_gar_callback
> 
> Hi!
> 
> On 26/10/2020 06:15, yaoaili126@163.com wrote:
> > From: Aili Yao <yaoaili@kingsoft.com>
> >
> > From commit 6915564dc5a8 ("ACPI: OSL: Change the type of
> > acpi_os_map_generic_address() return
> > value"),acpi_os_map_generic_address
> > will return logical address or NULL for error, but
> > pre_map_gar_callback,for ACPI_ADR_SPACE_SYSTEM_IO case, it should
> 
> 'it should' refers to pre_map_gar_callback(), not
> acpi_os_map_generic_address()?
>

yes 

> 
> > be also return 0,as it's a
> > normal case, but now it will return -ENXIO. so check it out for such
> > case to avoid einj module initialization fail.
> 
> apei_map_generic_address() calls acpi_os_map_generic_address() which
> returns NULL for any address space that isn't
> ACPI_ADR_SPACE_SYSTEM_MEMORY.
> That commit now maps this to an error code, where-as before: this code was
> getting away with it.
> 
> The bug is it tries to map a GAR that doesn't need mapping.
> 
> 
> Could we avoid this problem more clearly by returning 0 from
> apei_map_generic_address() for address spaces that don't need mapping?
> (e.g. IO)
> 
> This would also fix any other callers lurking in apei.
> 

yes, you are right, I think we can move the ACPI_ADR_SPACE_SYSTEM_MEMORY check to:

    626 int apei_map_generic_address(struct acpi_generic_address *reg)
    627 {
    628         int rc;
    629         u32 access_bit_width;
    630         u64 address;
    631 
    632         rc = apei_check_gar(reg, &address, &access_bit_width);
    633         if (rc)
    634                 return rc;
    635 
    636         if (!acpi_os_map_generic_address(reg) &&
    637          reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
    638                 return -ENXIO;
    639         
    640         return 0;
    641 }
    642 EXPORT_SYMBOL_GPL(apei_map_generic_address);
> 
> Thanks,
> 
> James
> 
> 
> > diff --git a/drivers/acpi/apei/apei-base.c
> > b/drivers/acpi/apei/apei-base.c index 552fd9ffaca4..042d2dbdb855
> > 100644
> > --- a/drivers/acpi/apei/apei-base.c
> > +++ b/drivers/acpi/apei/apei-base.c
> > @@ -230,7 +230,8 @@ static int pre_map_gar_callback(struct
> > apei_exec_context *ctx,  {
> >  	u8 ins = entry->instruction;
> >
> > -	if (ctx->ins_table[ins].flags & APEI_EXEC_INS_ACCESS_REGISTER)
> > +	if (ctx->ins_table[ins].flags & APEI_EXEC_INS_ACCESS_REGISTER &&
> > +	 entry->register_region.space_id ==
> ACPI_ADR_SPACE_SYSTEM_MEMORY)
> >  		return apei_map_generic_address(&entry->register_region);
> >
> >  	return 0;
> 

Thanks
Aili Yao

