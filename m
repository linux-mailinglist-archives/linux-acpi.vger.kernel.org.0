Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCA144EBBE
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jun 2019 17:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfFUPSg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Jun 2019 11:18:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43254 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfFUPSg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Jun 2019 11:18:36 -0400
Received: from zn.tnic (p200300EC2F125200847393019077036E.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:5200:8473:9301:9077:36e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3880A1EC05C2;
        Fri, 21 Jun 2019 17:18:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1561130315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Hixi51aA14lZrTiPy7IpE0M7MNd2Djij9jfYC3NjsDc=;
        b=GpCZoU8z+uf2SUZxwLnNXQLLQtRpRE8W7OIeX/Z/gXOt1XEasm+k/nWwunCMJcDjS6S/8e
        /xR4mUugbDFRsaaFerbRvNGtuPYEtgkIuH3ysIM83ZotpWAHBK8kv63ODNmlWJa8iE6ZmB
        /w2g+wvi22fchfAlmJmDmdiJ10rkiTc=
Date:   Fri, 21 Jun 2019 17:18:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     luanshi <zhangliguang@linux.alibaba.com>,
        James Morse <james.morse@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] ACPI / APEI: Remove needless __ghes_check_estatus() calls
Message-ID: <20190621151826.GA19067@zn.tnic>
References: <1560749129-26288-1-git-send-email-zhangliguang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1560749129-26288-1-git-send-email-zhangliguang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 17, 2019 at 01:25:29PM +0800, luanshi wrote:
> Function __ghes_check_estatus() is called after __ghes_peek_estatus(),
> but it is already called in __ghes_peek_estatus(). So we should remove
> some needless __ghes_check_estatus() calls.
> 
> Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
> ---
>  drivers/acpi/apei/ghes.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 993940d..1041a4d 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -372,10 +372,6 @@ static int ghes_read_estatus(struct ghes *ghes,
>  	if (rc)
>  		return rc;
>  
> -	rc = __ghes_check_estatus(ghes, estatus);
> -	if (rc)
> -		return rc;
> -
>  	return __ghes_read_estatus(estatus, *buf_paddr, fixmap_idx,
>  				   cper_estatus_len(estatus));
>  }
> @@ -882,12 +878,6 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
>  		return rc;
>  	}
>  
> -	rc = __ghes_check_estatus(ghes, &tmp_header);
> -	if (rc) {
> -		ghes_clear_estatus(ghes, &tmp_header, buf_paddr, fixmap_idx);
> -		return rc;
> -	}
> -
>  	len = cper_estatus_len(&tmp_header);
>  	node_len = GHES_ESTATUS_NODE_LEN(len);
>  	estatus_node = (void *)gen_pool_alloc(ghes_estatus_pool, node_len);
> -- 

Yah, looks correct to me.

James, I think the cleaner thing to do would be for
__ghes_peek_estatus() not to call __ghes_check_estatus() at the end but
to return success and we can keep the two functions - "peek" and "check"
status - separate and always do:

	if (peek)
		return ...;

	if (check)
		return ...;

because this way the checking remains separate in __ghes_check_estatus()
and so is the peeking in __ghes_peek_estatus().

We can merge the two functions because we always do peek and then check
but keeping them separate makes the code clearer.

Am I making some sense...?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
