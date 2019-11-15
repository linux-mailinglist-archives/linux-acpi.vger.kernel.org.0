Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADBBFD468
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Nov 2019 06:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfKOFdL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Nov 2019 00:33:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35632 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfKOFdL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Nov 2019 00:33:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=t9pKAk5jRst2KOPoVTJaEkdldG1GZYtYdIn8IcV12jE=; b=rLbh0H8sv9W8oRhKzUW2z9H+u
        n5pVgq0mv/WTCI7KJ2Ds0H4C3zrEfQR1rJGUVBEsH2IOGmxtH4Iaa0HlNkcP/+g3DjJut9fB0L3Ah
        L5Aihasn2ELhhJWyFD6sl7n7CLOQ4aih/tdYO09U8Wi/hFRYnrfOtVugQSu/agBAKaG/vE5+tuz4b
        FR+hoJ5Zj++dL+qO7g/904BUC1e9gRrESPqzpz8AKZevGX9zV2ypTU8K17e+1AJguYDLaYGKMxj2Q
        Lt9PXy08lhIXy76y9JcT8VvLbMCdxSO1lWsFztCGbPeiybJF8AXhngChIV/MfMl7iFJDH+FSf+Ins
        GJtmRdqrw==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVUEJ-0002hA-9w; Fri, 15 Nov 2019 05:33:11 +0000
Subject: Re: how to disable the button kernel module?
To:     Bruno GNUser <kernel@dantas.airpost.net>,
        linux-kernel@vger.kernel.org,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
References: <1573732820166-0.post@n7.nabble.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0780918b-184e-55a6-a439-06403d3777ff@infradead.org>
Date:   Thu, 14 Nov 2019 21:33:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1573732820166-0.post@n7.nabble.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 11/14/19 4:00 AM, Bruno GNUser wrote:
> I realize that /button/ is a kernel built-in and therefore cannot be disabled
> via the /blacklist=<module_name>/ boot parameter. So I thought I'd try
> /initcall_blacklist=<function>/ but I cannot find an obvious module
> initialization function in button.c

In what kernel version if the button driver built-in?
It currently can be built as a loadable module.

The lines
module_driver(acpi_button_driver, acpi_button_register_driver,
	       acpi_button_unregister_driver);
at the end of the source file create an init function named
acpi_button_driver_init.  You could try:
  initcall_blacklist=acpi_button_driver_init


> Please, how would one disable the /button/ module? Either using the
> /initcall_blacklist=foo/ or some other method is fine, as long as it does
> not involve recompiling the kernel. 

Any help from ACPI people?


> Thanks,
> Bruno GNUser
> 
> 
> --
> Sent from: http://linux-kernel.2935.n7.nabble.com/


-- 
~Randy

