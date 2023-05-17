Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594F8706A32
	for <lists+linux-acpi@lfdr.de>; Wed, 17 May 2023 15:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjEQNvF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 17 May 2023 09:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjEQNvE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 May 2023 09:51:04 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392C51BFB;
        Wed, 17 May 2023 06:51:00 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-94f9cd65b1aso19319466b.0;
        Wed, 17 May 2023 06:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684331458; x=1686923458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAMn7RtSs7++/a6MSYIC0QwcL3rxFuXCit+8RcyQnpU=;
        b=JbuSW/RcFcyEzav9vwnCWXwWZK3pxK36vRilT6cn5UhRoo0deZs96fxMKrWSYDTAYz
         2GutmWmT6c82rQJ6jjFol1HNUNsrXE0ObugM+QHHmJzX4iGRp/QIe0lGhABVdGuFphWi
         wLgkcIg1FLrF3MvSShDH4e8bX6BU4HEoiRwMu8pmqLI5cdqX+D8wNzEtothTUHXuxDM1
         fA0n8krLzV8nyHcaJlguXjIpfMBdV3UdxnVlW8g8AUFkfq40FpVCakuTyWl8U2zg1oGZ
         XBgr9cT7siDwuI4rHiRa8YTdXZ+GDNmMHFQULDLXlGTplOaoa3xwF3Nx3cQF4jPa0oM4
         Zr0Q==
X-Gm-Message-State: AC+VfDw0sFxjINC9t+GWjNFV8bVCictT7Yas7koA4cwNsTZu0BKgw9Fc
        as/VyWd0H4hwQ1KUaBvt37tePjIEj5MsoBaYzVk=
X-Google-Smtp-Source: ACHHUZ59Svgboz6WtxTqGlKEZyehkjrVMW+IwZXTZzdKAMiG6xA/cncl/Q3NsfW3myaOpDRZNDoB/MALiWlyoRXprok=
X-Received: by 2002:a17:906:ce:b0:965:bc62:fe38 with SMTP id
 14-20020a17090600ce00b00965bc62fe38mr2312292eji.7.1684331458265; Wed, 17 May
 2023 06:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230329100951.1522322-1-sakari.ailus@linux.intel.com>
 <20230329100951.1522322-6-sakari.ailus@linux.intel.com> <CAJZ5v0gxqs3+ofqX0PGmM=3HOi96ioyYJis+RL2oACPq6rggEA@mail.gmail.com>
 <ZGS+RzCGl7Y3p6N/@kekkonen.localdomain> <CAJZ5v0i73bdo7oxv_hrj0qM0PQuk9cbRLQ4jqPbKn7V4nMqOhQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0i73bdo7oxv_hrj0qM0PQuk9cbRLQ4jqPbKn7V4nMqOhQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 17 May 2023 15:50:47 +0200
Message-ID: <CAJZ5v0hG-qGa==9cQz2-xK01JJxL2UZuL9u=5yaDo3rW9eL9eQ@mail.gmail.com>
Subject: Re: [PATCH v8 05/10] ACPI: property: Prepare generating swnodes for
 ACPI and DisCo for Imaging
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 17, 2023 at 2:22 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, May 17, 2023 at 1:54 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:

[cut]

> > > > +                       local_port = &local_swnodes->ports[local_index];
> > > > +                       local_node = &local_swnodes->nodes[ACPI_DEVICE_SWNODE_EP(local_index)];
> > > > +                       local_port->remote_ep_ref[0] = SOFTWARE_NODE_REFERENCE(local_node);
> > >
> > > This looks odd.  Is local_port pointing to its own node as a remote
> > > endpont, or am I confused?
> >
> > This is a reference to a software node that will be, in turn, referenced by
> > the "remote-endpoint" property entry in the remote node. Look for
> > ACPI_DEVICE_SWNODE_EP_REMOTE_EP a few lines below these.
>
> To be precise, IIUC, it is going to be the "remote-endpoint" value for
> the remote node.
>
> OK, thanks for the explanation.  This isn't exactly straightforward TBH.

So I'd arrange it so that the value of the "remote-endpoint" property
in a given node is stored in that node (the value itself being a
reference to another endpoint).
