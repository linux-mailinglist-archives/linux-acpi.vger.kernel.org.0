Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A1B41670B
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Sep 2021 23:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbhIWVEu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 23 Sep 2021 17:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbhIWVEt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Sep 2021 17:04:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D92C061574;
        Thu, 23 Sep 2021 14:03:17 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d68007248b45e3de00aaa.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6800:7248:b45e:3de0:aaa])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 269391EC03FE;
        Thu, 23 Sep 2021 23:03:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632430991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ObxXqz9MwOnlPx6YFBRR3QL7+Uqqp0L8yP+LhFBcOek=;
        b=ncof9ZZtHlm37SQzzDX4peCVfnOhM8+pS+j6h4QAYrURjns3yxNmP+EbVC78/RcJWZaKDD
        IGmsrHplIHp5d9DOlgtuhOsQvVwueaWavkPYSdWw1S3h0ZFcVC+Y5SO9v3q3qi1QF6sZwY
        QOuKSuVbaSmiOSQyAMESqpIaqXlsST8=
Date:   Thu, 23 Sep 2021 23:03:05 +0200
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
Message-ID: <YUzribOnxrSpIwbS@zn.tnic>
References: <20210923195612.25949-1-vgomonovych@marvell.com>
 <YUzoCwg/cShU2auq@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUzoCwg/cShU2auq@zn.tnic>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 23, 2021 at 10:48:11PM +0200, Borislav Petkov wrote:
> On Thu, Sep 23, 2021 at 12:56:10PM -0700, Vasyl Gomonovych wrote:
> > Exported symbol apei_hest_parse is external API
> > and should check pointer argument
> 
> Why?
> 
> All users pass a proper, non-NULL function pointer AFAICT.

Looking at this more, that apei_hest_parse() thng should be made static
and the export dropped.

The last user was removed in

708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST parsing for AER ownership")

You could mention it in the commit log.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
