Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BF52B02C3
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Nov 2020 11:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgKLKdI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 05:33:08 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49648 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbgKLKdI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Nov 2020 05:33:08 -0500
Received: from nazgul.tnic (unknown [78.130.214.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AC6E01EC0402;
        Thu, 12 Nov 2020 11:33:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605177186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=V8yGBB/eTXUI4K69OcAn6gOepvWF9iiSyg1scT+Ektc=;
        b=EvvYY5NuJIYksNvbfjga8h+YmIkJ4BQOgeVb0mAvqccoBgEdXbH+BL1th6AdI/liEYXSks
        YQ+BASRItnMoeUN86cuvblO8/e0nD1iEVWyvv0D6plh5HhicypQwajbAYbK1tSZUWSq5/c
        aD/zYesdtgDgBJHhX+dxQp0XCUxldfY=
Date:   Thu, 12 Nov 2020 11:32:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Aili Yao <yaoaili@kingsoft.com>
Cc:     <lenb@kernel.org>, <james.morse@arm.com>, <rjw@rjwysocki.net>,
        <tony.luck@intel.com>, <linux-acpi@vger.kernel.org>,
        <YANGFENG1@kingsoft.com>
Subject: Re: [PATCH] ACPI, APEI, Fix incorrect return value of
 apei_map_generic_address
Message-ID: <20201112103258.GA12908@nazgul.tnic>
References: <20201110120002.459078-1-yaoaili126@163.com>
 <20201110145450.GA9857@nazgul.tnic>
 <20201112172407.432b88cc.yaoaili@kingsoft.com>
 <20201112181203.6c39d096.yaoaili@kingsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201112181203.6c39d096.yaoaili@kingsoft.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 12, 2020 at 06:12:03PM +0800, Aili Yao wrote:
> If not this, please help point out!.

If there's something you're not clear on, searching the kernel tree
might help:

[ ~/kernel/linux> git grep top-post Documentation/
Documentation/process/2.Process.rst:444:- Avoid top-posting (the practice of putting your answer above the quoted

and now you open that document and read:

"- Avoid top-posting (the practice of putting your answer above the quoted
  text you are responding to).  It makes your response harder to read and
  makes a poor impression."

Here's another example:

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

Also, read this:

http://daringfireball.net/2007/07/on_top

Also, you can look at mail threads on lkml to see how most people reply
to mail - that also gives a good example what to do.

I hope it is clear now.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
