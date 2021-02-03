Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB55630DFEC
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Feb 2021 17:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhBCQmq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Feb 2021 11:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhBCQmp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Feb 2021 11:42:45 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827BDC061573;
        Wed,  3 Feb 2021 08:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=blj373H0bc+Fsmi6Ti/x/W0JiJ/lNNK0JSxAofHY8G8=; b=Thss449WfC0CdASo62EoNT2E6L
        /yabn5ZR3OMkABIHmq9pRtaWEpewntBeCZupq02ZwxxPSwREGkW0t29VJ55VKWMj3PEWbiSDvg7Re
        wx73NoMwNp+gg8Y1U3LyPaNFcBykMOhV4iaf+h8RRprW+iEghIuARlFyKXTdzjm0YobSho2GHhNRZ
        zF0MXwn/gUDuoQlHiD6MxJPC4gAElsQ1RdlJPeXmoAblZV/qgomkvf6tz3vnBf4bzeAIDrzyG0ubW
        j69X79k82uHlmZYaCr7QCxsIBWGunhrEfx6fHdpS+1prv7JNU1hhXt2TXp2MeYVo9fplmHoyC8I10
        qOFDREFw==;
Received: from [2601:1c0:6280:3f0::2a53]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7LE9-0002dG-4v; Wed, 03 Feb 2021 16:42:01 +0000
Subject: Re: [PATCH] include: acpi: Correct spelling in the file acoutput.h is
 optimzation to optimization
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, robert.moore@intel.com,
        erik.kaneda@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org
References: <20210203154437.15949-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <afd9b0da-c78f-6307-f30f-8e291f002d91@infradead.org>
Date:   Wed, 3 Feb 2021 08:41:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210203154437.15949-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2/3/21 7:44 AM, Bhaskar Chowdhury wrote:
> 
> s/optimzation/optimization/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/acpi/acoutput.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
> index c5d900c0ecda..1ba212372e79 100644
> --- a/include/acpi/acoutput.h
> +++ b/include/acpi/acoutput.h
> @@ -362,7 +362,7 @@
>   *
>   * A less-safe version of the macros is provided for optional use if the
>   * compiler uses excessive CPU stack (for example, this may happen in the
> - * debug case if code optimzation is disabled.)
> + * debug case if code optimization is disabled.)
>   */
> 
>  /* Exit trace helper macro */
> --
> 2.26.2
> 


-- 
~Randy

