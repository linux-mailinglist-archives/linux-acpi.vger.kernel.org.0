Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8E819DC28
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Apr 2020 18:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgDCQxK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Apr 2020 12:53:10 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54172 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728341AbgDCQxK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 3 Apr 2020 12:53:10 -0400
Received: from zn.tnic (p200300EC2F0D8900BDBBB37D18611998.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:8900:bdbb:b37d:1861:1998])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8D0A31EC0C64;
        Fri,  3 Apr 2020 18:53:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1585932788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=aL0ozGoheXBfskhoUlG0XEem1C7MV0gBiq23Nu6Wea0=;
        b=iHm7w32lF5P2+lf2EH9UJFXu22nhEzD59fuMfIB/inxE1rvqGkqIt9M7uI5KTISn2hdSQK
        6S71yUqOPPPcNBZA/SIS+0FWhtOM7imTnAz32es9pY2EfDvwY1Q5mMwT96ciRnW1SzdUu9
        QDQ+ewMGUmyqRnnj+0T1r5zVvSed/GU=
Date:   Fri, 3 Apr 2020 18:53:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] x86/acpi: fix a deadlock with cpu hotplug
Message-ID: <20200403165305.GF20218@zn.tnic>
References: <20200403140345.3828-1-cai@lca.pw>
 <CAJZ5v0jjZzSosFwR3Yqu9mWtUNms1u9fbJbQb=tc5=CPc7r_1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jjZzSosFwR3Yqu9mWtUNms1u9fbJbQb=tc5=CPc7r_1w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Apr 03, 2020 at 05:45:10PM +0200, Rafael J. Wysocki wrote:
> I can take this one unless there are objections or concerns.

Please do - I did trigger that yesterday again.

Tested-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
