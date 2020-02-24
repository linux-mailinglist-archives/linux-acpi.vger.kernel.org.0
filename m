Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3C7916A730
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2020 14:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgBXNV7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Feb 2020 08:21:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39444 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727348AbgBXNV6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Feb 2020 08:21:58 -0500
Received: from zn.tnic (p200300EC2F0C0F00754C15A63F97C369.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:f00:754c:15a6:3f97:c369])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 74D611EC06AC;
        Mon, 24 Feb 2020 14:21:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582550516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=APjkWpDkYH8yw2wswFHOWZARM3dlj65G1SzI9xgA+P4=;
        b=lxE4UnPODOkaacszfRk6SFjs53/XedHYzkTkjwsQeni5GNQ9cNkYoZG8wiG40LRf/vIlZ0
        Qkr8rbk2qp2J5olJmt6WVSUnb/CulXVkOxvp3ZOxNFbtJ5/dj+jY+I76cXFTgACF9e9grz
        6v39vyX+2O+d+4EaZn4c+ZjiJNXFxHw=
Date:   Mon, 24 Feb 2020 14:21:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Cao jin <caoj.fnst@cn.fujitsu.com>
Cc:     x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Subject: Re: [RFC PATCH 1/2] x86/acpi: Improve code readablity of early madt
 processing
Message-ID: <20200224132152.GB29318@zn.tnic>
References: <20200123014144.19155-1-caoj.fnst@cn.fujitsu.com>
 <20200123014144.19155-2-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200123014144.19155-2-caoj.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 23, 2020 at 09:41:43AM +0800, Cao jin wrote:
> Current processing logic is confusing.
> 
> Return value of early_acpi_parse_madt_lapic_addr_ovr() indicates error(< 0),
> parsed entry number(>= 0).

You mean, the count of table entries parsed successfully?

> So, it makes no sense to initialize acpi_lapic & smp_found_config
> seeing no override entry, instead, initialize them seeing MADT.

Err, that logical conclusion is not really clear to me - pls try
again with more detail. I kinda see what you mean by looking at
acpi_process_madt() but before I commit a change like that, I better
have the warm and fuzzy feeling that it is correct and properly
explained in its commit message.

So why did

  cbf9bd603ab1 ("acpi: get boot_cpu_id as early for k8_scan_nodes")

do it this way? Was it wrong or why?

I'm very wary about touching ACPI parsing code for no good reason
because, well, it is ACPI...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
