Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D7B417835
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Sep 2021 18:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhIXQMu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Sep 2021 12:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbhIXQMu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Sep 2021 12:12:50 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24614C061571;
        Fri, 24 Sep 2021 09:11:17 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0dd600a481e37252848e31.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:d600:a481:e372:5284:8e31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2C5CF1EC03FE;
        Fri, 24 Sep 2021 18:11:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632499871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TbX70JSG2rBq6ASh9WJOnkzpbMi1cTCSReNzsMFrWQQ=;
        b=LDQWBnosGGJ3Q3O/ksdTEIlmwGoeZ/ayCIfBRM5HYaasU18MswfnjjRadCnCOx9VqAoTP3
        n2QInL5b0IMkF033onkYYHzj8qisE4g4pWJINtyz8eaMVSj3XHyPbOq4XtB5iEFolSkfXn
        moUqz1rFpN5lnPH632jUC9hPmRf/eVk=
Date:   Fri, 24 Sep 2021 18:11:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Vasyl Gomonovych <vgomonovych@marvell.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Robert Richter <rrichter@amd.com>,
        Tom Saeger <tom.saeger@oracle.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: APEI: Check NULL argument in exported symbol
Message-ID: <YU34mQzQVVSghDvT@zn.tnic>
References: <SJ0PR18MB3900EC8E9BCB9EF18FE18C74A1A49@SJ0PR18MB3900.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ0PR18MB3900EC8E9BCB9EF18FE18C74A1A49@SJ0PR18MB3900.namprd18.prod.outlook.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 24, 2021 at 03:25:03PM +0000, Vasyl Gomonovych wrote:
> I found  apei_hest_parse() useful API to access the HEST table.

# hexdump -C /sys/firmware/acpi/tables/HEST

doesn't work for you?

Or you want to access it with an out-of-tree driver?

> I think RAS development should increase the number of users of
> apei_hest_parse(). With this API we can read HEST and modify it. Read
> example is to get a count of errors sources from HEST tables from the
> external driver and use that counter for driver data allocation.

Aha, so with external drivers my suggestion would be is to get it
upstream. The upstream kernel doesn't care about out-of-tree users so
I'd strongly suggest you try to get that functionality upstream because
otherwise that unused export will get removed.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
