Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140DE33E8DE
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Mar 2021 06:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhCQFRR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Mar 2021 01:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhCQFRC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Mar 2021 01:17:02 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C4EC06174A;
        Tue, 16 Mar 2021 22:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=r/L8g0R0AICVUSG3yi82Sz5e1f8E9VA9Ee+ipsV1FEM=; b=wAlAaZVQh1iKWfaUwy4cKXZX9j
        vetf5Z2+K1GpBPecjt6UzfD6e1+T5Bkt07rKLN2ySNWp+hB8Aou4/dgzyC95vG2N6itsZus6ZYj52
        FNUUjenwwTyG8fymrF+hwm1Bjn7ZDBcupIRdWEOelGi9gth10Di/NVsPEG4Im9IqR5HtdeT77hCES
        Q9LonXCq8rPQh9S7ZimFZdwM1a4ET1doNSVHlOxvw0HSUdJXO4HZJualvBpBnviXRCOq3PGO+zCms
        S1Ohs3nmtWg5KwTkmIWRB9NJMrT30/49TDAsgP30oT6H1ZpqALYe1AMhiKQTQ/dD8DTp4ehqF/dxW
        /r0rm3sw==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMOYG-001bVN-Hk; Wed, 17 Mar 2021 05:17:00 +0000
Subject: Re: [PATCH] include: acpi: A typo fix in the file cppc_acpi.h
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, robert.moore@intel.com,
        erik.kaneda@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org
References: <20210317050641.4158096-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <859a36ad-f9c6-942d-770e-e9e0306d34e4@infradead.org>
Date:   Tue, 16 Mar 2021 22:16:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317050641.4158096-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 3/16/21 10:06 PM, Bhaskar Chowdhury wrote:
> 
> s/folowing/following/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  include/acpi/cppc_acpi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index c7fc4524e151..d174721bab33 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -31,7 +31,7 @@
>  #define	CMD_READ 0
>  #define	CMD_WRITE 1
> 
> -/* Each register has the folowing format. */
> +/* Each register has the following format. */
>  struct cpc_reg {
>  	u8 descriptor;
>  	u16 length;
> --


-- 
~Randy

