Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8237A6034A
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2019 11:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfGEJmn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jul 2019 05:42:43 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54282 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfGEJmm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jul 2019 05:42:42 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id a392c6c7e4852f7c; Fri, 5 Jul 2019 11:42:40 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     luanshi <zhangliguang@linux.alibaba.com>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3] ACPI / APEI: Remove needless __ghes_check_estatus() calls
Date:   Fri, 05 Jul 2019 11:42:40 +0200
Message-ID: <2740228.kq3QBCH7cy@kreacher>
In-Reply-To: <1561439728-5223-1-git-send-email-zhangliguang@linux.alibaba.com>
References: <1561439728-5223-1-git-send-email-zhangliguang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, June 25, 2019 7:15:28 AM CEST luanshi wrote:
> Function __ghes_check_estatus() is always called after
> __ghes_peek_estatus(), but it is already called in __ghes_peek_estatus().
> So we should remove some needless __ghes_check_estatus() calls.
> 
> Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> ---
>  drivers/acpi/apei/ghes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 993940d..a66e00f 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -345,7 +345,7 @@ static int __ghes_peek_estatus(struct ghes *ghes,
>  		return -ENOENT;
>  	}
>  
> -	return __ghes_check_estatus(ghes, estatus);
> +	return 0;
>  }
>  
>  static int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
> 

Applied, thanks!



