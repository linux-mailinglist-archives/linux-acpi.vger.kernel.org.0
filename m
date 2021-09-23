Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023824166E4
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Sep 2021 22:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhIWUtz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 23 Sep 2021 16:49:55 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35568 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229609AbhIWUty (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 23 Sep 2021 16:49:54 -0400
Received: from zn.tnic (p200300ec2f0d68007248b45e3de00aaa.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6800:7248:b45e:3de0:aaa])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8AE7A1EC0390;
        Thu, 23 Sep 2021 22:48:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632430097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KWL4a0lkxnpvQ1ULF1NDI0X+2x+ytAENqWmiXGbtL74=;
        b=nirua982t+sIDD3AZXBBjNvLsAE1bnm00Tk2TmZw9vHyBxOUeZYXocQnrnGiMMgsqNJE87
        ujAAcrnIauT/WNJXZYmG2jRrVK4y+DzXxKTzRLPMBfjleMZ8kRB7+uYFtSwACE6Ew2OpsS
        1V0jRHN+QHxTEDmRP1s1P3Yv/M5+kTw=
Date:   Thu, 23 Sep 2021 22:48:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Vasyl Gomonovych <vgomonovych@marvell.com>
Cc:     rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        Tony Luck <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Robert Richter <rrichter@amd.com>,
        Tom Saeger <tom.saeger@oracle.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: APEI: Check NULL argument in exported symbol
Message-ID: <YUzoCwg/cShU2auq@zn.tnic>
References: <20210923195612.25949-1-vgomonovych@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210923195612.25949-1-vgomonovych@marvell.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 23, 2021 at 12:56:10PM -0700, Vasyl Gomonovych wrote:
> Exported symbol apei_hest_parse is external API
> and should check pointer argument

Why?

All users pass a proper, non-NULL function pointer AFAICT.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
