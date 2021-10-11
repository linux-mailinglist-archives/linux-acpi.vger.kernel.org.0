Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545D242946D
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Oct 2021 18:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbhJKQZh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Oct 2021 12:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbhJKQZg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Oct 2021 12:25:36 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45142C061570;
        Mon, 11 Oct 2021 09:23:36 -0700 (PDT)
Received: from zn.tnic (p200300ec2f08bb0030636ca0dab1dbfc.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:bb00:3063:6ca0:dab1:dbfc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9BC1A1EC03CA;
        Mon, 11 Oct 2021 18:23:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633969414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tSm9jf94PmL4XEwSBV/yP6piPnrq638nfyV8/qTI/6g=;
        b=UvABe+xtZyBfGqYegcgX4vWmRppTbCWJlWGD+yTluNiWmN3LKRfqxkzzRqlXBHDgSKsNlO
        guAQYlPXfsGLf1BPOjfFep9JmROjWUlcffiTSUht0sLz9reByfmhpmrLs0428FdknBo2rN
        sDmWBWMFM6jyR9c4mE2Ogxk5F7iU9pg=
Date:   Mon, 11 Oct 2021 18:23:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Liguang Zhang <zhangliguang@linux.alibaba.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ACPI / APEI: restore interrupt before panic in sdei flow
Message-ID: <YWRlBzBXq7T1Vo4c@zn.tnic>
References: <20211011151028.105215-1-zhangliguang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211011151028.105215-1-zhangliguang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 11, 2021 at 11:10:28PM +0800, Liguang Zhang wrote:
> We use ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED Notify type for ras event.
> 
> In ATF:
> ehf_activate_priority()
>    dispatch sdei()
> ehf_deactivate_priority()
> 
> If ras error severity is fatal, panic was called in sdei(),
> ehf_deactivate_priority was not called. we should restore interrupt before panic
> otherwise kdump will trigger error.

I have *absolutely* no clue what this commit message is trying to tell
me - sorry you'd have to try again. Maybe structuring it this way, would
help:

--
Problem is A.

It happens because of B.

Fix it by doing C.

(Potentially do D).

For more detailed info, see
Documentation/process/submitting-patches.rst, Section "2) Describe your
changes".

Also, to the tone, from Documentation/process/submitting-patches.rst:

 "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
  to do frotz", as if you are giving orders to the codebase to change
  its behaviour."

Also, do not talk about what your patch does - that should hopefully be
visible in the diff itself. Rather, talk about *why* you're doing what
you're doing.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
