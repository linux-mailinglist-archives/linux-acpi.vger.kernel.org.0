Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E94C5E8E5C
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Sep 2022 18:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbiIXQIq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 24 Sep 2022 12:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIXQIp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 24 Sep 2022 12:08:45 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4834D24C
        for <linux-acpi@vger.kernel.org>; Sat, 24 Sep 2022 09:08:43 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id j10so1797493qtv.4
        for <linux-acpi@vger.kernel.org>; Sat, 24 Sep 2022 09:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wU23b1ZrlverzcsZH5b8SQAuQOWIwL4Tndo+bzW+zb4=;
        b=3bEWUK1siJQ5Ch7kgcruiy1fCx6yj9mS0UUDq+Yi2HXq77cBXvsZUnk8Ou3J0ruhzD
         IDT8Dbbu7vwplxxqxk5xPaGAEVzbdIXf0lHuWmEbTBDVdMt35nd2e0AKBzweVwIcqNm6
         pM+yo/+kTaCrLFVWoS4bTFKij6cBFrW/jzqO+GlTkc+eSXqLMckQgSOwQFKEXJy6IWzT
         YTD8undbXETW6FExM3oTrEJV6wr3EFtHmcZzNMZANUnjR2BWYX6ZDHRTeqB+R4H9S7c/
         EOMW/doWI9BSfSuq781TWhNbq1l6i6vVWxOQUSOSH+l04z57mOTA66NWMSgOxlauzfhr
         HNcg==
X-Gm-Message-State: ACrzQf0grk+5bA7+JQpkUk539ZNm9pFcvpliR/l2q04tYQHtpdB1t+7m
        hS2+F+eo3tqxwOCKhVbPXK0c1ok2wjDChu3KM0k=
X-Google-Smtp-Source: AMsMyM4DTuMTqzRcD9sBPxwkOa7um+9oSK9aYvYXwphrtXtkQLU96F2YTitym/U/waF3zp6yFDfGLsQsv7ApT0AzUiI=
X-Received: by 2002:a05:622a:1a08:b0:35c:d9b5:144b with SMTP id
 f8-20020a05622a1a0800b0035cd9b5144bmr11688806qtb.27.1664035722466; Sat, 24
 Sep 2022 09:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220911094535.3226660-1-cuigaosheng1@huawei.com> <20220913224121.GA629552@bhelgaas>
In-Reply-To: <20220913224121.GA629552@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 24 Sep 2022 18:08:31 +0200
Message-ID: <CAJZ5v0hKDzBoi8yF1ii5dExPNMCW019OdEcLLW2ydJ93RrbgTA@mail.gmail.com>
Subject: Re: [PATCH] PNPBIOS: remove unused pnpid32_to_pnpid() declaration
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>, bjorn.helgaas@hp.com,
        rene.herman@gmail.com, Len Brown <len.brown@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 14, 2022 at 12:41 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sun, Sep 11, 2022 at 05:45:35PM +0800, Gaosheng Cui wrote:
> > pnpid32_to_pnpid() has been removed since
> > commit 25eb846189d2 ("PNP: add pnp_eisa_id_to_string()"),
> > so remove it.
>
> Woof, I guess I messed that up, sorry :(
>
> I would word the commit log as:
>
>   All uses of pnpid32_to_pnpid() were removed by 25eb846189d2 ("PNP:
>   add pnp_eisa_id_to_string()"), so remove the declaration, too.
>
> Regardless,
>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

Applied as 6.1 material, thanks!

> > Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> > ---
> >  drivers/pnp/pnpbios/pnpbios.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/pnp/pnpbios/pnpbios.h b/drivers/pnp/pnpbios/pnpbios.h
> > index 2ce739ff9c1a..f3302006842e 100644
> > --- a/drivers/pnp/pnpbios/pnpbios.h
> > +++ b/drivers/pnp/pnpbios/pnpbios.h
> > @@ -153,7 +153,6 @@ extern int  pnpbios_dont_use_current_config;
> >  extern int pnpbios_parse_data_stream(struct pnp_dev *dev, struct pnp_bios_node * node);
> >  extern int pnpbios_read_resources_from_node(struct pnp_dev *dev, struct pnp_bios_node *node);
> >  extern int pnpbios_write_resources_to_node(struct pnp_dev *dev, struct pnp_bios_node *node);
> > -extern void pnpid32_to_pnpid(u32 id, char *str);
> >
> >  extern void pnpbios_print_status(const char * module, u16 status);
> >  extern void pnpbios_calls_init(union pnp_bios_install_struct * header);
> > --
> > 2.25.1
> >
