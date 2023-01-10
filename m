Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C891664FED
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Jan 2023 00:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbjAJXY0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Jan 2023 18:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235371AbjAJXYL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Jan 2023 18:24:11 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0514E42D
        for <linux-acpi@vger.kernel.org>; Tue, 10 Jan 2023 15:24:10 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6977B1EC0682;
        Wed, 11 Jan 2023 00:24:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673393048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dtNSGuGKPKKWarL4raderkCgJPYz6hdJZd5bZDtbnIk=;
        b=UwjdBYWVPrVlw8PR7QEaKxZvZKAQjJUnAo0pthDff9PD7DRk5DpZQBTIchRCykBmrebK9o
        IUBe5y0EYgUnGZ8TaL9u0OjfnCsF/cgu0tsfL/ShE007n6jA9xeR51hTuVcc+42fKcZ6t9
        USpi5E96ggy0V+aUdYwB1zT5qIi/cZ4=
Date:   Wed, 11 Jan 2023 00:24:01 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     James Puthukattukaran <james.puthukattukaran@oracle.com>
Cc:     linux-acpi@vger.kernel.org, x86@kernel.org, rafael@kernel.org,
        lenb@kernel.org, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com
Subject: Re: [PATCH v3] x86/ACPI: Ignore CPUs that are not online capable for
 x2apic, entries as well
Message-ID: <Y73zkXlPqiMFeT6V@zn.tnic>
References: <ef8c7138-8ed1-d849-0ed5-e629ddcafd63@oracle.com>
 <1987c2d2-1246-b172-985f-360e5c2c437a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1987c2d2-1246-b172-985f-360e5c2c437a@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 10, 2023 at 05:43:41PM -0500, James Puthukattukaran wrote:
> Adding others that I missed on my first email. 
> 
> James
> 
> On 12/22/22 13:26, James Puthukattukaran wrote:
> > Extending commit aa06e20f1be6 ("x86/ACPI: Don't add CPUs that are not
> > online capable") to include acpi_parse_x2apic as well.

This doesn't look like an extension to some existing commit but like a separate
fix.

> > There is a check for invalid apicid; however, there are BIOS FW with madt
> > version >= 5 support that do not bother setting apic id to an invalid value
> > since they assume the OS will check the enabled and online capable flags.

Which BIOSes are those?

Also, I'm no BIOS guy but I don't see you checking MADT version anywhere?

> > Signed-off-by: James Puthukattukaran<james.puthukattukaran@oracle.com>
> > Reported-by: Benjamin Fuller<ben.fuller@oracle.com>
> > 
> > v2 : use 'enabled' local variable. Also fix checkpatch.pl catches
> > v3 : updates as per Rafael's comments

Yah, I'd like for Rafael to decide what to do here...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
