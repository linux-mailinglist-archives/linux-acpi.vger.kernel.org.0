Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6497507A3
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jul 2023 14:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjGLMLc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Jul 2023 08:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjGLMLb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jul 2023 08:11:31 -0400
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF463E4D
        for <linux-acpi@vger.kernel.org>; Wed, 12 Jul 2023 05:11:30 -0700 (PDT)
Received: from [134.238.52.102] (helo=[10.8.4.22])
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qJYgp-00CXBw-BY; Wed, 12 Jul 2023 13:11:28 +0100
Message-ID: <0d1bf461-d9e8-88bc-b7e2-b03b56594213@codethink.co.uk>
Date:   Wed, 12 Jul 2023 13:11:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RESEND v2] ACPI: NFIT: limit string attribute write
Content-Language: en-GB
To:     nvdimm@lists.linux.dev
Cc:     linux-acpi@vger.kernel.org
References: <20230712115753.20688-1-ben.dooks@codethink.co.uk>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20230712115753.20688-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 12/07/2023 12:57, Ben Dooks wrote:
> If we're writing what could be an arbitrary sized string into an attribute
> we should probably use sysfs_emit() just to be safe. Most of the other
> attriubtes are some sort of integer so unlikely to be an issue so not
> altered at this time.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> v2:
>    - use sysfs_emit() instead of snprintf.
> ---
>   drivers/acpi/nfit/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 9213b426b125..59c354137627 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1579,7 +1579,7 @@ static ssize_t id_show(struct device *dev,
>   {
>   	struct nfit_mem *nfit_mem = to_nfit_mem(dev);
>   
> -	return sprintf(buf, "%s\n", nfit_mem->id);
> +	return sysfs_emit(buf, "%s\n", nfit_mem->id);
>   }
>   static DEVICE_ATTR_RO(id);

Should we go through and change all the attribute code to use
sysfs_emit() ?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

