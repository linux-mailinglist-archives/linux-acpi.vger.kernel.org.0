Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E8C5B7D25
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Sep 2022 00:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiIMWl0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Sep 2022 18:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIMWlZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Sep 2022 18:41:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948C917A8C
        for <linux-acpi@vger.kernel.org>; Tue, 13 Sep 2022 15:41:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A85F61633
        for <linux-acpi@vger.kernel.org>; Tue, 13 Sep 2022 22:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582CBC433C1;
        Tue, 13 Sep 2022 22:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663108883;
        bh=PtjJ4cGohnEp8AHX9ERnrELX138x9De9VcAzsQ4q3I8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CCzbn2o8ogUWXT2XewzuYgGJC+/av/ST+55dGzOUwl6uj17HqBrJyNKsod+BI7dG0
         qSoJDt5h74XkGcDZscSfzEW9sEWHTDPYeB+bY/80PtnwX4wiRbNVdLuuoQJ39GxoHI
         YEE1AQrRmFFxixqXj49z/WJceMU8AOlIeLqVMMzNQ/7MPyNH3CqarLqnvsYND8e7oj
         NUGtlcg8ssn4nRrTlweX1m2uYNVqa3i2nIPsEnF2mrH9qJr1i0Hlv+0H8sqiFOPMfe
         +YmP6S8ccuCY6uuCS6YoTusK4S3qdQFjRfsCAVbA9jWJVqh7AoRzXOOdtegfNo5sj8
         Pl28St5SESB3Q==
Date:   Tue, 13 Sep 2022 17:41:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     rafael.j.wysocki@intel.com, bjorn.helgaas@hp.com,
        rene.herman@gmail.com, len.brown@intel.com,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] PNPBIOS: remove unused pnpid32_to_pnpid() declaration
Message-ID: <20220913224121.GA629552@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220911094535.3226660-1-cuigaosheng1@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Sep 11, 2022 at 05:45:35PM +0800, Gaosheng Cui wrote:
> pnpid32_to_pnpid() has been removed since
> commit 25eb846189d2 ("PNP: add pnp_eisa_id_to_string()"),
> so remove it.

Woof, I guess I messed that up, sorry :(

I would word the commit log as:

  All uses of pnpid32_to_pnpid() were removed by 25eb846189d2 ("PNP:
  add pnp_eisa_id_to_string()"), so remove the declaration, too.

Regardless,

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  drivers/pnp/pnpbios/pnpbios.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pnp/pnpbios/pnpbios.h b/drivers/pnp/pnpbios/pnpbios.h
> index 2ce739ff9c1a..f3302006842e 100644
> --- a/drivers/pnp/pnpbios/pnpbios.h
> +++ b/drivers/pnp/pnpbios/pnpbios.h
> @@ -153,7 +153,6 @@ extern int  pnpbios_dont_use_current_config;
>  extern int pnpbios_parse_data_stream(struct pnp_dev *dev, struct pnp_bios_node * node);
>  extern int pnpbios_read_resources_from_node(struct pnp_dev *dev, struct pnp_bios_node *node);
>  extern int pnpbios_write_resources_to_node(struct pnp_dev *dev, struct pnp_bios_node *node);
> -extern void pnpid32_to_pnpid(u32 id, char *str);
>  
>  extern void pnpbios_print_status(const char * module, u16 status);
>  extern void pnpbios_calls_init(union pnp_bios_install_struct * header);
> -- 
> 2.25.1
> 
